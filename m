From: Andrew de Quincey <adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
Subject: Re: Possible quick fix for ACPI routing problem on Nforce2
Date: Sun, 13 Jul 2003 02:18:44 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200307130218.44398.adq_dvb@lidskialf.net>
References: <200307122352.45704.adq_dvb@lidskialf.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200307122352.45704.adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
Content-Disposition: inline
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

Hi, I've been playing about with this, and I've found what is happening.
I've not yet tracked down the reason yet, but if anyone else has this
problem, can they try please this fix to see if it is consistent.

Anyway, IRQs > 15 get set to Active low/Level Sensitive in the IO-APIC on
my board.

The fix (No patch as this is NOT a proper fix):
Edit arch/i386/kernel/io_apic.c
Find the function io_apic_set_pci_routing() (its the last one in 2.5.74).
Change the line:
entry.polarity = 1;         /* Low active */

To:
entry.polarity = 0;         /* High active */

For me, this makes everything work fine. Originally, I also forced these
IRQs to be edge sensitive, but leaving them at level seems to work fine as
well.

Now, I assume one of the other functions in io_apic.c is _meant_ to be
called to set this correctly. My next step is to track down why this is not
occurring.

A question: Why are these set to level/activelow in a function which is
labelled to be setting up PCI IRQs? I'd assumed they were always
edge/active high.. or is this not necessarily the case?



-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
