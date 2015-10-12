From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 10/16] acpi/gsi: Add acpi_set_irq_model to initialize the GSI layer
Date: Mon, 12 Oct 2015 22:36:09 +0200
Message-ID: <3307806.SbgVXOQCOR@vostro.rjw.lan>
References: <1444152989-31726-1-git-send-email-marc.zyngier@arm.com> <1444152989-31726-11-git-send-email-marc.zyngier@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:46610 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751372AbbJLUHb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 12 Oct 2015 16:07:31 -0400
In-Reply-To: <1444152989-31726-11-git-send-email-marc.zyngier@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jiang Liu <jiang.liu@linux.intel.com>, Jason Cooper <jason@lakedaemon.net>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Hanjun Guo <hanjun.guo@linaro.org>, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, Graeme Gregory <graeme@xora.org.uk>, Jake Oshins <jakeo@microsoft.com>

On Tuesday, October 06, 2015 06:36:23 PM Marc Zyngier wrote:
> In order to start embrassing irqdomains at the GSI level, introduce
> a new initializer:
> 
> void acpi_set_irq_model(enum acpi_irq_model_id model,
> 			struct fwnode_handle *fwnode);
> 
> where:
> - model is the value assigned to acpi_irq_model
> - fwnode is the identifier for the irqdomain mapping
>   GSI interrupts
> 
> As nobody calls this code yet, the current code is (mostly)
> left in place.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> 
> Conflicts:
> 	include/linux/acpi.h
> ---
>  drivers/acpi/gsi.c   | 32 +++++++++++++++++++++++++++-----
>  include/linux/acpi.h |  3 +++
>  2 files changed, 30 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/acpi/gsi.c b/drivers/acpi/gsi.c
> index 2c39fe1..202a8fe 100644
> --- a/drivers/acpi/gsi.c
> +++ b/drivers/acpi/gsi.c
> @@ -75,12 +75,21 @@ int acpi_register_gsi(struct device *dev, u32 gsi, int trigger,
>  {
>  	unsigned int irq;
>  	unsigned int irq_type = acpi_gsi_get_irq_type(trigger, polarity);
> -	struct irq_domain *d = irq_find_matching_fwnode(acpi_gsi_domain_id,
> -							DOMAIN_BUS_ANY);
>  
> -	irq = irq_create_mapping(d, gsi);
> -	if (!irq)
> -		return -EINVAL;
> +	if (acpi_gsi_domain_id) {
> +		struct irq_fwspec fwspec;
> +
> +		fwspec.fwnode = acpi_gsi_domain_id;
> +		fwspec.param[0] = gsi;
> +		fwspec.param[1] = irq_type;
> +		fwspec.param_count = 2;
> +
> +		return irq_create_fwspec_mapping(&fwspec);
> +	} else {
> +		irq = irq_create_mapping(NULL, gsi);
> +		if (!irq)
> +			return -EINVAL;
> +	}
>  
>  	/* Set irq type if specified and different than the current one */
>  	if (irq_type != IRQ_TYPE_NONE &&
> @@ -103,3 +112,16 @@ void acpi_unregister_gsi(u32 gsi)
>  	irq_dispose_mapping(irq);
>  }
>  EXPORT_SYMBOL_GPL(acpi_unregister_gsi);
> +
> +/**
> + * acpi_set_irq_model - Setup the GSI irqdomain information
> + * @model: the value assigned to acpi_irq_model
> + * @fwnode: the irq_domain identifier for mapping and looking up
> + *          GSI interrupts
> + */
> +void __init acpi_set_irq_model(enum acpi_irq_model_id model,
> +			       struct fwnode_handle *fwnode)
> +{
> +	acpi_irq_model = model;
> +	acpi_gsi_domain_id = fwnode;
> +}
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 43856d1..d863e12 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -201,6 +201,9 @@ int acpi_register_gsi (struct device *dev, u32 gsi, int triggering, int polarity
>  int acpi_gsi_to_irq (u32 gsi, unsigned int *irq);
>  int acpi_isa_irq_to_gsi (unsigned isa_irq, u32 *gsi);
>  
> +void acpi_set_irq_model(enum acpi_irq_model_id model,
> +			struct fwnode_handle *fwnode);
> +
>  #ifdef CONFIG_X86_IO_APIC
>  extern int acpi_get_override_irq(u32 gsi, int *trigger, int *polarity);
>  #else
> 

