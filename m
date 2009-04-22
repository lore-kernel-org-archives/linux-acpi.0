From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: Re: [FIXED] EEE PC hangs when booting off battery
Date: Wed, 22 Apr 2009 13:17:01 +0100
Message-ID: <49EF0ABD.2080801@tuffmail.co.uk>
References: <49E065CF.6040408@tuffmail.co.uk> <200904140859.02188.bjorn.helgaas@hp.com> <20090414081728.10de978a@infradead.org> <200904140948.37633.bjorn.helgaas@hp.com> <49E5F01B.2060201@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.243]:64219 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750830AbZDVMRJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 22 Apr 2009 08:17:09 -0400
In-Reply-To: <49E5F01B.2060201@tuffmail.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, linux-acpi@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

Alan Jenkins wrote:
> Bjorn Helgaas wrote:
>   
>> On Tuesday 14 April 2009 09:17:28 am Arjan van de Ven wrote:
>>   
>>     
>>> On Tue, 14 Apr 2009 08:59:01 -0600
>>> Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:
>>>
>>>     
>>>       
>>>> I can't help with the real problem of why the asynchronous battery
>>>> init causes the hang.
>>>>       
>>>>         
>>> that got fixed already for the module case.
>>>     
>>>       
>> But apparently still broken for the builtin case?  I think Alan is
>> running pretty new bits -- he said "latest git" on April 11.
>>   
>>     
>
> It's now fixed, in 2.6.30-rc2.  My battery is modular btw.  I suspect
>
> 5d38258ec026921a7b266f4047ebeaa75db358e5 "ACPI battery: fix async boot
> oops" [removal of __init]
>
> was not sufficient to fix my problem, but it was solved by the "real" fix,
>
> d6de2c80e9d758d2e36c21699117db6178c0f517 "async: Fix module loading
> async-work regression" [module loading waits on async work]
>
>
> I would argue there's still a question over why the asynchronous battery
> init (_with_ the oops fix) should cause a hang in the idle routine.  But
> since the regression is fixed, it's not exactly an urgent question.
>   

Ugh.  Recently I tried building the battery driver into the kernel, to
benefit from the async work.  Later, I tried booting from the battery
and it hung again.

This time, the kernel did not even respond to SysRq.  I tried
nmi_watchdog=1 and waiting 2 minutes, but the watchdog didn't trigger
either.  As before, it doesn't happen with acpi=off.

I checked that this still happened in todays rc3, and it doesn't happen
if I revert

0f66af530116e9f4dd97f328d91718b56a6fc5a4 "ACPI: battery: asynchronous init"

Regards
Alan
