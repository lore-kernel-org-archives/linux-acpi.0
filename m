From: Ryan Underwood <nemesis-lists-RBwgCYbvQ+vk1uMJSBkQmQ@public.gmane.org>
Subject: Re: IO-APIC on MS-6163 (2.4.23). ACPI?
Date: Wed, 10 Dec 2003 04:39:23 -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031210103923.GB31759@dbz.icequake.net>
References: <3ACA40606221794F80A5670F0AF15F8401720C15@PDSMSX403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yVhtmJPUSI46BTXb"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8401720C15-SRlDPOYGfgogGBtAFL8yw7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
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


--yVhtmJPUSI46BTXb
Content-Type: multipart/mixed; boundary="aVD9QWMuhilNxW9f"
Content-Disposition: inline


--aVD9QWMuhilNxW9f
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


The other message to ACPI list was for a different machine (Shuttle HOT-591=
P)

I attached the acpidump for this machine, I will try booting with
acpi=3Doff next chance I get to reboot it.

On Wed, Dec 10, 2003 at 10:56:55AM +0800, Yu, Luming wrote:
> I found " evxfevnt-0093 [04] acpi_enable           : Transition to ACPI m=
ode successful". So ACPI seems to work on your machine.=20
> Since you previous email complain transition to acpi mode failed, could y=
ou please tell me what kind of kernel could result in acp mode transition f=
ailure on your box?
>=20
> Regarding IO-APIC issue, I didn't find MADT. Please try acpi=3Doff to ver=
ify IO-APCI can work on your box.
>=20
> Thanks=20
> Luming
>=20
> -----Original Message-----
> From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-admin@lis=
ts.sourceforge.net]On Behalf Of Ryan Underwood
> Sent: 2003?12?9? 17:07
> To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: [ACPI] IO-APIC on MS-6163 (2.4.23). ACPI?
>=20
>=20
>=20
> Hello,
>=20
> Not sure if this is appropriate for ACPI or kernel list so I Cc: both.
>=20
> On my MS-6163 v3.0 (BX Master) board, the IO-APIC was previously being
> used before a blacklist was incorrectly added last year.  Now that the
> blacklist is removed when I upgraded to 2.4.23, ACPI doesn't seem to
> want to enable IO-APIC usage (dmesg attached).  I don't remember whether
> or not I had ACPI enabled when the IO-APIC was working a long time ago.
>=20
> I added some debug statements to arch/i386/kernel/acpi.c/acpi_boot_init()
> to try to diagnose the code flow.  However, when recompiling, almost the =
entire
> kernel must be rebuilt for dependencies, which takes forever on my poor
> machine... :(  So I didn't want to spend much more time without some outs=
ide
> opinion of the situation.
>=20
> But, as you can see from dmesg, it gets here:
> |
> =3D=3D=3D>        printk(KERN_INFO PREFIX "past blacklist\n");
>=20
> #ifdef CONFIG_X86_LOCAL_APIC
>=20
>         /*=20
>          * MADT
>          * ----
>          * Parse the Multiple APIC Description Table (MADT), if exists.
>          * Note that this table provides platform SMP configuration=20
>          * information -- the successor to MPS tables.
>          */
>=20
> XXX     result =3D acpi_table_parse(ACPI_APIC, acpi_parse_madt);
>         if (!result) {
>                 return 0;
>         }
>         else if (result < 0) {
>                 printk(KERN_ERR PREFIX "Error parsing MADT\n");
>                 return result;
>         }
>         else if (result > 1)
>                 printk(KERN_WARNING PREFIX "Multiple MADT tables exist\n"=
);
>=20
> =3D=3D=3D>        printk(KERN_INFO PREFIX "past MADT\n")
> |
> but not here.  There are no other kernel messages printed, so I think XXX=
 is the
> failing part.  Why would that happen?  Is it because this is a UP machine=
 and
> the call only works for SMP?  (CONFIG_X86_LOCAL_APIC is definitely enable=
d)
>=20
> Is it possible that IO-APIC and ACPI can work individually but be mutually
> exclusive on a system if the ACPI tables don't correctly describe the IO-=
APIC?
>=20
> I have only a shallow understanding of how this works (from reading www.a=
cpi.info
> and kernel source) so please bear with me if I am overlooking something o=
bvious.
>=20
> thanks,
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

--aVD9QWMuhilNxW9f
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="ms-6163_v3.txt"
Content-Transfer-Encoding: quoted-printable

--------------------------------------------------------------
Table: =1B[20GRSDP - (Root System Description Pointer)
Signature 1:=1B[40GRSD=20
Signature 2:=1B[40GPTR=20
Checksum:=1B[40G0xbb
OEMID:=1B[40GMSISYS
Revision:=1B[40G0x00
RSDT Address:=1B[40G0x0fff3000
--------------------------------------------------------------
Table: =1B[20GRSDT - (Root System Description)
Signature:=1B[40GRSDT
Length:=1B[40G0x00000028
Revision:=1B[40G0x01
Checksum:=1B[40G0x51
OEMID:=1B[40GMSISYS
OEM Table ID:=1B[40GMS-6163W
OEM Revision:=1B[40G3.00
Creator ID:=1B[40GAWRD
Table Pointer:=1B[40G0x0fff3040
--------------------------------------------------------------
Table: =1B[20GDSDT - (Differentied System Description)
Signature:=1B[40GDSDT
Length:=1B[40G0x00002338
Revision:=1B[40G0x01
Checksum:=1B[40G0x79
OEMID:=1B[40GMSISYS
OEM Table ID:=1B[40GAWRDACPI
OEM Revision:=1B[40G
Creator ID:=1B[40GMSFT
=09
0000:  10 19 5c 5f 50 52 5f 5b   83 11 5c 2e 5f 50 52 5f 	..\_PR_[..\._PR_
0010:  43 50 55 30 01 10 40 00   00 06 08 5c 5f 53 30 5f 	CPU0..-9D9NNryygCw@public.gmane.org\_S0_
0020:  12 06 02 0a 05 0a 05 08   5c 5f 53 31 5f 12 06 02 	........\_S1_...
0030:  0a 04 0a 04 5b 80 43 4d   4f 53 01 0a 70 0a 02 5b 	....[.CMOS..p..[
0040:  81 10 43 4d 4f 53 01 49   4e 58 5f 08 44 54 41 5f 	..CMOS.INX_.DTA_
0050:  08 70 0a 40 60 70 0a 5d   49 4e 58 5f 70 44 54 41 	.p.@`p.]INX_pDTA
0060:  5f 61 7b 61 60 61 a0 12   93 61 0a 40 08 5c 5f 53 	_a{a`a...a.-4b8TPpkIZ3Q@public.gmane.org\_S
0070:  33 5f 12 06 02 0a 01 0a   01 08 5c 5f 53 34 5f 12 	3_........\_S4_.
0080:  04 02 00 00 08 5c 5f 53   35 5f 12 04 02 00 00 5b 	.....\_S5_.....[
0090:  80 5c 44 45 42 47 01 0a   80 0a 01 5b 81 0c 5c 44 	.\DEBG.....[..\D
00a0:  45 42 47 01 44 42 47 31   08 5b 80 45 58 54 4d 00 	EBG.DBG1.[.EXTM.
00b0:  0c 30 f8 0f 00 0a 10 5b   81 29 45 58 54 4d 02 52 	.0.....[.)EXTM.R
00c0:  4f 4d 31 10 52 4d 53 31   10 52 4f 4d 32 10 52 4d 	OM1.RMS1.ROM2.RM
00d0:  53 32 10 52 4f 4d 33 10   52 4d 53 33 10 41 4d 45 	S2.ROM3.RMS3.AME
00e0:  4d 20 5b 80 56 47 41 4d   00 0c 02 00 0c 00 0a 01 	M [.VGAM........
00f0:  5b 81 0b 56 47 41 4d 01   56 47 41 31 08 5b 80 5c 	[..VGAM.VGA1.[.\
0100:  53 4d 49 43 01 0a b2 0a   01 5b 81 0c 5c 53 4d 49 	SMIC.....[..\SMI
0110:  43 01 53 43 50 5f 08 5b   80 5c 54 52 41 50 01 0b 	C.SCP_.[.\TRAP..
0120:  2f 40 0a 01 5b 81 0e 5c   54 52 41 50 01 00 01 54 	/@..[..\TRAP...T
0130:  52 31 33 01 5b 80 5c 47   42 4c 45 01 0b 21 40 0a 	R13.[.\GBLE..!@.
0140:  01 5b 81 0c 5c 47 42 4c   45 01 45 53 4d 49 08 08 	.[..\GBLE.ESMI..
0150:  43 4d 44 42 11 03 0a 08   8c 43 4d 44 42 0a 00 42 	CMDB.....CMDB..B
0160:  59 54 30 8c 43 4d 44 42   0a 01 42 59 54 31 8c 43 	YT0.CMDB..BYT1.C
0170:  4d 44 42 0a 02 42 59 54   32 8c 43 4d 44 42 0a 03 	MDB..BYT2.CMDB..
0180:  42 59 54 33 8c 43 4d 44   42 0a 04 42 59 54 34 8c 	BYT3.CMDB..BYT4.
0190:  43 4d 44 42 0a 05 42 59   54 35 8c 43 4d 44 42 0a 	CMDB..BYT5.CMDB.
01a0:  06 42 59 54 36 8c 43 4d   44 42 0a 07 42 59 54 37 	.BYT6.CMDB..BYT7
01b0:  08 49 44 45 42 11 03 0a   38 5b 13 49 44 45 42 0a 	.IDEB...8[.IDEB.
01c0:  00 0a 38 43 4d 44 30 5b   13 49 44 45 42 0a 38 0a 	..8CMD0[.IDEB.8.
01d0:  38 43 4d 44 31 5b 13 49   44 45 42 0a 70 0a 38 43 	8CMD1[.IDEB.p.8C
01e0:  4d 44 32 5b 13 49 44 45   42 0a a8 0a 38 43 4d 44 	MD2[.IDEB...8CMD
01f0:  33 5b 13 49 44 45 42 0a   e0 0a 38 43 4d 44 34 5b 	3[.IDEB...8CMD4[
0200:  13 49 44 45 42 0b 18 01   0a 38 43 4d 44 35 5b 13 	.IDEB....8CMD5[.
0210:  49 44 45 42 0b 50 01 0a   38 43 4d 44 36 5b 13 49 	IDEB.P..8CMD6[.I
0220:  44 45 42 0b 88 01 0a 38   43 4d 44 37 5b 80 41 50 	DEB....8CMD7[.AP
0230:  4d 50 01 0a b2 0a 02 5b   81 10 41 50 4d 50 01 41 	MP.....[..APMP.A
0240:  50 4d 43 08 41 50 4d 44   08 5b 80 45 4c 43 52 01 	PMC.APMD.[.ELCR.
0250:  0b d0 04 0a 02 5b 81 10   45 4c 43 52 01 45 4c 43 	.....[..ELCR.ELC
0260:  31 08 45 4c 43 32 08 5b   80 47 50 4f 42 01 0b 34 	1.ELC2.[.GPOB..4
0270:  40 0a 04 5b 81 47 0a 47   50 4f 42 01 47 50 30 30 	@..[.G.GPOB.GP00
0280:  01 47 50 30 31 01 47 50   30 32 01 47 50 30 33 01 	.GP01.GP02.GP03.
0290:  47 50 30 34 01 47 50 30   35 01 47 50 30 36 01 47 	GP04.GP05.GP06.G
02a0:  50 30 37 01 47 50 30 38   01 47 50 30 39 01 47 50 	P07.GP08.GP09.GP
02b0:  30 41 01 47 50 30 42 01   47 50 30 43 01 47 50 30 	0A.GP0B.GP0C.GP0
02c0:  44 01 47 50 30 45 01 47   50 30 46 01 47 50 31 30 	D.GP0E.GP0F.GP10
02d0:  01 47 50 31 31 01 47 50   31 32 01 47 50 31 33 01 	.GP11.GP12.GP13.
02e0:  47 50 31 34 01 47 50 31   35 01 47 50 31 36 01 47 	GP14.GP15.GP16.G
02f0:  50 31 37 01 47 50 31 38   01 47 50 31 39 01 47 50 	P17.GP18.GP19.GP
0300:  31 41 01 47 50 31 42 01   47 50 31 43 01 47 50 31 	1A.GP1B.GP1C.GP1
0310:  44 01 47 50 31 45 01 47   50 31 46 01 5b 80 57 49 	D.GP1E.GP1F.[.WI
0320:  4e 32 01 0a 70 0a 02 5b   81 10 57 49 4e 32 01 49 	N2..p..[..WIN2.I
0330:  4e 44 32 08 44 41 54 32   08 14 24 47 43 4d 53 02 	ND2.DAT2..$GCMS.
0340:  70 69 60 70 68 49 4e 44   32 70 44 41 54 32 61 7b 	pi`phIND2pDAT2a{
0350:  61 60 61 82 60 62 76 62   7a 61 62 61 a4 61 14 26 	a`a.`bvbzaba.a.&
0360:  52 43 4d 53 00 70 0a 0c   60 70 0a 5b 49 4e 44 32 	RCMS.p..`p.[IND2
0370:  70 44 41 54 32 61 7b 61   60 61 82 60 62 76 62 7a 	pDAT2a{a`a.`bvbz
0380:  61 62 61 a4 61 5b 80 57   49 4e 31 01 0b f0 03 0a 	aba.a[.WIN1.....
0390:  02 5b 81 10 57 49 4e 31   01 49 4e 44 5f 08 44 41 	.[..WIN1.IND_.DA
03a0:  54 5f 08 14 14 45 4e 46   47 00 70 0a 87 49 4e 44 	T_...ENFG.p..IND
03b0:  5f 70 0a 87 49 4e 44 5f   14 0d 45 58 46 47 00 70 	_p..IND_..EXFG.p
03c0:  0a aa 49 4e 44 5f 14 46   08 53 41 4c 44 01 a0 1a 	..IND_.F.SALD...
03d0:  93 68 0a 00 45 4e 46 47   70 0a 2c 49 4e 44 5f 70 	.h..ENFGp.,IND_p
03e0:  00 44 41 54 5f 45 58 46   47 a1 43 06 a0 40 06 93 	.DAT_EXFG.C..-rVxdn2TrCWA@public.gmane.org
03f0:  68 0a 01 70 52 43 4d 53   60 a0 37 93 60 0a 01 45 	h..pRCMS`.7.`..E
0400:  4e 46 47 70 0a 2c 49 4e   44 5f 70 0a 01 44 41 54 	NFGp.,IND_p..DAT
0410:  5f 70 0a 07 49 4e 44 5f   70 0a 07 44 41 54 5f 70 	_p..IND_p..DAT_p
0420:  0a e4 49 4e 44 5f 70 0a   0a 44 41 54 5f 45 58 46 	..IND_p..DAT_EXF
0430:  47 a0 1b 93 60 0a 02 45   4e 46 47 70 0a 2c 49 4e 	G...`..ENFGp.,IN
0440:  44 5f 70 0a 02 44 41 54   5f 45 58 46 47 5b 80 42 	D_p..DAT_EXFG[.B
0450:  45 45 50 01 0a 61 0a 01   5b 81 0b 42 45 45 50 01 	EEP..a..[..BEEP.
0460:  53 31 42 5f 08 5b 80 43   4f 4e 54 01 0a 40 0a 04 	S1B_.[.CONT..-rVxdn2TrCWA@public.gmane.org
0470:  5b 81 1a 43 4f 4e 54 01   43 4e 54 30 08 43 4e 54 	[..CONT.CNT0.CNT
0480:  31 08 43 4e 54 32 08 43   54 52 4c 08 14 43 06 53 	1.CNT2.CTRL..C.S
0490:  50 4b 52 01 70 53 31 42   5f 60 70 0a b6 43 54 52 	PKR.pS1B_`p..CTR
04a0:  4c 70 0a 55 43 4e 54 32   70 0a 03 43 4e 54 32 70 	Lp.UCNT2p..CNT2p
04b0:  68 62 a2 37 94 62 0a 00   7d 53 31 42 5f 0a 03 53 	hb.7.b..}S1B_..S
04c0:  31 42 5f 70 0b ff 5f 63   a2 07 94 63 0a 00 76 63 	1B_p.._c...c..vc
04d0:  7b 53 31 42 5f 0a fc 53   31 42 5f 70 0b ff 0e 63 	{S1B_..S1B_p...c
04e0:  a2 07 94 63 0a 00 76 63   76 62 70 60 53 31 42 5f 	...c..vcvbp`S1B_
04f0:  14 4d 08 5c 5f 50 54 53   01 a0 27 93 68 0a 05 7d 	.M.\_PTS..'.h..}
0500:  68 0a 50 60 70 60 53 43   50 5f 70 45 53 4d 49 60 	h.P`p`SCP_pESMI`
0510:  7b 60 0a fb 60 70 60 45   53 4d 49 70 01 54 52 31 	{`..`p`ESMIp.TR1
0520:  33 a0 27 93 68 0a 01 a0   16 93 47 43 4d 53 0a 53 	3.'.h.....GCMS.S
0530:  0a 01 0a 01 57 42 59 54   0a 5a 0a 5f 0a 00 70 01 	....WBYT.Z._..p.
0540:  54 52 31 33 53 41 4c 44   68 a0 0b 93 68 0a 02 70 	TR13SALDh...h..p
0550:  01 54 52 31 33 7d 68 0a   f0 60 70 60 44 42 47 31 	.TR13}h..`p`DBG1
0560:  a0 0b 95 68 0a 04 70 00   47 50 30 30 a0 05 93 68 	...h..p.GP00...h
0570:  0a 04 a0 0b 93 68 0a 05   70 01 47 50 30 30 14 4e 	.....h..p.GP00.N
0580:  04 5c 5f 57 41 4b 01 70   0a ff 44 42 47 31 53 41 	.\_WAK.p..DBG1SA
0590:  4c 44 0a 00 45 4e 46 47   70 0a 2c 49 4e 44 5f 70 	LD..ENFGp.,IND_p
05a0:  00 44 41 54 5f 45 58 46   47 70 01 47 50 30 30 57 	.DAT_EXFGp.GP00W
05b0:  42 59 54 0a 5a 0a 5f 0a   ff 70 0a 50 53 43 50 5f 	BYT.Z._..p.PSCP_
05c0:  86 5c 2e 5f 53 42 5f 50   57 52 42 0a 02 10 06 5c 	.\._SB_PWRB....\
05d0:  5f 53 49 5f 5b 80 53 4d   30 30 01 0b 00 50 0a 01 	_SI_[.SM00...P..
05e0:  5b 81 0b 53 4d 30 30 01   48 53 54 53 08 5b 80 53 	[..SM00.HSTS.[.S
05f0:  4d 30 32 01 0b 02 50 0a   01 5b 81 0b 53 4d 30 32 	M02...P..[..SM02
0600:  01 43 54 4c 52 08 5b 80   53 4d 30 33 01 0b 03 50 	.CTLR.[.SM03...P
0610:  0a 01 5b 81 0b 53 4d 30   33 01 43 4d 44 52 08 5b 	..[..SM03.CMDR.[
0620:  80 53 4d 30 34 01 0b 04   50 0a 01 5b 81 0b 53 4d 	.SM04...P..[..SM
0630:  30 34 01 41 44 44 52 08   5b 80 53 4d 30 35 01 0b 	04.ADDR.[.SM05..
0640:  05 50 0a 01 5b 81 0b 53   4d 30 35 01 44 41 54 30 	.P..[..SM05.DAT0
0650:  08 5b 80 53 4d 30 36 01   0b 06 50 0a 01 5b 81 0b 	.[.SM06...P..[..
0660:  53 4d 30 36 01 44 41 54   31 08 14 26 53 57 46 53 	SM06.DAT1..&SWFS
0670:  00 7b 48 53 54 53 0a 02   60 a2 10 93 60 00 5b 21 	.{HSTS..`...`.[!
0680:  0a 01 7b 48 53 54 53 0a   02 60 70 0a ff 48 53 54 	..{HSTS..`p..HST
0690:  53 14 24 53 42 59 54 02   70 68 41 44 44 52 70 69 	S.$SBYT.phADDRpi
06a0:  43 4d 44 52 70 0a ff 48   53 54 53 70 0a 44 43 54 	CMDRp..HSTSp.DCT
06b0:  4c 52 53 57 46 53 14 2a   57 42 59 54 03 70 68 41 	LRSWFS.*WBYT.phA
06c0:  44 44 52 70 69 43 4d 44   52 70 6a 44 41 54 30 70 	DDRpiCMDRpjDAT0p
06d0:  0a ff 48 53 54 53 70 0a   48 43 54 4c 52 53 57 46 	..HSTSp.HCTLRSWF
06e0:  53 14 30 57 57 52 44 04   70 68 41 44 44 52 70 69 	S.0WWRD.phADDRpi
06f0:  43 4d 44 52 70 6a 44 41   54 30 70 6b 44 41 54 31 	CMDRpjDAT0pkDAT1
0700:  70 0a ff 48 53 54 53 70   0a 4c 43 54 4c 52 53 57 	p..HSTSp.LCTLRSW
0710:  46 53 14 2e 52 42 59 54   02 7d 68 0a 01 61 70 61 	FS..RBYT.}h..apa
0720:  41 44 44 52 70 69 43 4d   44 52 70 0a ff 48 53 54 	ADDRpiCMDRp..HST
0730:  53 70 0a 48 43 54 4c 52   53 57 46 53 a4 44 41 54 	Sp.HCTLRSWFS.DAT
0740:  30 14 3a 52 57 52 44 02   7d 68 0a 01 41 44 44 52 	0.:RWRD.}h..ADDR
0750:  70 69 43 4d 44 52 70 0a   ff 48 53 54 53 70 0a 4c 	piCMDRp..HSTSp.L
0760:  43 54 4c 52 53 57 46 53   70 44 41 54 30 60 79 44 	CTLRSWFSpDAT0`yD
0770:  41 54 31 0a 08 61 7d 60   61 62 a4 62 10 06 5c 5f 	AT1..a}`ab.b..\_
0780:  47 50 45 10 80 b9 01 5c   5f 53 42 5f 5b 82 19 50 	GPE....\_SB_[..P
0790:  57 52 42 08 5f 48 49 44   0c 41 d0 0c 0c 14 09 5f 	WRB._HID.A....._
07a0:  53 54 41 00 a4 0a 0b 5b   82 42 1b 4d 45 4d 5f 08 	STA....[.B.MEM_.
07b0:  5f 48 49 44 0c 41 d0 0c   01 14 41 1a 5f 43 52 53 	_HID.A....A._CRS
07c0:  00 08 42 55 46 30 11 46   06 0a 62 86 09 00 01 00 	..BUF0.F..b.....
07d0:  00 0f 00 00 40 00 00 86   09 00 01 00 40 0f 00 00 	....-3wQm9ZMZ9co@public.gmane.org@...
07e0:  40 00 00 86 09 00 01 00   80 0f 00 00 40 00 00 86 	@...........-47IYjYMXMt4@public.gmane.org
07f0:  09 00 01 00 c0 0f 00 00   40 00 00 86 09 00 01 00 	........-3wQm9ZMZ9co@public.gmane.org
0800:  00 00 00 00 00 01 00 86   09 00 01 00 00 ff ff 00 	................
0810:  00 01 00 86 09 00 01 00   00 00 00 00 00 0a 00 86 	................
0820:  09 00 01 00 00 10 00 00   00 00 00 79 00 8a 42 55 	...........y..BU
0830:  46 30 0a 34 41 43 4d 4d   8a 42 55 46 30 0a 04 52 	F0.4ACMM.BUF0..R
0840:  4d 41 31 8a 42 55 46 30   0a 08 52 53 53 31 8a 42 	MA1.BUF0..RSS1.B
0850:  55 46 30 0a 10 52 4d 41   32 8a 42 55 46 30 0a 14 	UF0..RMA2.BUF0..
0860:  52 53 53 32 8a 42 55 46   30 0a 1c 52 4d 41 33 8a 	RSS2.BUF0..RMA3.
0870:  42 55 46 30 0a 20 52 53   53 33 8a 42 55 46 30 0a 	BUF0. RSS3.BUF0.
0880:  28 52 4d 41 34 8a 42 55   46 30 0a 2c 52 53 53 34 	(RMA4.BUF0.,RSS4
0890:  8a 42 55 46 30 0a 5c 45   58 54 4d 74 41 4d 45 4d 	.BUF0.\EXTMtAMEM
08a0:  0c 00 00 10 00 45 58 54   4d a0 35 92 93 52 4f 4d 	.....EXTM.5..ROM
08b0:  31 00 70 52 4d 41 31 52   4d 41 32 79 52 4f 4d 31 	1.pRMA1RMA2yROM1
08c0:  0a 08 60 70 60 52 4d 41   31 79 52 4d 53 31 0a 08 	..`p`RMA1yRMS1..
08d0:  60 70 60 52 53 53 31 70   0b 00 80 52 53 53 32 a0 	`p`RSS1p...RSS2.
08e0:  35 92 93 52 4f 4d 32 00   70 52 4d 41 32 52 4d 41 	5..ROM2.pRMA2RMA
08f0:  33 79 52 4f 4d 32 0a 08   60 70 60 52 4d 41 32 79 	3yROM2..`p`RMA2y
0900:  52 4d 53 32 0a 08 60 70   60 52 53 53 32 70 0b 00 	RMS2..`p`RSS2p..
0910:  c0 52 53 53 33 a0 37 92   93 52 4f 4d 33 00 70 52 	.RSS3.7..ROM3.pR
0920:  4d 41 33 52 4d 41 34 79   52 4f 4d 33 0a 08 60 70 	MA3RMA4yROM3..`p
0930:  60 52 4d 41 33 79 52 4d   53 33 0a 08 60 70 60 52 	`RMA3yRMS3..`p`R
0940:  53 53 33 70 0c 00 00 01   00 52 53 53 34 70 41 4d 	SS3p.....RSS4pAM
0950:  45 4d 41 43 4d 4d a4 42   55 46 30 5b 82 87 9b 01 	EMACMM.BUF0[....
0960:  50 43 49 30 08 5f 48 49   44 0c 41 d0 0a 03 08 5f 	PCI0._HID.A...._
0970:  41 44 52 0a 00 14 09 5f   53 54 41 00 a4 0a 0f 14 	ADR...._STA.....
0980:  4a 11 5f 43 52 53 00 08   42 55 46 30 11 42 0a 0a 	J._CRS..BUF0.B..
0990:  9e 88 0d 00 02 01 00 00   00 00 00 ff 00 00 00 00 	................
09a0:  01 47 01 f8 0c f8 0c 01   08 88 0d 00 01 0c 03 00 	.G..............
09b0:  00 00 00 f7 0c 00 00 f8   0c 88 0d 00 01 0c 03 00 	................
09c0:  00 00 0d ff 3f 00 00 00   33 47 01 00 40 00 40 01 	....?...3G..-4b8TPpkIZ3Q@public.gmane.org@.
09d0:  42 88 0d 00 01 0c 03 00   00 42 40 ff 4f 00 00 be 	B........B-AhvopwGtO18@public.gmane.org
09e0:  0f 47 01 00 50 00 50 01   10 88 0d 00 01 0c 03 00 	.G..P.P.........
09f0:  00 10 50 ff ff 00 00 f0   af 87 17 00 00 0c 03 00 	..P.............
0a00:  00 00 00 00 00 0a 00 ff   7f 0c 00 00 00 00 00 00 	................
0a10:  80 02 00 87 17 00 00 0c   03 00 00 00 00 00 00 10 	................
0a20:  00 ff ff ef ff 00 00 00   00 00 00 f0 ff 79 00 8a 	.............y..
0a30:  42 55 46 30 0a 76 56 4d   41 58 8a 42 55 46 30 0a 	BUF0.vVMAX.BUF0.
0a40:  7e 56 4c 45 4e 79 56 47   41 31 0a 09 60 72 60 0c 	~VLENyVGA1..`r`.
0a50:  ff ff 0b 00 56 4d 41 58   72 60 0c 00 00 02 00 56 	....VMAXr`.....V
0a60:  4c 45 4e 8a 42 55 46 30   0a 8c 54 43 4d 4d 8a 42 	LEN.BUF0..TCMM.B
0a70:  55 46 30 0a 98 54 4f 4d   4d 72 41 4d 45 4d 0c 00 	UF0..TOMMrAMEM..
0a80:  00 01 00 54 43 4d 4d 74   0c 00 00 f0 ff 54 43 4d 	...TCMMt.....TCM
0a90:  4d 54 4f 4d 4d a4 42 55   46 30 08 5f 50 52 54 12 	MTOMM.BUF0._PRT.
0aa0:  4f 45 24 12 1e 04 0c ff   ff 13 00 0a 00 5c 2f 04 	OE$..........\/.
0ab0:  5f 53 42 5f 50 43 49 30   49 53 41 5f 4c 4e 4b 44 	_SB_PCI0ISA_LNKD
0ac0:  0a 00 12 1e 04 0c ff ff   13 00 0a 01 5c 2f 04 5f 	............\/._
0ad0:  53 42 5f 50 43 49 30 49   53 41 5f 4c 4e 4b 41 0a 	SB_PCI0ISA_LNKA.
0ae0:  00 12 1e 04 0c ff ff 13   00 0a 02 5c 2f 04 5f 53 	...........\/._S
0af0:  42 5f 50 43 49 30 49 53   41 5f 4c 4e 4b 42 0a 00 	B_PCI0ISA_LNKB..
0b00:  12 1e 04 0c ff ff 13 00   0a 03 5c 2f 04 5f 53 42 	..........\/._SB
0b10:  5f 50 43 49 30 49 53 41   5f 4c 4e 4b 43 0a 00 12 	_PCI0ISA_LNKC...
0b20:  1e 04 0c ff ff 0e 00 0a   00 5c 2f 04 5f 53 42 5f 	.........\/._SB_
0b30:  50 43 49 30 49 53 41 5f   4c 4e 4b 41 0a 00 12 1e 	PCI0ISA_LNKA....
0b40:  04 0c ff ff 0e 00 0a 01   5c 2f 04 5f 53 42 5f 50 	........\/._SB_P
0b50:  43 49 30 49 53 41 5f 4c   4e 4b 42 0a 00 12 1e 04 	CI0ISA_LNKB.....
0b60:  0c ff ff 0e 00 0a 02 5c   2f 04 5f 53 42 5f 50 43 	.......\/._SB_PC
0b70:  49 30 49 53 41 5f 4c 4e   4b 43 0a 00 12 1e 04 0c 	I0ISA_LNKC......
0b80:  ff ff 0e 00 0a 03 5c 2f   04 5f 53 42 5f 50 43 49 	......\/._SB_PCI
0b90:  30 49 53 41 5f 4c 4e 4b   44 0a 00 12 1e 04 0c ff 	0ISA_LNKD.......
0ba0:  ff 10 00 0a 00 5c 2f 04   5f 53 42 5f 50 43 49 30 	.....\/._SB_PCI0
0bb0:  49 53 41 5f 4c 4e 4b 42   0a 00 12 1e 04 0c ff ff 	ISA_LNKB........
0bc0:  10 00 0a 01 5c 2f 04 5f   53 42 5f 50 43 49 30 49 	....\/._SB_PCI0I
0bd0:  53 41 5f 4c 4e 4b 43 0a   00 12 1e 04 0c ff ff 10 	SA_LNKC.........
0be0:  00 0a 02 5c 2f 04 5f 53   42 5f 50 43 49 30 49 53 	...\/._SB_PCI0IS
0bf0:  41 5f 4c 4e 4b 44 0a 00   12 1e 04 0c ff ff 10 00 	A_LNKD..........
0c00:  0a 03 5c 2f 04 5f 53 42   5f 50 43 49 30 49 53 41 	..\/._SB_PCI0ISA
0c10:  5f 4c 4e 4b 41 0a 00 12   1e 04 0c ff ff 12 00 0a 	_LNKA...........
0c20:  00 5c 2f 04 5f 53 42 5f   50 43 49 30 49 53 41 5f 	.\/._SB_PCI0ISA_
0c30:  4c 4e 4b 43 0a 00 12 1e   04 0c ff ff 12 00 0a 01 	LNKC............
0c40:  5c 2f 04 5f 53 42 5f 50   43 49 30 49 53 41 5f 4c 	\/._SB_PCI0ISA_L
0c50:  4e 4b 44 0a 00 12 1e 04   0c ff ff 12 00 0a 02 5c 	NKD............\
0c60:  2f 04 5f 53 42 5f 50 43   49 30 49 53 41 5f 4c 4e 	/._SB_PCI0ISA_LN
0c70:  4b 41 0a 00 12 1e 04 0c   ff ff 12 00 0a 03 5c 2f 	KA............\/
0c80:  04 5f 53 42 5f 50 43 49   30 49 53 41 5f 4c 4e 4b 	._SB_PCI0ISA_LNK
0c90:  42 0a 00 12 1e 04 0c ff   ff 14 00 0a 00 5c 2f 04 	B............\/.
0ca0:  5f 53 42 5f 50 43 49 30   49 53 41 5f 4c 4e 4b 42 	_SB_PCI0ISA_LNKB
0cb0:  0a 00 12 1e 04 0c ff ff   14 00 0a 01 5c 2f 04 5f 	............\/._
0cc0:  53 42 5f 50 43 49 30 49   53 41 5f 4c 4e 4b 41 0a 	SB_PCI0ISA_LNKA.
0cd0:  00 12 1e 04 0c ff ff 14   00 0a 02 5c 2f 04 5f 53 	...........\/._S
0ce0:  42 5f 50 43 49 30 49 53   41 5f 4c 4e 4b 44 0a 00 	B_PCI0ISA_LNKD..
0cf0:  12 1e 04 0c ff ff 14 00   0a 03 5c 2f 04 5f 53 42 	..........\/._SB
0d00:  5f 50 43 49 30 49 53 41   5f 4c 4e 4b 43 0a 00 12 	_PCI0ISA_LNKC...
0d10:  1e 04 0c ff ff 11 00 0a   00 5c 2f 04 5f 53 42 5f 	.........\/._SB_
0d20:  50 43 49 30 49 53 41 5f   4c 4e 4b 44 0a 00 12 1e 	PCI0ISA_LNKD....
0d30:  04 0c ff ff 11 00 0a 01   5c 2f 04 5f 53 42 5f 50 	........\/._SB_P
0d40:  43 49 30 49 53 41 5f 4c   4e 4b 43 0a 00 12 1e 04 	CI0ISA_LNKC.....
0d50:  0c ff ff 11 00 0a 02 5c   2f 04 5f 53 42 5f 50 43 	.......\/._SB_PC
0d60:  49 30 49 53 41 5f 4c 4e   4b 42 0a 00 12 1e 04 0c 	I0ISA_LNKB......
0d70:  ff ff 11 00 0a 03 5c 2f   04 5f 53 42 5f 50 43 49 	......\/._SB_PCI
0d80:  30 49 53 41 5f 4c 4e 4b   41 0a 00 12 1e 04 0c ff 	0ISA_LNKA.......
0d90:  ff 0c 00 0a 00 5c 2f 04   5f 53 42 5f 50 43 49 30 	.....\/._SB_PCI0
0da0:  49 53 41 5f 4c 4e 4b 43   0a 00 12 1e 04 0c ff ff 	ISA_LNKC........
0db0:  0c 00 0a 01 5c 2f 04 5f   53 42 5f 50 43 49 30 49 	....\/._SB_PCI0I
0dc0:  53 41 5f 4c 4e 4b 44 0a   00 12 1e 04 0c ff ff 0c 	SA_LNKD.........
0dd0:  00 0a 02 5c 2f 04 5f 53   42 5f 50 43 49 30 49 53 	...\/._SB_PCI0IS
0de0:  41 5f 4c 4e 4b 41 0a 00   12 1e 04 0c ff ff 0c 00 	A_LNKA..........
0df0:  0a 03 5c 2f 04 5f 53 42   5f 50 43 49 30 49 53 41 	..\/._SB_PCI0ISA
0e00:  5f 4c 4e 4b 42 0a 00 12   1e 04 0c ff ff 07 00 0a 	_LNKB...........
0e10:  00 5c 2f 04 5f 53 42 5f   50 43 49 30 49 53 41 5f 	.\/._SB_PCI0ISA_
0e20:  4c 4e 4b 41 0a 00 12 1e   04 0c ff ff 07 00 0a 01 	LNKA............
0e30:  5c 2f 04 5f 53 42 5f 50   43 49 30 49 53 41 5f 4c 	\/._SB_PCI0ISA_L
0e40:  4e 4b 42 0a 00 12 1e 04   0c ff ff 07 00 0a 02 5c 	NKB............\
0e50:  2f 04 5f 53 42 5f 50 43   49 30 49 53 41 5f 4c 4e 	/._SB_PCI0ISA_LN
0e60:  4b 43 0a 00 12 1e 04 0c   ff ff 07 00 0a 03 5c 2f 	KC............\/
0e70:  04 5f 53 42 5f 50 43 49   30 49 53 41 5f 4c 4e 4b 	._SB_PCI0ISA_LNK
0e80:  44 0a 00 12 1e 04 0c ff   ff 01 00 0a 00 5c 2f 04 	D............\/.
0e90:  5f 53 42 5f 50 43 49 30   49 53 41 5f 4c 4e 4b 41 	_SB_PCI0ISA_LNKA
0ea0:  0a 00 12 1e 04 0c ff ff   01 00 0a 01 5c 2f 04 5f 	............\/._
0eb0:  53 42 5f 50 43 49 30 49   53 41 5f 4c 4e 4b 42 0a 	SB_PCI0ISA_LNKB.
0ec0:  00 12 1e 04 0c ff ff 01   00 0a 02 5c 2f 04 5f 53 	...........\/._S
0ed0:  42 5f 50 43 49 30 49 53   41 5f 4c 4e 4b 43 0a 00 	B_PCI0ISA_LNKC..
0ee0:  12 1e 04 0c ff ff 01 00   0a 03 5c 2f 04 5f 53 42 	..........\/._SB
0ef0:  5f 50 43 49 30 49 53 41   5f 4c 4e 4b 44 0a 00 5b 	_PCI0ISA_LNKD..[
0f00:  82 0f 46 41 4e 30 08 5f   48 49 44 0c 41 d0 0c 0b 	..FAN0._HID.A...
0f10:  5b 82 4a 04 50 58 34 30   08 5f 41 44 52 0c 00 00 	[.J.PX40._ADR...
0f20:  07 00 5b 80 50 49 52 51   02 0a 60 0a 04 10 2e 5c 	..[.PIRQ..`....\
0f30:  00 5b 81 29 5c 2f 04 5f   53 42 5f 50 43 49 30 50 	.[.)\/._SB_PCI0P
0f40:  58 34 30 50 49 52 51 01   50 49 52 41 08 50 49 52 	X40PIRQ.PIRA.PIR
0f50:  42 08 50 49 52 43 08 50   49 52 44 08 5b 82 1b 55 	B.PIRC.PIRD.[..U
0f60:  53 42 30 08 5f 41 44 52   0c 02 00 07 00 08 5f 50 	SB0._ADR......_P
0f70:  52 57 12 06 02 0a 08 0a   04 5b 82 0f 50 58 34 33 	RW.......[..PX43
0f80:  08 5f 41 44 52 0c 03 00   07 00 5b 82 88 38 01 49 	._ADR.....[..8.I
0f90:  53 41 5f 08 5f 41 44 52   0c 00 00 07 00 14 09 5f 	SA_._ADR......._
0fa0:  53 54 41 00 a4 0a 0b 5b   82 4f 15 4c 4e 4b 41 08 	STA....[.O.LNKA.
0fb0:  5f 48 49 44 0c 41 d0 0c   0f 08 5f 55 49 44 0a 01 	_HID.A...._UID..
0fc0:  14 1c 5f 53 54 41 00 7b   50 49 52 41 0a 80 60 a0 	.._STA.{PIRA..`.
0fd0:  08 93 60 0a 80 a4 0a 09   a1 04 a4 0a 0b 14 1a 5f 	..`............_
0fe0:  50 52 53 00 08 42 55 46   41 11 09 0a 06 23 f8 dc 	PRS..BUFA....#..
0ff0:  18 79 00 a4 42 55 46 41   14 4f 04 5f 44 49 53 00 	.y..BUFA.O._DIS.
1000:  70 0a 01 63 7b 50 49 52   41 0a 0f 61 70 61 62 a0 	p..c{PIRA..apab.
1010:  0a 94 61 0a 08 74 61 0a   08 61 79 63 61 63 80 63 	..a..ta..aycac.c
1020:  63 a0 0f 94 62 0a 08 7b   45 4c 43 32 63 45 4c 43 	c...b..{ELC2cELC
1030:  32 a1 0b 7b 45 4c 43 31   63 45 4c 43 31 7d 50 49 	2..{ELC1cELC1}PI
1040:  52 41 0a 80 50 49 52 41   14 43 07 5f 43 52 53 00 	RA..PIRA.C._CRS.
1050:  08 42 55 46 41 11 09 0a   06 23 00 00 18 79 00 8c 	.BUFA....#...y..
1060:  42 55 46 41 0a 01 49 52   41 31 8c 42 55 46 41 0a 	BUFA..IRA1.BUFA.
1070:  02 49 52 41 32 70 0a 00   63 70 0a 00 64 7b 50 49 	.IRA2p..cp..d{PI
1080:  52 41 0a 8f 61 a0 31 95   61 0a 80 7b 61 0a 0f 61 	RA..a.1.a..{a..a
1090:  a0 0e 94 61 0a 07 74 61   0a 08 62 79 01 62 64 a1 	...a..ta..by.bd.
10a0:  0b a0 09 94 61 0a 00 79   01 61 63 70 63 49 52 41 	....a..y.acpcIRA
10b0:  31 70 64 49 52 41 32 a4   42 55 46 41 14 4b 04 5f 	1pdIRA2.BUFA.K._
10c0:  53 52 53 01 8c 68 0a 01   49 52 41 31 8c 68 0a 02 	SRS..h..IRA1.h..
10d0:  49 52 41 32 79 49 52 41   32 0a 08 60 7d 60 49 52 	IRA2yIRA2..`}`IR
10e0:  41 31 60 70 0a 00 61 7a   60 0a 01 60 a2 0c 94 60 	A1`p..az`..`...`
10f0:  0a 00 75 61 7a 60 0a 01   60 7b 50 49 52 41 0a 70 	..uaz`..`{PIRA.p
1100:  60 7d 61 60 50 49 52 41   5b 82 4f 15 4c 4e 4b 42 	`}a`PIRA[.O.LNKB
1110:  08 5f 48 49 44 0c 41 d0   0c 0f 08 5f 55 49 44 0a 	._HID.A...._UID.
1120:  02 14 1c 5f 53 54 41 00   7b 50 49 52 42 0a 80 60 	..._STA.{PIRB..`
1130:  a0 08 93 60 0a 80 a4 0a   09 a1 04 a4 0a 0b 14 1a 	...`............
1140:  5f 50 52 53 00 08 42 55   46 42 11 09 0a 06 23 f8 	_PRS..BUFB....#.
1150:  dc 18 79 00 a4 42 55 46   42 14 4f 04 5f 44 49 53 	..y..BUFB.O._DIS
1160:  00 70 0a 01 63 7b 50 49   52 42 0a 0f 61 70 61 62 	.p..c{PIRB..apab
1170:  a0 0a 94 61 0a 08 74 61   0a 08 61 79 63 61 63 80 	...a..ta..aycac.
1180:  63 63 a0 0f 94 62 0a 08   7b 45 4c 43 32 63 45 4c 	cc...b..{ELC2cEL
1190:  43 32 a1 0b 7b 45 4c 43   31 63 45 4c 43 31 7d 50 	C2..{ELC1cELC1}P
11a0:  49 52 42 0a 80 50 49 52   42 14 43 07 5f 43 52 53 	IRB..PIRB.C._CRS
11b0:  00 08 42 55 46 42 11 09   0a 06 23 00 00 18 79 00 	..BUFB....#...y.
11c0:  8c 42 55 46 42 0a 01 49   52 42 31 8c 42 55 46 42 	.BUFB..IRB1.BUFB
11d0:  0a 02 49 52 42 32 70 0a   00 63 70 0a 00 64 7b 50 	..IRB2p..cp..d{P
11e0:  49 52 42 0a 8f 61 a0 31   95 61 0a 80 7b 61 0a 0f 	IRB..a.1.a..{a..
11f0:  61 a0 0e 94 61 0a 07 74   61 0a 08 62 79 01 62 64 	a...a..ta..by.bd
1200:  a1 0b a0 09 94 61 0a 00   79 01 61 63 70 63 49 52 	.....a..y.acpcIR
1210:  42 31 70 64 49 52 42 32   a4 42 55 46 42 14 4b 04 	B1pdIRB2.BUFB.K.
1220:  5f 53 52 53 01 8c 68 0a   01 49 52 42 31 8c 68 0a 	_SRS..h..IRB1.h.
1230:  02 49 52 42 32 79 49 52   42 32 0a 08 60 7d 60 49 	.IRB2yIRB2..`}`I
1240:  52 42 31 60 70 0a 00 61   7a 60 0a 01 60 a2 0c 94 	RB1`p..az`..`...
1250:  60 0a 00 75 61 7a 60 0a   01 60 7b 50 49 52 42 0a 	`..uaz`..`{PIRB.
1260:  70 60 7d 61 60 50 49 52   42 5b 82 43 15 4c 4e 4b 	p`}a`PIRB[.C.LNK
1270:  43 08 5f 48 49 44 0c 41   d0 0c 0f 08 5f 55 49 44 	C._HID.A...._UID
1280:  0a 03 14 1c 5f 53 54 41   00 7b 50 49 52 43 0a 80 	...._STA.{PIRC..
1290:  60 a0 08 93 60 0a 80 a4   0a 09 a1 04 a4 0a 0b 08 	`...`...........
12a0:  5f 50 52 53 11 09 0a 06   23 f8 dc 18 79 00 14 4f 	_PRS....#...y..O
12b0:  04 5f 44 49 53 00 70 0a   01 63 7b 50 49 52 43 0a 	._DIS.p..c{PIRC.
12c0:  0f 61 70 61 62 a0 0a 94   61 0a 08 74 61 0a 08 61 	.apab...a..ta..a
12d0:  79 63 61 63 80 63 63 a0   0f 94 62 0a 08 7b 45 4c 	ycac.cc...b..{EL
12e0:  43 32 63 45 4c 43 32 a1   0b 7b 45 4c 43 31 63 45 	C2cELC2..{ELC1cE
12f0:  4c 43 31 7d 50 49 52 43   0a 80 50 49 52 43 14 43 	LC1}PIRC..PIRC.C
1300:  07 5f 43 52 53 00 08 42   55 46 43 11 09 0a 06 23 	._CRS..BUFC....#
1310:  00 00 18 79 00 8c 42 55   46 43 0a 01 49 52 43 31 	...y..BUFC..IRC1
1320:  8c 42 55 46 43 0a 02 49   52 43 32 70 0a 00 63 70 	.BUFC..IRC2p..cp
1330:  0a 00 64 7b 50 49 52 43   0a 8f 60 a0 31 95 60 0a 	..d{PIRC..`.1.`.
1340:  80 7b 60 0a 0f 60 a0 0e   94 60 0a 07 74 60 0a 08 	.{`..`...`..t`..
1350:  62 79 01 62 64 a1 0b a0   09 94 60 0a 00 79 01 60 	by.bd.....`..y.`
1360:  63 70 63 49 52 43 31 70   64 49 52 43 32 a4 42 55 	cpcIRC1pdIRC2.BU
1370:  46 43 14 4b 04 5f 53 52   53 01 8c 68 0a 01 49 52 	FC.K._SRS..h..IR
1380:  43 31 8c 68 0a 02 49 52   43 32 79 49 52 43 32 0a 	C1.h..IRC2yIRC2.
1390:  08 60 7d 60 49 52 43 31   60 70 0a 00 61 7a 60 0a 	.`}`IRC1`p..az`.
13a0:  01 60 a2 0c 94 60 0a 00   75 61 7a 60 0a 01 60 7b 	.`...`..uaz`..`{
13b0:  50 49 52 43 0a 70 60 7d   61 60 50 49 52 43 5b 82 	PIRC.p`}a`PIRC[.
13c0:  43 15 4c 4e 4b 44 08 5f   48 49 44 0c 41 d0 0c 0f 	C.LNKD._HID.A...
13d0:  08 5f 55 49 44 0a 04 14   1c 5f 53 54 41 00 7b 50 	._UID...._STA.{P
13e0:  49 52 44 0a 80 60 a0 08   93 60 0a 80 a4 0a 09 a1 	IRD..`...`......
13f0:  04 a4 0a 0b 08 5f 50 52   53 11 09 0a 06 23 f8 dc 	....._PRS....#..
1400:  18 79 00 14 4f 04 5f 44   49 53 00 70 0a 01 63 7b 	.y..O._DIS.p..c{
1410:  50 49 52 44 0a 0f 61 70   61 62 a0 0a 94 61 0a 08 	PIRD..apab...a..
1420:  74 61 0a 08 61 79 63 61   63 80 63 63 a0 0f 94 62 	ta..aycac.cc...b
1430:  0a 08 7b 45 4c 43 32 63   45 4c 43 32 a1 0b 7b 45 	..{ELC2cELC2..{E
1440:  4c 43 31 63 45 4c 43 31   7d 50 49 52 44 0a 80 50 	LC1cELC1}PIRD..P
1450:  49 52 44 14 43 07 5f 43   52 53 00 08 42 55 46 44 	IRD.C._CRS..BUFD
1460:  11 09 0a 06 23 00 00 18   79 00 8c 42 55 46 44 0a 	....#...y..BUFD.
1470:  01 49 52 44 31 8c 42 55   46 44 0a 02 49 52 44 32 	.IRD1.BUFD..IRD2
1480:  70 0a 00 63 70 0a 00 64   7b 50 49 52 44 0a 8f 60 	p..cp..d{PIRD..`
1490:  a0 31 95 60 0a 80 7b 60   0a 0f 60 a0 0e 94 60 0a 	.1.`..{`..`...`.
14a0:  07 74 60 0a 08 62 79 01   62 64 a1 0b a0 09 94 60 	.t`..by.bd.....`
14b0:  0a 00 79 01 60 63 70 63   49 52 44 31 70 64 49 52 	..y.`cpcIRD1pdIR
14c0:  44 32 a4 42 55 46 44 14   4b 04 5f 53 52 53 01 8c 	D2.BUFD.K._SRS..
14d0:  68 0a 01 49 52 44 31 8c   68 0a 02 49 52 44 32 79 	h..IRD1.h..IRD2y
14e0:  49 52 44 32 0a 08 60 7d   60 49 52 44 31 60 70 0a 	IRD2..`}`IRD1`p.
14f0:  00 61 7a 60 0a 01 60 a2   0c 94 60 0a 00 75 61 7a 	.az`..`...`..uaz
1500:  60 0a 01 60 7b 50 49 52   44 0a 70 60 7d 61 60 50 	`..`{PIRD.p`}a`P
1510:  49 52 44 5b 82 43 08 53   59 53 52 08 5f 48 49 44 	IRD[.C.SYSR._HID
1520:  0c 41 d0 0c 02 08 5f 55   49 44 0a 01 08 5f 43 52 	.A...._UID..._CR
1530:  53 11 46 06 0a 62 47 01   10 00 10 00 01 10 47 01 	S.F..bG.......G.
1540:  22 00 22 00 01 1e 47 01   44 00 44 00 01 1c 47 01 	"."...G.D.D...G.
1550:  62 00 62 00 01 02 47 01   65 00 65 00 01 0b 47 01 	b.b...G.e.e...G.
1560:  74 00 74 00 01 0c 47 01   91 00 91 00 01 03 47 01 	t.t...G.......G.
1570:  a2 00 a2 00 01 1e 47 01   e0 00 e0 00 01 10 47 01 	......G.......G.
1580:  f0 03 f0 03 01 02 47 01   d0 04 d0 04 01 02 47 01 	......G.......G.
1590:  95 02 95 02 01 02 79 00   5b 82 2b 50 49 43 5f 08 	......y.[.+PIC_.
15a0:  5f 48 49 44 0b 41 d0 08   5f 43 52 53 11 18 0a 15 	_HID.A.._CRS....
15b0:  47 01 20 00 20 00 01 02   47 01 a0 00 a0 00 01 02 	G. . ...G.......
15c0:  22 04 00 79 00 5b 82 3d   44 4d 41 31 08 5f 48 49 	"..y.[.=3DDMA1._HI
15d0:  44 0c 41 d0 02 00 08 5f   43 52 53 11 28 0a 25 2a 	D.A...._CRS.(.%*
15e0:  10 04 47 01 00 00 00 00   01 10 47 01 80 00 80 00 	..G.......G.....
15f0:  01 11 47 01 94 00 94 00   01 0c 47 01 c0 00 c0 00 	..G.......G.....
1600:  01 20 79 00 5b 82 25 54   4d 52 5f 08 5f 48 49 44 	. y.[.%TMR_._HID
1610:  0c 41 d0 01 00 08 5f 43   52 53 11 10 0a 0d 47 01 	.A...._CRS....G.
1620:  40 00 40 00 01 04 22 01   00 79 00 5b 82 25 52 54 	@.-47IYjYMXMt4@public.gmane.org"..y.[.%RT
1630:  43 5f 08 5f 48 49 44 0c   41 d0 0b 00 08 5f 43 52 	C_._HID.A...._CR
1640:  53 11 10 0a 0d 47 01 70   00 70 00 00 04 22 00 01 	S....G.p.p..."..
1650:  79 00 5b 82 22 53 50 4b   52 08 5f 48 49 44 0c 41 	y.[."SPKR._HID.A
1660:  d0 08 00 08 5f 43 52 53   11 0d 0a 0a 47 01 61 00 	...._CRS....G.a.
1670:  61 00 01 01 79 00 5b 82   25 43 4f 50 52 08 5f 48 	a...y.[.%COPR._H
1680:  49 44 0c 41 d0 0c 04 08   5f 43 52 53 11 10 0a 0d 	ID.A...._CRS....
1690:  47 01 f0 00 f0 00 01 10   22 00 20 79 00 5b 80 57 	G.......". y.[.W
16a0:  49 4e 31 01 0b f0 03 0a   02 5b 81 10 57 49 4e 31 	IN1......[..WIN1
16b0:  01 49 4e 44 58 08 44 41   54 41 08 5b 86 40 07 49 	.INDX.DATA.[.-9dC9m7gJutY@public.gmane.org
16c0:  4e 44 58 44 41 54 41 01   00 10 43 46 47 5f 08 00 	NDXDATA...CFG_..
16d0:  20 4c 44 4e 5f 08 00 40   0c 49 44 48 49 08 49 44 	 LDN_..-8s4ZMI5DEqI@public.gmane.org
16e0:  4c 4f 08 50 4f 57 43 08   00 48 06 41 43 54 52 08 	LO.POWC..H.ACTR.
16f0:  00 48 17 49 4f 41 48 08   49 4f 41 4c 08 00 40 07 	.H.IOAH.IOAL..-4b8TPpkIZ3Q@public.gmane.org
1700:  49 4e 54 52 08 00 08 49   4e 54 31 08 00 08 44 4d 	INTR...INT1...DM
1710:  43 48 08 00 48 25 47 50   34 30 08 00 48 17 4f 50 	CH..H%GP40..H.OP
1720:  54 31 08 4f 50 54 32 08   4f 50 54 33 08 14 14 45 	T1.OPT2.OPT3...E
1730:  4e 46 47 00 70 0a 87 49   4e 44 58 70 0a 87 49 4e 	NFG.p..INDXp..IN
1740:  44 58 14 0d 45 58 46 47   00 70 0a aa 49 4e 44 58 	DX..EXFG.p..INDX
1750:  5b 82 47 12 46 44 43 30   08 5f 48 49 44 0c 41 d0 	[.G.FDC0._HID.A.
1760:  07 00 14 3a 5f 53 54 41   00 45 4e 46 47 70 00 4c 	...:_STA.ENFGp.L
1770:  44 4e 5f a0 0c 41 43 54   52 45 58 46 47 a4 0a 0f 	DN_..ACTREXFG...
1780:  a1 1c a0 11 91 49 4f 41   48 49 4f 41 4c 45 58 46 	.....IOAHIOALEXF
1790:  47 a4 0a 05 a1 08 45 58   46 47 a4 0a 00 14 1b 5f 	G.....EXFG....._
17a0:  44 49 53 00 45 4e 46 47   70 0a 00 4c 44 4e 5f 70 	DIS.ENFGp..LDN_p
17b0:  00 41 43 54 52 45 58 46   47 14 41 06 5f 43 52 53 	.ACTREXFG.A._CRS
17c0:  00 08 42 55 46 30 11 1b   0a 18 47 01 f2 03 f2 03 	..BUF0....G.....
17d0:  01 04 47 01 f7 03 f7 03   01 01 22 40 00 2a 04 00 	..G......."@.*..
17e0:  79 00 8c 42 55 46 30 0a   02 49 4f 4c 4f 8c 42 55 	y..BUF0..IOLO.BU
17f0:  46 30 0a 03 49 4f 48 49   8c 42 55 46 30 0a 04 49 	F0..IOHI.BUF0..I
1800:  4f 52 4c 8c 42 55 46 30   0a 05 49 4f 52 48 45 4e 	ORL.BUF0..IORHEN
1810:  46 47 45 58 46 47 a4 42   55 46 30 08 5f 50 52 53 	FGEXFG.BUF0._PRS
1820:  11 1d 0a 1a 30 47 01 f2   03 f2 03 01 04 47 01 f7 	....0G.......G..
1830:  03 f7 03 01 01 22 40 00   2a 04 00 38 79 00 14 3a 	....."@.*..8y..:
1840:  5f 53 52 53 01 8c 68 0a   02 49 4f 4c 4f 8c 68 0a 	_SRS..h..IOLO.h.
1850:  03 49 4f 48 49 8b 68 0a   19 49 52 51 4c 8c 68 0a 	.IOHI.h..IRQL.h.
1860:  1c 44 4d 41 56 45 4e 46   47 70 00 4c 44 4e 5f 70 	.DMAVENFGp.LDN_p
1870:  01 41 43 54 52 45 58 46   47 5b 82 4e 19 55 41 52 	.ACTREXFG[.N.UAR
1880:  31 08 5f 48 49 44 0c 41   d0 05 01 08 5f 55 49 44 	1._HID.A...._UID
1890:  0a 01 14 3f 5f 53 54 41   00 45 4e 46 47 70 0a 02 	...?_STA.ENFGp..
18a0:  4c 44 4e 5f a0 0c 41 43   54 52 45 58 46 47 a4 0a 	LDN_..ACTREXFG..
18b0:  0f a1 1c a0 11 91 49 4f   41 48 49 4f 41 4c 45 58 	......IOAHIOALEX
18c0:  46 47 a4 0a 0d a1 08 45   58 46 47 a4 0a 00 45 58 	FG.....EXFG...EX
18d0:  46 47 14 1b 5f 44 49 53   00 45 4e 46 47 70 0a 02 	FG.._DIS.ENFGp..
18e0:  4c 44 4e 5f 70 00 41 43   54 52 45 58 46 47 14 49 	LDN_p.ACTREXFG.I
18f0:  09 5f 43 52 53 00 08 42   55 46 31 11 10 0a 0d 47 	._CRS..BUF1....G
1900:  01 00 00 00 00 00 08 22   00 00 79 00 8c 42 55 46 	......."..y..BUF
1910:  31 0a 02 49 4f 4c 4f 8c   42 55 46 31 0a 03 49 4f 	1..IOLO.BUF1..IO
1920:  48 49 8c 42 55 46 31 0a   04 49 4f 52 4c 8c 42 55 	HI.BUF1..IORL.BU
1930:  46 31 0a 05 49 4f 52 48   8c 42 55 46 31 0a 09 49 	F1..IORH.BUF1..I
1940:  52 51 4c 45 4e 46 47 70   0a 02 4c 44 4e 5f 70 49 	RQLENFGp..LDN_pI
1950:  4f 41 4c 49 4f 4c 4f 70   49 4f 41 4c 49 4f 52 4c 	OALIOLOpIOALIORL
1960:  70 49 4f 41 48 49 4f 48   49 70 49 4f 41 48 49 4f 	pIOAHIOHIpIOAHIO
1970:  52 48 70 01 60 79 60 49   4e 54 52 49 52 51 4c 45 	RHp.`y`INTRIRQLE
1980:  58 46 47 a4 42 55 46 31   08 5f 50 52 53 11 36 0a 	XFG.BUF1._PRS.6.
1990:  33 30 47 01 f8 03 f8 03   00 08 22 10 00 30 47 01 	30G......."..0G.
19a0:  f8 02 f8 02 00 08 22 08   00 30 47 01 e8 03 e8 03 	......"..0G.....
19b0:  00 08 22 10 00 30 47 01   e8 02 e8 02 00 08 22 08 	.."..0G.......".
19c0:  00 38 79 00 14 44 05 5f   53 52 53 01 8c 68 0a 02 	.8y..D._SRS..h..
19d0:  49 4f 4c 4f 8c 68 0a 03   49 4f 48 49 8c 68 0a 09 	IOLO.h..IOHI.h..
19e0:  49 52 51 4c 45 4e 46 47   70 0a 02 4c 44 4e 5f 70 	IRQLENFGp..LDN_p
19f0:  01 41 43 54 52 70 49 4f   4c 4f 49 4f 41 4c 70 49 	.ACTRpIOLOIOALpI
1a00:  4f 48 49 49 4f 41 48 82   49 52 51 4c 60 74 60 0a 	OHIIOAH.IRQL`t`.
1a10:  01 49 4e 54 52 45 58 46   47 5b 82 46 1c 43 4f 4d 	.INTREXFG[.F.COM
1a20:  42 08 5f 48 49 44 0c 41   d0 05 01 08 5f 55 49 44 	B._HID.A...._UID
1a30:  0a 02 14 43 05 5f 53 54   41 00 45 4e 46 47 70 0a 	...C._STA.ENFGp.
1a40:  03 4c 44 4e 5f 7b 4f 50   54 32 0a 38 60 a0 2f 93 	.LDN_{OPT2.8`./.
1a50:  60 0a 00 a0 0c 41 43 54   52 45 58 46 47 a4 0a 0f 	`....ACTREXFG...
1a60:  a1 1c a0 11 91 49 4f 41   48 49 4f 41 4c 45 58 46 	.....IOAHIOALEXF
1a70:  47 a4 0a 0d a1 08 45 58   46 47 a4 0a 00 a1 08 45 	G.....EXFG.....E
1a80:  58 46 47 a4 0a 00 14 29   5f 44 49 53 00 45 4e 46 	XFG....)_DIS.ENF
1a90:  47 70 0a 03 4c 44 4e 5f   7b 4f 50 54 32 0a 38 60 	Gp..LDN_{OPT2.8`
1aa0:  a0 0b 93 60 0a 00 70 00   41 43 54 52 45 58 46 47 	...`..p.ACTREXFG
1ab0:  14 4f 09 5f 43 52 53 00   08 42 55 46 32 11 10 0a 	.O._CRS..BUF2...
1ac0:  0d 47 01 00 00 00 00 00   08 22 10 00 79 00 8c 42 	.G......."..y..B
1ad0:  55 46 32 0a 02 49 4f 4c   4f 8c 42 55 46 32 0a 03 	UF2..IOLO.BUF2..
1ae0:  49 4f 48 49 8c 42 55 46   32 0a 04 49 4f 52 4c 8c 	IOHI.BUF2..IORL.
1af0:  42 55 46 32 0a 05 49 4f   52 48 8c 42 55 46 32 0a 	BUF2..IORH.BUF2.
1b00:  09 49 52 51 4c 45 4e 46   47 70 0a 03 4c 44 4e 5f 	.IRQLENFGp..LDN_
1b10:  70 01 41 43 54 52 70 49   4f 41 4c 49 4f 4c 4f 70 	p.ACTRpIOALIOLOp
1b20:  49 4f 41 4c 49 4f 52 4c   70 49 4f 41 48 49 4f 48 	IOALIORLpIOAHIOH
1b30:  49 70 49 4f 41 48 49 4f   52 48 70 01 60 79 60 49 	IpIOAHIORHp.`y`I
1b40:  4e 54 52 49 52 51 4c 45   58 46 47 a4 42 55 46 32 	NTRIRQLEXFG.BUF2
1b50:  08 5f 50 52 53 11 36 0a   33 30 47 01 f8 03 f8 03 	._PRS.6.30G.....
1b60:  00 08 22 10 00 30 47 01   f8 02 f8 02 00 08 22 08 	.."..0G.......".
1b70:  00 30 47 01 e8 03 e8 03   00 08 22 10 00 30 47 01 	.0G......."..0G.
1b80:  e8 02 e8 02 00 08 22 08   00 38 79 00 14 44 05 5f 	......"..8y..D._
1b90:  53 52 53 01 8c 68 0a 02   49 4f 4c 4f 8c 68 0a 03 	SRS..h..IOLO.h..
1ba0:  49 4f 48 49 8c 68 0a 09   49 52 51 4c 45 4e 46 47 	IOHI.h..IRQLENFG
1bb0:  70 0a 03 4c 44 4e 5f 70   01 41 43 54 52 70 49 4f 	p..LDN_p.ACTRpIO
1bc0:  4c 4f 49 4f 41 4c 70 49   4f 48 49 49 4f 41 48 82 	LOIOALpIOHIIOAH.
1bd0:  49 52 51 4c 60 74 60 0a   01 49 4e 54 52 45 58 46 	IRQL`t`..INTREXF
1be0:  47 5b 82 44 21 49 52 44   41 08 5f 48 49 44 0c 41 	G[.D!IRDA._HID.A
1bf0:  d0 05 10 14 44 05 5f 53   54 41 00 45 4e 46 47 70 	....D._STA.ENFGp
1c00:  0a 03 4c 44 4e 5f 7b 4f   50 54 32 0a 38 60 a0 30 	..LDN_{OPT2.8`.0
1c10:  92 93 60 0a 00 a0 0c 41   43 54 52 45 58 46 47 a4 	..`....ACTREXFG.
1c20:  0a 0f a1 1c a0 11 91 49   4f 41 48 49 4f 41 4c 45 	.......IOAHIOALE
1c30:  58 46 47 a4 0a 0d a1 08   45 58 46 47 a4 0a 00 a1 	XFG.....EXFG....
1c40:  08 45 58 46 47 a4 0a 00   14 2a 5f 44 49 53 00 45 	.EXFG....*_DIS.E
1c50:  4e 46 47 70 0a 03 4c 44   4e 5f 7b 4f 50 54 32 0a 	NFGp..LDN_{OPT2.
1c60:  38 60 a0 0c 92 93 60 0a   00 70 00 41 43 54 52 45 	8`....`..p.ACTRE
1c70:  58 46 47 14 41 0d 5f 43   52 53 00 08 42 55 46 34 	XFG.A._CRS..BUF4
1c80:  11 10 0a 0d 47 01 00 00   00 00 00 08 22 00 00 79 	....G......."..y
1c90:  00 8c 42 55 46 34 0a 02   49 4f 4c 4f 8c 42 55 46 	..BUF4..IOLO.BUF
1ca0:  34 0a 03 49 4f 48 49 8c   42 55 46 34 0a 04 49 4f 	4..IOHI.BUF4..IO
1cb0:  52 4c 8c 42 55 46 34 0a   05 49 4f 52 48 8c 42 55 	RL.BUF4..IORH.BU
1cc0:  46 34 0a 09 49 52 51 4c   8c 42 55 46 34 0a 0a 49 	F4..IRQL.BUF4..I
1cd0:  52 51 48 45 4e 46 47 70   0a 03 4c 44 4e 5f 70 01 	RQHENFGp..LDN_p.
1ce0:  41 43 54 52 70 49 4f 41   4c 49 4f 4c 4f 70 49 4f 	ACTRpIOALIOLOpIO
1cf0:  41 4c 49 4f 52 4c 70 49   4f 41 48 49 4f 48 49 70 	ALIORLpIOAHIOHIp
1d00:  49 4f 41 48 49 4f 52 48   a0 1f 94 49 4e 54 52 0a 	IOAHIORH...INTR.
1d10:  08 70 0a 00 49 52 51 4c   74 49 4e 54 52 0a 08 60 	.p..IRQLtINTR..`
1d20:  79 0a 01 60 49 52 51 48   a1 13 70 0a 00 49 52 51 	y..`IRQH..p..IRQ
1d30:  48 79 0a 01 49 4e 54 52   49 52 51 4c 45 58 46 47 	Hy..INTRIRQLEXFG
1d40:  a4 42 55 46 34 08 5f 50   52 53 11 36 0a 33 30 47 	.BUF4._PRS.6.30G
1d50:  01 f8 03 f8 03 00 08 22   18 0c 30 47 01 f8 02 f8 	......."..0G....
1d60:  02 00 08 22 18 0c 30 47   01 e8 03 e8 03 08 08 22 	..."..0G......."
1d70:  18 0c 30 47 01 e8 02 e8   02 08 08 22 18 0c 38 79 	..0G......."..8y
1d80:  00 14 45 07 5f 53 52 53   01 8c 68 0a 02 49 4f 4c 	..E._SRS..h..IOL
1d90:  4f 8c 68 0a 03 49 4f 48   49 8c 68 0a 09 49 52 51 	O.h..IOHI.h..IRQ
1da0:  4c 8c 68 0a 0a 49 52 51   48 45 4e 46 47 70 0a 03 	L.h..IRQHENFGp..
1db0:  4c 44 4e 5f 70 01 41 43   54 52 70 49 4f 4c 4f 49 	LDN_p.ACTRpIOLOI
1dc0:  4f 41 4c 70 49 4f 48 49   49 4f 41 48 a0 16 93 49 	OALpIOHIIOAH...I
1dd0:  52 51 4c 0a 00 82 49 52   51 48 60 72 60 0a 07 49 	RQL...IRQH`r`..I
1de0:  4e 54 52 a1 0f 82 49 52   51 4c 60 74 60 0a 01 49 	NTR...IRQL`t`..I
1df0:  4e 54 52 45 58 46 47 5b   82 40 1e 4c 50 54 5f 08 	NTREXFG[.-Xm7auJ3V/Hk@public.gmane.org
1e00:  5f 48 49 44 0c 41 d0 04   00 14 44 05 5f 53 54 41 	_HID.A....D._STA
1e10:  00 45 4e 46 47 70 0a 01   4c 44 4e 5f 7b 4f 50 54 	.ENFGp..LDN_{OPT
1e20:  31 0a 02 60 a0 30 92 93   60 0a 02 a0 0c 41 43 54 	1..`.0..`....ACT
1e30:  52 45 58 46 47 a4 0a 0f   a1 1c a0 11 91 49 4f 41 	REXFG........IOA
1e40:  48 49 4f 41 4c 45 58 46   47 a4 0a 0d a1 08 45 58 	HIOALEXFG.....EX
1e50:  46 47 a4 0a 00 a1 08 45   58 46 47 a4 0a 00 14 1b 	FG.....EXFG.....
1e60:  5f 44 49 53 00 45 4e 46   47 70 0a 01 4c 44 4e 5f 	_DIS.ENFGp..LDN_
1e70:  70 00 41 43 54 52 45 58   46 47 14 46 0c 5f 43 52 	p.ACTREXFG.F._CR
1e80:  53 00 08 42 55 46 35 11   10 0a 0d 47 01 00 00 00 	S..BUF5....G....
1e90:  00 00 00 22 00 00 79 00   8c 42 55 46 35 0a 02 49 	..."..y..BUF5..I
1ea0:  4f 4c 4f 8c 42 55 46 35   0a 03 49 4f 48 49 8c 42 	OLO.BUF5..IOHI.B
1eb0:  55 46 35 0a 04 49 4f 52   4c 8c 42 55 46 35 0a 05 	UF5..IORL.BUF5..
1ec0:  49 4f 52 48 8c 42 55 46   35 0a 07 49 4f 4c 45 8c 	IORH.BUF5..IOLE.
1ed0:  42 55 46 35 0a 09 49 52   51 4c 45 4e 46 47 70 0a 	BUF5..IRQLENFGp.
1ee0:  01 4c 44 4e 5f 70 49 4f   41 4c 49 4f 4c 4f 70 49 	.LDN_pIOALIOLOpI
1ef0:  4f 4c 4f 49 4f 52 4c 70   49 4f 41 48 49 4f 48 49 	OLOIORLpIOAHIOHI
1f00:  70 49 4f 48 49 49 4f 52   48 a0 0f 93 49 4f 4c 4f 	pIOHIIORH...IOLO
1f10:  0a bc 70 0a 04 49 4f 4c   45 a1 08 70 0a 08 49 4f 	..p..IOLE..p..IO
1f20:  4c 45 70 01 60 70 49 4e   54 52 65 79 60 65 49 52 	LEp.`pINTRey`eIR
1f30:  51 4c 70 01 41 43 54 52   45 58 46 47 a4 42 55 46 	QLp.ACTREXFG.BUF
1f40:  35 08 5f 50 52 53 11 2a   0a 27 30 47 01 78 03 78 	5._PRS.*.'0G.x.x
1f50:  03 00 08 22 b8 00 30 47   01 78 02 78 02 00 08 22 	..."..0G.x.x..."
1f60:  b8 00 30 47 01 bc 03 bc   03 00 04 22 b8 00 38 79 	..0G......."..8y
1f70:  00 14 47 06 5f 53 52 53   01 8c 68 0a 02 49 4f 4c 	..G._SRS..h..IOL
1f80:  4f 8c 68 0a 03 49 4f 48   49 8c 68 0a 04 49 4f 52 	O.h..IOHI.h..IOR
1f90:  4c 8c 68 0a 05 49 4f 52   48 8c 68 0a 09 49 52 51 	L.h..IORH.h..IRQ
1fa0:  4c 45 4e 46 47 70 0a 01   4c 44 4e 5f 70 01 41 43 	LENFGp..LDN_p.AC
1fb0:  54 52 70 49 4f 4c 4f 49   4f 41 4c 70 49 4f 48 49 	TRpIOLOIOALpIOHI
1fc0:  49 4f 41 48 81 49 52 51   4c 60 74 60 0a 01 60 70 	IOAH.IRQL`t`..`p
1fd0:  60 49 4e 54 52 45 58 46   47 5b 82 4e 25 45 43 50 	`INTREXFG[.N%ECP
1fe0:  5f 08 5f 48 49 44 0c 41   d0 04 01 14 43 05 5f 53 	_._HID.A....C._S
1ff0:  54 41 00 45 4e 46 47 70   0a 01 4c 44 4e 5f 7b 4f 	TA.ENFGp..LDN_{O
2000:  50 54 31 0a 02 60 a0 2f   93 60 0a 02 a0 0c 41 43 	PT1..`./.`....AC
2010:  54 52 45 58 46 47 a4 0a   0f a1 1c a0 11 91 49 4f 	TREXFG........IO
2020:  41 48 49 4f 41 4c 45 58   46 47 a4 0a 0d a1 08 45 	AHIOALEXFG.....E
2030:  58 46 47 a4 0a 00 a1 08   45 58 46 47 a4 0a 00 14 	XFG.....EXFG....
2040:  1b 5f 44 49 53 00 45 4e   46 47 70 0a 01 4c 44 4e 	._DIS.ENFGp..LDN
2050:  5f 70 00 41 43 54 52 45   58 46 47 14 4d 11 5f 43 	_p.ACTREXFG.M._C
2060:  52 53 00 08 42 55 46 36   11 1b 0a 18 47 01 00 00 	RS..BUF6....G...
2070:  00 00 00 04 47 01 00 00   00 00 00 04 22 00 00 2a 	....G......."..*
2080:  00 00 79 00 8c 42 55 46   36 0a 02 49 4f 4c 4f 8c 	..y..BUF6..IOLO.
2090:  42 55 46 36 0a 03 49 4f   48 49 8c 42 55 46 36 0a 	BUF6..IOHI.BUF6.
20a0:  04 49 4f 52 4c 8c 42 55   46 36 0a 05 49 4f 52 48 	.IORL.BUF6..IORH
20b0:  8c 42 55 46 36 0a 0a 49   4f 45 4c 8c 42 55 46 36 	.BUF6..IOEL.BUF6
20c0:  0a 0b 49 4f 45 48 8c 42   55 46 36 0a 0c 49 4f 4d 	..IOEH.BUF6..IOM
20d0:  4c 8c 42 55 46 36 0a 0d   49 4f 4d 48 8c 42 55 46 	L.BUF6..IOMH.BUF
20e0:  36 0a 11 49 52 51 4c 8c   42 55 46 36 0a 14 44 4d 	6..IRQL.BUF6..DM
20f0:  41 43 45 4e 46 47 70 0a   01 4c 44 4e 5f 70 01 41 	ACENFGp..LDN_p.A
2100:  43 54 52 70 49 4f 41 4c   62 70 62 49 4f 4c 4f 70 	CTRpIOALbpbIOLOp
2110:  49 4f 41 48 63 70 63 49   4f 48 49 7d 63 0a 04 63 	IOAHcpcIOHI}c..c
2120:  70 63 49 4f 45 48 70 63   49 4f 4d 48 70 49 4f 4c 	pcIOEHpcIOMHpIOL
2130:  4f 49 4f 52 4c 70 49 4f   4c 4f 49 4f 45 4c 70 49 	OIORLpIOLOIOELpI
2140:  4f 4c 4f 49 4f 4d 4c 70   49 4f 48 49 49 4f 52 48 	OLOIOMLpIOHIIORH
2150:  70 01 60 70 49 4e 54 52   65 79 60 65 49 52 51 4c 	p.`pINTRey`eIRQL
2160:  70 01 60 70 44 4d 43 48   65 79 60 65 44 4d 41 43 	p.`pDMCHey`eDMAC
2170:  45 58 46 47 a4 42 55 46   36 08 5f 50 52 53 11 4c 	EXFG.BUF6._PRS.L
2180:  04 0a 48 30 47 01 78 03   78 03 00 08 47 01 78 07 	..H0G.x.x...G.x.
2190:  78 07 00 04 22 b0 00 2a   0b 00 30 47 01 78 02 78 	x..."..*..0G.x.x
21a0:  02 00 08 47 01 78 06 78   06 00 04 22 b8 00 2a 0b 	...G.x.x..."..*.
21b0:  00 30 47 01 bc 03 bc 03   00 04 47 01 bc 07 bc 07 	.0G.......G.....
21c0:  00 04 22 b0 00 2a 0b 00   38 79 00 14 4d 06 5f 53 	.."..*..8y..M._S
21d0:  52 53 01 8c 68 0a 02 49   4f 4c 4f 8c 68 0a 03 49 	RS..h..IOLO.h..I
21e0:  4f 48 49 8c 68 0a 11 49   52 51 4c 8c 68 0a 14 44 	OHI.h..IRQL.h..D
21f0:  4d 41 43 45 4e 46 47 70   0a 01 4c 44 4e 5f 70 01 	MACENFGp..LDN_p.
2200:  41 43 54 52 70 49 4f 4c   4f 49 4f 41 4c 70 49 4f 	ACTRpIOLOIOALpIO
2210:  48 49 49 4f 41 48 81 49   52 51 4c 60 74 60 0a 01 	HIIOAH.IRQL`t`..
2220:  60 70 60 49 4e 54 52 81   44 4d 41 43 61 74 61 0a 	`p`INTR.DMACata.
2230:  01 44 4d 43 48 45 58 46   47 5b 80 5c 47 52 41 4d 	.DMCHEXFG[.\GRAM
2240:  00 0b 00 04 0b 00 01 5b   81 0f 5c 47 52 41 4d 01 	.......[..\GRAM.
2250:  00 40 08 46 4c 47 30 08   5b 82 47 04 50 53 32 4d 	.-7dtsnethz0c@public.gmane.org[.G.PS2M
2260:  08 5f 48 49 44 0c 41 d0   0f 13 14 1c 5f 53 54 41 	._HID.A....._STA
2270:  00 7b 46 4c 47 30 0a 04   60 a0 08 93 60 0a 04 a4 	.{FLG0..`...`...
2280:  0a 0f a1 04 a4 0a 00 14   19 5f 43 52 53 00 08 42 	........._CRS..B
2290:  55 46 4d 11 08 0a 05 22   00 10 79 00 a4 42 55 46 	UFM...."..y..BUF
22a0:  4d 5b 82 41 07 50 53 32   4b 08 5f 48 49 44 0c 41 	M[.A.PS2K._HID.A
22b0:  d0 03 03 14 27 5f 53 54   41 00 45 4e 46 47 70 0a 	....'_STA.ENFGp.
22c0:  05 4c 44 4e 5f a0 0c 41   43 54 52 45 58 46 47 a4 	.LDN_..ACTREXFG.
22d0:  0a 0f a1 08 45 58 46 47   a4 0a 00 14 38 5f 43 52 	....EXFG....8_CR
22e0:  53 00 08 42 55 46 37 11   18 0a 15 47 01 60 00 60 	S..BUF7....G.`.`
22f0:  00 01 01 47 01 64 00 64   00 01 01 22 02 00 79 00 	...G.d.d..."..y.
2300:  45 4e 46 47 70 0a 05 4c   44 4e 5f 45 58 46 47 a4 	ENFGp..LDN_EXFG.
2310:  42 55 46 37 	BUF7


--------------------------------------------------------------
Table: =1B[20GFACP - (Fixed ACPI Description (FADT))
Signature:=1B[40GFACP
Length:=1B[40G0x00000074
Revision:=1B[40G0x01
Checksum:=1B[40G0xa5
OEMID:=1B[40GMSISYS
OEM Table ID:=1B[40GMS-6163W
OEM Revision:=1B[40G3.00
Creator ID:=1B[40GAWRD
FACS Address:=1B[40G0x0fff0000
DSDT Address:=1B[40G0x0fff30c0
Reserved:=1B[40G****
Preferred PM Profile:=1B[40G0x00
SCI Interrupt:=1B[40G0x0009
SCI Command:=1B[40G0x000000b2
ACPI Enable:=1B[40G0xa1
ACPI Disable:=1B[40G0xa0
S4 BIOS Request:=1B[40G0x00
Processor State Control:=1B[40G0x00
PM1a Event Reg Block:=1B[40G0x00004000
PM1b Event Reg Block:=1B[40G0x00000000
PM1a Control Reg Block:=1B[40G0x00004040
PM1b Control Reg Block:=1B[40G0x00000000
PM2 Control Reg Block:=1B[40G0x00000000
PM Timer Control Reg Block:=1B[40G0x00004008
GPE 0 Block:=1B[40G0x0000400c
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
Duty Width:=1B[40G0x03
Day Alarm:=1B[40G0x0d
Month Alarm:=1B[40G0x00
Century Alarm:=1B[40G0x00
IA/PC Boot Flags:=1B[40G0x0000
Reserved:=1B[40G****
Fixed Feature Flags:=1B[40G0x000000a5
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
Flags:=1B[40G0x00000000

--aVD9QWMuhilNxW9f--

--yVhtmJPUSI46BTXb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/1vfbIonHnh+67jkRAn+ZAJ9IFzym8RuyPLZWa4y2eQxvKYPj1QCgl9O4
LD3OFY4Ts7KOCU6Id3no7hQ=
=vlbT
-----END PGP SIGNATURE-----

--yVhtmJPUSI46BTXb--


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
