From: =?UTF-8?B?w4lyaWMgUGllbA==?= <Eric.Piel@tremplin-utc.net>
Subject: Re: [2.6 patch] make acpi_no_initrd_override_setup() static
Date: Wed, 13 Feb 2008 23:16:27 +0100
Message-ID: <47B36C3B.9060508@tremplin-utc.net>
References: <20080213213000.GS3383@cs181133002.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailservice.tudelft.nl ([130.161.131.5]:7792 "EHLO
	mailservice.tudelft.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764473AbYBMWQh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 13 Feb 2008 17:16:37 -0500
In-Reply-To: <20080213213000.GS3383@cs181133002.pp.htv.fi>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Adrian Bunk <bunk@kernel.org>
Cc: Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

13/02/08 22:30, Adrian Bunk wrote/a =C3=A9crit:
> acpi_no_initrd_override_setup() can become static.
>=20
> Signed-off-by: Adrian Bunk <bunk@kernel.org>
Oh, indeed, no one else uses this function.
Acked-by: Eric Piel <eric.piel@tremplin-utc.net>

>=20
> ---
> 1778953a9751288a9bee1d4f6a8b4f3d22e37f52 diff --git a/drivers/acpi/os=
l.c b/drivers/acpi/osl.c
> index 0c37c65..b72a7f1 100644
> --- a/drivers/acpi/osl.c
> +++ b/drivers/acpi/osl.c
> @@ -419,7 +419,7 @@ acpi_os_table_override(struct acpi_table_header *=
 existing_table,
>  }
> =20
>  #ifdef CONFIG_ACPI_CUSTOM_DSDT_INITRD
> -int __init acpi_no_initrd_override_setup(char *s)
> +static int __init acpi_no_initrd_override_setup(char *s)
>  {
>  	acpi_no_initrd_override =3D 1;
>  	return 1;

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
