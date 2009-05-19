From: Mario Limonciello <mario_limonciello@dell.com>
Subject: Re: [PATCH] Explicitly disable BT radio using rfkill interface on
 suspend
Date: Tue, 19 May 2009 11:30:32 -0500
Message-ID: <4A12DEA8.4060305@dell.com>
References: <4A11C126.1000704@dell.com> <1242710064.3147.4.camel@localhost.localdomain> <20090519090610.GA29967@srcf.ucam.org> <200905191447.34000.oliver@neukum.org> <20090519125853.GA12483@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig4B0AC60646A4CF9AA26AE72B"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ausxippc101.us.dell.com ([143.166.85.207]:33513 "EHLO
	ausxippc101.us.dell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753240AbZESQa3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 19 May 2009 12:30:29 -0400
In-Reply-To: <20090519125853.GA12483@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Oliver Neukum <oliver@neukum.org>, Marcel Holtmann <marcel@holtmann.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4B0AC60646A4CF9AA26AE72B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Guys:

Matthew Garrett wrote:
> On Tue, May 19, 2009 at 02:47:33PM +0200, Oliver Neukum wrote:
>  =20
>
> It doesn't seem to for Mario, otherwise this patch wouldn't change=20
> anything.
>
>  =20
During S3, when power gets cut, the device is reset and the radio
logical device no longer shows up.  At no point do either of the USB
keyboard/mouse devices stop showing up on the bus.  Henceforth, there is
no event for udev to trigger from when a mouse or keyboard gets
added/removed.

--=20
Mario Limonciello
*Dell | Linux Engineering*
mario_limonciello@dell.com


--------------enig4B0AC60646A4CF9AA26AE72B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkoS3qgACgkQ2CrZjkA73YsMnwCgixuWcPu6p8fuhHu7L1ftxEWt
SB4An3TY/hsjnrZM6UzfKyXvk8IzKsEJ
=oOrP
-----END PGP SIGNATURE-----

--------------enig4B0AC60646A4CF9AA26AE72B--
