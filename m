From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 07/18] ACPI: Adjust system_state check
Date: Tue, 16 May 2017 20:13:15 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1705162011530.2095@nanos>
References: <20170514182716.347236777@linutronix.de> <20170514183613.002084749@linutronix.de> <20170515102700.0037d156@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:41075 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751291AbdEPSNe (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 16 May 2017 14:13:34 -0400
In-Reply-To: <20170515102700.0037d156@gandalf.local.home>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

On Mon, 15 May 2017, Steven Rostedt wrote:

> 
> [ added linux-acpi and took off arm list ;-) ]
> 
> On Sun, 14 May 2017 20:27:23 +0200
> Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> > To enable smp_processor_id() and might_sleep() debug checks earlier, it's
> > required to add system states between SYSTEM_BOOTING and SYSTEM_RUNNING.
> > 
> > Make the decision wether a pci root is hotplugged depend on SYSTEM_RUNNING
> > instead of !SYSTEM_BOOTING.
> > 
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: linux-arm-kernel@lists.infradead.org
> > ---
> >  drivers/acpi/pci_root.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > --- a/drivers/acpi/pci_root.c
> > +++ b/drivers/acpi/pci_root.c
> > @@ -523,7 +523,7 @@ static int acpi_pci_root_add(struct acpi
> >  	struct acpi_pci_root *root;
> >  	acpi_handle handle = device->handle;
> >  	int no_aspm = 0;
> > -	bool hotadd = system_state != SYSTEM_BOOTING;
> > +	bool hotadd = system_state == SYSTEM_RUNNING;
> 
> What about the other boot states greater than SYSTEM_RUNNING? Can this
> be called then too?
> 
> IOW, should it be:
> 
> 	bool hotadd = system_state >= SYSTEM_RUNNING;

Greater than RUNNING is HALT,POWEROFF,RESTART. Having a PCI hotplug event
there would be interesting :) I'll amend the changelog.

Thanks,

	tglx




