From: Andre Eisenbach <andre-+hZUvIEKc2q1Z/+hSey0Gg@public.gmane.org>
Subject: ACPI issues - suspend-to-ram and processor speed
Date: Tue, 18 May 2004 02:13:25 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200405180213.34603.andre@eisenbach.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
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

=2D----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Dear ACPI devel team,

I have two issues which prevent me from fully enjoying my notbook running o=
n=20
Linux. Both are seemingly related to ACPI. Please help me understand the=20
problems better and maybe fix them or help me attempting a fix.

The notebook in question is a Compaq Presario 2100Z with an AMD Athlon XP=20
2400+ processor. Current kernel version is 2.6.6-mm2. I am not applying any=
=20
ACPI patches from sf.net, but rely on whats in the kernel (which may be my=
=20
first mistake).

I am very willing to learn and may be able to fix it myself, if you guys ca=
n=20
help me find out more about which components are involved.

Problem 1 - Cannot suspend (or resume better)

Right now I am unable to suspend my notebook in any for or fashion (ram, di=
sk,=20
etc.). Therefore I have to turn off the notebook and boot again, which=20
honestly makes the notebook pretty useless.

When I try to suspend to RAM, the suspend part seems to run fine (I can see=
=20
suspend-to-ram messages), the lcd shuts off and the power button starts=20
pulsing slowly (indicating standby). So far so good. However, if I hit the=
=20
power button then to resume, the device seems to want to wake up (hd spins=
=20
up, fans start) but the LCD never turns on and the notebook quickly (1-2=20
seconds) later switched to off (all quiet/lights off). Hitting the power=20
button again starts a normal startup.

I also tried to suspend to disk using swsusp. That corrupted my swap partit=
ion=20
and didn't resume.

What does it take to suspend to RAM?
What could be broken, and where should I start looking if I want to fix it?
What more debug information do you guys need?

Problem 2 - CPU slows down when on battery

When the power cord is unplugged, my CPU slows down quite a bit. This is no=
t=20
indicated in /proc/cpuinfo and NOT due to cpufreq / powernow adjustments.

The problem does not seem to occur with ACPI=3DOFF=20

More details here in a post to the linux-kernel mailing list:
http://lkml.org/lkml/2004/5/9/100

Also a relevant and informative entry here:
http://forums1.itrc.hp.com/service/forums/questionanswer.do?threadId=3D4676=
55

When on battery, KDE is barely usable. Once again it doesnt make much sense=
=20
for a laptop not to be usable on battery ... :(


Thanks for your attention and hopefully for your answers/comments. I can=20
provide as much debug/info/configs as you would like and as a programmer am=
=20
willing to help out/read up, if you just help me identify where to start.

Thanks,
   Andr=E9 Eisenbach
=2D----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAqdO45DBE808V5icRAnEcAJ49pvxNlggXYpLBARhqh/pNSmSKewCgr6Eg
mW5uBTiyk0Ab2IdtDXV3038=3D
=3DlqX+
=2D----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
