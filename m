From: Mario Limonciello <mario_limonciello@dell.com>
Subject: Re: [PATCH] Explicitly disable BT radio using rfkill interface on
 suspend
Date: Tue, 19 May 2009 11:52:47 -0500
Message-ID: <4A12E3DF.3070402@dell.com>
References: <4A11C126.1000704@dell.com> <1242710064.3147.4.camel@localhost.localdomain> <20090519090610.GA29967@srcf.ucam.org> <200905191447.34000.oliver@neukum.org> <20090519125853.GA12483@srcf.ucam.org> <4A12DEA8.4060305@dell.com> <20090519163333.GA17189@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig18BBED433BED8C599762CC20"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:35725 "EHLO
	ausc60pc101.us.dell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751462AbZESQwo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 19 May 2009 12:52:44 -0400
In-Reply-To: <20090519163333.GA17189@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Oliver Neukum <oliver@neukum.org>, Marcel Holtmann <marcel@holtmann.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig18BBED433BED8C599762CC20
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Matthew:

Matthew Garrett wrote:
> On Tue, May 19, 2009 at 11:30:32AM -0500, Mario Limonciello wrote:
>  =20
>
> I thought all USB devices got reenumerated on resume?
>  =20
Leaving udevadm monitor running on a terminal during S3, I don't see any
events that would agree with this.
--=20
Mario Limonciello
*Dell | Linux Engineering*
mario_limonciello@dell.com


--------------enig18BBED433BED8C599762CC20
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkoS498ACgkQ2CrZjkA73YstwQCfRs8dXw61gK+uYTD7PaF/lfDL
fsQAnRJVLm5mFtOSUUAmN6FHvoWlzGSU
=kbYZ
-----END PGP SIGNATURE-----

--------------enig18BBED433BED8C599762CC20--
