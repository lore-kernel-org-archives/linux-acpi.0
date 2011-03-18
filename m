From: Lin Ming <ming.m.lin@intel.com>
Subject: Re: ACPICA release 20110211 linuxized patches
Date: Fri, 18 Mar 2011 10:16:33 +0800
Message-ID: <1300414593.29989.2.camel@minggr.sh.intel.com>
References: <1297672276.21742.21.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:55391 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755352Ab1CRCQr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 17 Mar 2011 22:16:47 -0400
In-Reply-To: <1297672276.21742.21.camel@minggr.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb <lenb@kernel.org>
Cc: "Moore, Robert" <robert.moore@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>

Hi, Len

Did you push these patches out to the linux-acpi-2.6.git repository?

Lin Ming

On Mon, 2011-02-14 at 16:31 +0800, Lin Ming wrote:
> Hi, Len
> 
> ACPICA release 20110211 linuxized patches attached.
> Applied cleanly on top of Linus tree(091994cf) and tested on my
> notebook.
> 
> [PATCH 1/9] ACPICA: GPE detect optimization - ignore unused GPE registers
> [PATCH 2/9] ACPICA: Remove use of unreliable FADT revision field
> [PATCH 3/9] ACPICA: Clarify a couple of error messages
> [PATCH 4/9] ACPICA: Split large utglobal into utdecode.c.
> [PATCH 5/9] ACPICA: Fix unresolved name issue for no-debug and no-error-msg cases
> [PATCH 6/9] ACPICA: Split large dsopcode and dsload.c files.
> [PATCH 7/9] ACPICA: Add support for FunctionalFixedHW in acpi_ut_get_region_name
> [PATCH 8/9] ACPICA: Add mechanism to defer _REG methods for some installed handlers
> [PATCH 9/9] ACPICA: Update version to 20110211.
> 
> Lin Ming


