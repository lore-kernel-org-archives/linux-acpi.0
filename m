From: Huang Ying <ying.huang@intel.com>
Subject: [PATCH -v4 0/4] ACPI, APEI, GHES, printk support for recoverable error via NMI
Date: Tue, 26 Apr 2011 16:34:34 +0800
Message-ID: <1303806878-333-1-git-send-email-ying.huang@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:7890 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751107Ab1DZIel (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 26 Apr 2011 04:34:41 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, Tony Luck <tony.luck@intel.com>, ying.huang@intel.com, linux-acpi@vger.kernel.org

v4:

- Add rcu_read_lock/unlock in lockless gen_pool implementation, at least we
  need that for future pool shrinking support.

v3:

- Some changes to lock-less list based on Mathieu's comments

v2:

- Update some comments of llist per Mathieu's comments

[PATCH -v4 1/4] Add Kconfig option ARCH_HAVE_NMI_SAFE_CMPXCHG
[PATCH -v4 2/4] lib, Add lock-less NULL terminated single list
[PATCH -v4 3/4] lib, Make gen_pool memory allocator lockless
[PATCH -v4 4/4] ACPI, APEI, GHES, printk support for recoverable error via NMI
