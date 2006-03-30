From: glen martin <lists@locutory.org>
Subject: Re: FIXED: no /proc/acpi, trying to dump dsdt to a file
Date: Wed, 29 Mar 2006 23:47:37 -0800
Message-ID: <442B8D19.3040500@locutory.org>
References: <554C5F4C5BA7384EB2B412FD46A3BAD10F0D2A@pdsmsx411.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from m198-163.dsl.rawbw.com ([198.144.198.163]:28409 "EHLO
	slowpoke.locutory.org") by vger.kernel.org with ESMTP
	id S1751017AbWC3Hrh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 30 Mar 2006 02:47:37 -0500
In-Reply-To: <554C5F4C5BA7384EB2B412FD46A3BAD10F0D2A@pdsmsx411.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Yu, Luming" <luming.yu@intel.com>
Cc: linux-acpi@vger.kernel.org

Well, maybe. Under linux with the broken table, the system mostly sorta 
worked. One thing that didn't was the on-mobo ethernet. the 
reverse-engineered forcedeth would load, but not work. On Windows, 
NVidia's proprietary driver may have a different way to figure out 
whatever the DSDT would provide, and so not need the DSDT data.

glen

Yu, Luming wrote:

>Then, Linux could need to forgive it too. :-)
>--Luming
>
>
>  
>
>>Yes, no problems detected under WinXP Pro. Somehow Windows is 
>>forgiving 
>>of these issues.
>>
>>glen
>>
>>
>>Yu, Luming wrote:
>>
>>    
>>
>>>>Or at least, I'm past my pain, thanks to a lot of help from 
>>>>Robert and Len.
>>>>
>>>>To recap:
>>>>
>>>>The DSDT in my BIOS was very broken, such that ACPI didn't load up 
>>>>properly.  This meant I was having trouble reading the data 
>>>>   
>>>>
>>>>        
>>>>
>>>>from my BIOS 
>>> 
>>>
>>>      
>>>
>>>>using /proc/acpi/dsdt.
>>>>   
>>>>
>>>>        
>>>>
>>>Does windows works with such broken BIOS ?
>>>
>>>      
>>>

