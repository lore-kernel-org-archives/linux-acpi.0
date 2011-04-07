From: Huang Ying <ying.huang@intel.com>
Subject: [PATCH	-v2 0/4] ACPI, APEI, GHES, printk support for recoverable error via NMI
Date: Thu,  7 Apr 2011 09:29:02 +0800
Message-ID: <1302139746-1030-1-git-send-email-ying.huang@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:40761 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755887Ab1DGB3R (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 6 Apr 2011 21:29:17 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, Tony Luck <tony.luck@intel.com>, ying.huang@intel.com, linux-acpi@vger.kernel.org

v2:

- Update some comments of llist per Mathieu's comments


[PATCH -v2 1/4] Add Kconfig option ARCH_HAVE_NMI_SAFE_CMPXCHG
[PATCH -v2 2/4] lib, Add lock-less NULL terminated single list
[PATCH -v2 3/4] lib, Make gen_pool memory allocator lockless
[PATCH -v2 4/4] ACPI, APEI, GHES, printk support for recoverable error via NMI
