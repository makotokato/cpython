    AREA |.text|, CODE, ARM64

    IMPORT |ffi_prep_args|
    EXPORT |ffi_call_ARM64|
    EXPORT |ffi_closure_OUTER|

; extern int
; ffi_call_ARM64(void (*)(char *, extended_cif *),
; 		 /*@out@*/ extended_cif *,
;		 unsigned, unsigned,
;		 /*@out@*/ unsigned *,
;		 void (*fn)());

|ffi_call_ARM64| PROC
    sub sp, sp, #96
    stp x29, x30, [sp]
    stp x0, x1, [sp, #16]
    stp x2, x3, [sp, #32]
    stp x3, x4, [sp, #48]
    str x5, [sp, #64]

    mov x1, x0
    sub sp, sp, #128 ; (parameter * sizeof(void*) + sizeof(double) * 8)
    mov x0, sp
    bl ffi_prep_args

    ldp d0, d1, [sp]
    ldp d2, d3, [sp, #16]
    ldp d4, d5, [sp, #32]
    ldp d6, d7, [sp, #48]

    ldp x0, x1, [sp, #64]
    ldp x2, x3, [sp, #80]
    ldp x4, x5, [sp, #96]
    ldp x6, x7, [sp, #112]

    add sp, sp, #128
    ldr x8, [sp, #64]
    blr x8

    add sp, sp, #96
    ldp x29, x30, [sp, #-96]
    ret
    ENDP

|ffi_closure_OUTER| PROC
    ret
    ENDP

    END