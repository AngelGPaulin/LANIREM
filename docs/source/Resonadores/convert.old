import sys
print (sys.argv)

def Procesa_Comas(ss='', i=0):
  filon.write('::')
  filon.write('\n\n')
  ban = 1
  i = i+1
  while ban == 1:
    ss = datos[i]
    if '```' in ss:
      ban = 0
      i=i+1
    else:
      filon.write('   '+ss)
      i = i+1
  return i

def Encuentra_corch_paren(ss=''):
  i = ss.find('](.')
#  print(i)
  i2 = ss.find(')', i+1)
  tit2 = ss[i+4:i2]
#  print(tit2)
  j1 = Busca_Izquierda(ss, '[', i)
  tit1 = ss[j1:i]
#  print(tit1)
  ssN = ss[:j1-1]+':doc:`'+tit2+ '`' + ss[i2+1:]
  print(ssN)
  return ssN

def Procesa_Gato(ss):
  i=1
  while ss[i] == '#':
    i = i+1
  ss = ss[i+1:]
  print(ss)
  filon.write(ss+'\n')
  filon.write('-----------------------\n')
  
def Busca_Izquierda(ss='', car='', pos=0):
  i = pos
  i1 = -1
  while  i > 0:
    if ss[i] == car:
      i1 = i+1
      i = -1
    else:
      i = i-1
  return i1

def Encuentra_http(ss=''):
  i = ss.find('http')
  i2 = ss.find(')', i+1)
  i1 = Busca_Izquierda(ss, '(', i-1)
  print(i1, i2)
  http = ss[i1:i2]
  print(http)
  k2 = Busca_Izquierda(ss, ']', i1)-1
  k1 = Busca_Izquierda(ss, '[', k2)
  titulo = ss[k1:k2]
  print(titulo)  
  ssN = ss[:k1-1]+'`'+titulo+' <'+http+'>`_' 
  ss = ss[i2+1:]
  if ss.find('http') > 0:
    ssN = ssN + Encuentra_http(ss)
  else:
    ssN = ssN+ss
    return ssN
  print(ssN)  
  return ssN  
 
nombre = sys.argv[1]

filin = open(nombre+'.md', 'r')
datos = filin.readlines()
filin.close

filon = open(nombre+'.rst', 'w')

i = 0
ld = len(datos)
while i < ld:
  ss = datos[i]
  ss=ss.replace('\n', '')
  if len(ss) > 0:
    if '```' in ss:
      i = Procesa_Comas(ss,i)
    else:
      ss=ss.replace('`','``')
      if 'http' in ss:
        ss = Encuentra_http(ss)
        filon.write(ss+'\n')
      elif "](." in ss:
        ss = Encuentra_corch_paren(ss)
        filon.write(ss+'\n')
      elif "#" == ss[0]:
        Procesa_Gato(ss)
  else:
    filon.write(ss+'\n')
  i = i+1

filon.close()




