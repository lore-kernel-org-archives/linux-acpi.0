From: Florian Lohoff <flo-BCn6idZOOBwdnm+yROfE0A@public.gmane.org>
Subject: Re: S3 wakeup code
Date: Fri, 25 Jul 2003 15:23:34 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030725132334.GA586@paradigm.rfc822.org>
References: <20030723152809.GA591@paradigm.rfc822.org> <20030723162423.GD9013@atrey.karlin.mff.cuni.cz> <1059041888.19684.8.camel@bacchus.gpphy.uni-duesseldorf.de> <20030724104518.GA12041@paradigm.rfc822.org> <1059045536.19684.21.camel@bacchus.gpphy.uni-duesseldorf.de> <20030724144535.GA629@paradigm.rfc822.org> <m3r84eaj3z.fsf@localhost.localdomain> <20030725125052.GC910@paradigm.rfc822.org> <1059138637.20426.7.camel@bacchus.gpphy.uni-duesseldorf.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1059138637.20426.7.camel-s1IKGncK6J2OERECOqmV57dB6IYNvbhm87tLKu7D3g4@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Knut Neumann <knut.neumann-4bfl1RV3iZDOEhgYWvzSCYQuADTiUCJX@public.gmane.org>
Cc: Ole Myren Rohne <ole.rohne-vJEk5272eHo@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2003 at 03:10:38PM +0200, Knut Neumann wrote:
> Am Fre, 2003-07-25 um 14.50 schrieb Florian Lohoff:
> > Hmmm - I didnt have a look at that - I was assuming that alloc_bootmem
> > returned a physical address. In 2.5 it seems we dont write out the
> > allocated address on boot as we did in 2.4 (hint, hint)
>=20
> Without a look and everything I remember that S3 once at least worked
> with disk and stuff resuming - no video though. I actually though it
> stopped working in course of 2.5 - but might have been the change from
> 2.4 to 2.5. You wouldnt mind testing with 2.4, would you?

S4/swsusp works like a charm for me on 2.4 - S3 is not available=20
for 2.4 i thought ?

Flo
--=20
Florian Lohoff                  flo-BCn6idZOOBwdnm+yROfE0A@public.gmane.org             +49-171-2280134
                        Heisenberg may have been here.

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/IS9WUaz2rXW+gJcRAoiBAKDEZ9G9M9BqdIwEHp21blrEF1PACgCcDUrc
FmC3jo2AEeQbMRbek8Le9sY=
=mOj1
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
