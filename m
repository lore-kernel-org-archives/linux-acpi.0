From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: PCI, ACPI, IRQ, IOAPIC: reroute PCI interrupt to legacy boot interrupt equivalent
Date: Wed, 14 Jan 2009 14:42:47 -0800
Message-ID: <m11vv5wlug.fsf@frodo.ebiederm.org>
References: <alpine.LFD.2.00.0901091743310.20020@localhost.localdomain>
	<496B24E5.1070804@suse.de> <200901121151.53195.bjorn.helgaas@hp.com>
	<m1d4esxfk2.fsf@frodo.ebiederm.org>
	<1231806563.4094.25.camel@perihelion.bos.jonmasters.org>
	<20090113014723.GA11366@elte.hu> <m1prirx3xn.fsf@frodo.ebiederm.org>
	<1231820798.4094.34.camel@perihelion.bos.jonmasters.org>
	<20090114114006.GF8625@elte.hu>
	<1231960709.23174.0.camel@londonpacket.bos.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out01.mta.xmission.com ([166.70.13.231]:43925 "EHLO
	out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755349AbZANWsJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Jan 2009 17:48:09 -0500
In-Reply-To: <1231960709.23174.0.camel@londonpacket.bos.redhat.com> (Jon
	Masters's message of "Wed, 14 Jan 2009 14:18:29 -0500")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jon Masters <jcm@redhat.com>
Cc: Ingo Molnar <mingo@elte.hu>, Bjorn Helgaas <bjorn.helgaas@hp.com>, Stefan Assmann <sassmann@suse.de>, Len Brown <lenb@kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Olaf Dabrunz <od@suse.de>, Thomas Gleixner <tglx@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Sven Dietrich <sdietrich@novell.com>, "Maciej W. Rozycki" <macro@linux-mips.org>

Jon Masters <jcm@redhat.com> writes:

> On Wed, 2009-01-14 at 12:40 +0100, Ingo Molnar wrote:
>
>> it's not just -rt, but it is also needed for the concept of threaded IRQ 
>> handlers - which was discussed at the Kernel Summit to be desired for 
>> mainline.
>
> Right. I'm poking at Thomas' patches and hope to post something soon on
> that front - I'm acutely aware that this will be impacted aswell but
> because it's vaguely RT related had banded it under that banner.

Stepping back a moment.  The only way I can see this working reliably
is if we disable the boot interrupt.  Anything that leaves the boot interrupt
enabled means that when we disable the primary interrupt the boot interrupt
will scream, and thus we must disable it as well.

Which leads to my problem with the entire development process of this feature.

 People want the feature.
 People don't want to pay attention to the limits of the hardware.
 Which leads to countless broken patches proposed.

Which leads me to conclude.
- IRQ handling in the RT kernel is hopelessly broken.
- IRQ threads are a bad idea.

Because it is all leading to stupid patches and stupid development.

None of this works reliably on level triggered ioapic irqs.

Eric
