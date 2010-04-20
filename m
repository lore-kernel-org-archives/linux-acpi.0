From: Len Brown <lenb@kernel.org>
Subject: Re: ACPICA Release 20100331 linuxized patches
Date: Tue, 20 Apr 2010 10:51:17 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1004201050330.2402@sony>
References: <1270710730.3473.34.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from [12.175.186.2] ([12.175.186.2]:41717 "EHLO
	vbn.0055647.lodgenet.net" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1758822Ab0EABoc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 30 Apr 2010 21:44:32 -0400
In-Reply-To: <1270710730.3473.34.camel@minggr.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: "Moore, Robert" <robert.moore@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>

applied to acpi-test
(and acpica branch re-based to 2.6.34-rc5 to allow 8/9 to apply)

thanks,
Len Brown, Intel Open Source Technology Center

On Thu, 8 Apr 2010, Lin Ming wrote:

> Hi, Len
> 
> This patch series applied cleanly on top of your acpi/test branch.
> Build and test on my machine and it works well.
> 
> [PATCH 1/9] ACPICA: Update comments/headers, no functional change
> [PATCH 2/9] ACPICA: Fix for acpi_reallocate_root_table for incorrect root table copy
> [PATCH 3/9] ACPICA: Add write support for DataTable operation regions
> [PATCH 4/9] ACPICA: Add detection of corrupted/replaced DSDT
> [PATCH 5/9] ACPICA: Add subsystem option to force copy of DSDT to local memory
> [PATCH 6/9] ACPICA: Update DSDT copy/detection.
> [PATCH 7/9] ACPI: add boot option acpi=copy_dsdt to fix corrupt DSDT
> [PATCH 8/9] ACPICA: Minimize the differences between linux GPE code and ACPICA code base
> [PATCH 9/9] ACPICA: Update version to 20100331.
> 
> Patch 7 includes the acpi=copy_dsdt option, DMI backlist and customized
> ACPICA warning message for corrupt DSDT workaround (bug 14679).
> 
> Lin Ming
> 
> 
