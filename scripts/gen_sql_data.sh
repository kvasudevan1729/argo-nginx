#!/usr/bin/env sh

dept_sql="./02-department-data.sql"
emp_sql="./03-employees-data.sql"
rooms_sql="./04-rooms-data.sql"
emp_room_sql="./05-employee-room-data.sql"
desktop_sql="./06-desktop-data.sql"
departments=""

echo "=> generating sql for department table ..."
echo "INSERT INTO department (name, school) VALUES" > ${dept_sql}
for i in $(seq 1 20); do
    dept=$(tr -dc 'A-Z' < /dev/urandom | head -c8)
    school=$(tr -dc 'A-Z' < /dev/urandom | head -c4)
    departments="${departments} ${dept}"
    echo "  ('${dept}', '${school}')," >> ${dept_sql}
done

dept=$(tr -dc 'A-Z' < /dev/urandom | head -c8)
school=$(tr -dc 'A-Z' < /dev/urandom | head -c4)
departments="${departments} ${dept}"
echo "  ('${dept}', '${school}');" >> ${dept_sql}

echo "=> generating sql for remaining tables ..."
echo "INSERT INTO employee (name, age, department_name) VALUES" > ${emp_sql}
echo "INSERT INTO rooms (name, department) VALUES" > ${rooms_sql}
echo "INSERT INTO employee_room (room_name, employee_id) VALUES" > ${emp_room_sql}
echo "INSERT INTO desktop (name, employee_id, desktop_type) VALUES" > ${desktop_sql}

for d in ${departments}; do
    for i in $(seq 1 1000); do
        printf "."
        emp_name=$(tr -dc 'a-zA-Z0-9' < /dev/urandom | head -c20);
        emp_age=$(tr -dc '0-9' < /dev/urandom | head -c8);
        echo "  ('${emp_name}', ${emp_age}, '${d}')," >> ${emp_sql}
        room=$(tr -dc 'a-zA-Z0-9' < /dev/urandom | head -c20)
        echo "  ('${room}', '${d}')," >> ${rooms_sql}
        echo "  ('${room}', $i)," >> ${emp_room_sql}
        desktop_win=$(tr -dc 'a-zA-Z0-9' < /dev/urandom | head -c20)
        desktop_linux=$(tr -dc 'a-zA-Z0-9' < /dev/urandom | head -c20)
        echo "  ('${desktop_win}', ${i}, 'windows')," >> ${desktop_sql}
        echo "  ('${desktop_linux}', ${i}, 'linux')," >> ${desktop_sql}
    done
done

emp_name=$(tr -dc 'a-zA-Z0-9' < /dev/urandom | head -c20);
emp_age=$(tr -dc '0-9' < /dev/urandom | head -c8);
echo "  ('${emp_name}', ${emp_age}, '${dept}');" >> ${emp_sql}
room=$(tr -dc 'a-zA-Z0-9' < /dev/urandom | head -c20)
echo "  ('${room}', '${dept}');" >> ${rooms_sql}
echo "  ('${room}', 1);" >> ${emp_room_sql}
desktop_win=$(tr -dc 'a-zA-Z0-9' < /dev/urandom | head -c20)
echo "  ('${desktop_win}', 1, 'windows');" >> ${desktop_sql}
