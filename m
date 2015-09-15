From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] ACPI: tables: simplify acpi_parse_entries
Date: Tue, 15 Sep 2015 10:31:47 +0100
Message-ID: <55F7E583.2070207@arm.com>
References: <1442243686-15845-1-git-send-email-sudeep.holla@arm.com>
 <1725643.HXZjLoU2vc@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:49595 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754951AbbIOJbw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 15 Sep 2015 05:31:52 -0400
In-Reply-To: <1725643.HXZjLoU2vc@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>



On 15/09/15 00:41, Rafael J. Wysocki wrote:
> On Monday, September 14, 2015 04:14:46 PM Sudeep Holla wrote:
>> acpi_parse_entries passes the table end pointer to the sub-table entry
>> handler. acpi_parse_entries itself could validate the end of an entry
>> against the table end using the length in the sub-table entry.
>>
>> This patch adds the validation of the sub-table entry end using the
>> length field.This will help to eliminate the need to pass the table end
>> to the handlers.
>>
>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>
> Well, I'm not a big fan of (void *) arithmetics and the patch seems to be
> doing too much to me.
>

Agreed, I will try to remove(if not most likely reduce) it.

>> ---
>>   drivers/acpi/tables.c | 34 +++++++++-------------------------
>>   1 file changed, 9 insertions(+), 25 deletions(-)
>>
>> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
>> index 17a6fa01a338..145d4f6a1c54 100644
>> --- a/drivers/acpi/tables.c
>> +++ b/drivers/acpi/tables.c
>> @@ -217,16 +217,13 @@ acpi_parse_entries(char *id, unsigned long table_size,
>>   		int entry_id, unsigned int max_entries)
>>   {
>>   	struct acpi_subtable_header *entry;
>> +	void *entry_end, *table_end;
>>   	int count = 0;
>> -	unsigned long table_end;
>
> I'd keep that as unsigned long and I'd add unsigned long entry_end here.
>

OK will change accordingly

>>
>>   	if (acpi_disabled)
>>   		return -ENODEV;
>>
>> -	if (!id || !handler)
>> -		return -EINVAL;
>> -
>> -	if (!table_size)
>> +	if (!id || !handler || !table_size)
>>   		return -EINVAL;
>
> Please mention this cleanup bit in the changelog, as it is not related to
> the other changes.
>

Ah right, sorry for unnecessary change. Better I will remove it.

>>
>>   	if (!table_header) {
>> @@ -234,34 +231,21 @@ acpi_parse_entries(char *id, unsigned long table_size,
>>   		return -ENODEV;
>>   	}
>>
>> -	table_end = (unsigned long)table_header + table_header->length;
>> +	table_end = (void *)table_header + table_header->length;
>>
>>   	/* Parse all entries looking for a match. */
>> +	entry = (void *)table_header + table_size;
>> +	entry_end = (void *)entry + entry->length;
>>
>> -	entry = (struct acpi_subtable_header *)
>> -	    ((unsigned long)table_header + table_size);
>
> 	entry_end = (unsigned long)table_header + table_size;
> 	entry = (struct acpi_subtable_header *)entry_end;
> 	entry_end += entry->length;
>
>> -
>> -	while (((unsigned long)entry) + sizeof(struct acpi_subtable_header) <
>> -	       table_end) {
>> +	while (entry->length && entry_end <= table_end) {
>
> We used to return -EINVAL for entry->length == 0 and now we don't.  Isn't that
> a problem?
>

I thought the main reason was to break the infinite loop, will retain
that as you suggested.

>>   		if (entry->type == entry_id
>>   		    && (!max_entries || count < max_entries)) {
>> -			if (handler(entry, table_end))
>> +			if (handler(entry, (unsigned long)entry_end))
>>   				return -EINVAL;
>> -
>>   			count++;
>>   		}
>> -
>> -		/*
>> -		 * If entry->length is 0, break from this loop to avoid
>> -		 * infinite loop.
>> -		 */
>> -		if (entry->length == 0) {
>> -			pr_err("[%4.4s:0x%02x] Invalid zero length\n", id, entry_id);
>> -			return -EINVAL;
>> -		}
>
> Perhaps just reorder this with the previous if () and write the loop as
>

Make sense.

> 	while (entry_end <= table_end) {
>
>> -
>> -		entry = (struct acpi_subtable_header *)
>> -		    ((unsigned long)entry + entry->length);
>> +		entry = entry_end;
>> +		entry_end = (void *)entry + entry->length;
>
> And this can be
>
> 		entry = (struct acpi_subtable_header *)entry_end;
> 		entry_end += entry->length;
>

OK

Anyways I realized that I tested this on top of Al's MADT cleanup
series. I think this might break BAD_MADT_ENTRY macro which expects to
get table_end rather than entry_end(though latter is correct)

I am not sure if that's the case with APIC, but for MADT and
BAD_MADT_GICC_ENTRY, entry + sizeof(*entry) > entry_end can be true(as
the specification is broken and Al is trying to solve)

I will respin the patch as per your suggestion but needs to go only
after Al's MADT patches.

Regards,
Sudeep
