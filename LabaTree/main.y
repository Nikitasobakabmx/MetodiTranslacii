#include <iostream>
#define AP_left_KW 56
#define AP_right_KW 57
#define AP_end_KW 58
using namespace std;
int number;
int symbol;
int A(int);
int yylex() // ввод символов исходного текста
{
    char s;
    cin>>s;
    switch (s)
    {
        case '(': return AP_left_KW;
        case ')': return AP_right_KW;
        case '$': return AP_end_KW;
        default : return -1;
    }
}
int Y(int inherited)
{
    int synthesized;
    switch (symbol)
    {
        case AP_left_KW:{
            if(( synthesized=A(inherited))==-1) //Y ::= { Ai = Y i } A )
            else if(symbol==AP_right_KW)
                return synthesized; //{Ys = As }
                return -1;
            else
                return -1;
        }

        case AP_right_KW: 
        {
            symbol=yylex();//Y ::= )
            return inherited;
        }// { Ys = Yi }

        default: return -1;
    }
}
int T(int inherited)
{
    symbol=yylex();
    return Y(inherited+1);// T ::= ( { Yi = Ti + 1 } Y { Ts = Ys }
}

int Z()
{
    switch (symbol)
    {
        case AP_left_KW: T(0); return Z();//Z ::= { Ti = 0 } T Z
        case AP_right_KW: return 0; // Z ::= Λ
        case AP_end_KW: return 0; // Z ::= Λ
        default: return -1;
    }
}
int A(int inherited)
{
    if(symbol==AP_left_KW)
    {
        int synthesized=T(inherited); //A ::= { Ti = Ai } T Z
        Z();
        return synthesized; //{ As = Ts }
    }
    else
        return -1;
}
void main()
{
    symbol=yylex();
    int y=A(0); //A - аксиома
    // анализ результата трансляции:
    if(y<0)
        cout<<"error\n";
    else 
        cout<<"prefix length "<<y<<'\n';
}
