From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH] acpi: const-ify functions
Date: Wed, 8 Dec 2010 21:17:36 +0200
Message-ID: <20101208191736.GA6694@core2.telecom.by>
References: <201012081925.10292.hanno@hboeck.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f45.google.com ([209.85.215.45]:33799 "EHLO
	mail-ew0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756321Ab0LHTRn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Dec 2010 14:17:43 -0500
Content-Disposition: inline
In-Reply-To: <201012081925.10292.hanno@hboeck.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanno =?iso-8859-1?Q?B=F6ck?= <hanno@hboeck.de>
Cc: lenb@kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Wed, Dec 08, 2010 at 07:25:10PM +0100, Hanno B=F6ck wrote:
> Will const a couple of functions and variables. This is extracted
> from grsecurity (with only a slight modification to limit a line
> to 80 chars).

Why don't they do it themselves? :^)

> Patch is against linux-acpi-2.6 git.
>=20
> Similar patches have been sent in the past but not applied,
> supposedly because they weren't sent to subsystem maintainers.
> (I may continue to send similar extracts to other subsystems)
>=20
> ---
> Signed-off-by: Hanno Boeck <hanno@hboeck.de>

Signed-off-by should be before --- -- it must make into changelog.

> diff -Naurp linux-acpi-1//drivers/acpi/battery.c linux-acpi-2/drivers=
/acpi/battery.c
> --- linux-acpi-1//drivers/acpi/battery.c	2010-12-08 18:42:26.18700000=
5 +0100
> +++ linux-acpi-2/drivers/acpi/battery.c	2010-12-08 18:42:53.595000204=
 +0100
> @@ -851,7 +851,7 @@ DECLARE_FILE_FUNCTIONS(alarm);
>  	}
> =20
>  static struct battery_file {
> -	struct file_operations ops;
> +	const struct file_operations ops;

Whoa, does this work?

>  	mode_t mode;
>  	const char *name;
>  } acpi_battery_file[] =3D {

It maybe better to call proc_create_date() by hand (and even handle
errors gracefully?
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
