REPORT Z_INVENTORY.

data v type i.

select-options s_matnr for v.

PARAMETERS p_werks type mard-werks.





TYPES: BEGIN OF TY_MARA,
         MATNR TYPE MARA-MATNR,
         MTART TYPE MARA-MTART,
         WERKS TYPE MARD-WERKS,
         LGORT TYPE MARD-LGORT,
         LABST TYPE MARD-LABST,

       END OF TY_MARA.




DATA IT_MARA TYPE TABLE OF TY_MARA.
DATA WA_MARA TYPE TY_MARA.



SELECT  A~MATNR
        A~MTART
        B~WERKS
        B~LGORT
        B~LABST  FROM MARA AS A
        INNER JOIN MARD AS B
  ON A~MATNR = B~MATNR
  INTO TABLE IT_MARA where b~werks = p_werks and a~matnr in s_matnr .


IF SY-SUBRC = 0.
  WRITE: /'material',
          11 'material_type',
          27 'plant',
          35 'storage_location',
           63'stock'.
  ULINE.

  LOOP AT IT_MARA INTO WA_MARA.
    WRITE:/ WA_MARA-MATNR,
           11 WA_MARA-MTART,
           27 WA_MARA-WERKS,
           35 WA_MARA-LGORT,
           53 WA_MARA-LABST.

  ENDLOOP.
ELSE.
  MESSAGE E000(ZMESSAGE).


ENDIF.