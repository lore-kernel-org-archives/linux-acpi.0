From: "Craig Whitmore" <lennon-q3Ck4f9/EBK9koe0gwxAeg@public.gmane.org>
Subject: Re: ACPI patches updated (20021111)
Date: Wed, 13 Nov 2002 13:46:12 +1300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <018101c28aae$105abd80$6df058db@PC2>
References: <EDC461A30AC4D511ADE10002A5072CAD04C7A4FF@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

ok. the lspci -vvvv can be found @ http://www.spam.co.nz/lspci
and the dsdt.dsl file can be found @ http://www.spam.co.nz/dsdt.dsl

Do you need anything else?


Thanks
Craig Whitmore






----- Original Message -----
From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
To: "'Craig Whitmore'" <lennon-q3Ck4f9/EBK9koe0gwxAeg@public.gmane.org>
Cc: <acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org>
Sent: Wednesday, November 13, 2002 1:17 PM
Subject: RE: [ACPI] ACPI patches updated (20021111)


> > From: Craig Whitmore [mailto:lennon-q3Ck4f9/EBK9koe0gwxAeg@public.gmane.org]
> > pci_link-0207 [08] acpi_pci_link_get_curr: Error evaluating _CRS
>
> Problem 1: _CRS error (possibly the cause of Problem 3 below)
>
> > ACPI: Embedded Controller [EC0] (gpe 53)
> > schedule_task(): keventd has not started
>
> Problem 2: EC driver doing something requiring keventd before it's
> available?
>
> >  pci_irq-0297 [08] acpi_pci_irq_derive   : Unable to derive
> > IRQ for device
> > 00:0f.2
> > PCI: No IRQ known for interrupt pin A of device 00:0f.2 - using IRQ 10
>
> Problem 3: _PRT entry Pin A of device f.2 missing
>
> > acpi_processor-2108 [-43] acpi_processor_get_inf: Invalid
> > PBLK length [0]
> > ACPI: Processor [CPU0] (supports C1)
>
> Problem 4: Invalid PBLK lengths for all 4 procs. Maybe this shouldn't be
an
> error, not sure.
>
> Could you:
>
> Make your DSDT available?
> Provide "lspci -vv" output?
>
> Regards -- Andy
>
>
> -------------------------------------------------------
> This sf.net email is sponsored by:
> To learn the basics of securing your web site with SSL,
> click here to get a FREE TRIAL of a Thawte Server Certificate:
> http://www.gothawte.com/rd522.html
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
>
>



-------------------------------------------------------
This sf.net email is sponsored by: 
To learn the basics of securing your web site with SSL, 
click here to get a FREE TRIAL of a Thawte Server Certificate: 
http://www.gothawte.com/rd522.html
