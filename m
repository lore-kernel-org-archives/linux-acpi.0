From: "D. S." <silent.bob-zqRNUXuvxA0b1SvskN2V4Q@public.gmane.org>
Subject: RE: acpi-problem with samsung x10 1700
Date: Fri, 19 Dec 2003 18:19:59 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1071854398.2072.111.camel@drnpc01.hell.hellgate.net>
References: <BF1FE1855350A0479097B3A0D2A80EE0CC8933@hdsmsx402.hd.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-hIbk9fTgo4t4OqvX1TQn"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <BF1FE1855350A0479097B3A0D2A80EE0CC8933-N2PTB0HCzHJF3Yvz3xaN/VDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--=-hIbk9fTgo4t4OqvX1TQn
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

ok, here is the output.

i hope you guys can help me out!

regards
dennis


Am Fr, 2003-12-19 um 17.33 schrieb Brown, Len:
> Look in the status method specifically:
> 
> \SB_.ADP1._STA
> \SB_.BAT1._STA
> 
> Also, it is okay to post your acpidmp output to the list so people can
> take a look at it.
> 
> Cheers,
> -Len
> 
> > -----Original Message-----
> > From: D. S. [mailto:silent.bob-zqRNUXuvxA0b1SvskN2V4Q@public.gmane.org] 
> > Sent: Friday, December 19, 2003 11:08 AM
> > To: Brown, Len
> > Subject: RE: [ACPI] acpi-problem with samsung x10 1700
> > 
> > 
> > hi,
> > thanks for the quick answer...
> > 
> > this is what i thought.
> > my problem is, that i don't know where to put that add. return (or
> > change the value to the correct one).
> > in the dsdt (ref to ADP1 and BAT1) file are returns (i.e 
> > return (local0)
> > ).
> > any idea?
> > 
> > regards
> > dennis
> > 
> > Am Fr, 2003-12-19 um 16.43 schrieb Brown, Len:
> > > AML is like C -- if there is no return statement from a 
> > routine (method)
> > > then nothing gets returned.
> > > 
> > > Unfortunately the microsoft implementation of the AML interpreter
> > > behaves as if there is a return statement, and so bugs in AML get
> > > through windows validation.
> > > 
> > > For this to work on the ACPICA AML interpreter, you need to 
> > insert the
> > > missing return statements in the AML -- we don't have a 
> > workaround for
> > > this type of BIOS bug.
> > > 
> > > -Len
> > > 
> > > > -----Original Message-----
> > > > From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org 
> > > > [mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of D. S.
> > > > Sent: Friday, December 19, 2003 10:10 AM
> > > > To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > > > Subject: [ACPI] acpi-problem with samsung x10 1700
> > > > 
> > > > 
> > > > hi folks,
> > > > maybe you folks could help me out.
> > > > i fixed the dsdt.aml so far that iasl compiles without an error.
> > > > so far so good.
> > > > 
> > > > now dmesg gives me the following:
> > > > 
> > > > acpi-1121: error:method execution failed [\SB_.ADP1._STA] (Node
> > > > c1613920), AE_AML_NO_RETURN_VALUE
> > > > acpi-1121: error:method execution failed [\SB_.BAT1._STA] (Node
> > > > c1613a20), AE_AML_NO_RETURN_VALUE
> > > > 
> > > > this means, if i'm correct, that the stats for battery 
> > and ac-adapter
> > > > can't be read.
> > > > i am not sure where to correct this and how.
> > > > 
> > > > so you maybe need some info on the machine/dist.
> > > > samsung x10 xtc1700
> > > > bios 06ye (samsung orginal shipped)
> > > > suse 9.0 (wich is patched already for reading dsdt)
> > > > 
> > > > help would be great!
> > > > 
> > > > regards
> > > > d.
> > > > 
> > > > Some programming languages manage to absorb change, but withstand
> > > > progress. -- Epigrams in Programming, ACM SIGPLAN Sept. 1982
> > > > 
> > > > 
> > > > 
> > > > -------------------------------------------------------
> > > > This SF.net email is sponsored by: IBM Linux Tutorials.
> > > > Become an expert in LINUX or just sharpen your skills.  Sign 
> > > > up for IBM's
> > > > Free Linux Tutorials.  Learn everything from the bash shell 
> > > > to sys admin.
> > > > Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
> > > > _______________________________________________
> > > > Acpi-devel mailing list
> > > > Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > > > https://lists.sourceforge.net/lists/listinfo/acpi-devel
> > > > 
> > One difference between a man and a machine is that a machine is quiet
> > when well oiled.
> > 
> > 
Democracy is the recurrent suspicion that more than half of the people
are right more than half of the time. -- E. B. White

--=-hIbk9fTgo4t4OqvX1TQn
Content-Disposition: attachment; filename=acpidmp.x10
Content-Type: text/plain; name=acpidmp.x10; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

RSDP "SENSX" @ 0x000f7570
  0000: 52 53 44 20 50 54 52 20 b6 53 45 4e 53 58 20 00  RSD PTR .SENSX .
  0010: e6 7e f7 1f                                      .~..

RSDT @ 0x1ff77ee6
  0000: 52 53 44 54 30 00 00 00 01 10 53 45 4e 53 58 20  RSDT0.....SENSX 
  0010: 41 51 55 49 4c 41 20 20 00 00 04 06 53 45 4e 53  AQUILA  ....SENS
  0020: 00 00 00 00 64 bf f7 1f d8 bf f7 1f 16 7f f7 1f  ....d...........

FACP @ 0x1ff7bf64
  0000: 46 41 43 50 74 00 00 00 01 aa 53 45 4e 53 58 20  FACPt.....SENSX 
  0010: 53 45 4e 53 58 31 30 20 00 00 04 06 53 45 4e 53  SENSX10 ....SENS
  0020: 50 00 00 00 c0 cf f7 1f 2b 83 f7 1f 00 00 09 00  P.......+.......
  0030: b2 00 00 00 f0 f1 f2 80 00 10 00 00 00 00 00 00  ................
  0040: 04 10 00 00 00 00 00 00 20 10 00 00 08 10 00 00  ........ .......
  0050: 28 10 00 00 00 00 00 00 04 02 01 04 08 00 00 85  (...............
  0060: 01 00 55 00 00 00 00 00 01 03 0d 00 32 00 00 00  ..U.........2...
  0070: 25 00 00 00                                      %...

DSDT @ 0x1ff7832b
  0000: 44 53 44 54 39 3c 00 00 01 4d 53 45 4e 53 58 20  DSDT9<...MSENSX 
  0010: 41 51 55 49 4c 41 20 20 00 00 04 06 4d 53 46 54  AQUILA  ....MSFT
  0020: 0e 00 00 01 5b 80 50 4f 52 54 01 0a 80 0a 01 5b  ....[.PORT.....[
  0030: 81 0b 50 4f 52 54 01 50 38 30 48 08 5b 80 49 4f  ..PORT.P80H.[.IO
  0040: 5f 54 01 0b 00 08 0a 08 5b 81 0b 49 4f 5f 54 01  _T......[..IO_T.
  0050: 54 52 50 30 08 5b 80 47 50 49 4f 01 0b 80 11 0a  TRP0.[.GPIO.....
  0060: 3c 5b 81 45 0b 47 50 49 4f 01 47 55 30 30 08 47  <[.E.GPIO.GU00.G
  0070: 55 30 31 08 47 55 30 32 08 47 55 30 33 08 47 49  U01.GU02.GU03.GI
  0080: 4f 30 08 47 49 4f 31 08 47 49 4f 32 08 47 49 4f  O0.GIO1.GIO2.GIO
  0090: 33 08 00 20 47 4c 30 30 08 47 4c 30 31 08 47 4c  3.. GL00.GL01.GL
  00a0: 30 32 08 47 4c 30 33 08 00 40 04 47 42 30 30 08  02.GL03..-PiTYS4XTsfg@public.gmane.org
  00b0: 47 42 30 31 08 47 42 30 32 08 47 42 30 33 08 00  GB01.GB02.GB03..
  00c0: 40 08 47 49 56 30 08 47 49 56 31 08 47 49 56 32  @.GIV0.GIV1.GIV2
  00d0: 08 47 49 56 33 08 47 55 30 34 08 47 55 30 35 08  .GIV3.GU04.GU05.
  00e0: 47 55 30 36 08 47 55 30 37 08 47 49 4f 34 08 47  GU06.GU07.GIO4.G
  00f0: 49 4f 35 08 47 49 4f 36 08 47 49 4f 37 08 00 01  IO5.GIO6.GIO7...
  0100: 00 01 43 50 45 4e 01 00 05 47 4c 30 35 08 47 4c  ..CPEN...GL05.GL
  0110: 30 36 08 47 4c 30 37 08 5b 80 4d 4e 56 53 00 0c  06.GL07.[.MNVS..
  0120: 7d cd f7 1f 0a 40 5b 81 44 0b 4d 4e 56 53 10 4f  }....@[.D.MNVS.O
  0130: 53 59 53 10 53 4d 49 46 08 53 43 49 46 08 41 43  SYS.SMIF.SCIF.AC
  0140: 50 53 08 44 42 47 53 08 44 43 4b 53 04 43 44 43  PS.DBGS.DCKS.CDC
  0150: 4b 04 46 50 53 54 08 4c 49 44 53 08 46 50 45 4e  K.FPST.LIDS.FPEN
  0160: 08 00 08 00 28 43 4d 41 50 08 43 4d 42 50 08 4c  ....(CMAP.CMBP.L
  0170: 50 54 50 08 46 44 43 50 08 00 20 41 43 54 54 08  PTP.FDCP.. ACTT.
  0180: 50 53 56 54 08 54 43 31 56 08 54 43 32 56 08 54  PSVT.TC1V.TC2V.T
  0190: 53 50 56 08 43 52 54 54 08 00 10 42 56 41 4c 20  SPV.CRTT...BVAL 
  01a0: 54 4d 50 30 08 54 4d 50 31 08 54 4d 50 32 08 43  TMP0.TMP1.TMP2.C
  01b0: 50 57 52 08 54 4d 50 34 20 54 4d 50 35 20 56 46  PWR.TMP4 TMP5 VF
  01c0: 55 4e 10 43 53 54 45 10 4e 53 54 45 10 53 53 54  UN.CSTE.NSTE.SST
  01d0: 45 10 43 41 44 4c 10 50 41 44 4c 10 5b 80 49 44  E.CADL.PADL.[.ID
  01e0: 45 30 01 0b f0 01 0a 08 5b 81 2e 49 44 45 30 01  E0......[..IDE0.
  01f0: 49 31 46 30 08 49 31 46 31 08 49 31 46 32 08 49  I1F0.I1F1.I1F2.I
  0200: 31 46 33 08 49 31 46 34 08 49 31 46 35 08 49 31  1F3.I1F4.I1F5.I1
  0210: 46 36 08 49 31 46 37 08 5b 81 0b 49 44 45 30 02  F6.I1F7.[..IDE0.
  0220: 57 31 46 30 10 5b 80 4e 56 31 5f 01 0a 72 0a 02  W1F0.[.NV1_..r..
  0230: 5b 81 10 4e 56 31 5f 01 4e 31 49 5f 08 4e 31 44  [..NV1_.N1I_.N1D
  0240: 5f 08 5b 01 4d 55 54 58 00 08 5f 53 30 5f 12 08  _.[.MUTX.._S0_..
  0250: 03 0a 00 0a 00 0a 00 08 5f 53 33 5f 12 08 03 0a  ........_S3_....
  0260: 05 0a 05 0a 00 08 5f 53 34 5f 12 08 03 0a 06 0a  ......_S4_......
  0270: 06 0a 00 08 5f 53 35 5f 12 08 03 0a 07 0a 07 0a  ...._S5_........
  0280: 00 10 4a 15 5c 5f 50 52 5f 5b 83 41 15 43 50 55  ..J.\_PR_[.A.CPU
  0290: 30 00 10 10 00 00 06 14 44 14 5f 43 53 54 00 a0  0.......D._CST..
  02a0: 49 06 41 43 50 53 a4 12 41 06 04 0a 03 12 1e 04  I.ACPS..A.......
  02b0: 11 14 0a 11 82 0c 00 7f 08 00 00 00 00 00 00 00  ................
  02c0: 00 00 00 79 00 0a 01 0a 01 0b e8 03 12 1e 04 11  ...y............
  02d0: 14 0a 11 82 0c 00 01 08 00 00 14 10 00 00 00 00  ................
  02e0: 00 00 79 00 0a 02 0a 01 0b f4 01 12 1d 04 11 14  ..y.............
  02f0: 0a 11 82 0c 00 01 08 00 00 15 10 00 00 00 00 00  ................
  0300: 00 79 00 0a 03 0a 55 0a fa a1 42 0d a0 47 08 43  .y....U...B..G.C
  0310: 50 57 52 a4 12 4f 07 05 0a 04 12 1e 04 11 14 0a  PWR..O..........
  0320: 11 82 0c 00 7f 08 00 00 00 00 00 00 00 00 00 00  ................
  0330: 79 00 0a 01 0a 01 0b e8 03 12 1e 04 11 14 0a 11  y...............
  0340: 82 0c 00 01 08 00 00 14 10 00 00 00 00 00 00 79  ...............y
  0350: 00 0a 02 0a 01 0b f4 01 12 1d 04 11 14 0a 11 82  ................
  0360: 0c 00 01 08 00 00 15 10 00 00 00 00 00 00 79 00  ..............y.
  0370: 0a 03 0a 55 0a fa 12 1d 04 11 14 0a 11 82 0c 00  ...U............
  0380: 01 08 00 00 16 10 00 00 00 00 00 00 79 00 0a 03  ............y...
  0390: 0a b9 0a 64 a1 47 04 a4 12 43 04 03 0a 02 12 1e  ...d.G...C......
  03a0: 04 11 14 0a 11 82 0c 00 7f 08 00 00 00 00 00 00  ................
  03b0: 00 00 00 00 79 00 0a 01 0a 01 0b e8 03 12 1e 04  ....y...........
  03c0: 11 14 0a 11 82 0c 00 01 08 00 00 14 10 00 00 00  ................
  03d0: 00 00 00 79 00 0a 02 0a 01 0b f4 01 08 5c 47 50  ...y.........\GP
  03e0: 49 43 0a 00 08 5c 43 54 59 50 0a 00 08 5c 45 43  IC...\CTYP...\EC
  03f0: 4f 4e 0a 00 08 5c 44 53 45 4e 0a 00 08 5c 45 4e  ON...\DSEN...\EN
  0400: 55 4d 0a 01 08 5c 4c 46 43 41 0a 00 08 5c 52 45  UM...\LFCA...\RE
  0410: 43 41 0a 00 14 0d 5c 5f 50 49 43 01 70 68 47 50  CA....\_PIC.phGP
  0420: 49 43 14 0c 5f 50 54 53 01 70 68 50 38 30 48 14  IC.._PTS.phP80H.
  0430: 4b 07 5f 57 41 4b 01 70 5c 2f 05 5f 53 42 5f 50  K._WAK.p\/._SB_P
  0440: 43 49 30 4c 50 43 42 48 5f 45 43 41 43 45 58 5c  CI0LPCBH_ECACEX\
  0450: 41 43 50 53 a0 12 5c 41 43 50 53 5c 2e 5f 53 42  ACPS..\ACPS\._SB
  0460: 5f 50 48 53 5f 0a 95 a1 0d 5c 2e 5f 53 42 5f 50  _PHS_....\._SB_P
  0470: 48 53 5f 0a 94 a0 28 93 68 0a 03 5c 2e 5f 53 42  HS_...(.h..\._SB
  0480: 5f 50 48 53 5f 0a 8a a0 16 93 4f 53 59 53 0b ce  _PHS_.....OSYS..
  0490: 07 86 5c 2e 5f 53 42 5f 50 57 52 42 0a 02 86 5c  ..\._SB_PWRB...\
  04a0: 2e 5f 50 52 5f 43 50 55 30 0a 81 10 4c 0d 5c 5f  ._PR_CPU0...L.\_
  04b0: 47 50 45 14 25 5f 4c 30 35 00 86 5c 2f 03 5f 53  GPE.%_L05..\/._S
  04c0: 42 5f 50 43 49 30 4d 4f 44 4d 0a 02 86 5c 2e 5f  B_PCI0MODM...\._
  04d0: 53 42 5f 50 57 52 42 0a 02 14 4a 05 5f 4c 30 42  SB_PWRB...J._L0B
  04e0: 00 86 5c 2f 03 5f 53 42 5f 50 43 49 30 50 43 49  ..\/._SB_PCI0PCI
  04f0: 42 0a 02 86 5c 2e 5f 53 42 5f 50 57 52 42 0a 02  B...\._SB_PWRB..
  0500: 70 0a 01 5c 2f 05 5f 53 42 5f 50 43 49 30 50 43  p..\/._SB_PCI0PC
  0510: 49 42 43 44 42 30 50 4d 45 53 70 0a 01 5c 2f 05  IBCDB0PMESp..\/.
  0520: 5f 53 42 5f 50 43 49 30 50 43 49 42 43 44 42 31  _SB_PCI0PCIBCDB1
  0530: 50 4d 45 53 14 43 05 5f 4c 31 44 00 70 5c 2e 5f  PMES.C._L1D.p\._
  0540: 53 42 5f 50 48 53 31 0a 8e 0a 00 60 a0 12 93 60  SB_PHS1....`...`
  0550: 0a 01 86 5c 2e 5f 53 42 5f 50 57 52 42 0a 02 a0  ...\._SB_PWRB...
  0560: 12 93 60 0a 02 86 5c 2e 5f 53 42 5f 50 57 52 42  ..`...\._SB_PWRB
  0570: 0a 02 a0 15 93 4f 53 59 53 0b ce 07 5c 2e 5f 53  .....OSYS...\._S
  0580: 42 5f 50 48 53 5f 0a 93 10 45 0e 5c 5f 54 5a 5f  B_PHS_...E.\_TZ_
  0590: 5b 85 4c 0d 54 48 52 4d 14 42 04 5f 54 4d 50 00  [.L.THRM.B._TMP.
  05a0: a0 36 93 5c 45 43 4f 4e 0a 01 70 5c 2f 05 5f 53  .6.\ECON..p\/._S
  05b0: 42 5f 50 43 49 30 4c 50 43 42 48 5f 45 43 43 54  B_PCI0LPCBH_ECCT
  05c0: 4d 50 60 a0 13 92 93 60 0a ff 77 60 0a 0a 60 72  MP`....`..w`..`r
  05d0: 60 0b ac 0a 60 a4 60 a4 0b 1c 0c 14 17 5f 41 43  `...`.`......_AC
  05e0: 30 00 70 0a 41 60 77 60 0a 0a 60 72 60 0b ac 0a  0.p.A`w`..`r`...
  05f0: 60 a4 60 08 5f 41 4c 30 12 06 01 46 41 4e 30 14  `.`._AL0...FAN0.
  0600: 17 58 50 53 56 00 70 0a 78 60 77 60 0a 0a 60 72  .XPSV.p.x`w`..`r
  0610: 60 0b ac 0a 60 a4 60 08 58 50 53 4c 12 0c 01 5c  `...`.`.XPSL...\
  0620: 2e 5f 50 52 5f 43 50 55 30 14 17 5f 43 52 54 00  ._PR_CPU0.._CRT.
  0630: 70 0a 78 60 77 60 0a 0a 60 72 60 0b ac 0a 60 a4  p.x`w`..`r`...`.
  0640: 60 14 16 5f 53 43 50 01 70 0d 4e 6f 74 20 53 75  `.._SCP.p.Not Su
  0650: 70 70 6f 72 74 00 5b 31 08 5f 54 43 31 0a 04 08  pport.[1._TC1...
  0660: 5f 54 43 32 0a 03 08 5f 54 53 50 0b 2c 01 5b 84  _TC2..._TSP.,.[.
  0670: 30 50 46 41 4e 00 00 00 14 0b 5f 53 54 41 00 a4  0PFAN....._STA..
  0680: 46 41 4e 45 14 0d 5f 4f 4e 5f 00 70 0a 01 46 41  FANE.._ON_.p..FA
  0690: 4e 45 14 0d 5f 4f 46 46 00 70 0a 00 46 41 4e 45  NE.._OFF.p..FANE
  06a0: 08 46 41 4e 45 0a 01 5b 82 1b 46 41 4e 30 08 5f  .FANE..[..FAN0._
  06b0: 48 49 44 0c 41 d0 0c 0b 08 5f 50 52 30 12 06 01  HID.A...._PR0...
  06c0: 50 46 41 4e 10 84 57 03 5c 5f 53 42 5f 5b 82 4f  PFAN..W.\_SB_[.O
  06d0: 09 41 44 50 31 08 5f 48 49 44 0d 41 43 50 49 30  .ADP1._HID.ACPI0
  06e0: 30 30 33 00 14 3d 5f 50 53 52 00 a0 19 93 5c 45  003..=_PSR....\E
  06f0: 43 4f 4e 0a 00 70 5c 2e 5f 53 42 5f 50 48 53 31  CON..p\._SB_PHS1
  0700: 0a 81 0a 02 60 a1 1a 70 5c 2f 05 5f 53 42 5f 50  ....`..p\/._SB_P
  0710: 43 49 30 4c 50 43 42 48 5f 45 43 41 43 45 58 60  CI0LPCBH_ECACEX`
  0720: a4 60 14 0c 5f 50 43 4c 00 a4 5c 5f 53 42 5f 14  .`.._PCL..\_SB_.
  0730: 3e 5f 53 54 41 00 a0 0d 93 5c 45 43 4f 4e 0a 00  >_STA....\ECON..
  0740: 70 0a 0f 60 a1 27 a0 1f 93 5c 2f 05 5f 53 42 5f  p..`.'...\/._SB_
  0750: 50 43 49 30 4c 50 43 42 48 5f 45 43 41 43 45 58  PCI0LPCBH_ECACEX
  0760: 0a 00 70 0a 1f 60 a1 05 70 0a 0f 60 a4 60 5b 82  ..p..`..p..`.`[.
  0770: 4f 57 42 41 54 31 08 5f 48 49 44 0c 41 d0 0c 0a  OWBAT1._HID.A...
  0780: 08 5f 55 49 44 0a 01 08 42 41 54 49 12 42 04 0d  ._UID...BATI.B..
  0790: 0a 01 0c ff ff ff ff 0c ff ff ff ff 0a 01 0c ff  ................
  07a0: ff ff ff 0a 03 0a 0a 0a 01 0a 01 0d 55 6e 6b 6e  ............Unkn
  07b0: 6f 77 6e 00 0d 55 6e 6b 6e 6f 77 6e 00 0d 55 6e  own..Unknown..Un
  07c0: 6b 6e 6f 77 6e 00 0d 55 6e 6b 6e 6f 77 6e 00 14  known..Unknown..
  07d0: 4f 26 5f 42 49 46 00 a0 4d 0d 93 5c 45 43 4f 4e  O&_BIF..M..\ECON
  07e0: 0a 00 70 5c 2e 5f 53 42 5f 50 48 53 32 0a 8c 0a  ..p\._SB_PHS2...
  07f0: b0 0a 00 60 a0 14 93 60 0b ff ff 70 0c ff ff ff  ...`...`...p....
  0800: ff 88 42 41 54 49 0a 01 00 a1 0b 70 60 88 42 41  ..BATI.....p`.BA
  0810: 54 49 0a 01 00 70 5c 2e 5f 53 42 5f 50 48 53 32  TI...p\._SB_PHS2
  0820: 0a 8c 0a b2 0a 00 60 a0 14 93 60 0b ff ff 70 0c  ......`...`...p.
  0830: ff ff ff ff 88 42 41 54 49 0a 02 00 a1 0b 70 60  .....BATI.....p`
  0840: 88 42 41 54 49 0a 02 00 70 5c 2e 5f 53 42 5f 50  .BATI...p\._SB_P
  0850: 48 53 32 0a 8c 0a b4 0a 00 60 a0 14 93 60 0b ff  HS2......`...`..
  0860: ff 70 0c ff ff ff ff 88 42 41 54 49 0a 04 00 a1  .p......BATI....
  0870: 0b 70 60 88 42 41 54 49 0a 04 00 70 0a 00 88 42  .p`.BATI...p...B
  0880: 41 54 49 0a 05 00 70 5c 2e 5f 53 42 5f 50 48 53  ATI...p\._SB_PHS
  0890: 32 0a 8c 0a b6 0a 00 60 a0 10 93 60 0b ff ff 70  2......`...`...p
  08a0: 00 88 42 41 54 49 0a 06 00 a1 0b 70 60 88 42 41  ..BATI.....p`.BA
  08b0: 54 49 0a 06 00 a1 41 14 70 5c 2f 05 5f 53 42 5f  TI....A.p\/._SB_
  08c0: 50 43 49 30 4c 50 43 42 48 5f 45 43 42 31 41 46  PCI0LPCBH_ECB1AF
  08d0: 63 70 5c 2f 05 5f 53 42 5f 50 43 49 30 4c 50 43  cp\/._SB_PCI0LPC
  08e0: 42 48 5f 45 43 42 31 56 4c 64 70 63 60 7b 60 0b  BH_ECB1VLdpc`{`.
  08f0: ff ff 60 79 60 0a 08 61 7b 61 0b 00 ff 61 7a 60  ..`y`..a{a...az`
  0900: 0a 08 60 7d 60 61 60 a0 14 93 60 0b ff ff 70 0c  ..`}`a`...`...p.
  0910: ff ff ff ff 88 42 41 54 49 0a 01 00 a1 0b 70 60  .....BATI.....p`
  0920: 88 42 41 54 49 0a 01 00 70 63 60 7a 60 0a 10 60  .BATI...pc`z`..`
  0930: 7b 60 0b ff ff 60 79 60 0a 08 61 7b 61 0b 00 ff  {`...`y`..a{a...
  0940: 61 7a 60 0a 08 60 7d 60 61 60 a0 14 93 60 0b ff  az`..`}`a`...`..
  0950: ff 70 0c ff ff ff ff 88 42 41 54 49 0a 02 00 a1  .p......BATI....
  0960: 0b 70 60 88 42 41 54 49 0a 02 00 70 64 60 7b 60  .p`.BATI...pd`{`
  0970: 0b ff ff 60 79 60 0a 08 61 7b 61 0b 00 ff 61 7a  ...`y`..a{a...az
  0980: 60 0a 08 60 7d 60 61 60 a0 14 93 60 0b ff ff 70  `..`}`a`...`...p
  0990: 0c ff ff ff ff 88 42 41 54 49 0a 04 00 a1 0b 70  ......BATI.....p
  09a0: 60 88 42 41 54 49 0a 04 00 70 0a 00 88 42 41 54  `.BATI...p...BAT
  09b0: 49 0a 05 00 70 64 60 7a 60 0a 10 60 7b 60 0b ff  I...pd`z`..`{`..
  09c0: ff 60 79 60 0a 08 61 7b 61 0b 00 ff 61 7a 60 0a  .`y`..a{a...az`.
  09d0: 08 60 7d 60 61 60 a0 14 93 60 0b ff ff 70 0c ff  .`}`a`...`...p..
  09e0: ff ff ff 88 42 41 54 49 0a 06 00 a1 0b 70 60 88  ....BATI.....p`.
  09f0: 42 41 54 49 0a 06 00 70 0d 00 88 42 41 54 49 0a  BATI...p...BATI.
  0a00: 09 00 70 0d 00 88 42 41 54 49 0a 0a 00 70 0d 4c  ..p...BATI...p.L
  0a10: 49 4f 4e 00 88 42 41 54 49 0a 0b 00 70 0d 53 41  ION..BATI...p.SA
  0a20: 4d 53 55 4e 47 20 45 6c 65 63 74 72 6f 6e 69 63  MSUNG Electronic
  0a30: 73 00 88 42 41 54 49 0a 0c 00 a4 42 41 54 49 08  s..BATI....BATI.
  0a40: 53 54 41 54 12 0a 04 0a 00 0a 00 0a 00 0a 00 14  STAT............
  0a50: 49 23 5f 42 53 54 00 a0 40 0f 93 5c 45 43 4f 4e  I#_BST..-rVxdn2TrCWA@public.gmane.org\ECON
  0a60: 0a 00 70 5c 2e 5f 53 42 5f 50 48 53 32 0a 8b 0a  ..p\._SB_PHS2...
  0a70: 84 0a 00 60 a0 20 90 92 93 60 0a 00 92 93 60 0a  ...`. ...`....`.
  0a80: 05 a0 0d 93 5c 41 43 50 53 0a 01 70 0a 02 60 a1  ....\ACPS..p..`.
  0a90: 05 70 0a 01 60 70 60 88 53 54 41 54 0a 00 00 70  .p..`p`.STAT...p
  0aa0: 5c 2e 5f 53 42 5f 50 48 53 32 0a 8c 0a a4 0a 00  \._SB_PHS2......
  0ab0: 60 a0 14 93 60 0b ff ff 70 0c ff ff ff ff 88 53  `...`...p......S
  0ac0: 54 41 54 0a 01 00 a1 1b a0 0f 92 95 60 0b 00 80  TAT.........`...
  0ad0: 7f 60 0b ff ff 60 75 60 70 60 88 53 54 41 54 0a  .`...`u`p`.STAT.
  0ae0: 01 00 70 5c 2e 5f 53 42 5f 50 48 53 32 0a 8c 0a  ..p\._SB_PHS2...
  0af0: a2 0a 00 60 a0 14 93 60 0b ff ff 70 0c ff ff ff  ...`...`...p....
  0b00: ff 88 53 54 41 54 0a 02 00 a1 0b 70 60 88 53 54  ..STAT.....p`.ST
  0b10: 41 54 0a 02 00 70 5c 2e 5f 53 42 5f 50 48 53 32  AT...p\._SB_PHS2
  0b20: 0a 8c 0a a6 0a 00 60 a0 14 93 60 0b ff ff 70 0c  ......`...`...p.
  0b30: ff ff ff ff 88 53 54 41 54 0a 03 00 a1 0b 70 60  .....STAT.....p`
  0b40: 88 53 54 41 54 0a 03 00 a1 4b 13 70 5c 2f 05 5f  .STAT....K.p\/._
  0b50: 53 42 5f 50 43 49 30 4c 50 43 42 48 5f 45 43 42  SB_PCI0LPCBH_ECB
  0b60: 31 52 52 63 70 5c 2f 05 5f 53 42 5f 50 43 49 30  1RRcp\/._SB_PCI0
  0b70: 4c 50 43 42 48 5f 45 43 42 31 50 56 64 70 63 60  LPCBH_ECB1PVdpc`
  0b80: 7b 60 0a ff 60 a0 20 90 92 93 60 0a 00 92 93 60  {`..`. ...`....`
  0b90: 0a 05 a0 0d 93 5c 41 43 50 53 0a 01 70 0a 02 60  .....\ACPS..p..`
  0ba0: a1 05 70 0a 01 60 70 60 88 53 54 41 54 0a 00 00  ..p..`p`.STAT...
  0bb0: 70 64 60 7b 60 0b ff ff 60 79 60 0a 08 61 7b 61  pd`{`...`y`..a{a
  0bc0: 0b 00 ff 61 7a 60 0a 08 60 7d 60 61 60 a0 14 93  ...az`..`}`a`...
  0bd0: 60 0b ff ff 70 0c ff ff ff ff 88 53 54 41 54 0a  `...p......STAT.
  0be0: 01 00 a1 1b a0 0f 92 95 60 0b 00 80 7f 60 0b ff  ........`....`..
  0bf0: ff 60 75 60 70 60 88 53 54 41 54 0a 01 00 70 63  .`u`p`.STAT...pc
  0c00: 60 7a 60 0a 10 60 7b 60 0b ff ff 60 79 60 0a 08  `z`..`{`...`y`..
  0c10: 61 7b 61 0b 00 ff 61 7a 60 0a 08 60 7d 60 61 60  a{a...az`..`}`a`
  0c20: a0 14 93 60 0b ff ff 70 0c ff ff ff ff 88 53 54  ...`...p......ST
  0c30: 41 54 0a 02 00 a1 0b 70 60 88 53 54 41 54 0a 02  AT.....p`.STAT..
  0c40: 00 70 64 60 7a 60 0a 10 60 7b 60 0b ff ff 60 79  .pd`z`..`{`...`y
  0c50: 60 0a 08 61 7b 61 0b 00 ff 61 7a 60 0a 08 60 7d  `..a{a...az`..`}
  0c60: 60 61 60 a0 14 93 60 0b ff ff 70 0c ff ff ff ff  `a`...`...p.....
  0c70: 88 53 54 41 54 0a 03 00 a1 0b 70 60 88 53 54 41  .STAT.....p`.STA
  0c80: 54 0a 03 00 a4 53 54 41 54 14 48 05 5f 53 54 41  T....STAT.H._STA
  0c90: 00 a0 26 93 5c 45 43 4f 4e 0a 00 a0 16 93 5c 2e  ..&.\ECON.....\.
  0ca0: 5f 53 42 5f 50 48 53 31 0a 81 0a 00 0a 01 70 0a  _SB_PHS1......p.
  0cb0: 1f 60 a1 05 70 0a 0f 60 a1 27 a0 1f 93 5c 2f 05  .`..p..`.'...\/.
  0cc0: 5f 53 42 5f 50 43 49 30 4c 50 43 42 48 5f 45 43  _SB_PCI0LPCBH_EC
  0cd0: 42 31 45 58 0a 01 70 0a 1f 60 a1 05 70 0a 0f 60  B1EX..p..`..p..`
  0ce0: a4 60 14 0c 5f 50 43 4c 00 a4 5c 5f 53 42 5f 5b  .`.._PCL..\_SB_[
  0cf0: 80 50 48 53 44 00 0c bd cd f7 1f 0c 90 01 00 00  .PHSD...........
  0d00: 5b 81 18 50 48 53 44 00 42 43 4d 44 08 44 49 44  [..PHSD.BCMD.DID
  0d10: 5f 20 49 4e 46 4f 40 c5 00 08 5b 81 1c 50 48 53  _ INFO-47IYjYMXMt4@public.gmane.org[..PHS
  0d20: 44 00 00 28 49 4e 46 5f 08 49 4e 46 31 08 49 4e  D..(INF_.INF1.IN
  0d30: 46 32 08 49 4e 46 33 08 5b 81 0d 50 48 53 44 00  F2.INF3.[..PHSD.
  0d40: 00 28 49 4e 46 57 10 5b 81 0d 50 48 53 44 00 00  .(INFW.[..PHSD..
  0d50: 28 49 4e 46 44 20 5b 80 50 48 53 49 01 0c 00 fe  (INFD [.PHSI....
  0d60: 00 00 0c 02 00 00 00 5b 81 0b 50 48 53 49 00 53  .......[..PHSI.S
  0d70: 4d 49 43 08 5b 01 4d 50 48 53 00 14 2f 50 48 53  MIC.[.MPHS../PHS
  0d80: 5f 09 5b 23 4d 50 48 53 ff ff 70 68 42 43 4d 44  _.[#MPHS..phBCMD
  0d90: 70 00 53 4d 49 43 70 0a 00 42 43 4d 44 70 49 4e  p.SMICp..BCMDpIN
  0da0: 46 5f 67 5b 27 4d 50 48 53 a4 67 14 2f 50 48 53  F_g['MPHS.g./PHS
  0db0: 52 09 5b 23 4d 50 48 53 ff ff 70 68 42 43 4d 44  R.[#MPHS..phBCMD
  0dc0: 70 00 53 4d 49 43 70 0a 00 42 43 4d 44 70 49 4e  p.SMICp..BCMDpIN
  0dd0: 46 44 67 5b 27 4d 50 48 53 a4 67 14 35 50 48 53  FDg['MPHS.g.5PHS
  0de0: 31 0a 5b 23 4d 50 48 53 ff ff 70 68 42 43 4d 44  1.[#MPHS..phBCMD
  0df0: 70 69 49 4e 46 5f 70 00 53 4d 49 43 70 0a 00 42  piINF_p.SMICp..B
  0e00: 43 4d 44 70 49 4e 46 5f 67 5b 27 4d 50 48 53 a4  CMDpINF_g['MPHS.
  0e10: 67 14 3b 50 48 53 32 0b 5b 23 4d 50 48 53 ff ff  g.;PHS2.[#MPHS..
  0e20: 70 68 42 43 4d 44 70 69 49 4e 46 5f 70 6a 49 4e  phBCMDpiINF_pjIN
  0e30: 46 31 70 00 53 4d 49 43 70 0a 00 42 43 4d 44 70  F1p.SMICp..BCMDp
  0e40: 49 4e 46 57 67 5b 27 4d 50 48 53 a4 67 14 48 04  INFWg['MPHS.g.H.
  0e50: 50 48 53 34 0d 5b 23 4d 50 48 53 ff ff 70 68 42  PHS4.[#MPHS..phB
  0e60: 43 4d 44 70 69 49 4e 46 5f 70 6a 49 4e 46 31 70  CMDpiINF_pjINF1p
  0e70: 6b 49 4e 46 32 70 6c 49 4e 46 33 70 00 53 4d 49  kINF2plINF3p.SMI
  0e80: 43 70 0a 00 42 43 4d 44 70 49 4e 46 44 67 5b 27  Cp..BCMDpINFDg['
  0e90: 4d 50 48 53 a4 67 5b 82 4a 04 4c 49 44 30 08 5f  MPHS.g[.J.LID0._
  0ea0: 48 49 44 0c 41 d0 0c 0d 14 09 5f 53 54 41 00 a4  HID.A....._STA..
  0eb0: 0a 0f 14 2f 5f 4c 49 44 00 a0 25 5c 45 43 4f 4e  .../_LID..%\ECON
  0ec0: a0 1e 93 5c 2f 05 5f 53 42 5f 50 43 49 30 4c 50  ...\/._SB_PCI0LP
  0ed0: 43 42 48 5f 45 43 4c 49 44 53 0a 01 a4 0a 01 a4  CBH_ECLIDS......
  0ee0: 0a 00 5b 82 19 53 4c 50 42 08 5f 48 49 44 0c 41  ..[..SLPB._HID.A
  0ef0: d0 0c 0e 14 09 5f 53 54 41 00 a4 0a 0f 5b 82 1b  ....._STA....[..
  0f00: 50 57 52 42 08 5f 48 49 44 0c 41 d0 0c 0c 08 5f  PWRB._HID.A...._
  0f10: 50 52 57 12 06 02 0a 1d 0a 04 5b 82 8d d1 02 50  PRW.......[....P
  0f20: 43 49 30 14 4f 0b 5f 49 4e 49 00 70 0a aa 50 38  CI0.O._INI.p..P8
  0f30: 30 48 70 5c 2e 5f 53 42 5f 50 48 53 31 0a 81 0a  0Hp\._SB_PHS1...
  0f40: 02 60 a0 12 92 93 60 0a 01 5c 2e 5f 53 42 5f 50  .`....`..\._SB_P
  0f50: 48 53 5f 0a 94 a0 1d 5b 12 5c 5f 4f 53 49 60 70  HS_....[.\_OSI`p
  0f60: 0b d1 07 4f 53 59 53 5c 2e 5f 53 42 5f 50 48 53  ...OSYS\._SB_PHS
  0f70: 5f 0a 88 a1 4d 05 a0 24 93 87 5f 4f 53 5f 0a 14  _...M..$.._OS_..
  0f80: 70 0b d0 07 4f 53 59 53 70 0a a7 50 38 30 48 5c  p...OSYSp..P80H\
  0f90: 2e 5f 53 42 5f 50 48 53 5f 0a 87 a1 35 a0 1d 93  ._SB_PHS_...5...
  0fa0: 87 5f 4f 53 5f 0a 27 70 0b cf 07 4f 53 59 53 5c  ._OS_.'p...OSYS\
  0fb0: 2e 5f 53 42 5f 50 48 53 5f 0a 86 a1 15 70 0b ce  ._SB_PHS_....p..
  0fc0: 07 4f 53 59 53 5c 2e 5f 53 42 5f 50 48 53 5f 0a  .OSYS\._SB_PHS_.
  0fd0: 85 a0 11 92 94 4f 53 59 53 0b cf 07 70 0a 01 45  .....OSYS...p..E
  0fe0: 43 4f 4e 14 09 5f 53 31 44 00 a4 0a 02 14 09 5f  CON.._S1D......_
  0ff0: 53 33 44 00 a4 0a 02 14 09 5f 53 34 44 00 a4 0a  S3D......_S4D...
  1000: 02 08 5f 48 49 44 0c 41 d0 0a 03 08 5f 41 44 52  .._HID.A...._ADR
  1010: 0a 00 08 5f 42 42 4e 0a 00 5b 80 48 42 55 53 02  ..._BBN..[.HBUS.
  1020: 0a 40 0a c0 5b 81 43 08 48 42 55 53 03 00 40 10  .-rVxdn2TrCWA@public.gmane.org[.C.HBUS..@.
  1030: 44 52 42 30 08 44 52 42 31 08 44 52 42 32 08 44  DRB0.DRB1.DRB2.D
  1040: 52 42 33 08 00 40 16 00 04 50 4d 30 48 02 00 02  RB3..-QlU/4NrZwoCtXF2fZOsJYA@public.gmane.org
  1050: 50 4d 31 4c 02 00 02 50 4d 31 48 02 00 02 50 4d  PM1L...PM1H...PM
  1060: 32 4c 02 00 02 50 4d 32 48 02 00 02 50 4d 33 4c  2L...PM2H...PM3L
  1070: 02 00 02 50 4d 33 48 02 00 02 50 4d 34 4c 02 00  ...PM3H...PM4L..
  1080: 02 50 4d 34 48 02 00 02 50 4d 35 4c 02 00 02 50  .PM4H...PM5L...P
  1090: 4d 35 48 02 00 02 50 4d 36 4c 02 00 02 50 4d 36  M5H...PM6L...PM6
  10a0: 48 02 00 02 46 44 48 43 08 08 42 55 46 30 11 46  H...FDHC..BUF0.F
  10b0: 20 0b 01 02 88 0e 00 02 0c 00 00 00 00 00 ff 00   ...............
  10c0: 00 00 00 01 00 87 18 00 01 0c 03 00 00 00 00 00  ................
  10d0: 00 00 00 f7 0c 00 00 00 00 00 00 f8 0c 00 00 00  ................
  10e0: 47 01 f8 0c f8 0c 01 08 87 18 00 01 0c 03 00 00  G...............
  10f0: 00 00 00 0d 00 00 ff ff 00 00 00 00 00 00 00 f3  ................
  1100: 00 00 00 87 18 00 00 0c 03 00 00 00 00 00 00 0a  ................
  1110: 00 ff ff 0b 00 00 00 00 00 00 00 02 00 00 87 18  ................
  1120: 00 00 0c 03 00 00 00 00 00 00 0c 00 ff 3f 0c 00  .............?..
  1130: 00 00 00 00 00 40 00 00 00 87 18 00 00 0c 03 00  .....-BlbsxGdv4A6tXF2fZOsJYA@public.gmane.org
  1140: 00 00 00 00 40 0c 00 ff 7f 0c 00 00 00 00 00 00  ....-BlbsxGdv4A7jshiNgxcy3g@public.gmane.org
  1150: 40 00 00 00 87 18 00 00 0c 03 00 00 00 00 00 80  @...............
  1160: 0c 00 ff bf 0c 00 00 00 00 00 00 40 00 00 00 87  ...........-9D9NNryygCw@public.gmane.org
  1170: 18 00 00 0c 03 00 00 00 00 00 c0 0c 00 ff ff 0c  ................
  1180: 00 00 00 00 00 00 40 00 00 00 87 18 00 00 0c 03  ......-BlbsxGdv4A7hvxM+mQhndA@public.gmane.org
  1190: 00 00 00 00 00 00 0d 00 ff 3f 0d 00 00 00 00 00  .........?......
  11a0: 00 40 00 00 00 87 18 00 00 0c 03 00 00 00 00 00  .-BlbsxGdv4A4TZT1p1SMppg@public.gmane.org
  11b0: 40 0d 00 ff 7f 0d 00 00 00 00 00 00 40 00 00 00  @...........-47IYjYMXMt4@public.gmane.org
  11c0: 87 18 00 00 0c 03 00 00 00 00 00 80 0d 00 ff bf  ................
  11d0: 0d 00 00 00 00 00 00 40 00 00 00 87 18 00 00 0c  .......-BlbsxGdv4A4@public.gmane.org
  11e0: 03 00 00 00 00 00 c0 0d 00 ff ff 0d 00 00 00 00  ................
  11f0: 00 00 40 00 00 00 87 18 00 00 0c 03 00 00 00 00  ..-BlbsxGdv4A7maATwymIwmA@public.gmane.org
  1200: 00 00 0e 00 ff 3f 0e 00 00 00 00 00 00 40 00 00  .....?.......-rVxdn2TrCWA@public.gmane.org
  1210: 00 87 18 00 00 0c 03 00 00 00 00 00 40 0e 00 ff  ............-47IYjYMXMt4@public.gmane.org
  1220: 7f 0e 00 00 00 00 00 00 40 00 00 00 87 18 00 00  ........-3wQm9ZMZ9co@public.gmane.org
  1230: 0c 03 00 00 00 00 00 80 0e 00 ff bf 0e 00 00 00  ................
  1240: 00 00 00 40 00 00 00 87 18 00 00 0c 03 00 00 00  ...-BlbsxGdv4A70P002vLKALA@public.gmane.org
  1250: 00 00 c0 0e 00 ff ff 0e 00 00 00 00 00 00 40 00  ..............-4b8TPpkIZ3Q@public.gmane.org
  1260: 00 00 87 18 00 00 0c 03 00 00 00 00 00 00 0f 00  ................
  1270: ff ff 0f 00 00 00 00 00 00 00 01 00 00 87 18 00  ................
  1280: 00 0c 03 00 00 00 00 00 00 00 00 ff ff bf fe 00  ................
  1290: 00 00 00 00 00 00 00 00 87 18 00 00 0c 03 00 00  ................
  12a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  12b0: 00 00 00 79 00 14 45 39 5f 43 52 53 08 a0 16 50  ...y..E9_CRS...P
  12c0: 4d 31 4c 8a 42 55 46 30 0a 80 43 30 4c 4e 70 00  M1L.BUF0..C0LNp.
  12d0: 43 30 4c 4e a0 1a 93 50 4d 31 4c 0a 01 8d 42 55  C0LN...PM1L...BU
  12e0: 46 30 0b 78 03 43 30 52 57 70 00 43 30 52 57 a0  F0.x.C0RWp.C0RW.
  12f0: 16 50 4d 31 48 8a 42 55 46 30 0a 9b 43 34 4c 4e  .PM1H.BUF0..C4LN
  1300: 70 00 43 34 4c 4e a0 1a 93 50 4d 31 48 0a 01 8d  p.C4LN...PM1H...
  1310: 42 55 46 30 0b 50 04 43 34 52 57 70 00 43 34 52  BUF0.P.C4RWp.C4R
  1320: 57 a0 16 50 4d 32 4c 8a 42 55 46 30 0a b6 43 38  W..PM2L.BUF0..C8
  1330: 4c 4e 70 00 43 38 4c 4e a0 1a 93 50 4d 32 4c 0a  LNp.C8LN...PM2L.
  1340: 01 8d 42 55 46 30 0b 28 05 43 38 52 57 70 00 43  ..BUF0.(.C8RWp.C
  1350: 38 52 57 a0 16 50 4d 32 48 8a 42 55 46 30 0a d1  8RW..PM2H.BUF0..
  1360: 43 43 4c 4e 70 00 43 43 4c 4e a0 1a 93 50 4d 32  CCLNp.CCLN...PM2
  1370: 48 0a 01 8d 42 55 46 30 0b 00 06 43 43 52 57 70  H...BUF0...CCRWp
  1380: 00 43 43 52 57 a0 16 50 4d 33 4c 8a 42 55 46 30  .CCRW..PM3L.BUF0
  1390: 0a ec 44 30 4c 4e 70 00 44 30 4c 4e a0 1a 93 50  ..D0LNp.D0LN...P
  13a0: 4d 33 4c 0a 01 8d 42 55 46 30 0b d8 06 44 30 52  M3L...BUF0...D0R
  13b0: 57 70 00 44 30 52 57 a0 17 50 4d 33 48 8a 42 55  Wp.D0RW..PM3H.BU
  13c0: 46 30 0b 07 01 44 34 4c 4e 70 00 44 34 4c 4e a0  F0...D4LNp.D4LN.
  13d0: 1a 93 50 4d 33 48 0a 01 8d 42 55 46 30 0b b0 07  ..PM3H...BUF0...
  13e0: 44 34 52 57 70 00 44 34 52 57 a0 17 50 4d 34 4c  D4RWp.D4RW..PM4L
  13f0: 8a 42 55 46 30 0b 22 01 44 38 4c 4e 70 00 44 38  .BUF0.".D8LNp.D8
  1400: 4c 4e a0 1a 93 50 4d 34 4c 0a 01 8d 42 55 46 30  LN...PM4L...BUF0
  1410: 0b 88 08 44 38 52 57 70 00 44 38 52 57 a0 17 50  ...D8RWp.D8RW..P
  1420: 4d 34 48 8a 42 55 46 30 0b 3d 01 44 43 4c 4e 70  M4H.BUF0.=.DCLNp
  1430: 00 44 43 4c 4e a0 1a 93 50 4d 34 48 0a 01 8d 42  .DCLN...PM4H...B
  1440: 55 46 30 0b 60 09 44 43 52 57 70 00 44 43 52 57  UF0.`.DCRWp.DCRW
  1450: a0 17 50 4d 35 4c 8a 42 55 46 30 0b 58 01 45 30  ..PM5L.BUF0.X.E0
  1460: 4c 4e 70 00 45 30 4c 4e a0 1a 93 50 4d 35 4c 0a  LNp.E0LN...PM5L.
  1470: 01 8d 42 55 46 30 0b 38 0a 45 30 52 57 70 00 45  ..BUF0.8.E0RWp.E
  1480: 30 52 57 a0 17 50 4d 35 48 8a 42 55 46 30 0b 73  0RW..PM5H.BUF0.s
  1490: 01 45 34 4c 4e 70 00 45 34 4c 4e a0 1a 93 50 4d  .E4LNp.E4LN...PM
  14a0: 35 48 0a 01 8d 42 55 46 30 0b 10 0b 45 34 52 57  5H...BUF0...E4RW
  14b0: 70 00 45 34 52 57 a0 17 50 4d 36 4c 8a 42 55 46  p.E4RW..PM6L.BUF
  14c0: 30 0b 8e 01 45 38 4c 4e 70 00 45 38 4c 4e a0 1a  0...E8LNp.E8LN..
  14d0: 93 50 4d 36 4c 0a 01 8d 42 55 46 30 0b e8 0b 45  .PM6L...BUF0...E
  14e0: 38 52 57 70 00 45 38 52 57 a0 17 50 4d 36 48 8a  8RWp.E8RW..PM6H.
  14f0: 42 55 46 30 0b a9 01 45 43 4c 4e 70 00 45 43 4c  BUF0...ECLNp.ECL
  1500: 4e a0 1a 93 50 4d 36 48 0a 01 8d 42 55 46 30 0b  N...PM6H...BUF0.
  1510: c0 0c 45 43 52 57 70 00 45 43 52 57 a0 17 50 4d  ..ECRWp.ECRW..PM
  1520: 30 48 8a 42 55 46 30 0b c4 01 46 30 4c 4e 70 00  0H.BUF0...F0LNp.
  1530: 46 30 4c 4e a0 1a 93 50 4d 30 48 0a 01 8d 42 55  F0LN...PM0H...BU
  1540: 46 30 0b 98 0d 46 30 52 57 70 00 46 30 52 57 8a  F0...F0RWp.F0RW.
  1550: 42 55 46 30 0b d3 01 4d 31 4d 4e 8a 42 55 46 30  BUF0...M1MN.BUF0
  1560: 0b d7 01 4d 31 4d 58 8a 42 55 46 30 0b df 01 4d  ...M1MX.BUF0...M
  1570: 31 4c 4e 77 0c 00 00 00 02 44 52 42 33 4d 31 4d  1LNw.....DRB3M1M
  1580: 4e 72 74 4d 31 4d 58 4d 31 4d 4e 00 0a 01 4d 31  NrtM1MXM1MN...M1
  1590: 4c 4e 7a 7b 5c 2f 04 5f 53 42 5f 50 43 49 30 4c  LNz{\/._SB_PCI0L
  15a0: 50 43 42 48 50 54 45 0c 00 80 03 00 00 0a 0f 60  PCBHPTE........`
  15b0: a0 45 09 7b 60 0a 04 00 8a 42 55 46 30 0b ee 01  .E.{`....BUF0...
  15c0: 4d 32 4d 4e 8a 42 55 46 30 0b f2 01 4d 32 4d 58  M2MN.BUF0...M2MX
  15d0: 8a 42 55 46 30 0b fa 01 4d 32 4c 4e 70 0c 00 00  .BUF0...M2LNp...
  15e0: d0 fe 4d 32 4d 4e 70 0c ff 03 d0 fe 4d 32 4d 58  ..M2MNp.....M2MX
  15f0: 70 0b 00 04 4d 32 4c 4e a0 19 93 60 0a 05 70 0c  p...M2LN...`..p.
  1600: 00 10 d0 fe 4d 32 4d 4e 70 0c ff 13 d0 fe 4d 32  ....M2MNp.....M2
  1610: 4d 58 a0 19 93 60 0a 06 70 0c 00 20 d0 fe 4d 32  MX...`..p.. ..M2
  1620: 4d 4e 70 0c ff 23 d0 fe 4d 32 4d 58 a0 19 93 60  MNp..#..M2MX...`
  1630: 0a 07 70 0c 00 30 d0 fe 4d 32 4d 4e 70 0c ff 33  ..p..0..M2MNp..3
  1640: d0 fe 4d 32 4d 58 a4 42 55 46 30 14 46 15 5f 50  ..M2MX.BUF0.F._P
  1650: 52 54 00 a0 4d 06 47 50 49 43 a4 12 45 06 07 12  RT..M.GPIC..E...
  1660: 0d 04 0c ff ff 07 00 0a 00 0a 00 0a 10 12 0d 04  ................
  1670: 0c ff ff 1d 00 0a 00 0a 00 0a 10 12 0d 04 0c ff  ................
  1680: ff 1d 00 0a 01 0a 00 0a 13 12 0d 04 0c ff ff 1d  ................
  1690: 00 0a 02 0a 00 0a 12 12 0d 04 0c ff ff 1d 00 0a  ................
  16a0: 03 0a 00 0a 17 12 0d 04 0c ff ff 1f 00 0a 00 0a  ................
  16b0: 00 0a 12 12 0d 04 0c ff ff 1f 00 0a 01 0a 00 0a  ................
  16c0: 11 a1 40 0e a4 12 4c 0d 07 12 1e 04 0c ff ff 07  ..-4QJ3gbxO07fmaATwymIwmA@public.gmane.org
  16d0: 00 0a 00 5c 2f 04 5f 53 42 5f 50 43 49 30 4c 50  ...\/._SB_PCI0LP
  16e0: 43 42 4c 4e 4b 41 0a 00 12 1e 04 0c ff ff 1d 00  CBLNKA..........
  16f0: 0a 00 5c 2f 04 5f 53 42 5f 50 43 49 30 4c 50 43  ..\/._SB_PCI0LPC
  1700: 42 4c 4e 4b 41 0a 00 12 1e 04 0c ff ff 1d 00 0a  BLNKA...........
  1710: 01 5c 2f 04 5f 53 42 5f 50 43 49 30 4c 50 43 42  .\/._SB_PCI0LPCB
  1720: 4c 4e 4b 44 0a 00 12 1e 04 0c ff ff 1d 00 0a 02  LNKD............
  1730: 5c 2f 04 5f 53 42 5f 50 43 49 30 4c 50 43 42 4c  \/._SB_PCI0LPCBL
  1740: 4e 4b 43 0a 00 12 1e 04 0c ff ff 1d 00 0a 03 5c  NKC............\
  1750: 2f 04 5f 53 42 5f 50 43 49 30 4c 50 43 42 4c 4e  /._SB_PCI0LPCBLN
  1760: 4b 48 0a 00 12 1e 04 0c ff ff 1f 00 0a 00 5c 2f  KH............\/
  1770: 04 5f 53 42 5f 50 43 49 30 4c 50 43 42 4c 4e 4b  ._SB_PCI0LPCBLNK
  1780: 43 0a 00 12 1e 04 0c ff ff 1f 00 0a 01 5c 2f 04  C............\/.
  1790: 5f 53 42 5f 50 43 49 30 4c 50 43 42 4c 4e 4b 42  _SB_PCI0LPCBLNKB
  17a0: 0a 00 5b 82 41 36 41 47 50 42 08 5f 41 44 52 0c  ..[.A6AGPB._ADR.
  17b0: 00 00 01 00 5b 82 4f 30 4e 56 49 44 08 5f 41 44  ....[.O0NVID._AD
  17c0: 52 0a 00 14 10 5f 44 4f 53 01 70 7b 68 0a 03 00  R...._DOS.p{h...
  17d0: 44 53 45 4e 14 4e 1b 5f 44 4f 44 00 08 50 53 49  DSEN.N._DOD..PSI
  17e0: 5a 0a 00 08 50 50 54 52 0a 00 70 0a 3c 53 4d 49  Z...PPTR..p.<SMI
  17f0: 46 70 0a 02 56 46 55 4e 70 0a 00 54 52 50 30 70  Fp..VFUNp..TRP0p
  1800: 43 41 44 4c 60 70 43 41 44 4c 61 70 43 41 44 4c  CADL`pCADLapCADL
  1810: 50 41 44 4c a2 13 61 a0 0b 7b 61 0a 01 00 75 50  PADL..a..{a...uP
  1820: 53 49 5a 7a 61 0a 01 61 a0 20 91 93 50 53 49 5a  SIZza..a. ..PSIZ
  1830: 0a 00 94 50 53 49 5a 0a 04 70 0a 00 45 4e 55 4d  ...PSIZ..p..ENUM
  1840: a4 12 07 01 0c 10 01 01 00 a1 49 14 70 0a 01 45  ..........I.p..E
  1850: 4e 55 4d a0 44 07 93 50 53 49 5a 0a 02 08 56 49  NUM.D..PSIZ...VI
  1860: 44 32 12 0c 02 0c 10 01 01 00 0c 00 01 01 00 a0  D2..............
  1870: 1b 7b 60 0a 01 00 70 0c 10 01 01 00 88 56 49 44  .{`...p......VID
  1880: 32 50 50 54 52 00 75 50 50 54 52 a0 1b 7b 60 0a  2PPTR.uPPTR..{`.
  1890: 02 00 70 0c 00 01 01 00 88 56 49 44 32 50 50 54  ..p......VID2PPT
  18a0: 52 00 75 50 50 54 52 a0 1b 7b 60 0a 04 00 70 0c  R.uPPTR..{`...p.
  18b0: 00 02 01 00 88 56 49 44 32 50 50 54 52 00 75 50  .....VID2PPTR.uP
  18c0: 50 54 52 a4 56 49 44 32 a0 49 07 93 50 53 49 5a  PTR.VID2.I..PSIZ
  18d0: 0a 03 08 56 49 44 33 12 11 03 0c 10 01 01 00 0c  ...VID3.........
  18e0: 00 01 01 00 0c 00 02 01 00 a0 1b 7b 60 0a 01 00  ...........{`...
  18f0: 70 0c 10 01 01 00 88 56 49 44 33 50 50 54 52 00  p......VID3PPTR.
  1900: 75 50 50 54 52 a0 1b 7b 60 0a 02 00 70 0c 00 01  uPPTR..{`...p...
  1910: 01 00 88 56 49 44 33 50 50 54 52 00 75 50 50 54  ...VID3PPTR.uPPT
  1920: 52 a0 1b 7b 60 0a 04 00 70 0c 00 02 01 00 88 56  R..{`...p......V
  1930: 49 44 33 50 50 54 52 00 75 50 50 54 52 a4 56 49  ID3PPTR.uPPTR.VI
  1940: 44 33 08 56 49 44 31 12 07 01 0c 10 01 01 00 a0  D3.VID1.........
  1950: 14 7b 60 0a 01 00 70 0c 10 01 01 00 88 56 49 44  .{`...p......VID
  1960: 31 0a 00 00 a0 14 7b 60 0a 02 00 70 0c 00 01 01  1.....{`...p....
  1970: 00 88 56 49 44 31 0a 00 00 a0 14 7b 60 0a 04 00  ..VID1.....{`...
  1980: 70 0c 00 02 01 00 88 56 49 44 31 0a 00 00 a4 56  p......VID1....V
  1990: 49 44 31 5b 82 44 06 43 52 54 31 08 5f 41 44 52  ID1[.D.CRT1._ADR
  19a0: 0b 00 01 14 31 5f 44 43 53 00 70 0a 3c 53 4d 49  ....1_DCS.p.<SMI
  19b0: 46 70 0a 01 56 46 55 4e 70 0a 00 54 52 50 30 70  Fp..VFUNp..TRP0p
  19c0: 43 53 54 45 60 a0 0c 60 a0 09 7b 60 0a 02 00 a4  CSTE`..`..{`....
  19d0: 0a 1f a4 0a 1d 14 1c 5f 44 47 53 00 70 4e 53 54  ......._DGS.pNST
  19e0: 45 60 a0 0c 60 a0 09 7b 60 0a 02 00 a4 0a 01 a4  E`..`..{`.......
  19f0: 0a 00 14 06 5f 44 53 53 01 5b 82 44 06 4c 43 44  ...._DSS.[.D.LCD
  1a00: 31 08 5f 41 44 52 0b 10 01 14 31 5f 44 43 53 00  1._ADR....1_DCS.
  1a10: 70 0a 3c 53 4d 49 46 70 0a 01 56 46 55 4e 70 0a  p.<SMIFp..VFUNp.
  1a20: 00 54 52 50 30 70 43 53 54 45 60 a0 0c 60 a0 09  .TRP0pCSTE`..`..
  1a30: 7b 60 0a 01 00 a4 0a 1f a4 0a 1d 14 1c 5f 44 47  {`..........._DG
  1a40: 53 00 70 4e 53 54 45 60 a0 0c 60 a0 09 7b 60 0a  S.pNSTE`..`..{`.
  1a50: 01 00 a4 0a 01 a4 0a 00 14 06 5f 44 53 53 01 5b  .........._DSS.[
  1a60: 82 44 06 44 54 56 31 08 5f 41 44 52 0b 00 02 14  .D.DTV1._ADR....
  1a70: 31 5f 44 43 53 00 70 0a 3c 53 4d 49 46 70 0a 01  1_DCS.p.<SMIFp..
  1a80: 56 46 55 4e 70 0a 00 54 52 50 30 70 43 53 54 45  VFUNp..TRP0pCSTE
  1a90: 60 a0 0c 60 a0 09 7b 60 0a 04 00 a4 0a 1f a4 0a  `..`..{`........
  1aa0: 1d 14 1c 5f 44 47 53 00 70 4e 53 54 45 60 a0 0c  ..._DGS.pNSTE`..
  1ab0: 60 a0 09 7b 60 0a 04 00 a4 0a 01 a4 0a 00 14 06  `..{`...........
  1ac0: 5f 44 53 53 01 14 3f 5f 50 52 54 00 a0 15 47 50  _DSS..?_PRT...GP
  1ad0: 49 43 a4 12 0e 01 12 0b 04 0b ff ff 0a 00 0a 00  IC..............
  1ae0: 0a 11 a1 22 a4 12 1f 01 12 1c 04 0b ff ff 0a 00  ..."............
  1af0: 5c 2f 04 5f 53 42 5f 50 43 49 30 4c 50 43 42 4c  \/._SB_PCI0LPCBL
  1b00: 4e 4b 42 0a 00 5b 82 48 2b 50 43 49 42 08 5f 41  NKB..[.H+PCIB._A
  1b10: 44 52 0c 00 00 1e 00 5b 82 4d 05 43 44 42 30 08  DR.....[.M.CDB0.
  1b20: 5f 41 44 52 0c 00 00 03 00 5b 80 43 42 44 30 02  _ADR.....[.CBD0.
  1b30: 0a 00 0a f0 5b 81 27 43 42 44 30 00 00 40 1e 43  ....[.'CBD0..-MmdWRlgwZ0I@public.gmane.org
  1b40: 44 33 43 08 00 38 43 44 34 34 20 00 48 2e 43 44  D3C..8CD44 .H.CD
  1b50: 41 35 08 00 48 1d 00 07 50 4d 45 53 01 14 18 5f  A5..H...PMES..._
  1b60: 49 4e 49 00 7d 43 44 33 43 0a ff 43 44 33 43 70  INI.}CD3C..CD3Cp
  1b70: 0a 00 43 44 34 34 5b 82 45 05 43 44 42 31 08 5f  ..CD44[.E.CDB1._
  1b80: 41 44 52 0c 01 00 03 00 5b 80 43 42 44 31 02 0a  ADR.....[.CBD1..
  1b90: 00 0a f0 5b 81 1f 43 42 44 31 00 00 40 1e 43 44  ...[..CBD1..-pCYjSMgWTbc@public.gmane.org
  1ba0: 33 43 08 00 38 43 44 34 34 20 00 48 4c 00 07 50  3C..8CD44 .HL..P
  1bb0: 4d 45 53 01 14 18 5f 49 4e 49 00 7d 43 44 33 43  MES..._INI.}CD3C
  1bc0: 0a ff 43 44 33 43 70 0a 00 43 44 34 34 5b 82 43  ..CD3Cp..CD44[.C
  1bd0: 05 4f 48 43 49 08 5f 41 44 52 0c 02 00 03 00 5b  .OHCI._ADR.....[
  1be0: 80 4f 48 43 49 02 0a 00 0a f0 5b 81 1d 4f 48 43  .OHCI.....[..OHC
  1bf0: 49 00 00 40 1e 43 44 33 43 08 00 38 43 44 34 34  I..-nJViGFutKF8TRLoWvWY4HQ@public.gmane.org
  1c00: 20 00 48 4c 50 4d 45 53 08 14 18 5f 49 4e 49 00   .HLPMES..._INI.
  1c10: 7d 43 44 33 43 0a ff 43 44 33 43 70 0a 00 43 44  }CD3C..CD3Cp..CD
  1c20: 34 34 5b 82 1b 4c 41 4e 43 08 5f 41 44 52 0c 00  44[..LANC._ADR..
  1c30: 00 05 00 08 5f 50 52 57 12 06 02 0a 0b 0a 04 5b  ...._PRW.......[
  1c40: 82 29 4d 50 43 30 08 5f 41 44 52 0c 00 00 07 00  .)MPC0._ADR.....
  1c50: 5b 80 4d 50 43 30 02 0a a0 0a 10 5b 81 0d 4d 50  [.MPC0.....[..MP
  1c60: 43 30 00 00 28 4d 41 35 5f 08 5b 82 29 4d 50 43  C0..(MA5_.[.)MPC
  1c70: 31 08 5f 41 44 52 0c 01 00 07 00 5b 80 4d 50 43  1._ADR.....[.MPC
  1c80: 31 02 0a a0 0a 10 5b 81 0d 4d 50 43 31 00 00 28  1.....[..MPC1..(
  1c90: 4d 41 35 5f 08 14 49 12 5f 50 52 54 00 a0 4f 05  MA5_..I._PRT..O.
  1ca0: 47 50 49 43 a4 12 47 05 06 12 0d 04 0c ff ff 05  GPIC..G.........
  1cb0: 00 0a 00 0a 00 0a 13 12 0d 04 0c ff ff 03 00 0a  ................
  1cc0: 00 0a 00 0a 10 12 0d 04 0c ff ff 03 00 0a 01 0a  ................
  1cd0: 00 0a 11 12 0d 04 0c ff ff 03 00 0a 02 0a 00 0a  ................
  1ce0: 12 12 0d 04 0c ff ff 07 00 0a 00 0a 00 0a 14 12  ................
  1cf0: 0d 04 0c ff ff 07 00 0a 01 0a 00 0a 15 a1 41 0c  ..............A.
  1d00: a4 12 4d 0b 06 12 1e 04 0c ff ff 05 00 0a 00 5c  ..M............\
  1d10: 2f 04 5f 53 42 5f 50 43 49 30 4c 50 43 42 4c 4e  /._SB_PCI0LPCBLN
  1d20: 4b 44 0a 00 12 1e 04 0c ff ff 03 00 0a 00 5c 2f  KD............\/
  1d30: 04 5f 53 42 5f 50 43 49 30 4c 50 43 42 4c 4e 4b  ._SB_PCI0LPCBLNK
  1d40: 41 0a 00 12 1e 04 0c ff ff 03 00 0a 01 5c 2f 04  A............\/.
  1d50: 5f 53 42 5f 50 43 49 30 4c 50 43 42 4c 4e 4b 42  _SB_PCI0LPCBLNKB
  1d60: 0a 00 12 1e 04 0c ff ff 03 00 0a 02 5c 2f 04 5f  ............\/._
  1d70: 53 42 5f 50 43 49 30 4c 50 43 42 4c 4e 4b 43 0a  SB_PCI0LPCBLNKC.
  1d80: 00 12 1e 04 0c ff ff 07 00 0a 00 5c 2f 04 5f 53  ...........\/._S
  1d90: 42 5f 50 43 49 30 4c 50 43 42 4c 4e 4b 45 0a 00  B_PCI0LPCBLNKE..
  1da0: 12 1e 04 0c ff ff 07 00 0a 01 5c 2f 04 5f 53 42  ..........\/._SB
  1db0: 5f 50 43 49 30 4c 50 43 42 4c 4e 4b 46 0a 00 5b  _PCI0LPCBLNKF..[
  1dc0: 82 4c d5 4c 50 43 42 08 5f 41 44 52 0c 00 00 1f  .L.LPCB._ADR....
  1dd0: 00 5b 80 4c 50 43 30 02 0a 40 0a c0 5b 81 49 04  .[.LPC0..-rVxdn2TrCWA@public.gmane.org[.I.
  1de0: 4c 50 43 30 00 00 40 10 50 49 52 41 08 50 49 52  LPC0..-P+85WYokNPrl2ZiQzgSchg@public.gmane.org
  1df0: 42 08 50 49 52 43 08 50 49 52 44 08 00 20 50 49  B.PIRC.PIRD.. PI
  1e00: 52 45 08 50 49 52 46 08 50 49 52 47 08 50 49 52  RE.PIRF.PIRG.PIR
  1e10: 48 08 00 40 32 48 50 54 45 20 00 40 06 4c 44 45  H..-my/X9odgTOY@public.gmane.org .@.LDE
  1e20: 30 08 4c 44 45 31 08 5b 82 45 0a 4c 4e 4b 41 08  0.LDE1.[.E.LNKA.
  1e30: 5f 48 49 44 0c 41 d0 0c 0f 08 5f 55 49 44 0a 01  _HID.A...._UID..
  1e40: 14 0d 5f 44 49 53 08 70 0a 80 50 49 52 41 08 5f  .._DIS.p..PIRA._
  1e50: 50 52 53 11 09 0a 06 23 00 08 18 79 00 14 3a 5f  PRS....#...y..:_
  1e60: 43 52 53 08 08 52 54 4c 41 11 09 0a 06 23 00 00  CRS..RTLA....#..
  1e70: 18 79 00 8b 52 54 4c 41 0a 01 49 52 51 30 70 00  .y..RTLA..IRQ0p.
  1e80: 49 52 51 30 79 0a 01 7b 50 49 52 41 0a 0f 00 49  IRQ0y..{PIRA...I
  1e90: 52 51 30 a4 52 54 4c 41 14 1c 5f 53 52 53 09 8b  RQ0.RTLA.._SRS..
  1ea0: 68 0a 01 49 52 51 30 82 49 52 51 30 60 76 60 70  h..IRQ0.IRQ0`v`p
  1eb0: 60 50 49 52 41 14 18 5f 53 54 41 08 a0 0c 7b 50  `PIRA.._STA...{P
  1ec0: 49 52 41 0a 80 00 a4 0a 09 a1 04 a4 0a 0b 5b 82  IRA...........[.
  1ed0: 45 0a 4c 4e 4b 42 08 5f 48 49 44 0c 41 d0 0c 0f  E.LNKB._HID.A...
  1ee0: 08 5f 55 49 44 0a 02 14 0d 5f 44 49 53 08 70 0a  ._UID...._DIS.p.
  1ef0: 80 50 49 52 42 08 5f 50 52 53 11 09 0a 06 23 00  .PIRB._PRS....#.
  1f00: 08 18 79 00 14 3a 5f 43 52 53 08 08 52 54 4c 42  ..y..:_CRS..RTLB
  1f10: 11 09 0a 06 23 00 00 18 79 00 8b 52 54 4c 42 0a  ....#...y..RTLB.
  1f20: 01 49 52 51 30 70 00 49 52 51 30 79 0a 01 7b 50  .IRQ0p.IRQ0y..{P
  1f30: 49 52 42 0a 0f 00 49 52 51 30 a4 52 54 4c 42 14  IRB...IRQ0.RTLB.
  1f40: 1c 5f 53 52 53 09 8b 68 0a 01 49 52 51 30 82 49  ._SRS..h..IRQ0.I
  1f50: 52 51 30 60 76 60 70 60 50 49 52 42 14 18 5f 53  RQ0`v`p`PIRB.._S
  1f60: 54 41 08 a0 0c 7b 50 49 52 42 0a 80 00 a4 0a 09  TA...{PIRB......
  1f70: a1 04 a4 0a 0b 5b 82 45 0a 4c 4e 4b 43 08 5f 48  .....[.E.LNKC._H
  1f80: 49 44 0c 41 d0 0c 0f 08 5f 55 49 44 0a 03 14 0d  ID.A...._UID....
  1f90: 5f 44 49 53 08 70 0a 80 50 49 52 43 08 5f 50 52  _DIS.p..PIRC._PR
  1fa0: 53 11 09 0a 06 23 00 04 18 79 00 14 3a 5f 43 52  S....#...y..:_CR
  1fb0: 53 08 08 52 54 4c 43 11 09 0a 06 23 00 00 18 79  S..RTLC....#...y
  1fc0: 00 8b 52 54 4c 43 0a 01 49 52 51 30 70 00 49 52  ..RTLC..IRQ0p.IR
  1fd0: 51 30 79 0a 01 7b 50 49 52 43 0a 0f 00 49 52 51  Q0y..{PIRC...IRQ
  1fe0: 30 a4 52 54 4c 43 14 1c 5f 53 52 53 09 8b 68 0a  0.RTLC.._SRS..h.
  1ff0: 01 49 52 51 30 82 49 52 51 30 60 76 60 70 60 50  .IRQ0.IRQ0`v`p`P
  2000: 49 52 43 14 18 5f 53 54 41 08 a0 0c 7b 50 49 52  IRC.._STA...{PIR
  2010: 43 0a 80 00 a4 0a 09 a1 04 a4 0a 0b 5b 82 45 0a  C...........[.E.
  2020: 4c 4e 4b 44 08 5f 48 49 44 0c 41 d0 0c 0f 08 5f  LNKD._HID.A...._
  2030: 55 49 44 0a 04 14 0d 5f 44 49 53 08 70 0a 80 50  UID...._DIS.p..P
  2040: 49 52 44 08 5f 50 52 53 11 09 0a 06 23 00 04 18  IRD._PRS....#...
  2050: 79 00 14 3a 5f 43 52 53 08 08 52 54 4c 44 11 09  y..:_CRS..RTLD..
  2060: 0a 06 23 00 00 18 79 00 8b 52 54 4c 44 0a 01 49  ..#...y..RTLD..I
  2070: 52 51 30 70 00 49 52 51 30 79 0a 01 7b 50 49 52  RQ0p.IRQ0y..{PIR
  2080: 44 0a 0f 00 49 52 51 30 a4 52 54 4c 44 14 1c 5f  D...IRQ0.RTLD.._
  2090: 53 52 53 09 8b 68 0a 01 49 52 51 30 82 49 52 51  SRS..h..IRQ0.IRQ
  20a0: 30 60 76 60 70 60 50 49 52 44 14 18 5f 53 54 41  0`v`p`PIRD.._STA
  20b0: 08 a0 0c 7b 50 49 52 44 0a 80 00 a4 0a 09 a1 04  ...{PIRD........
  20c0: a4 0a 0b 5b 82 45 0a 4c 4e 4b 45 08 5f 48 49 44  ...[.E.LNKE._HID
  20d0: 0c 41 d0 0c 0f 08 5f 55 49 44 0a 05 14 0d 5f 44  .A...._UID...._D
  20e0: 49 53 08 70 0a 80 50 49 52 45 08 5f 50 52 53 11  IS.p..PIRE._PRS.
  20f0: 09 0a 06 23 20 00 18 79 00 14 3a 5f 43 52 53 08  ...# ..y..:_CRS.
  2100: 08 52 54 4c 45 11 09 0a 06 23 00 00 18 79 00 8b  .RTLE....#...y..
  2110: 52 54 4c 45 0a 01 49 52 51 30 70 00 49 52 51 30  RTLE..IRQ0p.IRQ0
  2120: 79 0a 01 7b 50 49 52 45 0a 0f 00 49 52 51 30 a4  y..{PIRE...IRQ0.
  2130: 52 54 4c 45 14 1c 5f 53 52 53 09 8b 68 0a 01 49  RTLE.._SRS..h..I
  2140: 52 51 30 82 49 52 51 30 60 76 60 70 60 50 49 52  RQ0.IRQ0`v`p`PIR
  2150: 45 14 18 5f 53 54 41 08 a0 0c 7b 50 49 52 45 0a  E.._STA...{PIRE.
  2160: 80 00 a4 0a 09 a1 04 a4 0a 0b 5b 82 45 0a 4c 4e  ..........[.E.LN
  2170: 4b 46 08 5f 48 49 44 0c 41 d0 0c 0f 08 5f 55 49  KF._HID.A...._UI
  2180: 44 0a 06 14 0d 5f 44 49 53 08 70 0a 80 50 49 52  D...._DIS.p..PIR
  2190: 46 08 5f 50 52 53 11 09 0a 06 23 20 00 18 79 00  F._PRS....# ..y.
  21a0: 14 3a 5f 43 52 53 08 08 52 54 4c 46 11 09 0a 06  .:_CRS..RTLF....
  21b0: 23 00 00 18 79 00 8b 52 54 4c 46 0a 01 49 52 51  #...y..RTLF..IRQ
  21c0: 30 70 00 49 52 51 30 79 0a 01 7b 50 49 52 46 0a  0p.IRQ0y..{PIRF.
  21d0: 0f 00 49 52 51 30 a4 52 54 4c 46 14 1c 5f 53 52  ..IRQ0.RTLF.._SR
  21e0: 53 09 8b 68 0a 01 49 52 51 30 82 49 52 51 30 60  S..h..IRQ0.IRQ0`
  21f0: 76 60 70 60 50 49 52 46 14 18 5f 53 54 41 08 a0  v`p`PIRF.._STA..
  2200: 0c 7b 50 49 52 46 0a 80 00 a4 0a 09 a1 04 a4 0a  .{PIRF..........
  2210: 0b 5b 82 45 0a 4c 4e 4b 47 08 5f 48 49 44 0c 41  .[.E.LNKG._HID.A
  2220: d0 0c 0f 08 5f 55 49 44 0a 07 14 0d 5f 44 49 53  ...._UID...._DIS
  2230: 08 70 0a 80 50 49 52 47 08 5f 50 52 53 11 09 0a  .p..PIRG._PRS...
  2240: 06 23 00 04 18 79 00 14 3a 5f 43 52 53 08 08 52  .#...y..:_CRS..R
  2250: 54 4c 47 11 09 0a 06 23 00 00 18 79 00 8b 52 54  TLG....#...y..RT
  2260: 4c 47 0a 01 49 52 51 30 70 00 49 52 51 30 79 0a  LG..IRQ0p.IRQ0y.
  2270: 01 7b 50 49 52 47 0a 0f 00 49 52 51 30 a4 52 54  .{PIRG...IRQ0.RT
  2280: 4c 47 14 1c 5f 53 52 53 09 8b 68 0a 01 49 52 51  LG.._SRS..h..IRQ
  2290: 30 82 49 52 51 30 60 76 60 70 60 50 49 52 47 14  0.IRQ0`v`p`PIRG.
  22a0: 18 5f 53 54 41 08 a0 0c 7b 50 49 52 47 0a 80 00  ._STA...{PIRG...
  22b0: a4 0a 09 a1 04 a4 0a 0b 5b 82 45 0a 4c 4e 4b 48  ........[.E.LNKH
  22c0: 08 5f 48 49 44 0c 41 d0 0c 0f 08 5f 55 49 44 0a  ._HID.A...._UID.
  22d0: 08 14 0d 5f 44 49 53 08 70 0a 80 50 49 52 48 08  ..._DIS.p..PIRH.
  22e0: 5f 50 52 53 11 09 0a 06 23 20 00 18 79 00 14 3a  _PRS....# ..y..:
  22f0: 5f 43 52 53 08 08 52 54 4c 48 11 09 0a 06 23 00  _CRS..RTLH....#.
  2300: 00 18 79 00 8b 52 54 4c 48 0a 01 49 52 51 30 70  ..y..RTLH..IRQ0p
  2310: 00 49 52 51 30 79 0a 01 7b 50 49 52 48 0a 0f 00  .IRQ0y..{PIRH...
  2320: 49 52 51 30 a4 52 54 4c 48 14 1c 5f 53 52 53 09  IRQ0.RTLH.._SRS.
  2330: 8b 68 0a 01 49 52 51 30 82 49 52 51 30 60 76 60  .h..IRQ0.IRQ0`v`
  2340: 70 60 50 49 52 48 14 18 5f 53 54 41 08 a0 0c 7b  p`PIRH.._STA...{
  2350: 50 49 52 48 0a 80 00 a4 0a 09 a1 04 a4 0a 0b 5b  PIRH...........[
  2360: 82 47 06 54 49 4d 52 08 5f 48 49 44 0c 41 d0 01  .G.TIMR._HID.A..
  2370: 00 08 42 55 46 30 11 15 0a 12 47 01 40 00 40 00  ..BUF0....G.-4b8TPpkIZ3Q@public.gmane.org@.
  2380: 01 04 47 01 50 00 50 00 10 04 79 00 08 42 55 46  ..G.P.P...y..BUF
  2390: 31 11 18 0a 15 47 01 40 00 40 00 01 04 47 01 50  1....G.-4b8TPpkIZ3Q@public.gmane.org@...G.P
  23a0: 00 50 00 10 04 22 01 00 79 00 14 1d 5f 43 52 53  .P..."..y..._CRS
  23b0: 08 a0 11 7b 48 50 54 45 0c 00 00 02 00 00 a4 42  ...{HPTE.......B
  23c0: 55 46 30 a4 42 55 46 31 5b 82 45 0a 49 50 49 43  UF0.BUF1[.E.IPIC
  23d0: 08 5f 48 49 44 0b 41 d0 08 5f 43 52 53 11 41 09  ._HID.A.._CRS.A.
  23e0: 0a 8d 47 01 20 00 20 00 01 02 47 01 24 00 24 00  ..G. . ...G.$.$.
  23f0: 01 02 47 01 28 00 28 00 01 02 47 01 2c 00 2c 00  ..G.(.(...G.,.,.
  2400: 01 02 47 01 30 00 30 00 01 02 47 01 34 00 34 00  ..G.0.0...G.4.4.
  2410: 01 02 47 01 38 00 38 00 01 02 47 01 3c 00 3c 00  ..G.8.8...G.<.<.
  2420: 01 02 47 01 a0 00 a0 00 01 02 47 01 a4 00 a4 00  ..G.......G.....
  2430: 01 02 47 01 a8 00 a8 00 01 02 47 01 ac 00 ac 00  ..G.......G.....
  2440: 01 02 47 01 b0 00 b0 00 01 02 47 01 b4 00 b4 00  ..G.......G.....
  2450: 01 02 47 01 b8 00 b8 00 01 02 47 01 bc 00 bc 00  ..G.......G.....
  2460: 01 02 47 01 d0 04 d0 04 01 02 22 04 00 79 00 5b  ..G......."..y.[
  2470: 82 47 05 52 54 43 5f 08 5f 48 49 44 0c 41 d0 0b  .G.RTC_._HID.A..
  2480: 00 08 42 55 46 30 11 0d 0a 0a 47 01 70 00 70 00  ..BUF0....G.p.p.
  2490: 01 08 79 00 08 42 55 46 31 11 10 0a 0d 47 01 70  ..y..BUF1....G.p
  24a0: 00 70 00 01 08 22 00 01 79 00 14 1d 5f 43 52 53  .p..."..y..._CRS
  24b0: 08 a0 11 7b 48 50 54 45 0c 00 00 02 00 00 a4 42  ...{HPTE.......B
  24c0: 55 46 30 a4 42 55 46 31 5b 82 25 4d 41 54 48 08  UF0.BUF1[.%MATH.
  24d0: 5f 48 49 44 0c 41 d0 0c 04 08 5f 43 52 53 11 10  _HID.A...._CRS..
  24e0: 0a 0d 47 01 f0 00 f0 00 01 01 22 00 20 79 00 5b  ..G.......". y.[
  24f0: 82 46 04 44 4d 41 43 08 5f 48 49 44 0c 41 d0 02  .F.DMAC._HID.A..
  2500: 00 08 5f 43 52 53 11 30 0a 2d 47 01 00 00 00 00  .._CRS.0.-G.....
  2510: 01 20 47 01 81 00 81 00 01 0f 47 01 90 00 90 00  . G.......G.....
  2520: 01 02 47 01 93 00 93 00 01 0d 47 01 c0 00 c0 00  ..G.......G.....
  2530: 01 20 2a 10 01 79 00 5b 82 48 0a 4d 42 52 44 08  . *..y.[.H.MBRD.
  2540: 5f 48 49 44 0c 41 d0 0c 02 08 5f 43 52 53 11 42  _HID.A...._CRS.B
  2550: 09 0a 8e 47 01 2e 00 2e 00 01 02 47 01 61 00 61  ...G.......G.a.a
  2560: 00 01 01 47 01 63 00 63 00 01 01 47 01 65 00 65  ...G.c.c...G.e.e
  2570: 00 01 01 47 01 67 00 67 00 01 01 47 01 80 00 80  ...G.g.g...G....
  2580: 00 01 01 47 01 92 00 92 00 01 01 47 01 b2 00 b2  ...G.......G....
  2590: 00 01 02 47 01 00 06 00 06 01 10 47 01 00 07 00  ...G.......G....
  25a0: 07 01 10 47 01 00 08 00 08 01 08 47 01 00 10 00  ...G.......G....
  25b0: 10 01 80 47 01 80 11 80 11 01 40 86 09 00 01 00  ...G......-5mgE8MpiMJg@public.gmane.org
  25c0: e0 bf fe 00 10 00 00 86 09 00 01 00 f0 bf fe 00  ................
  25d0: 10 00 00 86 09 00 01 00 00 c0 fe 00 10 00 00 79  ...............y
  25e0: 00 5b 82 26 46 57 48 44 08 5f 48 49 44 0c 25 d4  .[.&FWHD._HID.%.
  25f0: 08 00 08 5f 43 52 53 11 11 0a 0e 86 09 00 00 00  ..._CRS.........
  2600: 00 80 ff 00 00 80 00 79 00 5b 82 45 0c 48 50 45  .......y.[.E.HPE
  2610: 54 08 5f 48 49 44 0c 41 d0 01 03 08 42 55 46 30  T._HID.A....BUF0
  2620: 11 17 0a 14 22 01 00 22 00 01 86 09 00 00 00 00  ....".."........
  2630: d0 fe 00 04 00 00 79 00 14 38 5f 53 54 41 00 7a  ......y..8_STA.z
  2640: 7b 48 50 54 45 0c 00 80 03 00 00 0a 0f 60 a0 13  {HPTE........`..
  2650: 93 4f 53 59 53 0b d1 07 a0 09 7b 60 0a 04 00 a4  .OSYS.....{`....
  2660: 0a 0f a1 0b a0 09 7b 60 0a 04 00 a4 0a 0b a4 0a  ......{`........
  2670: 00 14 4e 05 5f 43 52 53 08 7a 7b 48 50 54 45 0c  ..N._CRS.z{HPTE.
  2680: 00 80 03 00 00 0a 0f 60 a0 42 04 7b 60 0a 04 00  .......`.B.{`...
  2690: 8a 42 55 46 30 0a 0a 48 50 54 30 a0 0f 93 60 0a  .BUF0..HPT0...`.
  26a0: 05 70 0c 00 10 d0 fe 48 50 54 30 a0 0f 93 60 0a  .p.....HPT0...`.
  26b0: 06 70 0c 00 20 d0 fe 48 50 54 30 a0 0f 93 60 0a  .p.. ..HPT0...`.
  26c0: 07 70 0c 00 30 d0 fe 48 50 54 30 a4 42 55 46 30  .p..0..HPT0.BUF0
  26d0: 5b 82 4b 3f 48 5f 45 43 08 5f 48 49 44 0c 41 d0  [.K?H_EC._HID.A.
  26e0: 0c 09 08 5f 55 49 44 0a 01 14 26 5f 43 52 53 00  ..._UID...&_CRS.
  26f0: 08 42 46 46 52 11 15 0a 12 47 01 62 00 62 00 00  .BFFR....G.b.b..
  2700: 01 47 01 66 00 66 00 00 01 79 00 a4 42 46 46 52  .G.f.f...y..BFFR
  2710: 5b 80 45 43 52 5f 03 0a 00 0a ff 5b 81 45 09 45  [.ECR_.....[.E.E
  2720: 43 52 5f 13 00 40 40 42 31 45 58 01 42 32 45 58  CR_..@@B1EX.B2EX
  2730: 01 41 43 45 58 01 00 05 53 57 42 45 01 44 43 42  .ACEX...SWBE.DCB
  2740: 45 01 00 06 00 08 4c 49 44 53 01 00 07 42 31 53  E.....LIDS...B1S
  2750: 54 08 42 32 53 54 08 00 40 0d 42 31 52 52 20 42  T.B2ST..-iWvjK+nTZDc@public.gmane.org B
  2760: 31 50 56 20 42 32 52 52 20 42 32 50 56 20 42 31  1PV B2RR B2PV B1
  2770: 41 46 20 42 31 56 4c 20 42 32 41 46 20 42 32 56  AF B1VL B2AF B2V
  2780: 4c 20 43 54 4d 50 08 00 48 07 42 31 54 49 10 42  L CTMP..H.B1TI.B
  2790: 31 53 45 10 42 31 43 52 10 42 31 54 4d 10 42 32  1SE.B1CR.B1TM.B2
  27a0: 54 49 10 42 32 53 45 10 42 32 43 52 10 42 32 54  TI.B2SE.B2CR.B2T
  27b0: 4d 10 14 35 5f 52 45 47 02 a0 2e 90 93 68 0a 03  M..5_REG.....h..
  27c0: 93 69 0a 01 70 0a 01 45 43 4f 4e 70 5c 2f 05 5f  .i..p..ECONp\/._
  27d0: 53 42 5f 50 43 49 30 4c 50 43 42 48 5f 45 43 41  SB_PCI0LPCBH_ECA
  27e0: 43 45 58 5c 41 43 50 53 08 5f 47 50 45 0a 1c 14  CEX\ACPS._GPE...
  27f0: 08 5f 47 4c 4b 01 a4 01 14 13 5f 51 35 30 00 86  ._GLK....._Q50..
  2800: 5c 2e 5f 53 42 5f 50 57 52 42 0a 80 14 4a 04 5f  \._SB_PWRB...J._
  2810: 51 35 31 00 70 0a 51 50 38 30 48 5c 2e 5f 53 42  Q51.p.QP80H\._SB
  2820: 5f 50 48 53 31 0a 82 0a 01 70 0a 01 5c 41 43 50  _PHS1....p..\ACP
  2830: 53 86 5c 2e 5f 53 42 5f 41 44 50 31 0a 80 5c 2e  S.\._SB_ADP1..\.
  2840: 5f 53 42 5f 50 48 53 5f 0a 95 86 5c 2e 5f 50 52  _SB_PHS_...\._PR
  2850: 5f 43 50 55 30 0a 81 14 4a 04 5f 51 35 32 00 70  _CPU0...J._Q52.p
  2860: 0a 52 50 38 30 48 5c 2e 5f 53 42 5f 50 48 53 31  .RP80H\._SB_PHS1
  2870: 0a 82 0a 00 70 0a 00 5c 41 43 50 53 86 5c 2e 5f  ....p..\ACPS.\._
  2880: 53 42 5f 41 44 50 31 0a 80 5c 2e 5f 53 42 5f 50  SB_ADP1..\._SB_P
  2890: 48 53 5f 0a 94 86 5c 2e 5f 50 52 5f 43 50 55 30  HS_...\._PR_CPU0
  28a0: 0a 81 14 35 5f 51 35 33 00 70 0a 53 50 38 30 48  ...5_Q53.p.SP80H
  28b0: 5c 2e 5f 53 42 5f 50 48 53 31 0a 8f 0a 01 86 5c  \._SB_PHS1.....\
  28c0: 2e 5f 53 42 5f 42 41 54 31 0a 01 86 5c 2e 5f 53  ._SB_BAT1...\._S
  28d0: 42 5f 42 41 54 31 0a 81 14 35 5f 51 35 34 00 70  B_BAT1...5_Q54.p
  28e0: 0a 54 50 38 30 48 5c 2e 5f 53 42 5f 50 48 53 31  .TP80H\._SB_PHS1
  28f0: 0a 8f 0a 00 86 5c 2e 5f 53 42 5f 42 41 54 31 0a  .....\._SB_BAT1.
  2900: 01 86 5c 2e 5f 53 42 5f 42 41 54 31 0a 81 14 13  ..\._SB_BAT1....
  2910: 5f 51 35 42 00 86 5c 2e 5f 53 42 5f 53 4c 50 42  _Q5B..\._SB_SLPB
  2920: 0a 80 14 12 5f 51 35 43 00 5c 2e 5f 53 42 5f 50  ...._Q5C.\._SB_P
  2930: 48 53 5f 0a 83 14 4d 10 5f 51 35 44 00 a0 35 92  HS_...M._Q5D..5.
  2940: 94 4f 53 59 53 0b cf 07 70 0a 3c 53 4d 49 46 70  .OSYS...p.<SMIFp
  2950: 0a 03 56 46 55 4e 70 0a 00 54 52 50 30 86 5c 2f  ..VFUNp..TRP0.\/
  2960: 04 5f 53 42 5f 50 43 49 30 41 47 50 42 4e 56 49  ._SB_PCI0AGPBNVI
  2970: 44 0a 81 a1 4f 0c 70 0a 3c 53 4d 49 46 70 0a 05  D...O.p.<SMIFp..
  2980: 56 46 55 4e 70 0a 00 54 52 50 30 70 53 4d 49 46  VFUNp..TRP0pSMIF
  2990: 60 a0 41 0b 93 0a 00 60 70 0a 3c 53 4d 49 46 70  `.A....`p.<SMIFp
  29a0: 0a 02 56 46 55 4e 70 0a 00 54 52 50 30 a0 1d 92  ..VFUNp..TRP0...
  29b0: 93 43 41 44 4c 50 41 44 4c 86 5c 2e 5f 53 42 5f  .CADLPADL.\._SB_
  29c0: 50 43 49 30 0a 00 5b 22 0b e8 03 a0 39 93 0a 00  PCI0..["....9...
  29d0: 44 53 45 4e a0 30 45 4e 55 4d 70 0a 3c 53 4d 49  DSEN.0ENUMp.<SMI
  29e0: 46 70 0a 04 56 46 55 4e 70 0a 00 54 52 50 30 86  Fp..VFUNp..TRP0.
  29f0: 5c 2f 04 5f 53 42 5f 50 43 49 30 41 47 50 42 4e  \/._SB_PCI0AGPBN
  2a00: 56 49 44 0a 80 a0 33 93 0a 01 44 53 45 4e 70 0a  VID...3...DSENp.
  2a10: 3c 53 4d 49 46 70 0a 03 56 46 55 4e 70 0a 00 54  <SMIFp..VFUNp..T
  2a20: 52 50 30 86 5c 2f 04 5f 53 42 5f 50 43 49 30 41  RP0.\/._SB_PCI0A
  2a30: 47 50 42 4e 56 49 44 0a 81 a0 09 92 95 44 53 45  GPBNVID......DSE
  2a40: 4e 0a 02 14 13 5f 51 35 45 00 86 5c 2e 5f 53 42  N...._Q5E..\._SB
  2a50: 5f 4c 49 44 30 0a 80 14 13 5f 51 35 46 00 86 5c  _LID0...._Q5F..\
  2a60: 2e 5f 53 42 5f 4c 49 44 30 0a 80 14 1c 5f 51 36  ._SB_LID0...._Q6
  2a70: 30 00 a0 15 93 42 31 45 58 0a 01 86 5c 2e 5f 53  0....B1EX...\._S
  2a80: 42 5f 42 41 54 31 0a 01 14 1c 5f 51 36 31 00 a0  B_BAT1...._Q61..
  2a90: 15 93 42 31 45 58 0a 01 86 5c 2e 5f 53 42 5f 42  ..B1EX...\._SB_B
  2aa0: 41 54 31 0a 01 14 13 5f 51 36 35 00 86 5c 2e 5f  AT1...._Q65..\._
  2ab0: 54 5a 5f 54 48 52 4d 0a 80 14 13 5f 51 36 36 00  TZ_THRM...._Q66.
  2ac0: 86 5c 2e 5f 53 42 5f 42 41 54 31 0a 80 5b 82 2e  .\._SB_BAT1..[..
  2ad0: 50 53 32 4b 08 5f 48 49 44 0c 41 d0 03 03 08 5f  PS2K._HID.A...._
  2ae0: 43 52 53 11 19 0a 16 47 01 60 00 60 00 01 01 47  CRS....G.`.`...G
  2af0: 01 64 00 64 00 01 01 23 02 00 01 79 00 5b 82 1e  .d.d...#...y.[..
  2b00: 50 53 32 4d 08 5f 48 49 44 0c 41 d0 0f 13 08 5f  PS2M._HID.A...._
  2b10: 43 52 53 11 09 0a 06 23 00 10 01 79 00 5b 82 40  CRS....#...y.[.@
  2b20: 06 55 53 42 30 08 5f 41 44 52 0c 00 00 1d 00 5b  .USB0._ADR.....[
  2b30: 80 55 30 43 53 02 0a c4 0a 04 5b 81 0b 55 30 43  .U0CS.....[..U0C
  2b40: 53 03 55 30 45 4e 02 14 19 5f 50 53 57 01 a0 09  S.U0EN..._PSW...
  2b50: 68 70 0a 03 55 30 45 4e a1 08 70 0a 00 55 30 45  hp..U0EN..p..U0E
  2b60: 4e 14 09 5f 53 31 44 00 a4 0a 02 14 09 5f 53 33  N.._S1D......_S3
  2b70: 44 00 a4 0a 02 14 09 5f 53 34 44 00 a4 0a 02 5b  D......_S4D....[
  2b80: 82 40 06 55 53 42 31 08 5f 41 44 52 0c 01 00 1d  .-c1o+mxRrqvdnRKCGQkHmKA@public.gmane.org
  2b90: 00 5b 80 55 31 43 53 02 0a c4 0a 04 5b 81 0b 55  .[.U1CS.....[..U
  2ba0: 31 43 53 03 55 31 45 4e 02 14 19 5f 50 53 57 01  1CS.U1EN..._PSW.
  2bb0: a0 09 68 70 0a 03 55 31 45 4e a1 08 70 0a 00 55  ..hp..U1EN..p..U
  2bc0: 31 45 4e 14 09 5f 53 31 44 00 a4 0a 02 14 09 5f  1EN.._S1D......_
  2bd0: 53 33 44 00 a4 0a 02 14 09 5f 53 34 44 00 a4 0a  S3D......_S4D...
  2be0: 02 5b 82 40 06 55 53 42 32 08 5f 41 44 52 0c 02  .[.-tujCLMZP7Js63ADYO7DcFQ@public.gmane.org
  2bf0: 00 1d 00 5b 80 55 32 43 53 02 0a c4 0a 04 5b 81  ...[.U2CS.....[.
  2c00: 0b 55 32 43 53 03 55 32 45 4e 02 14 19 5f 50 53  .U2CS.U2EN..._PS
  2c10: 57 01 a0 09 68 70 0a 03 55 32 45 4e a1 08 70 0a  W...hp..U2EN..p.
  2c20: 00 55 32 45 4e 14 09 5f 53 31 44 00 a4 0a 02 14  .U2EN.._S1D.....
  2c30: 09 5f 53 33 44 00 a4 0a 02 14 09 5f 53 34 44 00  ._S3D......_S4D.
  2c40: a4 0a 02 5b 82 0f 55 53 42 37 08 5f 41 44 52 0c  ...[..USB7._ADR.
  2c50: 07 00 1d 00 08 4e 41 54 41 12 07 01 0c 01 00 1f  .....NATA.......
  2c60: 00 5b 82 42 ec 49 44 45 43 08 5f 41 44 52 0c 01  .[.B.IDEC._ADR..
  2c70: 00 1f 00 5b 80 49 44 45 43 02 0a 40 0a 18 5b 81  ...[.IDEC..-rVxdn2TrCWA@public.gmane.org[.
  2c80: 4f 05 49 44 45 43 03 50 52 49 54 10 53 45 43 54  O.IDEC.PRIT.SECT
  2c90: 10 50 53 49 54 04 53 53 49 54 04 00 18 53 59 4e  .PSIT.SSIT...SYN
  2ca0: 43 04 00 0c 53 44 54 30 02 00 02 53 44 54 31 02  C...SDT0...SDT1.
  2cb0: 00 02 53 44 54 32 02 00 02 53 44 54 33 02 00 42  ..SDT2...SDT3..B
  2cc0: 04 49 43 52 30 04 49 43 52 31 04 49 43 52 32 04  .ICR0.ICR1.ICR2.
  2cd0: 49 43 52 33 04 49 43 52 34 04 49 43 52 35 04 5b  ICR3.ICR4.ICR5.[
  2ce0: 82 41 65 50 52 49 44 08 5f 41 44 52 0a 00 14 49  .AePRID._ADR...I
  2cf0: 14 5f 47 54 4d 00 08 50 42 55 46 11 17 0a 14 00  ._GTM..PBUF.....
  2d00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  2d10: 00 00 00 8a 50 42 55 46 0a 00 50 49 4f 30 8a 50  ....PBUF..PIO0.P
  2d20: 42 55 46 0a 04 44 4d 41 30 8a 50 42 55 46 0a 08  BUF..DMA0.PBUF..
  2d30: 50 49 4f 31 8a 50 42 55 46 0a 0c 44 4d 41 31 8a  PIO1.PBUF..DMA1.
  2d40: 50 42 55 46 0a 10 46 4c 41 47 70 47 45 54 50 50  PBUF..FLAGpGETPP
  2d50: 52 49 54 50 49 4f 30 70 47 44 4d 41 7b 53 59 4e  RITPIO0pGDMA{SYN
  2d60: 43 0a 01 00 7b 49 43 52 33 0a 01 00 7b 49 43 52  C...{ICR3...{ICR
  2d70: 30 0a 01 00 53 44 54 30 7b 49 43 52 31 0a 01 00  0...SDT0{ICR1...
  2d80: 44 4d 41 30 a0 14 93 44 4d 41 30 0c ff ff ff ff  DMA0...DMA0.....
  2d90: 70 50 49 4f 30 44 4d 41 30 a0 2e 7b 50 52 49 54  pPIO0DMA0..{PRIT
  2da0: 0b 00 40 00 a0 14 93 7b 50 52 49 54 0a 90 00 0a  ..-9D9NNryygCw@public.gmane.org{PRIT....
  2db0: 80 70 0b 84 03 50 49 4f 31 a1 0e 70 47 45 54 54  .p...PIO1..pGETT
  2dc0: 50 53 49 54 50 49 4f 31 a1 0b 70 0c ff ff ff ff  PSITPIO1..p.....
  2dd0: 50 49 4f 31 70 47 44 4d 41 7b 53 59 4e 43 0a 02  PIO1pGDMA{SYNC..
  2de0: 00 7b 49 43 52 33 0a 02 00 7b 49 43 52 30 0a 02  .{ICR3...{ICR0..
  2df0: 00 53 44 54 31 7b 49 43 52 31 0a 02 00 44 4d 41  .SDT1{ICR1...DMA
  2e00: 31 a0 14 93 44 4d 41 31 0c ff ff ff ff 70 50 49  1...DMA1.....pPI
  2e10: 4f 31 44 4d 41 31 70 47 45 54 46 7b 53 59 4e 43  O1DMA1pGETF{SYNC
  2e20: 0a 01 00 7b 53 59 4e 43 0a 02 00 50 52 49 54 46  ...{SYNC...PRITF
  2e30: 4c 41 47 a4 50 42 55 46 14 45 2c 5f 53 54 4d 03  LAG.PBUF.E,_STM.
  2e40: 8a 68 0a 00 50 49 4f 30 8a 68 0a 04 44 4d 41 30  .h..PIO0.h..DMA0
  2e50: 8a 68 0a 08 50 49 4f 31 8a 68 0a 0c 44 4d 41 31  .h..PIO1.h..DMA1
  2e60: 8a 68 0a 10 46 4c 41 47 7d 49 43 52 32 0a 04 49  .h..FLAG}ICR2..I
  2e70: 43 52 32 a0 47 12 93 87 69 0b 00 02 7b 50 52 49  CR2.G...i...{PRI
  2e80: 54 0b f0 40 50 52 49 54 7b 53 59 4e 43 0a 0e 53  T..-2Xuijrnunv4@public.gmane.org{SYNC..S
  2e90: 59 4e 43 70 0a 00 53 44 54 30 7b 49 43 52 30 0a  YNCp..SDT0{ICR0.
  2ea0: 0e 49 43 52 30 7b 49 43 52 31 0a 0e 49 43 52 31  .ICR0{ICR1..ICR1
  2eb0: 7b 49 43 52 33 0a 0e 49 43 52 33 7b 49 43 52 35  {ICR3..ICR3{ICR5
  2ec0: 0a 0e 49 43 52 35 8b 69 0a 62 57 34 39 30 8b 69  ..ICR5.i.bW490.i
  2ed0: 0a 6a 57 35 33 30 8b 69 0a 7e 57 36 33 30 8b 69  .jW530.i.~W630.i
  2ee0: 0a 80 57 36 34 30 8b 69 0a b0 57 38 38 30 8b 69  ..W640.i..W880.i
  2ef0: 0a ba 57 39 33 30 7d 50 52 49 54 0b 04 80 50 52  ..W930}PRIT...PR
  2f00: 49 54 a0 1e 90 7b 46 4c 41 47 0a 02 00 7b 57 34  IT...{FLAG...{W4
  2f10: 39 30 0b 00 08 00 7d 50 52 49 54 0a 02 50 52 49  90....}PRIT..PRI
  2f20: 54 7d 50 52 49 54 53 45 54 50 50 49 4f 30 57 35  T}PRITSETPPIO0W5
  2f30: 33 30 57 36 34 30 50 52 49 54 a0 40 06 7b 46 4c  30W640PRIT.-4b8TPpkIZ3Q@public.gmane.org{FL
  2f40: 41 47 0a 01 00 7d 53 59 4e 43 0a 01 53 59 4e 43  AG...}SYNC..SYNC
  2f50: 70 53 44 4d 41 44 4d 41 30 53 44 54 30 a0 13 95  pSDMADMA0SDT0...
  2f60: 44 4d 41 30 0a 1e 7d 49 43 52 33 0a 01 49 43 52  DMA0..}ICR3..ICR
  2f70: 33 a0 13 95 44 4d 41 30 0a 3c 7d 49 43 52 30 0a  3...DMA0.<}ICR0.
  2f80: 01 49 43 52 30 a0 15 7b 57 39 33 30 0b 00 20 00  .ICR0..{W930.. .
  2f90: 7d 49 43 52 31 0a 01 49 43 52 31 a0 42 16 93 87  }ICR1..ICR1.B...
  2fa0: 6a 0b 00 02 7b 50 52 49 54 0b 0f 3f 50 52 49 54  j...{PRIT..?PRIT
  2fb0: 70 0a 00 50 53 49 54 7b 53 59 4e 43 0a 0d 53 59  p..PSIT{SYNC..SY
  2fc0: 4e 43 70 0a 00 53 44 54 31 7b 49 43 52 30 0a 0d  NCp..SDT1{ICR0..
  2fd0: 49 43 52 30 7b 49 43 52 31 0a 0d 49 43 52 31 7b  ICR0{ICR1..ICR1{
  2fe0: 49 43 52 33 0a 0d 49 43 52 33 7b 49 43 52 35 0a  ICR3..ICR3{ICR5.
  2ff0: 0d 49 43 52 35 8b 6a 0a 62 57 34 39 31 8b 6a 0a  .ICR5.j.bW491.j.
  3000: 6a 57 35 33 31 8b 6a 0a 7e 57 36 33 31 8b 6a 0a  jW531.j.~W631.j.
  3010: 80 57 36 34 31 8b 6a 0a b0 57 38 38 31 8b 6a 0a  .W641.j..W881.j.
  3020: ba 57 39 33 31 7d 50 52 49 54 0b 40 80 50 52 49  .W931}PRIT.-0qiSB7ftpHM@public.gmane.org
  3030: 54 a0 1e 90 7b 46 4c 41 47 0a 08 00 7b 57 34 39  T...{FLAG...{W49
  3040: 31 0b 00 08 00 7d 50 52 49 54 0a 20 50 52 49 54  1....}PRIT. PRIT
  3050: a0 4c 04 7b 46 4c 41 47 0a 10 00 7d 50 52 49 54  .L.{FLAG...}PRIT
  3060: 0b 00 40 50 52 49 54 a0 13 94 50 49 4f 31 0a f0  ..-R3FBB1wyRtMUcNwqLg151g@public.gmane.org
  3070: 7d 50 52 49 54 0a 80 50 52 49 54 a1 21 7d 50 52  }PRIT..PRIT.!}PR
  3080: 49 54 0a 10 50 52 49 54 70 53 45 54 54 50 49 4f  IT..PRITpSETTPIO
  3090: 31 57 35 33 31 57 36 34 31 50 53 49 54 a0 40 06  1W531W641PSIT.-4b8TPpkIZ3Q@public.gmane.org
  30a0: 7b 46 4c 41 47 0a 04 00 7d 53 59 4e 43 0a 02 53  {FLAG...}SYNC..S
  30b0: 59 4e 43 70 53 44 4d 41 44 4d 41 31 53 44 54 31  YNCpSDMADMA1SDT1
  30c0: a0 13 95 44 4d 41 31 0a 1e 7d 49 43 52 33 0a 02  ...DMA1..}ICR3..
  30d0: 49 43 52 33 a0 13 95 44 4d 41 31 0a 3c 7d 49 43  ICR3...DMA1.<}IC
  30e0: 52 30 0a 02 49 43 52 30 a0 15 7b 57 39 33 31 0b  R0..ICR0..{W931.
  30f0: 00 20 00 7d 49 43 52 31 0a 02 49 43 52 31 5b 82  . .}ICR1..ICR1[.
  3100: 49 11 50 5f 44 30 08 5f 41 44 52 0a 00 14 40 10  I.P_D0._ADR...-4b8TPpkIZ3Q@public.gmane.org
  3110: 5f 47 54 46 00 08 50 49 42 30 11 11 0a 0e 03 00  _GTF..PIB0......
  3120: 00 00 00 a0 ef 03 00 00 00 00 a0 ef 8c 50 49 42  .............PIB
  3130: 30 0a 01 50 4d 44 30 8c 50 49 42 30 0a 08 44 4d  0..PMD0.PIB0..DM
  3140: 44 30 a0 40 06 7b 50 52 49 54 0a 02 00 a0 13 93  D0.-4b8TPpkIZ3Q@public.gmane.org{PRIT......
  3150: 7b 50 52 49 54 0a 09 00 0a 08 70 0a 08 50 4d 44  {PRIT.....p..PMD
  3160: 30 a1 41 04 70 0a 0a 50 4d 44 30 7a 7b 50 52 49  0.A.p..PMD0z{PRI
  3170: 54 0b 00 03 00 0a 08 60 7a 7b 50 52 49 54 0b 00  T......`z{PRIT..
  3180: 30 00 0a 0c 61 72 60 61 62 a0 0c 93 0a 03 62 70  0...ar`ab.....bp
  3190: 0a 0b 50 4d 44 30 a0 0c 93 0a 05 62 70 0a 0c 50  ..PMD0.....bp..P
  31a0: 4d 44 30 a1 08 70 0a 01 50 4d 44 30 a0 47 04 7b  MD0..p..PMD0.G.{
  31b0: 53 59 4e 43 0a 01 00 70 7d 53 44 54 30 0a 40 00  SYNC...p}SDT0.-4b8TPpkIZ3Q@public.gmane.org
  31c0: 44 4d 44 30 a0 2f 7b 49 43 52 31 0a 01 00 a0 14  DMD0./{ICR1.....
  31d0: 7b 49 43 52 30 0a 01 00 72 44 4d 44 30 0a 02 44  {ICR0...rDMD0..D
  31e0: 4d 44 30 a0 10 7b 49 43 52 33 0a 01 00 70 0a 45  MD0..{ICR3...p.E
  31f0: 44 4d 44 30 a1 14 7d 74 7b 50 4d 44 30 0a 07 00  DMD0..}t{PMD0...
  3200: 0a 02 00 0a 20 44 4d 44 30 a4 50 49 42 30 08 46  .... DMD0.PIB0.F
  3210: 57 53 4f 0d 46 57 53 4f 00 5b 82 49 10 50 5f 44  WSO.FWSO.[.I.P_D
  3220: 31 08 5f 41 44 52 0a 01 14 4b 0f 5f 47 54 46 00  1._ADR...K._GTF.
  3230: 08 50 49 42 31 11 11 0a 0e 03 00 00 00 00 b0 ef  .PIB1...........
  3240: 03 00 00 00 00 b0 ef 8c 50 49 42 31 0a 01 50 4d  ........PIB1..PM
  3250: 44 31 8c 50 49 42 31 0a 08 44 4d 44 31 a0 4b 05  D1.PIB1..DMD1.K.
  3260: 7b 50 52 49 54 0a 20 00 a0 13 93 7b 50 52 49 54  {PRIT. ....{PRIT
  3270: 0a 90 00 0a 80 70 0a 08 50 4d 44 31 a1 3c 72 7b  .....p..PMD1.<r{
  3280: 50 53 49 54 0a 03 00 7a 7b 50 53 49 54 0a 0c 00  PSIT...z{PSIT...
  3290: 0a 02 00 60 a0 0c 93 0a 05 60 70 0a 0c 50 4d 44  ...`.....`p..PMD
  32a0: 31 a1 17 a0 0c 93 0a 03 60 70 0a 0b 50 4d 44 31  1.......`p..PMD1
  32b0: a1 08 70 0a 0a 50 4d 44 31 a1 08 70 0a 01 50 4d  ..p..PMD1..p..PM
  32c0: 44 31 a0 47 04 7b 53 59 4e 43 0a 02 00 70 7d 53  D1.G.{SYNC...p}S
  32d0: 44 54 31 0a 40 00 44 4d 44 31 a0 2f 7b 49 43 52  DT1.-cDEJmm6HT9M@public.gmane.org/{ICR
  32e0: 31 0a 02 00 a0 14 7b 49 43 52 30 0a 02 00 72 44  1.....{ICR0...rD
  32f0: 4d 44 31 0a 02 44 4d 44 31 a0 10 7b 49 43 52 33  MD1..DMD1..{ICR3
  3300: 0a 02 00 70 0a 45 44 4d 44 31 a1 14 7d 74 7b 50  ...p.EDMD1..}t{P
  3310: 4d 44 31 0a 07 00 0a 02 00 0a 20 44 4d 44 31 a4  MD1....... DMD1.
  3320: 50 49 42 31 14 06 5f 50 53 30 00 14 06 5f 50 53  PIB1.._PS0..._PS
  3330: 33 00 5b 82 46 64 53 45 43 44 08 5f 41 44 52 0a  3.[.FdSECD._ADR.
  3340: 01 14 49 14 5f 47 54 4d 00 08 53 42 55 46 11 17  ..I._GTM..SBUF..
  3350: 0a 14 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  3360: 00 00 00 00 00 00 8a 53 42 55 46 0a 00 50 49 4f  .......SBUF..PIO
  3370: 30 8a 53 42 55 46 0a 04 44 4d 41 30 8a 53 42 55  0.SBUF..DMA0.SBU
  3380: 46 0a 08 50 49 4f 31 8a 53 42 55 46 0a 0c 44 4d  F..PIO1.SBUF..DM
  3390: 41 31 8a 53 42 55 46 0a 10 46 4c 41 47 70 47 45  A1.SBUF..FLAGpGE
  33a0: 54 50 53 45 43 54 50 49 4f 30 70 47 44 4d 41 7b  TPSECTPIO0pGDMA{
  33b0: 53 59 4e 43 0a 04 00 7b 49 43 52 33 0a 04 00 7b  SYNC...{ICR3...{
  33c0: 49 43 52 30 0a 04 00 53 44 54 32 7b 49 43 52 31  ICR0...SDT2{ICR1
  33d0: 0a 04 00 44 4d 41 30 a0 14 93 44 4d 41 30 0c ff  ...DMA0...DMA0..
  33e0: ff ff ff 70 50 49 4f 30 44 4d 41 30 a0 2e 7b 53  ...pPIO0DMA0..{S
  33f0: 45 43 54 0b 00 40 00 a0 14 93 7b 53 45 43 54 0a  ECT..-9D9NNryygCw@public.gmane.org{SECT.
  3400: 90 00 0a 80 70 0b 84 03 50 49 4f 31 a1 0e 70 47  ....p...PIO1..pG
  3410: 45 54 54 53 53 49 54 50 49 4f 31 a1 0b 70 0c ff  ETTSSITPIO1..p..
  3420: ff ff ff 50 49 4f 31 70 47 44 4d 41 7b 53 59 4e  ...PIO1pGDMA{SYN
  3430: 43 0a 08 00 7b 49 43 52 33 0a 08 00 7b 49 43 52  C...{ICR3...{ICR
  3440: 30 0a 08 00 53 44 54 33 7b 49 43 52 31 0a 08 00  0...SDT3{ICR1...
  3450: 44 4d 41 31 a0 14 93 44 4d 41 31 0c ff ff ff ff  DMA1...DMA1.....
  3460: 70 50 49 4f 31 44 4d 41 31 70 47 45 54 46 7b 53  pPIO1DMA1pGETF{S
  3470: 59 4e 43 0a 04 00 7b 53 59 4e 43 0a 08 00 53 45  YNC...{SYNC...SE
  3480: 43 54 46 4c 41 47 a4 53 42 55 46 14 45 2c 5f 53  CTFLAG.SBUF.E,_S
  3490: 54 4d 03 8a 68 0a 00 50 49 4f 30 8a 68 0a 04 44  TM..h..PIO0.h..D
  34a0: 4d 41 30 8a 68 0a 08 50 49 4f 31 8a 68 0a 0c 44  MA0.h..PIO1.h..D
  34b0: 4d 41 31 8a 68 0a 10 46 4c 41 47 7d 49 43 52 32  MA1.h..FLAG}ICR2
  34c0: 0a 04 49 43 52 32 a0 47 12 93 87 69 0b 00 02 7b  ..ICR2.G...i...{
  34d0: 53 45 43 54 0b f0 40 53 45 43 54 7b 53 59 4e 43  SECT..-rEp6QHzXslU@public.gmane.org{SYNC
  34e0: 0a 0b 53 59 4e 43 70 0a 00 53 44 54 32 7b 49 43  ..SYNCp..SDT2{IC
  34f0: 52 30 0a 0b 49 43 52 30 7b 49 43 52 31 0a 0b 49  R0..ICR0{ICR1..I
  3500: 43 52 31 7b 49 43 52 33 0a 0b 49 43 52 33 7b 49  CR1{ICR3..ICR3{I
  3510: 43 52 35 0a 0b 49 43 52 35 8b 69 0a 62 57 34 39  CR5..ICR5.i.bW49
  3520: 30 8b 69 0a 6a 57 35 33 30 8b 69 0a 7e 57 36 33  0.i.jW530.i.~W63
  3530: 30 8b 69 0a 80 57 36 34 30 8b 69 0a b0 57 38 38  0.i..W640.i..W88
  3540: 30 8b 69 0a ba 57 39 33 30 7d 53 45 43 54 0b 04  0.i..W930}SECT..
  3550: 80 53 45 43 54 a0 1e 90 7b 46 4c 41 47 0a 02 00  .SECT...{FLAG...
  3560: 7b 57 34 39 30 0b 00 08 00 7d 53 45 43 54 0a 02  {W490....}SECT..
  3570: 53 45 43 54 7d 53 45 43 54 53 45 54 50 50 49 4f  SECT}SECTSETPPIO
  3580: 30 57 35 33 30 57 36 34 30 53 45 43 54 a0 40 06  0W530W640SECT.-4b8TPpkIZ3Q@public.gmane.org
  3590: 7b 46 4c 41 47 0a 01 00 7d 53 59 4e 43 0a 04 53  {FLAG...}SYNC..S
  35a0: 59 4e 43 70 53 44 4d 41 44 4d 41 30 53 44 54 32  YNCpSDMADMA0SDT2
  35b0: a0 13 95 44 4d 41 30 0a 1e 7d 49 43 52 33 0a 04  ...DMA0..}ICR3..
  35c0: 49 43 52 33 a0 13 95 44 4d 41 30 0a 3c 7d 49 43  ICR3...DMA0.<}IC
  35d0: 52 30 0a 04 49 43 52 30 a0 15 7b 57 39 33 30 0b  R0..ICR0..{W930.
  35e0: 00 20 00 7d 49 43 52 31 0a 04 49 43 52 31 a0 42  . .}ICR1..ICR1.B
  35f0: 16 93 87 6a 0b 00 02 7b 53 45 43 54 0b 0f 3f 53  ...j...{SECT..?S
  3600: 45 43 54 70 0a 00 53 53 49 54 7b 53 59 4e 43 0a  ECTp..SSIT{SYNC.
  3610: 07 53 59 4e 43 70 0a 00 53 44 54 33 7b 49 43 52  .SYNCp..SDT3{ICR
  3620: 30 0a 07 49 43 52 30 7b 49 43 52 31 0a 07 49 43  0..ICR0{ICR1..IC
  3630: 52 31 7b 49 43 52 33 0a 07 49 43 52 33 7b 49 43  R1{ICR3..ICR3{IC
  3640: 52 35 0a 07 49 43 52 35 8b 6a 0a 62 57 34 39 31  R5..ICR5.j.bW491
  3650: 8b 6a 0a 6a 57 35 33 31 8b 6a 0a 7e 57 36 33 31  .j.jW531.j.~W631
  3660: 8b 6a 0a 80 57 36 34 31 8b 6a 0a b0 57 38 38 31  .j..W641.j..W881
  3670: 8b 6a 0a ba 57 39 33 31 7d 53 45 43 54 0b 40 80  .j..W931}SECT.-4b8TPpkIZ3Q@public.gmane.org
  3680: 53 45 43 54 a0 1e 90 7b 46 4c 41 47 0a 08 00 7b  SECT...{FLAG...{
  3690: 57 34 39 31 0b 00 08 00 7d 53 45 43 54 0a 20 53  W491....}SECT. S
  36a0: 45 43 54 a0 4c 04 7b 46 4c 41 47 0a 10 00 7d 53  ECT.L.{FLAG...}S
  36b0: 45 43 54 0b 00 40 53 45 43 54 a0 13 94 50 49 4f  ECT..-9D9euU5CxHFZniD/+SkqNA@public.gmane.org
  36c0: 31 0a f0 7d 53 45 43 54 0a 80 53 45 43 54 a1 21  1..}SECT..SECT.!
  36d0: 7d 53 45 43 54 0a 10 53 45 43 54 70 53 45 54 54  }SECT..SECTpSETT
  36e0: 50 49 4f 31 57 35 33 31 57 36 34 31 53 53 49 54  PIO1W531W641SSIT
  36f0: a0 40 06 7b 46 4c 41 47 0a 04 00 7d 53 59 4e 43  .-4b8TPpkIZ3Q@public.gmane.org{FLAG...}SYNC
  3700: 0a 08 53 59 4e 43 70 53 44 4d 41 44 4d 41 31 53  ..SYNCpSDMADMA1S
  3710: 44 54 33 a0 13 95 44 4d 41 31 0a 1e 7d 49 43 52  DT3...DMA1..}ICR
  3720: 33 0a 08 49 43 52 33 a0 13 95 44 4d 41 31 0a 3c  3..ICR3...DMA1.<
  3730: 7d 49 43 52 30 0a 08 49 43 52 30 a0 15 7b 57 39  }ICR0..ICR0..{W9
  3740: 33 31 0b 00 20 00 7d 49 43 52 31 0a 08 49 43 52  31.. .}ICR1..ICR
  3750: 31 5b 82 4e 10 53 5f 44 30 08 5f 41 44 52 0a 00  1[.N.S_D0._ADR..
  3760: 14 40 10 5f 47 54 46 00 08 53 49 42 30 11 11 0a  .-6udDSWIYFU4Vlv8pF8/cFw@public.gmane.org
  3770: 0e 03 00 00 00 00 a0 ef 03 00 00 00 00 a0 ef 8c  ................
  3780: 53 49 42 30 0a 01 50 4d 44 30 8c 53 49 42 30 0a  SIB0..PMD0.SIB0.
  3790: 08 44 4d 44 30 a0 40 06 7b 53 45 43 54 0a 02 00  .DMD0.-4b8TPpkIZ3Q@public.gmane.org{SECT...
  37a0: a0 13 93 7b 53 45 43 54 0a 09 00 0a 08 70 0a 08  ...{SECT.....p..
  37b0: 50 4d 44 30 a1 41 04 70 0a 0a 50 4d 44 30 7a 7b  PMD0.A.p..PMD0z{
  37c0: 53 45 43 54 0b 00 03 00 0a 08 60 7a 7b 53 45 43  SECT......`z{SEC
  37d0: 54 0b 00 30 00 0a 0c 61 72 60 61 62 a0 0c 93 0a  T..0...ar`ab....
  37e0: 03 62 70 0a 0b 50 4d 44 30 a0 0c 93 0a 05 62 70  .bp..PMD0.....bp
  37f0: 0a 0c 50 4d 44 30 a1 08 70 0a 01 50 4d 44 30 a0  ..PMD0..p..PMD0.
  3800: 47 04 7b 53 59 4e 43 0a 04 00 70 7d 53 44 54 32  G.{SYNC...p}SDT2
  3810: 0a 40 00 44 4d 44 30 a0 2f 7b 49 43 52 31 0a 04  .-Bp4WBFZxkXI@public.gmane.org/{ICR1..
  3820: 00 a0 14 7b 49 43 52 30 0a 04 00 72 44 4d 44 30  ...{ICR0...rDMD0
  3830: 0a 02 44 4d 44 30 a0 10 7b 49 43 52 33 0a 04 00  ..DMD0..{ICR3...
  3840: 70 0a 45 44 4d 44 30 a1 14 7d 74 7b 50 4d 44 30  p.EDMD0..}t{PMD0
  3850: 0a 07 00 0a 02 00 0a 20 44 4d 44 30 a4 53 49 42  ....... DMD0.SIB
  3860: 30 5b 82 49 10 53 5f 44 31 08 5f 41 44 52 0a 01  0[.I.S_D1._ADR..
  3870: 14 4b 0f 5f 47 54 46 00 08 53 49 42 31 11 11 0a  .K._GTF..SIB1...
  3880: 0e 03 00 00 00 00 b0 ef 03 00 00 00 00 b0 ef 8c  ................
  3890: 53 49 42 31 0a 01 50 4d 44 31 8c 53 49 42 31 0a  SIB1..PMD1.SIB1.
  38a0: 08 44 4d 44 31 a0 4b 05 7b 53 45 43 54 0a 20 00  .DMD1.K.{SECT. .
  38b0: a0 13 93 7b 53 45 43 54 0a 90 00 0a 80 70 0a 08  ...{SECT.....p..
  38c0: 50 4d 44 31 a1 3c 72 7b 53 53 49 54 0a 03 00 7a  PMD1.<r{SSIT...z
  38d0: 7b 53 53 49 54 0a 0c 00 0a 02 00 60 a0 0c 93 0a  {SSIT......`....
  38e0: 05 60 70 0a 0c 50 4d 44 31 a1 17 a0 0c 93 0a 03  .`p..PMD1.......
  38f0: 60 70 0a 0b 50 4d 44 31 a1 08 70 0a 0a 50 4d 44  `p..PMD1..p..PMD
  3900: 31 a1 08 70 0a 01 50 4d 44 31 a0 47 04 7b 53 59  1..p..PMD1.G.{SY
  3910: 4e 43 0a 08 00 70 7d 53 44 54 33 0a 40 00 44 4d  NC...p}SDT3.-S/zr7nwKMMQ@public.gmane.org
  3920: 44 31 a0 2f 7b 49 43 52 31 0a 08 00 a0 14 7b 49  D1./{ICR1.....{I
  3930: 43 52 30 0a 08 00 72 44 4d 44 31 0a 02 44 4d 44  CR0...rDMD1..DMD
  3940: 31 a0 10 7b 49 43 52 33 0a 08 00 70 0a 45 44 4d  1..{ICR3...p.EDM
  3950: 44 31 a1 14 7d 74 7b 50 4d 44 31 0a 07 00 0a 02  D1..}t{PMD1.....
  3960: 00 0a 20 44 4d 44 31 a4 53 49 42 31 14 06 5f 50  .. DMD1.SIB1.._P
  3970: 53 30 00 14 06 5f 50 53 33 00 14 46 04 47 45 54  S0..._PS3..F.GET
  3980: 50 09 a0 0f 93 7b 68 0a 09 00 0a 00 a4 0c ff ff  P....{h.........
  3990: ff ff a0 0d 93 7b 68 0a 09 00 0a 08 a4 0b 84 03  .....{h.........
  39a0: 7a 7b 68 0b 00 03 00 0a 08 60 7a 7b 68 0b 00 30  z{h......`z{h..0
  39b0: 00 0a 0c 61 a4 77 0a 1e 74 0a 09 72 60 61 00 00  ...a.w..t..r`a..
  39c0: 00 14 30 47 44 4d 41 0d a0 23 68 a0 07 90 69 6c  ..0GDMA..#h...il
  39d0: a4 0a 14 a0 0e 90 6a 6c a4 77 74 0a 04 6b 00 0a  ......jl.wt..k..
  39e0: 0f 00 a4 77 74 0a 04 6b 00 0a 1e 00 a4 0c ff ff  ...wt..k........
  39f0: ff ff 14 1f 47 45 54 54 09 a4 77 0a 1e 74 0a 09  ....GETT..w..t..
  3a00: 72 7b 7a 68 0a 02 00 0a 03 00 7b 68 0a 03 00 00  r{zh......{h....
  3a10: 00 00 14 46 06 47 45 54 46 0b 08 54 4d 50 46 0a  ...F.GETF..TMPF.
  3a20: 00 a0 0d 68 7d 54 4d 50 46 0a 01 54 4d 50 46 a0  ...h}TMPF..TMPF.
  3a30: 11 7b 6a 0a 02 00 7d 54 4d 50 46 0a 02 54 4d 50  .{j...}TMPF..TMP
  3a40: 46 a0 0d 69 7d 54 4d 50 46 0a 04 54 4d 50 46 a0  F..i}TMPF..TMPF.
  3a50: 11 7b 6a 0a 20 00 7d 54 4d 50 46 0a 08 54 4d 50  .{j. .}TMPF..TMP
  3a60: 46 a0 12 7b 6a 0b 00 40 00 7d 54 4d 50 46 0a 10  F..{j..-4b8TPpkIZ3Q@public.gmane.org}TMPF..
  3a70: 54 4d 50 46 a4 54 4d 50 46 14 3e 53 45 54 50 0b  TMPF.TMPF.>SETP.
  3a80: a0 08 94 68 0a f0 a4 0a 08 a1 2e a0 28 7b 69 0a  ...h........({i.
  3a90: 02 00 a0 10 90 92 94 68 0a 78 7b 6a 0a 02 00 a4  .......h.x{j....
  3aa0: 0b 01 23 a0 10 90 92 94 68 0a b4 7b 6a 0a 01 00  ..#.....h..{j...
  3ab0: a4 0b 01 21 a4 0b 01 10 14 3b 53 44 4d 41 09 a0  ...!.....;SDMA..
  3ac0: 09 92 94 68 0a 14 a4 0a 01 a0 09 92 94 68 0a 1e  ...h.........h..
  3ad0: a4 0a 02 a0 09 92 94 68 0a 2d a4 0a 01 a0 09 92  .......h.-......
  3ae0: 94 68 0a 3c a4 0a 02 a0 09 92 94 68 0a 5a a4 0a  .h.<.......h.Z..
  3af0: 01 a4 0a 00 14 30 53 45 54 54 0b a0 26 7b 69 0a  .....0SETT..&{i.
  3b00: 02 00 a0 0f 90 92 94 68 0a 78 7b 6a 0a 02 00 a4  .......h.x{j....
  3b10: 0a 0b a0 0f 90 92 94 68 0a b4 7b 6a 0a 01 00 a4  .......h..{j....
  3b20: 0a 09 a4 0a 04 5b 82 44 0e 53 42 55 53 08 5f 41  .....[.D.SBUS._A
  3b30: 44 52 0c 03 00 1f 00 5b 80 53 42 55 53 01 0b 60  DR.....[.SBUS..`
  3b40: 18 0a 10 5b 81 37 53 42 55 53 01 48 53 54 53 08  ...[.7SBUS.HSTS.
  3b50: 00 08 48 43 4f 4e 08 48 43 4f 4d 08 54 58 53 41  ..HCON.HCOM.TXSA
  3b60: 08 44 41 54 30 08 44 41 54 31 08 42 44 42 52 08  .DAT0.DAT1.BDBR.
  3b70: 00 08 52 58 53 41 08 53 44 41 54 10 14 45 04 53  ..RXSA.SDAT..E.S
  3b80: 42 57 42 03 a2 09 7b 48 53 54 53 0a 01 00 70 0a  BWB...{HSTS...p.
  3b90: 1e 48 53 54 53 70 68 54 58 53 41 70 69 48 43 4f  .HSTSphTXSApiHCO
  3ba0: 4d 70 6a 44 41 54 30 70 0a 48 48 43 4f 4e a2 0c  MpjDAT0p.HHCON..
  3bb0: 93 7b 48 53 54 53 0a 1e 00 0a 00 70 0a 1e 48 53  .{HSTS.....p..HS
  3bc0: 54 53 14 48 04 53 42 52 42 02 a2 09 7b 48 53 54  TS.H.SBRB...{HST
  3bd0: 53 0a 01 00 70 0a 1e 48 53 54 53 70 7d 68 0a 01  S...p..HSTSp}h..
  3be0: 00 54 58 53 41 70 69 48 43 4f 4d 70 0a 48 48 43  .TXSApiHCOMp.HHC
  3bf0: 4f 4e a2 0c 93 7b 48 53 54 53 0a 1e 00 0a 00 70  ON...{HSTS.....p
  3c00: 0a 1e 48 53 54 53 a4 44 41 54 30 5b 82 0f 41 55  ..HSTS.DAT0[..AU
  3c10: 44 30 08 5f 41 44 52 0c 05 00 1f 00 5b 82 1b 4d  D0._ADR.....[..M
  3c20: 4f 44 4d 08 5f 41 44 52 0c 06 00 1f 00 08 5f 50  ODM._ADR......_P
  3c30: 52 57 12 06 02 0a 05 0a 04                       RW.......

FACS @ 0x1ff7cfc0
  0000: 46 41 43 53 40 00 00 00 fc 12 00 00 00 00 00 00  FACS-BlbsxGdv4A7jshiNgxcy3g@public.gmane.org
  0010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  0020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  0030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................

BOOT @ 0x1ff7bfd8
  0000: 42 4f 4f 54 28 00 00 00 01 73 53 45 4e 53 58 20  BOOT(....sSENSX 
  0010: 24 53 42 46 54 42 4c 24 00 00 04 06 53 45 4e 53  $SBFTBL$....SENS
  0020: 01 00 00 00 36 00 00 00                          ....6...

SSDT @ 0x1ff77f16
  0000: 53 53 44 54 8a 02 00 00 01 09 49 4e 54 45 4c 00  SSDT......INTEL.
  0010: 45 49 53 54 52 65 66 00 00 20 00 00 49 4e 54 4c  EISTRef.. ..INTL
  0020: 44 20 01 02 10 44 26 5c 2e 5f 50 52 5f 43 50 55  D ...D&\._PR_CPU
  0030: 30 14 08 5f 50 50 43 00 a4 00 08 50 44 43 30 0c  0.._PPC....PDC0.
  0040: 00 00 00 f0 14 17 5f 50 44 43 01 8a 68 0a 08 43  ......_PDC..h..C
  0050: 41 50 30 70 43 41 50 30 50 44 43 30 14 40 07 5f  AP0pCAP0PDC0.-k+F0d9mFdQs@public.gmane.org
  0060: 50 43 54 00 a0 38 93 7b 50 44 43 30 01 00 01 a4  PCT..8.{PDC0....
  0070: 12 2c 02 11 14 0a 11 82 0c 00 7f 00 00 00 00 00  .,..............
  0080: 00 00 00 00 00 00 79 00 11 14 0a 11 82 0c 00 7f  ......y.........
  0090: 00 00 00 00 00 00 00 00 00 00 00 79 00 a1 2f a4  ...........y../.
  00a0: 12 2c 02 11 14 0a 11 82 0c 00 01 10 00 00 b2 00  .,..............
  00b0: 00 00 00 00 00 00 79 00 11 14 0a 11 82 0c 00 01  ......y.........
  00c0: 08 00 00 b3 00 00 00 00 00 00 00 79 00 14 1d 5f  ...........y..._
  00d0: 50 53 53 00 a0 0f 93 7b 50 44 43 30 01 00 01 a4  PSS....{PDC0....
  00e0: 4e 50 53 53 a1 06 a4 53 50 53 53 08 4e 50 53 53  NPSS...SPSS.NPSS
  00f0: 12 49 0c 06 12 20 06 0c a4 06 00 00 0c b4 5f 00  .I... ........_.
  0100: 00 0c 0a 00 00 00 0c 0a 00 00 00 0c 31 11 00 00  ............1...
  0110: 0c 31 11 00 00 12 20 06 0c 78 05 00 00 0c 2c 4c  .1.... ..x....,L
  0120: 00 00 0c 0a 00 00 00 0c 0a 00 00 00 0c 26 0e 00  .............&..
  0130: 00 0c 26 0e 00 00 12 20 06 0c b0 04 00 00 0c 80  ..&.... ........
  0140: 3e 00 00 0c 0a 00 00 00 0c 0a 00 00 00 0c 21 0c  >.............!.
  0150: 00 00 0c 21 0c 00 00 12 20 06 0c e8 03 00 00 0c  ...!.... .......
  0160: c8 32 00 00 0c 0a 00 00 00 0c 0a 00 00 00 0c 1a  .2..............
  0170: 0a 00 00 0c 1a 0a 00 00 12 20 06 0c 20 03 00 00  ......... .. ...
  0180: 0c 1c 25 00 00 0c 0a 00 00 00 0c 0a 00 00 00 0c  ..%.............
  0190: 13 08 00 00 0c 13 08 00 00 12 20 06 0c 58 02 00  .......... ..X..
  01a0: 00 0c 70 17 00 00 0c 0a 00 00 00 0c 0a 00 00 00  ..p.............
  01b0: 0c 10 06 00 00 0c 10 06 00 00 08 53 50 53 53 12  ...........SPSS.
  01c0: 49 0c 06 12 20 06 0c a4 06 00 00 0c b4 5f 00 00  I... ........_..
  01d0: 0c 64 00 00 00 0c 6e 00 00 00 0c 83 00 00 00 0c  .d....n.........
  01e0: 00 00 00 00 12 20 06 0c 78 05 00 00 0c 2c 4c 00  ..... ..x....,L.
  01f0: 00 0c 64 00 00 00 0c 6e 00 00 00 0c 83 01 00 00  ..d....n........
  0200: 0c 01 00 00 00 12 20 06 0c b0 04 00 00 0c 80 3e  ...... ........>
  0210: 00 00 0c 64 00 00 00 0c 6e 00 00 00 0c 83 02 00  ...d....n.......
  0220: 00 0c 02 00 00 00 12 20 06 0c e8 03 00 00 0c c8  ....... ........
  0230: 32 00 00 0c 64 00 00 00 0c 6e 00 00 00 0c 83 03  2...d....n......
  0240: 00 00 0c 03 00 00 00 12 20 06 0c 20 03 00 00 0c  ........ .. ....
  0250: 1c 25 00 00 0c 64 00 00 00 0c 6e 00 00 00 0c 83  .%...d....n.....
  0260: 04 00 00 0c 04 00 00 00 12 20 06 0c 58 02 00 00  ......... ..X...
  0270: 0c 70 17 00 00 0c 64 00 00 00 0c 6e 00 00 00 0c  .p....d....n....
  0280: 83 05 00 00 0c 05 00 00 00 12                    ..........


--=-hIbk9fTgo4t4OqvX1TQn
Content-Disposition: attachment; filename=dsdt.dsl.x10
Content-Type: text/plain; name=dsdt.dsl.x10; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

/*
 * Intel ACPI Component Architecture
 * AML Disassembler version 20030918
 *
 * Disassembly of /tmp/dsdt.dsl, Fri Dec 19 15:02:34 2003
 */
DefinitionBlock ("DSDT.aml", "DSDT", 1, "SENSX ", "AQUILA  ", 100925440)
{
    OperationRegion (PORT, SystemIO, 0x80, 0x01)
    Field (PORT, ByteAcc, NoLock, Preserve)
    {
        P80H,   8
    }

    OperationRegion (IO_T, SystemIO, 0x0800, 0x08)
    Field (IO_T, ByteAcc, NoLock, Preserve)
    {
        TRP0,   8
    }

    OperationRegion (GPIO, SystemIO, 0x1180, 0x3C)
    Field (GPIO, ByteAcc, NoLock, Preserve)
    {
        GU00,   8, 
        GU01,   8, 
        GU02,   8, 
        GU03,   8, 
        GIO0,   8, 
        GIO1,   8, 
        GIO2,   8, 
        GIO3,   8, 
        Offset (0x0C), 
        GL00,   8, 
        GL01,   8, 
        GL02,   8, 
        GL03,   8, 
        Offset (0x18), 
        GB00,   8, 
        GB01,   8, 
        GB02,   8, 
        GB03,   8, 
        Offset (0x2C), 
        GIV0,   8, 
        GIV1,   8, 
        GIV2,   8, 
        GIV3,   8, 
        GU04,   8, 
        GU05,   8, 
        GU06,   8, 
        GU07,   8, 
        GIO4,   8, 
        GIO5,   8, 
        GIO6,   8, 
        GIO7,   8, 
            ,   1, 
            ,   1, 
        CPEN,   1, 
        Offset (0x39), 
        GL05,   8, 
        GL06,   8, 
        GL07,   8
    }

    OperationRegion (MNVS, SystemMemory, 0x1FF7CD7D, 0x40)
    Field (MNVS, AnyAcc, Lock, Preserve)
    {
        OSYS,   16, 
        SMIF,   8, 
        SCIF,   8, 
        ACPS,   8, 
        DBGS,   8, 
        DCKS,   4, 
        CDCK,   4, 
        FPST,   8, 
        LIDS,   8, 
        FPEN,   8, 
        Offset (0x0B), 
        Offset (0x10), 
        CMAP,   8, 
        CMBP,   8, 
        LPTP,   8, 
        FDCP,   8, 
        Offset (0x18), 
        ACTT,   8, 
        PSVT,   8, 
        TC1V,   8, 
        TC2V,   8, 
        TSPV,   8, 
        CRTT,   8, 
        Offset (0x20), 
        BVAL,   32, 
        TMP0,   8, 
        TMP1,   8, 
        TMP2,   8, 
        CPWR,   8, 
        TMP4,   32, 
        TMP5,   32, 
        VFUN,   16, 
        CSTE,   16, 
        NSTE,   16, 
        SSTE,   16, 
        CADL,   16, 
        PADL,   16
    }

    OperationRegion (IDE0, SystemIO, 0x01F0, 0x08)
    Field (IDE0, ByteAcc, NoLock, Preserve)
    {
        I1F0,   8, 
        I1F1,   8, 
        I1F2,   8, 
        I1F3,   8, 
        I1F4,   8, 
        I1F5,   8, 
        I1F6,   8, 
        I1F7,   8
    }

    Field (IDE0, WordAcc, NoLock, Preserve)
    {
        W1F0,   16
    }

    OperationRegion (NV1, SystemIO, 0x72, 0x02)
    Field (NV1, ByteAcc, NoLock, Preserve)
    {
        N1I,    8, 
        N1D,    8
    }

    Mutex (MUTX, 0x00)
    Name (_S0, Package (0x03)
    {
        0x00, 
        0x00, 
        0x00
    })
    Name (_S3, Package (0x03)
    {
        0x05, 
        0x05, 
        0x00
    })
    Name (_S4, Package (0x03)
    {
        0x06, 
        0x06, 
        0x00
    })
    Name (_S5, Package (0x03)
    {
        0x07, 
        0x07, 
        0x00
    })
    Scope (\_PR)
    {
        Processor (CPU0, 0x00, 0x00001010, 0x06)
        {
            Method (_CST, 0, NotSerialized)
            {
                If (ACPS)
                {
                    Return (Package (0x04)
                    {
                        0x03, 
                        Package (0x04)
                        {
                            ResourceTemplate ()
                            {
                                Register (FFixedHW, 0x08, 0x00, 0x0000000000000000)
                            }, 

                            0x01, 
                            0x01, 
                            0x03E8
                        }, 

                        Package (0x04)
                        {
                            ResourceTemplate ()
                            {
                                Register (SystemIO, 0x08, 0x00, 0x0000000000001014)
                            }, 

                            0x02, 
                            0x01, 
                            0x01F4
                        }, 

                        Package (0x04)
                        {
                            ResourceTemplate ()
                            {
                                Register (SystemIO, 0x08, 0x00, 0x0000000000001015)
                            }, 

                            0x03, 
                            0x55, 
                            0xFA
                        }
                    })
                }
                Else
                {
                    If (CPWR)
                    {
                        Return (Package (0x05)
                        {
                            0x04, 
                            Package (0x04)
                            {
                                ResourceTemplate ()
                                {
                                    Register (FFixedHW, 0x08, 0x00, 0x0000000000000000)
                                }, 

                                0x01, 
                                0x01, 
                                0x03E8
                            }, 

                            Package (0x04)
                            {
                                ResourceTemplate ()
                                {
                                    Register (SystemIO, 0x08, 0x00, 0x0000000000001014)
                                }, 

                                0x02, 
                                0x01, 
                                0x01F4
                            }, 

                            Package (0x04)
                            {
                                ResourceTemplate ()
                                {
                                    Register (SystemIO, 0x08, 0x00, 0x0000000000001015)
                                }, 

                                0x03, 
                                0x55, 
                                0xFA
                            }, 

                            Package (0x04)
                            {
                                ResourceTemplate ()
                                {
                                    Register (SystemIO, 0x08, 0x00, 0x0000000000001016)
                                }, 

                                0x03, 
                                0xB9, 
                                0x64
                            }
                        })
                    }
                    Else
                    {
                        Return (Package (0x03)
                        {
                            0x02, 
                            Package (0x04)
                            {
                                ResourceTemplate ()
                                {
                                    Register (FFixedHW, 0x08, 0x00, 0x0000000000000000)
                                }, 

                                0x01, 
                                0x01, 
                                0x03E8
                            }, 

                            Package (0x04)
                            {
                                ResourceTemplate ()
                                {
                                    Register (SystemIO, 0x08, 0x00, 0x0000000000001014)
                                }, 

                                0x02, 
                                0x01, 
                                0x01F4
                            }
                        })
                    }
                }
            }
        }
    }

    Name (\GPIC, 0x00)
    Name (\CTYP, 0x00)
    Name (\ECON, 0x00)
    Name (\DSEN, 0x00)
    Name (\ENUM, 0x01)
    Name (\LFCA, 0x00)
    Name (\RECA, 0x00)
    Method (\_PIC, 1, NotSerialized)
    {
        Store (Arg0, GPIC)
    }

    Method (_PTS, 1, NotSerialized)
    {
        Store (Arg0, P80H)
    }

    Method (_WAK, 1, NotSerialized)
    {
        Store (\_SB.PCI0.LPCB.H_EC.ACEX, \ACPS)
        If (\ACPS)
        {
            \_SB.PHS (0x95)
        }
        Else
        {
            \_SB.PHS (0x94)
        }

        If (LEqual (Arg0, 0x03))
        {
            \_SB.PHS (0x8A)
            If (LEqual (OSYS, 0x07CE))
            {
                Notify (\_SB.PWRB, 0x02)
            }
        }

        Notify (\_PR.CPU0, 0x81)
	Return(Package(0x02){0x00, 0x00})
    }

    Scope (\_GPE)
    {
        Method (_L05, 0, NotSerialized)
        {
            Notify (\_SB.PCI0.MODM, 0x02)
            Notify (\_SB.PWRB, 0x02)
        }

        Method (_L0B, 0, NotSerialized)
        {
            Notify (\_SB.PCI0.PCIB, 0x02)
            Notify (\_SB.PWRB, 0x02)
            Store (0x01, \_SB.PCI0.PCIB.CDB0.PMES)
            Store (0x01, \_SB.PCI0.PCIB.CDB1.PMES)
        }

        Method (_L1D, 0, NotSerialized)
        {
            Store (\_SB.PHS1 (0x8E, 0x00), Local0)
            If (LEqual (Local0, 0x01))
            {
                Notify (\_SB.PWRB, 0x02)
            }

            If (LEqual (Local0, 0x02))
            {
                Notify (\_SB.PWRB, 0x02)
            }

            If (LEqual (OSYS, 0x07CE))
            {
                \_SB.PHS (0x93)
            }
        }
    }

    Scope (\_TZ)
    {
        ThermalZone (THRM)
        {
            Method (_TMP, 0, NotSerialized)
            {
                If (LEqual (\ECON, 0x01))
                {
                    Store (\_SB.PCI0.LPCB.H_EC.CTMP, Local0)
                    If (LNot (LEqual (Local0, 0xFF)))
                    {
                        Multiply (Local0, 0x0A, Local0)
                        Add (Local0, 0x0AAC, Local0)
                        Return (Local0)
                    }
                }

                Return (0x0C1C)
            }

            Method (_AC0, 0, NotSerialized)
            {
                Store (0x41, Local0)
                Multiply (Local0, 0x0A, Local0)
                Add (Local0, 0x0AAC, Local0)
                Return (Local0)
            }

            Name (_AL0, Package (0x01)
            {
                FAN0
            })
            Method (XPSV, 0, NotSerialized)
            {
                Store (0x78, Local0)
                Multiply (Local0, 0x0A, Local0)
                Add (Local0, 0x0AAC, Local0)
                Return (Local0)
            }

            Name (XPSL, Package (0x01)
            {
                \_PR.CPU0
            })
            Method (_CRT, 0, NotSerialized)
            {
                Store (0x78, Local0)
                Multiply (Local0, 0x0A, Local0)
                Add (Local0, 0x0AAC, Local0)
                Return (Local0)
            }

            Method (_SCP, 1, NotSerialized)
            {
                Store ("Not Support", Debug)
            }

            Name (_TC1, 0x04)
            Name (_TC2, 0x03)
            Name (_TSP, 0x012C)
        }
    }

    PowerResource (PFAN, 0x00, 0x0000)
    {
        Method (_STA, 0, NotSerialized)
        {
            Return (FANE)
        }

        Method (_ON, 0, NotSerialized)
        {
            Store (0x01, FANE)
        }

        Method (_OFF, 0, NotSerialized)
        {
            Store (0x00, FANE)
        }
    }

    Name (FANE, 0x01)
    Device (FAN0)
    {
        Name (_HID, EisaId ("PNP0C0B"))
        Name (_PR0, Package (0x01)
        {
            PFAN
        })
    }

    Scope (\_SB)
    {
        Device (ADP1)
        {
            Name (_HID, "ACPI0003")
            Method (_PSR, 0, NotSerialized)
            {
                If (LEqual (\ECON, 0x00))
                {
                    Store (\_SB.PHS1 (0x81, 0x02), Local0)
                }
                Else
                {
                    Store (\_SB.PCI0.LPCB.H_EC.ACEX, Local0)
                }

                Return (Local0)
            }

            Method (_PCL, 0, NotSerialized)
            {
                Return (\_SB)
            }

            Method (_STA, 0, NotSerialized)
            {
                If (LEqual (\ECON, 0x00))
                {
                    Store (0x0F, Local0)
                }
                Else
                {
                    If (LEqual (\_SB.PCI0.LPCB.H_EC.ACEX, 0x00))
                    {
                        Store (0x1F, Local0)
                    }
                    Else
                    {
                        Store (0x0F, Local0)
                    }
                }

                Return (Local0)
            }
        }

        Device (BAT1)
        {
            Name (_HID, EisaId ("PNP0C0A"))
            Name (_UID, 0x01)
            Name (BATI, Package (0x0D)
            {
                0x01, 
                0xFFFFFFFF, 
                0xFFFFFFFF, 
                0x01, 
                0xFFFFFFFF, 
                0x03, 
                0x0A, 
                0x01, 
                0x01, 
                "Unknown", 
                "Unknown", 
                "Unknown", 
                "Unknown"
            })
            Method (_BIF, 0, NotSerialized)
            {
                If (LEqual (\ECON, 0x00))
                {
                    Store (\_SB.PHS2 (0x8C, 0xB0, 0x00), Local0)
                    If (LEqual (Local0, 0xFFFF))
                    {
                        Store (0xFFFFFFFF, Index (BATI, 0x01))
                    }
                    Else
                    {
                        Store (Local0, Index (BATI, 0x01))
                    }

                    Store (\_SB.PHS2 (0x8C, 0xB2, 0x00), Local0)
                    If (LEqual (Local0, 0xFFFF))
                    {
                        Store (0xFFFFFFFF, Index (BATI, 0x02))
                    }
                    Else
                    {
                        Store (Local0, Index (BATI, 0x02))
                    }

                    Store (\_SB.PHS2 (0x8C, 0xB4, 0x00), Local0)
                    If (LEqual (Local0, 0xFFFF))
                    {
                        Store (0xFFFFFFFF, Index (BATI, 0x04))
                    }
                    Else
                    {
                        Store (Local0, Index (BATI, 0x04))
                    }

                    Store (0x00, Index (BATI, 0x05))
                    Store (\_SB.PHS2 (0x8C, 0xB6, 0x00), Local0)
                    If (LEqual (Local0, 0xFFFF))
                    {
                        Store (Zero, Index (BATI, 0x06))
                    }
                    Else
                    {
                        Store (Local0, Index (BATI, 0x06))
                    }
                }
                Else
                {
                    Store (\_SB.PCI0.LPCB.H_EC.B1AF, Local3)
                    Store (\_SB.PCI0.LPCB.H_EC.B1VL, Local4)
                    Store (Local3, Local0)
                    And (Local0, 0xFFFF, Local0)
                    ShiftLeft (Local0, 0x08, Local1)
                    And (Local1, 0xFF00, Local1)
                    ShiftRight (Local0, 0x08, Local0)
                    Or (Local0, Local1, Local0)
                    If (LEqual (Local0, 0xFFFF))
                    {
                        Store (0xFFFFFFFF, Index (BATI, 0x01))
                    }
                    Else
                    {
                        Store (Local0, Index (BATI, 0x01))
                    }

                    Store (Local3, Local0)
                    ShiftRight (Local0, 0x10, Local0)
                    And (Local0, 0xFFFF, Local0)
                    ShiftLeft (Local0, 0x08, Local1)
                    And (Local1, 0xFF00, Local1)
                    ShiftRight (Local0, 0x08, Local0)
                    Or (Local0, Local1, Local0)
                    If (LEqual (Local0, 0xFFFF))
                    {
                        Store (0xFFFFFFFF, Index (BATI, 0x02))
                    }
                    Else
                    {
                        Store (Local0, Index (BATI, 0x02))
                    }

                    Store (Local4, Local0)
                    And (Local0, 0xFFFF, Local0)
                    ShiftLeft (Local0, 0x08, Local1)
                    And (Local1, 0xFF00, Local1)
                    ShiftRight (Local0, 0x08, Local0)
                    Or (Local0, Local1, Local0)
                    If (LEqual (Local0, 0xFFFF))
                    {
                        Store (0xFFFFFFFF, Index (BATI, 0x04))
                    }
                    Else
                    {
                        Store (Local0, Index (BATI, 0x04))
                    }

                    Store (0x00, Index (BATI, 0x05))
                    Store (Local4, Local0)
                    ShiftRight (Local0, 0x10, Local0)
                    And (Local0, 0xFFFF, Local0)
                    ShiftLeft (Local0, 0x08, Local1)
                    And (Local1, 0xFF00, Local1)
                    ShiftRight (Local0, 0x08, Local0)
                    Or (Local0, Local1, Local0)
                    If (LEqual (Local0, 0xFFFF))
                    {
                        Store (0xFFFFFFFF, Index (BATI, 0x06))
                    }
                    Else
                    {
                        Store (Local0, Index (BATI, 0x06))
                    }
                }

                Store ("", Index (BATI, 0x09))
                Store ("", Index (BATI, 0x0A))
                Store ("LION", Index (BATI, 0x0B))
                Store ("SAMSUNG Electronics", Index (BATI, 0x0C))
                Return (BATI)
            }

            Name (STAT, Package (0x04)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00
            })
            Method (_BST, 0, NotSerialized)
            {
                If (LEqual (\ECON, 0x00))
                {
                    Store (\_SB.PHS2 (0x8B, 0x84, 0x00), Local0)
                    If (LAnd (LNot (LEqual (Local0, 0x00)), LNot (LEqual (Local0, 0x05))))
                    {
                        If (LEqual (\ACPS, 0x01))
                        {
                            Store (0x02, Local0)
                        }
                        Else
                        {
                            Store (0x01, Local0)
                        }
                    }

                    Store (Local0, Index (STAT, 0x00))
                    Store (\_SB.PHS2 (0x8C, 0xA4, 0x00), Local0)
                    If (LEqual (Local0, 0xFFFF))
                    {
                        Store (0xFFFFFFFF, Index (STAT, 0x01))
                    }
                    Else
                    {
                        If (LNot (LLess (Local0, 0x8000)))
                        {
                            XOr (Local0, 0xFFFF, Local0)
                            Increment (Local0)
                        }

                        Store (Local0, Index (STAT, 0x01))
                    }

                    Store (\_SB.PHS2 (0x8C, 0xA2, 0x00), Local0)
                    If (LEqual (Local0, 0xFFFF))
                    {
                        Store (0xFFFFFFFF, Index (STAT, 0x02))
                    }
                    Else
                    {
                        Store (Local0, Index (STAT, 0x02))
                    }

                    Store (\_SB.PHS2 (0x8C, 0xA6, 0x00), Local0)
                    If (LEqual (Local0, 0xFFFF))
                    {
                        Store (0xFFFFFFFF, Index (STAT, 0x03))
                    }
                    Else
                    {
                        Store (Local0, Index (STAT, 0x03))
                    }
                }
                Else
                {
                    Store (\_SB.PCI0.LPCB.H_EC.B1RR, Local3)
                    Store (\_SB.PCI0.LPCB.H_EC.B1PV, Local4)
                    Store (Local3, Local0)
                    And (Local0, 0xFF, Local0)
                    If (LAnd (LNot (LEqual (Local0, 0x00)), LNot (LEqual (Local0, 0x05))))
                    {
                        If (LEqual (\ACPS, 0x01))
                        {
                            Store (0x02, Local0)
                        }
                        Else
                        {
                            Store (0x01, Local0)
                        }
                    }

                    Store (Local0, Index (STAT, 0x00))
                    Store (Local4, Local0)
                    And (Local0, 0xFFFF, Local0)
                    ShiftLeft (Local0, 0x08, Local1)
                    And (Local1, 0xFF00, Local1)
                    ShiftRight (Local0, 0x08, Local0)
                    Or (Local0, Local1, Local0)
                    If (LEqual (Local0, 0xFFFF))
                    {
                        Store (0xFFFFFFFF, Index (STAT, 0x01))
                    }
                    Else
                    {
                        If (LNot (LLess (Local0, 0x8000)))
                        {
                            XOr (Local0, 0xFFFF, Local0)
                            Increment (Local0)
                        }

                        Store (Local0, Index (STAT, 0x01))
                    }

                    Store (Local3, Local0)
                    ShiftRight (Local0, 0x10, Local0)
                    And (Local0, 0xFFFF, Local0)
                    ShiftLeft (Local0, 0x08, Local1)
                    And (Local1, 0xFF00, Local1)
                    ShiftRight (Local0, 0x08, Local0)
                    Or (Local0, Local1, Local0)
                    If (LEqual (Local0, 0xFFFF))
                    {
                        Store (0xFFFFFFFF, Index (STAT, 0x02))
                    }
                    Else
                    {
                        Store (Local0, Index (STAT, 0x02))
                    }

                    Store (Local4, Local0)
                    ShiftRight (Local0, 0x10, Local0)
                    And (Local0, 0xFFFF, Local0)
                    ShiftLeft (Local0, 0x08, Local1)
                    And (Local1, 0xFF00, Local1)
                    ShiftRight (Local0, 0x08, Local0)
                    Or (Local0, Local1, Local0)
                    If (LEqual (Local0, 0xFFFF))
                    {
                        Store (0xFFFFFFFF, Index (STAT, 0x03))
                    }
                    Else
                    {
                        Store (Local0, Index (STAT, 0x03))
                    }
                }

                Return (STAT)
            }

            Method (_STA, 0, NotSerialized)
            {
                If (LEqual (\ECON, 0x00))
                {
                    If (LEqual (\_SB.PHS1 (0x81, 0x00), 0x01))
                    {
                        Store (0x1F, Local0)
                    }
                    Else
                    {
                        Store (0x0F, Local0)
                    }
                }
                Else
                {
                    If (LEqual (\_SB.PCI0.LPCB.H_EC.B1EX, 0x01))
                    {
                        Store (0x1F, Local0)
                    }
                    Else
                    {
                        Store (0x0F, Local0)
                    }
                }

                Return (Local0)
            }

            Method (_PCL, 0, NotSerialized)
            {
                Return (\_SB)
            }
        }

        OperationRegion (PHSD, SystemMemory, 0x1FF7CDBD, 0x00000190)
        Field (PHSD, AnyAcc, NoLock, Preserve)
        {
            BCMD,   8, 
            DID,    32, 
            INFO,   3152, 
            Offset (0x190)
        }

        Field (PHSD, AnyAcc, NoLock, Preserve)
        {
            Offset (0x05), 
            INF,    8, 
            INF1,   8, 
            INF2,   8, 
            INF3,   8
        }

        Field (PHSD, AnyAcc, NoLock, Preserve)
        {
            Offset (0x05), 
            INFW,   16
        }

        Field (PHSD, AnyAcc, NoLock, Preserve)
        {
            Offset (0x05), 
            INFD,   32
        }

        OperationRegion (PHSI, SystemIO, 0x0000FE00, 0x00000002)
        Field (PHSI, AnyAcc, NoLock, Preserve)
        {
            SMIC,   8
        }

        Mutex (MPHS, 0x00)
        Method (PHS, 1, Serialized)
        {
            Acquire (MPHS, 0xFFFF)
            Store (Arg0, BCMD)
            Store (Zero, SMIC)
            Store (0x00, BCMD)
            Store (INF, Local7)
            Release (MPHS)
            Return (Local7)
        }

        Method (PHSR, 1, Serialized)
        {
            Acquire (MPHS, 0xFFFF)
            Store (Arg0, BCMD)
            Store (Zero, SMIC)
            Store (0x00, BCMD)
            Store (INFD, Local7)
            Release (MPHS)
            Return (Local7)
        }

        Method (PHS1, 2, Serialized)
        {
            Acquire (MPHS, 0xFFFF)
            Store (Arg0, BCMD)
            Store (Arg1, INF)
            Store (Zero, SMIC)
            Store (0x00, BCMD)
            Store (INF, Local7)
            Release (MPHS)
            Return (Local7)
        }

        Method (PHS2, 3, Serialized)
        {
            Acquire (MPHS, 0xFFFF)
            Store (Arg0, BCMD)
            Store (Arg1, INF)
            Store (Arg2, INF1)
            Store (Zero, SMIC)
            Store (0x00, BCMD)
            Store (INFW, Local7)
            Release (MPHS)
            Return (Local7)
        }

        Method (PHS4, 5, Serialized)
        {
            Acquire (MPHS, 0xFFFF)
            Store (Arg0, BCMD)
            Store (Arg1, INF)
            Store (Arg2, INF1)
            Store (Arg3, INF2)
            Store (Arg4, INF3)
            Store (Zero, SMIC)
            Store (0x00, BCMD)
            Store (INFD, Local7)
            Release (MPHS)
            Return (Local7)
        }

        Device (LID0)
        {
            Name (_HID, EisaId ("PNP0C0D"))
            Method (_STA, 0, NotSerialized)
            {
                Return (0x0F)
            }

            Method (_LID, 0, NotSerialized)
            {
                If (\ECON)
                {
                    If (LEqual (\_SB.PCI0.LPCB.H_EC.LIDS, 0x01))
                    {
                        Return (0x01)
                    }
                }

                Return (0x00)
            }
        }

        Device (SLPB)
        {
            Name (_HID, EisaId ("PNP0C0E"))
            Method (_STA, 0, NotSerialized)
            {
                Return (0x0F)
            }
        }

        Device (PWRB)
        {
            Name (_HID, EisaId ("PNP0C0C"))
            Name (_PRW, Package (0x02)
            {
                0x1D, 
                0x04
            })
        }

        Device (PCI0)
        {
            Method (_INI, 0, NotSerialized)
            {
                Store (0xAA, P80H)
                Store (\_SB.PHS1 (0x81, 0x02), Local0)
                If (LNot (LEqual (Local0, 0x01)))
                {
                    \_SB.PHS (0x94)
                }

                If (CondRefOf (\_OSI, Local0))
                {
                    Store (0x07D1, OSYS)
                    \_SB.PHS (0x88)
                }
                Else
                {
                    If (LEqual (SizeOf (_OS), 0x14))
                    {
                        Store (0x07D0, OSYS)
                        Store (0xA7, P80H)
                        \_SB.PHS (0x87)
                    }
                    Else
                    {
                        If (LEqual (SizeOf (_OS), 0x27))
                        {
                            Store (0x07CF, OSYS)
                            \_SB.PHS (0x86)
                        }
                        Else
                        {
                            Store (0x07CE, OSYS)
                            \_SB.PHS (0x85)
                        }
                    }
                }

                If (LNot (LGreater (OSYS, 0x07CF)))
                {
                    Store (0x01, ECON)
                }
            }

            Method (_S1D, 0, NotSerialized)
            {
                Return (0x02)
            }

            Method (_S3D, 0, NotSerialized)
            {
                Return (0x02)
            }

            Method (_S4D, 0, NotSerialized)
            {
                Return (0x02)
            }

            Name (_HID, EisaId ("PNP0A03"))
            Name (_ADR, 0x00)
            Name (_BBN, 0x00)
            OperationRegion (HBUS, PCI_Config, 0x40, 0xC0)
            Field (HBUS, DWordAcc, NoLock, Preserve)
            {
                Offset (0x20), 
                DRB0,   8, 
                DRB1,   8, 
                DRB2,   8, 
                DRB3,   8, 
                Offset (0x50), 
                    ,   4, 
                PM0H,   2, 
                Offset (0x51), 
                PM1L,   2, 
                    ,   2, 
                PM1H,   2, 
                Offset (0x52), 
                PM2L,   2, 
                    ,   2, 
                PM2H,   2, 
                Offset (0x53), 
                PM3L,   2, 
                    ,   2, 
                PM3H,   2, 
                Offset (0x54), 
                PM4L,   2, 
                    ,   2, 
                PM4H,   2, 
                Offset (0x55), 
                PM5L,   2, 
                    ,   2, 
                PM5H,   2, 
                Offset (0x56), 
                PM6L,   2, 
                    ,   2, 
                PM6H,   2, 
                Offset (0x57), 
                FDHC,   8
            }

            Name (BUF0, ResourceTemplate ()
            {
                WordBusNumber (ResourceProducer, MinFixed, MaxFixed, PosDecode,
                    0x0000,
                    0x0000,
                    0x00FF,
                    0x0000,
                    0x0100, 0x00)
                DWordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
                    0x00000000,
                    0x00000000,
                    0x00000CF7,
                    0x00000000,
                    0x00000CF8, 0x00)
                IO (Decode16, 0x0CF8, 0x0CF8, 0x01, 0x08)
                DWordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
                    0x00000000,
                    0x00000D00,
                    0x0000FFFF,
                    0x00000000,
                    0x0000F300, 0x00)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,
                    0x000A0000,
                    0x000BFFFF,
                    0x00000000,
                    0x00020000, 0x00)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,
                    0x000C0000,
                    0x000C3FFF,
                    0x00000000,
                    0x00004000, 0x00)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,
                    0x000C4000,
                    0x000C7FFF,
                    0x00000000,
                    0x00004000, 0x00)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,
                    0x000C8000,
                    0x000CBFFF,
                    0x00000000,
                    0x00004000, 0x00)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,
                    0x000CC000,
                    0x000CFFFF,
                    0x00000000,
                    0x00004000, 0x00)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,
                    0x000D0000,
                    0x000D3FFF,
                    0x00000000,
                    0x00004000, 0x00)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,
                    0x000D4000,
                    0x000D7FFF,
                    0x00000000,
                    0x00004000, 0x00)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,
                    0x000D8000,
                    0x000DBFFF,
                    0x00000000,
                    0x00004000, 0x00)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,
                    0x000DC000,
                    0x000DFFFF,
                    0x00000000,
                    0x00004000, 0x00)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,
                    0x000E0000,
                    0x000E3FFF,
                    0x00000000,
                    0x00004000, 0x00)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,
                    0x000E4000,
                    0x000E7FFF,
                    0x00000000,
                    0x00004000, 0x00)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,
                    0x000E8000,
                    0x000EBFFF,
                    0x00000000,
                    0x00004000, 0x00)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,
                    0x000EC000,
                    0x000EFFFF,
                    0x00000000,
                    0x00004000, 0x00)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,
                    0x000F0000,
                    0x000FFFFF,
                    0x00000000,
                    0x00010000, 0x00)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,
                    0x00000000,
                    0xFEBFFFFF,
                    0x00000000,
                    0x00000000, 0x00)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,
                    0x00000000,
                    0x00000000,
                    0x00000000,
                    0x00000000, 0x00)
            })
            Method (_CRS, 0, Serialized)
            {
                If (PM1L)
                {
                    CreateDWordField (BUF0, 0x80, C0LN)
                    Store (Zero, C0LN)
                }

                If (LEqual (PM1L, 0x01))
                {
                    CreateBitField (BUF0, 0x0378, C0RW)
                    Store (Zero, C0RW)
                }

                If (PM1H)
                {
                    CreateDWordField (BUF0, 0x9B, C4LN)
                    Store (Zero, C4LN)
                }

                If (LEqual (PM1H, 0x01))
                {
                    CreateBitField (BUF0, 0x0450, C4RW)
                    Store (Zero, C4RW)
                }

                If (PM2L)
                {
                    CreateDWordField (BUF0, 0xB6, C8LN)
                    Store (Zero, C8LN)
                }

                If (LEqual (PM2L, 0x01))
                {
                    CreateBitField (BUF0, 0x0528, C8RW)
                    Store (Zero, C8RW)
                }

                If (PM2H)
                {
                    CreateDWordField (BUF0, 0xD1, CCLN)
                    Store (Zero, CCLN)
                }

                If (LEqual (PM2H, 0x01))
                {
                    CreateBitField (BUF0, 0x0600, CCRW)
                    Store (Zero, CCRW)
                }

                If (PM3L)
                {
                    CreateDWordField (BUF0, 0xEC, D0LN)
                    Store (Zero, D0LN)
                }

                If (LEqual (PM3L, 0x01))
                {
                    CreateBitField (BUF0, 0x06D8, D0RW)
                    Store (Zero, D0RW)
                }

                If (PM3H)
                {
                    CreateDWordField (BUF0, 0x0107, D4LN)
                    Store (Zero, D4LN)
                }

                If (LEqual (PM3H, 0x01))
                {
                    CreateBitField (BUF0, 0x07B0, D4RW)
                    Store (Zero, D4RW)
                }

                If (PM4L)
                {
                    CreateDWordField (BUF0, 0x0122, D8LN)
                    Store (Zero, D8LN)
                }

                If (LEqual (PM4L, 0x01))
                {
                    CreateBitField (BUF0, 0x0888, D8RW)
                    Store (Zero, D8RW)
                }

                If (PM4H)
                {
                    CreateDWordField (BUF0, 0x013D, DCLN)
                    Store (Zero, DCLN)
                }

                If (LEqual (PM4H, 0x01))
                {
                    CreateBitField (BUF0, 0x0960, DCRW)
                    Store (Zero, DCRW)
                }

                If (PM5L)
                {
                    CreateDWordField (BUF0, 0x0158, E0LN)
                    Store (Zero, E0LN)
                }

                If (LEqual (PM5L, 0x01))
                {
                    CreateBitField (BUF0, 0x0A38, E0RW)
                    Store (Zero, E0RW)
                }

                If (PM5H)
                {
                    CreateDWordField (BUF0, 0x0173, E4LN)
                    Store (Zero, E4LN)
                }

                If (LEqual (PM5H, 0x01))
                {
                    CreateBitField (BUF0, 0x0B10, E4RW)
                    Store (Zero, E4RW)
                }

                If (PM6L)
                {
                    CreateDWordField (BUF0, 0x018E, E8LN)
                    Store (Zero, E8LN)
                }

                If (LEqual (PM6L, 0x01))
                {
                    CreateBitField (BUF0, 0x0BE8, E8RW)
                    Store (Zero, E8RW)
                }

                If (PM6H)
                {
                    CreateDWordField (BUF0, 0x01A9, ECLN)
                    Store (Zero, ECLN)
                }

                If (LEqual (PM6H, 0x01))
                {
                    CreateBitField (BUF0, 0x0CC0, ECRW)
                    Store (Zero, ECRW)
                }

                If (PM0H)
                {
                    CreateDWordField (BUF0, 0x01C4, F0LN)
                    Store (Zero, F0LN)
                }

                If (LEqual (PM0H, 0x01))
                {
                    CreateBitField (BUF0, 0x0D98, F0RW)
                    Store (Zero, F0RW)
                }

                CreateDWordField (BUF0, 0x01D3, M1MN)
                CreateDWordField (BUF0, 0x01D7, M1MX)
                CreateDWordField (BUF0, 0x01DF, M1LN)
                Multiply (0x02000000, DRB3, M1MN)
                Add (Subtract (M1MX, M1MN), 0x01, M1LN)
                ShiftRight (And (\_SB.PCI0.LPCB.HPTE, 0x00038000), 0x0F, Local0)
                If (And (Local0, 0x04))
                {
                    CreateDWordField (BUF0, 0x01EE, M2MN)
                    CreateDWordField (BUF0, 0x01F2, M2MX)
                    CreateDWordField (BUF0, 0x01FA, M2LN)
                    Store (0xFED00000, M2MN)
                    Store (0xFED003FF, M2MX)
                    Store (0x0400, M2LN)
                    If (LEqual (Local0, 0x05))
                    {
                        Store (0xFED01000, M2MN)
                        Store (0xFED013FF, M2MX)
                    }

                    If (LEqual (Local0, 0x06))
                    {
                        Store (0xFED02000, M2MN)
                        Store (0xFED023FF, M2MX)
                    }

                    If (LEqual (Local0, 0x07))
                    {
                        Store (0xFED03000, M2MN)
                        Store (0xFED033FF, M2MX)
                    }
                }

                Return (BUF0)
            }

            Method (_PRT, 0, NotSerialized)
            {
                If (GPIC)
                {
                    Return (Package (0x07)
                    {
                        Package (0x04)
                        {
                            0x0007FFFF, 
                            0x00, 
                            0x00, 
                            0x10
                        }, 

                        Package (0x04)
                        {
                            0x001DFFFF, 
                            0x00, 
                            0x00, 
                            0x10
                        }, 

                        Package (0x04)
                        {
                            0x001DFFFF, 
                            0x01, 
                            0x00, 
                            0x13
                        }, 

                        Package (0x04)
                        {
                            0x001DFFFF, 
                            0x02, 
                            0x00, 
                            0x12
                        }, 

                        Package (0x04)
                        {
                            0x001DFFFF, 
                            0x03, 
                            0x00, 
                            0x17
                        }, 

                        Package (0x04)
                        {
                            0x001FFFFF, 
                            0x00, 
                            0x00, 
                            0x12
                        }, 

                        Package (0x04)
                        {
                            0x001FFFFF, 
                            0x01, 
                            0x00, 
                            0x11
                        }
                    })
                }
                Else
                {
                    Return (Package (0x07)
                    {
                        Package (0x04)
                        {
                            0x0007FFFF, 
                            0x00, 
                            \_SB.PCI0.LPCB.LNKA, 
                            0x00
                        }, 

                        Package (0x04)
                        {
                            0x001DFFFF, 
                            0x00, 
                            \_SB.PCI0.LPCB.LNKA, 
                            0x00
                        }, 

                        Package (0x04)
                        {
                            0x001DFFFF, 
                            0x01, 
                            \_SB.PCI0.LPCB.LNKD, 
                            0x00
                        }, 

                        Package (0x04)
                        {
                            0x001DFFFF, 
                            0x02, 
                            \_SB.PCI0.LPCB.LNKC, 
                            0x00
                        }, 

                        Package (0x04)
                        {
                            0x001DFFFF, 
                            0x03, 
                            \_SB.PCI0.LPCB.LNKH, 
                            0x00
                        }, 

                        Package (0x04)
                        {
                            0x001FFFFF, 
                            0x00, 
                            \_SB.PCI0.LPCB.LNKC, 
                            0x00
                        }, 

                        Package (0x04)
                        {
                            0x001FFFFF, 
                            0x01, 
                            \_SB.PCI0.LPCB.LNKB, 
                            0x00
                        }
                    })
                }
            }

            Device (AGPB)
            {
                Name (_ADR, 0x00010000)
                Device (NVID)
                {
                    Name (_ADR, 0x00)
                    Method (_DOS, 1, NotSerialized)
                    {
                        Store (And (Arg0, 0x03), DSEN)
                    }

                    Method (_DOD, 0, NotSerialized)
                    {
                        Name (PSIZ, 0x00)
                        Name (PPTR, 0x00)
                        Store (0x3C, SMIF)
                        Store (0x02, VFUN)
                        Store (0x00, TRP0)
                        Store (CADL, Local0)
                        Store (CADL, Local1)
                        Store (CADL, PADL)
                        While (Local1)
                        {
                            If (And (Local1, 0x01))
                            {
                                Increment (PSIZ)
                            }

                            ShiftRight (Local1, 0x01, Local1)
                        }

                        If (LOr (LEqual (PSIZ, 0x00), LGreater (PSIZ, 0x04)))
                        {
                            Store (0x00, ENUM)
                            Return (Package (0x01)
                            {
                                0x00010110
                            })
                        }
                        Else
                        {
                            Store (0x01, ENUM)
                            If (LEqual (PSIZ, 0x02))
                            {
                                Name (VID2, Package (0x02)
                                {
                                    0x00010110, 
                                    0x00010100
                                })
                                If (And (Local0, 0x01))
                                {
                                    Store (0x00010110, Index (VID2, PPTR))
                                    Increment (PPTR)
                                }

                                If (And (Local0, 0x02))
                                {
                                    Store (0x00010100, Index (VID2, PPTR))
                                    Increment (PPTR)
                                }

                                If (And (Local0, 0x04))
                                {
                                    Store (0x00010200, Index (VID2, PPTR))
                                    Increment (PPTR)
                                }

                                Return (VID2)
                            }

                            If (LEqual (PSIZ, 0x03))
                            {
                                Name (VID3, Package (0x03)
                                {
                                    0x00010110, 
                                    0x00010100, 
                                    0x00010200
                                })
                                If (And (Local0, 0x01))
                                {
                                    Store (0x00010110, Index (VID3, PPTR))
                                    Increment (PPTR)
                                }

                                If (And (Local0, 0x02))
                                {
                                    Store (0x00010100, Index (VID3, PPTR))
                                    Increment (PPTR)
                                }

                                If (And (Local0, 0x04))
                                {
                                    Store (0x00010200, Index (VID3, PPTR))
                                    Increment (PPTR)
                                }

                                Return (VID3)
                            }

                            Name (VID1, Package (0x01)
                            {
                                0x00010110
                            })
                            If (And (Local0, 0x01))
                            {
                                Store (0x00010110, Index (VID1, 0x00))
                            }

                            If (And (Local0, 0x02))
                            {
                                Store (0x00010100, Index (VID1, 0x00))
                            }

                            If (And (Local0, 0x04))
                            {
                                Store (0x00010200, Index (VID1, 0x00))
                            }

                            Return (VID1)
                        }
                    }

                    Device (CRT1)
                    {
                        Name (_ADR, 0x0100)
                        Method (_DCS, 0, NotSerialized)
                        {
                            Store (0x3C, SMIF)
                            Store (0x01, VFUN)
                            Store (0x00, TRP0)
                            Store (CSTE, Local0)
                            If (Local0)
                            {
                                If (And (Local0, 0x02))
                                {
                                    Return (0x1F)
                                }
                            }

                            Return (0x1D)
                        }

                        Method (_DGS, 0, NotSerialized)
                        {
                            Store (NSTE, Local0)
                            If (Local0)
                            {
                                If (And (Local0, 0x02))
                                {
                                    Return (0x01)
                                }
                            }

                            Return (0x00)
                        }

                        Method (_DSS, 1, NotSerialized)
                        {
                        }
                    }

                    Device (LCD1)
                    {
                        Name (_ADR, 0x0110)
                        Method (_DCS, 0, NotSerialized)
                        {
                            Store (0x3C, SMIF)
                            Store (0x01, VFUN)
                            Store (0x00, TRP0)
                            Store (CSTE, Local0)
                            If (Local0)
                            {
                                If (And (Local0, 0x01))
                                {
                                    Return (0x1F)
                                }
                            }

                            Return (0x1D)
                        }

                        Method (_DGS, 0, NotSerialized)
                        {
                            Store (NSTE, Local0)
                            If (Local0)
                            {
                                If (And (Local0, 0x01))
                                {
                                    Return (0x01)
                                }
                            }

                            Return (0x00)
                        }

                        Method (_DSS, 1, NotSerialized)
                        {
                        }
                    }

                    Device (DTV1)
                    {
                        Name (_ADR, 0x0200)
                        Method (_DCS, 0, NotSerialized)
                        {
                            Store (0x3C, SMIF)
                            Store (0x01, VFUN)
                            Store (0x00, TRP0)
                            Store (CSTE, Local0)
                            If (Local0)
                            {
                                If (And (Local0, 0x04))
                                {
                                    Return (0x1F)
                                }
                            }

                            Return (0x1D)
                        }

                        Method (_DGS, 0, NotSerialized)
                        {
                            Store (NSTE, Local0)
                            If (Local0)
                            {
                                If (And (Local0, 0x04))
                                {
                                    Return (0x01)
                                }
                            }

                            Return (0x00)
                        }

                        Method (_DSS, 1, NotSerialized)
                        {
                        }
                    }
                }

                Method (_PRT, 0, NotSerialized)
                {
                    If (GPIC)
                    {
                        Return (Package (0x01)
                        {
                            Package (0x04)
                            {
                                0xFFFF, 
                                0x00, 
                                0x00, 
                                0x11
                            }
                        })
                    }
                    Else
                    {
                        Return (Package (0x01)
                        {
                            Package (0x04)
                            {
                                0xFFFF, 
                                0x00, 
                                \_SB.PCI0.LPCB.LNKB, 
                                0x00
                            }
                        })
                    }
                }
            }

            Device (PCIB)
            {
                Name (_ADR, 0x001E0000)
                Device (CDB0)
                {
                    Name (_ADR, 0x00030000)
                    OperationRegion (CBD0, PCI_Config, 0x00, 0xF0)
                    Field (CBD0, AnyAcc, NoLock, Preserve)
                    {
                        Offset (0x3C), 
                        CD3C,   8, 
                        Offset (0x44), 
                        CD44,   32, 
                        Offset (0xA5), 
                        CDA5,   8, 
                        Offset (0xE1), 
                            ,   7, 
                        PMES,   1
                    }

                    Method (_INI, 0, NotSerialized)
                    {
                        Or (CD3C, 0xFF, CD3C)
                        Store (0x00, CD44)
                    }
                }

                Device (CDB1)
                {
                    Name (_ADR, 0x00030001)
                    OperationRegion (CBD1, PCI_Config, 0x00, 0xF0)
                    Field (CBD1, AnyAcc, NoLock, Preserve)
                    {
                        Offset (0x3C), 
                        CD3C,   8, 
                        Offset (0x44), 
                        CD44,   32, 
                        Offset (0xE1), 
                            ,   7, 
                        PMES,   1
                    }

                    Method (_INI, 0, NotSerialized)
                    {
                        Or (CD3C, 0xFF, CD3C)
                        Store (0x00, CD44)
                    }
                }

                Device (OHCI)
                {
                    Name (_ADR, 0x00030002)
                    OperationRegion (OHCI, PCI_Config, 0x00, 0xF0)
                    Field (OHCI, AnyAcc, NoLock, Preserve)
                    {
                        Offset (0x3C), 
                        CD3C,   8, 
                        Offset (0x44), 
                        CD44,   32, 
                        Offset (0xE1), 
                        PMES,   8
                    }

                    Method (_INI, 0, NotSerialized)
                    {
                        Or (CD3C, 0xFF, CD3C)
                        Store (0x00, CD44)
                    }
                }

                Device (LANC)
                {
                    Name (_ADR, 0x00050000)
                    Name (_PRW, Package (0x02)
                    {
                        0x0B, 
                        0x04
                    })
                }

                Device (MPC0)
                {
                    Name (_ADR, 0x00070000)
                    OperationRegion (MPC0, PCI_Config, 0xA0, 0x10)
                    Field (MPC0, AnyAcc, NoLock, Preserve)
                    {
                        Offset (0x05), 
                        MA5,    8
                    }
                }

                Device (MPC1)
                {
                    Name (_ADR, 0x00070001)
                    OperationRegion (MPC1, PCI_Config, 0xA0, 0x10)
                    Field (MPC1, AnyAcc, NoLock, Preserve)
                    {
                        Offset (0x05), 
                        MA5,    8
                    }
                }

                Method (_PRT, 0, NotSerialized)
                {
                    If (GPIC)
                    {
                        Return (Package (0x06)
                        {
                            Package (0x04)
                            {
                                0x0005FFFF, 
                                0x00, 
                                0x00, 
                                0x13
                            }, 

                            Package (0x04)
                            {
                                0x0003FFFF, 
                                0x00, 
                                0x00, 
                                0x10
                            }, 

                            Package (0x04)
                            {
                                0x0003FFFF, 
                                0x01, 
                                0x00, 
                                0x11
                            }, 

                            Package (0x04)
                            {
                                0x0003FFFF, 
                                0x02, 
                                0x00, 
                                0x12
                            }, 

                            Package (0x04)
                            {
                                0x0007FFFF, 
                                0x00, 
                                0x00, 
                                0x14
                            }, 

                            Package (0x04)
                            {
                                0x0007FFFF, 
                                0x01, 
                                0x00, 
                                0x15
                            }
                        })
                    }
                    Else
                    {
                        Return (Package (0x06)
                        {
                            Package (0x04)
                            {
                                0x0005FFFF, 
                                0x00, 
                                \_SB.PCI0.LPCB.LNKD, 
                                0x00
                            }, 

                            Package (0x04)
                            {
                                0x0003FFFF, 
                                0x00, 
                                \_SB.PCI0.LPCB.LNKA, 
                                0x00
                            }, 

                            Package (0x04)
                            {
                                0x0003FFFF, 
                                0x01, 
                                \_SB.PCI0.LPCB.LNKB, 
                                0x00
                            }, 

                            Package (0x04)
                            {
                                0x0003FFFF, 
                                0x02, 
                                \_SB.PCI0.LPCB.LNKC, 
                                0x00
                            }, 

                            Package (0x04)
                            {
                                0x0007FFFF, 
                                0x00, 
                                \_SB.PCI0.LPCB.LNKE, 
                                0x00
                            }, 

                            Package (0x04)
                            {
                                0x0007FFFF, 
                                0x01, 
                                \_SB.PCI0.LPCB.LNKF, 
                                0x00
                            }
                        })
                    }
                }
            }

            Device (LPCB)
            {
                Name (_ADR, 0x001F0000)
                OperationRegion (LPC0, PCI_Config, 0x40, 0xC0)
                Field (LPC0, AnyAcc, NoLock, Preserve)
                {
                    Offset (0x20), 
                    PIRA,   8, 
                    PIRB,   8, 
                    PIRC,   8, 
                    PIRD,   8, 
                    Offset (0x28), 
                    PIRE,   8, 
                    PIRF,   8, 
                    PIRG,   8, 
                    PIRH,   8, 
                    Offset (0x90), 
                    HPTE,   32, 
                    Offset (0xA0), 
                    LDE0,   8, 
                    LDE1,   8
                }

                Device (LNKA)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x01)
                    Method (_DIS, 0, Serialized)
                    {
                        Store (0x80, PIRA)
                    }

                    Name (_PRS, ResourceTemplate ()
                    {
                        IRQ (Level, ActiveLow, Shared) {11}
                    })
                    Method (_CRS, 0, Serialized)
                    {
                        Name (RTLA, ResourceTemplate ()
                        {
                            IRQ (Level, ActiveLow, Shared) {}
                        })
                        CreateWordField (RTLA, 0x01, IRQ0)
                        Store (Zero, IRQ0)
                        ShiftLeft (0x01, And (PIRA, 0x0F), IRQ0)
                        Return (RTLA)
                    }

                    Method (_SRS, 1, Serialized)
                    {
                        CreateWordField (Arg0, 0x01, IRQ0)
                        FindSetRightBit (IRQ0, Local0)
                        Decrement (Local0)
                        Store (Local0, PIRA)
                    }

                    Method (_STA, 0, Serialized)
                    {
                        If (And (PIRA, 0x80))
                        {
                            Return (0x09)
                        }
                        Else
                        {
                            Return (0x0B)
                        }
                    }
                }

                Device (LNKB)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x02)
                    Method (_DIS, 0, Serialized)
                    {
                        Store (0x80, PIRB)
                    }

                    Name (_PRS, ResourceTemplate ()
                    {
                        IRQ (Level, ActiveLow, Shared) {11}
                    })
                    Method (_CRS, 0, Serialized)
                    {
                        Name (RTLB, ResourceTemplate ()
                        {
                            IRQ (Level, ActiveLow, Shared) {}
                        })
                        CreateWordField (RTLB, 0x01, IRQ0)
                        Store (Zero, IRQ0)
                        ShiftLeft (0x01, And (PIRB, 0x0F), IRQ0)
                        Return (RTLB)
                    }

                    Method (_SRS, 1, Serialized)
                    {
                        CreateWordField (Arg0, 0x01, IRQ0)
                        FindSetRightBit (IRQ0, Local0)
                        Decrement (Local0)
                        Store (Local0, PIRB)
                    }

                    Method (_STA, 0, Serialized)
                    {
                        If (And (PIRB, 0x80))
                        {
                            Return (0x09)
                        }
                        Else
                        {
                            Return (0x0B)
                        }
                    }
                }

                Device (LNKC)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x03)
                    Method (_DIS, 0, Serialized)
                    {
                        Store (0x80, PIRC)
                    }

                    Name (_PRS, ResourceTemplate ()
                    {
                        IRQ (Level, ActiveLow, Shared) {10}
                    })
                    Method (_CRS, 0, Serialized)
                    {
                        Name (RTLC, ResourceTemplate ()
                        {
                            IRQ (Level, ActiveLow, Shared) {}
                        })
                        CreateWordField (RTLC, 0x01, IRQ0)
                        Store (Zero, IRQ0)
                        ShiftLeft (0x01, And (PIRC, 0x0F), IRQ0)
                        Return (RTLC)
                    }

                    Method (_SRS, 1, Serialized)
                    {
                        CreateWordField (Arg0, 0x01, IRQ0)
                        FindSetRightBit (IRQ0, Local0)
                        Decrement (Local0)
                        Store (Local0, PIRC)
                    }

                    Method (_STA, 0, Serialized)
                    {
                        If (And (PIRC, 0x80))
                        {
                            Return (0x09)
                        }
                        Else
                        {
                            Return (0x0B)
                        }
                    }
                }

                Device (LNKD)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x04)
                    Method (_DIS, 0, Serialized)
                    {
                        Store (0x80, PIRD)
                    }

                    Name (_PRS, ResourceTemplate ()
                    {
                        IRQ (Level, ActiveLow, Shared) {10}
                    })
                    Method (_CRS, 0, Serialized)
                    {
                        Name (RTLD, ResourceTemplate ()
                        {
                            IRQ (Level, ActiveLow, Shared) {}
                        })
                        CreateWordField (RTLD, 0x01, IRQ0)
                        Store (Zero, IRQ0)
                        ShiftLeft (0x01, And (PIRD, 0x0F), IRQ0)
                        Return (RTLD)
                    }

                    Method (_SRS, 1, Serialized)
                    {
                        CreateWordField (Arg0, 0x01, IRQ0)
                        FindSetRightBit (IRQ0, Local0)
                        Decrement (Local0)
                        Store (Local0, PIRD)
                    }

                    Method (_STA, 0, Serialized)
                    {
                        If (And (PIRD, 0x80))
                        {
                            Return (0x09)
                        }
                        Else
                        {
                            Return (0x0B)
                        }
                    }
                }

                Device (LNKE)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x05)
                    Method (_DIS, 0, Serialized)
                    {
                        Store (0x80, PIRE)
                    }

                    Name (_PRS, ResourceTemplate ()
                    {
                        IRQ (Level, ActiveLow, Shared) {5}
                    })
                    Method (_CRS, 0, Serialized)
                    {
                        Name (RTLE, ResourceTemplate ()
                        {
                            IRQ (Level, ActiveLow, Shared) {}
                        })
                        CreateWordField (RTLE, 0x01, IRQ0)
                        Store (Zero, IRQ0)
                        ShiftLeft (0x01, And (PIRE, 0x0F), IRQ0)
                        Return (RTLE)
                    }

                    Method (_SRS, 1, Serialized)
                    {
                        CreateWordField (Arg0, 0x01, IRQ0)
                        FindSetRightBit (IRQ0, Local0)
                        Decrement (Local0)
                        Store (Local0, PIRE)
                    }

                    Method (_STA, 0, Serialized)
                    {
                        If (And (PIRE, 0x80))
                        {
                            Return (0x09)
                        }
                        Else
                        {
                            Return (0x0B)
                        }
                    }
                }

                Device (LNKF)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x06)
                    Method (_DIS, 0, Serialized)
                    {
                        Store (0x80, PIRF)
                    }

                    Name (_PRS, ResourceTemplate ()
                    {
                        IRQ (Level, ActiveLow, Shared) {5}
                    })
                    Method (_CRS, 0, Serialized)
                    {
                        Name (RTLF, ResourceTemplate ()
                        {
                            IRQ (Level, ActiveLow, Shared) {}
                        })
                        CreateWordField (RTLF, 0x01, IRQ0)
                        Store (Zero, IRQ0)
                        ShiftLeft (0x01, And (PIRF, 0x0F), IRQ0)
                        Return (RTLF)
                    }

                    Method (_SRS, 1, Serialized)
                    {
                        CreateWordField (Arg0, 0x01, IRQ0)
                        FindSetRightBit (IRQ0, Local0)
                        Decrement (Local0)
                        Store (Local0, PIRF)
                    }

                    Method (_STA, 0, Serialized)
                    {
                        If (And (PIRF, 0x80))
                        {
                            Return (0x09)
                        }
                        Else
                        {
                            Return (0x0B)
                        }
                    }
                }

                Device (LNKG)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x07)
                    Method (_DIS, 0, Serialized)
                    {
                        Store (0x80, PIRG)
                    }

                    Name (_PRS, ResourceTemplate ()
                    {
                        IRQ (Level, ActiveLow, Shared) {10}
                    })
                    Method (_CRS, 0, Serialized)
                    {
                        Name (RTLG, ResourceTemplate ()
                        {
                            IRQ (Level, ActiveLow, Shared) {}
                        })
                        CreateWordField (RTLG, 0x01, IRQ0)
                        Store (Zero, IRQ0)
                        ShiftLeft (0x01, And (PIRG, 0x0F), IRQ0)
                        Return (RTLG)
                    }

                    Method (_SRS, 1, Serialized)
                    {
                        CreateWordField (Arg0, 0x01, IRQ0)
                        FindSetRightBit (IRQ0, Local0)
                        Decrement (Local0)
                        Store (Local0, PIRG)
                    }

                    Method (_STA, 0, Serialized)
                    {
                        If (And (PIRG, 0x80))
                        {
                            Return (0x09)
                        }
                        Else
                        {
                            Return (0x0B)
                        }
                    }
                }

                Device (LNKH)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x08)
                    Method (_DIS, 0, Serialized)
                    {
                        Store (0x80, PIRH)
                    }

                    Name (_PRS, ResourceTemplate ()
                    {
                        IRQ (Level, ActiveLow, Shared) {5}
                    })
                    Method (_CRS, 0, Serialized)
                    {
                        Name (RTLH, ResourceTemplate ()
                        {
                            IRQ (Level, ActiveLow, Shared) {}
                        })
                        CreateWordField (RTLH, 0x01, IRQ0)
                        Store (Zero, IRQ0)
                        ShiftLeft (0x01, And (PIRH, 0x0F), IRQ0)
                        Return (RTLH)
                    }

                    Method (_SRS, 1, Serialized)
                    {
                        CreateWordField (Arg0, 0x01, IRQ0)
                        FindSetRightBit (IRQ0, Local0)
                        Decrement (Local0)
                        Store (Local0, PIRH)
                    }

                    Method (_STA, 0, Serialized)
                    {
                        If (And (PIRH, 0x80))
                        {
                            Return (0x09)
                        }
                        Else
                        {
                            Return (0x0B)
                        }
                    }
                }

                Device (TIMR)
                {
                    Name (_HID, EisaId ("PNP0100"))
                    Name (BUF0, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0040, 0x0040, 0x01, 0x04)
                        IO (Decode16, 0x0050, 0x0050, 0x10, 0x04)
                    })
                    Name (BUF1, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0040, 0x0040, 0x01, 0x04)
                        IO (Decode16, 0x0050, 0x0050, 0x10, 0x04)
                        IRQNoFlags () {0}
                    })
                    Method (_CRS, 0, Serialized)
                    {
                        If (And (HPTE, 0x00020000))
                        {
                            Return (BUF0)
                        }

                        Return (BUF1)
                    }
                }

                Device (IPIC)
                {
                    Name (_HID, EisaId ("PNP0000"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0020, 0x0020, 0x01, 0x02)
                        IO (Decode16, 0x0024, 0x0024, 0x01, 0x02)
                        IO (Decode16, 0x0028, 0x0028, 0x01, 0x02)
                        IO (Decode16, 0x002C, 0x002C, 0x01, 0x02)
                        IO (Decode16, 0x0030, 0x0030, 0x01, 0x02)
                        IO (Decode16, 0x0034, 0x0034, 0x01, 0x02)
                        IO (Decode16, 0x0038, 0x0038, 0x01, 0x02)
                        IO (Decode16, 0x003C, 0x003C, 0x01, 0x02)
                        IO (Decode16, 0x00A0, 0x00A0, 0x01, 0x02)
                        IO (Decode16, 0x00A4, 0x00A4, 0x01, 0x02)
                        IO (Decode16, 0x00A8, 0x00A8, 0x01, 0x02)
                        IO (Decode16, 0x00AC, 0x00AC, 0x01, 0x02)
                        IO (Decode16, 0x00B0, 0x00B0, 0x01, 0x02)
                        IO (Decode16, 0x00B4, 0x00B4, 0x01, 0x02)
                        IO (Decode16, 0x00B8, 0x00B8, 0x01, 0x02)
                        IO (Decode16, 0x00BC, 0x00BC, 0x01, 0x02)
                        IO (Decode16, 0x04D0, 0x04D0, 0x01, 0x02)
                        IRQNoFlags () {2}
                    })
                }

                Device (RTC)
                {
                    Name (_HID, EisaId ("PNP0B00"))
                    Name (BUF0, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0070, 0x0070, 0x01, 0x08)
                    })
                    Name (BUF1, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0070, 0x0070, 0x01, 0x08)
                        IRQNoFlags () {8}
                    })
                    Method (_CRS, 0, Serialized)
                    {
                        If (And (HPTE, 0x00020000))
                        {
                            Return (BUF0)
                        }

                        Return (BUF1)
                    }
                }

                Device (MATH)
                {
                    Name (_HID, EisaId ("PNP0C04"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x00F0, 0x00F0, 0x01, 0x01)
                        IRQNoFlags () {13}
                    })
                }

                Device (DMAC)
                {
                    Name (_HID, EisaId ("PNP0200"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0000, 0x0000, 0x01, 0x20)
                        IO (Decode16, 0x0081, 0x0081, 0x01, 0x0F)
                        IO (Decode16, 0x0090, 0x0090, 0x01, 0x02)
                        IO (Decode16, 0x0093, 0x0093, 0x01, 0x0D)
                        IO (Decode16, 0x00C0, 0x00C0, 0x01, 0x20)
                        DMA (Compatibility, NotBusMaster, Transfer8_16) {4}
                    })
                }

                Device (MBRD)
                {
                    Name (_HID, EisaId ("PNP0C02"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x002E, 0x002E, 0x01, 0x02)
                        IO (Decode16, 0x0061, 0x0061, 0x01, 0x01)
                        IO (Decode16, 0x0063, 0x0063, 0x01, 0x01)
                        IO (Decode16, 0x0065, 0x0065, 0x01, 0x01)
                        IO (Decode16, 0x0067, 0x0067, 0x01, 0x01)
                        IO (Decode16, 0x0080, 0x0080, 0x01, 0x01)
                        IO (Decode16, 0x0092, 0x0092, 0x01, 0x01)
                        IO (Decode16, 0x00B2, 0x00B2, 0x01, 0x02)
                        IO (Decode16, 0x0600, 0x0600, 0x01, 0x10)
                        IO (Decode16, 0x0700, 0x0700, 0x01, 0x10)
                        IO (Decode16, 0x0800, 0x0800, 0x01, 0x08)
                        IO (Decode16, 0x1000, 0x1000, 0x01, 0x80)
                        IO (Decode16, 0x1180, 0x1180, 0x01, 0x40)
                        Memory32Fixed (ReadWrite, 0xFEBFE000, 0x00001000)
                        Memory32Fixed (ReadWrite, 0xFEBFF000, 0x00001000)
                        Memory32Fixed (ReadWrite, 0xFEC00000, 0x00001000)
                    })
                }

                Device (FWHD)
                {
                    Name (_HID, EisaId ("INT0800"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        Memory32Fixed (ReadOnly, 0xFF800000, 0x00800000)
                    })
                }

                Device (HPET)
                {
                    Name (_HID, EisaId ("PNP0103"))
                    Name (BUF0, ResourceTemplate ()
                    {
                        IRQNoFlags () {0}
                        IRQNoFlags () {8}
                        Memory32Fixed (ReadOnly, 0xFED00000, 0x00000400)
                    })
                    Method (_STA, 0, NotSerialized)
                    {
                        ShiftRight (And (HPTE, 0x00038000), 0x0F, Local0)
                        If (LEqual (OSYS, 0x07D1))
                        {
                            If (And (Local0, 0x04))
                            {
                                Return (0x0F)
                            }
                        }
                        Else
                        {
                            If (And (Local0, 0x04))
                            {
                                Return (0x0B)
                            }
                        }

                        Return (0x00)
                    }

                    Method (_CRS, 0, Serialized)
                    {
                        ShiftRight (And (HPTE, 0x00038000), 0x0F, Local0)
                        If (And (Local0, 0x04))
                        {
                            CreateDWordField (BUF0, 0x0A, HPT0)
                            If (LEqual (Local0, 0x05))
                            {
                                Store (0xFED01000, HPT0)
                            }

                            If (LEqual (Local0, 0x06))
                            {
                                Store (0xFED02000, HPT0)
                            }

                            If (LEqual (Local0, 0x07))
                            {
                                Store (0xFED03000, HPT0)
                            }
                        }

                        Return (BUF0)
                    }
                }

                Device (H_EC)
                {
                    Name (_HID, EisaId ("PNP0C09"))
                    Name (_UID, 0x01)
                    Method (_CRS, 0, NotSerialized)
                    {
                        Name (BFFR, ResourceTemplate ()
                        {
                            IO (Decode16, 0x0062, 0x0062, 0x00, 0x01)
                            IO (Decode16, 0x0066, 0x0066, 0x00, 0x01)
                        })
                        Return (BFFR)
                    }

                    OperationRegion (ECR, EmbeddedControl, 0x00, 0xFF)
                    Field (ECR, ByteAcc, Lock, Preserve)
                    {
                        Offset (0x80), 
                        B1EX,   1, 
                        B2EX,   1, 
                        ACEX,   1, 
                        Offset (0x81), 
                        SWBE,   1, 
                        DCBE,   1, 
                        Offset (0x82), 
                        Offset (0x83), 
                        LIDS,   1, 
                        Offset (0x84), 
                        B1ST,   8, 
                        B2ST,   8, 
                        Offset (0xA0), 
                        B1RR,   32, 
                        B1PV,   32, 
                        B2RR,   32, 
                        B2PV,   32, 
                        B1AF,   32, 
                        B1VL,   32, 
                        B2AF,   32, 
                        B2VL,   32, 
                        CTMP,   8, 
                        Offset (0xD0), 
                        B1TI,   16, 
                        B1SE,   16, 
                        B1CR,   16, 
                        B1TM,   16, 
                        B2TI,   16, 
                        B2SE,   16, 
                        B2CR,   16, 
                        B2TM,   16
                    }

                    Method (_REG, 2, NotSerialized)
                    {
                        If (LAnd (LEqual (Arg0, 0x03), LEqual (Arg1, 0x01)))
                        {
                            Store (0x01, ECON)
                            Store (\_SB.PCI0.LPCB.H_EC.ACEX, \ACPS)
                        }
                    }

                    Name (_GPE, 0x1C)
                    Method (_GLK, 0, NotSerialized)
                    {
                        Return (One)
                    }

                    Method (_Q50, 0, NotSerialized)
                    {
                        Notify (\_SB.PWRB, 0x80)
                    }

                    Method (_Q51, 0, NotSerialized)
                    {
                        Store (0x51, P80H)
                        \_SB.PHS1 (0x82, 0x01)
                        Store (0x01, \ACPS)
                        Notify (\_SB.ADP1, 0x80)
                        \_SB.PHS (0x95)
                        Notify (\_PR.CPU0, 0x81)
                    }

                    Method (_Q52, 0, NotSerialized)
                    {
                        Store (0x52, P80H)
                        \_SB.PHS1 (0x82, 0x00)
                        Store (0x00, \ACPS)
                        Notify (\_SB.ADP1, 0x80)
                        \_SB.PHS (0x94)
                        Notify (\_PR.CPU0, 0x81)
                    }

                    Method (_Q53, 0, NotSerialized)
                    {
                        Store (0x53, P80H)
                        \_SB.PHS1 (0x8F, 0x01)
                        Notify (\_SB.BAT1, 0x01)
                        Notify (\_SB.BAT1, 0x81)
                    }

                    Method (_Q54, 0, NotSerialized)
                    {
                        Store (0x54, P80H)
                        \_SB.PHS1 (0x8F, 0x00)
                        Notify (\_SB.BAT1, 0x01)
                        Notify (\_SB.BAT1, 0x81)
                    }

                    Method (_Q5B, 0, NotSerialized)
                    {
                        Notify (\_SB.SLPB, 0x80)
                    }

                    Method (_Q5C, 0, NotSerialized)
                    {
                        \_SB.PHS (0x83)
                    }

                    Method (_Q5D, 0, NotSerialized)
                    {
                        If (LNot (LGreater (OSYS, 0x07CF)))
                        {
                            Store (0x3C, SMIF)
                            Store (0x03, VFUN)
                            Store (0x00, TRP0)
                            Notify (\_SB.PCI0.AGPB.NVID, 0x81)
                        }
                        Else
                        {
                            Store (0x3C, SMIF)
                            Store (0x05, VFUN)
                            Store (0x00, TRP0)
                            Store (SMIF, Local0)
                            If (LEqual (0x00, Local0))
                            {
                                Store (0x3C, SMIF)
                                Store (0x02, VFUN)
                                Store (0x00, TRP0)
                                If (LNot (LEqual (CADL, PADL)))
                                {
                                    Notify (\_SB.PCI0, 0x00)
                                    Sleep (0x03E8)
                                }

                                If (LEqual (0x00, DSEN))
                                {
                                    If (ENUM)
                                    {
                                        Store (0x3C, SMIF)
                                        Store (0x04, VFUN)
                                        Store (0x00, TRP0)
                                        Notify (\_SB.PCI0.AGPB.NVID, 0x80)
                                    }
                                }

                                If (LEqual (0x01, DSEN))
                                {
                                    Store (0x3C, SMIF)
                                    Store (0x03, VFUN)
                                    Store (0x00, TRP0)
                                    Notify (\_SB.PCI0.AGPB.NVID, 0x81)
                                }

                                If (LNot (LLess (DSEN, 0x02))) {}
                            }
                        }
                    }

                    Method (_Q5E, 0, NotSerialized)
                    {
                        Notify (\_SB.LID0, 0x80)
                    }

                    Method (_Q5F, 0, NotSerialized)
                    {
                        Notify (\_SB.LID0, 0x80)
                    }

                    Method (_Q60, 0, NotSerialized)
                    {
                        If (LEqual (B1EX, 0x01))
                        {
                            Notify (\_SB.BAT1, 0x01)
                        }
                    }

                    Method (_Q61, 0, NotSerialized)
                    {
                        If (LEqual (B1EX, 0x01))
                        {
                            Notify (\_SB.BAT1, 0x01)
                        }
                    }

                    Method (_Q65, 0, NotSerialized)
                    {
                        Notify (\_TZ.THRM, 0x80)
                    }

                    Method (_Q66, 0, NotSerialized)
                    {
                        Notify (\_SB.BAT1, 0x80)
                    }
                }

                Device (PS2K)
                {
                    Name (_HID, EisaId ("PNP0303"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0060, 0x0060, 0x01, 0x01)
                        IO (Decode16, 0x0064, 0x0064, 0x01, 0x01)
                        IRQ (Edge, ActiveHigh, Exclusive) {1}
                    })
                }

                Device (PS2M)
                {
                    Name (_HID, EisaId ("PNP0F13"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IRQ (Edge, ActiveHigh, Exclusive) {12}
                    })
                }
            }

            Device (USB0)
            {
                Name (_ADR, 0x001D0000)
                OperationRegion (U0CS, PCI_Config, 0xC4, 0x04)
                Field (U0CS, DWordAcc, NoLock, Preserve)
                {
                    U0EN,   2
                }

                Method (_PSW, 1, NotSerialized)
                {
                    If (Arg0)
                    {
                        Store (0x03, U0EN)
                    }
                    Else
                    {
                        Store (0x00, U0EN)
                    }
                }

                Method (_S1D, 0, NotSerialized)
                {
                    Return (0x02)
                }

                Method (_S3D, 0, NotSerialized)
                {
                    Return (0x02)
                }

                Method (_S4D, 0, NotSerialized)
                {
                    Return (0x02)
                }
            }

            Device (USB1)
            {
                Name (_ADR, 0x001D0001)
                OperationRegion (U1CS, PCI_Config, 0xC4, 0x04)
                Field (U1CS, DWordAcc, NoLock, Preserve)
                {
                    U1EN,   2
                }

                Method (_PSW, 1, NotSerialized)
                {
                    If (Arg0)
                    {
                        Store (0x03, U1EN)
                    }
                    Else
                    {
                        Store (0x00, U1EN)
                    }
                }

                Method (_S1D, 0, NotSerialized)
                {
                    Return (0x02)
                }

                Method (_S3D, 0, NotSerialized)
                {
                    Return (0x02)
                }

                Method (_S4D, 0, NotSerialized)
                {
                    Return (0x02)
                }
            }

            Device (USB2)
            {
                Name (_ADR, 0x001D0002)
                OperationRegion (U2CS, PCI_Config, 0xC4, 0x04)
                Field (U2CS, DWordAcc, NoLock, Preserve)
                {
                    U2EN,   2
                }

                Method (_PSW, 1, NotSerialized)
                {
                    If (Arg0)
                    {
                        Store (0x03, U2EN)
                    }
                    Else
                    {
                        Store (0x00, U2EN)
                    }
                }

                Method (_S1D, 0, NotSerialized)
                {
                    Return (0x02)
                }

                Method (_S3D, 0, NotSerialized)
                {
                    Return (0x02)
                }

                Method (_S4D, 0, NotSerialized)
                {
                    Return (0x02)
                }
            }

            Device (USB7)
            {
                Name (_ADR, 0x001D0007)
            }

            Name (NATA, Package (0x01)
            {
                0x001F0001
            })
            Device (IDEC)
            {
                Name (_ADR, 0x001F0001)
                OperationRegion (IDEC, PCI_Config, 0x40, 0x18)
                Field (IDEC, DWordAcc, NoLock, Preserve)
                {
                    PRIT,   16, 
                    SECT,   16, 
                    PSIT,   4, 
                    SSIT,   4, 
                    Offset (0x08), 
                    SYNC,   4, 
                    Offset (0x0A), 
                    SDT0,   2, 
                        ,   2, 
                    SDT1,   2, 
                    Offset (0x0B), 
                    SDT2,   2, 
                        ,   2, 
                    SDT3,   2, 
                    Offset (0x14), 
                    ICR0,   4, 
                    ICR1,   4, 
                    ICR2,   4, 
                    ICR3,   4, 
                    ICR4,   4, 
                    ICR5,   4
                }

                Device (PRID)
                {
                    Name (_ADR, 0x00)
                    Method (_GTM, 0, NotSerialized)
                    {
                        Name (PBUF, Buffer (0x14)
                        {
                            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
                            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
                            0x00, 0x00, 0x00, 0x00
                        })
                        CreateDWordField (PBUF, 0x00, PIO0)
                        CreateDWordField (PBUF, 0x04, DMA0)
                        CreateDWordField (PBUF, 0x08, PIO1)
                        CreateDWordField (PBUF, 0x0C, DMA1)
                        CreateDWordField (PBUF, 0x10, FLAG)
                        Store (GETP (PRIT), PIO0)
                        Store (GDMA (And (SYNC, 0x01), And (ICR3, 0x01), And (ICR0, 0x01), SDT0, And (ICR1, 0x01)), DMA0)
                        If (LEqual (DMA0, 0xFFFFFFFF))
                        {
                            Store (PIO0, DMA0)
                        }

                        If (And (PRIT, 0x4000))
                        {
                            If (LEqual (And (PRIT, 0x90), 0x80))
                            {
                                Store (0x0384, PIO1)
                            }
                            Else
                            {
                                Store (GETT (PSIT), PIO1)
                            }
                        }
                        Else
                        {
                            Store (0xFFFFFFFF, PIO1)
                        }

                        Store (GDMA (And (SYNC, 0x02), And (ICR3, 0x02), And (ICR0, 0x02), SDT1, And (ICR1, 0x02)), DMA1)
                        If (LEqual (DMA1, 0xFFFFFFFF))
                        {
                            Store (PIO1, DMA1)
                        }

                        Store (GETF (And (SYNC, 0x01), And (SYNC, 0x02), PRIT), FLAG)
                        Return (PBUF)
                    }

                    Method (_STM, 3, NotSerialized)
                    {
                        CreateDWordField (Arg0, 0x00, PIO0)
                        CreateDWordField (Arg0, 0x04, DMA0)
                        CreateDWordField (Arg0, 0x08, PIO1)
                        CreateDWordField (Arg0, 0x0C, DMA1)
                        CreateDWordField (Arg0, 0x10, FLAG)
                        Or (ICR2, 0x04, ICR2)
                        If (LEqual (SizeOf (Arg1), 0x0200))
                        {
                            And (PRIT, 0x40F0, PRIT)
                            And (SYNC, 0x0E, SYNC)
                            Store (0x00, SDT0)
                            And (ICR0, 0x0E, ICR0)
                            And (ICR1, 0x0E, ICR1)
                            And (ICR3, 0x0E, ICR3)
                            And (ICR5, 0x0E, ICR5)
                            CreateWordField (Arg1, 0x62, W490)
                            CreateWordField (Arg1, 0x6A, W530)
                            CreateWordField (Arg1, 0x7E, W630)
                            CreateWordField (Arg1, 0x80, W640)
                            CreateWordField (Arg1, 0xB0, W880)
                            CreateWordField (Arg1, 0xBA, W930)
                            Or (PRIT, 0x8004, PRIT)
                            If (LAnd (And (FLAG, 0x02), And (W490, 0x0800)))
                            {
                                Or (PRIT, 0x02, PRIT)
                            }

                            Or (PRIT, SETP (PIO0, W530, W640), PRIT)
                            If (And (FLAG, 0x01))
                            {
                                Or (SYNC, 0x01, SYNC)
                                Store (SDMA (DMA0), SDT0)
                                If (LLess (DMA0, 0x1E))
                                {
                                    Or (ICR3, 0x01, ICR3)
                                }

                                If (LLess (DMA0, 0x3C))
                                {
                                    Or (ICR0, 0x01, ICR0)
                                }

                                If (And (W930, 0x2000))
                                {
                                    Or (ICR1, 0x01, ICR1)
                                }
                            }
                        }

                        If (LEqual (SizeOf (Arg2), 0x0200))
                        {
                            And (PRIT, 0x3F0F, PRIT)
                            Store (0x00, PSIT)
                            And (SYNC, 0x0D, SYNC)
                            Store (0x00, SDT1)
                            And (ICR0, 0x0D, ICR0)
                            And (ICR1, 0x0D, ICR1)
                            And (ICR3, 0x0D, ICR3)
                            And (ICR5, 0x0D, ICR5)
                            CreateWordField (Arg2, 0x62, W491)
                            CreateWordField (Arg2, 0x6A, W531)
                            CreateWordField (Arg2, 0x7E, W631)
                            CreateWordField (Arg2, 0x80, W641)
                            CreateWordField (Arg2, 0xB0, W881)
                            CreateWordField (Arg2, 0xBA, W931)
                            Or (PRIT, 0x8040, PRIT)
                            If (LAnd (And (FLAG, 0x08), And (W491, 0x0800)))
                            {
                                Or (PRIT, 0x20, PRIT)
                            }

                            If (And (FLAG, 0x10))
                            {
                                Or (PRIT, 0x4000, PRIT)
                                If (LGreater (PIO1, 0xF0))
                                {
                                    Or (PRIT, 0x80, PRIT)
                                }
                                Else
                                {
                                    Or (PRIT, 0x10, PRIT)
                                    Store (SETT (PIO1, W531, W641), PSIT)
                                }
                            }

                            If (And (FLAG, 0x04))
                            {
                                Or (SYNC, 0x02, SYNC)
                                Store (SDMA (DMA1), SDT1)
                                If (LLess (DMA1, 0x1E))
                                {
                                    Or (ICR3, 0x02, ICR3)
                                }

                                If (LLess (DMA1, 0x3C))
                                {
                                    Or (ICR0, 0x02, ICR0)
                                }

                                If (And (W931, 0x2000))
                                {
                                    Or (ICR1, 0x02, ICR1)
                                }
                            }
                        }
                    }

                    Device (P_D0)
                    {
                        Name (_ADR, 0x00)
                        Method (_GTF, 0, NotSerialized)
                        {
                            Name (PIB0, Buffer (0x0E)
                            {
                                0x03, 0x00, 0x00, 0x00, 0x00, 0xA0, 0xEF, 0x03, 
                                0x00, 0x00, 0x00, 0x00, 0xA0, 0xEF
                            })
                            CreateByteField (PIB0, 0x01, PMD0)
                            CreateByteField (PIB0, 0x08, DMD0)
                            If (And (PRIT, 0x02))
                            {
                                If (LEqual (And (PRIT, 0x09), 0x08))
                                {
                                    Store (0x08, PMD0)
                                }
                                Else
                                {
                                    Store (0x0A, PMD0)
                                    ShiftRight (And (PRIT, 0x0300), 0x08, Local0)
                                    ShiftRight (And (PRIT, 0x3000), 0x0C, Local1)
                                    Add (Local0, Local1, Local2)
                                    If (LEqual (0x03, Local2))
                                    {
                                        Store (0x0B, PMD0)
                                    }

                                    If (LEqual (0x05, Local2))
                                    {
                                        Store (0x0C, PMD0)
                                    }
                                }
                            }
                            Else
                            {
                                Store (0x01, PMD0)
                            }

                            If (And (SYNC, 0x01))
                            {
                                Store (Or (SDT0, 0x40), DMD0)
                                If (And (ICR1, 0x01))
                                {
                                    If (And (ICR0, 0x01))
                                    {
                                        Add (DMD0, 0x02, DMD0)
                                    }

                                    If (And (ICR3, 0x01))
                                    {
                                        Store (0x45, DMD0)
                                    }
                                }
                            }
                            Else
                            {
                                Or (Subtract (And (PMD0, 0x07), 0x02), 0x20, DMD0)
                            }

                            Return (PIB0)
                        }

                        Name (FWSO, "FWSO")
                    }

                    Device (P_D1)
                    {
                        Name (_ADR, 0x01)
                        Method (_GTF, 0, NotSerialized)
                        {
                            Name (PIB1, Buffer (0x0E)
                            {
                                0x03, 0x00, 0x00, 0x00, 0x00, 0xB0, 0xEF, 0x03, 
                                0x00, 0x00, 0x00, 0x00, 0xB0, 0xEF
                            })
                            CreateByteField (PIB1, 0x01, PMD1)
                            CreateByteField (PIB1, 0x08, DMD1)
                            If (And (PRIT, 0x20))
                            {
                                If (LEqual (And (PRIT, 0x90), 0x80))
                                {
                                    Store (0x08, PMD1)
                                }
                                Else
                                {
                                    Add (And (PSIT, 0x03), ShiftRight (And (PSIT, 0x0C), 0x02), Local0)
                                    If (LEqual (0x05, Local0))
                                    {
                                        Store (0x0C, PMD1)
                                    }
                                    Else
                                    {
                                        If (LEqual (0x03, Local0))
                                        {
                                            Store (0x0B, PMD1)
                                        }
                                        Else
                                        {
                                            Store (0x0A, PMD1)
                                        }
                                    }
                                }
                            }
                            Else
                            {
                                Store (0x01, PMD1)
                            }

                            If (And (SYNC, 0x02))
                            {
                                Store (Or (SDT1, 0x40), DMD1)
                                If (And (ICR1, 0x02))
                                {
                                    If (And (ICR0, 0x02))
                                    {
                                        Add (DMD1, 0x02, DMD1)
                                    }

                                    If (And (ICR3, 0x02))
                                    {
                                        Store (0x45, DMD1)
                                    }
                                }
                            }
                            Else
                            {
                                Or (Subtract (And (PMD1, 0x07), 0x02), 0x20, DMD1)
                            }

                            Return (PIB1)
                        }
                    }

                    Method (_PS0, 0, NotSerialized)
                    {
                    }

                    Method (_PS3, 0, NotSerialized)
                    {
                    }
                }

                Device (SECD)
                {
                    Name (_ADR, 0x01)
                    Method (_GTM, 0, NotSerialized)
                    {
                        Name (SBUF, Buffer (0x14)
                        {
                            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
                            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
                            0x00, 0x00, 0x00, 0x00
                        })
                        CreateDWordField (SBUF, 0x00, PIO0)
                        CreateDWordField (SBUF, 0x04, DMA0)
                        CreateDWordField (SBUF, 0x08, PIO1)
                        CreateDWordField (SBUF, 0x0C, DMA1)
                        CreateDWordField (SBUF, 0x10, FLAG)
                        Store (GETP (SECT), PIO0)
                        Store (GDMA (And (SYNC, 0x04), And (ICR3, 0x04), And (ICR0, 0x04), SDT2, And (ICR1, 0x04)), DMA0)
                        If (LEqual (DMA0, 0xFFFFFFFF))
                        {
                            Store (PIO0, DMA0)
                        }

                        If (And (SECT, 0x4000))
                        {
                            If (LEqual (And (SECT, 0x90), 0x80))
                            {
                                Store (0x0384, PIO1)
                            }
                            Else
                            {
                                Store (GETT (SSIT), PIO1)
                            }
                        }
                        Else
                        {
                            Store (0xFFFFFFFF, PIO1)
                        }

                        Store (GDMA (And (SYNC, 0x08), And (ICR3, 0x08), And (ICR0, 0x08), SDT3, And (ICR1, 0x08)), DMA1)
                        If (LEqual (DMA1, 0xFFFFFFFF))
                        {
                            Store (PIO1, DMA1)
                        }

                        Store (GETF (And (SYNC, 0x04), And (SYNC, 0x08), SECT), FLAG)
                        Return (SBUF)
                    }

                    Method (_STM, 3, NotSerialized)
                    {
                        CreateDWordField (Arg0, 0x00, PIO0)
                        CreateDWordField (Arg0, 0x04, DMA0)
                        CreateDWordField (Arg0, 0x08, PIO1)
                        CreateDWordField (Arg0, 0x0C, DMA1)
                        CreateDWordField (Arg0, 0x10, FLAG)
                        Or (ICR2, 0x04, ICR2)
                        If (LEqual (SizeOf (Arg1), 0x0200))
                        {
                            And (SECT, 0x40F0, SECT)
                            And (SYNC, 0x0B, SYNC)
                            Store (0x00, SDT2)
                            And (ICR0, 0x0B, ICR0)
                            And (ICR1, 0x0B, ICR1)
                            And (ICR3, 0x0B, ICR3)
                            And (ICR5, 0x0B, ICR5)
                            CreateWordField (Arg1, 0x62, W490)
                            CreateWordField (Arg1, 0x6A, W530)
                            CreateWordField (Arg1, 0x7E, W630)
                            CreateWordField (Arg1, 0x80, W640)
                            CreateWordField (Arg1, 0xB0, W880)
                            CreateWordField (Arg1, 0xBA, W930)
                            Or (SECT, 0x8004, SECT)
                            If (LAnd (And (FLAG, 0x02), And (W490, 0x0800)))
                            {
                                Or (SECT, 0x02, SECT)
                            }

                            Or (SECT, SETP (PIO0, W530, W640), SECT)
                            If (And (FLAG, 0x01))
                            {
                                Or (SYNC, 0x04, SYNC)
                                Store (SDMA (DMA0), SDT2)
                                If (LLess (DMA0, 0x1E))
                                {
                                    Or (ICR3, 0x04, ICR3)
                                }

                                If (LLess (DMA0, 0x3C))
                                {
                                    Or (ICR0, 0x04, ICR0)
                                }

                                If (And (W930, 0x2000))
                                {
                                    Or (ICR1, 0x04, ICR1)
                                }
                            }
                        }

                        If (LEqual (SizeOf (Arg2), 0x0200))
                        {
                            And (SECT, 0x3F0F, SECT)
                            Store (0x00, SSIT)
                            And (SYNC, 0x07, SYNC)
                            Store (0x00, SDT3)
                            And (ICR0, 0x07, ICR0)
                            And (ICR1, 0x07, ICR1)
                            And (ICR3, 0x07, ICR3)
                            And (ICR5, 0x07, ICR5)
                            CreateWordField (Arg2, 0x62, W491)
                            CreateWordField (Arg2, 0x6A, W531)
                            CreateWordField (Arg2, 0x7E, W631)
                            CreateWordField (Arg2, 0x80, W641)
                            CreateWordField (Arg2, 0xB0, W881)
                            CreateWordField (Arg2, 0xBA, W931)
                            Or (SECT, 0x8040, SECT)
                            If (LAnd (And (FLAG, 0x08), And (W491, 0x0800)))
                            {
                                Or (SECT, 0x20, SECT)
                            }

                            If (And (FLAG, 0x10))
                            {
                                Or (SECT, 0x4000, SECT)
                                If (LGreater (PIO1, 0xF0))
                                {
                                    Or (SECT, 0x80, SECT)
                                }
                                Else
                                {
                                    Or (SECT, 0x10, SECT)
                                    Store (SETT (PIO1, W531, W641), SSIT)
                                }
                            }

                            If (And (FLAG, 0x04))
                            {
                                Or (SYNC, 0x08, SYNC)
                                Store (SDMA (DMA1), SDT3)
                                If (LLess (DMA1, 0x1E))
                                {
                                    Or (ICR3, 0x08, ICR3)
                                }

                                If (LLess (DMA1, 0x3C))
                                {
                                    Or (ICR0, 0x08, ICR0)
                                }

                                If (And (W931, 0x2000))
                                {
                                    Or (ICR1, 0x08, ICR1)
                                }
                            }
                        }
                    }

                    Device (S_D0)
                    {
                        Name (_ADR, 0x00)
                        Method (_GTF, 0, NotSerialized)
                        {
                            Name (SIB0, Buffer (0x0E)
                            {
                                0x03, 0x00, 0x00, 0x00, 0x00, 0xA0, 0xEF, 0x03, 
                                0x00, 0x00, 0x00, 0x00, 0xA0, 0xEF
                            })
                            CreateByteField (SIB0, 0x01, PMD0)
                            CreateByteField (SIB0, 0x08, DMD0)
                            If (And (SECT, 0x02))
                            {
                                If (LEqual (And (SECT, 0x09), 0x08))
                                {
                                    Store (0x08, PMD0)
                                }
                                Else
                                {
                                    Store (0x0A, PMD0)
                                    ShiftRight (And (SECT, 0x0300), 0x08, Local0)
                                    ShiftRight (And (SECT, 0x3000), 0x0C, Local1)
                                    Add (Local0, Local1, Local2)
                                    If (LEqual (0x03, Local2))
                                    {
                                        Store (0x0B, PMD0)
                                    }

                                    If (LEqual (0x05, Local2))
                                    {
                                        Store (0x0C, PMD0)
                                    }
                                }
                            }
                            Else
                            {
                                Store (0x01, PMD0)
                            }

                            If (And (SYNC, 0x04))
                            {
                                Store (Or (SDT2, 0x40), DMD0)
                                If (And (ICR1, 0x04))
                                {
                                    If (And (ICR0, 0x04))
                                    {
                                        Add (DMD0, 0x02, DMD0)
                                    }

                                    If (And (ICR3, 0x04))
                                    {
                                        Store (0x45, DMD0)
                                    }
                                }
                            }
                            Else
                            {
                                Or (Subtract (And (PMD0, 0x07), 0x02), 0x20, DMD0)
                            }

                            Return (SIB0)
                        }
                    }

                    Device (S_D1)
                    {
                        Name (_ADR, 0x01)
                        Method (_GTF, 0, NotSerialized)
                        {
                            Name (SIB1, Buffer (0x0E)
                            {
                                0x03, 0x00, 0x00, 0x00, 0x00, 0xB0, 0xEF, 0x03, 
                                0x00, 0x00, 0x00, 0x00, 0xB0, 0xEF
                            })
                            CreateByteField (SIB1, 0x01, PMD1)
                            CreateByteField (SIB1, 0x08, DMD1)
                            If (And (SECT, 0x20))
                            {
                                If (LEqual (And (SECT, 0x90), 0x80))
                                {
                                    Store (0x08, PMD1)
                                }
                                Else
                                {
                                    Add (And (SSIT, 0x03), ShiftRight (And (SSIT, 0x0C), 0x02), Local0)
                                    If (LEqual (0x05, Local0))
                                    {
                                        Store (0x0C, PMD1)
                                    }
                                    Else
                                    {
                                        If (LEqual (0x03, Local0))
                                        {
                                            Store (0x0B, PMD1)
                                        }
                                        Else
                                        {
                                            Store (0x0A, PMD1)
                                        }
                                    }
                                }
                            }
                            Else
                            {
                                Store (0x01, PMD1)
                            }

                            If (And (SYNC, 0x08))
                            {
                                Store (Or (SDT3, 0x40), DMD1)
                                If (And (ICR1, 0x08))
                                {
                                    If (And (ICR0, 0x08))
                                    {
                                        Add (DMD1, 0x02, DMD1)
                                    }

                                    If (And (ICR3, 0x08))
                                    {
                                        Store (0x45, DMD1)
                                    }
                                }
                            }
                            Else
                            {
                                Or (Subtract (And (PMD1, 0x07), 0x02), 0x20, DMD1)
                            }

                            Return (SIB1)
                        }
                    }

                    Method (_PS0, 0, NotSerialized)
                    {
                    }

                    Method (_PS3, 0, NotSerialized)
                    {
                    }
                }

                Method (GETP, 1, Serialized)
                {
                    If (LEqual (And (Arg0, 0x09), 0x00))
                    {
                        Return (0xFFFFFFFF)
                    }

                    If (LEqual (And (Arg0, 0x09), 0x08))
                    {
                        Return (0x0384)
                    }

                    ShiftRight (And (Arg0, 0x0300), 0x08, Local0)
                    ShiftRight (And (Arg0, 0x3000), 0x0C, Local1)
                    Return (Multiply (0x1E, Subtract (0x09, Add (Local0, Local1))))
                }

                Method (GDMA, 5, Serialized)
                {
                    If (Arg0)
                    {
                        If (LAnd (Arg1, Arg4))
                        {
                            Return (0x14)
                        }

                        If (LAnd (Arg2, Arg4))
                        {
                            Return (Multiply (Subtract (0x04, Arg3), 0x0F))
                        }

                        Return (Multiply (Subtract (0x04, Arg3), 0x1E))
                    }

                    Return (0xFFFFFFFF)
                }

                Method (GETT, 1, Serialized)
                {
                    Return (Multiply (0x1E, Subtract (0x09, Add (And (ShiftRight (Arg0, 0x02), 0x03), And (Arg0, 0x03)))))
                }

                Method (GETF, 3, Serialized)
                {
                    Name (TMPF, 0x00)
                    If (Arg0)
                    {
                        Or (TMPF, 0x01, TMPF)
                    }

                    If (And (Arg2, 0x02))
                    {
                        Or (TMPF, 0x02, TMPF)
                    }

                    If (Arg1)
                    {
                        Or (TMPF, 0x04, TMPF)
                    }

                    If (And (Arg2, 0x20))
                    {
                        Or (TMPF, 0x08, TMPF)
                    }

                    If (And (Arg2, 0x4000))
                    {
                        Or (TMPF, 0x10, TMPF)
                    }

                    Return (TMPF)
                }

                Method (SETP, 3, Serialized)
                {
                    If (LGreater (Arg0, 0xF0))
                    {
                        Return (0x08)
                    }
                    Else
                    {
                        If (And (Arg1, 0x02))
                        {
                            If (LAnd (LNot (LGreater (Arg0, 0x78)), And (Arg2, 0x02)))
                            {
                                Return (0x2301)
                            }

                            If (LAnd (LNot (LGreater (Arg0, 0xB4)), And (Arg2, 0x01)))
                            {
                                Return (0x2101)
                            }
                        }

                        Return (0x1001)
                    }
                }

                Method (SDMA, 1, Serialized)
                {
                    If (LNot (LGreater (Arg0, 0x14)))
                    {
                        Return (0x01)
                    }

                    If (LNot (LGreater (Arg0, 0x1E)))
                    {
                        Return (0x02)
                    }

                    If (LNot (LGreater (Arg0, 0x2D)))
                    {
                        Return (0x01)
                    }

                    If (LNot (LGreater (Arg0, 0x3C)))
                    {
                        Return (0x02)
                    }

                    If (LNot (LGreater (Arg0, 0x5A)))
                    {
                        Return (0x01)
                    }

                    Return (0x00)
                }

                Method (SETT, 3, Serialized)
                {
                    If (And (Arg1, 0x02))
                    {
                        If (LAnd (LNot (LGreater (Arg0, 0x78)), And (Arg2, 0x02)))
                        {
                            Return (0x0B)
                        }

                        If (LAnd (LNot (LGreater (Arg0, 0xB4)), And (Arg2, 0x01)))
                        {
                            Return (0x09)
                        }
                    }

                    Return (0x04)
                }
            }

            Device (SBUS)
            {
                Name (_ADR, 0x001F0003)
                OperationRegion (SBUS, SystemIO, 0x1860, 0x10)
                Field (SBUS, ByteAcc, NoLock, Preserve)
                {
                    HSTS,   8, 
                    Offset (0x02), 
                    HCON,   8, 
                    HCOM,   8, 
                    TXSA,   8, 
                    DAT0,   8, 
                    DAT1,   8, 
                    BDBR,   8, 
                    Offset (0x09), 
                    RXSA,   8, 
                    SDAT,   16
                }

                Method (SBWB, 3, NotSerialized)
                {
                    While (And (HSTS, 0x01)) {}
                    Store (0x1E, HSTS)
                    Store (Arg0, TXSA)
                    Store (Arg1, HCOM)
                    Store (Arg2, DAT0)
                    Store (0x48, HCON)
                    While (LEqual (And (HSTS, 0x1E), 0x00)) {}
                    Store (0x1E, HSTS)
                }

                Method (SBRB, 2, NotSerialized)
                {
                    While (And (HSTS, 0x01)) {}
                    Store (0x1E, HSTS)
                    Store (Or (Arg0, 0x01), TXSA)
                    Store (Arg1, HCOM)
                    Store (0x48, HCON)
                    While (LEqual (And (HSTS, 0x1E), 0x00)) {}
                    Store (0x1E, HSTS)
                    Return (DAT0)
                }
            }

            Device (AUD0)
            {
                Name (_ADR, 0x001F0005)
            }

            Device (MODM)
            {
                Name (_ADR, 0x001F0006)
                Name (_PRW, Package (0x02)
                {
                    0x05, 
                    0x04
                })
            }
        }
    }
}


--=-hIbk9fTgo4t4OqvX1TQn--



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
