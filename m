From: "Prakash, Prashanth" <pprakash@codeaurora.org>
Subject: Re: [RFC] ACPI / Processor: add sysfs support for low power idle
Date: Wed, 19 Apr 2017 17:00:57 -0600
Message-ID: <f24c964c-bfe5-0ef5-0021-6c6093e990e4@codeaurora.org>
References: <1490832795-27441-1-git-send-email-pprakash@codeaurora.org>
 <2594349.EKCJmLdolL@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:36618 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937612AbdDSXBA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 19 Apr 2017 19:01:00 -0400
In-Reply-To: <2594349.EKCJmLdolL@aspire.rjw.lan>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org, sudeep.holla@arm.com, al.stone@linaro.org

Hi Rafael,

On 4/18/2017 8:34 AM, Rafael J. Wysocki wrote:
> On Wednesday, March 29, 2017 06:13:15 PM Prashanth Prakash wrote:
>> Add support to expose idle statistics maintained by platform to
>> userspace via sysfs in addition to other data of interest from
>> each LPI(Low Power Idle) state.
>>
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
>> 	|-> state0
>> 	|	|-> desc
>> 	|	|-> time
>> 	|	|-> usage
>> 	|	|-> latency
>> 	|	|-> min_residency
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
>>
>> Signed-off-by: Prashanth Prakash <pprakash@codeaurora.org>
> I'd like Sudeep to tell me what he thinks about this in the first place.
>
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
> This isn't the right place to do it IMO.
>
> It should be done at the processor driver initialization when it is know that
> LPI is going to be used at all.
I will make the changes to initialize this in processor driver.

Thanks for the feedback!

--
Thanks,
Prashanth

