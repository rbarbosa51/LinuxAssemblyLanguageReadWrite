NAME=ReadWriteFile
$(NAME): $(NAME).asm
	nasm -g -f elf64 -o $(NAME).o $?
	ld -g -o $@ $(NAME).o

clean:
	rm -f $(NAME) $(NAME).o Test.txt
