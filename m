From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v2 3/3] ACPI / ARM64 : use the new BAD_MADT_GICC_ENTRY
 macro
Date: Fri, 19 Jun 2015 10:46:58 +0100
Message-ID: <20150619094658.GB18017@arm.com>
References: <1434666968-1543-1-git-send-email-al.stone@linaro.org>
 <1434666968-1543-4-git-send-email-al.stone@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:44406 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753246AbbFSJrC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 19 Jun 2015 05:47:02 -0400
Content-Disposition: inline
In-Reply-To: <1434666968-1543-4-git-send-email-al.stone@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Al Stone <al.stone@linaro.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "lenb@kernel.org" <lenb@kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "jason@lakedaemon.net" <jason@lakedaemon.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "patches@linaro.org" <patches@linaro.org>

On Thu, Jun 18, 2015 at 11:36:08PM +0100, Al Stone wrote:
> For those parts of the arm64 ACPI code that need to check GICC subtables
> in the MADT, use the new BAD_MADT_GICC_ENTRY macro instead of the previous
> BAD_MADT_ENTRY.  The new macro takes into account differences in the size
> of the GICC subtable that the old macro did not; this caused failures even
> though the subtable entries are valid.
> 
> Signed-off-by: Al Stone <al.stone@linaro.org>
> ---
>  arch/arm64/kernel/smp.c   | 2 +-
>  drivers/irqchip/irq-gic.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Acked-by: Will Deacon <will.deacon@arm.com>

Good to see this stuff is holding up so well...

Will

> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 4b2121b..80d5984 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -438,7 +438,7 @@ acpi_parse_gic_cpu_interface(struct acpi_subtable_header *header,
>  	struct acpi_madt_generic_interrupt *processor;
>  
>  	processor = (struct acpi_madt_generic_interrupt *)header;
> -	if (BAD_MADT_ENTRY(processor, end))
> +	if (BAD_MADT_GICC_ENTRY(processor, end))
>  		return -EINVAL;
>  
>  	acpi_table_print_madt_entry(header);
> diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
> index 8d7e1c8..4dd8826 100644
> --- a/drivers/irqchip/irq-gic.c
> +++ b/drivers/irqchip/irq-gic.c
> @@ -1055,7 +1055,7 @@ gic_acpi_parse_madt_cpu(struct acpi_subtable_header *header,
>  
>  	processor = (struct acpi_madt_generic_interrupt *)header;
>  
> -	if (BAD_MADT_ENTRY(processor, end))
> +	if (BAD_MADT_GICC_ENTRY(processor, end))
>  		return -EINVAL;
>  
>  	/*
> -- 
> 2.4.0
> 
