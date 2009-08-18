From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [RFC][PATCH 7/7] PM: Asynchronous suspend and resume of i8042
Date: Tue, 18 Aug 2009 15:03:30 +0800
Message-ID: <1250579010.5351.69.camel@rzhang-dt>
References: <200908122218.13975.rjw@sisk.pl>
	 <200908170215.21173.rjw@sisk.pl>  <200908170221.34885.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:6490 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752170AbZHRHFE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 18 Aug 2009 03:05:04 -0400
In-Reply-To: <200908170221.34885.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, linux-acpi <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Arjan van de Ven <arjan@linux.intel.com>, Greg KH <gregkh@suse.de>

On Mon, 2009-08-17 at 08:21 +0800, Rafael J. Wysocki wrote:
> Set async_suspend for i8042.
>=20
it's the psmouse reset that takes the 0.4 seconds during suspend.
=EF=BB=BFso we should call device_enable_async_suspend for the psmouse =
serio
device in psmouse-base.c

Or invoking device_enable_async_suspend for every serio device in
serio.c, as the keyboard also takes about 0.2s to suspend.

thanks,
rui
> ---
>  drivers/input/serio/i8042.c |    2 ++
>  1 file changed, 2 insertions(+)
>=20
> Index: linux-2.6/drivers/input/serio/i8042.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/drivers/input/serio/i8042.c
> +++ linux-2.6/drivers/input/serio/i8042.c
> @@ -1289,6 +1289,8 @@ static int __init i8042_init(void)
>  	if (err)
>  		goto err_free_device;
> =20
> +	device_enable_async_suspend(&i8042_platform_device->dev, true);
> +
>  	panic_blink =3D i8042_panic_blink;
> =20
>  	return 0;

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
