From: =?iso-8859-1?Q?=C9ric?= Brunet <ebrunet-l5PIGlIYzrxGWvitb5QawA@public.gmane.org>
Subject: Several problems on a toshiba S3000-X11
Date: Fri, 27 Sep 2002 16:23:20 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020927142320.GB2821@lps.ens.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="M9NhX3UHpAaciwkO"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: mcelrath-/+vdk8Lzq6wBYXXUC76CrNADJCGDAxhI@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by platane.lps.ens.fr id g8RENK503374

Hi !

I am using acpi-20020829 with a 2.4.20pre5 kernel on a toshiba satellite
3000-X11, with the custom DSDT made by Bruno Ducrot. The previous acpi
patch I used was acpi-20020503 (I think) with the native DSDT.
I also use the toshiba_3000 module by Bruno.

I have one big problem: my computer shuts down without warning. I have
also some minor problems, and I will begin with those.

	MINOR PROBLEMS
	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

When I read the battery state for the first couple of times, the
/proc/acpi files claim that I have two batteries present, and that both
batteries have a charge of 2040 mAh (capacity is 4000 mAh). After a
couple of readings, I have the truth (only one battery and whatever
capacity I have left.) That's annoying, and it didn't happen with my
previous kernel. I don't now if it comes from the patched DSDT or from
the new version of the acpi patch.

When ACPI assigns interrupts at boot, I get
	ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 9 *10 11 12 14 15)
	ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 9 *10 11 12 14 15)
	ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 *9 10 11 12 14 15)
	ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 *9 10 11 12 14 15)
Now I am __nearly__ sure that there was a version of the ACPI patch where
the interrupts were more evenly distributed. Did I dream that or was a
patch reverted ?

In order to have S1 working, I have to apply this patch (originally by
Bruno Ducrot)
-------------------------------------------------------------------------=
---
--- drivers/acpi/hardware/hwsleep.c.orig        Sun Sep  1 16:54:05 2002
+++ drivers/acpi/hardware/hwsleep.c     Sun Sep  1 18:24:33 2002
@@ -269,6 +269,9 @@

        ACPI_FLUSH_CPU_CACHE ();

+       /* Disable BM arbitration */
+       acpi_set_register(ACPI_BITREG_ARB_DISABLE, 1, ACPI_MTX_DO_NOT_LOC=
K);
+
        status =3D acpi_hw_register_write (ACPI_MTX_LOCK, ACPI_REGISTER_P=
M1A_CONTROL, PM1Acontrol);
        if (ACPI_FAILURE (status)) {
                return_ACPI_STATUS (status);
@@ -309,6 +312,9 @@

        } while (!in_value);

+       /* Restore BM arbitration */
+       acpi_set_register(ACPI_BITREG_ARB_DISABLE, 0, ACPI_MTX_DO_NOT_LOC=
K);
+
        return_ACPI_STATUS (AE_OK);
 }
-------------------------------------------------------------------------=
-------
(note that I have only tried vanilla acpi patch; acpi patch + this two
liners; and acpi patch + this two liners + patched DSDT.  Maybe S1 works
fine with acpi patch + patched DSDT __without__ this two liners. I will
check)

With this patch, when I come back from S1, the computer hangs if I try to
use DMA on the DVD player. Whereas, of course, DMA on the hard drive
works fine. (Maybe I should play with hdparm on the DVD after wake-up...)

		MAJOR PROBLEM
		=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
So the computer shuts down, without warning, while it is not particulary
hot, with nothing written in the logs, while the user was just using vim
in a xterm, at irregular times, and it can happen two or three times in
an afternoon.

That's a major nuisance. By the way, I can confirm that ext3 works very
nicely at recovering a filesystem.

I have an hypothesis; somehow I think there is something wrong in the
reading of the temperature. When I read the temperature, there are some
very unnatural pics; the computer was at 53 degree, then jumps 3 seconds
at 60 and comes back at 53. I believe that, some time to time, this
unnatural jump goes over the critical trippoint and the computer shuts
down in emergency.

The reading of temperatures was made with
while true; do cat /proc/toshiba3k/temperature | awk '{print $1}' >> t; s=
leep 1;done

I have attached a postscript file showing the result. Note the pics at
around 500 seconds, 800 seconds, etc. (My trip points are 48 and 53
degrees)

Now, what can cause this ? And, more important for me, is there a way to
desactivate emergency shutdown at critical temperature ? Or, better, make
the emergency shutdown occurs only if the __average__ temperature over,
say, the last 5 seconds is over some thresold ?

If you have any idea, I would love to hear it... Meanwhile, I will try
the latest patch.

Regards,

	=C9ric Brunet

--M9NhX3UHpAaciwkO
Content-Type: application/postscript
Content-Disposition: attachment; filename="temp.ps"
Content-Transfer-Encoding: quoted-printable

%!PS-Adobe-2.0=0A%%Title: temp.ps=0A%%Creator: gnuplot 3.7 patchlevel 1=0A%=
%CreationDate: Thu Sep 26 15:40:52 2002=0A%%DocumentFonts: (atend)=0A%%Boun=
dingBox: 50 50 554 770=0A%%Orientation: Landscape=0A%%Pages: (atend)=0A%%En=
dComments=0A/gnudict 256 dict def=0Agnudict begin=0A/Color false def=0A/Sol=
id false def=0A/gnulinewidth 5.000 def=0A/userlinewidth gnulinewidth def=0A=
/vshift -46 def=0A/dl {10 mul} def=0A/hpt_ 31.5 def=0A/vpt_ 31.5 def=0A/hpt=
 hpt_ def=0A/vpt vpt_ def=0A/M {moveto} bind def=0A/L {lineto} bind def=0A/=
