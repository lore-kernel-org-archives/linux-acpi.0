From: Hanno =?utf-8?q?B=C3=B6ck?= <mail-60OJuG18Xr6zQB+pC5nmwQ@public.gmane.org>
Subject: Re: oops with asus_acpi on P30/P35
Date: Wed, 21 Sep 2005 13:47:10 +0200
Message-ID: <200509211347.13322.mail@hboeck.de>
References: <20050618004506.GE3690@orest.greek0.net> <1124634977.4952.9.camel@nouse.net> <20050921090810.GS22403@orest.greek0.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart6649179.9Hbjjk9vrZ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050921090810.GS22403-eJYrgmUciHpxYM3rXe3Iuw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Christian Aichinger <Greek0-hi6Y0CQ0nG0@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>, Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>, "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Timo Hoenig <thoenig-dCxI//HcOdFeoWH0uzbU5w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

--nextPart6649179.9Hbjjk9vrZ
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Wednesday, 21. September 2005 11:08 schrieb Christian Aichinger:
> Since the relevant part hasn't changed between P30 -> P35's DSDT, I
> assume that there has been some change in the Linux ACPI code, that
> causes integer returns now instead of no returns. This means we
> could get rid of the P30 code in the (!buffer.pointer) path. I don't
> have a P30 around to test this though :-/

I have a P30 around to test and I'd gladly help, but your patch doesn't app=
ly=20
to the current 2.6.14-rc1 and -git5 kernel.
Also note that afaik asus_acpi-cvs and kernel aren't in sync at the moment.

=2D-=20
Hanno B=C3=B6ck		Blog:   http://www.hboeck.de/
GPG: 3DBD3B20		Jabber: jabber-60OJuG18Xr6zQB+pC5nmwQ@public.gmane.org

--nextPart6649179.9Hbjjk9vrZ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDMUhBr2QksT29OyARAgvNAKCMjuayqoI3nvzyIKJk2NrTzE6fuwCfZGfI
85icd5Suost+ctsYyaEAxLU=
=NA7/
-----END PGP SIGNATURE-----

--nextPart6649179.9Hbjjk9vrZ--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
