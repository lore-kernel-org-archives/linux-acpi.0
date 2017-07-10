From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 1/3] ACPI / X86: Allow matching always_present_id array
 entries by DMI
Date: Mon, 10 Jul 2017 20:13:24 +0200
Message-ID: <20605f11-e788-6dd5-74e7-28a31b00d599@redhat.com>
References: <20170709190514.3437-1-hdegoede@redhat.com>
 <1499696704.22624.329.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35660 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754319AbdGJSN2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 10 Jul 2017 14:13:28 -0400
In-Reply-To: <1499696704.22624.329.camel@linux.intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

Hi,

On 10-07-17 16:25, Andy Shevchenko wrote:
> On Sun, 2017-07-09 at 21:05 +0200, Hans de Goede wrote:
>> On some X86 systems the DSDT hides APCI devices to work around Windows
>> driver bugs. On one such system the device is even hidden until a
>> certain
>> time after _SB.PCI0.GFX0.LCD.LCD1._ON gets called has passed *and*
>> _STA has been called at least 3 times since. TL;DR: it is a mess.
>>
>> Until now the always_present_id matching was used to force status
>> for a whole class of devices, e.g. always enable PWM1 on CHerry Trail
> 
> Cherry
> 
>> devices.
>>
>> This commit extends the always_present_id matching code to optionally
>> als check for a DMI match so that we can also add system specific
>> quirks to the always_present_id array.
>>
> 
> I got answers to my questions (see thread), thus, FWIW,
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thank you, does that apply to the entire set or just the first patch ?

Regards,

Hans



> 
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   drivers/acpi/x86/utils.c | 19 +++++++++++++++----
>>   1 file changed, 15 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
>> index bd86b809c848..b0e16516adfd 100644
>> --- a/drivers/acpi/x86/utils.c
>> +++ b/drivers/acpi/x86/utils.c
>> @@ -12,6 +12,7 @@
>>    */
>>   
>>   #include <linux/acpi.h>
>> +#include <linux/dmi.h>
>>   #include <asm/cpu_device_id.h>
>>   #include <asm/intel-family.h>
>>   #include "../internal.h"
>> @@ -20,6 +21,10 @@
>>    * Some ACPI devices are hidden (status == 0x0) in recent BIOS-es
>> because
>>    * some recent Windows drivers bind to one device but poke at
>> multiple
>>    * devices at the same time, so the others get hidden.
>> + *
>> + * Some BIOS-es (temporarily) hide specific APCI devices to work
>> around Windows
>> + * driver bugs. We use DMI matching to match known cases of this.
>> + *
>>    * We work around this by always reporting ACPI_STA_DEFAULT for these
>>    * devices. Note this MUST only be done for devices where this is
>> safe.
>>    *
>> @@ -31,14 +36,16 @@
>>   struct always_present_id {
>>   	struct acpi_device_id hid[2];
>>   	struct x86_cpu_id cpu_ids[2];
>> +	struct dmi_system_id dmi_ids[2]; /* Optional */
>>   	const char *uid;
>>   };
>>   
>>   #define ICPU(model)	{ X86_VENDOR_INTEL, 6, model,
>> X86_FEATURE_ANY, }
>>   
>> -#define ENTRY(hid, uid, cpu_models) {					
>> \
>> +#define ENTRY(hid, uid, cpu_models, dmi...) {				
>> \
>>   	{ { hid, }, {} },						
>> \
>>   	{ cpu_models, {} },						
>> \
>> +	{ { .matches = dmi }, {} },					
>> \
>>   	uid,								
>> \
>>   }
>>   
>> @@ -47,13 +54,13 @@ static const struct always_present_id
>> always_present_ids[] = {
>>   	 * Bay / Cherry Trail PWM directly poked by GPU driver in
>> win10,
>>   	 * but Linux uses a separate PWM driver, harmless if not
>> used.
>>   	 */
>> -	ENTRY("80860F09", "1", ICPU(INTEL_FAM6_ATOM_SILVERMONT1)),
>> -	ENTRY("80862288", "1", ICPU(INTEL_FAM6_ATOM_AIRMONT)),
>> +	ENTRY("80860F09", "1", ICPU(INTEL_FAM6_ATOM_SILVERMONT1),
>> {}),
>> +	ENTRY("80862288", "1", ICPU(INTEL_FAM6_ATOM_AIRMONT), {}),
>>   	/*
>>   	 * The INT0002 device is necessary to clear wakeup interrupt
>> sources
>>   	 * on Cherry Trail devices, without it we get nobody cared
>> IRQ msgs.
>>   	 */
>> -	ENTRY("INT0002", "1", ICPU(INTEL_FAM6_ATOM_AIRMONT)),
>> +	ENTRY("INT0002", "1", ICPU(INTEL_FAM6_ATOM_AIRMONT), {}),
>>   };
>>   
>>   bool acpi_device_always_present(struct acpi_device *adev)
>> @@ -76,6 +83,10 @@ bool acpi_device_always_present(struct acpi_device
>> *adev)
>>   		if (!x86_match_cpu(always_present_ids[i].cpu_ids))
>>   			continue;
>>   
>> +		if (always_present_ids[i].dmi_ids[0].matches[0].slot
>> &&
>> +		    !dmi_check_system(always_present_ids[i].dmi_ids))
>> +			continue;
>> +
>>   		if (old_status != ACPI_STA_DEFAULT) /* Log only once
>> */
>>   			dev_info(&adev->dev,
>>   				 "Device [%s] is in always present
>> list\n",
> 
