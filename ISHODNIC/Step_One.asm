          .386
        .model flat,stdcall
  option   casemap:none
                        include C:\masm32\INCLUDE\WINDOWS.INC
                        include C:\masm32\INCLUDE\KERNEL32.INC 
                        include C:\masm32\INCLUDE\USER32.INC
                        include C:\masm32\INCLUDE\ADVAPI32.INC 
                        include   C:\masm32\INCLUDE\GDI32.INC                                                
                        include  my.inc
                                                                     
                        includelib C:\masm32\lib\comctl32.lib
                        includelib C:\masm32\lib\user32.lib
                        includelib C:\masm32\lib\gdi32.lib
                        includelib C:\masm32\lib\kernel32.lib                
                        includelib C:\masm32\lib\user32.lib
                        includelib C:\masm32\lib\advapi32.lib      
;###########################################################
MAIN_WINDOW_PROC     PROTO   :DWORD ,  :DWORD , :DWORD ,  :DWORD 
MODULE_CREATE_CHILD_proc       PROTO     hWnd1 :DWORD  
IntegerIn	PROTO   : DWORD
;###########################################################
public    HINST
public    HWNDN
public    HWNDM
public    HWNDD
public    HWNDY
public    HWNDZ
;###########################################################
;data--data--data--data--data--data--data--data--data--data--     PROC
;----------------------------------------------------------------------------------------------
.DATA
HINST        DWORD      NULL
HWND_WIN        DWORD     NULL
HWNDN		DWORD	NULL
HWNDM		DWORD	NULL
HWNDD		DWORD	NULL
HWNDY		DWORD	NULL
HWNDZ		DWORD	NULL
;text db 255,?,255 dup(0) 
textN db 255 dup(0) 
textM db 255 dup(0) 
textD db 255 dup(0) 
textY db 255 dup(0) 
textZ db 255 dup(0) 
rez db 255 dup(0)
n	dw	0
m	dw	0
d	dw	0
y	dw	0
z	dw	0
a	dw	0
b	dw	0
x dw 0
;-
String_CLASS              DB    "MY_WINDOW",0  
String_CAPTION             DB  "MY_CAPTION",0

OUTPUT             DB    255 dup(0)  
CONTROL            DB  "%d",0
;-
MSG_WIN        MSG      <0>
;-
CONTENER         DB    256   dup (0)
;##############################################################
;code--code--code--code--code--code--code--code--code--code-- PROC
;--------------------------------------------------------------------------------------------------
.CODE  
START:
                invoke  GetModuleHandle  ,  Null 
                 mov    HINST   ,  EAX   
                    ;-        
                      CALL   MY_REGISTER_CLASS 
	                  cmp   EAX  ,  null
	              je   EXIT
	          ;-       
	          ;������ �������� �������� ����
                invoke    CreateWindowEx   ,  NULL ,    addr    String_CLASS   ,  addr  String_CAPTION  , \
                		WS_OVERLAPPEDWINDOW ,   100 , 100 ,  500 ,  500  , \
                		NULL ,  NULL  ,  HINST ,  NULL	
                  ;-       
                  MOV   HWND_WIN  , EAX		
                  ;-	
                invoke  ShowWindow   ,  HWND_WIN   , TRUE  
                invoke  UpdateWindow ,  HWND_WIN      
                
                
                        								          
          ;====================
          ;������� ����� ��������� ���������
MSG_LOOP:
			   invoke   GetMessage  ,    addr  MSG_WIN  , null , null , null
			   CMP   Eax  ,  FALSE
		        JE    EXIT	   
		        
			   invoke   TranslateMessage  ,   addr   MSG_WIN 
			   invoke   DispatchMessage       , addr  MSG_WIN
	               JMP   MSG_LOOP
          ;====================	
EXIT:     
             invoke               ExitProcess        ,       Null
;----------------------------------------------------------------------------------------------------------
;                                    GET   POINT  SCREEN                                                        
;---------------------------------------------------------------------------------------------------------- 
MY_REGISTER_CLASS  PROC   
local  _Struct_WNDCLASS : WNDCLASS  
;-
      Mov  _Struct_WNDCLASS.style               ,       CS_DBLCLKS              ;  �����  ����
            ;  Mov   Eax  ,  
      Mov  _Struct_WNDCLASS.lpfnWndProc       ,     MAIN_WINDOW_PROC   ; ��������� ����
      Mov  _Struct_WNDCLASS.cbClsExtra     ,    null            ; �������������� ������ ��� ������
      Mov  _Struct_WNDCLASS.cbWndExtra   ,   null            ; �������������� ������ ���  ����
              Mov   Eax  ,  HINST
      Mov  _Struct_WNDCLASS.hInstance     ,       Eax         ;  handle   ����������

      Mov  _Struct_WNDCLASS.lpszMenuName     ,    NULL   ;  ������������� ����
      Mov  _Struct_WNDCLASS.lpszClassName   ,     offset  String_CLASS  ;   ����� ������ ������
   ;-
            invoke   LoadIcon  ,   NULL  ,    IDI_ASTERISK	                 
      Mov  _Struct_WNDCLASS.hIcon       ,      Eax
         ;-
            invoke   LoadCursor  ,  NULL  ,   IDC_IBEAM
      Mov  _Struct_WNDCLASS.hCursor      ,   Eax
         ;-
            invoke   CreateSolidBrush  ,  00FF0000h               ;  ��������� �������������  �����
              invoke   GetStockObject     ,   LTGRAY_BRUSH		
      Mov  _Struct_WNDCLASS.hbrBackground     ,  Eax
