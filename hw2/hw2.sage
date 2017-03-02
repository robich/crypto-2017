###### Exercise 1
X=[202267246792075570485713284452135002164920307178954807136678216045311378164224753288399803972535055409738802066180455871021315473327992,
839384277911317298699739692978129634679306425263401874315963552757602335997644337552032205900877977692859129478450203106714800213605872,
585492858913421986996214117040079317767097317456576317573680898000379677016478971367080121517283455478043847461027172206783115697825906,
438188476373496417397420869225192016722575729470824644838645900601919187165525019932871200436195614611760715203611881069209242177045402,
1050985055981679088500192389054591286495976838559645046673948500683140776360875004360997272641419869579451588569750294855193317813867513,
1154116911557365353351849295370003629383181322413897379533801814162981549365232113751609348112127072476859841484429949820299450565504232,
273913767739519296243341178841439006678685315840497588275583324909833557380888776623872244736715917504857492264385729475717207533219629,
613235901811634042186962212103254972465778265606288976646142751515743223110656048290922081237161914104601522265681355945795560852481311,
171657615870666262857222648264501836297348521638147671888777542712057454901660992228143865089987817636223832080072401948516618316725934]
p=1463921411160212404292876540785617455019932263305046751169835608999227302691622607823075318851864511151091142685884961829351364544957887
p11=862636436862870811955571685052869178137303021
p12=1159197446349711899067685475588744928288090739
p13=731985626221320199682921957094804417246273497
print "CRYPTO HOME WORK 2 - ROBIN GENOLET 227358"
print "Ex 1:"

import itertools
from sets import Set

'''
Zp star is of order p-1 = 2*p11*p12*p13 (+1 -1)
Let x in X.
x is a generator for Zp star if x^a = 1 mod p and a=p-1
i.e. there is no a smaller than p-1 that satisfies the above equality.
So to find if x is a generator of Zp star,
we can write a program that computes the order of each x and
see if it equals p-1

By Lagrange's thm, order of element divides order of group.
This fixes the possible factors of a.
'''

X_not_generators = []
possible_factors = [2, p11, p12, p13]

print "X has", len(X), "elements"

for x in X:
    for n in range(1, len(possible_factors) + 1):
        for subset in itertools.combinations(possible_factors, n):
            a = 1
            for elem in subset:
                a = a * elem
            
            if (power_mod(x, a, p) == 1):
                if (a != p-1):
                    #print "Found a non-generator:", x
                    X_not_generators.append(x)

# generators is set difference of X and X_not_generators
X_generators = list(set(X) - set(X_not_generators))

print "Number of generators, Q1a=", len(X_generators)
print "generators: Q1b=", sorted(X_generators)

###### Exercise 2
word2='arbitrariness will be the encoded word of today.'
encoded2=[0, 1, 17, 0, 2, 0, 3, 0, 1, 17, 0, 26, 0, 13, 3, 26, 19, 7, 4, 26, 18, 4, 2, 17, 4, 19, 26, 22, 14, 17, 3, 26, 8, 18, 26, 18, 0, 22, 24, 4, 17, 18, 27]

print "Ex 2:"

def encode(word):
    if len(word) == 0:
        raise ValueError("Expected at least one char")
    
    res = []
    
    for c in word:
        if c == ' ':
            res.append(26)
        elif c == '.':
            res.append(27)
        else:
            res.append(ord(c) - ord('a'))
        
    return res

def decode(list):
    if len(list) == 0:
        raise ValueError("Expected a non-empty list")
    
    res = ''
    
    for n in list:
        n = int(n)

        if n == 26:
            res = res + ' '
        elif n == 27:
            res = res + '.'
        else:
            res = res + chr(n + ord('a'))
            
    return res

print decode(encode("it worked. yay"))
print "Encoded word: Q2a = "
print encode(word2)
print "Decoded word: Q2b = " + decode(encoded2)

###### Exercise 3
u3 = 3764262947957454857910677751312595985544003234231520452608937778277611198517459087489721606195378801224903536332731703203920267962927768416001024133199768
v3 = 4422365119855977875164147216791485660087868152276982325042831847912133146552908489714931218113543408437284691507873125068179383373914627232106204546499778
y3 = 4088616701929806821610538605571374267066188696459513012190627723561808695393689152929006217923453570332304595589695290140685883871983923595134328459610112
x3 = 1336944797120946139103754265428905400070934234098450931314108938695421895751809137920511450366175572992239290341497457878194894325262669398102374064459756
g3 = 161512177608335864028022005566362084058140769598436956227945616012326112798766722625503000232161998048421854590133468053190264952521599042207603293739281
n3 = 6221400957060344477177671018063597053363176462411976766548711826320055022198754452237081373811516447663166551536617931216593608822950028607549857023737362

