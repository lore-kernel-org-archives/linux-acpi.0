From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v2 3/3] ACPI / ARM64 : use the new BAD_MADT_GICC_ENTRY
 macro
Date: Fri, 19 Jun 2015 18:52:12 +0800
Message-ID: <5583F45C.2070708@linaro.org>
References: <1434666968-1543-1-git-send-email-al.stone@linaro.org> <1434666968-1543-4-git-send-email-al.stone@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34340 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751363AbbFSKwV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Jun 2015 06:52:21 -0400
Received: by pabvl15 with SMTP id vl15so36896737pab.1
        for <linux-acpi@vger.kernel.org>; Fri, 19 Jun 2015 03:52:20 -0700 (PDT)
In-Reply-To: <1434666968-1543-4-git-send-email-al.stone@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Al Stone <al.stone@linaro.org>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: rjw@rjwysocki.net, lenb@kernel.org, catalin.marinas@arm.com, will.deacon@arm.com, tglx@linutronix.de, jason@lakedaemon.net, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, linaro-kernel@lists.linaro.org, patches@linaro.org

On 06/19/2015 06:36 AM, Al Stone wrote:
> For those parts of the arm64 ACPI code that need to check GICC subtables
> in the MADT, use the new BAD_MADT_GICC_ENTRY macro instead of the previous
> BAD_MADT_ENTRY.  The new macro takes into account differences in the size
> of the GICC subtable that the old macro did not; this caused failures even
> though the subtable entries are valid.
>
> Signed-off-by: Al Stone <al.stone@linaro.org>
> ---
>   arch/arm64/kernel/smp.c   | 2 +-
>   drivers/irqchip/irq-gic.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 4b2121b..80d5984 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -438,7 +438,7 @@ acpi_parse_gic_cpu_interface(struct acpi_subtable_header *header,
>   	struct acpi_madt_generic_interrupt *processor;
>
>   	processor = (struct acpi_madt_generic_interrupt *)header;
> -	if (BAD_MADT_ENTRY(processor, end))
> +	if (BAD_MADT_GICC_ENTRY(processor, end))
>   		return -EINVAL;
>
>   	acpi_table_print_madt_entry(header);
> diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
> index 8d7e1c8..4dd8826 100644
> --- a/drivers/irqchip/irq-gic.c
> +++ b/drivers/irqchip/irq-gic.c
> @@ -1055,7 +1055,7 @@ gic_acpi_parse_madt_cpu(struct acpi_subtable_header *header,
>
>   	processor = (struct acpi_madt_generic_interrupt *)header;
>
> -	if (BAD_MADT_ENTRY(processor, end))
> +	if (BAD_MADT_GICC_ENTRY(processor, end))
>   		return -EINVAL;

Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
