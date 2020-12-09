# word = 'PasswoRd'

f = open("temp.txt", "r")
for word in f:
    output=''
    for char in word.strip():
        if char.isalpha():
            output=output+'['+char.casefold()+'|'+char.capitalize()+']'
        else:
            output=output+char
    print(output)

# sting='-'
# print(sting.isalpha())