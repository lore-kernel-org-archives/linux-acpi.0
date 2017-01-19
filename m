From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v13 1/7] arm64: Rename the common MADT parse routine
Date: Thu, 19 Jan 2017 11:51:28 +0800
Message-ID: <c9056b99-7a32-3c91-eb8a-5b44a182c140@linaro.org>
References: <1484686210-7211-1-git-send-email-jeremy.linton@arm.com>
 <1484686210-7211-2-git-send-email-jeremy.linton@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:36411 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751656AbdASD7i (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Jan 2017 22:59:38 -0500
Received: by mail-pf0-f179.google.com with SMTP id 189so9722055pfu.3
        for <linux-acpi@vger.kernel.org>; Wed, 18 Jan 2017 19:59:20 -0800 (PST)
In-Reply-To: <1484686210-7211-2-git-send-email-jeremy.linton@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jeremy Linton <jeremy.linton@arm.com>, linux-arm-kernel@lists.infradead.org
Cc: mark.rutland@arm.com, lorenzo.pieralisi@arm.com, steve.capper@arm.com, mlangsdorf@redhat.com, punit.agrawal@arm.com, will.deacon@arm.com, linux@armlinux.org.uk, linux-acpi@vger.kernel.org, msalter@redhat.com, bamvor.zhangjian@linaro.org

Hi Jeremy,

On 2017/1/18 4:50, Jeremy Linton wrote:
> The MADT parser in smp.c is now being used to parse
> out NUMA, PMU and ACPI parking protocol information as
> well as the GIC information for which it was originally
> created. Rename it to avoid a misleading name.
>
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  arch/arm64/kernel/smp.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index cb87234..8ea244c 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -517,13 +517,14 @@ static unsigned int cpu_count = 1;
>
>  #ifdef CONFIG_ACPI
>  /*
> - * acpi_map_gic_cpu_interface - parse processor MADT entry
> + * acpi_verify_and_map_madt - parse processor MADT entry
>   *
>   * Carry out sanity checks on MADT processor entry and initialize
> - * cpu_logical_map on success
> + * cpu_logical_map, the ACPI parking protocol, NUMA mapping
> + * and the PMU interrupts on success
>   */
>  static void __init
> -acpi_map_gic_cpu_interface(struct acpi_madt_generic_interrupt *processor)
> +acpi_verify_and_map_madt(struct acpi_madt_generic_interrupt *processor)

Nit, MADT is a table includes multi type of table entries, we just
need to map the the processor type, how about updating it to
acpi_verify_and_map_madt_processor()?

Thanks
Hanjun