R {rmoveto} bind def=0A/V {rlineto} bind def=0A/vpt2 vpt 2 mul def=0A/hpt2 =
hpt 2 mul def=0A/Lshow { currentpoint stroke M=0A  0 vshift R show } def=0A=
/Rshow { currentpoint stroke M=0A  dup stringwidth pop neg vshift R show } =
def=0A/Cshow { currentpoint stroke M=0A  dup stringwidth pop -2 div vshift =
R show } def=0A/UP { dup vpt_ mul /vpt exch def hpt_ mul /hpt exch def=0A  =
/hpt2 hpt 2 mul def /vpt2 vpt 2 mul def } def=0A/DL { Color {setrgbcolor So=
lid {pop []} if 0 setdash }=0A {pop pop pop Solid {pop []} if 0 setdash} if=
else } def=0A/BL { stroke userlinewidth 2 mul setlinewidth } def=0A/AL { st=
roke userlinewidth 2 div setlinewidth } def=0A/UL { dup gnulinewidth mul /u=
serlinewidth exch def=0A      10 mul /udl exch def } def=0A/PL { stroke use=
rlinewidth setlinewidth } def=0A/LTb { BL [] 0 0 0 DL } def=0A/LTa { AL [1 =
udl mul 2 udl mul] 0 setdash 0 0 0 setrgbcolor } def=0A/LT0 { PL [] 1 0 0 D=
L } def=0A/LT1 { PL [4 dl 2 dl] 0 1 0 DL } def=0A/LT2 { PL [2 dl 3 dl] 0 0 =
1 DL } def=0A/LT3 { PL [1 dl 1.5 dl] 1 0 1 DL } def=0A/LT4 { PL [5 dl 2 dl =
1 dl 2 dl] 0 1 1 DL } def=0A/LT5 { PL [4 dl 3 dl 1 dl 3 dl] 1 1 0 DL } def=
=0A/LT6 { PL [2 dl 2 dl 2 dl 4 dl] 0 0 0 DL } def=0A/LT7 { PL [2 dl 2 dl 2 =
dl 2 dl 2 dl 4 dl] 1 0.3 0 DL } def=0A/LT8 { PL [2 dl 2 dl 2 dl 2 dl 2 dl 2=
 dl 2 dl 4 dl] 0.5 0.5 0.5 DL } def=0A/Pnt { stroke [] 0 setdash=0A   gsave=
 1 setlinecap M 0 0 V stroke grestore } def=0A/Dia { stroke [] 0 setdash 2 =
copy vpt add M=0A  hpt neg vpt neg V hpt vpt neg V=0A  hpt vpt V hpt neg vp=
t V closepath stroke=0A  Pnt } def=0A/Pls { stroke [] 0 setdash vpt sub M 0=
 vpt2 V=0A  currentpoint stroke M=0A  hpt neg vpt neg R hpt2 0 V stroke=0A =
 } def=0A/Box { stroke [] 0 setdash 2 copy exch hpt sub exch vpt add M=0A  =
0 vpt2 neg V hpt2 0 V 0 vpt2 V=0A  hpt2 neg 0 V closepath stroke=0A  Pnt } =
def=0A/Crs { stroke [] 0 setdash exch hpt sub exch vpt add M=0A  hpt2 vpt2 =
neg V currentpoint stroke M=0A  hpt2 neg 0 R hpt2 vpt2 V stroke } def=0A/Tr=
iU { stroke [] 0 setdash 2 copy vpt 1.12 mul add M=0A  hpt neg vpt -1.62 mu=
l V=0A  hpt 2 mul 0 V=0A  hpt neg vpt 1.62 mul V closepath stroke=0A  Pnt  =
} def=0A/Star { 2 copy Pls Crs } def=0A/BoxF { stroke [] 0 setdash exch hpt=
 sub exch vpt add M=0A  0 vpt2 neg V  hpt2 0 V  0 vpt2 V=0A  hpt2 neg 0 V  =
closepath fill } def=0A/TriUF { stroke [] 0 setdash vpt 1.12 mul add M=0A  =
hpt neg vpt -1.62 mul V=0A  hpt 2 mul 0 V=0A  hpt neg vpt 1.62 mul V closep=
ath fill } def=0A/TriD { stroke [] 0 setdash 2 copy vpt 1.12 mul sub M=0A  =
hpt neg vpt 1.62 mul V=0A  hpt 2 mul 0 V=0A  hpt neg vpt -1.62 mul V closep=
ath stroke=0A  Pnt  } def=0A/TriDF { stroke [] 0 setdash vpt 1.12 mul sub M=
=0A  hpt neg vpt 1.62 mul V=0A  hpt 2 mul 0 V=0A  hpt neg vpt -1.62 mul V c=
losepath fill} def=0A/DiaF { stroke [] 0 setdash vpt add M=0A  hpt neg vpt =
neg V hpt vpt neg V=0A  hpt vpt V hpt neg vpt V closepath fill } def=0A/Pen=
t { stroke [] 0 setdash 2 copy gsave=0A  translate 0 hpt M 4 {72 rotate 0 h=
pt L} repeat=0A  closepath stroke grestore Pnt } def=0A/PentF { stroke [] 0=
 setdash gsave=0A  translate 0 hpt M 4 {72 rotate 0 hpt L} repeat=0A  close=
path fill grestore } def=0A/Circle { stroke [] 0 setdash 2 copy=0A  hpt 0 3=
60 arc stroke Pnt } def=0A/CircleF { stroke [] 0 setdash hpt 0 360 arc fill=
 } def=0A/C0 { BL [] 0 setdash 2 copy moveto vpt 90 450  arc } bind def=0A/=
