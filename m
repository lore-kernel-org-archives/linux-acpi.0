From: Huang Ying <ying.huang@intel.com>
Subject: [PATCH 00/17] ACPI, APEI, Patches for 3.1
Date: Wed, 13 Jul 2011 13:14:11 +0800
Message-ID: <1310534068-30547-1-git-send-email-ying.huang@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:9791 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750705Ab1GMFOc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 13 Jul 2011 01:14:32 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, Tony Luck <tony.luck@intel.com>, ying.huang@intel.com, linux-acpi@vger.kernel.org

Including some bug fixes,  APEI _OSC support, recoverable error
printk support and memory error recovery support.

[PATCH 01/17] ACPI, APEI, HEST, Detect duplicated hardware error
[PATCH 02/17] ACPI, APEI, ERST, Prevent erst_dbg from loading if
[PATCH 03/17] ACPI, APEI, ERST, Fix erst-dbg long record reading
[PATCH 04/17] ACPI, APEI, GHES, Do not ratelimit fatal error printk
[PATCH 05/17] ACPI, APEI, Add apei_exec_run_optional
[PATCH 06/17] ACPI, APEI, Use apei_exec_run_optional in APEI EINJ
[PATCH 07/17] ACPI, APEI, GHES, Prevent GHES to be built as module
[PATCH 08/17] ACPI, APEI, GHES, Support disable GHES at boot time
[PATCH 09/17] ACPI, APEI, Add APEI bit support in generic _OSC call
[PATCH 10/17] ACPI, APEI, Add WHEA _OSC support
[PATCH 11/17] Add Kconfig option ARCH_HAVE_NMI_SAFE_CMPXCHG
[PATCH 12/17] lib, Add lock-less NULL terminated single list
[PATCH 13/17] lib, Make gen_pool memory allocator lockless
[PATCH 14/17] ACPI, APEI, GHES, printk support for recoverable error
[PATCH 15/17] ACPI, APEI, GHES, Error records content based throttle
[PATCH 16/17] HWPoison: add memory_failure_queue()
[PATCH 17/17] ACPI, APEI, GHES: Add hardware memory error recovery
