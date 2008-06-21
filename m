From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: linux-next: Tree for June 13: IO APIC breakage on HP nx6325
Date: Sat, 21 Jun 2008 13:38:22 +0100
Message-ID: <20080621123822.GA27686@srcf.ucam.org>
References: <20080613232214.394fd6fd.sfr@canb.auug.org.au> <200806201353.59083.rjw@sisk.pl> <20080620115714.GC8637@srcf.ucam.org> <200806201422.12659.rjw@sisk.pl> <20080620122714.GA9332@srcf.ucam.org> <Pine.LNX.4.55.0806202241120.19614@cliff.in.clinika.pl> <20080621014047.GA20908@srcf.ucam.org> <Pine.LNX.4.55.0806210321470.19614@cliff.in.clinika.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0806210321470.19614@cliff.in.clinika.pl>
Sender: linux-next-owner@vger.kernel.org
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Ingo Molnar <mingo@elte.hu>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Sat, Jun 21, 2008 at 03:41:37AM +0100, Maciej W. Rozycki wrote:

>  Maybe, though your code seems to match product IDs rather than the broken
> DSDT itself.  I think the latter would be preferable as it would cover all
> the pieces of equipment using the broken piece of firmware rather than
> ones we have already tracked down.  Perhaps the version could be included
> too, but that would only make sense if the breakage ever gets fixed -- the
> use of the through-8259A mode for the 8254 timer would allow this piece of
> equipment to benefit from the I/O APIC driven NMI watchdog.

I haven't seen any other machines with this issue, so I suspect that 
this is HP-specific code. I'll look into what would need doing to quirk 
it off the DSDT strings, though.

>  Not exactly.  The IRQ0->2 mapping is certainly wrong here, but so is the
> identity IRQ0->0 one.  Which means it should not be recorded in
> mp_config_acpi_legacy_irqs() at all.  I can cook this part if you'd rather
> not to, if you do the ACPI part.  If you think there is no easy way to
> match the DSDT rather than the product ID -- we are trying to cope with
> outright breakage here after all, so any amount of effort is too much ;)  
> -- I can update your proposal with what I have in mind.

Ok, that works for me.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
