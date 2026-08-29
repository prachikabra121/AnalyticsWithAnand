# with open("data.txt","r") as f:
#     data=f.read()
#     print(data)

#
# with open("data.txt","w") as f:
#     data=f.write("Hello bye bye")
#     print(data)


# file = open("data.txt",'r')
# content=file.read()
# print(content)
# file.close()
# file = open("data.txt",'r')
# content=file.readline()
# print(content)
# file.close()

# file = open("data.txt",'r')
# content=file.readlines()
# print(content)
# file.close()



# f = open("data.txt", "w", encoding="utf-8")
# f.write("SKU101, Basmati Rice 5kg, 120\n")
# f.write("SKU102, Sunflower Oil 1L, 340\n")
# f.close()

# lines = ["SKU101, Basmati Rice 5kg, 120\n","SKU102, Sunflower Oil 1L, 340\n","SKU102, Sunflower Oil 1L, 350\n"]
#
# file=open("data2.txt",'w')
# file.writelines(lines)
# file.close()

# file = open("data.txt",'r')
# # content=file.readlines()
# # print(content)
# # file.close()

# f = open("test.txt","w")
# x=f.write("Welcome to the Jungle")
# print(x)
# # f.close()
# # f = open("test.txt","w")
# y = f.write("bye bye")

# f= open(("test.txt","r"))

# f = open("test.txt","r")
# print(f.tell())
# f.seek(8)
# x=f.read()
# print(x)
# print(f.tell())
# print(f.read(),"exit")

import os
# os.remove("test.txt")

os.rename("data.txt","content.txt")








