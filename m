From: Ben Gamari <ben@smart-cactus.org>
Subject: Re: OpRegion conflicts for Skylake LPSS
Date: Tue, 26 Apr 2016 23:10:47 +0200
Message-ID: <87eg9snkiw.fsf@smart-cactus.org>
References: <87lh41nqqq.fsf@smart-cactus.org> <20160426155437.GA10202@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.smart-cactus.org ([54.187.36.80]:55398 "EHLO
	mail.smart-cactus.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753089AbcDZVLB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 26 Apr 2016 17:11:01 -0400
In-Reply-To: <20160426155437.GA10202@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Mika Westerberg <mika.westerberg@linux.intel.com> writes:

> On Tue, Apr 26, 2016 at 02:44:13AM +0200, Ben Gamari wrote:
>>=20
snip

>> It looks very much like these are describing the same device. Perhaps
>> the lpss driver should be binding to this ACPI node? Or perhaps this is
>> a firmware issue? Any guidance would be greatly appreciated.
>
> Can you send me full acpidump of that machine?

It can be found at
https://github.com/bgamari/dell-e7470-dsdt/blob/master/acpi.log.

Cheers,

=2D Ben

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXH9lXAAoJEHPt6ejPuu8BAr4H/jzIjA5A8zwqQRVhsRSBOoHI
WvfhJ50E7gXLOZUN9npHde+0eiM1cSfwiIMxbClFMlxcJSDuqEZ7ZyyMxBiA2Vq5
Lu5goA7kJM5gd62COM+udrBuNXICRxx41avJiFdz1zC7GJdZPJMm0hPUG2Qxc6lm
XqR1dC8PntyyEALONrL27KZ2FMNMI/3R3UbUZqG0c7NnUVFlcQdtbJEwGsFEKqU9
yRhac4EssfJNdIrrMrPxzN7Qtj7tN0yD/rYOudAz4GsN5zLcJDoXwJU+BWyyxVDf
Nyc2hDswrmhdny3/21oyH1uSA0TFPnrNtp9HMHGLdhXuj1gUgScV6LWOiH8+UlQ=
=wAlw
-----END PGP SIGNATURE-----
--=-=-=--
