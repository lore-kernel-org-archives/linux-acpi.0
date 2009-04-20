From: Mario Limonciello <mario_limonciello@dell.com>
Subject: Re: Add support for Eject hotkey in dell-wmi
Date: Mon, 20 Apr 2009 13:45:56 -0500
Message-ID: <49ECC2E4.6070105@dell.com>
References: <49ECBAE2.2080308@dell.com> <20090420182312.GA2910@srcf.ucam.org> <49ECBE35.9040003@dell.com> <20090420182848.GA3105@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig534C8EFDB8E1454D946A0E4B"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:15169 "EHLO
	ausc60ps301.us.dell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751785AbZDTSpt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 20 Apr 2009 14:45:49 -0400
In-Reply-To: <20090420182848.GA3105@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig534C8EFDB8E1454D946A0E4B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Matthew

Matthew Garrett wrote:
> On Mon, Apr 20, 2009 at 01:25:57PM -0500, Mario Limonciello wrote:
>  =20
>
> Ok. How can we determine whether we're on a machine with this support? =

> Applying this patch right now will result in systems receiving the even=
t=20
> twice.
>  =20
I've checked with the BIOS teams further, and they indicated at the time
that this is enabled on those consumer systems, the hotkey should be
switched over to a mechanical key rather than a software key, so the
keyboard interface would not see this key.  The support in the BIOS to
turn on and off WMI would actually enable SMI hot key events instead
(which could then be serviced by dell-laptop).

--=20
Mario Limonciello
*Dell | Linux Engineering*
mario_limonciello@dell.com


--------------enig534C8EFDB8E1454D946A0E4B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAknswuQACgkQ2CrZjkA73YuG5ACfcs0gyOdSgN/7hxGpJmzat4I/
qtcAoINxvS8LYlFiyXqGPhvVZ91Y4Qo7
=Uzgv
-----END PGP SIGNATURE-----

--------------enig534C8EFDB8E1454D946A0E4B--
