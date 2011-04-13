From: Huang Ying <ying.huang@intel.com>
Subject: [PATCH -v3 0/4] ACPI, APEI, GHES, printk support for recoverable error via NMI
Date: Wed, 13 Apr 2011 16:53:51 +0800
Message-ID: <1302684835-14133-1-git-send-email-ying.huang@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, Tony Luck <tony.luck@intel.com>, ying.huang@intel.com, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

v3:

- Some changes to lock-less list based on Mathieu's comments

v2:

- Update some comments of llist per Mathieu's comments


[PATCH -v3 1/4] Add Kconfig option ARCH_HAVE_NMI_SAFE_CMPXCHG
[PATCH -v3 2/4] lib, Add lock-less NULL terminated single list
[PATCH -v3 3/4] lib, Make gen_pool memory allocator lockless
[PATCH -v3 4/4] ACPI, APEI, GHES, printk support for recoverable error via NMI
