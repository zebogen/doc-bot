task import_provider_data: :environment do
  doctor_count = 0
  specialization_count = 0
  procedure_count = 0
  insurer_count = 0
  plan_count = 0
  row_count = 0
  CSV.foreach('db/data_files/provider_info.csv', headers: true) do |row|
    doctor = Doctor.find_or_create_by!(npi: row['npi']) do |doc|
      %w(
        distance
        city
        state
        street
        street2
        zip
        phone
        gender
        first_name
        last_name
        yelp_id
      ).each do |field|
        doc[field] = row[field] unless row[field] == "NA"
        doctor_count += 1
      end

      doc.last_degree_year = row['last_degree_yr'] unless row['last_degree_yr'] == "NA"
    end

    specialization = Specialization.find_or_create_by!(uid: row['spec.uid']) do |spec|
      spec.name = row['spec.name']
      spec.description = row['spec.description']
      spec.practitioner_name = row['spec.actor']
      specialization_count += 1
    end

    doctor.specializations << specialization

    procedure = Procedure.find_or_create_by!(code: row['code']) do |pro|
      pro.description = row['description']
      procedure_count += 1
    end

    DoctorProcedure.find_or_create_by!(doctor_id: doctor.id, procedure_id: procedure.id) do |dp|
      dp.count = row['count']
      dp.complication_rate = row['adjusted_complication_rate']
    end

    insurer = Insurer.find_or_create_by!(uid: row['insprov.uid']) do |ins|
      ins.name = row['insprov.name']
      insurer_count += 1
    end

    plan = Plan.find_or_create_by!(uid: row['insplan.uid']) do |pl|
      pl.name = row['insplan.name']
      pl.insurer_id = insurer.id
      plan_count += 1
    end

    doctor.plans << plan

    row_count += 1
    puts "Processed #{row_count} rows..."
  end
  puts "Created:"
  puts "=========================="
  puts "#{doctor_count} doctors"
  puts "#{specialization_count} specializations"
  puts "#{procedure_count} procedures"
  puts "#{insurer_count} insurers"
  puts "#{plan_count} plans"
end
