From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [RFC] Fix shared irq trigger-flags conflict when old irqaction
 uses IRQF_TRIGGER_NONE
Date: Mon, 10 Apr 2017 11:13:14 +0100
Message-ID: <8e5511ce-601b-bde9-cdd3-c901ffc3d53d@arm.com>
References: <20170409195918.20864-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:45718 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752475AbdDJKNR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 10 Apr 2017 06:13:17 -0400
In-Reply-To: <20170409195918.20864-1-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-acpi@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org

Hi Hans,

On 09/04/17 20:59, Hans de Goede wrote:
> While writing a driver for the INT0002 ACPI device found on Intel
> Bay and Cherry Trail devices I hit the following error:
> 
> "genirq: Flags mismatch irq 9. 00000084 (INT0002) vs. 00000080 (acpi)"
> 
> This is caused by drivers/acpi/osl.c first doing:
> 
> request_irq(irq, acpi_irq, IRQF_SHARED, "acpi", acpi_irq)
> 
> While the irqdata for the irq contains no trigger flags, resulting
> in an irqaction with IRQF_TRIGGER_NONE.
> 
> And then the INT0002 driver I'm working on calling platform_get_irq
> which does: irqd_set_trigger_type(irqd, r->flags & IORESOURCE_BITS);
> 
> And then request_irq(irq, ..., IRQF_SHARED, ...) on the irq returned
> by platform_get_irq causes the error quoted above.
> 
> Arguably the genirq code should not hit the shared irq trigger-flags
> mismatch code if the old irqaction has IRQF_TRIGGER_NONE as flags.
> 
> This patch is an attempt at fixing this, but I'm not sure it is the
> right fix, hence it RFC status.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  kernel/irq/manage.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> index a4afe5c..24e5eef 100644
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -1212,8 +1212,13 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
>  		 * set the trigger type must match. Also all must
>  		 * agree on ONESHOT.
>  		 */
> +		unsigned int old_msk = old->flags & IRQF_TRIGGER_MASK;
> +
> +		if (!old_msk)
> +			old_msk = irqd_get_trigger_type(&desc->irq_data);
> +
>  		if (!((old->flags & new->flags) & IRQF_SHARED) ||
> -		    ((old->flags ^ new->flags) & IRQF_TRIGGER_MASK) ||
> +		    ((old_msk ^ new->flags) & IRQF_TRIGGER_MASK) ||
>  		    ((old->flags ^ new->flags) & IRQF_ONESHOT))
>  			goto mismatch;
>  
> 

I'm afraid you're just papering over the issue here, as you leave the
"old" descriptor in an inconsistent state w.r.t. the "new" descriptor.

My view is that the old irq_desc should be "upgraded" to the new trigger
configuration, because they are sharing a line and must have compatible
behaviours. NONE is effectively a wildcard, and the second interrupt
request should turn this wildcard into the real thing.

The opposite case also exists (request a LEVEL interrupt first, then a
NONE), and should be resolved the same way (NONE becomes LEVEL).

Thoughts?

	M.
-- 
Jazz is not dead. It just smells funny...
