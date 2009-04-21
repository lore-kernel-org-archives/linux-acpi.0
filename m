From: Mario Limonciello <mario_limonciello@dell.com>
Subject: Re: [PATCH 1/3] Add support for more dell-wmi hotkeys
Date: Tue, 21 Apr 2009 14:16:47 -0500
Message-ID: <49EE1B9F.2030504@dell.com>
References: <49ECBAE2.2080308@dell.com> <49EE09D9.2060209@dell.com> <20090421183100.GA8120@srcf.ucam.org> <49EE1945.2080808@dell.com> <20090421191242.GA8445@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigDA0B7533C0DA4EA34B3303D9"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:35575 "EHLO
	ausc60pc101.us.dell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754235AbZDUTQl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 21 Apr 2009 15:16:41 -0400
In-Reply-To: <20090421191242.GA8445@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDA0B7533C0DA4EA34B3303D9
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Matthew:

Matthew Garrett wrote:
> Hm. But if we get the scancode, presumably we can do this anyway?
>  =20
Yes, this information might not be as useful on Linux as it is for the
Windows situation.  On Windows, the WMI event doesn't translate directly
into a key, but rather a userspace application makes the changes.  As it
stands right now, the keys still don't do anything with my patch(s).=20
They're at least documented however in case someone would like to change
this behavior at some point.

Regards
--=20
Mario Limonciello
*Dell | Linux Engineering*
mario_limonciello@dell.com


--------------enigDA0B7533C0DA4EA34B3303D9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAknuG6AACgkQ2CrZjkA73YuvDwCfaZ7z1cqYaOKNGwNnEbAYB8hd
RkIAnj8/hK/K0cth7aebPS6FB+1846ME
=03jE
-----END PGP SIGNATURE-----

--------------enigDA0B7533C0DA4EA34B3303D9--
