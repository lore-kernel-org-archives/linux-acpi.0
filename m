From: Jurriaan <thunder7-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>
Subject: Re: Re: Possible quick fix for ACPI routing problem on Nforce2
Date: Sun, 13 Jul 2003 07:39:13 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030713053913.GB1284@middle.of.nowhere>
References: <200307122352.45704.adq_dvb@lidskialf.net> <200307130218.44398.adq_dvb@lidskialf.net>
Reply-To: thunder7-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200307130218.44398.adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

From: Andrew de Quincey <adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
Date: Sun, Jul 13, 2003 at 02:18:44AM +0100
> Hi, I've been playing about with this, and I've found what is happening.
> I've not yet tracked down the reason yet, but if anyone else has this
> problem, can they try please this fix to see if it is consistent.
> 
> Anyway, IRQs > 15 get set to Active low/Level Sensitive in the IO-APIC on
> my board.
> 
> The fix (No patch as this is NOT a proper fix):
> Edit arch/i386/kernel/io_apic.c
> Find the function io_apic_set_pci_routing() (its the last one in 2.5.74).
> Change the line:
> entry.polarity = 1;         /* Low active */
> 
> To:
> entry.polarity = 0;         /* High active */
> 
> For me, this makes everything work fine. Originally, I also forced these
> IRQs to be edge sensitive, but leaving them at level seems to work fine as
> well.
> 
No joy on VIA KT400 chipset (bugzilla #678): ide0 get's IRQ 17, during
boot multiple oopses occur, starting with 'IRQ 17: nobody cared' right
after probing hda. Eventually it crashes hard, after probing hde.

Thanks,
Jurriaan
-- 
Pay attention, the wreckage seemed to declare. Some things cannot be
undone, short of time pivoting in its groove and crawling back on itself.
	Tad Williams - Otherland
Debian (Unstable) GNU/Linux 2.5.75 4112 bogomips load av: 1.06 0.44 0.16


-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
