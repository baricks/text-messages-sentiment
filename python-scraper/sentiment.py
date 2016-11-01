import csv
import sys
from textblob import TextBlob

reload(sys)
sys.setdefaultencoding('utf8')

infile = 'texty.csv'

with open(infile, 'r') as csvfile:
    rows = csv.reader(csvfile)
    for row in rows:
        sentence = row[0]
        sentence.encode('utf-8')
        blob = TextBlob(sentence)
        polarity = blob.sentiment.polarity
        subjectivity = blob.sentiment.subjectivity
        noun_phrases = blob.noun_phrases
        nouns = [u', '.join(noun_phrases).decode("utf-8")]
        # print sentence
        # print polarity
        # print subjectivity
        # print nouns
