From: Andrew de Quincey <adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
Subject: Re: ACPI PCI routing problem
Date: Fri, 11 Jul 2003 13:56:22 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200307111356.22376.adq_dvb@lidskialf.net>
References: <200307110022.29512.adq_dvb@lidskialf.net> <200307111243.34695.adq_dvb@lidskialf.net> <20030711125126.GA22636@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030711125126.GA22636-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> > During boot it says: Found and enabled local APIC!
> > But does not have any mention of the IO-APIC.
> >
> >            CPU0
> >   0:      50946          XT-PIC  timer
> >   1:         16          XT-PIC  i8042
> >   2:          0          XT-PIC  cascade
> >  11:         13          XT-PIC  ohci-hcd
> >  12:        346          XT-PIC  ohci-hcd
> >  14:       1024          XT-PIC  ide0
> >  15:         18          XT-PIC  ide1
> > NMI:          0
> > LOC:      50874
> > ERR:         91
> > MIS:          0
>
> Then perhaps you may turn off IO-APIC.  I know there are troubles
> with some SiS based system.  Though, it may be problematic with
> NForce2 as well?
>
> A Guru of that kind of stuff should help more than me (Alan perhaps?).

Yeah, I can easily make it work by turning it off or supplying pci=noacpi. 
However, I'm pursuing this problem to develop a fix for the issue.

The new ACPI PCI routing seems to cause other people problems as well.. I've 
seen mention on various web pages. Not really a good situation to leave these 
problems in the OS.

Wish I had docs on the nforce2 chipset. Sigh.



-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