C1 { BL [] 0 setdash 2 copy        moveto=0A       2 copy  vpt 0 90 arc clo=
sepath fill=0A               vpt 0 360 arc closepath } bind def=0A/C2 { BL =
[] 0 setdash 2 copy moveto=0A       2 copy  vpt 90 180 arc closepath fill=
=0A               vpt 0 360 arc closepath } bind def=0A/C3 { BL [] 0 setdas=
h 2 copy moveto=0A       2 copy  vpt 0 180 arc closepath fill=0A           =
    vpt 0 360 arc closepath } bind def=0A/C4 { BL [] 0 setdash 2 copy movet=
o=0A       2 copy  vpt 180 270 arc closepath fill=0A               vpt 0 36=
0 arc closepath } bind def=0A/C5 { BL [] 0 setdash 2 copy moveto=0A       2=
 copy  vpt 0 90 arc=0A       2 copy moveto=0A       2 copy  vpt 180 270 arc=
 closepath fill=0A               vpt 0 360 arc } bind def=0A/C6 { BL [] 0 s=
etdash 2 copy moveto=0A      2 copy  vpt 90 270 arc closepath fill=0A      =
        vpt 0 360 arc closepath } bind def=0A/C7 { BL [] 0 setdash 2 copy m=
oveto=0A      2 copy  vpt 0 270 arc closepath fill=0A              vpt 0 36=
0 arc closepath } bind def=0A/C8 { BL [] 0 setdash 2 copy moveto=0A      2 =
copy vpt 270 360 arc closepath fill=0A              vpt 0 360 arc closepath=
 } bind def=0A/C9 { BL [] 0 setdash 2 copy moveto=0A      2 copy  vpt 270 4=
50 arc closepath fill=0A              vpt 0 360 arc closepath } bind def=0A=
/C10 { BL [] 0 setdash 2 copy 2 copy moveto vpt 270 360 arc closepath fill=
=0A       2 copy moveto=0A       2 copy vpt 90 180 arc closepath fill=0A   =
            vpt 0 360 arc closepath } bind def=0A/C11 { BL [] 0 setdash 2 c=
opy moveto=0A       2 copy  vpt 0 180 arc closepath fill=0A       2 copy mo=
veto=0A       2 copy  vpt 270 360 arc closepath fill=0A               vpt 0=
 360 arc closepath } bind def=0A/C12 { BL [] 0 setdash 2 copy moveto=0A    =
   2 copy  vpt 180 360 arc closepath fill=0A               vpt 0 360 arc cl=
osepath } bind def=0A/C13 { BL [] 0 setdash  2 copy moveto=0A       2 copy =
 vpt 0 90 arc closepath fill=0A       2 copy moveto=0A       2 copy  vpt 18=
0 360 arc closepath fill=0A               vpt 0 360 arc closepath } bind de=
f=0A/C14 { BL [] 0 setdash 2 copy moveto=0A       2 copy  vpt 90 360 arc cl=
osepath fill=0A               vpt 0 360 arc } bind def=0A/C15 { BL [] 0 set=
dash 2 copy vpt 0 360 arc closepath fill=0A               vpt 0 360 arc clo=
sepath } bind def=0A/Rec   { newpath 4 2 roll moveto 1 index 0 rlineto 0 ex=
ch rlineto=0A       neg 0 rlineto closepath } bind def=0A/Square { dup Rec =
} bind def=0A/Bsquare { vpt sub exch vpt sub exch vpt2 Square } bind def=0A=
/S0 { BL [] 0 setdash 2 copy moveto 0 vpt rlineto BL Bsquare } bind def=0A/=
S1 { BL [] 0 setdash 2 copy vpt Square fill Bsquare } bind def=0A/S2 { BL [=
] 0 setdash 2 copy exch vpt sub exch vpt Square fill Bsquare } bind def=0A/=
S3 { BL [] 0 setdash 2 copy exch vpt sub exch vpt2 vpt Rec fill Bsquare } b=
ind def=0A/S4 { BL [] 0 setdash 2 copy exch vpt sub exch vpt sub vpt Square=
 fill Bsquare } bind def=0A/S5 { BL [] 0 setdash 2 copy 2 copy vpt Square f=
ill=0A       exch vpt sub exch vpt sub vpt Square fill Bsquare } bind def=
=0A/S6 { BL [] 0 setdash 2 copy exch vpt sub exch vpt sub vpt vpt2 Rec fill=
 Bsquare } bind def=0A/S7 { BL [] 0 setdash 2 copy exch vpt sub exch vpt su=
b vpt vpt2 Rec fill=0A       2 copy vpt Square fill=0A       Bsquare } bind=
 def=0A/S8 { BL [] 0 setdash 2 copy vpt sub vpt Square fill Bsquare } bind =
def=0A/S9 { BL [] 0 setdash 2 copy vpt sub vpt vpt2 Rec fill Bsquare } bind=
 def=0A/S10 { BL [] 0 setdash 2 copy vpt sub vpt Square fill 2 copy exch vp=
t sub exch vpt Square fill=0A       Bsquare } bind def=0A/S11 { BL [] 0 set=
dash 2 copy vpt sub vpt Square fill 2 copy exch vpt sub exch vpt2 vpt Rec f=
ill=0A       Bsquare } bind def=0A/S12 { BL [] 0 setdash 2 copy exch vpt su=
b exch vpt sub vpt2 vpt Rec fill Bsquare } bind def=0A/S13 { BL [] 0 setdas=
h 2 copy exch vpt sub exch vpt sub vpt2 vpt Rec fill=0A       2 copy vpt Sq=
uare fill Bsquare } bind def=0A/S14 { BL [] 0 setdash 2 copy exch vpt sub e=
xch vpt sub vpt2 vpt Rec fill=0A       2 copy exch vpt sub exch vpt Square =
fill Bsquare } bind def=0A/S15 { BL [] 0 setdash 2 copy Bsquare fill Bsquar=
e } bind def=0A/D0 { gsave translate 45 rotate 0 0 S0 stroke grestore } bin=
d def=0A/D1 { gsave translate 45 rotate 0 0 S1 stroke grestore } bind def=
=0A/D2 { gsave translate 45 rotate 0 0 S2 stroke grestore } bind def=0A/D3 =
{ gsave translate 45 rotate 0 0 S3 stroke grestore } bind def=0A/D4 { gsave=
 translate 45 rotate 0 0 S4 stroke grestore } bind def=0A/D5 { gsave transl=
ate 45 rotate 0 0 S5 stroke grestore } bind def=0A/D6 { gsave translate 45 =
rotate 0 0 S6 stroke grestore } bind def=0A/D7 { gsave translate 45 rotate =
0 0 S7 stroke grestore } bind def=0A/D8 { gsave translate 45 rotate 0 0 S8 =
stroke grestore } bind def=0A/D9 { gsave translate 45 rotate 0 0 S9 stroke =
grestore } bind def=0A/D10 { gsave translate 45 rotate 0 0 S10 stroke grest=
ore } bind def=0A/D11 { gsave translate 45 rotate 0 0 S11 stroke grestore }=
 bind def=0A/D12 { gsave translate 45 rotate 0 0 S12 stroke grestore } bind=
 def=0A/D13 { gsave translate 45 rotate 0 0 S13 stroke grestore } bind def=
