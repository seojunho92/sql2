select * from users;

select users.user_id, user_name, reg_date, address
		from users join addresses
		on users.user_id = addresses.user_id
		order by user_id;

