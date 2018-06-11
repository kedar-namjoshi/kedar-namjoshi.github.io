import xmltodict

def print_authors(lauthors):
    # print authors as comma-separated list
    x = '\t\t\t'
    x += lauthors[0]
    for i in range(1, len(lauthors)):
        x += ', ' + lauthors[i]
    print x

def last_name(author):
    y = author.split(' ')
    return y[len(y)-1]

def paper_name(lauthors,conf,year):
    # paper name: last name of authors, conf, year separated by - 
    x = last_name(lauthors[0])
    for i in range(1, len(lauthors)):
        x += '-' + last_name(lauthors[i])
    x += '-' + conf + '-' + year
    return x

def authors_as_list(authors):
    # turn authors, which could be a string, into a list
    if type(authors) is list:
        return authors
    else:
        return [authors]

def print_item(title,authors,conf,year):
    mtitle = title.split('.')[0]
    lauthors = authors_as_list(authors)
    paper = paper_name(lauthors,conf,year)
    print '<ul>'
    print '\t<li class="title"> <a href="papers/' + paper + '.pdf"> '+ mtitle + '</a> </li>'
    print '\t<li class="authors">'
    print_authors(lauthors)
    print '\t</li>'
    print '\t<li class="conf">' + conf + ' ' + year + '</li>'
    print '</ul>'
    print ''

with open('/home/kedar/Desktop/2017/kpapers.xml') as fd:
   b = xmltodict.parse(fd.read())
   papers = b['dblpperson']['r']
   n = int(b['dblpperson']['@n'])
   for i in range(0,n):
      t = papers[i]
      for k,v in t.iteritems():
	 if k == 'inproceedings':
	    print_item(v['title'], v['author'], v['booktitle'], v['year'])
	 elif k == 'article':
	    print_item(v['title'], v['author'], v['journal'], v['year'])
	 else:
	    print ''



