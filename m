From: G Gregory <graeme.gregory@linaro.org>
Subject: Re: [PATCH v3 11/14] ACPI: irq: introduce interrupt producer
Date: Sat, 3 Dec 2016 12:18:02 +0000
Message-ID: <20161203121802.GG1115@linaro-xps13.localdomain>
References: <1477408169-22217-1-git-send-email-guohanjun@huawei.com>
 <1477408169-22217-12-git-send-email-guohanjun@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:35494 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751056AbcLCMSW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 3 Dec 2016 07:18:22 -0500
Received: by mail-wm0-f50.google.com with SMTP id a197so40095027wmd.0
        for <linux-acpi@vger.kernel.org>; Sat, 03 Dec 2016 04:18:22 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1477408169-22217-12-git-send-email-guohanjun@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <guohanjun@huawei.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Greg KH <gregkh@linuxfoundation.org>, Tomasz Nowicki <tn@semihalf.com>, Ma Jun <majun258@huawei.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Agustin Vega-Frias <agustinv@codeaurora.org>, Sinan Kaya <okaya@codeaurora.org>, Charles Garcia-Tobin <charles.garcia-tobin@arm.com>, huxinwei@huawei.com, yimin@huawei.com, linuxarm@huawei.com, Hanjun Guo <hanjun.guo@linaro.org>

