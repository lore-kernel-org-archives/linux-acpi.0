From: Sebastian Henschel <shensche-1rjuZeEg9oEb1SvskN2V4Q@public.gmane.org>
Subject: Re: ACPI Suspend support
Date: Thu, 6 Mar 2003 12:31:53 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030306113153.GA11760@enigma.daemon.sh>
References: <20030306120556.17cd0ef1.g.zwartjes@student.tue.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030306120556.17cd0ef1.g.zwartjes-oe7qfRrRQfdlL9U78CI+FQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Gertjan <g.zwartjes-oe7qfRrRQfdlL9U78CI+FQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

heyho...

Received at 2003-03-06 / 12:19 by Gertjan:
>=20
> I was wondering if suspend support for ACPI is already implemented. Which
> kernel must I use if I want my laptop to support suspending. My laptop is
> an ASUS L3400D with a SiS chip set in it. It has no support for APM so I
> really would like to have support for suspend-to-RAM. Can somebody tell me
> what versions to use, or if it is still unsupported.

take one of the recent 2.5.x kernels if you really need it. but i cannot
say if it will work for your laptop. :)

with kernel 2.4.x you maybe can have standby (S1) with the acpi-patch
and suspend-to-disk (S4) with the swsusp-patch
(http://fchabaud.free.fr/English/default.php3?COUNT=3D3&FILE0=3DTricks&FILE=
1=3DLaptop&FILE2=3DSwsusp). but no suspend-to-ram (S3) as far as i know.

> Please correct me if I am asking this question in the wrong mailing-list.
> The reason I am posting it here is that I am inquiring the stage of
> development...

that is okay, acpi4linux is still under heavy development, so the border
between devel and user is very thin (though i would have posted it in
acpi-support).

cheers,
 sebastian
--=20
::: sebastian henschel
::: kodeaffe
::: lynx -source http://www.kodeaffe.de/shensche.pub | gpg --import

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE+ZzGpreHfL3pi+bQRAoBeAJsHJQl8JYlKS4V7yPiWdFEgWkJqsgCdG8TB
Ip/OEsAs4nmJ2nRcb0BaUMU=
=/tbx
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--


-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
