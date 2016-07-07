From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 08/11] arm64: pmu: Provide cpumask attribute for PMU
Date: Thu, 7 Jul 2016 17:21:04 +0100
Message-ID: <20160707162103.GD9270@leverpostej>
References: <1466529109-21715-1-git-send-email-jeremy.linton@arm.com>
 <1466529109-21715-9-git-send-email-jeremy.linton@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:37598 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751035AbcGGQVU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 7 Jul 2016 12:21:20 -0400
Content-Disposition: inline
In-Reply-To: <1466529109-21715-9-git-send-email-jeremy.linton@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, will.deacon@arm.com, catalin.marinas@arm.com, Lorenzo.Pieralisi@arm.com, alexander.shishkin@linux.intel.com, acme@kernel.org, mingo@redhat.com, peterz@infradead.org, mlangsdorf@redhat.com, punit.agrawal@arm.com, Steve.Capper@arm.com

Hi Jeremy,

Apologies for the late reply on this.

On Tue, Jun 21, 2016 at 12:11:46PM -0500, Jeremy Linton wrote:
> With heterogeneous PMUs its helpful to know which PMUs are bound
> to each CPU. Provide that information with a cpumask sysfs entry
> similar to other PMUs.

Have you tested trying to stat on a particular PMU? e.g.

$ perf stat -e armv8_cortex_a53/cpu_cycles/ ls

I found that the presence of a cpumask file would cause (at least some
versions) of perf-stat to hang, and was holding off adding a cpumask
until we had a solution to that.

See [1,2] for more details on that.

> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  arch/arm64/kernel/perf_event.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)

This should be generic across the arm-pmu code, and so should live under
drivers/perf/.

Thanks,
Mark.

[1] http://lkml.kernel.org/r/1467907474-3290-1-git-send-email-mark.rutland@arm.com
[2] http://lkml.kernel.org/r/1467907474-3290-2-git-send-email-mark.rutland@arm.com

> diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
> index 356fa6c..dae73ea 100644
> --- a/arch/arm64/kernel/perf_event.c
> +++ b/arch/arm64/kernel/perf_event.c
> @@ -533,6 +533,26 @@ static struct attribute_group armv8_pmuv3_events_attr_group = {
>  
>  PMU_FORMAT_ATTR(event, "config:0-9");
>  
> +static ssize_t
> +cpumask_show(struct device *dev, struct device_attribute *attr, char *page)
> +{
> +	struct pmu *pmu = dev_get_drvdata(dev);
> +	struct arm_pmu *cpu_pmu = container_of(pmu, struct arm_pmu, pmu);
> +
> +	return cpumap_print_to_pagebuf(true, page, &cpu_pmu->supported_cpus);
> +}
> +static DEVICE_ATTR_RO(cpumask);
> +
> +static struct attribute *armv8_pmuv3_attrs[] = {
> +	 &dev_attr_cpumask.attr,
> +	 NULL,
> +};
> +
> +static struct attribute_group armv8_pmuv3_attr_group = {
> +	.attrs = armv8_pmuv3_attrs,
> +};
> +
> +
>  static struct attribute *armv8_pmuv3_format_attrs[] = {
>  	&format_attr_event.attr,
>  	NULL,
> @@ -544,6 +564,7 @@ static struct attribute_group armv8_pmuv3_format_attr_group = {
>  };
>  
>  static const struct attribute_group *armv8_pmuv3_attr_groups[] = {
> +	&armv8_pmuv3_attr_group,
>  	&armv8_pmuv3_events_attr_group,
>  	&armv8_pmuv3_format_attr_group,
>  	NULL,
> -- 
> 2.5.5
> 
