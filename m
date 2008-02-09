From: Jochen Kemnade <kemnade@gmail.com>
Subject: Re: dmidecode for Compal HEL80 Notebook
Date: Sat, 09 Feb 2008 12:12:01 +0100
Message-ID: <47AD8A81.3020302@gmail.com>
References: <470746EB.2000707@gmail.com> <200801182320.15049.lenb@kernel.org> <47921522.9070008@gmail.com> <200801201856.15742.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-ripemd160;
 protocol="application/pgp-signature";
 boundary="------------enig132699E18140ED2B0A1A35C1"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:59247 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751897AbYBILMR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 9 Feb 2008 06:12:17 -0500
Received: by fg-out-1718.google.com with SMTP id e21so3158938fga.17
        for <linux-acpi@vger.kernel.org>; Sat, 09 Feb 2008 03:12:13 -0800 (PST)
In-Reply-To: <200801201856.15742.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig132699E18140ED2B0A1A35C1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello Len,

Len Brown schrieb:
> On Saturday 19 January 2008 10:20, Jochen Kemnade wrote:
>> Hello,
>>
>> Len Brown schrieb:
>>> Do you notice any functional difference when booting with
>>>
>>> "acpi_osi=3DLinux"        (default for 2.6.22 and earlier)
>>> vs.
>>> "acpi_osi=3D!Linux"       (default for 2.6.23 and later)
>> No, i didn't. I was running 2.6.22 for some time and at the moment, I'=
m
>> running 2.6.24-rc8, but I couldn't make out any functional change. Do
>> you have anything specific in mind that I could test and report about?=

>>
>>> Also, please send me the output from acpidump.
>=20
> Thanks for the acpidump.
> Please verify that the battery and AC/CD switch evenst are working
> properly in both cases above.

as far as I can tell, the events work just fine with both settings.

Regards,
Jochen
--=20
Jochen Kemnade
kemnade@gmail.com
PGP: 0xb5cb0a3f


--------------enig132699E18140ED2B0A1A35C1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHrYqE8gsDeLXLCj8RA+gHAJ0T4x2ecviWHwF+Oh6hKblmynedNwCeNFYf
1k9+f8zCdEPWyDw+15Dz6N4=
=N+Co
-----END PGP SIGNATURE-----

--------------enig132699E18140ED2B0A1A35C1--
