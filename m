From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [patch 15/18] PNP: support optional IRQ resources
Date: Mon, 16 Jun 2008 18:26:50 +0200
Message-ID: <4856944A.8040802@keyaccess.nl>
References: <20080604220933.168145536@ldl.fc.hp.com> <20080604221129.758385014@ldl.fc.hp.com> <4853814D.4010309@keyaccess.nl> <200806160941.49959.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtpq2.groni1.gr.home.nl ([213.51.130.201]:48324 "EHLO
	smtpq2.groni1.gr.home.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754383AbYFPQ0e (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Jun 2008 12:26:34 -0400
In-Reply-To: <200806160941.49959.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Adam M Belay <abelay@mit.edu>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>, Takashi Iwai <tiwai@suse.de>

On 16-06-08 17:41, Bjorn Helgaas wrote:

>>> @@ -176,33 +184,10 @@ static void quirk_ad1815_mpu_resources(s
>>>  	if (!irq || irq->next)
>>>  		return;
>>>  
>>> -	res = dev->dependent;
>>> -	if (!res)
>>> -		return;
>>> -
>>> -	while (1) {
>>> -		struct pnp_irq *copy;
>>> -
>>> -		copy = pnp_alloc(sizeof *copy);
>>> -		if (!copy)
>>> -			break;
>>> -
>>> -		bitmap_copy(copy->map.bits, irq->map.bits, PNP_IRQ_NR);
>>> -		copy->flags = irq->flags;
>>> -
>>> -		copy->next = res->irq; /* Yes, this is NULL */
>>> -		res->irq = copy;
>>> -
>>> -		if (!res->next)
>>> -			break;
>>> -		res = res->next;
>>> -	}
>>> -	kfree(irq);
>>> +	irq->flags |= IORESOURCE_IRQ_OPTIONAL;
>>> +	dev_info(&dev->dev, "made independent IRQ optional\n");
>>>  
>>>  	res->next = quirk_isapnp_mpu_options(dev);
>> 
>> ... this line should just go.
> 
> You mean I should delete the "res->next = quirk_isapnp_mpu_options(dev)"
> line?

Yes. With the optional flag, ad1815 doesn't need the cloning and due to 
the below it's actively wrong at this point in the series.

>> Previously "res" ended up as the last dependent set through the while 
>> loop but now it's the independendent set which in this previous setup of 
>> things shouldn't even have a ->next. Just deleting this line makes this 
>> patch fine and
>>
>> Acked-by: Rene Herman <rene.herman@gmail.com>
> 
> OK.  This will mean replacing patches 15 and 18 in this series.  If
> I repost those two, is that easy for you to deal with, Andrew?
> 
> If I replace these, I'll also update patch 18 to fix the
> pnp_independent_option() comment Rene made.

Rene.
