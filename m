From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 09/16] acpi/gsi: Always perform an irq domain lookup
Date: Mon, 12 Oct 2015 22:34:26 +0200
Message-ID: <2238247.YpCRlzfP9y@vostro.rjw.lan>
References: <1444152989-31726-1-git-send-email-marc.zyngier@arm.com> <1444152989-31726-10-git-send-email-marc.zyngier@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:57981 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751694AbbJLUFr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 12 Oct 2015 16:05:47 -0400
In-Reply-To: <1444152989-31726-10-git-send-email-marc.zyngier@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jiang Liu <jiang.liu@linux.intel.com>, Jason Cooper <jason@lakedaemon.net>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Hanjun Guo <hanjun.guo@linaro.org>, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, Graeme Gregory <graeme@xora.org.uk>, Jake Oshins <jakeo@microsoft.com>

On Tuesday, October 06, 2015 06:36:22 PM Marc Zyngier wrote:
> Instead of directly passing NULL to the various irq_domain functions,
> start by looking up the domain with a domain identifier..
> 
> As this identifier is permanently set to NULL, the lookup function will
> return the same value (no domain found) and the default will be used,
> preserving the current behaviour.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/acpi/gsi.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/acpi/gsi.c b/drivers/acpi/gsi.c
> index 38208f2..2c39fe1 100644
> --- a/drivers/acpi/gsi.c
> +++ b/drivers/acpi/gsi.c
> @@ -11,9 +11,12 @@
>  #include <linux/acpi.h>
>  #include <linux/irq.h>
>  #include <linux/irqdomain.h>
> +#include <linux/of.h>
>  
>  enum acpi_irq_model_id acpi_irq_model;
>  
> +static struct fwnode_handle *acpi_gsi_domain_id;
> +
>  static unsigned int acpi_gsi_get_irq_type(int trigger, int polarity)
>  {
>  	switch (polarity) {
> @@ -45,12 +48,10 @@ static unsigned int acpi_gsi_get_irq_type(int trigger, int polarity)
>   */
>  int acpi_gsi_to_irq(u32 gsi, unsigned int *irq)
>  {
> -	/*
> -	 * Only default domain is supported at present, always find
> -	 * the mapping corresponding to default domain by passing NULL
> -	 * as irq_domain parameter
> -	 */
> -	*irq = irq_find_mapping(NULL, gsi);
> +	struct irq_domain *d = irq_find_matching_fwnode(acpi_gsi_domain_id,
> +							DOMAIN_BUS_ANY);
> +
> +	*irq = irq_find_mapping(d, gsi);
>  	/*
>  	 * *irq == 0 means no mapping, that should
>  	 * be reported as a failure
> @@ -74,13 +75,10 @@ int acpi_register_gsi(struct device *dev, u32 gsi, int trigger,
>  {
>  	unsigned int irq;
>  	unsigned int irq_type = acpi_gsi_get_irq_type(trigger, polarity);
> +	struct irq_domain *d = irq_find_matching_fwnode(acpi_gsi_domain_id,
> +							DOMAIN_BUS_ANY);
>  
> -	/*
> -	 * There is no way at present to look-up the IRQ domain on ACPI,
> -	 * hence always create mapping referring to the default domain
> -	 * by passing NULL as irq_domain parameter
> -	 */
> -	irq = irq_create_mapping(NULL, gsi);
> +	irq = irq_create_mapping(d, gsi);
>  	if (!irq)
>  		return -EINVAL;
>  
> @@ -98,7 +96,9 @@ EXPORT_SYMBOL_GPL(acpi_register_gsi);
>   */
>  void acpi_unregister_gsi(u32 gsi)
>  {
> -	int irq = irq_find_mapping(NULL, gsi);
> +	struct irq_domain *d = irq_find_matching_fwnode(acpi_gsi_domain_id,
> +							DOMAIN_BUS_ANY);
> +	int irq = irq_find_mapping(d, gsi);
>  
>  	irq_dispose_mapping(irq);
>  }
> 

