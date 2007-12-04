From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 1/2] HWMON: coretemp, suspend fix
Date: Tue, 4 Dec 2007 01:29:56 -0500
Message-ID: <200712040129.56505.lenb@kernel.org>
References: <1196624925-17220-1-git-send-email-lenb@kernel.org> <200712031755.44441.rjw@sisk.pl> <200712031801.51513.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:43580 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751490AbXLDGai convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 4 Dec 2007 01:30:38 -0500
In-Reply-To: <200712031801.51513.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-acpi@vger.kernel.org, pm list <linux-pm@lists.linux-foundation.org>, "Mark M. Hoffman" <mhoffman@lightlink.com>, Jiri Slaby <jirislaby@gmail.com>, Andrew Morton <akpm@linux-foundation.org>

Applied to suspend branch.

thanks,
-Len

On Monday 03 December 2007 12:01, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> =A0
> It's not permitted to unregister a device after devices have been sus=
pended.
> It causes deadlocks to appear on systems with coretemp hwmon loaded. =
=A0To avoid
> this, we can make coretemp_cpu_callback() do nothing if the _FROZEN b=
it is set
> in action.
> =A0
> Also, in other cases it's generally too late to unregister the corete=
mp device
> if the CPU is already dead, so it should be unregistered on CPU_DOWN_=
PREPARE.
> =A0
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> Acked-by: Mark M. Hoffman <mhoffman@lightlink.com>
> Cc: Jiri Slaby <jirislaby@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
>  drivers/hwmon/coretemp.c |    5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> Index: linux-2.6/drivers/hwmon/coretemp.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/drivers/hwmon/coretemp.c
> +++ linux-2.6/drivers/hwmon/coretemp.c
> @@ -337,11 +337,10 @@ static int coretemp_cpu_callback(struct=20
> =20
>  	switch (action) {
>  	case CPU_ONLINE:
> -	case CPU_ONLINE_FROZEN:
> +	case CPU_DOWN_FAILED:
>  		coretemp_device_add(cpu);
>  		break;
> -	case CPU_DEAD:
> -	case CPU_DEAD_FROZEN:
> +	case CPU_DOWN_PREPARE:
>  		coretemp_device_remove(cpu);
>  		break;
>  	}
>=20
>=20
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
