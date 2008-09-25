From: "Yinghai Lu" <yinghai@kernel.org>
Subject: Re: [PATCH 7/7] x86: print out irq nr for msi/ht -v2
Date: Thu, 25 Sep 2008 10:07:17 -0700
Message-ID: <86802c440809251007n71738552n88b8ebfc7ecd017f@mail.gmail.com>
References: <1222323223-23529-1-git-send-email-yhlu.kernel@gmail.com>
	 <200809250900.24736.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.238]:27945 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751672AbYIYRHS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 25 Sep 2008 13:07:18 -0400
Received: by rv-out-0506.google.com with SMTP id k40so529237rvb.1
        for <linux-acpi@vger.kernel.org>; Thu, 25 Sep 2008 10:07:17 -0700 (PDT)
In-Reply-To: <200809250900.24736.bjorn.helgaas@hp.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Len Brown <lenb@kernel.org>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org

On Thu, Sep 25, 2008 at 8:00 AM, Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:
> On Thursday 25 September 2008 12:13:43 am Yinghai Lu wrote:
>> v2: fix hpet compiling
>>
>> Signed-off-by: Yinghai Lu <yhlu.kernel@gmail.com>
>> ---
>>  arch/x86/kernel/hpet.c    |    3 +++
>>  arch/x86/kernel/io_apic.c |    7 +++++++
>>  2 files changed, 10 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
>> index 422c577..686505a 100644
>> --- a/arch/x86/kernel/hpet.c
>> +++ b/arch/x86/kernel/hpet.c
>> @@ -467,6 +467,9 @@ static int hpet_setup_irq(struct hpet_dev *dev)
>>       irq_set_affinity(dev->irq, cpumask_of_cpu(dev->cpu));
>>       enable_irq(dev->irq);
>>
>> +     printk(KERN_DEBUG "hpet: %s is using irq %#x aka %d for MSI\n",
>> +                      dev->name, dev->irq, dev->irq);
>> +
>
> Why do we want to print the irq as hex?  Do we do that anywhere else?
> I think we should pick one format and stick with it, and I think
> decimal is the logical choice because it's the most common.

when sparseirq is enabled, irq for msi will be bus_nr/dev/func + 12bits.
so show it as hex is more straight. but we can not use hex in
/proc/interrupts --ABI want decimal.

just try to print out...in log, so user could get some idea that who
is using it...

YH
