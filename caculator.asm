.MODEL SMALL
.STACK 100H
.DATA      

CLRF  DB 13, 10,'$'
MSG1  DB 'For Add(+) type   :'1'$'
MSG2  DB 10,13,'For Sub(-) type   :'2'$'
MSG3  DB 10,13,'For Mul(*) type   :'3'$'
MSG4  DB 10,13,'For Div(/) type   :'4'$'
MSG10 DB 10,13,'For Pow(^) type   :'5'$'
MSG5  DB 10,13,'Choose Any One:$'
MSG6  DB 10,13,10,13,'Enter 1st Number:$'
MSG7  DB 10,13,'Enter 2nd Number:$'
MSG8  DB 10,13,10,13,'The Result is: $' 
MSG9  DB 10,13, 'Wrong input. Choose again 1 -> 5$'
MSG   DB 10,13,10,13,'               ***THANK YOU FOR USING MY APP***$'
TENAPP   DB '               *********Mini Calculator********$'                           
TMP DW ?
TMP1 DW ? 
TMP2 DW ?
.CODE   

;   --------Main function-------------

MAIN PROC
    
    MOV AX,@DATA
    MOV DS,AX 
    
    MOV AH,9
    LEA DX,TENAPP
    INT 21H
    
    CALL nextLine
    CALL nextLine
    
Input:
;   In thong bao chon phep tinh cong    
    LEA DX,MSG1
    MOV AH,9
    INT 21H

;   In thong bao chon phep tinh tru     
    LEA DX,MSG2
    MOV AH,9
    INT 21H

;   In thong bao chon phep tinh nhan    
    LEA DX,MSG3
    MOV AH,9
    INT 21H

;   In thong bao chon phep tinh chia    
    LEA DX,MSG4
    MOV AH,9
    INT 21H  
    
;   In thong bao chon phep tinh mu
    LEA DX,MSG10
    MOV AH,9
    INT 21H
    
;   In thong bao nguoi dung lua chon phep tinh     
    LEA DX,MSG5
    MOV AH,9
    INT 21H
    
;   Nhap ki tu tu ban phim, chuyen tu ki tu sang so  
    MOV AH,1
    INT 21H
    MOV BH,AL
    SUB BH,48
    
;   Logic chon dau vao    
    CMP BH,1
    JE ADD
    
    CMP BH,2
    JE SUB
     
    CMP BH,3
    JE MUL
    
    CMP BH,4
    JE DIV  
    
    CMP BH,5
    JE POW

;   Neu nhap input khac 1 den 5 thi in ra tbao nhap lai input    
    LEA DX, MSG9
    MOV AH, 9
    INT 21H
    
    CALL nextLine; Xuong dong
    
    JMP Input; Tro lai buoc nhap input


    
;   ---------Cong 2 so----------    
  ADD:
    MOV BH, 0; Vi o ham main su dung thanh ghi BH, nen o day ta gan no lai bang 0
        
    LEA DX,MSG6  ;tbao ENTER 1ST NUMBER
    MOV AH,9
    INT 21H 
    
    CALL inputDec     ; goi ham nhap so thu nhat he 10
    PUSH AX           ; luu ax da nhap lai
    CALL nextLine
    
    LEA DX,MSG7    ;tbao ENTER 2ND NUMBER
    MOV AH,9
    INT 21H 
    
    CALL inputDec   ; goi ham nhap so thu hai
    MOV BX,AX
    CALL nextLine  ;Xuong dong
    
    POP AX            ; goi ax tu Stack ra
    CALL tong         ; goi ham tinh tong 2 so (trong ax va bx)
    PUSH AX
    
    LEA DX,MSG8    ;in tbao ket qua
    MOV AH,9
    INT 21H
    
    POP AX
    CALL outputDec   ; goi ham in ket qua
    
    JMP EXIT_P       ;nhay xuong buoc in ket thuc chuong trinh



    
;  ----------------------Tru 2 so---------------------    
   SUB: 
   
    MOV BH, 0; Vi o ham main su dung thanh ghi BH, nen o day ta gan no lai bang 0
        
    LEA DX,MSG6  ;ENTER 1ST NUMBER
    MOV AH,9
    INT 21H 
    
    CALL inputDec     ; goi ham nhap so thu nhat he 10
    PUSH AX           ; luu ax da nhap lai
    CALL nextLine     ; Xuong dong
    
    LEA DX,MSG7    ;ENTER 2ND NUMBER
    MOV AH,9
    INT 21H  
    
    CALL inputDec     ; goi ham nhap so thu 2
    MOV BX,AX
    CALL nextLine
    
    POP AX           ; goi ax tu Stack ra
    CALL hieu          ; goi ham tinh hieu 2 so (trong ax va bx)
    PUSH AX
    
    LEA DX,MSG8       ; in tbao ket qua
    MOV AH,9
    INT 21H
    
    POP AX
    CALL outputDec    ; goi ham in ket qua
    
    JMP EXIT_P 
    
    
    
