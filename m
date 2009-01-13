From: Jon Masters <jcm@redhat.com>
Subject: Re: PCI, ACPI, IRQ, IOAPIC: reroute PCI interrupt to legacy boot
	interrupt equivalent
Date: Mon, 12 Jan 2009 19:29:23 -0500
Message-ID: <1231806563.4094.25.camel@perihelion.bos.jonmasters.org>
References: <alpine.LFD.2.00.0901091743310.20020@localhost.localdomain>
	 <496B24E5.1070804@suse.de> <200901121151.53195.bjorn.helgaas@hp.com>
	 <m1d4esxfk2.fsf@frodo.ebiederm.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:33053 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752218AbZAMAa2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 12 Jan 2009 19:30:28 -0500
In-Reply-To: <m1d4esxfk2.fsf@frodo.ebiederm.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Stefan Assmann <sassmann@suse.de>, Len Brown <lenb@kernel.org>, Ingo Molnar <mingo@elte.hu>, Jesse Barnes <jbarnes@virtuousgeek.org>, Olaf Dabrunz <od@suse.de>, Thomas Gleixner <tglx@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Sven Dietrich <sdietrich@novell.com>, "Maciej W. Rozycki" <macro@linux-mips.org>

On Mon, 2009-01-12 at 15:36 -0800, Eric W. Biederman wrote:

> This hardware behavior is not specific to boot interrupts or Intel.

It's not specific to Intel, but it is a specific compatibility behavior.

> Is this case really so interesting and compelling that we want to fight
> through and figure what we need to do to make this work reliably on every
> x86 chipset?

How else do you propose implementing IRQ handling in e.g. the RT kernel?
We get a hardware interrupt, we can't FastEOI, we can't process
synchronously, we can't do all of those things you might expect.
Implementing RT requires that we delay handling of the IRQ until
arbitrarily later in the future when we get around to it.

Jon.


