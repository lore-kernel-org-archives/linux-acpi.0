From: Rob North <tzwvgwv2001-O/bDAPVd7B0N+BqQ9rBEUg@public.gmane.org>
Subject: Re: ACPI ignoring IRQ flags in PRT
Date: Sun, 13 Jul 2003 19:08:02 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <bes74d$ucr$1@main.gmane.org>
References: <200307131452.39000.adq_dvb@lidskialf.net> <20030713142321.GC20424@parcelfarce.linux.theplanet.co.uk> <200307131745.42153.adq_dvb@lidskialf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200307131745.42153.adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
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

Andrew de Quincey wrote:
> On Sunday 13 July 2003 15:23, Matthew Wilcox wrote:
> 

> 
> So, the code in io_apic.c is assuming that all IRQs > 15 are PCI-compatable. 
> For me, at least, they are not, *EVEN THOUGH they're in the _PRT*. The ACPI 
> tables are describing them as I have experimentally found them to be.
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email sponsored by: Parasoft
> Error proof Web apps, automate testing & more.
> Download & eval WebKing and get a free book.
> www.parasoft.com/bulletproofapps1

Andrew, I think you're on to something big here.
I've been having similiar problems with my A7N8x Deluxe motherboard, and
I've been looking into the kernel code in the 2.4.X series of kernels,
and you've definately found something that look amiss.

I think what was throwing Matthew is that the interupt trigger types are 
specified in  _PRS objects
The _PRT object is a mapping from PCI device to a particular "PCI 
Interrupt Link device" and in the defintion of the link device, the IRQs 
are defined in _PRS objects.

I'm about to re-compile a 2.4.22-pre3-ac1 kernel with your suggested 
quick fix.
Will report back.

Keep up the good work
	-Rob.




-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
