import sqlite3
from os import path
from datetime import datetime
import csv

db = list()
db2 = list()
CHAT_DB = path.expanduser("~/Library/Messages/chat.db")
dbs = sqlite3.connect(CHAT_DB)
cursor = dbs.cursor()
rows = cursor.execute("""select date, text from message where is_from_me=1;""")
# for date in rows:
#     date = str(datetime.fromtimestamp(int(mac_timestamp) + 978307200))
for row in rows:
# some are None, others are weird objects (when sending photos etc.)
    if row[0] is not None and str(row)[:10] != "(u'\ufffc'":
        oba = str(datetime.fromtimestamp(int(row[0]) + 978307200))
    db.append(oba)
    db2.append(row[1])
# print db

with open('test2.csv','wb') as csvfile:
    writer = csv.writer(csvfile)
    for lines in db2:
        writer.writerow([u''.join(lines).encode("utf-8").strip()])
