From: Knut Neumann <knut.neumann-4bfl1RV3iZDOEhgYWvzSCYQuADTiUCJX@public.gmane.org>
Subject: s3 on vaio z600
Date: Wed, 26 Mar 2003 13:35:12 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1048682112.501.11.camel@localhost>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="Boundary_(ID_EbCCJti3+s2CFLPOP17awQ)"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
Cc: ole.rohne-vJEk5272eHo@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--Boundary_(ID_EbCCJti3+s2CFLPOP17awQ)
Content-type: text/plain
Content-transfer-encoding: 7BIT

Hi there,

with some help from Ole Rohne I started investigating S3 suspend/resume
on my sony vaio z600tek.

I found that when I either jmp over acpi_enter_sleep_state in wakeup.s
or comment out writing the sleep_enable_bit and the
waiting-for-wakeup-loop in acpi_enter_sleep_state the suspend/resume
cycle works fine.

Without doing one of the above it suspends but on resume the
power/charge/ilink leds go on and remain on - tough they are supposed to
only blink once (what I know from resuming under win2000). Nothing else
happens: no harddisk, no video, no fan, it is just completely dead -
regardless of what I try to do.

So I conclude that either there is something wrong with _WAK and _BFS or
it locks up in wakeup.S - just before the hardware part in control of
the leds gets resumed (resetted). 

Now, I would really appreciate any hint, how I can gather more
information. Is there any chance to find out wether it actually jumps
into wakeup.S after resume?

DSDT is attached.

Thanks in advance.

-Knut


-- 
--
"Marriage is the alliance of two people,one of whom never remembers
birthdays and the other never forgets them." - Ogden Nash

--Boundary_(ID_EbCCJti3+s2CFLPOP17awQ)
Content-type: text/plain; charset=ISO-8859-1; name=z600.dsdt
Content-disposition: attachment; filename=z600.dsdt
Content-transfer-encoding: 7BIT

RSDP "SONY" @ 0x000f6bb0
  0000: 52 53 44 20 50 54 52 20 c7 53 4f 4e 59 20 20 00  RSD PTR .SONY  .
  0010: ca c1 ff 07                                      ....

RSDT @ 0x07ffc1ca
  0000: 52 53 44 54 2c 00 00 00 01 2d 53 4f 4e 59 20 20  RSDT,....-SONY  
  0010: 5a 33 20 20 20 20 20 20 25 08 00 20 50 54 4c 20  Z3      %.. PTL 
  0020: 00 00 00 00 64 f7 ff 07 d8 f7 ff 07              ....d.......

FACP @ 0x07fff764
  0000: 46 41 43 50 74 00 00 00 01 f9 53 4f 4e 59 20 20  FACPt.....SONY  
  0010: 5a 33 20 20 20 20 20 20 25 08 00 20 50 54 4c 20  Z3      %.. PTL 
  0020: 40 42 0f 00 c0 ff ff 07 f6 c1 ff 07 00 00 09 00  @B..............
  0030: b2 00 00 00 f0 f1 00 00 00 80 00 00 00 00 00 00  ................
  0040: 42 80 00 00 00 00 00 00 22 00 00 00 08 80 00 00  B.......".......
  0050: 0c 80 00 00 00 00 00 00 04 02 01 04 04 00 00 00  ................
  0060: 0a 00 01 10 00 00 00 00 01 03 0d 00 32 00 00 00  ............2...
  0070: b1 00 00 00                                      ....

