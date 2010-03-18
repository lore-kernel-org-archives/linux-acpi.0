From: Venkatesh Pallipadi <venki@google.com>
Subject: Re: [PATCH v2 1/4] hpet: convert from ACPI to PNP driver
Date: Thu, 18 Mar 2010 12:26:38 -0700
Message-ID: <3055132f1003181226w3db55bd8o506b1020d2e2218c@mail.gmail.com>
References: <20100318175852.15143.2124.stgit@bob.kio>
	 <20100318175930.15143.28660.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:13772 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751317Ab0CRT0m convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 18 Mar 2010 15:26:42 -0400
In-Reply-To: <20100318175930.15143.28660.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Clemens Ladisch <clemens@ladisch.de>, Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

Acked-by: Venkatesh Pallipadi <venki@google.com>

On Thu, Mar 18, 2010 at 10:59 AM, Bjorn Helgaas <bjorn.helgaas@hp.com> =
wrote:
>
> PNPACPI already parses _CRS, and does a more complete job than we did=
 here,
> so let's just take advantage of that.
>
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> ---
>
> =A0drivers/char/hpet.c | =A0109 +++++++++++++++----------------------=
--------------
> =A01 files changed, 33 insertions(+), 76 deletions(-)
>
>
> diff --git a/drivers/char/hpet.c b/drivers/char/hpet.c
> index e481c59..5cb05ed 100644
> --- a/drivers/char/hpet.c
> +++ b/drivers/char/hpet.c
> @@ -31,6 +31,7 @@
> =A0#include <linux/seq_file.h>
> =A0#include <linux/bitops.h>
> =A0#include <linux/clocksource.h>
> +#include <linux/pnp.h>
>
> =A0#include <asm/current.h>
> =A0#include <asm/uaccess.h>
> @@ -40,7 +41,6 @@
> =A0#include <asm/div64.h>
>
> =A0#include <linux/acpi.h>
> -#include <acpi/acpi_bus.h>
> =A0#include <linux/hpet.h>
>
> =A0/*
> @@ -899,101 +899,56 @@ int hpet_alloc(struct hpet_data *hdp)
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> -static acpi_status hpet_resources(struct acpi_resource *res, void *d=
ata)
> +#ifdef CONFIG_PNP
> +static int hpet_pnp_add(struct pnp_dev *dev, const struct pnp_device=
_id *dev_id)
> =A0{
> - =A0 =A0 =A0 struct hpet_data *hdp;
> - =A0 =A0 =A0 acpi_status status;
> - =A0 =A0 =A0 struct acpi_resource_address64 addr;
> -
> - =A0 =A0 =A0 hdp =3D data;
> -
> - =A0 =A0 =A0 status =3D acpi_resource_to_address64(res, &addr);
> -
> - =A0 =A0 =A0 if (ACPI_SUCCESS(status)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 hdp->hd_phys_address =3D addr.minimum;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 hdp->hd_address =3D ioremap(addr.minimu=
m, addr.address_length);
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (hpet_is_known(hdp)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 iounmap(hdp->hd_address=
);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return AE_ALREADY_EXIST=
S;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> - =A0 =A0 =A0 } else if (res->type =3D=3D ACPI_RESOURCE_TYPE_FIXED_ME=
MORY32) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct acpi_resource_fixed_memory32 *fi=
xmem32;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 fixmem32 =3D &res->data.fixed_memory32;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!fixmem32)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return AE_NO_MEMORY;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 hdp->hd_phys_address =3D fixmem32->addr=
ess;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 hdp->hd_address =3D ioremap(fixmem32->a=
ddress,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 HPET_RANGE_SIZE);
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (hpet_is_known(hdp)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 iounmap(hdp->hd_address=
);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return AE_ALREADY_EXIST=
S;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> - =A0 =A0 =A0 } else if (res->type =3D=3D ACPI_RESOURCE_TYPE_EXTENDED=
_IRQ) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct acpi_resource_extended_irq *irqp=
;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 int i, irq;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 irqp =3D &res->data.extended_irq;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < irqp->interrupt_count=
; i++) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq =3D acpi_register_g=
si(NULL, irqp->interrupts[i],
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 irqp->triggering, irqp->polarity);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (irq < 0)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return =
AE_ERROR;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hdp->hd_irq[hdp->hd_nir=
qs] =3D irq;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hdp->hd_nirqs++;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> - =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 return AE_OK;
> -}
> -
> -static int hpet_acpi_add(struct acpi_device *device)
> -{
> - =A0 =A0 =A0 acpi_status result;
> =A0 =A0 =A0 =A0struct hpet_data data;
> + =A0 =A0 =A0 struct resource *mem, *irq;
> + =A0 =A0 =A0 int i;
>
> =A0 =A0 =A0 =A0memset(&data, 0, sizeof(data));
>
> - =A0 =A0 =A0 result =3D
> - =A0 =A0 =A0 =A0 =A0 acpi_walk_resources(device->handle, METHOD_NAME=
__CRS,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hpet_re=
sources, &data);
> -
> - =A0 =A0 =A0 if (ACPI_FAILURE(result))
> + =A0 =A0 =A0 mem =3D pnp_get_resource(dev, IORESOURCE_MEM, 0);
> + =A0 =A0 =A0 if (!mem)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENODEV;
>
> - =A0 =A0 =A0 if (!data.hd_address || !data.hd_nirqs) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk("%s: no address or irqs in _CRS\=
n", __func__);
> + =A0 =A0 =A0 data.hd_phys_address =3D mem->start;
> +
> + =A0 =A0 =A0 if (hpet_is_known(&data))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENODEV;
> +
> + =A0 =A0 =A0 i =3D 0;
> + =A0 =A0 =A0 while (data.hd_nirqs < ARRAY_SIZE(data.hd_irq)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq =3D pnp_get_resource(dev, IORESOURC=
E_IRQ, i++);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pnp_resource_valid(irq) && pnp_reso=
urce_enabled(irq))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data.hd_irq[data.hd_nir=
qs++] =3D irq->start;
> =A0 =A0 =A0 =A0}
> + =A0 =A0 =A0 if (!data.hd_nirqs)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> +
> + =A0 =A0 =A0 data.hd_address =3D ioremap(mem->start, resource_size(m=
em));
>
> =A0 =A0 =A0 =A0return hpet_alloc(&data);
> =A0}
>
> -static int hpet_acpi_remove(struct acpi_device *device, int type)
> +static void hpet_pnp_remove(struct pnp_dev *dev)
> =A0{
> =A0 =A0 =A0 =A0/* XXX need to unregister clocksource, dealloc mem, et=
c */
> - =A0 =A0 =A0 return -EINVAL;
> =A0}
>
> -static const struct acpi_device_id hpet_device_ids[] =3D {
> +static const struct pnp_device_id hpet_device_ids[] =3D {
> =A0 =A0 =A0 =A0{"PNP0103", 0},
> =A0 =A0 =A0 =A0{"", 0},
> =A0};
> =A0MODULE_DEVICE_TABLE(acpi, hpet_device_ids);
>
> -static struct acpi_driver hpet_acpi_driver =3D {
> +static struct pnp_driver hpet_pnp_driver =3D {
> =A0 =A0 =A0 =A0.name =3D "hpet",
> - =A0 =A0 =A0 .ids =3D hpet_device_ids,
> - =A0 =A0 =A0 .ops =3D {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .add =3D hpet_acpi_add,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .remove =3D hpet_acpi_remove,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> + =A0 =A0 =A0 .id_table =3D hpet_device_ids,
> + =A0 =A0 =A0 .probe =3D hpet_pnp_add,
> + =A0 =A0 =A0 .remove =3D hpet_pnp_remove,
> =A0};
> +#endif
>
> =A0static struct miscdevice hpet_misc =3D { HPET_MINOR, "hpet", &hpet=
_fops };
>
> @@ -1007,26 +962,28 @@ static int __init hpet_init(void)
>
> =A0 =A0 =A0 =A0sysctl_header =3D register_sysctl_table(dev_root);
>
> - =A0 =A0 =A0 result =3D acpi_bus_register_driver(&hpet_acpi_driver);
> +#ifdef CONFIG_PNP
> + =A0 =A0 =A0 result =3D pnp_register_driver(&hpet_pnp_driver);
> =A0 =A0 =A0 =A0if (result < 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (sysctl_header)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unregister_sysctl_tabl=
e(sysctl_header);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0misc_deregister(&hpet_misc);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return result;
> =A0 =A0 =A0 =A0}
> +#endif
>
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> =A0static void __exit hpet_exit(void)
> =A0{
> - =A0 =A0 =A0 acpi_bus_unregister_driver(&hpet_acpi_driver);
> +#ifdef CONFIG_PNP
> + =A0 =A0 =A0 pnp_unregister_driver(&hpet_pnp_driver);
> +#endif
>
> =A0 =A0 =A0 =A0if (sysctl_header)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unregister_sysctl_table(sysctl_header)=
;
> =A0 =A0 =A0 =A0misc_deregister(&hpet_misc);
> -
> - =A0 =A0 =A0 return;
> =A0}
>
> =A0module_init(hpet_init);
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