=0A/D14 { gsave translate 45 rotate 0 0 S14 stroke grestore } bind def=0A/D=
15 { gsave translate 45 rotate 0 0 S15 stroke grestore } bind def=0A/DiaE {=
 stroke [] 0 setdash vpt add M=0A  hpt neg vpt neg V hpt vpt neg V=0A  hpt =
vpt V hpt neg vpt V closepath stroke } def=0A/BoxE { stroke [] 0 setdash ex=
ch hpt sub exch vpt add M=0A  0 vpt2 neg V hpt2 0 V 0 vpt2 V=0A  hpt2 neg 0=
 V closepath stroke } def=0A/TriUE { stroke [] 0 setdash vpt 1.12 mul add M=
=0A  hpt neg vpt -1.62 mul V=0A  hpt 2 mul 0 V=0A  hpt neg vpt 1.62 mul V c=
losepath stroke } def=0A/TriDE { stroke [] 0 setdash vpt 1.12 mul sub M=0A =
 hpt neg vpt 1.62 mul V=0A  hpt 2 mul 0 V=0A  hpt neg vpt -1.62 mul V close=
path stroke } def=0A/PentE { stroke [] 0 setdash gsave=0A  translate 0 hpt =
M 4 {72 rotate 0 hpt L} repeat=0A  closepath stroke grestore } def=0A/CircE=
 { stroke [] 0 setdash =0A  hpt 0 360 arc stroke } def=0A/Opaque { gsave cl=
osepath 1 setgray fill grestore 0 setgray closepath } def=0A/DiaW { stroke =
[] 0 setdash vpt add M=0A  hpt neg vpt neg V hpt vpt neg V=0A  hpt vpt V hp=
t neg vpt V Opaque stroke } def=0A/BoxW { stroke [] 0 setdash exch hpt sub =
exch vpt add M=0A  0 vpt2 neg V hpt2 0 V 0 vpt2 V=0A  hpt2 neg 0 V Opaque s=
troke } def=0A/TriUW { stroke [] 0 setdash vpt 1.12 mul add M=0A  hpt neg v=
pt -1.62 mul V=0A  hpt 2 mul 0 V=0A  hpt neg vpt 1.62 mul V Opaque stroke }=
 def=0A/TriDW { stroke [] 0 setdash vpt 1.12 mul sub M=0A  hpt neg vpt 1.62=
 mul V=0A  hpt 2 mul 0 V=0A  hpt neg vpt -1.62 mul V Opaque stroke } def=0A=
/PentW { stroke [] 0 setdash gsave=0A  translate 0 hpt M 4 {72 rotate 0 hpt=
 L} repeat=0A  Opaque stroke grestore } def=0A/CircW { stroke [] 0 setdash =
=0A  hpt 0 360 arc Opaque stroke } def=0A/BoxFill { gsave Rec 1 setgray fil=
l grestore } def=0Aend=0A%%EndProlog=0A%%Page: 1 1=0Agnudict begin=0Agsave=
=0A50 50 translate=0A0.100 0.100 scale=0A90 rotate=0A0 -5040 translate=0A0 =
setgray=0Anewpath=0A(Helvetica) findfont 140 scalefont setfont=0A1.000 UL=
=0ALTb=0A406 280 M=0A63 0 V=0A6493 0 R=0A-63 0 V=0A322 280 M=0A(30) Rshow=
=0A406 936 M=0A63 0 V=0A6493 0 R=0A-63 0 V=0A322 936 M=0A(35) Rshow=0A406 1=
592 M=0A63 0 V=0A6493 0 R=0A-63 0 V=0A-6577 0 R=0A(40) Rshow=0A406 2248 M=
=0A63 0 V=0A6493 0 R=0A-63 0 V=0A-6577 0 R=0A(45) Rshow=0A406 2904 M=0A63 0=
 V=0A6493 0 R=0A-63 0 V=0A-6577 0 R=0A(50) Rshow=0A406 3560 M=0A63 0 V=0A64=
