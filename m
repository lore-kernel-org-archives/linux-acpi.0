From: Mario Limonciello <mario_limonciello@dell.com>
Subject: Re: [PATCH 1/3] Add support for more dell-wmi hotkeys
Date: Tue, 21 Apr 2009 14:22:15 -0500
Message-ID: <49EE1CE7.5020503@dell.com>
References: <49ECBAE2.2080308@dell.com> <49EE09D9.2060209@dell.com> <20090421183100.GA8120@srcf.ucam.org> <49EE1945.2080808@dell.com> <20090421191242.GA8445@srcf.ucam.org> <49EE1B9F.2030504@dell.com> <20090421191817.GA9419@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigAEC2AC6B32E84F8AE5D35A35"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:25753 "EHLO
	ausc60pc101.us.dell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751749AbZDUTWI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 21 Apr 2009 15:22:08 -0400
In-Reply-To: <20090421191817.GA9419@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAEC2AC6B32E84F8AE5D35A35
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Matthew:

Matthew Garrett wrote:
> On Tue, Apr 21, 2009 at 02:16:47PM -0500, Mario Limonciello wrote:
>  =20
>
> Ok. As long as there's a way of determining when a platform no longer=20
> sends scancodes (and so we can switch to WMI delivery), then that seems=
=20
> fine.
>  =20
Looking at the specs for this next year, there is no plan to drop
sending the scancodes for the volume keys.  These were written with Win7
in mind, so at a minimum, this behavior wouldn't be changed until Win7+1.=


A lot of the other keys I've hooked up through this however, platforms
will see these changes within the year.  I've tried to document which
keys will still send scan code events per that spec.

Regards
--=20
Mario Limonciello
*Dell | Linux Engineering*
mario_limonciello@dell.com


--------------enigAEC2AC6B32E84F8AE5D35A35
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAknuHOcACgkQ2CrZjkA73Yu5xACffixsN7LZgKpu8X3hTrK2TdIu
IKkAnAtgcyJ356Fk1WNtZm7Tdd2BuaNs
=ZCUP
-----END PGP SIGNATURE-----

--------------enigAEC2AC6B32E84F8AE5D35A35--
