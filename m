From: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] Full dropback to PIC mode
Date: Sun, 31 Aug 2003 01:55:25 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030831005525.GP13467@parcelfarce.linux.theplanet.co.uk>
References: <200308310146.13936.adq_dvb@lidskialf.net> <200308310214.18628.adq_dvb@lidskialf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200308310214.18628.adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
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

On Sun, Aug 31, 2003 at 02:14:18AM +0100, Andrew de Quincey wrote:
> Actually, turns out its much easier than I thought.
> 
> This patch includes the changes necessary for ia64 and x86_64.
> Unfortunately I 
> cannot compile or test them, but I hope there isn't too much wrong with them 
> to get them going.

There aren't any ia64 boxes with PIC -- they're all SAPIC.  So for ia64,
just have a dummy function that fails in a header file somewhere.

> BTW: vanilla linux-2.4.22 with ACPI and IOSAPIC is broken at compile time.. 
> pci_irq.c/acpi_pci_irq_init() calls nonexistent method iosapic_parse_prt(). 
> 
> In the patch for 2.4.22, I've changed acpi_pci_irq_init() to be in line with 
> 2.6.0-test4, but that method is still going to be missing from 
> ia64/kernel/isoapic.c.

Try Bjorn's ia64 patch (I don't think there's one for 2.4.22 yet, but
it's available from lia64.bkbits.net).


-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
