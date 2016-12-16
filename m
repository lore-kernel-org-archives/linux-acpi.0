From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH V9 1/3] ACPI: Generic GSI: Do not attempt to map non-GSI
 IRQs during bus scan
Date: Fri, 16 Dec 2016 16:24:39 +0000
Message-ID: <20161216162439.GA24673@red-moon>
References: <1481753438-3905-1-git-send-email-agustinv@codeaurora.org>
 <1481753438-3905-2-git-send-email-agustinv@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:56370 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1761905AbcLPQXR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 16 Dec 2016 11:23:17 -0500
Content-Disposition: inline
In-Reply-To: <1481753438-3905-2-git-send-email-agustinv@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Agustin Vega-Frias <agustinv@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rjw@rjwysocki.net, lenb@kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, timur@codeaurora.org, cov@codeaurora.org, agross@codeaurora.org, harba@codeaurora.org, jcm@redhat.com, msalter@redhat.com, mlangsdo@redhat.com, ahs3@redhat.com, astone@redhat.com, graeme.gregory@linaro.org, guohanjun@huawei.com, charles.garcia-tobin@arm.com

On Wed, Dec 14, 2016 at 05:10:36PM -0500, Agustin Vega-Frias wrote:
> ACPI extended IRQ resources may contain a Resource Source field to specify
> an alternate interrupt controller, attempting to map them as GSIs is
> incorrect, so just disable the platform resource.
> 
> Since this field is currently ignored, we make this change conditional
> on CONFIG_ACPI_GENERIC_GSI to keep the current behavior on x86 platforms,
> in case some existing ACPI tables are using this incorrectly.
> 
> Signed-off-by: Agustin Vega-Frias <agustinv@codeaurora.org>
> ---
>  drivers/acpi/resource.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index 56241eb..76ca4e9 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -43,6 +43,18 @@ static inline bool acpi_iospace_resource_valid(struct resource *res)
>  acpi_iospace_resource_valid(struct resource *res) { return true; }
>  #endif
>  
> +#ifdef CONFIG_ACPI_GENERIC_GSI
> +static inline bool is_gsi(struct acpi_resource_extended_irq *ext_irq)
> +{
> +	return ext_irq->resource_source.string_length == 0;
> +}
> +#else
> +static inline bool is_gsi(struct acpi_resource_extended_irq *ext_irq)
> +{
> +	return true;
> +}
> +#endif

Well, patch is simple there is not much to say other that on the
firmware side I honestly do not see many options, either we remove the
ifdeffery above and make the check unconditional (ie we do check on
x86/ia64 too instead of always returning true) and see if things hold up
on x86 (at least we try) or we will never know and will never be able to
use this on x86 if there will ever be need.

It would be certainly weird to find out that a descriptor has a
resource_source pointer put there by mistake (because that's what we are
talking about, things work on x86/ia64 by ignoring the resource_source
pointer so any string there is just an unfortunate mistake AFAICS).

I am quite tempted to remove the ifdef and make the is_gsi() check effective on
x86/ia64 too.

Lorenzo

> +
>  static bool acpi_dev_resource_len_valid(u64 start, u64 end, u64 len, bool io)
>  {
>  	u64 reslen = end - start + 1;
> @@ -470,9 +482,12 @@ bool acpi_dev_resource_interrupt(struct acpi_resource *ares, int index,
>  			acpi_dev_irqresource_disabled(res, 0);
>  			return false;
>  		}
> -		acpi_dev_get_irqresource(res, ext_irq->interrupts[index],
> +		if (is_gsi(ext_irq))
> +			acpi_dev_get_irqresource(res, ext_irq->interrupts[index],
>  					 ext_irq->triggering, ext_irq->polarity,
>  					 ext_irq->sharable, false);
> +		else
> +			acpi_dev_irqresource_disabled(res, 0);
>  		break;
>  	default:
>  		res->flags = 0;
> -- 
> Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm Technologies, Inc.
> Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
> 
