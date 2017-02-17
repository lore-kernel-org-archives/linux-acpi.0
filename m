From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: Re: [PATCH 1/2] acpi: Fix the mapping handle in case of declaring
 processors using the Device operator
Date: Fri, 17 Feb 2017 09:48:48 +0800
Message-ID: <32d3205d-f976-7b0d-3a5d-f2688280b836@cn.fujitsu.com>
References: <1487241492-30005-1-git-send-email-douly.fnst@cn.fujitsu.com>
 <2ba0b2be-f858-18c5-1b12-105df4c2962a@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([59.151.112.132]:6011 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754913AbdBQBsy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 16 Feb 2017 20:48:54 -0500
In-Reply-To: <2ba0b2be-f858-18c5-1b12-105df4c2962a@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>, rjw@rjwysocki.net, rafael@kernel.org, lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org



At 02/16/2017 09:06 PM, Hanjun Guo wrote:
> On 2017/2/16 18:38, Dou Liyang wrote:
>> In ACPI spec, we can declare processors using both Processor and
>> Device operator. But now, we just handle the mapping of processors
>> which are declared by Processor operator.
>>
>> It misses the processors declared by Device operator.
>>
>> The patch adds this case of the Device operator.
>>
>> Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
>> ---
>>  drivers/acpi/processor_core.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/acpi/processor_core.c
>> b/drivers/acpi/processor_core.c
>> index 611a558..1aab5b0 100644
>> --- a/drivers/acpi/processor_core.c
>> +++ b/drivers/acpi/processor_core.c
>> @@ -344,8 +344,10 @@ void __init acpi_set_processor_mapping(void)
>>  {
>>      /* Set persistent cpu <-> node mapping for all processors. */
>>      acpi_walk_namespace(ACPI_TYPE_PROCESSOR, ACPI_ROOT_OBJECT,
>> -                ACPI_UINT32_MAX, set_processor_node_mapping,
>> -                NULL, NULL, NULL);
>> +                ACPI_UINT32_MAX, set_processor_node_mapping,
>> +                NULL, NULL, NULL);
>
> no need to update the code above.

Here is some format problem I fixed, but it looks like I didn't do
anything. I will modify it in next version.

>
>> +    acpi_get_devices(ACPI_PROCESSOR_DEVICE_HID,
>> set_processor_node_mapping,
>> +                NULL, NULL);
>
> It makes sense to me to add support for Processor devices of setting
> persistent cpu <-> node mapping, but I just wondering if there is no
> Processor device or Processor Operator for a processor entry(such as
> local apic, the spec didn't say it's a mandatory) in MADT,


It is in DSDT. Declare processprs like:

Processor (ProcessorName, ProcessorID, PBlockAddress, PblockLength) { 
ObjectList }

Or

Device (DeviceName) { ObjectList }

how do we
> set the mappings?

Step 1. we generate the logical CPU IDs by the Local APIC/x2APIC ID in
MADT. So, we have the mapping of CPU ID <-> Local Apic ID. We also can
get the mapping of Processor ID/UID <-> Local Apic ID directly in MADT.

  195 [0ECh 0236   1]                Subtable Type : 00 [Processor Local 
APIC]
  196 [0EDh 0237   1]                       Length : 08
  197 [0EEh 0238   1]                *Processor ID : 40*
  198 [0EFh 0239   1]                *Local Apic ID : 40*
  199 [0F0h 0240   4]        Flags (decoded below) : 00000001
  200                            Processor Enabled : 1

So, at last, we get the mapping of

*Processor ID/UID <-> Local Apic ID <-> CPU ID*

Step 2. we can get *processorID/_UID <-> Node ID(_PXM)* in DSDT.

So, we get the maaping of *Node ID <-> CPU ID* according to

*Node ID(_PXM) <-> Processor ID/UID <-> Local Apic ID <-> CPU ID*

>
> BTW, multi places in the ACPI driver are using the same pattern here
> to scan all the processors, maybe we can add a function then call it
> to reduce some lines of code?
>

Yes, I think so.

Thanks,
Liyang.

> Thanks
> Hanjun
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>


