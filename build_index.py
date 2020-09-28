# build_index.py
# Builds the index.html file from stubs
# -------------------------------------

import os

# Open the stubs
working_directory = os.getcwd()
print(working_directory)

# Global header stub
global_header_stub_file = open(working_directory + "\\global_header_stub.html", "r")
global_header_stub = global_header_stub_file.read() + "\n\n"
global_header_stub_file.close()

# Global footer stub
global_footer_stub_file = open(working_directory + "\\global_footer_stub.html", "r")
global_footer_stub = global_footer_stub_file.read() + "\n"
global_footer_stub_file.close()

# Index head stub
index_head_stub_file = open(working_directory + "\\index_head_stub.html", "r")
index_head_stub = index_head_stub_file.read() + "\n\n"
index_head_stub_file.close()

# Index main stub
index_main_stub_file = open(working_directory + "\\index_main_stub.html", "r")
index_main_stub = index_main_stub_file.read() + "\n\n"
index_main_stub_file.close()

# Open index.html and wrire all the stubs in order
index_file = open(working_directory + "\\index.html", "w")
index = index_head_stub + "<body>\n" + global_header_stub + index_main_stub + global_footer_stub + "</body>"
index_file.write(index)
index_file.close()