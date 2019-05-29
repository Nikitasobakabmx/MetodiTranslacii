#include <iostream>
#include <string>
#include "except.h"
//lex
#define T_NEWLINE '\n'
#define T_TWO '2'
#define T_THREE '3'
#define T_FOUR '4'
#define T_PLUS '+'
#define T_MULTIPLYER '*'
#define T_MINUS '-'
//product rule
/*
    S: E;
    E: E E '+' | E E "*" | E E "-";
    E: '2' | '3' | '4'; 
*/

char S();
char E();
char X(char Xi);
char Z(char Z0, char Z1);
char N();

//prototype
void next();


std::string string;
char curVal;
std::string translationString;
int position = -1;

void next()
{
    if(++position == string.size())
    {
        curVal = -1;
        return;
    }    
    curVal = string[position];
    switch (curVal)
    {
        case T_TWO:{ curVal = 2; break;}
        case T_THREE: {curVal = 3; break;}
        case T_FOUR: {curVal = 4; break;}
        case T_PLUS: {curVal = '+'; break;}
        case T_MULTIPLYER: {curVal = '*'; break;}
        case T_MINUS: {curVal = '-'; break;} 
        default: {throw except((char*)"lex error");break;}
    }
}

char S()
{
    if(curVal == 2 || curVal == 3 || curVal == 4)
        return E();
    else
        throw except((char*)"Parse Error! 1");    
}

char E()
{
    if(curVal == 2 || curVal == 3 || curVal == 4)
        return X(N());
    else
        throw except((char*)"Parse Error! 2");    
}

char N()
{
    if(curVal == 2 || curVal == 3 || curVal == 4)
    {
        int tmp = curVal;
        next();
        //translationString += std::to_string(tmp);
        return tmp;
    }
    else
        throw except((char*)"Parse Error! 3");    
}
char X(char Xi)
{
    if(curVal == 2 || curVal == 3 || curVal == 4)
        return X(Z(Xi, E()));
    else
        return Xi;
}


//my rubish
char previousVal = -1;
char Z(char Z0, char Z1)
{
    char val = 0;
    std::string tmpKostil = "";
    switch (curVal)
    {
        case T_PLUS:{val = Z0 + Z1; tmpKostil = "+"; break;}
        case T_MULTIPLYER:{val = Z0 * Z1; tmpKostil = "*"; break;}
        case T_MINUS:{val = Z0 - Z1; tmpKostil = "-"; break;}
        default : val = 0;
    }
    next();
    if(val == 0)
        return 0;
    if(Z0 != previousVal)
        translationString += "(" + std::to_string(int(Z0)) + tmpKostil +  std::to_string(int(Z1)) + ")";
    else
        translationString += tmpKostil +  std::to_string(int(Z1));
    previousVal = val;
    return val;
    
}

int main()
{
    while (true)
    {
        try
        {
            std::cin >> string;
            next();
            int val = S();
            std::cout << translationString << " = " << val << std::endl;
        }
        catch(except &ex)
        {
            std::cout << ex.what();
        }
        string.erase();
        translationString.erase();
        position = -1;
    }
}