From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] ACPICA: Detect duplicate SSDT tables
Date: Wed, 1 Mar 2017 10:19:08 +0100
Message-ID: <a2cdcf07-055c-6cb2-a0f2-b179a128f845@redhat.com>
References: <20170227093432.3308-1-hdegoede@redhat.com>
 <1AE640813FDE7649BE1B193DEA596E886CE430EF@SHSMSX101.ccr.corp.intel.com>
 <d2552299-d658-af67-44f1-7e528133cfaf@redhat.com>
 <1AE640813FDE7649BE1B193DEA596E886CE43ED5@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45758 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750947AbdCAJ1k (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 1 Mar 2017 04:27:40 -0500
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E886CE43ED5@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "Moore, Robert" <robert.moore@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>

Hi,

On 01-03-17 04:21, Zheng, Lv wrote:
> Hi,
>
>> From: Hans de Goede [mailto:hdegoede@redhat.com]
>> Subject: Re: [PATCH] ACPICA: Detect duplicate SSDT tables
>>
>> Hi,
>>
>> On 28-02-17 06:19, Zheng, Lv wrote:
>>> Hi,
>>>
>>>> From: Hans de Goede [mailto:hdegoede@redhat.com]
>>>> Subject: [PATCH] ACPICA: Detect duplicate SSDT tables
>>>>
>>>> Some machines have the exact (byte for byte) same SSDT tables multiple
>>>> times in the root_table_list.
>>>
>>> Could you give a machine list here?
>>
>> Currently I'm seeing this on a GPD win machine:
>>
>> http://www.gpd.hk/gpdwin.asp
>>
>> I thought I was seeing it on more machines, but those have
>> different apci table loading errors...
>
> I'm not sure what the Windows clones will behave in this case.
> Upon seeing a duplicate table, will Windows:
> 1. override old namespace node, or
> 2. discard (maybe silently) new namespace node that has conflict namespace hierarchy position against existing node, or
> 3. just complain us with a blue screen, or
> 4. compare all tables first.
>
> Before knowing the de-facto standard behavior, I'm not sure if the behavior introduced by this commit is correct.
> We should be able to judge if this case is real after knowing the Windows behavior.

It is impossible to know what Windows does under the hood, but it
does work without complaints on this device, so it certainly does
not do 3. As for 1., 2. and 4. since these are identical tables
the end result is the same in all 3 cases, it is as if only a
single copy was used:

1. Overriding with the exact same table is a no-op
2. Silently discarding means the old copy is used
4. Comparing tables and presumable then not loading duplicate
    ones will result in the old copy being used.

So it really does not matter which route windows goes, the
end result is: Things work without the user being show scary
error messages during boot.

> So I don't think this commit goes the right direction on the right track.
>
>>
>>>> Detect this and silently skip the duplicates
>>>> rather then printing a scary looking set of errors.
>>>
>>> Why will this matter to OSPMs?
>>
>> Not sure what you mean with OSPMs but I can tell you why this
>> matters in general, Linux distributions like e.g. Fedora have
>> been putting a lot of work in a smooth boot experience where
>> end users do not get any scary text messages. For some more
>> embedded like systems this even is a hard requirement.
>>
>> The kernel supports quiet kernel cmdline argument to silence
>> normal kernel messages, which is part of what is needed but
>> messages with a log level of error still get shown, breaking
>> the "no scary text messages" product requirement.
>>
>>> And should we add non-costless steps just in order to reduce errors,
>>
>> Yes we should, work on that front has been happening for years,
>> also the CPU cost of this check is quite small, memcmp will
>> only happen on identically sized tables and even then it will
>> exit as soon as a single byte differs.
>
> Even though, there are server systems containing many tables, almost one/two/three table(s) per CPU.
> And you surely need to compare each of them against each of the others.

And those machines typically take quite a lot time to boot anyways.

Note my patch is only checking previously loaded tables (we do want
to load the first copy). So all it is doing is accessing system memory
from the CPU. I think you will find in impossible to even measure the
extra boot time these few extra (likely cached) system memory accesses
take, let alone that it will be anywhere near relevant for the total
boot time.

>>> while the errors are on the contrary useful (in1dicating platform issues)?
>>
>> These errors are useful for developers / during testing but
>> not in production setups, esp. in the case of duplicate tables
>> where not loading the duplicate leads to 0 bad side effects.
>>
>> I've an alternative proposal though, since this check just fixes
>> a small part of the early boot messages caused by SSDT loading
>> and since the code itself chooses to ignore any errors:
>>
>>          /* Ignore errors while loading tables, get as many as possible */
>>
>> How about setting a global flag while loading these tables and making
>>
>> ACPI_EXCEPTION calls log the exceptions with a log level of warning
>> as well as turning the final:
>>
>>                  ACPI_ERROR((AE_INFO,
>>                              "%u table load failures, %u successful",
>>                              tables_failed, tables_loaded));
>>
>> Into a warning ?
>
> So will Linux just unconditionally change pr_err() into pr_warn() in the printk.h?

I'm not talking about unconditionally doing this, the acpica code itself
contains in drivers/acpi/acpica/tbxfload.c:

         /* Ignore errors while loading tables, get as many as possible */

Since acpica is ignoring errors here, it would seem reasonable to me for
acpica to treat all ACPI_ERROR / ACPI_EXCEPTION calls while doing this
as ACPI_WARNING calls.

> ACPI_EXCEPTION here actually means blue screen in Windows.
> Maybe it's correct, maybe not.
> Linux doesn't run into panic in ACPI_EXCEPTIION just because Linux ACPI implementation still has compliance issues against the de-facto standard.

De-facto standard ? ACPI is a written standard, not a de-facto standard.
I surely hope ACPICA tries to implements the standard as written...

Regards,

Hans



>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>> ---
>>>>  drivers/acpi/acpica/tbxfload.c | 41 ++++++++++++++++++++++++++++++++++++++++-
>>>>  1 file changed, 40 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/acpi/acpica/tbxfload.c b/drivers/acpi/acpica/tbxfload.c
>>>> index 82019c0..1971cd7 100644
>>>> --- a/drivers/acpi/acpica/tbxfload.c
>>>> +++ b/drivers/acpi/acpica/tbxfload.c
>>>> @@ -125,6 +125,44 @@ ACPI_EXPORT_SYMBOL_INIT(acpi_load_tables)
>>>>
>>>>  /*******************************************************************************
>>>>   *
>>>> + * FUNCTION:    acpi_tb_find_duplicate_ssdt
>>>> + *
>>>> + * PARAMETERS:  table         - validated acpi_table_desc of table to check
>>>> + *              index         - index of table to find a duplicate of
>>>> + *
>>>> + * RETURN:      TRUE if a duplicate is found, FALSE if not
>>>> + *
>>>> + * DESCRIPTION: Private helper function for acpi_tb_load_namespace to
>>>> + *              avoid trying to load duplicate ssdt tables
>>>> + *
>>>> + ******************************************************************************/
>>>> +static u8 acpi_tb_find_duplicate_ssdt(struct acpi_table_desc *table, u32 index)
>>>> +{
>>>> +	struct acpi_table_desc *dup;
>>>> +	u32 i;
>>>> +
>>>> +	for (i = 0; i < index; ++i) {
>>>> +		dup = &acpi_gbl_root_table_list.tables[i];
>>>> +
>>>> +		if (!acpi_gbl_root_table_list.tables[i].address ||
>>>> +		    (!ACPI_COMPARE_NAME(dup->signature.ascii, ACPI_SIG_SSDT)
>>>> +		     && !ACPI_COMPARE_NAME(dup->signature.ascii,
>>>> +					   ACPI_SIG_PSDT)
>>>> +		     && !ACPI_COMPARE_NAME(dup->signature.ascii,
>>>> +					   ACPI_SIG_OSDT))
>>>> +		    || ACPI_FAILURE(acpi_tb_validate_table(dup))
>>>> +		    || dup->length != table->length) {
>>>> +			continue;
>>>> +		}
>>>> +
>>>> +		if (memcmp(dup->pointer, table->pointer, table->length) == 0)
>>>> +			return TRUE;
>>>> +	}
>>>> +	return FALSE;
>>>> +}
>>>> +
>>>> +/*******************************************************************************
>>>> + *
>>>>   * FUNCTION:    acpi_tb_load_namespace
>>>>   *
>>>>   * PARAMETERS:  None
>>>> @@ -212,7 +250,8 @@ acpi_status acpi_tb_load_namespace(void)
>>>>  					   ACPI_SIG_PSDT)
>>>>  		     && !ACPI_COMPARE_NAME(table->signature.ascii,
>>>>  					   ACPI_SIG_OSDT))
>>>> -		    || ACPI_FAILURE(acpi_tb_validate_table(table))) {
>>>> +		    || ACPI_FAILURE(acpi_tb_validate_table(table))
>>>> +		    || acpi_tb_find_duplicate_ssdt(table, i)) {
>>>>  			continue;
>>>>  		}
>>>>
>>>> --
>>>> 2.9.3
>>>
