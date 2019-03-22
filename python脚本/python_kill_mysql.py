#!/bin/env python
import pymysql

def send_cmd(sql):
	conn = pymysql.connect(host='192.168.0.1', user='root', passwd='123456')
	cur = conn.cursor()
	cur.execute(sql)
	pid_list=[]
	try:
		res = cur.fetchall()
		for row in res:
			pid_list.append(row)	
	except:
		print ("Error: unable to fetch data")
	cur.close()
	conn.close()
	return pid_list

if __name__ == '__main__':
	list_proc = send_cmd("show PROCESSLIST")
	for i in list_proc:
		try:
			if i[5] > 3 and i[7].startswith(('SELECT','select')):
				send_cmd(('kill {}').format(i[0]))
		except:
			pass
			# print ("Error: No slow SQL")

		