DSDT @ 0x07ffc1f6
  0000: 44 53 44 54 6e 35 00 00 01 83 53 4f 4e 59 00 00  DSDTn5....SONY..
  0010: 5a 33 20 20 20 20 20 00 25 08 00 20 4d 53 46 54  Z3     .%.. MSFT
  0020: 0c 00 00 01 10 12 5f 50 52 5f 5b 83 0b 43 50 55  ......_PR_[..CPU
  0030: 30 00 10 80 00 00 06 08 5f 53 30 5f 12 0a 04 0a  0......._S0_....
  0040: 05 0a 05 0a 00 0a 00 08 5f 53 31 5f 12 0a 04 0a  ........_S1_....
  0050: 04 0a 04 0a 00 0a 00 08 5f 53 33 5f 12 0a 04 0a  ........_S3_....
  0060: 01 0a 01 0a 00 0a 00 08 5f 53 34 5f 12 0a 04 0a  ........_S4_....
  0070: 00 0a 00 0a 00 0a 00 08 5f 53 35 5f 12 0a 04 0a  ........_S5_....
  0080: 00 0a 00 0a 00 0a 00 5b 80 47 50 4f 5f 01 0b 34  .......[.GPO_..4
  0090: 80 0a 04 5b 81 47 0a 47 50 4f 5f 03 47 4f 30 30  ...[.G.GPO_.GO00
  00a0: 01 47 4f 30 31 01 47 4f 30 32 01 47 4f 30 33 01  .GO01.GO02.GO03.
  00b0: 47 4f 30 34 01 47 4f 30 35 01 47 4f 30 36 01 47  GO04.GO05.GO06.G
  00c0: 4f 30 37 01 47 4f 30 38 01 47 4f 30 39 01 47 4f  O07.GO08.GO09.GO
  00d0: 31 30 01 47 4f 31 31 01 47 4f 31 32 01 47 4f 31  10.GO11.GO12.GO1
  00e0: 33 01 47 4f 31 34 01 47 4f 31 35 01 47 4f 31 36  3.GO14.GO15.GO16
  00f0: 01 47 4f 31 37 01 47 4f 31 38 01 47 4f 31 39 01  .GO17.GO18.GO19.
  0100: 47 4f 32 30 01 47 4f 32 31 01 47 4f 32 32 01 47  GO20.GO21.GO22.G
  0110: 4f 32 33 01 47 4f 32 34 01 47 4f 32 35 01 47 4f  O23.GO24.GO25.GO
  0120: 32 36 01 47 4f 32 37 01 47 4f 32 38 01 47 4f 32  26.GO27.GO28.GO2
  0130: 39 01 47 4f 33 30 01 47 4f 33 31 01 5b 80 47 4c  9.GO30.GO31.[.GL
  0140: 42 4c 01 0b 28 80 0a 04 5b 81 0f 47 4c 42 4c 03  BL..(...[..GLBL.
  0150: 00 18 00 01 4c 50 4f 4c 01 5b 80 53 4d 49 30 00  ....LPOL.[.SMI0.
  0160: 0c a7 fb ff 07 0c 15 04 00 00 5b 81 17 53 4d 49  ..........[..SMI
  0170: 30 00 42 43 4d 44 08 44 49 44 5f 20 49 4e 46 4f  0.BCMD.DID_ INFO
  0180: 80 00 01 5b 81 0d 53 4d 49 30 00 00 28 49 4e 46  ...[..SMI0..(INF
  0190: 42 08 5b 81 0d 53 4d 49 30 00 00 28 49 4e 46 44  B.[..SMI0..(INFD
  01a0: 20 5b 81 0f 53 4d 49 30 00 00 28 53 58 42 46 80   [..SMI0..(SXBF.
  01b0: 08 02 5b 80 53 4d 49 31 01 0c 40 80 00 00 0c 02  ..[.SMI1..-5mgE8MpiMJg@public.gmane.org
  01c0: 00 00 00 5b 81 0b 53 4d 49 31 00 53 4d 49 43 08  ...[..SMI1.SMIC.
  01d0: 5b 01 4d 50 48 53 00 14 21 50 48 53 30 01 70 68  [.MPHS..!PHS0.ph
  01e0: 42 43 4d 44 70 00 53 4d 49 43 a2 07 93 42 43 4d  BCMDp.SMIC...BCM
  01f0: 44 68 70 0a 00 42 43 4d 44 14 28 50 48 53 5f 09  Dhp..BCMD.(PHS_.
  0200: 5b 23 4d 50 48 53 ff ff 70 0a 00 44 49 44 5f 50  [#MPHS..p..DID_P
  0210: 48 53 30 68 70 49 4e 46 44 60 5b 27 4d 50 48 53  HS0hpINFD`['MPHS
  0220: a4 60 14 2e 50 48 53 44 0a 5b 23 4d 50 48 53 ff  .`..PHSD.[#MPHS.
  0230: ff 70 0a 00 44 49 44 5f 70 69 49 4e 46 44 50 48  .p..DID_piINFDPH
  0240: 53 30 68 70 49 4e 46 44 60 5b 27 4d 50 48 53 a4  S0hpINFD`['MPHS.
  0250: 60 14 2e 50 48 53 42 0a 5b 23 4d 50 48 53 ff ff  `..PHSB.[#MPHS..
  0260: 70 0a 00 44 49 44 5f 70 69 49 4e 46 42 50 48 53  p..DID_piINFBPHS
  0270: 30 68 70 49 4e 46 42 60 5b 27 4d 50 48 53 a4 60  0hpINFB`['MPHS.`
  0280: 14 28 50 53 43 53 09 5b 23 4d 50 48 53 ff ff 70  .(PSCS.[#MPHS..p
  0290: 68 44 49 44 5f 50 48 53 30 0a 00 70 49 4e 46 4f  hDID_PHS0..pINFO
  02a0: 60 5b 27 4d 50 48 53 a4 60 14 26 50 53 53 53 0a  `['MPHS.`.&PSSS.
  02b0: 5b 23 4d 50 48 53 ff ff 70 68 44 49 44 5f 70 69  [#MPHS..phDID_pi
  02c0: 49 4e 46 4f 50 48 53 30 0a 01 5b 27 4d 50 48 53  INFOPHS0..['MPHS
  02d0: 14 28 50 53 50 53 09 5b 23 4d 50 48 53 ff ff 70  .(PSPS.[#MPHS..p
  02e0: 68 44 49 44 5f 50 48 53 30 0a 02 70 49 4e 46 4f  hDID_PHS0..pINFO
  02f0: 60 5b 27 4d 50 48 53 a4 60 14 20 50 53 44 49 09  `['MPHS.`. PSDI.
  0300: 5b 23 4d 50 48 53 ff ff 70 68 44 49 44 5f 50 48  [#MPHS..phDID_PH
  0310: 53 30 0a 03 5b 27 4d 50 48 53 14 28 50 53 53 54  S0..['MPHS.(PSST
  0320: 09 5b 23 4d 50 48 53 ff ff 70 68 44 49 44 5f 50  .[#MPHS..phDID_P
  0330: 48 53 30 0a 04 70 49 4e 46 42 60 5b 27 4d 50 48  HS0..pINFB`['MPH
  0340: 53 a4 60 10 48 04 5c 5f 47 50 45 14 13 5f 4c 30  S.`.H.\_GPE.._L0
  0350: 42 00 86 5c 2e 5f 53 42 5f 50 57 52 42 0a 02 14  B..\._SB_PWRB...
  0360: 13 5f 4c 30 41 00 86 5c 2e 5f 53 42 5f 50 43 49  ._L0A..\._SB_PCI
  0370: 30 0a 02 14 18 5f 4c 30 38 00 86 5c 2f 03 5f 53  0...._L08..\/._S
  0380: 42 5f 50 43 49 30 55 53 42 30 0a 02 14 11 4d 49  B_PCI0USB0....MI
  0390: 4e 5f 02 a0 06 95 68 69 a4 68 a1 03 a4 69 14 09  N_....hi.h...i..
  03a0: 53 4c 45 4e 01 a4 87 68 14 21 53 32 42 46 09 72  SLEN...h.!S2BF.r
  03b0: 53 4c 45 4e 68 01 60 08 42 55 46 46 11 02 60 70  SLENh.`.BUFF..`p
  03c0: 68 42 55 46 46 a4 42 55 46 46 14 47 06 53 43 4d  hBUFF.BUFF.G.SCM
  03d0: 50 02 70 53 32 42 46 68 60 70 53 32 42 46 69 61  P.pS2BFh`pS2BFia
  03e0: 70 00 64 70 53 4c 45 4e 68 65 70 53 4c 45 4e 69  p.dpSLENhepSLENi
  03f0: 66 70 4d 49 4e 5f 65 66 67 a2 24 95 64 67 70 83  fpMIN_efg.$.dgp.
  0400: 88 60 64 00 62 70 83 88 61 64 00 63 a0 06 94 62  .`d.bp..ad.c...b
  0410: 63 a4 01 a1 08 a0 06 95 62 63 a4 ff 75 64 a0 06  c.......bc..ud..
  0420: 95 64 65 a4 01 a1 0c a0 06 95 64 66 a4 ff a1 03  .de.......df....
  0430: a4 00 14 4b 0c 5f 50 54 53 01 a0 18 92 95 68 0a  ...K._PTS.....h.
  0440: 02 70 0a 01 5c 2f 03 5f 53 42 5f 50 43 49 30 43  .p..\/._SB_PCI0C
  0450: 52 53 54 a1 13 70 0a 00 5c 2f 03 5f 53 42 5f 50  RST..p..\/._SB_P
  0460: 43 49 30 43 52 53 54 a0 43 09 93 68 0a 04 70 5c  CI0CRST.C..h..p\
  0470: 2f 05 5f 53 42 5f 50 43 49 30 49 53 41 5f 53 50  /._SB_PCI0ISA_SP
  0480: 49 43 5f 43 52 53 5c 2f 05 5f 53 42 5f 50 43 49  IC_CRS\/._SB_PCI
  0490: 30 49 53 41 5f 53 50 49 43 53 53 52 43 a0 2e 93  0ISA_SPICSSRC...
  04a0: 53 43 4d 50 5c 5f 4f 53 5f 0d 4d 69 63 72 6f 73  SCMP\_OS_.Micros
  04b0: 6f 66 74 20 57 69 6e 64 6f 77 73 20 4e 54 00 00  oft Windows NT..
  04c0: 50 48 53 5f 0a e3 50 48 53 5f 0a e5 a1 2e a0 2c  PHS_..PHS_.....,
  04d0: 92 93 53 43 4d 50 5c 5f 4f 53 5f 0d 4d 69 63 72  ..SCMP\_OS_.Micr
  04e0: 6f 73 6f 66 74 20 57 69 6e 64 6f 77 73 00 00 50  osoft Windows..P
  04f0: 48 53 5f 0a e3 50 48 53 5f 0a e5 a4 0a 00 10 83  HS_..PHS_.......
  0500: 9b 02 5f 53 42 5f 5b 82 25 50 57 52 42 08 5f 48  .._SB_[.%PWRB._H
  0510: 49 44 0c 41 d0 0c 0c 08 5f 50 52 57 12 06 02 0a  ID.A...._PRW....
  0520: 0b 0a 04 14 09 5f 53 54 41 00 a4 0a 0f 5b 82 83  ....._STA....[..
  0530: 98 02 50 43 49 30 08 5f 48 49 44 0c 41 d0 0a 03  ..PCI0._HID.A...
  0540: 5b 80 42 58 52 53 02 0a 7a 0a 01 5b 81 0d 42 58  [.BXRS..z..[..BX
  0550: 52 53 01 43 52 53 54 01 00 07 5b 82 34 48 32 50  RS.CRST...[.4H2P
  0560: 42 08 5f 41 44 52 0a 00 5b 80 4e 52 42 52 02 0a  B._ADR..[.NRBR..
  0570: 00 0b 00 01 5b 81 1a 4e 52 42 52 03 00 48 28 00  ....[..NRBR..H(.
  0580: 01 41 41 47 45 01 00 46 2f 00 07 47 54 45 4e 01  .AAGE..F/..GTEN.
  0590: 5b 82 4c 06 56 49 44 30 08 5f 41 44 52 0c 00 00  [.L.VID0._ADR...
  05a0: 01 00 08 5f 50 53 43 0a 00 14 09 5f 53 54 41 00  ..._PSC...._STA.
  05b0: a4 0a 0f 14 3c 5f 50 53 30 00 a0 2e 93 53 43 4d  ....<_PS0....SCM
  05c0: 50 5c 5f 4f 53 5f 0d 4d 69 63 72 6f 73 6f 66 74  P\_OS_.Microsoft
  05d0: 20 57 69 6e 64 6f 77 73 20 4e 54 00 00 50 48 53   Windows NT..PHS
  05e0: 5f 0a e7 50 48 53 5f 0a e9 70 0a 00 5f 50 53 43  _..PHS_..p.._PSC
  05f0: 14 0d 5f 50 53 33 00 70 0a 03 5f 50 53 43 08 5f  .._PS3.p.._PSC._
  0600: 41 44 52 0a 00 08 5f 50 52 54 12 43 0b 0b 12 0f  ADR..._PRT.C....
  0610: 04 0c ff ff 01 00 0a 00 4c 4e 4b 41 0a 00 12 0f  ........LNKA....
  0620: 04 0c ff ff 01 00 0a 01 4c 4e 4b 42 0a 00 12 0f  ........LNKB....
  0630: 04 0c ff ff 01 00 0a 02 4c 4e 4b 43 0a 00 12 0f  ........LNKC....
  0640: 04 0c ff ff 01 00 0a 03 4c 4e 4b 44 0a 00 12 0f  ........LNKD....
  0650: 04 0c ff ff 07 00 0a 03 4c 4e 4b 44 0a 00 12 0f  ........LNKD....
  0660: 04 0c ff ff 08 00 0a 00 4c 4e 4b 44 0a 00 12 0f  ........LNKD....
  0670: 04 0c ff ff 09 00 0a 00 4c 4e 4b 43 0a 00 12 0f  ........LNKC....
  0680: 04 0c ff ff 0a 00 0a 00 4c 4e 4b 42 0a 00 12 0f  ........LNKB....
  0690: 04 0c ff ff 0b 00 0a 00 4c 4e 4b 41 0a 00 12 0f  ........LNKA....
  06a0: 04 0c ff ff 0c 00 0a 00 4c 4e 4b 42 0a 00 12 0f  ........LNKB....
  06b0: 04 0c ff ff 0d 00 0a 00 4c 4e 4b 42 0a 00 5b 80  ........LNKB..[.
  06c0: 52 45 47 53 02 0a 40 0a c0 5b 81 49 06 52 45 47  REGS..@..[.I.REG
  06d0: 53 03 00 48 0c 50 41 4d 30 08 50 41 4d 31 08 50  S..H.PAM0.PAM1.P
  06e0: 41 4d 32 08 50 41 4d 33 08 50 41 4d 34 08 50 41  AM2.PAM3.PAM4.PA
  06f0: 4d 35 08 50 41 4d 36 08 44 52 42 30 08 44 52 42  M5.PAM6.DRB0.DRB
  0700: 31 08 44 52 42 32 08 44 52 42 33 08 44 52 42 34  1.DRB2.DRB3.DRB4
  0710: 08 44 52 42 35 08 44 52 42 36 08 44 52 42 37 08  .DRB5.DRB6.DRB7.
  0720: 00 06 48 45 4e 5f 02 00 40 05 54 5f 45 4e 01 54  ..HEN_..-Lyo4eKvhOds@public.gmane.org
  0730: 5f 53 5a 02 08 52 53 52 43 11 47 1d 0b d2 01 88  _SZ..RSRC.G.....
  0740: 0e 00 02 0c 00 00 00 00 00 ff 00 00 00 00 01 00  ................
  0750: 87 18 00 00 0c 03 00 00 00 00 00 00 0a 00 ff ff  ................
  0760: 0b 00 00 00 00 00 00 00 02 00 00 87 18 00 00 0c  ................
  0770: 03 00 00 00 00 00 00 0c 00 ff 3f 0c 00 00 00 00  ..........?.....
  0780: 00 00 40 00 00 00 87 18 00 00 0c 03 00 00 00 00  ..-BlbsxGdv4A7maATwymIwmA@public.gmane.org
  0790: 00 40 0c 00 ff 7f 0c 00 00 00 00 00 00 40 00 00  .-BlbsxGdv4A7jshiNgxcy3g@public.gmane.org@..
  07a0: 00 87 18 00 00 0c 03 00 00 00 00 00 80 0c 00 ff  ................
  07b0: bf 0c 00 00 00 00 00 00 40 00 00 00 87 18 00 00  ........-3wQm9ZMZ9co@public.gmane.org
  07c0: 0c 03 00 00 00 00 00 c0 0c 00 ff ff 0c 00 00 00  ................
  07d0: 00 00 00 40 00 00 00 87 18 00 00 0c 03 00 00 00  ...-BlbsxGdv4A70P002vLKALA@public.gmane.org
  07e0: 00 00 00 0d 00 ff 3f 0d 00 00 00 00 00 00 40 00  ......?.......@.
  07f0: 00 00 87 18 00 00 0c 03 00 00 00 00 00 40 0d 00  .............@..
  0800: ff 7f 0d 00 00 00 00 00 00 40 00 00 00 87 18 00  .........-E2U9adUjKaY@public.gmane.org
  0810: 00 0c 03 00 00 00 00 00 80 0d 00 ff bf 0d 00 00  ................
  0820: 00 00 00 00 40 00 00 00 87 18 00 00 0c 03 00 00  ....-BlbsxGdv4A7jshiNgxcy3g@public.gmane.org
  0830: 00 00 00 c0 0d 00 ff ff 0d 00 00 00 00 00 00 40  ...............@
  0840: 00 00 00 87 18 00 00 0c 03 00 00 00 00 00 00 0e  ................
  0850: 00 ff 3f 0e 00 00 00 00 00 00 40 00 00 00 87 18  ..?.......-5mgE8MpiMJg@public.gmane.org
  0860: 00 00 0c 03 00 00 00 00 00 40 0e 00 ff 7f 0e 00  .........-E2U9adUjKaY@public.gmane.org
  0870: 00 00 00 00 00 40 00 00 00 87 18 00 00 0c 03 00  .....-BlbsxGdv4A6tXF2fZOsJYA@public.gmane.org
  0880: 00 00 00 00 80 0e 00 ff bf 0e 00 00 00 00 00 00  ................
  0890: 40 00 00 00 87 18 00 00 0c 03 00 00 00 00 00 c0  @...............
  08a0: 0e 00 ff ff 0e 00 00 00 00 00 00 40 00 00 00 87  ...........-9D9NNryygCw@public.gmane.org
  08b0: 18 00 00 0c 03 00 00 00 00 00 00 00 00 00 00 00  ................
  08c0: 00 00 00 00 00 00 00 00 00 00 87 18 00 00 0c 03  ................
  08d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  08e0: 00 00 00 00 00 47 01 f8 0c f8 0c 01 08 88 0e 00  .....G..........
  08f0: 01 0c 03 00 00 00 00 f7 0c 00 00 f8 0c 00 88 0e  ................
  0900: 00 01 0c 03 00 00 00 0d ff ff 00 00 00 f3 00 79  ...............y
  0910: 00 14 42 55 5f 43 52 53 08 70 00 61 a0 11 54 5f  ..BU_CRS.p.a..T_
  0920: 45 4e 79 0a 01 72 54 5f 53 5a 0a 11 00 61 8a 52  ENy..rT_SZ...a.R
  0930: 53 52 43 0b 7a 01 42 54 4d 4e 8a 52 53 52 43 0b  SRC.z.BTMN.RSRC.
  0940: 7e 01 42 54 4d 58 8a 52 53 52 43 0b 86 01 42 54  ~.BTMX.RSRC...BT
  0950: 4c 4e 77 44 52 42 37 0c 00 00 80 00 60 a0 20 54  LNwDRB7.....`. T
  0960: 5f 45 4e 74 60 61 62 70 62 42 54 4d 4e 74 72 60  _ENt`abpbBTMNtr`
  0970: 0c 00 00 00 10 00 42 54 4d 4e 42 54 4c 4e a1 23  ......BTMNBTLN.#
  0980: 70 60 42 54 4d 4e 74 0c 00 00 e0 ff 60 42 54 4c  p`BTMNt.....`BTL
  0990: 4e 74 72 42 54 4d 4e 42 54 4c 4e 00 0a 01 42 54  NtrBTMNBTLN...BT
  09a0: 4d 58 8a 52 53 52 43 0b 95 01 41 54 4d 4e 8a 52  MX.RSRC...ATMN.R
  09b0: 53 52 43 0b 99 01 41 54 4d 58 8a 52 53 52 43 0b  SRC...ATMX.RSRC.
  09c0: a1 01 41 54 4c 4e a0 34 54 5f 45 4e 72 72 42 54  ..ATLN.4T_ENrrBT
  09d0: 4d 4e 42 54 4c 4e 00 61 41 54 4d 4e 74 0c 00 00  MNBTLN.aATMNt...
  09e0: e0 ff 41 54 4d 4e 41 54 4c 4e 74 72 41 54 4d 4e  ..ATMNATLNtrATMN
  09f0: 41 54 4c 4e 00 0a 01 41 54 4d 58 a1 07 70 00 41  ATLN...ATMX..p.A
  0a00: 54 4c 4e 8d 52 53 52 43 0b 88 01 43 30 52 57 8a  TLN.RSRC...C0RW.
  0a10: 52 53 52 43 0a 36 43 30 4d 4e 8a 52 53 52 43 0a  RSRC.6C0MN.RSRC.
  0a20: 3a 43 30 4d 58 8a 52 53 52 43 0a 42 43 30 4c 4e  :C0MX.RSRC.BC0LN
  0a30: 70 01 43 30 52 57 a0 12 93 7b 50 41 4d 31 0a 03  p.C0RW...{PAM1..
  0a40: 00 0a 01 70 00 43 30 52 57 70 00 43 30 4c 4e a0  ...p.C0RWp.C0LN.
  0a50: 12 92 7b 50 41 4d 31 0a 03 00 70 0b 00 40 43 30  ..{PAM1...p..@C0
  0a60: 4c 4e 8d 52 53 52 43 0b 60 02 43 34 52 57 8a 52  LN.RSRC.`.C4RW.R
  0a70: 53 52 43 0a 51 43 34 4d 4e 8a 52 53 52 43 0a 55  SRC.QC4MN.RSRC.U
  0a80: 43 34 4d 58 8a 52 53 52 43 0a 5d 43 34 4c 4e 70  C4MX.RSRC.]C4LNp
  0a90: 01 43 34 52 57 a0 12 93 7b 50 41 4d 31 0a 30 00  .C4RW...{PAM1.0.
  0aa0: 0a 10 70 00 43 34 52 57 70 00 43 34 4c 4e a0 12  ..p.C4RWp.C4LN..
  0ab0: 92 7b 50 41 4d 31 0a 30 00 70 0b 00 40 43 34 4c  .{PAM1.0.p..@C4L
  0ac0: 4e 8d 52 53 52 43 0b 38 03 43 38 52 57 8a 52 53  N.RSRC.8.C8RW.RS
  0ad0: 52 43 0a 6c 43 38 4d 4e 8a 52 53 52 43 0a 70 43  RC.lC8MN.RSRC.pC
  0ae0: 38 4d 58 8a 52 53 52 43 0a 78 43 38 4c 4e 70 01  8MX.RSRC.xC8LNp.
  0af0: 43 38 52 57 a0 12 93 7b 50 41 4d 32 0a 03 00 0a  C8RW...{PAM2....
  0b00: 01 70 00 43 38 52 57 70 00 43 38 4c 4e a0 12 92  .p.C8RWp.C8LN...
  0b10: 7b 50 41 4d 32 0a 03 00 70 0b 00 40 43 38 4c 4e  {PAM2...p..@C8LN
  0b20: 8d 52 53 52 43 0b 10 04 43 43 52 57 8a 52 53 52  .RSRC...CCRW.RSR
  0b30: 43 0a 87 43 43 4d 4e 8a 52 53 52 43 0a 8b 43 43  C..CCMN.RSRC..CC
  0b40: 4d 58 8a 52 53 52 43 0a 93 43 43 4c 4e 70 01 43  MX.RSRC..CCLNp.C
  0b50: 43 52 57 a0 12 93 7b 50 41 4d 32 0a 30 00 0a 10  CRW...{PAM2.0...
  0b60: 70 00 43 43 52 57 70 00 43 43 4c 4e a0 12 92 7b  p.CCRWp.CCLN...{
  0b70: 50 41 4d 32 0a 30 00 70 0b 00 40 43 43 4c 4e 8d  PAM2.0.p..@CCLN.
  0b80: 52 53 52 43 0b e8 04 44 30 52 57 8a 52 53 52 43  RSRC...D0RW.RSRC
  0b90: 0a a2 44 30 4d 4e 8a 52 53 52 43 0a a6 44 30 4d  ..D0MN.RSRC..D0M
  0ba0: 58 8a 52 53 52 43 0a ae 44 30 4c 4e 70 01 44 30  X.RSRC..D0LNp.D0
  0bb0: 52 57 a0 12 93 7b 50 41 4d 33 0a 03 00 0a 01 70  RW...{PAM3.....p
  0bc0: 00 44 30 52 57 70 00 44 30 4c 4e a0 12 92 7b 50  .D0RWp.D0LN...{P
  0bd0: 41 4d 33 0a 03 00 70 0b 00 40 44 30 4c 4e 8d 52  AM3...p..-+ayk61v4+lk@public.gmane.org
  0be0: 53 52 43 0b c0 05 44 34 52 57 8a 52 53 52 43 0a  SRC...D4RW.RSRC.
  0bf0: bd 44 34 4d 4e 8a 52 53 52 43 0a c1 44 34 4d 58  .D4MN.RSRC..D4MX
  0c00: 8a 52 53 52 43 0a c9 44 34 4c 4e 70 01 44 34 52  .RSRC..D4LNp.D4R
  0c10: 57 a0 12 93 7b 50 41 4d 33 0a 30 00 0a 10 70 00  W...{PAM3.0...p.
  0c20: 44 34 52 57 70 00 44 34 4c 4e a0 12 92 7b 50 41  D4RWp.D4LN...{PA
  0c30: 4d 33 0a 30 00 70 0b 00 40 44 34 4c 4e 8d 52 53  M3.0.p..-bRXtDLAMSLI@public.gmane.org
  0c40: 52 43 0b 98 06 44 38 52 57 8a 52 53 52 43 0a d8  RC...D8RW.RSRC..
  0c50: 44 38 4d 4e 8a 52 53 52 43 0a dc 44 38 4d 58 8a  D8MN.RSRC..D8MX.
  0c60: 52 53 52 43 0a e4 44 38 4c 4e 70 01 44 38 52 57  RSRC..D8LNp.D8RW
  0c70: a0 12 93 7b 50 41 4d 34 0a 03 00 0a 01 70 00 44  ...{PAM4.....p.D
  0c80: 38 52 57 70 00 44 38 4c 4e a0 12 92 7b 50 41 4d  8RWp.D8LN...{PAM
  0c90: 34 0a 03 00 70 0b 00 40 44 38 4c 4e 8d 52 53 52  4...p..-YV4Udz28Ev8@public.gmane.org
  0ca0: 43 0b 70 07 44 43 52 57 8a 52 53 52 43 0a f3 44  C.p.DCRW.RSRC..D
  0cb0: 43 4d 4e 8a 52 53 52 43 0a f7 44 43 4d 58 8a 52  CMN.RSRC..DCMX.R
  0cc0: 53 52 43 0a ff 44 43 4c 4e 70 00 44 43 52 57 70  SRC..DCLNp.DCRWp
  0cd0: 0b 00 40 44 43 4c 4e 8d 52 53 52 43 0b 48 08 45  ..-gn79mkCwxEqPenO2ANc6bA@public.gmane.org
  0ce0: 30 52 57 8a 52 53 52 43 0b 0e 01 45 30 4d 4e 8a  0RW.RSRC...E0MN.
  0cf0: 52 53 52 43 0b 12 01 45 30 4d 58 8a 52 53 52 43  RSRC...E0MX.RSRC
  0d00: 0b 1a 01 45 30 4c 4e 70 01 45 30 52 57 a0 12 93  ...E0LNp.E0RW...
  0d10: 7b 50 41 4d 35 0a 03 00 0a 01 70 00 45 30 52 57  {PAM5.....p.E0RW
  0d20: 70 00 45 30 4c 4e a0 12 92 7b 50 41 4d 35 0a 03  p.E0LN...{PAM5..
  0d30: 00 70 0b 00 40 45 30 4c 4e 8d 52 53 52 43 0b 20  .p..-xxB8gvdRRhaFqyXNGmKg3w@public.gmane.org 
  0d40: 09 45 34 52 57 8a 52 53 52 43 0b 29 01 45 34 4d  .E4RW.RSRC.).E4M
  0d50: 4e 8a 52 53 52 43 0b 2d 01 45 34 4d 58 8a 52 53  N.RSRC.-.E4MX.RS
  0d60: 52 43 0b 35 01 45 34 4c 4e 70 01 45 34 52 57 a0  RC.5.E4LNp.E4RW.
  0d70: 12 93 7b 50 41 4d 35 0a 30 00 0a 10 70 00 45 34  ..{PAM5.0...p.E4
  0d80: 52 57 70 00 45 34 4c 4e a0 12 92 7b 50 41 4d 35  RWp.E4LN...{PAM5
  0d90: 0a 30 00 70 0b 00 40 45 34 4c 4e 8d 52 53 52 43  .0.p..-45QKx6p2129/8xXOW9rC8g@public.gmane.org
  0da0: 0b f8 09 45 38 52 57 8a 52 53 52 43 0b 44 01 45  ...E8RW.RSRC.D.E
  0db0: 38 4d 4e 8a 52 53 52 43 0b 48 01 45 38 4d 58 8a  8MN.RSRC.H.E8MX.
  0dc0: 52 53 52 43 0b 50 01 45 38 4c 4e 70 01 45 38 52  RSRC.P.E8LNp.E8R
  0dd0: 57 a0 12 93 7b 50 41 4d 36 0a 03 00 0a 01 70 00  W...{PAM6.....p.
  0de0: 45 38 52 57 70 00 45 38 4c 4e a0 12 92 7b 50 41  E8RWp.E8LN...{PA
  0df0: 4d 36 0a 03 00 70 0b 00 40 45 38 4c 4e 8d 52 53  M6...p..-xSyYB6rwgkw@public.gmane.org
  0e00: 52 43 0b d0 0a 45 43 52 57 8a 52 53 52 43 0b 5f  RC...ECRW.RSRC._
  0e10: 01 45 43 4d 4e 8a 52 53 52 43 0b 63 01 45 43 4d  .ECMN.RSRC.c.ECM
  0e20: 58 8a 52 53 52 43 0b 6b 01 45 43 4c 4e 70 01 45  X.RSRC.k.ECLNp.E
  0e30: 43 52 57 a0 12 93 7b 50 41 4d 36 0a 30 00 0a 10  CRW...{PAM6.0...
  0e40: 70 00 45 43 52 57 70 00 45 43 4c 4e a0 12 92 7b  p.ECRWp.ECLN...{
  0e50: 50 41 4d 36 0a 30 00 70 0b 00 40 45 43 4c 4e a4  PAM6.0.p..@ECLN.
  0e60: 52 53 52 43 5b 82 41 14 55 53 42 30 08 5f 41 44  RSRC[.A.USB0._AD
  0e70: 52 0c 02 00 07 00 5b 80 43 46 47 32 02 0a 00 0b  R.....[.CFG2....
  0e80: 00 01 5b 81 0e 43 46 47 32 03 00 40 10 55 53 42  ..[..CFG2..@.USB
  0e90: 42 10 14 1d 5f 53 54 41 00 7b 55 53 42 42 0b e0  B..._STA.{USBB..
  0ea0: ff 60 a0 08 93 60 0a 00 a4 0a 00 a1 04 a4 0a 0f  .`...`..........
  0eb0: 08 5f 50 53 43 0a 00 14 43 04 5f 50 53 30 00 a0  ._PSC...C._PS0..
  0ec0: 23 93 53 43 4d 50 5c 5f 4f 53 5f 0d 4d 69 63 72  #.SCMP\_OS_.Micr
  0ed0: 6f 73 6f 66 74 20 57 69 6e 64 6f 77 73 20 4e 54  osoft Windows NT
  0ee0: 00 00 a3 a1 10 a0 0e 93 5f 50 53 43 0a 03 50 48  ........_PSC..PH
  0ef0: 53 5f 0a c3 70 0a 00 5f 50 53 43 14 43 04 5f 50  S_..p.._PSC.C._P
  0f00: 53 33 00 a0 23 93 53 43 4d 50 5c 5f 4f 53 5f 0d  S3..#.SCMP\_OS_.
  0f10: 4d 69 63 72 6f 73 6f 66 74 20 57 69 6e 64 6f 77  Microsoft Window
  0f20: 73 20 4e 54 00 00 a3 a1 10 a0 0e 93 5f 50 53 43  s NT........_PSC
  0f30: 0a 00 50 48 53 5f 0a c2 70 0a 03 5f 50 53 43 14  ..PHS_..p.._PSC.
  0f40: 47 06 5f 50 52 57 00 a0 2a 93 53 43 4d 50 5c 5f  G._PRW..*.SCMP\_
  0f50: 4f 53 5f 0d 4d 69 63 72 6f 73 6f 66 74 20 57 69  OS_.Microsoft Wi
  0f60: 6e 64 6f 77 73 20 4e 54 00 00 a4 12 06 02 0a 08  ndows NT........
  0f70: 0a 01 a1 34 a0 28 92 93 53 43 4d 50 5c 5f 4f 53  ...4.(..SCMP\_OS
  0f80: 5f 0d 4d 69 63 72 6f 73 6f 66 74 20 57 69 6e 64  _.Microsoft Wind
  0f90: 6f 77 73 00 00 a4 12 06 02 0a 08 0a 01 a1 09 a4  ows.............
  0fa0: 12 06 02 0a 08 0a 04 5b 82 4b 10 50 57 52 5f 08  .......[.K.PWR_.
  0fb0: 5f 41 44 52 0c 03 00 07 00 5b 80 50 43 49 5f 02  _ADR.....[.PCI_.
  0fc0: 0a 50 0a 28 5b 81 4e 0e 50 43 49 5f 03 00 08 00  .P.([.N.PCI_....
  0fd0: 04 46 44 43 4d 01 00 01 55 31 4d 5f 01 00 01 55  .FDCM...U1M_...U
  0fe0: 32 4d 5f 01 00 01 4c 50 54 4d 01 00 4d 04 4d 44  2M_...LPTM..M.MD
  0ff0: 49 45 01 4d 44 49 41 02 53 42 45 5f 01 47 4d 45  IE.MDIA.SBE_.GME
  1000: 5f 01 53 42 41 5f 02 4d 53 53 45 01 4d 53 53 41  _.SBA_.MSSE.MSSA
  1010: 02 00 0e 00 01 41 55 44 4d 01 00 02 4b 42 43 4d  .....AUDM...KBCM
  1020: 01 47 31 32 4d 01 47 31 33 4d 01 4c 50 54 45 01  .G12M.G13M.LPTE.
  1030: 47 30 39 41 10 47 30 39 4c 04 00 01 47 30 39 4d  G09A.G09L...G09M
  1040: 01 47 30 39 45 01 00 01 00 01 4c 50 54 41 02 00  .G09E.....LPTA..
  1050: 01 46 44 43 41 01 46 44 43 45 01 4b 42 43 45 01  .FDCA.FDCE.KBCE.
  1060: 47 4d 4d 5f 01 47 31 30 41 10 47 31 30 4c 04 00  GMM_.G10A.G10L..
  1070: 01 47 31 30 4d 01 47 31 30 45 01 47 31 30 43 01  .G10M.G10E.G10C.
  1080: 55 31 41 5f 03 55 31 45 5f 01 55 32 41 5f 03 55  U1A_.U1E_.U2A_.U
  1090: 32 45 5f 01 47 31 32 41 10 47 31 32 4c 04 47 31  2E_.G12A.G12L.G1
  10a0: 32 45 01 00 2b 47 31 33 41 10 47 31 33 4c 04 47  2E..+G13A.G13L.G
  10b0: 31 33 45 01 5b 82 43 12 49 44 45 5f 08 5f 41 44  13E.[.C.IDE_._AD
  10c0: 52 0c 01 00 07 00 5b 80 50 43 49 5f 02 0a 40 0a  R.....[.PCI_..@.
  10d0: 10 5b 81 0f 50 43 49 5f 03 00 18 00 07 53 49 44  .[..PCI_.....SID
  10e0: 45 01 5b 81 12 50 43 49 5f 03 52 34 30 5f 20 00  E.[..PCI_.R40_ .
  10f0: 20 52 34 38 5f 20 5b 82 49 08 50 52 49 4d 08 5f   R48_ [.I.PRIM._
  1100: 41 44 52 0a 00 08 5f 50 53 43 0a 00 08 49 44 45  ADR..._PSC...IDE
  1110: 54 0a 00 08 55 44 4d 41 0a 00 14 09 5f 53 54 41  T...UDMA...._STA
  1120: 00 a4 0a 0f 5b 82 0c 4d 41 53 54 08 5f 41 44 52  ....[..MAST._ADR
  1130: 0a 00 14 2e 5f 50 53 30 00 a0 20 93 5f 50 53 43  ...._PS0.. ._PSC
  1140: 0a 03 70 49 44 45 54 52 34 30 5f 70 55 44 4d 41  ..pIDETR40_pUDMA
  1150: 52 34 38 5f 50 48 53 5f 0a cd 70 0a 00 5f 50 53  R48_PHS_..p.._PS
  1160: 43 14 1f 5f 50 53 33 00 70 52 34 30 5f 49 44 45  C.._PS3.pR40_IDE
  1170: 54 70 52 34 38 5f 55 44 4d 41 70 0a 03 5f 50 53  TpR48_UDMAp.._PS
  1180: 43 5b 82 46 05 53 45 43 4e 08 5f 41 44 52 0a 01  C[.F.SECN._ADR..
  1190: 08 5f 50 53 43 0a 00 08 49 44 45 54 0a 00 08 55  ._PSC...IDET...U
  11a0: 44 4d 41 0a 00 14 09 5f 53 54 41 00 a4 0a 0f 5b  DMA...._STA....[
  11b0: 82 0c 4d 41 53 54 08 5f 41 44 52 0a 00 14 0d 5f  ..MAST._ADR...._
  11c0: 50 53 30 00 70 0a 00 5f 50 53 43 14 0d 5f 50 53  PS0.p.._PSC.._PS
  11d0: 33 00 70 0a 03 5f 50 53 43 5b 82 49 0a 53 44 39  3.p.._PSC[.I.SD9
  11e0: 34 08 5f 41 44 52 0c 00 00 08 00 08 5f 53 54 41  4._ADR......_STA
  11f0: 0a 0f 5b 80 53 50 43 49 02 0a 00 0b 00 01 5b 81  ..[.SPCI......[.
  1200: 1b 53 50 43 49 03 00 40 06 43 41 4c 53 08 4c 41  .SPCI..-zkztiFWA+/k@public.gmane.org
  1210: 54 49 08 00 40 69 50 57 53 54 08 08 5f 50 53 43  TI..-2Zr2Ara7ZGo8hdxRYKeSpQ@public.gmane.org
  1220: 0a 00 14 43 05 5f 50 53 30 00 a0 23 93 53 43 4d  ...C._PS0..#.SCM
  1230: 50 5c 5f 4f 53 5f 0d 4d 69 63 72 6f 73 6f 66 74  P\_OS_.Microsoft
  1240: 20 57 69 6e 64 6f 77 73 20 4e 54 00 00 a3 a1 1a   Windows NT.....
  1250: 70 0a 00 50 57 53 54 5b 22 0a 01 70 0a 08 43 41  p..PWST["..p..CA
  1260: 4c 53 70 0a 40 4c 41 54 49 50 48 53 5f 0a d6 70  LSp.-VSEBKM2dYjmpUs2DtKHuOw@public.gmane.org
  1270: 0a 00 5f 50 53 43 14 0d 5f 50 53 33 00 70 0a 03  .._PSC.._PS3.p..
  1280: 5f 50 53 43 5b 82 42 16 43 52 44 30 08 5f 41 44  _PSC[.B.CRD0._AD
  1290: 52 0c 00 00 0c 00 08 5f 50 52 57 12 06 02 0a 0a  R......_PRW.....
  12a0: 0a 03 5b 80 43 43 52 44 02 0a 00 0a e4 5b 81 29  ..[.CCRD.....[.)
  12b0: 43 43 52 44 03 00 20 43 44 30 34 20 00 40 1b 43  CCRD.. CD04 .@.C
  12c0: 44 33 45 20 00 10 43 44 34 34 20 00 40 4c 43 44  D3E ..CD44 .@LCD
  12d0: 45 30 08 43 44 45 31 08 5b 80 45 58 43 41 01 0b  E0.CDE1.[.EXCA..
  12e0: e0 03 0a 02 5b 81 10 45 58 43 41 01 49 4e 44 58  ....[..EXCA.INDX
  12f0: 08 44 41 54 41 08 5b 86 13 49 4e 44 58 44 41 54  .DATA.[..INDXDAT
  1300: 41 01 00 18 00 07 45 52 49 42 01 14 4a 04 5f 49  A.....ERIB..J._I
  1310: 4e 49 00 a0 28 93 53 43 4d 50 5c 5f 4f 53 5f 0d  NI..(.SCMP\_OS_.
  1320: 4d 69 63 72 6f 73 6f 66 74 20 57 69 6e 64 6f 77  Microsoft Window
  1330: 73 20 4e 54 00 00 70 00 43 44 45 31 a1 19 70 00  s NT..p.CDE1..p.
  1340: 43 44 45 30 70 00 43 44 30 34 70 00 43 44 33 45  CDE0p.CD04p.CD3E
  1350: 70 01 43 44 34 34 08 5f 50 53 43 0a 00 14 2e 50  p.CD44._PSC....P
  1360: 53 58 5f 01 70 0a 00 43 44 45 30 70 0b e0 03 43  SX_.p..CDE0p...C
  1370: 44 34 34 70 01 45 52 49 42 70 0a 00 43 44 34 34  D44p.ERIBp..CD44
  1380: 70 68 43 44 45 30 70 68 5f 50 53 43 14 13 5f 50  phCDE0ph_PSC.._P
  1390: 53 30 00 70 00 43 44 45 31 70 0a 00 5f 50 53 43  S0.p.CDE1p.._PSC
  13a0: 14 17 5f 50 53 31 00 50 53 58 5f 0a 01 7d 43 44  .._PS1.PSX_..}CD
  13b0: 45 31 0a 01 43 44 45 31 14 17 5f 50 53 32 00 50  E1..CDE1.._PS2.P
  13c0: 53 58 5f 0a 02 7d 43 44 45 31 0a 01 43 44 45 31  SX_..}CDE1..CDE1
  13d0: 14 17 5f 50 53 33 00 50 53 58 5f 0a 03 7d 43 44  .._PS3.PSX_..}CD
  13e0: 45 31 0a 01 43 44 45 31 5b 82 45 0c 4d 4f 44 45  E1..CDE1[.E.MODE
  13f0: 08 5f 41 44 52 0c 00 00 0a 00 08 5f 53 54 41 0a  ._ADR......_STA.
  1400: 0f 14 47 06 5f 50 52 57 00 a0 27 93 53 43 4d 50  ..G._PRW..'.SCMP
  1410: 5c 5f 4f 53 5f 0d 4d 69 63 72 6f 73 6f 66 74 20  \_OS_.Microsoft 
  1420: 57 69 6e 64 6f 77 73 00 00 a4 12 06 02 0a 0a 0a  Windows.........
  1430: 04 a1 37 a0 2b 92 93 53 43 4d 50 5c 5f 4f 53 5f  ..7.+..SCMP\_OS_
  1440: 0d 4d 69 63 72 6f 73 6f 66 74 20 57 69 6e 64 6f  .Microsoft Windo
  1450: 77 73 20 4e 54 00 00 a4 12 06 02 0a 0a 0a 03 a1  ws NT...........
  1460: 09 a4 12 06 02 0a 0a 0a 03 14 45 04 5f 50 53 57  ..........E._PSW
  1470: 01 a0 22 93 5c 2f 05 5f 53 42 5f 50 43 49 30 49  ..".\/._SB_PCI0I
  1480: 53 41 5f 45 43 30 5f 45 43 4f 4b 0a 00 50 48 53  SA_EC0_ECOK..PHS
  1490: 42 0a dd 68 a1 1a 70 68 5c 2f 05 5f 53 42 5f 50  B..h..ph\/._SB_P
  14a0: 43 49 30 49 53 41 5f 45 43 30 5f 53 4d 44 4d 5b  CI0ISA_EC0_SMDM[
  14b0: 82 4c 0f 45 54 48 52 08 5f 41 44 52 0c 00 00 0b  .L.ETHR._ADR....
  14c0: 00 08 5f 53 54 41 0a 0f 08 5f 50 53 43 0a 00 14  .._STA..._PSC...
  14d0: 38 5f 50 52 57 00 a0 27 93 53 43 4d 50 5c 5f 4f  8_PRW..'.SCMP\_O
  14e0: 53 5f 0d 4d 69 63 72 6f 73 6f 66 74 20 57 69 6e  S_.Microsoft Win
  14f0: 64 6f 77 73 00 00 a4 12 06 02 0a 0a 0a 04 a1 09  dows............
  1500: a4 12 06 02 0a 0a 0a 03 5b 80 45 50 43 49 02 0a  ........[.EPCI..
  1510: 00 0b 00 01 5b 81 13 45 50 43 49 03 00 40 70 45  ....[..EPCI..@pE
  1520: 54 45 30 08 45 54 45 31 08 14 45 07 5f 50 53 30  TE0.ETE1..E._PS0
  1530: 00 70 0a 00 45 54 45 30 50 48 53 5f 0a e8 a0 2d  .p..ETE0PHS_...-
  1540: 93 53 43 4d 50 5c 5f 4f 53 5f 0d 4d 69 63 72 6f  .SCMP\_OS_.Micro
  1550: 73 6f 66 74 20 57 69 6e 64 6f 77 73 20 4e 54 00  soft Windows NT.
  1560: 00 7b 45 54 45 31 0a fe 45 54 45 31 a1 2b a0 27  .{ETE1..ETE1.+.'
  1570: 93 53 43 4d 50 5c 5f 4f 53 5f 0d 4d 69 63 72 6f  .SCMP\_OS_.Micro
  1580: 73 6f 66 74 20 57 69 6e 64 6f 77 73 00 00 70 0b  soft Windows..p.
  1590: 08 42 45 54 30 43 a1 01 70 0a 00 5f 50 53 43 14  .BET0C..p.._PSC.
  15a0: 0d 5f 50 53 33 00 70 0a 03 5f 50 53 43 5b 82 4d  ._PS3.p.._PSC[.M
  15b0: 08 4d 53 43 4c 08 5f 41 44 52 0c 00 00 0d 00 08  .MSCL._ADR......
  15c0: 5f 53 54 41 0a 0f 08 5f 50 53 43 0a 00 5b 80 4d  _STA..._PSC..[.M
  15d0: 53 43 47 02 0a 00 0b 00 01 5b 81 1b 4d 53 43 47  SCG......[..MSCG
  15e0: 03 00 40 24 4d 53 34 38 18 00 48 4a 4d 53 45 30  ..@$MS48..HJMSE0
  15f0: 08 4d 53 45 31 08 14 37 5f 50 53 30 00 70 0a 00  .MSE1..7_PS0.p..
  1600: 4d 53 45 30 70 0c 00 01 05 00 4d 53 34 38 7b 4d  MSE0p.....MS48{M
  1610: 53 45 31 0a 80 60 a0 10 93 60 0a 80 7d 4d 53 45  SE1..`...`..}MSE
  1620: 31 0a 80 4d 53 45 31 70 0a 00 5f 50 53 43 14 0d  1..MSE1p.._PSC..
  1630: 5f 50 53 33 00 70 0a 03 5f 50 53 43 5b 82 84 87  _PS3.p.._PSC[...
  1640: 01 49 53 41 5f 08 5f 41 44 52 0c 00 00 07 00 5b  .ISA_._ADR.....[
  1650: 80 50 49 52 58 02 0a 60 0a 04 5b 81 1a 50 49 52  .PIRX..`..[..PIR
  1660: 58 01 50 49 52 41 08 50 49 52 42 08 50 49 52 43  X.PIRA.PIRB.PIRC
  1670: 08 50 49 52 44 08 5b 82 43 05 4d 4f 54 48 08 5f  .PIRD.[.C.MOTH._
  1680: 48 49 44 0c 41 d0 0c 02 08 5f 43 52 53 11 3d 0a  HID.A...._CRS.=.
  1690: 3a 47 01 80 00 80 00 01 01 47 01 b2 00 b2 00 01  :G.......G......
  16a0: 02 47 01 98 03 98 03 01 02 47 01 d0 04 d0 04 01  .G.......G......
  16b0: 02 47 01 40 10 40 10 01 10 47 01 00 80 00 80 01  .G.@.-IVZtA+XTBH+tXF2fZOsJYA@public.gmane.org
  16c0: 50 47 01 72 00 72 00 01 02 79 00 5b 82 47 09 4d  PG.r.r...y.[.G.M
  16d0: 45 4d 5f 08 5f 48 49 44 0c 41 d0 0c 01 08 4d 53  EM_._HID.A....MS
  16e0: 52 43 11 4e 04 0a 4a 86 09 00 01 00 00 10 00 00  RC.N..J.........
  16f0: 00 00 00 86 09 00 01 00 00 00 00 00 00 0a 00 86  ................
  1700: 09 00 00 00 c0 0d 00 00 40 00 00 86 09 00 00 00  ........-3wQm9ZMZ9co@public.gmane.org
  1710: 00 0e 00 00 00 02 00 86 09 00 00 00 00 f8 ff 00  ................
  1720: 00 08 00 86 09 00 00 00 f6 f7 ff 00 0a 00 00 79  ...............y
  1730: 00 14 28 5f 43 52 53 00 8a 4d 53 52 43 0a 08 4d  ..(_CRS..MSRC..M
  1740: 45 4d 53 a0 11 92 4d 45 4d 53 70 50 48 53 5f 0a  EMS...MEMSpPHS_.
  1750: c0 4d 45 4d 53 a4 4d 53 52 43 14 09 5f 53 54 41  .MEMS.MSRC.._STA
  1760: 00 a4 0a 0f 5b 82 3f 44 4d 41 43 08 5f 48 49 44  ....[.?DMAC._HID
  1770: 0c 41 d0 02 00 08 5f 43 52 53 11 20 0a 1d 47 01  .A...._CRS. ..G.
  1780: 00 00 00 00 01 10 47 01 81 00 81 00 01 0f 47 01  ......G.......G.
  1790: c0 00 c0 00 01 20 2a 10 00 79 00 14 09 5f 53 54  ..... *..y..._ST
  17a0: 41 00 a4 0a 0f 5b 82 2f 52 54 43 5f 08 5f 48 49  A....[./RTC_._HI
  17b0: 44 0c 41 d0 0b 00 08 5f 43 52 53 11 10 0a 0d 47  D.A...._CRS....G
  17c0: 01 70 00 70 00 01 02 22 00 01 79 00 14 09 5f 53  .p.p..."..y..._S
  17d0: 54 41 00 a4 0a 0f 5b 82 35 50 49 43 5f 08 5f 48  TA....[.5PIC_._H
  17e0: 49 44 0b 41 d0 08 5f 43 52 53 11 18 0a 15 47 01  ID.A.._CRS....G.
  17f0: 20 00 20 00 01 02 47 01 a0 00 a0 00 01 02 22 04   . ...G.......".
  1800: 00 79 00 14 09 5f 53 54 41 00 a4 0a 0f 5b 82 2f  .y..._STA....[./
  1810: 46 50 55 5f 08 5f 48 49 44 0c 41 d0 0c 04 08 5f  FPU_._HID.A...._
  1820: 43 52 53 11 10 0a 0d 47 01 f0 00 f0 00 01 10 22  CRS....G......."
  1830: 00 20 79 00 14 09 5f 53 54 41 00 a4 0a 0f 5b 82  . y..._STA....[.
  1840: 2f 54 4d 52 5f 08 5f 48 49 44 0c 41 d0 01 00 08  /TMR_._HID.A....
  1850: 5f 43 52 53 11 10 0a 0d 47 01 40 00 40 00 01 04  _CRS....G.@.-47IYjYMXMt4@public.gmane.org
  1860: 22 01 00 79 00 14 09 5f 53 54 41 00 a4 0a 0f 5b  "..y..._STA....[
  1870: 82 2c 53 50 4b 52 08 5f 48 49 44 0c 41 d0 08 00  .,SPKR._HID.A...
  1880: 08 5f 43 52 53 11 0d 0a 0a 47 01 61 00 61 00 01  ._CRS....G.a.a..
  1890: 01 79 00 14 09 5f 53 54 41 00 a4 0a 0f 5b 82 37  .y..._STA....[.7
  18a0: 4b 42 43 5f 08 5f 48 49 44 0c 41 d0 03 03 08 5f  KBC_._HID.A...._
  18b0: 43 52 53 11 18 0a 15 47 01 60 00 60 00 01 01 47  CRS....G.`.`...G
  18c0: 01 64 00 64 00 01 01 22 02 00 79 00 14 09 5f 53  .d.d..."..y..._S
  18d0: 54 41 00 a4 0a 0f 5b 82 1d 4d 4f 55 45 08 5f 48  TA....[..MOUE._H
  18e0: 49 44 0c 41 d0 0f 13 08 5f 43 52 53 11 08 0a 05  ID.A...._CRS....
  18f0: 22 00 10 79 00 5b 82 41 46 45 43 30 5f 08 5f 48  "..y.[.AFEC0_._H
  1900: 49 44 0c 41 d0 0c 09 08 5f 43 52 53 11 15 0a 12  ID.A...._CRS....
  1910: 47 01 62 00 62 00 01 01 47 01 66 00 66 00 01 01  G.b.b...G.f.f...
  1920: 79 00 08 5f 47 50 45 0a 09 08 45 43 4f 4b 0a 00  y.._GPE...ECOK..
  1930: 14 12 5f 52 45 47 02 a0 0b 93 68 0a 03 70 69 45  .._REG....h..piE
  1940: 43 4f 4b 5b 80 45 43 52 5f 03 0a 00 0a ff 5b 81  COK[.ECR_.....[.
  1950: 47 12 45 43 52 5f 10 00 40 40 4d 50 42 50 01 4d  G.ECR_..@@MPBP.M
  1960: 50 42 44 01 44 4f 4b 44 01 44 46 42 50 01 00 04  PBD.DOKD.DFBP...
  1970: 42 54 31 41 01 42 54 32 41 01 41 43 41 54 01 00  BT1A.BT2A.ACAT..
  1980: 05 50 57 52 42 01 4a 4f 47 42 01 4c 49 44 53 01  .PWRB.JOGB.LIDS.
  1990: 00 05 42 54 31 50 01 42 54 32 50 01 00 06 42 31  ..BT1P.BT2P...B1
  19a0: 53 54 08 42 32 53 54 08 00 40 05 4d 41 53 4b 08  ST.B2ST..@.MASK.
  19b0: 42 54 31 53 01 42 54 32 53 01 00 06 42 54 31 57  BT1S.BT2S...BT1W
  19c0: 01 42 54 32 57 01 00 06 46 41 4e 30 08 43 42 30  .BT2W...FAN0.CB0
  19d0: 53 01 43 42 31 53 01 00 06 50 48 59 4f 01 00 07  S.CB1S...PHYO...
  19e0: 42 52 49 54 08 43 4f 4e 54 08 53 4e 44 55 01 53  BRIT.CONT.SNDU.S
  19f0: 4e 44 44 01 00 06 53 4d 44 4d 01 00 07 00 30 42  NDD...SMDM....0B
  1a00: 31 52 43 10 42 31 41 42 10 42 31 52 54 10 42 31  1RC.B1AB.B1RT.B1
  1a10: 56 4f 10 42 32 52 43 10 42 32 41 42 10 42 32 52  VO.B2RC.B2AB.B2R
  1a20: 54 10 42 32 56 4f 10 42 31 44 43 10 42 31 4c 46  T.B2VO.B1DC.B1LF
  1a30: 10 42 31 44 56 10 42 31 44 4c 10 42 32 44 43 10  .B1DV.B1DL.B2DC.
  1a40: 42 32 4c 46 10 42 32 44 56 10 42 32 44 4c 10 41  B2LF.B2DV.B2DL.A
  1a50: 31 54 50 10 41 31 41 54 10 41 31 50 54 10 41 31  1TP.A1AT.A1PT.A1
  1a60: 43 54 10 41 32 54 50 10 41 32 41 54 10 41 32 50  CT.A2TP.A2AT.A2P
  1a70: 54 10 41 32 43 54 10 14 13 5f 51 35 30 00 50 48  T.A2CT..._Q50.PH
  1a80: 53 5f 0a e0 86 41 43 41 44 0a 80 14 23 5f 51 35  S_...ACAD...#_Q5
  1a90: 31 00 a0 0c 42 54 31 41 86 42 41 54 31 0a 00 a1  1...BT1A.BAT1...
  1aa0: 08 86 42 41 54 31 0a 01 86 42 41 54 31 0a 80 14  ..BAT1...BAT1...
  1ab0: 26 5f 51 35 32 00 70 0d 5f 51 35 32 3a 43 68 61  &_Q52.p._Q52:Cha
  1ac0: 6e 67 65 20 42 61 74 74 65 72 79 20 32 20 45 76  nge Battery 2 Ev
  1ad0: 65 6e 74 00 5b 31 14 21 5f 51 35 33 00 70 0d 5f  ent.[1.!_Q53.p._
  1ae0: 51 35 33 3a 42 61 74 74 65 72 79 20 53 65 6c 65  Q53:Battery Sele
  1af0: 63 74 69 6f 6e 00 5b 31 14 3e 5f 51 35 38 00 70  ction.[1.>_Q58.p
  1b00: 0d 5f 51 35 38 3a 41 54 46 20 74 65 6d 70 65 72  ._Q58:ATF temper
  1b10: 61 74 75 72 65 20 74 72 69 70 20 70 6f 69 6e 74  ature trip point
  1b20: 20 63 68 61 6e 67 64 00 5b 31 86 5c 2e 5f 54 5a   changd.[1.\._TZ
  1b30: 5f 41 54 46 30 0a 81 14 1c 5f 51 35 45 00 70 0d  _ATF0...._Q5E.p.
  1b40: 5f 51 35 45 3a 52 49 31 20 6f 63 63 75 72 72 65  _Q5E:RI1 occurre
  1b50: 64 00 5b 31 14 3f 5f 51 35 46 00 70 0d 5f 51 35  d.[1.?_Q5F.p._Q5
  1b60: 46 3a 41 54 46 20 74 65 6d 70 65 72 61 74 75 72  F:ATF temperatur
  1b70: 65 20 72 65 61 63 68 65 73 20 74 72 69 70 20 70  e reaches trip p
  1b80: 6f 69 6e 74 00 5b 31 86 5c 2e 5f 54 5a 5f 41 54  oint.[1.\._TZ_AT
  1b90: 46 30 0a 80 14 13 5f 51 36 30 00 86 5c 2e 5f 53  F0...._Q60..\._S
  1ba0: 42 5f 50 57 52 42 0a 80 5b 82 43 16 42 41 54 31  B_PWRB..[.C.BAT1
  1bb0: 08 5f 48 49 44 0c 41 d0 0c 0a 08 5f 55 49 44 0a  ._HID.A...._UID.
  1bc0: 01 08 5f 50 43 4c 12 07 01 5c 5f 53 42 5f 08 42  .._PCL...\_SB_.B
  1bd0: 41 54 49 12 2d 0d 0a 00 0b 50 96 0b 50 96 0a 00  ATI.-....P..P...
  1be0: 0b d0 39 0a 00 0a 78 0a 00 0a 0a 0d 00 0d 00 0d  ..9...x.........
  1bf0: 4c 49 4f 4e 00 0d 53 6f 6e 79 20 43 6f 72 70 2e  LION..Sony Corp.
  1c00: 00 08 42 41 54 53 12 0f 04 0a 02 0c ff ff ff ff  ..BATS..........
  1c10: 0b 7a 0d 0b 40 38 14 22 5f 53 54 41 00 7b 50 48  .z..@8."_STA.{PH
  1c20: 53 44 0a db 0a 80 0b 00 01 61 a0 06 61 70 0a 1f  SD.......a..ap..
  1c30: 60 a1 05 70 0a 0f 60 a4 60 14 49 04 5f 42 49 46  `..p..`.`.I._BIF
  1c40: 00 70 50 48 53 44 0a db 0a b0 61 77 61 0a 0a 88  .pPHSD....awa...
  1c50: 42 41 54 49 0a 01 00 70 50 48 53 44 0a db 0a b2  BATI...pPHSD....
  1c60: 61 77 61 0a 0a 88 42 41 54 49 0a 02 00 70 50 48  awa...BATI...pPH
  1c70: 53 44 0a db 0a b6 88 42 41 54 49 0a 04 00 a4 42  SD.....BATI....B
  1c80: 41 54 49 14 49 08 5f 42 53 54 00 70 7b 50 48 53  ATI.I._BST.p{PHS
  1c90: 44 0a db 0a 84 0a ff 60 88 42 41 54 53 0a 00 00  D......`.BATS...
  1ca0: 70 50 48 53 44 0a db 0a a4 61 a0 23 95 61 0b 00  pPHSD....a.#.a..
  1cb0: 80 a0 10 61 70 0c ff ff ff ff 88 42 41 54 53 0a  ...ap......BATS.
  1cc0: 01 00 a1 0b 70 00 88 42 41 54 53 0a 01 00 a1 15  ....p..BATS.....
  1cd0: 7f 61 0b ff ff 61 75 61 77 61 0a 0a 88 42 41 54  .a...auawa...BAT
  1ce0: 53 0a 01 00 77 50 48 53 44 0a db 0a a2 0a 0a 88  S...wPHSD.......
  1cf0: 42 41 54 53 0a 02 00 70 50 48 53 44 0a db 0a a6  BATS...pPHSD....
  1d00: 88 42 41 54 53 0a 03 00 a4 42 41 54 53 5b 82 49  .BATS....BATS[.I
  1d10: 04 41 43 41 44 08 5f 48 49 44 0d 41 43 50 49 30  .ACAD._HID.ACPI0
  1d20: 30 30 33 00 08 5f 50 43 4c 12 07 01 5c 5f 53 42  003.._PCL...\_SB
  1d30: 5f 14 1c 5f 50 53 52 00 7b 50 48 53 44 0a db 0a  _.._PSR.{PHSD...
  1d40: 80 0b 00 04 61 a0 04 61 a4 01 a1 03 a4 00 14 09  ....a..a........
  1d50: 5f 53 54 41 00 a4 0a 0f 5b 82 4c 2e 53 50 49 43  _STA....[.L.SPIC
  1d60: 08 5f 48 49 44 0c 4d d9 60 01 08 52 53 52 43 11  ._HID.M.`..RSRC.
  1d70: 18 0a 15 47 01 00 00 00 00 01 01 47 01 00 00 00  ...G.......G....
  1d80: 00 01 01 22 00 00 79 00 08 53 53 52 43 11 18 0a  ..."..y..SSRC...
  1d90: 15 47 01 00 00 00 00 01 01 47 01 00 00 00 00 01  .G.......G......
  1da0: 01 22 00 00 79 00 14 42 10 5f 43 52 53 00 8b 52  ."..y..B._CRS..R
  1db0: 53 52 43 0a 02 49 4f 41 31 8b 52 53 52 43 0a 04  SRC..IOA1.RSRC..
  1dc0: 49 4f 41 32 8b 52 53 52 43 0a 0a 49 4f 42 31 8b  IOA2.RSRC..IOB1.
  1dd0: 52 53 52 43 0a 0c 49 4f 42 32 8b 52 53 52 43 0a  RSRC..IOB2.RSRC.
  1de0: 11 49 52 51 56 70 5c 2f 04 5f 53 42 5f 50 43 49  .IRQVp\/._SB_PCI
  1df0: 30 50 57 52 5f 47 31 30 41 49 4f 41 31 70 5c 2f  0PWR_G10AIOA1p\/
  1e00: 04 5f 53 42 5f 50 43 49 30 50 57 52 5f 47 31 30  ._SB_PCI0PWR_G10
  1e10: 41 49 4f 41 32 7d 5c 2f 04 5f 53 42 5f 50 43 49  AIOA2}\/._SB_PCI
  1e20: 30 50 57 52 5f 47 31 30 41 5c 2f 04 5f 53 42 5f  0PWR_G10A\/._SB_
  1e30: 50 43 49 30 50 57 52 5f 47 31 30 4c 49 4f 42 31  PCI0PWR_G10LIOB1
  1e40: 7d 5c 2f 04 5f 53 42 5f 50 43 49 30 50 57 52 5f  }\/._SB_PCI0PWR_
  1e50: 47 31 30 41 5c 2f 04 5f 53 42 5f 50 43 49 30 50  G10A\/._SB_PCI0P
  1e60: 57 52 5f 47 31 30 4c 49 4f 42 32 a0 1c 47 4f 32  WR_G10LIOB2..GO2
  1e70: 32 a0 0b 47 4f 32 33 70 00 49 52 51 56 a1 0a 79  2..GO23p.IRQV..y
  1e80: 0a 01 0a 0a 49 52 51 56 a1 1b a0 0e 47 4f 32 33  ....IRQV....GO23
  1e90: 79 0a 01 0a 0b 49 52 51 56 a1 0a 79 0a 01 0a 05  y....IRQV..y....
  1ea0: 49 52 51 56 a4 52 53 52 43 14 4c 0e 5f 53 52 53  IRQV.RSRC.L._SRS
  1eb0: 01 8b 68 0a 02 49 4f 41 31 8b 68 0a 0a 49 4f 42  ..h..IOA1.h..IOB
  1ec0: 31 8b 68 0a 11 49 52 51 56 70 49 4f 41 31 5c 2f  1.h..IRQVpIOA1\/
  1ed0: 04 5f 53 42 5f 50 43 49 30 50 57 52 5f 47 31 30  ._SB_PCI0PWR_G10
  1ee0: 41 7f 49 4f 41 31 49 4f 42 31 5c 2f 04 5f 53 42  A.IOA1IOB1\/._SB
  1ef0: 5f 50 43 49 30 50 57 52 5f 47 31 30 4c 82 49 52  _PCI0PWR_G10L.IR
  1f00: 51 56 60 76 60 a0 12 93 60 00 70 0a 01 47 4f 32  QV`v`...`.p..GO2
  1f10: 32 70 0a 01 47 4f 32 33 a0 13 93 60 0a 05 70 0a  2p..GO23...`..p.
  1f20: 00 47 4f 32 32 70 0a 00 47 4f 32 33 a0 13 93 60  .GO22p..GO23...`
  1f30: 0a 0a 70 0a 01 47 4f 32 32 70 0a 00 47 4f 32 33  ..p..GO22p..GO23
  1f40: a0 13 93 60 0a 0b 70 0a 00 47 4f 32 32 70 0a 01  ...`..p..GO22p..
  1f50: 47 4f 32 33 70 0a 00 5c 2f 04 5f 53 42 5f 50 43  GO23p..\/._SB_PC
  1f60: 49 30 50 57 52 5f 47 31 30 4d 70 0a 01 5c 2f 04  I0PWR_G10Mp..\/.
  1f70: 5f 53 42 5f 50 43 49 30 50 57 52 5f 47 31 30 45  _SB_PCI0PWR_G10E
  1f80: 70 0a 01 5c 2f 04 5f 53 42 5f 50 43 49 30 50 57  p..\/._SB_PCI0PW
  1f90: 52 5f 47 31 30 43 08 5f 50 52 53 11 4e 04 0a 4a  R_G10C._PRS.N..J
  1fa0: 30 47 01 80 10 80 10 01 01 47 01 84 10 84 10 01  0G.......G......
  1fb0: 01 30 47 01 90 10 90 10 01 01 47 01 94 10 94 10  .0G.......G.....
  1fc0: 01 01 30 47 01 a0 10 a0 10 01 01 47 01 a4 10 a4  ..0G.......G....
  1fd0: 10 01 01 30 47 01 b0 10 b0 10 01 01 47 01 b4 10  ...0G.......G...
  1fe0: b4 10 01 01 38 22 20 0c 79 00 14 41 04 5f 44 49  ....8" .y..A._DI
  1ff0: 53 00 70 0a 00 5c 2f 04 5f 53 42 5f 50 43 49 30  S.p..\/._SB_PCI0
  2000: 50 57 52 5f 47 31 30 45 70 0a 00 5c 2f 04 5f 53  PWR_G10Ep..\/._S
  2010: 42 5f 50 43 49 30 50 57 52 5f 47 31 30 43 70 0a  B_PCI0PWR_G10Cp.
  2020: 01 47 4f 32 32 70 0a 01 47 4f 32 33 14 19 5f 53  .GO22p..GO23.._S
  2030: 54 41 00 a0 0d 90 47 4f 32 32 47 4f 32 33 a4 0a  TA....GO22GO23..
  2040: 0d a1 04 a4 0a 0f 5b 01 53 4c 4f 4b 00 5b 82 4d  ......[.SLOK.[.M
  2050: 10 43 4f 4d 41 08 5f 48 49 44 0c 41 d0 05 01 08  .COMA._HID.A....
  2060: 4d 43 44 5f 0a 0e 14 41 04 5f 43 52 53 00 a0 30  MCD_...A._CRS..0
  2070: 5c 2f 05 5f 53 42 5f 50 43 49 30 49 53 41 5f 43  \/._SB_PCI0ISA_C
  2080: 4f 4d 41 5f 53 54 41 5b 23 53 4c 4f 4b ff ff 70  OMA_STA[#SLOK..p
  2090: 50 53 43 53 0a 0e 60 5b 27 53 4c 4f 4b a4 60 a1  PSCS..`['SLOK.`.
  20a0: 08 a4 11 05 0a 02 79 00 14 1b 42 5f 53 52 01 5b  ......y...B_SR.[
  20b0: 23 53 4c 4f 4b ff ff 50 53 53 53 0a 0e 68 5b 27  #SLOK..PSSS..h['
  20c0: 53 4c 4f 4b 14 1e 42 5f 50 52 00 5b 23 53 4c 4f  SLOK..B_PR.[#SLO
  20d0: 4b ff ff 70 50 53 50 53 0a 0e 60 5b 27 53 4c 4f  K..pPSPS..`['SLO
  20e0: 4b a4 60 14 1a 42 5f 44 49 00 5b 23 53 4c 4f 4b  K.`..B_DI.[#SLOK
  20f0: ff ff 50 53 44 49 0a 0e 5b 27 53 4c 4f 4b 14 1e  ..PSDI..['SLOK..
  2100: 5f 53 54 41 00 5b 23 53 4c 4f 4b ff ff 70 50 53  _STA.[#SLOK..pPS
  2110: 53 54 0a 0e 60 5b 27 53 4c 4f 4b a4 60 08 5f 50  ST..`['SLOK.`._P
  2120: 53 43 0a 00 14 17 5f 50 53 30 00 70 01 47 4f 31  SC...._PS0.p.GO1
  2130: 33 5b 21 0a c8 70 0a 00 5f 50 53 43 14 13 5f 50  3[!..p.._PSC.._P
  2140: 53 33 00 70 00 47 4f 31 33 70 0a 03 5f 50 53 43  S3.p.GO13p.._PSC
  2150: 08 5f 50 52 57 12 06 02 0a 0a 0a 03 5b 82 4f 0d  ._PRW.......[.O.
  2160: 46 49 52 5f 08 5f 48 49 44 0c 4d d9 70 01 08 5f  FIR_._HID.M.p.._
  2170: 43 49 44 0c 3a 63 60 01 08 4d 43 44 5f 0a 0f 14  CID.:c`..MCD_...
  2180: 41 04 5f 43 52 53 00 a0 30 5c 2f 05 5f 53 42 5f  A._CRS..0\/._SB_
  2190: 50 43 49 30 49 53 41 5f 46 49 52 5f 5f 53 54 41  PCI0ISA_FIR__STA
  21a0: 5b 23 53 4c 4f 4b ff ff 70 50 53 43 53 0a 0f 60  [#SLOK..pPSCS..`
  21b0: 5b 27 53 4c 4f 4b a4 60 a1 08 a4 11 05 0a 02 79  ['SLOK.`.......y
  21c0: 00 14 1b 42 5f 53 52 01 5b 23 53 4c 4f 4b ff ff  ...B_SR.[#SLOK..
  21d0: 50 53 53 53 0a 0f 68 5b 27 53 4c 4f 4b 14 1e 42  PSSS..h['SLOK..B
  21e0: 5f 50 52 00 5b 23 53 4c 4f 4b ff ff 70 50 53 50  _PR.[#SLOK..pPSP
  21f0: 53 0a 0f 60 5b 27 53 4c 4f 4b a4 60 14 1a 42 5f  S..`['SLOK.`..B_
  2200: 44 49 00 5b 23 53 4c 4f 4b ff ff 50 53 44 49 0a  DI.[#SLOK..PSDI.
  2210: 0f 5b 27 53 4c 4f 4b 14 1e 5f 53 54 41 00 5b 23  .['SLOK.._STA.[#
  2220: 53 4c 4f 4b ff ff 70 50 53 53 54 0a 0f 60 5b 27  SLOK..pPSST..`['
  2230: 53 4c 4f 4b a4 60 08 5f 50 53 43 0a 00 5b 82 48  SLOK.`._PSC..[.H
  2240: 21 4c 50 54 41 08 5f 48 49 44 0c 41 d0 04 00 08  !LPTA._HID.A....
  2250: 5f 55 49 44 0a 01 08 4d 43 44 5f 0a 10 08 43 52  _UID...MCD_...CR
  2260: 53 42 11 10 0a 0d 47 01 00 00 00 00 01 08 22 00  SB....G.......".
  2270: 00 79 00 14 4f 0b 5f 43 52 53 00 a0 4e 0a 5c 2f  .y..O._CRS..N.\/
  2280: 05 5f 53 42 5f 50 43 49 30 49 53 41 5f 4c 50 54  ._SB_PCI0ISA_LPT
  2290: 41 5f 53 54 41 8b 43 52 53 42 0a 02 49 4f 31 42  A_STA.CRSB..IO1B
  22a0: 8b 43 52 53 42 0a 04 49 4f 32 42 8b 43 52 53 42  .CRSB..IO2B.CRSB
  22b0: 0a 06 49 4f 33 42 8b 43 52 53 42 0a 09 49 52 51  ..IO3B.CRSB..IRQ
  22c0: 42 5b 23 53 4c 4f 4b ff ff 7a 52 45 41 44 0a 1b  B[#SLOK..zREAD..
  22d0: 0a f0 0a 00 0a 04 60 70 00 49 52 51 42 a0 0a 60  ......`p.IRQB..`
  22e0: 79 0a 01 60 49 52 51 42 7d 79 7b 52 34 33 30 0a  y..`IRQB}y{R430.
  22f0: fc 00 0a 08 00 79 52 34 32 30 0a 02 00 49 4f 31  .....yR420...IO1
  2300: 42 70 49 4f 31 42 49 4f 32 42 a0 11 93 49 4f 31  BpIO1BIO2B...IO1
  2310: 42 0b bc 03 70 0b 01 04 49 4f 33 42 70 43 52 53  B...p...IO3BpCRS
  2320: 42 61 5b 27 53 4c 4f 4b a4 61 a1 08 a4 11 05 0a  Ba['SLOK.a......
  2330: 02 79 00 14 43 0c 42 5f 53 52 01 08 58 52 46 49  .y..C.B_SR..XRFI
  2340: 12 22 10 0a 00 0a 00 0a 00 0a 00 0a 00 0a 07 0a  ."..............
  2350: 00 0a 01 0a 00 0a 02 0a 03 0a 04 0a 00 0a 00 0a  ................
  2360: 05 0a 06 8b 68 0a 02 49 4f 31 41 8b 68 0a 09 49  ....h..IO1A.h..I
  2370: 52 51 42 5b 23 53 4c 4f 4b ff ff 57 52 49 54 0a  RQB[#SLOK..WRIT.
  2380: 00 0a fe 0a 00 0a 00 57 52 49 54 0a 42 0a 00 7a  .......WRIT.B..z
  2390: 49 4f 31 41 0a 02 00 0a 00 57 52 49 54 0a 43 0a  IO1A.....WRIT.C.
  23a0: 03 7a 49 4f 31 41 0a 08 00 0a 00 82 49 52 51 42  .zIO1A......IRQB
  23b0: 60 a0 25 60 76 60 57 52 49 54 0a 1b 0a 0f 79 60  `.%`v`WRIT....y`
  23c0: 0a 04 00 0a 00 57 52 49 54 0a 1b 0a f8 83 88 58  .....WRIT......X
  23d0: 52 46 49 60 00 0a 00 a1 0d 57 52 49 54 0a 1b 0a  RFI`.....WRIT...
  23e0: 08 0a 00 0a 00 57 52 49 54 0a 00 0a fe 0a 01 0a  .....WRIT.......
  23f0: 00 5b 27 53 4c 4f 4b 14 1e 42 5f 50 52 00 5b 23  .['SLOK..B_PR.[#
  2400: 53 4c 4f 4b ff ff 70 50 53 50 53 0a 10 60 5b 27  SLOK..pPSPS..`['
  2410: 53 4c 4f 4b a4 60 14 1a 42 5f 44 49 00 5b 23 53  SLOK.`..B_DI.[#S
  2420: 4c 4f 4b ff ff 50 53 44 49 0a 10 5b 27 53 4c 4f  LOK..PSDI..['SLO
  2430: 4b 14 1e 5f 53 54 41 00 5b 23 53 4c 4f 4b ff ff  K.._STA.[#SLOK..
  2440: 70 50 53 53 54 0a 10 60 5b 27 53 4c 4f 4b a4 60  pPSST..`['SLOK.`
  2450: 08 5f 50 53 43 0a 00 5b 82 48 21 4c 50 54 42 08  ._PSC..[.H!LPTB.
  2460: 5f 48 49 44 0c 41 d0 04 00 08 5f 55 49 44 0a 02  _HID.A...._UID..
  2470: 08 4d 43 44 5f 0a 11 08 43 52 53 42 11 10 0a 0d  .MCD_...CRSB....
  2480: 47 01 00 00 00 00 01 08 22 00 00 79 00 14 4f 0b  G......."..y..O.
  2490: 5f 43 52 53 00 a0 4e 0a 5c 2f 05 5f 53 42 5f 50  _CRS..N.\/._SB_P
  24a0: 43 49 30 49 53 41 5f 4c 50 54 42 5f 53 54 41 5b  CI0ISA_LPTB_STA[
  24b0: 23 53 4c 4f 4b ff ff 8b 43 52 53 42 0a 02 49 4f  #SLOK...CRSB..IO
  24c0: 31 42 8b 43 52 53 42 0a 04 49 4f 32 42 8b 43 52  1B.CRSB..IO2B.CR
  24d0: 53 42 0a 06 49 4f 33 42 8b 43 52 53 42 0a 09 49  SB..IO3B.CRSB..I
  24e0: 52 51 42 7d 79 7b 52 34 33 30 0a fc 00 0a 08 00  RQB}y{R430......
  24f0: 79 52 34 32 30 0a 02 00 49 4f 31 42 70 49 4f 31  yR420...IO1BpIO1
  2500: 42 49 4f 32 42 a0 11 93 49 4f 31 42 0b bc 03 70  BIO2B...IO1B...p
  2510: 0b 01 04 49 4f 33 42 70 00 49 52 51 42 7a 52 45  ...IO3Bp.IRQBzRE
  2520: 41 44 0a 1b 0a f0 0a 00 0a 04 60 a0 0a 60 79 0a  AD........`..`y.
  2530: 01 60 49 52 51 42 70 43 52 53 42 61 5b 27 53 4c  .`IRQBpCRSBa['SL
  2540: 4f 4b a4 61 a1 08 a4 11 05 0a 02 79 00 14 43 0c  OK.a.......y..C.
  2550: 42 5f 53 52 01 08 58 52 46 49 12 22 10 0a 00 0a  B_SR..XRFI."....
  2560: 00 0a 00 0a 00 0a 00 0a 07 0a 00 0a 01 0a 00 0a  ................
  2570: 02 0a 03 0a 04 0a 00 0a 00 0a 05 0a 06 8b 68 0a  ..............h.
  2580: 02 49 4f 31 41 8b 68 0a 09 49 52 51 42 5b 23 53  .IO1A.h..IRQB[#S
  2590: 4c 4f 4b ff ff 57 52 49 54 0a 00 0a fe 0a 00 0a  LOK..WRIT.......
  25a0: 00 57 52 49 54 0a 42 0a 00 7a 49 4f 31 41 0a 02  .WRIT.B..zIO1A..
  25b0: 00 0a 00 57 52 49 54 0a 43 0a 03 7a 49 4f 31 41  ...WRIT.C..zIO1A
  25c0: 0a 08 00 0a 00 82 49 52 51 42 60 a0 25 60 76 60  ......IRQB`.%`v`
  25d0: 57 52 49 54 0a 1b 0a 0f 79 60 0a 04 00 0a 00 57  WRIT....y`.....W
  25e0: 52 49 54 0a 1b 0a f8 83 88 58 52 46 49 60 00 0a  RIT......XRFI`..
  25f0: 00 a1 0d 57 52 49 54 0a 1b 0a 08 0a 00 0a 00 57  ...WRIT........W
  2600: 52 49 54 0a 00 0a fe 0a 01 0a 00 5b 27 53 4c 4f  RIT........['SLO
  2610: 4b 14 1e 42 5f 50 52 00 5b 23 53 4c 4f 4b ff ff  K..B_PR.[#SLOK..
  2620: 70 50 53 50 53 0a 11 60 5b 27 53 4c 4f 4b a4 60  pPSPS..`['SLOK.`
  2630: 14 1a 42 5f 44 49 00 5b 23 53 4c 4f 4b ff ff 50  ..B_DI.[#SLOK..P
  2640: 53 44 49 0a 11 5b 27 53 4c 4f 4b 14 1e 5f 53 54  SDI..['SLOK.._ST
  2650: 41 00 5b 23 53 4c 4f 4b ff ff 70 50 53 53 54 0a  A.[#SLOK..pPSST.
  2660: 11 60 5b 27 53 4c 4f 4b a4 60 08 5f 50 53 43 0a  .`['SLOK.`._PSC.
  2670: 00 5b 82 41 2b 45 43 50 5f 08 5f 48 49 44 0c 41  .[.A+ECP_._HID.A
  2680: d0 04 01 08 4d 43 44 5f 0a 12 08 43 52 53 41 11  ....MCD_...CRSA.
  2690: 1b 0a 18 47 01 00 00 00 00 01 08 47 01 00 00 00  ...G.......G....
  26a0: 00 01 08 22 00 00 2a 00 00 79 00 14 41 13 5f 43  ..."..*..y..A._C
  26b0: 52 53 00 a0 40 12 5c 2f 05 5f 53 42 5f 50 43 49  RS..@.\/._SB_PCI
  26c0: 30 49 53 41 5f 45 43 50 5f 5f 53 54 41 8b 43 52  0ISA_ECP__STA.CR
  26d0: 53 41 0a 02 49 4f 31 41 8b 43 52 53 41 0a 04 49  SA..IO1A.CRSA..I
  26e0: 4f 32 41 8b 43 52 53 41 0a 06 49 4f 33 41 8b 43  O2A.CRSA..IO3A.C
  26f0: 52 53 41 0a 0a 49 4f 34 41 8b 43 52 53 41 0a 0c  RSA..IO4A.CRSA..
  2700: 49 4f 35 41 8b 43 52 53 41 0a 0e 49 4f 36 41 8b  IO5A.CRSA..IO6A.
  2710: 43 52 53 41 0a 11 49 52 51 41 8c 43 52 53 41 0a  CRSA..IRQA.CRSA.
  2720: 14 44 4d 41 41 5b 23 53 4c 4f 4b ff ff 7d 79 7b  .DMAA[#SLOK..}y{
  2730: 52 34 33 30 0a fc 00 0a 08 00 79 52 34 32 30 0a  R430......yR420.
  2740: 02 00 49 4f 31 41 70 49 4f 31 41 49 4f 32 41 72  ..IO1ApIO1AIO2Ar
  2750: 49 4f 31 41 0b 00 04 49 4f 34 41 72 49 4f 31 41  IO1A...IO4ArIO1A
  2760: 0b 00 04 49 4f 35 41 a0 19 93 49 4f 31 41 0b bc  ...IO5A...IO1A..
  2770: 03 70 0b 01 04 49 4f 33 41 70 0b 01 03 49 4f 36  .p...IO3Ap...IO6
  2780: 41 a1 09 70 0b 01 03 49 4f 36 41 70 00 49 52 51  A..p...IO6Ap.IRQ
  2790: 41 7a 52 45 41 44 0a 1b 0a f0 0a 00 0a 04 60 a0  AzREAD........`.
  27a0: 0a 60 79 0a 01 60 49 52 51 41 7a 52 45 41 44 0a  .`y..`IRQAzREAD.
  27b0: 18 0a 06 0a 00 0a 01 44 4d 41 41 79 0a 01 44 4d  .......DMAAy..DM
  27c0: 41 41 44 4d 41 41 70 43 52 53 41 61 5b 27 53 4c  AADMAApCRSAa['SL
  27d0: 4f 4b a4 61 a1 08 a4 11 05 0a 02 79 00 14 46 0e  OK.a.......y..F.
  27e0: 42 5f 53 52 01 08 58 52 46 49 12 22 10 0a 00 0a  B_SR..XRFI."....
  27f0: 00 0a 00 0a 00 0a 00 0a 07 0a 00 0a 01 0a 00 0a  ................
  2800: 02 0a 03 0a 04 0a 00 0a 00 0a 05 0a 06 8b 68 0a  ..............h.
  2810: 02 49 4f 31 41 8b 68 0a 11 49 52 51 41 8c 68 0a  .IO1A.h..IRQA.h.
  2820: 14 44 4d 41 41 5b 23 53 4c 4f 4b ff ff 57 52 49  .DMAA[#SLOK..WRI
  2830: 54 0a 00 0a fe 0a 00 0a 00 57 52 49 54 0a 42 0a  T........WRIT.B.
  2840: 00 7a 49 4f 31 41 0a 02 00 0a 00 57 52 49 54 0a  .zIO1A.....WRIT.
  2850: 43 0a 03 7a 49 4f 31 41 0a 08 00 0a 00 82 49 52  C..zIO1A......IR
  2860: 51 41 60 a0 25 60 76 60 57 52 49 54 0a 1b 0a 0f  QA`.%`v`WRIT....
  2870: 79 60 0a 04 00 0a 00 57 52 49 54 0a 1b 0a f8 83  y`.....WRIT.....
  2880: 88 58 52 46 49 60 00 0a 00 a1 0d 57 52 49 54 0a  .XRFI`.....WRIT.
  2890: 1b 0a 08 0a 00 0a 00 82 44 4d 41 41 60 57 52 49  ........DMAA`WRI
  28a0: 54 0a 18 0a c7 79 60 0a 03 00 0a 00 57 52 49 54  T....y`.....WRIT
  28b0: 0a 00 0a fe 0a 01 0a 00 50 48 53 5f 0a da 5b 27  ........PHS_..['
  28c0: 53 4c 4f 4b 14 1e 42 5f 50 52 00 5b 23 53 4c 4f  SLOK..B_PR.[#SLO
  28d0: 4b ff ff 70 50 53 50 53 0a 12 60 5b 27 53 4c 4f  K..pPSPS..`['SLO
  28e0: 4b a4 60 14 1a 42 5f 44 49 00 5b 23 53 4c 4f 4b  K.`..B_DI.[#SLOK
  28f0: ff ff 50 53 44 49 0a 12 5b 27 53 4c 4f 4b 14 1e  ..PSDI..['SLOK..
  2900: 5f 53 54 41 00 5b 23 53 4c 4f 4b ff ff 70 50 53  _STA.[#SLOK..pPS
  2910: 53 54 0a 12 60 5b 27 53 4c 4f 4b a4 60 08 5f 50  ST..`['SLOK.`._P
  2920: 53 43 0a 00 5b 82 42 21 45 50 50 5f 08 5f 48 49  SC..[.B!EPP_._HI
  2930: 44 0c 41 d0 04 00 08 5f 55 49 44 0a 03 08 4d 43  D.A...._UID...MC
  2940: 44 5f 0a 13 08 43 52 53 42 11 10 0a 0d 47 01 00  D_...CRSB....G..
  2950: 00 00 00 01 08 22 00 00 79 00 14 4d 0a 5f 43 52  ....."..y..M._CR
  2960: 53 00 a0 4c 09 5c 2f 05 5f 53 42 5f 50 43 49 30  S..L.\/._SB_PCI0
  2970: 49 53 41 5f 45 50 50 5f 5f 53 54 41 8b 43 52 53  ISA_EPP__STA.CRS
  2980: 42 0a 02 49 4f 31 42 8b 43 52 53 42 0a 04 49 4f  B..IO1B.CRSB..IO
  2990: 32 42 8b 43 52 53 42 0a 06 49 4f 33 42 8b 43 52  2B.CRSB..IO3B.CR
  29a0: 53 42 0a 09 49 52 51 42 5b 23 53 4c 4f 4b ff ff  SB..IRQB[#SLOK..
  29b0: 7d 79 7b 52 34 33 30 0a fc 00 0a 08 00 79 52 34  }y{R430......yR4
  29c0: 32 30 0a 02 00 49 4f 31 42 70 49 4f 31 42 49 4f  20...IO1BpIO1BIO
  29d0: 32 42 70 00 49 52 51 42 7a 52 45 41 44 0a 1b 0a  2Bp.IRQBzREAD...
  29e0: f0 0a 00 0a 04 60 a0 0a 60 79 0a 01 60 49 52 51  .....`..`y..`IRQ
  29f0: 42 70 43 52 53 42 61 5b 27 53 4c 4f 4b a4 61 a1  BpCRSBa['SLOK.a.
  2a00: 08 a4 11 05 0a 02 79 00 14 4f 0c 42 5f 53 52 01  ......y..O.B_SR.
  2a10: 08 58 52 46 49 12 22 10 0a 00 0a 00 0a 00 0a 00  .XRFI.".........
  2a20: 0a 00 0a 07 0a 00 0a 01 0a 00 0a 02 0a 03 0a 04  ................
  2a30: 0a 00 0a 00 0a 05 0a 06 8b 68 0a 02 49 4f 31 41  .........h..IO1A
  2a40: 8b 68 0a 09 49 52 51 42 5b 23 53 4c 4f 4b ff ff  .h..IRQB[#SLOK..
  2a50: 57 52 49 54 0a 00 0a fe 0a 00 0a 00 57 52 49 54  WRIT........WRIT
  2a60: 0a 42 0a 00 7a 49 4f 31 41 0a 02 00 0a 00 57 52  .B..zIO1A.....WR
  2a70: 49 54 0a 43 0a 03 7a 49 4f 31 41 0a 08 00 0a 00  IT.C..zIO1A.....
  2a80: 82 49 52 51 42 60 a0 25 60 76 60 57 52 49 54 0a  .IRQB`.%`v`WRIT.
  2a90: 1b 0a 0f 79 60 0a 04 00 0a 00 57 52 49 54 0a 1b  ...y`.....WRIT..
  2aa0: 0a f8 83 88 58 52 46 49 60 00 0a 00 a1 0d 57 52  ....XRFI`.....WR
  2ab0: 49 54 0a 1b 0a 08 0a 00 0a 00 57 52 49 54 0a 00  IT........WRIT..
  2ac0: 0a fe 0a 01 0a 00 57 52 49 54 0a 04 0a fa 0a 01  ......WRIT......
  2ad0: 0a 00 5b 27 53 4c 4f 4b 14 1e 42 5f 50 52 00 5b  ..['SLOK..B_PR.[
  2ae0: 23 53 4c 4f 4b ff ff 70 50 53 50 53 0a 13 60 5b  #SLOK..pPSPS..`[
  2af0: 27 53 4c 4f 4b a4 60 14 1a 42 5f 44 49 00 5b 23  'SLOK.`..B_DI.[#
  2b00: 53 4c 4f 4b ff ff 50 53 44 49 0a 13 5b 27 53 4c  SLOK..PSDI..['SL
  2b10: 4f 4b 14 1e 5f 53 54 41 00 5b 23 53 4c 4f 4b ff  OK.._STA.[#SLOK.
  2b20: ff 70 50 53 53 54 0a 13 60 5b 27 53 4c 4f 4b a4  .pPSST..`['SLOK.
  2b30: 60 08 5f 50 53 43 0a 00 5b 80 53 49 4f 52 01 0b  `._PSC..[.SIOR..
  2b40: 98 03 0a 02 5b 81 10 53 49 4f 52 01 49 4e 44 58  ....[..SIOR.INDX
  2b50: 08 44 41 54 41 08 5b 86 40 05 49 4e 44 58 44 41  .DATA.[.@.INDXDA
  2b60: 54 41 01 52 30 30 30 08 00 08 52 30 32 30 08 00  TA.R000...R020..
  2b70: 08 52 30 34 30 08 00 48 1e 52 34 32 30 08 52 34  .R040..H.R420.R4
  2b80: 33 30 08 52 34 34 30 08 52 34 35 30 08 52 34 36  30.R440.R450.R46
  2b90: 30 08 52 34 37 30 08 52 34 38 30 08 52 34 39 30  0.R470.R480.R490
  2ba0: 08 00 28 52 34 46 30 08 14 18 52 45 41 44 03 a0  ..(R4F0...READ..
  2bb0: 11 92 6a 70 68 49 4e 44 58 a4 7b 44 41 54 41 69  ..jphINDX.{DATAi
  2bc0: 00 14 2e 57 52 49 54 04 a0 25 92 6b 70 68 49 4e  ...WRIT..%.kphIN
  2bd0: 44 58 7d 7b 44 41 54 41 69 00 6a 60 70 68 49 4e  DX}{DATAi.j`phIN
  2be0: 44 58 70 60 44 41 54 41 70 60 44 41 54 41 a1 01  DXp`DATAp`DATA..
  2bf0: 5b 82 45 25 53 4e 43 5f 08 5f 48 49 44 0c 4d d9  [.E%SNC_._HID.M.
  2c00: 50 01 14 0f 47 50 49 44 00 a4 50 48 53 42 0a c1  P...GPID..PHSB..
  2c10: 0a 00 14 40 05 47 42 52 54 00 a0 25 93 5c 2f 05  ...-vRWMzq4NRuc@public.gmane.org%.\/.
  2c20: 5f 53 42 5f 50 43 49 30 49 53 41 5f 45 43 30 5f  _SB_PCI0ISA_EC0_
  2c30: 45 43 4f 4b 0a 00 70 50 48 53 44 0a db 0a 96 60  ECOK..pPHSD....`
  2c40: a1 1a 70 5c 2f 05 5f 53 42 5f 50 43 49 30 49 53  ..p\/._SB_PCI0IS
  2c50: 41 5f 45 43 30 5f 42 52 49 54 60 a4 50 48 53 42  A_EC0_BRIT`.PHSB
  2c60: 0a d2 60 14 40 05 53 42 52 54 01 70 50 48 53 42  ..`.-oYVBL3lRgRZef1c+Zt+eqQ@public.gmane.org
  2c70: 0a d0 68 60 a0 22 93 5c 2f 05 5f 53 42 5f 50 43  ..h`.".\/._SB_PC
  2c80: 49 30 49 53 41 5f 45 43 30 5f 45 43 4f 4b 0a 00  I0ISA_EC0_ECOK..
  2c90: 50 48 53 42 0a de 60 a1 1a 70 60 5c 2f 05 5f 53  PHSB..`..p`\/._S
  2ca0: 42 5f 50 43 49 30 49 53 41 5f 45 43 30 5f 42 52  B_PCI0ISA_EC0_BR
  2cb0: 49 54 a4 00 14 0f 47 50 42 52 00 a4 50 48 53 42  IT....GPBR..PHSB
  2cc0: 0a c6 0a 00 14 0f 53 50 42 52 01 50 48 53 42 0a  ......SPBR.PHSB.
  2cd0: c7 68 a4 00 14 40 05 47 43 54 52 00 a0 25 93 5c  .h...-MnZaZ0pevGA@public.gmane.org%.\
  2ce0: 2f 05 5f 53 42 5f 50 43 49 30 49 53 41 5f 45 43  /._SB_PCI0ISA_EC
  2cf0: 30 5f 45 43 4f 4b 0a 00 70 50 48 53 44 0a db 0a  0_ECOK..pPHSD...
  2d00: 97 60 a1 1a 70 5c 2f 05 5f 53 42 5f 50 43 49 30  .`..p\/._SB_PCI0
  2d10: 49 53 41 5f 45 43 30 5f 43 4f 4e 54 60 a4 50 48  ISA_EC0_CONT`.PH
  2d20: 53 42 0a d3 60 14 40 05 53 43 54 52 01 70 50 48  SB..`.-za3q/rWui1aVvH7r1IiJvQ@public.gmane.org
  2d30: 53 42 0a d1 68 60 a0 22 93 5c 2f 05 5f 53 42 5f  SB..h`.".\/._SB_
  2d40: 50 43 49 30 49 53 41 5f 45 43 30 5f 45 43 4f 4b  PCI0ISA_EC0_ECOK
  2d50: 0a 00 50 48 53 42 0a df 60 a1 1a 70 60 5c 2f 05  ..PHSB..`..p`\/.
  2d60: 5f 53 42 5f 50 43 49 30 49 53 41 5f 45 43 30 5f  _SB_PCI0ISA_EC0_
  2d70: 43 4f 4e 54 a4 00 14 0f 47 50 43 52 00 a4 50 48  CONT....GPCR..PH
  2d80: 53 42 0a c8 0a 00 14 0f 53 50 43 52 01 50 48 53  SB......SPCR.PHS
  2d90: 42 0a c9 68 a4 00 14 0f 53 4c 56 54 00 a4 50 48  B..h....SLVT..PH
  2da0: 53 42 0a ca 0a 00 14 0f 53 4c 54 54 00 a4 50 48  SB......SLTT..PH
  2db0: 53 42 0a cb 0a 00 14 0f 53 45 56 46 00 a4 50 48  SB......SEVF..PH
  2dc0: 53 42 0a cc 0a 00 14 0e 47 43 4d 49 01 a4 50 48  SB......GCMI..PH
  2dd0: 53 44 0a ce 68 14 0e 53 43 4d 49 01 a4 50 48 53  SD..h..SCMI..PHS
  2de0: 44 0a cf 68 14 09 50 57 41 4b 00 a3 a4 00 14 13  D..h..PWAK......
  2df0: 50 57 52 4e 00 86 5c 2e 5f 53 42 5f 50 57 52 42  PWRN..\._SB_PWRB
  2e00: 0a 80 14 28 43 53 58 42 01 5b 23 4d 50 48 53 ff  ...(CSXB.[#MPHS.
  2e10: ff 70 68 53 58 42 46 50 48 53 30 0a e2 70 53 58  .phSXBFPHS0..pSX
  2e20: 42 46 60 5b 27 4d 50 48 53 a4 60 14 1b 43 4d 47  BF`['MPHS.`..CMG
  2e30: 42 01 a0 09 68 70 0a 00 47 4f 31 32 a1 08 70 0a  B...hp..GO12..p.
  2e40: 01 47 4f 31 32 a4 00 5b 80 47 45 4e 43 02 0a b0  .GO12..[.GENC...
  2e50: 0a 04 5b 81 1c 47 45 4e 43 03 49 53 41 53 01 50  ..[..GENC.ISAS.P
  2e60: 4f 53 44 01 00 09 49 44 30 54 01 49 44 31 54 01  OSD...ID0T.ID1T.
  2e70: 5b 80 50 43 49 5f 02 0a 60 0a 04 5b 81 0b 50 43  [.PCI_..`..[..PC
  2e80: 49 5f 03 50 49 52 51 20 08 50 31 5f 5f 11 04 0a  I_.PIRQ .P1__...
  2e90: 04 00 14 0f 52 45 53 50 00 70 50 31 5f 5f 50 49  ....RESP.pP1__PI
  2ea0: 52 51 14 0f 53 41 56 50 00 70 50 49 52 51 50 31  RQ..SAVP.pPIRQP1
  2eb0: 5f 5f 10 31 5c 5f 53 49 5f 14 2a 5f 53 53 54 01  __.1\_SI_.*_SST.
  2ec0: a0 05 93 68 0a 00 a0 05 93 68 0a 01 a0 05 93 68  ...h.....h.....h
  2ed0: 0a 02 a0 05 93 68 0a 03 a0 05 93 68 0a 04 a0 05  .....h.....h....
  2ee0: 93 68 0a 05 14 45 10 5f 57 41 4b 01 70 0a 00 5c  .h...E._WAK.p..\
  2ef0: 2f 03 5f 53 42 5f 50 43 49 30 43 52 53 54 a0 0b  /._SB_PCI0CRST..
  2f00: 93 68 0a 01 50 48 53 5f 0a e0 a0 46 08 93 68 0a  .h..PHS_...F..h.
  2f10: 04 5c 2f 05 5f 53 42 5f 50 43 49 30 49 53 41 5f  .\/._SB_PCI0ISA_
  2f20: 53 50 49 43 5f 53 52 53 5c 2f 05 5f 53 42 5f 50  SPIC_SRS\/._SB_P
  2f30: 43 49 30 49 53 41 5f 53 50 49 43 53 53 52 43 a0  CI0ISA_SPICSSRC.
  2f40: 28 93 53 43 4d 50 5c 5f 4f 53 5f 0d 4d 69 63 72  (.SCMP\_OS_.Micr
  2f50: 6f 73 6f 66 74 20 57 69 6e 64 6f 77 73 20 4e 54  osoft Windows NT
  2f60: 00 00 50 48 53 5f 0a e6 a1 28 a0 26 92 93 53 43  ..PHS_...(.&..SC
  2f70: 4d 50 5c 5f 4f 53 5f 0d 4d 69 63 72 6f 73 6f 66  MP\_OS_.Microsof
  2f80: 74 20 57 69 6e 64 6f 77 73 00 00 50 48 53 5f 0a  t Windows..PHS_.
  2f90: e6 a0 23 93 53 43 4d 50 5c 5f 4f 53 5f 0d 4d 69  ..#.SCMP\_OS_.Mi
  2fa0: 63 72 6f 73 6f 66 74 20 57 69 6e 64 6f 77 73 20  crosoft Windows 
  2fb0: 4e 54 00 00 a3 a1 32 a0 21 92 93 53 43 4d 50 5c  NT....2.!..SCMP\
  2fc0: 5f 4f 53 5f 0d 4d 69 63 72 6f 73 6f 66 74 20 57  _OS_.Microsoft W
  2fd0: 69 6e 64 6f 77 73 00 00 a3 a1 0e 86 5c 2e 5f 53  indows......\._S
  2fe0: 42 5f 50 57 52 42 0a 02 a4 00 10 4f 0a 5c 5f 54  B_PWRB.....O.\_T
  2ff0: 5a 5f 5b 85 46 0a 41 54 46 30 14 16 4b 45 4c 56  Z_[.F.ATF0..KELV
  3000: 01 70 68 60 77 60 0a 0a 60 72 60 0b ab 0a 60 a4  .ph`w`..`r`...`.
  3010: 60 14 2f 5f 54 4d 50 00 7a 50 48 53 44 0a db 0a  `./_TMP.zPHSD...
  3020: c0 0a 08 60 a0 16 92 95 60 0a 80 5b 22 0a 32 7a  ...`....`..[".2z
  3030: 50 48 53 44 0a db 0a c0 0a 08 60 a4 4b 45 4c 56  PHSD......`.KELV
  3040: 60 14 18 5f 50 53 56 00 7a 50 48 53 44 0a db 0a  `.._PSV.zPHSD...
  3050: c4 0a 08 60 a4 4b 45 4c 56 60 08 5f 50 53 4c 12  ...`.KELV`._PSL.
  3060: 0c 01 5c 2e 5f 50 52 5f 43 50 55 30 14 18 5f 43  ..\._PR_CPU0.._C
  3070: 52 54 00 7a 50 48 53 44 0a db 0a c6 0a 08 60 a4  RT.zPHSD......`.
  3080: 4b 45 4c 56 60 08 5f 54 43 31 0a 01 08 5f 54 43  KELV`._TC1..._TC
  3090: 32 0a 01 08 5f 54 53 50 0a 32 10 43 4d 5f 53 42  2..._TSP.2.CM_SB
  30a0: 5f 08 49 52 51 50 12 23 10 0a 00 0a 00 0a 00 0a  _.IRQP.#........
  30b0: 00 0a 00 0a 00 0a 00 0a 00 0a 00 0b 00 02 0a 00  ................
  30c0: 0a 00 0a 00 0a 00 0a 00 0a 00 5b 82 47 12 4c 4e  ..........[.G.LN
  30d0: 4b 41 08 5f 48 49 44 0c 41 d0 0c 0f 08 5f 55 49  KA._HID.A...._UI
  30e0: 44 0a 01 08 5f 50 52 53 11 09 0a 06 23 00 02 18  D..._PRS....#...
  30f0: 79 00 14 2f 5f 44 49 53 00 7d 5c 2f 04 5f 53 42  y../_DIS.}\/._SB
  3100: 5f 50 43 49 30 49 53 41 5f 50 49 52 41 0a 80 5c  _PCI0ISA_PIRA..\
  3110: 2f 04 5f 53 42 5f 50 43 49 30 49 53 41 5f 50 49  /._SB_PCI0ISA_PI
  3120: 52 41 14 48 05 5f 43 52 53 00 08 42 55 46 41 11  RA.H._CRS..BUFA.
  3130: 09 0a 06 23 00 00 18 79 00 8b 42 55 46 41 0a 01  ...#...y..BUFA..
  3140: 49 52 41 31 7b 5c 2f 04 5f 53 42 5f 50 43 49 30  IRA1{\/._SB_PCI0
  3150: 49 53 41 5f 50 49 52 41 0a 8f 60 a0 1a 95 60 0a  ISA_PIRA..`...`.
  3160: 80 7b 60 0a 0f 60 70 83 88 49 52 51 50 60 00 64  .{`..`p..IRQP`.d
  3170: 70 64 49 52 41 31 a4 42 55 46 41 14 40 05 5f 53  pdIRA1.BUFA.@._S
  3180: 52 53 01 8b 68 0a 01 49 52 41 31 70 49 52 41 31  RS..h..IRA1pIRA1
  3190: 60 70 89 49 52 51 50 01 60 00 0a 00 0a 00 61 7b  `p.IRQP.`.....a{
  31a0: 5c 2f 04 5f 53 42 5f 50 43 49 30 49 53 41 5f 50  \/._SB_PCI0ISA_P
  31b0: 49 52 41 0a 70 60 7d 61 60 5c 2f 04 5f 53 42 5f  IRA.p`}a`\/._SB_
  31c0: 50 43 49 30 49 53 41 5f 50 49 52 41 14 26 5f 53  PCI0ISA_PIRA.&_S
  31d0: 54 41 00 a0 1a 93 5c 2f 04 5f 53 42 5f 50 43 49  TA....\/._SB_PCI
  31e0: 30 49 53 41 5f 50 49 52 41 0a 80 a4 0a 09 a1 04  0ISA_PIRA.......
  31f0: a4 0a 0b 5b 82 47 12 4c 4e 4b 42 08 5f 48 49 44  ...[.G.LNKB._HID
  3200: 0c 41 d0 0c 0f 08 5f 55 49 44 0a 02 08 5f 50 52  .A...._UID..._PR
  3210: 53 11 09 0a 06 23 00 02 18 79 00 14 2f 5f 44 49  S....#...y../_DI
  3220: 53 00 7d 5c 2f 04 5f 53 42 5f 50 43 49 30 49 53  S.}\/._SB_PCI0IS
  3230: 41 5f 50 49 52 42 0a 80 5c 2f 04 5f 53 42 5f 50  A_PIRB..\/._SB_P
  3240: 43 49 30 49 53 41 5f 50 49 52 42 14 48 05 5f 43  CI0ISA_PIRB.H._C
  3250: 52 53 00 08 42 55 46 41 11 09 0a 06 23 00 00 18  RS..BUFA....#...
  3260: 79 00 8b 42 55 46 41 0a 01 49 52 41 31 7b 5c 2f  y..BUFA..IRA1{\/
  3270: 04 5f 53 42 5f 50 43 49 30 49 53 41 5f 50 49 52  ._SB_PCI0ISA_PIR
  3280: 42 0a 8f 60 a0 1a 95 60 0a 80 7b 60 0a 0f 60 70  B..`...`..{`..`p
  3290: 83 88 49 52 51 50 60 00 64 70 64 49 52 41 31 a4  ..IRQP`.dpdIRA1.
  32a0: 42 55 46 41 14 40 05 5f 53 52 53 01 8b 68 0a 01  BUFA.-M1bAd7IOAFGtXF2fZOsJYA@public.gmane.org
  32b0: 49 52 41 31 70 49 52 41 31 60 70 89 49 52 51 50  IRA1pIRA1`p.IRQP
  32c0: 01 60 00 0a 00 0a 00 61 7b 5c 2f 04 5f 53 42 5f  .`.....a{\/._SB_
  32d0: 50 43 49 30 49 53 41 5f 50 49 52 42 0a 70 60 7d  PCI0ISA_PIRB.p`}
  32e0: 61 60 5c 2f 04 5f 53 42 5f 50 43 49 30 49 53 41  a`\/._SB_PCI0ISA
  32f0: 5f 50 49 52 42 14 26 5f 53 54 41 00 a0 1a 93 5c  _PIRB.&_STA....\
  3300: 2f 04 5f 53 42 5f 50 43 49 30 49 53 41 5f 50 49  /._SB_PCI0ISA_PI
  3310: 52 42 0a 80 a4 0a 09 a1 04 a4 0a 0b 5b 82 47 12  RB..........[.G.
  3320: 4c 4e 4b 43 08 5f 48 49 44 0c 41 d0 0c 0f 08 5f  LNKC._HID.A...._
  3330: 55 49 44 0a 03 08 5f 50 52 53 11 09 0a 06 23 00  UID..._PRS....#.
  3340: 02 18 79 00 14 2f 5f 44 49 53 00 7d 5c 2f 04 5f  ..y../_DIS.}\/._
  3350: 53 42 5f 50 43 49 30 49 53 41 5f 50 49 52 43 0a  SB_PCI0ISA_PIRC.
  3360: 80 5c 2f 04 5f 53 42 5f 50 43 49 30 49 53 41 5f  .\/._SB_PCI0ISA_
  3370: 50 49 52 43 14 48 05 5f 43 52 53 00 08 42 55 46  PIRC.H._CRS..BUF
  3380: 41 11 09 0a 06 23 00 00 18 79 00 8b 42 55 46 41  A....#...y..BUFA
  3390: 0a 01 49 52 41 31 7b 5c 2f 04 5f 53 42 5f 50 43  ..IRA1{\/._SB_PC
  33a0: 49 30 49 53 41 5f 50 49 52 43 0a 8f 60 a0 1a 95  I0ISA_PIRC..`...
  33b0: 60 0a 80 7b 60 0a 0f 60 70 83 88 49 52 51 50 60  `..{`..`p..IRQP`
  33c0: 00 64 70 64 49 52 41 31 a4 42 55 46 41 14 40 05  .dpdIRA1.BUFA.@.
  33d0: 5f 53 52 53 01 8b 68 0a 01 49 52 41 31 70 49 52  _SRS..h..IRA1pIR
  33e0: 41 31 60 70 89 49 52 51 50 01 60 00 0a 00 0a 00  A1`p.IRQP.`.....
  33f0: 61 7b 5c 2f 04 5f 53 42 5f 50 43 49 30 49 53 41  a{\/._SB_PCI0ISA
  3400: 5f 50 49 52 43 0a 70 60 7d 61 60 5c 2f 04 5f 53  _PIRC.p`}a`\/._S
  3410: 42 5f 50 43 49 30 49 53 41 5f 50 49 52 43 14 26  B_PCI0ISA_PIRC.&
  3420: 5f 53 54 41 00 a0 1a 93 5c 2f 04 5f 53 42 5f 50  _STA....\/._SB_P
  3430: 43 49 30 49 53 41 5f 50 49 52 43 0a 80 a4 0a 09  CI0ISA_PIRC.....
  3440: a1 04 a4 0a 0b 5b 82 47 12 4c 4e 4b 44 08 5f 48  .....[.G.LNKD._H
  3450: 49 44 0c 41 d0 0c 0f 08 5f 55 49 44 0a 04 08 5f  ID.A...._UID..._
  3460: 50 52 53 11 09 0a 06 23 00 02 18 79 00 14 2f 5f  PRS....#...y../_
  3470: 44 49 53 00 7d 5c 2f 04 5f 53 42 5f 50 43 49 30  DIS.}\/._SB_PCI0
  3480: 49 53 41 5f 50 49 52 44 0a 80 5c 2f 04 5f 53 42  ISA_PIRD..\/._SB
  3490: 5f 50 43 49 30 49 53 41 5f 50 49 52 44 14 48 05  _PCI0ISA_PIRD.H.
  34a0: 5f 43 52 53 00 08 42 55 46 41 11 09 0a 06 23 00  _CRS..BUFA....#.
  34b0: 00 18 79 00 8b 42 55 46 41 0a 01 49 52 41 31 7b  ..y..BUFA..IRA1{
  34c0: 5c 2f 04 5f 53 42 5f 50 43 49 30 49 53 41 5f 50  \/._SB_PCI0ISA_P
  34d0: 49 52 44 0a 8f 60 a0 1a 95 60 0a 80 7b 60 0a 0f  IRD..`...`..{`..
  34e0: 60 70 83 88 49 52 51 50 60 00 64 70 64 49 52 41  `p..IRQP`.dpdIRA
  34f0: 31 a4 42 55 46 41 14 40 05 5f 53 52 53 01 8b 68  1.BUFA.-M1bAd7IOAFE@public.gmane.org
  3500: 0a 01 49 52 41 31 70 49 52 41 31 60 70 89 49 52  ..IRA1pIRA1`p.IR
  3510: 51 50 01 60 00 0a 00 0a 00 61 7b 5c 2f 04 5f 53  QP.`.....a{\/._S
  3520: 42 5f 50 43 49 30 49 53 41 5f 50 49 52 44 0a 70  B_PCI0ISA_PIRD.p
  3530: 60 7d 61 60 5c 2f 04 5f 53 42 5f 50 43 49 30 49  `}a`\/._SB_PCI0I
  3540: 53 41 5f 50 49 52 44 14 26 5f 53 54 41 00 a0 1a  SA_PIRD.&_STA...
  3550: 93 5c 2f 04 5f 53 42 5f 50 43 49 30 49 53 41 5f  .\/._SB_PCI0ISA_
  3560: 50 49 52 44 0a 80 a4 0a 09 a1 04 a4 0a 0b        PIRD..........

FACS @ 0x07ffffc0
  0000: 46 41 43 53 40 00 00 00 88 0f 00 00 00 00 00 00  FACS-BlbsxGdv4A7jshiNgxcy3g@public.gmane.org
  0010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  0020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  0030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................

BOOT @ 0x07fff7d8
  0000: 42 4f 4f 54 28 00 00 00 01 3a 53 4f 4e 59 20 20  BOOT(....:SONY  
  0010: 5a 33 20 20 20 20 20 20 25 08 00 20 50 54 4c 20  Z3      %.. PTL 
  0020: 01 00 00 00 35 00 00 00                          ....5...


--Boundary_(ID_EbCCJti3+s2CFLPOP17awQ)--


-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
