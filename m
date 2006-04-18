From: Henrik Brix Andersen <brix@gentoo.org>
Subject: Re: PATCH [2/3]: Provide generic backlight support in IBM ACPI driver
Date: Tue, 18 Apr 2006 11:18:57 +0200
Message-ID: <20060418091857.GB30628@osgiliath>
References: <20060418082952.GA13811@srcf.ucam.org> <20060418083056.GA13846@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1LKvkjL3sHcu1TtY"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([134.68.220.30]:10183 "EHLO smtp.gentoo.org")
	by vger.kernel.org with ESMTP id S932097AbWDRJTB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 18 Apr 2006 05:19:01 -0400
Content-Disposition: inline
In-Reply-To: <20060418083056.GA13846@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org


--1LKvkjL3sHcu1TtY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 18, 2006 at 09:30:56AM +0100, Matthew Garrett wrote:
> diff -urp drivers/acpi.bak/Kconfig drivers/acpi/Kconfig
> --- drivers/acpi.bak/Kconfig	2006-04-18 08:51:49 +0100
> +++ a/drivers/acpi/Kconfig	2006-04-18 09:13:09 +0100
> @@ -195,7 +195,7 @@ config ACPI_ASUS
>           =20
>  config ACPI_IBM
>  	tristate "IBM ThinkPad Laptop Extras"
> -	depends on X86
> +	depends on X86 && BACKLIGHT_DEVICE

Wouldn't it be better to have ACPI_IBM and friends select
BACKLIGHT_DEVICE?

Regards,
Brix
--=20
Henrik Brix Andersen <brix@gentoo.org>
Gentoo Metadistribution | Mobile computing herd

--1LKvkjL3sHcu1TtY
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: GnuPG signed

iD8DBQFERK8Bv+Q4flTiePgRAmPrAKCa+dWrBOikaRt1m8O3hxg6BpcP+wCgv+cv
PcVS80WBwLmAkIU9OYa0chQ=
=4Bnj
-----END PGP SIGNATURE-----

--1LKvkjL3sHcu1TtY--
