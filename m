From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: ISA -> ISA_ (Re: [GIT PATCH] ACPI patches for 2.6.25-rc6)
Date: Wed, 26 Mar 2008 22:21:42 +0300
Message-ID: <47EAA246.3050707@gmail.com>
References: <200803180510.47670.lenb@kernel.org> <200803260956.55804.bjorn.helgaas@hp.com> <47EA86D9.7040404@gmail.com> <200803261247.31531.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.191]:23824 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753556AbYCZTVu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Mar 2008 15:21:50 -0400
Received: by fk-out-0910.google.com with SMTP id 19so4894237fkr.5
        for <linux-acpi@vger.kernel.org>; Wed, 26 Mar 2008 12:21:47 -0700 (PDT)
In-Reply-To: <200803261247.31531.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Len Brown <lenb@kernel.org>, Ingo Molnar <mingo@elte.hu>, Corentin CHARY <corentincj@iksaif.net>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org

Bjorn Helgaas wrote:
> On Wednesday 26 March 2008 11:24:41 am Alexey Starikovskiy wrote:
>   
>> Bjorn Helgaas wrote:
>>     
>>> I'm curious about how this works.  I disassembled the DSDT from
>>> http://bugzilla.kernel.org/show_bug.cgi?id=4773 (I attached the disassembly
>>> at http://bugzilla.kernel.org/attachment.cgi?id=15448&action=view), and
>>> the _PRT contains "_SB" and "ISA" (no trailing underscores):
>>>
>>>                 Package (0x04)
>>>                 {
>>>                     0x000DFFFF, 
>>>                     0x00, 
>>>                     \_SB.PCI0.ISA.LNKA, 
>>>                     0x00
>>>                 }
>>>
>>> But by the time we get to acpi_pci_irq_add_entry(), we've added the
>>> underscores somewhere (see
>>> http://bugzilla.kernel.org/attachment.cgi?id=15423&action=view):
>>>
>>>   0000:00:0d[A] -> \_SB_.PCI0.ISA_.LNKA
>>>
>>> I don't know where this happens, but it certainly confused me, and
>>> it seems like it could lead to other bugs.
>>>   
>>>       
>> ACPI is supposed to add trailing underscore for pad all names to 4 bytes.
>> So ISA will be padded to ISA_.
>>     
>
> The questions are "where does this happen?" and "why does it not
> apply to other things like asus_acpi.c?"
>   
1. drivers/acpi/namespace/nsutils.c:419
