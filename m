From: Sebastian Henschel <shensche-1rjuZeEg9oEb1SvskN2V4Q@public.gmane.org>
Subject: Re: enabling ACPI on RH 8
Date: Mon, 7 Apr 2003 10:20:20 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030407082019.GA13268@enigma.daemon.sh>
References: <DFDDBBFBAF6C634BAE34B5F175A29F0227F405@hasmsx403.iil.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <DFDDBBFBAF6C634BAE34B5F175A29F0227F405-DFHDMA+VBDpRVdoAopKfxth3ngVCH38I@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Polevoy, IgorX" <igorx.polevoy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hello...

Received at 2003-04-06 / 18:28 by Polevoy, IgorX:

> I'm trying to enable ACPI on Linux RH 80 (kernel 2.4.18-14) and to run
> acpid.
> I succeeded to re-compile and re-boot the kernel with all the
> ACPI support options selected, however there is no=20
> /proc/acpi created (or other signs of ACPI driver is up).=20
>=20
> How do I enable it?=20

dunno what redhat uses, but:

check the boot parameters of your kernel, for instance in
/etc/lilo.conf:
- look for the line which conains the "append" keyword and replace "apm=3Do=
n"
with "apm=3Doff" and "acpi=3Doff" with "acpi=3Don".
- save lilo.conf and rerun lilo with "/sbin/lilo".

if you are running grub it is quite similar, look for the aforementioned
parameters and change them.
the important thing is to _not_ have "acpi=3Doff". acpi usually overrides
apm if both are "on" (either explicitly or implicitly).

if this does not help, please send the output of "dmesg" after a fresh
reboot to the list.

> Has it anything to do with the fact that the APM support is currently
> enabled ?

well, compiling both, acpi and apm, into your kernel is usually no
problem.

hth,
 sebastian
--=20
::: sebastian henschel
::: kodeaffe
::: lynx -source http://www.kodeaffe.de/shensche.pub | gpg --import

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+kTTDreHfL3pi+bQRAsVpAJ4zaegqw2O3W4+k3FtPXB9bvMaiFQCghvu4
NYUcTJYxiwg4/GtstnGruUc=
=bdUa
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--


-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
