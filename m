From: =?UTF-8?B?w4lyaWMgUGllbA==?= <eric.piel@tremplin-utc.net>
Subject: Re: [PATCH 13/21] hp_accel: Use struct dev_pm_ops for power management
Date: Sun, 24 Jun 2012 22:00:54 +0200
Message-ID: <4FE771F6.7000206@tremplin-utc.net>
References: <201206232306.06602.rjw@sisk.pl> <201206232316.20989.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <201206232316.20989.rjw@sisk.pl>
Sender: platform-driver-x86-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM list <linux-pm@vger.kernel.org>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, platform-driver-x86@vger.kernel.org, Mattia Dongili <malattia@linux.it>, Harald Welte <laforge@gnumonks.org>
List-Id: linux-acpi@vger.kernel.org

On 23-06-12 23:16, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
>
> Make the hp_accel driver define its PM callbacks through
> a struct dev_pm_ops object rather than by using legacy PM hooks
> in struct acpi_device_ops.
>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Hello,
Looks fine from my point of view.

Reviewed-by: =C3=89ric Piel <eric.piel@tremplin-utc.net>

=C3=89ric

> ---
>   drivers/platform/x86/hp_accel.c |   15 ++++++++-------
>   1 file changed, 8 insertions(+), 7 deletions(-)
>
> Index: linux/drivers/platform/x86/hp_accel.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux.orig/drivers/platform/x86/hp_accel.c
> +++ linux/drivers/platform/x86/hp_accel.c
> @@ -353,20 +353,22 @@ static int lis3lv02d_remove(struct acpi_
>
>
>   #ifdef CONFIG_PM
> -static int lis3lv02d_suspend(struct acpi_device *device)
> +static int lis3lv02d_suspend(struct device *dev)
>   {
>   	/* make sure the device is off when we suspend */
>   	lis3lv02d_poweroff(&lis3_dev);
>   	return 0;
>   }
>
> -static int lis3lv02d_resume(struct acpi_device *device)
> +static int lis3lv02d_resume(struct device *dev)
>   {
>   	return lis3lv02d_poweron(&lis3_dev);
>   }
> +
> +static SIMPLE_DEV_PM_OPS(hp_accel_pm, lis3lv02d_suspend, lis3lv02d_r=
esume);
> +#define HP_ACCEL_PM (&hp_accel_pm)
>   #else
> -#define lis3lv02d_suspend NULL
> -#define lis3lv02d_resume NULL
> +#define HP_ACCEL_PM NULL
>   #endif
>
>   /* For the HP MDPS aka 3D Driveguard */
> @@ -377,9 +379,8 @@ static struct acpi_driver lis3lv02d_driv
>   	.ops =3D {
>   		.add     =3D lis3lv02d_add,
>   		.remove  =3D lis3lv02d_remove,
> -		.suspend =3D lis3lv02d_suspend,
> -		.resume  =3D lis3lv02d_resume,
> -	}
> +	},
> +	.drv.pm =3D HP_ACCEL_PM,
>   };
>
>   static int __init lis3lv02d_init_module(void)
>