93 0 R=0A-63 0 V=0A-6577 0 R=0A(55) Rshow=0A406 4216 M=0A63 0 V=0A6493 0 R=
=0A-63 0 V=0A-6577 0 R=0A(60) Rshow=0A406 4872 M=0A63 0 V=0A6493 0 R=0A-63 =
0 V=0A-6577 0 R=0A(65) Rshow=0A406 280 M=0A0 63 V=0A0 4529 R=0A0 -63 V=0A40=
6 140 M=0A(0) Cshow=0A1377 280 M=0A0 63 V=0A0 4529 R=0A0 -63 V=0A0 -4669 R=
=0A(200) Cshow=0A2349 280 M=0A0 63 V=0A0 4529 R=0A0 -63 V=0A0 -4669 R=0A(40=
0) Cshow=0A3320 280 M=0A0 63 V=0A0 4529 R=0A0 -63 V=0A0 -4669 R=0A(600) Csh=
ow=0A4291 280 M=0A0 63 V=0A0 4529 R=0A0 -63 V=0A0 -4669 R=0A(800) Cshow=0A5=
262 280 M=0A0 63 V=0A0 4529 R=0A0 -63 V=0A0 -4669 R=0A(1000) Cshow=0A6234 2=
80 M=0A0 63 V=0A0 4529 R=0A0 -63 V=0A0 -4669 R=0A(1200) Cshow=0A1.000 UL=0A=
LTb=0A406 280 M=0A6556 0 V=0A0 4592 V=0A-6556 0 V=0A406 280 L=0A1.000 UL=0A=
LT0=0A6311 4739 M=0A(Temperature as a function of time) Rshow=0A6395 4739 M=
=0A399 0 V=0A406 3035 M=0A5 0 V=0A5 0 V=0A5 0 V=0A4 0 V=0A5 0 V=0A5 0 V=0A5=
 131 V=0A5 0 V=0A5 0 V=0A5 0 V=0A4 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 =
0 V=0A5 0 V=0A4 -131 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 -131 V=0A5 0 V=0A5 0 V=
=0A4 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A4 0 V=0A5 0 V=0A=
5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A4 0 V=0A5 -131 V=0A5 0 V=0A5 0 V=0A=
5 0 V=0A5 0 V=0A5 131 V=0A4 0 V=0A5 -131 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=
=0A5 0 V=0A4 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A4 0 V=0A=
5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A4 0 V=0A5 0 V=0A5 0 V=0A5 0=
 V=0A5 0 V=0A5 0 V=0A5 -131 V=0A4 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0=
 V=0A5 0 V=0A4 131 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A4 0 V=0A5 0 =
V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A4 0 V=0A5 0 V=0A5 0 V=0A5 0 V=
=0A5 0 V=0A5 0 V=0A5 0 V=0A4 0 V=0A5 0 V=0A5 131 V=0A5 0 V=0A5 0 V=0A5 0 V=
=0A5 0 V=0A4 0 V=0A5 -131 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 262 V=0A4 0=
 V=0A5 0 V=0A5 -131 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A4 0 V=0A5 0 V=0A5 0=
 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A4 0 V=0A5 131 V=0A5 0 V=0A5 0 V=0A5 0 =
V=0A5 0 V=0A5 0 V=0A4 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=
=0A4 0 V=0A5 0 V=0A5 0 V=0A5 131 V=0A5 0 V=0A5 0 V=0A5 -131 V=0A4 0 V=0A5 0=
 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A4 0 V=0A5 0 V=0A5 0 V=0A5 131 =
V=0A5 0 V=0A5 0 V=0A5 0 V=0A4 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=
=0A5 0 V=0A4 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 132 V=0A5 0 V=0A4 0 V=
=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A4 0 V=0A5 -132 V=0A5 0 V=
=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A4 132 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 131 =
V=0A5 0 V=0A5 0 V=0A4 -263 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 =
V=0A4 0 V=0A5 0 V=0A5 -131 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 131 V=0A4 0 V=0A5 =
0 V=0A5 0 V=0A5 -131 V=0A5 0 V=0A5 0 V=0A5 0 V=0A4 0 V=0A5 0 V=0A5 0 V=0A5 =
0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A4 0 V=0A5 -131 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 =
0 V=0A5 0 V=0A4 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A4 0 V=
=0A5 0 V=0A5 0 V=0A5 0 V=0A5 131 V=0A5 0 V=0A5 0 V=0A4 0 V=0A5 -262 V=0A5 0=
 V=0A5 0 V=0A5 0 V=0A5 0 V=0A4 0 V=0A5 262 V=0A5 0 V=0A5 0 V=0A5 -131 V=0A5=
 0 V=0A5 0 V=0A4 -131 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A4=
 0 V=0A5 131 V=0A5 0 V=0A5 0 V=0A5 -131 V=0A5 0 V=0A5 0 V=0A4 0 V=0A5 0 V=
=0A5 0 V=0A5 131 V=0A5 0 V=0A5 0 V=0A5 -131 V=0A4 0 V=0A5 0 V=0A5 0 V=0A5 0=
 V=0A5 0 V=0A5 0 V=0A5 -131 V=0A4 0 V=0A5 0 V=0A5 131 V=0A5 0 V=0A5 0 V=0A5=
 0 V=0A5 0 V=0A4 0 V=0A5 0 V=0A5 -131 V=0A5 0 V=0A5 0 V=0A5 131 V=0A5 0 V=
=0A4 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A4 0 V=0A5 0 V=0A=
5 131 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A4 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5=
 -131 V=0A5 0 V=0A5 0 V=0A4 131 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=
=0A5 0 V=0A4 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A4 0 V=0A=
5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 262 V=0A4 0 V=0A5 0 V=0A5 0 V=0A5=
 -131 V=0A5 0 V=0A5 0 V=0A5 0 V=0A4 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5=
 0 V=0A5 0 V=0A4 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 131 V=0A4 =
0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 -131 V=0A5 0 V=0A5 0 V=0A4 0 V=0A5 131 V=0A=
5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A4 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0=
 V=0A5 0 V=0A5 0 V=0A4 132 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 -132 V=0A5 0 V=0A5=
 0 V=0A4 132 V=0A5 0 V=0A5 0 V=0A5 -132 V=0Acurrentpoint stroke M=0A5 0 V=
=0A5 0 V=0A5 0 V=0A4 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A=
4 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A4 0 V=0A5 0 V=0A5 0=
 V=0A5 -131 V=0A5 0 V=0A5 263 V=0A5 0 V=0A4 0 V=0A5 -263 V=0A5 0 V=0A5 0 V=
