From: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>
Subject: Re: Entering C3 Processor State without a Bus Arbiter
Date: Fri, 16 Jan 2004 00:25:15 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040115232515.GA5386@dominikbrodowski.de>
References: <Law11-OE36TK4GXSNMh0000bd93@hotmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Law11-OE36TK4GXSNMh0000bd93-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Dino Klein <dinoklein-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2004 at 05:29:23PM -0500, Dino Klein wrote:
> Hello,
>=20
> I'm curios as to why the implementation does not enter C3 without the pre=
sence of a Bus Arbiter; also, how come a comment in the
> source claims that C3/WBINVD is too expensive?

[ /me shuffles in some old directories and finds a file called wbinvd_analy=
sis ]

I'd investigated this a couple of months ago. It turned out to hang my
(previous) notebook every once in a while; I think that was the reason I
aborted the patch...

The average cost of a wbinvd instruction was 98us, the minimum cost 22us.
However, the  maximum cost was a horrible 780us. The average sleeping time
of C3 was 519us, minimum 0us...

This is discussed in detail in these threads:
http://marc.theaimsgroup.com/?l=3Dacpi4linux&m=3D101630988127506&w=3D2
http://marc.theaimsgroup.com/?l=3Dacpi4linux&m=3D101662029010850&w=3D2

other threads (including my patches) can be found by searching for "wbinvd"
in this archive.

	Dominik

--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAByFbZ8MDCHJbN8YRAhFxAKCGDJaZV+/dZUrLufOKLRGOWWfAYACeKaBW
b+pr/oKODIfXtmjtTZ6HFks=
=jyDK
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
