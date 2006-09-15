From: "Roger Lucas" <roger@planbit.co.uk>
Subject: RE: Kernel eats memory with LG-81  motherboard , acpi_operand possible culprit?
Date: Fri, 15 Sep 2006 17:41:37 +0100
Message-ID: <20060915164139.7BBA412EDE@bluewhale.planbit.co.uk>
References: <450ACC29.4080409@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from 82-71-36-240.dsl.in-addr.zen.co.uk ([82.71.36.240]:29579 "EHLO
	bluewhale.planbit.co.uk") by vger.kernel.org with ESMTP
	id S1750729AbWIOQll (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 15 Sep 2006 12:41:41 -0400
In-Reply-To: <450ACC29.4080409@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: 'Alexey Starikovskiy' <alexey_y_starikovskiy@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, "'Suietov, Fiodor F'" <fiodor.f.suietov@intel.com>

Hi Alexey,

Thanks for the quick responses - it looks like I either need to
path+recompile the 2.6.16.20 kernel to allow a replacement DSDT file or use
the 2.6.17.13 kernel.

Can you clarify exactly what memory leak you think is the problem?  I don't
mind trying the 2.6.17.x kernel, but I would like to know exactly what the
problem being resolved is.

Thanks,

Roger

> -----Original Message-----
> From: Alexey Starikovskiy [mailto:alexey_y_starikovskiy@linux.intel.com]
> Sent: 15 September 2006 16:52
> To: Suietov, Fiodor F
> Cc: Roger Lucas; linux-acpi@vger.kernel.org
> Subject: Re: Kernel eats memory with LG-81 motherboard , acpi_operand
> possible culprit?
> 
> Roger,
> Please try to upgrade to 2.6.17.x, as it probably contains a fix to your
> memory leak.
> 
> Regards,
> Alex.
> 
> Suietov, Fiodor F wrote:
> > Perhaps, it is related to #6514:
> >
> > http://bugzilla.kernel.org/show_bug.cgi?id=6514
> >
> > Thanks,
> >  Fiodor
> >
> >> -----Original Message-----
> >> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> >> owner@vger.kernel.org] On Behalf Of Alexey Starikovskiy
> >> Sent: Friday, September 15, 2006 6:41 PM
> >> To: Roger Lucas
> >> Cc: linux-acpi@vger.kernel.org
> >> Subject: Re: Kernel eats memory with LG-81 motherboard , acpi_operand
> >> possible culprit?
> >>
> >> Roger,
> >>
> >> Please try to change Store(Local0, Local0) to Store(Zero, Local0) and
> >> check if you still have a leak...
> >>
> >> Thanks,
> >> Alex.
> >>
> >> Roger Lucas wrote:
> >>> Some more information...
> >>>
> >>> It seems that there are bugs in the DSDT information.  I followed
> > the
> >>> instructions on this link to analyse the DSDT table.
> >>>
> >>> http://gentoo-wiki.com/HOWTO_Fix_Common_ACPI_Problems
> >>>
> >>> When I recompiled it, the following errors occurred.  I have no idea
> >> what
> >>> these mean or if they are important, but I suspect that they are not
> >> good.
> >>> The BIOS ASL was originally compiled with the Microsoft compiler.
> >>>
> >>> root@hydra:~# iasl -tc dsdt.dsl
> >>>
> >>> Intel ACPI Component Architecture
> >>> ASL Optimizing Compiler version 20051216 [Jan  9 2006]
> >>> Copyright (C) 2000 - 2005 Intel Corporation
> >>> Supports ACPI Specification Revision 3.0
> >>>
> >>> dsdt.dsl   361:     Method (\_WAK, 1, NotSerialized)
> >>> Warning  2078 -                 ^ Reserved method must return a
> > value
> >> (_WAK)
> >>> dsdt.dsl   394:             Store (Local0, Local0)
> >>> Error    1048 -                         ^ Method local variable is
> > not
> >>> initialized (Local0)
> >>>
> >>> dsdt.dsl   399:             Store (Local0, Local0)
> >>> Error    1048 -                         ^ Method local variable is
> > not
> >>> initialized (Local0)
> >>>
> >>> dsdt.dsl  5349:                 If (Or (PLCY, PLCY, Local7))
> >>> Warning  2097 -                      ^ Statement is unreachable
> >>>
> >>> ASL Input:  dsdt.dsl - 5433 lines, 178284 bytes, 2002 keywords
> >>> Compilation complete. 2 Errors, 2 Warnings, 0 Remarks, 537
> > Optimizations
> >>> root@hydra:~#
> >> -
> >> To unsubscribe from this list: send the line "unsubscribe linux-acpi"
> > in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >

