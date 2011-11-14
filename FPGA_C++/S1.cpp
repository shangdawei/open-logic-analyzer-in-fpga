#include <cstdio>
#include <iostream>
#include <cstdlib>

using namespace std;

FILE* ifile;
FILE* ofile;
FILE* cfgfile;
const char iname[255]="DATA.dat";
const char oname[255]="ODATA.dat";
const char cfgname[255]="Config.ini";
void reperr(char *s){
	printf("%s\n",s);
	fclose(ifile);
	fclose(ofile);
	system("PAUSE");
}

const int Channels=16;
unsigned char buf[Channels+5];
unsigned char tbuf[Channels+5];
unsigned int line;
int main(){
	unsigned char c;
	unsigned char n;
	int i,j;
	int cfgs[50];
	line=0;
	unsigned char bufc;
	ifile=fopen(iname,"rb");
	ofile=fopen(oname,"wb");
	cfgfile=fopen(cfgname,"r");

	if(ifile==NULL)
		reperr("0010:input Idata File open ERROR");
    if(ofile==NULL)
        reperr("0011:output Odata File open ERROR");
	if(cfgfile==NULL)
        reperr("0012:output Config File open ERROR");

	for(i=0;i<Channels;i++)
        fscanf(cfgfile,"%d",&cfgs[i]);
    fclose(cfgfile);

	//c=0xFF;
	c=fgetc(ifile);
	if((c=fgetc(ifile))!=0xDA)
		reperr("0001:File Head Error");
	while(c==0xDA)
		c=fgetc(ifile);
	if(c!=0xA5)
		reperr("0002:File Div Error");

    while(1){
        if(fgets((char*)tbuf,Channels+2,ifile)==NULL)
			break;
        for(i=0;i<Channels;i++)
            buf[i]=tbuf[cfgs[i]];
        buf[Channels]=tbuf[Channels];
        if(buf[Channels]!=0xA5)
            reperr("0003:File Div Error");
		printf("%04Xh:From <",line);
		line+=Channels;
		for(i=0;i<Channels;i++)
			printf("%02X ",buf[i]);

		printf("> To <");
        for(j=0;j<8;j++){
            for(i=0;i<Channels;i++){
                bufc=(bufc<<1)|((buf[i]>>(j))&1);
                if(i%8==7){
					fputc(bufc,ofile);
					printf("%02X ",bufc);
				}
            }
        }
		printf(">\n");
		//printf("-=-Output-=-\n");
    }


}
