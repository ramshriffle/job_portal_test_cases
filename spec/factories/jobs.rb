FactoryBot.define do
  factory :job do
    # job_title {"Hr"}
    # description {"1 year experience in ROR"}
    # location {"Indore"}
    # salary {"35000"} 

    sequence(:job_title)             {|n|" Hr #{n}"}
    sequence(:description)             {|n|" Description #{n}"}
    sequence(:location)         {|n| "Location #{n}"}
    sequence(:salary)         {|n| "Location"+ "#{n}"}
    user   
  end
end
