From: John Wong <kernel-AAfBIQCtFhbR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] Drop back to extended IRQ resource type
Date: Tue, 2 Sep 2003 09:23:12 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030902162312.GA1011@gambit.implode.net>
References: <20030829045032.GA688@gambit.implode.net> <200308301956.41007.adq_dvb@lidskialf.net> <20030902154820.GA961@gambit.implode.net> <200309021753.36646.adq_dvb@lidskialf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200309021753.36646.adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andrew de Quincey <adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Andew Grover <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

My card does work, but I'm am using the XFree86 nv driver since nVidia's
binary driver doesn't yet work with kernel 2.6.  I will try the 2.4.22
patch and the nVidia binary driver afterwards.

My dmesg does show a mapping to IRQ 27.

Pin 2-16 already programmed
    ACPI-1121: *** Error: Method execution failed [\_SB_.SRS_] (Node
cefdbca0), 
AE_AML_BUFFER_LIMIT
    ACPI-1121: *** Error: Method execution failed [\_SB_.LNKE._SRS]
(Node cef437
a0), AE_AML_BUFFER_LIMIT
ACPI: Retrying with extended IRQ descriptor
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 11
IOAPIC[0]: Set PCI routing entry (2-11 -> 0xd1 -> IRQ 27 Mode:1
Active:0)
00:02:00[A] -> 2-11 -> IRQ 27


On Tue, Sep 02, 2003 at 05:53:36PM +0100, Andrew de Quincey wrote:
> On Tuesday 02 Sep 2003 4:48 pm, John Wong wrote:
> > The patch does appear to give the card an IRQ, but it does not appear to
> > be valid.  Doesn't the IRQ only go up to 24 on a single APIC processor?
> > The IRQ of 27 does not get registered in /proc/interrupts either.
> 
> Check the debug printout of the IO-APIC in your dmesg to see if IRQ 27 is 
> valid... it should have lines saying its mapping IRQ 27 to  particular input 
> on an IO-APIC.
> 
> 


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