;---------Nhan 2 so--------------------    
   MUL:
 
    MOV bh, 0
        
    LEA DX,MSG6  ;ENTER 1ST NUMBER
    MOV AH,9
    INT 21H 
    
    CALL inputDec     ; goi CTC nhap so thu nhat he 10
    PUSH AX           ; luu ax da nhap lai
    CALL nextLine
    
    LEA DX,MSG7    ;ENTER 2ND NUMBER
    MOV AH,9
    INT 21H 
    
    CALL inputDec
    MOV BX,AX
    CALL nextLine
    
    POP AX            ; goi ax tu Stack ra
    CALL tich          ; goi ham tinh tich 2 so (trong ax va bx)
    PUSH AX
    
    LEA DX,MSG8
    MOV AH,9
    INT 21H
    
    POP AX
    CALL outputDec
    
    JMP EXIT_P  
    
   
   
;----Chia 2 so----------  
   DIV:
    
    MOV BH, 0
        
    LEA DX,MSG6  ;ENTER 1ST NUMBER
    MOV AH,9
    INT 21H 
    
    CALL inputDec     ; goi CTC nhap so thu nhat he 10
    PUSH AX           ; luu ax da nhap lai
    CALL nextLine
    
    LEA DX,MSG7    ;ENTER 2ND NUMBER
    MOV AH,9
    INT 21H 
    
    CALL inputDec
    CMP AX,0
    JE nhapLai
    MOV BX,AX
    CALL nextLine
    
    POP AX            ; goi ax tu Stack ra
    CALL thuong          ; goi ham tinh thuong 2 so (trong ax va bx)
    PUSH AX
    
    LEA DX,MSG8
    MOV AH,9
    INT 21H
    
    POP AX
    CALL outputDec
    
    JMP EXIT_P
    
    nhapLai:
        MOV AH,9
        LEA DX,MSG9
        INT 21H
        
        call nextLine
    
        POP AX
        MOV AX,0 
        
        JMP Input 
        
;------Ham mu-----------------
    POW:
 
    MOV bh, 0
        
    LEA DX,MSG6  ;ENTER 1ST NUMBER
    MOV AH,9
    INT 21H 
    
    CALL inputDec     ; goi CTC nhap so thu nhat he 10
    PUSH AX           ; luu ax da nhap lai
    CALL nextLine
    
    LEA DX,MSG7    ;ENTER 2ND NUMBER
    MOV AH,9
    INT 21H 
    
    CALL inputDec
    MOV BX,AX
    CALL nextLine
    
    POP AX            ; goi ax tu Stack ra
    CALL mu          ; goi ham tinh a^b 2 so (trong ax va bx)
   
    CALL outputDec
    
    JMP EXIT_P
    
    EXIT_P:
    
        LEA DX,MSG
        MOV AH,9
        INT 21H    
        
    MOV AH,4CH
    INT 21H
MAIN ENDP 


;    ---------Chuong trinh con-------------  

; Chuong trinh con tinh tong 2 so  
    tong PROC          
        ADD AX, BX
        RET
    tong ENDP


;   Chuong trinh con tinh hieu
    hieu PROC
        SUB AX, BX
        RET
    hieu ENDP  


; Chuong trinh con tinh tich     
    tich PROC 
         MUL BX
         RET
    tich ENDP 


; Chuong trinh con tinh thuong    
    thuong PROC 
         MOV CX,0
        start: 
         CMP AX,0 
         JLE xu_ly1
         CMP BX,0
         JLE xu_ly2
         
         tinh_thuong:
            CMP CX,0
            JE thuong_duong_duong
            CMP CX,1
            JE thuong_duong_am
            CMP CX,2
            JE thuong_duong_duong
         xu_ly1:
            NEG AX
            INC CX 
            JMP start
         xu_ly2:
            NEG BX
            INC CX
            JMP start
            
          thuong_duong_duong:
            DIV BX
            JMP thoat
          thuong_duong_am:
            DIV BX
            NEG AX
         thoat:
            RET
    thuong ENDP
