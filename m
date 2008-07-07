From: Filippo Zangheri <filippo.zangheri@yahoo.it>
Subject: Re: Battery life difference
Date: Mon, 07 Jul 2008 11:48:42 +0200
Message-ID: <4871E67A.1040600@yahoo.it>
References: <31e679430807050617u3fc706fasee9bb43a151c501f@mail.gmail.com> <20080705082352.4b6be669@infradead.org> <31e679430807050844r30ff74fby7e15641573b42d82@mail.gmail.com> <20080706172159.GA12736@x61>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA532BFD3741BA59E2091A315"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from n26.bullet.mail.mud.yahoo.com ([68.142.206.221]:30492 "HELO
	n26.bullet.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751908AbYGGJyQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Jul 2008 05:54:16 -0400
In-Reply-To: <20080706172159.GA12736@x61>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Felipe Balbi <felipebalbi@users.sourceforge.net>, Kernel development list <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA532BFD3741BA59E2091A315
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 06/07/2008 19:21, Tino Keitel wrote:
> On Sat, Jul 05, 2008 at 18:44:21 +0300, Felipe Balbi wrote:
>> Hi,
>>
>> On Sat, Jul 5, 2008 at 6:23 PM, Arjan van de Ven <arjan@infradead.org>=
 wrote:
>=20
> [...]
>=20
>>> Also take a look at
>>> http://kerneltrap.org/mailarchive/linux-kernel/2008/5/8/1771024 becau=
se
>>> these patches save like 0.75W in our lab.
>> cool, is it merged upstream ?
>=20
> If I got this right, at least Linux 2.6.25 allows to control this via
> "/sys/class/scsi_host/host*/link_power_management_policy". Setting it
> to "min_power" does the trick. This is also covered by powertop 1.10
> and later.

I cannot see this on 2.6.25.9. Is there a particular configuration option=

you must enable, or it just didn't make it to 2.6.25?

Thanks.
Regards.

--=20
Filippo Zangheri

GPG key ID: 0x6C1F2F2F


--------------enigA532BFD3741BA59E2091A315
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIceaAjzxMG2wfLy8RAqsUAJ9pEDT8CVG28VSO9H8YfcUJvPbqrgCeOUiG
YvEuPTwS5Di8hpdMylXRERQ=
=PrjA
-----END PGP SIGNATURE-----

--------------enigA532BFD3741BA59E2091A315--

