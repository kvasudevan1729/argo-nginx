#!/usr/bin/env bash

dept_sql="./02-department-data.sql"
emp_sql="./03-employees-data.sql"
rooms_sql="./04-rooms-data.sql"
emp_room_sql="./05-employee-room-data.sql"
desktop_sql="./06-desktop-data.sql"
skill_sql="./07-skill-data.sql"
skill_level_sql="./07-skill-level-data.sql"
emp_skills_sql="./08-employee-skills-data.sql"
departments=""

echo "=> generating sql for department table ..."
dept_cnt=30
echo "INSERT INTO department (name, school) VALUES" > ${dept_sql}
for i in $(seq 1 ${dept_cnt}); do
    dept=$(tr -dc 'A-Z' < /dev/urandom | head -c8)
    school=$(tr -dc 'A-Z' < /dev/urandom | head -c4)
    departments="${departments} ${dept}"
    echo "  ('${dept}', '${school}')," >> ${dept_sql}
done

dept=$(tr -dc 'A-Z' < /dev/urandom | head -c8)
school=$(tr -dc 'A-Z' < /dev/urandom | head -c4)
departments="${departments} ${dept}"
echo "  ('${dept}', '${school}');" >> ${dept_sql}

#### SKILL_LEVEL
skill_level_cnt=20
skill_levels=()
echo "=> generating sql for skill_level table ..."
echo "INSERT INTO skill_level (level_name, description) VALUES" > ${skill_level_sql}
for i in $(seq 1 $skill_level_cnt); do
    level_name=$(tr -dc 'A-Z' < /dev/urandom | head -c10)
    description=$(tr -dc 'A-Z' < /dev/urandom | head -c20)
    skill_levels+=("${level_name}")
    echo "  ('${level_name}', '${description}')," >> ${skill_level_sql}
done

level_name=$(tr -dc 'A-Z' < /dev/urandom | head -c10)
description=$(tr -dc 'A-Z' < /dev/urandom | head -c20)
skill_levels+=("${level_name}")
echo "  ('${level_name}', '${description}');" >> ${skill_level_sql}

#### SKILL

skills_cnt=50
skills=()
echo "=> generating sql for skill table ..."
echo "INSERT INTO skill (name, description) VALUES" > ${skill_sql}
for i in $(seq 1 $skills_cnt); do
    skill_name=$(tr -dc 'A-Z' < /dev/urandom | head -c10)
    description=$(tr -dc 'A-Z' < /dev/urandom | head -c20)
    skills+=("${skill_name}")
    echo "  ('${skill_name}', '${description}')," >> ${skill_sql}
done

skill_name=$(tr -dc 'A-Z' < /dev/urandom | head -c10)
description=$(tr -dc 'A-Z' < /dev/urandom | head -c20)
skills+=("${skill_name}")
echo "  ('${skill_name}', '${description}');" >> ${skill_sql}

### ALL OTHER TABLESD

echo "=> generating sql for remaining tables ..."
echo "INSERT INTO employee (id, name, age, department_name) VALUES" > ${emp_sql}
echo "INSERT INTO rooms (name, department) VALUES" > ${rooms_sql}
echo "INSERT INTO employee_room (room_name, employee_id) VALUES" > ${emp_room_sql}
echo "INSERT INTO desktop (name, employee_id, desktop_type) VALUES" > ${desktop_sql}
echo "INSERT INTO employee_skills (employee_id, skill_name, skill_level) VALUES" > ${emp_skills_sql}

no_recs_per_dept=2000
for d in ${departments}; do
  echo -e "\n=> department: ${d}"
    for i in $(seq 1 ${no_recs_per_dept}); do
        printf "."
        emp_id=$(tr -dc 'a-zA-Z0-9' < /dev/urandom | head -c20);
        emp_name=$(tr -dc 'a-zA-Z0-9' < /dev/urandom | head -c20);
        emp_age=$(tr -dc '0-9' < /dev/urandom | head -c2);
        echo "  ('${emp_id}', '${emp_name}', ${emp_age}, '${d}')," >> ${emp_sql}

        room=$(tr -dc 'a-zA-Z0-9' < /dev/urandom | head -c20)
        echo "  ('${room}', '${d}')," >> ${rooms_sql}
        echo "  ('${room}', '${emp_id}')," >> ${emp_room_sql}

        desktop_win=$(tr -dc 'a-zA-Z0-9' < /dev/urandom | head -c20)
        desktop_linux=$(tr -dc 'a-zA-Z0-9' < /dev/urandom | head -c20)
        echo "  ('${desktop_win}', '${emp_id}', 'windows')," >> ${desktop_sql}
        echo "  ('${desktop_linux}', '${emp_id}', 'linux')," >> ${desktop_sql}

        # emp skills
        skill_name="${skills[$RANDOM%${skills_cnt}]}"
        skill_level="${skill_levels[$RANDOM%${skill_level_cnt}]}"
        echo "  ('${emp_id}', '${skill_name}', '${skill_level}')," >> ${emp_skills_sql}
    done
done

emp_id=$(tr -dc 'a-zA-Z0-9' < /dev/urandom | head -c20);
emp_name=$(tr -dc 'a-zA-Z0-9' < /dev/urandom | head -c20);
emp_age=$(tr -dc '0-9' < /dev/urandom | head -c8);
echo "  ('${emp_id}', '${emp_name}', ${emp_age}, '${dept}');" >> ${emp_sql}

room=$(tr -dc 'a-zA-Z0-9' < /dev/urandom | head -c20)
echo "  ('${room}', '${dept}');" >> ${rooms_sql}
echo "  ('${room}', '${emp_id}');" >> ${emp_room_sql}

desktop_win=$(tr -dc 'a-zA-Z0-9' < /dev/urandom | head -c20)
echo "  ('${desktop_win}', '${emp_id}', 'windows');" >> ${desktop_sql}

skill_name="${skills[$RANDOM%${skills_cnt}]}"
skill_level="${skill_levels[$RANDOM%${skill_level_cnt}]}"
echo "  ('${emp_id}', '${skill_name}', '${skill_level}');" >> ${emp_skills_sql}