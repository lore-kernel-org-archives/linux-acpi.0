From: Bernt Hansen <bernt-CNteSEi18yz3fQ9qLvQP4Q@public.gmane.org>
Subject: Re: Toshiba ACPI battery status - ACPI errors
Date: Mon, 24 Nov 2003 17:34:25 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031124223425.GA10489@norang.ca>
References: <7F740D512C7C1046AB53446D37200173618752@scsmsx402.sc.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="jI8keyz6grp/JLjh"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <7F740D512C7C1046AB53446D37200173618752-exJ48ZlmiLrcnAH0NVKmOFDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Nakajima, Jun" <jun.nakajima-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I'm having problems getting the status of the two batteries in my new
Toshiba Tecra S1 laptop.

The dmesg log reports
ACPI: Using PIC for interrupt routing
    ACPI-1120: *** Error: Method execution failed [\_SB_.BAT0._STA]
(Node dff61fe0), AE_NOT_EXIST
    ACPI-1120: *** Error: Method execution failed [\_SB_.BAT1._STA]
(Node dff61ea0), AE_NOT_EXIST
ACPI: PCI Root Bridge [PCI0] (00:00)

Attached are dumps for:
	acpidmp
	dmesg -s40000
	dmidecode
from this laptop.

Let me know if there are any other details I can provide.

Thanks,
Bernt.

On Mon, Nov 24, 2003 at 01:04:22PM -0800, Nakajima, Jun wrote:
> I suspect this is a known issue with AML code from Toshiba. Their _STA
> does not return a value explicitly, but (wrongly) expects the AML
> interpreter to get the return value returned by the function _STA is
> calling, like
> 	Method (_STA, ....) {
> 		AAA(...)
> 	}
> Instead of 
> 	Method (_STA, ....) {
> 		Return (AAA(...))
> 	}
> 
> If you can provide ACPI dump data of the machine, that would be helpful
> when identifying the cause. Copy the ACPI mailing list and Len.
> 
> 	Jun
-- 
Bernt Hansen     Norang Consulting Inc.

--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Description: acpidmp log output
Content-Disposition: attachment; filename="acpidump.log"

RSDP "OID_00" @ 0x000e6010
  0000: 52 53 44 20 50 54 52 20 8e 4f 49 44 5f 30 30 00  RSD PTR .OID_00.
  0010: f0 aa ff 1f                                      ....

RSDT @ 0x1fffaaf0
  0000: 52 53 44 54 34 00 00 00 01 c0 49 4e 53 59 44 45  RSDT4.....INSYDE
  0010: 52 53 44 54 5f 30 30 30 01 00 00 00 5f 43 53 49  RSDT_000...._CSI
  0020: 01 01 01 00 00 fb ff 1f 90 fb ff 1f c0 fb ff 1f  ................
  0030: 30 ab ff 1f                                      0...

