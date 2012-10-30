From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] acpi: add newline in power.c message
Date: Tue, 30 Oct 2012 14:34:29 -0600
Message-ID: <CAErSpo7z8uaQyWj2Ud7jbX+tup3RyFazv2=EGKSZODbj0+=DnQ@mail.gmail.com>
References: <508D7CF7.1070707@gmx.de> <508EBBFF.2020803@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:53421 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934502Ab2J3Uev convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 30 Oct 2012 16:34:51 -0400
Received: by mail-we0-f174.google.com with SMTP id t9so323994wey.19
        for <linux-acpi@vger.kernel.org>; Tue, 30 Oct 2012 13:34:50 -0700 (PDT)
In-Reply-To: <508EBBFF.2020803@xenotime.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: =?ISO-8859-1?Q?Toralf_F=F6rster?= <toralf.foerster@gmx.de>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>

On Mon, Oct 29, 2012 at 11:25 AM, Randy Dunlap <rdunlap@xenotime.net> w=
rote:
> From: Randy Dunlap <rdunlap@xenotime.net>
>
> Add newline to printk so that the message is on a line
> by itself and not merged with something unrelated to it.
>
> Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
> Reported-by: Toralf F=F6rster <toralf.foerster@gmx.de>
> Cc:     Len Brown <lenb@kernel.org>
> Cc:     Rafael J. Wysocki <rjw@sisk.pl>
> ---
>  drivers/acpi/power.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- lnx-37-rc3.orig/drivers/acpi/power.c
> +++ lnx-37-rc3/drivers/acpi/power.c
> @@ -473,7 +473,7 @@ int acpi_power_resource_register_device(
>         return ret;
>
>  no_power_resource:
> -       printk(KERN_DEBUG PREFIX "Invalid Power Resource to register!=
");
> +       printk(KERN_DEBUG PREFIX "Invalid Power Resource to register!=
\n");

It'd be nice if this and the other similar printks in this file
included a hint about the context, e.g., the device to which it's
related.

>         return -ENODEV;
>  }
>  EXPORT_SYMBOL_GPL(acpi_power_resource_register_device);
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
