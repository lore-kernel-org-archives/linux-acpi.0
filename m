From: Matthias Brugger <mbrugger@suse.com>
Subject: Re: [PATCH] ACPI / tables: Return error from table parse handler
Date: Fri, 20 May 2016 10:11:14 +0200
Message-ID: <573EC6A2.1010701@suse.com>
References: <1463676667-17945-1-git-send-email-mbrugger@suse.com>
 <CAJZ5v0jSt-q6tKOSLMmJGLzqpHzLDvyDNoKR2fMmzS4wVW5oFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:41775 "EHLO
	smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751942AbcETILu (ORCPT
	<rfc822;groupwise-linux-acpi@vger.kernel.org:0:0>);
	Fri, 20 May 2016 04:11:50 -0400
In-Reply-To: <CAJZ5v0jSt-q6tKOSLMmJGLzqpHzLDvyDNoKR2fMmzS4wVW5oFg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>



On 19/05/16 23:17, Rafael J. Wysocki wrote:
> On Thu, May 19, 2016 at 6:51 PM, Matthias Brugger <mbrugger@suse.com> wrote:
>> The handler called in acpi_table_parse may return an error.
>> This patch returns this error instead of ignoring it.
>
> And does it address any particular practical problem or is it just a
> code cleanup?
>

It's just a code cleanup.

>> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
>> ---
>>   drivers/acpi/tables.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
>> index a372f9e..fb5cd80 100644
>> --- a/drivers/acpi/tables.c
>> +++ b/drivers/acpi/tables.c
>> @@ -394,6 +394,7 @@ int __init acpi_table_parse(char *id, acpi_tbl_table_handler handler)
>>   {
>>          struct acpi_table_header *table = NULL;
>>          acpi_size tbl_size;
>> +       int ret;
>>
>>          if (acpi_disabled)
>>                  return -ENODEV;
>> @@ -407,9 +408,9 @@ int __init acpi_table_parse(char *id, acpi_tbl_table_handler handler)
>>                  acpi_get_table_with_size(id, 0, &table, &tbl_size);
>>
>>          if (table) {
>> -               handler(table);
>> +               ret = handler(table);
>>                  early_acpi_os_unmap_memory(table, tbl_size);
>> -               return 0;
>> +               return ret;
>>          } else
>>                  return -ENODEV;
>>   }
>> --
>
