From: Sebastian Henschel <shensche-1rjuZeEg9oEb1SvskN2V4Q@public.gmane.org>
Subject: Re: RE: ACPI source releases updated (20030509)
Date: Tue, 13 May 2003 10:54:21 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030513085421.GB1338@enigma.daemon.sh>
References: <F760B14C9561B941B89469F59BA3A84725A299@orsmsx401.jf.intel.com> <b9pf9o$jjs$1@main.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uQr8t48UFsdbeI+V"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <b9pf9o$jjs$1@main.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nathan Gray <n8gray-7GExONQZ6ZKVc3sceRu5cw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--uQr8t48UFsdbeI+V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi there...

Received at 2003-05-13 / 09:14 by Nathan Gray:
> Grover, Andrew wrote:
> > Can you help me understand what problem putting the DSDT in initrd
> > fixes?
>=20
> It solves the problem of having to recompile your kernel in order to chan=
ge
> your DSDT.  Switching to a new DSDT becomes as simple as:
>=20
> cp initrd_backup.img initrd.img
> cat marker >> initrd.img  # Mark the start of the DSDT
> cat DSDT.aml >> initrd.img
> reboot
>=20
> It's very handy.

i totally agree with that.

and the patch seems quite small and non-intrusive to me, though i do not
know the innards of acpi/kernel (yet) so well.

on the other hand, this patch should not be necessary anyway. users
should not patch part of their "bios" by themselves to get their system
to work better. but this is how the situation currently looks like, as
long as the vendors provide buggy DSDTs. i would consider the patch to
be temporary, marked as soon-to-be-deleted. :)

cheers,
 sebastian
--=20
::: sebastian henschel
::: kodeaffe
::: lynx -source http://www.kodeaffe.de/shensche.pub | gpg --import

--uQr8t48UFsdbeI+V
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+wLK9reHfL3pi+bQRAmBmAJ0f5IHFSW2KU4q7reC/vJTGNQ76UQCglb/G
j9UcKI0IE/3pr8i1+Xf+V38=
=JA2d
-----END PGP SIGNATURE-----

--uQr8t48UFsdbeI+V--


-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
