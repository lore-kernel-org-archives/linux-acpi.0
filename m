From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH] 2.4.23-pre3 ACPI fixes series (3/3)
Date: Fri, 5 Sep 2003 21:27:27 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE009FD1E@hdsmsx402.hd.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andrew de Quincey <adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>, Jeff Garzik <jgarzik-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
Cc: torvalds-3NddpPZAyC0@public.gmane.org, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-acpi <linux-acpi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

This also was pulled into the acpi patch earlier this week -- sorry I
didn't mention it to you earlier -- e-mail list latency has been
horrible lately.

Thanks,
-Len

> -----Original Message-----
> From: Andrew de Quincey [mailto:adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org]=20
> Sent: Friday, September 05, 2003 8:16 PM
> To: Jeff Garzik
> Cc: torvalds-3NddpPZAyC0@public.gmane.org; lkml;=20
> acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; linux-acpi
> Subject: [PATCH] 2.4.23-pre3 ACPI fixes series (3/3)
>=20
>=20
> This patch is actually a patch by "Jun Nakajima"=20
> <jun.nakajima-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> When setting an IRQ link device, it checks if the value=20
> returned by _CRS is 0.=20
> If so, it assumes everything went OK. This fixes problems on=20
> MANY VIA bioses.
> It seems to be a standard-ish way of saying "the _CRS IRQ=20
> setting cannot be read".
>=20
>=20
> --- linux-2.4.23-pre3.extirq/drivers/acpi/pci_link.c=09
> 2003-09-05 23:54:59.945755216 +0100
> +++ linux-2.4.23-pre3.null_crs/drivers/acpi/pci_link.c=09
> 2003-09-05 23:57:39.782456344 +0100
> @@ -277,6 +277,32 @@
> =20
> =20
>  static int
> +acpi_pci_link_try_get_current (
> +	struct acpi_pci_link *link,
> +	int irq)
> +{
> +	int result;
> +
> +	ACPI_FUNCTION_TRACE("acpi_pci_link_try_get_current");
> +  =20
> +	result =3D acpi_pci_link_get_current(link);
> +	if (result && link->irq.active)=20
> +	{
> +		return_VALUE(result);
> +	}
> +
> +	if (!link->irq.active)=20
> +	{
> +		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "No active IRQ=20
> resource found\n"));
> +		printk(KERN_WARNING "_CRS returns NULL! Using=20
> IRQ %d for device (%s [%s]).\n", irq,=20
> acpi_device_name(link->device), acpi_device_bid(link->device));
> +		link->irq.active =3D irq;
> +	}
> +  =20
> +	return 0;
> +}
> +
> +
> +static int
>  acpi_pci_link_set (
>  	struct acpi_pci_link	*link,
>  	int			irq)
> @@ -382,7 +408,7 @@
>  	}
> =20
>  	/* Make sure the active IRQ is the one we requested. */
> -	result =3D acpi_pci_link_get_current(link);
> +	result =3D acpi_pci_link_try_get_current(link, irq);
>  	if (result) {
>  		return_VALUE(result);
>  	}
> @@ -600,10 +626,6 @@
>  		else
>  			printk(" %d", link->irq.possible[i]);
>  	}
> -	if (!link->irq.active)
> -		printk(", disabled");
> -	else if (!found)
> -		printk(", enabled at IRQ %d", link->irq.active);
>  	printk(")\n");
> =20
>  	/* TBD: Acquire/release lock */
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe=20
> linux-kernel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>=20


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
