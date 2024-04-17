from datetime import datetime


def say_hi():
	date = datetime.now().strftime('%H:%M:%S')
	print("hello, world!" + "\n" + "Current time is " + date)
