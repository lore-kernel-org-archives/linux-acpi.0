From: Cao jin <caoj.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v2] pci: fix unavailable irq number 255 reported by BIOS
Date: Wed, 27 Jan 2016 13:24:36 +0800
Message-ID: <56A85494.8070606@cn.fujitsu.com>
References: <1453705178-27389-1-git-send-email-chen.fan.fnst@cn.fujitsu.com>
 <20160125205803.GA10272@localhost> <alpine.DEB.2.11.1601260825510.3886@nanos>
 <20160126152221.GB9279@localhost> <alpine.DEB.2.11.1601261628450.3886@nanos>
 <20160127002505.GA3329@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([59.151.112.132]:64989 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752775AbcA0FYy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Jan 2016 00:24:54 -0500
In-Reply-To: <20160127002505.GA3329@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <helgaas@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Chen Fan <chen.fan.fnst@cn.fujitsu.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net, lenb@kernel.org, izumi.taku@jp.fujitsu.com, wency@cn.fujitsu.com, ddaney.cavm@gmail.com, okaya@codeaurora.org, bhelgaas@google.com, jiang.liu@linux.intel.com, linux-pci@vger.kernel.org



On 01/27/2016 08:25 AM, Bjorn Helgaas wrote:
> On Tue, Jan 26, 2016 at 04:48:25PM +0100, Thomas Gleixner wrote:
>> On Tue, 26 Jan 2016, Bjorn Helgaas wrote:


>>
>> Right. So we could certainly do something like this INVALID_IRQ thingy, but
>> that looks a bit weird. What would request_irq() return?
>>
>> If it returns success, then drivers might make the wrong decision. If it
>> returns an error code, then the i801 one works, but we might have to fix
>> others anyway.
>
> I was thinking request_irq() could return -EINVAL if the caller passed
> INVALID_IRQ.  That should tell drivers that this interrupt won't work.
>
> We'd be making request_irq() return -EINVAL in some cases where it
> currently returns success.  But even though it returns success today,
> I don't think the driver is getting interrupts, because the wire isn't
> connected.
>
>> I think it's better to have a software flag in pci_dev to indicate that there
>> is no irq line and fix up the (probably few) affected drivers so they avoid
>> calling request_irq() and take the right action.
>
> We could add an "irq_valid" flag in struct pci_dev and make a new
> rule that drivers should check dev->irq_valid before using dev->irq.
> But realistically, i801 is the only place that will check irq_valid
> because that's the only driver where we know about a problem, so that
> seems like sort of a point solution.
>
> Bjorn
>

How about using IRQ_BITMAP_BITS as that "irq_valid" flag? because it is 
the ceiling of struct irq_desc irq_desc[], and request_irq() will return 
-EINVAL in case of the ceiling.

#ifdef CONFIG_SPARSE_IRQ
# define IRQ_BITMAP_BITS	(NR_IRQS + 8196)
#else
# define IRQ_BITMAP_BITS	NR_IRQS
#endif

> .
>

-- 
Yours Sincerely,

Cao jin


