From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Subject: Re: [Linaro-acpi] [RFC] ACPI: Add new function to get table entries
Date: Thu, 20 Mar 2014 11:16:18 +0100
Message-ID: <532ABFF2.6080103@linaro.org>
References: <1395270568-30021-1-git-send-email-ashwin.chaugule@linaro.org> <532ABD83.9020003@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:62389 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750863AbaCTKPh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Mar 2014 06:15:37 -0400
Received: by mail-wg0-f45.google.com with SMTP id l18so417275wgh.4
        for <linux-acpi@vger.kernel.org>; Thu, 20 Mar 2014 03:15:36 -0700 (PDT)
In-Reply-To: <532ABD83.9020003@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ashwin Chaugule <ashwin.chaugule@linaro.org>, linaro-acpi@lists.linaro.org
Cc: linux-acpi@vger.kernel.org, rjw@rjwysocki.net, lenb@kernel.org



On 20.03.2014 11:05, Tomasz Nowicki wrote:
>
>
> On 20.03.2014 00:09, Ashwin Chaugule wrote:
>> The acpi_table_parse() function has a callback that
>> passes a pointer to a table_header. Add a new function
>> which takes this pointer and parses its entries. This
>> eliminates the need to re-traverse all the tables for
>> each call. e.g. as in acpi_table_parse_madt() which is
>> normally called after acpi_table_parse().
>>
>> Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
>> ---
>>   drivers/acpi/tables.c | 69
>> +++++++++++++++++++++++++++++++++++----------------
>>   include/linux/acpi.h  |  4 +++
>>   2 files changed, 51 insertions(+), 22 deletions(-)
>>
>> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
>> index 5837f85..b7bd6a3 100644
>> --- a/drivers/acpi/tables.c
>> +++ b/drivers/acpi/tables.c
>> @@ -199,19 +199,15 @@ void acpi_table_print_madt_entry(struct
>> acpi_subtable_header *header)
>>       }
>>   }
>>
>> -
>>   int __init
>> -acpi_table_parse_entries(char *id,
>> -                 unsigned long table_size,
>> -                 int entry_id,
>> -                 acpi_tbl_entry_handler handler,
>> -                 unsigned int max_entries)
>> +acpi_parse_entries(unsigned long table_size,
>> +        acpi_tbl_entry_handler handler,
>> +        struct acpi_table_header *table_header,
>> +        int entry_id, unsigned int max_entries)
>>   {
>> -    struct acpi_table_header *table_header = NULL;
>>       struct acpi_subtable_header *entry;
>>       unsigned int count = 0;
>>       unsigned long table_end;
>> -    acpi_size tbl_size;
>>
>>       if (acpi_disabled)
>>           return -ENODEV;
>> @@ -219,16 +215,14 @@ acpi_table_parse_entries(char *id,
>>       if (!handler)
>>           return -EINVAL;
>>
>> -    if (strncmp(id, ACPI_SIG_MADT, 4) == 0)
>> -        acpi_get_table_with_size(id, acpi_apic_instance,
>> &table_header, &tbl_size);
>> -    else
>> -        acpi_get_table_with_size(id, 0, &table_header, &tbl_size);
>> -
>>       if (!table_header) {
>> -        printk(KERN_WARNING PREFIX "%4.4s not present\n", id);
>> +        pr_warn(PREFIX "Table header not present\n");
>>           return -ENODEV;
>>       }
>>
>> +    if (!table_size)
>> +        table_size = table_header->length;
>> +
>
> If table_size == 0, that would causes 'entry' and 'table_end' are equal
> and no entries at all. For that case I would suggest to print error and
> return.
>
> Tomasz
>
>>       table_end = (unsigned long)table_header + table_header->length;
>>
>>       /* Parse all entries looking for a match. */
>> @@ -240,15 +234,18 @@ acpi_table_parse_entries(char *id,
>>              table_end) {
>>           if (entry->type == entry_id
>>               && (!max_entries || count++ < max_entries))
>> -            if (handler(entry, table_end))
>> +            if (handler(entry, table_end)) {
>> +                count = -EINVAL;
>>                   goto err;
>> +            }
>>
>>           /*
>>            * If entry->length is 0, break from this loop to avoid
>>            * infinite loop.
>>            */
>>           if (entry->length == 0) {
>> -            pr_err(PREFIX "[%4.4s:0x%02x] Invalid zero length\n", id,
>> entry_id);
>> +            pr_err(PREFIX "[0x%02x] Invalid zero length\n", entry_id);
>> +            count = -EINVAL;
>>               goto err;
>>           }
>>
>> @@ -256,15 +253,43 @@ acpi_table_parse_entries(char *id,
>>               ((unsigned long)entry + entry->length);
>>       }
>>       if (max_entries && count > max_entries) {
>> -        printk(KERN_WARNING PREFIX "[%4.4s:0x%02x] ignored %i entries
>> of "
>> -               "%i found\n", id, entry_id, count - max_entries, count);
>> +        printk(KERN_WARNING PREFIX "[0x%02x] ignored %i entries of "
>> +               "%i found\n", entry_id, count - max_entries, count);
>>       }
>>
>> -    early_acpi_os_unmap_memory((char *)table_header, tbl_size);
>> -    return count;
>>   err:
>> -    early_acpi_os_unmap_memory((char *)table_header, tbl_size);
>> -    return -EINVAL;
>> +    early_acpi_os_unmap_memory((char *)table_header,
>> (acpi_size)table_size);
>> +    return count;
>
> Changelog is saying that acpi_parse_entries() takes already mapped table
> and parses entries. IMO, caller should takes care about unmapping table.
> It can be still parsed using different ID later on.
>
> Tomasz
>
>> +}
>> +
>> +int __init
>> +acpi_table_parse_entries(char *id,
>> +                 unsigned long table_size,
>> +                 int entry_id,
>> +                 acpi_tbl_entry_handler handler,
>> +                 unsigned int max_entries)
>> +{
>> +    struct acpi_table_header *table_header = NULL;
>> +    acpi_size tbl_size;
>> +
>> +    if (acpi_disabled)
>> +        return -ENODEV;
>> +
>> +    if (!handler)
>> +        return -EINVAL;
>> +
>> +    if (strncmp(id, ACPI_SIG_MADT, 4) == 0)
>> +        acpi_get_table_with_size(id, acpi_apic_instance,
>> &table_header, &tbl_size);
>> +    else
>> +        acpi_get_table_with_size(id, 0, &table_header, &tbl_size);
>> +
>> +    if (!table_header) {
>> +        pr_warn("%4.4s not present\n", id);
>> +        return -ENODEV;
>> +    }
>> +
>> +    return acpi_parse_entries(table_header->length, handler,
>> table_header,
>> +            entry_id, max_entries);
Also, first argument of acpi_parse_entries() expect subtable start point 
offset, but now it points to the end of table.

Tomasz
>>   }
>>
>>   int __init
>> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
>> index 1151a1d..da959fd 100644
>> --- a/include/linux/acpi.h
>> +++ b/include/linux/acpi.h
>> @@ -118,6 +118,10 @@ int acpi_numa_init (void);
>>
>>   int acpi_table_init (void);
>>   int acpi_table_parse(char *id, acpi_tbl_table_handler handler);
>> +int __init acpi_parse_entries(unsigned long table_size,
>> +        acpi_tbl_entry_handler handler,
>> +        struct acpi_table_header *table_header,
>> +        int entry_id, unsigned int max_entries);
>>   int __init acpi_table_parse_entries(char *id, unsigned long table_size,
>>                       int entry_id,
>>                       acpi_tbl_entry_handler handler,
>>
