From: Christian Hoenig <me-IGuAFssZLu2QuR96i0ejA4QuADTiUCJX@public.gmane.org>
Subject: broken DSDT on Samsung X05 Notebook
Date: Tue, 18 Nov 2003 10:51:35 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200311181051.38825.me@christianhoenig.de>
Reply-To: me-IGuAFssZLu2QuR96i0ejA4QuADTiUCJX@public.gmane.org
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Description: clearsigned data
Content-Disposition: inline
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

=2D----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi List,

I'm pretty new to this list and all the ACPI/DSDT and notebook stuff, so=20
please be kind if I miss something :-).

I recently bought a "Samsung X05 XTC 1400" which works fine with linux so f=
ar,=20
only the ACPI (DSDT) stuff gives me a headache.
It would be very nice if there's someone who has more knowlege of the DSDT=
=20
hacking than me and who is willing to help me to fix my DSDT :-).

All my logs and errors can be found in [3] or [4].
The original DSDT can be found in [5], the decompiled one in [6].
[7] is my try to fix that problems.


So, here is my problem description (partially):

When I run the gentoo-2.4.20-r8 kernel, the internal power display [1] and =
the
Brightness-control (via Fn-UP, Fn-DOWN) work. Unfortunately I don't know=20
exactly, which ACPI version is included in that (heavily patched) kernel.

When I run vanilla-2.4.22 or 2.6.-test9 patched with the latest ACPI those=
=20
stuff doesn't work. The Battery, AC and Thermal stuff don't work here, too=
=20
(see the boot.logs.* and the /proc/acpi 'dumps' in [3]).

The Cause seems to be a broken DSDT.
I did the steps to dump the DSDT, decompile it and tried to recompile it,=20
which leads to the errors in [2]. I then tried to fix the (only) ERROR whic=
h=20
lead stuff to the point, that now the thermal stuff works and the notebook=
=20
powers off at shutdown (which didn't work before, either). But the errors i=
n=20
boot.log about BAT and AC still remain. Unfortunately in this setup changin=
g=20
the displaybrightness works, but the Icon in the upper right always shows a=
=20
static symbol (not a little progressbar) and [1] only shows the exact same=
=20
(and wrong) icon, too, and not the % left in the Bat.


Since I never had contact to that stuff, I really don't know, what can be o=
f=20
help for you, so please ask, if you need further information or stuff!


So, again, it would be very nice, if someone could take his/her hand on tha=
t=20
and help me a little bit ;-)

and... thanks in advance!
take care, have fun
/christian
EDDK


=3D=3D=3D=3D=3D
[1] internal power display: The notebook shows a little Icon in the top left
	corner showing the powerstatus (Bat/AC) and the % left in the Bat
	when hitting Fn-F2
[2] ftp://ftp.christianhoenig.de/ACPI-DSDT/iasl.error.log
[3] ftp://ftp.christianhoenig.de/ACPI-DSDT/
[4] ftp://ftp.christianhoeing.de/ACPI-DSDT.tar.gz       <-- which only is a=
=20
tarball
	of all
[5] ftp://ftp.christianhoeing.de/ACPI-DSDT/dsdt.samsung-original.dat
[6] ftp://ftp.christianhoeing.de/ACPI-DSDT/dsdt.samsung-original.dsl
[7] ftp://ftp.christianhoeing.de/ACPI-DSDT/dsdt.own.dsl

=2D----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/ueuqmauZIX3ydQURAqhGAJ9SV33jlsHsslxWiuxJItzkcQyMpwCfSqBh
QwkZkAT24j1UDGXyZtTNRok=3D
=3DCoil
=2D----END PGP SIGNATURE-----



-------------------------------------------------------
This SF. Net email is sponsored by: GoToMyPC
GoToMyPC is the fast, easy and secure way to access your computer from
any Web browser or wireless device. Click here to Try it Free!
https://www.gotomypc.com/tr/OSDN/AW/Q4_2003/t/g22lp?Target=mm/g22lp.tmpl
