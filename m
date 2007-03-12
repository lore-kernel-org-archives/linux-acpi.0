From: Nigel <nigels@hotmail.com>
Subject: Re: [repost] acpi on gentoo
Date: Mon, 12 Mar 2007 15:59:48 +0100
Message-ID: <45F56AE4.4050300@hotmail.com>
References: <BAY123-W214EDC3E723EFE3C0B5E8FD57D0@phx.gbl> <45F559A4.6090606@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp7-g19.free.fr ([212.27.42.64]:48085 "EHLO smtp7-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030283AbXCLO7y (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 12 Mar 2007 10:59:54 -0400
In-Reply-To: <45F559A4.6090606@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Cc: linux-acpi@vger.kernel.org



Alexey Starikovskiy said on 12/03/2007 2:46 PM:
> Nigel Nigel wrote:
>>
>>
>>
>>
>>
>> ----------------------------------------
>>  
>>> Date: Mon, 12 Mar 2007 14:16:51 +0300
>>> From: alexey.y.starikovskiy@linux.intel.com
>>> To: nigels@hotmail.com
>>> CC: linux-acpi@vger.kernel.org
>>> Subject: Re: [repost] acpi on gentoo
>>>
>>> Nigel wrote:
>>>    
>>>>> Date: Sun, 11 Mar 2007 18:57:58 +0300
>>>>> From: alexey.y.starikovskiy@linux.intel.com
>>>>> To: nigels@hotmail.com
>>>>> CC: luming.yu@gmail.com; linux-acpi@vger.kernel.org
>>>>> Subject: Re: [repost] acpi on gentoo
>>>>>
>>>>> Nigel wrote:
>>>>>        
>>>>>> response inline
>>>>>>
>>>>  
>>>>
>>>> [skipped]
>>>>       
>>> I asked if copying of single file helps... I didn't ask you to copy 
>>> all acpi files two kernel releases back and make it work...
>>>    
>>>> If there is a relatively simple way to get this to work. Let me know.
>>>>       
>>> Copy one file: drivers/acpi/ec.c
>>>     
>>
>> Sorry, I should have explained in more detail. I did copy just the 
>> one file to start with, and  got this :
>> CHK     include/linux/version.h
>> CHK     include/linux/compile.h
>> CC      drivers/acpi/ec.o
>> drivers/acpi/ec.c: In function 'acpi_ec_gpe_handler':
>> drivers/acpi/ec.c:467: warning: implicit declaration of function
>> 'acpi_os_execute'
>> drivers/acpi/ec.c:467: error: 'OSL_EC_BURST_HANDLER' undeclared (first
>> use in this function)
>> drivers/acpi/ec.c:467: error: (Each undeclared identifier is reported
>> only once
>> drivers/acpi/ec.c:467: error: for each function it appears in.)
>> make[2]: *** [drivers/acpi/ec.o] Error 1
>> make[1]: *** [drivers/acpi] Error 2
>> make: *** [drivers] Error 2
>>
>>
>> Is there something I can do to get this going ?
>>
>>   
> change call to acpi_os_execute to call to 
> acpi_os_queue_for_execution() as it was in 2.6.17.
> It is just rename of the function in this case.

I changed this:
 status = acpi_os_execute(OSL_EC_BURST_HANDLER,acpi_ec_gpe_query, ec);

To this:
status = acpi_os_queue_for_execution(OSD_PRIORITY_MED,acpi_ec_gpe_query, 
ec);

Not sure if this is the right thing there: OSD_PRIORITY_MED

It compiles with a warning:

# make
CHK     include/linux/version.h
CHK     include/linux/compile.h
LD [M]  drivers/acpi/processor.o
Kernel: arch/i386/boot/bzImage is ready  (#29)
Building modules, stage 2.
 MODPOST
WARNING: drivers/acpi/processor.o - Section mismatch: reference to
 .init.data: from .text between 'acpi_processor_power_init' (at
 offset 0xe75) and 'acpi_safe_halt'


 LD [M]  drivers/acpi/processor.k


Is this warning a problem  ?

Well, nothing seems to have changed it works as before. Still no events 
received by acpid

>>>> Otherwise I'll just leave it, and hopefully in a year or so I'll be 
>>>> able  to upgrade.
>>>>
>>>>       
>>> Ok.
>>>    
>>>> Thanks,
>>>> Nigel.
>>>> -
>>>> To unsubscribe from this list: send the line "unsubscribe 
>>>> linux-acpi" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>       
>>> -
>>> To unsubscribe from this list: send the line "unsubscribe 
>>> linux-acpi" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>     
>>
>> _________________________________________________________________
>> Explore the seven wonders of the world
>> http://search.msn.com/results.aspx?q=7+wonders+world&mkt=en-US&form=QBRE
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> </pre
>