On Tue, Oct 25, 2016 at 11:09:26PM +0800, Hanjun Guo wrote:
> From: Hanjun Guo <hanjun.guo@linaro.org>
>=20
> In ACPI 6.1 spec, section 19.6.62, Interrupt Resource Descriptor Macro,
>=20
> Interrupt (ResourceUsage, EdgeLevel, ActiveLevel, Shared,
> ResourceSourceIndex, ResourceSource, DescriptorName)
> { InterruptList } =3D> Buffer
>=20
> For the arguement ResourceUsage and DescriptorName, which means:
>=20
> ResourceUsage describes whether the device consumes the specified
> interrupt ( ResourceConsumer ) or produces it for use by a child
> device ( ResourceProducer ).
> If nothing is specified, then ResourceConsumer is assumed.
>=20
> DescriptorName evaluates to a name string which refers to the
> entire resource descriptor.
>=20
> So it can be used for devices connecting to a specific interrupt
> prodcucer instead of the main interrupt controller in MADT. In the
> real world, we have irqchip such as mbi-gen which connecting to
> a group of wired interrupts and then issue msi to the ITS, devices
> connecting to such interrupt controller fit this scope.
>=20
> For now the irq for ACPI only pointer to the main interrupt
> controller's irqdomain, for devices not connecting to those
> irqdomains, which need to present its irq parent, we can use
> following ASL code to represent it:
>=20
> Interrupt(ResourceConsumer,..., "\_SB.IRQP") {12,14,....}
>=20
> then we can parse the interrupt producer with the full
> path name "\_SB.IRQP".
>=20
> In order to do that, we introduce a pointer interrupt_producer
> in struct acpi_device, and fill it when scanning irq resources
> for acpi device if it specifies the interrupt producer.
>=20
> But for now when parsing the resources for acpi devices, we don't
> pass the acpi device for acpi_walk_resoures() in drivers/acpi/resource.c,
> so introduce a adev in struct res_proc_context to pass it as a context
> to scan the interrupt resources, then finally pass to acpi_register_gsi()
> to find its interrupt producer to get the virq from diffrent domains.
>=20
> With steps above ready, rework acpi_register_gsi() to get other
> interrupt producer if devices not connecting to main interrupt
> controller.
>=20
> Since we often pass NULL to acpi_register_gsi() and there is no interrupt
> producer for devices connect to gicd on ARM or io-apic on X86, so it will
> use the default irqdomain for those deivces and no functional changes to
> those devices.
>=20
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Agustin Vega-Frias <agustinv@codeaurora.org>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> ---
>  drivers/acpi/gsi.c      | 10 ++++--
>  drivers/acpi/resource.c | 85 ++++++++++++++++++++++++++++++++++---------=
------
>  include/acpi/acpi_bus.h |  1 +
>  3 files changed, 68 insertions(+), 28 deletions(-)
>=20
> diff --git a/drivers/acpi/gsi.c b/drivers/acpi/gsi.c
> index ee9e0f2..29ee547 100644
> --- a/drivers/acpi/gsi.c
> +++ b/drivers/acpi/gsi.c
> @@ -55,13 +55,19 @@ int acpi_register_gsi(struct device *dev, u32 gsi, in=
t trigger,
>  		      int polarity)
>  {
>  	struct irq_fwspec fwspec;
> +	struct acpi_device *adev =3D dev ? to_acpi_device(dev) : NULL;
> =20
> -	if (WARN_ON(!acpi_gsi_domain_id)) {
> +	if (adev && &adev->fwnode && adev->interrupt_producer)
> +		/* devices in DSDT connecting to spefic interrupt producer */
> +		fwspec.fwnode =3D adev->interrupt_producer;
> +	else if (acpi_gsi_domain_id)
> +		/* devices connecting to gicd in default */
> +		fwspec.fwnode =3D acpi_gsi_domain_id;
> +	else {
>  		pr_warn("GSI: No registered irqchip, giving up\n");
>  		return -EINVAL;
>  	}
> =20
> -	fwspec.fwnode =3D acpi_gsi_domain_id;
>  	fwspec.param[0] =3D gsi;
>  	fwspec.param[1] =3D acpi_dev_get_irq_type(trigger, polarity);
>  	fwspec.param_count =3D 2;
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index 56241eb..f1371cf 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -381,7 +381,7 @@ static void acpi_dev_irqresource_disabled(struct reso=
urce *res, u32 gsi)
>  	res->flags =3D IORESOURCE_IRQ | IORESOURCE_DISABLED | IORESOURCE_UNSET;
>  }
> =20
> -static void acpi_dev_get_irqresource(struct resource *res, u32 gsi,
> +static void acpi_dev_get_irqresource(struct acpi_device *adev, struct re=
source *res, u32 gsi,
>  				     u8 triggering, u8 polarity, u8 shareable,
>  				     bool legacy)
>  {
> @@ -415,7 +415,7 @@ static void acpi_dev_get_irqresource(struct resource =
*res, u32 gsi,
>  	}
> =20
>  	res->flags =3D acpi_dev_irq_flags(triggering, polarity, shareable);
> -	irq =3D acpi_register_gsi(NULL, gsi, triggering, polarity);
> +	irq =3D acpi_register_gsi(&adev->dev, gsi, triggering, polarity);
>  	if (irq >=3D 0) {
>  		res->start =3D irq;
>  		res->end =3D irq;
> @@ -424,27 +424,9 @@ static void acpi_dev_get_irqresource(struct resource=
 *res, u32 gsi,
>  	}
>  }
> =20
> -/**
> - * acpi_dev_resource_interrupt - Extract ACPI interrupt resource informa=
tion.
> - * @ares: Input ACPI resource object.
> - * @index: Index into the array of GSIs represented by the resource.
> - * @res: Output generic resource object.
> - *
> - * Check if the given ACPI resource object represents an interrupt resou=
rce
> - * and @index does not exceed the resource's interrupt count (true is re=
turned
> - * in that case regardless of the results of the other checks)).  If tha=
t's the
> - * case, register the GSI corresponding to @index from the array of inte=
rrupts
> - * represented by the resource and populate the generic resource object =
pointed
> - * to by @res accordingly.  If the registration of the GSI is not succes=
sful,
> - * IORESOURCE_DISABLED will be set it that object's flags.
> - *
> - * Return:
> - * 1) false with res->flags setting to zero: not the expected resource t=
ype
> - * 2) false with IORESOURCE_DISABLED in res->flags: valid unassigned res=
ource
> - * 3) true: valid assigned resource
> - */
> -bool acpi_dev_resource_interrupt(struct acpi_resource *ares, int index,
> -				 struct resource *res)
> +static bool __acpi_dev_resource_interrupt(struct acpi_device *adev,
> +					  struct acpi_resource *ares, int index,
> +					  struct resource *res)
>  {
>  	struct acpi_resource_irq *irq;
>  	struct acpi_resource_extended_irq *ext_irq;
> @@ -460,7 +442,7 @@ bool acpi_dev_resource_interrupt(struct acpi_resource=
 *ares, int index,
>  			acpi_dev_irqresource_disabled(res, 0);
>  			return false;
>  		}
> -		acpi_dev_get_irqresource(res, irq->interrupts[index],
> +		acpi_dev_get_irqresource(adev, res, irq->interrupts[index],
>  					 irq->triggering, irq->polarity,
>  					 irq->sharable, true);
>  		break;
> @@ -470,7 +452,31 @@ bool acpi_dev_resource_interrupt(struct acpi_resourc=
e *ares, int index,
>  			acpi_dev_irqresource_disabled(res, 0);
>  			return false;
>  		}
> -		acpi_dev_get_irqresource(res, ext_irq->interrupts[index],
> +
> +		/*
> +		 * It's a interrupt consumer device and connecting to specfic
> +		 * interrupt controller. For now, we only support connecting
> +		 * interrupts to one irq controller for a single device
> +		 */
> +		if (ext_irq->producer_consumer =3D=3D ACPI_CONSUMER
> +		    && ext_irq->resource_source.string_length !=3D 0
> +		    && !adev->interrupt_producer) {
> +			acpi_status status;
> +			acpi_handle handle;
> +			struct acpi_device *device;
> +
> +			status =3D acpi_get_handle(NULL, ext_irq->resource_source.string_ptr,=
 &handle);
> +			if (ACPI_FAILURE(status))
> +				return false;
> +
> +			device =3D acpi_bus_get_acpi_device(handle);
> +			if (!device)
> +				return false;
> +
> +			adev->interrupt_producer =3D &device->fwnode;
> +		}
> +
> +		acpi_dev_get_irqresource(adev, res, ext_irq->interrupts[index],
>  					 ext_irq->triggering, ext_irq->polarity,
>  					 ext_irq->sharable, false);
>  		break;
> @@ -481,6 +487,31 @@ bool acpi_dev_resource_interrupt(struct acpi_resourc=
e *ares, int index,
> =20
>  	return true;
>  }
> +
> +/**
> + * acpi_dev_resource_interrupt - Extract ACPI interrupt resource informa=
tion.
> + * @ares: Input ACPI resource object.
> + * @index: Index into the array of GSIs represented by the resource.
> + * @res: Output generic resource object.
> + *
> + * Check if the given ACPI resource object represents an interrupt resou=
rce
> + * and @index does not exceed the resource's interrupt count (true is re=
turned
> + * in that case regardless of the results of the other checks)).  If tha=
t's the
> + * case, register the GSI corresponding to @index from the array of inte=
rrupts
> + * represented by the resource and populate the generic resource object =
pointed
> + * to by @res accordingly.  If the registration of the GSI is not succes=
sful,
> + * IORESOURCE_DISABLED will be set it that object's flags.
> + *
> + * Return:
> + * 1) false with res->flags setting to zero: not the expected resource t=
ype
> + * 2) false with IORESOURCE_DISABLED in res->flags: valid unassigned res=
ource
> + * 3) true: valid assigned resource
> + */
> +bool acpi_dev_resource_interrupt(struct acpi_resource *ares, int index,
> +				 struct resource *res)
> +{
> +	return __acpi_dev_resource_interrupt(NULL, ares, index, res);
> +}
>  EXPORT_SYMBOL_GPL(acpi_dev_resource_interrupt);

You cannot do this as &adev->dev is deferenced in acpi_dev_get_irqresource
without a check that adev is NULL, and so passes an offset from NULL to
acpi_register_gsi() which breaks everything.

Graeme

> =20
>  /**
> @@ -499,6 +530,7 @@ struct res_proc_context {
>  	void *preproc_data;
>  	int count;
>  	int error;
> +	struct acpi_device *adev;
>  };
> =20
>  static acpi_status acpi_dev_new_resource_entry(struct resource_win *win,
> @@ -546,7 +578,7 @@ static acpi_status acpi_dev_process_resource(struct a=
cpi_resource *ares,
>  	    || acpi_dev_resource_ext_address_space(ares, &win))
>  		return acpi_dev_new_resource_entry(&win, c);
> =20
> -	for (i =3D 0; acpi_dev_resource_interrupt(ares, i, res); i++) {
> +	for (i =3D 0; __acpi_dev_resource_interrupt(c->adev, ares, i, res); i++=
) {
>  		acpi_status status;
> =20
>  		status =3D acpi_dev_new_resource_entry(&win, c);
> @@ -599,6 +631,7 @@ int acpi_dev_get_resources(struct acpi_device *adev, =
struct list_head *list,
>  	c.preproc_data =3D preproc_data;
>  	c.count =3D 0;
>  	c.error =3D 0;
> +	c.adev =3D adev;
>  	status =3D acpi_walk_resources(adev->handle, METHOD_NAME__CRS,
>  				     acpi_dev_process_resource, &c);
>  	if (ACPI_FAILURE(status)) {
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index 4242c31..5410d3b 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -355,6 +355,7 @@ struct acpi_device {
>  	int device_type;
>  	acpi_handle handle;		/* no handle for fixed hardware */
>  	struct fwnode_handle fwnode;
> +	struct fwnode_handle *interrupt_producer;
>  	struct acpi_device *parent;
>  	struct list_head children;
>  	struct list_head node;
> --=20
> 1.7.12.4
>=20
