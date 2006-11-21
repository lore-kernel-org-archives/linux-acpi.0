From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: RE: [PATCH] allow the highest frequency if bios think so.
Date: Tue, 21 Nov 2006 07:08:57 -0800
Message-ID: <EB12A50964762B4D8111D55B764A8454E76E62@scsmsx413.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:25162 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S1030847AbWKUPJQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 21 Nov 2006 10:09:16 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bruno Ducrot <ducrot@poupinou.org>, davej@redhat.com
Cc: cpufreq@lists.linux.org.uk, linux-acpi@vger.kernel.org

 

>-----Original Message-----
>From: cpufreq-bounces@lists.linux.org.uk 
>[mailto:cpufreq-bounces@lists.linux.org.uk] On Behalf Of Bruno Ducrot
>Sent: Tuesday, November 21, 2006 5:52 AM
>To: davej@redhat.com
>Cc: cpufreq@lists.linux.org.uk; linux-acpi@vger.kernel.org
>Subject: Re: [PATCH] allow the highest frequency if bios think so.
>
>On Tue, Nov 21, 2006 at 11:30:42AM +0100, Bruno Ducrot wrote:
>> Hi all,
>> 
>> processor_perflib.c::acpi_processor_ppc_notifier() check if the value
>> returned by the processor's _PPC method is 0 and return failed if so.
>> This is wrong since 0 indicate that the bios think the 
>processor can go
>> to the highest frequency.  This patch for example fix the HP 
>NX 6125 to
>> allow its highest frequency to be available.
>> 
>> Signed-off-by: Bruno Ducrot <ducrot@poupinou.org>
>> 
>> --- linux-2.6.19-rc6/drivers/acpi/processor_perflib.c	
>2006/11/21 10:18:39	1.1
>> +++ linux-2.6.19-rc6/drivers/acpi/processor_perflib.c	
>2006/11/21 10:18:55
>> @@ -83,8 +83,6 @@ static int acpi_processor_ppc_notifier(s
>>  		goto out;
>>  
>>  	ppc = (unsigned int)pr->performance_platform_limit;
>> -	if (!ppc)
>> -		goto out;


Hmmm Great find.....
A perfect example of the bug that was quietly hiding
under our noses all these years....

>>  	if (ppc > pr->performance->state_count)
>
>BTW I'm wondering if this check should be :
>	if (ppc >= pr->performance->state_count)
>>  		goto out;
>

Yes. I think this should change to >= as well.
Otherwise indexing states with this ppc can go out of bounds.

Thanks,
Venki
