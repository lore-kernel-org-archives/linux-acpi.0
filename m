From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: No battery status with 2.6.24-rcX anymore
Date: Sun, 16 Dec 2007 21:15:45 +0300
Message-ID: <47656B51.401@gmail.com>
References: <4762C081.4010000@willies.info> <200712160030.08991.rjw@sisk.pl> <476520FE.4080101@willies.info> <200712161534.16486.rjw@sisk.pl> <47653BA5.9020105@willies.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:39961 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752206AbXLPSPr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 16 Dec 2007 13:15:47 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1460726ugc.16
        for <linux-acpi@vger.kernel.org>; Sun, 16 Dec 2007 10:15:45 -0800 (PST)
In-Reply-To: <47653BA5.9020105@willies.info>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jan Willies <jan@willies.info>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

Jan Willies wrote:
> Rafael J. Wysocki wrote:
>   
>> On Sunday, 16 of December 2007, Jan Willies wrote:
>>     
>>> Rafael J. Wysocki wrote:
>>>       
>>>> On Saturday, 15 of December 2007, Jan Willies wrote:
>>>>         
>>>>> Len Brown wrote:
>>>>>           
>>>>>> On Friday 14 December 2007 12:42, Jan Willies wrote:
>>>>>>
>>>>>>             
>>>>>>> ACPI: Table DSDT replaced by host OS
>>>>>>>               
>>>>>> Sorry, can't help you if you are running a modified BIOS.
>>>>>>             
>>>>> Uh sorry, I totally forgot about that. It's just some compile errors fixed with intel compiler [1] and a little undervolting [2], don't know if it matters at all. Here is a clean log:
>>>>>           
>>>> [--snip--]
>>>>         
>>>>> What else information is needed?
>>>>>           
>>>> Have you tested the latest Linus' tree?  We've had some ACPI fixes recently.
>>>>         
>>> Latest as in 2.6.24-rc5-git3?
>>>       
>> Yes.
>>     
>
> No change with 2.6.24-rc5-git3. I used the tarball from [1], shortlog says last changes were made 3 days ago. I don't know if that is 'recently' enough?
>
>
> - Jan
>
> [1] http://www.kernel.org/pub/linux/kernel/v2.6/snapshots/patch-2.6.24-rc5-git3.bz2
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>   

Jan,
Please open bug at bugzilla.kernel.org, and append acpidump output, full 
dmesg and .config from your kernel.


Thanks,
Alex.
