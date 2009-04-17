From: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] thermal: Fix polling frequency for systems without
	passive cooling
Date: Fri, 17 Apr 2009 09:37:07 +0800
Message-ID: <1239932227.7661.397.camel@rzhang-dt>
References: <49DF6835.9040501@tuffmail.co.uk> <49DFE345.3010109@gmail.com>
	 <49E05F83.2090500@tuffmail.co.uk> <49E20EBA.2090708@tuffmail.co.uk>
	 <1239588248.5564.19.camel@localhost.localdomain>
	 <49E3085D.3060403@tuffmail.co.uk> <20090413170531.GA13188@srcf.ucam.org>
	 <49E38779.9060705@tuffmail.co.uk>  <20090414191645.GB7940@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090414191645.GB7940-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Sender: kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Cc: Alan Jenkins <alan-jenkins-cCz0Lq7MMjm9FHfhHBbuYA@public.gmane.org>, "Zhao, Yakui" <yakui.zhao-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Alexey Starikovskiy <aystarik-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kernel Testers List <kernel-testers-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, 2009-04-15 at 03:16 +0800, Matthew Garrett wrote:
> The polling interval (in deciseconds) was accidently interpreted as=20
> being in milliseconds in one codepath, resulting in excessively frequ=
ent=20
> polling. Ensure that the conversion is performed.
>=20
> Signed-off-by: Matthew Garrett <mjg-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Acked-by: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

=EF=BB=BFLen,
I think we can ship this patch in 2.6.30-rc3.

thanks,
rui
>=20
> ---
>=20
> diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
> index 9cd15e8..564ea14 100644
> --- a/drivers/acpi/thermal.c
> +++ b/drivers/acpi/thermal.c
> @@ -909,7 +909,7 @@ static int acpi_thermal_register_thermal_zone(str=
uct acpi_thermal *tz)
>  			thermal_zone_device_register("acpitz", trips, tz,
>  						     &acpi_thermal_zone_ops,
>  						     0, 0, 0,
> -						     tz->polling_frequency);
> +						     tz->polling_frequency*100);
>  	if (IS_ERR(tz->thermal_zone))
>  		return -ENODEV;
>=20
