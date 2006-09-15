From: Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>
Subject: Re: Kernel eats memory with LG-81  motherboard , acpi_operand possible
 culprit?
Date: Fri, 15 Sep 2006 18:40:57 +0400
Message-ID: <450ABB79.8050909@linux.intel.com>
References: <20060915143431.54E6912EDE@bluewhale.planbit.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:6333 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751590AbWIOOm1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 15 Sep 2006 10:42:27 -0400
In-Reply-To: <20060915143431.54E6912EDE@bluewhale.planbit.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Roger Lucas <roger@planbit.co.uk>
Cc: linux-acpi@vger.kernel.org

Roger,

Please try to change Store(Local0, Local0) to Store(Zero, Local0) and check if you still have a leak...

Thanks,
Alex.

Roger Lucas wrote:
> Some more information...
> 
> It seems that there are bugs in the DSDT information.  I followed the
> instructions on this link to analyse the DSDT table.
> 
> http://gentoo-wiki.com/HOWTO_Fix_Common_ACPI_Problems
> 
> When I recompiled it, the following errors occurred.  I have no idea what
> these mean or if they are important, but I suspect that they are not good.
> The BIOS ASL was originally compiled with the Microsoft compiler.
> 
> root@hydra:~# iasl -tc dsdt.dsl
> 
> Intel ACPI Component Architecture
> ASL Optimizing Compiler version 20051216 [Jan  9 2006]
> Copyright (C) 2000 - 2005 Intel Corporation
> Supports ACPI Specification Revision 3.0
> 
> dsdt.dsl   361:     Method (\_WAK, 1, NotSerialized)
> Warning  2078 -                 ^ Reserved method must return a value (_WAK)
> 
> dsdt.dsl   394:             Store (Local0, Local0)
> Error    1048 -                         ^ Method local variable is not
> initialized (Local0)
> 
> dsdt.dsl   399:             Store (Local0, Local0)
> Error    1048 -                         ^ Method local variable is not
> initialized (Local0)
> 
> dsdt.dsl  5349:                 If (Or (PLCY, PLCY, Local7))
> Warning  2097 -                      ^ Statement is unreachable
> 
> ASL Input:  dsdt.dsl - 5433 lines, 178284 bytes, 2002 keywords
> Compilation complete. 2 Errors, 2 Warnings, 0 Remarks, 537 Optimizations
> root@hydra:~#
