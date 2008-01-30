From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: an error an bug
Date: Wed, 30 Jan 2008 16:39:17 +0300
Message-ID: <47A07E05.9020108@gmail.com>
References: <0JVG006G88DEB9@szxml04-in.huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.189]:15636 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755601AbYA3NjW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Jan 2008 08:39:22 -0500
Received: by fk-out-0910.google.com with SMTP id z23so188557fkz.5
        for <linux-acpi@vger.kernel.org>; Wed, 30 Jan 2008 05:39:20 -0800 (PST)
In-Reply-To: <0JVG006G88DEB9@szxml04-in.huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: xuqiang <likes@huawei.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "acpi@linux.intel.com" <acpi@linux.intel.com>

xuqiang wrote:
> Alexey Starikovskiy,??!
>
> 	ok, I will get all needed information. But can you tell me what [\_SB_.RPME] [\_SB_.RDPE] and [\_GPE._L18] mean?  
>
>   
_L18 is ACPI level-triggered event #18. _GPE._L18 is a BIOS provided (in 
DSDT table) handler for this event.
It calls some other routines, which in the end try to access some 
address in system memory (RAM). Handler of
such accesses somehow is not happy with that. Acpidump will provide us 
with source of DSDT, so we will be able to
look for any problem with these routines.

Regards,
Alex.
> ======= 2008-01-30 11:33:00 ???????:=======
>
>   
>> Hi Likes,
>>
>> What kernel are you using?
>> Please open bug in bugzilla.kernel.org for ACPI and provide all needed 
>> information, including dmesg (from the beginning) and acpidump.
>>
>> xuqiang wrote:
>>     
>>> hi,all:
>>>    an error happened. in an hour, more than 30 million lines were repeated and writed to /var/log/messages and /var/log/warn.
>>> Jan  1 05:08:06 bond0 kernel:     ACPI-0347: *** Error: Handler for [SystemMemory] returned AE_NO_MEMORY
>>> Jan  1 05:08:06 bond0 kernel:     ACPI-1133: *** Error: Method execution failed [\_SB_.RDPE] (Node cdf7aec0), AE_NO_MEMORY
>>> Jan  1 05:08:06 bond0 kernel:     ACPI-1133: *** Error: Method execution failed [\_SB_.RPME] (Node cdf7ae20), AE_NO_MEMORY
>>> Jan  1 05:08:06 bond0 kernel:     ACPI-1133: *** Error: Method execution failed  (Node cdf7ad80), AE_NO_MEMORY
>>> Jan  1 05:08:06 bond0 kernel:     ACPI-0295: *** Error: AE_NO_MEMORY while evaluating method [_L18] for GPE[ 0]
>>> ]
>>>  where can I get enough information to understand the error or who can tell me  what the method means?		
>>>
>>> likes
>>> likes@huawei.com
>>> 2008-01-30
>>>
>>>
>>> -
>>> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>   
>>>       
>
> = = = = = = = = = = = = = = = = = = = =
> 			
>
> ?
> ?!
>  
> 				 
> xuqiang
> likes@huawei.com
> 2008-01-30
>
>
>
>   

