From: "Carlo C. Maley" <cmaley-q9hIisBwmLrYtjvyW6yDsg@public.gmane.org>
Subject: problems with a Dell Inspiron 300M
Date: Fri, 24 Oct 2003 19:25:08 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3F99DF04.90709@fhcrc.org>
Reply-To: cmaley-FrUbXkNCsVf2fBVCVOL8/A@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080601090100060707060206"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------080601090100060707060206
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I have Suse 8.2 running on my new Dell Inspiron 300M.  However, ACPI is 
only barely working.  I can boot and I have acpid running but when KDE 
starts up, it can't detect the battery level and neither standby nor 
suspend works.  

Suse claims to have patched the 2.4 kernel with the ACPI support but the 
kernel parameters like acpi=force don't seem to work 
(http://sdb.suse.de/en/sdb/html/81_acpi.html).

I've never compiled a kernel before, so I'm a little intimidated by the 
prospect described in the 2 pages I could find on this machine: 
(http://www.frogsonice.com/300m.html and 
http://www.hoolehan.com/300mlinux/).

I'm attaching the output from
acpidmp FACP | acpitbl
and
acpidmp DSDT | acpidisasm
and
dmidecode
boot.msg

Any help would be deeply appreciated.

    - Carlo Maley

-- 
Carlo C. Maley, Ph.D.
Staff Scientist
Fred Hutchinson Cancer Research Center
P.O. Box 19024
Seattle, WA 98109

phone: 206-667-4615
fax: 206-667-6132
cell: 206-355-7425

http://www.fhcrc.org/phs/barretts/cmaley/


--------------080601090100060707060206
Content-Type: text/plain;
 name="acpi-table.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="acpi-table.txt"

Signature:        FACP
Length:           116
Revision:         0x01
Checksum:         0x80
OEMID:            DELL
OEM Table ID:     MONTARA
OEM Revision:     0x06040000
Creator ID:       PTL
Creator Revision: 0x00000050
FIRMWARE_CTRL:    0x476fcfc0
DSDT:             0x476e6280
INT_MODEL:        0x00
SCI_INT:          9
SMI_CMD:          0x000000b2
ACPI_ENABLE:      0xf0
ACPI_DISABLE:     0xf1
S4BIOS_REQ:       0x00
PM1a_EVT_BLK:     0x00001000
PM1b_EVT_BLK:     0x00000000
PM1a_CNT_BLK:     0x00001004
PM1b_CNT_BLK:     0x00000000
PM2_CNT_BLK:      0x00001020
PM_TMR_BLK:       0x00001008
GPE0_BLK:         0x00001028
GPE1_BLK:         0x00000000
PM1_EVT_LEN:      4
PM1_CNT_LEN:      2
PM2_CNT_LEN:      1
PM_TM_LEN:        4
GPE0_BLK_LEN:     8
GPE1_BLK_LEN:     0
GPE1_BASE:        0
P_LVL2_LAT:       1
P_LVL3_LAT:       85
FLUSH_SIZE:       0
FLUSH_STRIDE:     0
DUTY_OFFSET:      1
DUTY_WIDTH:       3
DAY_ALRM:         0x0d
MON_ALRM:         0x00
CENTURY:          0x32
Flags:            0x00000225

--------------080601090100060707060206
Content-Type: text/plain;
 name="acpi-disassembled.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="acpi-disassembled.txt"

00000000: OpRegion PORT (\PORT)
00000006:   SystemIO
00000007:   0x80
00000009:   0x02
0000000b: Field
0000000e:   PORT (00000000)
00000012:   AccessType: ByteAcc; LockRule: NoLock; UpdateRule: Preserve
00000013:   NamedField P80H
00000018:   NamedField P81H
0000001d: OpRegion IO_T (\IO_T)
00000023:   SystemIO
00000024:   0x0800
00000027:   0x10
00000029: Field
0000002c:   IO_T (0000001d)
00000030:   AccessType: ByteAcc; LockRule: NoLock; UpdateRule: Preserve
00000031:   NamedField TRP0
00000036: OpRegion A_IO (\A_IO)
0000003c:   SystemIO
0000003d:   0x1000
00000040:   0x30
00000042: Field
00000046:   A_IO (00000036)
0000004a:   AccessType: ByteAcc; LockRule: NoLock; UpdateRule: Preserve
0000004b:   NamedField PMS0
00000050:   NamedField PMS1
00000055:   NamedField PME0
0000005a:   NamedField PME1
0000005f:   NamedField PMC0
00000064:   NamedField PMC1
00000069:   ReservedField
0000006b:   NamedField TMR0
00000070:   NamedField TMR1
00000075:   NamedField TMR2
0000007a:   NamedField TMR3
0000007f:   ReservedField
00000081:   NamedField PRC0
00000086:   NamedField PRC1
0000008b:   NamedField PRC2
00000090:   NamedField PRC3
00000095:   ReservedField
00000098:   NamedField GPS0
0000009d:   NamedField GPS1
000000a2: OpRegion GPIO (\GPIO)
000000a8:   SystemIO
000000a9:   0x1180
000000ac:   0x3c
000000ae: Field
000000b2:   GPIO (000000a2)
000000b6:   AccessType: ByteAcc; LockRule: NoLock; UpdateRule: Preserve
000000b7:   NamedField GU00
000000bc:   NamedField GU01
000000c1:   NamedField GU02
000000c6:   NamedField GU03
000000cb:   NamedField GIO0
000000d0:   NamedField GIO1
000000d5:   NamedField GIO2
000000da:   NamedField GIO3
000000df:   ReservedField
000000e1:   NamedField GL00
000000e6:   NamedField GL01
000000eb:   NamedField GL02
000000f0:   NamedField GL03
000000f5:   ReservedField
000000f8:   NamedField GB00
000000fd:   NamedField GB01
00000102:   NamedField GB02
00000107:   NamedField GB03
0000010c:   ReservedField
0000010f:   NamedField GIV0
00000114:   NamedField GIV1
00000119:   NamedField GIV2
0000011e:   NamedField GIV3
00000123:   NamedField GU04
00000128:   NamedField GU05
0000012d:   NamedField GU06
00000132:   NamedField GU07
00000137:   NamedField GIO4
0000013c:   NamedField GIO5
00000141:   NamedField GIO6
00000146:   NamedField GIO7
0000014b:   ReservedField
0000014d:   NamedField LDBK
00000152:   ReservedField
00000154:   NamedField GL05
00000159:   NamedField GL06
0000015e:   NamedField GL07
00000163: OpRegion MNVS (\MNVS)
00000169:   SystemMemory
0000016a:   0x476ecd79
0000016f:   0x40
00000171: Field
00000175:   MNVS (00000163)
00000179:   AccessType: AnyAcc; LockRule: Lock; UpdateRule: Preserve
0000017a:   NamedField OSYS
0000017f:   NamedField SMIF
00000184:   NamedField PRM0
00000189:   NamedField PRM1
0000018e:   NamedField SCIF
00000193:   NamedField PRM2
00000198:   NamedField PRM3
0000019d:   NamedField LCKF
000001a2:   NamedField PRM4
000001a7:   NamedField PRM5
000001ac:   NamedField DBGS
000001b1:   NamedField DCKS
000001b6:   NamedField CDCK
000001bb:   NamedField FPEN
000001c0:   NamedField FPST
000001c5:   NamedField LIDS
000001ca:   NamedField PWRS
000001cf:   ReservedField
000001d1:   NamedField CMAP
000001d6:   NamedField CMBP
000001db:   NamedField LPTP
000001e0:   NamedField FDCP
000001e5:   NamedField TZON
000001ea:   NamedField ACTT
000001ef:   NamedField PSVT
000001f4:   NamedField TC1V
000001f9:   NamedField TC2V
000001fe:   NamedField TSPV
00000203:   NamedField CRTT
00000208:   ReservedField
0000020a:   NamedField BVAL
0000020f:   NamedField TMP0
00000214:   NamedField TMP1
00000219:   NamedField TMP2
0000021e:   NamedField TMP3
00000223:   NamedField TMP4
00000228:   NamedField TMP5
0000022d:   NamedField IGDS
00000232:   NamedField LCDA
00000237:   NamedField TLST
0000023c:   NamedField CADL
00000241:   NamedField PADL
00000246:   NamedField CSTE
0000024b:   NamedField NSTE
00000250:   NamedField SSTE
00000255: Mutex MUTX (\MUTX)
0000025b:   SyncLevel 0x0
0000025c: Name _S0_ (\_S0_)
00000261:   Package
00000263:     0x03
00000264:     0x00
00000266:     0x00
00000268:     0x00
0000026a: Name _S3_ (\_S3_)
0000026f:   Package
00000271:     0x03
00000272:     0x05
00000274:     0x05
00000276:     0x00
00000278: Name _S4_ (\_S4_)
0000027d:   Package
0000027f:     0x03
00000280:     0x06
00000282:     0x06
00000284:     0x00
00000286: Name _S5_ (\_S5_)
0000028b:   Package
0000028d:     0x03
0000028e:     0x07
00000290:     0x07
00000292:     0x00
00000294: Scope _PR_ (\_PR_)
0000029c:   Processor CPU0 (\_PR_.CPU0)
000002a4:     0x00
000002a5:     0x00001010
000002a9:     0x06
000002aa:     Method _CST (\_PR_.CPU0._CST)
000002b1:       ArgCount 0; NotSerialized
000002b2:       If
000002b5:         PWRS (000001ca)
000002b9:         Return
000002ba:           Package
000002bd:             0x05
000002be:             0x04
000002c0:             Package
000002c2:               0x04
000002c3:               Buffer
000002c5:                 0x11
000002c7:                 ByteList <0x82 0x0c 0x00 0x7f 0x08 0x00 0x00 0x00 
000002c7:                 	      0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x79 
000002c7:                 	      0x00>
000002d8:               0x01
000002da:               0x01
000002dc:               0x03e8
000002df:             Package
000002e1:               0x04
000002e2:               Buffer
000002e4:                 0x11
000002e6:                 ByteList <0x82 0x0c 0x00 0x01 0x08 0x00 0x00 0x14 
000002e6:                 	      0x10 0x00 0x00 0x00 0x00 0x00 0x00 0x79 
000002e6:                 	      0x00>
000002f7:               0x02
000002f9:               0x01
000002fb:               0x01f4
000002fe:             Package
00000300:               0x04
00000301:               Buffer
00000303:                 0x11
00000305:                 ByteList <0x82 0x0c 0x00 0x01 0x08 0x00 0x00 0x15 
00000305:                 	      0x10 0x00 0x00 0x00 0x00 0x00 0x00 0x79 
00000305:                 	      0x00>
00000316:               0x03
00000318:               0x55
0000031a:               0xfa
0000031c:             Package
0000031e:               0x04
0000031f:               Buffer
00000321:                 0x11
00000323:                 ByteList <0x82 0x0c 0x00 0x01 0x08 0x00 0x00 0x16 
00000323:                 	      0x10 0x00 0x00 0x00 0x00 0x00 0x00 0x79 
00000323:                 	      0x00>
00000334:               0x03
00000336:               0xb9
00000338:               0x64
0000033a:       Else
0000033d:         Return
0000033e:           Package
00000341:             0x05
00000342:             0x04
00000344:             Package
00000346:               0x04
00000347:               Buffer
00000349:                 0x11
0000034b:                 ByteList <0x82 0x0c 0x00 0x7f 0x08 0x00 0x00 0x00 
0000034b:                 	      0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x79 
0000034b:                 	      0x00>
0000035c:               0x01
0000035e:               0x01
00000360:               0x03e8
00000363:             Package
00000365:               0x04
00000366:               Buffer
00000368:                 0x11
0000036a:                 ByteList <0x82 0x0c 0x00 0x01 0x08 0x00 0x00 0x14 
0000036a:                 	      0x10 0x00 0x00 0x00 0x00 0x00 0x00 0x79 
0000036a:                 	      0x00>
0000037b:               0x02
0000037d:               0x01
0000037f:               0x01f4
00000382:             Package
00000384:               0x04
00000385:               Buffer
00000387:                 0x11
00000389:                 ByteList <0x82 0x0c 0x00 0x01 0x08 0x00 0x00 0x15 
00000389:                 	      0x10 0x00 0x00 0x00 0x00 0x00 0x00 0x79 
00000389:                 	      0x00>
0000039a:               0x03
0000039c:               0x55
0000039e:               0xfa
000003a0:             Package
000003a2:               0x04
000003a3:               Buffer
000003a5:                 0x11
000003a7:                 ByteList <0x82 0x0c 0x00 0x01 0x08 0x00 0x00 0x16 
000003a7:                 	      0x10 0x00 0x00 0x00 0x00 0x00 0x00 0x79 
000003a7:                 	      0x00>
000003b8:               0x03
000003ba:               0xb9
000003bc:               0x64
000003be: Name GPIC (\GPIC)
000003c4:   0x00
000003c6: Name CTYP (\CTYP)
000003cc:   0x00
000003ce: Name ECON (\ECON)
000003d4:   0x00
000003d6: Name DSEN (\DSEN)
000003dc:   0x01
000003de: Name WEND (\WEND)
000003e4:   0x00
000003e6: Name HSAV (\HSAV)
000003ec:   0x00
000003ee: Name INWK (\INWK)
000003f4:   0x00
000003f6: Name B1SA (\B1SA)
000003fc:   0x00
000003fe: Name B2SA (\B2SA)
00000404:   0x00
00000406: Method _PIC (\_PIC)
0000040d:   ArgCount 1; NotSerialized
0000040e:   Store
0000040f:     Arg0
00000410:     GPIC (000003be)
00000414: Method _PTS (\_PTS)
0000041b:   ArgCount 1; NotSerialized
0000041c:   Store
0000041d:     Arg0
0000041e:     P80H (00000013)
00000422:   Store
00000423:     \_SB_.PCI0.PCIB.DHID (00002c48)
00000436:     \HSAV (000003e6)
0000043b:   If
0000043d:     LEqual
0000043e:       Arg0
0000043f:       0x05
00000441:     <NULL>
0000044b:     0x9a
0000044d:     <NULL>
00000457:     0x9c
00000459:     0xff
0000045b:     Store
0000045c:       ZeroOp
0000045d:       LDBK (0000014d)
00000461:     <NULL>
0000046b:     0x9d
0000046d:   If
0000046f:     LEqual
00000470:       Arg0
00000471:       0x04
00000473:     <NULL>
0000047d:     0x9a
0000047f:     <NULL>
00000489:     0x98
0000048b:     0x14
0000048d:   If
0000048f:     LEqual
00000490:       <NULL>
0000049f:       0x0f
000004a1:     Store
000004a2:       OneOp
000004a3:       \_SB_.MEDB.DCBF (00000ff4)
000004b2:   Else
000004b4:     Store
000004b5:       ZeroOp
000004b6:       \_SB_.MEDB.DCBF (00000ff4)
000004c5:   Store
000004c6:     ZeroOp
000004c7:     \_SB_.MEDB.S4FL (00001017)
000004d6:   Store
000004d7:     ZeroOp
000004d8:     \_SB_.MEDB.SPUD (00001009)
000004e7:   And
000004e8:     GL03 (000000f0)
000004ec:     0xe5
000004ee:     GL03 (000000f0)
000004f2: Method _WAK (\_WAK)
000004f9:   ArgCount 1; NotSerialized
000004fa:   Store
000004fb:     0x00
000004fd:     P80H (00000013)
00000501:   Store
00000502:     \HSAV (000003e6)
00000507:     \_SB_.PCI0.PCIB.DHID (00002c48)
0000051a:   <NULL>
00000524:   0x98
00000526:   0x00
00000528:   If
0000052a:     LEqual
0000052b:       Arg0
0000052c:       0x04
0000052e:     Notify
0000052f:       \_SB_.PWRB (00001fa1)
00000539:       0x02
0000053b:     Store
0000053c:       OneOp
0000053d:       \_SB_.MEDB.S4FL (00001017)
0000054c:   If
0000054f:     LEqual
00000550:       \_SB_.MEDB.DCBF (00000ff4)
0000055f:       OneOp
00000560:     If
00000563:       LEqual
00000564:         <NULL>
00000573:         ZeroOp
00000574:       Store
00000575:         OneOp
00000576:         \_SB_.MEDB.SPUD (00001009)
00000585:       Notify
00000586:         \_SB_.MEDB (00000fca)
00000590:         0x01
00000592:       Store
00000593:         ZeroOp
00000594:         \_SB_.MEDB.DCST (00000ffb)
000005a3:   Else
000005a5:     If
000005a7:       LEqual
000005a8:         <NULL>
000005b7:         0x0f
000005b9:       Notify
000005ba:         \_SB_.MEDB (00000fca)
000005c4:         0x00
000005c6:       Store
000005c7:         OneOp
000005c8:         \_SB_.MEDB.DCST (00000ffb)
000005d7:   Store
000005d8:     \_SB_.PCI0.LPCB.H_EC.ACEX (0000382c)
000005ef:     PWRS (000001ca)
000005f3:   If
000005f6:     LEqual
000005f7:       \_SB_.PCI0.LPCB.H_EC.B2EX (00003827)
0000060e:       0x01
00000610:     Store
00000611:       \_SB_.PCI0.LPCB.H_EC.B2AF (0000387a)
00000628:       Local0
00000629:     ShiftRight
0000062a:       Local0
0000062b:       0x10
0000062d:       Local0
0000062e:     And
0000062f:       Local0
00000630:       0xffff
00000633:       Local0
00000634:     ShiftLeft
00000635:       Local0
00000636:       0x08
00000638:       Local1
00000639:     And
0000063a:       Local1
0000063b:       0xff00
0000063e:       Local1
0000063f:     ShiftRight
00000640:       Local0
00000641:       0x08
00000643:       Local0
00000644:     Or
00000645:       Local0
00000646:       Local1
00000647:       Local0
00000648:     If
0000064a:       LNotEqual
0000064c:         Local0
0000064d:         B2SA (000003fe)
00000651:       Notify
00000652:         \_SB_.BAT2 (00001943)
0000065c:         0x01
0000065e:       Notify
0000065f:         \_SB_.BAT2 (00001943)
00000669:         0x81
0000066b:   If
0000066e:     LEqual
0000066f:       \_SB_.PCI0.LPCB.H_EC.B1EX (00003822)
00000686:       0x01
00000688:     Store
00000689:       \_SB_.PCI0.LPCB.H_EC.B1AF (00003870)
000006a0:       Local0
000006a1:     ShiftRight
000006a2:       Local0
000006a3:       0x10
000006a5:       Local0
000006a6:     And
000006a7:       Local0
000006a8:       0xffff
000006ab:       Local0
000006ac:     ShiftLeft
000006ad:       Local0
000006ae:       0x08
000006b0:       Local1
000006b1:     And
000006b2:       Local1
000006b3:       0xff00
000006b6:       Local1
000006b7:     ShiftRight
000006b8:       Local0
000006b9:       0x08
000006bb:       Local0
000006bc:     Or
000006bd:       Local0
000006be:       Local1
000006bf:       Local0
000006c0:     If
000006c2:       LNotEqual
000006c4:         Local0
000006c5:         B1SA (000003f6)
000006c9:       Notify
000006ca:         \_SB_.BAT1 (0000139e)
000006d4:         0x01
000006d6:       Notify
000006d7:         \_SB_.BAT1 (0000139e)
000006e1:         0x81
000006e3:   Return
000006e4:     Package
000006e6:       0x02
000006e7:       0x00
000006e9:       0x00
000006eb: Scope _GPE (\_GPE)
000006f3:   Method _L05 (\_GPE._L05)
000006f9:     ArgCount 0; NotSerialized
000006fa:     Notify
000006fb:       \_SB_.PCI0.MODM (00005c11)
0000070a:       0x02
0000070c:     Notify
0000070d:       \_SB_.PWRB (00001fa1)
00000717:       0x02
00000719:   Method _L0B (\_GPE._L0B)
0000071f:     ArgCount 0; NotSerialized
00000720:     Notify
00000721:       \_SB_.PCI0.PCIB (00002c23)
00000730:       0x02
00000732:   Method _L14 (\_GPE._L14)
00000739:     ArgCount 0; NotSerialized
0000073a:     If
0000073d:       \_SB_.MEDB.DSFL (00001002)
0000074c:       <NULL>
0000075b:       Signal
0000075d:         \_SB_.MEDB.DSYN (0000101e)
0000076c:       Store
0000076d:         ZeroOp
0000076e:         \_SB_.MEDB.DSFL (00001002)
0000077d:     Else
00000780:       Store
00000781:         OneOp
00000782:         \_SB_.MEDB.DSFL (00001002)
00000791:       If
00000793:         LEqual
00000794:           \_SB_.MEDB.ICNF (00001010)
000007a3:           0x00
000007a5:         If
000007a7:           IGDS (0000022d)
000007ab:           Store
000007ac:             0x10
000007ae:             SMIF (0000017f)
000007b2:           Store
000007b3:             0x00
000007b5:             TRP0 (00000031)
000007b9:         Store
000007ba:           0x01
000007bc:           \_SB_.MEDB.ICNF (00001010)
000007cb:       Wait
000007cd:         \_SB_.MEDB.DSYN (0000101e)
000007dc:         0xffff
000007df:       Reset
000007e1:         \_SB_.MEDB.DSYN (0000101e)
000007f0:       If
000007f2:         LEqual
000007f3:           \_SB_.MEDB.ICNF (00001010)
00000802:           0x01
00000804:         If
00000806:           IGDS (0000022d)
0000080a:           Store
0000080b:             0x12
0000080d:             SMIF (0000017f)
00000811:           Store
00000812:             0x00
00000814:             TRP0 (00000031)
00000818:         Store
00000819:           0x00
0000081b:           \_SB_.MEDB.ICNF (00001010)
0000082a:   Method _L15 (\_GPE._L15)
00000831:     ArgCount 0; NotSerialized
00000832:     If
00000835:       \_SB_.MEDB.DSFL (00001002)
00000844:       <NULL>
00000853:       Signal
00000855:         \_SB_.MEDB.DSYN (0000101e)
00000864:       Store
00000865:         ZeroOp
00000866:         \_SB_.MEDB.DSFL (00001002)
00000875:     Else
00000878:       Store
00000879:         OneOp
0000087a:         \_SB_.MEDB.DSFL (00001002)
00000889:       If
0000088b:         LEqual
0000088c:           \_SB_.MEDB.ICNF (00001010)
0000089b:           0x00
0000089d:         If
0000089f:           IGDS (0000022d)
000008a3:           Store
000008a4:             0x10
000008a6:             SMIF (0000017f)
000008aa:           Store
000008ab:             0x00
000008ad:             TRP0 (00000031)
000008b1:         Store
000008b2:           0x01
000008b4:           \_SB_.MEDB.ICNF (00001010)
000008c3:       Wait
000008c5:         \_SB_.MEDB.DSYN (0000101e)
000008d4:         0xffff
000008d7:       Reset
000008d9:         \_SB_.MEDB.DSYN (0000101e)
000008e8:       If
000008ea:         LEqual
000008eb:           \_SB_.MEDB.ICNF (00001010)
000008fa:           0x01
000008fc:         If
000008fe:           IGDS (0000022d)
00000902:           Store
00000903:             0x12
00000905:             SMIF (0000017f)
00000909:           Store
0000090a:             0x00
0000090c:             TRP0 (00000031)
00000910:         Store
00000911:           0x00
00000913:           \_SB_.MEDB.ICNF (00001010)
00000922:   Method _L1B (\_GPE._L1B)
00000929:     ArgCount 0; NotSerialized
0000092a:     If
0000092d:       LNotEqual
0000092f:         CADL (0000023c)
00000933:         PADL (00000241)
00000937:       Store
00000938:         CADL (0000023c)
0000093c:         PADL (00000241)
00000940:       If
00000942:         LEqual
00000943:           OSYS (0000017a)
00000947:           0x07d1
0000094a:         Notify
0000094b:           \_SB_.PCI0 (00001fbe)
00000955:           0x00
00000957:       Else
00000959:         Notify
0000095a:           \_SB_.PCI0.GFX0 (0000284f)
00000969:           0x00
0000096b:       Sleep
0000096d:         0x02ee
00000970:     Notify
00000971:       \_SB_.PCI0.GFX0 (0000284f)
00000980:       0x80
00000982:     Sleep
00000984:       0x03e8
00000987:     Notify
00000988:       \_SB_.PCI0.USB0 (00005262)
00000997:       0x00
00000999:     Notify
0000099a:       \_SB_.PCI0.USB1 (0000529d)
000009a9:       0x00
000009ab:     Notify
000009ac:       \_SB_.PCI0.USB2 (000052e9)
000009bb:       0x00
000009bd:   Method _L1D (\_GPE._L1D)
000009c4:     ArgCount 0; NotSerialized
000009c5:     Notify
000009c6:       \_SB_.PWRB (00001fa1)
000009d0:       0x02
000009d2:     If
000009d5:       ECON (000003ce)
000009d9:       If
000009dc:         LNotEqual
000009de:           LIDS (000001c5)
000009e2:           \_SB_.PCI0.LPCB.H_EC.LIDI (00003841)
000009f9:         Store
000009fa:           \_SB_.PCI0.LPCB.H_EC.LIDI (00003841)
00000a11:           LIDS (000001c5)
00000a15:         If
00000a17:           IGDS (0000022d)
00000a1b:           <NULL>
00000a1f:           LIDS (000001c5)
00000a23:         Else
00000a25:           Store
00000a26:             0x2a
00000a28:             SMIF (0000017f)
00000a2c:           Store
00000a2d:             0x00
00000a2f:             TRP0 (00000031)
00000a33:         Sleep
00000a35:           0x01f4
00000a38:         Sleep
00000a3a:           0x01f4
00000a3d:         Notify
00000a3e:           \_SB_.LID0 (00001ee8)
00000a48:           0x80
00000a4a:       If
00000a4d:         LNotEqual
00000a4f:           PWRS (000001ca)
00000a53:           \_SB_.PCI0.LPCB.H_EC.ACEX (0000382c)
00000a6a:         Store
00000a6b:           \_SB_.PCI0.LPCB.H_EC.ACEX (0000382c)
00000a82:           PWRS (000001ca)
00000a86:         Store
00000a87:           0x2b
00000a89:           SMIF (0000017f)
00000a8d:         Store
00000a8e:           0x00
00000a90:           TRP0 (00000031)
00000a94:         Notify
00000a95:           \_SB_.BAT1 (0000139e)
00000a9f:           0x80
00000aa1:         Notify
00000aa2:           \_SB_.BAT2 (00001943)
00000aac:           0x80
00000aae:         Notify
00000aaf:           \_PR_.CPU0 (0000029c)
00000ab9:           0x80
00000abb:         Sleep
00000abd:           0x64
00000abf:         Notify
00000ac0:           \_PR_.CPU0 (0000029c)
00000aca:           0x81
00000acc: Method BTTM (\BTTM)
00000ad3:   ArgCount 1; NotSerialized
00000ad4:   If
00000ad7:     FPEN (000001bb)
00000adb:     If
00000add:       FPST (000001c0)
00000ae1:       If
00000ae3:         LGreaterEqual
00000ae5:           Arg0
00000ae6:           BVAL (0000020a)
00000aea:         Store
00000aeb:           Arg0
00000aec:           BVAL (0000020a)
00000af0:         Notify
00000af1:           \_SB_.BAT1 (0000139e)
00000afb:           0x80
00000afd:         Notify
00000afe:           \_SB_.BAT2 (00001943)
00000b08:           0x80
00000b0a:     Else
00000b0c:       If
00000b0e:         LLessEqual
00000b10:           Arg0
00000b11:           BVAL (0000020a)
00000b15:         Store
00000b16:           Arg0
00000b17:           BVAL (0000020a)
00000b1b:         Notify
00000b1c:           \_SB_.BAT1 (0000139e)
00000b26:           0x80
00000b28:         Notify
00000b29:           \_SB_.BAT2 (00001943)
00000b33:           0x80
00000b35:   Else
00000b38:     If
00000b3a:       PWRS (000001ca)
00000b3e:       If
00000b40:         LGreaterEqual
00000b42:           Arg0
00000b43:           BVAL (0000020a)
00000b47:         Store
00000b48:           Arg0
00000b49:           BVAL (0000020a)
00000b4d:         Notify
00000b4e:           \_SB_.BAT1 (0000139e)
00000b58:           0x80
00000b5a:         Notify
00000b5b:           \_SB_.BAT2 (00001943)
00000b65:           0x80
00000b67:     Else
00000b69:       If
00000b6b:         LLessEqual
00000b6d:           Arg0
00000b6e:           BVAL (0000020a)
00000b72:         Store
00000b73:           Arg0
00000b74:           BVAL (0000020a)
00000b78:         Notify
00000b79:           \_SB_.BAT1 (0000139e)
00000b83:           0x80
00000b85:         Notify
00000b86:           \_SB_.BAT2 (00001943)
00000b90:           0x80
00000b92: Method HKDS (\HKDS)
00000b99:   ArgCount 1; Serialized
00000b9a:   If
00000b9d:     LEqual
00000b9e:       0x00
00000ba0:       DSEN (000003d6)
00000ba4:     Store
00000ba5:       Arg0
00000ba6:       SMIF (0000017f)
00000baa:     Store
00000bab:       0x00
00000bad:       TRP0 (00000031)
00000bb1:     If
00000bb4:       LEqual
00000bb5:         SMIF (0000017f)
00000bb9:         0x00
00000bbb:       If
00000bbe:         LNotEqual
00000bc0:           CADL (0000023c)
00000bc4:           PADL (00000241)
00000bc8:         Store
00000bc9:           CADL (0000023c)
00000bcd:           PADL (00000241)
00000bd1:         If
00000bd3:           LEqual
00000bd4:             OSYS (0000017a)
00000bd8:             0x07d1
00000bdb:           Notify
00000bdc:             \_SB_.PCI0 (00001fbe)
00000be6:             0x00
00000be8:         Else
00000bea:           Notify
00000beb:             \_SB_.PCI0.GFX0 (0000284f)
00000bfa:             0x00
00000bfc:         Sleep
00000bfe:           0x02ee
00000c01:       Notify
00000c02:         \_SB_.PCI0.GFX0 (0000284f)
00000c11:         0x80
00000c13:   If
00000c15:     LEqual
00000c16:       0x01
00000c18:       DSEN (000003d6)
00000c1c:     Store
00000c1d:       Increment
00000c1e:         Arg0
00000c1f:       SMIF (0000017f)
00000c23:     Store
00000c24:       0x00
00000c26:       TRP0 (00000031)
00000c2a:     If
00000c2c:       LEqual
00000c2d:         SMIF (0000017f)
00000c31:         0x00
00000c33:       Notify
00000c34:         \_SB_.PCI0.GFX0 (0000284f)
00000c43:         0x81
00000c45:   Sleep
00000c47:     0x03e8
00000c4a:   Notify
00000c4b:     \_SB_.PCI0.USB0 (00005262)
00000c5a:     0x00
00000c5c:   Notify
00000c5d:     \_SB_.PCI0.USB1 (0000529d)
00000c6c:     0x00
00000c6e:   Notify
00000c6f:     \_SB_.PCI0.USB2 (000052e9)
00000c7e:     0x00
00000c80: Method LSDS (\LSDS)
00000c86:   ArgCount 1; Serialized
00000c87:   If
00000c89:     Arg0
00000c8a:     <NULL>
00000c8e:     0x0c
00000c90:   Else
00000c92:     <NULL>
00000c96:     0x0e
00000c98: Method PNOT (\PNOT)
00000c9e:   ArgCount 0; Serialized
00000c9f:   Notify
00000ca0:     \_SB_.BAT1 (0000139e)
00000caa:     0x80
00000cac:   Notify
00000cad:     \_SB_.BAT2 (00001943)
00000cb7:     0x80
00000cb9:   Notify
00000cba:     \_PR_.CPU0 (0000029c)
00000cc4:     0x80
00000cc6:   Sleep
00000cc8:     0x64
00000cca:   Notify
00000ccb:     \_PR_.CPU0 (0000029c)
00000cd5:     0x81
00000cd7: Scope _TZ_ (\_TZ_)
00000cdf:   PowerRes PFAN (\_TZ_.PFAN)
00000ce6:     0x00
00000ce7:     0x0000
00000ce9:     Method _STA (\_TZ_.PFAN._STA)
00000cef:       ArgCount 0; NotSerialized
00000cf0:       Return
00000cf1:         FANE (00000d11)
00000cf5:     Method _ON_ (\_TZ_.PFAN._ON_)
00000cfb:       ArgCount 0; NotSerialized
00000cfc:       Store
00000cfd:         0x01
00000cff:         FANE (00000d11)
00000d03:     Method _OFF (\_TZ_.PFAN._OFF)
00000d09:       ArgCount 0; NotSerialized
00000d0a:       Store
00000d0b:         0x00
00000d0d:         FANE (00000d11)
00000d11:   Name FANE (\_TZ_.FANE)
00000d16:     0x01
00000d18:   Device FAN0 (\_TZ_.FAN0)
00000d1f:     Name _HID (\_TZ_.FAN0._HID)
00000d24:       PNP0c0b (0x0b0cd041)
00000d29:     Name _PR0 (\_TZ_.FAN0._PR0)
00000d2e:       Package
00000d30:         0x01
00000d31:         PFAN (00000cdf)
00000d35:   ThermalZone THRM (\_TZ_.THRM)
00000d3d:     Method _TMP (\_TZ_.THRM._TMP)
00000d44:       ArgCount 0; Serialized
00000d45:       If
00000d48:         LEqual
00000d49:           \ECON (000003ce)
00000d4e:           0x01
00000d50:         If
00000d52:           LEqual
00000d53:             \_SB_.PCI0.LPCB.H_EC.TZF5 (00003897)
00000d6a:             OneOp
00000d6b:           If
00000d6d:             LNotEqual
00000d6f:               \TZON (000001e5)
00000d74:               0x05
00000d76:             Store
00000d77:               0x05
00000d79:               \TZON (000001e5)
00000d7e:             <NULL>
00000d82:         Else
00000d85:           If
00000d87:             LEqual
00000d88:               \_SB_.PCI0.LPCB.H_EC.TZF4 (00003892)
00000d9f:               OneOp
00000da0:             If
00000da2:               LNotEqual
00000da4:                 \TZON (000001e5)
00000da9:                 0x04
00000dab:               Store
00000dac:                 0x04
00000dae:                 \TZON (000001e5)
00000db3:               <NULL>
00000db7:           Else
00000db9:             If
00000dbb:               LNotEqual
00000dbd:                 \TZON (000001e5)
00000dc2:                 0x00
00000dc4:               Store
00000dc5:                 0x00
00000dc7:                 \TZON (000001e5)
00000dcc:               <NULL>
00000dd0:         Store
00000dd1:           \_SB_.PCI0.LPCB.H_EC.CTMP (00003884)
00000de8:           Local0
00000de9:         If
00000deb:           LNotEqual
00000ded:             Local0
00000dee:             0xff
00000df0:           Return
00000df1:             Add
00000df2:               0x0aac
00000df5:               Multiply
00000df6:                 Local0
00000df7:                 0x0a
00000df9:                 <NULL>
00000dfa:               <NULL>
00000dfb:         Else
00000dfd:           Return
00000dfe:             0x0bb8
00000e01:       Else
00000e03:         Return
00000e04:           0x0bb8
00000e07:     Method _AC0 (\_TZ_.THRM._AC0)
00000e0d:       ArgCount 0; Serialized
00000e0e:       Store
00000e0f:         0x41
00000e11:         Local0
00000e12:       Return
00000e13:         Add
00000e14:           0x0aac
00000e17:           Multiply
00000e18:             Local0
00000e19:             0x0a
00000e1b:             <NULL>
00000e1c:           <NULL>
00000e1d:     Name _AL0 (\_TZ_.THRM._AL0)
00000e22:       Package
00000e24:         0x01
00000e25:         FAN0 (00000d18)
00000e29:     Method XPSV (\_TZ_.THRM.XPSV)
00000e2f:       ArgCount 0; Serialized
00000e30:       Store
00000e31:         0x78
00000e33:         Local0
00000e34:       Return
00000e35:         Add
00000e36:           0x0aac
00000e39:           Multiply
00000e3a:             Local0
00000e3b:             0x0a
00000e3d:             <NULL>
00000e3e:           <NULL>
00000e3f:     Name XPSL (\_TZ_.THRM.XPSL)
00000e44:       Package
00000e46:         0x01
00000e47:         \_PR_.CPU0 (0000029c)
00000e51:     Method _CRT (\_TZ_.THRM._CRT)
00000e57:       ArgCount 0; Serialized
00000e58:       Store
00000e59:         0x54
00000e5b:         Local0
00000e5c:       Return
00000e5d:         Add
00000e5e:           0x0aac
00000e61:           Multiply
00000e62:             Local0
00000e63:             0x0a
00000e65:             <NULL>
00000e66:           <NULL>
00000e67:     Method _SCP (\_TZ_.THRM._SCP)
00000e6d:       ArgCount 1; Serialized
00000e6e:       Store
00000e6f:         "Not Support"
00000e7c:         Debug
00000e7e:     Name _TC1 (\_TZ_.THRM._TC1)
00000e83:       0x04
00000e85:     Name _TC2 (\_TZ_.THRM._TC2)
00000e8a:       0x03
00000e8c:     Name _TSP (\_TZ_.THRM._TSP)
00000e91:       0x96
00000e93: Scope _SB_ (\_SB_)
00000e9c:   OpRegion PHSD (\_SB_.PHSD)
00000ea2:     SystemMemory
00000ea3:     0x476fcdbd
00000ea8:     0x00000190
00000ead:   Field
00000eb0:     PHSD (00000e9c)
00000eb4:     AccessType: AnyAcc; LockRule: NoLock; UpdateRule: Preserve
00000eb5:     NamedField BCMD
00000eba:     NamedField DID_
00000ebf:     NamedField INFO
00000ec5:     ReservedField
00000ec7:   Field
00000eca:     PHSD (00000e9c)
00000ece:     AccessType: AnyAcc; LockRule: NoLock; UpdateRule: Preserve
00000ecf:     ReservedField
00000ed1:     NamedField INF_
00000ed6:     NamedField INF1
00000edb:     NamedField INF2
00000ee0:     NamedField INF3
00000ee5:   Field
00000ee8:     PHSD (00000e9c)
00000eec:     AccessType: AnyAcc; LockRule: NoLock; UpdateRule: Preserve
00000eed:     ReservedField
00000eef:     NamedField INFW
00000ef4:   Field
00000ef7:     PHSD (00000e9c)
00000efb:     AccessType: AnyAcc; LockRule: NoLock; UpdateRule: Preserve
00000efc:     ReservedField
00000efe:     NamedField INFD
00000f03:   OpRegion PHSI (\_SB_.PHSI)
00000f09:     SystemIO
00000f0a:     0x0000fe00
00000f0f:     0x00000002
00000f14:   Field
00000f17:     PHSI (00000f03)
00000f1b:     AccessType: AnyAcc; LockRule: NoLock; UpdateRule: Preserve
00000f1c:     NamedField SMIC
00000f21:   Mutex MPHS (\_SB_.MPHS)
00000f27:     SyncLevel 0x0
00000f28:   Method PHS_ (\_SB_.PHS_)
00000f2e:     ArgCount 1; Serialized
00000f2f:     Acquire
00000f31:       MPHS (00000f21)
00000f35:       0xffff
00000f37:     Store
00000f38:       Arg0
00000f39:       BCMD (00000eb5)
00000f3d:     Store
00000f3e:       ZeroOp
00000f3f:       SMIC (00000f1c)
00000f43:     Store
00000f44:       0x00
00000f46:       BCMD (00000eb5)
00000f4a:     Store
00000f4b:       INF_ (00000ed1)
00000f4f:       Local7
00000f50:     Release
00000f52:       MPHS (00000f21)
00000f56:     Return
00000f57:       Local7
00000f58:   Method PHS1 (\_SB_.PHS1)
00000f5e:     ArgCount 2; Serialized
00000f5f:     Acquire
00000f61:       MPHS (00000f21)
00000f65:       0xffff
00000f67:     Store
00000f68:       Arg0
00000f69:       BCMD (00000eb5)
00000f6d:     Store
00000f6e:       Arg1
00000f6f:       INF_ (00000ed1)
00000f73:     Store
00000f74:       ZeroOp
00000f75:       SMIC (00000f1c)
00000f79:     Store
00000f7a:       0x00
00000f7c:       BCMD (00000eb5)
00000f80:     Store
00000f81:       INF_ (00000ed1)
00000f85:       Local7
00000f86:     Release
00000f88:       MPHS (00000f21)
00000f8c:     Return
00000f8d:       Local7
00000f8e:   Method PHS2 (\_SB_.PHS2)
00000f94:     ArgCount 3; Serialized
00000f95:     Acquire
00000f97:       MPHS (00000f21)
00000f9b:       0xffff
00000f9d:     Store
00000f9e:       Arg0
00000f9f:       BCMD (00000eb5)
00000fa3:     Store
00000fa4:       Arg1
00000fa5:       INF_ (00000ed1)
00000fa9:     Store
00000faa:       Arg2
00000fab:       INF1 (00000ed6)
00000faf:     Store
00000fb0:       ZeroOp
00000fb1:       SMIC (00000f1c)
00000fb5:     Store
00000fb6:       0x00
00000fb8:       BCMD (00000eb5)
00000fbc:     Store
00000fbd:       INFW (00000eef)
00000fc1:       Local7
00000fc2:     Release
00000fc4:       MPHS (00000f21)
00000fc8:     Return
00000fc9:       Local7
00000fca:   Device MEDB (\_SB_.MEDB)
00000fd2:     Name _CID (\_SB_.MEDB._CID)
00000fd7:       PNP0c15 (0x150cd041)
00000fdc:     Name _HID (\_SB_.MEDB._HID)
00000fe1:       SEC0002 (0x0200a34c)
00000fe6:     Name _UID (\_SB_.MEDB._UID)
00000feb:       0x02
00000fed:     Name _BDN (\_SB_.MEDB._BDN)
00000ff2:       0x02
00000ff4:     Name DCBF (\_SB_.MEDB.DCBF)
00000ff9:       0x00
00000ffb:     Name DCST (\_SB_.MEDB.DCST)
00001000:       0x00
00001002:     Name DSFL (\_SB_.MEDB.DSFL)
00001007:       0x00
00001009:     Name SPUD (\_SB_.MEDB.SPUD)
0000100e:       0x00
00001010:     Name ICNF (\_SB_.MEDB.ICNF)
00001015:       0x00
00001017:     Name S4FL (\_SB_.MEDB.S4FL)
0000101c:       0x00
0000101e:     Event DSYN (\_SB_.MEDB.DSYN)
00001024:     Event DEVT (\_SB_.MEDB.DEVT)
0000102a:     Method _STA (\_SB_.MEDB._STA)
00001031:       ArgCount 0; NotSerialized
00001032:       If
00001034:         LEqual
00001035:           OSYS (0000017a)
00001039:           0x07d0
0000103c:         If
0000103e:           LEqual
0000103f:             S4FL (00001017)
00001043:             OneOp
00001044:           If
00001046:             LEqual
00001047:               SPUD (00001009)
0000104b:               OneOp
0000104c:             Return
0000104d:               0x0f
0000104f:       Store
00001050:         GPS0 (00000098)
00001054:         Local0
00001055:       And
00001056:         Local0
00001057:         0x80
00001059:         Local0
0000105a:       Store
0000105b:         Local0
0000105c:         GPS0 (00000098)
00001060:       Store
00001061:         GPS0 (00000098)
00001065:         Local0
00001066:       And
00001067:         Local0
00001068:         0x80
0000106a:         Local0
0000106b:       If
0000106d:         LEqual
0000106e:           Local0
0000106f:           0x80
00001071:         Return
00001072:           0x0f
00001074:       Else
00001076:         Return
00001077:           0x00
00001079:     Method _DCK (\_SB_.MEDB._DCK)
00001080:       ArgCount 1; NotSerialized
00001081:       If
00001083:         LEqual
00001084:           Arg0
00001085:           0x00
00001087:         Sleep
00001089:           0xc8
0000108b:         Return
0000108c:           0x01
0000108e:       Else
00001091:         Sleep
00001093:           0x1e
00001095:         <NULL>
0000109f:         0x90
000010a1:         Sleep
000010a3:           0x01f4
000010a6:         Sleep
000010a8:           0x01f4
000010ab:         Sleep
000010ad:           0x01f4
000010b0:         Sleep
000010b2:           0x01f4
000010b5:         Sleep
000010b7:           0x01f4
000010ba:         Sleep
000010bc:           0x01f4
000010bf:         Store
000010c0:           OneOp
000010c1:           \_SB_.MEDB.DCST (00000ffb)
000010d0:         Store
000010d1:           ZeroOp
000010d2:           \_SB_.MEDB.SPUD (00001009)
000010e1:         If
000010e3:           IGDS (0000022d)
000010e7:           <NULL>
000010eb:           0x13
000010ed:         Return
000010ee:           0x01
000010f0:     Method _EJ0 (\_SB_.MEDB._EJ0)
000010f7:       ArgCount 1; NotSerialized
000010f8:       Store
000010f9:         ZeroOp
000010fa:         \_SB_.MEDB.DCST (00000ffb)
00001109:       <NULL>
00001113:       0x91
00001115:       Sleep
00001117:         0x01f4
0000111a:       If
0000111d:         LEqual
0000111e:           SPUD (00001009)
00001122:           ZeroOp
00001123:         If
00001125:           LEqual
00001126:             ICNF (00001010)
0000112a:             0x00
0000112c:           Store
0000112d:             0x02
0000112f:             ICNF (00001010)
00001133:           If
00001135:             IGDS (0000022d)
00001139:             Store
0000113a:               0x11
0000113c:               SMIF (0000017f)
00001140:             Store
00001141:               0x00
00001143:               TRP0 (00000031)
00001147:         Wait
00001149:           DEVT (00001024)
0000114d:           0xffff
00001150:         Reset
00001152:           DEVT (00001024)
00001156:         If
00001158:           LEqual
00001159:             ICNF (00001010)
0000115d:             0x02
0000115f:           If
00001161:             IGDS (0000022d)
00001165:             Store
00001166:               0x12
00001168:               SMIF (0000017f)
0000116c:             Store
0000116d:               0x00
0000116f:               TRP0 (00000031)
00001173:           Store
00001174:             0x00
00001176:             ICNF (00001010)
0000117a:       Else
0000117c:         Store
0000117d:           ZeroOp
0000117e:           \_SB_.MEDB.SPUD (00001009)
0000118d:       Sleep
0000118f:         0x01f4
00001192:       If
00001194:         IGDS (0000022d)
00001198:         <NULL>
0000119c:         0x13
0000119e:       Return
0000119f:         0x01
000011a1:     Method _EJ3 (\_SB_.MEDB._EJ3)
000011a8:       ArgCount 1; NotSerialized
000011a9:       <NULL>
000011b3:       0x91
000011b5:       Sleep
000011b7:         0x01f4
000011ba:       If
000011bc:         LEqual
000011bd:           SPUD (00001009)
000011c1:           ZeroOp
000011c2:       Else
000011c4:         Store
000011c5:           ZeroOp
000011c6:           \_SB_.MEDB.SPUD (00001009)
000011d5:       Store
000011d6:         ZeroOp
000011d7:         \_SB_.MEDB.DCST (00000ffb)
000011e6:       Return
000011e7:         0x01
000011e9:     Method EVNT (\_SB_.MEDB.EVNT)
000011f0:       ArgCount 0; NotSerialized
000011f1:       Sleep
000011f3:         0xfa
000011f5:       Store
000011f6:         GPS0 (00000098)
000011fa:         Local0
000011fb:       And
000011fc:         Local0
000011fd:         0x30
000011ff:         Local0
00001200:       Store
00001201:         Local0
00001202:         GPS0 (00000098)
00001206:       Store
00001207:         GPS0 (00000098)
0000120b:         Local0
0000120c:       And
0000120d:         Local0
0000120e:         0x30
00001210:         Local0
00001211:       Store
00001212:         GIV0 (0000010f)
00001216:         Local1
00001217:       And
00001218:         Local1
00001219:         0x30
0000121b:         Local1
0000121c:       If
0000121f:         LNotEqual
00001221:           Local0
00001222:           Local1
00001223:         If
00001225:           LNotEqual
00001227:             \_SB_.MEDB.DCST (00000ffb)
00001236:             ZeroOp
00001237:           Store
00001238:             OneOp
00001239:             \_SB_.MEDB.SPUD (00001009)
00001248:           Notify
00001249:             \_SB_.MEDB (00000fca)
00001253:             0x01
00001255:         Signal
00001257:           \_SB_.MEDB.DEVT (00001024)
00001266:         Sleep
00001268:           0xc8
0000126a:       Else
0000126c:         If
0000126e:           LEqual
0000126f:             \_SB_.MEDB.DCST (00000ffb)
0000127e:             ZeroOp
0000127f:           Notify
00001280:             \_SB_.MEDB (00000fca)
0000128a:             0x00
0000128c:         Sleep
0000128e:           0xc8
00001290:       XOr
00001291:         GIV0 (0000010f)
00001295:         0x30
00001297:         GIV0 (0000010f)
0000129b:       Sleep
0000129d:         0x1e
0000129f:       Store
000012a0:         GPS0 (00000098)
000012a4:         Local0
000012a5:       And
000012a6:         Local0
000012a7:         0x30
000012a9:         Local0
000012aa:       Store
000012ab:         Local0
000012ac:         GPS0 (00000098)
000012b0:   Device ADP1 (\_SB_.ADP1)
000012b8:     Name _HID (\_SB_.ADP1._HID)
000012bd:       "ACPI0003"
000012c7:     Method _PSR (\_SB_.ADP1._PSR)
000012ce:       ArgCount 0; NotSerialized
000012cf:       If
000012d1:         LEqual
000012d2:           \WEND (000003de)
000012d7:           OneOp
000012d8:         Store
000012d9:           ZeroOp
000012da:           \WEND (000003de)
000012df:         <NULL>
000012e9:         0x97
000012eb:         Notify
000012ec:           \_PR_.CPU0 (0000029c)
000012f6:           0x80
000012f8:         Sleep
000012fa:           0x64
000012fc:         Notify
000012fd:           \_PR_.CPU0 (0000029c)
00001307:           0x81
00001309:       If
0000130b:         LEqual
0000130c:           \ECON (000003ce)
00001311:           0x00
00001313:         Store
00001314:           <NULL>
0000131e:           0x81
00001320:         0x02
00001322:         Local0
00001323:       Else
00001325:         Store
00001326:           \_SB_.PCI0.LPCB.H_EC.ACEX (0000382c)
0000133d:           Local0
0000133e:       Return
0000133f:         Local0
00001340:     Method _PCL (\_SB_.ADP1._PCL)
00001346:       ArgCount 0; NotSerialized
00001347:       Return
00001348:         Package
0000134a:           0x02
0000134b:           \_SB_.BAT1 (0000139e)
00001355:           \_SB_.BAT2 (00001943)
0000135f:     Method _STA (\_SB_.ADP1._STA)
00001365:       ArgCount 0; NotSerialized
00001366:       If
00001368:         LEqual
00001369:           \ECON (000003ce)
0000136e:           0x00
00001370:         Store
00001371:           0x0f
00001373:           Local0
00001374:       Else
00001376:         If
00001378:           LEqual
00001379:             \_SB_.PCI0.LPCB.H_EC.ACEX (0000382c)
00001390:             0x00
00001392:           Store
00001393:             0x1f
00001395:             Local0
00001396:         Else
00001398:           Store
00001399:             0x0f
0000139b:             Local0
0000139c:       Return
0000139d:         Local0
0000139e:   Device BAT1 (\_SB_.BAT1)
000013a6:     Name _HID (\_SB_.BAT1._HID)
000013ab:       PNP0c0a (0x0a0cd041)
000013b0:     Name _UID (\_SB_.BAT1._UID)
000013b5:       0x01
000013b7:     Name BATI (\_SB_.BAT1.BATI)
000013bc:       Package
000013bf:         0x0d
000013c0:         0x01
000013c2:         0xffffffff
000013c7:         0xffffffff
000013cc:         0x01
000013ce:         0xffffffff
000013d3:         0x0a
000013d5:         0x03
000013d7:         0x01
000013d9:         0x01
000013db:         "Unknown"
000013e4:         "Unknown"
000013ed:         "Unknown"
000013f6:         "Unknown"
000013ff:     Method _BIF (\_SB_.BAT1._BIF)
00001406:       ArgCount 0; NotSerialized
00001407:       If
0000140a:         LEqual
0000140b:           \ECON (000003ce)
00001410:           0x00
00001412:         Store
00001413:           <NULL>
0000141d:           0x8c
0000141f:         0xb0
00001421:         0x00
00001423:         Local0
00001424:         If
00001426:           LEqual
00001427:             Local0
00001428:             0xffff
0000142b:           Store
0000142c:             0xffffffff
00001431:             Index
00001432:               BATI (000013b7)
00001436:               0x01
00001438:               <NULL>
00001439:         Else
0000143b:           Store
0000143c:             Local0
0000143d:             Index
0000143e:               BATI (000013b7)
00001442:               0x01
00001444:               <NULL>
00001445:         Store
00001446:           <NULL>
00001450:           0x8c
00001452:         0xb2
00001454:         0x00
00001456:         Local0
00001457:         If
00001459:           LEqual
0000145a:             Local0
0000145b:             0xffff
0000145e:           Store
0000145f:             0xffffffff
00001464:             Index
00001465:               BATI (000013b7)
00001469:               0x02
0000146b:               <NULL>
0000146c:           Store
0000146d:             0xffffffff
00001472:             Local2
00001473:           Store
00001474:             0xffff
00001477:             B1SA (000003f6)
0000147b:         Else
0000147d:           Store
0000147e:             Local0
0000147f:             Index
00001480:               BATI (000013b7)
00001484:               0x02
00001486:               <NULL>
00001487:           Store
00001488:             Local0
00001489:             Local2
0000148a:           Store
0000148b:             Local0
0000148c:             B1SA (000003f6)
00001490:         Store
00001491:           <NULL>
0000149b:           0x8c
0000149d:         0xb4
0000149f:         0x00
000014a1:         Local0
000014a2:         If
000014a4:           LEqual
000014a5:             Local0
000014a6:             0xffff
000014a9:           Store
000014aa:             0xffffffff
000014af:             Index
000014b0:               BATI (000013b7)
000014b4:               0x04
000014b6:               <NULL>
000014b7:         Else
000014b9:           Store
000014ba:             Local0
000014bb:             Index
000014bc:               BATI (000013b7)
000014c0:               0x04
000014c2:               <NULL>
000014c3:       Else
000014c6:         Store
000014c7:           \_SB_.PCI0.LPCB.H_EC.B1AF (00003870)
000014de:           Local3
000014df:         Store
000014e0:           \_SB_.PCI0.LPCB.H_EC.B1VL (00003875)
000014f7:           Local4
000014f8:         Store
000014f9:           Local3
000014fa:           Local0
000014fb:         And
000014fc:           Local0
000014fd:           0xffff
00001500:           Local0
00001501:         ShiftLeft
00001502:           Local0
00001503:           0x08
00001505:           Local1
00001506:         And
00001507:           Local1
00001508:           0xff00
0000150b:           Local1
0000150c:         ShiftRight
0000150d:           Local0
0000150e:           0x08
00001510:           Local0
00001511:         Or
00001512:           Local0
00001513:           Local1
00001514:           Local0
00001515:         If
00001517:           LEqual
00001518:             Local0
00001519:             0xffff
0000151c:           Store
0000151d:             0xffffffff
00001522:             Index
00001523:               BATI (000013b7)
00001527:               0x01
00001529:               <NULL>
0000152a:         Else
0000152c:           Store
0000152d:             Local0
0000152e:             Index
0000152f:               BATI (000013b7)
00001533:               0x01
00001535:               <NULL>
00001536:         Store
00001537:           Local3
00001538:           Local0
00001539:         ShiftRight
0000153a:           Local0
0000153b:           0x10
0000153d:           Local0
0000153e:         And
0000153f:           Local0
00001540:           0xffff
00001543:           Local0
00001544:         ShiftLeft
00001545:           Local0
00001546:           0x08
00001548:           Local1
00001549:         And
0000154a:           Local1
0000154b:           0xff00
0000154e:           Local1
0000154f:         ShiftRight
00001550:           Local0
00001551:           0x08
00001553:           Local0
00001554:         Or
00001555:           Local0
00001556:           Local1
00001557:           Local0
00001558:         If
0000155a:           LEqual
0000155b:             Local0
0000155c:             0xffff
0000155f:           Store
00001560:             0xffffffff
00001565:             Index
00001566:               BATI (000013b7)
0000156a:               0x02
0000156c:               <NULL>
0000156d:           Store
0000156e:             0xffffffff
00001573:             Local2
00001574:           Store
00001575:             0xffff
00001578:             B1SA (000003f6)
0000157c:         Else
0000157e:           Store
0000157f:             Local0
00001580:             Index
00001581:               BATI (000013b7)
00001585:               0x02
00001587:               <NULL>
00001588:           Store
00001589:             Local0
0000158a:             Local2
0000158b:           Store
0000158c:             Local0
0000158d:             B1SA (000003f6)
00001591:         Store
00001592:           Local4
00001593:           Local0
00001594:         And
00001595:           Local0
00001596:           0xffff
00001599:           Local0
0000159a:         ShiftLeft
0000159b:           Local0
0000159c:           0x08
0000159e:           Local1
0000159f:         And
000015a0:           Local1
000015a1:           0xff00
000015a4:           Local1
000015a5:         ShiftRight
000015a6:           Local0
000015a7:           0x08
000015a9:           Local0
000015aa:         Or
000015ab:           Local0
000015ac:           Local1
000015ad:           Local0
000015ae:         If
000015b0:           LEqual
000015b1:             Local0
000015b2:             0xffff
000015b5:           Store
000015b6:             0xffffffff
000015bb:             Index
000015bc:               BATI (000013b7)
000015c0:               0x04
000015c2:               <NULL>
000015c3:         Else
000015c5:           Store
000015c6:             Local0
000015c7:             Index
000015c8:               BATI (000013b7)
000015cc:               0x04
000015ce:               <NULL>
000015cf:       If
000015d1:         LNotEqual
000015d3:           Local2
000015d4:           0xffffffff
000015d9:         Store
000015da:           Local2
000015db:           Local0
000015dc:         Divide
000015dd:           Local0
000015de:           0x64
000015e0:           Local2
000015e1:           Local1
000015e2:         If
000015e4:           LGreaterEqual
000015e6:             Local2
000015e7:             0x32
000015e9:           Increment
000015ea:             Local1
000015eb:         Multiply
000015ec:           Local1
000015ed:           0x0a
000015ef:           Local0
000015f0:         Store
000015f1:           Local0
000015f2:           Index
000015f3:             BATI (000013b7)
000015f7:             0x05
000015f9:             <NULL>
000015fa:         Multiply
000015fb:           Local1
000015fc:           0x03
000015fe:           Local0
000015ff:         Store
00001600:           Local0
00001601:           Index
00001602:             BATI (000013b7)
00001606:             0x06
00001608:             <NULL>
00001609:       Store
0000160a:         ""
0000160c:         Index
0000160d:           BATI (000013b7)
00001611:           0x09
00001613:           <NULL>
00001614:       Store
00001615:         ""
00001617:         Index
00001618:           BATI (000013b7)
0000161c:           0x0a
0000161e:           <NULL>
0000161f:       Store
00001620:         "LION"
00001626:         Index
00001627:           BATI (000013b7)
0000162b:           0x0b
0000162d:           <NULL>
0000162e:       Store
0000162f:         "DELL Computer Corporation"
0000164a:         Index
0000164b:           BATI (000013b7)
0000164f:           0x0c
00001651:           <NULL>
00001652:       Return
00001653:         BATI (000013b7)
00001657:     Name STAT (\_SB_.BAT1.STAT)
0000165c:       Package
0000165e:         0x04
0000165f:         0x00
00001661:         0x00
00001663:         0x00
00001665:         0x00
00001667:     Method _BST (\_SB_.BAT1._BST)
0000166e:       ArgCount 0; NotSerialized
0000166f:       If
00001671:         LEqual
00001672:           \WEND (000003de)
00001677:           OneOp
00001678:         Store
00001679:           ZeroOp
0000167a:           \WEND (000003de)
0000167f:         <NULL>
00001689:         0x97
0000168b:         Notify
0000168c:           \_PR_.CPU0 (0000029c)
00001696:           0x80
00001698:         Sleep
0000169a:           0x64
0000169c:         Notify
0000169d:           \_PR_.CPU0 (0000029c)
000016a7:           0x81
000016a9:       If
000016ac:         LEqual
000016ad:           \ECON (000003ce)
000016b2:           0x00
000016b4:         Store
000016b5:           <NULL>
000016bf:           0x8b
000016c1:         0x84
000016c3:         0x00
000016c5:         Local0
000016c6:         If
000016c8:           LAnd
000016c9:             LNotEqual
000016cb:               Local0
000016cc:               0x00
000016ce:             LNot
000016cf:               And
000016d0:                 Local0
000016d1:                 0x04
000016d3:                 <NULL>
000016d4:           If
000016d6:             LEqual
000016d7:               \PWRS (000001ca)
000016dc:               0x01
000016de:             Store
000016df:               0x02
000016e1:               Local0
000016e2:           Else
000016e4:             Store
000016e5:               0x01
000016e7:               Local0
000016e8:         Store
000016e9:           Local0
000016ea:           Index
000016eb:             STAT (00001657)
000016ef:             0x00
000016f1:             <NULL>
000016f2:         Store
000016f3:           <NULL>
000016fd:           0x8c
000016ff:         0xa4
00001701:         0x00
00001703:         Local0
00001704:         If
00001706:           LEqual
00001707:             Local0
00001708:             0xffff
0000170b:           Store
0000170c:             0xffffffff
00001711:             Index
00001712:               STAT (00001657)
00001716:               0x01
00001718:               <NULL>
00001719:         Else
0000171b:           If
0000171d:             LGreaterEqual
0000171f:               Local0
00001720:               0x8000
00001723:             XOr
00001724:               Local0
00001725:               0xffff
00001728:               Local0
00001729:             Increment
0000172a:               Local0
0000172b:           Store
0000172c:             Local0
0000172d:             Index
0000172e:               STAT (00001657)
00001732:               0x01
00001734:               <NULL>
00001735:         Store
00001736:           <NULL>
00001740:           0x8c
00001742:         0xa2
00001744:         0x00
00001746:         Local0
00001747:         If
00001749:           LEqual
0000174a:             Local0
0000174b:             0xffff
0000174e:           Store
0000174f:             0xffffffff
00001754:             Index
00001755:               STAT (00001657)
00001759:               0x02
0000175b:               <NULL>
0000175c:         Else
0000175e:           Store
0000175f:             Local0
00001760:             Index
00001761:               STAT (00001657)
00001765:               0x02
00001767:               <NULL>
00001768:         Store
00001769:           <NULL>
00001773:           0x8c
00001775:         0xa6
00001777:         0x00
00001779:         Local0
0000177a:         If
0000177c:           LEqual
0000177d:             Local0
0000177e:             0xffff
00001781:           Store
00001782:             0xffffffff
00001787:             Index
00001788:               STAT (00001657)
0000178c:               0x03
0000178e:               <NULL>
0000178f:         Else
00001791:           Store
00001792:             Local0
00001793:             Index
00001794:               STAT (00001657)
00001798:               0x03
0000179a:               <NULL>
0000179b:       Else
0000179e:         Store
0000179f:           \_SB_.PCI0.LPCB.H_EC.B1RR (0000385c)
000017b6:           Local3
000017b7:         Store
000017b8:           \_SB_.PCI0.LPCB.H_EC.B1PV (00003861)
000017cf:           Local4
000017d0:         Store
000017d1:           Local3
000017d2:           Local0
000017d3:         And
000017d4:           Local0
000017d5:           0xff
000017d7:           Local0
000017d8:         If
000017da:           LAnd
000017db:             LNotEqual
000017dd:               Local0
000017de:               0x00
000017e0:             LNot
000017e1:               And
000017e2:                 Local0
000017e3:                 0x04
000017e5:                 <NULL>
000017e6:           If
000017e8:             LEqual
000017e9:               \PWRS (000001ca)
000017ee:               0x01
000017f0:             Store
000017f1:               0x02
000017f3:               Local0
000017f4:           Else
000017f6:             Store
000017f7:               0x01
000017f9:               Local0
000017fa:         Store
000017fb:           Local0
000017fc:           Index
000017fd:             STAT (00001657)
00001801:             0x00
00001803:             <NULL>
00001804:         Store
00001805:           Local4
00001806:           Local0
00001807:         And
00001808:           Local0
00001809:           0xffff
0000180c:           Local0
0000180d:         ShiftLeft
0000180e:           Local0
0000180f:           0x08
00001811:           Local1
00001812:         And
00001813:           Local1
00001814:           0xff00
00001817:           Local1
00001818:         ShiftRight
00001819:           Local0
0000181a:           0x08
0000181c:           Local0
0000181d:         Or
0000181e:           Local0
0000181f:           Local1
00001820:           Local0
00001821:         If
00001823:           LEqual
00001824:             Local0
00001825:             0xffff
00001828:           Store
00001829:             0xffffffff
0000182e:             Index
0000182f:               STAT (00001657)
00001833:               0x01
00001835:               <NULL>
00001836:         Else
00001838:           If
0000183a:             LGreaterEqual
0000183c:               Local0
0000183d:               0x8000
00001840:             XOr
00001841:               Local0
00001842:               0xffff
00001845:               Local0
00001846:             Increment
00001847:               Local0
00001848:           Store
00001849:             Local0
0000184a:             Index
0000184b:               STAT (00001657)
0000184f:               0x01
00001851:               <NULL>
00001852:         Store
00001853:           Local3
00001854:           Local0
00001855:         ShiftRight
00001856:           Local0
00001857:           0x10
00001859:           Local0
0000185a:         And
0000185b:           Local0
0000185c:           0xffff
0000185f:           Local0
00001860:         ShiftLeft
00001861:           Local0
00001862:           0x08
00001864:           Local1
00001865:         And
00001866:           Local1
00001867:           0xff00
0000186a:           Local1
0000186b:         ShiftRight
0000186c:           Local0
0000186d:           0x08
0000186f:           Local0
00001870:         Or
00001871:           Local0
00001872:           Local1
00001873:           Local0
00001874:         If
00001876:           LEqual
00001877:             Local0
00001878:             0xffff
0000187b:           Store
0000187c:             0xffffffff
00001881:             Index
00001882:               STAT (00001657)
00001886:               0x02
00001888:               <NULL>
00001889:         Else
0000188b:           Store
0000188c:             Local0
0000188d:             Index
0000188e:               STAT (00001657)
00001892:               0x02
00001894:               <NULL>
00001895:         Store
00001896:           Local4
00001897:           Local0
00001898:         ShiftRight
00001899:           Local0
0000189a:           0x10
0000189c:           Local0
0000189d:         And
0000189e:           Local0
0000189f:           0xffff
000018a2:           Local0
000018a3:         ShiftLeft
000018a4:           Local0
000018a5:           0x08
000018a7:           Local1
000018a8:         And
000018a9:           Local1
000018aa:           0xff00
000018ad:           Local1
000018ae:         ShiftRight
000018af:           Local0
000018b0:           0x08
000018b2:           Local0
000018b3:         Or
000018b4:           Local0
000018b5:           Local1
000018b6:           Local0
000018b7:         If
000018b9:           LEqual
000018ba:             Local0
000018bb:             0xffff
000018be:           Store
000018bf:             0xffffffff
000018c4:             Index
000018c5:               STAT (00001657)
000018c9:               0x03
000018cb:               <NULL>
000018cc:         Else
000018ce:           Store
000018cf:             Local0
000018d0:             Index
000018d1:               STAT (00001657)
000018d5:               0x03
000018d7:               <NULL>
000018d8:       Return
000018d9:         STAT (00001657)
000018dd:     Method _STA (\_SB_.BAT1._STA)
000018e4:       ArgCount 0; NotSerialized
000018e5:       If
000018e7:         LEqual
000018e8:           \ECON (000003ce)
000018ed:           0x00
000018ef:         If
000018f1:           LEqual
000018f2:             <NULL>
000018fc:             0x81
000018fe:           0x00
00001900:           0x01
00001902:           Store
00001903:             0x1f
00001905:             Local0
00001906:         Else
00001908:           Store
00001909:             0x0f
0000190b:             Local0
0000190c:       Else
0000190e:         If
00001910:           LEqual
00001911:             \_SB_.PCI0.LPCB.H_EC.B1EX (00003822)
00001928:             0x01
0000192a:           Store
0000192b:             0x1f
0000192d:             Local0
0000192e:         Else
00001930:           Store
00001931:             0x0f
00001933:             Local0
00001934:       Return
00001935:         Local0
00001936:     Method _PCL (\_SB_.BAT1._PCL)
0000193c:       ArgCount 0; NotSerialized
0000193d:       Return
0000193e:         \_SB_ (00000e93)
00001943:   Device BAT2 (\_SB_.BAT2)
0000194b:     Name _HID (\_SB_.BAT2._HID)
00001950:       PNP0c0a (0x0a0cd041)
00001955:     Name _UID (\_SB_.BAT2._UID)
0000195a:       0x02
0000195c:     Name BATI (\_SB_.BAT2.BATI)
00001961:       Package
00001964:         0x0d
00001965:         0x01
00001967:         0xffffffff
0000196c:         0xffffffff
00001971:         0x01
00001973:         0xffffffff
00001978:         0x0a
0000197a:         0x03
0000197c:         0x01
0000197e:         0x01
00001980:         "Unknown"
00001989:         "Unknown"
00001992:         "Unknown"
0000199b:         "Unknown"
000019a4:     Method _BIF (\_SB_.BAT2._BIF)
000019ab:       ArgCount 0; NotSerialized
000019ac:       If
000019af:         LEqual
000019b0:           \ECON (000003ce)
000019b5:           0x00
000019b7:         Store
000019b8:           <NULL>
000019c2:           0x8c
000019c4:         0xb8
000019c6:         0x00
000019c8:         Local0
000019c9:         If
000019cb:           LEqual
000019cc:             Local0
000019cd:             0xffff
000019d0:           Store
000019d1:             0xffffffff
000019d6:             Index
000019d7:               BATI (0000195c)
000019db:               0x01
000019dd:               <NULL>
000019de:         Else
000019e0:           Store
000019e1:             Local0
000019e2:             Index
000019e3:               BATI (0000195c)
000019e7:               0x01
000019e9:               <NULL>
000019ea:         Store
000019eb:           <NULL>
000019f5:           0x8c
000019f7:         0xba
000019f9:         0x00
000019fb:         Local0
000019fc:         If
000019fe:           LEqual
000019ff:             Local0
00001a00:             0xffff
00001a03:           Store
00001a04:             0xffffffff
00001a09:             Index
00001a0a:               BATI (0000195c)
00001a0e:               0x02
00001a10:               <NULL>
00001a11:           Store
00001a12:             0xffffffff
00001a17:             Local2
00001a18:           Store
00001a19:             0xffff
00001a1c:             B2SA (000003fe)
00001a20:         Else
00001a22:           Store
00001a23:             Local0
00001a24:             Index
00001a25:               BATI (0000195c)
00001a29:               0x02
00001a2b:               <NULL>
00001a2c:           Store
00001a2d:             Local0
00001a2e:             Local2
00001a2f:           Store
00001a30:             Local0
00001a31:             B2SA (000003fe)
00001a35:         Store
00001a36:           <NULL>
00001a40:           0x8c
00001a42:         0xbc
00001a44:         0x00
00001a46:         Local0
00001a47:         If
00001a49:           LEqual
00001a4a:             Local0
00001a4b:             0xffff
00001a4e:           Store
00001a4f:             0xffffffff
00001a54:             Index
00001a55:               BATI (0000195c)
00001a59:               0x04
00001a5b:               <NULL>
00001a5c:         Else
00001a5e:           Store
00001a5f:             Local0
00001a60:             Index
00001a61:               BATI (0000195c)
00001a65:               0x04
00001a67:               <NULL>
00001a68:       Else
00001a6b:         Store
00001a6c:           \_SB_.PCI0.LPCB.H_EC.B2AF (0000387a)
00001a83:           Local3
00001a84:         Store
00001a85:           \_SB_.PCI0.LPCB.H_EC.B2VL (0000387f)
00001a9c:           Local4
00001a9d:         Store
00001a9e:           Local3
00001a9f:           Local0
00001aa0:         And
00001aa1:           Local0
00001aa2:           0xffff
00001aa5:           Local0
00001aa6:         ShiftLeft
00001aa7:           Local0
00001aa8:           0x08
00001aaa:           Local1
00001aab:         And
00001aac:           Local1
00001aad:           0xff00
00001ab0:           Local1
00001ab1:         ShiftRight
00001ab2:           Local0
00001ab3:           0x08
00001ab5:           Local0
00001ab6:         Or
00001ab7:           Local0
00001ab8:           Local1
00001ab9:           Local0
00001aba:         If
00001abc:           LEqual
00001abd:             Local0
00001abe:             0xffff
00001ac1:           Store
00001ac2:             0xffffffff
00001ac7:             Index
00001ac8:               BATI (0000195c)
00001acc:               0x01
00001ace:               <NULL>
00001acf:         Else
00001ad1:           Store
00001ad2:             Local0
00001ad3:             Index
00001ad4:               BATI (0000195c)
00001ad8:               0x01
00001ada:               <NULL>
00001adb:         Store
00001adc:           Local3
00001add:           Local0
00001ade:         ShiftRight
00001adf:           Local0
00001ae0:           0x10
00001ae2:           Local0
00001ae3:         And
00001ae4:           Local0
00001ae5:           0xffff
00001ae8:           Local0
00001ae9:         ShiftLeft
00001aea:           Local0
00001aeb:           0x08
00001aed:           Local1
00001aee:         And
00001aef:           Local1
00001af0:           0xff00
00001af3:           Local1
00001af4:         ShiftRight
00001af5:           Local0
00001af6:           0x08
00001af8:           Local0
00001af9:         Or
00001afa:           Local0
00001afb:           Local1
00001afc:           Local0
00001afd:         If
00001aff:           LEqual
00001b00:             Local0
00001b01:             0xffff
00001b04:           Store
00001b05:             0xffffffff
00001b0a:             Index
00001b0b:               BATI (0000195c)
00001b0f:               0x02
00001b11:               <NULL>
00001b12:           Store
00001b13:             0xffffffff
00001b18:             Local2
00001b19:           Store
00001b1a:             0xffff
00001b1d:             B2SA (000003fe)
00001b21:         Else
00001b23:           Store
00001b24:             Local0
00001b25:             Index
00001b26:               BATI (0000195c)
00001b2a:               0x02
00001b2c:               <NULL>
00001b2d:           Store
00001b2e:             Local0
00001b2f:             Local2
00001b30:           Store
00001b31:             Local0
00001b32:             B2SA (000003fe)
00001b36:         Store
00001b37:           Local4
00001b38:           Local0
00001b39:         And
00001b3a:           Local0
00001b3b:           0xffff
00001b3e:           Local0
00001b3f:         ShiftLeft
00001b40:           Local0
00001b41:           0x08
00001b43:           Local1
00001b44:         And
00001b45:           Local1
00001b46:           0xff00
00001b49:           Local1
00001b4a:         ShiftRight
00001b4b:           Local0
00001b4c:           0x08
00001b4e:           Local0
00001b4f:         Or
00001b50:           Local0
00001b51:           Local1
00001b52:           Local0
00001b53:         If
00001b55:           LEqual
00001b56:             Local0
00001b57:             0xffff
00001b5a:           Store
00001b5b:             0xffffffff
00001b60:             Index
00001b61:               BATI (0000195c)
00001b65:               0x04
00001b67:               <NULL>
00001b68:         Else
00001b6a:           Store
00001b6b:             Local0
00001b6c:             Index
00001b6d:               BATI (0000195c)
00001b71:               0x04
00001b73:               <NULL>
00001b74:       If
00001b76:         LNotEqual
00001b78:           Local2
00001b79:           0xffffffff
00001b7e:         Store
00001b7f:           Local2
00001b80:           Local0
00001b81:         Divide
00001b82:           Local0
00001b83:           0x64
00001b85:           Local2
00001b86:           Local1
00001b87:         If
00001b89:           LGreaterEqual
00001b8b:             Local2
00001b8c:             0x32
00001b8e:           Increment
00001b8f:             Local1
00001b90:         Multiply
00001b91:           Local1
00001b92:           0x0a
00001b94:           Local0
00001b95:         Store
00001b96:           Local0
00001b97:           Index
00001b98:             BATI (0000195c)
00001b9c:             0x05
00001b9e:             <NULL>
00001b9f:         Multiply
00001ba0:           Local1
00001ba1:           0x03
00001ba3:           Local0
00001ba4:         Store
00001ba5:           Local0
00001ba6:           Index
00001ba7:             BATI (0000195c)
00001bab:             0x06
00001bad:             <NULL>
00001bae:       Store
00001baf:         ""
00001bb1:         Index
00001bb2:           BATI (0000195c)
00001bb6:           0x09
00001bb8:           <NULL>
00001bb9:       Store
00001bba:         ""
00001bbc:         Index
00001bbd:           BATI (0000195c)
00001bc1:           0x0a
00001bc3:           <NULL>
00001bc4:       Store
00001bc5:         "LION"
00001bcb:         Index
00001bcc:           BATI (0000195c)
00001bd0:           0x0b
00001bd2:           <NULL>
00001bd3:       Store
00001bd4:         "DELL Computer Corporation"
00001bef:         Index
00001bf0:           BATI (0000195c)
00001bf4:           0x0c
00001bf6:           <NULL>
00001bf7:       Return
00001bf8:         BATI (0000195c)
00001bfc:     Name STAT (\_SB_.BAT2.STAT)
00001c01:       Package
00001c03:         0x04
00001c04:         0x00
00001c06:         0x00
00001c08:         0x00
00001c0a:         0x00
00001c0c:     Method _BST (\_SB_.BAT2._BST)
00001c13:       ArgCount 0; NotSerialized
00001c14:       If
00001c16:         LEqual
00001c17:           \WEND (000003de)
00001c1c:           OneOp
00001c1d:         Store
00001c1e:           ZeroOp
00001c1f:           \WEND (000003de)
00001c24:         <NULL>
00001c2e:         0x97
00001c30:         Notify
00001c31:           \_PR_.CPU0 (0000029c)
00001c3b:           0x80
00001c3d:         Sleep
00001c3f:           0x64
00001c41:         Notify
00001c42:           \_PR_.CPU0 (0000029c)
00001c4c:           0x81
00001c4e:       If
00001c51:         LEqual
00001c52:           \ECON (000003ce)
00001c57:           0x00
00001c59:         Store
00001c5a:           <NULL>
00001c64:           0x8b
00001c66:         0x85
00001c68:         0x00
00001c6a:         Local0
00001c6b:         If
00001c6d:           LAnd
00001c6e:             LNotEqual
00001c70:               Local0
00001c71:               0x00
00001c73:             LNot
00001c74:               And
00001c75:                 Local0
00001c76:                 0x04
00001c78:                 <NULL>
00001c79:           If
00001c7b:             LEqual
00001c7c:               \PWRS (000001ca)
00001c81:               0x01
00001c83:             Store
00001c84:               0x02
00001c86:               Local0
00001c87:           Else
00001c89:             Store
00001c8a:               0x01
00001c8c:               Local0
00001c8d:         Store
00001c8e:           Local0
00001c8f:           Index
00001c90:             STAT (00001bfc)
00001c94:             0x00
00001c96:             <NULL>
00001c97:         Store
00001c98:           <NULL>
00001ca2:           0x8c
00001ca4:         0xac
00001ca6:         0x00
00001ca8:         Local0
00001ca9:         If
00001cab:           LEqual
00001cac:             Local0
00001cad:             0xffff
00001cb0:           Store
00001cb1:             0xffffffff
00001cb6:             Index
00001cb7:               STAT (00001bfc)
00001cbb:               0x01
00001cbd:               <NULL>
00001cbe:         Else
00001cc0:           If
00001cc2:             LGreaterEqual
00001cc4:               Local0
00001cc5:               0x8000
00001cc8:             XOr
00001cc9:               Local0
00001cca:               0xffff
00001ccd:               Local0
00001cce:             Increment
00001ccf:               Local0
00001cd0:           Store
00001cd1:             Local0
00001cd2:             Index
00001cd3:               STAT (00001bfc)
00001cd7:               0x01
00001cd9:               <NULL>
00001cda:         Store
00001cdb:           <NULL>
00001ce5:           0x8c
00001ce7:         0xaa
00001ce9:         0x00
00001ceb:         Local0
00001cec:         If
00001cee:           LEqual
00001cef:             Local0
00001cf0:             0xffff
00001cf3:           Store
00001cf4:             0xffffffff
00001cf9:             Index
00001cfa:               STAT (00001bfc)
00001cfe:               0x02
00001d00:               <NULL>
00001d01:         Else
00001d03:           Store
00001d04:             Local0
00001d05:             Index
00001d06:               STAT (00001bfc)
00001d0a:               0x02
00001d0c:               <NULL>
00001d0d:         Store
00001d0e:           <NULL>
00001d18:           0x8c
00001d1a:         0xae
00001d1c:         0x00
00001d1e:         Local0
00001d1f:         If
00001d21:           LEqual
00001d22:             Local0
00001d23:             0xffff
00001d26:           Store
00001d27:             0xffffffff
00001d2c:             Index
00001d2d:               STAT (00001bfc)
00001d31:               0x03
00001d33:               <NULL>
00001d34:         Else
00001d36:           Store
00001d37:             Local0
00001d38:             Index
00001d39:               STAT (00001bfc)
00001d3d:               0x03
00001d3f:               <NULL>
00001d40:       Else
00001d43:         Store
00001d44:           \_SB_.PCI0.LPCB.H_EC.B2RR (00003866)
00001d5b:           Local3
00001d5c:         Store
00001d5d:           \_SB_.PCI0.LPCB.H_EC.B2PV (0000386b)
00001d74:           Local4
00001d75:         Store
00001d76:           Local3
00001d77:           Local0
00001d78:         And
00001d79:           Local0
00001d7a:           0xff
00001d7c:           Local0
00001d7d:         If
00001d7f:           LAnd
00001d80:             LNotEqual
00001d82:               Local0
00001d83:               0x00
00001d85:             LNot
00001d86:               And
00001d87:                 Local0
00001d88:                 0x04
00001d8a:                 <NULL>
00001d8b:           If
00001d8d:             LEqual
00001d8e:               \PWRS (000001ca)
00001d93:               0x01
00001d95:             Store
00001d96:               0x02
00001d98:               Local0
00001d99:           Else
00001d9b:             Store
00001d9c:               0x01
00001d9e:               Local0
00001d9f:         Store
00001da0:           Local0
00001da1:           Index
00001da2:             STAT (00001bfc)
00001da6:             0x00
00001da8:             <NULL>
00001da9:         Store
00001daa:           Local4
00001dab:           Local0
00001dac:         And
00001dad:           Local0
00001dae:           0xffff
00001db1:           Local0
00001db2:         ShiftLeft
00001db3:           Local0
00001db4:           0x08
00001db6:           Local1
00001db7:         And
00001db8:           Local1
00001db9:           0xff00
00001dbc:           Local1
00001dbd:         ShiftRight
00001dbe:           Local0
00001dbf:           0x08
00001dc1:           Local0
00001dc2:         Or
00001dc3:           Local0
00001dc4:           Local1
00001dc5:           Local0
00001dc6:         If
00001dc8:           LEqual
00001dc9:             Local0
00001dca:             0xffff
00001dcd:           Store
00001dce:             0xffffffff
00001dd3:             Index
00001dd4:               STAT (00001bfc)
00001dd8:               0x01
00001dda:               <NULL>
00001ddb:         Else
00001ddd:           If
00001ddf:             LGreaterEqual
00001de1:               Local0
00001de2:               0x8000
00001de5:             XOr
00001de6:               Local0
00001de7:               0xffff
00001dea:               Local0
00001deb:             Increment
00001dec:               Local0
00001ded:           Store
00001dee:             Local0
00001def:             Index
00001df0:               STAT (00001bfc)
00001df4:               0x01
00001df6:               <NULL>
00001df7:         Store
00001df8:           Local3
00001df9:           Local0
00001dfa:         ShiftRight
00001dfb:           Local0
00001dfc:           0x10
00001dfe:           Local0
00001dff:         And
00001e00:           Local0
00001e01:           0xffff
00001e04:           Local0
00001e05:         ShiftLeft
00001e06:           Local0
00001e07:           0x08
00001e09:           Local1
00001e0a:         And
00001e0b:           Local1
00001e0c:           0xff00
00001e0f:           Local1
00001e10:         ShiftRight
00001e11:           Local0
00001e12:           0x08
00001e14:           Local0
00001e15:         Or
00001e16:           Local0
00001e17:           Local1
00001e18:           Local0
00001e19:         If
00001e1b:           LEqual
00001e1c:             Local0
00001e1d:             0xffff
00001e20:           Store
00001e21:             0xffffffff
00001e26:             Index
00001e27:               STAT (00001bfc)
00001e2b:               0x02
00001e2d:               <NULL>
00001e2e:         Else
00001e30:           Store
00001e31:             Local0
00001e32:             Index
00001e33:               STAT (00001bfc)
00001e37:               0x02
00001e39:               <NULL>
00001e3a:         Store
00001e3b:           Local4
00001e3c:           Local0
00001e3d:         ShiftRight
00001e3e:           Local0
00001e3f:           0x10
00001e41:           Local0
00001e42:         And
00001e43:           Local0
00001e44:           0xffff
00001e47:           Local0
00001e48:         ShiftLeft
00001e49:           Local0
00001e4a:           0x08
00001e4c:           Local1
00001e4d:         And
00001e4e:           Local1
00001e4f:           0xff00
00001e52:           Local1
00001e53:         ShiftRight
00001e54:           Local0
00001e55:           0x08
00001e57:           Local0
00001e58:         Or
00001e59:           Local0
00001e5a:           Local1
00001e5b:           Local0
00001e5c:         If
00001e5e:           LEqual
00001e5f:             Local0
00001e60:             0xffff
00001e63:           Store
00001e64:             0xffffffff
00001e69:             Index
00001e6a:               STAT (00001bfc)
00001e6e:               0x03
00001e70:               <NULL>
00001e71:         Else
00001e73:           Store
00001e74:             Local0
00001e75:             Index
00001e76:               STAT (00001bfc)
00001e7a:               0x03
00001e7c:               <NULL>
00001e7d:       Return
00001e7e:         STAT (00001bfc)
00001e82:     Method _STA (\_SB_.BAT2._STA)
00001e89:       ArgCount 0; NotSerialized
00001e8a:       If
00001e8c:         LEqual
00001e8d:           \ECON (000003ce)
00001e92:           0x00
00001e94:         If
00001e96:           LEqual
00001e97:             <NULL>
00001ea1:             0x81
00001ea3:           0x01
00001ea5:           0x01
00001ea7:           Store
00001ea8:             0x1f
00001eaa:             Local0
00001eab:         Else
00001ead:           Store
00001eae:             0x0f
00001eb0:             Local0
00001eb1:       Else
00001eb3:         If
00001eb5:           LEqual
00001eb6:             \_SB_.PCI0.LPCB.H_EC.B2EX (00003827)
00001ecd:             0x01
00001ecf:           Store
00001ed0:             0x1f
00001ed2:             Local0
00001ed3:         Else
00001ed5:           Store
00001ed6:             0x0f
00001ed8:             Local0
00001ed9:       Return
00001eda:         Local0
00001edb:     Method _PCL (\_SB_.BAT2._PCL)
00001ee1:       ArgCount 0; NotSerialized
00001ee2:       Return
00001ee3:         \_SB_ (00000e93)
00001ee8:   Device LID0 (\_SB_.LID0)
00001ef0:     Name _HID (\_SB_.LID0._HID)
00001ef5:       PNP0c0d (0x0d0cd041)
00001efa:     Name _PRW (\_SB_.LID0._PRW)
00001eff:       Package
00001f01:         0x02
00001f02:         0x1d
00001f04:         0x03
00001f06:     Method _PSW (\_SB_.LID0._PSW)
00001f0d:       ArgCount 1; NotSerialized
00001f0e:       If
00001f10:         \ECON (000003ce)
00001f15:         If
00001f17:           Arg0
00001f18:           Store
00001f19:             OneOp
00001f1a:             \_SB_.PCI0.LPCB.H_EC.LIDE (00003848)
00001f31:         Else
00001f33:           Store
00001f34:             ZeroOp
00001f35:             \_SB_.PCI0.LPCB.H_EC.LIDE (00003848)
00001f4c:     Method _STA (\_SB_.LID0._STA)
00001f52:       ArgCount 0; NotSerialized
00001f53:       Return
00001f54:         0x0f
00001f56:     Method _LID (\_SB_.LID0._LID)
00001f5c:       ArgCount 0; NotSerialized
00001f5d:       If
00001f5f:         \ECON (000003ce)
00001f64:         If
00001f66:           LEqual
00001f67:             \_SB_.PCI0.LPCB.H_EC.LIDI (00003841)
00001f7e:             0x01
00001f80:           Return
00001f81:             0x01
00001f83:       Return
00001f84:         0x00
00001f86:   Device SLPB (\_SB_.SLPB)
00001f8d:     Name _HID (\_SB_.SLPB._HID)
00001f92:       PNP0c0e (0x0e0cd041)
00001f97:     Method _STA (\_SB_.SLPB._STA)
00001f9d:       ArgCount 0; NotSerialized
00001f9e:       Return
00001f9f:         0x0f
00001fa1:   Device PWRB (\_SB_.PWRB)
00001fa8:     Name _HID (\_SB_.PWRB._HID)
00001fad:       PNP0c0c (0x0c0cd041)
00001fb2:     Name _PRW (\_SB_.PWRB._PRW)
00001fb7:       Package
00001fb9:         0x02
00001fba:         0x1d
00001fbc:         0x04
00001fbe:   Device PCI0 (\_SB_.PCI0)
00001fc7:     Method _INI (\_SB_.PCI0._INI)
00001fce:       ArgCount 0; NotSerialized
00001fcf:       If
00001fd1:         CondRefOf
00001fd3:           _OSI
00001fd7:           Local0
00001fd8:         Store
00001fd9:           0x07d1
00001fdc:           OSYS (0000017a)
00001fe0:         <NULL>
00001fea:         0x92
00001fec:         0x03
00001fee:       Else
00001ff1:         If
00001ff3:           LEqual
00001ff4:             SizeOf
00001ff5:               _OS_
00001ff9:             0x14
00001ffb:           Store
00001ffc:             0x07d0
00001fff:             OSYS (0000017a)
00002003:           <NULL>
0000200d:           0x92
0000200f:           0x02
00002011:         Else
00002013:           If
00002015:             LEqual
00002016:               SizeOf
00002017:                 _OS_
0000201b:               0x27
0000201d:             Store
0000201e:               0x07cf
00002021:               OSYS (0000017a)
00002025:             <NULL>
0000202f:             0x92
00002031:             0x01
00002033:           Else
00002035:             Store
00002036:               0x07ce
00002039:               OSYS (0000017a)
0000203d:             <NULL>
00002047:             0x92
00002049:             0x00
0000204b:       If
0000204d:         LLessEqual
0000204f:           OSYS (0000017a)
00002053:           0x07cf
00002056:         Store
00002057:           0x01
00002059:           ECON (000003ce)
0000205d:       <NULL>
00002067:       0x98
00002069:       0x00
0000206b:     Method _S3D (\_SB_.PCI0._S3D)
00002071:       ArgCount 0; NotSerialized
00002072:       Return
00002073:         0x02
00002075:     Method _S4D (\_SB_.PCI0._S4D)
0000207b:       ArgCount 0; NotSerialized
0000207c:       Return
0000207d:         0x02
0000207f:     Name _HID (\_SB_.PCI0._HID)
00002084:       PNP0a03 (0x030ad041)
00002089:     Name _ADR (\_SB_.PCI0._ADR)
0000208e:       0x00
00002090:     Name _BBN (\_SB_.PCI0._BBN)
00002095:       0x00
00002097:     OpRegion HBUS (\_SB_.PCI0.HBUS)
0000209d:       PCI_Config
0000209e:       0x40
000020a0:       0xc0
000020a2:     Field
000020a6:       HBUS (00002097)
000020aa:       AccessType: DWordAcc; LockRule: NoLock; UpdateRule: Preserve
000020ab:       ReservedField
000020ae:       ReservedField
000020b0:       NamedField HENA
000020b5:       ReservedField
000020b7:       NamedField PM0H
000020bc:       ReservedField
000020be:       NamedField PM1L
000020c3:       ReservedField
000020c5:       NamedField PM1H
000020ca:       ReservedField
000020cc:       NamedField PM2L
000020d1:       ReservedField
000020d3:       NamedField PM2H
000020d8:       ReservedField
000020da:       NamedField PM3L
000020df:       ReservedField
000020e1:       NamedField PM3H
000020e6:       ReservedField
000020e8:       NamedField PM4L
000020ed:       ReservedField
000020ef:       NamedField PM4H
000020f4:       ReservedField
000020f6:       NamedField PM5L
000020fb:       ReservedField
000020fd:       NamedField PM5H
00002102:       ReservedField
00002104:       NamedField PM6L
00002109:       ReservedField
0000210b:       NamedField PM6H
00002110:       ReservedField
00002112:     Name BUF0 (\_SB_.PCI0.BUF0)
00002117:       Buffer
0000211a:         0x0201
0000211d:         ByteList <0x88 0x0e 0x00 0x02 0x0c 0x00 0x00 0x00 
0000211d:         	      0x00 0x00 0xff 0x00 0x00 0x00 0x00 0x01 
0000211d:         	      0x00 0x87 0x18 0x00 0x01 0x0c 0x03 0x00 
0000211d:         	      0x00 0x00 0x00 0x00 0x00 0x00 0x00 0xf7 
0000211d:         	      0x0c 0x00 0x00 0x00 0x00 0x00 0x00 0xf8 
0000211d:         	      0x0c 0x00 0x00 0x00 0x47 0x01 0xf8 0x0c 
0000211d:         	      0xf8 0x0c 0x01 0x08 0x87 0x18 0x00 0x01 
0000211d:         	      0x0c 0x03 0x00 0x00 0x00 0x00 0x00 0x0d 
0000211d:         	      0x00 0x00 0xff 0xff 0x00 0x00 0x00 0x00 
0000211d:         	      0x00 0x00 0x00 0xf3 0x00 0x00 0x00 0x87 
0000211d:         	      0x18 0x00 0x00 0x0c 0x03 0x00 0x00 0x00 
0000211d:         	      0x00 0x00 0x00 0x0a 0x00 0xff 0xff 0x0b 
0000211d:         	      0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x02 
0000211d:         	      0x00 0x00 0x87 0x18 0x00 0x00 0x0c 0x03 
0000211d:         	      0x00 0x00 0x00 0x00 0x00 0x00 0x0c 0x00 
0000211d:         	      0xff 0x3f 0x0c 0x00 0x00 0x00 0x00 0x00 
0000211d:         	      0x00 0x40 0x00 0x00 0x00 0x87 0x18 0x00 
0000211d:         	      0x00 0x0c 0x03 0x00 0x00 0x00 0x00 0x00 
0000211d:         	      0x40 0x0c 0x00 0xff 0x7f 0x0c 0x00 0x00 
0000211d:         	      0x00 0x00 0x00 0x00 0x40 0x00 0x00 0x00 
0000211d:         	      0x87 0x18 0x00 0x00 0x0c 0x03 0x00 0x00 
0000211d:         	      0x00 0x00 0x00 0x80 0x0c 0x00 0xff 0xbf 
0000211d:         	      0x0c 0x00 0x00 0x00 0x00 0x00 0x00 0x40 
0000211d:         	      0x00 0x00 0x00 0x87 0x18 0x00 0x00 0x0c 
0000211d:         	      0x03 0x00 0x00 0x00 0x00 0x00 0xc0 0x0c 
0000211d:         	      0x00 0xff 0xff 0x0c 0x00 0x00 0x00 0x00 
0000211d:         	      0x00 0x00 0x40 0x00 0x00 0x00 0x87 0x18 
0000211d:         	      0x00 0x00 0x0c 0x03 0x00 0x00 0x00 0x00 
0000211d:         	      0x00 0x00 0x0d 0x00 0xff 0x3f 0x0d 0x00 
0000211d:         	      0x00 0x00 0x00 0x00 0x00 0x40 0x00 0x00 
0000211d:         	      0x00 0x87 0x18 0x00 0x00 0x0c 0x03 0x00 
0000211d:         	      0x00 0x00 0x00 0x00 0x40 0x0d 0x00 0xff 
0000211d:         	      0x7f 0x0d 0x00 0x00 0x00 0x00 0x00 0x00 
0000211d:         	      0x40 0x00 0x00 0x00 0x87 0x18 0x00 0x00 
0000211d:         	      0x0c 0x03 0x00 0x00 0x00 0x00 0x00 0x80 
0000211d:         	      0x0d 0x00 0xff 0xbf 0x0d 0x00 0x00 0x00 
0000211d:         	      0x00 0x00 0x00 0x40 0x00 0x00 0x00 0x87 
0000211d:         	      0x18 0x00 0x00 0x0c 0x03 0x00 0x00 0x00 
0000211d:         	      0x00 0x00 0xc0 0x0d 0x00 0xff 0xff 0x0d 
0000211d:         	      0x00 0x00 0x00 0x00 0x00 0x00 0x40 0x00 
0000211d:         	      0x00 0x00 0x87 0x18 0x00 0x00 0x0c 0x03 
0000211d:         	      0x00 0x00 0x00 0x00 0x00 0x00 0x0e 0x00 
0000211d:         	      0xff 0x3f 0x0e 0x00 0x00 0x00 0x00 0x00 
0000211d:         	      0x00 0x40 0x00 0x00 0x00 0x87 0x18 0x00 
0000211d:         	      0x00 0x0c 0x03 0x00 0x00 0x00 0x00 0x00 
0000211d:         	      0x40 0x0e 0x00 0xff 0x7f 0x0e 0x00 0x00 
0000211d:         	      0x00 0x00 0x00 0x00 0x40 0x00 0x00 0x00 
0000211d:         	      0x87 0x18 0x00 0x00 0x0c 0x03 0x00 0x00 
0000211d:         	      0x00 0x00 0x00 0x80 0x0e 0x00 0xff 0xbf 
0000211d:         	      0x0e 0x00 0x00 0x00 0x00 0x00 0x00 0x40 
0000211d:         	      0x00 0x00 0x00 0x87 0x18 0x00 0x00 0x0c 
0000211d:         	      0x03 0x00 0x00 0x00 0x00 0x00 0xc0 0x0e 
0000211d:         	      0x00 0xff 0xff 0x0e 0x00 0x00 0x00 0x00 
0000211d:         	      0x00 0x00 0x40 0x00 0x00 0x00 0x87 0x18 
0000211d:         	      0x00 0x00 0x0c 0x03 0x00 0x00 0x00 0x00 
0000211d:         	      0x00 0x00 0x0f 0x00 0xff 0xff 0x0f 0x00 
0000211d:         	      0x00 0x00 0x00 0x00 0x00 0x00 0x01 0x00 
0000211d:         	      0x00 0x87 0x18 0x00 0x00 0x0c 0x03 0x00 
0000211d:         	      0x00 0x00 0x00 0x00 0x00 0x00 0x00 0xff 
0000211d:         	      0xff 0xbf 0xfe 0x00 0x00 0x00 0x00 0x00 
0000211d:         	      0x00 0x00 0x00 0x00 0x87 0x18 0x00 0x00 
0000211d:         	      0x0c 0x03 0x00 0x00 0x00 0x00 0x00 0x00 
0000211d:         	      0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 
0000211d:         	      0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x79 
0000211d:         	      0x00>
0000231e:     Method _CRS (\_SB_.PCI0._CRS)
00002325:       ArgCount 0; Serialized
00002326:       If
00002328:         PM1L (000020be)
0000232c:         CreateDWordField
0000232d:           BUF0 (00002112)
00002331:           0x80
00002333:           C0LN
00002337:         Store
00002338:           ZeroOp
00002339:           C0LN
0000233d:       If
0000233f:         LEqual
00002340:           PM1L (000020be)
00002344:           0x01
00002346:         CreateBitField
00002347:           BUF0 (00002112)
0000234b:           0x0378
0000234e:           C0RW
00002352:         Store
00002353:           ZeroOp
00002354:           C0RW
00002358:       If
0000235a:         PM1H (000020c5)
0000235e:         CreateDWordField
0000235f:           BUF0 (00002112)
00002363:           0x9b
00002365:           C4LN
00002369:         Store
0000236a:           ZeroOp
0000236b:           C4LN
0000236f:       If
00002371:         LEqual
00002372:           PM1H (000020c5)
00002376:           0x01
00002378:         CreateBitField
00002379:           BUF0 (00002112)
0000237d:           0x0450
00002380:           C4RW
00002384:         Store
00002385:           ZeroOp
00002386:           C4RW
0000238a:       If
0000238c:         PM2L (000020cc)
00002390:         CreateDWordField
00002391:           BUF0 (00002112)
00002395:           0xb6
00002397:           C8LN
0000239b:         Store
0000239c:           ZeroOp
0000239d:           C8LN
000023a1:       If
000023a3:         LEqual
000023a4:           PM2L (000020cc)
000023a8:           0x01
000023aa:         CreateBitField
000023ab:           BUF0 (00002112)
000023af:           0x0528
000023b2:           C8RW
000023b6:         Store
000023b7:           ZeroOp
000023b8:           C8RW
000023bc:       If
000023be:         PM2H (000020d3)
000023c2:         CreateDWordField
000023c3:           BUF0 (00002112)
000023c7:           0xd1
000023c9:           CCLN
000023cd:         Store
000023ce:           ZeroOp
000023cf:           CCLN
000023d3:       If
000023d5:         LEqual
000023d6:           PM2H (000020d3)
000023da:           0x01
000023dc:         CreateBitField
000023dd:           BUF0 (00002112)
000023e1:           0x0600
000023e4:           CCRW
000023e8:         Store
000023e9:           ZeroOp
000023ea:           CCRW
000023ee:       If
000023f0:         PM3L (000020da)
000023f4:         CreateDWordField
000023f5:           BUF0 (00002112)
000023f9:           0xec
000023fb:           D0LN
000023ff:         Store
00002400:           ZeroOp
00002401:           D0LN
00002405:       If
00002407:         LEqual
00002408:           PM3L (000020da)
0000240c:           0x01
0000240e:         CreateBitField
0000240f:           BUF0 (00002112)
00002413:           0x06d8
00002416:           D0RW
0000241a:         Store
0000241b:           ZeroOp
0000241c:           D0RW
00002420:       If
00002422:         PM3H (000020e1)
00002426:         CreateDWordField
00002427:           BUF0 (00002112)
0000242b:           0x0107
0000242e:           D4LN
00002432:         Store
00002433:           ZeroOp
00002434:           D4LN
00002438:       If
0000243a:         LEqual
0000243b:           PM3H (000020e1)
0000243f:           0x01
00002441:         CreateBitField
00002442:           BUF0 (00002112)
00002446:           0x07b0
00002449:           D4RW
0000244d:         Store
0000244e:           ZeroOp
0000244f:           D4RW
00002453:       If
00002455:         PM4L (000020e8)
00002459:         CreateDWordField
0000245a:           BUF0 (00002112)
0000245e:           0x0122
00002461:           D8LN
00002465:         Store
00002466:           ZeroOp
00002467:           D8LN
0000246b:       If
0000246d:         LEqual
0000246e:           PM4L (000020e8)
00002472:           0x01
00002474:         CreateBitField
00002475:           BUF0 (00002112)
00002479:           0x0888
0000247c:           D8RW
00002480:         Store
00002481:           ZeroOp
00002482:           D8RW
00002486:       If
00002488:         PM4H (000020ef)
0000248c:         CreateDWordField
0000248d:           BUF0 (00002112)
00002491:           0x013d
00002494:           DCLN
00002498:         Store
00002499:           ZeroOp
0000249a:           DCLN
0000249e:       If
000024a0:         LEqual
000024a1:           PM4H (000020ef)
000024a5:           0x01
000024a7:         CreateBitField
000024a8:           BUF0 (00002112)
000024ac:           0x0960
000024af:           DCRW
000024b3:         Store
000024b4:           ZeroOp
000024b5:           DCRW
000024b9:       If
000024bb:         PM5L (000020f6)
000024bf:         CreateDWordField
000024c0:           BUF0 (00002112)
000024c4:           0x0158
000024c7:           E0LN
000024cb:         Store
000024cc:           ZeroOp
000024cd:           E0LN
000024d1:       If
000024d3:         LEqual
000024d4:           PM5L (000020f6)
000024d8:           0x01
000024da:         CreateBitField
000024db:           BUF0 (00002112)
000024df:           0x0a38
000024e2:           E0RW
000024e6:         Store
000024e7:           ZeroOp
000024e8:           E0RW
000024ec:       If
000024ee:         PM5H (000020fd)
000024f2:         CreateDWordField
000024f3:           BUF0 (00002112)
000024f7:           0x0173
000024fa:           E4LN
000024fe:         Store
000024ff:           ZeroOp
00002500:           E4LN
00002504:       If
00002506:         LEqual
00002507:           PM5H (000020fd)
0000250b:           0x01
0000250d:         CreateBitField
0000250e:           BUF0 (00002112)
00002512:           0x0b10
00002515:           E4RW
00002519:         Store
0000251a:           ZeroOp
0000251b:           E4RW
0000251f:       If
00002521:         PM6L (00002104)
00002525:         CreateDWordField
00002526:           BUF0 (00002112)
0000252a:           0x018e
0000252d:           E8LN
00002531:         Store
00002532:           ZeroOp
00002533:           E8LN
00002537:       If
00002539:         LEqual
0000253a:           PM6L (00002104)
0000253e:           0x01
00002540:         CreateBitField
00002541:           BUF0 (00002112)
00002545:           0x0be8
00002548:           E8RW
0000254c:         Store
0000254d:           ZeroOp
0000254e:           E8RW
00002552:       If
00002554:         PM6H (0000210b)
00002558:         CreateDWordField
00002559:           BUF0 (00002112)
0000255d:           0x01a9
00002560:           ECLN
00002564:         Store
00002565:           ZeroOp
00002566:           ECLN
0000256a:       If
0000256c:         LEqual
0000256d:           PM6H (0000210b)
00002571:           0x01
00002573:         CreateBitField
00002574:           BUF0 (00002112)
00002578:           0x0cc0
0000257b:           ECRW
0000257f:         Store
00002580:           ZeroOp
00002581:           ECRW
00002585:       If
00002587:         PM0H (000020b7)
0000258b:         CreateDWordField
0000258c:           BUF0 (00002112)
00002590:           0x01c4
00002593:           F0LN
00002597:         Store
00002598:           ZeroOp
00002599:           F0LN
0000259d:       If
0000259f:         LEqual
000025a0:           PM0H (000020b7)
000025a4:           0x01
000025a6:         CreateBitField
000025a7:           BUF0 (00002112)
000025ab:           0x0d98
000025ae:           F0RW
000025b2:         Store
000025b3:           ZeroOp
000025b4:           F0RW
000025b8:       CreateDWordField
000025b9:         BUF0 (00002112)
000025bd:         0x01d3
000025c0:         M1MN
000025c4:       CreateDWordField
000025c5:         BUF0 (00002112)
000025c9:         0x01d7
000025cc:         M1MX
000025d0:       CreateDWordField
000025d1:         BUF0 (00002112)
000025d5:         0x01df
000025d8:         M1LN
000025dc:       Multiply
000025dd:         0x02000000
000025e2:         \_SB_.PCI0.MBUS.DRB3 (0000284a)
000025f5:         M1MN
000025f9:       Add
000025fa:         Subtract
000025fb:           M1MX
000025ff:           M1MN
00002603:           <NULL>
00002604:         0x01
00002606:         M1LN
0000260a:       ShiftRight
0000260b:         And
0000260c:           \_SB_.PCI0.LPCB.HPTE (00002ee8)
0000261f:           0x00038000
00002624:           <NULL>
00002625:         0x0f
00002627:         Local0
00002628:       If
0000262b:         And
0000262c:           Local0
0000262d:           0x04
0000262f:           <NULL>
00002630:         CreateDWordField
00002631:           BUF0 (00002112)
00002635:           0x01ee
00002638:           M2MN
0000263c:         CreateDWordField
0000263d:           BUF0 (00002112)
00002641:           0x01f2
00002644:           M2MX
00002648:         CreateDWordField
00002649:           BUF0 (00002112)
0000264d:           0x01fa
00002650:           M2LN
00002654:         Store
00002655:           0xfed00000
0000265a:           M2MN
0000265e:         Store
0000265f:           0xfed003ff
00002664:           M2MX
00002668:         Store
00002669:           0x0400
0000266c:           M2LN
00002670:         If
00002672:           LEqual
00002673:             Local0
00002674:             0x05
00002676:           Store
00002677:             0xfed01000
0000267c:             M2MN
00002680:           Store
00002681:             0xfed013ff
00002686:             M2MX
0000268a:         If
0000268c:           LEqual
0000268d:             Local0
0000268e:             0x06
00002690:           Store
00002691:             0xfed02000
00002696:             M2MN
0000269a:           Store
0000269b:             0xfed023ff
000026a0:             M2MX
000026a4:         If
000026a6:           LEqual
000026a7:             Local0
000026a8:             0x07
000026aa:           Store
000026ab:             0xfed03000
000026b0:             M2MN
000026b4:           Store
000026b5:             0xfed033ff
000026ba:             M2MX
000026be:       Return
000026bf:         BUF0 (00002112)
000026c3:     Method _PRT (\_SB_.PCI0._PRT)
000026ca:       ArgCount 0; NotSerialized
000026cb:       If
000026ce:         GPIC (000003be)
000026d2:         Return
000026d3:           Package
000026d6:             0x07
000026d7:             Package
000026d9:               0x04
000026da:               0x0002ffff
000026df:               0x00
000026e1:               0x00
000026e3:               0x10
000026e5:             Package
000026e7:               0x04
000026e8:               0x001dffff
000026ed:               0x00
000026ef:               0x00
000026f1:               0x10
000026f3:             Package
000026f5:               0x04
000026f6:               0x001dffff
000026fb:               0x01
000026fd:               0x00
000026ff:               0x13
00002701:             Package
00002703:               0x04
00002704:               0x001dffff
00002709:               0x02
0000270b:               0x00
0000270d:               0x12
0000270f:             Package
00002711:               0x04
00002712:               0x001dffff
00002717:               0x03
00002719:               0x00
0000271b:               0x17
0000271d:             Package
0000271f:               0x04
00002720:               0x001fffff
00002725:               0x00
00002727:               0x00
00002729:               0x12
0000272b:             Package
0000272d:               0x04
0000272e:               0x001fffff
00002733:               0x01
00002735:               0x00
00002737:               0x11
00002739:       Else
0000273c:         Return
0000273d:           Package
00002740:             0x07
00002741:             Package
00002743:               0x04
00002744:               0x0002ffff
00002749:               0x00
0000274b:               \_SB_.PCI0.LPCB.LNKA (00002f52)
0000275e:               0x00
00002760:             Package
00002762:               0x04
00002763:               0x001dffff
00002768:               0x00
0000276a:               \_SB_.PCI0.LPCB.LNKA (00002f52)
0000277d:               0x00
0000277f:             Package
00002781:               0x04
00002782:               0x001dffff
00002787:               0x01
00002789:               \_SB_.PCI0.LPCB.LNKD (0000313e)
0000279c:               0x00
0000279e:             Package
000027a0:               0x04
000027a1:               0x001dffff
000027a6:               0x02
000027a8:               \_SB_.PCI0.LPCB.LNKC (0000309a)
000027bb:               0x00
000027bd:             Package
000027bf:               0x04
000027c0:               0x001dffff
000027c5:               0x03
000027c7:               \_SB_.PCI0.LPCB.LNKH (000033ce)
000027da:               0x00
000027dc:             Package
000027de:               0x04
000027df:               0x001fffff
000027e4:               0x00
000027e6:               \_SB_.PCI0.LPCB.LNKC (0000309a)
000027f9:               0x00
000027fb:             Package
000027fd:               0x04
000027fe:               0x001fffff
00002803:               0x01
00002805:               \_SB_.PCI0.LPCB.LNKB (00002ff6)
00002818:               0x00
0000281a:     Device MBUS (\_SB_.PCI0.MBUS)
00002821:       Name _ADR (\_SB_.PCI0.MBUS._ADR)
00002826:         0x01
00002828:       OpRegion MBUS (\_SB_.PCI0.MBUS.MBUS)
0000282e:         PCI_Config
0000282f:         0x40
00002831:         0xc0
00002833:       Field
00002836:         MBUS (00002828)
0000283a:         AccessType: DWordAcc; LockRule: NoLock; UpdateRule: Preserve
0000283b:         NamedField DRB0
00002840:         NamedField DRB1
00002845:         NamedField DRB2
0000284a:         NamedField DRB3
0000284f:     Device GFX0 (\_SB_.PCI0.GFX0)
00002857:       Name _ADR (\_SB_.PCI0.GFX0._ADR)
0000285c:         0x00020000
00002861:       OpRegion VNVS (\_SB_.PCI0.GFX0.VNVS)
00002867:         SystemMemory
00002868:         0x476ecdb9
0000286d:         0x00010004
00002872:       Field
00002875:         VNVS (00002861)
00002879:         AccessType: AnyAcc; LockRule: Lock; UpdateRule: Preserve
0000287a:         NamedField RSIZ
0000287f:         NamedField RBUF
00002886:       Method _DOS (\_SB_.PCI0.GFX0._DOS)
0000288c:         ArgCount 1; NotSerialized
0000288d:         Store
0000288e:           And
0000288f:             Arg0
00002890:             0x03
00002892:             <NULL>
00002893:           DSEN (000003d6)
00002897:       Method _DOD (\_SB_.PCI0.GFX0._DOD)
0000289e:         ArgCount 0; NotSerialized
0000289f:         If
000028a1:           LEqual
000028a2:             LCDA (00000232)
000028a6:             0x0110
000028a9:           Return
000028aa:             Package
000028ac:               0x06
000028ad:               0x00010100
000028b2:               0x00010110
000028b7:               0x00010200
000028bc:               0x00010300
000028c1:               0x00010500
000028c6:               0x00010600
000028cb:         Return
000028cc:           Package
000028ce:             0x06
000028cf:             0x00010100
000028d4:             0x00010200
000028d9:             0x00010300
000028de:             0x00010400
000028e3:             0x00010500
000028e8:             0x00010600
000028ed:       Method _ROM (\_SB_.PCI0.GFX0._ROM)
000028f4:         ArgCount 2; NotSerialized
000028f5:         Store
000028f6:           Arg0
000028f7:           Local0
000028f8:         Store
000028f9:           Arg1
000028fa:           Local1
000028fb:         If
000028fd:           LGreater
000028fe:             Local1
000028ff:             0x1000
00002902:           Store
00002903:             0x1000
00002906:             Local1
00002907:         If
00002909:           LGreater
0000290a:             Add
0000290b:               Local0
0000290c:               Local1
0000290d:               <NULL>
0000290e:             RSIZ (0000287a)
00002912:           Store
00002913:             0x00
00002915:             Local0
00002916:         Multiply
00002917:           Local0
00002918:           0x08
0000291a:           Local2
0000291b:         Multiply
0000291c:           Local1
0000291d:           0x08
0000291f:           Local3
00002920:         Name ROM1 (\_SB_.PCI0.GFX0._ROM.ROM1)
00002925:           Buffer
00002927:             RSIZ (0000287a)
0000292b:         Name ROM2 (\_SB_.PCI0.GFX0._ROM.ROM2)
00002930:           Buffer
00002932:             Local1
00002933:         Store
00002934:           RBUF (0000287f)
00002938:           ROM1 (00002920)
0000293c:         CreateField
0000293e:           ROM1 (00002920)
00002942:           Local2
00002943:           Local3
00002944:           TMPB
00002948:         Store
00002949:           TMPB
0000294d:           ROM2 (0000292b)
00002951:         Return
00002952:           ROM2 (0000292b)
00002956:       Device CRT1 (\_SB_.PCI0.GFX0.CRT1)
0000295e:         Name _ADR (\_SB_.PCI0.GFX0.CRT1._ADR)
00002963:           0x0100
00002966:         Method _DCS (\_SB_.PCI0.GFX0.CRT1._DCS)
0000296c:           ArgCount 0; NotSerialized
0000296d:           Store
0000296e:             0x01
00002970:             SMIF (0000017f)
00002974:           Store
00002975:             0x00
00002977:             TRP0 (00000031)
0000297b:           If
0000297d:             And
0000297e:               CSTE (00000246)
00002982:               0x0101
00002985:               <NULL>
00002986:             Return
00002987:               0x1f
00002989:           Return
0000298a:             0x1d
0000298c:         Method _DGS (\_SB_.PCI0.GFX0.CRT1._DGS)
00002992:           ArgCount 0; NotSerialized
00002993:           If
00002995:             And
00002996:               NSTE (0000024b)
0000299a:               0x0101
0000299d:               <NULL>
0000299e:             Return
0000299f:               0x01
000029a1:           Return
000029a2:             0x00
000029a4:         Method _DSS (\_SB_.PCI0.GFX0.CRT1._DSS)
000029aa:           ArgCount 1; NotSerialized
000029ab:           If
000029ad:             LEqual
000029ae:               And
000029af:                 Arg0
000029b0:                 0xc0000000
000029b5:                 <NULL>
000029b6:               0xc0000000
000029bb:             Store
000029bc:               NSTE (0000024b)
000029c0:               CSTE (00000246)
000029c4:       Device DTV1 (\_SB_.PCI0.GFX0.DTV1)
000029cc:         Name _ADR (\_SB_.PCI0.GFX0.DTV1._ADR)
000029d1:           0x0200
000029d4:         Method _DCS (\_SB_.PCI0.GFX0.DTV1._DCS)
000029da:           ArgCount 0; NotSerialized
000029db:           Store
000029dc:             0x01
000029de:             SMIF (0000017f)
000029e2:           Store
000029e3:             0x00
000029e5:             TRP0 (00000031)
000029e9:           If
000029eb:             And
000029ec:               CSTE (00000246)
000029f0:               0x0202
000029f3:               <NULL>
000029f4:             Return
000029f5:               0x1f
000029f7:           Return
000029f8:             0x1d
000029fa:         Method _DGS (\_SB_.PCI0.GFX0.DTV1._DGS)
00002a00:           ArgCount 0; NotSerialized
00002a01:           If
00002a03:             And
00002a04:               NSTE (0000024b)
00002a08:               0x0202
00002a0b:               <NULL>
00002a0c:             Return
00002a0d:               0x01
00002a0f:           Return
00002a10:             0x00
00002a12:         Method _DSS (\_SB_.PCI0.GFX0.DTV1._DSS)
00002a18:           ArgCount 1; NotSerialized
00002a19:           If
00002a1b:             LEqual
00002a1c:               And
00002a1d:                 Arg0
00002a1e:                 0xc0000000
00002a23:                 <NULL>
00002a24:               0xc0000000
00002a29:             Store
00002a2a:               NSTE (0000024b)
00002a2e:               CSTE (00000246)
00002a32:       Device DFP1 (\_SB_.PCI0.GFX0.DFP1)
00002a3a:         Name _ADR (\_SB_.PCI0.GFX0.DFP1._ADR)
00002a3f:           0x0300
00002a42:         Method _DCS (\_SB_.PCI0.GFX0.DFP1._DCS)
00002a48:           ArgCount 0; NotSerialized
00002a49:           Store
00002a4a:             0x01
00002a4c:             SMIF (0000017f)
00002a50:           Store
00002a51:             0x00
00002a53:             TRP0 (00000031)
00002a57:           If
00002a59:             And
00002a5a:               CSTE (00000246)
00002a5e:               0x0404
00002a61:               <NULL>
00002a62:             Return
00002a63:               0x1f
00002a65:           Return
00002a66:             0x1d
00002a68:         Method _DGS (\_SB_.PCI0.GFX0.DFP1._DGS)
00002a6e:           ArgCount 0; NotSerialized
00002a6f:           If
00002a71:             And
00002a72:               NSTE (0000024b)
00002a76:               0x0404
00002a79:               <NULL>
00002a7a:             Return
00002a7b:               0x01
00002a7d:           Return
00002a7e:             0x00
00002a80:         Method _DSS (\_SB_.PCI0.GFX0.DFP1._DSS)
00002a86:           ArgCount 1; NotSerialized
00002a87:           If
00002a89:             LEqual
00002a8a:               And
00002a8b:                 Arg0
00002a8c:                 0xc0000000
00002a91:                 <NULL>
00002a92:               0xc0000000
00002a97:             Store
00002a98:               NSTE (0000024b)
00002a9c:               CSTE (00000246)
00002aa0:       Device LCD_ (\_SB_.PCI0.GFX0.LCD_)
00002aa8:         Method _ADR (\_SB_.PCI0.GFX0.LCD_._ADR)
00002aae:           ArgCount 0; NotSerialized
00002aaf:           If
00002ab1:             LEqual
00002ab2:               LCDA (00000232)
00002ab6:               0x0110
00002ab9:             Return
00002aba:               0x0110
00002abd:           Return
00002abe:             0x0400
00002ac1:         Method _DCS (\_SB_.PCI0.GFX0.LCD_._DCS)
00002ac7:           ArgCount 0; NotSerialized
00002ac8:           Store
00002ac9:             0x01
00002acb:             SMIF (0000017f)
00002acf:           Store
00002ad0:             0x00
00002ad2:             TRP0 (00000031)
00002ad6:           If
00002ad8:             And
00002ad9:               CSTE (00000246)
00002add:               0x0808
00002ae0:               <NULL>
00002ae1:             Return
00002ae2:               0x1f
00002ae4:           Return
00002ae5:             0x1d
00002ae7:         Method _DGS (\_SB_.PCI0.GFX0.LCD_._DGS)
00002aed:           ArgCount 0; NotSerialized
00002aee:           If
00002af0:             And
00002af1:               NSTE (0000024b)
00002af5:               0x0808
00002af8:               <NULL>
00002af9:             Return
00002afa:               0x01
00002afc:           Return
00002afd:             0x00
00002aff:         Method _DSS (\_SB_.PCI0.GFX0.LCD_._DSS)
00002b05:           ArgCount 1; NotSerialized
00002b06:           If
00002b08:             LEqual
00002b09:               And
00002b0a:                 Arg0
00002b0b:                 0xc0000000
00002b10:                 <NULL>
00002b11:               0xc0000000
00002b16:             Store
00002b17:               NSTE (0000024b)
00002b1b:               CSTE (00000246)
00002b1f:         Method _BCL (\_SB_.PCI0.GFX0.LCD_._BCL)
00002b25:           ArgCount 0; NotSerialized
00002b26:           Return
00002b27:             Package
00002b29:               0x08
00002b2a:               0x50
00002b2c:               0x3c
00002b2e:               0x00
00002b30:               0x14
00002b32:               0x28
00002b34:               0x3c
00002b36:               0x50
00002b38:               0x64
00002b3a:         Method _BCM (\_SB_.PCI0.GFX0.LCD_._BCM)
00002b40:           ArgCount 1; NotSerialized
00002b41:           Store
00002b42:             Arg0
00002b43:             P80H (00000013)
00002b47:       Device DTV2 (\_SB_.PCI0.GFX0.DTV2)
00002b4f:         Name _ADR (\_SB_.PCI0.GFX0.DTV2._ADR)
00002b54:           0x0500
00002b57:         Method _DCS (\_SB_.PCI0.GFX0.DTV2._DCS)
00002b5d:           ArgCount 0; NotSerialized
00002b5e:           Store
00002b5f:             0x01
00002b61:             SMIF (0000017f)
00002b65:           Store
00002b66:             0x00
00002b68:             TRP0 (00000031)
00002b6c:           If
00002b6e:             And
00002b6f:               CSTE (00000246)
00002b73:               0x1010
00002b76:               <NULL>
00002b77:             Return
00002b78:               0x1f
00002b7a:           Return
00002b7b:             0x1d
00002b7d:         Method _DGS (\_SB_.PCI0.GFX0.DTV2._DGS)
00002b83:           ArgCount 0; NotSerialized
00002b84:           If
00002b86:             And
00002b87:               NSTE (0000024b)
00002b8b:               0x1010
00002b8e:               <NULL>
00002b8f:             Return
00002b90:               0x01
00002b92:           Return
00002b93:             0x00
00002b95:         Method _DSS (\_SB_.PCI0.GFX0.DTV2._DSS)
00002b9b:           ArgCount 1; NotSerialized
00002b9c:           If
00002b9e:             LEqual
00002b9f:               And
00002ba0:                 Arg0
00002ba1:                 0xc0000000
00002ba6:                 <NULL>
00002ba7:               0xc0000000
00002bac:             Store
00002bad:               NSTE (0000024b)
00002bb1:               CSTE (00000246)
00002bb5:       Device DFP2 (\_SB_.PCI0.GFX0.DFP2)
00002bbd:         Name _ADR (\_SB_.PCI0.GFX0.DFP2._ADR)
00002bc2:           0x0600
00002bc5:         Method _DCS (\_SB_.PCI0.GFX0.DFP2._DCS)
00002bcb:           ArgCount 0; NotSerialized
00002bcc:           Store
00002bcd:             0x01
00002bcf:             SMIF (0000017f)
00002bd3:           Store
00002bd4:             0x00
00002bd6:             TRP0 (00000031)
00002bda:           If
00002bdc:             And
00002bdd:               CSTE (00000246)
00002be1:               0x2020
00002be4:               <NULL>
00002be5:             Return
00002be6:               0x1f
00002be8:           Return
00002be9:             0x1d
00002beb:         Method _DGS (\_SB_.PCI0.GFX0.DFP2._DGS)
00002bf1:           ArgCount 0; NotSerialized
00002bf2:           If
00002bf4:             And
00002bf5:               NSTE (0000024b)
00002bf9:               0x2020
00002bfc:               <NULL>
00002bfd:             Return
00002bfe:               0x01
00002c00:           Return
00002c01:             0x00
00002c03:         Method _DSS (\_SB_.PCI0.GFX0.DFP2._DSS)
00002c09:           ArgCount 1; NotSerialized
00002c0a:           If
00002c0c:             LEqual
00002c0d:               And
00002c0e:                 Arg0
00002c0f:                 0xc0000000
00002c14:                 <NULL>
00002c15:               0xc0000000
00002c1a:             Store
00002c1b:               NSTE (0000024b)
00002c1f:               CSTE (00000246)
00002c23:     Device PCIB (\_SB_.PCI0.PCIB)
00002c2b:       Name _ADR (\_SB_.PCI0.PCIB._ADR)
00002c30:         0x001e0000
00002c35:       OpRegion PBUS (\_SB_.PCI0.PCIB.PBUS)
00002c3b:         PCI_Config
00002c3c:         0x44
00002c3e:         0x04
00002c40:       Field
00002c43:         PBUS (00002c35)
00002c47:         AccessType: DWordAcc; LockRule: NoLock; UpdateRule: Preserve
00002c48:         NamedField DHID
00002c4d:       Device CDB0 (\_SB_.PCI0.PCIB.CDB0)
00002c55:         Name _ADR (\_SB_.PCI0.PCIB.CDB0._ADR)
00002c5a:           0x00030000
00002c5f:         OpRegion CBD0 (\_SB_.PCI0.PCIB.CDB0.CBD0)
00002c65:           PCI_Config
00002c66:           0x00
00002c68:           0xf0
00002c6a:         Field
00002c6d:           CBD0 (00002c5f)
00002c71:           AccessType: AnyAcc; LockRule: NoLock; UpdateRule: Preserve
00002c72:           ReservedField
00002c75:           NamedField CD3C
00002c7a:           ReservedField
00002c7c:           NamedField CD44
00002c81:           ReservedField
00002c84:           NamedField CDA5
00002c89:           ReservedField
00002c8c:           NamedField PMES
00002c91:         Method _INI (\_SB_.PCI0.PCIB.CDB0._INI)
00002c97:           ArgCount 0; NotSerialized
00002c98:           Or
00002c99:             CD3C (00002c75)
00002c9d:             0xff
00002c9f:             CD3C (00002c75)
00002ca3:           Store
00002ca4:             0x00
00002ca6:             CD44 (00002c7c)
00002caa:       Device CDB1 (\_SB_.PCI0.PCIB.CDB1)
00002cb2:         Name _ADR (\_SB_.PCI0.PCIB.CDB1._ADR)
00002cb7:           0x00030001
00002cbc:         OpRegion CBD1 (\_SB_.PCI0.PCIB.CDB1.CBD1)
00002cc2:           PCI_Config
00002cc3:           0x00
00002cc5:           0xf0
00002cc7:         Field
00002cca:           CBD1 (00002cbc)
00002cce:           AccessType: AnyAcc; LockRule: NoLock; UpdateRule: Preserve
00002ccf:           ReservedField
00002cd2:           NamedField CD3C
00002cd7:           ReservedField
00002cd9:           NamedField CD44
00002cde:           ReservedField
00002ce1:           NamedField PMES
00002ce6:         Method _INI (\_SB_.PCI0.PCIB.CDB1._INI)
00002cec:           ArgCount 0; NotSerialized
00002ced:           Or
00002cee:             CD3C (00002cd2)
00002cf2:             0xff
00002cf4:             CD3C (00002cd2)
00002cf8:           Store
00002cf9:             0x00
00002cfb:             CD44 (00002cd9)
00002cff:       Device OHCI (\_SB_.PCI0.PCIB.OHCI)
00002d06:         Name _ADR (\_SB_.PCI0.PCIB.OHCI._ADR)
00002d0b:           0x00030002
00002d10:       Device LANC (\_SB_.PCI0.PCIB.LANC)
00002d17:         Name _ADR (\_SB_.PCI0.PCIB.LANC._ADR)
00002d1c:           0x00050000
00002d21:         Name _PRW (\_SB_.PCI0.PCIB.LANC._PRW)
00002d26:           Package
00002d28:             0x02
00002d29:             0x0b
00002d2b:             0x04
00002d2d:       Device MPC0 (\_SB_.PCI0.PCIB.MPC0)
00002d34:         Name _ADR (\_SB_.PCI0.PCIB.MPC0._ADR)
00002d39:           0x00040000
00002d3e:         Name _PRW (\_SB_.PCI0.PCIB.MPC0._PRW)
00002d43:           Package
00002d45:             0x02
00002d46:             0x0b
00002d48:             0x03
00002d4a:       Device MPC1 (\_SB_.PCI0.PCIB.MPC1)
00002d51:         Name _ADR (\_SB_.PCI0.PCIB.MPC1._ADR)
00002d56:           0x00040001
00002d5b:         Name _PRW (\_SB_.PCI0.PCIB.MPC1._PRW)
00002d60:           Package
00002d62:             0x02
00002d63:             0x0b
00002d65:             0x03
00002d67:       Method _PRT (\_SB_.PCI0.PCIB._PRT)
00002d6e:         ArgCount 0; NotSerialized
00002d6f:         If
00002d72:           GPIC (000003be)
00002d76:           Return
00002d77:             Package
00002d7a:               0x06
00002d7b:               Package
00002d7d:                 0x04
00002d7e:                 0x0003ffff
00002d83:                 0x00
00002d85:                 0x00
00002d87:                 0x10
00002d89:               Package
00002d8b:                 0x04
00002d8c:                 0x0003ffff
00002d91:                 0x01
00002d93:                 0x00
00002d95:                 0x11
00002d97:               Package
00002d99:                 0x04
00002d9a:                 0x0003ffff
00002d9f:                 0x02
00002da1:                 0x00
00002da3:                 0x12
00002da5:               Package
00002da7:                 0x04
00002da8:                 0x0004ffff
00002dad:                 0x00
00002daf:                 0x00
00002db1:                 0x14
00002db3:               Package
00002db5:                 0x04
00002db6:                 0x0004ffff
00002dbb:                 0x01
00002dbd:                 0x00
00002dbf:                 0x15
00002dc1:               Package
00002dc3:                 0x04
00002dc4:                 0x0005ffff
00002dc9:                 0x00
00002dcb:                 0x00
00002dcd:                 0x13
00002dcf:         Else
00002dd2:           Return
00002dd3:             Package
00002dd6:               0x06
00002dd7:               Package
00002dd9:                 0x04
00002dda:                 0x0003ffff
00002ddf:                 0x00
00002de1:                 \_SB_.PCI0.LPCB.LNKA (00002f52)
00002df4:                 0x00
00002df6:               Package
00002df8:                 0x04
00002df9:                 0x0003ffff
00002dfe:                 0x01
00002e00:                 \_SB_.PCI0.LPCB.LNKB (00002ff6)
00002e13:                 0x00
00002e15:               Package
00002e17:                 0x04
00002e18:                 0x0003ffff
00002e1d:                 0x02
00002e1f:                 \_SB_.PCI0.LPCB.LNKC (0000309a)
00002e32:                 0x00
00002e34:               Package
00002e36:                 0x04
00002e37:                 0x0004ffff
00002e3c:                 0x00
00002e3e:                 \_SB_.PCI0.LPCB.LNKE (000031e2)
00002e51:                 0x00
00002e53:               Package
00002e55:                 0x04
00002e56:                 0x0004ffff
00002e5b:                 0x01
00002e5d:                 \_SB_.PCI0.LPCB.LNKF (00003286)
00002e70:                 0x00
00002e72:               Package
00002e74:                 0x04
00002e75:                 0x0005ffff
00002e7a:                 0x00
00002e7c:                 \_SB_.PCI0.LPCB.LNKD (0000313e)
00002e8f:                 0x00
00002e91:     Device LPCB (\_SB_.PCI0.LPCB)
00002e9a:       Name _ADR (\_SB_.PCI0.LPCB._ADR)
00002e9f:         0x001f0000
00002ea4:       OpRegion LPC0 (\_SB_.PCI0.LPCB.LPC0)
00002eaa:         PCI_Config
00002eab:         0x40
00002ead:         0xc0
00002eaf:       Field
00002eb3:         LPC0 (00002ea4)
00002eb7:         AccessType: AnyAcc; LockRule: NoLock; UpdateRule: Preserve
00002eb8:         ReservedField
00002ebb:         NamedField PIRA
00002ec0:         NamedField PIRB
00002ec5:         NamedField PIRC
00002eca:         NamedField PIRD
00002ecf:         ReservedField
00002ed1:         NamedField PIRE
00002ed6:         NamedField PIRF
00002edb:         NamedField PIRG
00002ee0:         NamedField PIRH
00002ee5:         ReservedField
00002ee8:         NamedField HPTE
00002eed:         ReservedField
00002ef0:         NamedField LDE0
00002ef5:         NamedField LDE1
00002efa:         ReservedField
00002efc:         NamedField LDEN
00002f01:       Method IRQ5 (\_SB_.PCI0.LPCB.IRQ5)
00002f07:         ArgCount 0; Serialized
00002f08:         Name BUF1 (\_SB_.PCI0.LPCB.IRQ5.BUF1)
00002f0d:           Buffer
00002f0f:             0x06
00002f11:             ByteList <0x23 0x20 0x00 0x18 0x79 0x00>
00002f11:             Interpreted as PnP Resource Descriptor:
00002f11:             IRQ mask: 0000000001000000
00002f11:             Info: shareable, low true level sensitive
00002f11:             Bad checksum 0xd4, should be 0
00002f11:             
00002f17:         Return
00002f18:           BUF1 (00002f08)
00002f1c:       Method IRQA (\_SB_.PCI0.LPCB.IRQA)
00002f22:         ArgCount 0; Serialized
00002f23:         Name BUF2 (\_SB_.PCI0.LPCB.IRQA.BUF2)
00002f28:           Buffer
00002f2a:             0x06
00002f2c:             ByteList <0x23 0x00 0x04 0x18 0x79 0x00>
00002f2c:             Interpreted as PnP Resource Descriptor:
00002f2c:             IRQ mask: 0000100000000000
00002f2c:             Info: shareable, low true level sensitive
00002f2c:             Bad checksum 0xb8, should be 0
00002f2c:             
00002f32:         Return
00002f33:           BUF2 (00002f23)
00002f37:       Method IRQB (\_SB_.PCI0.LPCB.IRQB)
00002f3d:         ArgCount 0; Serialized
00002f3e:         Name BUF3 (\_SB_.PCI0.LPCB.IRQB.BUF3)
00002f43:           Buffer
00002f45:             0x06
00002f47:             ByteList <0x23 0x00 0x08 0x18 0x79 0x00>
00002f47:             Interpreted as PnP Resource Descriptor:
00002f47:             IRQ mask: 0001000000000000
00002f47:             Info: shareable, low true level sensitive
00002f47:             Bad checksum 0xbc, should be 0
00002f47:             
00002f4d:         Return
00002f4e:           BUF3 (00002f3e)
00002f52:       Device LNKA (\_SB_.PCI0.LPCB.LNKA)
00002f5a:         Name _HID (\_SB_.PCI0.LPCB.LNKA._HID)
00002f5f:           PNP0c0f (0x0f0cd041)
00002f64:         Name _UID (\_SB_.PCI0.LPCB.LNKA._UID)
00002f69:           0x01
00002f6b:         Method _DIS (\_SB_.PCI0.LPCB.LNKA._DIS)
00002f71:           ArgCount 0; Serialized
00002f72:           Store
00002f73:             0x80
00002f75:             PIRA (00002ebb)
00002f79:         Method _PRS (\_SB_.PCI0.LPCB.LNKA._PRS)
00002f7f:           ArgCount 0; Serialized
00002f80:           Return
00002f81:             <NULL>
00002f85:         Method _CRS (\_SB_.PCI0.LPCB.LNKA._CRS)
00002f8b:           ArgCount 0; Serialized
00002f8c:           Name RTLA (\_SB_.PCI0.LPCB.LNKA._CRS.RTLA)
00002f91:             Buffer
00002f93:               0x06
00002f95:               ByteList <0x23 0x00 0x00 0x18 0x79 0x00>
00002f95:               Interpreted as PnP Resource Descriptor:
00002f95:               IRQ mask: 0000000000000000
00002f95:               Info: shareable, low true level sensitive
00002f95:               Bad checksum 0xb4, should be 0
00002f95:               
00002f9b:           CreateWordField
00002f9c:             RTLA (00002f8c)
00002fa0:             0x01
00002fa2:             IRQ0
00002fa6:           Store
00002fa7:             ZeroOp
00002fa8:             IRQ0
00002fac:           ShiftLeft
00002fad:             0x01
00002faf:             And
00002fb0:               PIRA (00002ebb)
00002fb4:               0x0f
00002fb6:               <NULL>
00002fb7:             IRQ0
00002fbb:           Return
00002fbc:             RTLA (00002f8c)
00002fc0:         Method _SRS (\_SB_.PCI0.LPCB.LNKA._SRS)
00002fc6:           ArgCount 1; Serialized
00002fc7:           CreateWordField
00002fc8:             Arg0
00002fc9:             0x01
00002fcb:             IRQ0
00002fcf:           FindSetRightBit
00002fd0:             IRQ0
00002fd4:             Local0
00002fd5:           Decrement
00002fd6:             Local0
00002fd7:           Store
00002fd8:             Local0
00002fd9:             PIRA (00002ebb)
00002fdd:         Method _STA (\_SB_.PCI0.LPCB.LNKA._STA)
00002fe3:           ArgCount 0; Serialized
00002fe4:           If
00002fe6:             And
00002fe7:               PIRA (00002ebb)
00002feb:               0x80
00002fed:               <NULL>
00002fee:             Return
00002fef:               0x09
00002ff1:           Else
00002ff3:             Return
00002ff4:               0x0b
00002ff6:       Device LNKB (\_SB_.PCI0.LPCB.LNKB)
00002ffe:         Name _HID (\_SB_.PCI0.LPCB.LNKB._HID)
00003003:           PNP0c0f (0x0f0cd041)
00003008:         Name _UID (\_SB_.PCI0.LPCB.LNKB._UID)
0000300d:           0x02
0000300f:         Method _DIS (\_SB_.PCI0.LPCB.LNKB._DIS)
00003015:           ArgCount 0; Serialized
00003016:           Store
00003017:             0x80
00003019:             PIRB (00002ec0)
0000301d:         Method _PRS (\_SB_.PCI0.LPCB.LNKB._PRS)
00003023:           ArgCount 0; Serialized
00003024:           Return
00003025:             <NULL>
00003029:         Method _CRS (\_SB_.PCI0.LPCB.LNKB._CRS)
0000302f:           ArgCount 0; Serialized
00003030:           Name RTLB (\_SB_.PCI0.LPCB.LNKB._CRS.RTLB)
00003035:             Buffer
00003037:               0x06
00003039:               ByteList <0x23 0x00 0x00 0x18 0x79 0x00>
00003039:               Interpreted as PnP Resource Descriptor:
00003039:               IRQ mask: 0000000000000000
00003039:               Info: shareable, low true level sensitive
00003039:               Bad checksum 0xb4, should be 0
00003039:               
0000303f:           CreateWordField
00003040:             RTLB (00003030)
00003044:             0x01
00003046:             IRQ0
0000304a:           Store
0000304b:             ZeroOp
0000304c:             IRQ0
00003050:           ShiftLeft
00003051:             0x01
00003053:             And
00003054:               PIRB (00002ec0)
00003058:               0x0f
0000305a:               <NULL>
0000305b:             IRQ0
0000305f:           Return
00003060:             RTLB (00003030)
00003064:         Method _SRS (\_SB_.PCI0.LPCB.LNKB._SRS)
0000306a:           ArgCount 1; Serialized
0000306b:           CreateWordField
0000306c:             Arg0
0000306d:             0x01
0000306f:             IRQ0
00003073:           FindSetRightBit
00003074:             IRQ0
00003078:             Local0
00003079:           Decrement
0000307a:             Local0
0000307b:           Store
0000307c:             Local0
0000307d:             PIRB (00002ec0)
00003081:         Method _STA (\_SB_.PCI0.LPCB.LNKB._STA)
00003087:           ArgCount 0; Serialized
00003088:           If
0000308a:             And
0000308b:               PIRB (00002ec0)
0000308f:               0x80
00003091:               <NULL>
00003092:             Return
00003093:               0x09
00003095:           Else
00003097:             Return
00003098:               0x0b
0000309a:       Device LNKC (\_SB_.PCI0.LPCB.LNKC)
000030a2:         Name _HID (\_SB_.PCI0.LPCB.LNKC._HID)
000030a7:           PNP0c0f (0x0f0cd041)
000030ac:         Name _UID (\_SB_.PCI0.LPCB.LNKC._UID)
000030b1:           0x03
000030b3:         Method _DIS (\_SB_.PCI0.LPCB.LNKC._DIS)
000030b9:           ArgCount 0; Serialized
000030ba:           Store
000030bb:             0x80
000030bd:             PIRC (00002ec5)
000030c1:         Method _PRS (\_SB_.PCI0.LPCB.LNKC._PRS)
000030c7:           ArgCount 0; Serialized
000030c8:           Return
000030c9:             <NULL>
000030cd:         Method _CRS (\_SB_.PCI0.LPCB.LNKC._CRS)
000030d3:           ArgCount 0; Serialized
000030d4:           Name RTLC (\_SB_.PCI0.LPCB.LNKC._CRS.RTLC)
000030d9:             Buffer
000030db:               0x06
000030dd:               ByteList <0x23 0x00 0x00 0x18 0x79 0x00>
000030dd:               Interpreted as PnP Resource Descriptor:
000030dd:               IRQ mask: 0000000000000000
000030dd:               Info: shareable, low true level sensitive
000030dd:               Bad checksum 0xb4, should be 0
000030dd:               
000030e3:           CreateWordField
000030e4:             RTLC (000030d4)
000030e8:             0x01
000030ea:             IRQ0
000030ee:           Store
000030ef:             ZeroOp
000030f0:             IRQ0
000030f4:           ShiftLeft
000030f5:             0x01
000030f7:             And
000030f8:               PIRC (00002ec5)
000030fc:               0x0f
000030fe:               <NULL>
000030ff:             IRQ0
00003103:           Return
00003104:             RTLC (000030d4)
00003108:         Method _SRS (\_SB_.PCI0.LPCB.LNKC._SRS)
0000310e:           ArgCount 1; Serialized
0000310f:           CreateWordField
00003110:             Arg0
00003111:             0x01
00003113:             IRQ0
00003117:           FindSetRightBit
00003118:             IRQ0
0000311c:             Local0
0000311d:           Decrement
0000311e:             Local0
0000311f:           Store
00003120:             Local0
00003121:             PIRC (00002ec5)
00003125:         Method _STA (\_SB_.PCI0.LPCB.LNKC._STA)
0000312b:           ArgCount 0; Serialized
0000312c:           If
0000312e:             And
0000312f:               PIRC (00002ec5)
00003133:               0x80
00003135:               <NULL>
00003136:             Return
00003137:               0x09
00003139:           Else
0000313b:             Return
0000313c:               0x0b
0000313e:       Device LNKD (\_SB_.PCI0.LPCB.LNKD)
00003146:         Name _HID (\_SB_.PCI0.LPCB.LNKD._HID)
0000314b:           PNP0c0f (0x0f0cd041)
00003150:         Name _UID (\_SB_.PCI0.LPCB.LNKD._UID)
00003155:           0x04
00003157:         Method _DIS (\_SB_.PCI0.LPCB.LNKD._DIS)
0000315d:           ArgCount 0; Serialized
0000315e:           Store
0000315f:             0x80
00003161:             PIRD (00002eca)
00003165:         Method _PRS (\_SB_.PCI0.LPCB.LNKD._PRS)
0000316b:           ArgCount 0; Serialized
0000316c:           Return
0000316d:             <NULL>
00003171:         Method _CRS (\_SB_.PCI0.LPCB.LNKD._CRS)
00003177:           ArgCount 0; Serialized
00003178:           Name RTLD (\_SB_.PCI0.LPCB.LNKD._CRS.RTLD)
0000317d:             Buffer
0000317f:               0x06
00003181:               ByteList <0x23 0x00 0x00 0x18 0x79 0x00>
00003181:               Interpreted as PnP Resource Descriptor:
00003181:               IRQ mask: 0000000000000000
00003181:               Info: shareable, low true level sensitive
00003181:               Bad checksum 0xb4, should be 0
00003181:               
00003187:           CreateWordField
00003188:             RTLD (00003178)
0000318c:             0x01
0000318e:             IRQ0
00003192:           Store
00003193:             ZeroOp
00003194:             IRQ0
00003198:           ShiftLeft
00003199:             0x01
0000319b:             And
0000319c:               PIRD (00002eca)
000031a0:               0x0f
000031a2:               <NULL>
000031a3:             IRQ0
000031a7:           Return
000031a8:             RTLD (00003178)
000031ac:         Method _SRS (\_SB_.PCI0.LPCB.LNKD._SRS)
000031b2:           ArgCount 1; Serialized
000031b3:           CreateWordField
000031b4:             Arg0
000031b5:             0x01
000031b7:             IRQ0
000031bb:           FindSetRightBit
000031bc:             IRQ0
000031c0:             Local0
000031c1:           Decrement
000031c2:             Local0
000031c3:           Store
000031c4:             Local0
000031c5:             PIRD (00002eca)
000031c9:         Method _STA (\_SB_.PCI0.LPCB.LNKD._STA)
000031cf:           ArgCount 0; Serialized
000031d0:           If
000031d2:             And
000031d3:               PIRD (00002eca)
000031d7:               0x80
000031d9:               <NULL>
000031da:             Return
000031db:               0x09
000031dd:           Else
000031df:             Return
000031e0:               0x0b
000031e2:       Device LNKE (\_SB_.PCI0.LPCB.LNKE)
000031ea:         Name _HID (\_SB_.PCI0.LPCB.LNKE._HID)
000031ef:           PNP0c0f (0x0f0cd041)
000031f4:         Name _UID (\_SB_.PCI0.LPCB.LNKE._UID)
000031f9:           0x05
000031fb:         Method _DIS (\_SB_.PCI0.LPCB.LNKE._DIS)
00003201:           ArgCount 0; Serialized
00003202:           Store
00003203:             0x80
00003205:             PIRE (00002ed1)
00003209:         Method _PRS (\_SB_.PCI0.LPCB.LNKE._PRS)
0000320f:           ArgCount 0; Serialized
00003210:           Return
00003211:             <NULL>
00003215:         Method _CRS (\_SB_.PCI0.LPCB.LNKE._CRS)
0000321b:           ArgCount 0; Serialized
0000321c:           Name RTLE (\_SB_.PCI0.LPCB.LNKE._CRS.RTLE)
00003221:             Buffer
00003223:               0x06
00003225:               ByteList <0x23 0x00 0x00 0x18 0x79 0x00>
00003225:               Interpreted as PnP Resource Descriptor:
00003225:               IRQ mask: 0000000000000000
00003225:               Info: shareable, low true level sensitive
00003225:               Bad checksum 0xb4, should be 0
00003225:               
0000322b:           CreateWordField
0000322c:             RTLE (0000321c)
00003230:             0x01
00003232:             IRQ0
00003236:           Store
00003237:             ZeroOp
00003238:             IRQ0
0000323c:           ShiftLeft
0000323d:             0x01
0000323f:             And
00003240:               PIRE (00002ed1)
00003244:               0x0f
00003246:               <NULL>
00003247:             IRQ0
0000324b:           Return
0000324c:             RTLE (0000321c)
00003250:         Method _SRS (\_SB_.PCI0.LPCB.LNKE._SRS)
00003256:           ArgCount 1; Serialized
00003257:           CreateWordField
00003258:             Arg0
00003259:             0x01
0000325b:             IRQ0
0000325f:           FindSetRightBit
00003260:             IRQ0
00003264:             Local0
00003265:           Decrement
00003266:             Local0
00003267:           Store
00003268:             Local0
00003269:             PIRE (00002ed1)
0000326d:         Method _STA (\_SB_.PCI0.LPCB.LNKE._STA)
00003273:           ArgCount 0; Serialized
00003274:           If
00003276:             And
00003277:               PIRE (00002ed1)
0000327b:               0x80
0000327d:               <NULL>
0000327e:             Return
0000327f:               0x09
00003281:           Else
00003283:             Return
00003284:               0x0b
00003286:       Device LNKF (\_SB_.PCI0.LPCB.LNKF)
0000328e:         Name _HID (\_SB_.PCI0.LPCB.LNKF._HID)
00003293:           PNP0c0f (0x0f0cd041)
00003298:         Name _UID (\_SB_.PCI0.LPCB.LNKF._UID)
0000329d:           0x06
0000329f:         Method _DIS (\_SB_.PCI0.LPCB.LNKF._DIS)
000032a5:           ArgCount 0; Serialized
000032a6:           Store
000032a7:             0x80
000032a9:             PIRF (00002ed6)
000032ad:         Method _PRS (\_SB_.PCI0.LPCB.LNKF._PRS)
000032b3:           ArgCount 0; Serialized
000032b4:           Return
000032b5:             <NULL>
000032b9:         Method _CRS (\_SB_.PCI0.LPCB.LNKF._CRS)
000032bf:           ArgCount 0; Serialized
000032c0:           Name RTLF (\_SB_.PCI0.LPCB.LNKF._CRS.RTLF)
000032c5:             Buffer
000032c7:               0x06
000032c9:               ByteList <0x23 0x00 0x00 0x18 0x79 0x00>
000032c9:               Interpreted as PnP Resource Descriptor:
000032c9:               IRQ mask: 0000000000000000
000032c9:               Info: shareable, low true level sensitive
000032c9:               Bad checksum 0xb4, should be 0
000032c9:               
000032cf:           CreateWordField
000032d0:             RTLF (000032c0)
000032d4:             0x01
000032d6:             IRQ0
000032da:           Store
000032db:             ZeroOp
000032dc:             IRQ0
000032e0:           ShiftLeft
000032e1:             0x01
000032e3:             And
000032e4:               PIRF (00002ed6)
000032e8:               0x0f
000032ea:               <NULL>
000032eb:             IRQ0
000032ef:           Return
000032f0:             RTLF (000032c0)
000032f4:         Method _SRS (\_SB_.PCI0.LPCB.LNKF._SRS)
000032fa:           ArgCount 1; Serialized
000032fb:           CreateWordField
000032fc:             Arg0
000032fd:             0x01
000032ff:             IRQ0
00003303:           FindSetRightBit
00003304:             IRQ0
00003308:             Local0
00003309:           Decrement
0000330a:             Local0
0000330b:           Store
0000330c:             Local0
0000330d:             PIRF (00002ed6)
00003311:         Method _STA (\_SB_.PCI0.LPCB.LNKF._STA)
00003317:           ArgCount 0; Serialized
00003318:           If
0000331a:             And
0000331b:               PIRF (00002ed6)
0000331f:               0x80
00003321:               <NULL>
00003322:             Return
00003323:               0x09
00003325:           Else
00003327:             Return
00003328:               0x0b
0000332a:       Device LNKG (\_SB_.PCI0.LPCB.LNKG)
00003332:         Name _HID (\_SB_.PCI0.LPCB.LNKG._HID)
00003337:           PNP0c0f (0x0f0cd041)
0000333c:         Name _UID (\_SB_.PCI0.LPCB.LNKG._UID)
00003341:           0x07
00003343:         Method _DIS (\_SB_.PCI0.LPCB.LNKG._DIS)
00003349:           ArgCount 0; Serialized
0000334a:           Store
0000334b:             0x80
0000334d:             PIRG (00002edb)
00003351:         Method _PRS (\_SB_.PCI0.LPCB.LNKG._PRS)
00003357:           ArgCount 0; Serialized
00003358:           Return
00003359:             <NULL>
0000335d:         Method _CRS (\_SB_.PCI0.LPCB.LNKG._CRS)
00003363:           ArgCount 0; Serialized
00003364:           Name RTLG (\_SB_.PCI0.LPCB.LNKG._CRS.RTLG)
00003369:             Buffer
0000336b:               0x06
0000336d:               ByteList <0x23 0x00 0x00 0x18 0x79 0x00>
0000336d:               Interpreted as PnP Resource Descriptor:
0000336d:               IRQ mask: 0000000000000000
0000336d:               Info: shareable, low true level sensitive
0000336d:               Bad checksum 0xb4, should be 0
0000336d:               
00003373:           CreateWordField
00003374:             RTLG (00003364)
00003378:             0x01
0000337a:             IRQ0
0000337e:           Store
0000337f:             ZeroOp
00003380:             IRQ0
00003384:           ShiftLeft
00003385:             0x01
00003387:             And
00003388:               PIRG (00002edb)
0000338c:               0x0f
0000338e:               <NULL>
0000338f:             IRQ0
00003393:           Return
00003394:             RTLG (00003364)
00003398:         Method _SRS (\_SB_.PCI0.LPCB.LNKG._SRS)
0000339e:           ArgCount 1; Serialized
0000339f:           CreateWordField
000033a0:             Arg0
000033a1:             0x01
000033a3:             IRQ0
000033a7:           FindSetRightBit
000033a8:             IRQ0
000033ac:             Local0
000033ad:           Decrement
000033ae:             Local0
000033af:           Store
000033b0:             Local0
000033b1:             PIRG (00002edb)
000033b5:         Method _STA (\_SB_.PCI0.LPCB.LNKG._STA)
000033bb:           ArgCount 0; Serialized
000033bc:           If
000033be:             And
000033bf:               PIRG (00002edb)
000033c3:               0x80
000033c5:               <NULL>
000033c6:             Return
000033c7:               0x09
000033c9:           Else
000033cb:             Return
000033cc:               0x0b
000033ce:       Device LNKH (\_SB_.PCI0.LPCB.LNKH)
000033d6:         Name _HID (\_SB_.PCI0.LPCB.LNKH._HID)
000033db:           PNP0c0f (0x0f0cd041)
000033e0:         Name _UID (\_SB_.PCI0.LPCB.LNKH._UID)
000033e5:           0x08
000033e7:         Method _DIS (\_SB_.PCI0.LPCB.LNKH._DIS)
000033ed:           ArgCount 0; Serialized
000033ee:           Store
000033ef:             0x80
000033f1:             PIRH (00002ee0)
000033f5:         Method _PRS (\_SB_.PCI0.LPCB.LNKH._PRS)
000033fb:           ArgCount 0; Serialized
000033fc:           Return
000033fd:             <NULL>
00003401:         Method _CRS (\_SB_.PCI0.LPCB.LNKH._CRS)
00003407:           ArgCount 0; Serialized
00003408:           Name RTLH (\_SB_.PCI0.LPCB.LNKH._CRS.RTLH)
0000340d:             Buffer
0000340f:               0x06
00003411:               ByteList <0x23 0x00 0x00 0x18 0x79 0x00>
00003411:               Interpreted as PnP Resource Descriptor:
00003411:               IRQ mask: 0000000000000000
00003411:               Info: shareable, low true level sensitive
00003411:               Bad checksum 0xb4, should be 0
00003411:               
00003417:           CreateWordField
00003418:             RTLH (00003408)
0000341c:             0x01
0000341e:             IRQ0
00003422:           Store
00003423:             ZeroOp
00003424:             IRQ0
00003428:           ShiftLeft
00003429:             0x01
0000342b:             And
0000342c:               PIRH (00002ee0)
00003430:               0x0f
00003432:               <NULL>
00003433:             IRQ0
00003437:           Return
00003438:             RTLH (00003408)
0000343c:         Method _SRS (\_SB_.PCI0.LPCB.LNKH._SRS)
00003442:           ArgCount 1; Serialized
00003443:           CreateWordField
00003444:             Arg0
00003445:             0x01
00003447:             IRQ0
0000344b:           FindSetRightBit
0000344c:             IRQ0
00003450:             Local0
00003451:           Decrement
00003452:             Local0
00003453:           Store
00003454:             Local0
00003455:             PIRH (00002ee0)
00003459:         Method _STA (\_SB_.PCI0.LPCB.LNKH._STA)
0000345f:           ArgCount 0; Serialized
00003460:           If
00003462:             And
00003463:               PIRH (00002ee0)
00003467:               0x80
00003469:               <NULL>
0000346a:             Return
0000346b:               0x09
0000346d:           Else
0000346f:             Return
00003470:               0x0b
00003472:       Device TIMR (\_SB_.PCI0.LPCB.TIMR)
0000347a:         Name _HID (\_SB_.PCI0.LPCB.TIMR._HID)
0000347f:           PNP0100 (0x0001d041)
00003484:         Name BUF0 (\_SB_.PCI0.LPCB.TIMR.BUF0)
00003489:           Buffer
0000348b:             0x12
0000348d:             ByteList <0x47 0x01 0x40 0x00 0x40 0x00 0x01 0x04 
0000348d:             	      0x47 0x01 0x50 0x00 0x50 0x00 0x10 0x04 
0000348d:             	      0x79 0x00>
0000348d:             Interpreted as PnP Resource Descriptor:
0000348d:             I/O Ports: 16 bit address decoding,
0000348d:             minbase 0x40, maxbase 0x40, align 0x1, count 0x4
0000348d:             I/O Ports: 16 bit address decoding,
0000348d:             minbase 0x50, maxbase 0x50, align 0x10, count 0x4
0000348d:             Bad checksum 0x42, should be 0
0000348d:             
0000349f:         Name BUF1 (\_SB_.PCI0.LPCB.TIMR.BUF1)
000034a4:           Buffer
000034a6:             0x15
000034a8:             ByteList <0x47 0x01 0x40 0x00 0x40 0x00 0x01 0x04 
000034a8:             	      0x47 0x01 0x50 0x00 0x50 0x00 0x10 0x04 
000034a8:             	      0x22 0x01 0x00 0x79 0x00>
000034a8:             Interpreted as PnP Resource Descriptor:
000034a8:             I/O Ports: 16 bit address decoding,
000034a8:             minbase 0x40, maxbase 0x40, align 0x1, count 0x4
000034a8:             I/O Ports: 16 bit address decoding,
000034a8:             minbase 0x50, maxbase 0x50, align 0x10, count 0x4
000034a8:             IRQ mask: 0000000000000010
000034a8:             Info: high true edge sensitive
000034a8:             Bad checksum 0x65, should be 0
000034a8:             
000034bd:         Method _CRS (\_SB_.PCI0.LPCB.TIMR._CRS)
000034c3:           ArgCount 0; Serialized
000034c4:           If
000034c6:             And
000034c7:               HPTE (00002ee8)
000034cb:               0x00020000
000034d0:               <NULL>
000034d1:             Return
000034d2:               BUF0 (00003484)
000034d6:           Return
000034d7:             BUF1 (0000349f)
000034db:       Device IPIC (\_SB_.PCI0.LPCB.IPIC)
000034e3:         Name _HID (\_SB_.PCI0.LPCB.IPIC._HID)
000034e8:           PNP0000 (0x0000d041)
000034eb:         Name _CRS (\_SB_.PCI0.LPCB.IPIC._CRS)
000034f0:           Buffer
000034f3:             0x8d
000034f5:             ByteList <0x47 0x01 0x20 0x00 0x20 0x00 0x01 0x02 
000034f5:             	      0x47 0x01 0x24 0x00 0x24 0x00 0x01 0x02 
000034f5:             	      0x47 0x01 0x28 0x00 0x28 0x00 0x01 0x02 
000034f5:             	      0x47 0x01 0x2c 0x00 0x2c 0x00 0x01 0x02 
000034f5:             	      0x47 0x01 0x30 0x00 0x30 0x00 0x01 0x02 
000034f5:             	      0x47 0x01 0x34 0x00 0x34 0x00 0x01 0x02 
000034f5:             	      0x47 0x01 0x38 0x00 0x38 0x00 0x01 0x02 
000034f5:             	      0x47 0x01 0x3c 0x00 0x3c 0x00 0x01 0x02 
000034f5:             	      0x47 0x01 0xa0 0x00 0xa0 0x00 0x01 0x02 
000034f5:             	      0x47 0x01 0xa4 0x00 0xa4 0x00 0x01 0x02 
000034f5:             	      0x47 0x01 0xa8 0x00 0xa8 0x00 0x01 0x02 
000034f5:             	      0x47 0x01 0xac 0x00 0xac 0x00 0x01 0x02 
000034f5:             	      0x47 0x01 0xb0 0x00 0xb0 0x00 0x01 0x02 
000034f5:             	      0x47 0x01 0xb4 0x00 0xb4 0x00 0x01 0x02 
000034f5:             	      0x47 0x01 0xb8 0x00 0xb8 0x00 0x01 0x02 
000034f5:             	      0x47 0x01 0xbc 0x00 0xbc 0x00 0x01 0x02 
000034f5:             	      0x47 0x01 0xd0 0x04 0xd0 0x04 0x01 0x02 
000034f5:             	      0x22 0x04 0x00 0x79 0x00>
000034f5:             Interpreted as PnP Resource Descriptor:
000034f5:             I/O Ports: 16 bit address decoding,
000034f5:             minbase 0x20, maxbase 0x20, align 0x1, count 0x2
000034f5:             I/O Ports: 16 bit address decoding,
000034f5:             minbase 0x24, maxbase 0x24, align 0x1, count 0x2
000034f5:             I/O Ports: 16 bit address decoding,
000034f5:             minbase 0x28, maxbase 0x28, align 0x1, count 0x2
000034f5:             I/O Ports: 16 bit address decoding,
000034f5:             minbase 0x2c, maxbase 0x2c, align 0x1, count 0x2
000034f5:             I/O Ports: 16 bit address decoding,
000034f5:             minbase 0x30, maxbase 0x30, align 0x1, count 0x2
000034f5:             I/O Ports: 16 bit address decoding,
000034f5:             minbase 0x34, maxbase 0x34, align 0x1, count 0x2
000034f5:             I/O Ports: 16 bit address decoding,
000034f5:             minbase 0x38, maxbase 0x38, align 0x1, count 0x2
000034f5:             I/O Ports: 16 bit address decoding,
000034f5:             minbase 0x3c, maxbase 0x3c, align 0x1, count 0x2
000034f5:             I/O Ports: 16 bit address decoding,
000034f5:             minbase 0xa0, maxbase 0xa0, align 0x1, count 0x2
000034f5:             I/O Ports: 16 bit address decoding,
000034f5:             minbase 0xa4, maxbase 0xa4, align 0x1, count 0x2
000034f5:             I/O Ports: 16 bit address decoding,
000034f5:             minbase 0xa8, maxbase 0xa8, align 0x1, count 0x2
000034f5:             I/O Ports: 16 bit address decoding,
000034f5:             minbase 0xac, maxbase 0xac, align 0x1, count 0x2
000034f5:             I/O Ports: 16 bit address decoding,
000034f5:             minbase 0xb0, maxbase 0xb0, align 0x1, count 0x2
000034f5:             I/O Ports: 16 bit address decoding,
000034f5:             minbase 0xb4, maxbase 0xb4, align 0x1, count 0x2
000034f5:             I/O Ports: 16 bit address decoding,
000034f5:             minbase 0xb8, maxbase 0xb8, align 0x1, count 0x2
000034f5:             I/O Ports: 16 bit address decoding,
000034f5:             minbase 0xbc, maxbase 0xbc, align 0x1, count 0x2
000034f5:             I/O Ports: 16 bit address decoding,
000034f5:             minbase 0x4d0, maxbase 0x4d0, align 0x1, count 0x2
000034f5:             IRQ mask: 0000000000001000
000034f5:             Info: high true edge sensitive
000034f5:             Bad checksum 0x2, should be 0
000034f5:             
00003582:       Device RTC_ (\_SB_.PCI0.LPCB.RTC_)
0000358a:         Name _HID (\_SB_.PCI0.LPCB.RTC_._HID)
0000358f:           PNP0b00 (0x000bd041)
00003594:         Name BUF0 (\_SB_.PCI0.LPCB.RTC_.BUF0)
00003599:           Buffer
0000359b:             0x0a
0000359d:             ByteList <0x47 0x01 0x70 0x00 0x70 0x00 0x01 0x08 
0000359d:             	      0x79 0x00>
0000359d:             Interpreted as PnP Resource Descriptor:
0000359d:             I/O Ports: 16 bit address decoding,
0000359d:             minbase 0x70, maxbase 0x70, align 0x1, count 0x8
0000359d:             Bad checksum 0xaa, should be 0
0000359d:             
000035a7:         Name BUF1 (\_SB_.PCI0.LPCB.RTC_.BUF1)
000035ac:           Buffer
000035ae:             0x0d
000035b0:             ByteList <0x47 0x01 0x70 0x00 0x70 0x00 0x01 0x08 
000035b0:             	      0x22 0x00 0x01 0x79 0x00>
000035b0:             Interpreted as PnP Resource Descriptor:
000035b0:             I/O Ports: 16 bit address decoding,
000035b0:             minbase 0x70, maxbase 0x70, align 0x1, count 0x8
000035b0:             IRQ mask: 0000001000000000
000035b0:             Info: high true edge sensitive
000035b0:             Bad checksum 0xcd, should be 0
000035b0:             
000035bd:         Method _CRS (\_SB_.PCI0.LPCB.RTC_._CRS)
000035c3:           ArgCount 0; Serialized
000035c4:           If
000035c6:             And
000035c7:               HPTE (00002ee8)
000035cb:               0x00020000
000035d0:               <NULL>
000035d1:             Return
000035d2:               BUF0 (00003594)
000035d6:           Return
000035d7:             BUF1 (000035a7)
000035db:       Device MATH (\_SB_.PCI0.LPCB.MATH)
000035e2:         Name _HID (\_SB_.PCI0.LPCB.MATH._HID)
000035e7:           PNP0c04 (0x040cd041)
000035ec:         Name _CRS (\_SB_.PCI0.LPCB.MATH._CRS)
000035f1:           Buffer
000035f3:             0x0d
000035f5:             ByteList <0x47 0x01 0xf0 0x00 0xf0 0x00 0x01 0x01 
000035f5:             	      0x22 0x00 0x20 0x79 0x00>
000035f5:             Interpreted as PnP Resource Descriptor:
000035f5:             I/O Ports: 16 bit address decoding,
000035f5:             minbase 0xf0, maxbase 0xf0, align 0x1, count 0x1
000035f5:             IRQ mask: 0100000000000000
000035f5:             Info: high true edge sensitive
000035f5:             Bad checksum 0xe5, should be 0
000035f5:             
00003602:       Device DMAC (\_SB_.PCI0.LPCB.DMAC)
0000360a:         Name _HID (\_SB_.PCI0.LPCB.DMAC._HID)
0000360f:           PNP0200 (0x0002d041)
00003614:         Name _CRS (\_SB_.PCI0.LPCB.DMAC._CRS)
00003619:           Buffer
0000361b:             0x2d
0000361d:             ByteList <0x47 0x01 0x00 0x00 0x00 0x00 0x01 0x20 
0000361d:             	      0x47 0x01 0x81 0x00 0x81 0x00 0x01 0x0f 
0000361d:             	      0x47 0x01 0x90 0x00 0x90 0x00 0x01 0x02 
0000361d:             	      0x47 0x01 0x93 0x00 0x93 0x00 0x01 0x0d 
0000361d:             	      0x47 0x01 0xc0 0x00 0xc0 0x00 0x01 0x20 
0000361d:             	      0x2a 0x10 0x01 0x79 0x00>
0000361d:             Interpreted as PnP Resource Descriptor:
0000361d:             I/O Ports: 16 bit address decoding,
0000361d:             minbase 0x0, maxbase 0x0, align 0x1, count 0x20
0000361d:             I/O Ports: 16 bit address decoding,
0000361d:             minbase 0x81, maxbase 0x81, align 0x1, count 0xf
0000361d:             I/O Ports: 16 bit address decoding,
0000361d:             minbase 0x90, maxbase 0x90, align 0x1, count 0x2
0000361d:             I/O Ports: 16 bit address decoding,
0000361d:             minbase 0x93, maxbase 0x93, align 0x1, count 0xd
0000361d:             I/O Ports: 16 bit address decoding,
0000361d:             minbase 0xc0, maxbase 0xc0, align 0x1, count 0x20
0000361d:             DMA mask: 00100000
0000361d:             DMA channel speed: compatibility mode; transfer type: 8/16 bit
0000361d:             Bad checksum 0x47, should be 0
0000361d:             
0000364a:       Device MBRD (\_SB_.PCI0.LPCB.MBRD)
00003652:         Name _HID (\_SB_.PCI0.LPCB.MBRD._HID)
00003657:           PNP0c02 (0x020cd041)
0000365c:         Name _CRS (\_SB_.PCI0.LPCB.MBRD._CRS)
00003661:           Buffer
00003664:             0x76
00003666:             ByteList <0x47 0x01 0x2e 0x00 0x2e 0x00 0x01 0x02 
00003666:             	      0x47 0x01 0x61 0x00 0x61 0x00 0x01 0x01 
00003666:             	      0x47 0x01 0x63 0x00 0x63 0x00 0x01 0x01 
00003666:             	      0x47 0x01 0x65 0x00 0x65 0x00 0x01 0x01 
00003666:             	      0x47 0x01 0x67 0x00 0x67 0x00 0x01 0x01 
00003666:             	      0x47 0x01 0x80 0x00 0x80 0x00 0x01 0x01 
00003666:             	      0x47 0x01 0x92 0x00 0x92 0x00 0x01 0x01 
00003666:             	      0x47 0x01 0xb2 0x00 0xb2 0x00 0x01 0x02 
00003666:             	      0x47 0x01 0x00 0x06 0x00 0x06 0x01 0x10 
00003666:             	      0x47 0x01 0x00 0x07 0x00 0x07 0x01 0x10 
00003666:             	      0x47 0x01 0x00 0x08 0x00 0x08 0x01 0x10 
00003666:             	      0x47 0x01 0x00 0x10 0x00 0x10 0x01 0x80 
00003666:             	      0x47 0x01 0x80 0x11 0x80 0x11 0x01 0x40 
00003666:             	      0x86 0x09 0x00 0x01 0x00 0x00 0xc1 0xfe 
00003666:             	      0x00 0x00 0x01 0x00 0x79 0x00>
00003666:             Interpreted as PnP Resource Descriptor:
00003666:             I/O Ports: 16 bit address decoding,
00003666:             minbase 0x2e, maxbase 0x2e, align 0x1, count 0x2
00003666:             I/O Ports: 16 bit address decoding,
00003666:             minbase 0x61, maxbase 0x61, align 0x1, count 0x1
00003666:             I/O Ports: 16 bit address decoding,
00003666:             minbase 0x63, maxbase 0x63, align 0x1, count 0x1
00003666:             I/O Ports: 16 bit address decoding,
00003666:             minbase 0x65, maxbase 0x65, align 0x1, count 0x1
00003666:             I/O Ports: 16 bit address decoding,
00003666:             minbase 0x67, maxbase 0x67, align 0x1, count 0x1
00003666:             I/O Ports: 16 bit address decoding,
00003666:             minbase 0x80, maxbase 0x80, align 0x1, count 0x1
00003666:             I/O Ports: 16 bit address decoding,
00003666:             minbase 0x92, maxbase 0x92, align 0x1, count 0x1
00003666:             I/O Ports: 16 bit address decoding,
00003666:             minbase 0xb2, maxbase 0xb2, align 0x1, count 0x2
00003666:             I/O Ports: 16 bit address decoding,
00003666:             minbase 0x600, maxbase 0x600, align 0x1, count 0x10
00003666:             I/O Ports: 16 bit address decoding,
00003666:             minbase 0x700, maxbase 0x700, align 0x1, count 0x10
00003666:             I/O Ports: 16 bit address decoding,
00003666:             minbase 0x800, maxbase 0x800, align 0x1, count 0x10
00003666:             I/O Ports: 16 bit address decoding,
00003666:             minbase 0x1000, maxbase 0x1000, align 0x1, count 0x80
00003666:             I/O Ports: 16 bit address decoding,
00003666:             minbase 0x1180, maxbase 0x1180, align 0x1, count 0x40
00003666:             32-bit rw Fixed memory range:
00003666:             base 0xfec10000, count 0x10000
00003666:             Bad checksum 0xe8, should be 0
00003666:             
000036dc:       Device FWHD (\_SB_.PCI0.LPCB.FWHD)
000036e3:         Name _HID (\_SB_.PCI0.LPCB.FWHD._HID)
000036e8:           INT0800 (0x0008d425)
000036ed:         Name _CRS (\_SB_.PCI0.LPCB.FWHD._CRS)
000036f2:           Buffer
000036f4:             0x0e
000036f6:             ByteList <0x86 0x09 0x00 0x00 0x00 0x00 0x80 0xff 
000036f6:             	      0x00 0x00 0x80 0x00 0x79 0x00>
000036f6:             Interpreted as PnP Resource Descriptor:
000036f6:             32-bit ro Fixed memory range:
000036f6:             base 0xff800000, count 0x800000
000036f6:             Bad checksum 0x7, should be 0
000036f6:             
00003704:       Device HPET (\_SB_.PCI0.LPCB.HPET)
0000370c:         Name _HID (\_SB_.PCI0.LPCB.HPET._HID)
00003711:           PNP0103 (0x0301d041)
00003716:         Name BUF0 (\_SB_.PCI0.LPCB.HPET.BUF0)
0000371b:           Buffer
0000371d:             0x14
0000371f:             ByteList <0x22 0x01 0x00 0x22 0x00 0x01 0x86 0x09 
0000371f:             	      0x00 0x00 0x00 0x00 0xd0 0xfe 0x00 0x04 
0000371f:             	      0x00 0x00 0x79 0x00>
0000371f:             Interpreted as PnP Resource Descriptor:
0000371f:             IRQ mask: 0000000000000010
0000371f:             Info: high true edge sensitive
0000371f:             IRQ mask: 0000001000000000
0000371f:             Info: high true edge sensitive
0000371f:             32-bit ro Fixed memory range:
0000371f:             base 0xfed00000, count 0x400
0000371f:             Bad checksum 0x20, should be 0
0000371f:             
00003733:         Method _STA (\_SB_.PCI0.LPCB.HPET._STA)
00003739:           ArgCount 0; NotSerialized
0000373a:           ShiftRight
0000373b:             And
0000373c:               HPTE (00002ee8)
00003740:               0x00038000
00003745:               <NULL>
00003746:             0x0f
00003748:             Local0
00003749:           If
0000374b:             LEqual
0000374c:               OSYS (0000017a)
00003750:               0x07d1
00003753:             If
00003755:               And
00003756:                 Local0
00003757:                 0x04
00003759:                 <NULL>
0000375a:               Return
0000375b:                 0x0f
0000375d:           Else
0000375f:             If
00003761:               And
00003762:                 Local0
00003763:                 0x04
00003765:                 <NULL>
00003766:               Return
00003767:                 0x0b
00003769:           Return
0000376a:             0x00
0000376c:         Method _CRS (\_SB_.PCI0.LPCB.HPET._CRS)
00003773:           ArgCount 0; Serialized
00003774:           ShiftRight
00003775:             And
00003776:               HPTE (00002ee8)
0000377a:               0x00038000
0000377f:               <NULL>
00003780:             0x0f
00003782:             Local0
00003783:           If
00003786:             And
00003787:               Local0
00003788:               0x04
0000378a:               <NULL>
0000378b:             CreateDWordField
0000378c:               BUF0 (00003716)
00003790:               0x0a
00003792:               HPT0
00003796:             If
00003798:               LEqual
00003799:                 Local0
0000379a:                 0x05
0000379c:               Store
0000379d:                 0xfed01000
000037a2:                 HPT0
000037a6:             If
000037a8:               LEqual
000037a9:                 Local0
000037aa:                 0x06
000037ac:               Store
000037ad:                 0xfed02000
000037b2:                 HPT0
000037b6:             If
000037b8:               LEqual
000037b9:                 Local0
000037ba:                 0x07
000037bc:               Store
000037bd:                 0xfed03000
000037c2:                 HPT0
000037c6:           Return
000037c7:             BUF0 (00003716)
000037cb:       Device H_EC (\_SB_.PCI0.LPCB.H_EC)
000037d3:         Name _HID (\_SB_.PCI0.LPCB.H_EC._HID)
000037d8:           PNP0c09 (0x090cd041)
000037dd:         Name _UID (\_SB_.PCI0.LPCB.H_EC._UID)
000037e2:           0x01
000037e4:         Method _CRS (\_SB_.PCI0.LPCB.H_EC._CRS)
000037ea:           ArgCount 0; NotSerialized
000037eb:           Name BFFR (\_SB_.PCI0.LPCB.H_EC._CRS.BFFR)
000037f0:             Buffer
000037f2:               0x12
000037f4:               ByteList <0x47 0x01 0x62 0x00 0x62 0x00 0x00 0x01 
000037f4:               	      0x47 0x01 0x66 0x00 0x66 0x00 0x00 0x01 
000037f4:               	      0x79 0x00>
000037f4:               Interpreted as PnP Resource Descriptor:
000037f4:               I/O Ports: 16 bit address decoding,
000037f4:               minbase 0x62, maxbase 0x62, align 0x0, count 0x1
000037f4:               I/O Ports: 16 bit address decoding,
000037f4:               minbase 0x66, maxbase 0x66, align 0x0, count 0x1
000037f4:               Bad checksum 0x9b, should be 0
000037f4:               
00003806:           Return
00003807:             BFFR (000037eb)
0000380b:         OpRegion ECR_ (\_SB_.PCI0.LPCB.H_EC.ECR_)
00003811:           EmbeddedControl
00003812:           0x00
00003814:           0xff
00003816:         Field
0000381a:           ECR_ (0000380b)
0000381e:           AccessType: DWordAcc; LockRule: Lock; UpdateRule: Preserve
0000381f:           ReservedField
00003822:           NamedField B1EX
00003827:           NamedField B2EX
0000382c:           NamedField ACEX
00003831:           ReservedField
00003833:           NamedField SWBE
00003838:           NamedField DCBE
0000383d:           ReservedField
0000383f:           ReservedField
00003841:           NamedField LIDI
00003846:           ReservedField
00003848:           NamedField LIDE
0000384d:           ReservedField
0000384f:           NamedField B1ST
00003854:           NamedField B2ST
00003859:           ReservedField
0000385c:           NamedField B1RR
00003861:           NamedField B1PV
00003866:           NamedField B2RR
0000386b:           NamedField B2PV
00003870:           NamedField B1AF
00003875:           NamedField B1VL
0000387a:           NamedField B2AF
0000387f:           NamedField B2VL
00003884:           NamedField CTMP
00003889:           ReservedField
0000388b:           NamedField LTMP
00003890:           ReservedField
00003892:           NamedField TZF4
00003897:           NamedField TZF5
0000389c:           ReservedField
0000389e:           NamedField B1TI
000038a3:           NamedField B1SE
000038a8:           NamedField B1CR
000038ad:           NamedField B1TM
000038b2:           NamedField B2TI
000038b7:           NamedField B2SE
000038bc:           NamedField B2CR
000038c1:           NamedField B2TM
000038c6:         Method _REG (\_SB_.PCI0.LPCB.H_EC._REG)
000038cd:           ArgCount 2; NotSerialized
000038ce:           If
000038d1:             LAnd
000038d2:               LEqual
000038d3:                 Arg0
000038d4:                 0x03
000038d6:               LEqual
000038d7:                 Arg1
000038d8:                 0x01
000038da:             Store
000038db:               0x01
000038dd:               ECON (000003ce)
000038e1:             If
000038e3:               LNotEqual
000038e5:                 LIDS (000001c5)
000038e9:                 LIDI (00003841)
000038ed:               Store
000038ee:                 LIDI (00003841)
000038f2:                 LIDS (000001c5)
000038f6:               If
000038f8:                 IGDS (0000022d)
000038fc:                 <NULL>
00003900:                 LIDS (000001c5)
00003904:               Else
00003906:                 Store
00003907:                   0x2a
00003909:                   SMIF (0000017f)
0000390d:                 Store
0000390e:                   0x00
00003910:                   TRP0 (00000031)
00003914:               Notify
00003915:                 \_SB_.LID0 (00001ee8)
0000391f:                 0x80
00003921:             If
00003923:               LNotEqual
00003925:                 ACEX (0000382c)
00003929:                 PWRS (000001ca)
0000392d:               Store
0000392e:                 ACEX (0000382c)
00003932:                 PWRS (000001ca)
00003936:               Store
00003937:                 0x2b
00003939:                 SMIF (0000017f)
0000393d:               Store
0000393e:                 0x00
00003940:                 TRP0 (00000031)
00003944:               Notify
00003945:                 \_SB_.BAT1 (0000139e)
0000394f:                 0x80
00003951:               Notify
00003952:                 \_SB_.BAT2 (00001943)
0000395c:                 0x80
0000395e:           If
00003960:             LEqual
00003961:               <NULL>
00003970:               0x0f
00003972:             Store
00003973:               OneOp
00003974:               \_SB_.MEDB.DCST (00000ffb)
00003983:           Else
00003985:             Store
00003986:               ZeroOp
00003987:               \_SB_.MEDB.DCST (00000ffb)
00003996:         Name _GPE (\_SB_.PCI0.LPCB.H_EC._GPE)
0000399b:           0x1c
0000399d:         Method _Q50 (\_SB_.PCI0.LPCB.H_EC._Q50)
000039a3:           ArgCount 0; NotSerialized
000039a4:           Notify
000039a5:             \_SB_.PWRB (00001fa1)
000039af:             0x80
000039b1:         Method _Q51 (\_SB_.PCI0.LPCB.H_EC._Q51)
000039b7:           ArgCount 0; NotSerialized
000039b8:           <NULL>
000039c2:           0x82
000039c4:           Store
000039c5:             0x01
000039c7:             \PWRS (000001ca)
000039cc:           Notify
000039cd:             \_SB_.ADP1 (000012b0)
000039d7:             0x80
000039d9:         Method _Q52 (\_SB_.PCI0.LPCB.H_EC._Q52)
000039df:           ArgCount 0; NotSerialized
000039e0:           <NULL>
000039ea:           0x82
000039ec:           Store
000039ed:             0x00
000039ef:             \PWRS (000001ca)
000039f4:           Notify
000039f5:             \_SB_.ADP1 (000012b0)
000039ff:             0x80
00003a01:         Method _Q53 (\_SB_.PCI0.LPCB.H_EC._Q53)
00003a08:           ArgCount 0; NotSerialized
00003a09:           Notify
00003a0a:             \_SB_.BAT1 (0000139e)
00003a14:             0x01
00003a16:           Notify
00003a17:             \_SB_.BAT1 (0000139e)
00003a21:             0x81
00003a23:           Sleep
00003a25:             0x01f4
00003a28:           Notify
00003a29:             \_SB_.PCI0.USB0 (00005262)
00003a38:             0x00
00003a3a:           Notify
00003a3b:             \_SB_.PCI0.USB1 (0000529d)
00003a4a:             0x00
00003a4c:           Notify
00003a4d:             \_SB_.PCI0.USB2 (000052e9)
00003a5c:             0x00
00003a5e:         Method _Q54 (\_SB_.PCI0.LPCB.H_EC._Q54)
00003a65:           ArgCount 0; NotSerialized
00003a66:           Notify
00003a67:             \_SB_.BAT1 (0000139e)
00003a71:             0x01
00003a73:           Notify
00003a74:             \_SB_.BAT1 (0000139e)
00003a7e:             0x81
00003a80:           Sleep
00003a82:             0x01f4
00003a85:           Notify
00003a86:             \_SB_.PCI0.USB0 (00005262)
00003a95:             0x00
00003a97:           Notify
00003a98:             \_SB_.PCI0.USB1 (0000529d)
00003aa7:             0x00
00003aa9:           Notify
00003aaa:             \_SB_.PCI0.USB2 (000052e9)
00003ab9:             0x00
00003abb:         Method _Q55 (\_SB_.PCI0.LPCB.H_EC._Q55)
00003ac2:           ArgCount 0; NotSerialized
00003ac3:           Notify
00003ac4:             \_SB_.BAT2 (00001943)
00003ace:             0x01
00003ad0:           Notify
00003ad1:             \_SB_.BAT2 (00001943)
00003adb:             0x81
00003add:           Sleep
00003adf:             0x01f4
00003ae2:           Notify
00003ae3:             \_SB_.PCI0.USB0 (00005262)
00003af2:             0x00
00003af4:           Notify
00003af5:             \_SB_.PCI0.USB1 (0000529d)
00003b04:             0x00
00003b06:           Notify
00003b07:             \_SB_.PCI0.USB2 (000052e9)
00003b16:             0x00
00003b18:         Method _Q56 (\_SB_.PCI0.LPCB.H_EC._Q56)
00003b1f:           ArgCount 0; NotSerialized
00003b20:           Notify
00003b21:             \_SB_.BAT2 (00001943)
00003b2b:             0x01
00003b2d:           Notify
00003b2e:             \_SB_.BAT2 (00001943)
00003b38:             0x81
00003b3a:           Sleep
00003b3c:             0x01f4
00003b3f:           Notify
00003b40:             \_SB_.PCI0.USB0 (00005262)
00003b4f:             0x00
00003b51:           Notify
00003b52:             \_SB_.PCI0.USB1 (0000529d)
00003b61:             0x00
00003b63:           Notify
00003b64:             \_SB_.PCI0.USB2 (000052e9)
00003b73:             0x00
00003b75:         Method _Q58 (\_SB_.PCI0.LPCB.H_EC._Q58)
00003b7b:           ArgCount 0; NotSerialized
00003b7c:           Notify
00003b7d:             \_SB_.MEDB (00000fca)
00003b87:             0x01
00003b89:         Method _Q5B (\_SB_.PCI0.LPCB.H_EC._Q5B)
00003b8f:           ArgCount 0; NotSerialized
00003b90:           Notify
00003b91:             \_SB_.SLPB (00001f86)
00003b9b:             0x80
00003b9d:         Method _Q5D (\_SB_.PCI0.LPCB.H_EC._Q5D)
00003ba3:           ArgCount 0; NotSerialized
00003ba4:           If
00003ba6:             IGDS (0000022d)
00003baa:             Store
00003bab:               0x01
00003bad:               TLST (00000237)
00003bb1:             <NULL>
00003bb5:             0x0a
00003bb7:         Method _Q5E (\_SB_.PCI0.LPCB.H_EC._Q5E)
00003bbe:           ArgCount 0; NotSerialized
00003bbf:           Store
00003bc0:             LIDI (00003841)
00003bc4:             LIDS (000001c5)
00003bc8:           If
00003bca:             IGDS (0000022d)
00003bce:             <NULL>
00003bd2:             LIDS (000001c5)
00003bd6:           Else
00003bd8:             Store
00003bd9:               0x2a
00003bdb:               SMIF (0000017f)
00003bdf:             Store
00003be0:               0x00
00003be2:               TRP0 (00000031)
00003be6:           Sleep
00003be8:             0x01f4
00003beb:           Sleep
00003bed:             0x01f4
00003bf0:           Notify
00003bf1:             \_SB_.LID0 (00001ee8)
00003bfb:             0x80
00003bfd:         Method _Q5F (\_SB_.PCI0.LPCB.H_EC._Q5F)
00003c04:           ArgCount 0; NotSerialized
00003c05:           Store
00003c06:             LIDI (00003841)
00003c0a:             LIDS (000001c5)
00003c0e:           If
00003c10:             IGDS (0000022d)
00003c14:             <NULL>
00003c18:             LIDS (000001c5)
00003c1c:           Else
00003c1e:             Store
00003c1f:               0x2a
00003c21:               SMIF (0000017f)
00003c25:             Store
00003c26:               0x00
00003c28:               TRP0 (00000031)
00003c2c:           Sleep
00003c2e:             0x01f4
00003c31:           Sleep
00003c33:             0x01f4
00003c36:           Notify
00003c37:             \_SB_.LID0 (00001ee8)
00003c41:             0x80
00003c43:         Method _Q63 (\_SB_.PCI0.LPCB.H_EC._Q63)
00003c49:           ArgCount 0; NotSerialized
00003c4a:           <NULL>
00003c54:           0x9e
00003c56:         Method _Q64 (\_SB_.PCI0.LPCB.H_EC._Q64)
00003c5c:           ArgCount 0; NotSerialized
00003c5d:           <NULL>
00003c67:           0x9f
00003c69:         Method _Q65 (\_SB_.PCI0.LPCB.H_EC._Q65)
00003c6f:           ArgCount 0; NotSerialized
00003c70:           Notify
00003c71:             \_TZ_.THRM (00000d35)
00003c7b:             0x80
00003c7d:         Method _Q66 (\_SB_.PCI0.LPCB.H_EC._Q66)
00003c83:           ArgCount 0; NotSerialized
00003c84:           Notify
00003c85:             \_SB_.BAT1 (0000139e)
00003c8f:             0x80
00003c91:         Method _Q67 (\_SB_.PCI0.LPCB.H_EC._Q67)
00003c97:           ArgCount 0; NotSerialized
00003c98:           Notify
00003c99:             \_SB_.BAT2 (00001943)
00003ca3:             0x80
00003ca5:         Method _Q6C (\_SB_.PCI0.LPCB.H_EC._Q6C)
00003cab:           ArgCount 0; NotSerialized
00003cac:           <NULL>
00003cb6:           0xa0
00003cb8:         Method _Q6D (\_SB_.PCI0.LPCB.H_EC._Q6D)
00003cbf:           ArgCount 0; NotSerialized
00003cc0:           If
00003cc2:             LEqual
00003cc3:               TZF5 (00003897)
00003cc7:               OneOp
00003cc8:             Store
00003cc9:               0x05
00003ccb:               TZON (000001e5)
00003ccf:             <NULL>
00003cd3:           Else
00003cd5:             If
00003cd7:               LEqual
00003cd8:                 TZF4 (00003892)
00003cdc:                 OneOp
00003cdd:               Store
00003cde:                 0x04
00003ce0:                 TZON (000001e5)
00003ce4:               <NULL>
00003ce8:             Else
00003cea:               If
00003cec:                 LNotEqual
00003cee:                   TZON (000001e5)
00003cf2:                   ZeroOp
00003cf3:                 Store
00003cf4:                   0x00
00003cf6:                   TZON (000001e5)
00003cfa:                 <NULL>
00003cfe:       Device SIOD (\_SB_.PCI0.LPCB.SIOD)
00003d07:         Name _HID (\_SB_.PCI0.LPCB.SIOD._HID)
00003d0c:           PNP0a05 (0x050ad041)
00003d11:         OpRegion N393 (\_SB_.PCI0.LPCB.SIOD.N393)
00003d17:           SystemIO
00003d18:           0x2e
00003d1a:           0x02
00003d1c:         Field
00003d1f:           N393 (00003d11)
00003d23:           AccessType: ByteAcc; LockRule: NoLock; UpdateRule: Preserve
00003d24:           NamedField INDX
00003d29:           NamedField DATA
00003d2e:         Method SETD (\_SB_.PCI0.LPCB.SIOD.SETD)
00003d34:           ArgCount 1; Serialized
00003d35:           Store
00003d36:             0x07
00003d38:             INDX (00003d24)
00003d3c:           Stall
00003d3e:             0x32
00003d40:           Store
00003d41:             Arg0
00003d42:             DATA (00003d29)
00003d46:           Stall
00003d48:             0x32
00003d4a:         Method READ (\_SB_.PCI0.LPCB.SIOD.READ)
00003d50:           ArgCount 1; Serialized
00003d51:           Store
00003d52:             Arg0
00003d53:             INDX (00003d24)
00003d57:           Stall
00003d59:             0x32
00003d5b:           Store
00003d5c:             DATA (00003d29)
00003d60:             Local0
00003d61:           Stall
00003d63:             0x32
00003d65:           Return
00003d66:             Local0
00003d67:         Method WRIT (\_SB_.PCI0.LPCB.SIOD.WRIT)
00003d6d:           ArgCount 2; Serialized
00003d6e:           Store
00003d6f:             Arg0
00003d70:             INDX (00003d24)
00003d74:           Stall
00003d76:             0x32
00003d78:           Store
00003d79:             Arg1
00003d7a:             DATA (00003d29)
00003d7e:           Stall
00003d80:             0x32
00003d82:         Method LTST (\_SB_.PCI0.LPCB.SIOD.LTST)
00003d88:           ArgCount 0; NotSerialized
00003d89:           If
00003d8b:             LEqual
00003d8c:               OSYS (0000017a)
00003d90:               0x07d0
00003d93:             Return
00003d94:               0x0f
00003d96:           Else
00003d98:             Return
00003d99:               <NULL>
00003da8:         Device COMA (\_SB_.PCI0.LPCB.SIOD.COMA)
00003db0:           Name _HID (\_SB_.PCI0.LPCB.SIOD.COMA._HID)
00003db5:             PNP0501 (0x0105d041)
00003dba:           Name _EJD (\_SB_.PCI0.LPCB.SIOD.COMA._EJD)
00003dbf:             "\_SB.MEDB"
00003dca:           Method _STA (\_SB_.PCI0.LPCB.SIOD.COMA._STA)
00003dd0:             ArgCount 0; NotSerialized
00003dd1:             If
00003dd3:               LEqual
00003dd4:                 <NULL>
00003de3:                 ZeroOp
00003de4:               Return
00003de5:                 0x00
00003de7:             If
00003de9:               CMAP (000001d1)
00003ded:               <NULL>
00003df1:               0x03
00003df3:               If
00003df5:                 <NULL>
00003df9:                 0x30
00003dfb:                 Return
00003dfc:                   0x0f
00003dfe:               Return
00003dff:                 0x0d
00003e01:             Return
00003e02:               0x00
00003e04:           Method _DIS (\_SB_.PCI0.LPCB.SIOD.COMA._DIS)
00003e0a:             ArgCount 0; NotSerialized
00003e0b:             <NULL>
00003e0f:             0x03
00003e11:             <NULL>
00003e15:             0x30
00003e17:             0x00
00003e19:             And
00003e1a:               LDEN (00002efc)
00003e1e:               0xfe
00003e20:               LDEN (00002efc)
00003e24:           Method _CRS (\_SB_.PCI0.LPCB.SIOD.COMA._CRS)
00003e2b:             ArgCount 0; NotSerialized
00003e2c:             If
00003e2e:               LEqual
00003e2f:                 <NULL>
00003e3e:                 ZeroOp
00003e3f:               Name BUF1 (\_SB_.PCI0.LPCB.SIOD.COMA._CRS.)
00003e44:                 Buffer
00003e46:                   0x10
00003e48:                   ByteList <0x31 0x08 0x47 0x01 0x00 0x00 0x00 0x00 
00003e48:                   	      0x01 0x00 0x22 0x00 0x00 0x38 0x79 0x00>
00003e48:                   Interpreted as PnP Resource Descriptor:
00003e48:                   Start dependent functions
00003e48:                   good compatiblity; sub-optimal performance/robustness
00003e48:                   I/O Ports: 16 bit address decoding,
00003e48:                   minbase 0x0, maxbase 0x0, align 0x1, count 0x0
00003e48:                   IRQ mask: 0000000000000000
00003e48:                   Info: high true edge sensitive
00003e48:                   End dependent functions
00003e48:                   Bad checksum 0x55, should be 0
00003e48:                   
00003e58:               Return
00003e59:                 BUF1 (00003e3f)
00003e5d:             Name BUF0 (\_SB_.PCI0.LPCB.SIOD.COMA._CRS.BUF0)
00003e62:               Buffer
00003e64:                 0x0d
00003e66:                 ByteList <0x47 0x01 0xf8 0x03 0xf8 0x03 0x01 0x08 
00003e66:                 	      0x22 0x10 0x00 0x79 0x00>
00003e66:                 Interpreted as PnP Resource Descriptor:
00003e66:                 I/O Ports: 16 bit address decoding,
00003e66:                 minbase 0x3f8, maxbase 0x3f8, align 0x1, count 0x8
00003e66:                 IRQ mask: 0000000000100000
00003e66:                 Info: high true edge sensitive
00003e66:                 Bad checksum 0xf2, should be 0
00003e66:                 
00003e73:             <NULL>
00003e77:             0x03
00003e79:             If
00003e7c:               CMAP (000001d1)
00003e80:               CreateByteField
00003e81:                 BUF0 (00003e5d)
00003e85:                 0x02
00003e87:                 IOL0
00003e8b:               CreateByteField
00003e8c:                 BUF0 (00003e5d)
00003e90:                 0x03
00003e92:                 IOH0
00003e96:               CreateByteField
00003e97:                 BUF0 (00003e5d)
00003e9b:                 0x04
00003e9d:                 IOL1
00003ea1:               CreateByteField
00003ea2:                 BUF0 (00003e5d)
00003ea6:                 0x05
00003ea8:                 IOH1
00003eac:               CreateByteField
00003ead:                 BUF0 (00003e5d)
00003eb1:                 0x07
00003eb3:                 LEN0
00003eb7:               CreateWordField
00003eb8:                 BUF0 (00003e5d)
00003ebc:                 0x09
00003ebe:                 IRQW
00003ec2:               Store
00003ec3:                 <NULL>
00003ec7:                 0x60
00003ec9:               IOH0
00003ecd:               Store
00003ece:                 <NULL>
00003ed2:                 0x61
00003ed4:               IOL0
00003ed8:               Store
00003ed9:                 <NULL>
00003edd:                 0x60
00003edf:               IOH1
00003ee3:               Store
00003ee4:                 <NULL>
00003ee8:                 0x61
00003eea:               IOL1
00003eee:               Store
00003eef:                 0x08
00003ef1:                 LEN0
00003ef5:               And
00003ef6:                 <NULL>
00003efa:                 0x70
00003efc:                 0x0f
00003efe:               Local0
00003eff:               If
00003f01:                 Local0
00003f02:                 ShiftLeft
00003f03:                   OneOp
00003f04:                   Local0
00003f05:                   IRQW
00003f09:               Else
00003f0b:                 Store
00003f0c:                   ZeroOp
00003f0d:                   IRQW
00003f11:             Return
00003f12:               BUF0 (00003e5d)
00003f16:           Method _PRS (\_SB_.PCI0.LPCB.SIOD.COMA._PRS)
00003f1d:             ArgCount 0; NotSerialized
00003f1e:             If
00003f20:               LEqual
00003f21:                 <NULL>
00003f30:                 ZeroOp
00003f31:               Name BUF1 (\_SB_.PCI0.LPCB.SIOD.COMA._PRS.)
00003f36:                 Buffer
00003f38:                   0x10
00003f3a:                   ByteList <0x31 0x08 0x47 0x01 0x00 0x00 0x00 0x00 
00003f3a:                   	      0x01 0x00 0x22 0x00 0x00 0x38 0x79 0x00>
00003f3a:                   Interpreted as PnP Resource Descriptor:
00003f3a:                   Start dependent functions
00003f3a:                   good compatiblity; sub-optimal performance/robustness
00003f3a:                   I/O Ports: 16 bit address decoding,
00003f3a:                   minbase 0x0, maxbase 0x0, align 0x1, count 0x0
00003f3a:                   IRQ mask: 0000000000000000
00003f3a:                   Info: high true edge sensitive
00003f3a:                   End dependent functions
00003f3a:                   Bad checksum 0x55, should be 0
00003f3a:                   
00003f4a:               Return
00003f4b:                 BUF1 (00003f31)
00003f4f:             Name BUF0 (\_SB_.PCI0.LPCB.SIOD.COMA._PRS.BUF0)
00003f54:               Buffer
00003f57:                 0x6b
00003f59:                 ByteList <0x31 0x08 0x47 0x01 0xf8 0x03 0xf8 0x03 
00003f59:                 	      0x01 0x08 0x22 0x10 0x00 0x31 0x08 0x47 
00003f59:                 	      0x01 0xf8 0x02 0xf8 0x02 0x01 0x08 0x22 
00003f59:                 	      0x10 0x00 0x31 0x08 0x47 0x01 0xe8 0x03 
00003f59:                 	      0xe8 0x03 0x01 0x08 0x22 0x10 0x00 0x31 
00003f59:                 	      0x08 0x47 0x01 0xe8 0x02 0xe8 0x02 0x01 
00003f59:                 	      0x08 0x22 0x10 0x00 0x31 0x08 0x47 0x01 
00003f59:                 	      0xf8 0x03 0xf8 0x03 0x01 0x08 0x22 0x08 
00003f59:                 	      0x00 0x31 0x08 0x47 0x01 0xf8 0x02 0xf8 
00003f59:                 	      0x02 0x01 0x08 0x22 0x08 0x00 0x31 0x08 
00003f59:                 	      0x47 0x01 0xe8 0x03 0xe8 0x03 0x01 0x08 
00003f59:                 	      0x22 0x08 0x00 0x31 0x08 0x47 0x01 0xe8 
00003f59:                 	      0x02 0xe8 0x02 0x01 0x08 0x22 0x08 0x00 
00003f59:                 	      0x38 0x79 0x00>
00003f59:                 Interpreted as PnP Resource Descriptor:
00003f59:                 Start dependent functions
00003f59:                 good compatiblity; sub-optimal performance/robustness
00003f59:                 I/O Ports: 16 bit address decoding,
00003f59:                 minbase 0x3f8, maxbase 0x3f8, align 0x1, count 0x8
00003f59:                 IRQ mask: 0000000000100000
00003f59:                 Info: high true edge sensitive
00003f59:                 Start dependent functions
00003f59:                 good compatiblity; sub-optimal performance/robustness
00003f59:                 I/O Ports: 16 bit address decoding,
00003f59:                 minbase 0x2f8, maxbase 0x2f8, align 0x1, count 0x8
00003f59:                 IRQ mask: 0000000000100000
00003f59:                 Info: high true edge sensitive
00003f59:                 Start dependent functions
00003f59:                 good compatiblity; sub-optimal performance/robustness
00003f59:                 I/O Ports: 16 bit address decoding,
00003f59:                 minbase 0x3e8, maxbase 0x3e8, align 0x1, count 0x8
00003f59:                 IRQ mask: 0000000000100000
00003f59:                 Info: high true edge sensitive
00003f59:                 Start dependent functions
00003f59:                 good compatiblity; sub-optimal performance/robustness
00003f59:                 I/O Ports: 16 bit address decoding,
00003f59:                 minbase 0x2e8, maxbase 0x2e8, align 0x1, count 0x8
00003f59:                 IRQ mask: 0000000000100000
00003f59:                 Info: high true edge sensitive
00003f59:                 Start dependent functions
00003f59:                 good compatiblity; sub-optimal performance/robustness
00003f59:                 I/O Ports: 16 bit address decoding,
00003f59:                 minbase 0x3f8, maxbase 0x3f8, align 0x1, count 0x8
00003f59:                 IRQ mask: 0000000000010000
00003f59:                 Info: high true edge sensitive
00003f59:                 Start dependent functions
00003f59:                 good compatiblity; sub-optimal performance/robustness
00003f59:                 I/O Ports: 16 bit address decoding,
00003f59:                 minbase 0x2f8, maxbase 0x2f8, align 0x1, count 0x8
00003f59:                 IRQ mask: 0000000000010000
00003f59:                 Info: high true edge sensitive
00003f59:                 Start dependent functions
00003f59:                 good compatiblity; sub-optimal performance/robustness
00003f59:                 I/O Ports: 16 bit address decoding,
00003f59:                 minbase 0x3e8, maxbase 0x3e8, align 0x1, count 0x8
00003f59:                 IRQ mask: 0000000000010000
00003f59:                 Info: high true edge sensitive
00003f59:                 Start dependent functions
00003f59:                 good compatiblity; sub-optimal performance/robustness
00003f59:                 I/O Ports: 16 bit address decoding,
00003f59:                 minbase 0x2e8, maxbase 0x2e8, align 0x1, count 0x8
00003f59:                 IRQ mask: 0000000000010000
00003f59:                 Info: high true edge sensitive
00003f59:                 End dependent functions
00003f59:                 Bad checksum 0x99, should be 0
00003f59:                 
00003fc4:             Return
00003fc5:               BUF0 (00003f4f)
00003fc9:           Method _SRS (\_SB_.PCI0.LPCB.SIOD.COMA._SRS)
00003fd0:             ArgCount 1; NotSerialized
00003fd1:             CreateByteField
00003fd2:               Arg0
00003fd3:               0x02
00003fd5:               IOLO
00003fd9:             CreateByteField
00003fda:               Arg0
00003fdb:               0x03
00003fdd:               IOHI
00003fe1:             CreateWordField
00003fe2:               Arg0
00003fe3:               0x09
00003fe5:               IRQW
00003fe9:             <NULL>
00003fed:             0x03
00003fef:             <NULL>
00003ff3:             0x30
00003ff5:             0x00
00003ff7:             <NULL>
00003ffb:             0x61
00003ffd:             IOLO
00004001:             <NULL>
00004005:             0x60
00004007:             IOHI
0000400b:             FindSetRightBit
0000400c:               IRQW
00004010:               Local0
00004011:             If
00004013:               LNotEqual
00004015:                 IRQW
00004019:                 ZeroOp
0000401a:               Decrement
0000401b:                 Local0
0000401c:             <NULL>
00004020:             0x70
00004022:             Local0
00004023:             And
00004024:               LDE0 (00002ef0)
00004028:               0xf8
0000402a:               LDE0 (00002ef0)
0000402e:             If
00004030:               LEqual
00004031:                 IOHI
00004035:                 0x03
00004037:               If
00004039:                 LEqual
0000403a:                   IOLO
0000403e:                   0xf8
00004040:                 Or
00004041:                   LDE0 (00002ef0)
00004045:                   0x00
00004047:                   LDE0 (00002ef0)
0000404b:               Else
0000404d:                 Or
0000404e:                   LDE0 (00002ef0)
00004052:                   0x07
00004054:                   LDE0 (00002ef0)
00004058:             Else
0000405a:               If
0000405c:                 LEqual
0000405d:                   IOLO
00004061:                   0xf8
00004063:                 Or
00004064:                   LDE0 (00002ef0)
00004068:                   0x01
0000406a:                   LDE0 (00002ef0)
0000406e:               Else
00004070:                 Or
00004071:                   LDE0 (00002ef0)
00004075:                   0x05
00004077:                   LDE0 (00002ef0)
0000407b:             Or
0000407c:               LDEN (00002efc)
00004080:               0x01
00004082:               LDEN (00002efc)
00004086:             If
00004088:               <NULL>
00004097:               <NULL>
0000409b:               0x03
0000409d:               <NULL>
000040a1:               0x30
000040a3:               0x01
000040a5:           Method _PS0 (\_SB_.PCI0.LPCB.SIOD.COMA._PS0)
000040ab:             ArgCount 0; NotSerialized
000040ac:             <NULL>
000040b0:             0x03
000040b2:             <NULL>
000040b6:             0xf0
000040b8:             0x82
000040ba:             <NULL>
000040be:             0x30
000040c0:             0x01
000040c2:             Or
000040c3:               LDEN (00002efc)
000040c7:               0x01
000040c9:               LDEN (00002efc)
000040cd:           Method _PS3 (\_SB_.PCI0.LPCB.SIOD.COMA._PS3)
000040d3:             ArgCount 0; NotSerialized
000040d4:             <NULL>
000040d8:             0x03
000040da:             <NULL>
000040de:             0x30
000040e0:             0x00
000040e2:         Device SIR_ (\_SB_.PCI0.LPCB.SIOD.SIR_)
000040ea:           Name _HID (\_SB_.PCI0.LPCB.SIOD.SIR_._HID)
000040ef:             PNP0510 (0x1005d041)
000040f4:           Name _UID (\_SB_.PCI0.LPCB.SIOD.SIR_._UID)
000040f9:             0x01
000040fb:           Method _STA (\_SB_.PCI0.LPCB.SIOD.SIR_._STA)
00004101:             ArgCount 0; NotSerialized
00004102:             If
00004104:               CMBP (000001d6)
00004108:               <NULL>
0000410c:               0x02
0000410e:               If
00004110:                 LNotEqual
00004112:                   <NULL>
00004116:                   0x74
00004118:                 0x04
0000411a:                 Return
0000411b:                   0x00
0000411d:               If
0000411f:                 <NULL>
00004123:                 0x30
00004125:                 Return
00004126:                   0x0f
00004128:               Return
00004129:                 0x0d
0000412b:             Return
0000412c:               0x00
0000412e:           Method _DIS (\_SB_.PCI0.LPCB.SIOD.SIR_._DIS)
00004134:             ArgCount 0; NotSerialized
00004135:             <NULL>
00004139:             0x02
0000413b:             <NULL>
0000413f:             0x30
00004141:             0x00
00004143:             And
00004144:               LDEN (00002efc)
00004148:               0xfd
0000414a:               LDEN (00002efc)
0000414e:           Method _CRS (\_SB_.PCI0.LPCB.SIOD.SIR_._CRS)
00004155:             ArgCount 0; NotSerialized
00004156:             Name BUF0 (\_SB_.PCI0.LPCB.SIOD.SIR_._CRS.BUF0)
0000415b:               Buffer
0000415d:                 0x0d
0000415f:                 ByteList <0x47 0x01 0xf8 0x02 0xf8 0x02 0x01 0x08 
0000415f:                 	      0x22 0x08 0x00 0x79 0x00>
0000415f:                 Interpreted as PnP Resource Descriptor:
0000415f:                 I/O Ports: 16 bit address decoding,
0000415f:                 minbase 0x2f8, maxbase 0x2f8, align 0x1, count 0x8
0000415f:                 IRQ mask: 0000000000010000
0000415f:                 Info: high true edge sensitive
0000415f:                 Bad checksum 0xe8, should be 0
0000415f:                 
0000416c:             <NULL>
00004170:             0x02
00004172:             If
00004175:               CMBP (000001d6)
00004179:               CreateByteField
0000417a:                 BUF0 (00004156)
0000417e:                 0x02
00004180:                 IOL0
00004184:               CreateByteField
00004185:                 BUF0 (00004156)
00004189:                 0x03
0000418b:                 IOH0
0000418f:               CreateByteField
00004190:                 BUF0 (00004156)
00004194:                 0x04
00004196:                 IOL1
0000419a:               CreateByteField
0000419b:                 BUF0 (00004156)
0000419f:                 0x05
000041a1:                 IOH1
000041a5:               CreateByteField
000041a6:                 BUF0 (00004156)
000041aa:                 0x07
000041ac:                 LEN0
000041b0:               CreateWordField
000041b1:                 BUF0 (00004156)
000041b5:                 0x09
000041b7:                 IRQW
000041bb:               Store
000041bc:                 <NULL>
000041c0:                 0x60
000041c2:               IOH0
000041c6:               Store
000041c7:                 <NULL>
000041cb:                 0x61
000041cd:               IOL0
000041d1:               Store
000041d2:                 <NULL>
000041d6:                 0x60
000041d8:               IOH1
000041dc:               Store
000041dd:                 <NULL>
000041e1:                 0x61
000041e3:               IOL1
000041e7:               Store
000041e8:                 0x08
000041ea:                 LEN0
000041ee:               And
000041ef:                 <NULL>
000041f3:                 0x70
000041f5:                 0x0f
000041f7:               Local0
000041f8:               If
000041fa:                 Local0
000041fb:                 ShiftLeft
000041fc:                   OneOp
000041fd:                   Local0
000041fe:                   IRQW
00004202:               Else
00004204:                 Store
00004205:                   ZeroOp
00004206:                   IRQW
0000420a:             Return
0000420b:               BUF0 (00004156)
0000420f:           Method _PRS (\_SB_.PCI0.LPCB.SIOD.SIR_._PRS)
00004216:             ArgCount 0; NotSerialized
00004217:             Name BUF0 (\_SB_.PCI0.LPCB.SIOD.SIR_._PRS.BUF0)
0000421c:               Buffer
0000421f:                 0x6b
00004221:                 ByteList <0x31 0x08 0x47 0x01 0xf8 0x03 0xf8 0x03 
00004221:                 	      0x01 0x08 0x22 0x10 0x00 0x31 0x08 0x47 
00004221:                 	      0x01 0xf8 0x02 0xf8 0x02 0x01 0x08 0x22 
00004221:                 	      0x10 0x00 0x31 0x08 0x47 0x01 0xe8 0x03 
00004221:                 	      0xe8 0x03 0x01 0x08 0x22 0x10 0x00 0x31 
00004221:                 	      0x08 0x47 0x01 0xe8 0x02 0xe8 0x02 0x01 
00004221:                 	      0x08 0x22 0x10 0x00 0x31 0x08 0x47 0x01 
00004221:                 	      0xf8 0x03 0xf8 0x03 0x01 0x08 0x22 0x08 
00004221:                 	      0x00 0x31 0x08 0x47 0x01 0xf8 0x02 0xf8 
00004221:                 	      0x02 0x01 0x08 0x22 0x08 0x00 0x31 0x08 
00004221:                 	      0x47 0x01 0xe8 0x03 0xe8 0x03 0x01 0x08 
00004221:                 	      0x22 0x08 0x00 0x31 0x08 0x47 0x01 0xe8 
00004221:                 	      0x02 0xe8 0x02 0x01 0x08 0x22 0x08 0x00 
00004221:                 	      0x38 0x79 0x00>
00004221:                 Interpreted as PnP Resource Descriptor:
00004221:                 Start dependent functions
00004221:                 good compatiblity; sub-optimal performance/robustness
00004221:                 I/O Ports: 16 bit address decoding,
00004221:                 minbase 0x3f8, maxbase 0x3f8, align 0x1, count 0x8
00004221:                 IRQ mask: 0000000000100000
00004221:                 Info: high true edge sensitive
00004221:                 Start dependent functions
00004221:                 good compatiblity; sub-optimal performance/robustness
00004221:                 I/O Ports: 16 bit address decoding,
00004221:                 minbase 0x2f8, maxbase 0x2f8, align 0x1, count 0x8
00004221:                 IRQ mask: 0000000000100000
00004221:                 Info: high true edge sensitive
00004221:                 Start dependent functions
00004221:                 good compatiblity; sub-optimal performance/robustness
00004221:                 I/O Ports: 16 bit address decoding,
00004221:                 minbase 0x3e8, maxbase 0x3e8, align 0x1, count 0x8
00004221:                 IRQ mask: 0000000000100000
00004221:                 Info: high true edge sensitive
00004221:                 Start dependent functions
00004221:                 good compatiblity; sub-optimal performance/robustness
00004221:                 I/O Ports: 16 bit address decoding,
00004221:                 minbase 0x2e8, maxbase 0x2e8, align 0x1, count 0x8
00004221:                 IRQ mask: 0000000000100000
00004221:                 Info: high true edge sensitive
00004221:                 Start dependent functions
00004221:                 good compatiblity; sub-optimal performance/robustness
00004221:                 I/O Ports: 16 bit address decoding,
00004221:                 minbase 0x3f8, maxbase 0x3f8, align 0x1, count 0x8
00004221:                 IRQ mask: 0000000000010000
00004221:                 Info: high true edge sensitive
00004221:                 Start dependent functions
00004221:                 good compatiblity; sub-optimal performance/robustness
00004221:                 I/O Ports: 16 bit address decoding,
00004221:                 minbase 0x2f8, maxbase 0x2f8, align 0x1, count 0x8
00004221:                 IRQ mask: 0000000000010000
00004221:                 Info: high true edge sensitive
00004221:                 Start dependent functions
00004221:                 good compatiblity; sub-optimal performance/robustness
00004221:                 I/O Ports: 16 bit address decoding,
00004221:                 minbase 0x3e8, maxbase 0x3e8, align 0x1, count 0x8
00004221:                 IRQ mask: 0000000000010000
00004221:                 Info: high true edge sensitive
00004221:                 Start dependent functions
00004221:                 good compatiblity; sub-optimal performance/robustness
00004221:                 I/O Ports: 16 bit address decoding,
00004221:                 minbase 0x2e8, maxbase 0x2e8, align 0x1, count 0x8
00004221:                 IRQ mask: 0000000000010000
00004221:                 Info: high true edge sensitive
00004221:                 End dependent functions
00004221:                 Bad checksum 0x99, should be 0
00004221:                 
0000428c:             Return
0000428d:               BUF0 (00004217)
00004291:           Method _SRS (\_SB_.PCI0.LPCB.SIOD.SIR_._SRS)
00004298:             ArgCount 1; NotSerialized
00004299:             CreateByteField
0000429a:               Arg0
0000429b:               0x02
0000429d:               IOLO
000042a1:             CreateByteField
000042a2:               Arg0
000042a3:               0x03
000042a5:               IOHI
000042a9:             CreateWordField
000042aa:               Arg0
000042ab:               0x09
000042ad:               IRQW
000042b1:             <NULL>
000042b5:             0x02
000042b7:             <NULL>
000042bb:             0x30
000042bd:             0x00
000042bf:             <NULL>
000042c3:             0x61
000042c5:             IOLO
000042c9:             <NULL>
000042cd:             0x60
000042cf:             IOHI
000042d3:             FindSetRightBit
000042d4:               IRQW
000042d8:               Local0
000042d9:             If
000042db:               LNotEqual
000042dd:                 IRQW
000042e1:                 ZeroOp
000042e2:               Decrement
000042e3:                 Local0
000042e4:             <NULL>
000042e8:             0x70
000042ea:             Local0
000042eb:             And
000042ec:               LDE0 (00002ef0)
000042f0:               0x8f
000042f2:               LDE0 (00002ef0)
000042f6:             If
000042f8:               LEqual
000042f9:                 IOHI
000042fd:                 0x03
000042ff:               If
00004301:                 LEqual
00004302:                   IOLO
00004306:                   0xf8
00004308:                 Or
00004309:                   LDE0 (00002ef0)
0000430d:                   0x00
0000430f:                   LDE0 (00002ef0)
00004313:               Else
00004315:                 Or
00004316:                   LDE0 (00002ef0)
0000431a:                   0x70
0000431c:                   LDE0 (00002ef0)
00004320:             Else
00004322:               If
00004324:                 LEqual
00004325:                   IOLO
00004329:                   0xf8
0000432b:                 Or
0000432c:                   LDE0 (00002ef0)
00004330:                   0x10
00004332:                   LDE0 (00002ef0)
00004336:               Else
00004338:                 Or
00004339:                   LDE0 (00002ef0)
0000433d:                   0x50
0000433f:                   LDE0 (00002ef0)
00004343:             Or
00004344:               LDEN (00002efc)
00004348:               0x02
0000434a:               LDEN (00002efc)
0000434e:             <NULL>
00004352:             0x30
00004354:             0x01
00004356:           Method _PS0 (\_SB_.PCI0.LPCB.SIOD.SIR_._PS0)
0000435c:             ArgCount 0; NotSerialized
0000435d:             <NULL>
00004361:             0x02
00004363:             <NULL>
00004367:             0xf0
00004369:             0x82
0000436b:             <NULL>
0000436f:             0x30
00004371:             0x01
00004373:             Or
00004374:               LDEN (00002efc)
00004378:               0x02
0000437a:               LDEN (00002efc)
0000437e:           Method _PS3 (\_SB_.PCI0.LPCB.SIOD.SIR_._PS3)
00004384:             ArgCount 0; NotSerialized
00004385:             <NULL>
00004389:             0x02
0000438b:             <NULL>
0000438f:             0x30
00004391:             0x00
00004393:         Device FIR_ (\_SB_.PCI0.LPCB.SIOD.FIR_)
0000439b:           Name _HID (\_SB_.PCI0.LPCB.SIOD.FIR_._HID)
000043a0:             NSC6001 (0x0160633a)
000043a5:           Name _UID (\_SB_.PCI0.LPCB.SIOD.FIR_._UID)
000043aa:             0x02
000043ac:           Method _STA (\_SB_.PCI0.LPCB.SIOD.FIR_._STA)
000043b2:             ArgCount 0; NotSerialized
000043b3:             If
000043b5:               CMBP (000001d6)
000043b9:               <NULL>
000043bd:               0x02
000043bf:               If
000043c1:                 LEqual
000043c2:                   <NULL>
000043c6:                   0x74
000043c8:                 0x04
000043ca:                 Return
000043cb:                   0x00
000043cd:               If
000043cf:                 <NULL>
000043d3:                 0x30
000043d5:                 Return
000043d6:                   0x0f
000043d8:               Return
000043d9:                 0x0d
000043db:             Return
000043dc:               0x00
000043de:           Method _DIS (\_SB_.PCI0.LPCB.SIOD.FIR_._DIS)
000043e4:             ArgCount 0; NotSerialized
000043e5:             <NULL>
000043e9:             0x02
000043eb:             <NULL>
000043ef:             0x30
000043f1:             0x00
000043f3:             And
000043f4:               LDEN (00002efc)
000043f8:               0xfd
000043fa:               LDEN (00002efc)
000043fe:           Method _CRS (\_SB_.PCI0.LPCB.SIOD.FIR_._CRS)
00004405:             ArgCount 0; NotSerialized
00004406:             Name BUF0 (\_SB_.PCI0.LPCB.SIOD.FIR_._CRS.BUF0)
0000440b:               Buffer
0000440d:                 0x10
0000440f:                 ByteList <0x47 0x01 0xf8 0x02 0xf8 0x02 0x01 0x08 
0000440f:                 	      0x22 0x08 0x00 0x2a 0x08 0x00 0x79 0x00>
0000440f:                 Interpreted as PnP Resource Descriptor:
0000440f:                 I/O Ports: 16 bit address decoding,
0000440f:                 minbase 0x2f8, maxbase 0x2f8, align 0x1, count 0x8
0000440f:                 IRQ mask: 0000000000010000
0000440f:                 Info: high true edge sensitive
0000440f:                 DMA mask: 00010000
0000440f:                 DMA channel speed: compatibility mode; transfer type: 8-bit
0000440f:                 Bad checksum 0x1a, should be 0
0000440f:                 
0000441f:             <NULL>
00004423:             0x02
00004425:             If
00004428:               CMBP (000001d6)
0000442c:               CreateByteField
0000442d:                 BUF0 (00004406)
00004431:                 0x02
00004433:                 IOL0
00004437:               CreateByteField
00004438:                 BUF0 (00004406)
0000443c:                 0x03
0000443e:                 IOH0
00004442:               CreateByteField
00004443:                 BUF0 (00004406)
00004447:                 0x04
00004449:                 IOL1
0000444d:               CreateByteField
0000444e:                 BUF0 (00004406)
00004452:                 0x05
00004454:                 IOH1
00004458:               CreateByteField
00004459:                 BUF0 (00004406)
0000445d:                 0x07
0000445f:                 LEN0
00004463:               CreateWordField
00004464:                 BUF0 (00004406)
00004468:                 0x09
0000446a:                 IRQW
0000446e:               CreateByteField
0000446f:                 BUF0 (00004406)
00004473:                 0x0c
00004475:                 DMA0
00004479:               CreateByteField
0000447a:                 BUF0 (00004406)
0000447e:                 0x0d
00004480:                 DMA1
00004484:               Store
00004485:                 <NULL>
00004489:                 0x60
0000448b:               IOH0
0000448f:               Store
00004490:                 <NULL>
00004494:                 0x61
00004496:               IOL0
0000449a:               Store
0000449b:                 <NULL>
0000449f:                 0x60
000044a1:               IOH1
000044a5:               Store
000044a6:                 <NULL>
000044aa:                 0x61
000044ac:               IOL1
000044b0:               Store
000044b1:                 0x08
000044b3:                 LEN0
000044b7:               And
000044b8:                 <NULL>
000044bc:                 0x70
000044be:                 0x0f
000044c0:               Local0
000044c1:               If
000044c3:                 Local0
000044c4:                 ShiftLeft
000044c5:                   OneOp
000044c6:                   Local0
000044c7:                   IRQW
000044cb:               Else
000044cd:                 Store
000044ce:                   ZeroOp
000044cf:                   IRQW
000044d3:               Store
000044d4:                 <NULL>
000044d8:                 0x74
000044da:               Local0
000044db:               If
000044dd:                 LEqual
000044de:                   Local0
000044df:                   0x04
000044e1:                 Store
000044e2:                   ZeroOp
000044e3:                   DMA0
000044e7:               Else
000044e9:                 ShiftLeft
000044ea:                   OneOp
000044eb:                   Local0
000044ec:                   DMA0
000044f0:             Return
000044f1:               BUF0 (00004406)
000044f5:           Method _PRS (\_SB_.PCI0.LPCB.SIOD.FIR_._PRS)
000044fc:             ArgCount 0; NotSerialized
000044fd:             Name BUF0 (\_SB_.PCI0.LPCB.SIOD.FIR_._PRS.BUF0)
00004502:               Buffer
00004505:                 0x83
00004507:                 ByteList <0x31 0x08 0x47 0x01 0xf8 0x03 0xf8 0x03 
00004507:                 	      0x01 0x08 0x22 0x10 0x00 0x2a 0x08 0x00 
00004507:                 	      0x31 0x08 0x47 0x01 0xf8 0x02 0xf8 0x02 
00004507:                 	      0x01 0x08 0x22 0x10 0x00 0x2a 0x08 0x00 
00004507:                 	      0x31 0x08 0x47 0x01 0xe8 0x03 0xe8 0x03 
00004507:                 	      0x01 0x08 0x22 0x10 0x00 0x2a 0x08 0x00 
00004507:                 	      0x31 0x08 0x47 0x01 0xe8 0x02 0xe8 0x02 
00004507:                 	      0x01 0x08 0x22 0x10 0x00 0x2a 0x08 0x00 
00004507:                 	      0x31 0x08 0x47 0x01 0xf8 0x03 0xf8 0x03 
00004507:                 	      0x01 0x08 0x22 0x08 0x00 0x2a 0x08 0x00 
00004507:                 	      0x31 0x08 0x47 0x01 0xf8 0x02 0xf8 0x02 
00004507:                 	      0x01 0x08 0x22 0x08 0x00 0x2a 0x08 0x00 
00004507:                 	      0x31 0x08 0x47 0x01 0xe8 0x03 0xe8 0x03 
00004507:                 	      0x01 0x08 0x22 0x08 0x00 0x2a 0x08 0x00 
00004507:                 	      0x31 0x08 0x47 0x01 0xe8 0x02 0xe8 0x02 
00004507:                 	      0x01 0x08 0x22 0x08 0x00 0x2a 0x08 0x00 
00004507:                 	      0x38 0x79 0x00>
00004507:                 Interpreted as PnP Resource Descriptor:
00004507:                 Start dependent functions
00004507:                 good compatiblity; sub-optimal performance/robustness
00004507:                 I/O Ports: 16 bit address decoding,
00004507:                 minbase 0x3f8, maxbase 0x3f8, align 0x1, count 0x8
00004507:                 IRQ mask: 0000000000100000
00004507:                 Info: high true edge sensitive
00004507:                 DMA mask: 00010000
00004507:                 DMA channel speed: compatibility mode; transfer type: 8-bit
00004507:                 Start dependent functions
00004507:                 good compatiblity; sub-optimal performance/robustness
00004507:                 I/O Ports: 16 bit address decoding,
00004507:                 minbase 0x2f8, maxbase 0x2f8, align 0x1, count 0x8
00004507:                 IRQ mask: 0000000000100000
00004507:                 Info: high true edge sensitive
00004507:                 DMA mask: 00010000
00004507:                 DMA channel speed: compatibility mode; transfer type: 8-bit
00004507:                 Start dependent functions
00004507:                 good compatiblity; sub-optimal performance/robustness
00004507:                 I/O Ports: 16 bit address decoding,
00004507:                 minbase 0x3e8, maxbase 0x3e8, align 0x1, count 0x8
00004507:                 IRQ mask: 0000000000100000
00004507:                 Info: high true edge sensitive
00004507:                 DMA mask: 00010000
00004507:                 DMA channel speed: compatibility mode; transfer type: 8-bit
00004507:                 Start dependent functions
00004507:                 good compatiblity; sub-optimal performance/robustness
00004507:                 I/O Ports: 16 bit address decoding,
00004507:                 minbase 0x2e8, maxbase 0x2e8, align 0x1, count 0x8
00004507:                 IRQ mask: 0000000000100000
00004507:                 Info: high true edge sensitive
00004507:                 DMA mask: 00010000
00004507:                 DMA channel speed: compatibility mode; transfer type: 8-bit
00004507:                 Start dependent functions
00004507:                 good compatiblity; sub-optimal performance/robustness
00004507:                 I/O Ports: 16 bit address decoding,
00004507:                 minbase 0x3f8, maxbase 0x3f8, align 0x1, count 0x8
00004507:                 IRQ mask: 0000000000010000
00004507:                 Info: high true edge sensitive
00004507:                 DMA mask: 00010000
00004507:                 DMA channel speed: compatibility mode; transfer type: 8-bit
00004507:                 Start dependent functions
00004507:                 good compatiblity; sub-optimal performance/robustness
00004507:                 I/O Ports: 16 bit address decoding,
00004507:                 minbase 0x2f8, maxbase 0x2f8, align 0x1, count 0x8
00004507:                 IRQ mask: 0000000000010000
00004507:                 Info: high true edge sensitive
00004507:                 DMA mask: 00010000
00004507:                 DMA channel speed: compatibility mode; transfer type: 8-bit
00004507:                 Start dependent functions
00004507:                 good compatiblity; sub-optimal performance/robustness
00004507:                 I/O Ports: 16 bit address decoding,
00004507:                 minbase 0x3e8, maxbase 0x3e8, align 0x1, count 0x8
00004507:                 IRQ mask: 0000000000010000
00004507:                 Info: high true edge sensitive
00004507:                 DMA mask: 00010000
00004507:                 DMA channel speed: compatibility mode; transfer type: 8-bit
00004507:                 Start dependent functions
00004507:                 good compatiblity; sub-optimal performance/robustness
00004507:                 I/O Ports: 16 bit address decoding,
00004507:                 minbase 0x2e8, maxbase 0x2e8, align 0x1, count 0x8
00004507:                 IRQ mask: 0000000000010000
00004507:                 Info: high true edge sensitive
00004507:                 DMA mask: 00010000
00004507:                 DMA channel speed: compatibility mode; transfer type: 8-bit
00004507:                 End dependent functions
00004507:                 Bad checksum 0x29, should be 0
00004507:                 
0000458a:             Return
0000458b:               BUF0 (000044fd)
0000458f:           Method _SRS (\_SB_.PCI0.LPCB.SIOD.FIR_._SRS)
00004596:             ArgCount 1; NotSerialized
00004597:             CreateByteField
00004598:               Arg0
00004599:               0x02
0000459b:               IOLO
0000459f:             CreateByteField
000045a0:               Arg0
000045a1:               0x03
000045a3:               IOHI
000045a7:             CreateWordField
000045a8:               Arg0
000045a9:               0x09
000045ab:               IRQW
000045af:             CreateByteField
000045b0:               Arg0
000045b1:               0x0c
000045b3:               DMA0
000045b7:             Store
000045b8:               DMA0
000045bc:               P80H (00000013)
000045c0:             <NULL>
000045c4:             0x02
000045c6:             <NULL>
000045ca:             0x30
000045cc:             0x00
000045ce:             <NULL>
000045d2:             0x61
000045d4:             IOLO
000045d8:             <NULL>
000045dc:             0x60
000045de:             IOHI
000045e2:             FindSetRightBit
000045e3:               IRQW
000045e7:               Local0
000045e8:             If
000045ea:               LNotEqual
000045ec:                 IRQW
000045f0:                 ZeroOp
000045f1:               Decrement
000045f2:                 Local0
000045f3:             <NULL>
000045f7:             0x70
000045f9:             Local0
000045fa:             FindSetRightBit
000045fb:               DMA0
000045ff:               Local0
00004600:             If
00004602:               LNotEqual
00004604:                 DMA0
00004608:                 ZeroOp
00004609:               Decrement
0000460a:                 Local0
0000460b:             <NULL>
0000460f:             0x74
00004611:             Local0
00004612:             And
00004613:               LDE0 (00002ef0)
00004617:               0x8f
00004619:               LDE0 (00002ef0)
0000461d:             If
0000461f:               LEqual
00004620:                 IOHI
00004624:                 0x03
00004626:               If
00004628:                 LEqual
00004629:                   IOLO
0000462d:                   0xf8
0000462f:                 Or
00004630:                   LDE0 (00002ef0)
00004634:                   0x00
00004636:                   LDE0 (00002ef0)
0000463a:               Else
0000463c:                 Or
0000463d:                   LDE0 (00002ef0)
00004641:                   0x70
00004643:                   LDE0 (00002ef0)
00004647:             Else
00004649:               If
0000464b:                 LEqual
0000464c:                   IOLO
00004650:                   0xf8
00004652:                 Or
00004653:                   LDE0 (00002ef0)
00004657:                   0x10
00004659:                   LDE0 (00002ef0)
0000465d:               Else
0000465f:                 Or
00004660:                   LDE0 (00002ef0)
00004664:                   0x50
00004666:                   LDE0 (00002ef0)
0000466a:             Or
0000466b:               LDEN (00002efc)
0000466f:               0x02
00004671:               LDEN (00002efc)
00004675:             <NULL>
00004679:             0x30
0000467b:             0x01
0000467d:           Method _PS0 (\_SB_.PCI0.LPCB.SIOD.FIR_._PS0)
00004683:             ArgCount 0; NotSerialized
00004684:             <NULL>
00004688:             0x02
0000468a:             <NULL>
0000468e:             0xf0
00004690:             0x82
00004692:             <NULL>
00004696:             0x30
00004698:             0x01
0000469a:             Or
0000469b:               LDEN (00002efc)
0000469f:               0x02
000046a1:               LDEN (00002efc)
000046a5:           Method _PS3 (\_SB_.PCI0.LPCB.SIOD.FIR_._PS3)
000046ab:             ArgCount 0; NotSerialized
000046ac:             <NULL>
000046b0:             0x02
000046b2:             <NULL>
000046b6:             0x30
000046b8:             0x00
000046ba:         Device POUT (\_SB_.PCI0.LPCB.SIOD.POUT)
000046c2:           Name _HID (\_SB_.PCI0.LPCB.SIOD.POUT._HID)
000046c7:             PNP0400 (0x0004d041)
000046cc:           Name _UID (\_SB_.PCI0.LPCB.SIOD.POUT._UID)
000046d1:             0x01
000046d3:           Method _EJD (\_SB_.PCI0.LPCB.SIOD.POUT._EJD)
000046d9:             ArgCount 0; NotSerialized
000046da:             If
000046dc:               LEqual
000046dd:                 OSYS (0000017a)
000046e1:                 0x07d0
000046e4:               Return
000046e5:                 "\_SB.PCI0.LPCB.MBRD"
000046fa:             Return
000046fb:               "\_SB.MEDB"
00004706:           Method _STA (\_SB_.PCI0.LPCB.SIOD.POUT._STA)
0000470d:             ArgCount 0; NotSerialized
0000470e:             If
00004710:               LEqual
00004711:                 <NULL>
00004715:                 ZeroOp
00004716:               Return
00004717:                 0x00
00004719:             <NULL>
0000471d:             0x01
0000471f:             If
00004721:               LEqual
00004722:                 And
00004723:                   <NULL>
00004727:                   0xf0
00004729:                   0xe0
0000472b:                 ZeroOp
0000472c:               0x00
0000472e:               If
00004730:                 LPTP (000001db)
00004734:                 <NULL>
00004738:                 0x01
0000473a:                 If
0000473c:                   <NULL>
00004740:                   0x30
00004742:                   Return
00004743:                     0x0f
00004745:                 Return
00004746:                   0x0d
00004748:             Return
00004749:               0x00
0000474b:           Method _DIS (\_SB_.PCI0.LPCB.SIOD.POUT._DIS)
00004751:             ArgCount 0; NotSerialized
00004752:             <NULL>
00004756:             0x01
00004758:             If
0000475a:               LEqual
0000475b:                 And
0000475c:                   <NULL>
00004760:                   0xf0
00004762:                   0xe0
00004764:                 ZeroOp
00004765:               0x00
00004767:               <NULL>
0000476b:               0x30
0000476d:               0x00
0000476f:             And
00004770:               LDEN (00002efc)
00004774:               0xfb
00004776:               LDEN (00002efc)
0000477a:           Method _CRS (\_SB_.PCI0.LPCB.SIOD.POUT._CRS)
00004781:             ArgCount 0; NotSerialized
00004782:             If
00004784:               LEqual
00004785:                 <NULL>
00004789:                 ZeroOp
0000478a:               Name BUF1 (\_SB_.PCI0.LPCB.SIOD.POUT._CRS.)
0000478f:                 Buffer
00004791:                   0x10
00004793:                   ByteList <0x31 0x08 0x47 0x01 0x00 0x00 0x00 0x00 
00004793:                   	      0x01 0x00 0x22 0x00 0x00 0x38 0x79 0x00>
00004793:                   Interpreted as PnP Resource Descriptor:
00004793:                   Start dependent functions
00004793:                   good compatiblity; sub-optimal performance/robustness
00004793:                   I/O Ports: 16 bit address decoding,
00004793:                   minbase 0x0, maxbase 0x0, align 0x1, count 0x0
00004793:                   IRQ mask: 0000000000000000
00004793:                   Info: high true edge sensitive
00004793:                   End dependent functions
00004793:                   Bad checksum 0x55, should be 0
00004793:                   
000047a3:               Return
000047a4:                 BUF1 (0000478a)
000047a8:             Name BUF0 (\_SB_.PCI0.LPCB.SIOD.POUT._CRS.BUF0)
000047ad:               Buffer
000047af:                 0x0d
000047b1:                 ByteList <0x47 0x01 0x78 0x03 0x78 0x03 0x01 0x04 
000047b1:                 	      0x22 0x80 0x00 0x79 0x00>
000047b1:                 Interpreted as PnP Resource Descriptor:
000047b1:                 I/O Ports: 16 bit address decoding,
000047b1:                 minbase 0x378, maxbase 0x378, align 0x1, count 0x4
000047b1:                 IRQ mask: 0000000100000000
000047b1:                 Info: high true edge sensitive
000047b1:                 Bad checksum 0x5e, should be 0
000047b1:                 
000047be:             <NULL>
000047c2:             0x01
000047c4:             If
000047c7:               LEqual
000047c8:                 And
000047c9:                   <NULL>
000047cd:                   0xf0
000047cf:                   0xe0
000047d1:                 ZeroOp
000047d2:               0x00
000047d4:               CreateByteField
000047d5:                 BUF0 (000047a8)
000047d9:                 0x02
000047db:                 IOL0
000047df:               CreateByteField
000047e0:                 BUF0 (000047a8)
000047e4:                 0x03
000047e6:                 IOH0
000047ea:               CreateByteField
000047eb:                 BUF0 (000047a8)
000047ef:                 0x04
000047f1:                 IOL1
000047f5:               CreateByteField
000047f6:                 BUF0 (000047a8)
000047fa:                 0x05
000047fc:                 IOH1
00004800:               CreateByteField
00004801:                 BUF0 (000047a8)
00004805:                 0x07
00004807:                 LEN0
0000480b:               CreateWordField
0000480c:                 BUF0 (000047a8)
00004810:                 0x09
00004812:                 IRQW
00004816:               <NULL>
0000481a:               0x01
0000481c:               Store
0000481d:                 <NULL>
00004821:                 0x61
00004823:               IOL0
00004827:               Store
00004828:                 <NULL>
0000482c:                 0x60
0000482e:               IOH0
00004832:               Store
00004833:                 IOL0
00004837:                 IOL1
0000483b:               Store
0000483c:                 IOH0
00004840:                 IOH1
00004844:               Store
00004845:                 0x04
00004847:                 LEN0
0000484b:               If
0000484d:                 And
0000484e:                   <NULL>
00004852:                   0x70
00004854:                   0x0f
00004856:                 ZeroOp
00004857:                 ShiftLeft
00004858:                   OneOp
00004859:                   And
0000485a:                     <NULL>
0000485e:                     0x70
00004860:                     0x0f
00004862:                   <NULL>
00004863:                 IRQW
00004867:               Else
00004869:                 Store
0000486a:                   ZeroOp
0000486b:                   IRQW
0000486f:             Return
00004870:               BUF0 (000047a8)
00004874:           Method _PRS (\_SB_.PCI0.LPCB.SIOD.POUT._PRS)
0000487b:             ArgCount 0; NotSerialized
0000487c:             If
0000487e:               LEqual
0000487f:                 <NULL>
00004883:                 ZeroOp
00004884:               Name BUF1 (\_SB_.PCI0.LPCB.SIOD.POUT._PRS.)
00004889:                 Buffer
0000488b:                   0x10
0000488d:                   ByteList <0x31 0x08 0x47 0x01 0x00 0x00 0x00 0x00 
0000488d:                   	      0x01 0x00 0x22 0x00 0x00 0x38 0x79 0x00>
0000488d:                   Interpreted as PnP Resource Descriptor:
0000488d:                   Start dependent functions
0000488d:                   good compatiblity; sub-optimal performance/robustness
0000488d:                   I/O Ports: 16 bit address decoding,
0000488d:                   minbase 0x0, maxbase 0x0, align 0x1, count 0x0
0000488d:                   IRQ mask: 0000000000000000
0000488d:                   Info: high true edge sensitive
0000488d:                   End dependent functions
0000488d:                   Bad checksum 0x55, should be 0
0000488d:                   
0000489d:               Return
0000489e:                 BUF1 (00004884)
000048a2:             Name BUF0 (\_SB_.PCI0.LPCB.SIOD.POUT._PRS.BUF0)
000048a7:               Buffer
000048aa:                 0x51
000048ac:                 ByteList <0x31 0x08 0x47 0x01 0x78 0x03 0x78 0x03 
000048ac:                 	      0x01 0x04 0x22 0x80 0x00 0x31 0x08 0x47 
000048ac:                 	      0x01 0x78 0x02 0x78 0x02 0x01 0x04 0x22 
000048ac:                 	      0x80 0x00 0x31 0x08 0x47 0x01 0xbc 0x03 
000048ac:                 	      0xbc 0x03 0x01 0x04 0x22 0x80 0x00 0x31 
000048ac:                 	      0x08 0x47 0x01 0x78 0x03 0x78 0x03 0x01 
000048ac:                 	      0x04 0x22 0x20 0x00 0x31 0x08 0x47 0x01 
000048ac:                 	      0x78 0x02 0x78 0x02 0x01 0x04 0x22 0x20 
000048ac:                 	      0x00 0x31 0x08 0x47 0x01 0xbc 0x03 0xbc 
000048ac:                 	      0x03 0x01 0x04 0x22 0x20 0x00 0x38 0x79 
000048ac:                 	      0x00>
000048ac:                 Interpreted as PnP Resource Descriptor:
000048ac:                 Start dependent functions
000048ac:                 good compatiblity; sub-optimal performance/robustness
000048ac:                 I/O Ports: 16 bit address decoding,
000048ac:                 minbase 0x378, maxbase 0x378, align 0x1, count 0x4
000048ac:                 IRQ mask: 0000000100000000
000048ac:                 Info: high true edge sensitive
000048ac:                 Start dependent functions
000048ac:                 good compatiblity; sub-optimal performance/robustness
000048ac:                 I/O Ports: 16 bit address decoding,
000048ac:                 minbase 0x278, maxbase 0x278, align 0x1, count 0x4
000048ac:                 IRQ mask: 0000000100000000
000048ac:                 Info: high true edge sensitive
000048ac:                 Start dependent functions
000048ac:                 good compatiblity; sub-optimal performance/robustness
000048ac:                 I/O Ports: 16 bit address decoding,
000048ac:                 minbase 0x3bc, maxbase 0x3bc, align 0x1, count 0x4
000048ac:                 IRQ mask: 0000000100000000
000048ac:                 Info: high true edge sensitive
000048ac:                 Start dependent functions
000048ac:                 good compatiblity; sub-optimal performance/robustness
000048ac:                 I/O Ports: 16 bit address decoding,
000048ac:                 minbase 0x378, maxbase 0x378, align 0x1, count 0x4
000048ac:                 IRQ mask: 0000000001000000
000048ac:                 Info: high true edge sensitive
000048ac:                 Start dependent functions
000048ac:                 good compatiblity; sub-optimal performance/robustness
000048ac:                 I/O Ports: 16 bit address decoding,
000048ac:                 minbase 0x278, maxbase 0x278, align 0x1, count 0x4
000048ac:                 IRQ mask: 0000000001000000
000048ac:                 Info: high true edge sensitive
000048ac:                 Start dependent functions
000048ac:                 good compatiblity; sub-optimal performance/robustness
000048ac:                 I/O Ports: 16 bit address decoding,
000048ac:                 minbase 0x3bc, maxbase 0x3bc, align 0x1, count 0x4
000048ac:                 IRQ mask: 0000000001000000
000048ac:                 Info: high true edge sensitive
000048ac:                 End dependent functions
000048ac:                 Bad checksum 0x51, should be 0
000048ac:                 
000048fd:             Return
000048fe:               BUF0 (000048a2)
00004902:           Method _SRS (\_SB_.PCI0.LPCB.SIOD.POUT._SRS)
00004909:             ArgCount 1; NotSerialized
0000490a:             CreateByteField
0000490b:               Arg0
0000490c:               0x02
0000490e:               IOL0
00004912:             CreateByteField
00004913:               Arg0
00004914:               0x03
00004916:               IOH0
0000491a:             CreateWordField
0000491b:               Arg0
0000491c:               0x09
0000491e:               IRQW
00004922:             <NULL>
00004926:             0x01
00004928:             <NULL>
0000492c:             0x30
0000492e:             0x00
00004930:             <NULL>
00004934:             0xf0
00004936:             And
00004937:               <NULL>
0000493b:               0xf0
0000493d:               0x0f
0000493f:             ZeroOp
00004940:             <NULL>
00004944:             0x74
00004946:             0x04
00004948:             <NULL>
0000494c:             0x61
0000494e:             IOL0
00004952:             <NULL>
00004956:             0x60
00004958:             IOH0
0000495c:             FindSetRightBit
0000495d:               IRQW
00004961:               Local0
00004962:             If
00004964:               LNotEqual
00004966:                 IRQW
0000496a:                 ZeroOp
0000496b:               Decrement
0000496c:                 Local0
0000496d:             <NULL>
00004971:             0x70
00004973:             Local0
00004974:             And
00004975:               LDE1 (00002ef5)
00004979:               0xfc
0000497b:               LDE1 (00002ef5)
0000497f:             If
00004981:               LEqual
00004982:                 IOH0
00004986:                 0x03
00004988:               If
0000498a:                 LEqual
0000498b:                   IOL0
0000498f:                   0x78
00004991:                 Or
00004992:                   LDE1 (00002ef5)
00004996:                   0x00
00004998:                   LDE1 (00002ef5)
0000499c:               Else
0000499e:                 Or
0000499f:                   LDE1 (00002ef5)
000049a3:                   0x02
000049a5:                   LDE1 (00002ef5)
000049a9:             Else
000049ab:               Or
000049ac:                 LDE1 (00002ef5)
000049b0:                 0x01
000049b2:                 LDE1 (00002ef5)
000049b6:             Or
000049b7:               LDEN (00002efc)
000049bb:               0x04
000049bd:               LDEN (00002efc)
000049c1:             If
000049c3:               <NULL>
000049c7:               <NULL>
000049cb:               0x01
000049cd:               <NULL>
000049d1:               0x30
000049d3:               0x01
000049d5:           Method _PS0 (\_SB_.PCI0.LPCB.SIOD.POUT._PS0)
000049db:             ArgCount 0; NotSerialized
000049dc:             <NULL>
000049e0:             0x01
000049e2:             <NULL>
000049e6:             0x30
000049e8:             0x01
000049ea:             Or
000049eb:               LDEN (00002efc)
000049ef:               0x04
000049f1:               LDEN (00002efc)
000049f5:           Method _PS3 (\_SB_.PCI0.LPCB.SIOD.POUT._PS3)
000049fb:             ArgCount 0; NotSerialized
000049fc:             <NULL>
00004a00:             0x01
00004a02:             If
00004a04:               LEqual
00004a05:                 And
00004a06:                   <NULL>
00004a0a:                   0xf0
00004a0c:                   0xe0
00004a0e:                 ZeroOp
00004a0f:               0x00
00004a11:               <NULL>
00004a15:               0x30
00004a17:               0x00
00004a19:         Device PBID (\_SB_.PCI0.LPCB.SIOD.PBID)
00004a21:           Name _HID (\_SB_.PCI0.LPCB.SIOD.PBID._HID)
00004a26:             PNP0400 (0x0004d041)
00004a2b:           Name _UID (\_SB_.PCI0.LPCB.SIOD.PBID._UID)
00004a30:             0x02
00004a32:           Method _EJD (\_SB_.PCI0.LPCB.SIOD.PBID._EJD)
00004a38:             ArgCount 0; NotSerialized
00004a39:             If
00004a3b:               LEqual
00004a3c:                 OSYS (0000017a)
00004a40:                 0x07d0
00004a43:               Return
00004a44:                 "\_SB.PCI0.LPCB.MBRD"
00004a59:             Return
00004a5a:               "\_SB.MEDB"
00004a65:           Method _STA (\_SB_.PCI0.LPCB.SIOD.PBID._STA)
00004a6c:             ArgCount 0; NotSerialized
00004a6d:             If
00004a6f:               LEqual
00004a70:                 <NULL>
00004a74:                 ZeroOp
00004a75:               Return
00004a76:                 0x00
00004a78:             <NULL>
00004a7c:             0x01
00004a7e:             If
00004a80:               LEqual
00004a81:                 And
00004a82:                   <NULL>
00004a86:                   0xf0
00004a88:                   0xe0
00004a8a:                 ZeroOp
00004a8b:               0x20
00004a8d:               If
00004a8f:                 LPTP (000001db)
00004a93:                 <NULL>
00004a97:                 0x01
00004a99:                 If
00004a9b:                   <NULL>
00004a9f:                   0x30
00004aa1:                   Return
00004aa2:                     0x0f
00004aa4:                 Return
00004aa5:                   0x0d
00004aa7:             Return
00004aa8:               0x00
00004aaa:           Method _DIS (\_SB_.PCI0.LPCB.SIOD.PBID._DIS)
00004ab0:             ArgCount 0; NotSerialized
00004ab1:             <NULL>
00004ab5:             0x01
00004ab7:             If
00004ab9:               LEqual
00004aba:                 And
00004abb:                   <NULL>
00004abf:                   0xf0
00004ac1:                   0xe0
00004ac3:                 ZeroOp
00004ac4:               0x20
00004ac6:               <NULL>
00004aca:               0x30
00004acc:               0x00
00004ace:             And
00004acf:               LDEN (00002efc)
00004ad3:               0xfb
00004ad5:               LDEN (00002efc)
00004ad9:           Method _CRS (\_SB_.PCI0.LPCB.SIOD.PBID._CRS)
00004ae0:             ArgCount 0; NotSerialized
00004ae1:             If
00004ae3:               LEqual
00004ae4:                 <NULL>
00004ae8:                 ZeroOp
00004ae9:               Name BUF1 (\_SB_.PCI0.LPCB.SIOD.PBID._CRS.)
00004aee:                 Buffer
00004af0:                   0x10
00004af2:                   ByteList <0x31 0x08 0x47 0x01 0x00 0x00 0x00 0x00 
00004af2:                   	      0x01 0x00 0x22 0x00 0x00 0x38 0x79 0x00>
00004af2:                   Interpreted as PnP Resource Descriptor:
00004af2:                   Start dependent functions
00004af2:                   good compatiblity; sub-optimal performance/robustness
00004af2:                   I/O Ports: 16 bit address decoding,
00004af2:                   minbase 0x0, maxbase 0x0, align 0x1, count 0x0
00004af2:                   IRQ mask: 0000000000000000
00004af2:                   Info: high true edge sensitive
00004af2:                   End dependent functions
00004af2:                   Bad checksum 0x55, should be 0
00004af2:                   
00004b02:               Return
00004b03:                 BUF1 (00004ae9)
00004b07:             Name BUF0 (\_SB_.PCI0.LPCB.SIOD.PBID._CRS.BUF0)
00004b0c:               Buffer
00004b0e:                 0x0d
00004b10:                 ByteList <0x47 0x01 0x78 0x03 0x78 0x03 0x01 0x04 
00004b10:                 	      0x22 0x80 0x00 0x79 0x00>
00004b10:                 Interpreted as PnP Resource Descriptor:
00004b10:                 I/O Ports: 16 bit address decoding,
00004b10:                 minbase 0x378, maxbase 0x378, align 0x1, count 0x4
00004b10:                 IRQ mask: 0000000100000000
00004b10:                 Info: high true edge sensitive
00004b10:                 Bad checksum 0x5e, should be 0
00004b10:                 
00004b1d:             <NULL>
00004b21:             0x01
00004b23:             If
00004b26:               LEqual
00004b27:                 And
00004b28:                   <NULL>
00004b2c:                   0xf0
00004b2e:                   0xe0
00004b30:                 ZeroOp
00004b31:               0x20
00004b33:               CreateByteField
00004b34:                 BUF0 (00004b07)
00004b38:                 0x02
00004b3a:                 IOL0
00004b3e:               CreateByteField
00004b3f:                 BUF0 (00004b07)
00004b43:                 0x03
00004b45:                 IOH0
00004b49:               CreateByteField
00004b4a:                 BUF0 (00004b07)
00004b4e:                 0x04
00004b50:                 IOL1
00004b54:               CreateByteField
00004b55:                 BUF0 (00004b07)
00004b59:                 0x05
00004b5b:                 IOH1
00004b5f:               CreateByteField
00004b60:                 BUF0 (00004b07)
00004b64:                 0x07
00004b66:                 LEN0
00004b6a:               CreateWordField
00004b6b:                 BUF0 (00004b07)
00004b6f:                 0x09
00004b71:                 IRQW
00004b75:               <NULL>
00004b79:               0x01
00004b7b:               Store
00004b7c:                 <NULL>
00004b80:                 0x61
00004b82:               IOL0
00004b86:               Store
00004b87:                 <NULL>
00004b8b:                 0x60
00004b8d:               IOH0
00004b91:               Store
00004b92:                 IOL0
00004b96:                 IOL1
00004b9a:               Store
00004b9b:                 IOH0
00004b9f:                 IOH1
00004ba3:               Store
00004ba4:                 0x04
00004ba6:                 LEN0
00004baa:               If
00004bac:                 And
00004bad:                   <NULL>
00004bb1:                   0x70
00004bb3:                   0x0f
00004bb5:                 ZeroOp
00004bb6:                 ShiftLeft
00004bb7:                   OneOp
00004bb8:                   And
00004bb9:                     <NULL>
00004bbd:                     0x70
00004bbf:                     0x0f
00004bc1:                   <NULL>
00004bc2:                 IRQW
00004bc6:               Else
00004bc8:                 Store
00004bc9:                   ZeroOp
00004bca:                   IRQW
00004bce:             Return
00004bcf:               BUF0 (00004b07)
00004bd3:           Method _PRS (\_SB_.PCI0.LPCB.SIOD.PBID._PRS)
00004bda:             ArgCount 0; NotSerialized
00004bdb:             If
00004bdd:               LEqual
00004bde:                 <NULL>
00004be2:                 ZeroOp
00004be3:               Name BUF1 (\_SB_.PCI0.LPCB.SIOD.PBID._PRS.)
00004be8:                 Buffer
00004bea:                   0x10
00004bec:                   ByteList <0x31 0x08 0x47 0x01 0x00 0x00 0x00 0x00 
00004bec:                   	      0x01 0x00 0x22 0x00 0x00 0x38 0x79 0x00>
00004bec:                   Interpreted as PnP Resource Descriptor:
00004bec:                   Start dependent functions
00004bec:                   good compatiblity; sub-optimal performance/robustness
00004bec:                   I/O Ports: 16 bit address decoding,
00004bec:                   minbase 0x0, maxbase 0x0, align 0x1, count 0x0
00004bec:                   IRQ mask: 0000000000000000
00004bec:                   Info: high true edge sensitive
00004bec:                   End dependent functions
00004bec:                   Bad checksum 0x55, should be 0
00004bec:                   
00004bfc:               Return
00004bfd:                 BUF1 (00004be3)
00004c01:             Name BUF0 (\_SB_.PCI0.LPCB.SIOD.PBID._PRS.BUF0)
00004c06:               Buffer
00004c09:                 0x51
00004c0b:                 ByteList <0x31 0x08 0x47 0x01 0x78 0x03 0x78 0x03 
00004c0b:                 	      0x01 0x04 0x22 0x80 0x00 0x31 0x08 0x47 
00004c0b:                 	      0x01 0x78 0x02 0x78 0x02 0x01 0x04 0x22 
00004c0b:                 	      0x80 0x00 0x31 0x08 0x47 0x01 0xbc 0x03 
00004c0b:                 	      0xbc 0x03 0x01 0x04 0x22 0x80 0x00 0x31 
00004c0b:                 	      0x08 0x47 0x01 0x78 0x03 0x78 0x03 0x01 
00004c0b:                 	      0x04 0x22 0x20 0x00 0x31 0x08 0x47 0x01 
00004c0b:                 	      0x78 0x02 0x78 0x02 0x01 0x04 0x22 0x20 
00004c0b:                 	      0x00 0x31 0x08 0x47 0x01 0xbc 0x03 0xbc 
00004c0b:                 	      0x03 0x01 0x04 0x22 0x20 0x00 0x38 0x79 
00004c0b:                 	      0x00>
00004c0b:                 Interpreted as PnP Resource Descriptor:
00004c0b:                 Start dependent functions
00004c0b:                 good compatiblity; sub-optimal performance/robustness
00004c0b:                 I/O Ports: 16 bit address decoding,
00004c0b:                 minbase 0x378, maxbase 0x378, align 0x1, count 0x4
00004c0b:                 IRQ mask: 0000000100000000
00004c0b:                 Info: high true edge sensitive
00004c0b:                 Start dependent functions
00004c0b:                 good compatiblity; sub-optimal performance/robustness
00004c0b:                 I/O Ports: 16 bit address decoding,
00004c0b:                 minbase 0x278, maxbase 0x278, align 0x1, count 0x4
00004c0b:                 IRQ mask: 0000000100000000
00004c0b:                 Info: high true edge sensitive
00004c0b:                 Start dependent functions
00004c0b:                 good compatiblity; sub-optimal performance/robustness
00004c0b:                 I/O Ports: 16 bit address decoding,
00004c0b:                 minbase 0x3bc, maxbase 0x3bc, align 0x1, count 0x4
00004c0b:                 IRQ mask: 0000000100000000
00004c0b:                 Info: high true edge sensitive
00004c0b:                 Start dependent functions
00004c0b:                 good compatiblity; sub-optimal performance/robustness
00004c0b:                 I/O Ports: 16 bit address decoding,
00004c0b:                 minbase 0x378, maxbase 0x378, align 0x1, count 0x4
00004c0b:                 IRQ mask: 0000000001000000
00004c0b:                 Info: high true edge sensitive
00004c0b:                 Start dependent functions
00004c0b:                 good compatiblity; sub-optimal performance/robustness
00004c0b:                 I/O Ports: 16 bit address decoding,
00004c0b:                 minbase 0x278, maxbase 0x278, align 0x1, count 0x4
00004c0b:                 IRQ mask: 0000000001000000
00004c0b:                 Info: high true edge sensitive
00004c0b:                 Start dependent functions
00004c0b:                 good compatiblity; sub-optimal performance/robustness
00004c0b:                 I/O Ports: 16 bit address decoding,
00004c0b:                 minbase 0x3bc, maxbase 0x3bc, align 0x1, count 0x4
00004c0b:                 IRQ mask: 0000000001000000
00004c0b:                 Info: high true edge sensitive
00004c0b:                 End dependent functions
00004c0b:                 Bad checksum 0x51, should be 0
00004c0b:                 
00004c5c:             Return
00004c5d:               BUF0 (00004c01)
00004c61:           Method _SRS (\_SB_.PCI0.LPCB.SIOD.PBID._SRS)
00004c68:             ArgCount 1; NotSerialized
00004c69:             CreateByteField
00004c6a:               Arg0
00004c6b:               0x02
00004c6d:               IOL0
00004c71:             CreateByteField
00004c72:               Arg0
00004c73:               0x03
00004c75:               IOH0
00004c79:             CreateWordField
00004c7a:               Arg0
00004c7b:               0x09
00004c7d:               IRQW
00004c81:             <NULL>
00004c85:             0x01
00004c87:             <NULL>
00004c8b:             0x30
00004c8d:             0x00
00004c8f:             <NULL>
00004c93:             0xf0
00004c95:             Or
00004c96:               0x20
00004c98:               And
00004c99:                 <NULL>
00004c9d:                 0xf0
00004c9f:                 0x0f
00004ca1:               <NULL>
00004ca2:             ZeroOp
00004ca3:             <NULL>
00004ca7:             0x74
00004ca9:             0x04
00004cab:             <NULL>
00004caf:             0x61
00004cb1:             IOL0
00004cb5:             <NULL>
00004cb9:             0x60
00004cbb:             IOH0
00004cbf:             FindSetRightBit
00004cc0:               IRQW
00004cc4:               Local0
00004cc5:             If
00004cc7:               LNotEqual
00004cc9:                 IRQW
00004ccd:                 ZeroOp
00004cce:               Decrement
00004ccf:                 Local0
00004cd0:             <NULL>
00004cd4:             0x70
00004cd6:             Local0
00004cd7:             And
00004cd8:               LDE1 (00002ef5)
00004cdc:               0xfc
00004cde:               LDE1 (00002ef5)
00004ce2:             If
00004ce4:               LEqual
00004ce5:                 IOH0
00004ce9:                 0x03
00004ceb:               If
00004ced:                 LEqual
00004cee:                   IOL0
00004cf2:                   0x78
00004cf4:                 Or
00004cf5:                   LDE1 (00002ef5)
00004cf9:                   0x00
00004cfb:                   LDE1 (00002ef5)
00004cff:               Else
00004d01:                 Or
00004d02:                   LDE1 (00002ef5)
00004d06:                   0x02
00004d08:                   LDE1 (00002ef5)
00004d0c:             Else
00004d0e:               Or
00004d0f:                 LDE1 (00002ef5)
00004d13:                 0x01
00004d15:                 LDE1 (00002ef5)
00004d19:             Or
00004d1a:               LDEN (00002efc)
00004d1e:               0x04
00004d20:               LDEN (00002efc)
00004d24:             If
00004d26:               <NULL>
00004d2a:               <NULL>
00004d2e:               0x01
00004d30:               <NULL>
00004d34:               0x30
00004d36:               0x01
00004d38:           Method _PS0 (\_SB_.PCI0.LPCB.SIOD.PBID._PS0)
00004d3e:             ArgCount 0; NotSerialized
00004d3f:             <NULL>
00004d43:             0x01
00004d45:             <NULL>
00004d49:             0x30
00004d4b:             0x01
00004d4d:             Or
00004d4e:               LDEN (00002efc)
00004d52:               0x04
00004d54:               LDEN (00002efc)
00004d58:           Method _PS3 (\_SB_.PCI0.LPCB.SIOD.PBID._PS3)
00004d5e:             ArgCount 0; NotSerialized
00004d5f:             <NULL>
00004d63:             0x01
00004d65:             If
00004d67:               LEqual
00004d68:                 And
00004d69:                   <NULL>
00004d6d:                   0xf0
00004d6f:                   0xe0
00004d71:                 ZeroOp
00004d72:               0x20
00004d74:               <NULL>
00004d78:               0x30
00004d7a:               0x00
00004d7c:         Device PECP (\_SB_.PCI0.LPCB.SIOD.PECP)
00004d84:           Name _HID (\_SB_.PCI0.LPCB.SIOD.PECP._HID)
00004d89:             PNP0401 (0x0104d041)
00004d8e:           Name _UID (\_SB_.PCI0.LPCB.SIOD.PECP._UID)
00004d93:             0x03
00004d95:           Method _EJD (\_SB_.PCI0.LPCB.SIOD.PECP._EJD)
00004d9b:             ArgCount 0; NotSerialized
00004d9c:             If
00004d9e:               LEqual
00004d9f:                 OSYS (0000017a)
00004da3:                 0x07d0
00004da6:               Return
00004da7:                 "\_SB.PCI0.LPCB.MBRD"
00004dbc:             Return
00004dbd:               "\_SB.MEDB"
00004dc8:           Method _STA (\_SB_.PCI0.LPCB.SIOD.PECP._STA)
00004dcf:             ArgCount 0; NotSerialized
00004dd0:             If
00004dd2:               LEqual
00004dd3:                 <NULL>
00004dd7:                 ZeroOp
00004dd8:               Return
00004dd9:                 0x00
00004ddb:             <NULL>
00004ddf:             0x01
00004de1:             If
00004de3:               LEqual
00004de4:                 And
00004de5:                   <NULL>
00004de9:                   0xf0
00004deb:                   0xe0
00004ded:                 ZeroOp
00004dee:               0xe0
00004df0:               If
00004df2:                 LPTP (000001db)
00004df6:                 <NULL>
00004dfa:                 0x01
00004dfc:                 If
00004dfe:                   <NULL>
00004e02:                   0x30
00004e04:                   Return
00004e05:                     0x0f
00004e07:                 Return
00004e08:                   0x0d
00004e0a:             Return
00004e0b:               0x00
00004e0d:           Method _DIS (\_SB_.PCI0.LPCB.SIOD.PECP._DIS)
00004e13:             ArgCount 0; NotSerialized
00004e14:             <NULL>
00004e18:             0x01
00004e1a:             If
00004e1c:               LEqual
00004e1d:                 And
00004e1e:                   <NULL>
00004e22:                   0xf0
00004e24:                   0xe0
00004e26:                 ZeroOp
00004e27:               0xe0
00004e29:               <NULL>
00004e2d:               0x30
00004e2f:               0x00
00004e31:             And
00004e32:               LDEN (00002efc)
00004e36:               0xfb
00004e38:               LDEN (00002efc)
00004e3c:           Method _CRS (\_SB_.PCI0.LPCB.SIOD.PECP._CRS)
00004e43:             ArgCount 0; NotSerialized
00004e44:             If
00004e46:               LEqual
00004e47:                 <NULL>
00004e4b:                 ZeroOp
00004e4c:               Name BUF1 (\_SB_.PCI0.LPCB.SIOD.PECP._CRS.)
00004e51:                 Buffer
00004e53:                   0x10
00004e55:                   ByteList <0x31 0x08 0x47 0x01 0x00 0x00 0x00 0x00 
00004e55:                   	      0x01 0x00 0x22 0x00 0x00 0x38 0x79 0x00>
00004e55:                   Interpreted as PnP Resource Descriptor:
00004e55:                   Start dependent functions
00004e55:                   good compatiblity; sub-optimal performance/robustness
00004e55:                   I/O Ports: 16 bit address decoding,
00004e55:                   minbase 0x0, maxbase 0x0, align 0x1, count 0x0
00004e55:                   IRQ mask: 0000000000000000
00004e55:                   Info: high true edge sensitive
00004e55:                   End dependent functions
00004e55:                   Bad checksum 0x55, should be 0
00004e55:                   
00004e65:               Return
00004e66:                 BUF1 (00004e4c)
00004e6a:             Name BUF0 (\_SB_.PCI0.LPCB.SIOD.PECP._CRS.BUF0)
00004e6f:               Buffer
00004e71:                 0x18
00004e73:                 ByteList <0x47 0x01 0x78 0x03 0x78 0x03 0x01 0x08 
00004e73:                 	      0x47 0x01 0x78 0x07 0x78 0x07 0x01 0x08 
00004e73:                 	      0x22 0x80 0x00 0x2a 0x02 0x01 0x79 0x00>
00004e73:                 Interpreted as PnP Resource Descriptor:
00004e73:                 I/O Ports: 16 bit address decoding,
00004e73:                 minbase 0x378, maxbase 0x378, align 0x1, count 0x8
00004e73:                 I/O Ports: 16 bit address decoding,
00004e73:                 minbase 0x778, maxbase 0x778, align 0x1, count 0x8
00004e73:                 IRQ mask: 0000000100000000
00004e73:                 Info: high true edge sensitive
00004e73:                 DMA mask: 00000100
00004e73:                 DMA channel speed: compatibility mode; transfer type: 8/16 bit
00004e73:                 Bad checksum 0xde, should be 0
00004e73:                 
00004e8b:             If
00004e8e:               LEqual
00004e8f:                 And
00004e90:                   <NULL>
00004e94:                   0xf0
00004e96:                   0xe0
00004e98:                 ZeroOp
00004e99:               0xe0
00004e9b:               CreateByteField
00004e9c:                 BUF0 (00004e6a)
00004ea0:                 0x02
00004ea2:                 IOL0
00004ea6:               CreateByteField
00004ea7:                 BUF0 (00004e6a)
00004eab:                 0x03
00004ead:                 IOH0
00004eb1:               CreateByteField
00004eb2:                 BUF0 (00004e6a)
00004eb6:                 0x04
00004eb8:                 IOL1
00004ebc:               CreateByteField
00004ebd:                 BUF0 (00004e6a)
00004ec1:                 0x05
00004ec3:                 IOH1
00004ec7:               CreateByteField
00004ec8:                 BUF0 (00004e6a)
00004ecc:                 0x07
00004ece:                 LEN0
00004ed2:               CreateByteField
00004ed3:                 BUF0 (00004e6a)
00004ed7:                 0x0a
00004ed9:                 IOL2
00004edd:               CreateByteField
00004ede:                 BUF0 (00004e6a)
00004ee2:                 0x0b
00004ee4:                 IOH2
00004ee8:               CreateByteField
00004ee9:                 BUF0 (00004e6a)
00004eed:                 0x0c
00004eef:                 IOL3
00004ef3:               CreateByteField
00004ef4:                 BUF0 (00004e6a)
00004ef8:                 0x0d
00004efa:                 IOH3
00004efe:               CreateByteField
00004eff:                 BUF0 (00004e6a)
00004f03:                 0x0f
00004f05:                 LEN1
00004f09:               CreateWordField
00004f0a:                 BUF0 (00004e6a)
00004f0e:                 0x11
00004f10:                 IRQW
00004f14:               CreateByteField
00004f15:                 BUF0 (00004e6a)
00004f19:                 0x14
00004f1b:                 DMA0
00004f1f:               <NULL>
00004f23:               0x01
00004f25:               Store
00004f26:                 <NULL>
00004f2a:                 0x61
00004f2c:               IOL0
00004f30:               Store
00004f31:                 <NULL>
00004f35:                 0x60
00004f37:               IOH0
00004f3b:               Store
00004f3c:                 IOL0
00004f40:                 IOL1
00004f44:               Store
00004f45:                 IOH0
00004f49:                 IOH1
00004f4d:               Store
00004f4e:                 IOL0
00004f52:                 IOL2
00004f56:               Store
00004f57:                 Add
00004f58:                   0x04
00004f5a:                   IOH0
00004f5e:                   <NULL>
00004f5f:                 IOH2
00004f63:               Store
00004f64:                 IOL0
00004f68:                 IOL3
00004f6c:               Store
00004f6d:                 Add
00004f6e:                   0x04
00004f70:                   IOH0
00004f74:                   <NULL>
00004f75:                 IOH3
00004f79:               Store
00004f7a:                 0x08
00004f7c:                 LEN0
00004f80:               Store
00004f81:                 0x08
00004f83:                 LEN1
00004f87:               And
00004f88:                 <NULL>
00004f8c:                 0x70
00004f8e:                 0x0f
00004f90:               Local0
00004f91:               If
00004f93:                 Local0
00004f94:                 ShiftLeft
00004f95:                   OneOp
00004f96:                   Local0
00004f97:                   IRQW
00004f9b:               Else
00004f9d:                 Store
00004f9e:                   ZeroOp
00004f9f:                   IRQW
00004fa3:               Store
00004fa4:                 <NULL>
00004fa8:                 0x74
00004faa:               Local0
00004fab:               If
00004fad:                 LEqual
00004fae:                   Local0
00004faf:                   0x04
00004fb1:                 Store
00004fb2:                   ZeroOp
00004fb3:                   DMA0
00004fb7:               Else
00004fb9:                 ShiftLeft
00004fba:                   OneOp
00004fbb:                   Local0
00004fbc:                   DMA0
00004fc0:             Return
00004fc1:               BUF0 (00004e6a)
00004fc5:           Method _PRS (\_SB_.PCI0.LPCB.SIOD.PECP._PRS)
00004fcc:             ArgCount 0; NotSerialized
00004fcd:             If
00004fcf:               LEqual
00004fd0:                 <NULL>
00004fd4:                 ZeroOp
00004fd5:               Name BUF1 (\_SB_.PCI0.LPCB.SIOD.PECP._PRS.)
00004fda:                 Buffer
00004fdc:                   0x10
00004fde:                   ByteList <0x31 0x08 0x47 0x01 0x00 0x00 0x00 0x00 
00004fde:                   	      0x01 0x00 0x22 0x00 0x00 0x38 0x79 0x00>
00004fde:                   Interpreted as PnP Resource Descriptor:
00004fde:                   Start dependent functions
00004fde:                   good compatiblity; sub-optimal performance/robustness
00004fde:                   I/O Ports: 16 bit address decoding,
00004fde:                   minbase 0x0, maxbase 0x0, align 0x1, count 0x0
00004fde:                   IRQ mask: 0000000000000000
00004fde:                   Info: high true edge sensitive
00004fde:                   End dependent functions
00004fde:                   Bad checksum 0x55, should be 0
00004fde:                   
00004fee:               Return
00004fef:                 BUF1 (00004fd5)
00004ff3:             Name BUF0 (\_SB_.PCI0.LPCB.SIOD.PECP._PRS.BUF0)
00004ff8:               Buffer
00004ffb:                 0xc3
00004ffd:                 ByteList <0x31 0x08 0x47 0x01 0x78 0x03 0x78 0x03 
00004ffd:                 	      0x01 0x08 0x47 0x01 0x78 0x07 0x78 0x07 
00004ffd:                 	      0x01 0x08 0x22 0x80 0x00 0x2a 0x08 0x01 
00004ffd:                 	      0x31 0x08 0x47 0x01 0x78 0x02 0x78 0x02 
00004ffd:                 	      0x01 0x08 0x47 0x01 0x78 0x06 0x78 0x06 
00004ffd:                 	      0x01 0x08 0x22 0x80 0x00 0x2a 0x08 0x01 
00004ffd:                 	      0x31 0x08 0x47 0x01 0x78 0x03 0x78 0x03 
00004ffd:                 	      0x01 0x08 0x47 0x01 0x78 0x07 0x78 0x07 
00004ffd:                 	      0x01 0x08 0x22 0x20 0x00 0x2a 0x08 0x01 
00004ffd:                 	      0x31 0x08 0x47 0x01 0x78 0x02 0x78 0x02 
00004ffd:                 	      0x01 0x08 0x47 0x01 0x78 0x06 0x78 0x06 
00004ffd:                 	      0x01 0x08 0x22 0x20 0x00 0x2a 0x08 0x01 
00004ffd:                 	      0x31 0x08 0x47 0x01 0x78 0x03 0x78 0x03 
00004ffd:                 	      0x01 0x08 0x47 0x01 0x78 0x07 0x78 0x07 
00004ffd:                 	      0x01 0x08 0x22 0x80 0x00 0x2a 0x02 0x01 
00004ffd:                 	      0x31 0x08 0x47 0x01 0x78 0x02 0x78 0x02 
00004ffd:                 	      0x01 0x08 0x47 0x01 0x78 0x06 0x78 0x06 
00004ffd:                 	      0x01 0x08 0x22 0x80 0x00 0x2a 0x02 0x01 
00004ffd:                 	      0x31 0x08 0x47 0x01 0x78 0x03 0x78 0x03 
00004ffd:                 	      0x01 0x08 0x47 0x01 0x78 0x07 0x78 0x07 
00004ffd:                 	      0x01 0x08 0x22 0x20 0x00 0x2a 0x02 0x01 
00004ffd:                 	      0x31 0x08 0x47 0x01 0x78 0x02 0x78 0x02 
00004ffd:                 	      0x01 0x08 0x47 0x01 0x78 0x06 0x78 0x06 
00004ffd:                 	      0x01 0x08 0x22 0x20 0x00 0x2a 0x02 0x01 
00004ffd:                 	      0x38 0x79 0x00>
000050c0:             Return
000050c1:               BUF0 (00004ff3)
000050c5:           Method _SRS (\_SB_.PCI0.LPCB.SIOD.PECP._SRS)
000050cc:             ArgCount 1; NotSerialized
000050cd:             CreateByteField
000050ce:               Arg0
000050cf:               0x02
000050d1:               IOL0
000050d5:             CreateByteField
000050d6:               Arg0
000050d7:               0x03
000050d9:               IOH0
000050dd:             CreateWordField
000050de:               Arg0
000050df:               0x11
000050e1:               IRQW
000050e5:             CreateByteField
000050e6:               Arg0
000050e7:               0x14
000050e9:               DMA0
000050ed:             <NULL>
000050f1:             0x01
000050f3:             <NULL>
000050f7:             0x30
000050f9:             0x00
000050fb:             <NULL>
000050ff:             0xf0
00005101:             Or
00005102:               0xf0
00005104:               <NULL>
00005108:               0xf0
0000510a:             ZeroOp
0000510b:             <NULL>
0000510f:             0x61
00005111:             IOL0
00005115:             <NULL>
00005119:             0x60
0000511b:             IOH0
0000511f:             FindSetRightBit
00005120:               IRQW
00005124:               Local0
00005125:             If
00005127:               LNotEqual
00005129:                 IRQW
0000512d:                 ZeroOp
0000512e:               Decrement
0000512f:                 Local0
00005130:             <NULL>
00005134:             0x70
00005136:             Local0
00005137:             FindSetRightBit
00005138:               DMA0
0000513c:               Local0
0000513d:             If
0000513f:               LNotEqual
00005141:                 DMA0
00005145:                 ZeroOp
00005146:               Decrement
00005147:                 Local0
00005148:             <NULL>
0000514c:             0x74
0000514e:             Local0
0000514f:             And
00005150:               LDE1 (00002ef5)
00005154:               0xfc
00005156:               LDE1 (00002ef5)
0000515a:             If
0000515c:               LEqual
0000515d:                 IOH0
00005161:                 0x03
00005163:               Or
00005164:                 LDE1 (00002ef5)
00005168:                 0x00
0000516a:                 LDE1 (00002ef5)
0000516e:             Else
00005170:               Or
00005171:                 LDE1 (00002ef5)
00005175:                 0x01
00005177:                 LDE1 (00002ef5)
0000517b:             Or
0000517c:               LDEN (00002efc)
00005180:               0x04
00005182:               LDEN (00002efc)
00005186:             If
00005188:               <NULL>
0000518c:               <NULL>
00005190:               0x01
00005192:               <NULL>
00005196:               0x30
00005198:               0x01
0000519a:           Method _PS0 (\_SB_.PCI0.LPCB.SIOD.PECP._PS0)
000051a0:             ArgCount 0; NotSerialized
000051a1:             <NULL>
000051a5:             0x01
000051a7:             <NULL>
000051ab:             0x30
000051ad:             0x01
000051af:             Or
000051b0:               LDEN (00002efc)
000051b4:               0x04
000051b6:               LDEN (00002efc)
000051ba:           Method _PS3 (\_SB_.PCI0.LPCB.SIOD.PECP._PS3)
000051c0:             ArgCount 0; NotSerialized
000051c1:             <NULL>
000051c5:             0x01
000051c7:             If
000051c9:               LEqual
000051ca:                 And
000051cb:                   <NULL>
000051cf:                   0xf0
000051d1:                   0xe0
000051d3:                 ZeroOp
000051d4:               0xe0
000051d6:               <NULL>
000051da:               0x30
000051dc:               0x00
000051de:       Device PS2K (\_SB_.PCI0.LPCB.PS2K)
000051e5:         Name _HID (\_SB_.PCI0.LPCB.PS2K._HID)
000051ea:           PNP0303 (0x0303d041)
000051ef:         Name _CRS (\_SB_.PCI0.LPCB.PS2K._CRS)
000051f4:           Buffer
000051f6:             0x16
000051f8:             ByteList <0x47 0x01 0x60 0x00 0x60 0x00 0x01 0x01 
000051f8:             	      0x47 0x01 0x64 0x00 0x64 0x00 0x01 0x01 
000051f8:             	      0x23 0x02 0x00 0x01 0x79 0x00>
000051f8:             Interpreted as PnP Resource Descriptor:
000051f8:             I/O Ports: 16 bit address decoding,
000051f8:             minbase 0x60, maxbase 0x60, align 0x1, count 0x1
000051f8:             I/O Ports: 16 bit address decoding,
000051f8:             minbase 0x64, maxbase 0x64, align 0x1, count 0x1
000051f8:             IRQ mask: 0000000000000100
000051f8:             Info: high true edge sensitive
000051f8:             Bad checksum 0xbb, should be 0
000051f8:             
0000520e:       Device PS2M (\_SB_.PCI0.LPCB.PS2M)
00005216:         Name _HID (\_SB_.PCI0.LPCB.PS2M._HID)
0000521b:           SYN0002 (0x02002e4f)
00005220:         Name _CID (\_SB_.PCI0.LPCB.PS2M._CID)
00005225:           PNP0f13 (0x130fd041)
0000522a:         Name _CRS (\_SB_.PCI0.LPCB.PS2M._CRS)
0000522f:           Buffer
00005231:             0x06
00005233:             ByteList <0x23 0x00 0x10 0x01 0x79 0x00>
00005233:             Interpreted as PnP Resource Descriptor:
00005233:             IRQ mask: 0010000000000000
00005233:             Info: high true edge sensitive
00005233:             Bad checksum 0xad, should be 0
00005233:             
00005239:         Name _PSC (\_SB_.PCI0.LPCB.PS2M._PSC)
0000523e:           0x00
00005240:         Method _PS0 (\_SB_.PCI0.LPCB.PS2M._PS0)
00005246:           ArgCount 0; NotSerialized
00005247:           Store
00005248:             OneOp
00005249:             \WEND (000003de)
0000524e:           Store
0000524f:             ZeroOp
00005250:             _PSC (00005239)
00005254:         Method _PS3 (\_SB_.PCI0.LPCB.PS2M._PS3)
0000525a:           ArgCount 0; NotSerialized
0000525b:           Store
0000525c:             0x03
0000525e:             _PSC (00005239)
00005262:     Device USB0 (\_SB_.PCI0.USB0)
00005269:       Name _ADR (\_SB_.PCI0.USB0._ADR)
0000526e:         0x001d0000
00005273:       Device HUB0 (\_SB_.PCI0.USB0.HUB0)
0000527a:         Name _ADR (\_SB_.PCI0.USB0.HUB0._ADR)
0000527f:           0x00
00005281:         Device POT0 (\_SB_.PCI0.USB0.HUB0.POT0)
00005288:           Name _ADR (\_SB_.PCI0.USB0.HUB0.POT0._ADR)
0000528d:             0x01
0000528f:         Device POT1 (\_SB_.PCI0.USB0.HUB0.POT1)
00005296:           Name _ADR (\_SB_.PCI0.USB0.HUB0.POT1._ADR)
0000529b:             0x02
0000529d:     Device USB1 (\_SB_.PCI0.USB1)
000052a5:       Name _ADR (\_SB_.PCI0.USB1._ADR)
000052aa:         0x001d0001
000052af:       Device HUB1 (\_SB_.PCI0.USB1.HUB1)
000052b6:         Name _ADR (\_SB_.PCI0.USB1.HUB1._ADR)
000052bb:           0x00
000052bd:         Device POT2 (\_SB_.PCI0.USB1.HUB1.POT2)
000052c4:           Name _ADR (\_SB_.PCI0.USB1.HUB1.POT2._ADR)
000052c9:             0x01
000052cb:           Name _EJD (\_SB_.PCI0.USB1.HUB1.POT2._EJD)
000052d0:             "\_SB.MEDB"
000052db:         Device POT3 (\_SB_.PCI0.USB1.HUB1.POT3)
000052e2:           Name _ADR (\_SB_.PCI0.USB1.HUB1.POT3._ADR)
000052e7:             0x02
000052e9:     Device USB2 (\_SB_.PCI0.USB2)
000052f1:       Name _ADR (\_SB_.PCI0.USB2._ADR)
000052f6:         0x001d0002
000052fb:       Device HUB2 (\_SB_.PCI0.USB2.HUB2)
00005303:         Name _ADR (\_SB_.PCI0.USB2.HUB2._ADR)
00005308:           0x00
0000530a:         Device POT4 (\_SB_.PCI0.USB2.HUB2.POT4)
00005311:           Name _ADR (\_SB_.PCI0.USB2.HUB2.POT4._ADR)
00005316:             0x01
00005318:           Name _EJD (\_SB_.PCI0.USB2.HUB2.POT4._EJD)
0000531d:             "\_SB.MEDB"
00005328:         Device POT5 (\_SB_.PCI0.USB2.HUB2.POT5)
0000532f:           Name _ADR (\_SB_.PCI0.USB2.HUB2.POT5._ADR)
00005334:             0x02
00005336:           Name _EJD (\_SB_.PCI0.USB2.HUB2.POT5._EJD)
0000533b:             "\_SB.MEDB"
00005346:     Device USB7 (\_SB_.PCI0.USB7)
0000534d:       Name _ADR (\_SB_.PCI0.USB7._ADR)
00005352:         0x001d0007
00005357:       Device RHUB (\_SB_.PCI0.USB7.RHUB)
0000535e:         Name _ADR (\_SB_.PCI0.USB7.RHUB._ADR)
00005363:           0x00
00005365:         Name _EJD (\_SB_.PCI0.USB7.RHUB._EJD)
0000536a:           "\_SB.MEDB"
00005375:     Name PUAL (\_SB_.PCI0.PUAL)
0000537a:       Package
0000537c:         0x01
0000537d:         0x001f0001
00005382:     Device IDEC (\_SB_.PCI0.IDEC)
0000538a:       Name _ADR (\_SB_.PCI0.IDEC._ADR)
0000538f:         0x001f0001
00005394:       OpRegion IDEC (\_SB_.PCI0.IDEC.IDEC)
0000539a:         PCI_Config
0000539b:         0x40
0000539d:         0x18
0000539f:       Field
000053a3:         IDEC (00005394)
000053a7:         AccessType: DWordAcc; LockRule: NoLock; UpdateRule: Preserve
000053a8:         NamedField PRIT
000053ad:         NamedField SECT
000053b2:         NamedField PSIT
000053b7:         NamedField SSIT
000053bc:         ReservedField
000053be:         NamedField SYNC
000053c3:         ReservedField
000053c5:         NamedField SDT0
000053ca:         ReservedField
000053cc:         NamedField SDT1
000053d1:         ReservedField
000053d3:         NamedField SDT2
000053d8:         ReservedField
000053da:         NamedField SDT3
000053df:         ReservedField
000053e2:         NamedField ICR0
000053e7:         NamedField ICR1
000053ec:         NamedField ICR2
000053f1:         NamedField ICR3
000053f6:         NamedField ICR4
000053fb:         NamedField ICR5
00005400:       Device PRID (\_SB_.PCI0.IDEC.PRID)
00005408:         Name _ADR (\_SB_.PCI0.IDEC.PRID._ADR)
0000540d:           0x00
0000540f:         Method _GTM (\_SB_.PCI0.IDEC.PRID._GTM)
00005416:           ArgCount 0; NotSerialized
00005417:           Name PBUF (\_SB_.PCI0.IDEC.PRID._GTM.PBUF)
0000541c:             Buffer
0000541e:               0x14
00005420:               ByteList <0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 
00005420:               	      0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 
00005420:               	      0x00 0x00 0x00 0x00>
00005434:           CreateDWordField
00005435:             PBUF (00005417)
00005439:             0x00
0000543b:             PIO0
0000543f:           CreateDWordField
00005440:             PBUF (00005417)
00005444:             0x04
00005446:             DMA0
0000544a:           CreateDWordField
0000544b:             PBUF (00005417)
0000544f:             0x08
00005451:             PIO1
00005455:           CreateDWordField
00005456:             PBUF (00005417)
0000545a:             0x0c
0000545c:             DMA1
00005460:           CreateDWordField
00005461:             PBUF (00005417)
00005465:             0x10
00005467:             FLAG
0000546b:           Store
0000546c:             <NULL>
00005470:             PRIT (000053a8)
00005474:           PIO0
00005478:           Store
00005479:             <NULL>
0000547d:             And
0000547e:               SYNC (000053be)
00005482:               0x01
00005484:               <NULL>
00005485:           And
00005486:             ICR3 (000053f1)
0000548a:             0x01
0000548c:             <NULL>
0000548d:           And
0000548e:             ICR0 (000053e2)
00005492:             0x01
00005494:             <NULL>
00005495:           SDT0 (000053c5)
00005499:           And
0000549a:             ICR1 (000053e7)
0000549e:             0x01
000054a0:             <NULL>
000054a1:           DMA0
000054a5:           If
000054a7:             LEqual
000054a8:               DMA0
000054ac:               0xffffffff
000054b1:             Store
000054b2:               PIO0
000054b6:               DMA0
000054ba:           If
000054bc:             And
000054bd:               PRIT (000053a8)
000054c1:               0x4000
000054c4:               <NULL>
000054c5:             If
000054c7:               LEqual
000054c8:                 And
000054c9:                   PRIT (000053a8)
000054cd:                   0x90
000054cf:                   <NULL>
000054d0:                 0x80
000054d2:               Store
000054d3:                 0x0384
000054d6:                 PIO1
000054da:             Else
000054dc:               Store
000054dd:                 <NULL>
000054e1:                 PSIT (000053b2)
000054e5:               PIO1
000054e9:           Else
000054eb:             Store
000054ec:               0xffffffff
000054f1:               PIO1
000054f5:           Store
000054f6:             <NULL>
000054fa:             And
000054fb:               SYNC (000053be)
000054ff:               0x02
00005501:               <NULL>
00005502:           And
00005503:             ICR3 (000053f1)
00005507:             0x02
00005509:             <NULL>
0000550a:           And
0000550b:             ICR0 (000053e2)
0000550f:             0x02
00005511:             <NULL>
00005512:           SDT1 (000053cc)
00005516:           And
00005517:             ICR1 (000053e7)
0000551b:             0x02
0000551d:             <NULL>
0000551e:           DMA1
00005522:           If
00005524:             LEqual
00005525:               DMA1
00005529:               0xffffffff
0000552e:             Store
0000552f:               PIO1
00005533:               DMA1
00005537:           Store
00005538:             <NULL>
0000553c:             And
0000553d:               SYNC (000053be)
00005541:               0x01
00005543:               <NULL>
00005544:           And
00005545:             SYNC (000053be)
00005549:             0x02
0000554b:             <NULL>
0000554c:           PRIT (000053a8)
00005550:           FLAG
00005554:           Return
00005555:             PBUF (00005417)
00005559:         Method _STM (\_SB_.PCI0.IDEC.PRID._STM)
00005560:           ArgCount 3; NotSerialized
00005561:           CreateDWordField
00005562:             Arg0
00005563:             0x00
00005565:             PIO0
00005569:           CreateDWordField
0000556a:             Arg0
0000556b:             0x04
0000556d:             DMA0
00005571:           CreateDWordField
00005572:             Arg0
00005573:             0x08
00005575:             PIO1
00005579:           CreateDWordField
0000557a:             Arg0
0000557b:             0x0c
0000557d:             DMA1
00005581:           CreateDWordField
00005582:             Arg0
00005583:             0x10
00005585:             FLAG
00005589:           Store
0000558a:             0x04
0000558c:             ICR2 (000053ec)
00005590:           If
00005593:             LEqual
00005594:               SizeOf
00005595:                 Arg1
00005596:               0x0200
00005599:             And
0000559a:               PRIT (000053a8)
0000559e:               0x40f0
000055a1:               PRIT (000053a8)
000055a5:             And
000055a6:               SYNC (000053be)
000055aa:               0x0e
000055ac:               SYNC (000053be)
000055b0:             Store
000055b1:               0x00
000055b3:               SDT0 (000053c5)
000055b7:             And
000055b8:               ICR0 (000053e2)
000055bc:               0x0e
000055be:               ICR0 (000053e2)
000055c2:             And
000055c3:               ICR1 (000053e7)
000055c7:               0x0e
000055c9:               ICR1 (000053e7)
000055cd:             And
000055ce:               ICR3 (000053f1)
000055d2:               0x0e
000055d4:               ICR3 (000053f1)
000055d8:             And
000055d9:               ICR5 (000053fb)
000055dd:               0x0e
000055df:               ICR5 (000053fb)
000055e3:             CreateWordField
000055e4:               Arg1
000055e5:               0x62
000055e7:               W490
000055eb:             CreateWordField
000055ec:               Arg1
000055ed:               0x6a
000055ef:               W530
000055f3:             CreateWordField
000055f4:               Arg1
000055f5:               0x7e
000055f7:               W630
000055fb:             CreateWordField
000055fc:               Arg1
000055fd:               0x80
000055ff:               W640
00005603:             CreateWordField
00005604:               Arg1
00005605:               0xb0
00005607:               W880
0000560b:             CreateWordField
0000560c:               Arg1
0000560d:               0xba
0000560f:               W930
00005613:             Or
00005614:               PRIT (000053a8)
00005618:               0x8004
0000561b:               PRIT (000053a8)
0000561f:             If
00005621:               LAnd
00005622:                 And
00005623:                   FLAG
00005627:                   0x02
00005629:                   <NULL>
0000562a:                 And
0000562b:                   W490
0000562f:                   0x0800
00005632:                   <NULL>
00005633:               Or
00005634:                 PRIT (000053a8)
00005638:                 0x02
0000563a:                 PRIT (000053a8)
0000563e:             Or
0000563f:               PRIT (000053a8)
00005643:               <NULL>
00005647:               PIO0
0000564b:             W530
0000564f:             W640
00005653:             PRIT (000053a8)
00005657:             If
0000565a:               And
0000565b:                 FLAG
0000565f:                 0x01
00005661:                 <NULL>
00005662:               Or
00005663:                 SYNC (000053be)
00005667:                 0x01
00005669:                 SYNC (000053be)
0000566d:               Store
0000566e:                 <NULL>
00005672:                 DMA0
00005676:               SDT0 (000053c5)
0000567a:               If
0000567c:                 LLess
0000567d:                   DMA0
00005681:                   0x1e
00005683:                 Or
00005684:                   ICR3 (000053f1)
00005688:                   0x01
0000568a:                   ICR3 (000053f1)
0000568e:               If
00005690:                 LLess
00005691:                   DMA0
00005695:                   0x3c
00005697:                 Or
00005698:                   ICR0 (000053e2)
0000569c:                   0x01
0000569e:                   ICR0 (000053e2)
000056a2:               If
000056a4:                 And
000056a5:                   W930
000056a9:                   0x2000
000056ac:                   <NULL>
000056ad:                 Or
000056ae:                   ICR1 (000053e7)
000056b2:                   0x01
000056b4:                   ICR1 (000053e7)
000056b8:           If
000056bb:             LEqual
000056bc:               SizeOf
000056bd:                 Arg2
000056be:               0x0200
000056c1:             And
000056c2:               PRIT (000053a8)
000056c6:               0x3f0f
000056c9:               PRIT (000053a8)
000056cd:             Store
000056ce:               0x00
000056d0:               PSIT (000053b2)
000056d4:             And
000056d5:               SYNC (000053be)
000056d9:               0x0d
000056db:               SYNC (000053be)
000056df:             Store
000056e0:               0x00
000056e2:               SDT1 (000053cc)
000056e6:             And
000056e7:               ICR0 (000053e2)
000056eb:               0x0d
000056ed:               ICR0 (000053e2)
000056f1:             And
000056f2:               ICR1 (000053e7)
000056f6:               0x0d
000056f8:               ICR1 (000053e7)
000056fc:             And
000056fd:               ICR3 (000053f1)
00005701:               0x0d
00005703:               ICR3 (000053f1)
00005707:             And
00005708:               ICR5 (000053fb)
0000570c:               0x0d
0000570e:               ICR5 (000053fb)
00005712:             CreateWordField
00005713:               Arg2
00005714:               0x62
00005716:               W491
0000571a:             CreateWordField
0000571b:               Arg2
0000571c:               0x6a
0000571e:               W531
00005722:             CreateWordField
00005723:               Arg2
00005724:               0x7e
00005726:               W631
0000572a:             CreateWordField
0000572b:               Arg2
0000572c:               0x80
0000572e:               W641
00005732:             CreateWordField
00005733:               Arg2
00005734:               0xb0
00005736:               W881
0000573a:             CreateWordField
0000573b:               Arg2
0000573c:               0xba
0000573e:               W931
00005742:             Or
00005743:               PRIT (000053a8)
00005747:               0x8040
0000574a:               PRIT (000053a8)
0000574e:             If
00005750:               LAnd
00005751:                 And
00005752:                   FLAG
00005756:                   0x08
00005758:                   <NULL>
00005759:                 And
0000575a:                   W491
0000575e:                   0x0800
00005761:                   <NULL>
00005762:               Or
00005763:                 PRIT (000053a8)
00005767:                 0x20
00005769:                 PRIT (000053a8)
0000576d:             If
00005770:               And
00005771:                 FLAG
00005775:                 0x10
00005777:                 <NULL>
00005778:               Or
00005779:                 PRIT (000053a8)
0000577d:                 0x4000
00005780:                 PRIT (000053a8)
00005784:               If
00005786:                 LGreater
00005787:                   PIO1
0000578b:                   0xf0
0000578d:                 Or
0000578e:                   PRIT (000053a8)
00005792:                   0x80
00005794:                   PRIT (000053a8)
00005798:               Else
0000579a:                 Or
0000579b:                   PRIT (000053a8)
0000579f:                   0x10
000057a1:                   PRIT (000053a8)
000057a5:                 Store
000057a6:                   <NULL>
000057aa:                   PIO1
000057ae:                 W531
000057b2:                 W641
000057b6:                 PSIT (000053b2)
000057ba:             If
000057bd:               And
000057be:                 FLAG
000057c2:                 0x04
000057c4:                 <NULL>
000057c5:               Or
000057c6:                 SYNC (000053be)
000057ca:                 0x02
000057cc:                 SYNC (000053be)
000057d0:               Store
000057d1:                 <NULL>
000057d5:                 DMA1
000057d9:               SDT1 (000053cc)
000057dd:               If
000057df:                 LLess
000057e0:                   DMA1
000057e4:                   0x1e
000057e6:                 Or
000057e7:                   ICR3 (000053f1)
000057eb:                   0x02
000057ed:                   ICR3 (000053f1)
000057f1:               If
000057f3:                 LLess
000057f4:                   DMA1
000057f8:                   0x3c
000057fa:                 Or
000057fb:                   ICR0 (000053e2)
000057ff:                   0x02
00005801:                   ICR0 (000053e2)
00005805:               If
00005807:                 And
00005808:                   W931
0000580c:                   0x2000
0000580f:                   <NULL>
00005810:                 Or
00005811:                   ICR1 (000053e7)
00005815:                   0x02
00005817:                   ICR1 (000053e7)
0000581b:         Device P_D0 (\_SB_.PCI0.IDEC.PRID.P_D0)
00005823:           Name _ADR (\_SB_.PCI0.IDEC.PRID.P_D0._ADR)
00005828:             0x00
0000582a:           Method _GTF (\_SB_.PCI0.IDEC.PRID.P_D0._GTF)
00005831:             ArgCount 0; NotSerialized
00005832:             Name PIB0 (\_SB_.PCI0.IDEC.PRID.P_D0._GTF.PIB0)
00005837:               Buffer
00005839:                 0x0e
0000583b:                 ByteList <0x03 0x00 0x00 0x00 0x00 0xa0 0xef 0x03 
0000583b:                 	      0x00 0x00 0x00 0x00 0xa0 0xef>
00005849:             CreateByteField
0000584a:               PIB0 (00005832)
0000584e:               0x01
00005850:               PMD0
00005854:             CreateByteField
00005855:               PIB0 (00005832)
00005859:               0x08
0000585b:               DMD0
0000585f:             If
00005862:               And
00005863:                 PRIT (000053a8)
00005867:                 0x02
00005869:                 <NULL>
0000586a:               If
0000586c:                 LEqual
0000586d:                   And
0000586e:                     PRIT (000053a8)
00005872:                     0x09
00005874:                     <NULL>
00005875:                   0x08
00005877:                 Store
00005878:                   0x08
0000587a:                   PMD0
0000587e:               Else
00005881:                 Store
00005882:                   0x0a
00005884:                   PMD0
00005888:                 ShiftRight
00005889:                   And
0000588a:                     PRIT (000053a8)
0000588e:                     0x0300
00005891:                     <NULL>
00005892:                   0x08
00005894:                   Local0
00005895:                 ShiftRight
00005896:                   And
00005897:                     PRIT (000053a8)
0000589b:                     0x3000
0000589e:                     <NULL>
0000589f:                   0x0c
000058a1:                   Local1
000058a2:                 Add
000058a3:                   Local0
000058a4:                   Local1
000058a5:                   Local2
000058a6:                 If
000058a8:                   LEqual
000058a9:                     0x03
000058ab:                     Local2
000058ac:                   Store
000058ad:                     0x0b
000058af:                     PMD0
000058b3:                 If
000058b5:                   LEqual
000058b6:                     0x05
000058b8:                     Local2
000058b9:                   Store
000058ba:                     0x0c
000058bc:                     PMD0
000058c0:             Else
000058c2:               Store
000058c3:                 0x01
000058c5:                 PMD0
000058c9:             If
000058cc:               And
000058cd:                 SYNC (000053be)
000058d1:                 0x01
000058d3:                 <NULL>
000058d4:               Store
000058d5:                 Or
000058d6:                   SDT0 (000053c5)
000058da:                   0x40
000058dc:                   <NULL>
000058dd:                 DMD0
000058e1:               If
000058e3:                 And
000058e4:                   ICR1 (000053e7)
000058e8:                   0x01
000058ea:                   <NULL>
000058eb:                 If
000058ed:                   And
000058ee:                     ICR0 (000053e2)
000058f2:                     0x01
000058f4:                     <NULL>
000058f5:                   Add
000058f6:                     DMD0
000058fa:                     0x02
000058fc:                     DMD0
00005900:                 If
00005902:                   And
00005903:                     ICR3 (000053f1)
00005907:                     0x01
00005909:                     <NULL>
0000590a:                   Store
0000590b:                     0x45
0000590d:                     DMD0
00005911:             Else
00005913:               Or
00005914:                 Subtract
00005915:                   And
00005916:                     PMD0
0000591a:                     0x07
0000591c:                     <NULL>
0000591d:                   0x02
0000591f:                   <NULL>
00005920:                 0x20
00005922:                 DMD0
00005926:             Return
00005927:               PIB0 (00005832)
0000592b:         Device P_D1 (\_SB_.PCI0.IDEC.PRID.P_D1)
00005933:           Name _ADR (\_SB_.PCI0.IDEC.PRID.P_D1._ADR)
00005938:             0x01
0000593a:           Method _GTF (\_SB_.PCI0.IDEC.PRID.P_D1._GTF)
00005941:             ArgCount 0; NotSerialized
00005942:             Name PIB1 (\_SB_.PCI0.IDEC.PRID.P_D1._GTF.PIB1)
00005947:               Buffer
00005949:                 0x0e
0000594b:                 ByteList <0x03 0x00 0x00 0x00 0x00 0xb0 0xef 0x03 
0000594b:                 	      0x00 0x00 0x00 0x00 0xb0 0xef>
00005959:             CreateByteField
0000595a:               PIB1 (00005942)
0000595e:               0x01
00005960:               PMD1
00005964:             CreateByteField
00005965:               PIB1 (00005942)
00005969:               0x08
0000596b:               DMD1
0000596f:             If
00005972:               And
00005973:                 PRIT (000053a8)
00005977:                 0x20
00005979:                 <NULL>
0000597a:               If
0000597c:                 LEqual
0000597d:                   And
0000597e:                     PRIT (000053a8)
00005982:                     0x90
00005984:                     <NULL>
00005985:                   0x80
00005987:                 Store
00005988:                   0x08
0000598a:                   PMD1
0000598e:               Else
00005990:                 Add
00005991:                   And
00005992:                     PSIT (000053b2)
00005996:                     0x03
00005998:                     <NULL>
00005999:                   ShiftRight
0000599a:                     And
0000599b:                       PSIT (000053b2)
0000599f:                       0x0c
000059a1:                       <NULL>
000059a2:                     0x02
000059a4:                     <NULL>
000059a5:                   Local0
000059a6:                 If
000059a8:                   LEqual
000059a9:                     0x05
000059ab:                     Local0
000059ac:                   Store
000059ad:                     0x0c
000059af:                     PMD1
000059b3:                 Else
000059b5:                   If
000059b7:                     LEqual
000059b8:                       0x03
000059ba:                       Local0
000059bb:                     Store
000059bc:                       0x0b
000059be:                       PMD1
000059c2:                   Else
000059c4:                     Store
000059c5:                       0x0a
000059c7:                       PMD1
000059cb:             Else
000059cd:               Store
000059ce:                 0x01
000059d0:                 PMD1
000059d4:             If
000059d7:               And
000059d8:                 SYNC (000053be)
000059dc:                 0x02
000059de:                 <NULL>
000059df:               Store
000059e0:                 Or
000059e1:                   SDT1 (000053cc)
000059e5:                   0x40
000059e7:                   <NULL>
000059e8:                 DMD1
000059ec:               If
000059ee:                 And
000059ef:                   ICR1 (000053e7)
000059f3:                   0x02
000059f5:                   <NULL>
000059f6:                 If
000059f8:                   And
000059f9:                     ICR0 (000053e2)
000059fd:                     0x02
000059ff:                     <NULL>
00005a00:                   Add
00005a01:                     DMD1
00005a05:                     0x02
00005a07:                     DMD1
00005a0b:                 If
00005a0d:                   And
00005a0e:                     ICR3 (000053f1)
00005a12:                     0x02
00005a14:                     <NULL>
00005a15:                   Store
00005a16:                     0x45
00005a18:                     DMD1
00005a1c:             Else
00005a1e:               Or
00005a1f:                 Subtract
00005a20:                   And
00005a21:                     PMD1
00005a25:                     0x07
00005a27:                     <NULL>
00005a28:                   0x02
00005a2a:                   <NULL>
00005a2b:                 0x20
00005a2d:                 DMD1
00005a31:             Return
00005a32:               PIB1 (00005942)
00005a36:         Method _PS0 (\_SB_.PCI0.IDEC.PRID._PS0)
00005a3c:           ArgCount 0; NotSerialized
00005a3d:         Method _PS3 (\_SB_.PCI0.IDEC.PRID._PS3)
00005a43:           ArgCount 0; NotSerialized
00005a44:       Method GETP (\_SB_.PCI0.IDEC.GETP)
00005a4b:         ArgCount 1; Serialized
00005a4c:         If
00005a4e:           LEqual
00005a4f:             And
00005a50:               Arg0
00005a51:               0x09
00005a53:               <NULL>
00005a54:             0x00
00005a56:           Return
00005a57:             0xffffffff
00005a5c:         If
00005a5e:           LEqual
00005a5f:             And
00005a60:               Arg0
00005a61:               0x09
00005a63:               <NULL>
00005a64:             0x08
00005a66:           Return
00005a67:             0x0384
00005a6a:         ShiftRight
00005a6b:           And
00005a6c:             Arg0
00005a6d:             0x0300
00005a70:             <NULL>
00005a71:           0x08
00005a73:           Local0
00005a74:         ShiftRight
00005a75:           And
00005a76:             Arg0
00005a77:             0x3000
00005a7a:             <NULL>
00005a7b:           0x0c
00005a7d:           Local1
00005a7e:         Return
00005a7f:           Multiply
00005a80:             0x1e
00005a82:             Subtract
00005a83:               0x09
00005a85:               Add
00005a86:                 Local0
00005a87:                 Local1
00005a88:                 <NULL>
00005a89:               <NULL>
00005a8a:             <NULL>
00005a8b:       Method GDMA (\_SB_.PCI0.IDEC.GDMA)
00005a91:         ArgCount 5; Serialized
00005a92:         If
00005a94:           Arg0
00005a95:           If
00005a97:             LAnd
00005a98:               Arg1
00005a99:               Arg4
00005a9a:             Return
00005a9b:               0x14
00005a9d:           If
00005a9f:             LAnd
00005aa0:               Arg2
00005aa1:               Arg4
00005aa2:             Return
00005aa3:               Multiply
00005aa4:                 Subtract
00005aa5:                   0x04
00005aa7:                   Arg3
00005aa8:                   <NULL>
00005aa9:                 0x0f
00005aab:                 <NULL>
00005aac:           Return
00005aad:             Multiply
00005aae:               Subtract
00005aaf:                 0x04
00005ab1:                 Arg3
00005ab2:                 <NULL>
00005ab3:               0x1e
00005ab5:               <NULL>
00005ab6:         Return
00005ab7:           0xffffffff
00005abc:       Method GETT (\_SB_.PCI0.IDEC.GETT)
00005ac2:         ArgCount 1; Serialized
00005ac3:         Return
00005ac4:           Multiply
00005ac5:             0x1e
00005ac7:             Subtract
00005ac8:               0x09
00005aca:               Add
00005acb:                 And
00005acc:                   ShiftRight
00005acd:                     Arg0
00005ace:                     0x02
00005ad0:                     <NULL>
00005ad1:                   0x03
00005ad3:                   <NULL>
00005ad4:                 And
00005ad5:                   Arg0
00005ad6:                   0x03
00005ad8:                   <NULL>
00005ad9:                 <NULL>
00005ada:               <NULL>
00005adb:             <NULL>
00005adc:       Method GETF (\_SB_.PCI0.IDEC.GETF)
00005ae3:         ArgCount 3; Serialized
00005ae4:         Name TMPF (\_SB_.PCI0.IDEC.GETF.TMPF)
00005ae9:           0x00
00005aeb:         If
00005aed:           Arg0
00005aee:           Or
00005aef:             TMPF (00005ae4)
00005af3:             0x01
00005af5:             TMPF (00005ae4)
00005af9:         If
00005afb:           And
00005afc:             Arg2
00005afd:             0x02
00005aff:             <NULL>
00005b00:           Or
00005b01:             TMPF (00005ae4)
00005b05:             0x02
00005b07:             TMPF (00005ae4)
00005b0b:         If
00005b0d:           Arg1
00005b0e:           Or
00005b0f:             TMPF (00005ae4)
00005b13:             0x04
00005b15:             TMPF (00005ae4)
00005b19:         If
00005b1b:           And
00005b1c:             Arg2
00005b1d:             0x20
00005b1f:             <NULL>
00005b20:           Or
00005b21:             TMPF (00005ae4)
00005b25:             0x08
00005b27:             TMPF (00005ae4)
00005b2b:         If
00005b2d:           And
00005b2e:             Arg2
00005b2f:             0x4000
00005b32:             <NULL>
00005b33:           Or
00005b34:             TMPF (00005ae4)
00005b38:             0x10
00005b3a:             TMPF (00005ae4)
00005b3e:         Return
00005b3f:           TMPF (00005ae4)
00005b43:       Method SETP (\_SB_.PCI0.IDEC.SETP)
00005b49:         ArgCount 3; Serialized
00005b4a:         If
00005b4c:           LGreater
00005b4d:             Arg0
00005b4e:             0xf0
00005b50:           Return
00005b51:             0x08
00005b53:         Else
00005b55:           If
00005b57:             And
00005b58:               Arg1
00005b59:               0x02
00005b5b:               <NULL>
00005b5c:             If
00005b5e:               LAnd
00005b5f:                 LLessEqual
00005b61:                   Arg0
00005b62:                   0x78
00005b64:                 And
00005b65:                   Arg2
00005b66:                   0x02
00005b68:                   <NULL>
00005b69:               Return
00005b6a:                 0x2301
00005b6d:             If
00005b6f:               LAnd
00005b70:                 LLessEqual
00005b72:                   Arg0
00005b73:                   0xb4
00005b75:                 And
00005b76:                   Arg2
00005b77:                   0x01
00005b79:                   <NULL>
00005b7a:               Return
00005b7b:                 0x2101
00005b7e:           Return
00005b7f:             0x1001
00005b82:       Method SDMA (\_SB_.PCI0.IDEC.SDMA)
00005b88:         ArgCount 1; Serialized
00005b89:         If
00005b8b:           LLessEqual
00005b8d:             Arg0
00005b8e:             0x14
00005b90:           Return
00005b91:             0x01
00005b93:         If
00005b95:           LLessEqual
00005b97:             Arg0
00005b98:             0x1e
00005b9a:           Return
00005b9b:             0x02
00005b9d:         If
00005b9f:           LLessEqual
00005ba1:             Arg0
00005ba2:             0x2d
00005ba4:           Return
00005ba5:             0x01
00005ba7:         If
00005ba9:           LLessEqual
00005bab:             Arg0
00005bac:             0x3c
00005bae:           Return
00005baf:             0x02
00005bb1:         If
00005bb3:           LLessEqual
00005bb5:             Arg0
00005bb6:             0x5a
00005bb8:           Return
00005bb9:             0x01
00005bbb:         Return
00005bbc:           0x00
00005bbe:       Method SETT (\_SB_.PCI0.IDEC.SETT)
00005bc4:         ArgCount 3; Serialized
00005bc5:         If
00005bc7:           And
00005bc8:             Arg1
00005bc9:             0x02
00005bcb:             <NULL>
00005bcc:           If
00005bce:             LAnd
00005bcf:               LLessEqual
00005bd1:                 Arg0
00005bd2:                 0x78
00005bd4:               And
00005bd5:                 Arg2
00005bd6:                 0x02
00005bd8:                 <NULL>
00005bd9:             Return
00005bda:               0x0b
00005bdc:           If
00005bde:             LAnd
00005bdf:               LLessEqual
00005be1:                 Arg0
00005be2:                 0xb4
00005be4:               And
00005be5:                 Arg2
00005be6:                 0x01
00005be8:                 <NULL>
00005be9:             Return
00005bea:               0x09
00005bec:         Return
00005bed:           0x04
00005bef:     Device SBUS (\_SB_.PCI0.SBUS)
00005bf6:       Name _ADR (\_SB_.PCI0.SBUS._ADR)
00005bfb:         0x001f0003
00005c00:     Device AUD0 (\_SB_.PCI0.AUD0)
00005c07:       Name _ADR (\_SB_.PCI0.AUD0._ADR)
00005c0c:         0x001f0005
00005c11:     Device MODM (\_SB_.PCI0.MODM)
00005c18:       Name _ADR (\_SB_.PCI0.MODM._ADR)
00005c1d:         0x001f0006
00005c22:       Name _PRW (\_SB_.PCI0.MODM._PRW)
00005c27:         Package
00005c29:           0x02
00005c2a:           0x05
00005c2c:           0x03

--------------080601090100060707060206
Content-Type: text/plain;
 name="dmi-decode.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmi-decode.txt"

SYSID present.
SMBIOS 2.3 present.
DMI 2.3 present.
36 structures occupying 1194 bytes.
DMI table at 0x000D8010.
Handle 0x0000
	DMI type 208, 10 bytes.
	01 04 fe 00 50 01                               	....P.          
Handle 0x0001
	DMI type 212, 77 bytes.
	72 00 73 00 01 61 63 7f 2d 00 61 fd 02 2e 00 61 	r.s..ac.-.a....a
	fd 00 42 00 61 fe 01 43 00 61 fe 00 55 00 61 ef 	..B.a..C.a..U.a.
	00 57 00 61 ef 10 5c 00 60 f0 05 5d 00 60 f0 00 	.W.a..\.`..].`..
	93 00 62 fc 02 94 00 62 fc 00 e8 00 61 fb 04 e9 	..b....b....a...
	00 61 fb 00 ff ff 00 00 00                      	.a.......       
Handle 0x0002
	DMI type 218, 23 bytes.
	b2 00 de 1f 0f 1a 00 7d 00 49 00 04 00 ff ff 00 	.......}.I......
	00 00 00                                        	...             
Handle 0x0003
	DMI type 222, 13 bytes.
	39 04 ff ff 00 00 00 00 00                      	9........       
Handle 0x0004
	DMI type 0, 20 bytes.
	BIOS Information Block
		Vendor: Phoenix Technologies LTD
		Version: A03  
		Release: 08/25/2003
		BIOS base: 0xE0000
		ROM size: 960K
		Capabilities:
			Flags: 0x001300003C01DF80
Handle 0x0005
	DMI type 1, 25 bytes.
	System Information Block
		Vendor: Dell Computer Corporation
		Product: Inspiron 300m
		Version: A03
		Serial Number: 5W0LH31
Handle 0x0006
	DMI type 2, 8 bytes.
	Board Information Block
		Vendor: Dell Computer Corporation
		Product: 0X0024
		Version: X04
		Serial Number: CN365213930069  
Handle 0x0007
	DMI type 3, 17 bytes.
	Chassis Information Block
		Vendor: Dell Computer Corporation
		Chassis Type: Portable
		Version: 00h
		Serial Number: 5W0LH31
		Asset Tag:             
Handle 0x0008
	DMI type 3, 17 bytes.
	Chassis Information Block
		Vendor: Dell Computer Corporation
		Chassis Type: Docking Station
		Version: 00h
		Serial Number: 5W0LH31
		Asset Tag:             
Handle 0x0009
	DMI type 4, 35 bytes.
	Processor
		Socket Designation: U1
		Processor Type: Central Processor
		Processor Family: 
		Processor Manufacturer: Intel
		Processor Version: A0
		Serial Number: (null)
		Asset Tag: (null)
		Vendor Part Number: (null)
Handle 0x000A
	DMI type 5, 22 bytes.
	Memory Controller
Handle 0x000B
	DMI type 6, 12 bytes.
	Memory Bank
		Socket: M1
		Banks: 0 1
		Type: 
		Installed Size: 1024Mbyte (Double sided)
		Enabled Size: 1024Mbyte (Double sided)
Handle 0x000C
	DMI type 6, 12 bytes.
	Memory Bank
		Socket: M2
		Banks: 2 3
		Type: 
		Installed Size: 128Mbyte
		Enabled Size: 128Mbyte
Handle 0x000D
	DMI type 7, 19 bytes.
	Cache
		Socket: L1 Cache
		L1 socketed Internal Cache: write-back
		L1 Cache Size: 16K
		L1 Cache Maximum: 16K
		L1 Cache Type: Asynchronous 
Handle 0x000E
	DMI type 7, 19 bytes.
	Cache
		Socket: L2 Cache
		L2 socketed External Cache: write-back
		L2 Cache Size: 512K
		L2 Cache Maximum: 1024K
		L2 Cache Type: Burst 
Handle 0x000F
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: J19
		Internal Connector Type: 9 Pin Dual Inline (pin 10 cut)
		External Designator: COM 1
		External Connector Type: DB-9 pin male
		Port Type: Serial Port 16650A Compatible
Handle 0x0010
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: J23
		Internal Connector Type: 25 Pin Dual Inline (pin 26 cut)
		External Designator: Parallel
		External Connector Type: DB-25 pin female
		Port Type: Parallel Port ECP/EPP
Handle 0x0011
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: J11
		Internal Connector Type: None
		External Designator: Keyboard
		External Connector Type: Circular DIN-8 male
		Port Type: Keyboard Port
Handle 0x0012
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: J12
		Internal Connector Type: None
		External Designator: PS/2 Mouse
		External Connector Type: Circular DIN-8 male
		Port Type: Keyboard Port
Handle 0x0013
	DMI type 9, 13 bytes.
	Card Slot
		Slot: PCI Slot J11
		Type: 32bit Long PCI 
		Status: In use.
		Slot Features: 5v 3.3v 
Handle 0x0014
	DMI type 9, 13 bytes.
	Card Slot
		Slot: PCI Slot J12
		Type: 32bit Long PCI 
		Slot Features: 5v 3.3v 
Handle 0x0015
	DMI type 9, 13 bytes.
	Card Slot
		Slot: PCI Slot J13
		Type: 32bit Long PCI 
		Slot Features: 5v 3.3v 
Handle 0x0016
	DMI type 10, 6 bytes.
	On Board Devices Information
		Description: ADI : Disabled
		Type: Sound
Handle 0x0017
	DMI type 11, 5 bytes.
	OEM Data
		Dell System
		1[0150]
		3[1.0]
		4[0001]
		6[DA]
Handle 0x0018
	DMI type 15, 29 bytes.
	Event Log
		Log Area: 0 bytes.
		Log Header At: 0.
		Log Data At: 16.
		Log Type: 4.
Handle 0x0019
	DMI type 16, 15 bytes.
	Physical Memory Array
		Location: System board or motherboard
		Use: System memory
		Error Correction Type: None
		Maximum Capacity: 3145728 Kbyte
		Error Information Handle: Not Provided
		Number of Devices: 2
Handle 0x001A
	DMI type 17, 27 bytes.
	Memory Device
		Array Handle: 0x0019
		Error Information Handle: None
		Total Width: 32 bits
		Data Width: 32 bits
		Size: 1024 Mbyte
		Form Factor: SODIMM
		Set: 0x01
		Locator: M1
		Bank Locator: Bank 0
		Type: 
		Type Detail: Synchronous 
		Speed: Unknown
		Manufacturer: (null)
		Serial Number: (null)
		Asset Tag: (null)
		Part Number: (null)
Handle 0x001B
	DMI type 17, 27 bytes.
	Memory Device
		Array Handle: 0x0019
		Error Information Handle: None
		Total Width: 32 bits
		Data Width: 32 bits
		Size: 128 Mbyte
		Form Factor: SODIMM
		Set: 0x01
		Locator: M2
		Bank Locator: Bank 1
		Type: 
		Type Detail: Synchronous 
		Speed: Unknown
		Manufacturer: (null)
		Serial Number: (null)
		Asset Tag: (null)
		Part Number: (null)
Handle 0x001C
	DMI type 19, 15 bytes.
	Memory Array Mapped Address
Handle 0x001D
	DMI type 20, 19 bytes.
	Memory Device Mapped Address
Handle 0x001E
	DMI type 20, 19 bytes.
	Memory Device Mapped Address
Handle 0x001F
	DMI type 21, 7 bytes.
	Built-In Pointing Device
Handle 0x0020
	DMI type 22, 26 bytes.
	Portable Battery
		Location: In the Back
		Manufacturer: Dell Computer Corporation
		Manufacture Date: (null)
		Serial Number: (null)
		Name: Dell Computer Corporation
Handle 0x0021
	DMI type 32, 20 bytes.
	System Boot Information
Handle 0x0022
	DMI type 126, 4 bytes.
	Inactive
Handle 0x0023
	DMI type 127, 4 bytes.
	End-of-Table
RSD PTR found at 0xF60E0.
OEM DELL  
PNP BIOS present.

--------------080601090100060707060206
Content-Type: text/plain;
 name="boot.msg"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="boot.msg"

Inspecting /boot/System.map-2.4.20-4GB
Loaded 20964 symbols from /boot/System.map-2.4.20-4GB.
Symbols match kernel version 2.4.20.
Loaded 89 symbols from 7 modules.
klogd 1.4.1, log source = ksyslog started.
<4>Linux version 2.4.20-4GB (root-MOF6036VFP+XcDkGTvBoYw@public.gmane.org) (gcc version 3.3 20030226 (prerelease) (SuSE Linux)) #1 Wed Aug 6 18:26:21 UTC 2003
<6>BIOS-provided physical RAM map:
<4> BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
<4> BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
<4> BIOS-e820: 00000000000d8000 - 0000000000100000 (reserved)
<4> BIOS-e820: 0000000000100000 - 000000004767e000 (usable)
<4> BIOS-e820: 000000004767e000 - 00000000476e0000 (ACPI NVS)
<4> BIOS-e820: 00000000476e0000 - 00000000476ec000 (ACPI data)
<4> BIOS-e820: 00000000476ec000 - 0000000047700000 (ACPI NVS)
<4> BIOS-e820: 0000000047700000 - 0000000048000000 (reserved)
<4> BIOS-e820: 00000000fec10000 - 00000000fec20000 (reserved)
<4> BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
<4> BIOS-e820: 00000000fffffc00 - 0000000100000000 (reserved)
<4>Scanning bios EBDA for MXT signature
<5>246MB HIGHMEM available.
<5>896MB LOWMEM available.
<7>ACPI: have wakeup address 0xc0001000
<4>On node 0 totalpages: 292478
<4>zone(0): 4096 pages.
<4>zone(1): 225280 pages.
<4>zone(2): 63102 pages.
<4>Dell Inspiron with broken BIOS detected. Refusing to enable the local APIC.
<6>ACPI: RSDP (v000 DELL                       ) @ 0x000f60e0
<6>ACPI: RSDT (v001 DELL   Montara  01540.00000) @ 0x476e5dea
<6>ACPI: FADT (v001 DELL   MONTARA  01540.00000) @ 0x476ebed2
<6>ACPI: BOOT (v001 DELL   $SBFTBL$ 01540.00000) @ 0x476ebfd8
<6>ACPI: SSDT (v001 DELL   MONTARA  01540.00000) @ 0x476e5e1a
<6>ACPI: DSDT (v001 INTEL  MONTARAG 01540.00000) @ 0x00000000
<5>ACPI: BIOS passes blacklist
<4>Building zonelist for node : 0
<4>Kernel command line: root=/dev/hda8 vga=0x314  splash=silent splash=silent acpi=force
<6>bootsplash: silent mode.
<6>bootsplash: silent mode.
<6>Initializing CPU#0
<4>Detected 1199.001 MHz processor.
<4>Console: colour dummy device 80x25
<4>Calibrating delay loop... 2392.06 BogoMIPS
<6>Memory: 1152424k/1169912k available (1571k kernel code, 17100k reserved, 574k data, 160k init, 252408k highmem)
<6>Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
<6>Inode cache hash table entries: 131072 (order: 8, 1048576 bytes)
<6>Mount cache hash table entries: 512 (order: 0, 4096 bytes)
<4>Buffer-cache hash table entries: 131072 (order: 7, 524288 bytes)
<4>Page-cache hash table entries: 524288 (order: 9, 2097152 bytes)
<6>Intel machine check architecture supported.
<6>Intel machine check reporting enabled on CPU#0.
<7>CPU:     After generic, caps: a7e9f9bf 00000000 00000000 00000000
<7>CPU:             Common caps: a7e9f9bf 00000000 00000000 00000000
<4>CPU: Intel(R) Pentium(R) M processor 1200MHz stepping 05
<6>Enabling fast FPU save and restore... done.
<6>Enabling unmasked SIMD FPU exception support... done.
<6>Checking 'hlt' instruction... OK.
<4>POSIX conformance testing by UNIFIX
<4>mtrr: v1.40 (20010327) Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
<4>mtrr: detected mtrr type: Intel
<6>ACPI: Subsystem revision 20030228
<6>PCI: PCI BIOS revision 2.10 entry at 0xfd9b0, last bus=2
<6>PCI: Using configuration type 1
<6>ACPI: Interpreter enabled
<6>ACPI: Using PIC for interrupt routing
<6>ACPI: System [ACPI] (supports S0 S3 S4 S5)
<4>    ACPI-1121: *** Error: Method execution failed [\_SB_.ADP1._STA] (Node f7f6f200), AE_AML_NO_RETURN_VALUE
<4>    ACPI-1121: *** Error: Method execution failed [\_SB_.BAT1._STA] (Node f7f6f300), AE_AML_NO_RETURN_VALUE
<4>    ACPI-1121: *** Error: Method execution failed [\_SB_.BAT2._STA] (Node f7f6f420), AE_AML_NO_RETURN_VALUE
<6>ACPI: PCI Root Bridge [PCI0] (00:00)
<4>PCI: Probing PCI hardware (bus 00)
<6>PCI: Ignoring BAR0-3 of IDE controller 00:1f.1
<4>Transparent bridge - Intel Corp. 82801BAM/CAM PCI Bridge
<7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
<7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
<4>ACPI: PCI Interrupt Link [LNKA] (IRQs *10)
<4>ACPI: PCI Interrupt Link [LNKB] (IRQs *10)
<4>ACPI: PCI Interrupt Link [LNKC] (IRQs *11)
<4>ACPI: PCI Interrupt Link [LNKD] (IRQs *11)
<4>ACPI: PCI Interrupt Link [LNKE] (IRQs *5)
<4>ACPI: PCI Interrupt Link [LNKF] (IRQs 5, disabled)
<4>ACPI: PCI Interrupt Link [LNKG] (IRQs 10, disabled)
<4>ACPI: PCI Interrupt Link [LNKH] (IRQs *10)
<6>ACPI: Embedded Controller [H_EC] (gpe 28)
<4>    ACPI-0341: *** Error: Handler for [EmbeddedControl] returned AE_BAD_PARAMETER
<4>    ACPI-1121: *** Error: Method execution failed [\_SB_.PCI0.LPCB.H_EC._REG] (Node f7f6ba20), AE_BAD_PARAMETER
<6>ACPI: Power Resource [PFAN] (on)
<6>PCI: Probing PCI hardware
<4>ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 5
<4>ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 10
<6>PCI: Using ACPI for IRQ routing
<6>PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
<6>Linux NET4.0 for Linux 2.4
<6>Based upon Swansea University Computer Society NET3.039
<4>Initializing RT netlink socket
<6>apm: BIOS not found.
<4>mxt_scan_bios: enter
<4>Starting kswapd
<4>bigpage subsystem: allocated 0 bigpages (=0MB).
<4>allocated 32 pages and 32 bhs reserved for the highmem bounces
<4>kinoded started
<5>VFS: Disk quotas vdquot_6.5.1
<5>aio_setup: num_physpages = 73119
<5>aio_setup: sizeof(struct page) = 48
<6>vesafb: framebuffer at 0xe8000000, mapped to 0xf881d000, size 8000k
<6>vesafb: mode is 800x600x16, linelength=1600, pages=7
<6>vesafb: protected mode interface info at a5f3:1f5f
<6>vesafb: scrolling: redraw
<6>vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
<6>Looking for splash picture.... silenjpeg size 21568 bytes, found (800x600, 16440 bytes, v3).
<6>Got silent jpeg.
<6>Got silent jpeg.
<4>Console: switching to colour frame buffer device 92x29
<6>fb0: VESA VGA frame buffer device
<4>pty: 256 Unix98 ptys configured
<6>Serial driver version 5.05c (2001-07-08) with HUB-6 MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI enabled
<6>ttyS01 at 0x02f8 (irq = 3) is a 16550A
<6>Real Time Clock Driver v1.10e
<4>floppy0: no floppy controllers found
<4>RAMDISK driver initialized: 16 RAM disks of 64000K size 1024 blocksize
<6>loop: loaded (max 16 devices)
<6>Uniform Multi-Platform E-IDE driver Revision: 7.00beta-2.4
<6>ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
<6>C-ICH: IDE controller at PCI slot 00:1f.1
<4>PCI: Enabling device 00:1f.1 (0005 -> 0007)
<6>C-ICH: chipset revision 1
<6>C-ICH: not 100%% native mode: will probe irqs later
<6>    ide0: BM-DMA at 0x1810-0x1817, BIOS settings: hda:DMA, hdb:pio
<4>hda: HITACHI_DK23FB-60, ATA DISK drive
<4>blk: queue c03ac500, I/O limit 4095Mb (mask 0xffffffff)
<4>ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
<4>hda: attached ide-disk driver.
<4>hda: host protected area => 1
<6>hda: 117210240 sectors (60012 MB) w/8192KiB Cache, CHS=7296/255/63, UDMA(100)
<4>ide-floppy driver 0.99.newide
<6>Partition check:
<6> hda: hda1 hda2 < hda5 hda6 hda7 hda8 hda9 >
<4>ide-floppy driver 0.99.newide
<6>SCSI subsystem driver Revision: 1.00
<3>kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
<6>md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
<6>md: Autodetecting RAID arrays.
<6>md: autorun ...
<6>md: ... autorun DONE.
<6>NET4: Linux TCP/IP 1.0 for NET4.0
<6>IP Protocols: ICMP, UDP, TCP, IGMP
<6>IP: routing cache hash table of 16384 buckets, 128Kbytes
<6>TCP: Hash tables configured (established 524288 bind 65536)
<6>Linux IP multicast router 0.06 plus PIM-SM
<6>NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
<5>RAMDISK: Compressed image found at block 0
<6>Freeing initrd memory: 458k freed
<4>VFS: Mounted root (ext2 filesystem).
<4>reiserfs: found format "3.6" with standard journal
<4>reiserfs: enabling write barrier flush mode
<4>reiserfs: using ordered data mode
<4>reiserfs: checking transaction log (ide0(3,8)) for (ide0(3,8))
<4>Using r5 hash to sort names
<4>VFS: Mounted root (reiserfs filesystem) readonly.
<5>Trying to move old root to /initrd ... failed
<5>Unmounting old root
<5>Trying to free ramdisk memory ... okay
<6>Freeing unused kernel memory: 160k freed
<6>md: Autodetecting RAID arrays.
<6>md: autorun ...
<6>md: ... autorun DONE.
<6>LVM version 1.0.5+(mp-v6a)(22/07/2002) module loaded
<6>Adding Swap: 1261060k swap-space (priority 42)
<6>Adding Swap: 1261060k swap-space (priority 42)
<4>reiserfs: found format "3.6" with standard journal
<4>reiserfs: enabling write barrier flush mode
<4>reiserfs: using ordered data mode
<4>reiserfs: checking transaction log (ide0(3,9)) for (ide0(3,9))
<4>Using r5 hash to sort names
<6>NTFS driver 2.1.1a [Flags: R/O MODULE].
<6>NTFS volume version 3.1.
<4>MSDOS FS: IO charset iso8859-1
Kernel logging (ksyslog) stopped.
Kernel log daemon terminating.

Boot logging started on /dev/tty1(/dev/console) at Fri Oct 24 12:12:37 2003

Configuring serial ports...

ttyS1 at 0x02f8 (irq = 3) is a 16550A

modprobe: modprobe: Can't locate module char-major-212


Configured serial ports


doneRun file system check on root for LVM activation


doneRemounting root file system (/) read/write for vgscan...

Scanning for LVM volume groups...

vgscan -- reading all physical volumes (this may take a while...)

vgscan -- "/etc/lvmtab" and "/etc/lvmtab.d" successfully created

vgscan -- WARNING: This program does not do a VGDA backup of your volume group



Activating LVM volume groups...

vgchange -- no volume groups found




done

Activating swap-devices in /etc/fstab...


doneChecking file systems...

fsck 1.28 (31-Aug-2002)

Reiserfs super block in block 16 on 0x308 of format 3.6 with standard journal

Blocks (total/free): 1311297/751934 by 4096 bytes

Filesystem is clean

Reiserfs super block in block 16 on 0x309 of format 3.6 with standard journal

Blocks (total/free): 10149055/7466308 by 4096 bytes

Filesystem is clean


doneMounting local file systems...

proc on /proc type proc (rw)

devpts on /dev/pts type devpts (rw,mode=0620,gid=5)

/dev/hda9 on /home type reiserfs (rw)

/dev/hda1 on /windows/C type ntfs (ro,noexec,nosuid,nodev,gid=100,umask=0002,nls=iso8859-1)

/dev/hda5 on /windows/D type vfat (rw,noexec,nosuid,nodev,gid=100,umask=0002,iocharset=iso8859-1,code=437)


doneLoading required kernel modules


doneRestore device permissions
done

Activating remaining swap-devices in /etc/fstab...


doneMounting shared memory FS on /dev/shm
done

Setting up the CMOS clock
done

Setting up timezone data
done

Setting up hostname 'mirimon'
done

Setting up loopback interface 
done

Enabling syn flood protection
done

Disabling IP forwarding
done

Creating /var/log/boot.msg


done<notice>killproc: kill(29,29)
Running /etc/init.d/boot.local


done
Boot logging started on /dev/tty1(/dev/console) at Fri Oct 24 19:12:48 2003

Master Resource Control: previous runlevel: N, switching to runlevel: 
5

Initializing random number generator
done

Setting up network interfaces:

    lo        <notice>killproc: kill(29,3)

INIT: Entering runlevel: 5


<notice>/etc/init.d/rc5.d/S01isdn start
<notice>'/etc/init.d/rc5.d/S01isdn start' exits with status 0
<notice>/etc/init.d/rc5.d/S01random start
<notice>'/etc/init.d/rc5.d/S01random start' exits with status 0
<notice>/etc/init.d/rc5.d/S05network start

done

    eth0      
failed

    eth1      
failed

<notice>'/etc/init.d/rc5.d/S05network start' exits with status 0
<notice>/etc/init.d/rc5.d/S06syslog start
Starting syslog services<notice>startproc: execve (/sbin/syslogd) [ /sbin/syslogd ], [ CONSOLE=/dev/console TERM=linux SHELL=/bin/sh progress=20 INIT_VERSION=sysvinit-2.82 REDIRECT=/dev/tty1 COLUMNS=92 PATH=/usr/local/sbin:/sbin:/bin:/usr/sbin:/usr/bin vga=0x314 RUNLEVEL=5 PWD=/ PREVLEVEL=N LINES=29 HOME=/ SHLVL=2 splash=silent sscripts=38 _=/sbin/startproc DAEMON=/sbin/syslogd ]
<notice>startproc: execve (/sbin/klogd) [ /sbin/klogd -c 1 -2 ], [ CONSOLE=/dev/console TERM=linux SHELL=/bin/sh progress=20 INIT_VERSION=sysvinit-2.82 REDIRECT=/dev/tty1 COLUMNS=92 PATH=/usr/local/sbin:/sbin:/bin:/usr/sbin:/usr/bin vga=0x314 RUNLEVEL=5 PWD=/ PREVLEVEL=N LINES=29 HOME=/ SHLVL=2 splash=silent sscripts=38 _=/sbin/startproc DAEMON=/sbin/klogd ]

done

Starting hotplugging services [<notice>'/etc/init.d/rc5.d/S06syslog start' exits with status 0
<notice>/etc/init.d/rc5.d/S07hotplug start
 ieee1394 net pci usb .. ]
done

<notice>'/etc/init.d/rc5.d/S07hotplug start' exits with status 0
<notice>/etc/init.d/rc5.d/S08pcmcia start
Starting kernel PCMCIA <notice>startproc: execve (/sbin/cardmgr) [ /sbin/cardmgr -m /lib/modules/2.4.20-4GB/ -n pcmcia ], [ CONSOLE=/dev/console TERM=linux SHELL=/bin/sh progress=22 INIT_VERSION=sysvinit-2.82 REDIRECT=/dev/tty1 COLUMNS=92 PATH=/usr/local/sbin:/sbin:/bin:/usr/sbin:/usr/bin vga=0x314 RUNLEVEL=5 PWD=/ PREVLEVEL=N LINES=29 HOME=/ SHLVL=2 splash=silent sscripts=38 _=/sbin/startproc DAEMON=/sbin/cardmgr ]

done

<notice>'/etc/init.d/rc5.d/S08pcmcia start' exits with status 0
<notice>/etc/init.d/rc5.d/S08resmgr start
Starting resource manager<notice>startproc: execve (/sbin/resmgrd) [ /sbin/resmgrd ], [ CONSOLE=/dev/console TERM=linux SHELL=/bin/sh progress=23 INIT_VERSION=sysvinit-2.82 REDIRECT=/dev/tty1 COLUMNS=92 PATH=/usr/local/sbin:/sbin:/bin:/usr/sbin:/usr/bin vga=0x314 RUNLEVEL=5 PWD=/ PREVLEVEL=N LINES=29 HOME=/ SHLVL=2 splash=silent sscripts=38 _=/sbin/startproc DAEMON=/sbin/resmgrd ]

done

<notice>'/etc/init.d/rc5.d/S08resmgr start' exits with status 0
Starting RPC portmap daemon<notice>/etc/init.d/rc5.d/S10portmap start
<notice>startproc: execve (/sbin/portmap) [ /sbin/portmap ], [ CONSOLE=/dev/console TERM=linux SHELL=/bin/sh progress=24 INIT_VERSION=sysvinit-2.82 REDIRECT=/dev/tty1 COLUMNS=92 PATH=/usr/local/sbin:/sbin:/bin:/usr/sbin:/usr/bin vga=0x314 RUNLEVEL=5 PWD=/ PREVLEVEL=N LINES=29 HOME=/ SHLVL=2 splash=silent sscripts=38 _=/sbin/startproc DAEMON=/sbin/portmap ]

done

<notice>'/etc/init.d/rc5.d/S10portmap start' exits with status 0
<notice>/etc/init.d/rc5.d/S10splash_early start
<notice>'/etc/init.d/rc5.d/S10splash_early start' exits with status 0
<notice>/etc/init.d/rc5.d/S14acpid start
Loading ACPI modules (ac fan processor battery thermal button ) 
done

Starting acpid 
done

<notice>startproc: execve (/usr/sbin/acpid) [ /usr/sbin/acpid ], [ CONSOLE=/dev/console TERM=linux SHELL=/bin/sh progress=26 INIT_VERSION=sysvinit-2.82 REDIRECT=/dev/tty1 COLUMNS=92 PATH=/usr/local/sbin:/sbin:/bin:/usr/sbin:/usr/bin vga=0x314 RUNLEVEL=5 PWD=/ PREVLEVEL=N LINES=29 HOME=/ SHLVL=2 splash=silent sscripts=38 _=/sbin/startproc DAEMON=/usr/sbin/acpid ]
<notice>'/etc/init.d/rc5.d/S14acpid start' exits with status 0
<notice>/etc/init.d/rc5.d/S14alsasound start
Starting sound driver:  intel8x0
done

Restoring the previous sound setting
done

<notice>'/etc/init.d/rc5.d/S14alsasound start' exits with status 0
<notice>/etc/init.d/rc5.d/S14fbset start
<notice>'/etc/init.d/rc5.d/S14fbset start' exits with status 0
<notice>/etc/init.d/rc5.d/S14rpmconfigcheck start
<notice>'/etc/init.d/rc5.d/S14rpmconfigcheck start' exits with status 0
<notice>/etc/init.d/rc5.d/S14sshd start
Starting SSH daemon<notice>startproc: execve (/usr/sbin/sshd) [ /usr/sbin/sshd -o PidFile=/var/run/sshd.init.pid ], [ CONSOLE=/dev/console TERM=linux SHELL=/bin/sh progress=30 INIT_VERSION=sysvinit-2.82 REDIRECT=/dev/tty1 COLUMNS=92 PATH=/usr/local/sbin:/sbin:/bin:/usr/sbin:/usr/bin vga=0x314 RUNLEVEL=5 PWD=/ PREVLEVEL=N LINES=29 HOME=/ SHLVL=2 splash=silent sscripts=38 _=/sbin/startproc DAEMON=/usr/sbin/sshd ]

done

<notice>'/etc/init.d/rc5.d/S14sshd start' exits with status 0
<notice>/etc/init.d/rc5.d/S15kbd start
Loading keymap qwerty/us.map.gz


doneLoading compose table winkeys shiftctrl latin1.add
done

Loading console font lat1-16.psfu


doneLoading screenmap none


doneSetting up console ttys


done<notice>'/etc/init.d/rc5.d/S15kbd start' exits with status 0
<notice>/etc/init.d/rc5.d/S15postfix start
Starting mail service (Postfix)
done

Starting service at daemon<notice>'/etc/init.d/rc5.d/S15postfix start' exits with status 0
<notice>/etc/init.d/rc5.d/S15splash start
<notice>'/etc/init.d/rc5.d/S15splash start' exits with status 0
<notice>/etc/init.d/rc5.d/S16atd start

done

<notice>startproc: execve (/usr/sbin/atd) [ /usr/sbin/atd ], [ CONSOLE=/dev/console TERM=linux SHELL=/bin/sh progress=34 INIT_VERSION=sysvinit-2.82 REDIRECT=/dev/tty1 COLUMNS=92 PATH=/usr/local/sbin:/sbin:/bin:/usr/sbin:/usr/bin vga=0x314 RUNLEVEL=5 PWD=/ PREVLEVEL=N LINES=29 HOME=/ SHLVL=2 splash=silent sscripts=38 _=/sbin/startproc DAEMON=/usr/sbin/atd ]
<notice>'/etc/init.d/rc5.d/S16atd start' exits with status 0
<notice>/etc/init.d/rc5.d/S16cron start
Starting CRON daemon<notice>startproc: execve (/usr/sbin/cron) [ /usr/sbin/cron ], [ CONSOLE=/dev/console TERM=linux SHELL=/bin/sh progress=35 INIT_VERSION=sysvinit-2.82 REDIRECT=/dev/tty1 COLUMNS=92 PATH=/usr/local/sbin:/sbin:/bin:/usr/sbin:/usr/bin vga=0x314 RUNLEVEL=5 PWD=/ PREVLEVEL=N LINES=29 HOME=/ SHLVL=2 splash=silent sscripts=38 _=/sbin/startproc DAEMON=/usr/sbin/cron ]

done

Starting hardware scan on boot<notice>'/etc/init.d/rc5.d/S16cron start' exits with status 0
<notice>/etc/init.d/rc5.d/S16hwscan start
<notice>'/etc/init.d/rc5.d/S16hwscan start' exits with status 0
Starting Name Service Cache Daemon<notice>/etc/init.d/rc5.d/S16nscd start
<notice>startproc: execve (/usr/sbin/nscd) [ /usr/sbin/nscd ], [ CONSOLE=/dev/console TERM=linux SHELL=/bin/sh progress=37 INIT_VERSION=sysvinit-2.82 REDIRECT=/dev/tty1 COLUMNS=92 PATH=/usr/local/sbin:/sbin:/bin:/usr/sbin:/usr/bin vga=0x314 RUNLEVEL=5 PWD=/ PREVLEVEL=N LINES=29 HOME=/ SHLVL=2 splash=silent sscripts=38 _=/sbin/startproc DAEMON=/usr/sbin/nscd ]

done

<notice>'/etc/init.d/rc5.d/S16nscd start' exits with status 0
<notice>/etc/init.d/rc5.d/S17splash_late start
<notice>'/etc/init.d/rc5.d/S17splash_late start' exits with status 0
<notice>/etc/init.d/rc5.d/S17xdm start
Starting service kdm<notice>startproc: execve (/opt/kde3/bin/kdm) [ /opt/kde3/bin/kdm ], [ LC_MONETARY= CONSOLE=/dev/console TERM=linux SHELL=/bin/sh LC_NUMERIC= QTDIR=/usr/lib/qt3 LC_ALL= progress=39 INIT_VERSION=sysvinit-2.82 KDEROOTHOME=/root/.kdm REDIRECT=/dev/tty1 COLUMNS=92 PATH=/usr/local/sbin:/sbin:/bin:/usr/sbin:/usr/bin LC_MESSAGES= vga=0x314 RUNLEVEL=5 LC_COLLATE=POSIX PWD=/ LANG=en_US PREVLEVEL=N LINES=29 HOME=/ SHLVL=2 no_proxy=localhost RC_LC_COLLATE=POSIX WINDOWMANAGER=/usr/bin/X11/kde PRINTER=lp RC_LANG=en_US LC_CTYPE=en_US splash=silent sscripts=38 LC_TIME= _=/sbin/startproc DAEMON=/opt/kde3/bin/kdm ]

done

Master Resource Control: runlevel 5 has been 
reached

<notice>'/etc/init.d/rc5.d/S17xdm start' exits with status 0
<notice>killproc: kill(572,3)

--------------080601090100060707060206--




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
