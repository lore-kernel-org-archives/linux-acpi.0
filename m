From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 10/10] x86, ACPI: default to reboot via ACPI (again)
Date: Mon, 10 Nov 2008 10:02:41 +0100
Message-ID: <20081110090241.GH22392@elte.hu>
References: <007e7d616a5d1c2e16ad627d03f8b97799445e71.1226032943.git.len.brown@intel.com> <200811080930.21462.arvidjaar@mail.ru> <alpine.LFD.2.00.0811080208590.3092@localhost.localdomain> <200811081050.25477.arvidjaar@mail.ru> <20081108115956.GE8354@elte.hu> <4916B38B.7050905@redhat.com> <4916B4DB.90602@zytor.com> <20081110083938.GD22392@elte.hu> <4917F6A9.3020408@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:40090 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754025AbYKJJDA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 10 Nov 2008 04:03:00 -0500
Content-Disposition: inline
In-Reply-To: <4917F6A9.3020408@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Avi Kivity <avi@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrey Borzenkov <arvidjaar@mail.ru>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Eduardo Habkost <ehabkost@redhat.com>, Andrew Morton <akpm@linux-foundation.org>


* Avi Kivity <avi@redhat.com> wrote:

> Ingo Molnar wrote:
>> * H. Peter Anvin <hpa@zytor.com> wrote:
>>
>>   
>>> Avi Kivity wrote:
>>>     
>>>> I think the sequence should be acpi -> kbd -> triple fault.  Given that
>>>> Windows uses ACPI, the number of machines that support it is much larger
>>>> (and growing daily) than the number of machines that do not.
>>>>
>>>>       
>>> Like with many other things ACPI, there probably should be an ACPI  
>>> date cutoff for using it by default.  There is also port CF9 reboot  
>>> (often incorrectly described as "PCI reboot", but it has nothing to  
>>> do with the PCI standard.)
>>>     
>>
>> so, the sequence should be:
>>
>>  [ acpi if date > 2007 ] -> kbd -> triple fault
>>
>>   
>
> 2007?  Maybe 2002, a year after Windows XP was launched?

the _first_ flag year should generally be close to the current status 
quo - otherwise we risk breaking a lot more boxes in the interim. 
Then, once the whole approach has proven out to work fine for new 
boxes, can we lower the flag year.

there's no need to argue about this much. We had our chance with ACPI 
reboot, it didnt work, now we simply _have_ to be careful about it. No 
ifs and when.

>> Anyway, safe-port-CF9 aside, the ACPI sequence should definitely be 
>> cutoff based, so the plain re-introduction of the patch that 
>> changes the default is not acceptable.
>
> What the vmx issues showed us is that keyboard reset is unreliable 
> on some machines, so reset was actually done by triple-fault, which 
> doesn't work well when vmx is enabled (if it's connected to INIT; 
> note it won't reset peripherals in that case).

well then we could insert CF9 to before the triple fault, and solve 
some of the problems as well, without unnecessary risks.

This is a separate patch from ACPI reboot itself, naturally.

	Ingo
