From: Ryan Underwood <nemesis-lists-RBwgCYbvQ+vk1uMJSBkQmQ@public.gmane.org>
Subject: Re: Shuttle HOT-591P fails ACPI on 2.4.23
Date: Wed, 10 Dec 2003 04:41:57 -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031210104157.GC31759@dbz.icequake.net>
References: <3ACA40606221794F80A5670F0AF15F8401720C14@PDSMSX403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AjmyJqqohANyBN/e"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8401720C14-SRlDPOYGfgogGBtAFL8yw7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--AjmyJqqohANyBN/e
Content-Type: multipart/mixed; boundary="x4pBfXISqBoDm8sr"
Content-Disposition: inline


--x4pBfXISqBoDm8sr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi,

attached acpidump output.  btw, acpidump makefile needs to be fixed to
-I/usr/src/linux/include, otherwise it takes the userspace headers and
fails to build.  also, I tried running the output through acpidisasm to
understand it, but acpidisasm produced no output:
# ../../acpidump/acpidmp | ./acpidisasm
#

This machine has never ran windows so I don't know whether it would work
or not.  If it is critical to understanding why it doesn't work, I can
try installing it on a different disk.

On Wed, Dec 10, 2003 at 10:40:20AM +0800, Yu, Luming wrote:
> It's too bad that your box faile to transition to ACPI mode. Did you boot=
 MS windows successfully on your box?
> BTW, I need full ouptput of acpidmp. --Luming
>=20
>=20
> -----Original Message-----
> From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-admin@lis=
ts.sourceforge.net]On Behalf Of Ryan Underwood
> Sent: 2003?12?9? 12:51
> To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: Re: [ACPI] Shuttle HOT-591P fails ACPI on 2.4.23
>=20
>=20
>=20
> Hi,
>=20
> This is the first time I have booted an ACPI-enabled kernel on this
> machine.  So I wasn't expecting too much. ;)
>=20
> Shuttle's spec page for the board: http://de.shuttle.com/591p.htm
> does claim to support ACPI.
>=20
> I attached the files you asked for.  acpi_pic_sci=3Dedge didn't seem to
> make a difference (paused in same place, and same error)
>=20
>=20
> On Mon, Dec 08, 2003 at 10:14:20AM -0500, Len Brown wrote:
> > Has ACPI worked better on this box using any other releases?
> >=20
> > Does it work any better if you boot with "acpi_pic_sci=3Dedge"?
> >=20
> > I'd be interested in seing the complete dmesg -s40000 output
> > and the resulting /proc/interrupts.
> >=20
> > thanks,
> > -Len
> >=20
> > On Mon, 2003-12-08 at 07:24, Ryan Underwood wrote:
> > > Hello,
> > >=20
> > > Shuttle HOT-591P with latest BIOS (591P025) and Cyrix CPU, kernel
> > > 2.4.23.  It is a Baby AT board with AT and ATX power.
> > >=20
> > > Vendor: Award Software International, Inc.
> > > Version: 4.51 PG
> > > Release Date: 03/27/01
> > >=20
> > > Manufacturer: Shuttle Inc.
> > > Product Name: VIA APOLLO MVP3 (HOT-597)
> > > Version: 2A5LEH2B
> > > (It is actually a 591P, regardless of the DMI string)
> > >=20
> > > It seems the ACPI tables are found, but the system does not properly
> > > handle the SCI interrupt:
> > >=20
> > > ACPI: Subsystem revision 20031002
> > > PCI: PCI BIOS revision 2.10 entry at 0xfb410, last bus=3D3D1
> > > PCI: Using configuration type 1
> > >  tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully a=
cquired
> > > Parsing all Control Methods:.........................................=
=2E.............
> > > Table [DSDT](id F004) - 227 Objects with 26 Devices 55 Methods 17 Reg=
ions
> > > ACPI Namespace successfully loaded at root c02dba3c
> > > ACPI: IRQ9 SCI: Level Trigger.  <---- PAUSES HERE
> > > evxfevnt-0089: *** Error: Could not transition to ACPI mode.
> > >  utxface-0170 [03] acpi_enable_subsystem : acpi_enable failed.
> > > ACPI: Unable to start the ACPI Interpreter
> > > evxfevnt-0127 [06] acpi_disable          : System is already in legac=
y (non-ACPI) mode
> > >  utalloc-0986 [05] ut_dump_allocations   : No outstanding allocations.
> > > PCI: Probing PCI hardware
> > > PCI: ACPI tables contain no PCI IRQ routing entries
> > > ...
> > >=20
> > > At the "ACPI: IRQ9 SCI:" part, it pauses for a few seconds before
> > > continuing.
> > >=20
> > > A similar system with a Tyan ATX board and K6/III 400 works great.
> > >=20
> > > any ideas?
> >=20
> >=20
> >=20
> > -------------------------------------------------------
> > This SF.net email is sponsored by: SF.net Giveback Program.
> > Does SourceForge.net help you be more productive?  Does it
> > help you create better code?  SHARE THE LOVE, and help us help
> > YOU!  Click Here: http://sourceforge.net/donate/
> > _______________________________________________
> > Acpi-devel mailing list
> > Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > https://lists.sourceforge.net/lists/listinfo/acpi-devel
> >=20
>=20
> --=20
> Ryan Underwood, <nemesis-RBwgCYbvQ+vk1uMJSBkQmQ@public.gmane.org>
>=20
>=20
> -------------------------------------------------------
> This SF.net email is sponsored by: SF.net Giveback Program.
> Does SourceForge.net help you be more productive?  Does it
> help you create better code?  SHARE THE LOVE, and help us help
> YOU!  Click Here: http://sourceforge.net/donate/
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
>=20

--=20
Ryan Underwood, <nemesis-RBwgCYbvQ+vk1uMJSBkQmQ@public.gmane.org>

--x4pBfXISqBoDm8sr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="hot591p.txt"
Content-Transfer-Encoding: quoted-printable

