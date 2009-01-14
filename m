From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: PCI, ACPI, IRQ, IOAPIC: reroute PCI interrupt to legacy boot interrupt equivalent
Date: Wed, 14 Jan 2009 08:48:07 -0700
Message-ID: <200901140848.08531.bjorn.helgaas@hp.com>
References: <alpine.LFD.2.00.0901091743310.20020@localhost.localdomain> <20090113082513.GA18449@sli10-desk.sh.intel.com> <496DB702.40302@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1763544AbZANPs0@vger.kernel.org>
In-Reply-To: <496DB702.40302@suse.de>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Assmann <sassmann@suse.de>
Cc: Shaohua Li <shaohua.li@intel.com>, Len Brown <lenb@kernel.org>, Ingo Molnar <mingo@elte.hu>, Jesse Barnes <jbarnes@virtuousgeek.org>, Olaf Dabrunz <od@suse.de>, Thomas Gleixner <tglx@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Sven Dietrich <sdietrich@novell.com>
List-Id: linux-acpi@vger.kernel.org

On Wednesday 14 January 2009 02:57:22 am Stefan Assmann wrote:
> Shaohua Li wrote:
> > So a device can generate interrupt from two irqs. And we can get the irq
> > number for the routing table. Can we extend the irq mechanism and
> > automatically register the interrupt handler for the two irqs?
> 
> This would not solve the problem of asserting 2 different interrupt
> lines, in the masked interrupt handling case, for 1 interrupt request.
> The result would be that the ISR is called twice and at the second call
> you can't be sure that the device hasn't already been serviced.

Calling the ISR twice isn't a problem, is it?  We're talking about
PCI interrupts, which are shareable, so ISRs have to handle being
called extra times.

There's still the problem that the core will disable an IRQ if we
take it too many times without any ISR that cares about it.  But that's
a core issue, not an ISR issue.

Bjorn
