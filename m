From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH v2] platform/x86: wmi-bmof: New driver to expose embedded Binary WMI MOF metadata
Date: Mon, 19 Jun 2017 18:07:42 +0200
Message-ID: <201706191807.42574@pali>
References: <cd020900567e5c26af29e0735a3945a855d26a30.1496718529.git.dvhart@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4090464.NfPQAyo2nT";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34432 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752879AbdFSQH4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 19 Jun 2017 12:07:56 -0400
In-Reply-To: <cd020900567e5c26af29e0735a3945a855d26a30.1496718529.git.dvhart@infradead.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Lutomirski <luto@kernel.org>
Cc: platform-driver-x86@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andy Lutomirski <luto@amacapital.net>, Mario Limonciello <mario_limonciello@dell.com>, Rafael Wysocki <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

--nextPart4090464.NfPQAyo2nT
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tuesday 06 June 2017 05:16:44 Andy Lutomirski wrote:
> Many laptops (and maybe servers?) have embedded WMI Binary MOF
> metadata. We do not yet have open-source tools for processing the
> data, although one is in the works thanks to Pali:
>=20
> 	https://github.com/pali/bmfdec
>=20
> There is currently no interface to get the data in the first place.
> By exposing it, we facilitate the development of new tools.
>=20
> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> Cc: Andy Lutomirski <luto@amacapital.net>
> Cc: Mario Limonciello <mario_limonciello@dell.com>
> Cc: Pali Roh=C3=A1r <pali.rohar@gmail.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: platform-driver-x86@vger.kernel.org
> Cc: linux-acpi@vger.kernel.org
> [dvhart: make sysfs mof binary read only, fixup comment block format]
> [dvhart: use bmof terminology and dev_err instead of dev_warn]
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Darren Hart (VMware) <dvhart@infradead.org>
> ---
> since-v1:
>  * address Pali's comments:
>    * update the cover letter for clarity and accuracy
>    * update mof->bmof and MOF to Binary MOF throughout the patch
>    * use dev_err instead of dev_warn in wmi_bmof_probe
>=20
>=20
>  drivers/platform/x86/Kconfig    |  12 ++++
>  drivers/platform/x86/Makefile   |   1 +
>  drivers/platform/x86/wmi-bmof.c | 125

Another suggestion (unrelated to this patch): For working with ACPI-WMI,=20
this binary MOF buffer is not enough. It is needed also content of _WDG=20
buffer. What about exporting it too via sysfs? Probably not part of of=20
wmi-bmof driver, but wmi driver itself.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart4090464.NfPQAyo2nT
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAllH9s4ACgkQi/DJPQPkQ1KafwCaA5egKGDBynfCAT1/7YiW9zLG
c9AAoJdFJmAtvmXyPGKSl2CaTIOTDUcy
=MfeX
-----END PGP SIGNATURE-----

--nextPart4090464.NfPQAyo2nT--