; Chuong trinh con tinh mu
    ;mu PROC
        mu PROC
            MOV TMP, AX
            MOV TMP1,BX
            
            ;Xet BX = 0,neu bang gan AX = 1 roi ket thuc,neu khong bang thi xet dau BX
            CMP BX,0
            JNE doi_dau
            MOV AX,1
            PUSH AX
            LEA DX,MSG8
            MOV AH,9
            INT 21H
            JMP ket_thuc
            
            doi_dau:
                CMP BX,0
                JGE xet_chan_le
                NEG BX
                
                ;Xet tinh chan le cua BX
                xet_chan_le:
                    MOV AX,BX
                    MOV TMP2,2
                    DIV TMP2  
                    MOV AX,1
                    CMP DX,0 
                    JE chan
                    MOV CX,1
                    JMP tinh_mu
                    chan:
                        MOV CX,0
                        
                ;Tinh AX^BX
                tinh_mu:
                    CMP BX,0
                    JE  xet_dau_BX
                    MUL TMP
                    DEC BX
                    JMP tinh_mu
                    
                xet_dau_BX:
                     CMP TMP1,0     ;xet xem BX la so am hay khong
                     JLE tinh_mu_am ;BX am thi xuong ham tinh_mu_am
                     
                     ;BX duong
                     CMP CX,0       ;Xet xem BX la so chan hay le
                     JNE them_AX_stack   ;Neu le thi day AX vao stack
                     ;BX chan         
                     CMP AX,0       ;Xet xem AX am hay duong
                     JLE doi_dau_AX ;Neu AX am thi doi thanh duong 
                     
                     PUSH AX
                     LEA DX,MSG8
                     MOV AH,9
                     INT 21H  
                     JMP ket_thuc   ;Neu duong thi ket thuc  
                        
                them_AX_stack:
                    PUSH AX
                    LEA DX,MSG8
                    MOV AH,9
                    INT 21H
                    JMP ket_thuc
                      
                doi_dau_AX:
                    NEG AX  
                    PUSH AX
                    LEA DX,MSG8
                    MOV AH,9
                    INT 21H
                    JMP ket_thuc
                    
                tinh_mu_am:         ;BX luc nay am
                    CMP CX,0        ;Xet xem BX chan hay le
                    JNE xet_dau_AX  ;BX le thi xet dau cua AX
                    
                    CMP AX,0        
                    JLE doi_dau_AX1 ;AX < 0
                    JMP in_phan_so
                doi_dau_AX1:
                    NEG AX
                    JMP in_phan_so
                    
                in_phan_so:  
                    PUSH AX  
                    LEA DX,MSG8
                    MOV AH,9
                    INT 21H
                    MOV DL,'1'
                    MOV AH,2
                    INT 21H
                    MOV DL,'/'
                    MOV AH,2
                    INT 21H
                    JMP ket_thuc 
                xet_dau_AX:
                    CMP AX,0                                                
                    JLE in_phan_so_am; Neu AX nho hon 0
                    JMP in_phan_so
                in_phan_so_am:
                    NEG AX
                    PUSH AX
                    LEA DX,MSG8
                    MOV AH,9
                    INT 21H 
                    MOV DL,'-'
                    MOV AH,2
                    INT 21H
                    MOV DL,'1'
                    MOV AH,2
                    INT 21H
                    MOV DL,'/'
                    MOV AH,2
                    INT 21H 
                ket_thuc:
                    POP AX
                    RET
        mu Endp          
                     
; Chuong trinh con xuong dong                                                            
    nextLine PROC    
        MOV AH, 9
        LEA DX, CLRF
        INT 21H
        RET
    nextLine ENDP

; Chuong trinh con nhap dau vao he 10     
    inputDec PROC
         
        batDau:
            MOV BX, 0 ; bien tinh tong
            MOV CX, 0
            MOV AH, 1
            INT 21H
            CMP AL, '-'
            JE dauTru
            CMP AL,'+'
            JE dauCong
            JMP tiepTuc
             
            dauTru:
                MOV CX, 1
                
            dauCong:
                INT 21H
             
            tiepTuc:
                AND AX, 000fh      ; doi thanh chu so, giai thich f sang nhi phan 1111, vd ki tu '1' trong 
                                   ; thanh ghi al co ma hex la 0x31 co ma o cuoi(1) chuyen sang nhi phan la 0001, sau cau lenh and thanh ghi al chua ma 0001 nen ki tu '1' duoc chuyen thanh so
                PUSH AX             ; luu gia tri vua nhap vao ngan xep
                MOV AX, 10           ; gan ax = 10
                 
                MUL BX              ; ax = tong*10 hay ax = bx * 10
                MOV BX, AX          
                POP AX              ; lay gia tri vua nhap ra gan vao ax chinh la cai bien 'so' o duoi
                ADD BX, AX          ; tong = tong*10 + so
                
                MOV AH, 1
                INT 21H
                CMP AL, 13          ; da enter chua?
                JNE tiepTuc         ; nhap tiep
                 
                MOV AX, BX          ; chuyen KQ ra ax
                CMP CX,1           ; co phai so am khong
                JNE ra
                NEG ax              ; neu la so am thi doi ax ra so am
                 
            ra: 
                RET
                 
    inputDec ENDP 
     
    outputDec PROC 
         
        CMP AX, 0   ;   neu ax >= 0 tuc la khong phai so am ta doi ra day
        JGE inRaDay
        PUSH AX
        MOV DL, '-'
        MOV AH, 2
        INT 21H
        POP AX
        NEG AX ; ax = -ax
         
        inRaDay:
            MOV CX, 0  ; gan cx = 0
            MOV BX, 10  ; so chia la 10
            chia:
                MOV DX, 0  ; gan dx = 0
                DIV BX      ; ax = ax / bx; dx = ax % bx
                PUSH DX      
                INC CX
                CMP AX, 0   ; kiem tra xem thuong bang khong chua?
                JNE chia    ; neu khong bang thi lai chia
                MOV AH, 2
            hien:
                POP DX
                ADD DL, 30H 
                INT 21H
                LOOP hien
                
                ; vi gia tri cac thanh ghi ban dau duoc dua vao stack 
                ;nen khi thuc hien xong co the lay tu stack va tra lai gia tri ban dau cua cac thanh ghi 
        RET
         
    outputDec ENDP
END MAIN