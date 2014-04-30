From: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: [PATCH] ACPI/Processor: Fix failure of loading acpi-cpufreq driver
Date: Wed, 30 Apr 2014 14:27:57 +0800
Message-ID: <536097ED.5010300@intel.com>
References: <1398827428-25540-1-git-send-email-tianyu.lan@intel.com> <53608551.8010208@linux.intel.com> <53608727.4080405@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:48140 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751713AbaD3Gfu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 30 Apr 2014 02:35:50 -0400
In-Reply-To: <53608727.4080405@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: rjw@rjwysocki.net, lenb@kernel.org, katoh@mikage.ne.jp, smf.linux@ntlworld.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On 2014=E5=B9=B404=E6=9C=8830=E6=97=A5 13:16, Jiang Liu wrote:
> Hi Tianyu,
> 	Found another issue at the second glance.
> In case of x2apic, "if (apic_id < 0)" should be replaced
> by "if (apic_id =3D=3D -1)" for safety.

Hi Jiang:
	Thanks for suggestion. I will update soon.
=09

> Best Regards!
> Gerry
>=20
> On 2014/4/30 13:08, Jiang Liu wrote:
>> Hi Tianyu,
>> 	With the suggested fix, we still need to protect
>> acpi_processor_hotadd_init() when pr->apic_id is -1,
>> otherwise it may cause invalid memory access.
>>
>> Best Regards!
>> Gerry
>>
>> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_proce=
ssor.c
>> index c29c2c3ec0ad..e17befc54c34 100644
>> --- a/drivers/acpi/acpi_processor.c
>> +++ b/drivers/acpi/acpi_processor.c
>> @@ -170,6 +170,9 @@ static int acpi_processor_hotadd_init(struct
>> acpi_processor *pr)
>>         acpi_status status;
>>         int ret;
>>
>> +       if (pr->apic_id < 0)
>> +               return -ENODEV;
>> +
>>         status =3D acpi_evaluate_integer(pr->handle, "_STA", NULL, &=
sta);
>>         if (ACPI_FAILURE(status) || !(sta & ACPI_STA_DEVICE_PRESENT)=
)
>>                 return -ENODEV;
>>
>>
>> On 2014/4/30 11:10, Lan Tianyu wrote:
>>> According commit d640113fe(ACPI: processor: fix acpi_get_cpuid for =
UP
>>> processor),  Bios may not provide _MAT or MADT tables and acpi_get_=
apicid()
>>> always returns -1. For these cases, original code will pass apic_id=
 with
>>> vaule of -1 to acpi_map_cpuid() and it will check the acpi_id. If a=
cpi_id
>>> is equal to zero, ignores apic_id and return zero for CPU0.
>>>
>>> Commit b981513(ACPI / scan: bail out early if failed to parse APIC
>>> ID for CPU) changed the behavior. Return ENODEV when find apic_id i=
s
>>> less than zero after calling acpi_get_apicid(). This causes acpi-cp=
ufreq
>>> driver fails to be loaded on some machines. This patch is to fix it=
=2E
>>>
>>> Reference:https://bugzilla.kernel.org/show_bug.cgi?id=3D73781
>>> Cc: stable@vger.kernel.org v3.14
>>> Reported-and-tested-by: KATO Hiroshi <katoh@mikage.ne.jp>
>>> Reported-and-tested-by: Stuart Foster <smf.linux@ntlworld.com>
>>> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
>>> ---
>>>  drivers/acpi/acpi_processor.c | 4 +---
>>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_proc=
essor.c
>>> index c29c2c3..d55b603 100644
>>> --- a/drivers/acpi/acpi_processor.c
>>> +++ b/drivers/acpi/acpi_processor.c
>>> @@ -260,10 +260,8 @@ static int acpi_processor_get_info(struct acpi=
_device *device)
>>>  	}
>>> =20
>>>  	apic_id =3D acpi_get_apicid(pr->handle, device_declaration, pr->a=
cpi_id);
>>> -	if (apic_id < 0) {
>>> +	if (apic_id < 0)
>>>  		acpi_handle_debug(pr->handle, "failed to get CPU APIC ID.\n");
>>> -		return -ENODEV;
>>> -	}
>>>  	pr->apic_id =3D apic_id;
>>> =20
>>>  	cpu_index =3D acpi_map_cpuid(pr->apic_id, pr->acpi_id);
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kern=
el" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>>


--=20
Best regards
Tianyu Lan
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
