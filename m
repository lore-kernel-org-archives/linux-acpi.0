From: Ben Gamari <ben@smart-cactus.org>
Subject: Re: OpRegion conflicts for Skylake LPSS
Date: Fri, 29 Apr 2016 09:30:27 +0200
Message-ID: <87r3dona7g.fsf@smart-cactus.org>
References: <87lh41nqqq.fsf@smart-cactus.org> <20160426155437.GA10202@lahna.fi.intel.com> <87eg9snkiw.fsf@smart-cactus.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.smart-cactus.org ([54.187.36.80]:55508 "EHLO
	mail.smart-cactus.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752223AbcD2Hag (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 29 Apr 2016 03:30:36 -0400
In-Reply-To: <87eg9snkiw.fsf@smart-cactus.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Ben Gamari <ben@smart-cactus.org> writes:

> [ Unknown signature status ]
> Mika Westerberg <mika.westerberg@linux.intel.com> writes:
>
>> On Tue, Apr 26, 2016 at 02:44:13AM +0200, Ben Gamari wrote:
>>>=20
> snip
>
>>> It looks very much like these are describing the same device. Perhaps
>>> the lpss driver should be binding to this ACPI node? Or perhaps this is
>>> a firmware issue? Any guidance would be greatly appreciated.
>>
>> Can you send me full acpidump of that machine?
>
> It can be found at
> https://github.com/bgamari/dell-e7470-dsdt/blob/master/acpi.log.
>
Did this provide any insight? Let me know if more information would be
helpful.

Also, is there a way to simply allow the driver subsystem to allow
probing to proceed despite this resource conflict so that I can resume
debugging my original input device issue?

Cheers,

=2D Ben

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXIw2TAAoJEHPt6ejPuu8BN6wH/iPFKgPtuLyUcFORJhdpdKwK
7O/XGptBfg38F1NggG+4tqLizL8wUnXnRHAJCUs7P0u9IYvOCzqVTcKXnPpH66K1
RvLiUqtXqu15ZWJZ3m3AQ/yKhsjITanafHLkZ2qbRBHMTEA9uhAK/tjCwsqX/4Hh
CF+o7nPjGShQJ+/GJxrABUIzM6ahhXnQly99DVRApYAyjshUIwU6jy98zcxhdZBC
zhc8KLflmrXWaWmV1cvAdJ5bYSjlc3CEh1ByL861xmwaMHtXleRDROXDy89C7rkN
KWco8D85fdH5lEpj+dXRE5X6HhCTi7oJofqx3MFER++sM0pSbI0uWwMD7PFTV00=
=erJO
-----END PGP SIGNATURE-----
--=-=-=--
