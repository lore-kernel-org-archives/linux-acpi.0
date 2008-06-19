From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: linux-next: Tree for June 13: IO APIC breakage on HP nx6325
Date: Thu, 19 Jun 2008 02:25:50 +0200
Message-ID: <200806190225.51088.rjw@sisk.pl>
References: <20080613232214.394fd6fd.sfr@canb.auug.org.au> <200806190011.38548.rjw@sisk.pl> <Pine.LNX.4.55.0806182345380.7802@cliff.in.clinika.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.55.0806182345380.7802@cliff.in.clinika.pl>
Content-Disposition: inline
Sender: linux-next-owner@vger.kernel.org
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Ingo Molnar <mingo@elte.hu>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Thursday, 19 of June 2008, Maciej W. Rozycki wrote:
> On Thu, 19 Jun 2008, Rafael J. Wysocki wrote:
> 
> > >  With such a configuration the "x86: I/O APIC: timer through 8259A
> > > second-chance" patch should not matter, because the only change it
> > > introduces is an attempt to try the same I/O APIC pin again, but with the
> > > IRQ0 line of the master 8259A enabled.  That's not a terribly unusual 
> > > configuration and nothing should get confused in the system.
> > 
> > But it _does_ get confused, really.
> 
>  Something certainly gets confused, but so far I am not sure which bit 
> exactly it is, are you?

No, I'm not.

> > >  Barring the unlikely possibility of the 8259A actually being wired to 
> > > INTIN2 of the I/O APIC I can see two possible explanations:
> > > 
> > > 1. The 8259A interrupt actually escapes to the CPU somehow and is handled
> > >    as an ExtINTA interrupt.  This would make the code in check_timer()  
> > >    decide it has found a working configuration, while actually it has been
> > >    fooled.
> [...]
> > Here you go:
> > 
> > [    0.108006] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
> > [    0.108006] ..MP-BIOS bug: 8254 timer not connected to IO-APIC
> > [    0.108006] ...trying to set up timer (IRQ0) through the 8259A ... <3>
> > [    0.108006] ..... (found apic 0 pin 2) ...<3> works.
> > 
> > The full dmesg is at: http://www.sisk.pl/kernel/debug/20080618/dmesg-1.log
> 
>  Thanks.  In this case I suspect the case #1 quoted above happens, that is
> the 8259A manages to deliver its interrupt somehow.  Note at this stage it
> is meant to be in the AEOI mode, so it can happily resubmit the interrupt
> indefinitely with no additional handling as long as it receives INTA
> cycles.
> 
>  Can you please try the patch below on top of "x86: I/O APIC: timer
> through 8259A second-chance" to see whether my hypothesis is true?  It
> modifies the through-8259A setup path so that the APIC input gets masked,
> but the 8259A has the timer interrupt still enabled.  Let me know how the
> timer interrupt is routed in this case.

That helped a lot, the system seems to work normally now.

Here's the relevant snippet from dmesg:

[    0.108006] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.108006] ..MP-BIOS bug: 8254 timer not connected to IO-APIC
[    0.108006] ...trying to set up timer (IRQ0) through the 8259A ... <3>
[    0.108006] ..... (found apic 0 pin 2) ...<3> failed.
[    0.108006] ...trying to set up timer as Virtual Wire IRQ...<3> works.

and the whole thing is at: http://www.sisk.pl/kernel/debug/20080618/dmesg-2.log
 
>  BTW, do we have any piece of technical information about the chipset
> used?

I, personally, don't have any and AMD only has SB600 documentation on its
web page (it's still marked as "AMD confidential" ;-)).

> The southbridge used is an ATI SB400, which is where I would 
> normally expect two 8259A and an I/O APIC core to be placed.

There is an interrupt controller in there, but I'm not sure if there's any
8259A.  The northbridge is on the CPU, actually.

Thanks,
Rafael
