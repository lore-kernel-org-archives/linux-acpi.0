From: Jon Masters <jcm@redhat.com>
Subject: Re: PCI, ACPI, IRQ, IOAPIC: reroute PCI interrupt to legacy boot
	interrupt equivalent
Date: Mon, 12 Jan 2009 23:26:38 -0500
Message-ID: <1231820798.4094.34.camel@perihelion.bos.jonmasters.org>
References: <alpine.LFD.2.00.0901091743310.20020@localhost.localdomain>
	 <496B24E5.1070804@suse.de> <200901121151.53195.bjorn.helgaas@hp.com>
	 <m1d4esxfk2.fsf@frodo.ebiederm.org>
	 <1231806563.4094.25.camel@perihelion.bos.jonmasters.org>
	 <20090113014723.GA11366@elte.hu>  <m1prirx3xn.fsf@frodo.ebiederm.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:53188 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751409AbZAME1J (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 12 Jan 2009 23:27:09 -0500
In-Reply-To: <m1prirx3xn.fsf@frodo.ebiederm.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Ingo Molnar <mingo@elte.hu>, Bjorn Helgaas <bjorn.helgaas@hp.com>, Stefan Assmann <sassmann@suse.de>, Len Brown <lenb@kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Olaf Dabrunz <od@suse.de>, Thomas Gleixner <tglx@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Sven Dietrich <sdietrich@novell.com>, "Maciej W. Rozycki" <macro@linux-mips.org>

On Mon, 2009-01-12 at 19:47 -0800, Eric W. Biederman wrote:
> Ingo Molnar <mingo@elte.hu> writes:

> > a number of mainline drivers also mask/unmask irqs from within the IRQ 
> > handler. It's not particularly smart in a native driver, but can happen - 
> > and if we get an active line after that point (and this can happen because 
> > the driver is active), we are in trouble.
> 
> Yep.  Right now it might be simpler to fix the mainline drivers.

Taking the easy option now doesn't make the pain go away later :) Just
because ACPI doesn't provide a handy description doesn't mean we
shouldn't handle "boot interrupts" - the kernel is riddled with quirks
already to deal with broken, buggy, or just quirky hardware scenarios.

> We are outside the descriptions provided by ACPI so it requires
> chipset specific knowledge, and a general understanding of how
> chipsets work to actually even comprehend the problem.

But how does that differ from most other chipset code? I'm not being
belligerent but I'm not seeing how your argument is uniquely special to
this particular situation. Personally, I'm a little biased because I'd
eventually like to see RT merged upstream and I /know/ that's going to
re-open this whole can of worms once again, even if it's "fixed" now.

Jon.


