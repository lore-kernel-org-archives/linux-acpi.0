From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v8 8/9] arm64: pmu: Detect and enable multiple PMUs in an
 ACPI system
Date: Fri, 9 Sep 2016 18:26:09 +0100
Message-ID: <20160909172609.GD11418@arm.com>
References: <1472507300-9844-1-git-send-email-jeremy.linton@arm.com>
 <1472507300-9844-9-git-send-email-jeremy.linton@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:50084 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751987AbcIIR0L (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 9 Sep 2016 13:26:11 -0400
Content-Disposition: inline
In-Reply-To: <1472507300-9844-9-git-send-email-jeremy.linton@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com, punit.agrawal@arm.com, linux-acpi@vger.kernel.org, mlangsdorf@redhat.com, steve.capper@arm.com

On Mon, Aug 29, 2016 at 04:48:19PM -0500, Jeremy Linton wrote:
> +/* Count number and type of CPU cores in the system. */
> +static void __init arm_pmu_acpi_determine_cpu_types(struct list_head *pmus)
> +{
> +	int i;
> +	bool alloc_failure = false;
> +
> +	for_each_possible_cpu(i) {
> +		struct cpuinfo_arm64 *cinfo = per_cpu_ptr(&cpu_data, i);
> +		u32 partnum = MIDR_PARTNUM(cinfo->reg_midr);
> +		struct pmu_types *pmu;
> +
> +		list_for_each_entry(pmu, pmus, list) {
> +			if (pmu->cpu_type == partnum) {
> +				pmu->cpu_count++;
> +				break;
> +			}
> +		}
> +
> +		/* we didn't find the CPU type, add an entry to identify it */
> +		if ((&pmu->list == pmus) && (!alloc_failure)) {
> +			pmu = kzalloc(sizeof(struct pmu_types), GFP_KERNEL);
> +			if (!pmu) {
> +				pr_warn("Unable to allocate pmu_types\n");
> +				/*
> +				 * continue to count cpus for any pmu_types
> +				 * already allocated, but don't allocate any
> +				 * more pmu_types. This avoids undercounting.
> +				 */
> +				alloc_failure = true;

I thought we were ripping this out?

Will
