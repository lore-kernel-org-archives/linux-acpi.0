From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] acpi: add newline in power.c message
Date: Fri, 02 Nov 2012 13:50:04 +0100
Message-ID: <4807253.ASC2v3Jian@vostro.rjw.lan>
References: <508D7CF7.1070707@gmx.de> <508EBBFF.2020803@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:52171 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752029Ab2KBMp5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 2 Nov 2012 08:45:57 -0400
In-Reply-To: <508EBBFF.2020803@xenotime.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: Toralf =?ISO-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

On Monday, October 29, 2012 10:25:19 AM Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@xenotime.net>
>=20
> Add newline to printk so that the message is on a line
> by itself and not merged with something unrelated to it.
>=20
> Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
> Reported-by: Toralf F=C3=B6rster <toralf.foerster@gmx.de>
> Cc:	Len Brown <lenb@kernel.org>
> Cc:	Rafael J. Wysocki <rjw@sisk.pl>

Applied to the linux-next branch of the linux-pm.git tree as v3.8 mater=
ial.

Thanks,
Rafael



> ---
>  drivers/acpi/power.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> --- lnx-37-rc3.orig/drivers/acpi/power.c
> +++ lnx-37-rc3/drivers/acpi/power.c
> @@ -473,7 +473,7 @@ int acpi_power_resource_register_device(
>  	return ret;
> =20
>  no_power_resource:
> -	printk(KERN_DEBUG PREFIX "Invalid Power Resource to register!");
> +	printk(KERN_DEBUG PREFIX "Invalid Power Resource to register!\n");
>  	return -ENODEV;
>  }
>  EXPORT_SYMBOL_GPL(acpi_power_resource_register_device);
>=20
--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
