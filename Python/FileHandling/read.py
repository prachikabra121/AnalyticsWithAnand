# file = open("data2.txt","r")
# print(file)
# print(file.read())

# file = open("data2.txt","w")
# print(file)
# print(file.write("Today is the beautiful day! I am very happy and exicted"))
#
# file = open("data2.txt","a")
# # print(file)
# print(file.write("\n Monday is blue"))

# file = open("data3.txt","x")
# print(file)
# print(file.write("Today is the beautiful day! I am very happy and exicted"))

# file = open("data2.txt","r+")
# print(file)
# print(file.write("Today is the beautiful day! I am very happy and exicted"))
# file.close()
#
# file = open("data2.txt","r+")
# print(file)
# print(file.read())
# # file.close()
#
# file.seek(8)
# file.write("ABCDEFGHIJK")


# file = open("diagram.png","rb")
# print(file.read())

# Creating and writing a fresh inventory file
# f = open("data.txt", "w", encoding="utf-8")
# f.write("SKU101, Basmati Rice 5kg, 120\n")
# f.write("SKU102, Sunflower Oil 1L, 340\n")
# f.close()
# Reading it back
f = open("data1.txt", "r", encoding="utf-8")
print(f.read())
f.close()