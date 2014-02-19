class Student < User
  belongs_to :squad_leader, :class_name => 'Instructor'
end
