From: Punit Agrawal <punit.agrawal@arm.com>
Subject: Re: [PATCH v7 1/9] arm64: pmu: add fallback probe table
Date: Fri, 26 Aug 2016 15:34:05 +0100
Message-ID: <87r39boazm.fsf@e105922-lin.cambridge.arm.com>
References: <1471985280-2243-1-git-send-email-jeremy.linton@arm.com>
        <1471985280-2243-2-git-send-email-jeremy.linton@arm.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.140]:58737 "EHLO
        cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750979AbcHZOfB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 26 Aug 2016 10:35:01 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com, will.deacon@arm.com, linux-acpi@vger.kernel.org, mlangsdorf@redhat.com, steve.capper@arm.com

Hi Jeremy,

One comment below.

Jeremy Linton <jeremy.linton@arm.com> writes:

> From: Mark Salter <msalter@redhat.com>
>
> In preparation for ACPI support, add a pmu_probe_info table to
> the arm_pmu_device_probe() call. This table gets used when
> probing in the absence of a devicetree node for PMU.
>
> Signed-off-by: Mark Salter <msalter@redhat.com>
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---

[...]


> diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
> index e188438..65d8e27 100644
> --- a/include/linux/perf/arm_pmu.h
> +++ b/include/linux/perf/arm_pmu.h
> @@ -147,6 +147,9 @@ struct pmu_probe_info {
>  #define XSCALE_PMU_PROBE(_version, _fn) \
>  	PMU_PROBE(ARM_CPU_IMP_INTEL << 24 | _version, ARM_PMU_XSCALE_MASK, _fn)
>  
> +#define ARMV8_PMU_PART_PROBE(_part, _fn) \
> +	PMU_PROBE((_part) << MIDR_PARTNUM_SHIFT, MIDR_PARTNUM_MASK, _fn)
> +

This hunk could be dropped as it doesn't seem to be used in the
patchset.

With the above change -

FWIW,
        Acked-by: Punit Agrawal <punit.agrawal@arm.com>


>  int arm_pmu_device_probe(struct platform_device *pdev,
>  			 const struct of_device_id *of_table,
>  			 const struct pmu_probe_info *probe_table);
