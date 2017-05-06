From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] ACPI: Delay turning off unused resources after suspend
 till acpi_pm_end()
Date: Sat, 6 May 2017 19:47:58 +0200
Message-ID: <a9a675f4-fa1f-e90d-53f1-fa0526ca9b29@redhat.com>
References: <20170430205416.6625-1-hdegoede@redhat.com>
 <3645269.cWqcE5V9pV@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59766 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751116AbdEFRsB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 6 May 2017 13:48:01 -0400
In-Reply-To: <3645269.cWqcE5V9pV@aspire.rjw.lan>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

Hi,

On 05-05-17 22:07, Rafael J. Wysocki wrote:
> On Sunday, April 30, 2017 10:54:16 PM Hans de Goede wrote:
>> Commit 660b1113e0f3 ("ACPI / PM: Fix consistency check for power resources
>> during resume") introduced a check for ACPI power resources which have
>> been turned on by the BIOS during suspend and turns these back off again.
>>
>> This is causing problems on a Dell Venue Pro 11 7130 (i5-4300Y) it causes
>> the following messages to show up in dmesg:
>>
>> [  131.014605] ACPI: Waking up from system sleep state S3
>> [  131.150271] acpi LNXPOWER:07: Turning OFF
>> [  131.150323] acpi LNXPOWER:06: Turning OFF
>> [  131.150911] acpi LNXPOWER:00: Turning OFF
>> [  131.169014] ACPI : EC: interrupt unblocked
>> [  131.181811] xhci_hcd 0000:00:14.0: System wakeup disabled by ACPI
>> [  133.535728] pci_raw_set_power_state: 76 callbacks suppressed
>> [  133.535735] iwlwifi 0000:01:00.0: Refused to change power state,
>>                 currently in D3
>> [  133.597672] PM: noirq resume of devices complete after 2428.891 msecs
>>
>> Followed by a bunch of iwlwifi errors later on and the pcie device
>> dropping from the bus (acpiphp thinks it has been unplugged).
>>
>> Disabling the turning off of unused power resources fixes this. Instead
>> of adding a quirk for this system, this commit fixes this by moving the
>> disabling of unused power resources to later in the resume sequence
>> when the iwlwifi card has been moved out of D3 so the ref_count for
>> its power resource no longer is 0.
>>
>> This new behavior seems to match the intend of the original commit which
>> commit-msg says: "which means that no devices are going to need them
>> any time soon) and we should turn them off".
>>
>> This also avoids power resources which we need when bringing devices out
>> of D3 from getting bounced off and then back on again.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   drivers/acpi/power.c | 10 ++++++++++
>>   drivers/acpi/sleep.c |  1 +
>>   drivers/acpi/sleep.h |  1 +
>>   3 files changed, 12 insertions(+)
>>
>> diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
>> index fcd4ce6..1d330a5 100644
>> --- a/drivers/acpi/power.c
>> +++ b/drivers/acpi/power.c
>> @@ -863,6 +863,16 @@ void acpi_resume_power_resources(void)
>>   
>>   		mutex_unlock(&resource->resource_lock);
>>   	}
>> +
>> +	mutex_unlock(&power_resource_list_lock);
>> +}
>> +
>> +void acpi_turn_off_unused_power_resources(void)
>> +{
>> +	struct acpi_power_resource *resource;
>> +
>> +	mutex_lock(&power_resource_list_lock);
>> +
>>   	list_for_each_entry_reverse(resource, &acpi_power_resource_list, list_node) {
>>   		int result, state;
>>   
>> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
>> index a4327af..097d630 100644
>> --- a/drivers/acpi/sleep.c
>> +++ b/drivers/acpi/sleep.c
>> @@ -474,6 +474,7 @@ static void acpi_pm_start(u32 acpi_state)
>>    */
>>   static void acpi_pm_end(void)
>>   {
>> +	acpi_turn_off_unused_power_resources();
>>   	acpi_scan_lock_release();
>>   	/*
>>   	 * This is necessary in case acpi_pm_finish() is not called during a
>> diff --git a/drivers/acpi/sleep.h b/drivers/acpi/sleep.h
>> index a9cc34e..a82ff74 100644
>> --- a/drivers/acpi/sleep.h
>> +++ b/drivers/acpi/sleep.h
>> @@ -6,6 +6,7 @@ extern struct list_head acpi_wakeup_device_list;
>>   extern struct mutex acpi_device_lock;
>>   
>>   extern void acpi_resume_power_resources(void);
>> +extern void acpi_turn_off_unused_power_resources(void);
>>   
>>   static inline acpi_status acpi_set_waking_vector(u32 wakeup_address)
>>   {
>>
> 
> Makes sense to me, so applied.

Great, thank you. Do you plan to submit it as a fix for 4.12 ?

IMHO it may be slightly to adventurous for stable but it would
be good to get it in 4.12.

Regards,

Hans