=0A5 0 V=0A5 0 V=0A4 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A=
4 0 V=0A5 0 V=0A5 0 V=0A5 -131 V=0A5 0 V=0A5 0 V=0A5 0 V=0A4 0 V=0A5 131 V=
=0A5 0 V=0A5 0 V=0A5 0 V=0A5 -131 V=0A5 0 V=0A4 0 V=0A5 0 V=0A5 0 V=0A5 0 V=
=0A5 131 V=0A5 0 V=0A5 0 V=0A4 -131 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0=
 V=0A5 0 V=0A4 131 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 -131 V=0A5 0 V=0A5 0 V=0A4=
 0 V=0A5 0 V=0A5 0 V=0A5 -131 V=0A5 0 V=0A5 0 V=0A5 0 V=0A4 0 V=0A5 0 V=0A5=
 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A4 0 V=0A5 0 V=0A5 0 V=0A5 131 V=0A5 =
0 V=0A5 0 V=0A5 1312 V=0A4 0 V=0A5 0 V=0A5 0 V=0A5 -1443 V=0A5 0 V=0A5 0 V=
=0A5 131 V=0A4 0 V=0A5 0 V=0A5 -131 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A4 0=
 V=0A5 -131 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 131 V=0A5 0 V=0A4 0 V=0A5 0 V=0A5=
 -131 V=0A5 0 V=0A5 0 V=0A5 131 V=0A5 0 V=0A4 0 V=0A5 0 V=0A5 0 V=0A5 0 V=
=0A5 0 V=0A5 0 V=0A5 0 V=0A4 0 V=0A5 0 V=0A5 0 V=0A5 262 V=0A5 0 V=0A5 0 V=
=0A5 -131 V=0A4 0 V=0A5 0 V=0A5 -131 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A4 =
0 V=0A5 0 V=0A5 0 V=0A5 131 V=0A5 0 V=0A5 0 V=0A5 0 V=0A4 0 V=0A5 0 V=0A5 1=
31 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A4 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 =
V=0A5 0 V=0A5 0 V=0A4 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=
=0A4 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A4 0 V=0A5 0 V=0A=
5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A4 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 1=
31 V=0A5 0 V=0A5 0 V=0A4 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A4 13=
2 V=0A5 0 V=0A5 0 V=0A5 -132 V=0A5 0 V=0A5 0 V=0A5 0 V=0A4 0 V=0A5 0 V=0A5 =
132 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A4 0 V=0A5 0 V=0A5 0 V=0A5 -263 V=0A=
5 0 V=0A5 0 V=0A5 0 V=0A4 0 V=0A5 0 V=0A5 131 V=0A5 0 V=0A5 0 V=0A5 -131 V=
=0A5 0 V=0A4 0 V=0A5 131 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A4 0 V=
=0A5 0 V=0A5 -131 V=0A5 0 V=0A5 0 V=0A5 131 V=0A5 0 V=0A4 0 V=0A5 -262 V=0A=
5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A4 131 V=0A5 0 V=0A5 0 V=0A5 -131 V=
=0A5 0 V=0A5 0 V=0A5 0 V=0A4 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A=
5 0 V=0A4 0 V=0A5 0 V=0A5 0 V=0A5 131 V=0A5 0 V=0A5 0 V=0A5 -131 V=0A4 0 V=
=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A4 0 V=0A5 0 V=0A5 0 V=0A=
5 0 V=0A5 0 V=0A5 0 V=0A5 -131 V=0A4 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A=
5 0 V=0A5 0 V=0A4 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 262 V=0A5 0 V=0A4=
 0 V=0A5 0 V=0A5 -131 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A4 0 V=0A5 131 V=
=0A5 0 V=0A5 0 V=0A5 0 V=0A5 -262 V=0A5 0 V=0A4 0 V=0A5 0 V=0A5 0 V=0A5 -13=
1 V=0A5 0 V=0A5 0 V=0A5 0 V=0A4 0 V=0A5 0 V=0A5 0 V=0A5 131 V=0A5 0 V=0A5 0=
 V=0A5 0 V=0A4 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A4 0 V=
=0A5 262 V=0A5 0 V=0A5 0 V=0A5 394 V=0A5 0 V=0A5 -525 V=0A4 0 V=0A5 0 V=0A5=
 131 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A4 0 V=0A5 0 V=0A5 0 V=0A5 -131 V=
=0A5 0 V=0A5 0 V=0A5 0 V=0A4 0 V=0A5 -131 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=
=0A5 0 V=0A4 0 V=0A5 262 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 131 V=0A4 0 V=0A5 0 =
V=0A5 -393 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A4 0 V=0A5 0 V=0A5 0 V=0A5 13=
1 V=0A5 0 V=0A5 0 V=0A5 0 V=0A4 131 V=0A5 0 V=0A5 0 V=0A5 -131 V=0A5 0 V=0A=
5 0 V=0A5 131 V=0A4 0 V=0A5 -2493 V=0A5 0 V=0A5 0 V=0A5 2231 V=0A5 0 V=0A5 =
0 V=0A4 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 131 V=0A5 0 V=0A4 0 V=0Acur=
rentpoint stroke M=0A5 0 V=0A5 0 V=0A5 0 V=0A5 -131 V=0A5 0 V=0A5 0 V=0A4 0=
 V=0A5 0 V=0A5 131 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A4 0 V=0A5 0 V=0A5 -1=
31 V=0A5 0 V=0A5 0 V=0A5 262 V=0A5 0 V=0A4 0 V=0A5 0 V=0A5 -131 V=0A5 0 V=
=0A5 0 V=0A5 0 V=0A5 0 V=0A4 0 V=0A5 0 V=0A5 131 V=0A5 0 V=0A5 0 V=0A5 0 V=
=0A5 0 V=0A4 0 V=0A5 -131 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A4 131=
 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 131 V=0A5 0 V=0A5 0 V=0A4 -131 V=0A5 0 V=0A5=
 0 V=0A5 0 V=0A5 131 V=0A5 0 V=0A5 0 V=0A4 0 V=0A5 -131 V=0A5 0 V=0A5 0 V=
