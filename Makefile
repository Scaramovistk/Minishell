#-------------------------------------------------------------------ASCIIART---------------------------------------------------------------------------------------------

define HEADLOGO
  (        (       )     (      (        )             (     (     
 (  )     )\ )   ( /(   )\ )   )\ )     ( /(         )\ )   )\ )  
 )\))(   (()/(   )\()) (()/(  (()/(     )\())  (    (()/(  (()/(  
((_)()\   /(_)) ((_)\   /(_))  /(_))   ((_)\   )\   /(_))  /(_)) 
(_()((_) (_))   ( _((_) (_))   (_) )   ( _((_) ((_) (_))   (_))   
|  \/  | |_ _|  | \| | |_ _|  / __|    | || | | __| | |    | |    
| |\/| |  | |   |  ` |  | |   \__ \  _ | __ | | _|  | |__  | |__  
|_|  |_| |___|  |_|\_| |___|  |___/ (_)|_||_| |___| |____| |____|

endef
export HEADLOGO

#-------------------------------------------------------------------COLORS---------------------------------------------------------------------------------------------

# Reset
Color_Off='\033[0m'       # Text Reset

# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

# Bold
BBlack='\033[1;30m'       # Black
BRed='\033[1;31m'         # Red
BGreen='\033[1;32m'       # Green
BYellow='\033[1;33m'      # Yellow
BBlue='\033[1;34m'        # Blue
BPurple='\033[1;35m'      # Purple
BCyan='\033[1;36m'        # Cyan
BWhite='\033[1;37m'       # White

# Underline
UBlack='\033[4;30m'       # Black
URed='\033[4;31m'         # Red
UGreen='\033[4;32m'       # Green
UYellow='\033[4;33m'      # Yellow
UBlue='\033[4;34m'        # Blue
UPurple='\033[4;35m'      # Purple
UCyan='\033[4;36m'        # Cyan
UWhite='\033[4;37m'       # White

# Background
On_Black='\033[40m'       # Black
On_Red='\033[41m'         # Red
On_Green='\033[42m'       # Green
On_Yellow='\033[43m'      # Yellow
On_Blue='\033[44m'        # Blue
On_Purple='\033[45m'      # Purple
On_Cyan='\033[46m'        # Cyan
On_White='\033[47m'       # White

# Bold High Intensity
BIBlack='\033[1;90m'      # Black
BIRed='\033[1;91m'        # Red
BIGreen='\033[1;92m'      # Green
BIYellow='\033[1;93m'     # Yellow
BIBlue='\033[1;94m'       # Blue
BIPurple='\033[1;95m'     # Purple
BICyan='\033[1;96m'       # Cyan
BIWhite='\033[1;97m'      # White

# High Intensity backgrounds
On_IBlack='\033[0;100m'   # Black
On_IRed='\033[0;101m'     # Red
On_IGreen='\033[0;102m'   # Green
On_IYellow='\033[0;103m'  # Yellow
On_IBlue='\033[0;104m'    # Blue
On_IPurple='\033[0;105m'  # Purple
On_ICyan='\033[0;106m'    # Cyan
On_IWhite='\033[0;107m'   # White

# --------------------------------------------------------------------VARS ---------------------------------------------------------------------------------------------

NAME			= minishell                												# name of the program

CC				= gcc                       											# compiler

CFLAGS			= -Wall -Wextra -Werror -g
			# flags

RM				= rm -f           														# remove

BREW			:= $(shell brew -v 2> /dev/null)										# define brew if it's installed

ifdef BREW																				# define path to readline dir if brew is installed
	READLINE_DIR	:= $(shell brew --prefix readline)
endif


# -----------------------------------------------------------------SOURCE FILES ----------------------------------------------------------------------------------------
SRCS			= 		lexer/lexer.c \
						lexer/lex_utils.c \
						lexer/lex_space.c \
						lexer/lex_redir.c \
						lexer/lex_quotes.c \
						lexer/lex_pipe.c \
						lexer/lex_null.c \
						lexer/lex_init.c \
						lexer/lex_char.c \
						parser/parser.c \
					 	parser/parse_arg.c \
						parser/parse_heredoc1.c \
						parser/parse_heredoc2.c \
						parser/parse_heredoc3.c \
						parser/parse_init.c \
						parser/parse_pipe.c \
						parser/parse_redir.c \
						parser/parse_redir_append.c \
						parser/parse_redir_input.c \
						parser/parse_redir_output.c \
						parser/parse_utils.c \
						signals/signals.c \
                        main.c \
                        expander/expander.c \
                        expander/expand_heredoc.c \
                        expander/heredoc_utils.c \
                        expander/heredoc_utils_2.c \
                        expander/heredoc_utils_3.c \
						executor/execute.c \
						utils/utils_envars_1.c \
						utils/utils_envars_2.c \
						utils/utils_envars_3.c \
						executor/utils_execute_1.c \
						executor/utils_execute_2.c \
						executor/execute_builtin.c \
						executor/execute_simple_command.c \
						executor/do_piped_command.c \
						executor/do_simple_command.c \
						executor/redirect_piped_command.c \
						executor/redirect_simple_command.c \
						executor/do_pipeline.c \
						utils/utils_cmd.c \
						utils/utils_token.c \
						builtins/msh_env.c \
						builtins/msh_exit.c \
						builtins/msh_cd.c \
						builtins/msh_echo.c \
						builtins/msh_export.c \
						builtins/msh_export_noarg.c \
						builtins/msh_unset.c \
						builtins/msh_export_arg.c \
                     	builtins/msh_pwd.c \
						utils/exitcode.c \
						utils/shlvl.c \
						utils/error.c \
						executor/redirect_in.c \
						executor/redirect_out.c \
						parser/parse_add_cmd.c \

OBJS	   		 = $(SRCS:.c=.o)       	 												# transforms all the ".c" files into ".o" (objects)

HEADER			 = -Iincludes -I./libft.h -I$(READLINE_DIR)/include 					# adds headers

LIBFT 			 = make -C libft/														# compiling Libft

NORM 			 = @norminette 														 	# checking the norm 



# -------------------------------------------------------------------- RULES -------------------------------------------------------------------------------------------

.c.o:		
			@$(CC) $(CFLAGS) $(HEADER) -c $< -o $(<:.c=.o)

all:	    $(NAME)   																	# will execute NAME rule
		
$(NAME):	$(OBJS)
			@ $(NORM)
			@echo $(Green)√$(Color_Off)$(BBlue)Norm is OK!$(Color_Off);
			@$(LIBFT)
			@echo $(BRed) "$$HEADLOGO" $(Color_Off)					
			@$(CC) $(CFLAGS) -L ./libft -lft -L $(READLINE_DIR)/lib -lreadline $(OBJS) -o $(NAME)
			@test -z '$(filter %.o,$?)' || echo $(BGreen)√$(Color_Off)$(BBlue)Minishell Has Been Compiled!$(Color_Off);
			@echo $(BBlue)To Use Minishell :$(BGreen)$(UGreen)./minishell $(Color_Off);

clean: 																					# remove all .o
			@$(RM) $(OBJS) libft/*.o 
			@echo $(BGreen)√$(Color_Off)$(BBlue)Clean Succeeded, All The '.o' Has Been Removed!$(Color_Off);
														         
fclean: clean                            												# force remove NAME
			@$(RM) $(NAME) libft/*.o libft/*.a 
			@echo $(BGreen)√$(Color_Off)$(BBlue)Fclean Succeeded, Everything Has Been Removed!$(Color_Off);


re: fclean all 																			# rule to recompile MAKEFILE (will remove everything and allows to recompile again)
			@echo $(BGreen)√$(Color_Off)$(BBlue)Recompile Succeeded!$(Color_Off);	

leaks:		${NAME}																		# adds valgrind to check system leaks
			valgrind --leak-check=full --show-leak-kinds=all ./$(NAME)
			@echo $(BBlue)No Leaks Detected$(Color_Off);

# ----------------------------------------------------------------------PHONY --------------------------------------------------------------------------------------------

.PHONY: all clean fclean leaks re             											# in phony section we need to include all used rules
