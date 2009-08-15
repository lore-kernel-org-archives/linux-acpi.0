From: Len Brown <lenb@kernel.org>
Subject: Re: ACPICA Release 20090730 linuxized patches
Date: Fri, 14 Aug 2009 23:30:36 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0908142321200.30537@localhost.localdomain>
References: <1250215084.2987.7.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173015pub.verizon.net ([206.46.173.15]:35833 "EHLO
	vms173015pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751513AbZHODbn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 14 Aug 2009 23:31:43 -0400
Received: from localhost.localdomain ([64.140.212.33])
 by vms173015.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KOE00E05F4AXD74@vms173015.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 14 Aug 2009 22:31:23 -0500 (CDT)
In-reply-to: <1250215084.2987.7.camel@minggr.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: "Moore, Robert" <robert.moore@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>

On Fri, 14 Aug 2009, Lin Ming wrote:

> Hi, Len
> 
> ACPICA Release 20090730 linuxized patches attached.
> Build&Test on 32&64 bit machines.
> 
> Applied cleanly on top of linux-acpi-2.6/test branch.
> 
> Lin Ming
> ---
> [PATCH 01/13] ACPICA: Move predefined repair code to new file, no functional change
> [PATCH 02/13] ACPICA: Add repair for predefined methods that return nested packages
> [PATCH 03/13] ACPICA: ACPI 4.0 : Add new return package type, restructure module.
> [PATCH 04/13] ACPICA: Fix fault if acpi_terminate is called twice
> [PATCH 05/13] ACPICA: Split large ACPI table header
> [PATCH 06/13] ACPICA: ACPI 4: Update headers for new and changed ACPI tables.
> [PATCH 07/13] ACPICA: reformat predefined method table, no functional change
> [PATCH 08/13] ACPICA: ACPI 4: Add validation for new predefined names.
> [PATCH 09/13] ACPICA: Add support for module-level executable AML code
> [PATCH 10/13] ACPICA: Update definitions for HEST table
> [PATCH 11/13] ACPICA: Fix typo for HEST ACPI table
> [PATCH 12/13] ACPICA: acpi_reset: Bypass port validation mechanism
> [PATCH 13/13] ACPICA: Update version to 20090730

thanks for the port, Lin-Ming.

checkpatch.pl, as usual, is not happy:

total: 389 errors, 103 warnings, 4771 lines checked

someday we need to address these formatting issues...


thanks,
Len Brown, Intel Open Source Technology Center

