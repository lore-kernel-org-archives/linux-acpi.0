From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [RFC] ACPI / Processor: add sysfs support for low power idle
Date: Wed, 19 Apr 2017 16:37:42 +0100
Message-ID: <2e633ef7-5155-7eb7-0f1b-8bc36bd25da7@arm.com>
References: <1490832795-27441-1-git-send-email-pprakash@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:42748 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937545AbdDSPhq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 19 Apr 2017 11:37:46 -0400
In-Reply-To: <1490832795-27441-1-git-send-email-pprakash@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Prashanth Prakash <pprakash@codeaurora.org>, linux-acpi@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, rjw@rjwysocki.net, lenb@kernel.org, al.stone@linaro.org



On 30/03/17 01:13, Prashanth Prakash wrote:
> Add support to expose idle statistics maintained by platform to
> userspace via sysfs in addition to other data of interest from
> each LPI(Low Power Idle) state.
> 

While I understand this information is useful for some optimization
and also for idle characterization with different workloads, I prefer
to keep this in debugfs for:

1. We already have CPUIdle stats, this information may be more accurate
   which is good for above reasons but user-space applications shouldn't
   depend on it and end-up misusing it.
2. Also as more features get pushed into hardware, even these stats may
   not remain so much accurate as it is today and hence it would be
   better if user-space applications never use/depend on them.

Let me know if there are conflicting reasons ?

> LPI described in section 8.4.4 of ACPI spec 6.1 provides different
> methods to obtain idle statistics maintained by the platform. These
> show a granular view of how each of the LPI state is being used at
> different level of hierarchy. sysfs data is exposed at each level in
> the hierarchy by creating a directory named 'lpi' at each level and
> the LPI state information is presented under it. Below is the
> representation of LPI information at one such level in the hierarchy
> 
> .../ACPI00XX: XX/lpi
> 	|-> summary_stats

Not sure if it's any useful, see below.

> 	|-> state0
> 	|	|-> desc
> 	|	|-> time
> 	|	|-> usage
> 	|	|-> latency
> 	|	|-> min_residency

The flags/arch_flags are meaning less if they are exposed as it. I would
rather drop them.

> 	|	|-> flags
> 	|	|-> arch_flags
> 	|
> 	<<more states>>
> 
> ACPI00XX can be ACPI0007(processor) or ACPI0010(processor container)
> 
> stateX contains information related to a specific LPI state defined
> in the LPI ACPI tables.
> 
> summary_stats shows the stats(usage and time) from all the LPI states
> under a device. The summary_stats are provided to reduce the number'
> of files to be accessed by the userspace to capture a snapshot of the'
> idle statistics.

Really ? What's the need to reduce the no. of file accesses ?

> 
> Signed-off-by: Prashanth Prakash <pprakash@codeaurora.org>
> ---
>  drivers/acpi/acpi_processor.c |  11 ++
>  drivers/acpi/processor_idle.c | 345 +++++++++++++++++++++++++++++++++++++++++-
>  include/acpi/processor.h      |  27 ++++
>  3 files changed, 381 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
> index 0143135..a01368d 100644
> --- a/drivers/acpi/acpi_processor.c
> +++ b/drivers/acpi/acpi_processor.c
> @@ -570,9 +570,19 @@ void __init acpi_early_processor_osc(void)
>  static int acpi_processor_container_attach(struct acpi_device *dev,
>  					   const struct acpi_device_id *id)
>  {
> +	if (dev->status.present && dev->status.functional &&
> +		dev->status.enabled && dev->status.show_in_ui)
> +		acpi_lpi_sysfs_init(dev->handle,
> +				(struct acpi_lpi_sysfs_data **)&dev->driver_data);

Why not register it only if LPIs are detected/initialized as active ?

[...]

> +
> +
> +/*
> + * LPI sysfs support
> + * Exports two APIs that can be called as part of init and exit to setup the LPI
> + * sysfs entries either from processor or processor_container driver
> + */
> +

[...]

Lot of this sysfs handling looks similar to what we already have for
cpuidle. I don't have a quick solution to avoid duplication but Greg
really hate dealing with kobjects/ksets. I need to think if there's any
better way to do this. Sorry for just raising issue without solution.


> +int acpi_lpi_sysfs_init(acpi_handle h,
> +			struct acpi_lpi_sysfs_data **lpi_sysfs_data)
> +{
> +	struct acpi_device *d;
> +	struct acpi_lpi_states_array info;
> +	struct acpi_lpi_sysfs_state *sysfs_state = NULL;
> +	struct acpi_lpi_sysfs_data *data = NULL;
> +	int ret, i;
> +
> +	if (!lpi_sysfs_data)
> +		return -EINVAL;
> +
> +	ret = acpi_bus_get_device(h, &d);
> +	if (ret)
> +		return ret;
> +
> +	ret = acpi_processor_evaluate_lpi(h, &info);

Why do we need to reevaluate _LPI here ?

-- 
Regards,
Sudeep
