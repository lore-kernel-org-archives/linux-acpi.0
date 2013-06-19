From: Tony Luck <tony.luck@gmail.com>
Subject: Re: [PATCH 0/5] ACPI / scan: Make it possible to use the container
 hotplug with other scan handlers
Date: Wed, 19 Jun 2013 10:37:27 -0700
Message-ID: <CA+8MBbLS9suFc4gdjbb1RQdYmEyNUUHhEKgSjMxJpQLcPPYN2g@mail.gmail.com>
References: <1417592.vuSG0cUIGo@vostro.rjw.lan>
	<3168584.RRBYoY5UXf@vostro.rjw.lan>
	<CA+8MBbKZBvqVA+wKTK7GpXorpBvDLGCJURc+PQz+QfDiwA1a8A@mail.gmail.com>
	<3321228.vG97AE80O6@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ve0-f173.google.com ([209.85.128.173]:34090 "EHLO
	mail-ve0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756708Ab3FSRh2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 19 Jun 2013 13:37:28 -0400
In-Reply-To: <3321228.vG97AE80O6@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Toshi Kani <toshi.kani@hp.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "Lu, Aaron" <aaron.lu@intel.com>

> Can you please apply the appended patch on top of it and see if the system
> still works then?

Still works with this patch.

-Tony

> ---
>  drivers/acpi/scan.c  |    3 +++
>  drivers/acpi/video.c |    3 ---
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> Index: linux-pm/drivers/acpi/scan.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/scan.c
> +++ linux-pm/drivers/acpi/scan.c
> @@ -939,6 +939,9 @@ static int acpi_device_probe(struct devi
>         struct acpi_driver *acpi_drv = to_acpi_driver(dev->driver);
>         int ret;
>
> +       if (acpi_dev->handler)
> +               return -EINVAL;
> +
>         if (!acpi_drv->ops.add)
>                 return -ENOSYS;
>
> Index: linux-pm/drivers/acpi/video.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/video.c
> +++ linux-pm/drivers/acpi/video.c
> @@ -1722,9 +1722,6 @@ static int acpi_video_bus_add(struct acp
>         int error;
>         acpi_status status;
>
> -       if (device->handler)
> -               return -EINVAL;
> -
>         status = acpi_walk_namespace(ACPI_TYPE_DEVICE,
>                                 device->parent->handle, 1,
>                                 acpi_video_bus_match, NULL,
>