--------------------------------------------------------------
Table: =1B[20GRSDP - (Root System Description Pointer)
Signature 1:=1B[40GRSD=20
Signature 2:=1B[40GPTR=20
Checksum:=1B[40G0xf6
OEMID:=1B[40GVIAVP3
Revision:=1B[40G0x00
RSDT Address:=1B[40G0x03ff3000
--------------------------------------------------------------
Table: =1B[20GRSDT - (Root System Description)
Signature:=1B[40GRSDT
Length:=1B[40G0x00000028
Revision:=1B[40G0x01
Checksum:=1B[40G0x25
OEMID:=1B[40GVIAVP3
OEM Table ID:=1B[40GAWRDACPI
OEM Revision:=1B[40G1.0B
Creator ID:=1B[40GAWRD
Table Pointer:=1B[40G0x03ff3040
--------------------------------------------------------------
Table: =1B[20GDSDT - (Differentied System Description)
Signature:=1B[40GDSDT
Length:=1B[40G0x00001c84
Revision:=1B[40G0x01
Checksum:=1B[40G0xd1
OEMID:=1B[40GVIAVP3
OEM Table ID:=1B[40GAWRDACPI
OEM Revision:=1B[40G
Creator ID:=1B[40GMSFT
=09
0000:  10 19 5c 5f 50 52 5f 5b   83 11 5c 2e 5f 50 52 5f 	..\_PR_[..\._PR_
0010:  43 50 55 30 01 10 50 00   00 06 08 5c 5f 53 30 5f 	CPU0..P....\_S0_
0020:  12 0a 04 0a 05 0a 05 0a   05 0a 05 08 5c 5f 53 31 	............\_S1
0030:  5f 12 0a 04 0a 02 0a 02   0a 02 0a 02 08 5c 5f 53 	_............\_S
0040:  35 5f 12 06 04 00 00 00   00 5b 80 5c 44 45 42 47 	5_.......[.\DEBG
0050:  01 0a 80 0a 01 5b 81 0c   5c 44 45 42 47 01 44 42 	.....[..\DEBG.DB
0060:  47 31 08 5b 80 45 58 54   4d 00 0c 30 f8 0f 00 0a 	G1.[.EXTM..0....
0070:  10 5b 81 29 45 58 54 4d   02 52 4f 4d 31 10 52 4d 	.[.)EXTM.ROM1.RM
0080:  53 31 10 52 4f 4d 32 10   52 4d 53 32 10 52 4f 4d 	S1.ROM2.RMS2.ROM
0090:  33 10 52 4d 53 33 10 41   4d 45 4d 20 5b 80 56 47 	3.RMS3.AMEM [.VG
00a0:  41 4d 00 0c 02 00 0c 00   0a 01 5b 81 0b 56 47 41 	AM........[..VGA
00b0:  4d 01 56 47 41 31 08 5b   80 45 4c 43 52 01 0b d0 	M.VGA1.[.ELCR...
00c0:  04 0a 02 5b 81 10 45 4c   43 52 01 45 4c 43 31 08 	...[..ELCR.ELC1.
00d0:  45 4c 43 32 08 5b 80 5c   53 54 55 53 01 0b 30 50 	ELC2.[.\STUS..0P
00e0:  0a 01 5b 81 0c 5c 53 54   55 53 01 47 5f 53 54 08 	..[..\STUS.G_ST.
00f0:  5b 80 5c 57 49 52 51 01   0b 2a 50 0a 01 5b 81 0c 	[.\WIRQ..*P..[..
0100:  5c 57 49 52 51 01 49 52   51 52 08 5b 80 47 50 45 	\WIRQ.IRQR.[.GPE
0110:  53 01 0b 20 50 0a 01 5b   81 2e 47 50 45 53 01 47 	S.. P..[..GPES.G
0120:  53 30 30 01 47 53 30 31   01 47 53 30 32 01 47 53 	S00.GS01.GS02.GS
0130:  30 33 01 47 53 30 34 01   47 53 30 35 01 47 53 30 	03.GS04.GS05.GS0
0140:  36 01 47 53 30 37 01 5b   80 45 58 54 53 01 0b 44 	6.GS07.[.EXTS..D
0150:  50 0a 01 5b 81 2e 45 58   54 53 01 45 58 30 30 01 	P..[..EXTS.EX00.
0160:  45 58 30 31 01 45 58 30   32 01 45 58 30 33 01 45 	EX01.EX02.EX03.E
0170:  58 30 34 01 45 58 30 35   01 45 58 30 36 01 45 58 	X04.EX05.EX06.EX
0180:  30 37 01 08 53 59 53 46   0a 00 5b 80 47 50 49 4f 	07..SYSF..[.GPIO
0190:  01 0b 42 50 0a 01 5b 81   2e 47 50 49 4f 01 47 49 	..BP..[..GPIO.GI
01a0:  4f 30 01 47 49 4f 31 01   47 49 4f 32 01 47 49 4f 	O0.GIO1.GIO2.GIO
01b0:  33 01 47 49 4f 34 01 47   49 4f 35 01 47 49 4f 36 	3.GIO4.GIO5.GIO6
01c0:  01 47 49 4f 37 01 08 4f   53 46 4c 0a 01 14 41 05 	.GIO7..OSFL...A.
01d0:  53 54 52 43 02 a0 0a 92   93 87 68 87 69 a4 0a 00 	STRC......h.i...
01e0:  72 87 68 0a 01 60 08 42   55 46 30 11 02 60 08 42 	r.h..`.BUF0..`.B
01f0:  55 46 31 11 02 60 70 68   42 55 46 30 70 69 42 55 	UF1..`phBUF0piBU
0200:  46 31 a2 1a 60 76 60 a0   15 92 93 83 88 42 55 46 	F1..`v`......BUF
0210:  30 60 00 83 88 42 55 46   31 60 00 a4 00 a4 01 5b 	0`...BUF1`.....[
0220:  80 52 54 43 4d 01 0a 70   0a 02 5b 81 10 52 54 43 	.RTCM..p..[..RTC
0230:  4d 01 43 4d 49 4e 08 43   4d 44 41 08 5b 86 12 43 	M.CMIN.CMDA.[..C
0240:  4d 49 4e 43 4d 44 41 01   00 48 07 53 48 55 54 08 	MINCMDA..H.SHUT.
0250:  5b 80 5c 47 52 41 4d 00   0b 00 04 0b 00 01 5b 81 	[.\GRAM.......[.
0260:  17 5c 47 52 41 4d 01 00   40 08 46 4c 47 30 08 00 	.\GRAM..-I5S5B7ENPww@public.gmane.org
0270:  48 54 53 46 4c 47 08 5b   80 49 4e 46 4f 00 0c 40 	HTSFLG.[.INFO..@
0280:  f8 0f 00 0a 01 5b 81 24   49 4e 46 4f 01 4b 42 44 	.....[.$INFO.KBD
0290:  49 01 52 54 43 57 01 50   53 32 46 01 49 52 46 4c 	I.RTCW.PS2F.IRFL
02a0:  02 44 49 53 45 01 53 53   48 55 01 5b 80 42 45 45 	.DISE.SSHU.[.BEE
02b0:  50 01 0a 61 0a 01 5b 81   0b 42 45 45 50 01 53 31 	P..a..[..BEEP.S1
02c0:  42 5f 08 5b 80 43 4f 4e   54 01 0a 40 0a 04 5b 81 	B_.[.CONT..-rVxdn2TrCWA@public.gmane.org[.
02d0:  1a 43 4f 4e 54 01 43 4e   54 30 08 43 4e 54 31 08 	.CONT.CNT0.CNT1.
02e0:  43 4e 54 32 08 43 54 52   4c 08 14 43 06 53 50 4b 	CNT2.CTRL..C.SPK
02f0:  52 01 70 53 31 42 5f 60   70 0a b6 43 54 52 4c 70 	R.pS1B_`p..CTRLp
0300:  0a 55 43 4e 54 32 70 0a   03 43 4e 54 32 70 68 62 	.UCNT2p..CNT2phb
0310:  a2 37 94 62 0a 00 7d 53   31 42 5f 0a 03 53 31 42 	.7.b..}S1B_..S1B
0320:  5f 70 0b ff 5f 63 a2 07   94 63 0a 00 76 63 7b 53 	_p.._c...c..vc{S
0330:  31 42 5f 0a fc 53 31 42   5f 70 0b ff 0e 63 a2 07 	1B_..S1B_p...c..
0340:  94 63 0a 00 76 63 76 62   70 60 53 31 42 5f 14 4a 	.c..vcvbp`S1B_.J
0350:  04 5c 5f 50 54 53 01 7d   68 0a f0 60 70 60 44 42 	.\_PTS.}h..`p`DB
0360:  47 31 a0 06 92 93 68 0a   05 a0 29 93 68 0a 01 70 	G1....h...).h..p
0370:  47 5f 53 54 61 a2 12 92   93 61 0a 00 70 61 47 5f 	G_STa....a..paG_
0380:  53 54 70 47 5f 53 54 61   7d 49 52 51 52 0a 80 49 	STpG_STa}IRQR..I
0390:  52 51 52 a0 05 93 68 0a   05 14 24 5c 5f 57 41 4b 	RQR...h...$\_WAK
03a0:  01 70 0a ff 44 42 47 31   a0 15 93 52 54 43 57 0a 	.p..DBG1...RTCW.
03b0:  00 86 5c 2e 5f 53 42 5f   50 57 52 42 0a 02 10 26 	..\._SB_PWRB...&
03c0:  5c 5f 53 49 5f 14 09 5f   4d 53 47 01 70 60 60 14 	\_SI_.._MSG.p``.
03d0:  15 5f 53 53 54 01 a0 05   93 68 0a 03 a0 05 93 68 	._SST....h.....h
03e0:  0a 01 70 60 60 10 06 5c   5f 47 50 45 10 83 87 01 	..p``..\_GPE....
03f0:  5c 5f 53 42 5f 5b 82 19   50 57 52 42 08 5f 48 49 	\_SB_[..PWRB._HI
0400:  44 0c 41 d0 0c 0c 14 09   5f 53 54 41 00 a4 0a 0b 	D.A....._STA....
0410:  5b 82 19 53 4c 50 42 08   5f 48 49 44 0c 41 d0 0c 	[..SLPB._HID.A..
0420:  0e 14 09 5f 53 54 41 00   a4 0a 0b 5b 82 42 1b 4d 	..._STA....[.B.M
0430:  45 4d 5f 08 5f 48 49 44   0c 41 d0 0c 01 14 41 1a 	EM_._HID.A....A.
0440:  5f 43 52 53 00 08 42 55   46 30 11 46 06 0a 62 86 	_CRS..BUF0.F..b.
0450:  09 00 01 00 00 0f 00 00   40 00 00 86 09 00 01 00 	........-3wQm9ZMZ9co@public.gmane.org
0460:  40 0f 00 00 40 00 00 86   09 00 01 00 80 0f 00 00 	@...-BlbsxGdv4A7jshiNgxcy3g@public.gmane.org
0470:  40 00 00 86 09 00 01 00   c0 0f 00 00 40 00 00 86 	@...........-47IYjYMXMt4@public.gmane.org
0480:  09 00 01 00 00 00 00 00   00 01 00 86 09 00 01 00 	................
0490:  00 ff ff 00 00 01 00 86   09 00 01 00 00 00 00 00 	................
04a0:  00 0a 00 86 09 00 01 00   00 10 00 00 00 00 00 79 	...............y
04b0:  00 8a 42 55 46 30 0a 34   41 43 4d 4d 8a 42 55 46 	..BUF0.4ACMM.BUF
04c0:  30 0a 04 52 4d 41 31 8a   42 55 46 30 0a 08 52 53 	0..RMA1.BUF0..RS
04d0:  53 31 8a 42 55 46 30 0a   10 52 4d 41 32 8a 42 55 	S1.BUF0..RMA2.BU
04e0:  46 30 0a 14 52 53 53 32   8a 42 55 46 30 0a 1c 52 	F0..RSS2.BUF0..R
04f0:  4d 41 33 8a 42 55 46 30   0a 20 52 53 53 33 8a 42 	MA3.BUF0. RSS3.B
0500:  55 46 30 0a 28 52 4d 41   34 8a 42 55 46 30 0a 2c 	UF0.(RMA4.BUF0.,
0510:  52 53 53 34 8a 42 55 46   30 0a 5c 45 58 54 4d 74 	RSS4.BUF0.\EXTMt
0520:  41 4d 45 4d 0c 00 00 10   00 45 58 54 4d a0 35 92 	AMEM.....EXTM.5.
0530:  93 52 4f 4d 31 00 70 52   4d 41 31 52 4d 41 32 79 	.ROM1.pRMA1RMA2y
0540:  52 4f 4d 31 0a 08 60 70   60 52 4d 41 31 79 52 4d 	ROM1..`p`RMA1yRM
0550:  53 31 0a 08 60 70 60 52   53 53 31 70 0b 00 80 52 	S1..`p`RSS1p...R
0560:  53 53 32 a0 35 92 93 52   4f 4d 32 00 70 52 4d 41 	SS2.5..ROM2.pRMA
0570:  32 52 4d 41 33 79 52 4f   4d 32 0a 08 60 70 60 52 	2RMA3yROM2..`p`R
0580:  4d 41 32 79 52 4d 53 32   0a 08 60 70 60 52 53 53 	MA2yRMS2..`p`RSS
0590:  32 70 0b 00 c0 52 53 53   33 a0 37 92 93 52 4f 4d 	2p...RSS3.7..ROM
05a0:  33 00 70 52 4d 41 33 52   4d 41 34 79 52 4f 4d 33 	3.pRMA3RMA4yROM3
05b0:  0a 08 60 70 60 52 4d 41   33 79 52 4d 53 33 0a 08 	..`p`RMA3yRMS3..
05c0:  60 70 60 52 53 53 33 70   0c 00 00 01 00 52 53 53 	`p`RSS3p.....RSS
05d0:  34 70 41 4d 45 4d 41 43   4d 4d a4 42 55 46 30 5b 	4pAMEMACMM.BUF0[
05e0:  82 8f 67 01 50 43 49 30   08 5f 48 49 44 0c 41 d0 	..g.PCI0._HID.A.
05f0:  0a 03 08 5f 41 44 52 0a   00 14 09 5f 53 54 41 00 	..._ADR...._STA.
0600:  a4 0a 0f 14 4a 10 5f 43   52 53 00 08 42 55 46 30 	....J._CRS..BUF0
0610:  11 42 09 0a 8e 88 0d 00   02 01 00 00 00 00 00 ff 	.B..............
0620:  00 00 00 00 01 47 01 f8   0c f8 0c 01 08 88 0d 00 	.....G..........
0630:  01 0c 03 00 00 00 00 f7   0c 00 00 f8 0c 88 0d 00 	................
0640:  01 0c 03 00 00 00 0d ff   4f 00 00 00 43 47 01 00 	........O...CG..
0650:  50 00 50 01 80 47 01 80   50 80 50 01 80 88 0d 00 	P.P..G..P.P.....
0660:  01 0c 03 00 00 00 51 ff   ff 00 00 ff ae 87 17 00 	......Q.........
0670:  00 0c 03 00 00 00 00 00   00 0a 00 ff 7f 0c 00 00 	................
0680:  00 00 00 00 80 02 00 87   17 00 00 0c 03 00 00 00 	................
0690:  00 00 00 10 00 ff ff ef   ff 00 00 00 00 00 00 f0 	................
06a0:  ff 79 00 8a 42 55 46 30   0a 66 56 4d 41 58 8a 42 	.y..BUF0.fVMAX.B
06b0:  55 46 30 0a 6e 56 4c 45   4e 79 56 47 41 31 0a 09 	UF0.nVLENyVGA1..
06c0:  60 72 60 0c ff ff 0b 00   56 4d 41 58 72 60 0c 00 	`r`.....VMAXr`..
06d0:  00 02 00 56 4c 45 4e 8a   42 55 46 30 0a 7c 54 43 	...VLEN.BUF0.|TC
06e0:  4d 4d 8a 42 55 46 30 0a   88 54 4f 4d 4d 72 41 4d 	MM.BUF0..TOMMrAM
06f0:  45 4d 0c 00 00 01 00 54   43 4d 4d 74 0c 00 00 f0 	EM.....TCMMt....
0700:  ff 54 43 4d 4d 54 4f 4d   4d a4 42 55 46 30 08 5f 	.TCMMTOMM.BUF0._
0710:  50 52 54 12 4b 28 18 12   1a 04 0c ff ff 09 00 0a 	PRT.K(..........
0720:  00 5c 2f 03 5f 53 42 5f   50 43 49 30 4c 4e 4b 41 	.\/._SB_PCI0LNKA
0730:  0a 00 12 1a 04 0c ff ff   09 00 0a 01 5c 2f 03 5f 	............\/._
0740:  53 42 5f 50 43 49 30 4c   4e 4b 42 0a 00 12 1a 04 	SB_PCI0LNKB.....
0750:  0c ff ff 09 00 0a 02 5c   2f 03 5f 53 42 5f 50 43 	.......\/._SB_PC
0760:  49 30 4c 4e 4b 43 0a 00   12 1a 04 0c ff ff 09 00 	I0LNKC..........
0770:  0a 03 5c 2f 03 5f 53 42   5f 50 43 49 30 4c 4e 4b 	..\/._SB_PCI0LNK
0780:  44 0a 00 12 1a 04 0c ff   ff 0a 00 0a 00 5c 2f 03 	D............\/.
0790:  5f 53 42 5f 50 43 49 30   4c 4e 4b 42 0a 00 12 1a 	_SB_PCI0LNKB....
07a0:  04 0c ff ff 0a 00 0a 01   5c 2f 03 5f 53 42 5f 50 	........\/._SB_P
07b0:  43 49 30 4c 4e 4b 43 0a   00 12 1a 04 0c ff ff 0a 	CI0LNKC.........
07c0:  00 0a 02 5c 2f 03 5f 53   42 5f 50 43 49 30 4c 4e 	...\/._SB_PCI0LN
07d0:  4b 44 0a 00 12 1a 04 0c   ff ff 0a 00 0a 03 5c 2f 	KD............\/
07e0:  03 5f 53 42 5f 50 43 49   30 4c 4e 4b 41 0a 00 12 	._SB_PCI0LNKA...
07f0:  1a 04 0c ff ff 0b 00 0a   00 5c 2f 03 5f 53 42 5f 	.........\/._SB_
0800:  50 43 49 30 4c 4e 4b 43   0a 00 12 1a 04 0c ff ff 	PCI0LNKC........
0810:  0b 00 0a 01 5c 2f 03 5f   53 42 5f 50 43 49 30 4c 	....\/._SB_PCI0L
0820:  4e 4b 44 0a 00 12 1a 04   0c ff ff 0b 00 0a 02 5c 	NKD............\
0830:  2f 03 5f 53 42 5f 50 43   49 30 4c 4e 4b 41 0a 00 	/._SB_PCI0LNKA..
0840:  12 1a 04 0c ff ff 0b 00   0a 03 5c 2f 03 5f 53 42 	..........\/._SB
0850:  5f 50 43 49 30 4c 4e 4b   42 0a 00 12 1a 04 0c ff 	_PCI0LNKB.......
0860:  ff 0c 00 0a 00 5c 2f 03   5f 53 42 5f 50 43 49 30 	.....\/._SB_PCI0
0870:  4c 4e 4b 44 0a 00 12 1a   04 0c ff ff 0c 00 0a 01 	LNKD............
0880:  5c 2f 03 5f 53 42 5f 50   43 49 30 4c 4e 4b 41 0a 	\/._SB_PCI0LNKA.
0890:  00 12 1a 04 0c ff ff 0c   00 0a 02 5c 2f 03 5f 53 	...........\/._S
08a0:  42 5f 50 43 49 30 4c 4e   4b 42 0a 00 12 1a 04 0c 	B_PCI0LNKB......
08b0:  ff ff 0c 00 0a 03 5c 2f   03 5f 53 42 5f 50 43 49 	......\/._SB_PCI
08c0:  30 4c 4e 4b 43 0a 00 12   1a 04 0c ff ff 07 00 0a 	0LNKC...........
08d0:  00 5c 2f 03 5f 53 42 5f   50 43 49 30 4c 4e 4b 41 	.\/._SB_PCI0LNKA
08e0:  0a 00 12 1a 04 0c ff ff   07 00 0a 01 5c 2f 03 5f 	............\/._
08f0:  53 42 5f 50 43 49 30 4c   4e 4b 42 0a 00 12 1a 04 	SB_PCI0LNKB.....
0900:  0c ff ff 07 00 0a 02 5c   2f 03 5f 53 42 5f 50 43 	.......\/._SB_PC
0910:  49 30 4c 4e 4b 43 0a 00   12 1a 04 0c ff ff 07 00 	I0LNKC..........
0920:  0a 03 5c 2f 03 5f 53 42   5f 50 43 49 30 4c 4e 4b 	..\/._SB_PCI0LNK
0930:  44 0a 00 12 1a 04 0c ff   ff 01 00 0a 00 5c 2f 03 	D............\/.
0940:  5f 53 42 5f 50 43 49 30   4c 4e 4b 41 0a 00 12 1a 	_SB_PCI0LNKA....
0950:  04 0c ff ff 01 00 0a 01   5c 2f 03 5f 53 42 5f 50 	........\/._SB_P
0960:  43 49 30 4c 4e 4b 42 0a   00 12 1a 04 0c ff ff 01 	CI0LNKB.........
0970:  00 0a 02 5c 2f 03 5f 53   42 5f 50 43 49 30 4c 4e 	...\/._SB_PCI0LN
0980:  4b 43 0a 00 12 1a 04 0c   ff ff 01 00 0a 03 5c 2f 	KC............\/
0990:  03 5f 53 42 5f 50 43 49   30 4c 4e 4b 44 0a 00 5b 	._SB_PCI0LNKD..[
09a0:  82 45 04 56 54 38 36 08   5f 41 44 52 0c 00 00 07 	.E.VT86._ADR....
09b0:  00 5b 80 50 49 52 51 02   0a 55 0a 03 10 29 5c 00 	.[.PIRQ..U...)\.
09c0:  5b 81 24 5c 2f 04 5f 53   42 5f 50 43 49 30 56 54 	[.$\/._SB_PCI0VT
09d0:  38 36 50 49 52 51 01 50   49 52 44 08 50 49 42 41 	86PIRQ.PIRD.PIBA
09e0:  08 50 49 52 43 08 5b 82   1b 55 53 42 30 08 5f 41 	.PIRC.[..USB0._A
09f0:  44 52 0c 02 00 07 00 08   5f 50 52 57 12 06 02 0a 	DR......_PRW....
0a00:  09 0a 05 5b 82 1b 55 53   42 31 08 5f 41 44 52 0c 	...[..USB1._ADR.
0a10:  03 00 07 00 08 5f 50 52   57 12 06 02 0a 09 0a 05 	....._PRW.......
0a20:  5b 82 0f 56 54 41 43 08   5f 41 44 52 0c 04 00 07 	[..VTAC._ADR....
0a30:  00 5b 82 43 12 4c 4e 4b   42 08 5f 48 49 44 0c 41 	.[.C.LNKB._HID.A
0a40:  d0 0c 0f 08 5f 55 49 44   0a 02 14 1c 5f 53 54 41 	...._UID...._STA
0a50:  00 7b 50 49 42 41 0a 0f   60 a0 08 93 60 0a 00 a4 	.{PIBA..`...`...
0a60:  0a 09 a1 04 a4 0a 0b 14   1a 5f 50 52 53 00 08 42 	........._PRS..B
0a70:  55 46 41 11 09 0a 06 23   fa dc 18 79 00 a4 42 55 	UFA....#...y..BU
0a80:  46 41 14 11 5f 44 49 53   00 7b 50 49 42 41 0a f0 	FA.._DIS.{PIBA..
0a90:  50 49 42 41 14 4f 06 5f   43 52 53 00 08 42 55 46 	PIBA.O._CRS..BUF
0aa0:  41 11 09 0a 06 23 00 00   18 79 00 8c 42 55 46 41 	A....#...y..BUFA
0ab0:  0a 01 49 52 41 31 8c 42   55 46 41 0a 02 49 52 41 	..IRA1.BUFA..IRA
0ac0:  32 70 0a 00 63 70 0a 00   64 7b 50 49 42 41 0a 0f 	2p..cp..d{PIBA..
0ad0:  61 a0 2d 92 93 61 0a 00   a0 0e 94 61 0a 07 74 61 	a.-..a.....a..ta
0ae0:  0a 08 62 79 01 62 64 a1   0b a0 09 94 61 0a 00 79 	..by.bd.....a..y
0af0:  01 61 63 70 63 49 52 41   31 70 64 49 52 41 32 a4 	.acpcIRA1pdIRA2.
0b00:  42 55 46 41 14 41 05 5f   53 52 53 01 8c 68 0a 01 	BUFA.A._SRS..h..
0b10:  49 52 41 31 8c 68 0a 02   49 52 41 32 79 49 52 41 	IRA1.h..IRA2yIRA
0b20:  32 0a 08 60 7d 60 49 52   41 31 60 70 0a 00 61 7a 	2..`}`IRA1`p..az
0b30:  60 0a 01 60 a2 0c 94 60   0a 00 75 61 7a 60 0a 01 	`..`...`..uaz`..
0b40:  60 7b 50 49 42 41 0a f0   50 49 42 41 7d 50 49 42 	`{PIBA..PIBA}PIB
0b50:  41 61 50 49 42 41 5b 82   4d 12 4c 4e 4b 41 08 5f 	AaPIBA[.M.LNKA._
0b60:  48 49 44 0c 41 d0 0c 0f   08 5f 55 49 44 0a 01 14 	HID.A...._UID...
0b70:  1c 5f 53 54 41 00 7b 50   49 42 41 0a f0 60 a0 08 	._STA.{PIBA..`..
0b80:  93 60 0a 00 a4 0a 09 a1   04 a4 0a 0b 14 1a 5f 50 	.`............_P
0b90:  52 53 00 08 42 55 46 42   11 09 0a 06 23 fa dc 18 	RS..BUFB....#...
0ba0:  79 00 a4 42 55 46 42 14   11 5f 44 49 53 00 7b 50 	y..BUFB.._DIS.{P
0bb0:  49 42 41 0a 0f 50 49 42   41 14 44 07 5f 43 52 53 	IBA..PIBA.D._CRS
0bc0:  00 08 42 55 46 42 11 09   0a 06 23 00 00 18 79 00 	..BUFB....#...y.
0bd0:  8c 42 55 46 42 0a 01 49   52 42 31 8c 42 55 46 42 	.BUFB..IRB1.BUFB
0be0:  0a 02 49 52 42 32 70 0a   00 63 70 0a 00 64 7b 50 	..IRB2p..cp..d{P
0bf0:  49 42 41 0a f0 61 7a 61   0a 04 61 a0 2d 92 93 61 	IBA..aza..a.-..a
0c00:  0a 00 a0 0e 94 61 0a 07   74 61 0a 08 62 79 01 62 	.....a..ta..by.b
0c10:  64 a1 0b a0 09 94 61 0a   00 79 01 61 63 70 63 49 	d.....a..y.acpcI
0c20:  52 42 31 70 64 49 52 42   32 a4 42 55 46 42 14 46 	RB1pdIRB2.BUFB.F
0c30:  05 5f 53 52 53 01 8c 68   0a 01 49 52 42 31 8c 68 	._SRS..h..IRB1.h
0c40:  0a 02 49 52 42 32 79 49   52 42 32 0a 08 60 7d 60 	..IRB2yIRB2..`}`
0c50:  49 52 42 31 60 70 0a 00   61 7a 60 0a 01 60 a2 0c 	IRB1`p..az`..`..
0c60:  94 60 0a 00 75 61 7a 60   0a 01 60 7b 50 49 42 41 	.`..uaz`..`{PIBA
0c70:  0a 0f 50 49 42 41 79 61   0a 04 61 7d 50 49 42 41 	..PIBAya..a}PIBA
0c80:  61 50 49 42 41 5b 82 4d   12 4c 4e 4b 43 08 5f 48 	aPIBA[.M.LNKC._H
0c90:  49 44 0c 41 d0 0c 0f 08   5f 55 49 44 0a 03 14 1c 	ID.A...._UID....
0ca0:  5f 53 54 41 00 7b 50 49   52 43 0a f0 60 a0 08 93 	_STA.{PIRC..`...
0cb0:  60 0a 00 a4 0a 09 a1 04   a4 0a 0b 14 1a 5f 50 52 	`............_PR
0cc0:  53 00 08 42 55 46 43 11   09 0a 06 23 fa dc 18 79 	S..BUFC....#...y
0cd0:  00 a4 42 55 46 43 14 11   5f 44 49 53 00 7b 50 49 	..BUFC.._DIS.{PI
0ce0:  52 43 0a 0f 50 49 52 43   14 44 07 5f 43 52 53 00 	RC..PIRC.D._CRS.
0cf0:  08 42 55 46 43 11 09 0a   06 23 00 00 18 79 00 8c 	.BUFC....#...y..
0d00:  42 55 46 43 0a 01 49 52   43 31 8c 42 55 46 43 0a 	BUFC..IRC1.BUFC.
0d10:  02 49 52 43 32 70 0a 00   63 70 0a 00 64 7b 50 49 	.IRC2p..cp..d{PI
0d20:  52 43 0a f0 61 7a 61 0a   04 61 a0 2d 92 93 61 0a 	RC..aza..a.-..a.
0d30:  00 a0 0e 94 61 0a 07 74   61 0a 08 62 79 01 62 64 	....a..ta..by.bd
0d40:  a1 0b a0 09 94 61 0a 00   79 01 61 63 70 63 49 52 	.....a..y.acpcIR
0d50:  43 31 70 64 49 52 43 32   a4 42 55 46 43 14 46 05 	C1pdIRC2.BUFC.F.
0d60:  5f 53 52 53 01 8c 68 0a   01 49 52 43 31 8c 68 0a 	_SRS..h..IRC1.h.
0d70:  02 49 52 43 32 79 49 52   43 32 0a 08 60 7d 60 49 	.IRC2yIRC2..`}`I
0d80:  52 43 31 60 70 0a 00 61   7a 60 0a 01 60 a2 0c 94 	RC1`p..az`..`...
0d90:  60 0a 00 75 61 7a 60 0a   01 60 7b 50 49 52 43 0a 	`..uaz`..`{PIRC.
0da0:  0f 50 49 52 43 79 61 0a   04 61 7d 50 49 52 43 61 	.PIRCya..a}PIRCa
0db0:  50 49 52 43 5b 82 4d 12   4c 4e 4b 44 08 5f 48 49 	PIRC[.M.LNKD._HI
0dc0:  44 0c 41 d0 0c 0f 08 5f   55 49 44 0a 04 14 1c 5f 	D.A...._UID...._
0dd0:  53 54 41 00 7b 50 49 52   44 0a f0 60 a0 08 93 60 	STA.{PIRD..`...`
0de0:  0a 00 a4 0a 09 a1 04 a4   0a 0b 14 1a 5f 50 52 53 	............_PRS
0df0:  00 08 42 55 46 44 11 09   0a 06 23 fa dc 18 79 00 	..BUFD....#...y.
0e00:  a4 42 55 46 44 14 11 5f   44 49 53 00 7b 50 49 52 	.BUFD.._DIS.{PIR
0e10:  44 0a 0f 50 49 52 44 14   44 07 5f 43 52 53 00 08 	D..PIRD.D._CRS..
0e20:  42 55 46 44 11 09 0a 06   23 00 00 18 79 00 8c 42 	BUFD....#...y..B
0e30:  55 46 44 0a 01 49 52 44   31 8c 42 55 46 44 0a 02 	UFD..IRD1.BUFD..
0e40:  49 52 44 32 70 0a 00 63   70 0a 00 64 7b 50 49 52 	IRD2p..cp..d{PIR
0e50:  44 0a f0 61 7a 61 0a 04   61 a0 2d 92 93 61 0a 00 	D..aza..a.-..a..
0e60:  a0 0e 94 61 0a 07 74 61   0a 08 62 79 01 62 64 a1 	...a..ta..by.bd.
0e70:  0b a0 09 94 61 0a 00 79   01 61 63 70 63 49 52 44 	....a..y.acpcIRD
0e80:  31 70 64 49 52 44 32 a4   42 55 46 44 14 46 05 5f 	1pdIRD2.BUFD.F._
0e90:  53 52 53 01 8c 68 0a 01   49 52 44 31 8c 68 0a 02 	SRS..h..IRD1.h..
0ea0:  49 52 44 32 79 49 52 44   32 0a 08 60 7d 60 49 52 	IRD2yIRD2..`}`IR
0eb0:  44 31 60 70 0a 00 61 7a   60 0a 01 60 a2 0c 94 60 	D1`p..az`..`...`
0ec0:  0a 00 75 61 7a 60 0a 01   60 7b 50 49 52 44 0a 0f 	..uaz`..`{PIRD..
0ed0:  50 49 52 44 79 61 0a 04   61 7d 50 49 52 44 61 50 	PIRDya..a}PIRDaP
0ee0:  49 52 44 5b 82 4b 07 53   59 53 52 08 5f 48 49 44 	IRD[.K.SYSR._HID
0ef0:  0c 41 d0 0c 02 08 5f 55   49 44 0a 01 08 5f 43 52 	.A...._UID..._CR
0f00:  53 11 4e 05 0a 5a 47 01   10 00 10 00 01 10 47 01 	S.N..ZG.......G.
0f10:  22 00 22 00 01 1e 47 01   44 00 44 00 01 1c 47 01 	"."...G.D.D...G.
0f20:  62 00 62 00 01 02 47 01   65 00 65 00 01 0b 47 01 	b.b...G.e.e...G.
0f30:  74 00 74 00 01 0c 47 01   91 00 91 00 01 03 47 01 	t.t...G.......G.
0f40:  a2 00 a2 00 01 1e 47 01   e0 00 e0 00 01 10 47 01 	......G.......G.
0f50:  f0 03 f0 03 01 02 47 01   d0 04 d0 04 01 02 79 00 	......G.......y.
0f60:  5b 82 2b 50 49 43 5f 08   5f 48 49 44 0b 41 d0 08 	[.+PIC_._HID.A..
0f70:  5f 43 52 53 11 18 0a 15   47 01 20 00 20 00 01 02 	_CRS....G. . ...
0f80:  47 01 a0 00 a0 00 01 02   22 04 00 79 00 5b 82 3d 	G......."..y.[.=3D
0f90:  44 4d 41 31 08 5f 48 49   44 0c 41 d0 02 00 08 5f 	DMA1._HID.A...._
0fa0:  43 52 53 11 28 0a 25 2a   10 04 47 01 00 00 00 00 	CRS.(.%*..G.....
0fb0:  01 10 47 01 80 00 80 00   01 11 47 01 94 00 94 00 	..G.......G.....
0fc0:  01 0c 47 01 c0 00 c0 00   01 20 79 00 5b 82 25 54 	..G...... y.[.%T
0fd0:  4d 52 5f 08 5f 48 49 44   0c 41 d0 01 00 08 5f 43 	MR_._HID.A...._C
0fe0:  52 53 11 10 0a 0d 47 01   40 00 40 00 01 04 22 01 	RS....G.-4b8TPpkIZ3Q@public.gmane.org@...".
0ff0:  00 79 00 5b 82 25 52 54   43 5f 08 5f 48 49 44 0c 	.y.[.%RTC_._HID.
1000:  41 d0 0b 00 08 5f 43 52   53 11 10 0a 0d 47 01 70 	A...._CRS....G.p
1010:  00 70 00 04 04 22 00 01   79 00 5b 82 22 53 50 4b 	.p..."..y.[."SPK
1020:  52 08 5f 48 49 44 0c 41   d0 08 00 08 5f 43 52 53 	R._HID.A...._CRS
1030:  11 0d 0a 0a 47 01 61 00   61 00 01 01 79 00 5b 82 	....G.a.a...y.[.
1040:  25 43 4f 50 52 08 5f 48   49 44 0c 41 d0 0c 04 08 	%COPR._HID.A....
1050:  5f 43 52 53 11 10 0a 0d   47 01 f0 00 f0 00 01 10 	_CRS....G.......
1060:  22 00 20 79 00 5b 80 49   54 45 31 01 0b f0 03 0a 	". y.[.ITE1.....
1070:  02 5b 81 10 49 54 45 31   01 49 4e 44 58 08 44 41 	.[..ITE1.INDX.DA
1080:  54 41 08 5b 80 45 4e 47   31 01 0b 79 02 0a 01 5b 	TA.[.ENG1..y...[
1090:  81 0b 45 4e 47 31 01 43   4f 4e 47 08 5b 86 46 06 	..ENG1.CONG.[.F.
10a0:  49 4e 44 58 44 41 54 41   01 00 10 43 46 47 5f 08 	INDXDATA...CFG_.
10b0:  00 20 4c 44 4e 5f 08 00   40 0d 50 4f 57 43 08 00 	. LDN_..-8C3lSGX4bNs@public.gmane.org
10c0:  48 06 41 43 54 52 08 00   48 17 49 4f 41 48 08 49 	H.ACTR..H.IOAH.I
10d0:  4f 41 4c 08 00 40 07 49   4e 54 52 08 00 08 49 4e 	OAL..-gw5aB26Wwp3dnjcmp9zZ6A@public.gmane.org
10e0:  54 31 08 00 08 44 4d 43   48 08 00 48 25 47 50 34 	T1...DMCH..H%GP4
10f0:  30 08 00 48 17 4f 50 54   31 08 4f 50 54 32 08 4f 	0..H.OPT1.OPT2.O
1100:  50 54 33 08 14 43 10 45   4e 46 47 00 70 0a 86 43 	PT3..C.ENFG.p..C
1110:  4f 4e 47 70 0a 80 43 4f   4e 47 70 0a 55 43 4f 4e 	ONGp..CONGp.UCON
1120:  47 70 0a 55 43 4f 4e 47   70 0a 6a 49 4e 44 58 70 	Gp.UCONGp.jINDXp
1130:  0a b5 49 4e 44 58 70 0a   da 49 4e 44 58 70 0a ed 	..INDXp..INDXp..
1140:  49 4e 44 58 70 0a f6 49   4e 44 58 70 0a fb 49 4e 	INDXp..INDXp..IN
1150:  44 58 70 0a 7d 49 4e 44   58 70 0a be 49 4e 44 58 	DXp.}INDXp..INDX
1160:  70 0a df 49 4e 44 58 70   0a 6f 49 4e 44 58 70 0a 	p..INDXp.oINDXp.
1170:  37 49 4e 44 58 70 0a 1b   49 4e 44 58 70 0a 0d 49 	7INDXp..INDXp..I
1180:  4e 44 58 70 0a 86 49 4e   44 58 70 0a c3 49 4e 44 	NDXp..INDXp..IND
1190:  58 70 0a 61 49 4e 44 58   70 0a b0 49 4e 44 58 70 	Xp.aINDXp..INDXp
11a0:  0a 58 49 4e 44 58 70 0a   2c 49 4e 44 58 70 0a 16 	.XINDXp.,INDXp..
11b0:  49 4e 44 58 70 0a 8b 49   4e 44 58 70 0a 45 49 4e 	INDXp..INDXp.EIN
11c0:  44 58 70 0a a2 49 4e 44   58 70 0a d1 49 4e 44 58 	DXp..INDXp..INDX
11d0:  70 0a e8 49 4e 44 58 70   0a 74 49 4e 44 58 70 0a 	p..INDXp.tINDXp.
11e0:  3a 49 4e 44 58 70 0a 9d   49 4e 44 58 70 0a ce 49 	:INDXp..INDXp..I
11f0:  4e 44 58 70 0a e7 49 4e   44 58 70 0a 73 49 4e 44 	NDXp..INDXp.sIND
1200:  58 70 0a 39 49 4e 44 58   14 0d 45 58 46 47 00 70 	Xp.9INDX..EXFG.p
1210:  0a 02 43 46 47 5f 5b 82   48 20 46 44 43 30 08 5f 	..CFG_[.H FDC0._
1220:  48 49 44 0c 41 d0 07 00   14 3a 5f 53 54 41 00 45 	HID.A....:_STA.E
1230:  4e 46 47 70 00 4c 44 4e   5f a0 0c 41 43 54 52 45 	NFGp.LDN_..ACTRE
1240:  58 46 47 a4 0a 0f a1 1c   a0 11 91 49 4f 41 48 49 	XFG........IOAHI
1250:  4f 41 4c 45 58 46 47 a4   0a 0d a1 08 45 58 46 47 	OALEXFG.....EXFG
1260:  a4 0a 00 14 1b 5f 44 49   53 00 45 4e 46 47 70 0a 	....._DIS.ENFGp.
1270:  00 4c 44 4e 5f 70 00 41   43 54 52 45 58 46 47 14 	.LDN_p.ACTREXFG.
1280:  45 11 5f 43 52 53 00 08   42 55 46 30 11 1b 0a 18 	E._CRS..BUF0....
1290:  47 01 00 00 00 00 00 04   47 01 00 00 00 00 00 01 	G.......G.......
12a0:  22 00 00 2a 00 00 79 00   8c 42 55 46 30 0a 02 49 	"..*..y..BUF0..I
12b0:  4f 4c 4f 8c 42 55 46 30   0a 03 49 4f 48 49 8c 42 	OLO.BUF0..IOHI.B
12c0:  55 46 30 0a 04 49 4f 52   4c 8c 42 55 46 30 0a 05 	UF0..IORL.BUF0..
12d0:  49 4f 52 48 8c 42 55 46   30 0a 0a 49 4c 4f 31 8c 	IORH.BUF0..ILO1.
12e0:  42 55 46 30 0a 0b 49 48   49 31 8c 42 55 46 30 0a 	BUF0..IHI1.BUF0.
12f0:  0c 49 52 4c 31 8c 42 55   46 30 0a 0d 49 52 48 31 	.IRL1.BUF0..IRH1
1300:  8c 42 55 46 30 0a 11 49   52 51 4c 8c 42 55 46 30 	.BUF0..IRQL.BUF0
1310:  0a 14 44 4d 41 56 45 4e   46 47 70 00 4c 44 4e 5f 	..DMAVENFGp.LDN_
1320:  70 01 41 43 54 52 72 49   4f 41 4c 0a 02 62 70 62 	p.ACTRrIOAL..bpb
1330:  49 4f 4c 4f 70 62 49 4f   52 4c 70 49 4f 41 48 49 	IOLOpbIORLpIOAHI
1340:  4f 48 49 70 49 4f 41 48   49 4f 52 48 72 49 4f 41 	OHIpIOAHIORHrIOA
1350:  4c 0a 07 62 70 62 49 4c   4f 31 70 62 49 52 4c 31 	L..bpbILO1pbIRL1
1360:  70 49 4f 41 48 49 48 49   31 70 49 4f 41 48 49 52 	pIOAHIHI1pIOAHIR
1370:  48 31 70 01 60 79 60 49   4e 54 52 49 52 51 4c 70 	H1p.`y`INTRIRQLp
1380:  01 60 79 60 44 4d 43 48   44 4d 41 56 45 58 46 47 	.`y`DMCHDMAVEXFG
1390:  a4 42 55 46 30 08 5f 50   52 53 11 1d 0a 1a 30 47 	.BUF0._PRS....0G
13a0:  01 f2 03 f2 03 00 04 47   01 f7 03 f7 03 00 01 22 	.......G......."
13b0:  40 00 2a 04 00 38 79 00   14 47 06 5f 53 52 53 01 	@.*..8y..G._SRS.
13c0:  8c 68 0a 02 49 4f 4c 4f   8c 68 0a 03 49 4f 48 49 	.h..IOLO.h..IOHI
13d0:  8b 68 0a 11 49 52 51 4c   8c 68 0a 14 44 4d 41 56 	.h..IRQL.h..DMAV
13e0:  45 4e 46 47 70 00 4c 44   4e 5f 70 0a f0 49 4f 41 	ENFGp.LDN_p..IOA
13f0:  4c 70 49 4f 48 49 49 4f   41 48 82 49 52 51 4c 60 	LpIOHIIOAH.IRQL`
1400:  74 60 0a 01 49 4e 54 52   82 44 4d 41 56 60 74 60 	t`..INTR.DMAV`t`
1410:  0a 01 44 4d 43 48 70 01   41 43 54 52 45 58 46 47 	..DMCHp.ACTREXFG
1420:  5b 82 40 1a 55 41 52 31   08 5f 48 49 44 0c 41 d0 	[.-MdUeknGpJgpAc1yVyaMGGg@public.gmane.org
1430:  05 01 08 5f 55 49 44 0a   01 14 3b 5f 53 54 41 00 	..._UID...;_STA.
1440:  45 4e 46 47 70 0a 01 4c   44 4e 5f a0 0c 41 43 54 	ENFGp..LDN_..ACT
1450:  52 45 58 46 47 a4 0a 0f   a1 1c a0 11 91 49 4f 41 	REXFG........IOA
1460:  48 49 4f 41 4c 45 58 46   47 a4 0a 0d a1 08 45 58 	HIOALEXFG.....EX
1470:  46 47 a4 0a 00 14 1b 5f   44 49 53 00 45 4e 46 47 	FG....._DIS.ENFG
1480:  70 0a 01 4c 44 4e 5f 70   00 41 43 54 52 45 58 46 	p..LDN_p.ACTREXF
1490:  47 14 4f 09 5f 43 52 53   00 08 42 55 46 31 11 10 	G.O._CRS..BUF1..
14a0:  0a 0d 47 01 00 00 00 00   00 08 22 00 00 79 00 8c 	..G......."..y..
14b0:  42 55 46 31 0a 02 49 4f   4c 4f 8c 42 55 46 31 0a 	BUF1..IOLO.BUF1.
14c0:  03 49 4f 48 49 8c 42 55   46 31 0a 04 49 4f 52 4c 	.IOHI.BUF1..IORL
14d0:  8c 42 55 46 31 0a 05 49   4f 52 48 8c 42 55 46 31 	.BUF1..IORH.BUF1
14e0:  0a 09 49 52 51 4c 45 4e   46 47 70 0a 01 4c 44 4e 	..IRQLENFGp..LDN
14f0:  5f 70 01 41 43 54 52 70   49 4f 41 4c 49 4f 4c 4f 	_p.ACTRpIOALIOLO
1500:  70 49 4f 41 4c 49 4f 52   4c 70 49 4f 41 48 49 4f 	pIOALIORLpIOAHIO
1510:  48 49 70 49 4f 41 48 49   4f 52 48 70 01 60 79 60 	HIpIOAHIORHp.`y`
1520:  49 4e 54 52 49 52 51 4c   45 58 46 47 a4 42 55 46 	INTRIRQLEXFG.BUF
1530:  31 08 5f 50 52 53 11 36   0a 33 30 47 01 f8 03 f8 	1._PRS.6.30G....
1540:  03 00 08 22 b8 00 30 47   01 f8 02 f8 02 00 08 22 	..."..0G......."
1550:  b8 00 30 47 01 e8 03 e8   03 00 08 22 b8 00 30 47 	..0G......."..0G
1560:  01 e8 02 e8 02 00 08 22   b8 00 38 79 00 14 44 05 	......."..8y..D.
1570:  5f 53 52 53 01 8c 68 0a   02 49 4f 4c 4f 8c 68 0a 	_SRS..h..IOLO.h.
1580:  03 49 4f 48 49 8c 68 0a   09 49 52 51 4c 45 4e 46 	.IOHI.h..IRQLENF
1590:  47 70 0a 01 4c 44 4e 5f   70 49 4f 4c 4f 49 4f 41 	Gp..LDN_pIOLOIOA
15a0:  4c 70 49 4f 48 49 49 4f   41 48 82 49 52 51 4c 60 	LpIOHIIOAH.IRQL`
15b0:  74 60 0a 01 49 4e 54 52   70 01 41 43 54 52 45 58 	t`..INTRp.ACTREX
15c0:  46 47 5b 82 4e 1a 55 41   52 32 08 5f 48 49 44 0c 	FG[.N.UAR2._HID.
15d0:  41 d0 05 01 08 5f 55 49   44 0a 02 14 3b 5f 53 54 	A...._UID...;_ST
15e0:  41 00 45 4e 46 47 70 0a   02 4c 44 4e 5f a0 0c 41 	A.ENFGp..LDN_..A
15f0:  43 54 52 45 58 46 47 a4   0a 0f a1 1c a0 11 91 49 	CTREXFG........I
1600:  4f 41 48 49 4f 41 4c 45   58 46 47 a4 0a 0d a1 08 	OAHIOALEXFG.....
1610:  45 58 46 47 a4 0a 00 14   29 5f 44 49 53 00 45 4e 	EXFG....)_DIS.EN
1620:  46 47 70 0a 02 4c 44 4e   5f 7b 4f 50 54 32 0a 07 	FGp..LDN_{OPT2..
1630:  60 a0 0b 93 60 0a 00 70   00 41 43 54 52 45 58 46 	`...`..p.ACTREXF
1640:  47 14 4f 09 5f 43 52 53   00 08 42 55 46 32 11 10 	G.O._CRS..BUF2..
1650:  0a 0d 47 01 00 00 00 00   00 08 22 00 00 79 00 8c 	..G......."..y..
1660:  42 55 46 32 0a 02 49 4f   4c 4f 8c 42 55 46 32 0a 	BUF2..IOLO.BUF2.
1670:  03 49 4f 48 49 8c 42 55   46 32 0a 04 49 4f 52 4c 	.IOHI.BUF2..IORL
1680:  8c 42 55 46 32 0a 05 49   4f 52 48 8c 42 55 46 32 	.BUF2..IORH.BUF2
1690:  0a 09 49 52 51 4c 45 4e   46 47 70 0a 02 4c 44 4e 	..IRQLENFGp..LDN
16a0:  5f 70 01 41 43 54 52 70   49 4f 41 4c 49 4f 4c 4f 	_p.ACTRpIOALIOLO
16b0:  70 49 4f 41 4c 49 4f 52   4c 70 49 4f 41 48 49 4f 	pIOALIORLpIOAHIO
16c0:  48 49 70 49 4f 41 48 49   4f 52 48 70 01 60 79 60 	HIpIOAHIORHp.`y`
16d0:  49 4e 54 52 49 52 51 4c   45 58 46 47 a4 42 55 46 	INTRIRQLEXFG.BUF
16e0:  32 08 5f 50 52 53 11 36   0a 33 30 47 01 f8 03 f8 	2._PRS.6.30G....
16f0:  03 00 08 22 b8 00 30 47   01 f8 02 f8 02 00 08 22 	..."..0G......."
1700:  b8 00 30 47 01 e8 03 e8   03 00 08 22 b8 00 30 47 	..0G......."..0G
1710:  01 e8 02 e8 02 00 08 22   b8 00 38 79 00 14 44 05 	......."..8y..D.
1720:  5f 53 52 53 01 8c 68 0a   02 49 4f 4c 4f 8c 68 0a 	_SRS..h..IOLO.h.
1730:  03 49 4f 48 49 8c 68 0a   09 49 52 51 4c 45 4e 46 	.IOHI.h..IRQLENF
1740:  47 70 0a 02 4c 44 4e 5f   70 01 41 43 54 52 70 49 	Gp..LDN_p.ACTRpI
1750:  4f 4c 4f 49 4f 41 4c 70   49 4f 48 49 49 4f 41 48 	OLOIOALpIOHIIOAH
1760:  82 49 52 51 4c 60 74 60   0a 01 49 4e 54 52 45 58 	.IRQL`t`..INTREX
1770:  46 47 5b 82 49 1d 4c 50   54 31 08 5f 48 49 44 0c 	FG[.I.LPT1._HID.
1780:  41 d0 04 00 14 43 05 5f   53 54 41 00 45 4e 46 47 	A....C._STA.ENFG
1790:  70 0a 03 4c 44 4e 5f 7b   4f 50 54 31 0a 02 60 a0 	p..LDN_{OPT1..`.
17a0:  2f 93 60 0a 00 a0 0c 41   43 54 52 45 58 46 47 a4 	/.`....ACTREXFG.
17b0:  0a 0f a1 1c a0 11 91 49   4f 41 48 49 4f 41 4c 45 	.......IOAHIOALE
17c0:  58 46 47 a4 0a 0d a1 08   45 58 46 47 a4 0a 00 a1 	XFG.....EXFG....
17d0:  08 45 58 46 47 a4 0a 00   14 1b 5f 44 49 53 00 45 	.EXFG....._DIS.E
17e0:  4e 46 47 70 0a 03 4c 44   4e 5f 70 00 41 43 54 52 	NFGp..LDN_p.ACTR
17f0:  45 58 46 47 14 43 0c 5f   43 52 53 00 08 42 55 46 	EXFG.C._CRS..BUF
1800:  35 11 10 0a 0d 47 01 00   00 00 00 00 08 22 00 00 	5....G......."..
1810:  79 00 8c 42 55 46 35 0a   02 49 4f 4c 4f 8c 42 55 	y..BUF5..IOLO.BU
1820:  46 35 0a 03 49 4f 48 49   8c 42 55 46 35 0a 04 49 	F5..IOHI.BUF5..I
1830:  4f 52 4c 8c 42 55 46 35   0a 05 49 4f 52 48 8c 42 	ORL.BUF5..IORH.B
1840:  55 46 35 0a 07 49 4f 4c   4e 8c 42 55 46 35 0a 09 	UF5..IOLN.BUF5..
1850:  49 52 51 4c 45 4e 46 47   70 0a 03 4c 44 4e 5f 70 	IRQLENFGp..LDN_p
1860:  01 41 43 54 52 70 49 4f   41 4c 49 4f 4c 4f 70 49 	.ACTRpIOALIOLOpI
1870:  4f 41 4c 49 4f 52 4c 70   49 4f 41 48 49 4f 48 49 	OALIORLpIOAHIOHI
1880:  70 49 4f 41 48 49 4f 52   48 a0 0f 93 49 4f 4c 4f 	pIOAHIORH...IOLO
1890:  0a bc 70 0a 04 49 4f 4c   4e a1 08 70 0a 08 49 4f 	..p..IOLN..p..IO
18a0:  4c 4e 70 01 60 79 60 49   4e 54 52 49 52 51 4c 45 	LNp.`y`INTRIRQLE
18b0:  58 46 47 a4 42 55 46 35   08 5f 50 52 53 11 2a 0a 	XFG.BUF5._PRS.*.
18c0:  27 30 47 01 78 03 78 03   00 08 22 b8 00 30 47 01 	'0G.x.x..."..0G.
18d0:  78 02 78 02 00 08 22 b8   00 30 47 01 bc 03 bc 03 	x.x..."..0G.....
18e0:  00 04 22 b8 00 38 79 00   14 44 06 5f 53 52 53 01 	.."..8y..D._SRS.
18f0:  8c 68 0a 02 49 4f 4c 4f   8c 68 0a 03 49 4f 48 49 	.h..IOLO.h..IOHI
1900:  8c 68 0a 04 49 4f 52 4c   8c 68 0a 05 49 4f 52 48 	.h..IORL.h..IORH
1910:  8c 68 0a 09 49 52 51 4c   45 4e 46 47 70 0a 03 4c 	.h..IRQLENFGp..L
1920:  44 4e 5f 70 49 4f 4c 4f   49 4f 41 4c 70 49 4f 48 	DN_pIOLOIOALpIOH
1930:  49 49 4f 41 48 81 49 52   51 4c 60 74 60 0a 01 49 	IIOAH.IRQL`t`..I
1940:  4e 54 52 70 01 41 43 54   52 45 58 46 47 5b 82 42 	NTRp.ACTREXFG[.B
1950:  29 45 43 50 31 08 5f 48   49 44 0c 41 d0 04 01 14 	)ECP1._HID.A....
1960:  43 05 5f 53 54 41 00 45   4e 46 47 70 0a 03 4c 44 	C._STA.ENFGp..LD
1970:  4e 5f 7b 4f 50 54 31 0a   02 60 a0 2f 93 60 0a 02 	N_{OPT1..`./.`..
1980:  a0 0c 41 43 54 52 45 58   46 47 a4 0a 0f a1 1c a0 	..ACTREXFG......
1990:  11 91 49 4f 41 48 49 4f   41 4c 45 58 46 47 a4 0a 	..IOAHIOALEXFG..
19a0:  0d a1 08 45 58 46 47 a4   0a 00 a1 08 45 58 46 47 	...EXFG.....EXFG
19b0:  a4 0a 00 14 1b 5f 44 49   53 00 45 4e 46 47 70 0a 	....._DIS.ENFGp.
19c0:  03 4c 44 4e 5f 70 00 41   43 54 52 45 58 46 47 14 	.LDN_p.ACTREXFG.
19d0:  44 15 5f 43 52 53 00 08   42 55 46 36 11 1b 0a 18 	D._CRS..BUF6....
19e0:  47 01 00 00 00 00 00 00   47 01 00 00 00 00 00 00 	G.......G.......
19f0:  22 00 00 2a 00 00 79 00   8c 42 55 46 36 0a 02 49 	"..*..y..BUF6..I
1a00:  4f 4c 4f 8c 42 55 46 36   0a 03 49 4f 48 49 8c 42 	OLO.BUF6..IOHI.B
1a10:  55 46 36 0a 04 49 4f 52   4c 8c 42 55 46 36 0a 05 	UF6..IORL.BUF6..
1a20:  49 4f 52 48 8c 42 55 46   36 0a 07 49 4f 4c 4e 8c 	IORH.BUF6..IOLN.
1a30:  42 55 46 36 0a 0a 49 4f   45 4c 8c 42 55 46 36 0a 	BUF6..IOEL.BUF6.
1a40:  0b 49 4f 45 48 8c 42 55   46 36 0a 0c 49 4f 4d 4c 	.IOEH.BUF6..IOML
1a50:  8c 42 55 46 36 0a 0d 49   4f 4d 48 8c 42 55 46 36 	.BUF6..IOMH.BUF6
1a60:  0a 0f 49 4f 48 4e 8c 42   55 46 36 0a 11 49 52 51 	..IOHN.BUF6..IRQ
1a70:  4c 8c 42 55 46 36 0a 14   44 4d 41 43 45 4e 46 47 	L.BUF6..DMACENFG
1a80:  70 0a 03 4c 44 4e 5f 70   01 41 43 54 52 70 49 4f 	p..LDN_p.ACTRpIO
1a90:  41 4c 49 4f 4c 4f 70 49   4f 41 4c 49 4f 52 4c 70 	ALIOLOpIOALIORLp
1aa0:  49 4f 41 4c 49 4f 45 4c   70 49 4f 41 4c 49 4f 4d 	IOALIOELpIOALIOM
1ab0:  4c 70 49 4f 41 48 49 4f   48 49 70 49 4f 41 48 49 	LpIOAHIOHIpIOAHI
1ac0:  4f 52 48 70 49 4f 41 48   63 7d 63 0a 04 63 70 63 	ORHpIOAHc}c..cpc
1ad0:  49 4f 45 48 70 63 49 4f   4d 48 a0 16 93 49 4f 4c 	IOEHpcIOMH...IOL
1ae0:  4f 0a bc 70 0a 04 49 4f   4c 4e 70 0a 04 49 4f 48 	O..p..IOLNp..IOH
1af0:  4e a1 0f 70 0a 08 49 4f   4c 4e 70 0a 04 49 4f 48 	N..p..IOLNp..IOH
1b00:  4e 70 01 60 79 60 49 4e   54 52 49 52 51 4c 70 01 	Np.`y`INTRIRQLp.
1b10:  60 79 60 44 4d 43 48 44   4d 41 43 45 58 46 47 a4 	`y`DMCHDMACEXFG.
1b20:  42 55 46 36 08 5f 50 52   53 11 4c 04 0a 48 30 47 	BUF6._PRS.L..H0G
1b30:  01 78 03 78 03 00 08 47   01 78 07 78 07 00 04 22 	.x.x...G.x.x..."
1b40:  b8 00 2a 0b 00 30 47 01   78 02 78 02 00 08 47 01 	..*..0G.x.x...G.
1b50:  78 06 78 06 00 04 22 b8   00 2a 0b 00 30 47 01 bc 	x.x..."..*..0G..
1b60:  03 bc 03 00 04 47 01 bc   07 bc 07 00 04 22 b8 00 	.....G......."..
1b70:  2a 0b 00 38 79 00 14 4a   06 5f 53 52 53 01 8c 68 	*..8y..J._SRS..h
1b80:  0a 02 49 4f 4c 4f 8c 68   0a 03 49 4f 48 49 8c 68 	..IOLO.h..IOHI.h
1b90:  0a 11 49 52 51 4c 8c 68   0a 14 44 4d 41 43 45 4e 	..IRQL.h..DMACEN
1ba0:  46 47 70 0a 03 4c 44 4e   5f 70 01 41 43 54 52 70 	FGp..LDN_p.ACTRp
1bb0:  49 4f 4c 4f 49 4f 41 4c   70 49 4f 48 49 49 4f 41 	IOLOIOALpIOHIIOA
1bc0:  48 81 49 52 51 4c 60 74   60 0a 01 49 4e 54 52 81 	H.IRQL`t`..INTR.
1bd0:  44 4d 41 43 61 74 61 0a   01 44 4d 43 48 45 58 46 	DMACata..DMCHEXF
1be0:  47 5b 82 35 50 53 32 4d   08 5f 48 49 44 0c 41 d0 	G[.5PS2M._HID.A.
1bf0:  0f 13 14 17 5f 53 54 41   00 a0 0b 93 50 53 32 46 	...._STA....PS2F
1c00:  0a 00 a4 0a 0f a1 04 a4   0a 00 08 5f 43 52 53 11 	..........._CRS.
1c10:  08 0a 05 22 00 10 79 00   5b 82 46 04 50 53 32 4b 	..."..y.[.F.PS2K
1c20:  08 5f 48 49 44 0c 41 d0   03 03 14 17 5f 53 54 41 	._HID.A....._STA
1c30:  00 a0 0b 93 4b 42 44 49   0a 01 a4 0a 00 a1 04 a4 	....KBDI........
1c40:  0a 0f 08 5f 43 52 53 11   18 0a 15 47 01 60 00 60 	..._CRS....G.`.`
1c50:  00 01 01 47 01 64 00 64   00 01 01 22 02 00 79 00 	...G.d.d..."..y.


--------------------------------------------------------------
Table: =1B[20GFACP - (Fixed ACPI Description (FADT))
Signature:=1B[40GFACP
Length:=1B[40G0x00000074
Revision:=1B[40G0x01
Checksum:=1B[40G0x02
OEMID:=1B[40GVIAVP3
OEM Table ID:=1B[40GAWRDACPI
OEM Revision:=1B[40G1.0B
Creator ID:=1B[40GAWRD
FACS Address:=1B[40G0x03ff0000
DSDT Address:=1B[40G0x03ff30c0
Reserved:=1B[40G****
Preferred PM Profile:=1B[40G0x00
SCI Interrupt:=1B[40G0x0009
SCI Command:=1B[40G0x0000502f
ACPI Enable:=1B[40G0xa1
ACPI Disable:=1B[40G0xa0
S4 BIOS Request:=1B[40G0x00
Processor State Control:=1B[40G0x00
PM1a Event Reg Block:=1B[40G0x00005000
PM1b Event Reg Block:=1B[40G0x00000000
PM1a Control Reg Block:=1B[40G0x00005004
PM1b Control Reg Block:=1B[40G0x00000000
PM2 Control Reg Block:=1B[40G0x00000000
PM Timer Control Reg Block:=1B[40G0x00005008
GPE 0 Block:=1B[40G0x00005020
GPE 1 Block:=1B[40G0x00000000
PM1 Event Len:=1B[40G0x04
PM1 Control Len:=1B[40G0x02
PM2 Control Len:=1B[40G0x00
PM Timer Len:=1B[40G0x04
GPE0 Block Len:=1B[40G0x04
GPE1 Block Len:=1B[40G0x00
GPE1 Base:=1B[40G0x00
Cx Control:=1B[40G0x00
C2 Latency:=1B[40G0x005a
C3 Latency:=1B[40G0x0384
Flush Size:=1B[40G0x0000
Flush Stride:=1B[40G0x0000
Duty Offset:=1B[40G0x01
Duty Width:=1B[40G0x01
Day Alarm:=1B[40G0x7d
Month Alarm:=1B[40G0x7e
Century Alarm:=1B[40G0x32
IA/PC Boot Flags:=1B[40G0x0000
Reserved:=1B[40G****
Fixed Feature Flags:=1B[40G0x00000025
Reset Register:=1B[40G
=1B[10GAddress Space ID:=1B[40GUnknown (49)
=1B[10GRegister Bit Width: =1B[40G0x00
=1B[10GRegister Bit Offset: =1B[40G0x00
=1B[10GAddress: =1B[40G0x0000004053434146

Reset Value:=1B[40G0x00
Reserved:=1B[40G0x00
--------------------------------------------------------------
Table: =1B[20GFACS - (Firmware ACPI Control Structure)
Signature:=1B[40GFACS
Length:=1B[40G0x00000040
Hardware Signature:=1B[40G0x00000000
Firmware Waking Vector:=1B[40G0x00000000
Global Lock:=1B[40G0x00000000
Flags:=1B[40G0x00000001

--x4pBfXISqBoDm8sr--

--AjmyJqqohANyBN/e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/1vh1IonHnh+67jkRAp9nAKCooYc1VkQ1Ikhi9K4h92Ns28NnWgCgv43j
Pb96NUHyVwcy7sQhUITEXJE=
=vCUS
-----END PGP SIGNATURE-----

--AjmyJqqohANyBN/e--


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
