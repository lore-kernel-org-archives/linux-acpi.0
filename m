From: James Courtier-Dutton <James-l7zRWeYnyd2TY6FTCsQk+9Bc4/FLrbF6@public.gmane.org>
Subject: Re: ACPI vs. ISA IRQs
Date: Wed, 05 Nov 2003 00:03:08 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3FA83E3C.6070907@superbug.demon.co.uk>
References: <1067981294.6057.20.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1067981294.6057.20.camel-D2Zvc0uNKG8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, linux-acpi <linux-acpi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Len Brown wrote:
> Assumption: sharing interrupts is bad.
> 
> Plan:
> ACPI should attempt to distribute interrupts across
> the available IRQs.
> 
> This mostly applies to PIC mode, where PCI
> IRQ Link Devices are available to route PCI
> interrupts to open IRQs on the PIC.
> (In IO-APIC mode, we generally get no choice
>  which IO-APIC pins devices are attached to)
> 
> We have acpi_irq_penalty[] (disabled at the moment)
> in pci_link.c hard-coded to tell ACPI to avoid some IRQs
> that are commonly used by ISA devices.
> 
> But if,say, a sound-blaster card requests exclusive access
> to an IRQ that we didn't happen to reserve, and we happened
> to set a PCI link device to that IRQ, then sound doesn't
> work.
> 
> How to fix?
> 
> We can manually reserve IRQs to over-ride acpi_irq_penalty[],
> say "acpi_irq_used=5,10" to tell ACPI not to use IRQs that
> it thought by default were available.
> 
> Conversely, we could us, say, "acpi_irq_free=3,15" to tell
> ACPI that some IRQs it assumed were reserved for ISA are
> actually available for PCI.
> 
> I don't know of an automatic way to handle this.
> Seems that the ISA devices use Plug-and-Play methods
> to request IRQs, but there is no mechanism for such
> an event to boot a PIRQ off an IRQ if ACPI has put it there.
> Also, if such a mechanism existed, it wouldn't work
> if PNP were not available to ask for an IRQ.
> 
> thoughts?
> 
> thanks,
> -Len
> 
> ref:
> http://bugzilla.kernel.org/show_bug.cgi?id=430
> http://bugzilla.kernel.org/show_bug.cgi?id=1139
> http://bugzilla.kernel.org/show_bug.cgi?id=1391
> 
> 
This explains IRQs a bit: -
http://www.microsoft.com/whdc/hwdev/platform/proc/IO-APIC.mspx




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
