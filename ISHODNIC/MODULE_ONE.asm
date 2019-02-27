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
 MODULE_CREATE_CHILD_proc       PROTO     hWnd1 :DWORD  
;###########################################################
EXTERN    HINST:DWORD 
EXTERN    HWNDN:DWORD 
EXTERN    HWNDM:DWORD 
EXTERN    HWNDD:DWORD 
EXTERN    HWNDY:DWORD 
EXTERN    HWNDZ:DWORD 

;###########################################################
;data--data--data--data--data--data--data--data--data--data--     PROC
;----------------------------------------------------------------------------------------------
.DATA
EDIT_CLASS        DB    "EDIT",0
String_NULL            DB    0 , 0 , 0 , 0
BUTTON_CLASS        DB    "BUTTON",0
BUTTON_NAME_1           DB     "Расчитать!",0
LABEL_CLASS        DB    "STATIC",0
LABEL_NAME_N       DB     "N = ",0
LABEL_NAME_M       DB     "M = ",0
LABEL_NAME_D       DB     "D = ",0
LABEL_NAME_Y       DB     "Y = ",0
LABEL_NAME_Z       DB     "Z = ",0
;-
Green_BRUSH        DWORD      Null
Red_BRUSH           DWORD       Null

;##############################################################
;code--code--code--code--code--code--code--code--code--code-- PROC
;--------------------------------------------------------------------------------------------------
.CODE  
START:  
;---------------------------------------------------------------------------------------------------------------
;                                       CREATE        CHILD                                                               
;---------------------------------------------------------------------------------------------------------------
MODULE_CREATE_CHILD_proc                 PROC     hWnd1 :DWORD 
local  _hWndGroup :DWORD
           invoke  CreateSolidBrush  ,  0033FF67h
           mov   Green_BRUSH   ,  EAX
;-1 StaticN
             	  invoke    CreateWindowEx   ,  NULL ,    addr    LABEL_CLASS   , \
             	 				                                                addr    LABEL_NAME_N    , \
                		WS_CHILD + WS_VISIBLE   ,   20 ,20 , 50 ,20 , \
                		hWnd1  ,  NULL  ,  HINST ,  NULL
 	        
 	        ; 
 	         ;-2 StaticD
             	  invoke    CreateWindowEx   ,  NULL ,    addr    LABEL_CLASS   , \
             	 				                                                addr    LABEL_NAME_D    , \
                		WS_CHILD + WS_VISIBLE   ,   20 ,60 , 50 ,20 , \
                		hWnd1  ,  NULL  ,  HINST ,  NULL
 	        ;
 	        ;-3 StaticM
             	  invoke    CreateWindowEx   ,  NULL ,    addr    LABEL_CLASS   , \
             	 				                                                addr    LABEL_NAME_M    , \
                		WS_CHILD + WS_VISIBLE   ,   20 ,100 , 50 ,20 , \
                		hWnd1  ,  NULL ,  HINST ,  NULL
 	        ; 

 	        ;-4 StaticY
             	  invoke    CreateWindowEx   ,  NULL ,    addr    LABEL_CLASS   , \
             	 				                                                addr    LABEL_NAME_Y   , \
                		WS_CHILD + WS_VISIBLE   ,   20 ,140 , 50 ,20 , \
                		hWnd1  , NULL  ,  HINST ,  NULL
 	        ; 
 	        ;-5 StaticZ
             	  invoke    CreateWindowEx   ,  NULL ,    addr    LABEL_CLASS   , \
             	 				                                                addr    LABEL_NAME_Z    , \
                		WS_CHILD + WS_VISIBLE   ,   20 ,240 , 50 ,20 , \
                		hWnd1  ,  NULL  ,  HINST ,  NULL
 	        ; 
;-1 EditN
             	  invoke    CreateWindowEx   ,  NULL ,    addr    EDIT_CLASS   , \
             	 				                                                addr    String_NULL    , \
                		WS_CHILD + WS_VISIBLE  +  WS_BORDER   ,   70 ,20 , 150 ,20 , \
                		hWnd1  ,  1  ,  HINST ,  NULL
                		mov	HWNDN,	eax
 	        ; 
;-2 EditD
             	  invoke    CreateWindowEx   ,  NULL ,    addr    EDIT_CLASS   , \
             	 				                                                addr    String_NULL    , \
                		WS_CHILD + WS_VISIBLE  +  WS_BORDER   ,   70 ,60 , 150 ,20 , \
                		hWnd1  ,  3  ,  HINST ,  NULL
                		mov	HWNDD,	eax
 	        ;
;-3 EditM
             	  invoke    CreateWindowEx   ,  NULL ,    addr    EDIT_CLASS   , \
             	 				                                                addr    String_NULL    , \
                		WS_CHILD + WS_VISIBLE  +  WS_BORDER   ,   70 ,100 , 150 ,20 , \
                		hWnd1  ,  2  ,  HINST ,  NULL
                		mov	HWNDM,	eax
 	        ;

;-4 EditY
             	  invoke    CreateWindowEx   ,  NULL ,    addr    EDIT_CLASS   , \
             	 				                                                addr    String_NULL    , \
                		WS_CHILD + WS_VISIBLE  +  WS_BORDER   ,   70 ,140 , 150 ,20 , \
                		hWnd1  ,  4  ,  HINST ,  NULL
                		mov	HWNDY,	eax
 	        ;   
;-5 EditD
             	  invoke    CreateWindowEx   ,  NULL ,    addr    EDIT_CLASS   , \
             	 				                                                addr    String_NULL    , \
                		WS_CHILD + WS_VISIBLE  +  WS_BORDER   ,   70 ,240 , 150 ,20 , \
                		hWnd1  ,  5  ,  HINST ,  NULL
                		mov	HWNDZ,	eax
 	        ; 

 	        
;-Button

 	         invoke    CreateWindowEx   ,  NULL ,    addr    BUTTON_CLASS   , \
             	 				                        addr  BUTTON_NAME_1  , \
                		WS_CHILD + WS_VISIBLE + BS_FLAT   ,   70 , 180 , 150 ,40 , \
                		hWnd1  ,  7  ,  HINST ,  NULL
 	        ;            		         	         	         	         	         
;-
RET  4
MODULE_CREATE_CHILD_proc                 ENDP
;-------------------------------------------------------------------------------------------------------------------------------
;                                          SEND    MESSAGE   to   EDIT                                                                  
;-------------------------------------------------------------------------------------------------------------------------------

    
;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++
END 









