From: =?iso-8859-1?Q?Herv=E9?= Eychenne <rv-tT0dJoOmRgdg9hUCZPvPmw@public.gmane.org>
Subject: fan status not working with kernel 2.6.0-test11 for Acer Travelmate 803 LCI
Date: Tue, 2 Dec 2003 19:10:33 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031202181033.GA23099@eychenne.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="l76fUT7nc3MelDdI"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--l76fUT7nc3MelDdI
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

 Hi,

I have acpi activated (as well as every acpi features) on my Acer
Travelmate 803 LCI (it's a laptop), with linux kernel 2.6.0-test11.

Everything works quite well, except that:
- old ACPI interface for performance management
  (/proc/acpi/processor/CPU0/performance) doesn't work: echoing a
  state number in it causes a small kernel oops, often killing the "su"
  session itself.
  But I don't care very much, as this interface is deprecated on 2.6,
  so I've disabled it and I use cpufreq instead, which works perfectly.
  If you're not aware of this problem and want the oops traces, just
  let me know.
- the fan is reported to be off, even when it is functionning. I'm
  currently developping a little program which ensures a "silent mode"
  (no fan activation), so it would be very useful.

# ls -lR /proc/acpi/fan/
/proc/acpi/fan/:
total 0
dr-xr-xr-x    2 root     root            0 Dec  2 18:43 FAN0
dr-xr-xr-x    2 root     root            0 Dec  2 18:43 FAN1

/proc/acpi/fan/FAN0:
total 0
-rw-r--r--    1 root     root            0 Dec  2 18:43 state

/proc/acpi/fan/FAN1:
total 0
-rw-r--r--    1 root     root            0 Dec  2 18:43 state

# cat /proc/acpi/fan/*/state
status:                  off
status:                  off

(while the processor fan _is_ running)

So, fan detection must be wrong.  What can we do to make this work?

(dmesg, dmidecode,acpidmp,lspci,/proc/interrupts and relevant kernel
config options attached)

 Herve

--=20
 _
(=B0=3D  Herv=E9 Eychenne
//)  Homepage:          http://www.eychenne.org/
v_/_ WallFire project:  http://www.wallfire.org/

--l76fUT7nc3MelDdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=acpidmp

RSDP "ACER" @ 0x000f60c0
  0000: 52 53 44 20 50 54 52 20 04 41 43 45 52 20 20 00  RSD PTR .ACER  .
  0010: 20 4c f7 1f                                       L..

RSDT @ 0x1ff74c20
  0000: 52 53 44 54 2c 00 00 00 01 03 41 43 45 52 20 20  RSDT,.....ACER  
  0010: 43 61 72 64 69 6e 61 6c 19 09 02 20 20 4c 54 50  Cardinal...  LTP
  0020: 00 00 00 00 64 af f7 1f d8 af f7 1f              ....d.......

FACP @ 0x1ff7af64
  0000: 46 41 43 50 74 00 00 00 01 21 41 43 45 52 20 20  FACPt....!ACER  
  0010: 43 61 72 64 69 6e 61 6c 19 09 02 20 50 54 4c 20  Cardinal... PTL 
  0020: 1e 00 00 00 c0 bf f7 1f 4c 4c f7 1f 00 00 09 00  ........LL......
  0030: b2 00 00 00 f0 f1 00 80 00 10 00 00 00 00 00 00  ................
  0040: 04 10 00 00 00 00 00 00 20 10 00 00 08 10 00 00  ........ .......
  0050: 28 10 00 00 00 00 00 00 04 02 01 04 08 00 10 85  (...............
  0060: 01 00 55 00 00 00 00 00 00 00 0d 00 32 00 00 00  ..U.........2...
  0070: 25 00 00 00                                      %...

DSDT @ 0x1ff74c4c
  0000: 44 53 44 54 18 63 00 00 01 59 41 43 45 52 20 20  DSDT.c...YACER  
  0010: 43 61 72 64 69 6e 61 6c 19 09 02 20 4d 53 46 54  Cardinal... MSFT
  0020: 0d 00 00 01 5b 80 44 42 47 5f 01 0a 80 0a 01 5b  ....[.DBG_.....[
  0030: 81 0b 44 42 47 5f 01 44 45 42 47 08 10 4e 0a 5f  ..DBG_.DEBG..N._
  0040: 50 52 5f 5b 83 46 0a 43 50 55 30 00 10 10 00 00  PR_[.F.CPU0.....
  0050: 06 08 5f 50 43 54 12 2c 02 11 14 0a 11 82 0c 00  .._PCT.,........
  0060: 01 08 00 00 b2 00 00 00 00 00 00 00 79 00 11 14  ............y...
  0070: 0a 11 82 0c 00 01 08 00 00 b3 00 00 00 00 00 00  ................
  0080: 00 79 00 08 5f 50 53 53 12 48 05 05 12 10 06 0b  .y.._PSS.H......
  0090: 40 06 0b c0 5d 0a 0a 0a 0a 0a 89 0a 00 12 10 06  @...]...........
  00a0: 0b 78 05 0b 20 4e 0a 0a 0a 0a 0a 8a 0a 01 12 10  .x.. N..........
  00b0: 06 0b b0 04 0b 50 46 0a 0a 0a 0a 0a 8b 0a 02 12  .....PF.........
  00c0: 10 06 0b 20 03 0b 80 3e 0a 0a 0a 0a 0a 8c 0a 03  ... ...>........
  00d0: 12 10 06 0b 58 02 0b e0 2e 0a 0a 0a 0a 0a 8d 0a  ....X...........
  00e0: 04 14 09 5f 50 50 43 00 a4 0a 00 10 3b 5f 53 49  ..._PPC.....;_SI
  00f0: 5f 14 35 5f 4d 53 47 01 a0 17 68 70 01 5c 2f 04  _.5_MSG...hp.\/.
  0100: 5f 53 42 5f 50 43 49 30 4c 50 43 30 42 4c 32 37  _SB_PCI0LPC0BL27
  0110: a1 16 70 00 5c 2f 04 5f 53 42 5f 50 43 49 30 4c  ..p.\/._SB_PCI0L
  0120: 50 43 30 42 4c 32 37 08 5c 5f 53 30 5f 12 06 02  PC0BL27.\_S0_...
  0130: 0a 00 0a 00 08 5c 5f 53 33 5f 12 06 02 0a 05 0a  .....\_S3_......
  0140: 05 08 5c 5f 53 34 5f 12 06 02 0a 06 0a 06 08 5c  ..\_S4_........\
  0150: 5f 53 35 5f 12 06 02 0a 07 0a 07 14 45 18 5f 50  _S5_........E._P
  0160: 54 53 01 70 68 5c 2e 5f 53 42 5f 53 54 41 54 70  TS.ph\._SB_STATp
  0170: 0d 3e 3e 3e 3e 20 5f 50 54 53 20 2d 2d 2d 2d 2d  .>>>> _PTS -----
  0180: 2d 2d 2d 2d 2d 2d 2d 00 5b 31 70 68 5b 31 70 68  -------.[1ph[1ph
  0190: 5c 2e 5f 53 42 5f 53 4c 45 45 70 0a 84 5c 2f 04  \._SB_SLEEp..\/.
  01a0: 5f 53 42 5f 50 43 49 30 4c 50 43 30 42 43 4d 44  _SB_PCI0LPC0BCMD
  01b0: 70 0a 00 5c 2f 04 5f 53 42 5f 50 43 49 30 4c 50  p..\/._SB_PCI0LP
  01c0: 43 30 53 4d 49 43 a0 25 7d 93 68 0a 03 93 68 0a  C0SMIC.%}.h...h.
  01d0: 04 00 70 0a 01 5c 2f 05 5f 53 42 5f 50 43 49 30  ..p..\/._SB_PCI0
  01e0: 4c 50 43 30 45 43 30 5f 41 50 57 52 a0 31 93 68  LPC0EC0_APWR.1.h
  01f0: 0a 03 70 0a 80 5c 2f 04 5f 53 42 5f 50 43 49 30  ..p..\/._SB_PCI0
  0200: 4c 50 43 30 42 43 4d 44 70 0a 00 5c 2f 04 5f 53  LPC0BCMDp..\/._S
  0210: 42 5f 50 43 49 30 4c 50 43 30 53 4d 49 43 a0 41  B_PCI0LPC0SMIC.A
  0220: 07 93 68 0a 04 70 0a 01 5c 2e 5f 53 42 5f 53 34  ..h..p..\._SB_S4
  0230: 57 50 70 0a 82 5c 2f 04 5f 53 42 5f 50 43 49 30  WPp..\/._SB_PCI0
  0240: 4c 50 43 30 42 43 4d 44 70 0a 00 5c 2f 04 5f 53  LPC0BCMDp..\/._S
  0250: 42 5f 50 43 49 30 4c 50 43 30 53 4d 49 43 70 01  B_PCI0LPC0SMICp.
  0260: 5c 2f 05 5f 53 42 5f 50 43 49 30 4c 50 43 30 45  \/._SB_PCI0LPC0E
  0270: 43 30 5f 50 46 4c 47 70 01 5c 2f 05 5f 53 42 5f  C0_PFLGp.\/._SB_
  0280: 50 43 49 30 4c 50 43 30 45 43 30 5f 53 34 4c 44  PCI0LPC0EC0_S4LD
  0290: a0 31 93 87 5c 5f 4f 53 5f 0a 27 86 5c 2e 5f 53  .1..\_OS_.'.\._S
  02a0: 42 5f 42 41 54 31 0a 80 86 5c 2e 5f 53 42 5f 42  B_BAT1...\._SB_B
  02b0: 41 54 32 0a 80 86 5c 2e 5f 53 42 5f 41 43 41 44  AT2...\._SB_ACAD
  02c0: 0a 00 a0 1e 93 68 0a 05 70 01 5c 2f 05 5f 53 42  .....h..p.\/._SB
  02d0: 5f 50 43 49 30 4c 50 43 30 45 43 30 5f 53 35 4c  _PCI0LPC0EC0_S5L
  02e0: 57 14 43 21 5f 57 41 4b 01 70 0d 3e 3e 3e 3e 20  W.C!_WAK.p.>>>> 
  02f0: 5f 57 41 4b 20 2d 2d 2d 2d 2d 2d 2d 2d 2d 2d 2d  _WAK -----------
  0300: 2d 00 5b 31 70 68 5b 31 70 68 5c 2e 5f 53 42 5f  -.[1ph[1ph\._SB_
  0310: 53 54 41 54 a0 31 93 68 0a 03 70 0a 81 5c 2f 04  STAT.1.h..p..\/.
  0320: 5f 53 42 5f 50 43 49 30 4c 50 43 30 42 43 4d 44  _SB_PCI0LPC0BCMD
  0330: 70 0a 00 5c 2f 04 5f 53 42 5f 50 43 49 30 4c 50  p..\/._SB_PCI0LP
  0340: 43 30 53 4d 49 43 a0 40 06 93 68 0a 04 a0 3f 93  C0SMIC.-68/iywnv+gw@public.gmane.org?.
  0350: 5c 2f 03 5f 53 42 5f 50 43 49 30 4d 59 4f 53 0a  \/._SB_PCI0MYOS.
  0360: 03 70 0a 83 5c 2f 04 5f 53 42 5f 50 43 49 30 4c  .p..\/._SB_PCI0L
  0370: 50 43 30 42 43 4d 44 70 0a 00 5c 2f 04 5f 53 42  PC0BCMDp..\/._SB
  0380: 5f 50 43 49 30 4c 50 43 30 53 4d 49 43 70 0a 01  _PCI0LPC0SMICp..
  0390: 5c 2e 5f 53 42 5f 4f 4b 45 43 86 5c 2e 5f 53 42  \._SB_OKEC.\._SB
  03a0: 5f 53 4c 50 42 0a 02 a0 44 0d 93 87 5c 5f 4f 53  _SLPB...D...\_OS
  03b0: 5f 0a 14 70 5c 2f 04 5f 53 42 5f 50 43 49 30 4c  _..p\/._SB_PCI0L
  03c0: 50 43 30 52 42 49 44 60 70 5c 2f 04 5f 53 42 5f  PC0RBID`p\/._SB_
  03d0: 50 43 49 30 49 44 45 30 42 41 59 52 61 70 60 5c  PCI0IDE0BAYRap`\
  03e0: 2f 04 5f 53 42 5f 50 43 49 30 49 44 45 30 42 41  /._SB_PCI0IDE0BA
  03f0: 59 52 a0 43 06 92 93 60 61 a0 4c 05 7d 93 61 0a  YR.C...`a.L.}.a.
  0400: 01 93 61 0a 02 00 a0 33 7b 93 5c 2f 03 5f 53 42  ..a....3{.\/._SB
  0410: 5f 50 43 49 30 4d 59 4f 53 0a 03 93 60 0a 03 00  _PCI0MYOS...`...
  0420: 86 5c 2f 05 5f 53 42 5f 50 43 49 30 49 44 45 30  .\/._SB_PCI0IDE0
  0430: 53 45 43 4e 42 41 59 31 0a 03 a1 1b 86 5c 2f 05  SECNBAY1.....\/.
  0440: 5f 53 42 5f 50 43 49 30 49 44 45 30 53 45 43 4e  _SB_PCI0IDE0SECN
  0450: 42 41 59 31 0a 01 a0 25 7d 93 60 0a 01 93 60 0a  BAY1...%}.`...`.
  0460: 02 00 86 5c 2f 05 5f 53 42 5f 50 43 49 30 49 44  ...\/._SB_PCI0ID
  0470: 45 30 53 45 43 4e 42 41 59 31 0a 00 a0 31 93 87  E0SECNBAY1...1..
  0480: 5c 5f 4f 53 5f 0a 27 86 5c 2e 5f 53 42 5f 42 41  \_OS_.'.\._SB_BA
  0490: 54 31 0a 80 86 5c 2e 5f 53 42 5f 42 41 54 32 0a  T1...\._SB_BAT2.
  04a0: 80 86 5c 2e 5f 53 42 5f 41 43 41 44 0a 00 70 5c  ..\._SB_ACAD..p\
  04b0: 2f 05 5f 53 42 5f 50 43 49 30 4c 50 43 30 45 43  /._SB_PCI0LPC0EC
  04c0: 30 5f 41 43 44 46 5c 2e 5f 53 42 5f 41 43 53 54  0_ACDF\._SB_ACST
  04d0: a0 17 93 87 5c 5f 4f 53 5f 0a 11 86 5c 2e 5f 53  ....\_OS_...\._S
  04e0: 42 5f 53 4c 50 42 0a 02 70 0a 00 5c 2e 5f 53 42  B_SLPB..p..\._SB
  04f0: 5f 53 4c 45 45 10 44 0c 5f 47 50 45 14 18 5f 4c  _SLEE.D._GPE.._L
  0500: 30 35 00 86 5c 2f 03 5f 53 42 5f 50 43 49 30 4d  05..\/._SB_PCI0M
  0510: 44 4d 30 0a 02 14 4e 04 5f 4c 30 42 00 86 5c 2f  DM0...N._L0B..\/
  0520: 03 5f 53 42 5f 50 43 49 30 48 55 42 5f 0a 00 a0  ._SB_PCI0HUB_...
  0530: 34 7d 93 5c 2f 03 5f 53 42 5f 50 43 49 30 4d 59  4}.\/._SB_PCI0MY
  0540: 4f 53 0a 01 93 5c 2f 03 5f 53 42 5f 50 43 49 30  OS...\/._SB_PCI0
  0550: 4d 59 4f 53 0a 03 00 86 5c 2e 5f 53 42 5f 53 4c  MYOS....\._SB_SL
  0560: 50 42 0a 02 14 18 5f 4c 30 33 00 86 5c 2f 03 5f  PB...._L03..\/._
  0570: 53 42 5f 50 43 49 30 55 53 42 31 0a 02 14 18 5f  SB_PCI0USB1...._
  0580: 4c 30 34 00 86 5c 2f 03 5f 53 42 5f 50 43 49 30  L04..\/._SB_PCI0
  0590: 55 53 42 32 0a 02 14 18 5f 4c 30 43 00 86 5c 2f  USB2...._L0C..\/
  05a0: 03 5f 53 42 5f 50 43 49 30 55 53 42 33 0a 02 14  ._SB_PCI0USB3...
  05b0: 0a 5f 45 31 38 00 5b 22 0a 01 10 8d d5 05 5f 53  ._E18.["......_S
  05c0: 42 5f 08 53 54 41 54 0a 00 08 44 31 53 54 0a 00  B_.STAT...D1ST..
  05d0: 08 44 31 53 4a 0a 01 5b 82 80 96 04 50 43 49 30  .D1SJ..[....PCI0
  05e0: 08 4d 59 4f 53 0a 02 14 40 0b 5f 49 4e 49 00 70  .MYOS...-lh3GFWRMZfo@public.gmane.org
  05f0: 0a 01 5c 2e 5f 53 42 5f 44 31 53 4a 70 0a 02 4d  ..\._SB_D1SJp..M
  0600: 59 4f 53 a0 41 05 93 87 5c 5f 4f 53 5f 0a 14 70  YOS.A...\_OS_..p
  0610: 0a 01 4d 59 4f 53 70 0a 01 5c 2e 5f 53 42 5f 57  ..MYOSp..\._SB_W
  0620: 32 4b 46 a0 31 5b 12 5f 4f 53 49 60 a0 28 5c 5f  2KF.1[._OSI`.(\_
  0630: 4f 53 49 0d 57 69 6e 64 6f 77 73 20 32 30 30 31  OSI.Windows 2001
  0640: 00 70 0a 03 4d 59 4f 53 70 0a 03 5c 2e 5f 53 42  .p..MYOSp..\._SB
  0650: 5f 57 32 4b 46 a1 42 04 a0 1e 93 87 5c 5f 4f 53  _W2KF.B.....\_OS
  0660: 5f 0a 11 70 0a 00 4d 59 4f 53 70 0a 00 5c 2e 5f  _..p..MYOSp..\._
  0670: 53 42 5f 57 32 4b 46 a1 20 a0 1e 93 87 5c 5f 4f  SB_W2KF. ....\_O
  0680: 53 5f 0a 27 70 0a 02 4d 59 4f 53 70 0a 02 5c 2e  S_.'p..MYOSp..\.
  0690: 5f 53 42 5f 57 32 4b 46 08 5f 48 49 44 0c 41 d0  _SB_W2KF._HID.A.
  06a0: 0a 03 08 5f 41 44 52 0a 00 08 5f 42 42 4e 0a 00  ..._ADR..._BBN..
  06b0: 5b 80 48 42 55 53 02 0a 40 0a c0 5b 81 43 08 48  [.HBUS..-rVxdn2TrCWA@public.gmane.org[.C.H
  06c0: 42 55 53 03 00 40 10 44 52 42 30 08 44 52 42 31  BUS..-zSsoGqwpEQjizxPgKy2Cyg@public.gmane.org
  06d0: 08 44 52 42 32 08 44 52 42 33 08 00 40 16 00 04  .DRB2.DRB3..-47IYjYMXMt4@public.gmane.org
  06e0: 50 4d 30 48 02 00 02 50 4d 31 4c 02 00 02 50 4d  PM0H...PM1L...PM
  06f0: 31 48 02 00 02 50 4d 32 4c 02 00 02 50 4d 32 48  1H...PM2L...PM2H
  0700: 02 00 02 50 4d 33 4c 02 00 02 50 4d 33 48 02 00  ...PM3L...PM3H..
  0710: 02 50 4d 34 4c 02 00 02 50 4d 34 48 02 00 02 50  .PM4L...PM4H...P
  0720: 4d 35 4c 02 00 02 50 4d 35 48 02 00 02 50 4d 36  M5L...PM5H...PM6
  0730: 4c 02 00 02 50 4d 36 48 02 00 02 46 44 48 43 08  L...PM6H...FDHC.
  0740: 08 42 55 46 30 11 46 20 0b 01 02 88 0e 00 02 0c  .BUF0.F ........
  0750: 00 00 00 00 00 ff 00 00 00 00 01 00 87 18 00 01  ................
  0760: 0c 03 00 00 00 00 00 00 00 00 f7 0c 00 00 00 00  ................
  0770: 00 00 f8 0c 00 00 00 47 01 f8 0c f8 0c 01 08 87  .......G........
  0780: 18 00 01 0c 03 00 00 00 00 00 0d 00 00 ff ff 00  ................
  0790: 00 00 00 00 00 00 f3 00 00 00 87 18 00 00 0c 03  ................
  07a0: 00 00 00 00 00 00 0a 00 ff ff 0b 00 00 00 00 00  ................
  07b0: 00 00 02 00 00 87 18 00 00 0c 03 00 00 00 00 00  ................
  07c0: 00 0c 00 ff 3f 0c 00 00 00 00 00 00 40 00 00 00  ....?.......-47IYjYMXMt4@public.gmane.org
  07d0: 87 18 00 00 0c 03 00 00 00 00 00 40 0c 00 ff 7f  ...........-9D9NNryygCw@public.gmane.org
  07e0: 0c 00 00 00 00 00 00 40 00 00 00 87 18 00 00 0c  .......-BlbsxGdv4A4@public.gmane.org
  07f0: 03 00 00 00 00 00 80 0c 00 ff bf 0c 00 00 00 00  ................
  0800: 00 00 40 00 00 00 87 18 00 00 0c 03 00 00 00 00  ..-BlbsxGdv4A7maATwymIwmA@public.gmane.org
  0810: 00 c0 0c 00 ff ff 0c 00 00 00 00 00 00 40 00 00  .............-rVxdn2TrCWA@public.gmane.org
  0820: 00 87 18 00 00 0c 03 00 00 00 00 00 00 0d 00 ff  ................
  0830: 3f 0d 00 00 00 00 00 00 40 00 00 00 87 18 00 00  ?.......-3wQm9ZMZ9co@public.gmane.org
  0840: 0c 03 00 00 00 00 00 40 0d 00 ff 7f 0d 00 00 00  .......-BlbsxGdv4A4@public.gmane.org
  0850: 00 00 00 40 00 00 00 87 18 00 00 0c 03 00 00 00  ...-BlbsxGdv4A70P002vLKALA@public.gmane.org
  0860: 00 00 80 0d 00 ff bf 0d 00 00 00 00 00 00 40 00  ..............-4b8TPpkIZ3Q@public.gmane.org
  0870: 00 00 87 18 00 00 0c 03 00 00 00 00 00 c0 0d 00  ................
  0880: ff ff 0d 00 00 00 00 00 00 40 00 00 00 87 18 00  .........-E2U9adUjKaY@public.gmane.org
  0890: 00 0c 03 00 00 00 00 00 00 0e 00 ff 3f 0e 00 00  ............?...
  08a0: 00 00 00 00 40 00 00 00 87 18 00 00 0c 03 00 00  ....-BlbsxGdv4A7jshiNgxcy3g@public.gmane.org
  08b0: 00 00 00 40 0e 00 ff 7f 0e 00 00 00 00 00 00 40  ...-BlbsxGdv4A7jshiNgxcy3g@public.gmane.org@
  08c0: 00 00 00 87 18 00 00 0c 03 00 00 00 00 00 80 0e  ................
  08d0: 00 ff bf 0e 00 00 00 00 00 00 40 00 00 00 87 18  ..........-5mgE8MpiMJg@public.gmane.org
  08e0: 00 00 0c 03 00 00 00 00 00 c0 0e 00 ff ff 0e 00  ................
  08f0: 00 00 00 00 00 40 00 00 00 87 18 00 00 0c 03 00  .....-BlbsxGdv4A6tXF2fZOsJYA@public.gmane.org
  0900: 00 00 00 00 00 0f 00 ff ff 0f 00 00 00 00 00 00  ................
  0910: 00 01 00 00 87 18 00 00 0c 03 00 00 00 00 00 00  ................
  0920: 00 00 ff ff bf fe 00 00 00 00 00 00 00 00 00 87  ................
  0930: 18 00 00 0c 03 00 00 00 00 00 00 00 00 00 00 00  ................
  0940: 00 00 00 00 00 00 00 00 00 00 79 00 14 43 39 5f  ..........y..C9_
  0950: 43 52 53 08 a0 16 50 4d 31 4c 8a 42 55 46 30 0a  CRS...PM1L.BUF0.
  0960: 80 43 30 4c 4e 70 00 43 30 4c 4e a0 1a 93 50 4d  .C0LNp.C0LN...PM
  0970: 31 4c 0a 01 8d 42 55 46 30 0b 78 03 43 30 52 57  1L...BUF0.x.C0RW
  0980: 70 00 43 30 52 57 a0 16 50 4d 31 48 8a 42 55 46  p.C0RW..PM1H.BUF
  0990: 30 0a 9b 43 34 4c 4e 70 00 43 34 4c 4e a0 1a 93  0..C4LNp.C4LN...
  09a0: 50 4d 31 48 0a 01 8d 42 55 46 30 0b 50 04 43 34  PM1H...BUF0.P.C4
  09b0: 52 57 70 00 43 34 52 57 a0 16 50 4d 32 4c 8a 42  RWp.C4RW..PM2L.B
  09c0: 55 46 30 0a b6 43 38 4c 4e 70 00 43 38 4c 4e a0  UF0..C8LNp.C8LN.
  09d0: 1a 93 50 4d 32 4c 0a 01 8d 42 55 46 30 0b 28 05  ..PM2L...BUF0.(.
  09e0: 43 38 52 57 70 00 43 38 52 57 a0 16 50 4d 32 48  C8RWp.C8RW..PM2H
  09f0: 8a 42 55 46 30 0a d1 43 43 4c 4e 70 00 43 43 4c  .BUF0..CCLNp.CCL
  0a00: 4e a0 1a 93 50 4d 32 48 0a 01 8d 42 55 46 30 0b  N...PM2H...BUF0.
  0a10: 00 06 43 43 52 57 70 00 43 43 52 57 a0 16 50 4d  ..CCRWp.CCRW..PM
  0a20: 33 4c 8a 42 55 46 30 0a ec 44 30 4c 4e 70 00 44  3L.BUF0..D0LNp.D
  0a30: 30 4c 4e a0 1a 93 50 4d 33 4c 0a 01 8d 42 55 46  0LN...PM3L...BUF
  0a40: 30 0b d8 06 44 30 52 57 70 00 44 30 52 57 a0 17  0...D0RWp.D0RW..
  0a50: 50 4d 33 48 8a 42 55 46 30 0b 07 01 44 34 4c 4e  PM3H.BUF0...D4LN
  0a60: 70 00 44 34 4c 4e a0 1a 93 50 4d 33 48 0a 01 8d  p.D4LN...PM3H...
  0a70: 42 55 46 30 0b b0 07 44 34 52 57 70 00 44 34 52  BUF0...D4RWp.D4R
  0a80: 57 a0 17 50 4d 34 4c 8a 42 55 46 30 0b 22 01 44  W..PM4L.BUF0.".D
  0a90: 38 4c 4e 70 00 44 38 4c 4e a0 1a 93 50 4d 34 4c  8LNp.D8LN...PM4L
  0aa0: 0a 01 8d 42 55 46 30 0b 88 08 44 38 52 57 70 00  ...BUF0...D8RWp.
  0ab0: 44 38 52 57 a0 17 50 4d 34 48 8a 42 55 46 30 0b  D8RW..PM4H.BUF0.
  0ac0: 3d 01 44 43 4c 4e 70 00 44 43 4c 4e a0 1a 93 50  =.DCLNp.DCLN...P
  0ad0: 4d 34 48 0a 01 8d 42 55 46 30 0b 60 09 44 43 52  M4H...BUF0.`.DCR
  0ae0: 57 70 00 44 43 52 57 a0 17 50 4d 35 4c 8a 42 55  Wp.DCRW..PM5L.BU
  0af0: 46 30 0b 58 01 45 30 4c 4e 70 00 45 30 4c 4e a0  F0.X.E0LNp.E0LN.
  0b00: 1a 93 50 4d 35 4c 0a 01 8d 42 55 46 30 0b 38 0a  ..PM5L...BUF0.8.
  0b10: 45 30 52 57 70 00 45 30 52 57 a0 17 50 4d 35 48  E0RWp.E0RW..PM5H
  0b20: 8a 42 55 46 30 0b 73 01 45 34 4c 4e 70 00 45 34  .BUF0.s.E4LNp.E4
  0b30: 4c 4e a0 1a 93 50 4d 35 48 0a 01 8d 42 55 46 30  LN...PM5H...BUF0
  0b40: 0b 10 0b 45 34 52 57 70 00 45 34 52 57 a0 17 50  ...E4RWp.E4RW..P
  0b50: 4d 36 4c 8a 42 55 46 30 0b 8e 01 45 38 4c 4e 70  M6L.BUF0...E8LNp
  0b60: 00 45 38 4c 4e a0 1a 93 50 4d 36 4c 0a 01 8d 42  .E8LN...PM6L...B
  0b70: 55 46 30 0b e8 0b 45 38 52 57 70 00 45 38 52 57  UF0...E8RWp.E8RW
  0b80: a0 17 50 4d 36 48 8a 42 55 46 30 0b a9 01 45 43  ..PM6H.BUF0...EC
  0b90: 4c 4e 70 00 45 43 4c 4e a0 1a 93 50 4d 36 48 0a  LNp.ECLN...PM6H.
  0ba0: 01 8d 42 55 46 30 0b c0 0c 45 43 52 57 70 00 45  ..BUF0...ECRWp.E
  0bb0: 43 52 57 a0 17 50 4d 30 48 8a 42 55 46 30 0b c4  CRW..PM0H.BUF0..
  0bc0: 01 46 30 4c 4e 70 00 46 30 4c 4e a0 1a 93 50 4d  .F0LNp.F0LN...PM
  0bd0: 30 48 0a 01 8d 42 55 46 30 0b 98 0d 46 30 52 57  0H...BUF0...F0RW
  0be0: 70 00 46 30 52 57 8a 42 55 46 30 0b d3 01 4d 31  p.F0RW.BUF0...M1
  0bf0: 4d 4e 8a 42 55 46 30 0b d7 01 4d 31 4d 58 8a 42  MN.BUF0...M1MX.B
  0c00: 55 46 30 0b df 01 4d 31 4c 4e 77 0c 00 00 00 02  UF0...M1LNw.....
  0c10: 44 52 42 33 4d 31 4d 4e 72 74 4d 31 4d 58 4d 31  DRB3M1MNrtM1MXM1
  0c20: 4d 4e 00 0a 01 4d 31 4c 4e 7a 7b 5c 2f 04 5f 53  MN...M1LNz{\/._S
  0c30: 42 5f 50 43 49 30 4c 50 43 30 4d 54 53 45 0b 80  B_PCI0LPC0MTSE..
  0c40: 03 00 0a 07 60 a0 45 09 7b 60 0a 04 00 8a 42 55  ....`.E.{`....BU
  0c50: 46 30 0b ee 01 4d 32 4d 4e 8a 42 55 46 30 0b f2  F0...M2MN.BUF0..
  0c60: 01 4d 32 4d 58 8a 42 55 46 30 0b fa 01 4d 32 4c  .M2MX.BUF0...M2L
  0c70: 4e 70 0c 00 00 d0 fe 4d 32 4d 4e 70 0c ff 03 d0  Np.....M2MNp....
  0c80: fe 4d 32 4d 58 70 0b 00 04 4d 32 4c 4e a0 19 93  .M2MXp...M2LN...
  0c90: 60 0a 05 70 0c 00 10 d0 fe 4d 32 4d 4e 70 0c ff  `..p.....M2MNp..
  0ca0: 13 d0 fe 4d 32 4d 58 a0 19 93 60 0a 06 70 0c 00  ...M2MX...`..p..
  0cb0: 20 d0 fe 4d 32 4d 4e 70 0c ff 23 d0 fe 4d 32 4d   ..M2MNp..#..M2M
  0cc0: 58 a0 19 93 60 0a 07 70 0c 00 30 d0 fe 4d 32 4d  X...`..p..0..M2M
  0cd0: 4e 70 0c ff 33 d0 fe 4d 32 4d 58 a4 42 55 46 30  Np..3..M2MX.BUF0
  0ce0: 08 5f 50 52 54 12 4c 1c 0f 12 1c 04 0b ff ff 0a  ._PRT.L.........
  0cf0: 00 5c 2f 04 5f 53 42 5f 50 43 49 30 4c 50 43 30  .\/._SB_PCI0LPC0
  0d00: 4c 4e 4b 41 0a 00 12 1c 04 0b ff ff 0a 01 5c 2f  LNKA..........\/
  0d10: 04 5f 53 42 5f 50 43 49 30 4c 50 43 30 4c 4e 4b  ._SB_PCI0LPC0LNK
  0d20: 42 0a 00 12 1c 04 0b ff ff 0a 02 5c 2f 04 5f 53  B..........\/._S
  0d30: 42 5f 50 43 49 30 4c 50 43 30 4c 4e 4b 43 0a 00  B_PCI0LPC0LNKC..
  0d40: 12 1c 04 0b ff ff 0a 03 5c 2f 04 5f 53 42 5f 50  ........\/._SB_P
  0d50: 43 49 30 4c 50 43 30 4c 4e 4b 44 0a 00 12 1e 04  CI0LPC0LNKD.....
  0d60: 0c ff ff 01 00 0a 00 5c 2f 04 5f 53 42 5f 50 43  .......\/._SB_PC
  0d70: 49 30 4c 50 43 30 4c 4e 4b 41 0a 00 12 1e 04 0c  I0LPC0LNKA......
  0d80: ff ff 1d 00 0a 00 5c 2f 04 5f 53 42 5f 50 43 49  ......\/._SB_PCI
  0d90: 30 4c 50 43 30 4c 4e 4b 41 0a 00 12 1e 04 0c ff  0LPC0LNKA.......
  0da0: ff 1d 00 0a 01 5c 2f 04 5f 53 42 5f 50 43 49 30  .....\/._SB_PCI0
  0db0: 4c 50 43 30 4c 4e 4b 44 0a 00 12 1e 04 0c ff ff  LPC0LNKD........
  0dc0: 1d 00 0a 02 5c 2f 04 5f 53 42 5f 50 43 49 30 4c  ....\/._SB_PCI0L
  0dd0: 50 43 30 4c 4e 4b 43 0a 00 12 1e 04 0c ff ff 1d  PC0LNKC.........
  0de0: 00 0a 03 5c 2f 04 5f 53 42 5f 50 43 49 30 4c 50  ...\/._SB_PCI0LP
  0df0: 43 30 4c 4e 4b 48 0a 00 12 1e 04 0c ff ff 1e 00  C0LNKH..........
  0e00: 0a 00 5c 2f 04 5f 53 42 5f 50 43 49 30 4c 50 43  ..\/._SB_PCI0LPC
  0e10: 30 4c 4e 4b 41 0a 00 12 1e 04 0c ff ff 1e 00 0a  0LNKA...........
  0e20: 01 5c 2f 04 5f 53 42 5f 50 43 49 30 4c 50 43 30  .\/._SB_PCI0LPC0
  0e30: 4c 4e 4b 42 0a 00 12 1e 04 0c ff ff 1e 00 0a 02  LNKB............
  0e40: 5c 2f 04 5f 53 42 5f 50 43 49 30 4c 50 43 30 4c  \/._SB_PCI0LPC0L
  0e50: 4e 4b 43 0a 00 12 1e 04 0c ff ff 1e 00 0a 03 5c  NKC............\
  0e60: 2f 04 5f 53 42 5f 50 43 49 30 4c 50 43 30 4c 4e  /._SB_PCI0LPC0LN
  0e70: 4b 44 0a 00 12 1e 04 0c ff ff 1f 00 0a 00 5c 2f  KD............\/
  0e80: 04 5f 53 42 5f 50 43 49 30 4c 50 43 30 4c 4e 4b  ._SB_PCI0LPC0LNK
  0e90: 43 0a 00 12 1e 04 0c ff ff 1f 00 0a 01 5c 2f 04  C............\/.
  0ea0: 5f 53 42 5f 50 43 49 30 4c 50 43 30 4c 4e 4b 42  _SB_PCI0LPC0LNKB
  0eb0: 0a 00 5b 82 46 3c 41 47 50 5f 08 5f 41 44 52 0c  ..[.F<AGP_._ADR.
  0ec0: 00 00 01 00 08 5f 50 52 54 12 1f 01 12 1c 04 0b  ....._PRT.......
  0ed0: ff ff 0a 00 5c 2f 04 5f 53 42 5f 50 43 49 30 4c  ....\/._SB_PCI0L
  0ee0: 50 43 30 4c 4e 4b 41 0a 00 5b 82 4f 38 56 47 41  PC0LNKA..[.O8VGA
  0ef0: 5f 08 5f 41 44 52 0a 00 08 53 57 49 54 0a 01 08  _._ADR...SWIT...
  0f00: 43 52 54 41 0a 01 08 4c 43 44 41 0a 01 08 54 56  CRTA...LCDA...TV
  0f10: 30 41 0a 01 08 54 4f 47 46 0a 02 14 09 5f 53 54  0A...TOGF...._ST
  0f20: 41 00 a4 0a 0f 08 5f 50 53 43 0a 00 08 55 53 42  A....._PSC...USB
  0f30: 46 0a 00 14 0d 5f 50 53 30 00 70 0a 00 5f 50 53  F...._PS0.p.._PS
  0f40: 43 14 0d 5f 50 53 33 00 70 0a 03 5f 50 53 43 14  C.._PS3.p.._PSC.
  0f50: 10 5f 44 4f 53 01 70 7b 68 0a 03 00 53 57 49 54  ._DOS.p{h...SWIT
  0f60: 14 19 5f 44 4f 44 00 a4 12 11 03 0c 00 01 01 00  .._DOD..........
  0f70: 0c 10 01 01 00 0c 00 02 01 00 5b 82 4e 04 43 52  ..........[.N.CR
  0f80: 54 5f 08 5f 41 44 52 0b 00 01 14 14 5f 44 43 53  T_._ADR....._DCS
  0f90: 00 a0 08 43 52 54 41 a4 0a 1f a1 04 a4 0a 1d 14  ...CRTA.........
  0fa0: 14 5f 44 47 53 00 a0 08 43 52 54 41 a4 0a 01 a1  ._DGS...CRTA....
  0fb0: 04 a4 0a 00 14 15 5f 44 53 53 01 70 0d 43 52 54  ......_DSS.p.CRT
  0fc0: 20 2d 2d 5f 44 53 53 00 5b 31 5b 82 4d 04 54 56   --_DSS.[1[.M.TV
  0fd0: 30 5f 08 5f 41 44 52 0b 00 02 14 14 5f 44 43 53  0_._ADR....._DCS
  0fe0: 00 a0 08 54 56 30 41 a4 0a 1f a1 04 a4 0a 1d 14  ...TV0A.........
  0ff0: 14 5f 44 47 53 00 a0 08 54 56 30 41 a4 0a 01 a1  ._DGS...TV0A....
  1000: 04 a4 0a 00 14 14 5f 44 53 53 01 70 0d 54 56 20  ......_DSS.p.TV 
  1010: 2d 2d 5f 44 53 53 00 5b 31 5b 82 44 05 4c 43 44  --_DSS.[1[.D.LCD
  1020: 5f 08 5f 41 44 52 0b 10 01 14 14 5f 44 43 53 00  _._ADR....._DCS.
  1030: a0 08 4c 43 44 41 a4 0a 1f a1 04 a4 0a 1d 14 1a  ..LCDA..........
  1040: 5f 44 47 53 00 70 4c 43 44 41 60 a0 08 4c 43 44  _DGS.pLCDA`..LCD
  1050: 41 a4 0a 01 a1 04 a4 0a 00 14 15 5f 44 53 53 01  A.........._DSS.
  1060: 70 0d 4c 43 44 20 2d 2d 5f 44 53 53 00 5b 31 14  p.LCD --_DSS.[1.
  1070: 46 19 53 57 49 48 00 70 0a 03 60 a0 48 07 93 60  F.SWIH.p..`.H..`
  1080: 0a 03 75 54 4f 47 46 70 54 4f 47 46 61 a0 17 93  ..uTOGFpTOGFa...
  1090: 61 0a 01 70 01 4c 43 44 41 70 00 43 52 54 41 70  a..p.LCDAp.CRTAp
  10a0: 00 54 56 30 41 a1 4e 04 a0 17 93 61 0a 02 70 00  .TV0A.N....a..p.
  10b0: 4c 43 44 41 70 01 43 52 54 41 70 00 54 56 30 41  LCDAp.CRTAp.TV0A
  10c0: a1 33 a0 17 93 61 0a 03 70 01 4c 43 44 41 70 01  .3...a..p.LCDAp.
  10d0: 43 52 54 41 70 00 54 56 30 41 a1 19 70 01 54 4f  CRTAp.TV0A..p.TO
  10e0: 47 46 70 01 4c 43 44 41 70 00 43 52 54 41 70 00  GFp.LCDAp.CRTAp.
  10f0: 54 56 30 41 a1 4b 0f a0 49 04 93 60 0a 05 75 54  TV0A.K..I..`..uT
  1100: 4f 47 46 70 54 4f 47 46 61 a0 17 93 61 0a 01 70  OGFpTOGFa...a..p
  1110: 01 4c 43 44 41 70 00 43 52 54 41 70 00 54 56 30  .LCDAp.CRTAp.TV0
  1120: 41 a1 1f 70 00 54 4f 47 46 70 00 4c 43 44 41 70  A..p.TOGFp.LCDAp
  1130: 00 43 52 54 41 70 01 54 56 30 41 70 00 54 56 30  .CRTAp.TV0Ap.TV0
  1140: 41 a1 4e 0a a0 4d 08 93 60 0a 07 75 54 4f 47 46  A.N..M..`..uTOGF
  1150: 70 54 4f 47 46 61 a0 1a 93 61 0a 01 70 0a 01 4c  pTOGFa...a..p..L
  1160: 43 44 41 70 0a 00 43 52 54 41 70 0a 00 54 56 30  CDAp..CRTAp..TV0
  1170: 41 a1 40 06 a0 1a 93 61 0a 02 70 0a 00 4c 43 44  A.-8lBlSa4ZabPgP/pwXJndQw@public.gmane.org
  1180: 41 70 0a 01 43 52 54 41 70 0a 00 54 56 30 41 a1  Ap..CRTAp..TV0A.
  1190: 42 04 a0 1a 93 61 0a 03 70 0a 01 4c 43 44 41 70  B....a..p..LCDAp
  11a0: 0a 01 43 52 54 41 70 0a 00 54 56 30 41 a1 24 70  ..CRTAp..TV0A.$p
  11b0: 0a 00 54 4f 47 46 70 0a 00 4c 43 44 41 70 0a 00  ..TOGFp..LCDAp..
  11c0: 43 52 54 41 70 0a 01 54 56 30 41 70 0a 00 54 56  CRTAp..TV0Ap..TV
  11d0: 30 41 a1 1d 70 0a 01 54 4f 47 46 70 0a 01 4c 43  0A..p..TOGFp..LC
  11e0: 44 41 70 0a 00 43 52 54 41 70 0a 00 54 56 30 41  DAp..CRTAp..TV0A
  11f0: 86 5c 2f 04 5f 53 42 5f 50 43 49 30 41 47 50 5f  .\/._SB_PCI0AGP_
  1200: 56 47 41 5f 0a 80 14 43 07 47 45 54 44 00 70 0a  VGA_...C.GETD.p.
  1210: 98 5c 2f 04 5f 53 42 5f 50 43 49 30 4c 50 43 30  .\/._SB_PCI0LPC0
  1220: 42 43 4d 44 70 0a 00 5c 2f 04 5f 53 42 5f 50 43  BCMDp..\/._SB_PC
  1230: 49 30 4c 50 43 30 53 4d 49 43 70 5c 2e 5f 53 42  I0LPC0SMICp\._SB
  1240: 5f 44 49 53 44 60 a0 0c 93 60 0a 01 70 0a 01 54  _DISD`...`..p..T
  1250: 4f 47 46 a0 0c 93 60 0a 02 70 0a 02 54 4f 47 46  OGF...`..p..TOGF
  1260: a0 0c 93 60 0a 03 70 0a 03 54 4f 47 46 a0 0c 93  ...`..p..TOGF...
  1270: 60 0a 04 70 0a 00 54 4f 47 46 5b 82 81 95 02 4c  `..p..TOGF[....L
  1280: 50 43 30 08 5f 41 44 52 0c 00 00 1f 00 14 0a 44  PC0._ADR.......D
  1290: 45 43 44 04 70 68 5b 31 5b 80 52 45 47 53 02 0a  ECD.ph[1[.REGS..
  12a0: 40 0a c0 5b 81 48 05 52 45 47 53 03 50 4d 42 41  @..[.H.REGS.PMBA
  12b0: 10 00 40 0b 47 50 42 41 10 00 40 3b 50 4f 53 44  ..-uAchhwfckjc@public.gmane.org@;POSD
  12c0: 01 00 07 4d 54 53 45 10 00 08 00 40 06 43 4d 41  ...MTSE....-QoL1Loa+uT0@public.gmane.org
  12d0: 44 03 00 01 43 4d 42 44 03 00 01 4c 50 54 44 02  D...CMBD...LPTD.
  12e0: 00 02 46 44 44 44 01 00 23 45 43 4f 31 01 45 43  ..FDDD..#ECO1.EC
  12f0: 4f 32 01 45 4c 50 54 01 45 46 44 44 01 5b 80 50  O2.ELPT.EFDD.[.P
  1300: 49 52 58 02 0a 60 0a 0c 5b 81 33 50 49 52 58 03  IRX..`..[.3PIRX.
  1310: 01 01 00 50 49 52 41 08 50 49 52 42 08 50 49 52  ...PIRA.PIRB.PIR
  1320: 43 08 50 49 52 44 08 00 20 50 49 52 45 08 50 49  C.PIRD.. PIRE.PI
  1330: 52 46 08 50 49 52 47 08 50 49 52 48 08 5b 82 48  RF.PIRG.PIRH.[.H
  1340: 1f 4d 42 52 44 08 5f 48 49 44 0c 41 d0 0c 02 08  .MBRD._HID.A....
  1350: 5f 55 49 44 0a 1f 08 52 53 52 43 11 4b 13 0b 36  _UID...RSRC.K..6
  1360: 01 47 01 10 00 10 00 01 10 47 01 24 00 24 00 01  .G.......G.$.$..
  1370: 02 47 01 28 00 28 00 01 02 47 01 2c 00 2c 00 01  .G.(.(...G.,.,..
  1380: 02 47 01 30 00 30 00 01 02 47 01 34 00 34 00 01  .G.0.0...G.4.4..
  1390: 02 47 01 38 00 38 00 01 02 47 01 3c 00 3c 00 01  .G.8.8...G.<.<..
  13a0: 02 47 01 50 00 50 00 01 04 47 01 72 00 72 00 01  .G.P.P...G.r.r..
  13b0: 06 47 01 80 00 80 00 01 01 47 01 90 00 90 00 01  .G.......G......
  13c0: 10 47 01 a4 00 a4 00 01 02 47 01 a8 00 a8 00 01  .G.......G......
  13d0: 02 47 01 ac 00 ac 00 01 02 47 01 b0 00 b0 00 01  .G.......G......
  13e0: 06 47 01 b8 00 b8 00 01 02 47 01 bc 00 bc 00 01  .G.......G......
  13f0: 02 47 01 00 10 00 10 01 80 47 01 80 11 80 11 01  .G.......G......
  1400: 40 47 01 c0 01 c0 01 01 10 47 01 2e 00 2e 00 01  @G.......G......
  1410: 02 47 01 4e 00 4e 00 01 02 47 01 68 00 68 00 01  .G.N.N...G.h.h..
  1420: 01 47 01 6c 00 6c 00 01 01 47 01 00 fe 00 fe 00  .G.l.l...G......
  1430: 01 47 01 d0 04 d0 04 01 02 47 01 00 06 00 06 01  .G.......G......
  1440: 10 47 01 10 06 10 06 01 10 47 01 68 00 68 00 01  .G.......G.h.h..
  1450: 01 47 01 6c 00 6c 00 01 01 86 09 00 00 00 00 80  .G.l.l..........
  1460: ff 00 00 40 00 86 09 00 00 00 00 f0 ff 00 00 10  ...-BlbsxGdv4A70P002vLKALA@public.gmane.org
  1470: 00 86 09 00 01 00 00 00 00 00 00 0a 00 86 09 00  ................
  1480: 00 00 00 0e 00 00 00 02 00 86 09 00 01 00 00 10  ................
  1490: 00 00 00 00 00 79 00 14 4f 09 5f 43 52 53 00 8b  .....y..O._CRS..
  14a0: 52 53 52 43 0a 92 50 4d 4d 4e 8b 52 53 52 43 0a  RSRC..PMMN.RSRC.
  14b0: 94 50 4d 4d 58 7b 5e 5e 50 4d 42 41 0b 80 ff 50  .PMMX{^^PMBA...P
  14c0: 4d 4d 4e 70 50 4d 4d 4e 50 4d 4d 58 8b 52 53 52  MMNpPMMNPMMX.RSR
  14d0: 43 0a 9a 47 50 4d 4e 8b 52 53 52 43 0a 9c 47 50  C..GPMN.RSRC..GP
  14e0: 4d 58 7b 5e 5e 47 50 42 41 0b 80 ff 47 50 4d 4e  MX{^^GPBA...GPMN
  14f0: 70 47 50 4d 4e 47 50 4d 58 8a 52 53 52 43 0b 30  pGPMNGPMX.RSRC.0
  1500: 01 54 4d 45 4d 70 5c 2f 03 5f 53 42 5f 50 43 49  .TMEMp\/._SB_PCI
  1510: 30 44 52 42 33 54 4d 45 4d 79 54 4d 45 4d 0a 19  0DRB3TMEMyTMEM..
  1520: 54 4d 45 4d 74 54 4d 45 4d 0c 00 00 10 00 54 4d  TMEMtTMEM.....TM
  1530: 45 4d a4 52 53 52 43 5b 82 35 44 4d 41 43 08 5f  EM.RSRC[.5DMAC._
  1540: 48 49 44 0c 41 d0 02 00 08 5f 43 52 53 11 20 0a  HID.A...._CRS. .
  1550: 1d 47 01 00 00 00 00 01 10 47 01 81 00 81 00 01  .G.......G......
  1560: 0f 47 01 c0 00 c0 00 01 20 2a 10 02 79 00 5b 82  .G...... *..y.[.
  1570: 26 4d 41 54 48 08 5f 48 49 44 0c 41 d0 0c 04 08  &MATH._HID.A....
  1580: 5f 43 52 53 11 11 0a 0e 47 01 f0 00 f0 00 01 0f  _CRS....G.......
  1590: 23 00 20 01 79 00 5b 82 2c 50 49 43 5f 08 5f 48  #. .y.[.,PIC_._H
  15a0: 49 44 0b 41 d0 08 5f 43 52 53 11 19 0a 16 47 01  ID.A.._CRS....G.
  15b0: 20 00 20 00 01 02 47 01 a0 00 a0 00 01 02 23 04   . ...G.......#.
  15c0: 00 01 79 00 5b 82 26 52 54 43 5f 08 5f 48 49 44  ..y.[.&RTC_._HID
  15d0: 0c 41 d0 0b 00 08 5f 43 52 53 11 11 0a 0e 47 01  .A...._CRS....G.
  15e0: 70 00 70 00 01 02 23 00 01 01 79 00 5b 82 22 53  p.p...#...y.[."S
  15f0: 50 4b 52 08 5f 48 49 44 0c 41 d0 08 00 08 5f 43  PKR._HID.A...._C
  1600: 52 53 11 0d 0a 0a 47 01 61 00 61 00 01 01 79 00  RS....G.a.a...y.
  1610: 5b 82 26 54 49 4d 45 08 5f 48 49 44 0c 41 d0 01  [.&TIME._HID.A..
  1620: 00 08 5f 43 52 53 11 11 0a 0e 47 01 40 00 40 00  .._CRS....G.-4b8TPpkIZ3Q@public.gmane.org@.
  1630: 01 04 23 01 00 01 79 00 5b 82 4a 0a 4c 4e 4b 41  ..#...y.[.J.LNKA
  1640: 08 5f 48 49 44 0c 41 d0 0c 0f 08 5f 55 49 44 0a  ._HID.A...._UID.
  1650: 01 08 5f 50 52 53 11 09 0a 06 23 00 04 18 79 00  .._PRS....#...y.
  1660: 08 52 53 52 43 11 09 0a 06 23 00 00 18 79 00 14  .RSRC....#...y..
  1670: 11 5f 44 49 53 00 7d 50 49 52 41 0a 80 50 49 52  ._DIS.}PIRA..PIR
  1680: 41 14 26 5f 43 52 53 00 8b 52 53 52 43 0a 01 49  A.&_CRS..RSRC..I
  1690: 52 51 30 7b 50 49 52 41 0a 0f 60 79 0a 01 60 49  RQ0{PIRA..`y..`I
  16a0: 52 51 30 a4 52 53 52 43 14 24 5f 53 52 53 01 8b  RQ0.RSRC.$_SRS..
  16b0: 68 0a 01 49 52 51 30 82 49 52 51 30 60 76 60 7d  h..IRQ0.IRQ0`v`}
  16c0: 60 7b 50 49 52 41 0a 70 00 50 49 52 41 14 16 5f  `{PIRA.p.PIRA.._
  16d0: 53 54 41 00 a0 0c 7b 50 49 52 41 0a 80 00 a4 0a  STA...{PIRA.....
  16e0: 09 a4 0a 0b 5b 82 4a 0a 4c 4e 4b 42 08 5f 48 49  ....[.J.LNKB._HI
  16f0: 44 0c 41 d0 0c 0f 08 5f 55 49 44 0a 02 08 5f 50  D.A...._UID..._P
  1700: 52 53 11 09 0a 06 23 00 04 18 79 00 08 52 53 52  RS....#...y..RSR
  1710: 43 11 09 0a 06 23 00 00 18 79 00 14 11 5f 44 49  C....#...y..._DI
  1720: 53 00 7d 50 49 52 42 0a 80 50 49 52 42 14 26 5f  S.}PIRB..PIRB.&_
  1730: 43 52 53 00 8b 52 53 52 43 0a 01 49 52 51 30 7b  CRS..RSRC..IRQ0{
  1740: 50 49 52 42 0a 0f 60 79 0a 01 60 49 52 51 30 a4  PIRB..`y..`IRQ0.
  1750: 52 53 52 43 14 24 5f 53 52 53 01 8b 68 0a 01 49  RSRC.$_SRS..h..I
  1760: 52 51 30 82 49 52 51 30 60 76 60 7d 60 7b 50 49  RQ0.IRQ0`v`}`{PI
  1770: 52 42 0a 70 00 50 49 52 42 14 16 5f 53 54 41 00  RB.p.PIRB.._STA.
  1780: a0 0c 7b 50 49 52 42 0a 80 00 a4 0a 09 a4 0a 0b  ..{PIRB.........
  1790: 5b 82 4a 0a 4c 4e 4b 43 08 5f 48 49 44 0c 41 d0  [.J.LNKC._HID.A.
  17a0: 0c 0f 08 5f 55 49 44 0a 03 08 5f 50 52 53 11 09  ..._UID..._PRS..
  17b0: 0a 06 23 00 04 18 79 00 08 52 53 52 43 11 09 0a  ..#...y..RSRC...
  17c0: 06 23 00 00 18 79 00 14 11 5f 44 49 53 00 7d 50  .#...y..._DIS.}P
  17d0: 49 52 43 0a 80 50 49 52 43 14 26 5f 43 52 53 00  IRC..PIRC.&_CRS.
  17e0: 8b 52 53 52 43 0a 01 49 52 51 30 7b 50 49 52 43  .RSRC..IRQ0{PIRC
  17f0: 0a 0f 60 79 0a 01 60 49 52 51 30 a4 52 53 52 43  ..`y..`IRQ0.RSRC
  1800: 14 24 5f 53 52 53 01 8b 68 0a 01 49 52 51 30 82  .$_SRS..h..IRQ0.
  1810: 49 52 51 30 60 76 60 7d 60 7b 50 49 52 43 0a 70  IRQ0`v`}`{PIRC.p
  1820: 00 50 49 52 43 14 16 5f 53 54 41 00 a0 0c 7b 50  .PIRC.._STA...{P
  1830: 49 52 43 0a 80 00 a4 0a 09 a4 0a 0b 5b 82 4a 0a  IRC.........[.J.
  1840: 4c 4e 4b 44 08 5f 48 49 44 0c 41 d0 0c 0f 08 5f  LNKD._HID.A...._
  1850: 55 49 44 0a 04 08 5f 50 52 53 11 09 0a 06 23 20  UID..._PRS....# 
  1860: 00 18 79 00 08 52 53 52 43 11 09 0a 06 23 00 00  ..y..RSRC....#..
  1870: 18 79 00 14 11 5f 44 49 53 00 7d 50 49 52 44 0a  .y..._DIS.}PIRD.
  1880: 80 50 49 52 44 14 26 5f 43 52 53 00 8b 52 53 52  .PIRD.&_CRS..RSR
  1890: 43 0a 01 49 52 51 30 7b 50 49 52 44 0a 0f 60 79  C..IRQ0{PIRD..`y
  18a0: 0a 01 60 49 52 51 30 a4 52 53 52 43 14 24 5f 53  ..`IRQ0.RSRC.$_S
  18b0: 52 53 01 8b 68 0a 01 49 52 51 30 82 49 52 51 30  RS..h..IRQ0.IRQ0
  18c0: 60 76 60 7d 60 7b 50 49 52 44 0a 70 00 50 49 52  `v`}`{PIRD.p.PIR
  18d0: 44 14 16 5f 53 54 41 00 a0 0c 7b 50 49 52 44 0a  D.._STA...{PIRD.
  18e0: 80 00 a4 0a 09 a4 0a 0b 5b 82 48 12 4c 4e 4b 45  ........[.H.LNKE
  18f0: 08 5f 48 49 44 0c 41 d0 0c 0f 08 5f 55 49 44 0a  ._HID.A...._UID.
  1900: 05 08 5f 50 52 53 11 09 0a 06 23 b8 1a 18 79 00  .._PRS....#...y.
  1910: 08 52 53 52 43 11 09 0a 06 23 00 00 18 79 00 08  .RSRC....#...y..
  1920: 49 4e 45 53 0a 00 14 47 04 5f 44 49 53 00 a0 32  INES...G._DIS..2
  1930: 7d 93 5c 2f 03 5f 53 42 5f 50 43 49 30 4d 59 4f  }.\/._SB_PCI0MYO
  1940: 53 0a 00 93 5c 2f 03 5f 53 42 5f 50 43 49 30 4d  S...\/._SB_PCI0M
  1950: 59 4f 53 0a 02 00 7d 50 49 52 45 0a 80 50 49 52  YOS...}PIRE..PIR
  1960: 45 a1 0c 7d 50 49 52 45 0a 80 50 49 52 45 14 26  E..}PIRE..PIRE.&
  1970: 5f 43 52 53 00 8b 52 53 52 43 0a 01 49 52 51 30  _CRS..RSRC..IRQ0
  1980: 7b 50 49 52 45 0a 0f 60 79 0a 01 60 49 52 51 30  {PIRE..`y..`IRQ0
  1990: a4 52 53 52 43 14 2d 5f 53 52 53 01 8b 68 0a 01  .RSRC.-_SRS..h..
  19a0: 49 52 51 30 82 49 52 51 30 60 76 60 7d 60 7b 50  IRQ0.IRQ0`v`}`{P
  19b0: 49 52 45 0a 70 00 50 49 52 45 70 50 49 52 45 49  IRE.p.PIREpPIREI
  19c0: 4e 45 53 14 4e 04 5f 53 54 41 00 a0 34 7d 93 5c  NES.N._STA..4}.\
  19d0: 2f 03 5f 53 42 5f 50 43 49 30 4d 59 4f 53 0a 00  /._SB_PCI0MYOS..
  19e0: 93 5c 2f 03 5f 53 42 5f 50 43 49 30 4d 59 4f 53  .\/._SB_PCI0MYOS
  19f0: 0a 02 00 a0 0c 7b 50 49 52 45 0a 80 00 a4 0a 09  .....{PIRE......
  1a00: a1 0e a0 0c 7b 50 49 52 45 0a 80 00 a4 0a 09 a4  ....{PIRE.......
  1a10: 0a 0b 5b 82 4a 0a 4c 4e 4b 46 08 5f 48 49 44 0c  ..[.J.LNKF._HID.
  1a20: 41 d0 0c 0f 08 5f 55 49 44 0a 06 08 5f 50 52 53  A...._UID..._PRS
  1a30: 11 09 0a 06 23 b8 1a 18 79 00 08 52 53 52 43 11  ....#...y..RSRC.
  1a40: 09 0a 06 23 00 00 18 79 00 14 11 5f 44 49 53 00  ...#...y..._DIS.
  1a50: 7d 50 49 52 46 0a 80 50 49 52 46 14 26 5f 43 52  }PIRF..PIRF.&_CR
  1a60: 53 00 8b 52 53 52 43 0a 01 49 52 51 30 7b 50 49  S..RSRC..IRQ0{PI
  1a70: 52 46 0a 0f 60 79 0a 01 60 49 52 51 30 a4 52 53  RF..`y..`IRQ0.RS
  1a80: 52 43 14 24 5f 53 52 53 01 8b 68 0a 01 49 52 51  RC.$_SRS..h..IRQ
  1a90: 30 82 49 52 51 30 60 76 60 7d 60 7b 50 49 52 46  0.IRQ0`v`}`{PIRF
  1aa0: 0a 70 00 50 49 52 46 14 16 5f 53 54 41 00 a0 0c  .p.PIRF.._STA...
  1ab0: 7b 50 49 52 46 0a 80 00 a4 0a 09 a4 0a 0b 5b 82  {PIRF.........[.
  1ac0: 4a 0a 4c 4e 4b 47 08 5f 48 49 44 0c 41 d0 0c 0f  J.LNKG._HID.A...
  1ad0: 08 5f 55 49 44 0a 07 08 5f 50 52 53 11 09 0a 06  ._UID..._PRS....
  1ae0: 23 00 04 18 79 00 08 52 53 52 43 11 09 0a 06 23  #...y..RSRC....#
  1af0: 00 00 18 79 00 14 11 5f 44 49 53 00 7d 50 49 52  ...y..._DIS.}PIR
  1b00: 47 0a 80 50 49 52 47 14 26 5f 43 52 53 00 8b 52  G..PIRG.&_CRS..R
  1b10: 53 52 43 0a 01 49 52 51 30 7b 50 49 52 47 0a 0f  SRC..IRQ0{PIRG..
  1b20: 60 79 0a 01 60 49 52 51 30 a4 52 53 52 43 14 24  `y..`IRQ0.RSRC.$
  1b30: 5f 53 52 53 01 8b 68 0a 01 49 52 51 30 82 49 52  _SRS..h..IRQ0.IR
  1b40: 51 30 60 76 60 7d 60 7b 50 49 52 47 0a 70 00 50  Q0`v`}`{PIRG.p.P
  1b50: 49 52 47 14 16 5f 53 54 41 00 a0 0c 7b 50 49 52  IRG.._STA...{PIR
  1b60: 47 0a 80 00 a4 0a 09 a4 0a 0b 5b 82 4a 0a 4c 4e  G.........[.J.LN
  1b70: 4b 48 08 5f 48 49 44 0c 41 d0 0c 0f 08 5f 55 49  KH._HID.A...._UI
  1b80: 44 0a 08 08 5f 50 52 53 11 09 0a 06 23 00 04 18  D..._PRS....#...
  1b90: 79 00 08 52 53 52 43 11 09 0a 06 23 00 00 18 79  y..RSRC....#...y
  1ba0: 00 14 11 5f 44 49 53 00 7d 50 49 52 48 0a 80 50  ..._DIS.}PIRH..P
  1bb0: 49 52 48 14 26 5f 43 52 53 00 8b 52 53 52 43 0a  IRH.&_CRS..RSRC.
  1bc0: 01 49 52 51 30 7b 50 49 52 48 0a 0f 60 79 0a 01  .IRQ0{PIRH..`y..
  1bd0: 60 49 52 51 30 a4 52 53 52 43 14 24 5f 53 52 53  `IRQ0.RSRC.$_SRS
  1be0: 01 8b 68 0a 01 49 52 51 30 82 49 52 51 30 60 76  ..h..IRQ0.IRQ0`v
  1bf0: 60 7d 60 7b 50 49 52 48 0a 70 00 50 49 52 48 14  `}`{PIRH.p.PIRH.
  1c00: 16 5f 53 54 41 00 a0 0c 7b 50 49 52 48 0a 80 00  ._STA...{PIRH...
  1c10: a4 0a 09 a4 0a 0b 5b 80 47 50 4f 58 01 0b 80 11  ......[.GPOX....
  1c20: 0a 40 5b 81 4a 06 47 50 4f 58 13 00 38 00 01 49  .@[.J.GPOX..8..I
  1c30: 4f 32 35 01 00 01 49 4f 32 37 01 00 34 4c 56 31  O25...IO27..4LV1
  1c40: 36 01 4c 56 31 37 01 00 06 00 01 4c 56 32 35 01  6.LV17.....LV25.
  1c50: 00 01 4c 56 32 37 01 00 4c 05 00 01 42 4c 32 35  ..LV27..L...BL25
  1c60: 01 00 01 42 4c 32 37 01 00 44 0e 52 42 49 44 02  ...BL27..D.RBID.
  1c70: 4c 56 33 34 01 4c 56 33 35 01 4c 56 33 36 01 4c  LV34.LV35.LV36.L
  1c80: 56 33 37 01 4c 56 33 38 01 4c 56 33 39 01 5b 80  V37.LV38.LV39.[.
  1c90: 50 4d 49 4f 01 0b 00 10 0a 51 5b 81 46 07 50 4d  PMIO.....Q[.F.PM
  1ca0: 49 4f 12 01 03 00 00 48 14 00 03 50 4d 45 53 01  IO.....H...PMES.
  1cb0: 00 0c 00 03 50 4d 45 45 01 00 04 47 50 49 30 01  ....PMEE...GPI0.
  1cc0: 47 50 49 31 01 47 50 49 32 01 47 50 49 33 01 47  GPI1.GPI2.GPI3.G
  1cd0: 50 49 34 01 47 50 49 35 01 47 50 49 36 01 47 50  PI4.GPI5.GPI6.GP
  1ce0: 49 37 01 47 50 49 38 01 47 50 49 39 01 47 50 49  I7.GPI8.GPI9.GPI
  1cf0: 41 01 47 50 49 42 01 47 50 49 43 01 47 50 49 44  A.GPIB.GPIC.GPID
  1d00: 01 47 50 49 45 01 47 50 49 46 01 00 06 47 50 45  .GPIE.GPIF...GPE
  1d10: 45 01 5b 82 37 4b 42 43 5f 08 5f 48 49 44 0c 41  E.[.7KBC_._HID.A
  1d20: d0 03 03 08 5f 43 52 53 11 18 0a 15 47 01 60 00  ...._CRS....G.`.
  1d30: 60 00 01 01 47 01 64 00 64 00 01 01 22 02 00 79  `...G.d.d..."..y
  1d40: 00 14 09 5f 53 54 41 00 a4 0a 0f 5b 82 43 05 4d  ..._STA....[.C.M
  1d50: 4f 55 45 08 5f 48 49 44 0c 24 4d 37 80 08 5f 43  OUE._HID.$M7.._C
  1d60: 49 44 0c 41 d0 0f 13 08 5f 43 52 53 11 08 0a 05  ID.A...._CRS....
  1d70: 22 00 10 79 00 14 2a 5f 53 54 41 00 a0 0d 93 87  "..y..*_STA.....
  1d80: 5c 5f 4f 53 5f 0a 14 a4 0a 00 a1 15 a0 0e 5c 2e  \_OS_.........\.
  1d90: 5f 53 42 5f 50 53 32 4d a4 0a 0f a1 04 a4 0a 00  _SB_PS2M........
  1da0: 5b 82 49 04 4d 4f 55 32 08 5f 48 49 44 0c 41 d0  [.I.MOU2._HID.A.
  1db0: 0f 13 08 5f 43 52 53 11 08 0a 05 22 00 10 79 00  ..._CRS...."..y.
  1dc0: 14 2a 5f 53 54 41 00 a0 1e 93 87 5c 5f 4f 53 5f  .*_STA.....\_OS_
  1dd0: 0a 14 a0 0e 5c 2e 5f 53 42 5f 50 53 32 4d a4 0a  ....\._SB_PS2M..
  1de0: 0f a1 04 a4 0a 00 a1 04 a4 0a 00 5b 82 83 0d 01  ...........[....
  1df0: 53 49 4f 5f 08 5f 48 49 44 0c 41 d0 0a 05 5b 80  SIO_._HID.A...[.
  1e00: 53 49 49 4f 01 0a 4e 0a 02 5b 81 10 53 49 49 4f  SIIO..N..[..SIIO
  1e10: 01 49 4e 44 58 08 44 41 54 41 08 5b 01 4e 33 39  .INDX.DATA.[.N39
  1e20: 33 00 14 13 53 45 54 44 09 70 0a 07 49 4e 44 58  3...SETD.p..INDX
  1e30: 70 68 44 41 54 41 14 14 52 45 41 44 09 70 68 49  phDATA..READ.phI
  1e40: 4e 44 58 70 44 41 54 41 60 a4 60 14 12 57 52 49  NDXpDATA`.`..WRI
  1e50: 54 0a 70 68 49 4e 44 58 70 69 44 41 54 41 14 2d  T.phINDXpiDATA.-
  1e60: 4c 44 52 53 03 5b 23 4e 33 39 33 ff ff 70 0a 07  LDRS.[#N393..p..
  1e70: 49 4e 44 58 70 68 44 41 54 41 70 69 49 4e 44 58  INDXphDATApiINDX
  1e80: 70 6a 44 41 54 41 5b 27 4e 33 39 33 14 2f 4c 44  pjDATA['N393./LD
  1e90: 52 47 02 5b 23 4e 33 39 33 ff ff 70 0a 07 49 4e  RG.[#N393..p..IN
  1ea0: 44 58 70 68 44 41 54 41 70 69 49 4e 44 58 70 44  DXphDATApiINDXpD
  1eb0: 41 54 41 60 5b 27 4e 33 39 33 a4 60 14 2a 52 43  ATA`['N393.`.*RC
  1ec0: 46 36 01 5b 23 4e 33 39 33 ff ff 70 0a 26 49 4e  F6.[#N393..p.&IN
  1ed0: 44 58 70 44 41 54 41 60 7b 60 68 60 5b 27 4e 33  DXpDATA`{`h`['N3
  1ee0: 39 33 a4 7f 60 68 00 14 4f 13 50 44 52 53 02 a0  93..`h..O.PDRS..
  1ef0: 42 13 5c 2f 04 5f 53 42 5f 50 43 49 30 4c 50 43  B.\/._SB_PCI0LPC
  1f00: 30 50 4f 53 44 a0 32 93 68 0a 00 a0 0a 93 69 0b  0POSD.2.h.....i.
  1f10: f0 03 70 0a 00 60 a1 0c a0 0a 93 69 0b 70 03 70  ..p..`.....i.p.p
  1f20: 0a 01 60 70 60 5c 2f 04 5f 53 42 5f 50 43 49 30  ..`p`\/._SB_PCI0
  1f30: 4c 50 43 30 46 44 44 44 a1 46 0e a0 3f 93 68 0a  LPC0FDDD.F..?.h.
  1f40: 01 a0 0a 93 69 0b 78 03 70 0a 00 60 a1 19 a0 0a  ....i.x.p..`....
  1f50: 93 69 0b 78 02 70 0a 01 60 a1 0c a0 0a 93 69 0b  .i.x.p..`.....i.
  1f60: bc 03 70 0a 02 60 70 60 5c 2f 04 5f 53 42 5f 50  ..p..`p`\/._SB_P
  1f70: 43 49 30 4c 50 43 30 4c 50 54 44 a1 43 0a a0 0a  CI0LPC0LPTD.C...
  1f80: 93 69 0b f8 03 70 0a 00 60 a1 4d 05 a0 0a 93 69  .i...p..`.M....i
  1f90: 0b f8 02 70 0a 01 60 a1 4f 04 a0 0a 93 69 0b 20  ...p..`.O....i. 
  1fa0: 02 70 0a 02 60 a1 41 04 a0 0a 93 69 0b 28 02 70  .p..`.A....i.(.p
  1fb0: 0a 03 60 a1 33 a0 0a 93 69 0b 38 02 70 0a 04 60  ..`.3...i.8.p..`
  1fc0: a1 26 a0 0a 93 69 0b e8 02 70 0a 05 60 a1 19 a0  .&...i...p..`...
  1fd0: 0a 93 69 0b 38 03 70 0a 06 60 a1 0c a0 0a 93 69  ..i.8.p..`.....i
  1fe0: 0b e8 03 70 0a 07 60 a0 1a 93 68 0a 02 70 60 5c  ...p..`...h..p`\
  1ff0: 2f 04 5f 53 42 5f 50 43 49 30 4c 50 43 30 43 4d  /._SB_PCI0LPC0CM
  2000: 42 44 a1 1c a0 1a 93 68 0a 03 70 60 5c 2f 04 5f  BD.....h..p`\/._
  2010: 53 42 5f 50 43 49 30 4c 50 43 30 43 4d 41 44 a4  SB_PCI0LPC0CMAD.
  2020: 0a 01 a1 04 a4 0a 00 5b 82 40 2a 45 43 50 5f 08  .......[.@*ECP_.
  2030: 5f 48 49 44 0c 41 d0 04 01 08 5f 55 49 44 0a 03  _HID.A...._UID..
  2040: 14 3f 5f 53 54 41 00 70 4c 44 52 47 0a 01 0a f0  .?_STA.pLDRG....
  2050: 60 7a 60 0a 05 60 a0 24 90 52 43 46 36 0a 02 91  `z`..`.$.RCF6...
  2060: 93 60 0a 04 93 60 0a 07 79 4c 44 52 47 0a 01 0a  .`...`..yLDRG...
  2070: 30 0a 01 61 72 0a 0d 61 61 a4 61 a1 04 a4 0a 00  0..ar..aa.a.....
  2080: 14 10 5f 50 53 30 00 4c 44 52 53 0a 01 0a 30 0a  .._PS0.LDRS...0.
  2090: 01 14 10 5f 50 53 33 00 4c 44 52 53 0a 01 0a 30  ..._PS3.LDRS...0
  20a0: 0a 00 14 48 0c 5f 50 52 53 00 a4 11 4f 0b 0a bb  ...H._PRS...O...
  20b0: 30 47 01 78 03 78 03 08 08 47 01 78 07 78 07 08  0G.x.x...G.x.x..
  20c0: 08 22 80 00 2a 08 00 30 47 01 78 02 78 02 08 08  ."..*..0G.x.x...
  20d0: 47 01 78 06 78 06 08 08 22 20 00 2a 08 00 30 47  G.x.x..." .*..0G
  20e0: 01 78 03 78 03 08 08 47 01 78 07 78 07 08 08 22  .x.x...G.x.x..."
  20f0: 20 00 2a 08 00 30 47 01 78 02 78 02 08 08 47 01   .*..0G.x.x...G.
  2100: 78 06 78 06 08 08 22 80 00 2a 08 00 30 47 01 78  x.x..."..*..0G.x
  2110: 03 78 03 08 08 47 01 78 07 78 07 08 08 22 80 00  .x...G.x.x..."..
  2120: 2a 02 00 30 47 01 78 02 78 02 08 08 47 01 78 06  *..0G.x.x...G.x.
  2130: 78 06 08 08 22 20 00 2a 02 00 30 47 01 78 03 78  x..." .*..0G.x.x
  2140: 03 08 08 47 01 78 07 78 07 08 08 22 20 00 2a 02  ...G.x.x..." .*.
  2150: 00 30 47 01 78 02 78 02 08 08 47 01 78 06 78 06  .0G.x.x...G.x.x.
  2160: 08 08 22 80 00 2a 02 00 38 79 00 14 10 5f 44 49  .."..*..8y..._DI
  2170: 53 00 4c 44 52 53 0a 01 0a 30 0a 00 14 40 0e 5f  S.LDRS...0...-k+F0d9mFdQs@public.gmane.org
  2180: 43 52 53 00 08 44 43 52 53 11 1b 0a 18 47 01 78  CRS..DCRS....G.x
  2190: 03 78 03 08 08 47 01 78 07 78 07 08 08 22 80 00  .x...G.x.x..."..
  21a0: 2a 08 00 79 00 70 4c 44 52 47 0a 01 0a 60 61 70  *..y.pLDRG...`ap
  21b0: 4c 44 52 47 0a 01 0a 61 60 70 60 88 44 43 52 53  LDRG...a`p`.DCRS
  21c0: 0a 02 00 70 60 88 44 43 52 53 0a 0a 00 70 60 88  ...p`.DCRS...p`.
  21d0: 44 43 52 53 0a 04 00 70 60 88 44 43 52 53 0a 0c  DCRS...p`.DCRS..
  21e0: 00 70 61 88 44 43 52 53 0a 03 00 70 61 88 44 43  .pa.DCRS...pa.DC
  21f0: 52 53 0a 05 00 72 61 0a 04 61 70 61 88 44 43 52  RS...ra..apa.DCR
  2200: 53 0a 0b 00 70 61 88 44 43 52 53 0a 0d 00 79 0a  S...pa.DCRS...y.
  2210: 01 4c 44 52 47 0a 01 0a 70 60 70 60 88 44 43 52  .LDRG...p`p`.DCR
  2220: 53 0a 11 00 7a 60 0a 08 61 70 61 88 44 43 52 53  S...z`..apa.DCRS
  2230: 0a 12 00 79 0a 01 4c 44 52 47 0a 01 0a 74 60 70  ...y..LDRG...t`p
  2240: 60 88 44 43 52 53 0a 14 00 7a 60 0a 08 61 70 61  `.DCRS...z`..apa
  2250: 88 44 43 52 53 0a 15 00 a4 44 43 52 53 14 4b 06  .DCRS....DCRS.K.
  2260: 5f 53 52 53 01 8c 68 0a 02 41 44 52 4c 8c 68 0a  _SRS..h..ADRL.h.
  2270: 03 41 44 52 4d 8b 68 0a 11 49 52 51 4d 8b 68 0a  .ADRM.h..IRQM.h.
  2280: 14 44 4d 41 4d 82 49 52 51 4d 60 76 60 82 44 4d  .DMAM.IRQM`v`.DM
  2290: 41 4d 61 76 61 4c 44 52 53 0a 01 0a 70 60 4c 44  AMavaLDRS...p`LD
  22a0: 52 53 0a 01 0a 74 61 4c 44 52 53 0a 01 0a 60 41  RS...taLDRS...`A
  22b0: 44 52 4d 4c 44 52 53 0a 01 0a 61 41 44 52 4c 4c  DRMLDRS...aADRLL
  22c0: 44 52 53 0a 01 0a 30 0a 01 5b 82 4f 21 45 50 50  DRS...0..[.O!EPP
  22d0: 5f 08 5f 48 49 44 0c 41 d0 04 00 08 5f 55 49 44  _._HID.A...._UID
  22e0: 0a 02 14 3f 5f 53 54 41 00 70 4c 44 52 47 0a 01  ...?_STA.pLDRG..
  22f0: 0a f0 60 7a 60 0a 05 60 a0 24 90 52 43 46 36 0a  ..`z`..`.$.RCF6.
  2300: 02 91 93 60 0a 02 93 60 0a 03 79 4c 44 52 47 0a  ...`...`..yLDRG.
  2310: 01 0a 30 0a 01 61 72 0a 0d 61 61 a4 61 a1 04 a4  ..0..ar..aa.a...
  2320: 0a 00 14 10 5f 50 53 30 00 4c 44 52 53 0a 01 0a  ...._PS0.LDRS...
  2330: 30 0a 01 14 10 5f 50 53 33 00 4c 44 52 53 0a 01  0...._PS3.LDRS..
  2340: 0a 30 0a 00 14 48 08 5f 50 52 53 00 a4 11 4f 07  .0...H._PRS...O.
  2350: 0a 7b 30 47 01 78 03 78 03 08 08 47 01 78 07 78  .{0G.x.x...G.x.x
  2360: 07 08 08 22 80 00 30 47 01 78 02 78 02 08 08 47  ..."..0G.x.x...G
  2370: 01 78 06 78 06 08 08 22 20 00 30 47 01 78 03 78  .x.x..." .0G.x.x
  2380: 03 08 08 47 01 78 07 78 07 08 08 22 20 00 30 47  ...G.x.x..." .0G
  2390: 01 78 02 78 02 08 08 47 01 78 06 78 06 08 08 22  .x.x...G.x.x..."
  23a0: 80 00 30 47 01 78 01 78 01 08 08 47 01 78 05 78  ..0G.x.x...G.x.x
  23b0: 05 08 08 22 80 00 30 47 01 78 01 78 01 08 08 47  ..."..0G.x.x...G
  23c0: 01 78 05 78 05 08 08 22 20 00 38 79 00 14 10 5f  .x.x..." .8y..._
  23d0: 44 49 53 00 4c 44 52 53 0a 01 0a 30 0a 00 14 48  DIS.LDRS...0...H
  23e0: 0b 5f 43 52 53 00 08 44 43 52 53 11 18 0a 15 47  ._CRS..DCRS....G
  23f0: 01 78 03 78 03 08 08 47 01 78 07 78 07 08 08 22  .x.x...G.x.x..."
  2400: 80 00 79 00 70 4c 44 52 47 0a 01 0a 60 61 70 4c  ..y.pLDRG...`apL
  2410: 44 52 47 0a 01 0a 61 60 70 60 88 44 43 52 53 0a  DRG...a`p`.DCRS.
  2420: 02 00 70 60 88 44 43 52 53 0a 0a 00 70 60 88 44  ..p`.DCRS...p`.D
  2430: 43 52 53 0a 04 00 70 60 88 44 43 52 53 0a 0c 00  CRS...p`.DCRS...
  2440: 70 61 88 44 43 52 53 0a 03 00 70 61 88 44 43 52  pa.DCRS...pa.DCR
  2450: 53 0a 05 00 72 61 0a 04 61 70 61 88 44 43 52 53  S...ra..apa.DCRS
  2460: 0a 0b 00 70 61 88 44 43 52 53 0a 0d 00 79 0a 01  ...pa.DCRS...y..
  2470: 4c 44 52 47 0a 01 0a 70 60 70 60 88 44 43 52 53  LDRG...p`p`.DCRS
  2480: 0a 11 00 7a 60 0a 08 61 70 61 88 44 43 52 53 0a  ...z`..apa.DCRS.
  2490: 12 00 a4 44 43 52 53 14 42 05 5f 53 52 53 01 8c  ...DCRS.B._SRS..
  24a0: 68 0a 02 41 44 52 4c 8c 68 0a 03 41 44 52 4d 8b  h..ADRL.h..ADRM.
  24b0: 68 0a 11 49 52 51 4d 82 49 52 51 4d 60 76 60 4c  h..IRQM.IRQM`v`L
  24c0: 44 52 53 0a 01 0a 70 60 4c 44 52 53 0a 01 0a 60  DRS...p`LDRS...`
  24d0: 41 44 52 4d 4c 44 52 53 0a 01 0a 61 41 44 52 4c  ADRMLDRS...aADRL
  24e0: 4c 44 52 53 0a 01 0a 30 0a 01 5b 82 43 25 4c 50  LDRS...0..[.C%LP
  24f0: 54 42 08 5f 48 49 44 0c 41 d0 04 00 08 5f 55 49  TB._HID.A...._UI
  2500: 44 0a 01 14 3a 5f 53 54 41 00 70 4c 44 52 47 0a  D...:_STA.pLDRG.
  2510: 01 0a f0 60 7a 60 0a 05 60 a0 1f 90 52 43 46 36  ...`z`..`...RCF6
  2520: 0a 02 93 60 0a 01 79 4c 44 52 47 0a 01 0a 30 0a  ...`..yLDRG...0.
  2530: 01 61 72 0a 0d 61 61 a4 61 a1 04 a4 0a 00 14 10  .ar..aa.a.......
  2540: 5f 50 53 30 00 4c 44 52 53 0a 01 0a 30 0a 01 14  _PS0.LDRS...0...
  2550: 10 5f 50 53 33 00 4c 44 52 53 0a 01 0a 30 0a 00  ._PS3.LDRS...0..
  2560: 14 48 08 5f 50 52 53 00 a4 11 4f 07 0a 7b 30 47  .H._PRS...O..{0G
  2570: 01 78 03 78 03 08 08 47 01 78 07 78 07 08 08 22  .x.x...G.x.x..."
  2580: 80 00 30 47 01 78 02 78 02 08 08 47 01 78 06 78  ..0G.x.x...G.x.x
  2590: 06 08 08 22 20 00 30 47 01 78 03 78 03 08 08 47  ..." .0G.x.x...G
  25a0: 01 78 07 78 07 08 08 22 20 00 30 47 01 78 02 78  .x.x..." .0G.x.x
  25b0: 02 08 08 47 01 78 06 78 06 08 08 22 80 00 30 47  ...G.x.x..."..0G
  25c0: 01 bc 03 bc 03 04 04 47 01 bc 07 bc 07 04 04 22  .......G......."
  25d0: 80 00 30 47 01 bc 03 bc 03 04 04 47 01 bc 07 bc  ..0G.......G....
  25e0: 07 04 04 22 20 00 38 79 00 14 10 5f 44 49 53 00  ..." .8y..._DIS.
  25f0: 4c 44 52 53 0a 01 0a 30 0a 00 14 41 0f 5f 43 52  LDRS...0...A._CR
  2600: 53 00 08 44 43 52 53 11 18 0a 15 47 01 78 03 78  S..DCRS....G.x.x
  2610: 03 08 08 47 01 78 07 78 07 08 08 22 80 00 79 00  ...G.x.x..."..y.
  2620: 70 4c 44 52 47 0a 01 0a 60 61 70 4c 44 52 47 0a  pLDRG...`apLDRG.
  2630: 01 0a 61 60 70 60 88 44 43 52 53 0a 02 00 70 60  ..a`p`.DCRS...p`
  2640: 88 44 43 52 53 0a 0a 00 70 60 88 44 43 52 53 0a  .DCRS...p`.DCRS.
  2650: 04 00 70 60 88 44 43 52 53 0a 0c 00 70 61 88 44  ..p`.DCRS...pa.D
  2660: 43 52 53 0a 03 00 70 61 88 44 43 52 53 0a 05 00  CRS...pa.DCRS...
  2670: 72 61 0a 04 61 70 61 88 44 43 52 53 0a 0b 00 70  ra..apa.DCRS...p
  2680: 61 88 44 43 52 53 0a 0d 00 a0 0a 7b 60 0a 04 00  a.DCRS.....{`...
  2690: 70 0a 04 60 a1 05 70 0a 08 60 70 60 88 44 43 52  p..`..p..`p`.DCR
  26a0: 53 0a 06 00 70 60 88 44 43 52 53 0a 07 00 70 60  S...p`.DCRS...p`
  26b0: 88 44 43 52 53 0a 0e 00 70 60 88 44 43 52 53 0a  .DCRS...p`.DCRS.
  26c0: 0f 00 79 0a 01 4c 44 52 47 0a 01 0a 70 60 70 60  ..y..LDRG...p`p`
  26d0: 88 44 43 52 53 0a 11 00 7a 60 0a 08 61 70 61 88  .DCRS...z`..apa.
  26e0: 44 43 52 53 0a 12 00 a4 44 43 52 53 14 42 05 5f  DCRS....DCRS.B._
  26f0: 53 52 53 01 8c 68 0a 02 41 44 52 4c 8c 68 0a 03  SRS..h..ADRL.h..
  2700: 41 44 52 4d 8b 68 0a 11 49 52 51 4d 82 49 52 51  ADRM.h..IRQM.IRQ
  2710: 4d 60 76 60 4c 44 52 53 0a 01 0a 70 60 4c 44 52  M`v`LDRS...p`LDR
  2720: 53 0a 01 0a 60 41 44 52 4d 4c 44 52 53 0a 01 0a  S...`ADRMLDRS...
  2730: 61 41 44 52 4c 4c 44 52 53 0a 01 0a 30 0a 01 5b  aADRLLDRS...0..[
  2740: 82 43 25 4c 50 54 5f 08 5f 48 49 44 0c 41 d0 04  .C%LPT_._HID.A..
  2750: 00 08 5f 55 49 44 0a 00 14 3a 5f 53 54 41 00 70  .._UID...:_STA.p
  2760: 4c 44 52 47 0a 01 0a f0 60 7a 60 0a 05 60 a0 1f  LDRG....`z`..`..
  2770: 90 52 43 46 36 0a 02 93 60 0a 00 79 4c 44 52 47  .RCF6...`..yLDRG
  2780: 0a 01 0a 30 0a 01 61 72 0a 0d 61 61 a4 61 a1 04  ...0..ar..aa.a..
  2790: a4 0a 00 14 10 5f 50 53 30 00 4c 44 52 53 0a 01  ....._PS0.LDRS..
  27a0: 0a 30 0a 01 14 10 5f 50 53 33 00 4c 44 52 53 0a  .0...._PS3.LDRS.
  27b0: 01 0a 30 0a 00 14 48 08 5f 50 52 53 00 a4 11 4f  ..0...H._PRS...O
  27c0: 07 0a 7b 30 47 01 78 03 78 03 08 08 47 01 78 07  ..{0G.x.x...G.x.
  27d0: 78 07 08 08 22 80 00 30 47 01 78 02 78 02 08 08  x..."..0G.x.x...
  27e0: 47 01 78 06 78 06 08 08 22 20 00 30 47 01 78 03  G.x.x..." .0G.x.
  27f0: 78 03 08 08 47 01 78 07 78 07 08 08 22 20 00 30  x...G.x.x..." .0
  2800: 47 01 78 02 78 02 08 08 47 01 78 06 78 06 08 08  G.x.x...G.x.x...
  2810: 22 80 00 30 47 01 bc 03 bc 03 04 04 47 01 bc 07  "..0G.......G...
  2820: bc 07 04 04 22 80 00 30 47 01 bc 03 bc 03 04 04  ...."..0G.......
  2830: 47 01 bc 07 bc 07 04 04 22 20 00 38 79 00 14 10  G......." .8y...
  2840: 5f 44 49 53 00 4c 44 52 53 0a 01 0a 30 0a 00 14  _DIS.LDRS...0...
  2850: 41 0f 5f 43 52 53 00 08 44 43 52 53 11 18 0a 15  A._CRS..DCRS....
  2860: 47 01 78 03 78 03 08 08 47 01 78 07 78 07 08 08  G.x.x...G.x.x...
  2870: 22 80 00 79 00 70 4c 44 52 47 0a 01 0a 60 61 70  "..y.pLDRG...`ap
  2880: 4c 44 52 47 0a 01 0a 61 60 70 60 88 44 43 52 53  LDRG...a`p`.DCRS
  2890: 0a 02 00 70 60 88 44 43 52 53 0a 0a 00 70 60 88  ...p`.DCRS...p`.
  28a0: 44 43 52 53 0a 04 00 70 60 88 44 43 52 53 0a 0c  DCRS...p`.DCRS..
  28b0: 00 70 61 88 44 43 52 53 0a 03 00 70 61 88 44 43  .pa.DCRS...pa.DC
  28c0: 52 53 0a 05 00 72 61 0a 04 61 70 61 88 44 43 52  RS...ra..apa.DCR
  28d0: 53 0a 0b 00 70 61 88 44 43 52 53 0a 0d 00 a0 0a  S...pa.DCRS.....
  28e0: 7b 60 0a 04 00 70 0a 04 60 a1 05 70 0a 08 60 70  {`...p..`..p..`p
  28f0: 60 88 44 43 52 53 0a 06 00 70 60 88 44 43 52 53  `.DCRS...p`.DCRS
  2900: 0a 07 00 70 60 88 44 43 52 53 0a 0e 00 70 60 88  ...p`.DCRS...p`.
  2910: 44 43 52 53 0a 0f 00 79 0a 01 4c 44 52 47 0a 01  DCRS...y..LDRG..
  2920: 0a 70 60 70 60 88 44 43 52 53 0a 11 00 7a 60 0a  .p`p`.DCRS...z`.
  2930: 08 61 70 61 88 44 43 52 53 0a 12 00 a4 44 43 52  .apa.DCRS....DCR
  2940: 53 14 42 05 5f 53 52 53 01 8c 68 0a 02 41 44 52  S.B._SRS..h..ADR
  2950: 4c 8c 68 0a 03 41 44 52 4d 8b 68 0a 11 49 52 51  L.h..ADRM.h..IRQ
  2960: 4d 82 49 52 51 4d 60 76 60 4c 44 52 53 0a 01 0a  M.IRQM`v`LDRS...
  2970: 70 60 4c 44 52 53 0a 01 0a 60 41 44 52 4d 4c 44  p`LDRS...`ADRMLD
  2980: 52 53 0a 01 0a 61 41 44 52 4c 4c 44 52 53 0a 01  RS...aADRLLDRS..
  2990: 0a 30 0a 01 5b 82 49 1b 43 4f 4d 41 08 5f 48 49  .0..[.I.COMA._HI
  29a0: 44 0c 41 d0 05 01 08 5f 55 49 44 0a 00 14 26 5f  D.A...._UID...&_
  29b0: 53 54 41 00 a0 1a 52 43 46 36 0a 08 79 4c 44 52  STA...RCF6..yLDR
  29c0: 47 0a 03 0a 30 0a 01 61 72 0a 0d 61 61 a4 61 a1  G...0..ar..aa.a.
  29d0: 04 a4 0a 00 14 10 5f 50 53 30 00 4c 44 52 53 0a  ......_PS0.LDRS.
  29e0: 03 0a 30 0a 01 14 10 5f 50 53 33 00 4c 44 52 53  ..0...._PS3.LDRS
  29f0: 0a 03 0a 30 0a 00 14 40 07 5f 50 52 53 00 a4 11  ...0...-zlzLnsEgg4Y@public.gmane.org
  2a00: 47 06 0a 63 30 47 01 f8 03 f8 03 08 08 22 10 00  G..c0G......."..
  2a10: 30 47 01 f8 02 f8 02 08 08 22 08 00 30 47 01 e8  0G......."..0G..
  2a20: 03 e8 03 08 08 22 10 00 30 47 01 e8 02 e8 02 08  ....."..0G......
  2a30: 08 22 08 00 30 47 01 f8 03 f8 03 08 08 22 08 00  ."..0G......."..
  2a40: 30 47 01 f8 02 f8 02 08 08 22 10 00 30 47 01 e8  0G......."..0G..
  2a50: 03 e8 03 08 08 22 08 00 30 47 01 e8 02 e8 02 08  ....."..0G......
  2a60: 08 22 10 00 38 79 00 14 10 5f 44 49 53 00 4c 44  ."..8y..._DIS.LD
  2a70: 52 53 0a 03 0a 30 0a 00 14 43 08 5f 43 52 53 00  RS...0...C._CRS.
  2a80: 08 44 43 52 53 11 10 0a 0d 47 01 f8 03 f8 03 08  .DCRS....G......
  2a90: 08 22 10 00 79 00 70 4c 44 52 47 0a 03 0a 60 61  ."..y.pLDRG...`a
  2aa0: 70 4c 44 52 47 0a 03 0a 61 60 70 60 88 44 43 52  pLDRG...a`p`.DCR
  2ab0: 53 0a 02 00 70 60 88 44 43 52 53 0a 04 00 70 61  S...p`.DCRS...pa
  2ac0: 88 44 43 52 53 0a 03 00 70 61 88 44 43 52 53 0a  .DCRS...pa.DCRS.
  2ad0: 05 00 79 0a 01 4c 44 52 47 0a 03 0a 70 60 70 60  ..y..LDRG...p`p`
  2ae0: 88 44 43 52 53 0a 09 00 7a 60 0a 08 61 70 61 88  .DCRS...z`..apa.
  2af0: 44 43 52 53 0a 0a 00 a4 44 43 52 53 14 42 05 5f  DCRS....DCRS.B._
  2b00: 53 52 53 01 8c 68 0a 02 41 44 52 4c 8c 68 0a 03  SRS..h..ADRL.h..
  2b10: 41 44 52 4d 8b 68 0a 09 49 52 51 4d 82 49 52 51  ADRM.h..IRQM.IRQ
  2b20: 4d 60 76 60 4c 44 52 53 0a 03 0a 70 60 4c 44 52  M`v`LDRS...p`LDR
  2b30: 53 0a 03 0a 60 41 44 52 4d 4c 44 52 53 0a 03 0a  S...`ADRMLDRS...
  2b40: 61 41 44 52 4c 4c 44 52 53 0a 03 0a 30 0a 01 5b  aADRLLDRS...0..[
  2b50: 82 4f 36 46 49 52 5f 14 25 5f 48 49 44 00 a0 16  .O6FIR_.%_HID...
  2b60: 91 93 4d 59 4f 53 0a 01 93 4d 59 4f 53 0a 03 a4  ..MYOS...MYOS...
  2b70: 0c 3a 63 60 01 a1 07 a4 0c 3a 63 60 01 08 5f 55  .:c`.....:c`.._U
  2b80: 49 44 0a 00 14 36 5f 53 54 41 00 70 4c 44 52 47  ID...6_STA.pLDRG
  2b90: 0a 02 0a 74 60 a0 20 90 52 43 46 36 0a 04 92 93  ...t`. .RCF6....
  2ba0: 60 0a 04 79 4c 44 52 47 0a 02 0a 30 0a 01 61 72  `..yLDRG...0..ar
  2bb0: 0a 0d 61 61 a4 61 a1 04 a4 0a 00 14 10 5f 50 53  ..aa.a......._PS
  2bc0: 30 00 4c 44 52 53 0a 02 0a 30 0a 01 14 10 5f 50  0.LDRS...0...._P
  2bd0: 53 33 00 4c 44 52 53 0a 02 0a 30 0a 00 14 49 17  S3.LDRS...0...I.
  2be0: 5f 50 52 53 00 a4 11 40 17 0b 6b 01 30 47 01 f8  _PRS...-ibKPwYNvp/4@public.gmane.org
  2bf0: 03 f8 03 08 08 22 10 00 2a 01 00 30 47 01 f8 02  ....."..*..0G...
  2c00: f8 02 08 08 22 08 00 2a 01 00 30 47 01 e8 03 e8  ...."..*..0G....
  2c10: 03 08 08 22 10 00 2a 01 00 30 47 01 e8 02 e8 02  ..."..*..0G.....
  2c20: 08 08 22 08 00 2a 01 00 30 47 01 f8 03 f8 03 08  .."..*..0G......
  2c30: 08 22 08 00 2a 01 00 30 47 01 f8 02 f8 02 08 08  ."..*..0G.......
  2c40: 22 10 00 2a 01 00 30 47 01 e8 03 e8 03 08 08 22  "..*..0G......."
  2c50: 08 00 2a 01 00 30 47 01 e8 02 e8 02 08 08 22 10  ..*..0G.......".
  2c60: 00 2a 01 00 30 47 01 f8 03 f8 03 08 08 22 10 00  .*..0G......."..
  2c70: 2a 02 00 30 47 01 f8 02 f8 02 08 08 22 08 00 2a  *..0G......."..*
  2c80: 02 00 30 47 01 e8 03 e8 03 08 08 22 10 00 2a 02  ..0G......."..*.
  2c90: 00 30 47 01 e8 02 e8 02 08 08 22 08 00 2a 02 00  .0G......."..*..
  2ca0: 30 47 01 f8 03 f8 03 08 08 22 08 00 2a 02 00 30  0G......."..*..0
  2cb0: 47 01 f8 02 f8 02 08 08 22 10 00 2a 02 00 30 47  G......."..*..0G
  2cc0: 01 e8 03 e8 03 08 08 22 08 00 2a 02 00 30 47 01  ......."..*..0G.
  2cd0: e8 02 e8 02 08 08 22 10 00 2a 02 00 30 47 01 f8  ......"..*..0G..
  2ce0: 03 f8 03 08 08 22 10 00 2a 08 00 30 47 01 f8 02  ....."..*..0G...
  2cf0: f8 02 08 08 22 08 00 2a 08 00 30 47 01 e8 03 e8  ...."..*..0G....
  2d00: 03 08 08 22 10 00 2a 08 00 30 47 01 e8 02 e8 02  ..."..*..0G.....
  2d10: 08 08 22 08 00 2a 08 00 30 47 01 f8 03 f8 03 08  .."..*..0G......
  2d20: 08 22 08 00 2a 08 00 30 47 01 f8 02 f8 02 08 08  ."..*..0G.......
  2d30: 22 10 00 2a 08 00 30 47 01 e8 03 e8 03 08 08 22  "..*..0G......."
  2d40: 08 00 2a 08 00 30 47 01 e8 02 e8 02 08 08 22 10  ..*..0G.......".
  2d50: 00 2a 08 00 38 79 00 14 26 5f 44 49 53 00 4c 44  .*..8y..&_DIS.LD
  2d60: 52 53 0a 02 0a 30 0a 00 70 0a 00 5c 2f 04 5f 53  RS...0..p..\/._S
  2d70: 42 5f 50 43 49 30 4c 50 43 30 45 43 4f 31 14 4b  B_PCI0LPC0ECO1.K
  2d80: 0a 5f 43 52 53 00 08 44 43 52 53 11 13 0a 10 47  ._CRS..DCRS....G
  2d90: 01 f8 02 f8 02 08 08 22 08 00 2a 01 00 79 00 70  ......."..*..y.p
  2da0: 4c 44 52 47 0a 02 0a 60 61 70 4c 44 52 47 0a 02  LDRG...`apLDRG..
  2db0: 0a 61 60 70 60 88 44 43 52 53 0a 02 00 70 60 88  .a`p`.DCRS...p`.
  2dc0: 44 43 52 53 0a 04 00 70 61 88 44 43 52 53 0a 03  DCRS...pa.DCRS..
  2dd0: 00 70 61 88 44 43 52 53 0a 05 00 79 0a 01 4c 44  .pa.DCRS...y..LD
  2de0: 52 47 0a 02 0a 70 60 70 60 88 44 43 52 53 0a 09  RG...p`p`.DCRS..
  2df0: 00 7a 60 0a 08 61 70 61 88 44 43 52 53 0a 0a 00  .z`..apa.DCRS...
  2e00: 79 0a 01 4c 44 52 47 0a 02 0a 74 60 70 60 88 44  y..LDRG...t`p`.D
  2e10: 43 52 53 0a 0c 00 7a 60 0a 08 61 70 61 88 44 43  CRS...z`..apa.DC
  2e20: 52 53 0a 0d 00 a4 44 43 52 53 14 45 09 5f 53 52  RS....DCRS.E._SR
  2e30: 53 01 70 0a 01 5c 2f 04 5f 53 42 5f 50 43 49 30  S.p..\/._SB_PCI0
  2e40: 4c 50 43 30 45 43 4f 31 8c 68 0a 02 41 44 52 4c  LPC0ECO1.h..ADRL
  2e50: 8c 68 0a 03 41 44 52 4d 8b 68 0a 09 49 52 51 4d  .h..ADRM.h..IRQM
  2e60: 8b 68 0a 0c 44 4d 41 4d 82 49 52 51 4d 60 76 60  .h..DMAM.IRQM`v`
  2e70: 82 44 4d 41 4d 61 76 61 4c 44 52 53 0a 02 0a 70  .DMAMavaLDRS...p
  2e80: 60 4c 44 52 53 0a 02 0a 74 61 4c 44 52 53 0a 02  `LDRS...taLDRS..
  2e90: 0a 60 41 44 52 4d 4c 44 52 53 0a 02 0a 61 41 44  .`ADRMLDRS...aAD
  2ea0: 52 4c 50 44 52 53 0a 02 72 79 41 44 52 4d 0a 08  RLPDRS..ryADRM..
  2eb0: 00 41 44 52 4c 00 4c 44 52 53 0a 02 0a 30 0a 01  .ADRL.LDRS...0..
  2ec0: 5b 82 42 cb 45 43 30 5f 08 5f 48 49 44 0c 41 d0  [.B.EC0_._HID.A.
  2ed0: 0c 09 08 5f 43 52 53 11 15 0a 12 47 01 62 00 62  ..._CRS....G.b.b
  2ee0: 00 01 01 47 01 66 00 66 00 01 01 79 00 08 5f 47  ...G.f.f...y.._G
  2ef0: 50 45 0a 1d 08 4f 53 45 4a 0a 00 14 40 06 5f 52  PE...OSEJ...-DSdbpz7AS3E@public.gmane.org
  2f00: 45 47 02 a0 48 05 93 68 0a 03 70 69 5c 2e 5f 53  EG..H..h..pi\._S
  2f10: 42 5f 4f 4b 45 43 a0 45 04 7d 93 5c 2f 03 5f 53  B_OKEC.E.}.\/._S
  2f20: 42 5f 50 43 49 30 4d 59 4f 53 0a 03 93 5c 2f 03  B_PCI0MYOS...\/.
  2f30: 5f 53 42 5f 50 43 49 30 4d 59 4f 53 0a 01 00 a0  _SB_PCI0MYOS....
  2f40: 1c 69 70 0a 01 5c 2f 05 5f 53 42 5f 50 43 49 30  .ip..\/._SB_PCI0
  2f50: 4c 50 43 30 45 43 30 5f 52 47 35 37 5b 80 45 52  LPC0EC0_RG57[.ER
  2f60: 41 4d 03 0a 00 0a ff 5b 81 4d 2c 45 52 41 4d 01  AM.....[.M,ERAM.
  2f70: 00 20 43 4d 43 4d 08 43 4d 44 31 08 43 4d 44 32  . CMCM.CMD1.CMD2
  2f80: 08 43 4d 44 33 08 00 40 08 53 4d 50 52 08 53 4d  .CMD3..-32JfEtWasNM@public.gmane.org
  2f90: 53 54 08 53 4d 41 44 08 53 4d 43 4d 08 53 4d 44  ST.SMAD.SMCM.SMD
  2fa0: 30 40 10 42 43 4e 54 08 53 4d 41 41 08 42 41 54  0-7qGp/5mYz6lec+2ENNI1xA@public.gmane.org
  2fb0: 44 10 41 43 44 46 01 00 07 00 04 46 50 52 31 01  D.ACDF.....FPR1.
  2fc0: 53 34 4c 44 01 53 35 4c 57 01 50 46 4c 47 01 00  S4LD.S5LW.PFLG..
  2fd0: 08 54 4d 53 53 02 00 02 42 41 4e 4b 04 00 08 56  .TMSS...BANK...V
  2fe0: 46 41 4e 01 00 07 52 4c 30 31 01 52 44 30 31 01  FAN...RL01.RD01.
  2ff0: 52 46 30 31 01 52 50 30 31 01 52 42 30 31 01 52  RF01.RP01.RB01.R
  3000: 43 30 31 01 00 01 52 37 30 31 01 52 38 30 31 01  C01...R701.R801.
  3010: 52 4d 30 31 01 52 49 30 31 01 00 01 00 01 00 01  RM01.RI01.......
  3020: 52 41 30 31 01 52 52 30 31 01 52 4c 31 30 01 52  RA01.RR01.RL10.R
  3030: 44 31 30 01 52 46 31 30 01 52 50 31 30 01 52 42  D10.RF10.RP10.RB
  3040: 31 30 01 52 43 31 30 01 00 01 52 37 31 30 01 52  10.RC10...R710.R
  3050: 38 31 30 01 52 4d 31 30 01 52 49 31 30 01 00 01  810.RM10.RI10...
  3060: 00 01 00 01 52 41 31 30 01 52 52 31 30 01 57 4c  ....RA10.RR10.WL
  3070: 30 31 01 57 44 30 31 01 57 46 30 31 01 57 50 30  01.WD01.WF01.WP0
  3080: 31 01 57 42 30 31 01 57 43 30 31 01 00 01 57 37  1.WB01.WC01...W7
  3090: 30 31 01 57 38 30 31 01 57 4d 30 31 01 57 49 30  01.W801.WM01.WI0
  30a0: 31 01 00 01 00 01 00 01 57 41 30 31 01 57 52 30  1.......WA01.WR0
  30b0: 31 01 57 4c 31 30 01 57 44 31 30 01 57 46 31 30  1.WL10.WD10.WF10
  30c0: 01 57 50 31 30 01 57 42 31 30 01 57 43 31 30 01  .WP10.WB10.WC10.
  30d0: 00 01 57 37 31 30 01 57 38 31 30 01 57 4d 31 30  ..W710.W810.WM10
  30e0: 01 57 49 31 30 01 00 01 00 01 00 01 57 41 31 30  .WI10.......WA10
  30f0: 01 57 52 31 30 01 4c 49 44 45 01 42 41 59 45 01  .WR10.LIDE.BAYE.
  3100: 45 46 44 45 01 50 52 44 45 01 42 52 42 45 01 43  EFDE.PRDE.BRBE.C
  3110: 52 54 45 01 00 01 57 37 42 45 01 57 38 42 45 01  RTE...W7BE.W8BE.
  3120: 50 4d 45 45 01 49 4e 54 45 01 00 01 00 01 00 01  PMEE.INTE.......
  3130: 44 42 32 45 01 44 42 33 45 01 00 10 4c 49 44 53  DB2E.DB3E...LIDS
  3140: 01 42 41 59 53 01 45 46 44 53 01 50 52 44 53 01  .BAYS.EFDS.PRDS.
  3150: 42 52 42 53 01 43 52 54 53 01 00 01 57 37 42 53  BRBS.CRTS...W7BS
  3160: 01 57 38 42 53 01 44 50 45 4d 01 44 49 4e 54 01  .W8BS.DPEM.DINT.
  3170: 00 01 00 01 00 01 44 42 32 53 01 44 42 33 53 01  ......DB2S.DB3S.
  3180: 00 18 52 47 35 37 08 43 54 4d 50 08 52 47 35 39  ..RG57.CTMP.RG59
  3190: 08 52 47 35 41 08 52 47 35 42 08 46 53 50 44 10  .RG5A.RG5B.FSPD.
  31a0: 00 08 46 41 4e 32 01 53 46 4e 32 01 00 06 00 01  ..FAN2.SFN2.....
  31b0: 46 41 4e 43 01 00 4e 07 4d 42 49 44 08 4d 42 54  FANC..N.MBID.MBT
  31c0: 53 01 4d 42 54 46 01 00 06 4d 42 54 43 01 00 27  S.MBTF...MBTC..'
  31d0: 42 41 31 43 08 4d 42 56 47 10 4d 43 55 52 10 00  BA1C.MBVG.MCUR..
  31e0: 20 53 42 49 44 08 53 42 54 53 01 53 42 54 46 01   SBID.SBTS.SBTF.
  31f0: 00 06 53 42 54 43 01 00 27 42 41 32 43 08 41 42  ..SBTC..'BA2C.AB
  3200: 56 47 10 41 43 55 52 10 00 48 1b 4d 42 52 4d 10  VG.ACUR..H.MBRM.
  3210: 00 28 41 42 52 4d 10 00 20 45 42 50 4c 01 00 0f  .(ABRM.. EBPL...
  3220: 00 06 41 50 57 52 01 00 19 44 42 50 4c 08 00 40  ..APWR...DBPL..@
  3230: 08 47 51 4b 53 07 5b 81 0e 45 52 41 4d 01 00 40  .GQKS.[..ERAM..@
  3240: 0e 53 4d 57 30 10 5b 81 0e 45 52 41 4d 01 00 40  .SMW0.[..ERAM..@
  3250: 0e 53 4d 42 30 08 5b 81 0f 45 52 41 4d 01 00 40  .SMB0.[..ERAM..@
  3260: 0e 46 4c 44 30 40 04 5b 81 0f 45 52 41 4d 01 00  .FLD0-4b8TPpkIZ3Q@public.gmane.org[..ERAM..
  3270: 40 0e 46 4c 44 31 40 08 5b 81 0f 45 52 41 4d 01  @.FLD1-4b8TPpkIZ3Q@public.gmane.org[..ERAM.
  3280: 00 40 0e 46 4c 44 32 40 0c 5b 81 0f 45 52 41 4d  .-E2hY8PtJ1VU@public.gmane.org@.[..ERAM
  3290: 01 00 40 0e 46 4c 44 33 40 10 5b 01 4d 55 54 30  ..-oczlbNmjnOE@public.gmane.org@.[.MUT0
  32a0: 00 14 4f 14 53 4d 52 44 04 a0 0f 92 5c 2e 5f 53  ..O.SMRD....\._S
  32b0: 42 5f 4f 4b 45 43 a4 0a ff a0 17 92 93 68 0a 07  B_OKEC.......h..
  32c0: a0 10 92 93 68 0a 09 a0 09 92 93 68 0a 0b a4 0a  ....h......h....
  32d0: 19 5b 23 4d 55 54 30 ff ff 70 0a 04 60 a2 4d 06  .[#MUT0..p..`.M.
  32e0: 94 60 0a 01 7b 53 4d 53 54 0a 40 53 4d 53 54 70  .`..{SMST.-ry7FSkqPhZc@public.gmane.org
  32f0: 6a 53 4d 43 4d 70 69 53 4d 41 44 70 68 53 4d 50  jSMCMpiSMADphSMP
  3300: 52 70 0a 00 63 a2 37 92 7b 53 4d 53 54 0a bf 61  Rp..c.7.{SMST..a
  3310: 5b 22 0a 02 75 63 a0 26 93 63 0a 32 7b 53 4d 53  ["..uc.&.c.2{SMS
  3320: 54 0a 40 53 4d 53 54 70 6a 53 4d 43 4d 70 69 53  T.-p+JQobSegzLQqphFDEm5QQ@public.gmane.org
  3330: 4d 41 44 70 68 53 4d 50 52 70 0a 00 63 a0 09 93  MADphSMPRp..c...
  3340: 61 0a 80 70 0a 00 60 a1 03 76 60 a0 09 60 70 7b  a..p..`..v`..`p{
  3350: 61 0a 1f 00 60 a1 43 09 a0 0b 93 68 0a 07 70 53  a...`.C....h..pS
  3360: 4d 42 30 6b a0 0b 93 68 0a 09 70 53 4d 57 30 6b  MB0k...h..pSMW0k
  3370: a0 48 07 93 68 0a 0b 70 42 43 4e 54 63 7a 0b 00  .H..h..pBCNTcz..
  3380: 01 0a 03 62 a0 07 94 63 62 70 62 63 a0 0b 95 63  ...b...cbpbc...c
  3390: 0a 09 70 46 4c 44 30 62 a1 23 a0 0b 95 63 0a 11  ..pFLD0b.#...c..
  33a0: 70 46 4c 44 31 62 a1 15 a0 0b 95 63 0a 19 70 46  pFLD1b.....c..pF
  33b0: 4c 44 32 62 a1 07 70 46 4c 44 33 62 75 63 70 11  LD2b..pFLD3bucp.
  33c0: 02 63 64 76 63 70 00 65 a2 15 94 63 65 47 42 46  .cdvcp.e...ceGBF
  33d0: 45 62 65 71 66 50 42 46 45 64 65 66 75 65 50 42  EbeqfPBFEdefuePB
  33e0: 46 45 64 65 0a 00 70 64 6b 5b 27 4d 55 54 30 a4  FEde..pdk['MUT0.
  33f0: 60 14 4f 0d 53 4d 57 52 04 a0 0f 92 5c 2e 5f 53  `.O.SMWR....\._S
  3400: 42 5f 4f 4b 45 43 a4 0a ff a0 17 92 93 68 0a 06  B_OKEC.......h..
  3410: a0 10 92 93 68 0a 08 a0 09 92 93 68 0a 0a a4 0a  ....h......h....
  3420: 19 5b 23 4d 55 54 30 ff ff 70 0a 04 60 a2 41 09  .[#MUT0..p..`.A.
  3430: 94 60 0a 01 a0 0b 93 68 0a 06 70 6b 53 4d 42 30  .`.....h..pkSMB0
  3440: a0 0b 93 68 0a 08 70 6b 53 4d 57 30 a0 0b 93 68  ...h..pkSMW0...h
  3450: 0a 0a 70 6b 53 4d 44 30 7b 53 4d 53 54 0a 40 53  ..pkSMD0{SMST.-p3RXJz+FWaA@public.gmane.org
  3460: 4d 53 54 70 6a 53 4d 43 4d 70 69 53 4d 41 44 70  MSTpjSMCMpiSMADp
  3470: 68 53 4d 50 52 70 0a 00 63 a2 37 92 7b 53 4d 53  hSMPRp..c.7.{SMS
  3480: 54 0a bf 61 5b 22 0a 02 75 63 a0 26 93 63 0a 32  T..a["..uc.&.c.2
  3490: 7b 53 4d 53 54 0a 40 53 4d 53 54 70 6a 53 4d 43  {SMST.-p+JQobSegzJ/8xXOW9rC8g@public.gmane.org
  34a0: 4d 70 69 53 4d 41 44 70 68 53 4d 50 52 70 0a 00  MpiSMADphSMPRp..
  34b0: 63 a0 09 93 61 0a 80 70 0a 00 60 a1 03 76 60 a0  c...a..p..`..v`.
  34c0: 09 60 70 7b 61 0a 1f 00 60 5b 27 4d 55 54 30 a4  .`p{a...`['MUT0.
  34d0: 60 14 13 42 50 4f 4c 01 70 68 44 42 50 4c 70 0a  `..BPOL.phDBPLp.
  34e0: 01 45 42 50 4c 08 45 43 55 53 0a 00 08 42 41 54  .EBPL.ECUS...BAT
  34f0: 4f 0a 00 08 42 41 54 4e 0a 00 08 42 41 54 46 0a  O...BATN...BATF.
  3500: c0 14 45 06 5f 51 30 39 00 a0 4c 04 93 87 5c 5f  ..E._Q09..L...\_
  3510: 4f 53 5f 0a 14 86 5c 2e 5f 53 42 5f 42 41 54 31  OS_...\._SB_BAT1
  3520: 0a 80 86 5c 2e 5f 53 42 5f 42 41 54 31 0a 00 86  ...\._SB_BAT1...
  3530: 5c 2e 5f 53 42 5f 42 41 54 32 0a 80 86 5c 2e 5f  \._SB_BAT2...\._
  3540: 53 42 5f 42 41 54 32 0a 00 86 5c 2e 5f 53 42 5f  SB_BAT2...\._SB_
  3550: 41 43 41 44 0a 00 a0 10 93 87 5c 5f 4f 53 5f 0a  ACAD......\_OS_.
  3560: 14 42 50 4f 4c 0a 3c 14 46 09 5f 51 32 30 00 a0  .BPOL.<.F._Q20..
  3570: 4e 08 7b 53 4d 53 54 0a 40 00 70 53 4d 41 41 60  N.{SMST.-xkUVAZ+L9Zg@public.gmane.org`
  3580: a0 4d 07 93 60 0a 14 53 45 4c 45 a0 16 7b 0a 40  .M..`..SELE..{.@
  3590: 42 41 54 46 00 86 5c 2e 5f 53 42 5f 42 41 54 31  BATF..\._SB_BAT1
  35a0: 0a 81 a0 16 7b 0a 80 42 41 54 46 00 86 5c 2e 5f  ....{..BATF..\._
  35b0: 53 42 5f 42 41 54 32 0a 81 a0 16 7b 0a 02 42 41  SB_BAT2....{..BA
  35c0: 54 46 00 86 5c 2e 5f 53 42 5f 41 43 41 44 0a 00  TF..\._SB_ACAD..
  35d0: 86 5c 2e 5f 53 42 5f 42 41 54 31 0a 80 86 5c 2e  .\._SB_BAT1...\.
  35e0: 5f 53 42 5f 42 41 54 32 0a 80 70 42 41 54 44 42  _SB_BAT2..pBATDB
  35f0: 41 54 4f 7b 53 4d 53 54 0a bf 53 4d 53 54 14 48  ATO{SMST..SMST.H
  3600: 11 53 45 4c 45 00 70 42 41 54 44 42 41 54 4e 70  .SELE.pBATDBATNp
  3610: 0a 00 42 41 54 46 a0 14 7b 0a c0 42 41 54 4e 00  ..BATF..{..BATN.
  3620: 7d 42 41 54 46 0a 01 42 41 54 46 a0 15 7b 0b 00  }BATF..BATF..{..
  3630: 03 42 41 54 4e 00 7d 42 41 54 46 0a 04 42 41 54  .BATN.}BATF..BAT
  3640: 46 7b 42 41 54 4e 0a 01 60 7b 42 41 54 4f 0a 01  F{BATN..`{BATO..
  3650: 61 a0 0e 60 7d 42 41 54 46 0b 00 01 42 41 54 46  a..`}BATF...BATF
  3660: a1 0d 7b 42 41 54 46 0b ff fe 42 41 54 46 a0 11  ..{BATF...BATF..
  3670: 80 93 60 61 00 7d 42 41 54 46 0a 40 42 41 54 46  ..`a.}BATF.-HxGJHaSneKA@public.gmane.org
  3680: 7b 42 41 54 4e 0a 02 60 7b 42 41 54 4f 0a 02 61  {BATN..`{BATO..a
  3690: a0 0e 60 7d 42 41 54 46 0b 00 02 42 41 54 46 a1  ..`}BATF...BATF.
  36a0: 0d 7b 42 41 54 46 0b ff fd 42 41 54 46 a0 11 80  .{BATF...BATF...
  36b0: 93 60 61 00 7d 42 41 54 46 0a 80 42 41 54 46 7b  .`a.}BATF..BATF{
  36c0: 42 41 54 4e 0a c0 60 7b 42 41 54 4f 0a c0 61 a0  BATN..`{BATO..a.
  36d0: 11 80 93 60 61 00 7d 42 41 54 46 0a 02 42 41 54  ...`a.}BATF..BAT
  36e0: 46 a0 35 7b 0a 01 42 41 54 46 00 a0 2b 7b 0a 04  F.5{..BATF..+{..
  36f0: 42 41 54 46 00 a0 14 7b 42 41 54 4e 0a 20 00 7d  BATF...{BATN. .}
  3700: 42 41 54 46 0a 10 42 41 54 46 a1 0c 7d 42 41 54  BATF..BATF..}BAT
  3710: 46 0a 20 42 41 54 46 14 31 5f 51 30 44 00 70 0d  F. BATF.1_Q0D.p.
  3720: 53 6c 65 65 70 20 42 75 74 74 6f 6e 20 51 75 65  Sleep Button Que
  3730: 72 79 3a 20 46 6e 2b 46 34 00 5b 31 86 5c 2e 5f  ry: Fn+F4.[1.\._
  3740: 53 42 5f 53 4c 50 42 0a 80 14 1d 5f 51 30 45 00  SB_SLPB...._Q0E.
  3750: 5c 2f 05 5f 53 42 5f 50 43 49 30 41 47 50 5f 56  \/._SB_PCI0AGP_V
  3760: 47 41 5f 53 57 49 48 14 2b 5f 51 30 46 00 70 0d  GA_SWIH.+_Q0F.p.
  3770: 44 69 73 70 6c 61 79 20 62 6c 61 6e 6b 3a 20 46  Display blank: F
  3780: 6e 2b 46 36 00 5b 31 80 4c 56 31 36 60 70 60 4c  n+F6.[1.LV16`p`L
  3790: 56 31 36 14 4c 04 5f 51 31 33 00 70 0d 42 72 69  V16.L._Q13.p.Bri
  37a0: 67 68 74 6e 65 73 73 20 55 70 3a 20 46 6e 2b 2d  ghtness Up: Fn+-
  37b0: 3e 00 5b 31 70 0a 8c 5c 2f 04 5f 53 42 5f 50 43  >.[1p..\/._SB_PC
  37c0: 49 30 4c 50 43 30 42 43 4d 44 70 0a 00 5c 2f 04  I0LPC0BCMDp..\/.
  37d0: 5f 53 42 5f 50 43 49 30 4c 50 43 30 53 4d 49 43  _SB_PCI0LPC0SMIC
  37e0: 14 4e 04 5f 51 31 32 00 70 0d 42 72 69 67 68 74  .N._Q12.p.Bright
  37f0: 6e 65 73 73 20 44 6f 77 6e 3a 20 46 6e 2b 3c 2d  ness Down: Fn+<-
  3800: 00 5b 31 70 0a 8d 5c 2f 04 5f 53 42 5f 50 43 49  .[1p..\/._SB_PCI
  3810: 30 4c 50 43 30 42 43 4d 44 70 0a 00 5c 2f 04 5f  0LPC0BCMDp..\/._
  3820: 53 42 5f 50 43 49 30 4c 50 43 30 53 4d 49 43 14  SB_PCI0LPC0SMIC.
  3830: 34 5f 51 38 30 00 70 0d 54 65 6d 70 65 72 61 74  4_Q80.p.Temperat
  3840: 75 72 65 20 69 6e 63 72 65 61 73 69 6e 67 3a 20  ure increasing: 
  3850: 5f 51 38 30 00 5b 31 86 5c 2e 5f 54 5a 5f 54 48  _Q80.[1.\._TZ_TH
  3860: 52 4d 0a 80 14 34 5f 51 38 31 00 70 0d 54 65 6d  RM...4_Q81.p.Tem
  3870: 70 65 72 61 74 75 72 65 20 64 65 63 72 65 61 73  perature decreas
  3880: 69 6e 67 3a 20 5f 51 38 31 00 5b 31 86 5c 2e 5f  ing: _Q81.[1.\._
  3890: 54 5a 5f 54 48 52 4d 0a 80 5b 02 45 4a 54 31 14  TZ_THRM..[.EJT1.
  38a0: 44 2d 5f 51 38 41 00 5b 01 4d 55 54 30 00 5b 01  D-_Q8A.[.MUT0.[.
  38b0: 4d 55 54 31 00 70 0d 2d 2d 2d 2d 2d 2d 2d 2d 2d  MUT1.p.---------
  38c0: 2d 2d 2d 2d 2d 2d 2d 2d 2d 5f 51 30 78 38 41 20  ---------_Q0x8A 
  38d0: 2d 2d 2d 2d 2d 2d 2d 2d 2d 2d 2d 2d 2d 2d 2d 2d  ----------------
  38e0: 2d 2d 2d 2d 2d 2d 2d 2d 2d 2d 2d 2d 2d 2d 2d 2d  ----------------
  38f0: 2d 2d 2d 2d 2d 2d 00 5b 31 a0 19 4c 49 44 45 70  ------.[1..LIDEp
  3900: 0a 01 4c 49 44 45 86 5c 2e 5f 53 42 5f 4c 49 44  ..LIDE.\._SB_LID
  3910: 5f 0a 80 a0 40 26 44 42 32 45 70 0d 2d 2d 2d 2d  _...@&DB2Ep.----
  3920: 2d 2d 2d 2d 20 44 65 76 69 63 65 20 52 2d 42 61  ---- Device R-Ba
  3930: 79 20 45 76 65 6e 74 20 2d 2d 2d 2d 2d 2d 00 5b  y Event ------.[
  3940: 31 70 0a 01 44 42 32 45 a0 4b 22 7d 93 5c 2f 03  1p..DB2E.K"}.\/.
  3950: 5f 53 42 5f 50 43 49 30 4d 59 4f 53 0a 01 93 5c  _SB_PCI0MYOS...\
  3960: 2f 03 5f 53 42 5f 50 43 49 30 4d 59 4f 53 0a 03  /._SB_PCI0MYOS..
  3970: 00 a0 44 18 44 42 32 53 70 0d 2d 2d 2d 2d 2d 2d  ..D.DB2Sp.------
  3980: 2d 2d 2d 2d 2d 20 44 65 76 69 63 65 20 42 61 79  ----- Device Bay
  3990: 20 43 68 61 6e 67 65 20 53 74 61 74 75 73 20 2d   Change Status -
  39a0: 2d 2d 2d 2d 2d 2d 2d 2d 2d 20 49 4e 20 00 5b 31  --------- IN .[1
  39b0: 70 5c 2f 04 5f 53 42 5f 50 43 49 30 4c 50 43 30  p\/._SB_PCI0LPC0
  39c0: 52 42 49 44 60 70 60 5c 2f 04 5f 53 42 5f 50 43  RBID`p`\/._SB_PC
  39d0: 49 30 49 44 45 30 42 41 59 52 a0 1b 93 60 0a 00  I0IDE0BAYR...`..
  39e0: 70 0a 00 5c 2f 04 5f 53 42 5f 50 43 49 30 4c 50  p..\/._SB_PCI0LP
  39f0: 43 30 4c 56 33 37 a1 4f 0f 70 0a 00 5c 2f 04 5f  C0LV37.O.p..\/._
  3a00: 53 42 5f 50 43 49 30 4c 50 43 30 4c 56 33 37 70  SB_PCI0LPC0LV37p
  3a10: 0a 00 5c 2f 04 5f 53 42 5f 50 43 49 30 4c 50 43  ..\/._SB_PCI0LPC
  3a20: 30 4c 56 33 39 5b 22 0a 32 70 0a 01 5c 2f 04 5f  0LV39[".2p..\/._
  3a30: 53 42 5f 50 43 49 30 4c 50 43 30 4c 56 33 39 5b  SB_PCI0LPC0LV39[
  3a40: 22 0b c4 09 70 0a 01 5c 2f 04 5f 53 42 5f 50 43  "...p..\/._SB_PC
  3a50: 49 30 49 44 45 30 53 53 49 47 70 0a 01 5c 2f 04  I0IDE0SSIGp..\/.
  3a60: 5f 53 42 5f 50 43 49 30 49 44 45 30 55 44 43 31  _SB_PCI0IDE0UDC1
  3a70: 70 0a 02 5c 2f 04 5f 53 42 5f 50 43 49 30 49 44  p..\/._SB_PCI0ID
  3a80: 45 30 55 44 54 31 7d 5c 2f 04 5f 53 42 5f 50 43  E0UDT1}\/._SB_PC
  3a90: 49 30 49 44 45 30 46 53 43 42 0a 04 5c 2f 04 5f  I0IDE0FSCB..\/._
  3aa0: 53 42 5f 50 43 49 30 49 44 45 30 46 53 43 42 70  SB_PCI0IDE0FSCBp
  3ab0: 0b 03 e3 5c 2f 04 5f 53 42 5f 50 43 49 30 49 44  ...\/._SB_PCI0ID
  3ac0: 45 30 49 54 4d 31 70 0a 00 5c 2f 04 5f 53 42 5f  E0ITM1p..\/._SB_
  3ad0: 50 43 49 30 49 44 45 30 53 53 49 47 86 5c 2f 05  PCI0IDE0SSIG.\/.
  3ae0: 5f 53 42 5f 50 43 49 30 49 44 45 30 53 45 43 4e  _SB_PCI0IDE0SECN
  3af0: 42 41 59 31 0a 00 a1 4d 07 70 0d 2d 2d 2d 2d 2d  BAY1...M.p.-----
  3b00: 2d 2d 2d 20 44 65 76 69 63 65 20 42 61 79 20 45  --- Device Bay E
  3b10: 76 65 6e 74 20 2d 2d 2d 2d 2d 2d 20 4f 55 54 20  vent ------ OUT 
  3b20: 00 5b 31 70 5c 2f 04 5f 53 42 5f 50 43 49 30 49  .[1p\/._SB_PCI0I
  3b30: 44 45 30 42 41 59 52 60 70 0a 01 5c 2f 04 5f 53  DE0BAYR`p..\/._S
  3b40: 42 5f 50 43 49 30 4c 50 43 30 4c 56 33 37 a0 25  B_PCI0LPC0LV37.%
  3b50: 7d 93 60 0a 01 93 60 0a 02 00 86 5c 2f 05 5f 53  }.`...`....\/._S
  3b60: 42 5f 50 43 49 30 49 44 45 30 53 45 43 4e 42 41  B_PCI0IDE0SECNBA
  3b70: 59 31 0a 01 5b 80 53 4d 49 30 01 0c 00 fe 00 00  Y1..[.SMI0......
  3b80: 0c 02 00 00 00 5b 81 0b 53 4d 49 30 00 53 4d 49  .....[..SMI0.SMI
  3b90: 43 08 5b 80 53 4d 49 31 00 0c bd be f7 1f 0c 90  C.[.SMI1........
  3ba0: 00 00 00 5b 81 16 53 4d 49 31 00 42 43 4d 44 08  ...[..SMI1.BCMD.
  3bb0: 44 49 44 5f 20 49 4e 46 4f 40 40 5b 81 10 53 4d  DID_ INFO@@[..SM
  3bc0: 49 31 00 01 01 00 00 28 49 4e 46 5f 08 5b 82 1b  I1.....(INF_.[..
  3bd0: 4d 44 4d 30 08 5f 41 44 52 0c 06 00 1f 00 08 5f  MDM0._ADR......_
  3be0: 50 52 57 12 06 02 0a 05 0a 03 5b 82 41 0d 48 55  PRW.......[.A.HU
  3bf0: 42 5f 08 5f 41 44 52 0c 00 00 1e 00 08 5f 50 52  B_._ADR......_PR
  3c00: 54 12 4e 09 05 12 1e 04 0c ff ff 02 00 0a 00 5c  T.N............\
  3c10: 2f 04 5f 53 42 5f 50 43 49 30 4c 50 43 30 4c 4e  /._SB_PCI0LPC0LN
  3c20: 4b 44 0a 00 12 1e 04 0c ff ff 04 00 0a 00 5c 2f  KD............\/
  3c30: 04 5f 53 42 5f 50 43 49 30 4c 50 43 30 4c 4e 4b  ._SB_PCI0LPC0LNK
  3c40: 45 0a 00 12 1e 04 0c ff ff 04 00 0a 01 5c 2f 04  E............\/.
  3c50: 5f 53 42 5f 50 43 49 30 4c 50 43 30 4c 4e 4b 46  _SB_PCI0LPC0LNKF
  3c60: 0a 00 12 1e 04 0c ff ff 06 00 0a 00 5c 2f 04 5f  ............\/._
  3c70: 53 42 5f 50 43 49 30 4c 50 43 30 4c 4e 4b 42 0a  SB_PCI0LPC0LNKB.
  3c80: 00 12 1e 04 0c ff ff 07 00 0a 00 5c 2f 04 5f 53  ...........\/._S
  3c90: 42 5f 50 43 49 30 4c 50 43 30 4c 4e 4b 43 0a 00  B_PCI0LPC0LNKC..
  3ca0: 5b 82 1b 47 4c 41 4e 08 5f 41 44 52 0c 00 00 02  [..GLAN._ADR....
  3cb0: 00 08 5f 50 52 57 12 06 02 0a 0b 0a 05 5b 82 80  .._PRW.......[..
  3cc0: 13 01 49 44 45 30 08 5f 41 44 52 0c 01 00 1f 00  ..IDE0._ADR.....
  3cd0: 5b 80 50 43 49 5f 02 0a 00 0a 58 5b 81 44 04 50  [.PCI_....X[.D.P
  3ce0: 43 49 5f 03 00 18 00 07 53 49 44 45 01 00 40 1f  CI_.....SIDE..-4b8TPpkIZ3Q@public.gmane.org
  3cf0: 00 01 45 49 4f 52 01 00 0d 45 53 49 44 01 00 20  ..EIOR...ESID.. 
  3d00: 55 4d 41 30 01 55 4d 41 31 01 55 4d 41 32 01 55  UMA0.UMA1.UMA2.U
  3d10: 4d 41 33 01 00 4c 06 50 53 49 47 02 53 53 49 47  MA3..L.PSIG.SSIG
  3d20: 02 5b 81 45 06 50 43 49 5f 03 00 40 20 49 54 4d  .[.E.PCI_..@ ITM
  3d30: 30 10 49 54 4d 31 10 53 49 54 30 04 53 49 54 31  0.ITM1.SIT0.SIT1
  3d40: 04 00 18 55 44 43 30 02 55 44 43 31 02 00 0c 55  ...UDC0.UDC1...U
  3d50: 44 54 30 08 55 44 54 31 08 00 40 04 49 43 46 30  DT0.UDT1..-SIL8ziia6V0@public.gmane.org
  3d60: 02 49 43 46 31 02 43 42 38 30 04 00 02 57 50 50  .ICF1.CB80...WPP
  3d70: 45 01 00 01 46 53 43 42 04 54 52 49 50 02 54 52  E...FSCB.TRIP.TR
  3d80: 49 53 02 46 41 54 53 04 08 54 49 4d 30 12 11 01  IS.FATS..TIM0...
  3d90: 12 0e 05 0a 78 0a b4 0a f0 0b 86 01 0b 58 02 08  ....x........X..
  3da0: 54 49 4d 31 12 0c 01 12 09 03 0a 78 0a 96 0b fe  TIM1.......x....
  3db0: 01 08 54 49 4d 32 12 11 01 12 0e 06 0a 18 0a 1e  ..TIM2..........
  3dc0: 0a 2d 0a 3c 0a 5a 0a 78 08 41 54 30 31 11 0a 0a  .-.<.Z.x.AT01...
  3dd0: 07 03 00 00 00 00 00 ef 08 41 54 30 32 11 0a 0a  .........AT02...
  3de0: 07 00 00 00 00 00 00 90 08 41 54 30 33 11 0a 0a  .........AT03...
  3df0: 07 00 00 00 00 00 00 c6 08 41 54 30 34 11 0a 0a  .........AT04...
  3e00: 07 00 00 00 00 00 00 91 08 41 54 41 30 11 03 0a  .........ATA0...
  3e10: 1d 08 41 54 41 31 11 03 0a 1d 08 41 54 41 32 11  ..ATA1.....ATA2.
  3e20: 03 0a 1d 08 41 54 41 33 11 03 0a 1d 08 41 54 41  ....ATA3.....ATA
  3e30: 42 11 03 0a 0e 08 43 4d 44 43 0a 00 08 42 41 59  B.....CMDC...BAY
  3e40: 52 0a 00 14 1e 5f 49 4e 49 00 70 5c 2f 04 5f 53  R...._INI.p\/._S
  3e50: 42 5f 50 43 49 30 4c 50 43 30 52 42 49 44 42 41  B_PCI0LPC0RBIDBA
  3e60: 59 52 14 47 05 47 54 46 42 0b 77 43 4d 44 43 0a  YR.G.GTFB.wCMDC.
  3e70: 38 60 5b 13 41 54 41 42 60 0a 38 43 4d 44 58 77  8`[.ATAB`.8CMDXw
  3e80: 43 4d 44 43 0a 07 60 8c 41 54 41 42 72 60 0a 01  CMDC..`.ATABr`..
  3e90: 00 41 30 30 31 8c 41 54 41 42 72 60 0a 05 00 41  .A001.ATABr`...A
  3ea0: 30 30 35 70 68 43 4d 44 58 70 69 41 30 30 31 70  005phCMDXpiA001p
  3eb0: 6a 41 30 30 35 75 43 4d 44 43 5b 01 47 54 46 4d  jA005uCMDC[.GTFM
  3ec0: 00 14 4e 20 47 54 46 5f 0b 5b 23 47 54 46 4d ff  ..N GTF_.[#GTFM.
  3ed0: ff 8a 6a 0a 00 50 49 4f 30 8a 6a 0a 04 44 4d 41  ..j..PIO0.j..DMA
  3ee0: 30 8a 6a 0a 08 50 49 4f 31 8a 6a 0a 0c 44 4d 41  0.j..PIO1.j..DMA
  3ef0: 31 8a 6a 0a 10 43 48 4e 46 70 0a 00 43 4d 44 43  1.j..CHNFp..CMDC
  3f00: 08 49 44 30 30 0a 80 08 49 44 34 39 0b 00 0c 08  .ID00...ID49....
  3f10: 49 44 35 39 0a 00 08 49 44 35 33 0a 04 08 49 44  ID59...ID53...ID
  3f20: 36 33 0b 00 0f 08 49 44 38 38 0b 00 0f 08 49 52  63....ID88....IR
  3f30: 44 59 0a 01 08 50 49 4f 54 0a 00 08 44 4d 41 54  DY...PIOT...DMAT
  3f40: 0a 00 a0 4e 06 93 87 69 0b 00 02 8c 69 0a 00 49  ...N...i....i..I
  3f50: 42 30 30 70 49 42 30 30 49 44 30 30 8b 69 0a 62  B00pIB00ID00.i.b
  3f60: 49 57 34 39 70 49 57 34 39 49 44 34 39 8b 69 0a  IW49pIW49ID49.i.
  3f70: 6a 49 57 35 33 70 49 57 35 33 49 44 35 33 8b 69  jIW53pIW53ID53.i
  3f80: 0a 7e 49 57 36 33 70 49 57 36 33 49 44 36 33 8b  .~IW63pIW63ID63.
  3f90: 69 0a 76 49 57 35 39 70 49 57 35 39 49 44 35 39  i.vIW59pIW59ID59
  3fa0: 8b 69 0a b0 49 57 38 38 70 49 57 38 38 49 44 38  .i..IW88pIW88ID8
  3fb0: 38 a1 06 a4 41 54 41 42 70 0a a0 67 a0 48 05 68  8...ATABp..g.H.h
  3fc0: 70 0a b0 67 7b 43 48 4e 46 0a 08 49 52 44 59 a0  p..g{CHNF..IRDY.
  3fd0: 12 7b 43 48 4e 46 0a 10 00 70 50 49 4f 31 50 49  .{CHNF...pPIO1PI
  3fe0: 4f 54 a1 0a 70 50 49 4f 30 50 49 4f 54 a0 27 7b  OT..pPIO0PIOT.'{
  3ff0: 43 48 4e 46 0a 04 00 a0 12 7b 43 48 4e 46 0a 10  CHNF.....{CHNF..
  4000: 00 70 44 4d 41 31 44 4d 41 54 a1 0a 70 44 4d 41  .pDMA1DMAT..pDMA
  4010: 30 44 4d 41 54 a1 28 7b 43 48 4e 46 0a 02 49 52  0DMAT.({CHNF..IR
  4020: 44 59 70 50 49 4f 30 50 49 4f 54 a0 12 7b 43 48  DYpPIO0PIOT..{CH
  4030: 4e 46 0a 01 00 70 44 4d 41 30 44 4d 41 54 a0 36  NF...pDMA0DMAT.6
  4040: 90 7b 49 44 35 33 0a 04 00 7b 49 44 38 38 0a ff  .{ID53...{ID88..
  4050: 00 70 0a 00 61 7b 49 44 38 38 0a ff 62 a2 07 7a  .p..a{ID88..b..z
  4060: 62 61 00 75 61 76 61 47 54 46 42 41 54 30 31 7d  ba.uavaGTFBAT01}
  4070: 0a 40 61 00 67 a0 37 49 52 44 59 70 89 83 88 54  .-fhlHQWb3e5F47cB+lvyzyw@public.gmane.org
  4080: 49 4d 30 0a 00 00 04 50 49 4f 54 00 0a 00 0a 00  IM0....PIOT.....
  4090: 61 a0 08 93 61 ff 70 0a 04 61 74 0a 04 61 61 47  a...a.p..at..aaG
  40a0: 54 46 42 41 54 30 31 7d 0a 08 61 00 67 a1 17 a0  TFBAT01}..a.g...
  40b0: 15 7b 49 44 34 39 0b 00 04 00 47 54 46 42 41 54  .{ID49....GTFBAT
  40c0: 30 31 0a 01 67 5b 27 47 54 46 4d a4 41 54 41 42  01..g['GTFM.ATAB
  40d0: 14 25 52 41 54 41 01 8c 68 0a 00 43 4d 44 4e 77  .%RATA..h..CMDNw
  40e0: 43 4d 44 4e 0a 38 60 5b 13 68 0a 08 60 52 45 54  CMDN.8`[.h..`RET
  40f0: 42 a4 52 45 54 42 08 52 45 47 46 0a 01 14 12 5f  B.RETB.REGF...._
  4100: 52 45 47 02 a0 0b 93 68 0a 02 70 69 52 45 47 46  REG....h..piREGF
  4110: 08 42 41 59 44 0a 00 14 09 5f 53 54 41 00 a4 0a  .BAYD...._STA...
  4120: 0f 14 48 1b 47 54 4d 5f 06 70 11 03 0a 14 60 8a  ..H.GTM_.p....`.
  4130: 60 0a 00 50 49 4f 30 8a 60 0a 04 44 4d 41 30 8a  `..PIO0.`..DMA0.
  4140: 60 0a 08 50 49 4f 31 8a 60 0a 0c 44 4d 41 31 8a  `..PIO1.`..DMA1.
  4150: 60 0a 10 46 4c 41 47 a0 15 91 7b 68 0a 08 00 92  `..FLAG...{h....
  4160: 7b 68 0a 01 00 70 0b 84 03 50 49 4f 30 a1 23 72  {h...p...PIO0.#r
  4170: 7a 7b 68 0b 00 03 00 0a 08 00 7a 7b 68 0b 00 30  z{h.......z{h..0
  4180: 00 0a 0c 00 61 77 74 0a 09 61 00 0a 1e 50 49 4f  ....awt..a...PIO
  4190: 30 a0 3b 7b 68 0b 00 40 00 a0 15 91 7b 68 0a 80  0.;{h..-9D9NNryygCw@public.gmane.org{h..
  41a0: 00 92 7b 68 0a 10 00 70 0b 84 03 50 49 4f 31 a1  ..{h...p...PIO1.
  41b0: 1d 72 7b 69 0a 03 00 7a 7b 69 0a 0c 00 0a 02 00  .r{i...z{i......
  41c0: 61 77 74 0a 09 61 00 0a 1e 50 49 4f 31 a1 0a 70  awt..a...PIO1..p
  41d0: 50 49 4f 30 50 49 4f 31 a0 38 7b 6a 0a 01 00 a0  PIO0PIO1.8{j....
  41e0: 0d 7b 6d 0a 01 00 70 0a 08 44 4d 41 30 a1 23 74  .{m...p..DMA0.#t
  41f0: 0a 04 7b 6b 0a 03 00 61 a0 0e 7b 6c 0a 01 00 77  ..{k...a..{l...w
  4200: 61 0a 0f 44 4d 41 30 a1 09 77 61 0a 1e 44 4d 41  a..DMA0..wa..DMA
  4210: 30 a1 0a 70 50 49 4f 30 44 4d 41 30 a0 40 05 7b  0..pPIO0DMA0.-4b8TPpkIZ3Q@public.gmane.org{
  4220: 68 0b 00 40 00 a0 3c 7b 6a 0a 02 00 a0 0d 7b 6d  h..-rVxdn2TrCWA@public.gmane.org<{j.....{m
  4230: 0a 02 00 70 0a 08 44 4d 41 31 a1 27 74 0a 04 7a  ...p..DMA1.'t..z
  4240: 7b 6b 0a 30 00 0a 04 00 61 a0 0e 7b 6c 0a 02 00  {k.0....a..{l...
  4250: 77 61 0a 0f 44 4d 41 31 a1 09 77 61 0a 1e 44 4d  wa..DMA1..wa..DM
  4260: 41 31 a1 0a 70 50 49 4f 31 44 4d 41 31 a1 0a 70  A1..pPIO1DMA1..p
  4270: 44 4d 41 30 44 4d 41 31 70 00 46 4c 41 47 a0 11  DMA0DMA1p.FLAG..
  4280: 7b 68 0a 01 00 7d 46 4c 41 47 0a 10 46 4c 41 47  {h...}FLAG..FLAG
  4290: a0 11 7b 6a 0a 01 00 7d 46 4c 41 47 0a 01 46 4c  ..{j...}FLAG..FL
  42a0: 41 47 a0 11 7b 68 0a 02 00 7d 46 4c 41 47 0a 02  AG..{h...}FLAG..
  42b0: 46 4c 41 47 a0 11 7b 6a 0a 02 00 7d 46 4c 41 47  FLAG..{j...}FLAG
  42c0: 0a 04 46 4c 41 47 a0 11 7b 68 0a 20 00 7d 46 4c  ..FLAG..{h. .}FL
  42d0: 41 47 0a 08 46 4c 41 47 a4 60 14 41 52 53 54 4d  AG..FLAG.`.ARSTM
  42e0: 53 03 70 11 03 0a 18 67 8a 67 0a 00 49 54 4d 5f  S.p....g.g..ITM_
  42f0: 8a 67 0a 04 53 49 54 5f 8a 67 0a 08 55 44 43 5f  .g..SIT_.g..UDC_
  4300: 8a 67 0a 0c 55 44 54 5f 8a 67 0a 10 49 43 46 5f  .g..UDT_.g..ICF_
  4310: 8a 67 0a 14 41 31 30 30 70 0a 01 57 50 50 45 8a  .g..A100p..WPPE.
  4320: 68 0a 00 50 49 4f 30 8a 68 0a 04 44 4d 41 30 8a  h..PIO0.h..DMA0.
  4330: 68 0a 08 50 49 4f 31 8a 68 0a 0c 44 4d 41 31 8a  h..PIO1.h..DMA1.
  4340: 68 0a 10 46 4c 41 47 70 46 4c 41 47 64 70 0b 00  h..FLAGpFLAGdp..
  4350: 40 60 08 57 34 39 4d 0a 00 08 57 35 33 4d 0a 00  @`.W49M...W53M..
  4360: 08 57 36 32 4d 0a 00 08 57 36 34 4d 0a 00 08 57  .W62M...W64M...W
  4370: 38 38 4d 0a 00 a0 41 08 93 87 69 0b 00 02 8a 69  88M...A...i....i
  4380: 0a 00 57 30 30 41 8a 69 0a 62 57 34 39 41 8a 69  ..W00A.i.bW49A.i
  4390: 0a 6a 57 35 33 41 8a 69 0a 7c 57 36 32 41 8a 69  .jW53A.i.|W62A.i
  43a0: 0a 80 57 36 34 41 8a 69 0a b0 57 38 38 41 70 57  ..W64A.i..W88ApW
  43b0: 34 39 41 57 34 39 4d 70 57 35 33 41 57 35 33 4d  49AW49MpW53AW53M
  43c0: 70 57 36 32 41 57 36 32 4d 70 57 36 34 41 57 36  pW62AW62MpW64AW6
  43d0: 34 4d 70 57 38 38 41 57 38 38 4d a0 0b 57 30 30  4MpW88AW88M..W00
  43e0: 41 7d 60 0b 00 80 60 a0 0f 92 7b 57 30 30 41 0a  A}`...`...{W00A.
  43f0: 80 00 7d 60 0a 04 60 a1 24 70 0a 00 57 34 39 4d  ..}`..`.$p..W49M
  4400: 70 0a 00 57 35 33 4d 70 0a 00 57 36 32 4d 70 0a  p..W53Mp..W62Mp.
  4410: 00 57 36 34 4d 70 0a 00 57 38 38 4d 08 57 34 39  .W64Mp..W88M.W49
  4420: 53 0a 00 08 57 35 33 53 0a 00 08 57 36 32 53 0a  S...W53S...W62S.
  4430: 00 08 57 36 34 53 0a 00 08 57 38 38 53 0a 00 a0  ..W64S...W88S...
  4440: 41 08 93 87 6a 0b 00 02 8a 6a 0a 00 57 30 30 42  A...j....j..W00B
  4450: 8a 6a 0a 62 57 34 39 42 8a 6a 0a 6a 57 35 33 42  .j.bW49B.j.jW53B
  4460: 8a 6a 0a 7c 57 36 32 42 8a 6a 0a 80 57 36 34 42  .j.|W62B.j..W64B
  4470: 8a 6a 0a b0 57 38 38 42 70 57 34 39 42 57 34 39  .j..W88BpW49BW49
  4480: 53 70 57 35 33 42 57 35 33 53 70 57 36 32 42 57  SpW53BW53SpW62BW
  4490: 36 32 53 70 57 36 34 42 57 36 34 53 70 57 38 38  62SpW64BW64SpW88
  44a0: 42 57 38 38 53 a0 0b 57 30 30 42 7d 60 0b 00 80  BW88S..W00B}`...
  44b0: 60 a0 0f 92 7b 57 30 30 42 0a 80 00 7d 60 0a 40  `...{W00B...}`.@
  44c0: 60 a1 24 70 0a 00 57 34 39 53 70 0a 00 57 35 33  `.$p..W49Sp..W53
  44d0: 53 70 0a 00 57 36 32 53 70 0a 00 57 36 34 53 70  Sp..W62Sp..W64Sp
  44e0: 0a 00 57 38 38 53 70 0a 00 41 31 30 30 a0 40 05  ..W88Sp..A100.-4b8TPpkIZ3Q@public.gmane.org
  44f0: 7b 0a 38 57 38 38 4d 00 a0 1e 7b 0a 20 57 38 38  {.8W88M...{. W88
  4500: 4d 00 70 0a 08 44 4d 41 30 7d 41 31 30 30 0c 10  M.p..DMA0}A100..
  4510: 00 10 00 41 31 30 30 a1 26 a0 1b 7b 0a 10 57 38  ...A100.&..{..W8
  4520: 38 4d 00 70 0a 1e 44 4d 41 30 7d 41 31 30 30 0a  8M.p..DMA0}A100.
  4530: 10 41 31 30 30 a1 08 70 0a 2d 44 4d 41 30 a1 46  .A100..p.-DMA0.F
  4540: 04 a0 43 04 7b 0a 07 57 38 38 4d 00 7d 0b 00 01  ..C.{..W88M.}...
  4550: 41 31 30 30 41 31 30 30 a0 10 7b 0a 04 57 38 38  A100A100..{..W88
  4560: 4d 00 70 0a 3c 44 4d 41 30 a1 1b a0 10 7b 0a 02  M.p.<DMA0....{..
  4570: 57 38 38 4d 00 70 0a 5a 44 4d 41 30 a1 08 70 0a  W88M.p.ZDMA0..p.
  4580: 78 44 4d 41 30 a0 40 05 7b 0a 3f 57 38 38 53 00  xDMA0.-4b8TPpkIZ3Q@public.gmane.org{.?W88S.
  4590: a0 1e 7b 0a 20 57 38 38 53 00 70 0a 08 44 4d 41  ..{. W88S.p..DMA
  45a0: 31 7d 41 31 30 30 0c 20 00 20 00 41 31 30 30 a1  1}A100. . .A100.
  45b0: 26 a0 1b 7b 0a 10 57 38 38 53 00 70 0a 1e 44 4d  &..{..W88S.p..DM
  45c0: 41 31 7d 41 31 30 30 0a 20 41 31 30 30 a1 08 70  A1}A100. A100..p
  45d0: 0a 2d 44 4d 41 31 a0 15 90 7b 57 34 39 4d 0b 00  .-DMA1...{W49M..
  45e0: 08 00 7b 64 0a 02 00 7d 60 0a 02 60 a0 0e 95 50  ..{d...}`..`...P
  45f0: 49 4f 30 0b 84 03 7d 60 0a 01 60 a0 15 90 7b 57  IO0...}`..`...{W
  4600: 34 39 53 0b 00 08 00 7b 64 0a 08 00 7d 60 0a 20  49S....{d...}`. 
  4610: 60 a0 0e 95 50 49 4f 31 0b 84 03 7d 60 0a 10 60  `...PIO1...}`..`
  4620: a0 0c 7b 64 0a 01 00 70 50 49 4f 30 61 a1 07 70  ..{d...pPIO0a..p
  4630: 44 4d 41 30 61 a0 0b 92 95 61 0a f0 7d 60 0a 08  DMA0a....a..}`..
  4640: 60 a1 42 04 a0 37 7b 57 35 33 4d 0a 02 00 a0 15  `.B..7{W53M.....
  4650: 90 7b 57 36 34 4d 0a 02 00 92 94 61 0a 78 7d 60  .{W64M.....a.x}`
  4660: 0b 01 23 60 a1 17 a0 15 90 7b 57 36 34 4d 0a 01  ..#`.....{W64M..
  4670: 00 92 94 61 0a b4 7d 60 0b 01 21 60 a1 07 7d 60  ...a..}`..!`..}`
  4680: 0b 01 10 60 70 60 49 54 4d 5f 70 00 60 a0 0c 7b  ...`p`ITM_p.`..{
  4690: 64 0a 04 00 70 50 49 4f 31 61 a1 07 70 44 4d 41  d...pPIO1a..pDMA
  46a0: 31 61 a0 41 06 7b 64 0a 10 00 a0 11 92 95 61 0a  1a.A.{d.......a.
  46b0: f0 7d 0a 80 49 54 4d 5f 49 54 4d 5f a1 47 04 7d  .}..ITM_ITM_.G.}
  46c0: 0a 10 49 54 4d 5f 49 54 4d 5f a0 33 7b 57 35 33  ..ITM_ITM_.3{W53
  46d0: 53 0a 02 00 a0 13 90 7b 57 36 34 53 0a 02 00 92  S......{W64S....
  46e0: 94 61 0a 78 70 0a 0b 60 a1 15 a0 13 90 7b 57 36  .a.xp..`.....{W6
  46f0: 34 53 0a 01 00 92 94 61 0a b4 70 0a 09 60 a1 05  4S.....a..p..`..
  4700: 70 0a 04 60 70 60 53 49 54 5f 70 0a 00 60 a0 14  p..`p`SIT_p..`..
  4710: 90 7b 0a 3f 57 38 38 4d 00 7b 64 0a 01 00 7d 60  .{.?W88M.{d...}`
  4720: 0a 01 60 a0 0b 7b 64 0a 04 00 7d 60 0a 02 60 70  ..`..{d...}`..`p
  4730: 60 55 44 43 5f 70 0a 00 60 a0 45 04 7b 64 0a 01  `UDC_p..`.E.{d..
  4740: 00 a0 19 95 44 4d 41 30 0a 1e 7d 41 31 30 30 0b  ....DMA0..}A100.
  4750: 00 10 41 31 30 30 7d 60 0a 01 60 a1 23 a0 11 95  ..A100}`..`.#...
  4760: 44 4d 41 30 0a 3c 78 44 4d 41 30 0a 0f 00 61 a1  DMA0.<xDMA0...a.
  4770: 0a 78 44 4d 41 30 0a 1e 00 61 74 0a 04 61 60 a0  .xDMA0...at..a`.
  4780: 4e 04 7b 64 0a 04 00 a0 19 95 44 4d 41 31 0a 1e  N.{d......DMA1..
  4790: 7d 41 31 30 30 0b 00 20 41 31 30 30 7d 60 0a 10  }A100.. A100}`..
  47a0: 60 a1 2c a0 11 95 44 4d 41 31 0a 3c 78 44 4d 41  `.,...DMA1.<xDMA
  47b0: 31 0a 0f 00 61 a1 0a 78 44 4d 41 31 0a 1e 00 61  1...a..xDMA1...a
  47c0: 74 0a 04 61 61 79 61 0a 04 61 7d 60 61 60 70 60  t..aaya..a}`a`p`
  47d0: 55 44 54 5f 70 0a 00 60 a0 0d 95 44 4d 41 30 0a  UDT_p..`...DMA0.
  47e0: 3c 7d 60 0a 01 60 a0 0d 95 44 4d 41 31 0a 3c 7d  <}`..`...DMA1.<}
  47f0: 60 0a 02 60 70 60 49 43 46 5f a4 67 14 49 0f 47  `..`p`ICF_.g.I.G
  4800: 54 46 30 07 70 11 0a 0a 07 03 00 00 00 00 a0 ef  TF0.p...........
  4810: 67 8c 67 0a 01 4d 4f 44 45 a0 2f 7b 6a 0a 01 00  g.g..MODE./{j...
  4820: a0 0d 7b 6e 0a 01 00 70 0a 45 4d 4f 44 45 a1 1a  ..{n...p.EMODE..
  4830: 7b 6b 0a 03 60 a0 0b 7b 6c 0a 01 00 72 60 0a 02  {k..`..{l...r`..
  4840: 60 7d 60 0a 40 4d 4f 44 45 a1 3e 72 7a 7b 68 0b  `}`.-fuMFxJv2sy8@public.gmane.org>rz{h.
  4850: 00 03 00 0a 08 00 7a 7b 68 0b 00 30 00 0a 0c 00  ......z{h..0....
  4860: 60 a0 0d 92 95 60 0a 05 70 0a 22 4d 4f 44 45 a1  `....`..p."MODE.
  4870: 18 a0 0d 92 95 60 0a 03 70 0a 21 4d 4f 44 45 a1  .....`..p.!MODE.
  4880: 08 70 0a 20 4d 4f 44 45 73 67 67 66 a0 24 91 7b  .p. MODEsggf.$.{
  4890: 68 0a 08 00 92 7b 68 0a 01 00 a0 0d 7b 68 0a 02  h....{h.....{h..
  48a0: 00 70 0a 00 4d 4f 44 45 a1 08 70 0a 08 4d 4f 44  .p..MODE..p..MOD
  48b0: 45 a1 3e 72 7a 7b 68 0b 00 03 00 0a 08 00 7a 7b  E.>rz{h.......z{
  48c0: 68 0b 00 30 00 0a 0c 00 60 a0 0d 92 95 60 0a 05  h..0....`....`..
  48d0: 70 0a 0c 4d 4f 44 45 a1 18 a0 0d 92 95 60 0a 03  p..MODE......`..
  48e0: 70 0a 0b 4d 4f 44 45 a1 08 70 0a 0a 4d 4f 44 45  p..MODE..p..MODE
  48f0: 73 66 67 65 a4 65 08 42 30 34 5f 11 03 0a 04 08  sfge.e.B04_.....
  4900: 42 32 30 5f 11 03 0a 04 08 42 34 30 5f 11 03 0a  B20_.....B40_...
  4910: 04 5b 82 4f 17 50 52 49 4d 08 5f 41 44 52 0a 00  .[.O.PRIM._ADR..
  4920: 08 5f 50 53 43 0a 00 14 0d 5f 50 53 30 00 70 0a  ._PSC...._PS0.p.
  4930: 00 5f 50 53 43 14 0d 5f 50 53 33 00 70 0a 03 5f  ._PSC.._PS3.p.._
  4940: 50 53 43 14 3b 5f 47 54 4d 00 70 11 04 0a 14 00  PSC.;_GTM.p.....
  4950: 60 70 5e 5e 47 54 4d 5f 5e 5e 49 54 4d 30 5e 5e  `p^^GTM_^^ITM0^^
  4960: 53 49 54 30 5e 5e 55 44 43 30 5e 5e 55 44 54 30  SIT0^^UDC0^^UDT0
  4970: 5e 5e 49 43 46 30 5e 5e 46 53 43 42 60 a4 60 14  ^^ICF0^^FSCB`.`.
  4980: 4e 0e 5f 53 54 4d 03 70 47 54 46 5f 0a 00 69 68  N._STM.pGTF_..ih
  4990: 41 54 41 30 70 47 54 46 5f 0a 01 6a 68 41 54 41  ATA0pGTF_..jhATA
  49a0: 31 70 5e 5e 53 54 4d 53 68 69 6a 60 8a 60 0a 00  1p^^STMShij`.`..
  49b0: 49 54 4d 5f 8a 60 0a 04 53 49 54 5f 8a 60 0a 08  ITM_.`..SIT_.`..
  49c0: 55 44 43 5f 8a 60 0a 0c 55 44 54 5f 8a 60 0a 10  UDC_.`..UDT_.`..
  49d0: 49 43 46 5f 70 49 54 4d 5f 5e 5e 49 54 4d 30 70  ICF_pITM_^^ITM0p
  49e0: 53 49 54 5f 5e 5e 53 49 54 30 70 55 44 43 5f 5e  SIT_^^SIT0pUDC_^
  49f0: 5e 55 44 43 30 70 55 44 54 5f 5e 5e 55 44 54 30  ^UDC0pUDT_^^UDT0
  4a00: 8a 60 0a 14 41 31 30 30 7d 7b 5e 5e 43 42 38 30  .`..A100}{^^CB80
  4a10: 0a 0c 00 7a 7b 0a 30 41 31 30 30 00 0a 04 00 5e  ...z{.0A100....^
  4a20: 5e 43 42 38 30 7d 7b 5e 5e 46 53 43 42 0a 0c 00  ^CB80}{^^FSCB...
  4a30: 7a 7b 0b 00 30 41 31 30 30 00 0a 0c 00 5e 5e 46  z{..0A100....^^F
  4a40: 53 43 42 7d 7b 5e 5e 46 41 54 53 0a 0c 00 7a 7b  SCB}{^^FATS...z{
  4a50: 0c 00 00 30 00 41 31 30 30 00 0a 14 00 5e 5e 46  ...0.A100....^^F
  4a60: 41 54 53 70 49 43 46 5f 5e 5e 49 43 46 30 5b 82  ATSpICF_^^ICF0[.
  4a70: 22 4d 41 53 54 08 5f 41 44 52 0a 00 08 48 31 35  "MAST._ADR...H15
  4a80: 46 00 14 0f 5f 47 54 46 00 a4 52 41 54 41 41 54  F..._GTF..RATAAT
  4a90: 41 30 5b 82 42 2f 53 45 43 4e 08 5f 41 44 52 0a  A0[.B/SECN._ADR.
  4aa0: 01 08 46 41 53 54 0a 63 14 14 5f 53 54 41 00 a0  ..FAST.c.._STA..
  4ab0: 08 45 53 49 44 a4 0a 0f a1 04 a4 0a 08 08 5f 50  .ESID........._P
  4ac0: 53 43 0a 00 14 0d 5f 50 53 30 00 70 0a 00 5f 50  SC...._PS0.p.._P
  4ad0: 53 43 14 0d 5f 50 53 33 00 70 0a 03 5f 50 53 43  SC.._PS3.p.._PSC
  4ae0: 14 44 04 5f 47 54 4d 00 70 11 04 0a 14 00 60 70  .D._GTM.p.....`p
  4af0: 5e 5e 46 53 43 42 61 7a 61 0a 02 61 70 5e 5e 47  ^^FSCBaza..ap^^G
  4b00: 54 4d 5f 5e 5e 49 54 4d 31 5e 5e 53 49 54 31 5e  TM_^^ITM1^^SIT1^
  4b10: 5e 55 44 43 31 5e 5e 55 44 54 31 5e 5e 49 43 46  ^UDC1^^UDT1^^ICF
  4b20: 31 61 60 a4 60 14 4e 0e 5f 53 54 4d 03 70 47 54  1a`.`.N._STM.pGT
  4b30: 46 5f 0a 00 69 68 41 54 41 32 70 47 54 46 5f 0a  F_..ihATA2pGTF_.
  4b40: 01 6a 68 41 54 41 33 70 5e 5e 53 54 4d 53 68 69  .jhATA3p^^STMShi
  4b50: 6a 60 8a 60 0a 00 49 54 4d 5f 8a 60 0a 04 53 49  j`.`..ITM_.`..SI
  4b60: 54 5f 8a 60 0a 08 55 44 43 5f 8a 60 0a 0c 55 44  T_.`..UDC_.`..UD
  4b70: 54 5f 8a 60 0a 10 49 43 46 5f 70 49 54 4d 5f 5e  T_.`..ICF_pITM_^
  4b80: 5e 49 54 4d 31 70 53 49 54 5f 5e 5e 53 49 54 31  ^ITM1pSIT_^^SIT1
  4b90: 70 55 44 43 5f 5e 5e 55 44 43 31 70 55 44 54 5f  pUDC_^^UDC1pUDT_
  4ba0: 5e 5e 55 44 54 31 8a 60 0a 14 41 31 30 30 7d 7b  ^^UDT1.`..A100}{
  4bb0: 5e 5e 43 42 38 30 0a 03 00 7a 7b 0a 30 41 31 30  ^^CB80...z{.0A10
  4bc0: 30 00 0a 02 00 5e 5e 43 42 38 30 7d 7b 5e 5e 46  0....^^CB80}{^^F
  4bd0: 53 43 42 0a 03 00 7a 7b 0b 00 30 41 31 30 30 00  SCB...z{..0A100.
  4be0: 0a 0a 00 5e 5e 46 53 43 42 7d 7b 5e 5e 46 41 54  ...^^FSCB}{^^FAT
  4bf0: 53 0a 03 00 7a 7b 0c 00 00 30 00 41 31 30 30 00  S...z{...0.A100.
  4c00: 0a 12 00 5e 5e 46 41 54 53 70 49 43 46 5f 5e 5e  ...^^FATSpICF_^^
  4c10: 49 43 46 31 5b 82 4b 11 42 41 59 31 08 5f 41 44  ICF1[.K.BAY1._AD
  4c20: 52 0a 00 08 48 31 35 46 00 08 45 4a 30 46 0a 00  R...H15F..EJ0F..
  4c30: 14 0f 5f 47 54 46 00 a4 52 41 54 41 41 54 41 32  .._GTF..RATAATA2
  4c40: 14 4f 09 5f 53 54 41 00 a0 42 09 5c 2f 04 5f 53  .O._STA..B.\/._S
  4c50: 42 5f 50 43 49 30 49 44 45 30 45 53 49 44 5c 2f  B_PCI0IDE0ESID\/
  4c60: 05 5f 53 42 5f 50 43 49 30 49 44 45 30 53 45 43  ._SB_PCI0IDE0SEC
  4c70: 4e 43 42 41 59 70 5e 5e 42 46 4c 47 60 a0 2e 93  NCBAYp^^BFLG`...
  4c80: 5e 5e 42 4e 55 4d 0a 01 a0 23 7b 60 0a 01 00 a0  ^^BNUM...#{`....
  4c90: 17 5c 2f 04 5f 53 42 5f 50 43 49 30 4c 50 43 30  .\/._SB_PCI0LPC0
  4ca0: 4c 56 33 37 a4 0a 08 a1 04 a4 0a 0f a1 2e a0 27  LV37...........'
  4cb0: 93 5e 5e 42 4e 55 4d 0a 02 a0 17 5c 2f 04 5f 53  .^^BNUM....\/._S
  4cc0: 42 5f 50 43 49 30 4c 50 43 30 4c 56 33 37 a4 0a  B_PCI0LPC0LV37..
  4cd0: 08 a1 04 a4 0a 0f a1 04 a4 0a 08 a1 04 a4 0a 08  ................
  4ce0: 14 40 05 5f 45 4a 30 01 a0 48 04 68 70 0a 01 5e  .-4kcfD1znWufzv0hrYtaEBw@public.gmane.org^
  4cf0: 5e 5e 53 53 49 47 5b 22 0a 32 70 0b 00 c0 5e 5e  ^^SSIG[".2p...^^
  4d00: 5e 49 54 4d 31 70 0a 01 5c 2f 04 5f 53 42 5f 50  ^ITM1p..\/._SB_P
  4d10: 43 49 30 4c 50 43 30 4c 56 33 37 70 0a 00 5c 2f  CI0LPC0LV37p..\/
  4d20: 04 5f 53 42 5f 50 43 49 30 4c 50 43 30 4c 56 33  ._SB_PCI0LPC0LV3
  4d30: 39 08 42 4e 55 4d 0a 00 08 42 46 4c 47 0a 00 14  9.BNUM...BFLG...
  4d40: 46 04 43 42 41 59 00 70 0a 00 42 4e 55 4d 70 0a  F.CBAY.p..BNUMp.
  4d50: 00 42 46 4c 47 70 5c 2f 04 5f 53 42 5f 50 43 49  .BFLGp\/._SB_PCI
  4d60: 30 4c 50 43 30 52 42 49 44 60 a0 1b 7d 93 60 0a  0LPC0RBID`..}.`.
  4d70: 01 93 60 0a 02 00 75 42 4e 55 4d 7d 42 46 4c 47  ..`...uBNUM}BFLG
  4d80: 0a 01 42 46 4c 47 14 43 05 5f 50 53 30 00 a0 44  ..BFLG.C._PS0..D
  4d90: 04 7b 93 5f 50 53 43 0a 03 93 5c 2e 5f 53 42 5f  .{._PSC...\._SB_
  4da0: 53 54 41 54 0a 03 00 70 0a 89 5c 2f 04 5f 53 42  STAT...p..\/._SB
  4db0: 5f 50 43 49 30 4c 50 43 30 42 43 4d 44 70 0a 00  _PCI0LPC0BCMDp..
  4dc0: 5c 2f 04 5f 53 42 5f 50 43 49 30 4c 50 43 30 53  \/._SB_PCI0LPC0S
  4dd0: 4d 49 43 70 0a 00 5f 50 53 43 14 0d 5f 50 53 33  MICp.._PSC.._PS3
  4de0: 00 70 0a 03 5f 50 53 43 08 5f 50 53 43 0a 00 5b  .p.._PSC._PSC..[
  4df0: 82 4c 06 55 53 42 31 08 5f 41 44 52 0c 00 00 1d  .L.USB1._ADR....
  4e00: 00 5b 80 55 53 42 4f 02 0a c4 0a 04 5b 81 0b 55  .[.USBO.....[..U
  4e10: 53 42 4f 01 52 53 45 4e 02 08 5f 50 52 57 12 06  SBO.RSEN.._PRW..
  4e20: 02 0a 03 0a 03 14 37 5f 50 53 57 01 a0 18 68 70  ......7_PSW...hp
  4e30: 0a 03 5c 2f 04 5f 53 42 5f 50 43 49 30 55 53 42  ..\/._SB_PCI0USB
  4e40: 31 52 53 45 4e a1 17 70 0a 00 5c 2f 04 5f 53 42  1RSEN..p..\/._SB
  4e50: 5f 50 43 49 30 55 53 42 31 52 53 45 4e 5b 82 4c  _PCI0USB1RSEN[.L
  4e60: 06 55 53 42 32 08 5f 41 44 52 0c 01 00 1d 00 5b  .USB2._ADR.....[
  4e70: 80 55 53 42 4f 02 0a c4 0a 04 5b 81 0b 55 53 42  .USBO.....[..USB
  4e80: 4f 01 52 53 45 4e 02 08 5f 50 52 57 12 06 02 0a  O.RSEN.._PRW....
  4e90: 04 0a 03 14 37 5f 50 53 57 01 a0 18 68 70 0a 03  ....7_PSW...hp..
  4ea0: 5c 2f 04 5f 53 42 5f 50 43 49 30 55 53 42 32 52  \/._SB_PCI0USB2R
  4eb0: 53 45 4e a1 17 70 0a 00 5c 2f 04 5f 53 42 5f 50  SEN..p..\/._SB_P
  4ec0: 43 49 30 55 53 42 32 52 53 45 4e 5b 82 4c 06 55  CI0USB2RSEN[.L.U
  4ed0: 53 42 33 08 5f 41 44 52 0c 02 00 1d 00 5b 80 55  SB3._ADR.....[.U
  4ee0: 53 42 4f 02 0a c4 0a 04 5b 81 0b 55 53 42 4f 01  SBO.....[..USBO.
  4ef0: 52 53 45 4e 02 08 5f 50 52 57 12 06 02 0a 0c 0a  RSEN.._PRW......
  4f00: 03 14 37 5f 50 53 57 01 a0 18 68 70 0a 03 5c 2f  ..7_PSW...hp..\/
  4f10: 04 5f 53 42 5f 50 43 49 30 55 53 42 33 52 53 45  ._SB_PCI0USB3RSE
  4f20: 4e a1 17 70 0a 00 5c 2f 04 5f 53 42 5f 50 43 49  N..p..\/._SB_PCI
  4f30: 30 55 53 42 33 52 53 45 4e 5b 82 4f 05 4c 49 44  0USB3RSEN[.O.LID
  4f40: 5f 08 5f 48 49 44 0c 41 d0 0c 0d 08 4c 53 54 53  _._HID.A....LSTS
  4f50: 0a 00 14 47 04 5f 4c 49 44 00 a0 32 5c 2e 5f 53  ...G._LID..2\._S
  4f60: 42 5f 4f 4b 45 43 a0 1e 5c 2f 05 5f 53 42 5f 50  B_OKEC..\/._SB_P
  4f70: 43 49 30 4c 50 43 30 45 43 30 5f 4c 49 44 53 70  CI0LPC0EC0_LIDSp
  4f80: 00 4c 53 54 53 a1 07 70 01 4c 53 54 53 a1 07 70  .LSTS..p.LSTS..p
  4f90: 00 4c 53 54 53 a4 4c 53 54 53 5b 82 47 0b 41 43  .LSTS.LSTS[.G.AC
  4fa0: 41 44 08 5f 48 49 44 0d 41 43 50 49 30 30 30 33  AD._HID.ACPI0003
  4fb0: 00 08 5f 50 43 4c 12 07 01 5c 5f 53 42 5f 08 41  .._PCL...\_SB_.A
  4fc0: 43 57 54 0a 00 14 4d 08 5f 50 53 52 00 70 5c 2e  CWT...M._PSR.p\.
  4fd0: 5f 53 42 5f 41 43 53 54 41 43 57 54 a0 2d 5c 2e  _SB_ACSTACWT.-\.
  4fe0: 5f 53 42 5f 4f 4b 45 43 70 5c 2f 05 5f 53 42 5f  _SB_OKECp\/._SB_
  4ff0: 50 43 49 30 4c 50 43 30 45 43 30 5f 41 43 44 46  PCI0LPC0EC0_ACDF
  5000: 5c 2e 5f 53 42 5f 41 43 53 54 a0 3d 92 93 41 43  \._SB_ACST.=..AC
  5010: 57 54 5c 2e 5f 53 42 5f 41 43 53 54 70 0a 8b 5c  WT\._SB_ACSTp..\
  5020: 2f 04 5f 53 42 5f 50 43 49 30 4c 50 43 30 42 43  /._SB_PCI0LPC0BC
  5030: 4d 44 70 0a 00 5c 2f 04 5f 53 42 5f 50 43 49 30  MDp..\/._SB_PCI0
  5040: 4c 50 43 30 53 4d 49 43 a4 5c 2e 5f 53 42 5f 41  LPC0SMIC.\._SB_A
  5050: 43 53 54 14 10 56 54 4f 42 01 70 0a 01 60 79 60  CST..VTOB.p..`y`
  5060: 68 60 a4 60 14 1b 42 54 4f 56 01 7a 68 0a 01 60  h`.`..BTOV.zh..`
  5070: 70 0a 00 61 a2 09 60 75 61 7a 60 0a 01 60 a4 61  p..a..`uaz`..`.a
  5080: 14 27 4d 4b 57 44 02 a0 0d 7b 69 0a 80 00 70 0c  .'MKWD...{i...p.
  5090: 00 00 ff ff 60 a1 04 70 00 60 7d 60 68 60 7d 60  ....`..p.`}`h`}`
  50a0: 79 69 0a 08 00 60 a4 60 14 2e 50 4f 53 57 01 a0  yi...`.`..POSW..
  50b0: 23 7b 68 0b 00 80 00 a0 0c 93 68 0b ff ff a4 0c  #{h.......h.....
  50c0: ff ff ff ff a1 0e 80 68 60 75 60 7b 60 0b ff ff  .......h`u`{`...
  50d0: 60 a4 60 a1 03 a4 68 14 13 47 42 46 45 03 8c 68  `.`...h..GBFE..h
  50e0: 69 54 49 44 58 70 54 49 44 58 6a 14 13 50 42 46  iTIDXpTIDXj..PBF
  50f0: 45 03 8c 68 69 54 49 44 58 70 6a 54 49 44 58 14  E..hiTIDXpjTIDX.
  5100: 46 06 49 54 4f 53 01 70 11 0c 0a 09 30 00 00 00  F.ITOS.p....0...
  5110: 00 00 00 00 00 60 70 11 14 0a 11 30 31 32 33 34  .....`p....01234
  5120: 35 36 37 38 39 41 42 43 44 45 46 00 67 70 0a 08  56789ABCDEF.gp..
  5130: 61 70 0a 00 62 70 0a 00 63 a2 2a 61 76 61 7b 7a  ap..bp..c.*ava{z
  5140: 68 79 61 0a 02 00 00 0a 0f 64 a0 05 64 70 ff 63  hya......d..dp.c
  5150: a0 13 63 47 42 46 45 67 64 71 65 50 42 46 45 60  ..cGBFEgdqePBFE`
  5160: 62 65 75 62 a4 60 5b 82 47 58 42 41 54 31 08 5f  beub.`[.GXBAT1._
  5170: 48 49 44 0c 41 d0 0c 0a 08 5f 55 49 44 0a 01 08  HID.A...._UID...
  5180: 5f 50 43 4c 12 07 01 5c 5f 53 42 5f 08 50 42 49  _PCL...\_SB_.PBI
  5190: 46 12 2c 0d 0a 01 0c ff ff ff ff 0c ff ff ff ff  F.,.............
  51a0: 0a 01 0c ff ff ff ff 0a fa 0a 64 0a 0a 0a 19 0d  ..........d.....
  51b0: 42 41 54 31 00 0d 20 00 0d 20 00 0d 20 00 08 50  BAT1.. .. .. ..P
  51c0: 42 53 54 12 11 04 0a 00 0c ff ff ff ff 0c ff ff  BST.............
  51d0: ff ff 0b 10 27 08 42 41 53 54 0a 00 08 46 41 53  ....'.BAST...FAS
  51e0: 54 0a 00 08 42 31 53 54 0a 0f 08 42 31 57 54 0a  T...B1ST...B1WT.
  51f0: 00 14 4e 08 5f 53 54 41 00 a0 43 04 95 46 41 53  ..N._STA..C..FAS
  5200: 54 0a 10 75 46 41 53 54 a0 34 93 46 41 53 54 0a  T..uFAST.4.FAST.
  5210: 10 70 0a 92 5c 2f 04 5f 53 42 5f 50 43 49 30 4c  .p..\/._SB_PCI0L
  5220: 50 43 30 42 43 4d 44 70 0a 00 5c 2f 04 5f 53 42  PC0BCMDp..\/._SB
  5230: 5f 50 43 49 30 4c 50 43 30 53 4d 49 43 a0 34 5c  _PCI0LPC0SMIC.4\
  5240: 2e 5f 53 42 5f 4f 4b 45 43 a0 1f 5c 2f 05 5f 53  ._SB_OKEC..\/._S
  5250: 42 5f 50 43 49 30 4c 50 43 30 45 43 30 5f 4d 42  B_PCI0LPC0EC0_MB
  5260: 54 53 70 0a 1f 42 31 53 54 a1 08 70 0a 0f 42 31  TSp..B1ST..p..B1
  5270: 53 54 a1 08 70 0a 0f 42 31 53 54 a4 42 31 53 54  ST..p..B1ST.B1ST
  5280: 14 41 04 5f 42 49 46 00 a0 2e 5c 2e 5f 53 42 5f  .A._BIF...\._SB_
  5290: 4f 4b 45 43 a0 1c 5c 2f 05 5f 53 42 5f 50 43 49  OKEC..\/._SB_PCI
  52a0: 30 4c 50 43 30 45 43 30 5f 4d 42 54 53 55 50 42  0LPC0EC0_MBTSUPB
  52b0: 49 a1 05 49 56 42 49 a1 05 49 56 42 49 a4 50 42  I..IVBI..IVBI.PB
  52c0: 49 46 14 41 04 5f 42 53 54 00 a0 2e 5c 2e 5f 53  IF.A._BST...\._S
  52d0: 42 5f 4f 4b 45 43 a0 1c 5c 2f 05 5f 53 42 5f 50  B_OKEC..\/._SB_P
  52e0: 43 49 30 4c 50 43 30 45 43 30 5f 4d 42 54 53 55  CI0LPC0EC0_MBTSU
  52f0: 50 42 53 a1 05 49 56 42 53 a1 05 49 56 42 53 a4  PBS..IVBS..IVBS.
  5300: 50 42 53 54 14 46 21 55 50 42 49 00 70 0b ff 1f  PBST.F!UPBI.p...
  5310: 62 5c 2f 05 5f 53 42 5f 50 43 49 30 4c 50 43 30  b\/._SB_PCI0LPC0
  5320: 45 43 30 5f 53 4d 57 52 0a 08 0a 14 0a 01 62 5c  EC0_SMWR......b\
  5330: 2f 05 5f 53 42 5f 50 43 49 30 4c 50 43 30 45 43  /._SB_PCI0LPC0EC
  5340: 30 5f 53 4d 52 44 0a 09 0a 14 0a 01 71 63 a0 35  0_SMRD......qc.5
  5350: 93 62 7d 63 0b ff 0f 00 a0 2b 92 5c 2f 05 5f 53  .b}c.....+.\/._S
  5360: 42 5f 50 43 49 30 4c 50 43 30 45 43 30 5f 53 4d  B_PCI0LPC0EC0_SM
  5370: 52 44 0a 09 0a 16 0a 10 71 65 70 65 88 50 42 49  RD......qepe.PBI
  5380: 46 0a 02 00 a0 41 06 93 5c 2f 05 5f 53 42 5f 50  F....A..\/._SB_P
  5390: 43 49 30 4c 50 43 30 45 43 30 5f 4d 42 49 44 0a  CI0LPC0EC0_MBID.
  53a0: 01 70 0b 30 11 88 50 42 49 46 0a 01 00 70 0b d0  .p.0..PBIF...p..
  53b0: 39 88 50 42 49 46 0a 04 00 70 0d 30 31 5a 47 00  9.PBIF...p.01ZG.
  53c0: 88 50 42 49 46 0a 09 00 70 0d 4c 49 4f 4e 00 88  .PBIF...p.LION..
  53d0: 50 42 49 46 0a 0b 00 70 0d 53 4d 50 20 00 88 50  PBIF...p.SMP ..P
  53e0: 42 49 46 0a 0c 00 a1 43 11 a0 42 06 93 5c 2f 05  BIF....C..B..\/.
  53f0: 5f 53 42 5f 50 43 49 30 4c 50 43 30 45 43 30 5f  _SB_PCI0LPC0EC0_
  5400: 4d 42 49 44 0a 02 70 0b 10 0e 88 50 42 49 46 0a  MBID..p....PBIF.
  5410: 01 00 70 0b d0 39 88 50 42 49 46 0a 04 00 70 0d  ..p..9.PBIF...p.
  5420: 30 32 5a 47 00 88 50 42 49 46 0a 09 00 70 0d 4c  02ZG..PBIF...p.L
  5430: 49 4f 4e 00 88 50 42 49 46 0a 0b 00 70 0d 53 41  ION..PBIF...p.SA
  5440: 4e 59 4f 00 88 50 42 49 46 0a 0c 00 a1 4d 0a a0  NYO..PBIF....M..
  5450: 42 06 93 5c 2f 05 5f 53 42 5f 50 43 49 30 4c 50  B..\/._SB_PCI0LP
  5460: 43 30 45 43 30 5f 4d 42 49 44 0a 03 70 0b 30 11  C0EC0_MBID..p.0.
  5470: 88 50 42 49 46 0a 01 00 70 0b d0 39 88 50 42 49  .PBIF...p..9.PBI
  5480: 46 0a 04 00 70 0d 30 33 5a 47 00 88 50 42 49 46  F...p.03ZG..PBIF
  5490: 0a 09 00 70 0d 4c 49 4f 4e 00 88 50 42 49 46 0a  ...p.LION..PBIF.
  54a0: 0b 00 70 0d 53 41 4e 59 4f 00 88 50 42 49 46 0a  ..p.SANYO..PBIF.
  54b0: 0c 00 a1 47 04 70 0b 30 11 88 50 42 49 46 0a 01  ...G.p.0..PBIF..
  54c0: 00 70 0b d0 39 88 50 42 49 46 0a 04 00 70 0d 30  .p..9.PBIF...p.0
  54d0: 31 5a 47 00 88 50 42 49 46 0a 09 00 70 0d 4c 49  1ZG..PBIF...p.LI
  54e0: 4f 4e 00 88 50 42 49 46 0a 0b 00 70 0d 53 4d 50  ON..PBIF...p.SMP
  54f0: 20 00 88 50 42 49 46 0a 0c 00 70 0a 01 88 50 42   ..PBIF...p...PB
  5500: 49 46 0a 00 00 a0 15 93 87 5c 5f 4f 53 5f 0a 27  IF.......\_OS_.'
  5510: 70 0a 00 88 50 42 49 46 0a 00 00 14 4c 12 55 50  p...PBIF....L.UP
  5520: 42 53 00 70 5c 2f 05 5f 53 42 5f 50 43 49 30 4c  BS.p\/._SB_PCI0L
  5530: 50 43 30 45 43 30 5f 4d 43 55 52 65 70 50 4f 53  PC0EC0_MCURepPOS
  5540: 57 65 88 50 42 53 54 0a 01 00 70 5c 2f 05 5f 53  We.PBST...p\/._S
  5550: 42 5f 50 43 49 30 4c 50 43 30 45 43 30 5f 4d 42  B_PCI0LPC0EC0_MB
  5560: 52 4d 88 50 42 53 54 0a 02 00 70 5c 2f 05 5f 53  RM.PBST...p\/._S
  5570: 42 5f 50 43 49 30 4c 50 43 30 45 43 30 5f 4d 42  B_PCI0LPC0EC0_MB
  5580: 56 47 88 50 42 53 54 0a 03 00 a0 3c 5c 2f 05 5f  VG.PBST....<\/._
  5590: 53 42 5f 50 43 49 30 4c 50 43 30 45 43 30 5f 4d  SB_PCI0LPC0EC0_M
  55a0: 42 54 46 a0 23 5c 2f 05 5f 53 42 5f 50 43 49 30  BTF.#\/._SB_PCI0
  55b0: 4c 50 43 30 45 43 30 5f 41 43 44 46 70 0a 00 88  LPC0EC0_ACDFp...
  55c0: 50 42 53 54 0a 00 00 a1 40 08 a0 4a 04 5c 2f 05  PBST....-7QL0eHYvMQY@public.gmane.org\/.
  55d0: 5f 53 42 5f 50 43 49 30 4c 50 43 30 45 43 30 5f  _SB_PCI0LPC0EC0_
  55e0: 4d 42 54 43 a0 23 5c 2f 05 5f 53 42 5f 50 43 49  MBTC.#\/._SB_PCI
  55f0: 30 4c 50 43 30 45 43 30 5f 41 43 44 46 70 0a 02  0LPC0EC0_ACDFp..
  5600: 88 50 42 53 54 0a 00 00 a1 0c 70 0a 00 88 50 42  .PBST.....p...PB
  5610: 53 54 0a 00 00 a1 32 a0 23 5c 2f 05 5f 53 42 5f  ST....2.#\/._SB_
  5620: 50 43 49 30 4c 50 43 30 45 43 30 5f 41 43 44 46  PCI0LPC0EC0_ACDF
  5630: 70 0a 00 88 50 42 53 54 0a 00 00 a1 0c 70 0a 01  p...PBST.....p..
  5640: 88 50 42 53 54 0a 00 00 14 4c 06 49 56 42 49 00  .PBST....L.IVBI.
  5650: 70 0c ff ff ff ff 88 50 42 49 46 0a 01 00 70 0c  p......PBIF...p.
  5660: ff ff ff ff 88 50 42 49 46 0a 02 00 70 0c ff ff  .....PBIF...p...
  5670: ff ff 88 50 42 49 46 0a 04 00 70 0d 42 61 64 00  ...PBIF...p.Bad.
  5680: 88 50 42 49 46 0a 09 00 70 0d 20 20 20 20 20 20  .PBIF...p.      
  5690: 00 88 50 42 49 46 0a 0a 00 70 0d 42 61 64 00 88  ..PBIF...p.Bad..
  56a0: 50 42 49 46 0a 0b 00 70 0d 42 61 64 00 88 50 42  PBIF...p.Bad..PB
  56b0: 49 46 0a 0c 00 14 39 49 56 42 53 00 70 0a 00 88  IF....9IVBS.p...
  56c0: 50 42 53 54 0a 00 00 70 0c ff ff ff ff 88 50 42  PBST...p......PB
  56d0: 53 54 0a 01 00 70 0c ff ff ff ff 88 50 42 53 54  ST...p......PBST
  56e0: 0a 02 00 70 0b 10 27 88 50 42 53 54 0a 03 00 5b  ...p..'.PBST...[
  56f0: 82 4f 52 42 41 54 32 08 5f 48 49 44 0c 41 d0 0c  .ORBAT2._HID.A..
  5700: 0a 08 5f 55 49 44 0a 02 08 5f 50 43 4c 12 07 01  .._UID..._PCL...
  5710: 5c 5f 53 42 5f 08 42 32 53 54 0a 0f 08 50 42 49  \_SB_.B2ST...PBI
  5720: 46 12 2c 0d 0a 01 0c ff ff ff ff 0c ff ff ff ff  F.,.............
  5730: 0a 01 0c ff ff ff ff 0a fa 0a 64 0a 0a 0a 19 0d  ..........d.....
  5740: 42 41 54 31 00 0d 20 00 0d 20 00 0d 20 00 08 50  BAT1.. .. .. ..P
  5750: 42 53 54 12 11 04 0a 00 0c ff ff ff ff 0c ff ff  BST.............
  5760: ff ff 0b 10 27 14 4a 04 5f 53 54 41 00 a0 34 5c  ....'.J._STA..4\
  5770: 2e 5f 53 42 5f 4f 4b 45 43 a0 1f 5c 2f 05 5f 53  ._SB_OKEC..\/._S
  5780: 42 5f 50 43 49 30 4c 50 43 30 45 43 30 5f 53 42  B_PCI0LPC0EC0_SB
  5790: 54 53 70 0a 1f 42 32 53 54 a1 08 70 0a 0f 42 32  TSp..B2ST..p..B2
  57a0: 53 54 a1 08 70 0a 0f 42 32 53 54 a4 42 32 53 54  ST..p..B2ST.B2ST
  57b0: 14 41 04 5f 42 49 46 00 a0 2e 5c 2e 5f 53 42 5f  .A._BIF...\._SB_
  57c0: 4f 4b 45 43 a0 1c 5c 2f 05 5f 53 42 5f 50 43 49  OKEC..\/._SB_PCI
  57d0: 30 4c 50 43 30 45 43 30 5f 53 42 54 53 55 50 42  0LPC0EC0_SBTSUPB
  57e0: 49 a1 05 49 56 42 49 a1 05 49 56 42 49 a4 50 42  I..IVBI..IVBI.PB
  57f0: 49 46 14 41 04 5f 42 53 54 00 a0 2e 5c 2e 5f 53  IF.A._BST...\._S
  5800: 42 5f 4f 4b 45 43 a0 1c 5c 2f 05 5f 53 42 5f 50  B_OKEC..\/._SB_P
  5810: 43 49 30 4c 50 43 30 45 43 30 5f 53 42 54 53 55  CI0LPC0EC0_SBTSU
  5820: 50 42 53 a1 05 49 56 42 53 a1 05 49 56 42 53 a4  PBS..IVBS..IVBS.
  5830: 50 42 53 54 14 47 21 55 50 42 49 00 70 0b ff 2f  PBST.G!UPBI.p../
  5840: 62 5c 2f 05 5f 53 42 5f 50 43 49 30 4c 50 43 30  b\/._SB_PCI0LPC0
  5850: 45 43 30 5f 53 4d 57 52 0a 08 0a 14 0a 01 62 5c  EC0_SMWR......b\
  5860: 2f 05 5f 53 42 5f 50 43 49 30 4c 50 43 30 45 43  /._SB_PCI0LPC0EC
  5870: 30 5f 53 4d 52 44 0a 09 0a 14 0a 01 71 63 a0 35  0_SMRD......qc.5
  5880: 93 62 7d 63 0b ff 0f 00 a0 2b 92 5c 2f 05 5f 53  .b}c.....+.\/._S
  5890: 42 5f 50 43 49 30 4c 50 43 30 45 43 30 5f 53 4d  B_PCI0LPC0EC0_SM
  58a0: 52 44 0a 09 0a 16 0a 10 71 65 70 65 88 50 42 49  RD......qepe.PBI
  58b0: 46 0a 02 00 a0 41 06 93 5c 2f 05 5f 53 42 5f 50  F....A..\/._SB_P
  58c0: 43 49 30 4c 50 43 30 45 43 30 5f 53 42 49 44 0a  CI0LPC0EC0_SBID.
  58d0: 01 70 0b 30 11 88 50 42 49 46 0a 01 00 70 0b d0  .p.0..PBIF...p..
  58e0: 39 88 50 42 49 46 0a 04 00 70 0d 30 31 5a 47 00  9.PBIF...p.01ZG.
  58f0: 88 50 42 49 46 0a 09 00 70 0d 4c 49 4f 4e 00 88  .PBIF...p.LION..
  5900: 50 42 49 46 0a 0b 00 70 0d 53 4d 50 20 00 88 50  PBIF...p.SMP ..P
  5910: 42 49 46 0a 0c 00 a1 44 11 a0 42 06 93 5c 2f 05  BIF....D..B..\/.
  5920: 5f 53 42 5f 50 43 49 30 4c 50 43 30 45 43 30 5f  _SB_PCI0LPC0EC0_
  5930: 53 42 49 44 0a 02 70 0b 10 0e 88 50 42 49 46 0a  SBID..p....PBIF.
  5940: 01 00 70 0b d0 39 88 50 42 49 46 0a 04 00 70 0d  ..p..9.PBIF...p.
  5950: 30 32 5a 47 00 88 50 42 49 46 0a 09 00 70 0d 4c  02ZG..PBIF...p.L
  5960: 49 4f 4e 00 88 50 42 49 46 0a 0b 00 70 0d 53 41  ION..PBIF...p.SA
  5970: 4e 59 4f 00 88 50 42 49 46 0a 0c 00 a1 4e 0a a0  NYO..PBIF....N..
  5980: 42 06 93 5c 2f 05 5f 53 42 5f 50 43 49 30 4c 50  B..\/._SB_PCI0LP
  5990: 43 30 45 43 30 5f 53 42 49 44 0a 03 70 0b 30 11  C0EC0_SBID..p.0.
  59a0: 88 50 42 49 46 0a 01 00 70 0b d0 39 88 50 42 49  .PBIF...p..9.PBI
  59b0: 46 0a 04 00 70 0d 30 33 5a 47 00 88 50 42 49 46  F...p.03ZG..PBIF
  59c0: 0a 09 00 70 0d 4c 49 4f 4e 00 88 50 42 49 46 0a  ...p.LION..PBIF.
  59d0: 0b 00 70 0d 53 41 4e 59 4f 00 88 50 42 49 46 0a  ..p.SANYO..PBIF.
  59e0: 0c 00 a1 48 04 70 0b 10 0e 88 50 42 49 46 0a 01  ...H.p....PBIF..
  59f0: 00 70 0b d0 39 88 50 42 49 46 0a 04 00 70 0d 30  .p..9.PBIF...p.0
  5a00: 32 5a 47 00 88 50 42 49 46 0a 09 00 70 0d 4c 49  2ZG..PBIF...p.LI
  5a10: 4f 4e 00 88 50 42 49 46 0a 0b 00 70 0d 53 41 4e  ON..PBIF...p.SAN
  5a20: 59 4f 00 88 50 42 49 46 0a 0c 00 70 0a 01 88 50  YO..PBIF...p...P
  5a30: 42 49 46 0a 00 00 a0 15 93 87 5c 5f 4f 53 5f 0a  BIF.......\_OS_.
  5a40: 27 70 0a 00 88 50 42 49 46 0a 00 00 14 4c 12 55  'p...PBIF....L.U
  5a50: 50 42 53 00 70 5c 2f 05 5f 53 42 5f 50 43 49 30  PBS.p\/._SB_PCI0
  5a60: 4c 50 43 30 45 43 30 5f 41 43 55 52 65 70 50 4f  LPC0EC0_ACURepPO
  5a70: 53 57 65 88 50 42 53 54 0a 01 00 70 5c 2f 05 5f  SWe.PBST...p\/._
  5a80: 53 42 5f 50 43 49 30 4c 50 43 30 45 43 30 5f 41  SB_PCI0LPC0EC0_A
  5a90: 42 52 4d 88 50 42 53 54 0a 02 00 70 5c 2f 05 5f  BRM.PBST...p\/._
  5aa0: 53 42 5f 50 43 49 30 4c 50 43 30 45 43 30 5f 41  SB_PCI0LPC0EC0_A
  5ab0: 42 56 47 88 50 42 53 54 0a 03 00 a0 3c 5c 2f 05  BVG.PBST....<\/.
  5ac0: 5f 53 42 5f 50 43 49 30 4c 50 43 30 45 43 30 5f  _SB_PCI0LPC0EC0_
  5ad0: 53 42 54 46 a0 23 5c 2f 05 5f 53 42 5f 50 43 49  SBTF.#\/._SB_PCI
  5ae0: 30 4c 50 43 30 45 43 30 5f 41 43 44 46 70 0a 00  0LPC0EC0_ACDFp..
  5af0: 88 50 42 53 54 0a 00 00 a1 40 08 a0 4a 04 5c 2f  .PBST....-7QL0eHYvMQY@public.gmane.org\/
  5b00: 05 5f 53 42 5f 50 43 49 30 4c 50 43 30 45 43 30  ._SB_PCI0LPC0EC0
  5b10: 5f 53 42 54 43 a0 23 5c 2f 05 5f 53 42 5f 50 43  _SBTC.#\/._SB_PC
  5b20: 49 30 4c 50 43 30 45 43 30 5f 41 43 44 46 70 0a  I0LPC0EC0_ACDFp.
  5b30: 02 88 50 42 53 54 0a 00 00 a1 0c 70 0a 00 88 50  ..PBST.....p...P
  5b40: 42 53 54 0a 00 00 a1 32 a0 23 5c 2f 05 5f 53 42  BST....2.#\/._SB
  5b50: 5f 50 43 49 30 4c 50 43 30 45 43 30 5f 41 43 44  _PCI0LPC0EC0_ACD
  5b60: 46 70 0a 00 88 50 42 53 54 0a 00 00 a1 0c 70 0a  Fp...PBST.....p.
  5b70: 01 88 50 42 53 54 0a 00 00 14 4c 06 49 56 42 49  ..PBST....L.IVBI
  5b80: 00 70 0c ff ff ff ff 88 50 42 49 46 0a 01 00 70  .p......PBIF...p
  5b90: 0c ff ff ff ff 88 50 42 49 46 0a 02 00 70 0c ff  ......PBIF...p..
  5ba0: ff ff ff 88 50 42 49 46 0a 04 00 70 0d 42 61 64  ....PBIF...p.Bad
  5bb0: 00 88 50 42 49 46 0a 09 00 70 0d 20 20 20 20 20  ..PBIF...p.     
  5bc0: 20 00 88 50 42 49 46 0a 0a 00 70 0d 42 61 64 00   ..PBIF...p.Bad.
  5bd0: 88 50 42 49 46 0a 0b 00 70 0d 42 61 64 00 88 50  .PBIF...p.Bad..P
  5be0: 42 49 46 0a 0c 00 14 39 49 56 42 53 00 70 0a 00  BIF....9IVBS.p..
  5bf0: 88 50 42 53 54 0a 00 00 70 0c ff ff ff ff 88 50  .PBST...p......P
  5c00: 42 53 54 0a 01 00 70 0c ff ff ff ff 88 50 42 53  BST...p......PBS
  5c10: 54 0a 02 00 70 0b 10 27 88 50 42 53 54 0a 03 00  T...p..'.PBST...
  5c20: 10 4d 63 5c 5f 54 5a 5f 08 54 50 4c 5f 0b a0 0c  .Mc\_TZ_.TPL_...
  5c30: 08 54 41 43 31 0b 0e 0d 08 54 41 43 30 0b 54 0d  .TAC1....TAC0.T.
  5c40: 08 54 50 41 53 0b 44 0e 08 54 50 43 5f 0b 94 0e  .TPAS.D..TPC_...
  5c50: 08 54 50 54 4d 0b 3c 0c 08 54 42 53 45 0b ac 0a  .TPTM.<..TBSE...
  5c60: 08 4c 54 4d 50 0b a0 0c 08 54 56 41 52 11 08 0a  .LTMP....TVAR...
  5c70: 05 00 20 1f 0c 1f 8c 54 56 41 52 0a 00 50 4c 43  .. ....TVAR..PLC
  5c80: 59 8b 54 56 41 52 0a 01 43 54 4f 53 8b 54 56 41  Y.TVAR..CTOS.TVA
  5c90: 52 0a 03 43 54 48 59 5b 82 43 06 46 41 4e 30 08  R..CTHY[.C.FAN0.
  5ca0: 5f 48 49 44 0c 41 d0 0c 0b 08 5f 55 49 44 0a 01  _HID.A...._UID..
  5cb0: 08 5f 50 52 30 12 06 01 50 46 4e 30 14 1f 5f 50  ._PR0...PFN0.._P
  5cc0: 53 30 00 70 0d 4c 6f 77 20 53 70 65 65 64 20 46  S0.p.Low Speed F
  5cd0: 41 4e 20 2d 20 5f 50 53 30 00 5b 31 14 1f 5f 50  AN - _PS0.[1.._P
  5ce0: 53 33 00 70 0d 4c 6f 77 20 53 70 65 65 64 20 46  S3.p.Low Speed F
  5cf0: 41 4e 20 2d 20 5f 50 53 33 00 5b 31 5b 84 45 1f  AN - _PS3.[1[.E.
  5d00: 50 46 4e 30 00 00 00 08 46 4e 53 31 0a 00 08 46  PFN0....FNS1...F
  5d10: 46 53 54 0a 01 14 0e 5f 53 54 41 00 70 46 4e 53  FST...._STA.pFNS
  5d20: 31 61 a4 61 14 43 0c 5f 4f 4e 5f 00 70 0a 01 46  1a.a.C._ON_.p..F
  5d30: 4e 53 31 a0 38 5c 2f 03 5f 54 5a 5f 50 46 4e 31  NS1.8\/._TZ_PFN1
  5d40: 46 4e 53 32 70 0d 46 41 4e 20 31 20 28 48 69 67  FNS2p.FAN 1 (Hig
  5d50: 68 20 73 70 65 65 64 20 61 6c 72 65 61 64 79 20  h speed already 
  5d60: 74 75 72 6e 20 6f 6e 29 20 00 5b 31 a1 42 04 a0  turn on) .[1.B..
  5d70: 3f 5c 2e 5f 53 42 5f 4f 4b 45 43 70 0a b4 5c 2f  ?\._SB_OKECp..\/
  5d80: 05 5f 53 42 5f 50 43 49 30 4c 50 43 30 45 43 30  ._SB_PCI0LPC0EC0
  5d90: 5f 46 53 50 44 70 0a 01 5c 2f 05 5f 53 42 5f 50  _FSPDp..\/._SB_P
  5da0: 43 49 30 4c 50 43 30 45 43 30 5f 46 50 52 31 a0  CI0LPC0EC0_FPR1.
  5db0: 38 7d 93 5c 2f 03 5f 53 42 5f 50 43 49 30 4d 59  8}.\/._SB_PCI0MY
  5dc0: 4f 53 0a 01 93 5c 2f 03 5f 53 42 5f 50 43 49 30  OS...\/._SB_PCI0
  5dd0: 4d 59 4f 53 0a 03 00 5c 2f 03 5f 54 5a 5f 54 48  MYOS...\/._TZ_TH
  5de0: 52 4d 5f 53 43 50 0a 01 14 4a 10 5f 4f 46 46 00  RM_SCP...J._OFF.
  5df0: 70 0a 00 46 4e 53 31 a0 4d 05 93 87 5c 5f 4f 53  p..FNS1.M...\_OS
  5e00: 5f 0a 14 a0 41 05 5c 2e 5f 53 42 5f 4f 4b 45 43  _...A.\._SB_OKEC
  5e10: a0 29 5c 2f 03 5f 54 5a 5f 50 46 4e 31 46 4e 53  .)\/._TZ_PFN1FNS
  5e20: 32 70 01 5c 2f 05 5f 53 42 5f 50 43 49 30 4c 50  2p.\/._SB_PCI0LP
  5e30: 43 30 45 43 30 5f 46 50 52 31 a1 1a 70 00 5c 2f  C0EC0_FPR1..p.\/
  5e40: 05 5f 53 42 5f 50 43 49 30 4c 50 43 30 45 43 30  ._SB_PCI0LPC0EC0
  5e50: 5f 46 50 52 31 a1 44 06 a0 39 95 46 46 53 54 0a  _FPR1.D..9.FFST.
  5e60: 02 70 0a 86 5c 2f 04 5f 53 42 5f 50 43 49 30 4c  .p..\/._SB_PCI0L
  5e70: 50 43 30 42 43 4d 44 70 0a 00 5c 2f 04 5f 53 42  PC0BCMDp..\/._SB
  5e80: 5f 50 43 49 30 4c 50 43 30 53 4d 49 43 75 46 46  _PCI0LPC0SMICuFF
  5e90: 53 54 a1 27 a0 25 5c 2e 5f 53 42 5f 4f 4b 45 43  ST.'.%\._SB_OKEC
  5ea0: 70 0a 00 5c 2f 05 5f 53 42 5f 50 43 49 30 4c 50  p..\/._SB_PCI0LP
  5eb0: 43 30 45 43 30 5f 46 50 52 31 a0 38 7d 93 5c 2f  C0EC0_FPR1.8}.\/
  5ec0: 03 5f 53 42 5f 50 43 49 30 4d 59 4f 53 0a 01 93  ._SB_PCI0MYOS...
  5ed0: 5c 2f 03 5f 53 42 5f 50 43 49 30 4d 59 4f 53 0a  \/._SB_PCI0MYOS.
  5ee0: 03 00 5c 2f 03 5f 54 5a 5f 54 48 52 4d 5f 53 43  ..\/._TZ_THRM_SC
  5ef0: 50 0a 01 5b 82 49 06 46 41 4e 31 08 5f 48 49 44  P..[.I.FAN1._HID
  5f00: 0c 41 d0 0c 0b 08 5f 55 49 44 0a 02 08 5f 50 52  .A...._UID..._PR
  5f10: 30 12 0a 02 50 46 4e 30 50 46 4e 31 14 20 5f 50  0...PFN0PFN1. _P
  5f20: 53 30 00 70 0d 48 69 67 68 20 53 70 65 65 64 20  S0.p.High Speed 
  5f30: 46 41 4e 20 2d 20 5f 50 53 30 00 5b 31 14 20 5f  FAN - _PS0.[1. _
  5f40: 50 53 33 00 70 0d 48 69 67 68 20 53 70 65 65 64  PS3.p.High Speed
  5f50: 20 46 41 4e 20 2d 20 5f 50 53 33 00 5b 31 5b 84   FAN - _PS3.[1[.
  5f60: 4c 16 50 46 4e 31 00 00 00 08 46 4e 53 32 0a 00  L.PFN1....FNS2..
  5f70: 14 0b 5f 53 54 41 00 a4 46 4e 53 32 14 47 08 5f  .._STA..FNS2.G._
  5f80: 4f 4e 5f 00 70 0a 01 46 4e 53 32 a0 3f 5c 2e 5f  ON_.p..FNS2.?\._
  5f90: 53 42 5f 4f 4b 45 43 70 0a ff 5c 2f 05 5f 53 42  SB_OKECp..\/._SB
  5fa0: 5f 50 43 49 30 4c 50 43 30 45 43 30 5f 46 53 50  _PCI0LPC0EC0_FSP
  5fb0: 44 70 0a 01 5c 2f 05 5f 53 42 5f 50 43 49 30 4c  Dp..\/._SB_PCI0L
  5fc0: 50 43 30 45 43 30 5f 46 50 52 31 a0 38 7d 93 5c  PC0EC0_FPR1.8}.\
  5fd0: 2f 03 5f 53 42 5f 50 43 49 30 4d 59 4f 53 0a 01  /._SB_PCI0MYOS..
  5fe0: 93 5c 2f 03 5f 53 42 5f 50 43 49 30 4d 59 4f 53  .\/._SB_PCI0MYOS
  5ff0: 0a 03 00 5c 2f 03 5f 54 5a 5f 54 48 52 4d 5f 53  ...\/._TZ_THRM_S
  6000: 43 50 0a 01 14 47 0c 5f 4f 46 46 00 70 00 46 4e  CP...G._OFF.p.FN
  6010: 53 32 70 0a 00 46 4e 53 32 a0 41 05 5c 2f 03 5f  S2p..FNS2.A.\/._
  6020: 54 5a 5f 50 46 4e 30 46 4e 53 31 a0 3f 5c 2e 5f  TZ_PFN0FNS1.?\._
  6030: 53 42 5f 4f 4b 45 43 70 0a b4 5c 2f 05 5f 53 42  SB_OKECp..\/._SB
  6040: 5f 50 43 49 30 4c 50 43 30 45 43 30 5f 46 53 50  _PCI0LPC0EC0_FSP
  6050: 44 70 0a 01 5c 2f 05 5f 53 42 5f 50 43 49 30 4c  Dp..\/._SB_PCI0L
  6060: 50 43 30 45 43 30 5f 46 50 52 31 a1 27 a0 25 5c  PC0EC0_FPR1.'.%\
  6070: 2e 5f 53 42 5f 4f 4b 45 43 70 0a 00 5c 2f 05 5f  ._SB_OKECp..\/._
  6080: 53 42 5f 50 43 49 30 4c 50 43 30 45 43 30 5f 46  SB_PCI0LPC0EC0_F
  6090: 50 52 31 a0 38 7d 93 5c 2f 03 5f 53 42 5f 50 43  PR1.8}.\/._SB_PC
  60a0: 49 30 4d 59 4f 53 0a 01 93 5c 2f 03 5f 53 42 5f  I0MYOS...\/._SB_
  60b0: 50 43 49 30 4d 59 4f 53 0a 03 00 5c 2f 03 5f 54  PCI0MYOS...\/._T
  60c0: 5a 5f 54 48 52 4d 5f 53 43 50 0a 01 5b 85 40 19  Z_THRM_SCP..[.-4b8TPpkIZ3Q@public.gmane.org
  60d0: 54 48 52 4d 08 5f 41 4c 30 12 06 01 46 41 4e 31  THRM._AL0...FAN1
  60e0: 14 0b 5f 41 43 30 00 a4 54 41 43 30 08 5f 41 4c  .._AC0..TAC0._AL
  60f0: 31 12 06 01 46 41 4e 30 14 0b 5f 41 43 31 00 a4  1...FAN0.._AC1..
  6100: 54 41 43 31 14 0b 5f 43 52 54 00 a4 54 50 43 5f  TAC1.._CRT..TPC_
  6110: 14 0b 5f 50 53 56 00 a4 54 50 41 53 08 5f 54 53  .._PSV..TPAS._TS
  6120: 50 0a 64 14 4a 07 5f 54 4d 50 00 a0 48 06 5c 2e  P.d.J._TMP..H.\.
  6130: 5f 53 42 5f 4f 4b 45 43 70 5c 2f 05 5f 53 42 5f  _SB_OKECp\/._SB_
  6140: 50 43 49 30 4c 50 43 30 45 43 30 5f 43 54 4d 50  PCI0LPC0EC0_CTMP
  6150: 61 70 0d 43 75 72 72 65 6e 74 20 54 65 6d 70 65  ap.Current Tempe
  6160: 72 61 74 75 72 65 20 69 73 20 2d 2d 2d 2d 2d 2d  rature is ------
  6170: 2d 2d 2d 2d 2d 20 00 5b 31 70 61 5b 31 70 61 5c  ----- .[1pa[1pa\
  6180: 2e 5f 53 42 5f 43 4d 32 35 72 77 61 0a 0a 00 54  ._SB_CM25rwa...T
  6190: 42 53 45 61 a1 07 70 4c 54 4d 50 61 a4 61 08 5f  BSEa..pLTMPa.a._
  61a0: 50 53 4c 12 0c 01 5c 2e 5f 50 52 5f 43 50 55 30  PSL...\._PR_CPU0
  61b0: 08 5f 54 43 31 0a 02 08 5f 54 43 32 0a 03 14 4f  ._TC1..._TC2...O
  61c0: 09 5f 53 43 50 01 70 00 50 4c 43 59 a0 47 04 5c  ._SCP.p.PLCY.G.\
  61d0: 2f 03 5f 54 5a 5f 50 46 4e 30 46 4e 53 31 a0 23  /._TZ_PFN0FNS1.#
  61e0: 93 5c 2f 03 5f 54 5a 5f 50 46 4e 31 46 4e 53 32  .\/._TZ_PFN1FNS2
  61f0: 0a 00 70 0b 22 0d 54 41 43 31 70 0b 86 0d 54 41  ..p.".TAC1p...TA
  6200: 43 30 a1 11 70 0b 22 0d 54 41 43 31 70 0b 40 0d  C0..p.".TAC1p.-4b8TPpkIZ3Q@public.gmane.org
  6210: 54 41 43 30 a1 34 a0 20 5c 2f 03 5f 54 5a 5f 50  TAC0.4. \/._TZ_P
  6220: 46 4e 31 46 4e 53 32 70 0b 22 0d 54 41 43 31 70  FN1FNS2p.".TAC1p
  6230: 0b 40 0d 54 41 43 30 a1 11 70 0b 40 0d 54 41 43  .-2fubbyhCYJThvxM+mQhndA@public.gmane.org@.TAC
  6240: 31 70 0b 86 0d 54 41 43 30 70 0b 44 0e 54 50 41  1p...TAC0p.D.TPA
  6250: 53 86 5c 2e 5f 54 5a 5f 54 48 52 4d 0a 81 5b 82  S.\._TZ_THRM..[.
  6260: 0f 53 4c 50 42 08 5f 48 49 44 0c 41 d0 0c 0e 5b  .SLPB._HID.A...[
  6270: 80 45 58 43 4f 01 0a 72 0a 02 5b 81 10 45 58 43  .EXCO..r..[..EXC
  6280: 4f 01 49 4e 44 58 08 44 41 54 41 08 5b 86 4a 08  O.INDX.DATA.[.J.
  6290: 49 4e 44 58 44 41 54 41 01 00 40 10 41 43 53 54  INDXDATA..-TW69a6i3BRk@public.gmane.org
  62a0: 01 4f 4b 45 43 01 50 4f 50 46 01 42 4c 54 46 01  .OKEC.POPF.BLTF.
  62b0: 57 32 4b 46 02 53 34 57 50 01 46 4c 41 37 01 4c  W2KF.S4WP.FLA7.L
  62c0: 53 46 47 01 4c 44 31 30 01 50 53 32 4d 01 44 49  SFG.LD10.PS2M.DI
  62d0: 53 44 03 4f 56 52 4c 01 00 01 53 4c 45 45 08 42  SD.OVRL...SLEE.B
  62e0: 50 46 47 08 50 57 53 54 08 43 4d 32 35 08 43 4d  PFG.PWST.CM25.CM
  62f0: 32 36 08 43 4d 32 37 08 43 4d 32 38 10 43 4d 32  26.CM27.CM28.CM2
  6300: 41 10 46 34 46 47 01 00 1f 43 4d 33 30 08 43 4d  A.F4FG...CM30.CM
  6310: 33 31 08 43 4d 33 32 08                          31.CM32.

FACS @ 0x1ff7bfc0
  0000: 46 41 43 53 40 00 00 00 4b 13 00 00 00 00 00 00  FACS-WPglUrM47s3jshiNgxcy3g@public.gmane.org
  0010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  0020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  0030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................

BOOT @ 0x1ff7afd8
  0000: 42 4f 4f 54 28 00 00 00 01 9e 41 43 45 52 20 20  BOOT(.....ACER  
  0010: 43 61 72 64 69 6e 61 6c 19 09 02 20 20 4c 54 50  Cardinal...  LTP
  0020: 01 00 00 00 37 00 00 00                          ....7...


--l76fUT7nc3MelDdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dmesg

# dmesg -s40000 | grep -i acpi
 BIOS-e820: 000000001ff70000 - 000000001ff7b000 (ACPI data)
 BIOS-e820: 000000001ff7b000 - 000000001ff80000 (ACPI NVS)
ACPI: RSDP (v000 ACER                                      ) @ 0x000f60c0
ACPI: RSDT (v001 ACER   Cardinal 0x20020919  LTP 0x00000000) @ 0x1ff74c20
ACPI: FADT (v001 ACER   Cardinal 0x20020919 PTL  0x0000001e) @ 0x1ff7af64
ACPI: BOOT (v001 ACER   Cardinal 0x20020919  LTP 0x00000001) @ 0x1ff7afd8
ACPI: DSDT (v001 ACER   Cardinal 0x20020919 MSFT 0x0100000d) @ 0x00000000
ACPI: Subsystem revision 20031002
ACPI: IRQ 9 was Edge Triggered, setting to Level Triggerd
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs *10)
ACPI: PCI Interrupt Link [LNKB] (IRQs *10)
ACPI: PCI Interrupt Link [LNKC] (IRQs *10)
ACPI: PCI Interrupt Link [LNKD] (IRQs *5)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 9 11 12)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 9 11 12)
ACPI: PCI Interrupt Link [LNKG] (IRQs 10)
ACPI: PCI Interrupt Link [LNKH] (IRQs *10)
ACPI: Embedded Controller [EC0] (gpe 29)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB_._PRT]
ACPI: Power Resource [PFN0] (off)
ACPI: Power Resource [PFN1] (off)
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 10
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
ACPI: AC Adapter [ACAD] (on-line)
ACPI: Battery Slot [BAT1] (battery absent)
ACPI: Battery Slot [BAT2] (battery absent)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Fan [FAN0] (off)
ACPI: Fan [FAN1] (off)
ACPI: Processor [CPU0] (supports C1 C2 C3)
ACPI: Thermal Zone [THRM] (49 C)
cpufreq: No CPUs supporting ACPI performance management found.
ACPI: (supports S0 S3 S4 S5)

--l76fUT7nc3MelDdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dmidecode

# dmidecode 2.3
SMBIOS 2.31 present.
24 structures occupying 1085 bytes.
Table at 0x000CF810.
Handle 0x0000
	DMI type 0, 20 bytes.
	BIOS Information
		Vendor: ACER   
		Version: 4A14
		Release Date: 09/19/2003
		Address: 0xE4580
		Runtime Size: 113280 bytes
		ROM Size: 512 kB
		Characteristics:
			ISA is supported
			PCI is supported
			PC Card (PCMCIA) is supported
			PNP is supported
			APM is supported
			BIOS is upgradeable
			BIOS shadowing is allowed
			ESCD support is available
			Boot from CD is supported
			3.5"/720 KB floppy services are supported (int 13h)
			Print screen service is supported (int 5h)
			8042 keyboard services are supported (int 9h)
			Serial services are supported (int 14h)
			Printer services are supported (int 17h)
			ACPI is supported
			USB legacy is supported
			AGP is supported
			Smart battery is supported
			BIOS boot specification is supported
Handle 0x0001
	DMI type 1, 25 bytes.
	System Information
		Manufacturer: Acer
		Product Name: TravelMate 800
		Version: Rev 1                   
		Serial Number: LXT250609034306D50EF05
		UUID: 6057F3EE-B206-D811-8CD1-00C09F2F78F1
		Wake-up Type: Power Switch
Handle 0x0002
	DMI type 2, 8 bytes.
	Base Board Information
		Manufacturer: Acer
		Product Name: TravelMate 800
		Version: Rev 1.0                 
		Serial Number: LXT250609034306D50EF05
Handle 0x0003
	DMI type 3, 17 bytes.
	Chassis Information
		Manufacturer: Acer
		Type: Notebook
		Lock: Not Present
		Version: Rev.1                   
		Serial Number: LXT250609034306D50EF05
		Asset Tag: ................................     
		Boot-up State: Safe
		Power Supply State: Safe
		Thermal State: Safe
		Security Status: None
		OEM Information: 0x00001234
Handle 0x0004
	DMI type 4, 35 bytes.
	Processor Information
		Socket Designation: uFCPGA2
		Type: Central Processor
		Family: Pentium M
		Manufacturer: Intel
		ID: 95 06 00 00 BF F9 E9 A7
		Signature: Type 0, Family 6, Model 9, Stepping 5
		Flags:
			FPU (Floating-point unit on-chip)
			VME (Virtual mode extension)
			DE (Debugging extension)
			PSE (Page size extension)
			TSC (Time stamp counter)
			MSR (Model specific registers)
			MCE (Machine check exception)
			CX8 (CMPXCHG8 instruction supported)
			SEP (Fast system call)
			MTRR (Memory type range registers)
			PGE (Page global enable)
			MCA (Machine check architecture)
			CMOV (Conditional move instruction supported)
			PAT (Page attribute table)
			CLFSH (CLFLUSH instruction supported)
			DS (Debug store)
			ACPI (ACPI supported)
			MMX (MMX technology supported)
			FXSR (Fast floating-point save and restore)
			SSE (Streaming SIMD extensions)
			SSE2 (Streaming SIMD extensions 2)
			TM (Thermal monitor supported)
			SBF (Signal break on FERR)
		Version: Intel(R) Pentium(R) M processor
		Voltage: 1.2 V
		External Clock: 400 MHz
		Max Speed: 1600 MHz
		Current Speed: 1600 MHz
		Status: Populated, Enabled
		Upgrade: ZIF Socket
		L1 Cache Handle: 0x0008
		L2 Cache Handle: 0x0009
		L3 Cache Handle: Not Provided
		Serial Number: Not Specified
		Asset Tag: Not Specified
		Part Number: Not Specified
Handle 0x0005
	DMI type 5, 20 bytes.
	Memory Controller Information
		Error Detecting Method: None
		Error Correcting Capabilities:
			None
		Supported Interleave: One-way Interleave
		Current Interleave: One-way Interleave
		Maximum Memory Module Size: 1024 MB
		Maximum Total Memory Size: 2048 MB
		Supported Speeds:
			60 ns
		Supported Memory Types:
			DIMM
		Memory Module Voltage: 3.3 V
		Associated Memory Slots: 2
			0x0006
			0x0007
		Enabled Error Correcting Capabilities:
			None
Handle 0x0006
	DMI type 6, 12 bytes.
	Memory Module Information
		Socket Designation: DIMM 1
		Bank Connections: 0 1
		Current Speed: 75 ns
		Type: DIMM SDRAM
		Installed Size: 256 MB (Double-bank Connection)
		Enabled Size: 256 MB (Double-bank Connection)
		Error Status: OK
Handle 0x0007
	DMI type 6, 12 bytes.
	Memory Module Information
		Socket Designation: DIMM 2
		Bank Connections: 2 3
		Current Speed: 75 ns
		Type: DIMM SDRAM
		Installed Size: 256 MB (Double-bank Connection)
		Enabled Size: 256 MB (Double-bank Connection)
		Error Status: OK
Handle 0x0008
	DMI type 7, 19 bytes.
	Cache Information
		Socket Designation: L1 Cache
		Configuration: Enabled, Not Socketed, Level 1
		Operational Mode: Write Back
		Location: Internal
		Installed Size: 32 KB
		Maximum Size: 32 KB
		Supported SRAM Types:
			Burst
			Pipeline Burst
			Asynchronous
		Installed SRAM Type: Asynchronous
		Speed: Unknown
		Error Correction Type: Unknown
		System Type: Unknown
		Associativity: Unknown
Handle 0x0009
	DMI type 7, 19 bytes.
	Cache Information
		Socket Designation: L2 Cache
		Configuration: Enabled, Not Socketed, Level 2
		Operational Mode: Write Back
		Location: External
		Installed Size: 1024 KB
		Maximum Size: 1024 KB
		Supported SRAM Types:
			Burst
			Pipeline Burst
			Asynchronous
		Installed SRAM Type: Burst
		Speed: Unknown
		Error Correction Type: Unknown
		System Type: Unknown
		Associativity: Unknown
Handle 0x000A
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: LPT 1
		Internal Connector Type: None
		External Reference Designator: Parallel
		External Connector Type: DB-25 female
		Port Type: Parallel Port ECP/EPP
Handle 0x000B
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: U28
		Internal Connector Type: None
		External Reference Designator: PS/2 Mouse
		External Connector Type: Circular DIN-8 male
		Port Type: Keyboard Port
Handle 0x000C
	DMI type 9, 13 bytes.
	System Slot Information
		Designation: PCMCIA socket 0
		Type: 32-bit PC Card (PCMCIA)
		Current Usage: Unknown
		Length: Long
		ID: Adapter 0, Socket 0
		Characteristics:
			5.0 V is provided
			3.3 V is provided
			PC Card-16 is supported
			Cardbus is supported
			Modem ring resume is supported
			PME signal is supported
			Hot-plug devices are supported
Handle 0x000D
	DMI type 10, 10 bytes.
	On Board Device Information
		Type: Video
		Status: Disabled
		Description: ATI M9
	On Board Device Information
		Type: Sound
		Status: Disabled
		Description: AC97 Audio
	On Board Device Information
		Type: Other
		Status: Disabled
		Description: TI TSB43AB21 IEEE-1394 Controller
Handle 0x000E
	DMI type 11, 5 bytes.
	OEM Strings
		String 1: SMBIOS 2.3
		String 2: Customer Reference Platform
Handle 0x000F
	DMI type 15, 29 bytes.
	System Event Log
		Area Length: 0 bytes
		Header Start Offset: 0x0000
		Header Length: 16 bytes
		Data Start Offset: 0x0010
		Access Method: Memory-mapped physical 32-bit address
		Access Address: 0x00000000
		Status: Invalid, Not Full
		Change Token: 0x00000020
		Header Format: Type 1
		Supported Log Type Descriptors: 3
		Descriptor 1: POST error
		Data Format 1: POST results bitmap
		Descriptor 2: Single-bit ECC memory error
		Data Format 2: Multiple-event
		Descriptor 3: Multi-bit ECC memory error
		Data Format 3: Multiple-event
Handle 0x0010
	DMI type 16, 15 bytes.
	Physical Memory Array
		Location: System Board Or Motherboard
		Use: System Memory
		Error Correction Type: None
		Maximum Capacity: 1 GB
		Error Information Handle: Not Provided
		Number Of Devices: 2
Handle 0x0011
	DMI type 17, 27 bytes.
	Memory Device
		Array Handle: 0x0010
		Error Information Handle: No Error
		Total Width: 64 bits
		Data Width: 64 bits
		Size: 256 MB
		Form Factor: DIMM
		Set: 1
		Locator: DIMM 0
		Bank Locator: Bank 0, 1
		Type: SRAM
		Type Detail: Synchronous
		Speed: 266 MHz (3.8 ns)
		Manufacturer: Not Specified
		Serial Number: Not Specified
		Asset Tag: Not Specified
		Part Number: Not Specified
Handle 0x0012
	DMI type 17, 27 bytes.
	Memory Device
		Array Handle: 0x0010
		Error Information Handle: No Error
		Total Width: 64 bits
		Data Width: 64 bits
		Size: 256 MB
		Form Factor: DIMM
		Set: 1
		Locator: DIMM 1
		Bank Locator: Bank 2, 3
		Type: SRAM
		Type Detail: Synchronous
		Speed: 266 MHz (3.8 ns)
		Manufacturer: Not Specified
		Serial Number: Not Specified
		Asset Tag: Not Specified
		Part Number: Not Specified
Handle 0x0013
	DMI type 19, 15 bytes.
	Memory Array Mapped Address
		Starting Address: 0x00000000000
		Ending Address: 0x0001FFFFFFF
		Range Size: 512 MB
		Physical Array Handle: 0x0010
		Partition Width: 0
Handle 0x0014
	DMI type 20, 19 bytes.
	Memory Device Mapped Address
		Starting Address: 0x00000000000
		Ending Address: 0x0000FFFFFFF
		Range Size: 256 MB
		Physical Device Handle: 0x0011
		Memory Array Mapped Address Handle: 0x0013
		Partition Row Position: 1
		Interleave Position: 1
Handle 0x0015
	DMI type 20, 19 bytes.
	Memory Device Mapped Address
		Starting Address: 0x00010000000
		Ending Address: 0x0001FFFFFFF
		Range Size: 256 MB
		Physical Device Handle: 0x0012
		Memory Array Mapped Address Handle: 0x0013
		Partition Row Position: 1
		Interleave Position: 1
Handle 0x0016
	DMI type 32, 20 bytes.
	System Boot Information
		Status: <OUT OF SPEC>
Handle 0x0017
	DMI type 127, 4 bytes.
	End Of Table

--l76fUT7nc3MelDdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=interrupts

           CPU0       
  0:   67020995          XT-PIC  timer
  1:      77284          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  5:     899583          XT-PIC  uhci_hcd, eth0
  8:          4          XT-PIC  rtc
  9:      71449          XT-PIC  acpi
 10:    4148886          XT-PIC  Intel 82801DB-ICH4, ehci_hcd, uhci_hcd, uhci_hcd, radeon-D5X1nVylZaA@public.gmane.org:1:0:0
 12:       2050          XT-PIC  i8042
 14:     216298          XT-PIC  ide0
 15:          0          XT-PIC  ide1
NMI:          0 
ERR:          0

--l76fUT7nc3MelDdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=lspci

00:00.0 Host bridge: Intel Corp. 82855PM Processor to I/O Controller (rev 03)
	Subsystem: Acer Incorporated [ALI]: Unknown device 001f
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort+ <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=256M]
	Capabilities: [e4] #09 [f104]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x1

00:01.0 PCI bridge: Intel Corp. 82855PM Processor to AGP Controller (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 96
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 00003000-00003fff
	Memory behind bridge: d0100000-d01fffff
	Prefetchable memory behind bridge: d8000000-dfffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:1d.0 USB Controller: Intel Corp. 82801DB USB (Hub #1) (rev 03) (prog-if 00 [UHCI])
	Subsystem: Acer Incorporated [ALI]: Unknown device 001f
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 10
	Region 4: I/O ports at 1800 [size=32]

00:1d.1 USB Controller: Intel Corp. 82801DB USB (Hub #2) (rev 03) (prog-if 00 [UHCI])
	Subsystem: Acer Incorporated [ALI]: Unknown device 001f
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 5
	Region 4: I/O ports at 1820 [size=32]

00:1d.2 USB Controller: Intel Corp. 82801DB USB (Hub #3) (rev 03) (prog-if 00 [UHCI])
	Subsystem: Acer Incorporated [ALI]: Unknown device 001f
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 10
	Region 4: I/O ports at 1840 [size=32]

00:1d.7 USB Controller: Intel Corp. 82801DB USB2 (rev 03) (prog-if 20 [EHCI])
	Subsystem: Acer Incorporated [ALI]: Unknown device 001f
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 10
	Region 0: Memory at d0000000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] #0a [2080]

00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 83) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort+ <TAbort- <MAbort- >SERR- <PERR+
	Latency: 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
	I/O behind bridge: 00004000-00004fff
	Memory behind bridge: d0200000-d05fffff
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp. 82801DBM LPC Interface Controller (rev 03)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:1f.1 IDE interface: Intel Corp. 82801DBM Ultra ATA Storage Controller (rev 03) (prog-if 8a [Master SecP PriP])
	Subsystem: Acer Incorporated [ALI]: Unknown device 001f
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at <unassigned>
	Region 1: I/O ports at <unassigned>
	Region 2: I/O ports at <unassigned>
	Region 3: I/O ports at <unassigned>
	Region 4: I/O ports at 1860 [size=16]
	Region 5: Memory at 20000000 (32-bit, non-prefetchable) [size=1K]

00:1f.3 SMBus: Intel Corp. 82801DB/DBM SMBus Controller (rev 03)
	Subsystem: Acer Incorporated [ALI]: Unknown device 001f
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 10
	Region 4: I/O ports at 1880 [size=32]

00:1f.5 Multimedia audio controller: Intel Corp. 82801DB AC'97 Audio Controller (rev 03)
	Subsystem: Acer Incorporated [ALI]: Unknown device 001f
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 10
	Region 0: I/O ports at 1c00 [size=256]
	Region 1: I/O ports at 18c0 [size=64]
	Region 2: Memory at d0000c00 (32-bit, non-prefetchable) [size=512]
	Region 3: Memory at d0000800 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1f.6 Modem: Intel Corp. 82801DB AC'97 Modem Controller (rev 03) (prog-if 00 [Generic])
	Subsystem: Acer Incorporated [ALI]: Unknown device 001f
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 10
	Region 0: I/O ports at 2400 [size=256]
	Region 1: I/O ports at 2000 [size=128]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R250 Lf [Radeon Mobility 9000 M9] (rev 02) (prog-if 00 [VGA])
	Subsystem: Acer Incorporated [ALI]: Unknown device 001f
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR+ FastB2B+
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 66 (2000ns min), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at d8000000 (32-bit, prefetchable) [size=128M]
	Region 1: I/O ports at 3000 [size=256]
	Region 2: Memory at d0100000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [58] AGP version 2.0
		Status: RQ=48 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
		Command: RQ=32 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x1
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:02.0 Ethernet controller: Broadcom Corporation BCM4401 100Base-T (rev 01)
	Subsystem: Acer Incorporated [ALI]: Unknown device 001f
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort+ <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at d0204000 (32-bit, non-prefetchable) [size=8K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

02:04.0 Network controller: Intel Corp. PRO/Wireless LAN 2100 3B Mini PCI Adapter (rev 04)
	Subsystem: Intel Corp.: Unknown device 2527
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 8500ns max), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at d0206000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-

02:06.0 CardBus bridge: O2 Micro, Inc.: Unknown device 7114 (rev 20)
	Subsystem: Acer Incorporated [ALI]: Unknown device 001f
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at d0207000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=02, secondary=03, subordinate=06, sec-latency=176
	Memory window 0: d0400000-d04ff000 (prefetchable)
	Memory window 1: d0300000-d03ff000 (prefetchable)
	I/O window 0: 00004400-000044ff
	I/O window 1: 00004000-000040ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite-
	16-bit legacy interface ports at 0001

02:06.1 CardBus bridge: O2 Micro, Inc.: Unknown device 7114 (rev 20)
	Subsystem: Acer Incorporated [ALI]: Unknown device 001f
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at 20001000 (32-bit, non-prefetchable) [disabled] [size=4K]
	Bus: primary=02, secondary=07, subordinate=0a, sec-latency=176
	I/O window 0: 00000000-00000003 [disabled]
	I/O window 1: 00000000-00000003 [disabled]
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- PostWrite-
	16-bit legacy interface ports at 0001

02:06.2 System peripheral: O2 Micro, Inc.: Unknown device 7110
	Subsystem: Acer Incorporated [ALI]: Unknown device 001f
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at d0208000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:07.0 FireWire (IEEE 1394): Texas Instruments TSB43AB21 IEEE-1394a-2000 Controller (PHY/Link) (prog-if 10 [OHCI])
	Subsystem: Acer Incorporated [ALI]: Unknown device 001f
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 1000ns max), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at d0209000 (32-bit, non-prefetchable) [size=2K]
	Region 1: Memory at d0200000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-


--l76fUT7nc3MelDdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=kernel_config

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_BUS=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
CONFIG_ACPI_RELAXED_AML=y

--l76fUT7nc3MelDdI--


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
