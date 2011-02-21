From: Huang Ying <ying.huang@intel.com>
Subject: [PATCH 0/7] ACPI, APEI patches for 2.6.39
Date: Mon, 21 Feb 2011 13:54:38 +0800
Message-ID: <1298267685-7357-1-git-send-email-ying.huang@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:60137 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750765Ab1BUFyt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 21 Feb 2011 00:54:49 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, Tony Luck <tony.luck@intel.com>, ying.huang@intel.com, linux-acpi@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

[PATCH 1/7] Add Kconfig option ARCH_HAVE_NMI_SAFE_CMPXCHG
[PATCH 2/7] lib, Add lock-less NULL terminated single list
[PATCH 3/7] ACPI, APEI, Add ERST record ID cache
[PATCH 4/7] PCIe, AER, use pre-generated prefix in error information printing
[PATCH 5/7] ACPI, APEI, Add PCIe AER error information printing support
[PATCH 6/7] lib, Make gen_pool memory allocator lockless
[PATCH 7/7] ACPI, APEI, GHES, printk support for recoverable error via NMI
