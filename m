From: "Suietov, Fiodor F" <fiodor.f.suietov@intel.com>
Subject: RE: Kernel eats memory with LG-81  motherboard , acpi_operand possible culprit?
Date: Fri, 15 Sep 2006 19:18:01 +0400
Message-ID: <3D8E84095C6A524A985B787423094E40433D01@mssmsx411>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:41274 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1751634AbWIOPSC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 15 Sep 2006 11:18:02 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Roger Lucas <roger@planbit.co.uk>
Cc: linux-acpi@vger.kernel.org

Perhaps, it is related to #6514:

http://bugzilla.kernel.org/show_bug.cgi?id=6514

Thanks,
 Fiodor

> -----Original Message-----
> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> owner@vger.kernel.org] On Behalf Of Alexey Starikovskiy
> Sent: Friday, September 15, 2006 6:41 PM
> To: Roger Lucas
> Cc: linux-acpi@vger.kernel.org
> Subject: Re: Kernel eats memory with LG-81 motherboard , acpi_operand
> possible culprit?
> 
> Roger,
> 
> Please try to change Store(Local0, Local0) to Store(Zero, Local0) and
> check if you still have a leak...
> 
> Thanks,
> Alex.
> 
> Roger Lucas wrote:
> > Some more information...
> >
> > It seems that there are bugs in the DSDT information.  I followed
the
> > instructions on this link to analyse the DSDT table.
> >
> > http://gentoo-wiki.com/HOWTO_Fix_Common_ACPI_Problems
> >
> > When I recompiled it, the following errors occurred.  I have no idea
> what
> > these mean or if they are important, but I suspect that they are not
> good.
> > The BIOS ASL was originally compiled with the Microsoft compiler.
> >
> > root@hydra:~# iasl -tc dsdt.dsl
> >
> > Intel ACPI Component Architecture
> > ASL Optimizing Compiler version 20051216 [Jan  9 2006]
> > Copyright (C) 2000 - 2005 Intel Corporation
> > Supports ACPI Specification Revision 3.0
> >
> > dsdt.dsl   361:     Method (\_WAK, 1, NotSerialized)
> > Warning  2078 -                 ^ Reserved method must return a
value
> (_WAK)
> >
> > dsdt.dsl   394:             Store (Local0, Local0)
> > Error    1048 -                         ^ Method local variable is
not
> > initialized (Local0)
> >
> > dsdt.dsl   399:             Store (Local0, Local0)
> > Error    1048 -                         ^ Method local variable is
not
> > initialized (Local0)
> >
> > dsdt.dsl  5349:                 If (Or (PLCY, PLCY, Local7))
> > Warning  2097 -                      ^ Statement is unreachable
> >
> > ASL Input:  dsdt.dsl - 5433 lines, 178284 bytes, 2002 keywords
> > Compilation complete. 2 Errors, 2 Warnings, 0 Remarks, 537
Optimizations
> > root@hydra:~#
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
