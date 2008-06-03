From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [patch 14/15] PNP: support optional IRQ resources
Date: Tue, 03 Jun 2008 22:25:18 +0200
Message-ID: <4845A8AE.30009@keyaccess.nl>
References: <20080530224853.976744229@ldl.fc.hp.com> <20080530224934.156287156@ldl.fc.hp.com> <48458141.9020409@keyaccess.nl> <200806031421.00767.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtpq2.groni1.gr.home.nl ([213.51.130.201]:46392 "EHLO
	smtpq2.groni1.gr.home.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751685AbYFCUZ1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 3 Jun 2008 16:25:27 -0400
In-Reply-To: <200806031421.00767.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Adam M Belay <abelay@mit.edu>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>, Takashi Iwai <tiwai@suse.de>

On 03-06-08 22:20, Bjorn Helgaas wrote:

> On Tuesday 03 June 2008 11:37:05 am Rene Herman wrote:
>>> Index: work10/include/linux/ioport.h
>>> ===================================================================
>>> --- work10.orig/include/linux/ioport.h	2008-05-20 13:34:58.000000000 -0600
>>> +++ work10/include/linux/ioport.h	2008-05-20 13:39:21.000000000 -0600
>>> @@ -59,6 +59,7 @@ struct resource_list {
>>>  #define IORESOURCE_IRQ_HIGHLEVEL	(1<<2)
>>>  #define IORESOURCE_IRQ_LOWLEVEL		(1<<3)
>>>  #define IORESOURCE_IRQ_SHAREABLE	(1<<4)
>>> +#define IORESOURCE_IRQ_OPTIONAL		(1<<5)
>>>  
>>>  /* ISA PnP DMA specific bits (IORESOURCE_BITS) */
>>>  #define IORESOURCE_DMA_TYPE_MASK	(3<<0)
>> Andrew scooped up a patch from a previous reaction of mine that deleted 
>> the "ISA " from these comments. I tend to use comments as a great way of 
>> avoiding actually reading code (I'm silly like that) and so as to be 
>> burned a _bit_ less by it, I think it's good if they're accurate. In 
>> this case for example, one might be tempted to assume these bits were 
>> specific to drivers/pnp/isapnp.
> 
> Yes, I see that's pnpacpi-fix-irq-flag-decoding-comment-fix.patch
> in mmotm.  How about if I incorporate that in my series (the one
> Andrew hasn't yet picked up), since your patch will otherwise
> conflict with it?

Yep, that would be good.

Rene.
