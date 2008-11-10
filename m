From: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH 10/10] x86, ACPI: default to reboot via ACPI (again)
Date: Mon, 10 Nov 2008 10:54:01 +0200
Message-ID: <4917F6A9.3020408@redhat.com>
References: <007e7d616a5d1c2e16ad627d03f8b97799445e71.1226032943.git.len.brown@intel.com> <200811080930.21462.arvidjaar@mail.ru> <alpine.LFD.2.00.0811080208590.3092@localhost.localdomain> <200811081050.25477.arvidjaar@mail.ru> <20081108115956.GE8354@elte.hu> <4916B38B.7050905@redhat.com> <4916B4DB.90602@zytor.com> <20081110083938.GD22392@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:39648 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753478AbYKJIzI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 10 Nov 2008 03:55:08 -0500
In-Reply-To: <20081110083938.GD22392@elte.hu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: "H. Peter Anvin" <hpa@zytor.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrey Borzenkov <arvidjaar@mail.ru>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Eduardo Habkost <ehabkost@redhat.com>, Andrew Morton <akpm@linux-foundation.org>

Ingo Molnar wrote:
> * H. Peter Anvin <hpa@zytor.com> wrote:
>
>   
>> Avi Kivity wrote:
>>     
>>> I think the sequence should be acpi -> kbd -> triple fault.  Given that
>>> Windows uses ACPI, the number of machines that support it is much larger
>>> (and growing daily) than the number of machines that do not.
>>>
>>>       
>> Like with many other things ACPI, there probably should be an ACPI 
>> date cutoff for using it by default.  There is also port CF9 reboot 
>> (often incorrectly described as "PCI reboot", but it has nothing to 
>> do with the PCI standard.)
>>     
>
> so, the sequence should be:
>
>  [ acpi if date > 2007 ] -> kbd -> triple fault
>
>   

2007?  Maybe 2002, a year after Windows XP was launched?

Windows XP uses ACPI by default.  Not sure about reboot, but I wouldn't 
be surprised if it did, since it's such a simple feature, not involving 
AML etc.

> Where in this sequence should we insert port-CF9 reboot? We have no 
> discovery of it, etc. The KGDB reboot will do _something_ on most 
> boxes, so inserting it like this:
>
>  [ acpi	if date	> 2007 ] -> kbd -> port-CF9 -> triple fault
>   

Most likely ACPI uses port CF9 if it's available.

> ... will likely have no practical impact as we rarely get to the 
> triple fault method to begin with. So the reboot chain we'd like to 
> have is:
>
>  [ acpi	if date	> 2007 ] -> safe-port-CF9 -> kbd -> triple fault
>
> ... where safe-port-CF9 is something that can be done safely on all 
> x86 boxes.
>
> Anyway, safe-port-CF9 aside, the ACPI sequence should definitely be 
> cutoff based, so the plain re-introduction of the patch that changes 
> the default is not acceptable.
>   

What the vmx issues showed us is that keyboard reset is unreliable on 
some machines, so reset was actually done by triple-fault, which doesn't 
work well when vmx is enabled (if it's connected to INIT; note it won't 
reset peripherals in that case).

-- 
error compiling committee.c: too many arguments to function

