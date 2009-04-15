From: Alan Jenkins <alan-jenkins-cCz0Lq7MMjm9FHfhHBbuYA@public.gmane.org>
Subject: [FIXED] EEE PC hangs when booting off battery
Date: Wed, 15 Apr 2009 15:32:59 +0100
Message-ID: <49E5F01B.2060201@tuffmail.co.uk>
References: <49E065CF.6040408@tuffmail.co.uk> <200904140859.02188.bjorn.helgaas@hp.com> <20090414081728.10de978a@infradead.org> <200904140948.37633.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200904140948.37633.bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Sender: kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Cc: Arjan van de Ven <arjan-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kernel Testers List <kernel-testers-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Venkatesh Pallipadi <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Bjorn Helgaas wrote:
> On Tuesday 14 April 2009 09:17:28 am Arjan van de Ven wrote:
>   
>> On Tue, 14 Apr 2009 08:59:01 -0600
>> Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org> wrote:
>>
>>     
>>> I can't help with the real problem of why the asynchronous battery
>>> init causes the hang.
>>>       
>> that got fixed already for the module case.
>>     
>
> But apparently still broken for the builtin case?  I think Alan is
> running pretty new bits -- he said "latest git" on April 11.
>   

It's now fixed, in 2.6.30-rc2.  My battery is modular btw.  I suspect

5d38258ec026921a7b266f4047ebeaa75db358e5 "ACPI battery: fix async boot
oops" [removal of __init]

was not sufficient to fix my problem, but it was solved by the "real" fix,

d6de2c80e9d758d2e36c21699117db6178c0f517 "async: Fix module loading
async-work regression" [module loading waits on async work]


I would argue there's still a question over why the asynchronous battery
init (_with_ the oops fix) should cause a hang in the idle routine.  But
since the regression is fixed, it's not exactly an urgent question.

Thanks
Alan
