From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH] acpi: fix generic acpi_register_gsi() handling of shared
 interrupts
Date: Tue, 28 Apr 2015 18:08:44 +0100
Message-ID: <553FBE9C.5070408@arm.com>
References: <1430239874-15928-1-git-send-email-msalter@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:59709 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030398AbbD1RIs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 28 Apr 2015 13:08:48 -0400
In-Reply-To: <1430239874-15928-1-git-send-email-msalter@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Salter <msalter@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Will Deacon <Will.Deacon@arm.com>

On 28/04/15 17:51, Mark Salter wrote:
> If there are devices sharing an interrupt, acpi_register_gsi() could
> be called multiple times for the same gsi. Currently, it just maps
> the gsi without checking for a previous mapping. This patch adds a
> check for an existing mapping and uses that if found.
> 
> Cc: Hanjun Guo <hanjun.guo@linaro.org>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Mark Salter <msalter@redhat.com>
> ---
>  drivers/acpi/gsi.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/acpi/gsi.c b/drivers/acpi/gsi.c
> index 38208f2..5698c4f 100644
> --- a/drivers/acpi/gsi.c
> +++ b/drivers/acpi/gsi.c
> @@ -76,6 +76,13 @@ int acpi_register_gsi(struct device *dev, u32 gsi, int trigger,
>  	unsigned int irq_type = acpi_gsi_get_irq_type(trigger, polarity);
>  
>  	/*
> +	 * The gsi may be shared with other devices, so check for a
> +	 * previous mapping and use that if found.
> +	 */
> +	if (acpi_gsi_to_irq(gsi, &irq) > 0)
> +		return irq;

I'm afraid that's completely racy, and doesn't prevent much (two CPUs
can execute this at the same time and still end up executing the rest of
the code).

Furthermore, irq_create_mapping is *designed* to handle that situation,
and returns the same virtual IRQ for a given hwirq (and it has the
proper locking...).

So maybe it would be worth explaining the actual problem you're seeing,
because the code as it stands should handle the problem you seem to
describe.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
