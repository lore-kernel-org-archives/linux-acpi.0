From: Sebastian Henschel <shensche-1rjuZeEg9oEb1SvskN2V4Q@public.gmane.org>
Subject: Re: Re: toshiba_acpi.o failed
Date: Tue, 13 May 2003 11:03:47 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030513090347.GC1338@enigma.daemon.sh>
References: <1052804863.1925.4.camel@zipur.doublet> <3EC0AB25.3020300@ottaky.com> <1052812391.2390.35.camel@zipur.doublet> <3EC0B400.3040807@ottaky.com> <1052813439.2390.40.camel@zipur.doublet>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mvpLiMfbWzRoNl4x"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1052813439.2390.40.camel-vc4QrBckZ/BTmvShAG/hGA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Preston Lord <webmaster-xSlfl9GhdHA@public.gmane.org>
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--mvpLiMfbWzRoNl4x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi preston..

Received at 2003-05-13 / 10:54 by Preston Lord:
=20
> Loading ACPI modules (ac fan processor insmod:
> /lib/modules/2.4.20-4GB/kernel/drivers/acpi/toshiba_acpi.o: init_module:
> No such device

as you have told us, you are using a notebook from Acer. as the name
of the module suggests, it is meant for computers from Toshiba (not for
all of them, btw). so just ignore it or take it out of your list of
autoloaded modules. dunno your distro, perhaps:

/etc/modules (debian)
/etc/modules.autoload (gentoo)
/etc/sysconfig/powermanagement (suse? redhat?)

hth,
 sebastian
--=20
::: sebastian henschel
::: kodeaffe
::: lynx -source http://www.kodeaffe.de/shensche.pub | gpg --import

--mvpLiMfbWzRoNl4x
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+wLTzreHfL3pi+bQRAnHHAJ99Vg+NVQHMrRdZWVi2pFMCktwMBgCbBFWw
yMv7pObgWx/voBK7v0qwqbI=
=7P98
-----END PGP SIGNATURE-----

--mvpLiMfbWzRoNl4x--


-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