;==============   
	      invoke  RegisterClassA        ,   addr     _Struct_WNDCLASS             
;==============  
ret  
MY_REGISTER_CLASS   ENDP
;---------------------------------------------------------------------------------------------------------------------------
;                                           WINDOW        PROCEDURE                                                              
;---------------------------------------------------------------------------------------------------------------------------
MAIN_WINDOW_PROC     PROC   USES  EBX   ESI  EDI  \
                      			      hWnd_  :DWORD , MESG :DWORD , wParam :DWORD ,  lParam:DWORD 
LOCAL    _hwnd_Win :DWORD                       			      
;-
                                            CMP     MESG    ,    WM_CREATE	;��������
                                       JE      WMCREATE                   
                                      	CMP	MESG	,	WM_COMMAND	;�������
                                       	JE	BUTTON_CHECK                      
                                            CMP     MESG    ,     WM_DESTROY	;��������
                                      JE       WMDESTROY     
    	
;----                                         
DEF_:	
               invoke   DefWindowProc ,  hWnd_   ,   MESG  ,  wParam , lParam  
               jmp      FINISH
;----                                         


WMCREATE:	;�������� �������� �����������

                                INVOKE MODULE_CREATE_CHILD_proc    ,  hWnd_

                                    jmp    FINISH
BUTTON_CHECK:
				mov	eax,	wParam
				cmp	wParam,	0
				je	FINISH
					cmp	ax,	7
						jne	FINISH
					shr	eax,	16
						cmp	ax,	BN_CLICKED
						jne	FINISH
						invoke	SendMessage,[HWNDN],WM_GETTEXT,10,addr textN	;������ N
						invoke	SendMessage,[HWNDM],WM_GETTEXT,10,addr textM	;������ M
						invoke	SendMessage,[HWNDD],WM_GETTEXT,10,addr textD	;������ D
						invoke	SendMessage,[HWNDY],WM_GETTEXT,10,addr textY	;������ Y
;�������� �� �������� � ���������� 
lea eax, textN
invoke IntegerIn,	eax
mov	n,	ax

lea eax, textM
invoke IntegerIn,	eax
mov	m,	ax

lea eax, textD
invoke IntegerIn,	eax
mov	d,	ax

lea eax, textY
invoke IntegerIn, 	eax
mov	y,	ax

;����� ������ �� �������
 formula:
	cmp d, 15  	;
	jg Dgreate		;���� d>15, ����� �� Dgreate	

	mov ax, m		;m � ax
	imul n		;m*n
	mov a, ax		;��������� � a
	
	mov ax, y		;y � ax
	idiv n 		;y/n
	mov b, ax		;��������� � b
	mov ax, a		;m*n � ax
	sub ax, [b]	;m*n-y/b
	mov [z], ax	;Z
	jmp finish		;������� �� ����� finish
Dgreate:		
	mov ax, y		;y � ax
	sub ax, m		;(y-m)
	mov a, ax		;��������� � a
	
	mov ax, y		;y � ax
	sub ax, d		;(y-d)
	mov b, ax		;��������� � b	
	
	mov ax, a		;(y-m) � ax
	imul [b]		;(y-m)*(y-d)
	mov [z], ax	;Z

finish:
mov ax, z

invoke wsprintf, addr rez,addr CONTROL, ax	;������� ����� � ������
invoke	SendMessage,[HWNDZ],WM_SETTEXT,NULL,addr rez	;����� ����������
							
					jmp    FINISH
                                    
WMDESTROY:
                        
              invoke    PostQuitMessage ,  False
              jmp	FINISH
 
;- 


FINISH:
RET  16                      					  
MAIN_WINDOW_PROC     ENDP
;^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^







;===========================
IntegerIn proc	text: DWORD
	mov x,0
	mov ebx, 0
	mov eax, 0
	mov edx, 0
	mov ecx, 0	;�������� �������
	mov eax,10	;�������� �� 10 ������ ����
	mov ebx, text	;������ ������
	mov dl, [ebx]	;������� � [dl]
	cmp dl, '-'		;���� -
	je GetInteger	;����� �����
loopGetUnsigned:
	mov dl, [ebx]	;������ � dl
	cmp dl, 0
	je  ff
	mul x		;�������� �� 10
	mov x, ax		;���������� ���������
	mov dl, [ebx]	;������� � [dl]
	sub dl, 30h		;�������� �����
	add x, dx		;���������� � ����������
	inc ebx		;��������� � ���������� �����
	mov ax,10	;��������������� ���������

	
	jmp	loopGetUnsigned	
ff:	
	mov ax, x		;��������� � ax
	ret	
GetInteger:
	mov ax,10		;�������� �� 10 ������ ����
	mov ch, 0		;�������� �������
	mov dh, 0		;� dl ����� �������� ����� � [bx]
	;dec cl		;���������� '-'
	inc bx		;��������� � ���������� �����
loopGetInteger: 
	mov dl, [ebx]	;������ � dl
	cmp dl, 0
	je  ff2
	mul x		;�������� �� 10
	mov x, ax		;���������� ���������
	mov dl, [ebx]	;������ � dl
	sub dl, 30h		;�������� �����
	add x, dx		;���������� � ����������
	inc ebx		;��������� � ���������� �����
	mov ax,10		;��������������� ���������
	jmp	loopGetInteger
ff2:
	mov ax, x		;��������� � ax
	neg ax		;������ ����
	ret	
IntegerIn endp

;===========================













END  START

