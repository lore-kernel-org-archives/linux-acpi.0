From: Thomas Jaeger <thjaeger@gmail.com>
Subject: Re: PNPACPI: use _CRS IRQ descriptor length for _SRS
Date: Sat, 24 May 2008 14:55:20 -0400
Message-ID: <48386498.6010006@gmail.com>
References: <200805231629.24421.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.181]:34558 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750871AbYEXSzX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 24 May 2008 14:55:23 -0400
Received: by py-out-1112.google.com with SMTP id p76so906111pyb.10
        for <linux-acpi@vger.kernel.org>; Sat, 24 May 2008 11:55:22 -0700 (PDT)
In-Reply-To: <200805231629.24421.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Adam Belay <ambx1@neo.rr.com>, Adam M Belay <abelay@mit.edu>, Matthieu Castet <castet.matthieu@free.fr>, Li Shaohua <shaohua.li@intel.com>, Len Brown <lenb@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Robert Moore <Robert.Moore@intel.com>, linux-acpi@vger.kernel.org

Bjorn Helgaas wrote:
> [This fixes a long-standing parport PNPACPI bug, and it would
> nice to have it in 2.6.26.]
>   
I agree, especially since the ground work has already been laid in 
1d5b285da1893b90507b081664ac27f1a8a3dc5b.
> @@ -799,11 +802,14 @@ static void pnpacpi_encode_irq(struct pn
>  		irq->sharable = ACPI_SHARED;
>  	irq->interrupt_count = 1;
>  	irq->interrupts[0] = p->start;
> +	irq->descriptor_length = resource->data.irq.descriptor_length;
>   
I don't understand the point of this line.  Aren't 
irq->descriptor_length and resource->data.irq.descriptor_length the same 
thing?

Bjorn, while we're on the subject, could you have a look at 
http://bugzilla.kernel.org/show_bug.cgi?id=9487#c32 ? I've noticed that 
you've already fixed the third point there; the other two points may 
well be irrelevant or never occur in practice, but then they could be 
the sort of thing that costs somebody hours of debugging time.

Thanks,
Tom
