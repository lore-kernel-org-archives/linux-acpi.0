From: "Prakash, Prashanth" <pprakash@codeaurora.org>
Subject: Re: [RFC] ACPI / Processor: add sysfs support for low power idle
Date: Wed, 19 Apr 2017 16:57:35 -0600
Message-ID: <37544927-1f7d-ab59-63d5-32ac1d777bb6@codeaurora.org>
References: <1490832795-27441-1-git-send-email-pprakash@codeaurora.org>
 <2e633ef7-5155-7eb7-0f1b-8bc36bd25da7@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:60820 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937565AbdDSW5i (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 19 Apr 2017 18:57:38 -0400
In-Reply-To: <2e633ef7-5155-7eb7-0f1b-8bc36bd25da7@arm.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>, linux-acpi@vger.kernel.org
Cc: rjw@rjwysocki.net, lenb@kernel.org, al.stone@linaro.org

Hi Sudeep,

On 4/19/2017 9:37 AM, Sudeep Holla wrote:
> On 30/03/17 01:13, Prashanth Prakash wrote:
>> Add support to expose idle statistics maintained by platform to
>> userspace via sysfs in addition to other data of interest from
>> each LPI(Low Power Idle) state.
>>
> While I understand this information is useful for some optimization
> and also for idle characterization with different workloads, I prefer
> to keep this in debugfs for:
>
> 1. We already have CPUIdle stats, this information may be more accurate
>    which is good for above reasons but user-space applications shouldn't
>    depend on it and end-up misusing it.
> 2. Also as more features get pushed into hardware, even these stats may
>    not remain so much accurate as it is today and hence it would be
>    better if user-space applications never use/depend on them.
>
> Let me know if there are conflicting reasons ?
The information about idle state of shared resources(Cache, interconnect ...)
which cannot be deduced from the cpuidle stats is quite useful. We can use this
to analyze newer workloads and to explain their power consumption, especially as
the amount of time some of these shared resources spends in different LPI states
can be influenced by changes to workload, kernel or firmware. And for auto
promote-able states this is the only way to capture idle stats.

Regarding 2, since these stats are clearly defined by ACPI spec and maintained by
platform, I think it is reasonable to expect them to be accurate. If it is not accurate,
it is likely that platform is breaking the spec.

Given above, I don't see much room for user-space applications to misuse this.
Given these are defined as optional in spec, user-space application should use
only if/when available and use it as complementary to cpuidle stats.

Sounds reasonable?

>> LPI described in section 8.4.4 of ACPI spec 6.1 provides different
>> methods to obtain idle statistics maintained by the platform. These
>> show a granular view of how each of the LPI state is being used at
>> different level of hierarchy. sysfs data is exposed at each level in
>> the hierarchy by creating a directory named 'lpi' at each level and
>> the LPI state information is presented under it. Below is the
>> representation of LPI information at one such level in the hierarchy
>>
>> .../ACPI00XX: XX/lpi
>> 	|-> summary_stats
> Not sure if it's any useful, see below.
>
>> 	|-> state0
>> 	|	|-> desc
>> 	|	|-> time
>> 	|	|-> usage
>> 	|	|-> latency
>> 	|	|-> min_residency
> The flags/arch_flags are meaning less if they are exposed as it. I would
> rather drop them.
Agree on arch_flags, will remove it.

We do decode the flags -  Enabled/Disabled.  I will make changes to populate sysfs
only for enabled states and get rid of flags as well.
>
>> 	|	|-> flags
>> 	|	|-> arch_flags
>> 	|
>> 	<<more states>>
>>
>> ACPI00XX can be ACPI0007(processor) or ACPI0010(processor container)
>>
>> stateX contains information related to a specific LPI state defined
>> in the LPI ACPI tables.
>>
>> summary_stats shows the stats(usage and time) from all the LPI states
>> under a device. The summary_stats are provided to reduce the number'
>> of files to be accessed by the userspace to capture a snapshot of the'
>> idle statistics.
> Really ? What's the need to reduce the no. of file accesses ?
When we have a large number of cores, with multiple idle state + few auto-promotable
states. The amount of files we need to access to get a snapshot before/after a running
a workload is quite high.

It gets worse if we want to keep the file handles open to sample it little more frequently,
to get breakdown of idle state distribution during different phases of a workload.
>> Signed-off-by: Prashanth Prakash <pprakash@codeaurora.org>
>> ---
>>  drivers/acpi/acpi_processor.c |  11 ++
>>  drivers/acpi/processor_idle.c | 345 +++++++++++++++++++++++++++++++++++++++++-
>>  include/acpi/processor.h      |  27 ++++
>>  3 files changed, 381 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
>> index 0143135..a01368d 100644
>> --- a/drivers/acpi/acpi_processor.c
>> +++ b/drivers/acpi/acpi_processor.c
>> @@ -570,9 +570,19 @@ void __init acpi_early_processor_osc(void)
>>  static int acpi_processor_container_attach(struct acpi_device *dev,
>>  					   const struct acpi_device_id *id)
>>  {
>> +	if (dev->status.present && dev->status.functional &&
>> +		dev->status.enabled && dev->status.show_in_ui)
>> +		acpi_lpi_sysfs_init(dev->handle,
>> +				(struct acpi_lpi_sysfs_data **)&dev->driver_data);
> Why not register it only if LPIs are detected/initialized as active ?
Based on Rafael's feedback, I was planning to refactor the code for to initialize
sysfs as part of LPI initialization, so that should take care of this.
> [...]
>
>> +
>> +
>> +/*
>> + * LPI sysfs support
>> + * Exports two APIs that can be called as part of init and exit to setup the LPI
>> + * sysfs entries either from processor or processor_container driver
>> + */
>> +
> [...]
>
> Lot of this sysfs handling looks similar to what we already have for
> cpuidle. I don't have a quick solution to avoid duplication but Greg
> really hate dealing with kobjects/ksets. I need to think if there's any
> better way to do this. Sorry for just raising issue without solution.
Given the hierarchical nature of LPI and presence of  auto promote-able states, it was
hard to fit it to cpuidle model. I will take a look at it again, though I am not confident
about finding a solution to avoid duplication.
>
>> +int acpi_lpi_sysfs_init(acpi_handle h,
>> +			struct acpi_lpi_sysfs_data **lpi_sysfs_data)
>> +{
>> +	struct acpi_device *d;
>> +	struct acpi_lpi_states_array info;
>> +	struct acpi_lpi_sysfs_state *sysfs_state = NULL;
>> +	struct acpi_lpi_sysfs_data *data = NULL;
>> +	int ret, i;
>> +
>> +	if (!lpi_sysfs_data)
>> +		return -EINVAL;
>> +
>> +	ret = acpi_bus_get_device(h, &d);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = acpi_processor_evaluate_lpi(h, &info);
> Why do we need to reevaluate _LPI here ?
Since I am calling acpi_lpi_sysfs_init( ) from processor_driver and processor_container,
calling reevaluate made the code much simpler.
Refactoring code to initialize LPI sysfs as part of LPI init in processor driver should
likely remove the need to call reevaluate here.

Thanks a lot for your inputs!

--
Thanks,
Prashanth

