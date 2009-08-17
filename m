From: Lin Ming <ming.m.lin@intel.com>
Subject: Re: ACPICA Release 20090730 linuxized patches
Date: Mon, 17 Aug 2009 09:40:56 +0800
Message-ID: <1250473256.28336.11.camel@minggr.sh.intel.com>
References: <1250215084.2987.7.camel@minggr.sh.intel.com>
	 <alpine.LFD.2.00.0908142321200.30537@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:1395 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753612AbZHQBp3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 16 Aug 2009 21:45:29 -0400
In-Reply-To: <alpine.LFD.2.00.0908142321200.30537@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "Moore, Robert" <robert.moore@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>

On Sat, 2009-08-15 at 11:30 +0800, Len Brown wrote:
> On Fri, 14 Aug 2009, Lin Ming wrote:
> 
> > Hi, Len
> > 
> > ACPICA Release 20090730 linuxized patches attached.
> > Build&Test on 32&64 bit machines.
> > 
> > Applied cleanly on top of linux-acpi-2.6/test branch.
> > 
> > Lin Ming
> > ---
> > [PATCH 01/13] ACPICA: Move predefined repair code to new file, no functional change
> > [PATCH 02/13] ACPICA: Add repair for predefined methods that return nested packages
> > [PATCH 03/13] ACPICA: ACPI 4.0 : Add new return package type, restructure module.
> > [PATCH 04/13] ACPICA: Fix fault if acpi_terminate is called twice
> > [PATCH 05/13] ACPICA: Split large ACPI table header
> > [PATCH 06/13] ACPICA: ACPI 4: Update headers for new and changed ACPI tables.
> > [PATCH 07/13] ACPICA: reformat predefined method table, no functional change
> > [PATCH 08/13] ACPICA: ACPI 4: Add validation for new predefined names.
> > [PATCH 09/13] ACPICA: Add support for module-level executable AML code
> > [PATCH 10/13] ACPICA: Update definitions for HEST table
> > [PATCH 11/13] ACPICA: Fix typo for HEST ACPI table
> > [PATCH 12/13] ACPICA: acpi_reset: Bypass port validation mechanism
> > [PATCH 13/13] ACPICA: Update version to 20090730
> 
> thanks for the port, Lin-Ming.
> 
> checkpatch.pl, as usual, is not happy:
> 
> total: 389 errors, 103 warnings, 4771 lines checked

$checkpatch.pl acpica-v20090730.mbox | grep "ERROR:" | sort | uniq
ERROR: return is not a function, parentheses are not required
ERROR: space required after that close brace '}'
ERROR: space required after that ',' (ctx:VxV)
ERROR: spaces required around that '?' (ctx:VxE)

I think we don't need to fix these errors in order to decrease the gap
between ACPICA and linux-acpica code.

> 
> someday we need to address these formatting issues...

We need to document which error(s) need to be fixed.
Currently, only two errors are fixed.

ERROR: trailing whitespace
ERROR: code indent should use tabs where possible

Lin Ming

> 
> 
> thanks,
> Len Brown, Intel Open Source Technology Center
> 

