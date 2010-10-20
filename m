From: Stefan Assmann <sassmann@redhat.com>
Subject: Re: lost parts of "pci, acpi: reroute PCI interrupt to legacy boot
 interrupt equivalent" during merge
Date: Wed, 20 Oct 2010 18:28:06 +0200
Message-ID: <4CBF1896.70901@redhat.com>
References: <4CBEDA90020000780001E290@vpn.id2.novell.com> <20101020134848.GB7970@elte.hu> <AANLkTi=LWrOKow7Nw8dr_YZTeMGncP+Vowz3EZK5vShD@mail.gmail.com> <20101020152453.GD22271@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37408 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753989Ab0JTQaA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 20 Oct 2010 12:30:00 -0400
In-Reply-To: <20101020152453.GD22271@elte.hu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jan Beulich <JBeulich@novell.com>, Takashi Iwai <tiwai@suse.de>, Junio C Hamano <gitster@pobox.com>, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, Len Brown <lenb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>

On 20.10.2010 17:24, Ingo Molnar wrote:
> 
> * Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
>> On Wed, Oct 20, 2010 at 6:48 AM, Ingo Molnar <mingo@elte.hu> wrote:
>>>
>>> I re-created the merge commit the following way:
>>>
>>>  git checkout c2f4398           # has old drivers/acpi/pci_irq.c
>>>  git merge 662c319              # contains new drivers/acpi/pci_irq.c bits
>>
>> The other way around. The c2f4398 version is the new one, the 662c319 is the old 
>> one. So git picks the new one.
> 
> Ah, indeed - i got confused by the fact that the newer tree had the 'older' content 
> of drivers/acpi/pci_irq.c. (which was really a new version as you noted)
> 
> Found the right commit as well - that chunk got zapped by:
> 
>  |
>  | commit ec9f168fcc344d2ffec1c8c822076bf22dab5c33
>  | Merge: b2576e1 087da3b
>  | Author: Len Brown <len.brown@intel.com>
>  | Date:   Fri Jan 9 03:41:08 2009 -0500
>  |
>  |    Merge branch 'simplify_PRT' into release
>  |    
>  |    Conflicts:
>  |        drivers/acpi/pci_irq.c
>  |    
>  |    Note that this merge disables
>  |    e1d3a90846b40ad3160bf4b648d36c6badad39ac
>  |    pci, acpi: reroute PCI interrupt to legacy boot interrupt equivalent
>  |    
>  |    Signed-off-by: Len Brown <len.brown@intel.com>
>  |
> 
> And was marked thusly by Len. So everything is in order - this chunk fell victim to 
> non-trivial merge complications and needs a resurrection.

Let me take a look at the current situation and see if I can come up
with a solution. Sorry if things got messy.

  Stefan
--
Stefan Assmann         | Red Hat GmbH
Software Engineer      | Otto-Hahn-Strasse 20, 85609 Dornach
                       | HR: Amtsgericht Muenchen HRB 153243
                       | GF: Brendan Lane, Charlie Peters,
sassmann at redhat.com |     Michael Cunningham, Charles Cachera
