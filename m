From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH 00/14] ACPI 2.0: Enable TermList interpretion and early
 opeartion region accesses for table loading
Date: Fri, 19 Feb 2016 06:40:40 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E883BB4D6A2@SHSMSX101.ccr.corp.intel.com>
References: <cover.1454730659.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:28008 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161045AbcBSGkp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Feb 2016 01:40:45 -0500
In-Reply-To: <cover.1454730659.git.lv.zheng@intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>
Cc: Lv Zheng <zetalog@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Hi, Rafael

> From: Zheng, Lv
> Subject: [PATCH 00/14] ACPI 2.0: Enable TermList interpretion and early
> opeartion region accesses for table loading
> 

<skip>

> 
> PATCH 01-02: The initrd installation testing facility.
> PATCH 03-07: Entropy reduction stuff in ACPICA.

PATCH 03-06 were just sent in ACPICA 20160212 release series.
So this patchset need to be re-arranged and sent again after the 20160212 release cycle.

But PATCH 01-02 looks not so closely related to this patchset.
Maybe you can help to check to see if they are upstreamable.
If they are merged, then I needn't send them again in v2 series.
Thanks in advance.

Best regards
-Lv

> PATCH 08-10: Entropy reduction stuff in EC driver and ACPI subsystem's
>              initialization order.
> PATCH 12:    The first step enabling.
> PATCH 13:    The code to facilitate AML 2.0 table loading.
> PATCH 14:    The second step enabling.
> 
> Lv Zheng (14):
>   ACPI / OSL: Cleanup initrd table override code
>   ACPI / OSL: Add support to install tables via initrd
>   ACPI 2.0 / AML: Make default region accessible during the table load
>   ACPI 2.0 / AML: Tune _REG evaluations order in the initialization
>     steps
>   ACPI 2.0 / AML: Ensure \_SB._INI executed before any _REG
>   ACPI 2.0 / AML: Rename acpi_gbl_reg_methods_enabled to
>     acpi_gbl_namespace_initialized
>   ACPICA: Events: Fix an issue that _REG association can happen before
>     namespace is initialized
>   ACPI 2.0 / ECDT: Split EC_FLAGS_HANDLERS_INSTALLED
>   ACPI 2.0 / ECDT: Remove early namespace reference from EC
>   ACPI 2.0 / ECDT: Enable correct ECDT initialization order
>   ACPI 2.0 / AML: Improve module level execution by moving the
>     If/Else/While execution to per-table basis
>   ACPI 2.0 / AML: Add TermList parsing support for table loading
>   ACPI 2.0 / AML: Enable correct ACPI subsystem initialization order
>     for new table loading mode
>   ACPI 2.0 / AML: Fix module level execution by correctly parsing table
>     as TermList
