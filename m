From: Len Brown <lenb@kernel.org>
Subject: Re: ACPICA release 20120816 linuxized patches
Date: Fri, 21 Sep 2012 00:29:14 -0400
Message-ID: <505BED1A.4000804@kernel.org>
References: <1342415080.3628.179.camel@minggr> <A74E4C03C808B649AF1F11527F2D44140335DA78@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:33511 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750804Ab2IUE3U (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Sep 2012 00:29:20 -0400
Received: by qcro28 with SMTP id o28so2308897qcr.19
        for <linux-acpi@vger.kernel.org>; Thu, 20 Sep 2012 21:29:19 -0700 (PDT)
In-Reply-To: <A74E4C03C808B649AF1F11527F2D44140335DA78@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Tang, Feng" <feng.tang@intel.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, "Moore, Robert" <robert.moore@intel.com>

Thanks for the series, Feng.

We are not doing as well here on checkpatch.pl compliance as I'd like --
something perhaps we can improve going forward?

thanks,
-Len

On 08/21/2012 10:42 PM, Tang, Feng wrote:
> Hi Len,
> 
> Here are the 20120816 ACPICA linuxized patches based on
> your acpi/next branch, please review.
> 
> [PATCH 01/12] ACPI: delelte more BFS/GTS related definition and code
> [PATCH 02/12] ACPICA: Enable Scope change to root during module-level code execution.
> [PATCH 03/12] ACPICA: Split ACPICA initialization functions to new file, utxfinit.c
> [PATCH 04/12] ACPICA: Comment update: Fix some typos in actble.h
> [PATCH 05/12] ACPICA: Add Windows8/Server2012 string for _OSI method.
> [PATCH 06/12] ACPICA: GPE Support: Update debug info for GPE tracing.
> [PATCH 07/12] ACPICA: Debug output: Update output for Processor object.
> [PATCH 08/12] ACPICA: GPE support: Remove extraneous parameter from low-level function.
> [PATCH 09/12] ACPICA: Headers: Add support for CSRT and DBG2 ACPI tables.
> [PATCH 10/12] ACPICA: Add support for complex _PLD buffers.
> [PATCH 11/12] ACPICA: Add struct header support for _FDE, _GRT, _GTM, and _SRT names.
> [PATCH 12/12] ACPICA: Update version to 20120816.
> 
> Thanks,
> Feng
> 

