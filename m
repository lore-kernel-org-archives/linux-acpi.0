From: Glauber Costa <gcosta@redhat.com>
Subject: Re: + acpi-use-acpi_debug_print-instead-of-printk.patch added to
 -mm tree
Date: Fri, 15 Feb 2008 21:21:52 -0200
Message-ID: <47B61E90.6070005@redhat.com>
References: <200802152128.m1FLSMGi024897@imap1.linux-foundation.org> <200802151712.36300.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:40845 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760627AbYBOX2Y (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 15 Feb 2008 18:28:24 -0500
In-Reply-To: <200802151712.36300.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: akpm@linux-foundation.org, linux-acpi@vger.kernel.org, "Thomas Renninger (Novell/SUSE)" <trenn@suse.de>, mm-commits@vger.kernel.org

Len Brown wrote:
> I.e. this printk will be present in a production shipping distro kernel
> even if you move to to ACPI_DEBUG_PRINT from printk.
Yes, but you can still disable it. And if you do, all the messages will 
vanish, but this will stay.

> The only variable  is the default verbosity level.
> 
> Thomas, what verbosity level do you use?
in this patch, I used the same verbosity level as the EJECT request. So
if it is not okay for SuSe, I suggest changing all the others too.

> thanks,
> -Len
> 
> On Friday 15 February 2008 16:28, akpm@linux-foundation.org wrote:
>> The patch titled
>>      acpi: use ACPI_DEBUG_PRINT instead of printk
>> has been added to the -mm tree.  Its filename is
>>      acpi-use-acpi_debug_print-instead-of-printk.patch
>>
>> Before you just go and hit "reply", please:
>>    a) Consider who else should be cc'ed
>>    b) Prefer to cc a suitable mailing list as well
>>    c) Ideally: find the original patch on the mailing list and do a
>>       reply-to-all to that, adding suitable additional cc's
>>
>> *** Remember to use Documentation/SubmitChecklist when testing your code ***
>>
>> See http://www.zip.com.au/~akpm/linux/patches/stuff/added-to-mm.txt to find
>> out what to do about this
>>
>> The current -mm tree may be found at http://userweb.kernel.org/~akpm/mmotm/
>>
>> ------------------------------------------------------
>> Subject: acpi: use ACPI_DEBUG_PRINT instead of printk
>> From: Glauber Costa <gcosta@redhat.com>
>>
>> For consistency, use ACPI_DEBUG_PRINT instead of printk in
>> acpi_processor_hotplug_notify() for BUS_CHECK and DEVICE_CHECK events
>>
>> Signed-off-by: Glauber Costa <gcosta@redhat.com>
>> Cc: Len Brown <lenb@kernel.org>
>> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>> ---
>>
>>  drivers/acpi/processor_core.c |    5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff -puN drivers/acpi/processor_core.c~acpi-use-acpi_debug_print-instead-of-printk drivers/acpi/processor_core.c
>> --- a/drivers/acpi/processor_core.c~acpi-use-acpi_debug_print-instead-of-printk
>> +++ a/drivers/acpi/processor_core.c
>> @@ -890,9 +890,10 @@ acpi_processor_hotplug_notify(acpi_handl
>>  	switch (event) {
>>  	case ACPI_NOTIFY_BUS_CHECK:
>>  	case ACPI_NOTIFY_DEVICE_CHECK:
>> -		printk("Processor driver received %s event\n",
>> +		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
>> +		"Processor driver received %s event\n",
>>  		       (event == ACPI_NOTIFY_BUS_CHECK) ?
>> -		       "ACPI_NOTIFY_BUS_CHECK" : "ACPI_NOTIFY_DEVICE_CHECK");
>> +		       "ACPI_NOTIFY_BUS_CHECK" : "ACPI_NOTIFY_DEVICE_CHECK"));
>>  
>>  		if (!is_processor_present(handle))
>>  			break;
>> _
>>
>> Patches currently in -mm which might be from gcosta@redhat.com are
>>
>> remove-is_processor_present-prototype.patch
>> acpi-use-acpi_debug_print-instead-of-printk.patch
>> git-kvm.patch
>>

