From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: PCI, ACPI, IRQ, IOAPIC: reroute PCI interrupt to legacy boot interrupt equivalent
Date: Mon, 12 Jan 2009 15:36:29 -0800
Message-ID: <m1d4esxfk2.fsf@frodo.ebiederm.org>
References: <alpine.LFD.2.00.0901091743310.20020@localhost.localdomain>
	<496B24E5.1070804@suse.de> <200901121151.53195.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out01.mta.xmission.com ([166.70.13.231]:54110 "EHLO
	out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751995AbZALXr7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 12 Jan 2009 18:47:59 -0500
In-Reply-To: <200901121151.53195.bjorn.helgaas@hp.com> (Bjorn Helgaas's
	message of "Mon, 12 Jan 2009 11:51:51 -0700")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Stefan Assmann <sassmann@suse.de>, Len Brown <lenb@kernel.org>, Ingo Molnar <mingo@elte.hu>, Jesse Barnes <jbarnes@virtuousgeek.org>, Olaf Dabrunz <od@suse.de>, Thomas Gleixner <tglx@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Sven Dietrich <sdietrich@novell.com>, "Maciej W. Rozycki" <macro@linux-mips.org>, Jon Masters <jcm@redhat.com>


I don't get it. Why are we trying to do such a stupid thing?

This hardware behavior is not specific to boot interrupts or Intel.
This is the classic x86 ioapic behaviour of redirecting a ioapic irq
into a legacy irq when the ioapic entry is disabled.

If you really want not to have problems ensure all irqs 0-15
are disabled, and not needed.  Otherwise you are taking the chance
on something like this happening.

Disabling irqs generically appears to be a crap shoot, and not on a
path hardware vendors look at or care about heavily.  Disabling an irq
in hardware on every interrupt, increasing the cost of the interrupt
and walking down these neglected hardware paths seems stupid.  Especially
when the interrupt line might be shared and we can be disabling several
devices at once.


Is this case really so interesting and compelling that we want to fight
through and figure what we need to do to make this work reliably on every
x86 chipset?

Eric