FACP @ 0x1ffffb00
  0000: 46 41 43 50 74 00 00 00 01 f5 49 4e 53 59 44 45  FACPt.....INSYDE
  0010: 46 41 43 50 5f 30 30 30 00 01 00 00 5f 43 53 49  FACP_000...._CSI
  0020: 01 01 01 00 c0 ff ff 1f 70 af ff 1f 00 00 09 00  ........p.......
  0030: b2 00 00 00 e0 e1 e2 80 00 10 00 00 00 00 00 00  ................
  0040: 04 10 00 00 00 00 00 00 20 10 00 00 08 10 00 00  ........ .......
  0050: 28 10 00 00 00 00 00 00 04 02 01 04 08 00 20 85  (............. .
  0060: 01 00 55 00 00 00 00 00 01 03 0d 00 00 03 00 00  ..U.............
  0070: a5 02 00 00                                      ....

DSDT @ 0x1fffaf70
  0000: 44 53 44 54 87 4b 00 00 01 0b 54 4f 53 49 4e 56  DSDT.K....TOSINV
  0010: 49 4e 54 38 31 30 00 00 02 10 00 00 49 4e 54 4c  INT810......INTL
  0020: 36 20 00 02 08 56 45 52 53 12 32 03 0d 50 72 6f  6 ...VERS.2..Pro
  0030: 6a 65 63 74 3a 20 4f 45 4d 78 00 0d 44 61 74 65  ject: OEMx..Date
  0040: 3a 20 30 33 2f 31 38 2f 32 30 30 32 00 0d 56 65  : 03/18/2002..Ve
  0050: 72 73 3a 20 31 2e 30 30 2e 30 34 00 10 49 10 5c  rs: 1.00.04..I.\
  0060: 5f 50 52 5f 5b 83 40 10 43 50 55 30 00 10 10 00  _PR_[.-zsH4aCspKG3hvxM+mQhndA@public.gmane.org
  0070: 00 06 14 43 0f 5f 43 53 54 00 a0 47 06 0a 01 a4  ...C._CST..G....
  0080: 12 41 06 04 0a 03 12 1e 04 11 14 0a 11 82 0c 00  .A..............
  0090: 7f 00 00 00 00 00 00 00 00 00 00 00 79 00 0a 01  ............y...
  00a0: 0a 01 0b e8 03 12 1e 04 11 14 0a 11 82 0c 00 01  ................
  00b0: 08 00 00 14 10 00 00 00 00 00 00 79 00 0a 02 0a  ...........y....
  00c0: 02 0b f4 01 12 1d 04 11 14 0a 11 82 0c 00 01 08  ................
  00d0: 00 00 15 10 00 00 00 00 00 00 79 00 0a 03 0a b9  ..........y.....
  00e0: 0a fa a1 43 08 a4 12 4f 07 05 0a 04 12 1e 04 11  ...C...O........
  00f0: 14 0a 11 82 0c 00 7f 08 00 00 00 00 00 00 00 00  ................
  0100: 00 00 79 00 0a 01 0a 01 0b e8 03 12 1e 04 11 14  ..y.............
  0110: 0a 11 82 0c 00 01 08 00 00 14 10 00 00 00 00 00  ................
  0120: 00 79 00 0a 02 0a 01 0b f4 01 12 1d 04 11 14 0a  .y..............
  0130: 11 82 0c 00 01 08 00 00 15 10 00 00 00 00 00 00  ................
  0140: 79 00 0a 03 0a 55 0a fa 12 1d 04 11 14 0a 11 82  y....U..........
  0150: 0c 00 01 08 00 00 16 10 00 00 00 00 00 00 79 00  ..............y.
  0160: 0a 03 0a b9 0a 64 10 46 12 5c 5f 47 50 45 14 18  .....d.F.\_GPE..
  0170: 5f 4c 30 33 00 86 5c 2f 03 5f 53 42 5f 50 43 49  _L03..\/._SB_PCI
  0180: 30 55 53 42 30 0a 02 14 18 5f 4c 30 34 00 86 5c  0USB0...._L04..\
  0190: 2f 03 5f 53 42 5f 50 43 49 30 55 53 42 31 0a 02  /._SB_PCI0USB1..
  01a0: 14 18 5f 4c 30 35 00 86 5c 2f 03 5f 53 42 5f 50  .._L05..\/._SB_P
  01b0: 43 49 30 4d 43 39 37 0a 02 14 20 5f 4c 30 41 00  CI0MC97... _L0A.
  01c0: 86 5c 2e 5f 53 42 5f 42 41 54 30 0a 02 86 5c 2e  .\._SB_BAT0...\.
  01d0: 5f 53 42 5f 42 41 54 31 0a 02 14 25 5f 4c 30 42  _SB_BAT1...%_L0B
  01e0: 00 86 5c 2f 03 5f 53 42 5f 50 43 49 30 50 43 49  ..\/._SB_PCI0PCI
  01f0: 32 0a 02 86 5c 2e 5f 53 42 5f 50 42 54 4e 0a 02  2...\._SB_PBTN..
  0200: 14 18 5f 4c 30 43 00 86 5c 2f 03 5f 53 42 5f 50  .._L0C..\/._SB_P
  0210: 43 49 30 55 53 42 32 0a 02 14 18 5f 4c 30 44 00  CI0USB2...._L0D.
  0220: 86 5c 2f 03 5f 53 42 5f 50 43 49 30 55 53 42 33  .\/._SB_PCI0USB3
  0230: 0a 02 14 4a 05 5f 4c 31 38 00 70 5c 2f 05 5f 53  ...J._L18.p\/._S
  0240: 42 5f 50 43 49 30 4c 50 43 42 45 43 30 5f 4c 49  B_PCI0LPCBEC0_LI
  0250: 44 43 60 a0 2a 93 60 4c 49 44 53 86 5c 2f 04 5f  DC`.*.`LIDS.\/._
  0260: 53 42 5f 50 43 49 30 4c 50 43 42 4b 42 43 5f 0a  SB_PCI0LPCBKBC_.
  0270: 80 86 5c 2e 5f 53 42 5f 50 42 54 4e 0a 02 a1 0e  ..\._SB_PBTN....
  0280: 86 5c 2e 5f 53 42 5f 4c 49 44 5f 0a 80 08 5c 45  .\._SB_LID_...\E
  0290: 43 4f 4e 0a 00 08 5c 44 46 45 43 0a 00 08 5c 54  CON...\DFEC...\T
  02a0: 54 4d 50 0a 00 08 5c 41 43 49 4e 0a 00 08 5c 42  TMP...\ACIN...\B
  02b0: 41 49 4e 0a 00 08 4d 59 4f 53 00 08 5c 4c 49 44  AIN...MYOS..\LID
  02c0: 53 0a 00 08 5c 50 52 53 54 0a 00 08 5c 41 43 43  S...\PRST...\ACC
  02d0: 48 0a 00 08 5c 54 50 4f 4b 0a 00 08 5c 41 43 50  H...\TPOK...\ACP
  02e0: 53 0a 00 08 5c 53 41 43 50 0a 00 08 5c 51 45 31  S...\SACP...\QE1
  02f0: 32 0a 00 08 5c 51 43 4e 54 0a 00 08 5c 51 4f 44  2...\QCNT...\QOD
  0300: 44 0a 00 08 5c 4d 42 5f 54 0a 00 5b 80 53 4d 49  D...\MB_T..[.SMI
  0310: 4f 01 0a b2 0a 02 5b 81 10 53 4d 49 4f 01 41 50  O.....[..SMIO.AP
  0320: 4d 43 08 41 50 4d 44 08 5b 80 58 43 4d 4f 01 0a  MC.APMD.[.XCMO..
  0330: 72 0a 02 5b 81 10 58 43 4d 4f 01 43 49 4e 58 08  r..[..XCMO.CINX.
  0340: 43 44 41 54 08 5b 86 17 43 49 4e 58 43 44 41 54  CDAT.[..CINXCDAT
  0350: 01 00 40 30 4d 58 30 31 08 4d 58 30 32 08 5b 80  ..-H+3VQ8Nx8mdhRW/cqzTaRw@public.gmane.org[.
  0360: 45 43 4d 42 01 0b 00 03 0a 02 5b 81 10 45 43 4d  ECMB......[..ECM
  0370: 42 01 4d 49 4e 58 08 4d 44 41 54 08 5b 86 2d 4d  B.MINX.MDAT.[.-M
  0380: 49 4e 58 4d 44 41 54 01 00 40 47 00 03 53 5f 41  INXMDAT..-/VmInDyowS4@public.gmane.org
  0390: 43 01 00 03 4d 42 53 34 01 00 02 44 4b 41 50 01  C...MBS4...DKAP.
  03a0: 00 05 00 05 4d 42 54 53 01 00 02 5b 80 50 4d 49  ....MBTS...[.PMI
  03b0: 4f 01 0b 00 10 0a 80 5b 81 31 50 4d 49 4f 03 00  O......[.1PMIO..
  03c0: 08 50 42 53 54 01 00 07 00 40 07 00 01 54 48 52  .PBST....-wn3Z3WZxF74@public.gmane.org
  03d0: 4f 03 45 54 48 52 01 00 4b 19 00 0c 4b 42 43 53  O.ETHR..K...KBCS
  03e0: 01 00 13 00 0c 4b 42 43 45 01 5b 80 47 50 49 4f  .....KBCE.[.GPIO
  03f0: 01 0b 00 13 0a 30 5b 81 2c 47 50 49 4f 03 55 53  .....0[.,GPIO.US
  0400: 53 45 20 49 4f 53 45 20 00 20 47 4c 56 4c 20 00  SE IOSE . GLVL .
  0410: 20 47 54 54 4c 20 42 4c 4e 4b 20 00 20 00 20 47   GTTL BLNK . . G
  0420: 49 4e 56 20 5b 80 53 4d 30 32 01 0b 00 14 0a 08  INV [.SM02......
  0430: 5b 81 2b 53 4d 30 32 01 53 53 54 41 08 00 08 53  [.+SM02.SSTA...S
  0440: 43 54 4c 08 53 43 4d 44 08 53 58 49 54 08 53 48  CTL.SCMD.SXIT.SH
  0450: 44 30 08 53 48 44 31 08 53 42 4c 4b 08 5b 80 50  D0.SHD1.SBLK.[.P
  0460: 54 38 30 01 0a 80 0a 01 5b 81 0b 50 54 38 30 01  T80.....[..PT80.
  0470: 50 38 30 54 08 5b 80 53 47 50 49 01 0b 10 03 0a  P80T.[.SGPI.....
  0480: 09 5b 81 33 53 47 50 49 01 00 08 00 08 00 08 00  .[.3SGPI........
  0490: 08 00 08 00 08 00 08 00 08 48 44 44 52 01 42 41  .........HDDR.BA
  04a0: 59 52 01 00 01 42 41 59 50 01 00 02 43 42 52 5f  YR...BAYP...CBR_
  04b0: 01 4d 50 43 52 01 5b 80 4d 42 4f 58 00 0c 00 fc  .MPCR.[.MBOX....
  04c0: ff 1f 0a 10 5b 81 47 06 4d 42 4f 58 10 44 54 4c  ....[.G.MBOX.DTL
  04d0: 4f 08 44 54 48 49 08 00 07 4b 42 44 57 01 55 54  O.DTHI...KBDW.UT
  04e0: 59 50 02 00 02 47 4d 4f 44 03 00 01 00 05 4d 44  YP...GMOD.....MD
  04f0: 4f 44 03 43 4d 41 44 04 43 4d 42 44 04 50 54 59  OD.CMAD.CMBD.PTY
  0500: 50 02 45 50 44 41 01 00 01 4c 50 54 45 02 00 01  P.EPDA...LPTE...
  0510: 45 50 50 54 01 45 54 4c 4f 08 45 54 48 49 08 00  EPPT.ETLO.ETHI..
  0520: 05 57 41 4b 52 01 00 02 43 4c 4d 54 02 08 5c 5f  .WAKR...CLMT..\_
  0530: 53 30 5f 12 0a 04 0a 00 0a 00 0a 00 0a 00 08 5c  S0_............\
  0540: 5f 53 33 5f 12 0a 04 0a 05 0a 05 0a 00 0a 00 08  _S3_............
  0550: 5c 5f 53 34 5f 12 0a 04 0a 06 0a 06 0a 00 0a 00  \_S4_...........
  0560: 08 5c 5f 53 35 5f 12 0a 04 0a 07 0a 07 0a 00 0a  .\_S5_..........
  0570: 00 14 46 19 5c 5f 50 54 53 01 a2 0c 50 42 53 54  ..F.\_PTS...PBST
  0580: 70 0a 01 50 42 53 54 a0 4a 09 93 68 0a 03 5c 2e  p..PBST.J..h..\.
  0590: 5f 53 42 5f 47 53 4d 49 0a 22 70 0a 00 54 50 4f  _SB_GSMI."p..TPO
  05a0: 4b a0 1f 4b 42 44 57 70 0a 01 5c 2f 05 5f 53 42  K..KBDWp..\/._SB
  05b0: 5f 50 43 49 30 4c 50 43 42 45 43 30 5f 45 4b 42  _PCI0LPCBEC0_EKB
  05c0: 44 70 5c 2f 05 5f 53 42 5f 50 43 49 30 4c 50 43  Dp\/._SB_PCI0LPC
  05d0: 42 45 43 30 5f 4c 49 44 43 4c 49 44 53 70 0a 01  BEC0_LIDCLIDSp..
  05e0: 5c 2f 05 5f 53 42 5f 50 43 49 30 4c 50 43 42 45  \/._SB_PCI0LPCBE
  05f0: 43 30 5f 45 4c 49 44 5c 2e 5f 53 42 5f 47 53 4d  C0_ELID\._SB_GSM
  0600: 49 0a 0d 5c 2e 5f 53 42 5f 47 53 4d 49 0a 13 5c  I..\._SB_GSMI..\
  0610: 2e 5f 53 42 5f 47 53 4d 49 0a 16 70 0a 53 50 38  ._SB_GSMI..p.SP8
  0620: 30 54 a1 45 0e a0 42 08 93 68 0a 04 70 0a 01 5c  0T.E..B..h..p..\
  0630: 2f 05 5f 53 42 5f 50 43 49 30 4c 50 43 42 45 43  /._SB_PCI0LPCBEC
  0640: 30 5f 45 4c 49 44 70 0a 01 5c 2f 05 5f 53 42 5f  0_ELIDp..\/._SB_
  0650: 50 43 49 30 4c 50 43 42 45 43 30 5f 45 54 53 34  PCI0LPCBEC0_ETS4
  0660: 70 0a 01 4d 42 53 34 a0 39 92 94 4d 59 4f 53 0a  p..MBS4.9..MYOS.
  0670: 02 5c 2e 5f 53 42 5f 47 53 4d 49 0a 23 5c 2e 5f  .\._SB_GSMI.#\._
  0680: 53 42 5f 47 53 4d 49 0a 1f 5c 2e 5f 53 42 5f 47  SB_GSMI..\._SB_G
  0690: 53 4d 49 0a 0a 5c 2e 5f 53 42 5f 47 53 4d 49 0a  SMI..\._SB_GSMI.
  06a0: 16 70 0a 54 50 38 30 54 a1 4f 05 70 0a 55 50 38  .p.TP80T.O.p.UP8
  06b0: 30 54 70 0a 00 5c 2f 05 5f 53 42 5f 50 43 49 30  0Tp..\/._SB_PCI0
  06c0: 4c 50 43 42 45 43 30 5f 53 4d 49 45 70 0a 00 4d  LPCBEC0_SMIEp..M
  06d0: 42 53 34 a0 2d 92 94 4d 59 4f 53 0a 02 5c 2e 5f  BS4.-..MYOS..\._
  06e0: 53 42 5f 47 53 4d 49 0a 23 5c 2e 5f 53 42 5f 47  SB_GSMI.#\._SB_G
  06f0: 53 4d 49 0a 0a 5c 2e 5f 53 42 5f 47 53 4d 49 0a  SMI..\._SB_GSMI.
  0700: 16 70 0a 56 50 38 30 54 14 42 35 5c 5f 57 41 4b  .p.VP80T.B5\_WAK
  0710: 01 70 0a 00 51 43 4e 54 70 0a 00 51 45 31 32 a0  .p..QCNTp..QE12.
  0720: 32 5c 2f 05 5f 53 42 5f 50 43 49 30 4c 50 43 42  2\/._SB_PCI0LPCB
  0730: 45 43 30 5f 42 4c 57 32 86 5c 2e 5f 53 42 5f 42  EC0_BLW2.\._SB_B
  0740: 41 54 30 0a 80 86 5c 2e 5f 53 42 5f 42 41 54 31  AT0...\._SB_BAT1
  0750: 0a 80 a0 4c 17 93 68 0a 03 a0 4d 05 92 95 4d 59  ...L..h...M...MY
  0760: 4f 53 0a 02 7b 5c 2f 04 5f 53 42 5f 50 43 49 30  OS..{\/._SB_PCI0
  0770: 55 53 42 33 4d 42 41 52 0a 00 5c 2f 04 5f 53 42  USB3MBAR..\/._SB
  0780: 5f 50 43 49 30 55 53 42 33 4d 42 41 52 7d 5c 2f  _PCI0USB3MBAR}\/
  0790: 04 5f 53 42 5f 50 43 49 30 4c 50 43 42 46 44 49  ._SB_PCI0LPCBFDI
  07a0: 53 0b 00 80 5c 2f 04 5f 53 42 5f 50 43 49 30 4c  S...\/._SB_PCI0L
  07b0: 50 43 42 46 44 49 53 5c 2e 5f 53 42 5f 47 53 4d  PCBFDIS\._SB_GSM
  07c0: 49 0a 14 5c 2e 5f 53 42 5f 47 53 4d 49 0a 15 70  I..\._SB_GSMI..p
  07d0: 0a 01 60 70 5c 2f 05 5f 53 42 5f 50 43 49 30 4c  ..`p\/._SB_PCI0L
  07e0: 50 43 42 45 43 30 5f 41 43 53 54 60 70 60 53 5f  PCBEC0_ACST`p`S_
  07f0: 41 43 86 5c 2e 5f 53 42 5f 41 43 5f 5f 0a 00 70  AC.\._SB_AC__..p
  0800: 5c 2f 05 5f 53 42 5f 50 43 49 30 4c 50 43 42 45  \/._SB_PCI0LPCBE
  0810: 43 30 5f 42 31 53 54 60 a0 12 93 60 0a 01 86 5c  C0_B1ST`...`...\
  0820: 2e 5f 53 42 5f 42 41 54 30 0a 81 70 5c 2f 05 5f  ._SB_BAT0..p\/._
  0830: 53 42 5f 50 43 49 30 4c 50 43 42 45 43 30 5f 42  SB_PCI0LPCBEC0_B
  0840: 32 53 54 60 a0 12 93 60 0a 01 86 5c 2e 5f 53 42  2ST`...`...\._SB
  0850: 5f 42 41 54 31 0a 81 86 5c 2f 03 5f 53 42 5f 50  _BAT1...\/._SB_P
  0860: 43 49 30 55 53 42 30 0a 00 86 5c 2f 03 5f 53 42  CI0USB0...\/._SB
  0870: 5f 50 43 49 30 55 53 42 31 0a 00 86 5c 2f 03 5f  _PCI0USB1...\/._
  0880: 53 42 5f 50 43 49 30 55 53 42 32 0a 00 86 5c 2f  SB_PCI0USB2...\/
  0890: 03 5f 53 42 5f 50 43 49 30 55 53 42 33 0a 00 5c  ._SB_PCI0USB3..\
  08a0: 2e 5f 53 42 5f 47 53 4d 49 0a 03 a0 19 41 50 4d  ._SB_GSMI....APM
  08b0: 44 86 5c 2e 5f 53 42 5f 50 42 54 4e 0a 02 70 0a  D.\._SB_PBTN..p.
  08c0: 00 41 50 4d 44 70 0a e3 50 38 30 54 a4 0a 00 a1  .APMDp..P80T....
  08d0: 4b 18 a0 4c 17 93 68 0a 04 70 0a 00 4d 42 53 34  K..L..h..p..MBS4
  08e0: 70 0a 00 5c 2f 05 5f 53 42 5f 50 43 49 30 4c 50  p..\/._SB_PCI0LP
  08f0: 43 42 45 43 30 5f 45 54 53 34 a0 4d 05 92 95 4d  CBEC0_ETS4.M...M
  0900: 59 4f 53 0a 02 7b 5c 2f 04 5f 53 42 5f 50 43 49  YOS..{\/._SB_PCI
  0910: 30 55 53 42 33 4d 42 41 52 0a 00 5c 2f 04 5f 53  0USB3MBAR..\/._S
  0920: 42 5f 50 43 49 30 55 53 42 33 4d 42 41 52 7d 5c  B_PCI0USB3MBAR}\
  0930: 2f 04 5f 53 42 5f 50 43 49 30 4c 50 43 42 46 44  /._SB_PCI0LPCBFD
  0940: 49 53 0b 00 80 5c 2f 04 5f 53 42 5f 50 43 49 30  IS...\/._SB_PCI0
  0950: 4c 50 43 42 46 44 49 53 5c 2e 5f 53 42 5f 47 53  LPCBFDIS\._SB_GS
  0960: 4d 49 0a 15 70 0a 01 60 70 5c 2f 05 5f 53 42 5f  MI..p..`p\/._SB_
  0970: 50 43 49 30 4c 50 43 42 45 43 30 5f 41 43 53 54  PCI0LPCBEC0_ACST
  0980: 60 70 60 53 5f 41 43 86 5c 2e 5f 53 42 5f 41 43  `p`S_AC.\._SB_AC
  0990: 5f 5f 0a 00 70 5c 2f 05 5f 53 42 5f 50 43 49 30  __..p\/._SB_PCI0
  09a0: 4c 50 43 42 45 43 30 5f 42 31 53 54 60 a0 12 93  LPCBEC0_B1ST`...
  09b0: 60 0a 01 86 5c 2e 5f 53 42 5f 42 41 54 30 0a 81  `...\._SB_BAT0..
  09c0: 70 5c 2f 05 5f 53 42 5f 50 43 49 30 4c 50 43 42  p\/._SB_PCI0LPCB
  09d0: 45 43 30 5f 42 32 53 54 60 a0 12 93 60 0a 01 86  EC0_B2ST`...`...
  09e0: 5c 2e 5f 53 42 5f 42 41 54 31 0a 81 86 5c 2f 03  \._SB_BAT1...\/.
  09f0: 5f 53 42 5f 50 43 49 30 55 53 42 33 0a 00 86 5c  _SB_PCI0USB3...\
  0a00: 2f 03 5f 53 42 5f 50 43 49 30 55 53 42 31 0a 00  /._SB_PCI0USB1..
  0a10: 86 5c 2f 03 5f 53 42 5f 50 43 49 30 55 53 42 32  .\/._SB_PCI0USB2
  0a20: 0a 00 86 5c 2f 03 5f 53 42 5f 50 43 49 30 55 53  ...\/._SB_PCI0US
  0a30: 42 30 0a 00 86 5c 2e 5f 53 42 5f 50 42 54 4e 0a  B0...\._SB_PBTN.
  0a40: 02 70 0a e4 50 38 30 54 5b 22 0a 64 a4 0a 00 a1  .p..P80T[".d....
  0a50: 0b 70 0a e5 50 38 30 54 a4 0a 00 08 43 54 50 42  .p..P80T....CTPB
  0a60: 11 0c 0a 09 2d 32 3c 46 4b 55 5a 68 6a 08 4d 54  ....-2<FKUZhj.MT
  0a70: 50 42 11 0c 0a 09 2d 32 3c 46 4b 55 5a 68 6a 08  PB....-2<FKUZhj.
  0a80: 50 54 50 42 11 0c 0a 09 2d 32 3c 46 52 57 4b 50  PTPB....-2<FRWKP
  0a90: 6a 08 42 54 50 42 11 0c 0a 09 3e 44 46 4c 4e 54  j.BTPB....>DFLNT
  0aa0: 36 3c 6a 08 54 52 4f 4e 0a 00 14 49 07 43 48 47  6<j.TRON...I.CHG
  0ab0: 54 01 a0 0e 93 68 0a 00 70 4d 54 50 42 43 54 50  T....h..pMTPBCTP
  0ac0: 42 a0 0e 93 68 0a 01 70 50 54 50 42 43 54 50 42  B...h..pPTPBCTPB
  0ad0: a0 0e 93 68 0a 02 70 42 54 50 42 43 54 50 42 8c  ...h..pBTPBCTPB.
  0ae0: 43 54 50 42 0a 06 50 53 50 4c 8c 43 54 50 42 0a  CTPB..PSPL.CTPB.
  0af0: 07 50 53 50 48 8c 43 54 50 42 0a 08 43 52 54 54  .PSPH.CTPB..CRTT
  0b00: 70 50 53 50 4c 50 41 53 4c 70 50 53 50 48 50 41  pPSPLPASLpPSPHPA
  0b10: 53 48 70 50 41 53 48 50 54 4d 50 70 43 52 54 54  SHpPASHPTMPpCRTT
  0b20: 43 54 54 50 08 50 4c 43 59 0a 01 08 43 54 4d 50  CTTP.PLCY...CTMP
  0b30: 0a 00 08 54 46 53 54 0a 00 08 45 41 43 30 0a 2d  ...TFST...EAC0.-
  0b40: 08 54 4d 50 4c 0a 2d 08 54 4d 50 4d 0a 32 08 54  .TMPL.-.TMPM.2.T
  0b50: 4d 50 48 0a 46 08 43 46 53 50 0a 00 08 50 54 4d  MPH.F.CFSP...PTM
  0b60: 50 0a 68 08 50 41 53 48 0a 68 08 50 41 53 4c 0a  P.h.PASH.h.PASL.
  0b70: 5a 08 43 54 54 50 0a 6a 14 47 19 53 54 45 56 01  Z.CTTP.j.G.STEV.
  0b80: 8c 43 54 50 42 0a 00 54 50 4c 30 8c 43 54 50 42  .CTPB..TPL0.CTPB
  0b90: 0a 01 54 50 48 30 8c 43 54 50 42 0a 02 54 50 4c  ..TPH0.CTPB..TPL
  0ba0: 31 8c 43 54 50 42 0a 03 54 50 48 31 8c 43 54 50  1.CTPB..TPH1.CTP
  0bb0: 42 0a 04 54 50 4c 32 8c 43 54 50 42 0a 05 54 50  B..TPL2.CTPB..TP
  0bc0: 48 32 8c 43 54 50 42 0a 06 50 53 50 4c 8c 43 54  H2.CTPB..PSPL.CT
  0bd0: 50 42 0a 07 50 53 50 48 8c 43 54 50 42 0a 08 43  PB..PSPH.CTPB..C
  0be0: 52 54 54 70 54 50 4c 30 45 41 43 30 70 68 60 a0  RTTpTPL0EAC0ph`.
  0bf0: 1e 95 60 54 50 48 30 70 0a 00 54 4d 50 4c 70 54  ..`TPH0p..TMPLpT
  0c00: 50 48 30 54 4d 50 48 70 0a 00 43 46 53 50 a1 4d  PH0TMPHp..CFSP.M
  0c10: 0a a0 27 90 95 60 54 50 48 31 94 60 54 50 4c 30  ..'..`TPH1.`TPL0
  0c20: 70 54 50 4c 30 54 4d 50 4c 70 54 50 48 31 54 4d  pTPL0TMPLpTPH1TM
  0c30: 50 48 70 0a 32 43 46 53 50 a1 42 08 a0 27 90 95  PHp.2CFSP.B..'..
  0c40: 60 54 50 48 32 94 60 54 50 4c 31 70 54 50 4c 31  `TPH2.`TPL1pTPL1
  0c50: 54 4d 50 4c 70 54 50 48 32 54 4d 50 48 70 0a 4b  TMPLpTPH2TMPHp.K
  0c60: 43 46 53 50 a1 47 05 a0 30 90 95 60 50 53 50 48  CFSP.G..0..`PSPH
  0c70: 94 60 54 50 4c 32 70 54 50 4c 32 54 4d 50 4c 70  .`TPL2pTPL2TMPLp
  0c80: 50 53 50 48 54 4d 50 48 70 50 53 50 48 50 54 4d  PSPHTMPHpPSPHPTM
  0c90: 50 70 0a 63 43 46 53 50 a1 23 70 50 53 50 4c 54  Pp.cCFSP.#pPSPLT
  0ca0: 4d 50 4c 70 43 52 54 54 54 4d 50 48 70 50 53 50  MPLpCRTTTMPHpPSP
  0cb0: 4c 50 54 4d 50 70 0a 63 43 46 53 50 70 54 4d 50  LPTMPp.cCFSPpTMP
  0cc0: 4c 5c 2f 05 5f 53 42 5f 50 43 49 30 4c 50 43 42  L\/._SB_PCI0LPCB
  0cd0: 45 43 30 5f 4c 54 4d 50 70 54 4d 50 48 5c 2f 05  EC0_LTMPpTMPH\/.
  0ce0: 5f 53 42 5f 50 43 49 30 4c 50 43 42 45 43 30 5f  _SB_PCI0LPCBEC0_
  0cf0: 48 54 4d 50 70 43 46 53 50 5c 2f 05 5f 53 42 5f  HTMPpCFSP\/._SB_
  0d00: 50 43 49 30 4c 50 43 42 45 43 30 5f 46 41 4e 53  PCI0LPCBEC0_FANS
  0d10: 08 46 31 53 54 0a 00 10 4e 2e 5c 5f 54 5a 5f 5b  .F1ST...N.\_TZ_[
  0d20: 84 3c 50 46 41 31 00 00 00 14 0b 5f 53 54 41 00  .<PFA1....._STA.
  0d30: a4 46 31 53 54 14 13 5f 4f 4e 5f 00 70 0a 01 46  .F1ST.._ON_.p..F
  0d40: 31 53 54 a0 05 45 43 4f 4e 14 13 5f 4f 46 46 00  1ST..ECON.._OFF.
  0d50: 70 0a 00 46 31 53 54 a0 05 45 43 4f 4e 5b 84 42  p..F1ST..ECON[.B
  0d60: 0b 50 46 41 30 00 00 00 14 1d 5f 53 54 41 00 a0  .PFA0....._STA..
  0d70: 12 45 43 4f 4e 70 45 54 48 52 60 a0 04 60 a4 01  .ECONpETHR`..`..
  0d80: a4 00 a1 03 a4 00 14 42 04 5f 4f 4e 5f 00 70 0a  .......B._ON_.p.
  0d90: 01 60 a0 36 45 43 4f 4e a0 30 93 45 54 48 52 0a  .`.6ECON.0.ETHR.
  0da0: 00 5c 2e 5f 53 42 5f 47 53 4d 49 0a 17 5b 22 0a  .\._SB_GSMI..[".
  0db0: 64 70 50 41 53 4c 50 54 4d 50 70 0a 01 54 52 4f  dpPASLPTMPp..TRO
  0dc0: 4e 86 5c 5f 54 5a 5f 0a 80 14 47 04 5f 4f 46 46  N.\_TZ_...G._OFF
  0dd0: 00 70 0a 01 60 a0 3b 45 43 4f 4e a0 35 90 45 54  .p..`.;ECON.5.ET
  0de0: 48 52 93 54 52 4f 4e 0a 01 5c 2e 5f 53 42 5f 47  HR.TRON..\._SB_G
  0df0: 53 4d 49 0a 18 5b 22 0a 64 70 50 41 53 48 50 54  SMI..[".dpPASHPT
  0e00: 4d 50 70 0a 00 54 52 4f 4e 86 5c 5f 54 5a 5f 0a  MPp..TRON.\_TZ_.
  0e10: 80 5b 82 28 46 41 4e 30 08 5f 48 49 44 0c 41 d0  .[.(FAN0._HID.A.
  0e20: 0c 0b 08 5f 55 49 44 0a 01 08 5f 50 52 30 12 0c  ..._UID..._PR0..
  0e30: 01 5c 2e 5f 54 5a 5f 50 46 41 30 5b 82 28 46 41  .\._TZ_PFA0[.(FA
  0e40: 4e 31 08 5f 48 49 44 0c 41 d0 0c 0b 08 5f 55 49  N1._HID.A...._UI
  0e50: 44 0a 02 08 5f 50 52 30 12 0c 01 5c 2e 5f 54 5a  D..._PR0...\._TZ
  0e60: 5f 50 46 41 31 5b 85 4f 19 54 48 5a 4e 14 45 10  _PFA1[.O.THZN.E.
  0e70: 5f 54 4d 50 08 a0 47 0f 45 43 4f 4e 70 5c 2f 05  _TMP..G.ECONp\/.
  0e80: 5f 53 42 5f 50 43 49 30 4c 50 43 42 45 43 30 5f  _SB_PCI0LPCBEC0_
  0e90: 43 43 50 54 60 70 60 43 54 4d 50 a0 4a 05 93 54  CCPT`p`CTMP.J..T
  0ea0: 50 4f 4b 0a 00 70 5c 2f 05 5f 53 42 5f 50 43 49  POK..p\/._SB_PCI
  0eb0: 30 4c 50 43 42 45 43 30 5f 4c 54 4d 50 61 70 5c  0LPCBEC0_LTMPap\
  0ec0: 2f 05 5f 53 42 5f 50 43 49 30 4c 50 43 42 45 43  /._SB_PCI0LPCBEC
  0ed0: 30 5f 48 54 4d 50 62 a0 15 91 92 93 54 4d 50 4c  0_HTMPb.....TMPL
  0ee0: 61 92 93 54 4d 50 48 62 53 54 45 56 60 a1 08 70  a..TMPHbSTEV`..p
  0ef0: 0a 01 54 50 4f 4b a0 1f 93 54 46 53 54 0a 00 43  ..TPOK...TFST..C
  0f00: 48 47 54 43 4c 4d 54 70 0a 01 54 46 53 54 53 54  HGTCLMTp..TFSTST
  0f10: 45 56 43 54 4d 50 a1 48 04 70 54 4d 50 48 61 70  EVCTMP.H.pTMPHap
  0f20: 54 4d 50 4c 62 a0 10 91 95 60 62 94 60 61 53 54  TMPLb....`b.`aST
  0f30: 45 56 43 54 4d 50 a1 28 a0 26 92 93 5c 2f 05 5f  EVCTMP.(.&..\/._
  0f40: 53 42 5f 50 43 49 30 4c 50 43 42 45 43 30 5f 48  SB_PCI0LPCBEC0_H
  0f50: 54 4d 50 54 4d 50 48 53 54 45 56 43 54 4d 50 a4  TMPTMPHSTEVCTMP.
  0f60: 72 0b ac 0a 77 43 54 4d 50 0a 0a 00 00 a1 05 a4  r...wCTMP.......
  0f70: 0b 80 0c 14 19 5f 41 43 31 00 70 45 41 43 30 60  ....._AC1.pEAC0`
  0f80: 72 60 0b 11 01 60 77 60 0a 0a 60 a4 60 14 19 5f  r`...`w`..`.`.._
  0f90: 41 43 30 00 70 50 54 4d 50 60 72 60 0b 11 01 60  AC0.pPTMP`r`...`
  0fa0: 77 60 0a 0a 60 a4 60 08 5f 41 4c 30 12 0c 01 5c  w`..`.`._AL0...\
  0fb0: 2e 5f 54 5a 5f 46 41 4e 30 08 5f 41 4c 31 12 0c  ._TZ_FAN0._AL1..
  0fc0: 01 5c 2e 5f 54 5a 5f 46 41 4e 31 14 14 5f 43 52  .\._TZ_FAN1.._CR
  0fd0: 54 00 a4 72 0b ac 0a 77 43 54 54 50 0a 0a 00 00  T..r...wCTTP....
  0fe0: 14 0c 5f 53 43 50 01 70 68 50 4c 43 59 08 5f 50  .._SCP.phPLCY._P
  0ff0: 53 4c 12 0c 01 5c 2e 5f 50 52 5f 43 50 55 30 08  SL...\._PR_CPU0.
  1000: 5f 54 53 50 0a 96 10 80 b8 03 5c 5f 53 42 5f 5b  _TSP......\_SB_[
  1010: 82 4f 04 4c 49 44 5f 08 5f 48 49 44 0c 41 d0 0c  .O.LID_._HID.A..
  1020: 0d 14 32 5f 4c 49 44 00 a0 26 45 43 4f 4e a0 1b  ..2_LID..&ECON..
  1030: 5c 2f 05 5f 53 42 5f 50 43 49 30 4c 50 43 42 45  \/._SB_PCI0LPCBE
  1040: 43 30 5f 4c 49 44 43 a4 0a 00 a1 04 a4 0a 01 a1  C0_LIDC.........
  1050: 04 a4 0a 01 08 5f 50 52 57 12 06 02 0a 18 0a 04  ....._PRW.......
  1060: 5b 82 0f 50 42 54 4e 08 5f 48 49 44 0c 41 d0 0c  [..PBTN._HID.A..
  1070: 0c 5b 82 48 11 41 43 5f 5f 08 5f 48 49 44 0d 41  .[.H.AC__._HID.A
  1080: 43 50 49 30 30 30 33 00 08 5f 50 43 4c 12 1b 03  CPI0003.._PCL...
  1090: 5c 5f 53 42 5f 5c 2e 5f 53 42 5f 42 41 54 30 5c  \_SB_\._SB_BAT0\
  10a0: 2e 5f 53 42 5f 42 41 54 31 08 4d 42 42 41 0b 00  ._SB_BAT1.MBBA..
  10b0: 03 5b 80 4d 42 49 4e 01 4d 42 42 41 0a 02 5b 81  .[.MBIN.MBBA..[.
  10c0: 10 4d 42 49 4e 01 4d 4c 49 4e 08 4d 4c 44 54 08  .MBIN.MLIN.MLDT.
  10d0: 14 40 0b 5f 50 53 52 00 a0 43 06 93 44 46 45 43  .-MMfLXvIapvTbuulzktEIGQ@public.gmane.org
  10e0: 0a 00 a0 45 05 45 43 4f 4e 70 5c 2f 05 5f 53 42  ...E.ECONp\/._SB
  10f0: 5f 50 43 49 30 4c 50 43 42 45 43 30 5f 41 43 53  _PCI0LPCBEC0_ACS
  1100: 54 60 a0 1b 93 60 0a 01 70 0a 00 5c 2f 04 5f 53  T`...`..p..\/._S
  1110: 42 5f 50 43 49 30 4c 50 43 42 43 34 43 33 a1 17  B_PCI0LPCBC4C3..
  1120: 70 0a 01 5c 2f 04 5f 53 42 5f 50 43 49 30 4c 50  p..\/._SB_PCI0LP
  1130: 43 42 43 34 43 33 a4 60 a1 03 a4 01 a1 03 a4 01  CBC4C3.`........
  1140: 5b 23 5c 5f 47 4c 5f ff ff 70 0a a0 4d 4c 49 4e  [#\_GL_..p..MLIN
  1150: 70 4d 4c 44 54 60 5b 27 5c 5f 47 4c 5f a0 08 93  pMLDT`['\_GL_...
  1160: 60 0a 77 a4 0a 01 70 5c 2f 05 5f 53 42 5f 50 43  `.w...p\/._SB_PC
  1170: 49 30 4c 50 43 42 45 43 30 5f 50 42 41 43 60 a4  I0LPCBEC0_PBAC`.
  1180: 60 14 09 5f 53 54 41 00 a4 0a 0f 08 42 49 46 31  `.._STA.....BIF1
  1190: 12 37 0d 0a 01 0c ff ff ff ff 0c ff ff ff ff 0a  .7..............
  11a0: 01 0c ff ff ff ff 0c ff ff ff ff 0c ff ff ff ff  ................
  11b0: 0c ff ff ff ff 0c ff ff ff ff 0d 20 00 0d 20 00  ........... .. .
  11c0: 0d 4c 69 2d 49 00 0d 00 08 42 53 54 31 12 11 04  .Li-I....BST1...
  11d0: 0a 00 0c ff ff ff ff 0c ff ff ff ff 0b 5c 2b 08  .............\+.
  11e0: 42 49 46 32 12 37 0d 0a 01 0c ff ff ff ff 0c ff  BIF2.7..........
  11f0: ff ff ff 0a 01 0c ff ff ff ff 0c ff ff ff ff 0c  ................
  1200: ff ff ff ff 0c ff ff ff ff 0c ff ff ff ff 0d 20  ............... 
  1210: 00 0d 20 00 0d 4c 69 2d 49 00 0d 00 08 42 53 54  .. ..Li-I....BST
  1220: 32 12 11 04 0a 00 0c ff ff ff ff 0c ff ff ff ff  2...............
  1230: 0b 5c 2b 5b 82 42 35 42 41 54 30 08 5f 48 49 44  .\+[.B5BAT0._HID
  1240: 0c 41 d0 0c 0a 08 5f 55 49 44 0a 01 08 5f 50 43  .A...._UID..._PC
  1250: 4c 12 07 01 5c 5f 53 42 5f 08 4d 42 42 53 0b 00  L...\_SB_.MBBS..
  1260: 03 5b 80 4d 42 49 44 01 4d 42 42 53 0a 02 5b 81  .[.MBID.MBBS..[.
  1270: 10 4d 42 49 44 01 4d 42 49 4e 08 4d 42 44 54 08  .MBID.MBIN.MBDT.
  1280: 08 5f 50 52 57 12 06 02 0a 0a 0a 04 14 45 04 5f  ._PRW........E._
  1290: 53 54 41 00 a0 0b 93 44 46 45 43 0a 01 a4 0a 0f  STA....DFEC.....
  12a0: a0 2c 45 43 4f 4e 70 5c 2f 05 5f 53 42 5f 50 43  .,ECONp\/._SB_PC
  12b0: 49 30 4c 50 43 42 45 43 30 5f 42 31 53 54 60 a0  I0LPCBEC0_B1ST`.
  12c0: 08 93 60 0a 01 a4 0a 1f a1 04 a4 0a 0f a1 04 a4  ..`.............
  12d0: 0a 0f 14 42 14 5f 42 49 46 00 a0 0d 93 44 46 45  ...B._BIF....DFE
  12e0: 43 0a 01 a4 42 49 46 31 a0 49 10 45 43 4f 4e 70  C...BIF1.I.ECONp
  12f0: 5c 2f 05 5f 53 42 5f 50 43 49 30 4c 50 43 42 45  \/._SB_PCI0LPCBE
  1300: 43 30 5f 4c 46 43 31 60 70 5c 2f 05 5f 53 42 5f  C0_LFC1`p\/._SB_
  1310: 50 43 49 30 4c 50 43 42 45 43 30 5f 44 45 53 31  PCI0LPCBEC0_DES1
  1320: 61 70 61 88 42 49 46 31 0a 01 00 70 60 88 42 49  apa.BIF1...p`.BI
  1330: 46 31 0a 02 00 70 0b 98 3a 88 42 49 46 31 0a 04  F1...p..:.BIF1..
  1340: 00 70 0a 00 62 70 62 88 42 49 46 31 0a 05 00 70  .p..bpb.BIF1...p
  1350: 0a 00 64 70 64 88 42 49 46 31 0a 06 00 74 62 64  ..dpd.BIF1...tbd
  1360: 66 70 66 88 42 49 46 31 0a 07 00 74 60 62 67 70  fpf.BIF1...t`bgp
  1370: 67 88 42 49 46 31 0a 08 00 70 5c 2f 05 5f 53 42  g.BIF1...p\/._SB
  1380: 5f 50 43 49 30 4c 50 43 42 45 43 30 5f 42 31 52  _PCI0LPCBEC0_B1R
  1390: 53 60 a0 1c 93 60 0a 01 70 0d 36 30 32 37 41 30  S`...`..p.6027A0
  13a0: 30 30 36 34 30 31 00 88 42 49 46 31 0a 09 00 a1  006401..BIF1....
  13b0: 18 70 0d 36 30 32 37 41 30 30 30 36 33 30 31 00  .p.6027A0006301.
  13c0: 88 42 49 46 31 0a 09 00 70 5c 2f 05 5f 53 42 5f  .BIF1...p\/._SB_
  13d0: 50 43 49 30 4c 50 43 42 45 43 30 5f 42 31 53 4e  PCI0LPCBEC0_B1SN
  13e0: 60 70 49 54 4f 53 60 61 70 61 88 42 49 46 31 0a  `pITOS`apa.BIF1.
  13f0: 0a 00 a1 1d 70 0c ff ff ff ff 88 42 49 46 31 0a  ....p......BIF1.
  1400: 01 00 70 0c ff ff ff ff 88 42 49 46 31 0a 04 00  ..p......BIF1...
  1410: a4 42 49 46 31 14 41 17 5f 42 53 54 00 a0 0d 93  .BIF1.A._BST....
  1420: 44 46 45 43 0a 01 a4 42 53 54 31 5b 23 5c 5f 47  DFEC...BST1[#\_G
  1430: 4c 5f ff ff 70 0a a0 4d 42 49 4e 70 4d 42 44 54  L_..p..MBINpMBDT
  1440: 60 5b 27 5c 5f 47 4c 5f a0 39 93 60 0a 77 70 0a  `['\_GL_.9.`.wp.
  1450: 02 88 42 53 54 31 0a 00 00 70 0b dc 05 88 42 53  ..BST1...p....BS
  1460: 54 31 0a 01 00 70 0b d0 39 88 42 53 54 31 0a 02  T1...p..9.BST1..
  1470: 00 70 0b d0 39 88 42 53 54 31 0a 03 00 a4 42 53  .p..9.BST1....BS
  1480: 54 31 a0 48 0c 45 43 4f 4e 70 5c 2f 05 5f 53 42  T1.H.ECONp\/._SB
  1490: 5f 50 43 49 30 4c 50 43 42 45 43 30 5f 42 31 43  _PCI0LPCBEC0_B1C
  14a0: 47 61 70 5c 2f 05 5f 53 42 5f 50 43 49 30 4c 50  Gap\/._SB_PCI0LP
  14b0: 43 42 45 43 30 5f 42 31 44 43 60 79 61 0a 01 62  CBEC0_B1DC`ya..b
  14c0: 7d 60 62 63 a0 16 90 51 45 31 32 95 51 43 4e 54  }`bc...QE12.QCNT
  14d0: 0a 0a 70 0a 05 60 75 51 43 4e 54 a1 1a 70 5c 2f  ..p..`uQCNT..p\/
  14e0: 05 5f 53 42 5f 50 43 49 30 4c 50 43 42 45 43 30  ._SB_PCI0LPCBEC0
  14f0: 5f 42 31 42 4c 60 a0 0a 95 60 0a 05 7d 63 0a 04  _B1BL`...`..}c..
  1500: 63 70 63 88 42 53 54 31 0a 00 00 70 0b dc 05 88  cpc.BST1...p....
  1510: 42 53 54 31 0a 01 00 70 83 88 42 49 46 31 0a 02  BST1...p..BIF1..
  1520: 00 61 77 61 60 62 78 62 0a 64 63 62 70 62 88 42  .awa`bxb.dcbpb.B
  1530: 53 54 31 0a 02 00 70 83 88 42 49 46 31 0a 04 00  ST1...p..BIF1...
  1540: 63 70 63 88 42 53 54 31 0a 03 00 a1 36 70 0a 01  cpc.BST1....6p..
  1550: 88 42 53 54 31 0a 00 00 70 0c ff ff ff ff 88 42  .BST1...p......B
  1560: 53 54 31 0a 01 00 70 0c ff ff ff ff 88 42 53 54  ST1...p......BST
  1570: 31 0a 02 00 70 0c ff ff ff ff 88 42 53 54 31 0a  1...p......BST1.
  1580: 03 00 a4 42 53 54 31 14 32 49 54 4f 53 01 70 0d  ...BST1.2ITOS.p.
  1590: 00 60 70 0a 04 61 a2 21 61 76 61 7b 7a 68 79 61  .`p..a.!ava{zhya
  15a0: 0a 02 00 00 0a 0f 64 70 83 88 43 48 41 52 64 00  ......dp..CHARd.
  15b0: 62 73 60 62 65 70 65 60 a4 60 08 43 48 41 52 12  bs`bepe`.`.CHAR.
  15c0: 32 10 0d 30 00 0d 31 00 0d 32 00 0d 33 00 0d 34  2..0..1..2..3..4
  15d0: 00 0d 35 00 0d 36 00 0d 37 00 0d 38 00 0d 39 00  ..5..6..7..8..9.
  15e0: 0d 41 00 0d 42 00 0d 43 00 0d 44 00 0d 45 00 0d  .A..B..C..D..E..
  15f0: 46 00 5b 82 42 2f 42 41 54 31 08 5f 48 49 44 0c  F.[.B/BAT1._HID.
  1600: 41 d0 0c 0a 08 5f 55 49 44 0a 02 08 5f 50 43 4c  A...._UID..._PCL
  1610: 12 07 01 5c 5f 53 42 5f 08 5f 50 52 57 12 06 02  ...\_SB_._PRW...
  1620: 0a 0a 0a 04 14 45 04 5f 53 54 41 00 a0 0b 93 44  .....E._STA....D
  1630: 46 45 43 0a 01 a4 0a 0f a0 2c 45 43 4f 4e 70 5c  FEC......,ECONp\
  1640: 2f 05 5f 53 42 5f 50 43 49 30 4c 50 43 42 45 43  /._SB_PCI0LPCBEC
  1650: 30 5f 42 32 53 54 60 a0 08 93 60 0a 01 a4 0a 1f  0_B2ST`...`.....
  1660: a1 04 a4 0a 0f a1 04 a4 0a 0f 14 42 14 5f 42 49  ...........B._BI
  1670: 46 00 a0 0d 93 44 46 45 43 0a 01 a4 42 49 46 32  F....DFEC...BIF2
  1680: a0 49 10 45 43 4f 4e 70 5c 2f 05 5f 53 42 5f 50  .I.ECONp\/._SB_P
  1690: 43 49 30 4c 50 43 42 45 43 30 5f 4c 46 43 32 60  CI0LPCBEC0_LFC2`
  16a0: 70 5c 2f 05 5f 53 42 5f 50 43 49 30 4c 50 43 42  p\/._SB_PCI0LPCB
  16b0: 45 43 30 5f 44 45 53 32 61 70 61 88 42 49 46 32  EC0_DES2apa.BIF2
  16c0: 0a 01 00 70 60 88 42 49 46 32 0a 02 00 70 0b 98  ...p`.BIF2...p..
  16d0: 3a 88 42 49 46 32 0a 04 00 70 0a 00 62 70 62 88  :.BIF2...p..bpb.
  16e0: 42 49 46 32 0a 05 00 70 0a 00 64 70 64 88 42 49  BIF2...p..dpd.BI
  16f0: 46 32 0a 06 00 74 62 64 66 70 66 88 42 49 46 32  F2...tbdfpf.BIF2
  1700: 0a 07 00 74 60 62 67 70 67 88 42 49 46 32 0a 08  ...t`bgpg.BIF2..
  1710: 00 70 5c 2f 05 5f 53 42 5f 50 43 49 30 4c 50 43  .p\/._SB_PCI0LPC
  1720: 42 45 43 30 5f 42 32 52 53 60 a0 1c 93 60 0a 01  BEC0_B2RS`...`..
  1730: 70 0d 36 30 32 37 41 30 30 30 36 30 30 31 00 88  p.6027A0006001..
  1740: 42 49 46 32 0a 09 00 a1 18 70 0d 36 30 32 37 41  BIF2.....p.6027A
  1750: 30 30 30 34 38 30 31 00 88 42 49 46 32 0a 09 00  0004801..BIF2...
  1760: 70 5c 2f 05 5f 53 42 5f 50 43 49 30 4c 50 43 42  p\/._SB_PCI0LPCB
  1770: 45 43 30 5f 42 32 53 4e 60 70 49 54 4f 53 60 61  EC0_B2SN`pITOS`a
  1780: 70 61 88 42 49 46 32 0a 0a 00 a1 1d 70 0c ff ff  pa.BIF2.....p...
  1790: ff ff 88 42 49 46 32 0a 01 00 70 0c ff ff ff ff  ...BIF2...p.....
  17a0: 88 42 49 46 32 0a 04 00 a4 42 49 46 32 14 48 13  .BIF2....BIF2.H.
  17b0: 5f 42 53 54 00 a0 0d 93 44 46 45 43 0a 01 a4 42  _BST....DFEC...B
  17c0: 53 54 32 a0 46 0e 45 43 4f 4e 70 5c 2f 05 5f 53  ST2.F.ECONp\/._S
  17d0: 42 5f 50 43 49 30 4c 50 43 42 45 43 30 5f 42 32  B_PCI0LPCBEC0_B2
  17e0: 43 47 61 70 5c 2f 05 5f 53 42 5f 50 43 49 30 4c  CGap\/._SB_PCI0L
  17f0: 50 43 42 45 43 30 5f 42 32 44 43 60 79 61 0a 01  PCBEC0_B2DC`ya..
  1800: 61 7d 60 61 63 a0 1d 5c 2f 05 5f 53 42 5f 50 43  a}`ac..\/._SB_PC
  1810: 49 30 4c 50 43 42 45 43 30 5f 42 4c 57 32 7d 63  I0LPCBEC0_BLW2}c
  1820: 0a 04 63 a0 16 90 51 45 31 32 95 51 43 4e 54 0a  ..c...QE12.QCNT.
  1830: 0a 70 0a 05 60 75 51 43 4e 54 a1 1a 70 5c 2f 05  .p..`uQCNT..p\/.
  1840: 5f 53 42 5f 50 43 49 30 4c 50 43 42 45 43 30 5f  _SB_PCI0LPCBEC0_
  1850: 42 32 42 4c 60 a0 0a 95 60 0a 05 7d 63 0a 04 63  B2BL`...`..}c..c
  1860: 70 63 88 42 53 54 32 0a 00 00 70 0b dc 05 88 42  pc.BST2...p....B
  1870: 53 54 32 0a 01 00 70 83 88 42 49 46 32 0a 02 00  ST2...p..BIF2...
  1880: 61 77 61 60 62 78 62 0a 64 63 62 70 62 88 42 53  awa`bxb.dcbpb.BS
  1890: 54 32 0a 02 00 70 83 88 42 49 46 32 0a 04 00 63  T2...p..BIF2...c
  18a0: 70 63 88 42 53 54 32 0a 03 00 a1 36 70 0a 01 88  pc.BST2....6p...
  18b0: 42 53 54 32 0a 00 00 70 0c ff ff ff ff 88 42 53  BST2...p......BS
  18c0: 54 32 0a 01 00 70 0c ff ff ff ff 88 42 53 54 32  T2...p......BST2
  18d0: 0a 02 00 70 0c ff ff ff ff 88 42 53 54 32 0a 03  ...p......BST2..
  18e0: 00 a4 42 53 54 32 5b 82 8f fe 02 50 43 49 30 14  ..BST2[....PCI0.
  18f0: 4b 0d 5f 49 4e 49 00 70 0a 00 41 43 50 53 70 0a  K._INI.p..ACPSp.
  1900: 00 53 41 43 50 70 87 5f 4f 53 5f 61 a0 32 93 61  .SACPp._OS_a.2.a
  1910: 0a 14 70 0a 01 4d 59 4f 53 a0 25 5b 12 5c 5f 4f  ..p..MYOS.%[.\_O
  1920: 53 49 60 a0 1b 5c 5f 4f 53 49 0d 57 69 6e 64 6f  SI`..\_OSI.Windo
  1930: 77 73 20 32 30 30 31 00 70 0a 00 4d 59 4f 53 a1  ws 2001.p..MYOS.
  1940: 4b 08 a0 40 06 93 61 0a 27 70 0a 02 4d 59 4f 53  K..-X72AJNbzP4w@public.gmane.org'p..MYOS
  1950: 7b 5c 2f 04 5f 53 42 5f 50 43 49 30 55 53 42 33  {\/._SB_PCI0USB3
  1960: 4d 42 41 52 0a 00 5c 2f 04 5f 53 42 5f 50 43 49  MBAR..\/._SB_PCI
  1970: 30 55 53 42 33 4d 42 41 52 7d 5c 2f 04 5f 53 42  0USB3MBAR}\/._SB
  1980: 5f 50 43 49 30 4c 50 43 42 46 44 49 53 0b 00 80  _PCI0LPCBFDIS...
  1990: 5c 2f 04 5f 53 42 5f 50 43 49 30 4c 50 43 42 46  \/._SB_PCI0LPCBF
  19a0: 44 49 53 a1 27 70 0a 03 4d 59 4f 53 70 0a 01 45  DIS.'p..MYOSp..E
  19b0: 43 4f 4e 70 5c 2f 04 5f 53 42 5f 50 43 49 30 55  CONp\/._SB_PCI0U
  19c0: 53 42 33 4d 42 41 52 4d 42 5f 54 08 5f 48 49 44  SB3MBARMB_T._HID
  19d0: 0c 41 d0 0a 03 08 5f 41 44 52 0a 00 5b 82 40 23  .A...._ADR..[.@#
  19e0: 50 43 49 32 08 5f 41 44 52 0c 00 00 1e 00 5b 82  PCI2._ADR.....[.
  19f0: 0f 4c 41 4e 5f 08 5f 41 44 52 0c 00 00 08 00 5b  .LAN_._ADR.....[
  1a00: 82 0f 4d 50 43 49 08 5f 41 44 52 0c 00 00 04 00  ..MPCI._ADR.....
  1a10: 5b 82 2d 43 41 52 44 08 5f 41 44 52 0c 00 00 09  [.-CARD._ADR....
  1a20: 00 5b 80 52 45 47 30 02 0a b0 0a 04 5b 81 11 52  .[.REG0.....[..R
  1a30: 45 47 30 03 00 08 00 08 00 08 52 47 42 33 08 08  EG0.......RGB3..
  1a40: 5f 50 52 57 12 06 02 0a 0b 0a 04 08 5f 50 52 54  _PRW........_PRT
  1a50: 12 4e 09 05 12 1e 04 0c ff ff 08 00 0a 00 5c 2f  .N............\/
  1a60: 04 5f 53 42 5f 50 43 49 30 4c 50 43 42 4c 4e 4b  ._SB_PCI0LPCBLNK
  1a70: 45 0a 00 12 1e 04 0c ff ff 04 00 0a 00 5c 2f 04  E............\/.
  1a80: 5f 53 42 5f 50 43 49 30 4c 50 43 42 4c 4e 4b 42  _SB_PCI0LPCBLNKB
  1a90: 0a 00 12 1e 04 0c ff ff 09 00 0a 00 5c 2f 04 5f  ............\/._
  1aa0: 53 42 5f 50 43 49 30 4c 50 43 42 4c 4e 4b 41 0a  SB_PCI0LPCBLNKA.
  1ab0: 00 12 1e 04 0c ff ff 09 00 0a 01 5c 2f 04 5f 53  ...........\/._S
  1ac0: 42 5f 50 43 49 30 4c 50 43 42 4c 4e 4b 44 0a 00  B_PCI0LPCBLNKD..
  1ad0: 12 1e 04 0c ff ff 09 00 0a 02 5c 2f 04 5f 53 42  ..........\/._SB
  1ae0: 5f 50 43 49 30 4c 50 43 42 4c 4e 4b 45 0a 00 5b  _PCI0LPCBLNKE..[
  1af0: 82 4d 11 44 4f 43 4b 08 5f 48 49 44 0c 41 d0 0a  .M.DOCK._HID.A..
  1b00: 06 08 5f 55 49 44 0a 01 14 42 05 5f 44 43 4b 01  .._UID...B._DCK.
  1b10: a0 25 68 a0 1f 90 92 93 4d 59 4f 53 0a 01 93 44  .%h.....MYOS...D
  1b20: 4b 41 50 0a 01 5c 2e 5f 53 42 5f 4d 53 4d 49 0a  KAP..\._SB_MSMI.
  1b30: ac 0a 01 a4 0a 01 a1 24 a0 1f 90 92 93 4d 59 4f  .......$.....MYO
  1b40: 53 0a 01 93 44 4b 41 50 0a 01 5c 2e 5f 53 42 5f  S...DKAP..\._SB_
  1b50: 4d 53 4d 49 0a ac 0a 00 a4 0a 01 14 47 08 5f 53  MSMI........G._S
  1b60: 54 41 00 a0 41 04 45 43 4f 4e a0 0f 93 44 4b 41  TA..A.ECON...DKA
  1b70: 50 0a 01 70 0a 00 50 52 53 54 a1 2a a0 1f 5c 2f  P..p..PRST.*..\/
  1b80: 05 5f 53 42 5f 50 43 49 30 4c 50 43 42 45 43 30  ._SB_PCI0LPCBEC0
  1b90: 5f 44 4b 4f 4e 70 0a 0f 50 52 53 54 a1 08 70 0a  _DKONp..PRST..p.
  1ba0: 00 50 52 53 54 a1 38 a0 0f 93 44 4b 41 50 0a 00  .PRST.8...DKAP..
  1bb0: 70 0a 00 50 52 53 54 a1 26 5c 2e 5f 53 42 5f 4d  p..PRST.&\._SB_M
  1bc0: 53 4d 49 0a ad 0a 00 a0 0d 5c 4d 58 30 31 70 0a  SMI......\MX01p.
  1bd0: 0f 50 52 53 54 a1 08 70 0a 00 50 52 53 54 a4 50  .PRST..p..PRST.P
  1be0: 52 53 54 14 09 5f 42 44 4e 00 a4 0a 01 14 1a 5f  RST.._BDN......_
  1bf0: 45 4a 30 01 a0 13 68 5b 26 5e 44 4b 52 51 5b 25  EJ0...h[&^DKRQ[%
  1c00: 5e 44 4b 52 51 0b 00 14 5b 02 44 4b 52 51 5b 80  ^DKRQ...[.DKRQ[.
  1c10: 52 45 47 30 02 0a 90 0a 04 5b 81 1e 52 45 47 30  REG0.....[..REG0
  1c20: 03 00 03 47 53 52 4d 01 44 4c 43 4b 01 44 43 4c  ...GSRM.DLCK.DCL
  1c30: 53 01 44 4f 50 4e 01 00 01 08 43 52 45 53 11 4a  S.DOPN....CRES.J
  1c40: 0d 0a d6 88 0d 00 02 00 00 00 00 00 00 ff 00 00  ................
  1c50: 00 00 01 47 01 f8 0c f8 0c 01 08 88 0d 00 01 0c  ...G............
  1c60: 03 00 00 00 00 f7 0c 00 00 f8 0c 88 0d 00 01 0c  ................
  1c70: 03 00 00 00 0d ff ff 00 00 00 f3 87 17 00 00 0c  ................
  1c80: 03 00 00 00 00 00 00 0a 00 ff ff 0b 00 00 00 00  ................
  1c90: 00 00 00 02 00 87 17 00 00 0c 03 00 00 00 00 00  ................
  1ca0: 00 0d 00 ff ff 0d 00 00 00 00 00 00 00 01 00 87  ................
  1cb0: 17 00 00 0c 03 00 00 00 00 00 00 0c 00 ff ff 0c  ................
  1cc0: 00 00 00 00 00 00 00 01 00 87 17 00 00 0d 00 00  ................
  1cd0: 00 00 00 00 00 b8 ff ff ff bf ff 00 00 00 00 00  ................
  1ce0: 00 08 00 87 17 00 00 0d 00 00 00 00 00 00 00 f8  ................
  1cf0: ff ff ff ff ff 00 00 00 00 00 00 08 00 87 17 00  ................
  1d00: 00 0c 03 00 00 00 00 00 00 00 02 ff ff bf fe 00  ................
  1d10: 00 00 00 00 00 e0 fc 79 00 14 47 07 5f 43 52 53  .......y..G._CRS
  1d20: 00 8a 43 52 45 53 0a c4 52 41 4d 54 8a 43 52 45  ..CRES..RAMT.CRE
  1d30: 53 0a d0 52 41 4d 52 70 0c 00 00 10 00 60 77 45  S..RAMRp.....`wE
  1d40: 54 48 49 0c 00 00 04 00 61 77 45 54 4c 4f 0b 00  THI.....awETLO..
  1d50: 04 62 72 61 62 61 77 61 0a 40 61 77 44 54 48 49  .brabawa.-r1kbbTBqFZk@public.gmane.org
  1d60: 0c 00 00 04 00 63 77 45 54 4c 4f 0b 00 04 64 72  .....cwETLO...dr
  1d70: 63 64 63 72 61 63 61 72 61 60 52 41 4d 54 74 0c  cdcracara`RAMTt.
  1d80: ff ff bf fe 52 41 4d 54 52 41 4d 52 a4 43 52 45  ....RAMTRAMR.CRE
  1d90: 53 08 5f 50 52 54 12 4b 0f 08 12 1e 04 0c ff ff  S._PRT.K........
  1da0: 01 00 0a 00 5c 2f 04 5f 53 42 5f 50 43 49 30 4c  ....\/._SB_PCI0L
  1db0: 50 43 42 4c 4e 4b 41 0a 00 12 1e 04 0c ff ff 01  PCBLNKA.........
  1dc0: 00 0a 01 5c 2f 04 5f 53 42 5f 50 43 49 30 4c 50  ...\/._SB_PCI0LP
  1dd0: 43 42 4c 4e 4b 42 0a 00 12 1e 04 0c ff ff 1f 00  CBLNKB..........
  1de0: 0a 00 5c 2f 04 5f 53 42 5f 50 43 49 30 4c 50 43  ..\/._SB_PCI0LPC
  1df0: 42 4c 4e 4b 43 0a 00 12 1e 04 0c ff ff 1f 00 0a  BLNKC...........
  1e00: 01 5c 2f 04 5f 53 42 5f 50 43 49 30 4c 50 43 42  .\/._SB_PCI0LPCB
  1e10: 4c 4e 4b 42 0a 00 12 1e 04 0c ff ff 1d 00 0a 00  LNKB............
  1e20: 5c 2f 04 5f 53 42 5f 50 43 49 30 4c 50 43 42 4c  \/._SB_PCI0LPCBL
  1e30: 4e 4b 41 0a 00 12 1e 04 0c ff ff 1d 00 0a 01 5c  NKA............\
  1e40: 2f 04 5f 53 42 5f 50 43 49 30 4c 50 43 42 4c 4e  /._SB_PCI0LPCBLN
  1e50: 4b 44 0a 00 12 1e 04 0c ff ff 1d 00 0a 02 5c 2f  KD............\/
  1e60: 04 5f 53 42 5f 50 43 49 30 4c 50 43 42 4c 4e 4b  ._SB_PCI0LPCBLNK
  1e70: 43 0a 00 12 1e 04 0c ff ff 1d 00 0a 03 5c 2f 04  C............\/.
  1e80: 5f 53 42 5f 50 43 49 30 4c 50 43 42 4c 4e 4b 48  _SB_PCI0LPCBLNKH
  1e90: 0a 00 5b 82 4b 04 41 47 50 42 08 5f 41 44 52 0c  ..[.K.AGPB._ADR.
  1ea0: 00 00 01 00 5b 82 39 56 47 41 30 08 5f 41 44 52  ....[.9VGA0._ADR
  1eb0: 0a 00 5b 82 0d 4c 43 44 5f 08 5f 41 44 52 0b 10  ..[..LCD_._ADR..
  1ec0: 01 5b 82 0d 54 56 5f 5f 08 5f 41 44 52 0b 00 02  .[..TV__._ADR...
  1ed0: 5b 82 0d 43 52 54 5f 08 5f 41 44 52 0b 00 01 5b  [..CRT_._ADR...[
  1ee0: 82 25 55 53 42 30 08 5f 41 44 52 0c 00 00 1d 00  .%USB0._ADR.....
  1ef0: 08 5f 50 52 57 12 06 02 0a 03 0a 03 14 09 5f 53  ._PRW........._S
  1f00: 33 44 00 a4 0a 03 5b 82 25 55 53 42 31 08 5f 41  3D....[.%USB1._A
  1f10: 44 52 0c 01 00 1d 00 08 5f 50 52 57 12 06 02 0a  DR......_PRW....
  1f20: 04 0a 03 14 09 5f 53 33 44 00 a4 0a 03 5b 82 25  ....._S3D....[.%
  1f30: 55 53 42 32 08 5f 41 44 52 0c 02 00 1d 00 08 5f  USB2._ADR......_
  1f40: 50 52 57 12 06 02 0a 0c 0a 03 14 09 5f 53 33 44  PRW........._S3D
  1f50: 00 a4 0a 03 5b 82 43 09 55 53 42 33 08 46 55 53  ....[.C.USB3.FUS
  1f60: 42 0a 00 08 5f 41 44 52 0c 07 00 1d 00 5b 80 42  B..._ADR.....[.B
  1f70: 41 52 30 02 0a 10 0a 04 5b 81 0b 42 41 52 30 03  AR0.....[..BAR0.
  1f80: 4d 42 41 52 20 08 5f 50 52 57 12 06 02 0a 0d 0a  MBAR ._PRW......
  1f90: 03 14 09 5f 53 33 44 00 a4 0a 03 14 46 04 5f 50  ..._S3D.....F._P
  1fa0: 53 30 00 a0 3e 93 4d 59 4f 53 0a 03 a0 2e 46 55  S0..>.MYOS....FU
  1fb0: 53 42 70 0a 00 5c 2f 04 5f 53 42 5f 50 43 49 30  SBp..\/._SB_PCI0
  1fc0: 4c 50 43 42 46 44 49 53 70 4d 42 5f 54 4d 42 41  LPCBFDISpMB_TMBA
  1fd0: 52 5b 22 0a 64 70 4d 42 41 52 60 70 0a 01 46 55  R[".dpMBAR`p..FU
  1fe0: 53 42 14 06 5f 50 53 33 00 5b 82 0f 41 43 39 37  SB.._PS3.[..AC97
  1ff0: 08 5f 41 44 52 0c 05 00 1f 00 5b 82 41 04 4d 43  ._ADR.....[.A.MC
  2000: 39 37 08 5f 41 44 52 0c 06 00 1f 00 08 57 4f 52  97._ADR......WOR
  2010: 30 12 06 02 0a 05 0a 00 08 57 4f 52 33 12 06 02  0........WOR3...
  2020: 0a 05 0a 03 14 18 5f 50 52 57 00 a0 0a 57 41 4b  ......_PRW...WAK
  2030: 52 a4 57 4f 52 30 a1 06 a4 57 4f 52 33 5b 82 46  R.WOR0...WOR3[.F
  2040: f2 49 44 45 43 08 5f 41 44 52 0c 01 00 1f 00 5b  .IDEC._ADR.....[
  2050: 80 49 44 45 52 02 0a 40 0a 18 5b 81 44 06 49 44  .IDER..-rVxdn2TrCWA@public.gmane.org[.D.ID
  2060: 45 52 03 50 52 49 54 10 53 45 43 54 10 50 53 49  ER.PRIT.SECT.PSI
  2070: 54 04 53 53 49 54 04 00 18 53 59 4e 43 04 00 0c  T.SSIT...SYNC...
  2080: 53 44 54 30 02 00 02 53 44 54 31 02 00 02 53 44  SDT0...SDT1...SD
  2090: 54 32 02 00 02 53 44 54 33 02 00 42 04 49 43 52  T2...SDT3..B.ICR
  20a0: 30 04 49 43 52 31 04 49 43 52 32 04 49 43 52 33  0.ICR1.ICR2.ICR3
  20b0: 04 50 4d 4f 44 02 53 4d 4f 44 02 49 43 52 35 04  .PMOD.SMOD.ICR5.
  20c0: 5b 82 44 63 50 52 49 44 08 5f 41 44 52 0a 00 14  [.DcPRID._ADR...
  20d0: 49 14 5f 47 54 4d 00 08 50 42 55 46 11 17 0a 14  I._GTM..PBUF....
  20e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  20f0: 00 00 00 00 8a 50 42 55 46 0a 00 50 49 4f 30 8a  .....PBUF..PIO0.
  2100: 50 42 55 46 0a 04 44 4d 41 30 8a 50 42 55 46 0a  PBUF..DMA0.PBUF.
  2110: 08 50 49 4f 31 8a 50 42 55 46 0a 0c 44 4d 41 31  .PIO1.PBUF..DMA1
  2120: 8a 50 42 55 46 0a 10 46 4c 41 47 70 47 45 54 50  .PBUF..FLAGpGETP
  2130: 50 52 49 54 50 49 4f 30 70 47 44 4d 41 7b 53 59  PRITPIO0pGDMA{SY
  2140: 4e 43 0a 01 00 7b 49 43 52 33 0a 01 00 7b 49 43  NC...{ICR3...{IC
  2150: 52 30 0a 01 00 53 44 54 30 7b 49 43 52 31 0a 01  R0...SDT0{ICR1..
  2160: 00 44 4d 41 30 a0 14 93 44 4d 41 30 0c ff ff ff  .DMA0...DMA0....
  2170: ff 70 50 49 4f 30 44 4d 41 30 a0 2e 7b 50 52 49  .pPIO0DMA0..{PRI
  2180: 54 0b 00 40 00 a0 14 93 7b 50 52 49 54 0a 90 00  T..-9D9NNryygCw@public.gmane.org{PRIT...
  2190: 0a 80 70 0b 84 03 50 49 4f 31 a1 0e 70 47 45 54  ..p...PIO1..pGET
  21a0: 54 50 53 49 54 50 49 4f 31 a1 0b 70 0c ff ff ff  TPSITPIO1..p....
  21b0: ff 50 49 4f 31 70 47 44 4d 41 7b 53 59 4e 43 0a  .PIO1pGDMA{SYNC.
  21c0: 02 00 7b 49 43 52 33 0a 02 00 7b 49 43 52 30 0a  ..{ICR3...{ICR0.
  21d0: 02 00 53 44 54 31 7b 49 43 52 31 0a 02 00 44 4d  ..SDT1{ICR1...DM
  21e0: 41 31 a0 14 93 44 4d 41 31 0c ff ff ff ff 70 50  A1...DMA1.....pP
  21f0: 49 4f 31 44 4d 41 31 70 47 45 54 46 7b 53 59 4e  IO1DMA1pGETF{SYN
  2200: 43 0a 01 00 7b 53 59 4e 43 0a 02 00 50 52 49 54  C...{SYNC...PRIT
  2210: 46 4c 41 47 a4 50 42 55 46 14 4b 2a 5f 53 54 4d  FLAG.PBUF.K*_STM
  2220: 03 8a 68 0a 00 50 49 4f 30 8a 68 0a 04 44 4d 41  ..h..PIO0.h..DMA
  2230: 30 8a 68 0a 08 50 49 4f 31 8a 68 0a 0c 44 4d 41  0.h..PIO1.h..DMA
  2240: 31 8a 68 0a 10 46 4c 41 47 70 0a 04 49 43 52 32  1.h..FLAGp..ICR2
  2250: a0 4c 11 93 87 69 0b 00 02 7b 50 52 49 54 0b f0  .L...i...{PRIT..
  2260: 40 50 52 49 54 7b 53 59 4e 43 0a 0e 53 59 4e 43  @PRIT{SYNC..SYNC
  2270: 70 0a 00 53 44 54 30 7b 49 43 52 30 0a 0e 49 43  p..SDT0{ICR0..IC
  2280: 52 30 7b 49 43 52 31 0a 0e 49 43 52 31 7b 49 43  R0{ICR1..ICR1{IC
  2290: 52 33 0a 0e 49 43 52 33 8b 69 0a 62 57 34 39 30  R3..ICR3.i.bW490
  22a0: 8b 69 0a 6a 57 35 33 30 8b 69 0a 7e 57 36 33 30  .i.jW530.i.~W630
  22b0: 8b 69 0a 80 57 36 34 30 8b 69 0a b0 57 38 38 30  .i..W640.i..W880
  22c0: 8b 69 0a ba 57 39 33 30 7d 50 52 49 54 0b 04 80  .i..W930}PRIT...
  22d0: 50 52 49 54 a0 1e 90 7b 46 4c 41 47 0a 02 00 7b  PRIT...{FLAG...{
  22e0: 57 34 39 30 0b 00 08 00 7d 50 52 49 54 0a 02 50  W490....}PRIT..P
  22f0: 52 49 54 7d 50 52 49 54 53 45 54 50 50 49 4f 30  RIT}PRITSETPPIO0
  2300: 57 35 33 30 57 36 34 30 50 52 49 54 a0 40 06 7b  W530W640PRIT.-4b8TPpkIZ3Q@public.gmane.org{
  2310: 46 4c 41 47 0a 01 00 7d 53 59 4e 43 0a 01 53 59  FLAG...}SYNC..SY
  2320: 4e 43 70 53 44 4d 41 44 4d 41 30 53 44 54 30 a0  NCpSDMADMA0SDT0.
  2330: 13 95 44 4d 41 30 0a 1e 7d 49 43 52 33 0a 01 49  ..DMA0..}ICR3..I
  2340: 43 52 33 a0 13 95 44 4d 41 30 0a 3c 7d 49 43 52  CR3...DMA0.<}ICR
  2350: 30 0a 01 49 43 52 30 a0 15 7b 57 39 33 30 0b 00  0..ICR0..{W930..
  2360: 20 00 7d 49 43 52 31 0a 01 49 43 52 31 a0 47 15   .}ICR1..ICR1.G.
  2370: 93 87 6a 0b 00 02 7b 50 52 49 54 0b 0f 3f 50 52  ..j...{PRIT..?PR
  2380: 49 54 70 0a 00 50 53 49 54 7b 53 59 4e 43 0a 0d  ITp..PSIT{SYNC..
  2390: 53 59 4e 43 70 0a 00 53 44 54 31 7b 49 43 52 30  SYNCp..SDT1{ICR0
  23a0: 0a 0d 49 43 52 30 7b 49 43 52 31 0a 0d 49 43 52  ..ICR0{ICR1..ICR
  23b0: 31 7b 49 43 52 33 0a 0d 49 43 52 33 8b 6a 0a 62  1{ICR3..ICR3.j.b
  23c0: 57 34 39 31 8b 6a 0a 6a 57 35 33 31 8b 6a 0a 7e  W491.j.jW531.j.~
  23d0: 57 36 33 31 8b 6a 0a 80 57 36 34 31 8b 6a 0a b0  W631.j..W641.j..
  23e0: 57 38 38 31 8b 6a 0a ba 57 39 33 31 7d 50 52 49  W881.j..W931}PRI
  23f0: 54 0b 40 80 50 52 49 54 a0 1e 90 7b 46 4c 41 47  T.-VTSyvLrO+P4@public.gmane.org{FLAG
  2400: 0a 08 00 7b 57 34 39 31 0b 00 08 00 7d 50 52 49  ...{W491....}PRI
  2410: 54 0a 20 50 52 49 54 a0 4c 04 7b 46 4c 41 47 0a  T. PRIT.L.{FLAG.
  2420: 10 00 7d 50 52 49 54 0b 00 40 50 52 49 54 a0 13  ..}PRIT..-nDKX1ZrVAFI@public.gmane.org
  2430: 94 50 49 4f 31 0a f0 7d 50 52 49 54 0a 80 50 52  .PIO1..}PRIT..PR
  2440: 49 54 a1 21 7d 50 52 49 54 0a 10 50 52 49 54 70  IT.!}PRIT..PRITp
  2450: 53 45 54 54 50 49 4f 31 57 35 33 31 57 36 34 31  SETTPIO1W531W641
  2460: 50 53 49 54 a0 40 06 7b 46 4c 41 47 0a 04 00 7d  PSIT.-4b8TPpkIZ3Q@public.gmane.org{FLAG...}
  2470: 53 59 4e 43 0a 02 53 59 4e 43 70 53 44 4d 41 44  SYNC..SYNCpSDMAD
  2480: 4d 41 31 53 44 54 31 a0 13 95 44 4d 41 30 0a 1e  MA1SDT1...DMA0..
  2490: 7d 49 43 52 33 0a 02 49 43 52 33 a0 13 95 44 4d  }ICR3..ICR3...DM
  24a0: 41 30 0a 3c 7d 49 43 52 30 0a 02 49 43 52 30 a0  A0.<}ICR0..ICR0.
  24b0: 15 7b 57 39 33 31 0b 00 20 00 7d 49 43 52 31 0a  .{W931.. .}ICR1.
  24c0: 02 49 43 52 31 5b 82 4e 10 50 5f 44 30 08 5f 41  .ICR1[.N.P_D0._A
  24d0: 44 52 0a 00 14 40 10 5f 47 54 46 00 08 50 49 42  DR...-CGOz1Ppph0gsWz6eVOvW+w@public.gmane.org
  24e0: 30 11 11 0a 0e 03 00 00 00 00 a0 ef 03 00 00 00  0...............
  24f0: 00 a0 ef 8c 50 49 42 30 0a 01 50 4d 44 30 8c 50  ....PIB0..PMD0.P
  2500: 49 42 30 0a 08 44 4d 44 30 a0 40 06 7b 50 52 49  IB0..DMD0.-4b8TPpkIZ3Q@public.gmane.org{PRI
  2510: 54 0a 02 00 a0 13 93 7b 50 52 49 54 0a 09 00 0a  T......{PRIT....
  2520: 08 70 0a 08 50 4d 44 30 a1 41 04 70 0a 0a 50 4d  .p..PMD0.A.p..PM
  2530: 44 30 7a 7b 50 52 49 54 0b 00 03 00 0a 08 60 7a  D0z{PRIT......`z
  2540: 7b 50 52 49 54 0b 00 30 00 0a 0c 61 72 60 61 62  {PRIT..0...ar`ab
  2550: a0 0c 93 0a 03 62 70 0a 0b 50 4d 44 30 a0 0c 93  .....bp..PMD0...
  2560: 0a 05 62 70 0a 0c 50 4d 44 30 a1 08 70 0a 01 50  ..bp..PMD0..p..P
  2570: 4d 44 30 a0 47 04 7b 53 59 4e 43 0a 01 00 70 7d  MD0.G.{SYNC...p}
  2580: 53 44 54 30 0a 40 00 44 4d 44 30 a0 2f 7b 49 43  SDT0.-Bp4WBFZxkXI@public.gmane.org/{IC
  2590: 52 31 0a 01 00 a0 14 7b 49 43 52 30 0a 01 00 72  R1.....{ICR0...r
  25a0: 44 4d 44 30 0a 02 44 4d 44 30 a0 10 7b 49 43 52  DMD0..DMD0..{ICR
  25b0: 33 0a 01 00 70 0a 45 44 4d 44 30 a1 14 7d 74 7b  3...p.EDMD0..}t{
  25c0: 50 4d 44 30 0a 07 00 0a 02 00 0a 20 44 4d 44 30  PMD0....... DMD0
  25d0: a4 50 49 42 30 5b 82 49 10 50 5f 44 31 08 5f 41  .PIB0[.I.P_D1._A
  25e0: 44 52 0a 01 14 4b 0f 5f 47 54 46 00 08 50 49 42  DR...K._GTF..PIB
  25f0: 31 11 11 0a 0e 03 00 00 00 00 b0 ef 03 00 00 00  1...............
  2600: 00 b0 ef 8c 50 49 42 31 0a 01 50 4d 44 31 8c 50  ....PIB1..PMD1.P
  2610: 49 42 31 0a 08 44 4d 44 31 a0 4b 05 7b 50 52 49  IB1..DMD1.K.{PRI
  2620: 54 0a 20 00 a0 13 93 7b 50 52 49 54 0a 90 00 0a  T. ....{PRIT....
  2630: 80 70 0a 08 50 4d 44 31 a1 3c 72 7b 50 53 49 54  .p..PMD1.<r{PSIT
  2640: 0a 03 00 7a 7b 50 53 49 54 0a 0c 00 0a 02 00 60  ...z{PSIT......`
  2650: a0 0c 93 0a 05 60 70 0a 0c 50 4d 44 31 a1 17 a0  .....`p..PMD1...
  2660: 0c 93 0a 03 60 70 0a 0b 50 4d 44 31 a1 08 70 0a  ....`p..PMD1..p.
  2670: 0a 50 4d 44 31 a1 08 70 0a 01 50 4d 44 31 a0 47  .PMD1..p..PMD1.G
  2680: 04 7b 53 59 4e 43 0a 02 00 70 7d 53 44 54 31 0a  .{SYNC...p}SDT1.
  2690: 40 00 44 4d 44 31 a0 2f 7b 49 43 52 31 0a 02 00  @.DMD1./{ICR1...
  26a0: a0 14 7b 49 43 52 30 0a 02 00 72 44 4d 44 31 0a  ..{ICR0...rDMD1.
  26b0: 02 44 4d 44 31 a0 10 7b 49 43 52 33 0a 02 00 70  .DMD1..{ICR3...p
  26c0: 0a 45 44 4d 44 31 a1 14 7d 74 7b 50 4d 44 31 0a  .EDMD1..}t{PMD1.
  26d0: 07 00 0a 02 00 0a 20 44 4d 44 31 a4 50 49 42 31  ...... DMD1.PIB1
  26e0: 14 0a 5f 50 53 30 00 70 0a 01 60 14 0a 5f 50 53  .._PS0.p..`.._PS
  26f0: 33 00 70 0a 01 60 5b 82 42 6c 53 45 43 44 08 5f  3.p..`[.BlSECD._
  2700: 41 44 52 0a 01 14 49 14 5f 47 54 4d 00 08 53 42  ADR...I._GTM..SB
  2710: 55 46 11 17 0a 14 00 00 00 00 00 00 00 00 00 00  UF..............
  2720: 00 00 00 00 00 00 00 00 00 00 8a 53 42 55 46 0a  ...........SBUF.
  2730: 00 50 49 4f 30 8a 53 42 55 46 0a 04 44 4d 41 30  .PIO0.SBUF..DMA0
  2740: 8a 53 42 55 46 0a 08 50 49 4f 31 8a 53 42 55 46  .SBUF..PIO1.SBUF
  2750: 0a 0c 44 4d 41 31 8a 53 42 55 46 0a 10 46 4c 41  ..DMA1.SBUF..FLA
  2760: 47 70 47 45 54 50 53 45 43 54 50 49 4f 30 70 47  GpGETPSECTPIO0pG
  2770: 44 4d 41 7b 53 59 4e 43 0a 04 00 7b 49 43 52 33  DMA{SYNC...{ICR3
  2780: 0a 04 00 7b 49 43 52 30 0a 04 00 53 44 54 32 7b  ...{ICR0...SDT2{
  2790: 49 43 52 31 0a 04 00 44 4d 41 30 a0 14 93 44 4d  ICR1...DMA0...DM
  27a0: 41 30 0c ff ff ff ff 70 50 49 4f 30 44 4d 41 30  A0.....pPIO0DMA0
  27b0: a0 2e 7b 53 45 43 54 0b 00 40 00 a0 14 93 7b 53  ..{SECT..-9D9NNryygCw@public.gmane.org{S
  27c0: 45 43 54 0a 90 00 0a 80 70 0b 84 03 50 49 4f 31  ECT.....p...PIO1
  27d0: a1 0e 70 47 45 54 54 53 53 49 54 50 49 4f 31 a1  ..pGETTSSITPIO1.
  27e0: 0b 70 0c ff ff ff ff 50 49 4f 31 70 47 44 4d 41  .p.....PIO1pGDMA
  27f0: 7b 53 59 4e 43 0a 08 00 7b 49 43 52 33 0a 08 00  {SYNC...{ICR3...
  2800: 7b 49 43 52 30 0a 08 00 53 44 54 33 7b 49 43 52  {ICR0...SDT3{ICR
  2810: 31 0a 08 00 44 4d 41 31 a0 14 93 44 4d 41 31 0c  1...DMA1...DMA1.
  2820: ff ff ff ff 70 50 49 4f 31 44 4d 41 31 70 47 45  ....pPIO1DMA1pGE
  2830: 54 46 7b 53 59 4e 43 0a 04 00 7b 53 59 4e 43 0a  TF{SYNC...{SYNC.
  2840: 08 00 53 45 43 54 46 4c 41 47 a4 53 42 55 46 14  ..SECTFLAG.SBUF.
  2850: 40 2a 5f 53 54 4d 03 8a 68 0a 00 50 49 4f 30 8a  @*_STM..h..PIO0.
  2860: 68 0a 04 44 4d 41 30 8a 68 0a 08 50 49 4f 31 8a  h..DMA0.h..PIO1.
  2870: 68 0a 0c 44 4d 41 31 8a 68 0a 10 46 4c 41 47 70  h..DMA1.h..FLAGp
  2880: 0a 04 49 43 52 32 a0 41 11 93 87 69 0b 00 02 7b  ..ICR2.A...i...{
  2890: 53 45 43 54 0b f2 40 53 45 43 54 7b 53 59 4e 43  SECT..-rEp6QHzXslU@public.gmane.org{SYNC
  28a0: 0a 0b 53 59 4e 43 70 0a 00 53 44 54 32 7b 49 43  ..SYNCp..SDT2{IC
  28b0: 52 30 0a 0b 49 43 52 30 7b 49 43 52 31 0a 0b 49  R0..ICR0{ICR1..I
  28c0: 43 52 31 7b 49 43 52 33 0a 0b 49 43 52 33 8b 69  CR1{ICR3..ICR3.i
  28d0: 0a 62 57 34 39 30 8b 69 0a 6a 57 35 33 30 8b 69  .bW490.i.jW530.i
  28e0: 0a 7e 57 36 33 30 8b 69 0a 80 57 36 34 30 8b 69  .~W630.i..W640.i
  28f0: 0a b0 57 38 38 30 8b 69 0a ba 57 39 33 30 7d 53  ..W880.i..W930}S
  2900: 45 43 54 0b 04 80 53 45 43 54 a0 13 90 7b 46 4c  ECT...SECT...{FL
  2910: 41 47 0a 02 00 7b 57 34 39 30 0b 00 08 00 7d 53  AG...{W490....}S
  2920: 45 43 54 53 45 54 50 50 49 4f 30 57 35 33 30 57  ECTSETPPIO0W530W
  2930: 36 34 30 53 45 43 54 a0 40 06 7b 46 4c 41 47 0a  640SECT.-4b8TPpkIZ3Q@public.gmane.org{FLAG.
  2940: 01 00 7d 53 59 4e 43 0a 04 53 59 4e 43 70 53 44  ..}SYNC..SYNCpSD
  2950: 4d 41 44 4d 41 30 53 44 54 32 a0 13 95 44 4d 41  MADMA0SDT2...DMA
  2960: 30 0a 1e 7d 49 43 52 33 0a 04 49 43 52 33 a0 13  0..}ICR3..ICR3..
  2970: 95 44 4d 41 30 0a 3c 7d 49 43 52 30 0a 04 49 43  .DMA0.<}ICR0..IC
  2980: 52 30 a0 15 7b 57 39 33 30 0b 00 20 00 7d 49 43  R0..{W930.. .}IC
  2990: 52 31 0a 04 49 43 52 31 a0 47 15 93 87 6a 0b 00  R1..ICR1.G...j..
  29a0: 02 7b 53 45 43 54 0b 0f 3f 53 45 43 54 70 0a 00  .{SECT..?SECTp..
  29b0: 53 53 49 54 7b 53 59 4e 43 0a 07 53 59 4e 43 70  SSIT{SYNC..SYNCp
  29c0: 0a 00 53 44 54 33 7b 49 43 52 30 0a 07 49 43 52  ..SDT3{ICR0..ICR
  29d0: 30 7b 49 43 52 31 0a 07 49 43 52 31 7b 49 43 52  0{ICR1..ICR1{ICR
  29e0: 33 0a 07 49 43 52 33 8b 6a 0a 62 57 34 39 31 8b  3..ICR3.j.bW491.
  29f0: 6a 0a 6a 57 35 33 31 8b 6a 0a 7e 57 36 33 31 8b  j.jW531.j.~W631.
  2a00: 6a 0a 80 57 36 34 31 8b 6a 0a b0 57 38 38 31 8b  j..W641.j..W881.
  2a10: 6a 0a ba 57 39 33 31 7d 53 45 43 54 0b 40 80 53  j..W931}SECT.-HbAATbMvftk@public.gmane.org
  2a20: 45 43 54 a0 1e 90 7b 46 4c 41 47 0a 08 00 7b 57  ECT...{FLAG...{W
  2a30: 34 39 31 0b 00 08 00 7d 53 45 43 54 0a 20 53 45  491....}SECT. SE
  2a40: 43 54 a0 4c 04 7b 46 4c 41 47 0a 10 00 7d 53 45  CT.L.{FLAG...}SE
  2a50: 43 54 0b 00 40 53 45 43 54 a0 13 94 50 49 4f 31  CT..-9D9euU5CxHHHSrDYSrwK2A@public.gmane.org
  2a60: 0a f0 7d 53 45 43 54 0a 80 53 45 43 54 a1 21 7d  ..}SECT..SECT.!}
  2a70: 53 45 43 54 0a 10 53 45 43 54 70 53 45 54 54 50  SECT..SECTpSETTP
  2a80: 49 4f 31 57 35 33 31 57 36 34 31 53 53 49 54 a0  IO1W531W641SSIT.
  2a90: 40 06 7b 46 4c 41 47 0a 04 00 7d 53 59 4e 43 0a  @.{FLAG...}SYNC.
  2aa0: 08 53 59 4e 43 70 53 44 4d 41 44 4d 41 31 53 44  .SYNCpSDMADMA1SD
  2ab0: 54 33 a0 13 95 44 4d 41 30 0a 1e 7d 49 43 52 33  T3...DMA0..}ICR3
  2ac0: 0a 08 49 43 52 33 a0 13 95 44 4d 41 30 0a 3c 7d  ..ICR3...DMA0.<}
  2ad0: 49 43 52 30 0a 08 49 43 52 30 a0 15 7b 57 39 33  ICR0..ICR0..{W93
  2ae0: 31 0b 00 20 00 7d 49 43 52 31 0a 08 49 43 52 31  1.. .}ICR1..ICR1
  2af0: 5b 82 44 18 53 5f 44 30 08 5f 41 44 52 0a 00 14  [.D.S_D0._ADR...
  2b00: 3b 5f 45 4a 30 01 5c 2e 5f 53 42 5f 47 53 4d 49  ;_EJ0.\._SB_GSMI
  2b10: 0a 24 70 0a 02 5c 2f 04 5f 53 42 5f 50 43 49 30  .$p..\/._SB_PCI0
  2b20: 49 44 45 43 53 4d 4f 44 7b 53 45 43 54 0b fd ff  IDECSMOD{SECT...
  2b30: 53 45 43 54 70 0a 01 42 41 59 50 14 39 5f 53 54  SECTp..BAYP.9_ST
  2b40: 41 00 a0 13 45 43 4f 4e a0 08 42 41 59 50 a4 0a  A...ECON..BAYP..
  2b50: 00 a1 04 a4 0a 0f a1 1e 5c 2e 5f 53 42 5f 47 53  ........\._SB_GS
  2b60: 4d 49 0a 1d a0 0b 93 41 50 4d 44 0a 00 a4 0a 00  MI.....APMD.....
  2b70: a1 04 a4 0a 0f 14 40 10 5f 47 54 46 00 08 53 49  ......-6udDSWIYFU5VBBxDL7pS9w@public.gmane.org
  2b80: 42 30 11 11 0a 0e 03 00 00 00 00 a0 ef 03 00 00  B0..............
  2b90: 00 00 a0 ef 8c 53 49 42 30 0a 01 50 4d 44 30 8c  .....SIB0..PMD0.
  2ba0: 53 49 42 30 0a 08 44 4d 44 30 a0 40 06 7b 53 45  SIB0..DMD0.-4b8TPpkIZ3Q@public.gmane.org{SE
  2bb0: 43 54 0a 02 00 a0 13 93 7b 53 45 43 54 0a 09 00  CT......{SECT...
  2bc0: 0a 08 70 0a 08 50 4d 44 30 a1 41 04 70 0a 0a 50  ..p..PMD0.A.p..P
  2bd0: 4d 44 30 7a 7b 53 45 43 54 0b 00 03 00 0a 08 60  MD0z{SECT......`
  2be0: 7a 7b 53 45 43 54 0b 00 30 00 0a 0c 61 72 60 61  z{SECT..0...ar`a
  2bf0: 62 a0 0c 93 0a 03 62 70 0a 0b 50 4d 44 30 a0 0c  b.....bp..PMD0..
  2c00: 93 0a 05 62 70 0a 0c 50 4d 44 30 a1 08 70 0a 01  ...bp..PMD0..p..
  2c10: 50 4d 44 30 a0 47 04 7b 53 59 4e 43 0a 04 00 70  PMD0.G.{SYNC...p
  2c20: 7d 53 44 54 32 0a 40 00 44 4d 44 30 a0 2f 7b 49  }SDT2.-Bp4WBFZxkXI@public.gmane.org/{I
  2c30: 43 52 31 0a 04 00 a0 14 7b 49 43 52 30 0a 04 00  CR1.....{ICR0...
  2c40: 72 44 4d 44 30 0a 02 44 4d 44 30 a0 10 7b 49 43  rDMD0..DMD0..{IC
  2c50: 52 33 0a 04 00 70 0a 45 44 4d 44 30 a1 14 7d 74  R3...p.EDMD0..}t
  2c60: 7b 50 4d 44 30 0a 07 00 0a 02 00 0a 20 44 4d 44  {PMD0....... DMD
  2c70: 30 a4 53 49 42 30 5b 82 49 10 53 5f 44 31 08 5f  0.SIB0[.I.S_D1._
  2c80: 41 44 52 0a 01 14 4b 0f 5f 47 54 46 00 08 53 49  ADR...K._GTF..SI
  2c90: 42 31 11 11 0a 0e 03 00 00 00 00 b0 ef 03 00 00  B1..............
  2ca0: 00 00 b0 ef 8c 53 49 42 31 0a 01 50 4d 44 31 8c  .....SIB1..PMD1.
  2cb0: 53 49 42 31 0a 08 44 4d 44 31 a0 4b 05 7b 53 45  SIB1..DMD1.K.{SE
  2cc0: 43 54 0a 20 00 a0 13 93 7b 53 45 43 54 0a 90 00  CT. ....{SECT...
  2cd0: 0a 80 70 0a 08 50 4d 44 31 a1 3c 72 7b 53 53 49  ..p..PMD1.<r{SSI
  2ce0: 54 0a 03 00 7a 7b 53 53 49 54 0a 0c 00 0a 02 00  T...z{SSIT......
  2cf0: 60 a0 0c 93 0a 05 60 70 0a 0c 50 4d 44 31 a1 17  `.....`p..PMD1..
  2d00: a0 0c 93 0a 03 60 70 0a 0b 50 4d 44 31 a1 08 70  .....`p..PMD1..p
  2d10: 0a 0a 50 4d 44 31 a1 08 70 0a 01 50 4d 44 31 a0  ..PMD1..p..PMD1.
  2d20: 47 04 7b 53 59 4e 43 0a 08 00 70 7d 53 44 54 33  G.{SYNC...p}SDT3
  2d30: 0a 40 00 44 4d 44 31 a0 2f 7b 49 43 52 31 0a 08  .-cDEJmm6HT9M@public.gmane.org/{ICR1..
  2d40: 00 a0 14 7b 49 43 52 30 0a 08 00 72 44 4d 44 31  ...{ICR0...rDMD1
  2d50: 0a 02 44 4d 44 31 a0 10 7b 49 43 52 33 0a 08 00  ..DMD1..{ICR3...
  2d60: 70 0a 45 44 4d 44 31 a1 14 7d 74 7b 50 4d 44 31  p.EDMD1..}t{PMD1
  2d70: 0a 07 00 0a 02 00 0a 20 44 4d 44 31 a4 53 49 42  ....... DMD1.SIB
  2d80: 31 14 1c 5f 50 53 30 00 86 5c 2f 04 5f 53 42 5f  1.._PS0..\/._SB_
  2d90: 50 43 49 30 49 44 45 43 53 45 43 44 0a 01 14 06  PCI0IDECSECD....
  2da0: 5f 50 53 33 00 14 14 5f 50 53 43 00 a0 08 42 41  _PS3..._PSC...BA
  2db0: 59 50 a4 0a 03 a1 04 a4 0a 00 14 46 04 47 45 54  YP.........F.GET
  2dc0: 50 01 a0 0f 93 7b 68 0a 09 00 0a 00 a4 0c ff ff  P....{h.........
  2dd0: ff ff a0 0d 93 7b 68 0a 09 00 0a 08 a4 0b 84 03  .....{h.........
  2de0: 7a 7b 68 0b 00 03 00 0a 08 60 7a 7b 68 0b 00 30  z{h......`z{h..0
  2df0: 00 0a 0c 61 a4 77 0a 1e 74 0a 09 72 60 61 00 00  ...a.w..t..r`a..
  2e00: 00 14 30 47 44 4d 41 05 a0 23 68 a0 07 90 69 6c  ..0GDMA..#h...il
  2e10: a4 0a 14 a0 0e 90 6a 6c a4 77 74 0a 04 6b 00 0a  ......jl.wt..k..
  2e20: 0f 00 a4 77 74 0a 04 6b 00 0a 1e 00 a4 0c ff ff  ...wt..k........
  2e30: ff ff 14 1f 47 45 54 54 01 a4 77 0a 1e 74 0a 09  ....GETT..w..t..
  2e40: 72 7b 7a 68 0a 02 00 0a 03 00 7b 68 0a 03 00 00  r{zh......{h....
  2e50: 00 00 14 46 06 47 45 54 46 03 08 54 4d 50 46 0a  ...F.GETF..TMPF.
  2e60: 00 a0 0d 68 7d 54 4d 50 46 0a 01 54 4d 50 46 a0  ...h}TMPF..TMPF.
  2e70: 11 7b 6a 0a 02 00 7d 54 4d 50 46 0a 02 54 4d 50  .{j...}TMPF..TMP
  2e80: 46 a0 0d 69 7d 54 4d 50 46 0a 04 54 4d 50 46 a0  F..i}TMPF..TMPF.
  2e90: 11 7b 6a 0a 20 00 7d 54 4d 50 46 0a 08 54 4d 50  .{j. .}TMPF..TMP
  2ea0: 46 a0 12 7b 6a 0b 00 40 00 7d 54 4d 50 46 0a 10  F..{j..-4b8TPpkIZ3Q@public.gmane.org}TMPF..
  2eb0: 54 4d 50 46 a4 54 4d 50 46 14 3e 53 45 54 50 03  TMPF.TMPF.>SETP.
  2ec0: a0 08 94 68 0a f0 a4 0a 08 a1 2e a0 28 7b 69 0a  ...h........({i.
  2ed0: 02 00 a0 10 90 92 94 68 0a 78 7b 6a 0a 02 00 a4  .......h.x{j....
  2ee0: 0b 01 23 a0 10 90 92 94 68 0a b4 7b 6a 0a 01 00  ..#.....h..{j...
  2ef0: a4 0b 01 21 a4 0b 01 10 14 3b 53 44 4d 41 01 a0  ...!.....;SDMA..
  2f00: 09 92 94 68 0a 14 a4 0a 01 a0 09 92 94 68 0a 1e  ...h.........h..
  2f10: a4 0a 02 a0 09 92 94 68 0a 2d a4 0a 01 a0 09 92  .......h.-......
  2f20: 94 68 0a 3c a4 0a 02 a0 09 92 94 68 0a 5a a4 0a  .h.<.......h.Z..
  2f30: 01 a4 0a 00 14 30 53 45 54 54 03 a0 26 7b 69 0a  .....0SETT..&{i.
  2f40: 02 00 a0 0f 90 92 94 68 0a 78 7b 6a 0a 02 00 a4  .......h.x{j....
  2f50: 0a 0b a0 0f 90 92 94 68 0a b4 7b 6a 0a 01 00 a4  .......h..{j....
  2f60: 0a 09 a4 0a 04 5b 82 0f 53 4d 42 53 08 5f 41 44  .....[..SMBS._AD
  2f70: 52 0c 03 00 1f 00 5b 82 8f 95 01 4c 50 43 42 08  R.....[....LPCB.
  2f80: 5f 41 44 52 0c 00 00 1f 00 5b 80 4c 50 43 30 02  _ADR.....[.LPC0.
  2f90: 0a 60 0a ff 5b 81 49 06 4c 50 43 30 01 50 49 52  .`..[.I.LPC0.PIR
  2fa0: 41 08 50 49 52 42 08 50 49 52 43 08 50 49 52 44  A.PIRB.PIRC.PIRD
  2fb0: 08 00 20 50 49 52 45 08 50 49 52 46 08 50 49 52  .. PIRE.PIRF.PIR
  2fc0: 47 08 50 49 52 48 08 00 40 1a 00 07 43 34 43 33  G.PIRH..-EzraXk5dugk@public.gmane.org
  2fd0: 01 00 48 1f 43 4d 44 45 08 46 4c 44 45 08 53 4e  ..H.CMDE.FLDE.SN
  2fe0: 44 45 08 00 08 47 45 4e 31 10 4c 50 45 4e 10 00  DE...GEN1.LPEN..
  2ff0: 10 00 10 47 45 4e 32 10 00 20 46 44 49 53 10 5b  ...GEN2.. FDIS.[
  3000: 82 49 0a 4c 4e 4b 41 08 5f 48 49 44 0c 41 d0 0c  .I.LNKA._HID.A..
  3010: 0f 08 5f 55 49 44 0a 01 08 5f 50 52 53 11 09 0a  .._UID..._PRS...
  3020: 06 23 a8 0c 18 79 00 14 17 5f 53 54 41 00 a0 0b  .#...y..._STA...
  3030: 93 50 49 52 41 0a 80 a4 0a 09 a1 04 a4 0a 0b 14  .PIRA...........
  3040: 0d 5f 44 49 53 00 70 0a 80 50 49 52 41 14 39 5f  ._DIS.p..PIRA.9_
  3050: 43 52 53 00 08 42 55 46 41 11 09 0a 06 23 00 00  CRS..BUFA....#..
  3060: 18 79 00 8b 42 55 46 41 0a 01 49 52 42 31 a0 13  .y..BUFA..IRB1..
  3070: 92 93 50 49 52 41 0a 80 79 01 50 49 52 41 49 52  ..PIRA..y.PIRAIR
  3080: 42 31 a4 42 55 46 41 14 22 5f 53 52 53 01 8b 68  B1.BUFA."_SRS..h
  3090: 0a 01 49 52 42 31 81 49 52 42 31 60 a0 07 94 60  ..IRB1.IRB1`...`
  30a0: 0a 00 76 60 70 60 50 49 52 41 5b 82 49 0a 4c 4e  ..v`p`PIRA[.I.LN
  30b0: 4b 42 08 5f 48 49 44 0c 41 d0 0c 0f 08 5f 55 49  KB._HID.A...._UI
  30c0: 44 0a 02 08 5f 50 52 53 11 09 0a 06 23 40 00 18  D..._PRS....#@..
  30d0: 79 00 14 17 5f 53 54 41 00 a0 0b 93 50 49 52 42  y..._STA....PIRB
  30e0: 0a 80 a4 0a 09 a1 04 a4 0a 0b 14 0d 5f 44 49 53  ............_DIS
  30f0: 00 70 0a 80 50 49 52 42 14 39 5f 43 52 53 00 08  .p..PIRB.9_CRS..
  3100: 42 55 46 42 11 09 0a 06 23 00 00 18 79 00 8b 42  BUFB....#...y..B
  3110: 55 46 42 0a 01 49 52 42 31 a0 13 92 93 50 49 52  UFB..IRB1....PIR
  3120: 42 0a 80 79 01 50 49 52 42 49 52 42 31 a4 42 55  B..y.PIRBIRB1.BU
  3130: 46 42 14 22 5f 53 52 53 01 8b 68 0a 01 49 52 42  FB."_SRS..h..IRB
  3140: 31 81 49 52 42 31 60 a0 07 94 60 0a 00 76 60 70  1.IRB1`...`..v`p
  3150: 60 50 49 52 42 5b 82 49 0a 4c 4e 4b 43 08 5f 48  `PIRB[.I.LNKC._H
  3160: 49 44 0c 41 d0 0c 0f 08 5f 55 49 44 0a 03 08 5f  ID.A...._UID..._
  3170: 50 52 53 11 09 0a 06 23 a8 0c 18 79 00 14 17 5f  PRS....#...y..._
  3180: 53 54 41 00 a0 0b 93 50 49 52 43 0a 80 a4 0a 09  STA....PIRC.....
  3190: a1 04 a4 0a 0b 14 0d 5f 44 49 53 00 70 0a 80 50  ......._DIS.p..P
  31a0: 49 52 43 14 39 5f 43 52 53 00 08 42 55 46 43 11  IRC.9_CRS..BUFC.
  31b0: 09 0a 06 23 00 00 18 79 00 8b 42 55 46 43 0a 01  ...#...y..BUFC..
  31c0: 49 52 42 31 a0 13 92 93 50 49 52 43 0a 80 79 01  IRB1....PIRC..y.
  31d0: 50 49 52 43 49 52 42 31 a4 42 55 46 43 14 22 5f  PIRCIRB1.BUFC."_
  31e0: 53 52 53 01 8b 68 0a 01 49 52 42 31 81 49 52 42  SRS..h..IRB1.IRB
  31f0: 31 60 a0 07 94 60 0a 00 76 60 70 60 50 49 52 43  1`...`..v`p`PIRC
  3200: 5b 82 49 0a 4c 4e 4b 44 08 5f 48 49 44 0c 41 d0  [.I.LNKD._HID.A.
  3210: 0c 0f 08 5f 55 49 44 0a 04 08 5f 50 52 53 11 09  ..._UID..._PRS..
  3220: 0a 06 23 88 0c 18 79 00 14 17 5f 53 54 41 00 a0  ..#...y..._STA..
  3230: 0b 93 50 49 52 44 0a 80 a4 0a 09 a1 04 a4 0a 0b  ..PIRD..........
  3240: 14 0d 5f 44 49 53 00 70 0a 80 50 49 52 44 14 39  .._DIS.p..PIRD.9
  3250: 5f 43 52 53 00 08 42 55 46 44 11 09 0a 06 23 00  _CRS..BUFD....#.
  3260: 00 18 79 00 8b 42 55 46 44 0a 01 49 52 42 31 a0  ..y..BUFD..IRB1.
  3270: 13 92 93 50 49 52 44 0a 80 79 01 50 49 52 44 49  ...PIRD..y.PIRDI
  3280: 52 42 31 a4 42 55 46 44 14 22 5f 53 52 53 01 8b  RB1.BUFD."_SRS..
  3290: 68 0a 01 49 52 42 31 81 49 52 42 31 60 a0 07 94  h..IRB1.IRB1`...
  32a0: 60 0a 00 76 60 70 60 50 49 52 44 5b 82 49 0a 4c  `..v`p`PIRD[.I.L
  32b0: 4e 4b 45 08 5f 48 49 44 0c 41 d0 0c 0f 08 5f 55  NKE._HID.A...._U
  32c0: 49 44 0a 05 08 5f 50 52 53 11 09 0a 06 23 b8 cc  ID..._PRS....#..
  32d0: 18 79 00 14 17 5f 53 54 41 00 a0 0b 93 50 49 52  .y..._STA....PIR
  32e0: 45 0a 80 a4 0a 09 a1 04 a4 0a 0b 14 0d 5f 44 49  E............_DI
  32f0: 53 00 70 0a 80 50 49 52 45 14 39 5f 43 52 53 00  S.p..PIRE.9_CRS.
  3300: 08 42 55 46 44 11 09 0a 06 23 00 00 18 79 00 8b  .BUFD....#...y..
  3310: 42 55 46 44 0a 01 49 52 42 31 a0 13 92 93 50 49  BUFD..IRB1....PI
  3320: 52 45 0a 80 79 01 50 49 52 45 49 52 42 31 a4 42  RE..y.PIREIRB1.B
  3330: 55 46 44 14 22 5f 53 52 53 01 8b 68 0a 01 49 52  UFD."_SRS..h..IR
  3340: 42 31 81 49 52 42 31 60 a0 07 94 60 0a 00 76 60  B1.IRB1`...`..v`
  3350: 70 60 50 49 52 45 5b 82 49 0a 4c 4e 4b 46 08 5f  p`PIRE[.I.LNKF._
  3360: 48 49 44 0c 41 d0 0c 0f 08 5f 55 49 44 0a 06 08  HID.A...._UID...
  3370: 5f 50 52 53 11 09 0a 06 23 a8 0c 18 79 00 14 17  _PRS....#...y...
  3380: 5f 53 54 41 00 a0 0b 93 50 49 52 46 0a 80 a4 0a  _STA....PIRF....
  3390: 09 a1 04 a4 0a 0b 14 0d 5f 44 49 53 00 70 0a 80  ........_DIS.p..
  33a0: 50 49 52 46 14 39 5f 43 52 53 00 08 42 55 46 44  PIRF.9_CRS..BUFD
  33b0: 11 09 0a 06 23 00 00 18 79 00 8b 42 55 46 44 0a  ....#...y..BUFD.
  33c0: 01 49 52 42 31 a0 13 92 93 50 49 52 46 0a 80 79  .IRB1....PIRF..y
  33d0: 01 50 49 52 46 49 52 42 31 a4 42 55 46 44 14 22  .PIRFIRB1.BUFD."
  33e0: 5f 53 52 53 01 8b 68 0a 01 49 52 42 31 81 49 52  _SRS..h..IRB1.IR
  33f0: 42 31 60 a0 07 94 60 0a 00 76 60 70 60 50 49 52  B1`...`..v`p`PIR
  3400: 46 5b 82 49 0a 4c 4e 4b 47 08 5f 48 49 44 0c 41  F[.I.LNKG._HID.A
  3410: d0 0c 0f 08 5f 55 49 44 0a 07 08 5f 50 52 53 11  ...._UID..._PRS.
  3420: 09 0a 06 23 b8 cc 18 79 00 14 17 5f 53 54 41 00  ...#...y..._STA.
  3430: a0 0b 93 50 49 52 47 0a 80 a4 0a 09 a1 04 a4 0a  ...PIRG.........
  3440: 0b 14 0d 5f 44 49 53 00 70 0a 80 50 49 52 47 14  ..._DIS.p..PIRG.
  3450: 39 5f 43 52 53 00 08 42 55 46 44 11 09 0a 06 23  9_CRS..BUFD....#
  3460: 00 00 18 79 00 8b 42 55 46 44 0a 01 49 52 42 31  ...y..BUFD..IRB1
  3470: a0 13 92 93 50 49 52 47 0a 80 79 01 50 49 52 47  ....PIRG..y.PIRG
  3480: 49 52 42 31 a4 42 55 46 44 14 22 5f 53 52 53 01  IRB1.BUFD."_SRS.
  3490: 8b 68 0a 01 49 52 42 31 81 49 52 42 31 60 a0 07  .h..IRB1.IRB1`..
  34a0: 94 60 0a 00 76 60 70 60 50 49 52 47 5b 82 49 0a  .`..v`p`PIRG[.I.
  34b0: 4c 4e 4b 48 08 5f 48 49 44 0c 41 d0 0c 0f 08 5f  LNKH._HID.A...._
  34c0: 55 49 44 0a 08 08 5f 50 52 53 11 09 0a 06 23 a8  UID..._PRS....#.
  34d0: 0c 18 79 00 14 17 5f 53 54 41 00 a0 0b 93 50 49  ..y..._STA....PI
  34e0: 52 48 0a 80 a4 0a 09 a1 04 a4 0a 0b 14 0d 5f 44  RH............_D
  34f0: 49 53 00 70 0a 80 50 49 52 48 14 39 5f 43 52 53  IS.p..PIRH.9_CRS
  3500: 00 08 42 55 46 44 11 09 0a 06 23 00 00 18 79 00  ..BUFD....#...y.
  3510: 8b 42 55 46 44 0a 01 49 52 42 31 a0 13 92 93 50  .BUFD..IRB1....P
  3520: 49 52 48 0a 80 79 01 50 49 52 48 49 52 42 31 a4  IRH..y.PIRHIRB1.
  3530: 42 55 46 44 14 22 5f 53 52 53 01 8b 68 0a 01 49  BUFD."_SRS..h..I
  3540: 52 42 31 81 49 52 42 31 60 a0 07 94 60 0a 00 76  RB1.IRB1`...`..v
  3550: 60 70 60 50 49 52 48 5b 82 1d 50 53 32 4d 08 5f  `p`PIRH[..PS2M._
  3560: 48 49 44 0c 41 d0 0f 13 08 5f 43 52 53 11 08 0a  HID.A...._CRS...
  3570: 05 22 00 10 79 00 5b 82 39 4b 42 43 5f 08 5f 48  ."..y.[.9KBC_._H
  3580: 49 44 0c 41 d0 03 03 08 5f 50 52 57 12 06 02 0a  ID.A...._PRW....
  3590: 18 0a 04 08 5f 43 52 53 11 18 0a 15 47 01 60 00  ...._CRS....G.`.
  35a0: 60 00 01 01 47 01 64 00 64 00 01 01 22 02 00 79  `...G.d.d..."..y
  35b0: 00 5b 82 25 52 54 43 5f 08 5f 48 49 44 0c 41 d0  .[.%RTC_._HID.A.
  35c0: 0b 00 08 5f 43 52 53 11 10 0a 0d 47 01 70 00 70  ..._CRS....G.p.p
  35d0: 00 01 08 22 00 01 79 00 5b 82 2d 54 4d 52 5f 08  ..."..y.[.-TMR_.
  35e0: 5f 48 49 44 0c 41 d0 01 00 08 5f 43 52 53 11 18  _HID.A...._CRS..
  35f0: 0a 15 47 01 40 00 40 00 01 04 47 01 50 00 50 00  ..G.-4b8TPpkIZ3Q@public.gmane.org@...G.P.P.
  3600: 01 04 22 01 00 79 00 5b 82 22 53 50 4b 52 08 5f  .."..y.[."SPKR._
  3610: 48 49 44 0c 41 d0 08 00 08 5f 43 52 53 11 0d 0a  HID.A...._CRS...
  3620: 0a 47 01 61 00 61 00 01 01 79 00 5b 82 26 4d 45  .G.a.a...y.[.&ME
  3630: 4d 5f 08 5f 48 49 44 0c 41 d0 0c 01 08 5f 43 52  M_._HID.A...._CR
  3640: 53 11 11 0a 0e 86 09 00 00 00 00 f8 ff 00 00 08  S...............
  3650: 00 79 00 5b 82 45 0a 50 49 43 5f 08 5f 48 49 44  .y.[.E.PIC_._HID
  3660: 0b 41 d0 08 5f 43 52 53 11 41 09 0a 8d 47 01 20  .A.._CRS.A...G. 
  3670: 00 20 00 01 02 47 01 24 00 24 00 01 02 47 01 28  . ...G.$.$...G.(
  3680: 00 28 00 01 02 47 01 2c 00 2c 00 01 02 47 01 30  .(...G.,.,...G.0
  3690: 00 30 00 01 02 47 01 34 00 34 00 01 02 47 01 38  .0...G.4.4...G.8
  36a0: 00 38 00 01 02 47 01 3c 00 3c 00 01 02 47 01 a0  .8...G.<.<...G..
  36b0: 00 a0 00 01 02 47 01 a4 00 a4 00 01 02 47 01 a8  .....G.......G..
  36c0: 00 a8 00 01 02 47 01 ac 00 ac 00 01 02 47 01 b0  .....G.......G..
  36d0: 00 b0 00 01 02 47 01 b4 00 b4 00 01 02 47 01 b8  .....G.......G..
  36e0: 00 b8 00 01 02 47 01 bc 00 bc 00 01 02 47 01 d0  .....G.......G..
  36f0: 04 d0 04 01 02 22 04 00 79 00 5b 82 46 04 4d 41  ....."..y.[.F.MA
  3700: 44 5f 08 5f 48 49 44 0c 41 d0 02 00 08 5f 43 52  D_._HID.A...._CR
  3710: 53 11 30 0a 2d 47 01 00 00 00 00 01 20 47 01 81  S.0.-G...... G..
  3720: 00 81 00 01 0f 47 01 90 00 90 00 01 02 47 01 93  .....G.......G..
  3730: 00 93 00 01 0d 47 01 c0 00 c0 00 01 20 2a 10 01  .....G...... *..
  3740: 79 00 5b 82 44 07 50 4e 50 5f 08 5f 48 49 44 0c  y.[.D.PNP_._HID.
  3750: 41 d0 0c 02 08 5f 43 52 53 11 4e 05 0a 5a 47 01  A...._CRS.N..ZG.
  3760: 2e 00 2e 00 01 02 47 01 80 00 80 00 01 01 47 01  ......G.......G.
  3770: 92 00 92 00 01 01 47 01 80 06 80 06 01 80 47 01  ......G.......G.
  3780: 00 02 00 02 01 10 47 01 00 10 00 10 01 80 47 01  ......G.......G.
  3790: 00 13 00 13 01 40 47 01 7c 07 7c 07 01 04 47 01  .....-iwXizj+LCLg@public.gmane.org|.|...G.
  37a0: b2 00 b2 00 01 02 47 01 00 03 00 03 01 02 47 01  ......G.......G.
  37b0: 10 03 10 03 01 10 79 00 5b 82 25 43 4f 50 52 08  ......y.[.%COPR.
  37c0: 5f 48 49 44 0c 41 d0 0c 04 08 5f 43 52 53 11 10  _HID.A...._CRS..
  37d0: 0a 0d 47 01 f0 00 f0 00 01 01 22 00 20 79 00 5b  ..G.......". y.[
  37e0: 82 32 46 57 48 5f 08 5f 48 49 44 0c 25 d4 08 00  .2FWH_._HID.%...
  37f0: 08 5f 43 52 53 11 1d 0a 1a 86 09 00 00 00 00 b8  ._CRS...........
  3800: ff 00 00 08 00 86 09 00 00 00 00 b0 ff 00 00 08  ................
  3810: 00 79 00 5b 82 46 61 45 43 30 5f 08 5f 48 49 44  .y.[.FaEC0_._HID
  3820: 0c 41 d0 0c 09 14 26 5f 43 52 53 00 08 42 45 43  .A....&_CRS..BEC
  3830: 30 11 15 0a 12 47 01 62 00 62 00 01 01 47 01 66  0....G.b.b...G.f
  3840: 00 66 00 01 01 79 00 a4 42 45 43 30 5b 80 45 43  .f...y..BEC0[.EC
  3850: 46 32 03 0a 00 0a f0 5b 81 40 1b 5c 2f 05 5f 53  F2.....[.-4b8TPpkIZ3Q@public.gmane.org\/._S
  3860: 42 5f 50 43 49 30 4c 50 43 42 45 43 30 5f 45 43  B_PCI0LPCBEC0_EC
  3870: 46 32 11 00 40 18 50 42 41 43 01 00 4f 2f 4c 53  F2..-LkJyhOIAbqI@public.gmane.org/LS
  3880: 43 49 08 4c 48 4b 59 08 4c 49 44 43 01 44 4b 4f  CI.LHKY.LIDC.DKO
  3890: 4e 01 46 4e 4b 50 01 41 43 53 54 01 42 4c 57 31  N.FNKP.ACST.BLW1
  38a0: 01 42 4c 57 32 01 00 02 53 4d 49 45 01 57 4c 53  .BLW2...SMIE.WLS
  38b0: 54 01 42 54 52 53 01 57 4c 4f 4e 01 42 54 4b 49  T.BTRS.WLON.BTKI
  38c0: 01 42 54 53 54 01 42 54 49 54 01 42 54 50 57 01  .BTST.BTIT.BTPW.
  38d0: 42 31 53 54 01 42 32 53 54 01 00 02 42 31 43 47  B1ST.B2ST...B1CG
  38e0: 01 42 32 43 47 01 00 02 42 31 44 43 01 42 32 44  .B2CG...B1DC.B2D
  38f0: 43 01 00 02 42 31 46 43 01 42 32 46 43 01 00 02  C...B1FC.B2FC...
  3900: 42 31 4c 31 01 42 32 4c 31 01 00 02 42 31 4c 32  B1L1.B2L1...B1L2
  3910: 01 42 32 4c 32 01 00 02 42 31 43 41 01 42 32 43  .B2L2...B1CA.B2C
  3920: 41 01 00 02 42 31 43 44 01 42 32 43 44 01 00 02  A...B1CD.B2CD...
  3930: 42 31 43 53 02 42 32 43 53 02 00 04 4c 31 50 31  B1CS.B2CS...L1P1
  3940: 07 00 01 4c 31 50 32 07 00 01 42 50 4f 44 07 00  ...L1P2...BPOD..
  3950: 01 43 43 50 54 07 00 01 4c 54 4d 50 07 00 01 48  .CCPT...LTMP...H
  3960: 54 4d 50 07 00 01 53 54 4d 50 07 00 01 46 41 4e  TMP...STMP...FAN
  3970: 53 07 00 01 53 42 49 44 03 00 05 00 01 57 4c 49  S...SBID.....WLI
  3980: 44 01 57 50 57 52 01 57 42 4c 32 01 57 44 43 4b  D.WPWR.WBL2.WDCK
  3990: 01 00 03 42 52 49 47 08 42 31 42 4c 07 00 01 42  ...BRIG.B1BL...B
  39a0: 32 42 4c 07 00 11 52 43 42 31 10 4c 46 43 31 10  2BL...RCB1.LFC1.
  39b0: 44 45 53 31 10 52 43 42 32 10 4c 46 43 32 10 44  DES1.RCB2.LFC2.D
  39c0: 45 53 32 10 00 10 45 4c 49 44 01 45 4b 42 44 01  ES2...ELID.EKBD.
  39d0: 00 0e 45 43 4c 4b 01 45 54 53 34 01 00 06 42 31  ..ECLK.ETS4...B1
  39e0: 53 4e 10 42 32 53 4e 10 42 31 50 52 10 42 32 50  SN.B2SN.B1PR.B2P
  39f0: 52 10 00 48 0d 42 31 52 53 04 42 32 52 53 04 42  R..H.B1RS.B2RS.B
  3a00: 31 4d 46 04 42 32 4d 46 04 14 0d 5f 50 53 30 00  1MF.B2MF..._PS0.
  3a10: 70 0a 00 44 46 45 43 14 0d 5f 50 53 33 00 70 0a  p..DFEC.._PS3.p.
  3a20: 01 44 46 45 43 14 26 5f 52 45 47 02 70 0a 01 60  .DFEC.&_REG.p..`
  3a30: a0 1b 93 68 0a 03 a0 0c 93 69 0a 01 70 0a 01 45  ...h.....i..p..E
  3a40: 43 4f 4e a1 08 70 0a 00 45 43 4f 4e 08 5f 47 50  CON..p..ECON._GP
  3a50: 45 0a 10 14 28 5f 51 31 31 00 70 5c 2f 05 5f 53  E...(_Q11.p\/._S
  3a60: 42 5f 50 43 49 30 4c 50 43 42 45 43 30 5f 43 43  B_PCI0LPCBEC0_CC
  3a70: 50 54 60 5b 22 0a c8 53 54 45 56 60 14 43 04 5f  PT`["..STEV`.C._
  3a80: 51 31 32 00 a0 0c 51 4f 44 44 70 0a 00 51 4f 44  Q12...QODDp..QOD
  3a90: 44 a1 2e 70 0a 01 51 45 31 32 75 51 43 4e 54 86  D..p..QE12uQCNT.
  3aa0: 5c 2e 5f 53 42 5f 42 41 54 30 0a 80 86 5c 2e 5f  \._SB_BAT0...\._
  3ab0: 53 42 5f 42 41 54 31 0a 80 70 0a 01 51 4f 44 44  SB_BAT1..p..QODD
  3ac0: 14 41 09 5f 51 31 33 00 70 5c 2f 05 5f 53 42 5f  .A._Q13.p\/._SB_
  3ad0: 50 43 49 30 4c 50 43 42 45 43 30 5f 41 43 53 54  PCI0LPCBEC0_ACST
  3ae0: 60 a0 10 60 70 0a 00 51 45 31 32 70 0a 00 51 43  `..`p..QE12p..QC
  3af0: 4e 54 a0 4f 05 92 93 60 53 5f 41 43 a0 0c 93 60  NT.O...`S_AC...`
  3b00: 0a 01 70 0a 01 53 5f 41 43 a1 08 70 0a 00 53 5f  ..p..S_AC..p..S_
  3b10: 41 43 5c 2e 5f 53 42 5f 47 53 4d 49 0a 1e 86 5c  AC\._SB_GSMI...\
  3b20: 2e 5f 53 42 5f 41 43 5f 5f 0a 00 86 5c 2e 5f 53  ._SB_AC__...\._S
  3b30: 42 5f 42 41 54 30 0a 80 86 5c 2e 5f 53 42 5f 42  B_BAT0...\._SB_B
  3b40: 41 54 31 0a 80 86 5c 2e 5f 50 52 5f 43 50 55 30  AT1...\._PR_CPU0
  3b50: 0a 80 14 47 04 5f 51 31 34 00 a0 24 5c 2f 05 5f  ...G._Q14..$\/._
  3b60: 53 42 5f 50 43 49 30 4c 50 43 42 45 43 30 5f 4c  SB_PCI0LPCBEC0_L
  3b70: 49 44 43 5c 2e 5f 53 42 5f 47 53 4d 49 0a 1b a1  IDC\._SB_GSMI...
  3b80: 0d 5c 2e 5f 53 42 5f 47 53 4d 49 0a 1c 86 5c 2e  .\._SB_GSMI...\.
  3b90: 5f 53 42 5f 4c 49 44 5f 0a 80 14 46 0a 5f 51 31  _SB_LID_...F._Q1
  3ba0: 37 00 70 0a 01 60 a0 27 93 5c 2f 05 5f 53 42 5f  7.p..`.'.\/._SB_
  3bb0: 50 43 49 30 4c 50 43 42 45 43 30 5f 44 4b 4f 4e  PCI0LPCBEC0_DKON
  3bc0: 0a 00 5c 2e 5f 53 42 5f 47 53 4d 49 0a 0b a0 42  ..\._SB_GSMI...B
  3bd0: 07 90 92 93 4d 59 4f 53 0a 01 93 44 4b 41 50 0a  ....MYOS...DKAP.
  3be0: 01 a0 2e 5c 2f 05 5f 53 42 5f 50 43 49 30 4c 50  ...\/._SB_PCI0LP
  3bf0: 43 42 45 43 30 5f 44 4b 4f 4e 86 5c 2f 04 5f 53  CBEC0_DKON.\/._S
  3c00: 42 5f 50 43 49 30 50 43 49 32 44 4f 43 4b 0a 00  B_PCI0PCI2DOCK..
  3c10: a1 30 86 5c 2f 04 5f 53 42 5f 50 43 49 30 50 43  .0.\/._SB_PCI0PC
  3c20: 49 32 44 4f 43 4b 0a 01 5b 24 5c 2f 05 5f 53 42  I2DOCK..[$\/._SB
  3c30: 5f 50 43 49 30 50 43 49 32 44 4f 43 4b 44 4b 52  _PCI0PCI2DOCKDKR
  3c40: 51 14 28 5f 51 31 38 00 5c 2e 5f 53 42 5f 47 53  Q.(_Q18.\._SB_GS
  3c50: 4d 49 0a 04 86 5c 2f 04 5f 53 42 5f 50 43 49 30  MI...\/._SB_PCI0
  3c60: 49 44 45 43 53 45 43 44 0a 01 14 2d 5f 51 31 39  IDECSECD...-_Q19
  3c70: 00 70 0a 01 60 a0 22 93 44 46 45 43 0a 00 86 5c  .p..`.".DFEC...\
  3c80: 2e 5f 53 42 5f 42 41 54 30 0a 80 86 5c 2e 5f 53  ._SB_BAT0...\._S
  3c90: 42 5f 42 41 54 30 0a 81 14 2d 5f 51 31 42 00 70  B_BAT0...-_Q1B.p
  3ca0: 0a 01 60 a0 22 93 44 46 45 43 0a 00 86 5c 2e 5f  ..`.".DFEC...\._
  3cb0: 53 42 5f 42 41 54 31 0a 80 86 5c 2e 5f 53 42 5f  SB_BAT1...\._SB_
  3cc0: 42 41 54 31 0a 81 14 12 5f 51 32 35 00 5c 2e 5f  BAT1...._Q25.\._
  3cd0: 53 42 5f 47 53 4d 49 0a 05 14 20 5f 51 32 36 00  SB_GSMI... _Q26.
  3ce0: 70 0a 11 50 38 30 54 5c 2e 5f 53 42 5f 47 53 4d  p..P80T\._SB_GSM
  3cf0: 49 0a 0b 70 0a 22 50 38 30 54 14 4a 0a 5f 51 32  I..p."P80T.J._Q2
  3d00: 38 00 a0 45 09 45 43 4f 4e a0 4e 08 5c 2f 05 5f  8..E.ECON.N.\/._
  3d10: 53 42 5f 50 43 49 30 4c 50 43 42 45 43 30 5f 42  SB_PCI0LPCBEC0_B
  3d20: 54 53 54 a0 44 07 5c 2f 05 5f 53 42 5f 50 43 49  TST.D.\/._SB_PCI
  3d30: 30 4c 50 43 42 45 43 30 5f 42 54 4b 49 70 0a 01  0LPCBEC0_BTKIp..
  3d40: 5c 2f 05 5f 53 42 5f 50 43 49 30 4c 50 43 42 45  \/._SB_PCI0LPCBE
  3d50: 43 30 5f 42 54 50 57 5b 22 0b 34 08 70 0a 01 5c  C0_BTPW[".4.p..\
  3d60: 2f 05 5f 53 42 5f 50 43 49 30 4c 50 43 42 45 43  /._SB_PCI0LPCBEC
  3d70: 30 5f 42 54 49 54 5b 22 0a 32 70 0a 01 5c 2f 05  0_BTIT[".2p..\/.
  3d80: 5f 53 42 5f 50 43 49 30 4c 50 43 42 45 43 30 5f  _SB_PCI0LPCBEC0_
  3d90: 42 54 52 53 5b 22 0a 64 86 5c 2e 5f 53 42 5f 42  BTRS[".d.\._SB_B
  3da0: 54 5f 5f 0a 00 14 47 04 5f 51 34 30 00 5c 2e 5f  T__...G._Q40.\._
  3db0: 53 42 5f 47 53 4d 49 0a 12 70 41 50 4d 44 43 4c  SB_GSMI..pAPMDCL
  3dc0: 4d 54 43 48 47 54 43 4c 4d 54 53 54 45 56 5c 2f  MTCHGTCLMTSTEV\/
  3dd0: 05 5f 53 42 5f 50 43 49 30 4c 50 43 42 45 43 30  ._SB_PCI0LPCBEC0
  3de0: 5f 43 43 50 54 86 5c 5f 54 5a 5f 0a 80 14 3d 5f  _CCPT.\_TZ_...=_
  3df0: 51 34 31 00 5c 2e 5f 53 42 5f 47 53 4d 49 0a 20  Q41.\._SB_GSMI. 
  3e00: 70 41 50 4d 44 41 43 50 53 a0 21 92 93 41 43 50  pAPMDACPS.!..ACP
  3e10: 53 53 41 43 50 86 5c 2e 5f 50 52 5f 43 50 55 30  SSACP.\._PR_CPU0
  3e20: 0a 80 70 41 43 50 53 53 41 43 50 5b 82 4a aa 53  ..pACPSSACP[.J.S
  3e30: 49 4f 44 08 5f 48 49 44 0c 41 d0 0a 05 08 42 41  IOD._HID.A....BA
  3e40: 53 45 0a 2e 5b 80 53 37 36 39 01 42 41 53 45 0a  SE..[.S769.BASE.
  3e50: 02 5b 81 10 53 37 36 39 01 41 49 4e 58 08 41 44  .[..S769.AINX.AD
  3e60: 54 41 08 5b 86 41 06 41 49 4e 58 41 44 54 41 01  TA.[.A.AINXADTA.
  3e70: 00 38 4c 44 4e 53 08 00 40 14 41 43 54 52 01 00  .8LDNS..-GJurPvEA92U@public.gmane.org
  3e80: 07 00 48 17 50 4d 53 42 08 50 4c 53 42 08 53 4d  ..H.PMSB.PLSB.SM
  3e90: 53 42 08 53 4c 53 42 08 00 40 06 49 4e 54 4c 04  SB.SLSB..-pCztMlyRrSA@public.gmane.org
  3ea0: 00 04 00 18 44 4d 41 43 03 00 05 00 48 3d 50 50  ....DMAC....H=PP
  3eb0: 4d 44 03 00 05 00 02 46 48 44 55 01 53 50 4d 44  MD.....FHDU.SPMD
  3ec0: 03 4d 55 58 4f 02 5b 01 4d 55 54 30 00 14 15 55  .MUXO.[.MUT0...U
  3ed0: 4e 4c 4b 00 5b 23 4d 55 54 30 ff 0f 70 0a 55 41  NLK.[#MUT0..p.UA
  3ee0: 49 4e 58 14 13 4c 4b 55 50 00 70 0a aa 41 49 4e  INX..LKUP.p..AIN
  3ef0: 58 5b 27 4d 55 54 30 14 0c 53 4c 44 4e 01 70 68  X['MUT0..SLDN.ph
  3f00: 4c 44 4e 53 08 44 4d 41 50 12 0a 04 0a 00 0a 01  LDNS.DMAP.......
  3f10: 0a 02 0a 03 5b 82 44 1e 45 43 50 5f 08 5f 48 49  ....[.D.ECP_._HI
  3f20: 44 0c 41 d0 04 01 14 26 5f 53 54 41 00 a0 17 90  D.A....&_STA....
  3f30: 93 50 54 59 50 0a 03 92 93 4c 50 54 45 0a 00 70  .PTYP....LPTE..p
  3f40: 50 53 54 41 60 a1 05 70 0a 00 60 a4 60 14 0a 5f  PSTA`..p..`.`.._
  3f50: 44 49 53 00 50 44 49 53 08 45 43 52 53 11 1b 0a  DIS.PDIS.ECRS...
  3f60: 18 47 01 78 03 78 03 00 08 22 80 00 47 01 78 07  .G.x.x..."..G.x.
  3f70: 78 07 00 04 2a 08 00 79 00 14 44 0c 5f 43 52 53  x...*..y..D._CRS
  3f80: 00 5b 13 45 43 52 53 0a 00 0a 58 4c 50 54 52 70  .[.ECRS...XLPTRp
  3f90: 50 43 52 53 4c 50 54 52 8c 45 43 52 53 0a 02 45  PCRSLPTR.ECRS..E
  3fa0: 41 44 4c 8c 45 43 52 53 0a 03 45 41 44 4d 8c 45  ADL.ECRS..EADM.E
  3fb0: 43 52 53 0a 0d 45 41 53 4c 8c 45 43 52 53 0a 0e  CRS..EASL.ECRS..
  3fc0: 45 41 44 53 8c 45 43 52 53 0a 0f 45 41 4c 4c 8c  EADS.ECRS..EALL.
  3fd0: 45 43 52 53 0a 10 45 41 44 32 8b 45 43 52 53 0a  ECRS..EAD2.ECRS.
  3fe0: 14 45 43 50 44 72 45 41 44 4d 0a 04 45 41 44 53  .ECPDrEADM..EADS
  3ff0: 70 45 41 44 53 45 41 44 32 70 45 41 44 4c 45 41  pEADSEAD2pEADLEA
  4000: 53 4c 70 45 41 44 4c 45 41 4c 4c 55 4e 4c 4b 53  SLpEADLEALLUNLKS
  4010: 4c 44 4e 0a 03 70 89 44 4d 41 50 01 44 4d 41 43  LDN..p.DMAP.DMAC
  4020: 00 0a 00 0a 00 60 79 0a 01 60 45 43 50 44 70 45  .....`y..`ECPDpE
  4030: 43 50 44 5b 31 4c 4b 55 50 a4 45 43 52 53 08 45  CPD[1LKUP.ECRS.E
  4040: 50 52 53 11 40 09 0a 8c 30 47 01 78 03 78 03 00  PRS.-YKTHiYkeidM7Bk9MgHMCNA@public.gmane.org
  4050: 08 22 80 00 47 01 78 07 78 07 00 04 2a 02 00 30  ."..G.x.x...*..0
  4060: 47 01 78 02 78 02 00 08 22 20 00 47 01 78 06 78  G.x.x..." .G.x.x
  4070: 06 00 04 2a 02 00 30 47 01 bc 03 bc 03 00 04 22  ...*..0G......."
  4080: 80 00 47 01 bc 07 bc 07 00 04 2a 02 00 30 47 01  ..G.......*..0G.
  4090: 78 03 78 03 00 08 22 80 00 47 01 78 07 78 07 00  x.x..."..G.x.x..
  40a0: 04 2a 08 00 30 47 01 78 02 78 02 00 08 22 20 00  .*..0G.x.x..." .
  40b0: 47 01 78 06 78 06 00 04 2a 08 00 30 47 01 bc 03  G.x.x...*..0G...
  40c0: bc 03 00 04 22 80 00 47 01 bc 07 bc 07 00 04 2a  ...."..G.......*
  40d0: 08 00 79 00 14 0b 5f 50 52 53 00 a4 45 50 52 53  ..y..._PRS..EPRS
  40e0: 14 19 5f 53 52 53 01 55 4e 4c 4b 53 4c 44 4e 0a  .._SRS.UNLKSLDN.
  40f0: 03 50 53 52 53 68 4c 4b 55 50 5b 82 44 10 4c 50  .PSRShLKUP[.D.LP
  4100: 54 5f 08 5f 48 49 44 0c 41 d0 04 00 14 27 5f 53  T_._HID.A....'_S
  4110: 54 41 00 a0 18 90 92 93 4c 50 54 45 0a 00 92 93  TA......LPTE....
  4120: 50 54 59 50 0a 03 70 50 53 54 41 60 a1 05 70 0a  PTYP..pPSTA`..p.
  4130: 00 60 a4 60 14 0a 5f 44 49 53 00 50 44 49 53 08  .`.`.._DIS.PDIS.
  4140: 4c 43 52 53 11 10 0a 0d 47 01 78 03 78 03 00 08  LCRS....G.x.x...
  4150: 22 80 00 79 00 14 22 5f 43 52 53 00 5b 13 4c 43  "..y.."_CRS.[.LC
  4160: 52 53 0a 00 0a 58 4c 50 54 52 70 50 43 52 53 4c  RS...XLPTRpPCRSL
  4170: 50 54 52 a4 4c 43 52 53 08 4c 50 52 53 11 29 0a  PTR.LCRS.LPRS.).
  4180: 26 30 47 01 78 03 78 03 00 08 22 80 00 30 47 01  &0G.x.x..."..0G.
  4190: 78 02 78 02 00 08 22 20 00 30 47 01 bc 03 bc 03  x.x..." .0G.....
  41a0: 00 04 22 80 00 79 00 08 50 50 52 53 11 1d 0a 1a  .."..y..PPRS....
  41b0: 30 47 01 78 03 78 03 00 08 22 80 00 30 47 01 78  0G.x.x..."..0G.x
  41c0: 02 78 02 00 08 22 20 00 79 00 14 1b 5f 50 52 53  .x..." .y..._PRS
  41d0: 00 a0 0d 93 50 54 59 50 0a 02 a4 50 50 52 53 a1  ....PTYP...PPRS.
  41e0: 06 a4 4c 50 52 53 14 19 5f 53 52 53 01 55 4e 4c  ..LPRS.._SRS.UNL
  41f0: 4b 53 4c 44 4e 0a 03 50 53 52 53 68 4c 4b 55 50  KSLDN..PSRShLKUP
  4200: 14 26 50 53 54 41 00 55 4e 4c 4b 53 4c 44 4e 0a  .&PSTA.UNLKSLDN.
  4210: 03 a0 09 41 43 54 52 70 0a 0f 60 a1 05 70 0a 0d  ...ACTRp..`..p..
  4220: 60 4c 4b 55 50 a4 60 14 0e 50 44 49 53 00 55 4e  `LKUP.`..PDIS.UN
  4230: 4c 4b 4c 4b 55 50 08 50 52 53 54 11 0e 0a 0b 47  LKLKUP.PRST....G
  4240: 01 78 03 78 03 00 08 22 80 00 14 4b 09 50 43 52  .x.x..."...K.PCR
  4250: 53 00 8c 50 52 53 54 0a 02 45 50 4c 41 8c 50 52  S..PRST..EPLA.PR
  4260: 53 54 0a 03 45 50 4d 41 8c 50 52 53 54 0a 04 45  ST..EPMA.PRST..E
  4270: 50 4c 31 8c 50 52 53 54 0a 05 45 50 4d 32 8b 50  PL1.PRST..EPM2.P
  4280: 52 53 54 0a 09 45 43 50 49 8c 50 52 53 54 0a 07  RST..ECPI.PRST..
  4290: 45 50 49 4f 55 4e 4c 4b 53 4c 44 4e 0a 03 70 50  EPIOUNLKSLDN..pP
  42a0: 4d 53 42 45 50 4d 41 70 50 4c 53 42 45 50 4c 41  MSBEPMApPLSBEPLA
  42b0: 70 50 4d 53 42 45 50 4d 32 70 50 4c 53 42 45 50  pPMSBEPM2pPLSBEP
  42c0: 4c 31 a0 0f 93 45 50 4c 41 0a bc 70 0a 04 45 50  L1...EPLA..p..EP
  42d0: 49 4f 79 0a 01 49 4e 54 4c 45 43 50 49 4c 4b 55  IOy..INTLECPILKU
  42e0: 50 a4 50 52 53 54 14 4a 0f 50 53 52 53 01 8b 68  P.PRST.J.PSRS..h
  42f0: 0a 02 45 41 44 30 8b 68 0a 09 45 43 50 49 70 0a  ..EAD0.h..ECPIp.
  4300: 01 41 43 54 52 a0 16 93 50 54 59 50 0a 00 70 0a  .ACTR...PTYP..p.
  4310: 04 44 4d 41 43 70 0a 00 50 50 4d 44 a1 43 06 a0  .DMACp..PPMD.C..
  4320: 16 93 50 54 59 50 0a 01 70 0a 04 44 4d 41 43 70  ..PTYP..p..DMACp
  4330: 0a 00 50 50 4d 44 a0 32 93 50 54 59 50 0a 03 8c  ..PPMD.2.PTYP...
  4340: 68 0a 14 45 43 50 44 81 45 43 50 44 60 a0 07 94  h..ECPD.ECPD`...
  4350: 60 0a 00 76 60 70 83 88 44 4d 41 50 60 00 44 4d  `..v`p..DMAP`.DM
  4360: 41 43 70 0a 02 50 50 4d 44 a0 16 93 50 54 59 50  ACp..PPMD...PTYP
  4370: 0a 02 70 0a 04 44 4d 41 43 70 0a 01 50 50 4d 44  ..p..DMACp..PPMD
  4380: 8c 68 0a 02 45 41 44 4c 8c 68 0a 03 45 41 44 48  .h..EADL.h..EADH
  4390: 70 45 41 44 4c 50 4c 53 42 70 45 41 44 48 50 4d  pEADLPLSBpEADHPM
  43a0: 53 42 a0 2a 93 50 54 59 50 0a 03 8c 68 0a 0d 41  SB.*.PTYP...h..A
  43b0: 44 53 4c 8c 68 0a 0e 41 44 53 48 70 41 44 53 4c  DSL.h..ADSHpADSL
  43c0: 53 4c 53 42 70 41 44 53 48 53 4d 53 42 81 45 43  SLSBpADSHSMSB.EC
  43d0: 50 49 60 a0 07 94 60 0a 00 76 60 70 60 49 4e 54  PI`...`..v`p`INT
  43e0: 4c 5b 82 4a 08 43 4f 4d 31 08 5f 48 49 44 0c 41  L[.J.COM1._HID.A
  43f0: d0 05 01 08 5f 55 49 44 0a 00 14 20 5f 53 54 41  ...._UID... _STA
  4400: 00 a0 11 92 93 43 4d 41 44 0a 00 70 55 53 54 41  .....CMAD..pUSTA
  4410: 0a 00 60 a1 05 70 0a 00 60 a4 60 14 0a 5f 44 49  ..`..p..`.`.._DI
  4420: 53 00 70 0a 01 60 14 24 5f 43 52 53 00 5b 13 55  S.p..`.$_CRS.[.U
  4430: 49 52 53 0a 00 0a 58 55 52 53 5f 70 55 43 52 53  IRS...XURS_pUCRS
  4440: 0a 00 55 52 53 5f a4 55 49 52 53 14 0f 5f 50 52  ..URS_.UIRS.._PR
  4450: 53 00 70 0a 01 60 a4 55 50 52 53 14 11 5f 53 52  S.p..`.UPRS.._SR
  4460: 53 01 70 0a 01 60 55 53 52 53 68 0a 00 5b 82 4c  S.p..`USRSh..[.L
  4470: 1a 46 49 52 5f 08 5f 48 49 44 0c 4d a3 f0 10 08  .FIR_._HID.M....
  4480: 5f 55 49 44 0a 03 14 10 5f 53 54 41 00 70 55 53  _UID...._STA.pUS
  4490: 54 41 0a 01 60 a4 60 14 0c 5f 44 49 53 00 55 44  TA..`.`.._DIS.UD
  44a0: 49 53 0a 01 14 48 06 5f 43 52 53 00 5b 13 46 43  IS...H._CRS.[.FC
  44b0: 52 53 0a 00 0a 58 55 52 53 5f 8c 46 43 52 53 0a  RS...XURS_.FCRS.
  44c0: 0c 49 52 44 4d 8c 46 43 52 53 0a 10 46 41 44 5f  .IRDM.FCRS..FAD_
  44d0: 70 55 43 52 53 0a 01 55 52 53 5f 55 4e 4c 4b a0  pUCRS..URS_UNLK.
  44e0: 1b 92 94 44 4d 41 43 0a 04 79 0a 01 83 88 44 4d  ...DMAC..y....DM
  44f0: 41 50 44 4d 41 43 00 49 52 44 4d 70 53 4c 53 42  APDMAC.IRDMpSLSB
  4500: 46 41 44 5f 4c 4b 55 50 a4 46 43 52 53 08 5f 50  FAD_LKUP.FCRS._P
  4510: 52 53 11 4e 0b 0a ba 30 47 01 f8 02 f8 02 00 08  RS.N...0G.......
  4520: 22 08 00 2a 02 00 47 01 00 01 00 01 00 08 30 47  "..*..G.......0G
  4530: 01 f8 02 f8 02 00 08 22 08 00 2a 02 00 47 01 10  ......."..*..G..
  4540: 01 10 01 00 08 30 47 01 e8 03 e8 03 00 08 22 10  .....0G.......".
  4550: 00 2a 02 00 47 01 20 01 20 01 00 08 30 47 01 e8  .*..G. . ...0G..
  4560: 02 e8 02 00 08 22 08 00 2a 02 00 47 01 30 01 30  ....."..*..G.0.0
  4570: 01 00 08 30 47 01 f8 03 f8 03 00 08 22 10 00 2a  ...0G......."..*
  4580: 08 00 47 01 00 01 00 01 00 08 30 47 01 f8 02 f8  ..G.......0G....
  4590: 02 00 08 22 08 00 2a 08 00 47 01 10 01 10 01 00  ..."..*..G......
  45a0: 08 30 47 01 e8 03 e8 03 00 08 22 10 00 2a 08 00  .0G......."..*..
  45b0: 47 01 20 01 20 01 00 08 30 47 01 e8 02 e8 02 00  G. . ...0G......
  45c0: 08 22 08 00 2a 08 00 47 01 30 01 30 01 00 08 79  ."..*..G.0.0...y
  45d0: 00 14 11 5f 53 52 53 01 70 0a 01 60 55 53 52 53  ..._SRS.p..`USRS
  45e0: 68 0a 01 5b 84 36 50 55 54 32 00 00 00 14 09 5f  h..[.6PUT2....._
  45f0: 53 54 41 00 a4 0a 01 14 0b 5f 4f 4e 5f 00 70 0a  STA......_ON_.p.
  4600: 01 60 a3 14 0b 5f 4f 46 46 00 70 0a 01 60 a3 08  .`..._OFF.p..`..
  4610: 5f 50 52 30 12 06 01 50 55 54 32 08 55 49 52 54  _PR0...PUT2.UIRT
  4620: 11 0e 0a 0b 47 01 f8 02 f8 02 00 08 22 08 00 08  ....G......."...
  4630: 55 49 52 53 11 10 0a 0d 47 01 00 00 00 00 00 08  UIRS....G.......
  4640: 22 00 00 79 00 08 46 43 52 53 11 1b 0a 18 47 01  "..y..FCRS....G.
  4650: e8 02 e8 02 00 08 22 08 00 2a 04 00 47 01 00 01  ......"..*..G...
  4660: 00 01 00 08 79 00 08 55 50 52 53 11 46 06 0a 62  ....y..UPRS.F..b
  4670: 30 47 01 f8 03 f8 03 00 08 22 10 00 30 47 01 f8  0G......."..0G..
  4680: 02 f8 02 00 08 22 08 00 30 47 01 e8 03 e8 03 00  ....."..0G......
  4690: 08 22 10 00 30 47 01 e8 03 e8 03 00 08 22 20 00  ."..0G......." .
  46a0: 30 47 01 e8 03 e8 03 00 08 22 80 00 30 47 01 e8  0G......."..0G..
  46b0: 02 e8 02 00 08 22 08 00 30 47 01 e8 02 e8 02 00  ....."..0G......
  46c0: 08 22 20 00 30 47 01 e8 02 e8 02 00 08 22 80 00  ." .0G......."..
  46d0: 79 00 14 31 55 53 54 41 01 55 4e 4c 4b a0 08 68  y..1USTA.UNLK..h
  46e0: 53 4c 44 4e 0a 05 a1 07 53 4c 44 4e 0a 04 a0 09  SLDN....SLDN....
  46f0: 41 43 54 52 70 0a 0f 60 a1 05 70 0a 0d 60 4c 4b  ACTRp..`..p..`LK
  4700: 55 50 a4 60 14 06 55 44 49 53 01 14 4b 08 55 43  UP.`..UDIS..K.UC
  4710: 52 53 01 55 4e 4c 4b 8c 55 49 52 54 0a 02 55 41  RS.UNLK.UIRT..UA
  4720: 44 4c 8c 55 49 52 54 0a 03 55 41 44 48 8c 55 49  DL.UIRT..UADH.UI
  4730: 52 54 0a 04 41 44 31 4c 8c 55 49 52 54 0a 05 41  RT..AD1L.UIRT..A
  4740: 44 31 48 8c 55 49 52 54 0a 09 55 49 52 51 a0 08  D1H.UIRT..UIRQ..
  4750: 68 53 4c 44 4e 0a 05 a1 07 53 4c 44 4e 0a 04 70  hSLDN....SLDN..p
  4760: 50 4c 53 42 55 41 44 4c 70 50 4d 53 42 55 41 44  PLSBUADLpPMSBUAD
  4770: 48 70 50 4c 53 42 41 44 31 4c 70 50 4d 53 42 41  HpPLSBAD1LpPMSBA
  4780: 44 31 48 79 0a 01 49 4e 54 4c 55 49 52 51 4c 4b  D1Hy..INTLUIRQLK
  4790: 55 50 a4 55 49 52 54 14 4f 13 55 53 52 53 02 55  UP.UIRT.O.USRS.U
  47a0: 4e 4c 4b 8b 68 0a 02 55 41 44 52 8c 68 0a 02 55  NLK.h..UADR.h..U
  47b0: 41 44 4c 8c 68 0a 03 55 41 44 48 8c 68 0a 09 55  ADL.h..UADH.h..U
  47c0: 49 52 51 a0 4a 0c 69 53 4c 44 4e 0a 05 70 0a 00  IRQ.J.iSLDN..p..
  47d0: 53 50 4d 44 70 0a 00 4d 55 58 4f 70 0a 00 53 4d  SPMDp..MUXOp..SM
  47e0: 53 42 70 0a 00 53 4c 53 42 70 0a 04 44 4d 41 43  SBp..SLSBp..DMAC
  47f0: 70 0a 01 41 43 54 52 a0 0f 93 55 54 59 50 0a 00  p..ACTR...UTYP..
  4800: 70 0a 00 53 50 4d 44 a1 46 08 70 0a 01 4d 55 58  p..SPMD.F.p..MUX
  4810: 4f 70 0a 01 46 48 44 55 a0 0f 93 55 54 59 50 0a  Op..FHDU...UTYP.
  4820: 01 70 0a 01 53 50 4d 44 a0 0f 93 55 54 59 50 0a  .p..SPMD...UTYP.
  4830: 02 70 0a 02 53 50 4d 44 a0 45 05 93 55 54 59 50  .p..SPMD.E..UTYP
  4840: 0a 03 70 0a 05 53 50 4d 44 8c 68 0a 10 55 46 41  ..p..SPMD.h..UFA
  4850: 4c 8c 68 0a 11 55 46 41 48 8c 68 0a 0c 49 52 44  L.h..UFAH.h..IRD
  4860: 4d 81 49 52 44 4d 60 a0 07 94 60 0a 00 76 60 70  M.IRDM`...`..v`p
  4870: 83 88 44 4d 41 50 60 00 44 4d 41 43 70 55 46 41  ..DMAP`.DMACpUFA
  4880: 48 53 4d 53 42 70 55 46 41 4c 53 4c 53 42 a0 08  HSMSBpUFALSLSB..
  4890: 69 53 4c 44 4e 0a 05 a1 0e 53 4c 44 4e 0a 04 70  iSLDN....SLDN..p
  48a0: 0a 00 53 50 4d 44 70 0a 01 41 43 54 52 70 55 41  ..SPMDp..ACTRpUA
  48b0: 44 4c 50 4c 53 42 70 55 41 44 48 50 4d 53 42 81  DLPLSBpUADHPMSB.
  48c0: 55 49 52 51 60 a0 07 94 60 0a 00 76 60 70 60 49  UIRQ`...`..v`p`I
  48d0: 4e 54 4c 4c 4b 55 50 5b 82 44 21 42 54 5f 5f 08  NTLLKUP[.D!BT__.
  48e0: 5f 48 49 44 0d 54 4f 53 36 32 30 35 00 14 1b 5f  _HID.TOS6205..._
  48f0: 53 54 41 00 a0 0c 93 4d 42 54 53 0a 01 70 0a 0f  STA....MBTS..p..
  4900: 60 a1 05 70 0a 00 60 a4 60 14 48 08 42 54 53 54  `..p..`.`.H.BTST
  4910: 00 70 0a 00 60 a0 4a 07 45 43 4f 4e a0 43 07 5c  .p..`.J.ECON.C.\
  4920: 2f 05 5f 53 42 5f 50 43 49 30 4c 50 43 42 45 43  /._SB_PCI0LPCBEC
  4930: 30 5f 42 54 53 54 a0 1d 5c 2f 05 5f 53 42 5f 50  0_BTST..\/._SB_P
  4940: 43 49 30 4c 50 43 42 45 43 30 5f 42 54 50 57 7d  CI0LPCBEC0_BTPW}
  4950: 60 0a 80 60 a0 1d 5c 2f 05 5f 53 42 5f 50 43 49  `..`..\/._SB_PCI
  4960: 30 4c 50 43 42 45 43 30 5f 42 54 49 54 7d 60 0a  0LPCBEC0_BTIT}`.
  4970: 40 60 a0 1d 5c 2f 05 5f 53 42 5f 50 43 49 30 4c  @`..\/._SB_PCI0L
  4980: 50 43 42 45 43 30 5f 42 54 4b 49 7d 60 0a 01 60  PCBEC0_BTKI}`..`
  4990: a4 60 14 4e 07 41 55 53 42 00 a0 46 07 45 43 4f  .`.N.AUSB..F.ECO
  49a0: 4e a0 4f 06 5c 2f 05 5f 53 42 5f 50 43 49 30 4c  N.O.\/._SB_PCI0L
  49b0: 50 43 42 45 43 30 5f 42 54 53 54 a0 45 05 5c 2f  PCBEC0_BTST.E.\/
  49c0: 05 5f 53 42 5f 50 43 49 30 4c 50 43 42 45 43 30  ._SB_PCI0LPCBEC0
  49d0: 5f 42 54 4b 49 70 0a 01 5c 2f 05 5f 53 42 5f 50  _BTKIp..\/._SB_P
  49e0: 43 49 30 4c 50 43 42 45 43 30 5f 42 54 49 54 5b  CI0LPCBEC0_BTIT[
  49f0: 22 0a 32 70 0a 01 5c 2f 05 5f 53 42 5f 50 43 49  ".2p..\/._SB_PCI
  4a00: 30 4c 50 43 42 45 43 30 5f 42 54 52 53 5b 22 0a  0LPCBEC0_BTRS[".
  4a10: 64 14 3f 44 55 53 42 00 a0 38 45 43 4f 4e a0 32  d.?DUSB..8ECON.2
  4a20: 5c 2f 05 5f 53 42 5f 50 43 49 30 4c 50 43 42 45  \/._SB_PCI0LPCBE
  4a30: 43 30 5f 42 54 53 54 70 0a 00 5c 2f 05 5f 53 42  C0_BTSTp..\/._SB
  4a40: 5f 50 43 49 30 4c 50 43 42 45 43 30 5f 42 54 49  _PCI0LPCBEC0_BTI
  4a50: 54 14 4b 05 42 54 50 4f 00 a0 43 05 45 43 4f 4e  T.K.BTPO..C.ECON
  4a60: a0 4c 04 5c 2f 05 5f 53 42 5f 50 43 49 30 4c 50  .L.\/._SB_PCI0LP
  4a70: 43 42 45 43 30 5f 42 54 53 54 a0 32 5c 2f 05 5f  CBEC0_BTST.2\/._
  4a80: 53 42 5f 50 43 49 30 4c 50 43 42 45 43 30 5f 42  SB_PCI0LPCBEC0_B
  4a90: 54 4b 49 70 0a 01 5c 2f 05 5f 53 42 5f 50 43 49  TKIp..\/._SB_PCI
  4aa0: 30 4c 50 43 42 45 43 30 5f 42 54 50 57 14 3f 42  0LPCBEC0_BTPW.?B
  4ab0: 54 50 46 00 a0 38 45 43 4f 4e a0 32 5c 2f 05 5f  TPF..8ECON.2\/._
  4ac0: 53 42 5f 50 43 49 30 4c 50 43 42 45 43 30 5f 42  SB_PCI0LPCBEC0_B
  4ad0: 54 53 54 70 0a 00 5c 2f 05 5f 53 42 5f 50 43 49  TSTp..\/._SB_PCI
  4ae0: 30 4c 50 43 42 45 43 30 5f 42 54 50 57 14 2b 47  0LPCBEC0_BTPW.+G
  4af0: 53 4d 49 01 70 68 41 50 4d 44 70 0a e3 41 50 4d  SMI.phAPMDp..APM
  4b00: 43 5b 21 0a ff 5b 21 0a ff 5b 21 0a ff 5b 21 0a  C[!..[!..[!..[!.
  4b10: ff 5b 21 0a ff 5b 21 0a ff 14 31 4d 53 4d 49 02  .[!..[!...1MSMI.
  4b20: 70 68 41 50 4d 44 70 69 4d 58 30 31 70 0a e4 41  phAPMDpiMX01p..A
  4b30: 50 4d 43 5b 21 0a ff 5b 21 0a ff 5b 21 0a ff 5b  PMC[!..[!..[!..[
  4b40: 21 0a ff 5b 21 0a ff 5b 21 0a ff 14 3b 52 42 41  !..[!..[!...;RBA
  4b50: 59 01 70 0a 01 42 41 59 50 70 0a 00 42 41 59 52  Y.p..BAYPp..BAYR
  4b60: 70 0a 00 48 44 44 52 5b 22 0a 64 70 0a 01 42 41  p..HDDR[".dp..BA
  4b70: 59 52 70 0a 01 48 44 44 52 5b 22 0a 64 70 68 42  YRp..HDDR[".dphB
  4b80: 41 59 50 5b 22 0a 64                             AYP[".d

FACS @ 0x1fffffc0
  0000: 46 41 43 53 40 00 00 00 00 00 00 00 00 00 00 00  FACS-BlbsxGdv4A7jshiNgxcy3g@public.gmane.org
  0010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  0020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  0030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................

BOOT @ 0x1ffffb90
  0000: 42 4f 4f 54 28 00 00 00 01 cc 49 4e 53 59 44 45  BOOT(.....INSYDE
  0010: 53 59 53 5f 42 4f 4f 54 00 01 00 00 5f 43 53 49  SYS_BOOT...._CSI
  0020: 01 01 01 00 37 00 00 00                          ....7...

DBGP @ 0x1ffffbc0
  0000: 44 42 47 50 34 00 00 00 01 90 49 4e 53 59 44 45  DBGP4.....INSYDE
  0010: 44 42 47 50 5f 30 30 30 00 01 00 00 5f 43 53 49  DBGP_000...._CSI
  0020: 01 01 01 00 00 00 00 00 01 08 00 00 f8 03 00 00  ................
  0030: 00 00 00 00                                      ....

SSDT @ 0x1fffab30
  0000: 53 53 44 54 9a 02 00 00 01 e9 49 4e 53 59 44 45  SSDT......INSYDE
  0010: 47 56 33 52 65 66 00 00 00 20 00 00 49 4e 54 4c  GV3Ref... ..INTL
  0020: 02 10 02 20 10 45 27 2e 5f 50 52 5f 43 50 55 30  ... .E'._PR_CPU0
  0030: 14 1a 5f 50 50 43 00 a0 07 01 a4 41 43 50 53 a1  .._PPC.....ACPS.
  0040: 0b 74 87 53 50 53 53 01 60 a4 60 08 50 44 43 30  .t.SPSS.`.`.PDC0
  0050: 0c 00 00 00 f0 14 17 5f 50 44 43 01 8a 68 0a 08  ......._PDC..h..
  0060: 43 41 50 30 70 43 41 50 30 50 44 43 30 14 40 07  CAP0pCAP0PDC0.-4b8TPpkIZ3Q@public.gmane.org
  0070: 5f 50 43 54 00 a0 38 93 7b 50 44 43 30 01 00 01  _PCT..8.{PDC0...
  0080: a4 12 2c 02 11 14 0a 11 82 0c 00 7f 00 00 00 00  ..,.............
  0090: 00 00 00 00 00 00 00 79 00 11 14 0a 11 82 0c 00  .......y........
  00a0: 7f 00 00 00 00 00 00 00 00 00 00 00 79 00 a1 2f  ............y../
  00b0: a4 12 2c 02 11 14 0a 11 82 0c 00 01 10 00 00 b2  ..,.............
  00c0: 00 00 00 00 00 00 00 79 00 11 14 0a 11 82 0c 00  .......y........
  00d0: 01 08 00 00 b3 00 00 00 00 00 00 00 79 00 14 1d  ............y...
  00e0: 5f 50 53 53 00 a0 0f 93 7b 50 44 43 30 01 00 01  _PSS....{PDC0...
  00f0: a4 4e 50 53 53 a1 06 a4 53 50 53 53 08 4e 50 53  .NPSS...SPSS.NPS
  0100: 53 12 49 0c 06 12 20 06 0c dc 05 00 00 0c b4 5f  S.I... ........_
  0110: 00 00 0c 0a 00 00 00 0c 0a 00 00 00 0c 31 0f 00  .............1..
  0120: 00 0c 31 0f 00 00 12 20 06 0c 78 05 00 00 0c e4  ..1.... ..x.....
  0130: 57 00 00 0c 0a 00 00 00 0c 0a 00 00 00 0c 2f 0e  W............./.
  0140: 00 00 0c 2f 0e 00 00 12 20 06 0c b0 04 00 00 0c  .../.... .......
  0150: 44 48 00 00 0c 0a 00 00 00 0c 0a 00 00 00 0c 29  DH.............)
  0160: 0c 00 00 0c 29 0c 00 00 12 20 06 0c e8 03 00 00  ....).... ......
  0170: 0c b0 36 00 00 0c 0a 00 00 00 0c 0a 00 00 00 0c  ..6.............
  0180: 21 0a 00 00 0c 21 0a 00 00 12 20 06 0c 20 03 00  !....!.... .. ..
  0190: 00 0c 10 27 00 00 0c 0a 00 00 00 0c 0a 00 00 00  ...'............
  01a0: 0c 1a 08 00 00 0c 1a 08 00 00 12 20 06 0c 58 02  ........... ..X.
  01b0: 00 00 0c 70 17 00 00 0c 0a 00 00 00 0c 0a 00 00  ...p............
  01c0: 00 0c 10 06 00 00 0c 10 06 00 00 08 53 50 53 53  ............SPSS
  01d0: 12 49 0c 06 12 20 06 0c dc 05 00 00 0c b4 5f 00  .I... ........_.
  01e0: 00 0c 64 00 00 00 0c 6e 00 00 00 0c 83 00 00 00  ..d....n........
  01f0: 0c 00 00 00 00 12 20 06 0c 78 05 00 00 0c e4 57  ...... ..x.....W
  0200: 00 00 0c 64 00 00 00 0c 6e 00 00 00 0c 83 01 00  ...d....n.......
  0210: 00 0c 01 00 00 00 12 20 06 0c b0 04 00 00 0c 44  ....... .......D
  0220: 48 00 00 0c 64 00 00 00 0c 6e 00 00 00 0c 83 02  H...d....n......
  0230: 00 00 0c 02 00 00 00 12 20 06 0c e8 03 00 00 0c  ........ .......
  0240: b0 36 00 00 0c 64 00 00 00 0c 6e 00 00 00 0c 83  .6...d....n.....
  0250: 03 00 00 0c 03 00 00 00 12 20 06 0c 20 03 00 00  ......... .. ...
  0260: 0c 10 27 00 00 0c 64 00 00 00 0c 6e 00 00 00 0c  ..'...d....n....
  0270: 83 04 00 00 0c 04 00 00 00 12 20 06 0c 58 02 00  .......... ..X..
  0280: 00 0c 70 17 00 00 0c 64 00 00 00 0c 6e 00 00 00  ..p....d....n...
  0290: 0c 83 05 00 00 0c 05 00 00 00                    ..........


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Description: dmesg -s40000 output
Content-Disposition: attachment; filename="dmesg.log"

Linux version 2.6.0-test10-legolas (root-jc7nuOyoleA@public.gmane.org) (gcc version 3.3.2 (Debian)) #1 Mon Nov 24 12:19:13 EST 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fffffc0 (ACPI data)
 BIOS-e820: 000000001fffffc0 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000ffb80000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 131056
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126960 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 OID_00                                    ) @ 0x000e6010
ACPI: RSDT (v001 INSYDE RSDT_000 0x00000001 _CSI 0x00010101) @ 0x1fffaaf0
ACPI: FADT (v001 INSYDE FACP_000 0x00000100 _CSI 0x00010101) @ 0x1ffffb00
ACPI: BOOT (v001 INSYDE SYS_BOOT 0x00000100 _CSI 0x00010101) @ 0x1ffffb90
ACPI: DBGP (v001 INSYDE DBGP_000 0x00000100 _CSI 0x00010101) @ 0x1ffffbc0
ACPI: SSDT (v001 INSYDE   GV3Ref 0x00002000 INTL 0x20021002) @ 0x1fffab30
ACPI: DSDT (v001 TOSINV   INT810 0x00001002 INTL 0x02002036) @ 0x00000000
Building zonelist for node : 0
Kernel command line: BOOT_IMAGE=LinuxNoX ro root=303 2
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 1495.353 MHz processor.
Console: colour dummy device 80x25
Memory: 515192k/524224k available (1912k kernel code, 8284k reserved, 842k data, 152k init, 0k highmem)
Calibrating delay loop... 2957.31 BogoMIPS
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: a7e9fbbf 00000000 00000000 00000000
CPU:     After vendor identify, caps: a7e9fbbf 00000000 00000000 00000000
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 1024K
CPU:     After all inits, caps: a7e9fbbf 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel(R) Pentium(R) M processor 1500MHz stepping 05
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1494.0900 MHz.
..... host bus clock speed is 99.0660 MHz.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xe9f24, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20031002
ACPI: IRQ 9 was Edge Triggered, setting to Level Triggerd
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
    ACPI-1120: *** Error: Method execution failed [\_SB_.BAT0._STA] (Node dff61fe0), AE_NOT_EXIST
    ACPI-1120: *** Error: Method execution failed [\_SB_.BAT1._STA] (Node dff61ea0), AE_NOT_EXIST
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI2._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 5 7 *10 11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 6)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 5 7 10 *11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 7 10 *11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 10 *11 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 5 7 10 11)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 10 11 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 5 7 10 11)
ACPI: Embedded Controller [EC0] (gpe 16)
ACPI: Power Resource [PUT2] (on)
ACPI: Power Resource [PFA1] (off)
ACPI: Power Resource [PFA0] (off)
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 11
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
vesafb: framebuffer at 0xa8000000, mapped to 0xe080d000, size 16384k
vesafb: mode is 1024x768x16, linelength=2048, pages=20
vesafb: protected mode interface info at c000:574f
vesafb: scrolling: redraw
vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
fb0: VESA VGA frame buffer device
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x80
speedstep-centrino: found "Intel(R) Pentium(R) M processor 1500MHz": max frequency: 1500000kHz
speedstep-smi: signature:0x47534943, command:0x008200b2, event:0x00ff00b3, perf_level:0x07d00001.
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
ibmphpd: IBM Hot Plug PCI Controller Driver version: 0.6
acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.4
acpiphp_glue: can't get bus number, assuming 0
ACPI: AC Adapter [AC] (on-line)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Fan [FAN0] (off)
ACPI: Fan [FAN1] (off)
Console: switching to colour frame buffer device 128x48
pty: 256 Unix98 ptys configured
toshiba: not a supported Toshiba laptop
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Intel(R) PRO/100 Network Driver - version 2.3.30-k1
Copyright (c) 2003 Intel Corporation

e100: selftest OK.
e100: eth0: Intel(R) PRO/100 Network Connection
  Hardware receive checksums enabled

orinoco.c 0.13e (David Gibson <hermes-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org> and others)
orinoco_cs.c 0.13e (David Gibson <hermes-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org> and others)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
hda: IC25N040ATCS05-0, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: max request size: 128KiB
hda: 78140160 sectors (40007 MB) w/7898KiB Cache, CHS=65535/16/63
 hda: hda1 hda2 hda3
Console: switching to colour frame buffer device 128x48
Yenta: CardBus bridge found at 0000:02:09.0 [1179:ff10]
Yenta: ISA IRQ list 0000, PCI irq10
Socket status: 30000006
Yenta: CardBus bridge found at 0000:02:09.1 [1179:ff10]
Yenta: ISA IRQ list 0000, PCI irq11
Socket status: 30000059
ehci_hcd 0000:00:1d.7: EHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: irq 5, pci mem e1814000
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2003-Jun-13
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
ohci_hcd: 2003 Oct 13 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
uhci_hcd 0000:00:1d.0: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: irq 10, io base 00001200
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.1: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: irq 11, io base 00001600
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.2: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: irq 11, io base 00001700
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
drivers/usb/core/usb.c: registered new driver audio
drivers/usb/class/audio.c: v1.0.0:USB Audio Class driver
Initializing USB Mass Storage driver...
drivers/usb/core/usb.c: registered new driver usb-storage
USB Mass Storage support registered.
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
i8042.c: Detected active multiplexing controller, rev 1.1.
input: PS/2 Generic Mouse on isa0060/serio1
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
input: AT Translated Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
Intel 810 + AC97 Audio, version 0.24, 12:18:14 Nov 24 2003
PCI: Setting latency timer of device 0000:00:1f.5 to 64
i810: Intel ICH4 found at IO 0xe100 and 0xe000, MEM 0xf0000000 and 0xf0000200, IRQ 10
i810: Intel ICH4 mmio at 0xe1816000 and 0xe1818200
i810_audio: Primary codec has ID 0
i810_audio: Audio Controller supports 6 channels.
i810_audio: Defaulting to base 2 channel mode.
i810_audio: Resetting connection 0
i810_audio: Connection 0 with codec id 0
ac97_codec: AC97 Audio codec, id: ADS99 (Unknown)
i810_audio: AC'97 codec 0 Unable to map surround DAC's (or DAC's not present), total channels = 2
i810_audio: setting clocking to 48546
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 8
NET: Registered protocol family 20
hub 2-0:1.0: new USB device on port 1, assigned address 2
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 152k freed
input: USB HID v1.10 Mouse [Logitech Trackball] on usb-0000:00:1d.0-1
Adding 529192k swap on /dev/hda2.  Priority:-1 extents:1
EXT3 FS on hda3, internal journal
cs: warning: no high memory space available!
cs: unable to map card memory!
cs: unable to map card memory!
parport0: PC-style at 0x378 (0x778) [PCSPP(,...)]
parport0: irq 7 detected
lp0: using parport0 (polling).
cs: unable to map card memory!
cs: unable to map card memory!
cs: unable to map card memory!
cs: unable to map card memory!
cs: unable to map card memory!
cs: unable to map card memory!
cs: unable to map card memory!
cs: unable to map card memory!
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x100-0x107 0x170-0x177 0x300-0x307 0x310-0x31f 0x370-0x37f 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
eth1: Station identity 001f:0006:0001:0003
eth1: Looks like an Intersil firmware version 1.3.6
eth1: Ad-hoc demo mode supported
eth1: IEEE standard IBSS ad-hoc mode supported
eth1: WEP supported, 104-bit key
eth1: MAC address 00:09:5B:34:F5:27
eth1: Station name "Prism  I"
eth1: ready
eth1: index 0x01: Vcc 5.0, irq 11, io 0x0180-0x01bf
eth1: New link status: Connected (0001)

--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Description: dmidecode output
Content-Disposition: attachment; filename="dmidecode.log"

# dmidecode 2.3
SMBIOS 2.3 present.
114 structures occupying 1523 bytes.
Table at 0x000EA970.
Handle 0x0000
	DMI type 0, 20 bytes.
	BIOS Information
		Vendor: TOSHIBA
		Version: Version 1.60
		Release Date: 04/28/2003
		Address: 0xEA800
		Runtime Size: 86 kB
		ROM Size: 512 kB
		Characteristics:
			ISA is supported
			PCI is supported
			PC Card (PCMCIA) is supported
			PNP is supported
			APM is supported
			BIOS is upgradeable
			BIOS shadowing is allowed
			Boot from CD is supported
			BIOS ROM is socketed
			EDD is supported
			Japanese floppy for NEC 9800 1.2 MB is supported (int 13h)
			3.5"/720 KB floppy services are supported (int 13h)
			3.5"/2.88 MB floppy services are supported (int 13h)
			Print screen service is supported (int 5h)
			8042 keyboard services are supported (int 9h)
			Serial services are supported (int 14h)
			Printer services are supported (int 17h)
			CGA/mono video services are supported (int 10h)
			ACPI is supported
			USB legacy is supported
			AGP is supported
			ATAPI Zip drive boot is supported
			Smart battery is supported
			Function key-initiated network boot is supported
Handle 0x0001
	DMI type 1, 25 bytes.
	System Information
		Manufacturer: TOSHIBA
		Product Name: TECRA S1
		Version: PT831C-11UDL
		Serial Number: 53014472V
		UUID: 62094780-7ABA-11D7-86CF-00A0D1D25163
		Wake-up Type: Power Switch
Handle 0x0002
	DMI type 2, 8 bytes.
	Base Board Information
		Manufacturer: TOSHIBA
		Product Name: Portable PC
		Version: Version A0
		Serial Number: 0000000000
Handle 0x0003
	DMI type 3, 17 bytes.
	Chassis Information
		Manufacturer: TOSHIBA
		Type: Portable
		Lock: Not Present
		Version: Version 1.0
		Serial Number: 00000000
		Asset Tag: 0000000000
		Boot-up State: Safe
		Power Supply State: Safe
		Thermal State: Safe
		Security Status: None
		OEM Information: 0x00000000
Handle 0x0004
	DMI type 4, 32 bytes.
	Processor Information
		Socket Designation: mFCPGA
		Type: Central Processor
		Family: Pentium M
		Manufacturer: Intel Corporation
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
		Version: <BAD INDEX>
		Voltage: 3.3 V
		External Clock: 133 MHz
		Max Speed: 1500 MHz
		Current Speed: 1500 MHz
		Status: Unpopulated
		Upgrade: <OUT OF SPEC>
		L1 Cache Handle: 0x0005
		L2 Cache Handle: 0x0006
		L3 Cache Handle: 0x0000
Handle 0x0005
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
		Installed SRAM Type: Burst Pipeline Burst
		Speed: Unknown
		Error Correction Type: None
		System Type: Unknown
		Associativity: Unknown
Handle 0x0006
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
		Installed SRAM Type: Burst Pipeline Burst
		Speed: Unknown
		Error Correction Type: None
		System Type: Unknown
		Associativity: Unknown
Handle 0x0007
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: Serial Port
		Internal Connector Type: None
		External Reference Designator: CN1003
		External Connector Type: DB-9 male
		Port Type: Serial Port 16550A Compatible
Handle 0x0008
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: Parallel Port
		Internal Connector Type: None
		External Reference Designator: CN1001
		External Connector Type: DB-25 male
		Port Type: Parallel Port ECP/EPP
Handle 0x0009
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: Kbd Connector
		Internal Connector Type: None
		External Reference Designator: CN5
		External Connector Type: PS/2
		Port Type: Keyboard Port
Handle 0x000A
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: Mouse Conn.
		Internal Connector Type: None
		External Reference Designator: CN8
		External Connector Type: PS/2
		Port Type: Mouse Port
Handle 0x000B
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: USB Conn.
		Internal Connector Type: None
		External Reference Designator: CN5
		External Connector Type: Other
		Port Type: USB
Handle 0x000C
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: Dock Conn.
		Internal Connector Type: None
		External Reference Designator: CN1004
		External Connector Type: Other
		Port Type: Other
Handle 0x000D
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: VGA Conn.
		Internal Connector Type: None
		External Reference Designator: CN1000
		External Connector Type: Other
		Port Type: Other
Handle 0x000E
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: DC Input
		Internal Connector Type: None
		External Reference Designator: JACK1000
		External Connector Type: Other
		Port Type: Other
Handle 0x000F
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: IrDA Port
		Internal Connector Type: None
		External Reference Designator: D1014
		External Connector Type: Infrared
		Port Type: Other
Handle 0x0010
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: CardBus Conn.
		Internal Connector Type: None
		External Reference Designator: CN1011
		External Connector Type: Other
		Port Type: Cardbus
Handle 0x0011
	DMI type 9, 13 bytes.
	System Slot Information
		Designation: PCI Slot
		Type: 32-bit PCI
		Current Usage: Available
		Length: Long
		ID: 4
		Characteristics: Unknown
Handle 0x0012
	DMI type 10, 16 bytes.
	On Board Device Information
		Type: Other
		Status: Enabled
		Description: ECP Port
	On Board Device Information
		Type: Other
		Status: Enabled
		Description: 16550 UART
	On Board Device Information
		Type: Other
		Status: Enabled
		Description: IrDA Port
	On Board Device Information
		Type: Other
		Status: Enabled
		Description: CardBus Bridge
	On Board Device Information
		Type: Other
		Status: Enabled
		Description: IDE Controller
	On Board Device Information
		Type: Video
		Status: Enabled
		Description: VGA
Handle 0x0058
	DMI type 11, 5 bytes.
	OEM Strings
		String 1: PT831C-11UDL,S3A1256D003
Handle 0x0059
	DMI type 12, 5 bytes.
	System Configuration Options
		Option 1: TOSHIBA
Handle 0x005A
	DMI type 13, 22 bytes.
	BIOS Language Information
		Installable Languages: 1
			en|US|iso8859-1
		Currently Installed Language: en|US|iso8859-1
Handle 0x005B
	DMI type 16, 15 bytes.
	Physical Memory Array
		Location: System Board Or Motherboard
		Use: System Memory
		Error Correction Type: None
		Maximum Capacity: 2 GB
		Error Information Handle: 0x0064
		Number Of Devices: 2
Handle 0x005C
	DMI type 16, 15 bytes.
	Physical Memory Array
		Location: System Board Or Motherboard
		Use: Video Memory
		Error Correction Type: None
		Maximum Capacity: 32 MB
		Error Information Handle: Not Provided
		Number Of Devices: 1
Handle 0x005D
	DMI type 16, 15 bytes.
	Physical Memory Array
		Location: System Board Or Motherboard
		Use: Flash Memory
		Error Correction Type: None
		Maximum Capacity: 512 kB
		Error Information Handle: Not Provided
		Number Of Devices: 1
Handle 0x005E
	DMI type 16, 15 bytes.
	Physical Memory Array
		Location: System Board Or Motherboard
		Use: Cache Memory
		Error Correction Type: None
		Maximum Capacity: 1 MB
		Error Information Handle: Not Provided
		Number Of Devices: 1
Handle 0x005F
	DMI type 17, 23 bytes.
	Memory Device
		Array Handle: 0x005B
		Error Information Handle: Not Provided
		Total Width: 64 bits
		Data Width: 64 bits
		Size: 256 MB
		Form Factor: SODIMM
		Set: Unknown
		Locator: DRAM Slot 0
		Bank Locator: Banks 0/1
		Type: DDR
		Type Detail: Synchronous
		Speed: 1 MHz (1000.0 ns)
Handle 0x0060
	DMI type 17, 23 bytes.
	Memory Device
		Array Handle: 0x005B
		Error Information Handle: Not Provided
		Total Width: 64 bits
		Data Width: 64 bits
		Size: 256 MB
		Form Factor: SODIMM
		Set: Unknown
		Locator: DRAM Slot 1
		Bank Locator: Banks 2/3
		Type: DDR
		Type Detail: Synchronous
		Speed: 1 MHz (1000.0 ns)
Handle 0x0061
	DMI type 17, 23 bytes.
	Memory Device
		Array Handle: 0x005C
		Error Information Handle: Not Provided
		Total Width: 64 bits
		Data Width: 64 bits
		Size: 32 MB
		Form Factor: TSOP
		Set: Unknown
		Locator: Video Memory
		Bank Locator: U7/U8
		Type: VRAM
		Type Detail: Synchronous
		Speed: 1 MHz (1000.0 ns)
Handle 0x0062
	DMI type 17, 23 bytes.
	Memory Device
		Array Handle: 0x005E
		Error Information Handle: Not Provided
		Total Width: 64 bits
		Data Width: 64 bits
		Size: 1 MB
		Form Factor: TSOP
		Set: Unknown
		Locator: Cache SRAM
		Bank Locator: CN1009
		Type: SRAM
		Type Detail: Unknown
		Speed: 1 MHz (1000.0 ns)
Handle 0x0063
	DMI type 17, 23 bytes.
	Memory Device
		Array Handle: 0x005D
		Error Information Handle: Not Provided
		Total Width: 16 bits
		Data Width: 16 bits
		Size: 4 MB
		Form Factor: Chip
		Set: Unknown
		Locator: Flash BIOS CN11
		Bank Locator: CN11
		Type: EEPROM
		Type Detail: Unknown
		Speed: 1 MHz (1000.0 ns)
Handle 0x0064
	DMI type 18, 23 bytes.
	32-bit Memory Error Information
		Type: Unknown
		Granularity: Memory Partition Level
		Operation: Unknown
		Vendor Syndrome: Unknown
		Memory Array Address: Unknown
		Device Address: Unknown
		Resolution: Unknown
Handle 0x0065
	DMI type 19, 15 bytes.
	Memory Array Mapped Address
		Starting Address: 0x00000000000
		Ending Address: 0x0000000BFFF
		Range Size: 48 kB
		Physical Array Handle: 0x005B
		Partition Width: 0
Handle 0x0066
	DMI type 21, 7 bytes.
	Built-in Pointing Device
		Type: Mouse
		Interface: PS/2
		Buttons: 2
Handle 0x0067
	DMI type 22, 26 bytes.
	Portable Battery
		Location: Smart Battery Conn CN1014
		Manufacturer: Duracell
		Manufacture Date: 01/06/97
		Serial Number: 0042
		Name: DR36
		Design Capacity: Unknown
		Design Voltage: 12 mV
		SBDS Version: V1.0
		Maximum Error: 6%
		SBDS Chemistry: Not Specified
		OEM-specific Information: 0x00000000
Handle 0x0068
	DMI type 23, 13 bytes.
	System Reset
		Status: Disabled
		Watchdog Timer: No
		Boot Option: <OUT OF SPEC>
		Boot Option On Limit: <OUT OF SPEC>
		Reset Count: Unknown
		Reset Limit: Unknown
		Timer Interval: Unknown
		Timeout: Unknown
Handle 0x0069
	DMI type 24, 5 bytes.
	Hardware Security
		Power-On Password Status: Disabled
		Keyboard Password Status: Not Implemented
		Administrator Password Status: Disabled
		Front Panel Reset Status: Not Implemented
Handle 0x006A
	DMI type 25, 9 bytes.
	System Power Controls
		Next Scheduled Power-on: *-* 00:00:00
Handle 0x006B
	DMI type 26, 20 bytes.
	Voltage Probe
		Description: Voltage Probe Description
		Location: Unknown
		Status: Unknown
		Maximum Value: Unknown
		Minimum Value: Unknown
		Resolution: Unknown
		Tolerance: Unknown
		Accuracy: Unknown
		OEM-specific Information: 0x00000000
Handle 0x006C
	DMI type 27, 12 bytes.
	Cooling Device
		Temperature Probe Handle: 0x006D
		Type: Unknown
		Status: Unknown
		OEM-specific Information: 0x00000000
Handle 0x006D
	DMI type 28, 20 bytes.
	Temperature Probe
		Description: Temperature Probe Description
		Location: Unknown
		Status: Unknown
		Maximum Value: Unknown
		Minimum Value Unknown
		Resolution: Unknown
		Tolerance: Unknown
		Accuracy: Unknown
		OEM-specific Information: 0x00000000
Handle 0x006E
	DMI type 29, 20 bytes.
	Electrical Current Probe
		Description: Electrical Probe Description
		Location: Unknown
		Status: Unknown
		Maximum Value: Unknown
		Minimum Value: Unknown
		Resolution: Unknown
		Tolerance: Unknown
		Accuracy: Unknown
		OEM-specific Information: 0x00000000
Handle 0x006F
	DMI type 30, 6 bytes.
	Out-of-band Remote Access
		Manufacturer Name: Manufacturer Name
		Inbound Connection: Disabled
		Outbound Connection: Disabled
Handle 0x0070
	DMI type 32, 11 bytes.
	System Boot Information
		Status: No errors detected
Handle 0x0071
	DMI type 127, 4 bytes.
	<TRUNCATED>
Wrong DMI structures count: 114 announced, only 45 decoded.
Wrong DMI structures length: 1523 bytes announced, structures occupy 1525 bytes.

--jI8keyz6grp/JLjh--


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
