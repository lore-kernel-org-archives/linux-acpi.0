From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [patch] 2.6.1-mm3 acpi frees free irq0
Date: Thu, 15 Jan 2004 12:19:24 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE0CC89CC@hdsmsx402.hd.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jes Sorensen <jes-dtAfj9ClZIwnoBwkMbRkTB2eb7JE58TQ@public.gmane.org>, akpm-3NddpPZAyC0@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Jesse Barnes <jbarnes-sJ/iWh9BUns@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

The primary failure is that the SCI was not found, and the secondary
symptom is that we failed to handle that error properly -- which you've
patched.

Can you tell me more about the primary failure?
Was the SCI found in other releases?

Thanks,
-Len

> -----Original Message-----
> From: Jes Sorensen [mailto:jes-dtAfj9ClZIwnoBwkMbRkTB2eb7JE58TQ@public.gmane.org]=20
> Sent: Thursday, January 15, 2004 9:57 AM
> To: akpm-3NddpPZAyC0@public.gmane.org
> Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;=20
> acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; Brown, Len; Jesse Barnes
> Subject: [patch] 2.6.1-mm3 acpi frees free irq0
>=20
>=20
> Hi,
>=20
> There is a bug in the ACPI code found in 2.6.1-mm3 where if it can't
> find the interrupt source for the ACPI System Control=20
> Interrupt Handler,
> it end up trying to free irq 0.
>=20
> Included patch fixes the problem.
>=20
> Cheers,
> Jes
>=20
> --- linux-2.6.1-mm3/drivers/acpi/osl.c~	Wed Jan 14 05:00:25 2004
> +++ linux-2.6.1-mm3/drivers/acpi/osl.c	Thu Jan 15 06:43:28 2004
> @@ -257,13 +257,13 @@
>  		return AE_OK;
>  	}
>  #endif
> -	acpi_irq_irq =3D irq;
>  	acpi_irq_handler =3D handler;
>  	acpi_irq_context =3D context;
>  	if (request_irq(irq, acpi_irq, SA_SHIRQ, "acpi", acpi_irq)) {
>  		printk(KERN_ERR PREFIX "SCI (IRQ%d) allocation=20
> failed\n", irq);
>  		return AE_NOT_ACQUIRED;
>  	}
> +	acpi_irq_irq =3D irq;
> =20
>  	return AE_OK;
>  }
> @@ -271,12 +271,13 @@
>  acpi_status
>  acpi_os_remove_interrupt_handler(u32 irq, OSD_HANDLER handler)
>  {
> -	if (acpi_irq_handler) {
> +	if (irq) {
>  #if defined(CONFIG_IA64) || defined(CONFIG_PCI_USE_VECTOR)
>  		irq =3D acpi_irq_to_vector(irq);
>  #endif
>  		free_irq(irq, acpi_irq);
>  		acpi_irq_handler =3D NULL;
> +		acpi_irq_irq =3D 0;
>  	}
> =20
>  	return AE_OK;
>=20


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