print "Ex 3:"

'''
We know that n3+1 is prime, so Zn3+1 star has order n3.
'''

def encode_elgamal(string):
    output = ""
    for char in string:
        encoded_char = `ord(char)`
        while len(encoded_char) < 3:
            encoded_char = `0` + encoded_char
        output += encoded_char
    return `1` + output

def decode_elgamal(string):
    str = string[1:]
    output = ""
    while (len(str) > 0):
        output += chr(int(str[0:3]))
        str = str[3:]
    
    return output

print encode_elgamal("Red fox")
print decode_elgamal(encode_elgamal("Red fox"))

m3 = mod(v3*power_mod(u3, -x3, n3+1), n3+1)
print "Q3=" + decode_elgamal(str(m3))

###### Exercise 4
y4= [ 9, 10, 3, 23, 7, 27, 17, 27, 14, 13, 21, 21, 3, 6, 8, 23, 16, 22, 26, 13, 6, 3, 2, 11, 19, 27, 2, 14, 4, 9, 3, 3, 6, 23, 17, 12, 11, 12, 21, 1, 12, 4, 11, 2, 25, 27, 1, 18, 14, 17, 11, 6, 27, 25, 20, 22, 12, 17, 9, 0, 20, 11, 4, 26, 22, 26, 14, 7, 11, 21, 26, 9, 16, 12, 19, 22, 7, 22, 16, 24, 22, 19, 21, 18, 7, 22, 6, 11, 26, 4, 4, 23, 20, 26, 2, 24, 2, 19, 23, 27, 0, 5, 4, 2, 3 ]
p4= [ [ 7, 27, 11, 5, 1, 20, 15, 10, 8, 25, 22, 6, 24, 21, 23, 2, 17, 4, 18, 14, 13, 9, 16, 12, 26, 19, 0, 3 ],
[ 21, 10, 4, 3, 9, 7, 2, 20, 18, 14, 0, 26, 19, 27, 13, 11, 5, 17, 22, 12, 8, 1, 15, 23, 24, 6, 25, 16 ],
[ 0, 12, 4, 21, 11, 8, 24, 25, 6, 10, 18, 26, 7, 5, 22, 3, 19, 14, 20, 23, 13, 2, 16, 15, 9, 17, 27, 1 ],
[ 16, 14, 2, 22, 25, 9, 21, 19, 10, 12, 20, 1, 13, 11, 0, 4, 23, 24, 5, 27, 26, 7, 8, 15, 6, 3, 17, 18 ] ]
c4= 15150
pi4= [ 13, 24, 6, 26, 27, 15, 2, 17, 9, 8, 21, 14, 22, 0, 11, 5, 20, 7, 25, 23, 16, 10, 12, 19, 1, 18, 3, 4 ]

print "Ex 4:"

def effective_rotor(x, rotor, i_power, inverse):
    if inverse:
        return mod(rotor.index(mod(x - i_power, 28)) + i_power, 28)
    else:
        return mod(rotor[mod(x - i_power, 28)] + i_power, 28)

for aprime in range(1,7):
    a = c4 + aprime
    for i in range(len(p4)):
        for j in range(len(p4)):
            for k in range(len(p4)):
                if i != j and i != k and j != k:
                    rotor1 = p4[i]
                    rotor2 = p4[j]
                    rotor3 = p4[k]
                    
                    clear_text_enigma = []
                    for index in range(len(y4)):
                        i0 = a + index
                        i1 = mod(i0, 28)
                        i2 = mod(floor(i0/28), 28)
                        i3 = mod(floor(i0/(28^2)), 28)
                        
                        clear_text_enigma.append(effective_rotor(effective_rotor(effective_rotor(pi4.index(effective_rotor(effective_rotor(effective_rotor(y4[index], rotor1, i1, False),
                        rotor2, i2, False), rotor3, i3, False)), rotor3, i3, True), rotor2, i2, True), rotor1, i1, True))
                    print decode(clear_text_enigma)
                        

###### Exercise 5
c5= [ 11, 17, 3, 9, 23, 1, 6, 26, 13, 3, 25, 24, 2, 11, 11, 19, 17, 0, 12, 15, 20, 23, 4, 24, 2, 2, 14, 3, 14, 7, 24, 4, 17, 9, 4, 6, 12, 5, 16, 12, 14, 2, 4, 12 ]
a5= 11
b5= 7

print "Ex 5:"

# Since k0 is not known, we display cleartexts corresponding to k0=0, ..., 27
for k0 in range(28):
    k5 = [k0]
    clear_text = [mod(c5[0] - k5[0], 28)]

    for i in range(1, len(c5)):
        k5.append( mod(a5*k5[i-1] + b5, 28))
        clear_text.append(mod(c5[i] - k5[i], 28))
        
    print decode(clear_text)