From: Luis Miguel Pires Neves <lneves-3+EeCmRbAIo+BYJ/izffpQ@public.gmane.org>
Subject: Problems with battery info
Date: Mon, 26 Aug 2002 23:31:39 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <E17jSOa-0000F3-00@incognito>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi everybody,

It is not the first time I post this subject but until now I got no answe=
r,=20
perhaps because I included it in the middle of others.

I'm still using the 20020403 acpi patch on top of 2.4.18 because with rec=
ent=20
versions I don't get a correct battery info (it says that the battery is =
NiMH=20
of 4500 mWh instead of the 3200 mWh my LiIon battery really has, causing =
a=20
wrong battery level information trough WMACPI).=20

This behaviour used to happen with the acpi code before february, but the=
n I=20
used to change a constant value in ectransx.c (a timeout if I remember) f=
rom=20
100 to 500 (us ???) to solve it. With the acpi code between February and=20
April this wasn't necessary anymore.

I must admit I've not tried all versions from April till now, but I tried=
=20
several, 20020716 as the last one, and the problem reappeared, and I don'=
t=20
know what I can do to overcome it.

In dmesg I found the following messages:

[ACPI Debug] String: =3D=3D=3D=3D=3D=3D=3D=3D=3D BAT1 UPBI =3D=3D=3D=3D=3D=
=3D=3D=3D=3D
dsmthdat-0433 [22] Ds_method_data_get_val: Uninitialized Local[3] at node=
=20
c7b6b54c
dsmthdat-0433 [22] Ds_method_data_get_val: Uninitialized Local[3] at node=
=20
c7b6b54c

My laptop is a COMPAQ Presario 12XL515 (1200 series) and as it is known, =
I=20
have to override the DSDT in order to have battery status and info. I pat=
ched=20
the DSDT following some instructions from Paul Diefenbaugh, but probably =
I=20
let some bugs untouched. I don't know if any of these can cause problems.

My original dsdt disassembled with AD.EXE from PHOENIX, my patched dsdt=20
(dsdt_n.asl) and dmesg after booting kernel 2.4.18 + acpi-20020726 +=20
swsusp-beta11 are on :

http://www.estg.iplei.pt/~lneves/files-cpq12xl515.tgz

Another persistent problem is the absence of events. My machine probably =
has=20
the firmware bugs Juliuzs pointed out. I tried the kacpid patch some time=
 ago=20
but it conflicted with swsusp. With a more recent version which was suppo=
sed=20
to cooperate with swsusp I get a defunct kacpid task. This is not so=20
important to me as the battery info, but of course it limits the usefulne=
ss=20
of ACPI.

I would appreciate any help to overcome these problems. A second analysis=
 on=20
my DSDT would be helpful.

Best regards and keep up the good work.

Lu=EDs Neves





-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