=0A5 0 V=0A5 0 V=0A5 131 V=0A4 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=
=0A5 0 V=0A4 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 132 V=0A5 0 V=0A4 0 V=
=0A5 -132 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A4 0 V=0A5 132 V=0A5 0=
 V=0A5 0 V=0A5 0 V=0A5 -132 V=0A5 0 V=0A4 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 1=
32 V=0A5 0 V=0A5 0 V=0A4 -263 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 131 V=0A5 0 V=
=0A5 0 V=0A4 0 V=0A5 132 V=0A5 0 V=0A5 0 V=0A5 918 V=0A5 0 V=0A5 0 V=0A4 -1=
050 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 -131 V=0A5 0 V=0A5 0 V=0A4 0 V=0A5 0 V=0A=
5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A4 0 V=0A5 0 V=0A5 0 V=0A5 263 V=0A5=
 0 V=0A5 0 V=0A4 -263 V=0A5 0 V=0A5 -131 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=
=0A4 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A4 0 V=0A5 0 V=0A=
5 -131 V=0A5 0 V=0A5 0 V=0A5 262 V=0A5 0 V=0A4 0 V=0A5 0 V=0A5 0 V=0A5 0 V=
=0A5 0 V=0A5 0 V=0A5 0 V=0A4 0 V=0A5 263 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=
=0A5 -394 V=0A4 0 V=0A5 0 V=0A5 131 V=0A5 0 V=0A5 0 V=0A5 -131 V=0A5 0 V=0A=
4 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 -131 V=0A5 0 V=0A5 0 V=0A4 0 V=0A5 0 V=0A=
5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A4 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0=
 V=0A5 0 V=0A5 262 V=0A4 0 V=0A5 0 V=0A5 -262 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5=
 0 V=0A4 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A4 0 V=0A5 0 =
V=0A5 0 V=0A5 131 V=0A5 0 V=0A5 0 V=0A5 131 V=0A4 0 V=0A5 0 V=0A5 0 V=0A5 0=
 V=0A5 -131 V=0A5 0 V=0A5 0 V=0A4 0 V=0A5 0 V=0A5 0 V=0A5 262 V=0A5 0 V=0A5=
 -262 V=0A5 0 V=0A4 0 V=0A5 -262 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 131 =
V=0A4 0 V=0A5 0 V=0A5 0 V=0A5 -131 V=0A5 0 V=0A5 0 V=0A5 0 V=0A4 0 V=0A5 0 =
V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 131 V=0A4 0 V=0A5 0 V=0A5 0 V=0A5 0 V=
=0A5 0 V=0A5 0 V=0A5 0 V=0A4 0 V=0A5 0 V=0A5 262 V=0A5 0 V=0A5 0 V=0A5 0 V=
=0A5 -131 V=0A4 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A4 0 V=
=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A4 131 V=0A5 0 V=0A5 0 V=
=0A5 131 V=0A5 0 V=0A5 0 V=0A5 0 V=0A4 -131 V=0A5 0 V=0A5 0 V=0A5 263 V=0A5=
 0 V=0A5 0 V=0A5 -263 V=0A4 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5=
 0 V=0A4 0 V=0A5 0 V=0A5 0 V=0A5 131 V=0A5 0 V=0A5 0 V=0A4 -131 V=0A5 0 V=
=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A4 394 V=0A5 0 V=0A5 0 V=0A5 -394=
 V=0A5 0 V=0A5 0 V=0A5 -131 V=0A4 0 V=0A5 0 V=0A5 262 V=0A5 0 V=0A5 0 V=0A5=
 -262 V=0A5 0 V=0A4 0 V=0A5 0 V=0A5 394 V=0A5 0 V=0A5 0 V=0A5 -132 V=0A5 0 =
V=0A4 0 V=0A5 -131 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 263 V=0A4 0 V=0A5 =
0 V=0A5 -394 V=0A5 0 V=0A5 0 V=0A5 131 V=0A5 0 V=0A4 0 V=0A5 -131 V=0A5 0 V=
=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A4 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 -131 V=
=0A5 0 V=0A5 0 V=0A4 0 V=0A5 0 V=0A5 0 V=0A5 131 V=0A5 0 V=0A5 0 V=0A5 0 V=
=0A4 -131 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 131 V=0A5 0 V=0A5 0 V=0A4 262 V=0A5=
 0 V=0A5 0 V=0A5 0 V=0A5 -131 V=0A5 0 V=0A5 -262 V=0A4 0 V=0A5 0 V=0A5 0 V=
=0A5 0 V=0A5 0 V=0A5 0 V=0A5 262 V=0A4 0 V=0A5 0 V=0A5 -262 V=0A5 0 V=0A5 0=
 V=0A5 -131 V=0A5 0 V=0A4 0 V=0A5 131 V=0A5 0 V=0A5 0 V=0Acurrentpoint stro=
ke M=0A5 0 V=0A5 131 V=0A5 0 V=0A4 0 V=0A5 -131 V=0A5 0 V=0A5 0 V=0A5 0 V=
=0A5 0 V=0A5 0 V=0A4 131 V=0A5 0 V=0A5 0 V=0A5 787 V=0A5 0 V=0A5 0 V=0A5 -9=
18 V=0A4 0 V=0A5 0 V=0A5 0 V=0A5 262 V=0A5 0 V=0A5 0 V=0A5 0 V=0A4 -262 V=
=0A5 0 V=0A5 0 V=0A5 262 V=0A5 0 V=0A5 0 V=0A5 0 V=0A4 0 V=0A5 -262 V=0A5 0=
 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A4 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=
=0A5 0 V=0A5 262 V=0A4 0 V=0A5 0 V=0A5 -262 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0=
 V=0A4 0 V=0A5 131 V=0A5 0 V=0A5 0 V=0A5 -262 V=0A5 0 V=0A5 0 V=0A4 131 V=
