From: Andrew de Quincey <adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
Subject: Re: Re: ACPI ignoring IRQ flags in PRT
Date: Sun, 13 Jul 2003 20:36:05 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200307132036.05761.adq_dvb@lidskialf.net>
References: <200307131452.39000.adq_dvb@lidskialf.net> <200307131745.42153.adq_dvb@lidskialf.net> <bes74d$ucr$1@main.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <bes74d$ucr$1@main.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Rob North <tzwvgwv2001-O/bDAPVd7B0N+BqQ9rBEUg@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


> Andrew, I think you're on to something big here.
> I've been having similiar problems with my A7N8x Deluxe motherboard, and
> I've been looking into the kernel code in the 2.4.X series of kernels,
> and you've definately found something that look amiss.
>
> I think what was throwing Matthew is that the interupt trigger types are
> specified in  _PRS objects
> The _PRT object is a mapping from PCI device to a particular "PCI
> Interrupt Link device" and in the defintion of the link device, the IRQs
> are defined in _PRS objects.

Yeah, I suspected I wasn't using the right terminology.

Where are the parameters for "global system interrupts" defined? It looks like 
we have to support this configuration method as well. The MADT table sounded 
likely, but that is only for overriding ISA IRQs. Where are >15 IRQs defined?



-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