=0A5 0 V=0A5 0 V=0A5 0 V=0A5 393 V=0A5 0 V=0A5 0 V=0A4 0 V=0A5 -393 V=0A5 0=
 V=0A5 0 V=0A5 0 V=0A5 0 V=0A4 0 V=0A5 0 V=0A5 131 V=0A5 0 V=0A5 0 V=0A5 0 =
V=0A5 0 V=0A4 0 V=0A5 -131 V=0A5 0 V=0A5 0 V=0A5 131 V=0A5 0 V=0A5 0 V=0A4 =
0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A4 0 V=0A5 0 V=0A5 0 V=
=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A4 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 131 V=
=0A5 0 V=0A5 0 V=0A4 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 263 V=0A5 0 V=0A5 -132=
 V=0A4 0 V=0A5 0 V=0A5 -131 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A4 0 V=0A5 0=
 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A4 0 V=0A5 0 V=0A5 0 V=0A5 0 V=
=0A5 0 V=0A5 0 V=0A5 0 V=0A4 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A=
5 0 V=0A4 0 V=0A5 -131 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A5 0 V=0A4 0 V=0A=
5 0 V=0A5 0 V=0A5 0 V=0A1.000 UL=0ALTa=0A406 2642 M=0A66 0 V=0A66 0 V=0A67 =
0 V=0A66 0 V=0A66 0 V=0A66 0 V=0A67 0 V=0A66 0 V=0A66 0 V=0A66 0 V=0A66 0 V=
=0A67 0 V=0A66 0 V=0A66 0 V=0A66 0 V=0A67 0 V=0A66 0 V=0A66 0 V=0A66 0 V=0A=
66 0 V=0A67 0 V=0A66 0 V=0A66 0 V=0A66 0 V=0A67 0 V=0A66 0 V=0A66 0 V=0A66 =
0 V=0A66 0 V=0A67 0 V=0A66 0 V=0A66 0 V=0A66 0 V=0A67 0 V=0A66 0 V=0A66 0 V=
=0A66 0 V=0A66 0 V=0A67 0 V=0A66 0 V=0A66 0 V=0A66 0 V=0A67 0 V=0A66 0 V=0A=
66 0 V=0A66 0 V=0A66 0 V=0A67 0 V=0A66 0 V=0A66 0 V=0A66 0 V=0A67 0 V=0A66 =
0 V=0A66 0 V=0A66 0 V=0A66 0 V=0A67 0 V=0A66 0 V=0A66 0 V=0A66 0 V=0A67 0 V=
=0A66 0 V=0A66 0 V=0A66 0 V=0A66 0 V=0A67 0 V=0A66 0 V=0A66 0 V=0A66 0 V=0A=
67 0 V=0A66 0 V=0A66 0 V=0A66 0 V=0A66 0 V=0A67 0 V=0A66 0 V=0A66 0 V=0A66 =
0 V=0A67 0 V=0A66 0 V=0A66 0 V=0A66 0 V=0A66 0 V=0A67 0 V=0A66 0 V=0A66 0 V=
=0A66 0 V=0A67 0 V=0A66 0 V=0A66 0 V=0A66 0 V=0A66 0 V=0A67 0 V=0A66 0 V=0A=
66 0 V=0A66 0 V=0A67 0 V=0A66 0 V=0A66 0 V=0A1.000 UL=0ALTa=0A6311 4599 M=
=0A(Trip points) Rshow=0A6395 4599 M=0A399 0 V=0A406 3298 M=0A66 0 V=0A66 0=
 V=0A67 0 V=0A66 0 V=0A66 0 V=0A66 0 V=0A67 0 V=0A66 0 V=0A66 0 V=0A66 0 V=
=0A66 0 V=0A67 0 V=0A66 0 V=0A66 0 V=0A66 0 V=0A67 0 V=0A66 0 V=0A66 0 V=0A=
66 0 V=0A66 0 V=0A67 0 V=0A66 0 V=0A66 0 V=0A66 0 V=0A67 0 V=0A66 0 V=0A66 =
0 V=0A66 0 V=0A66 0 V=0A67 0 V=0A66 0 V=0A66 0 V=0A66 0 V=0A67 0 V=0A66 0 V=
=0A66 0 V=0A66 0 V=0A66 0 V=0A67 0 V=0A66 0 V=0A66 0 V=0A66 0 V=0A67 0 V=0A=
66 0 V=0A66 0 V=0A66 0 V=0A66 0 V=0A67 0 V=0A66 0 V=0A66 0 V=0A66 0 V=0A67 =
0 V=0A66 0 V=0A66 0 V=0A66 0 V=0A66 0 V=0A67 0 V=0A66 0 V=0A66 0 V=0A66 0 V=
=0A67 0 V=0A66 0 V=0A66 0 V=0A66 0 V=0A66 0 V=0A67 0 V=0A66 0 V=0A66 0 V=0A=
66 0 V=0A67 0 V=0A66 0 V=0A66 0 V=0A66 0 V=0A66 0 V=0A67 0 V=0A66 0 V=0A66 =
0 V=0A66 0 V=0A67 0 V=0A66 0 V=0A66 0 V=0A66 0 V=0A66 0 V=0A67 0 V=0A66 0 V=
=0A66 0 V=0A66 0 V=0A67 0 V=0A66 0 V=0A66 0 V=0A66 0 V=0A66 0 V=0A67 0 V=0A=
66 0 V=0A66 0 V=0A66 0 V=0A67 0 V=0A66 0 V=0A66 0 V=0Astroke=0Agrestore=0Ae=
nd=0Ashowpage=0A%%Trailer=0A%%DocumentFonts: Helvetica=0A%%Pages: 1=0A
--M9NhX3UHpAaciwkO--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
