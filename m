From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v3 0/2] ACPI: DBGP/DBG2 early console support for LPIA.
Date: Thu, 27 Sep 2012 16:40:47 +0800
Message-ID: <cover.1348652044.git.lv.zheng@intel.com>
References: <cover.1347453194.git.zetalog@gmail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:35663 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751134Ab2I0AlG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 26 Sep 2012 20:41:06 -0400
In-Reply-To: <cover.1347453194.git.zetalog@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Len Brown <len.brown@intel.com>, Robert Moore <robert.moore@intel.com>, Ying Huang <ying.huang@intel.com>, Rui Zhang <rui.zhang@intel.com>, Lv Zheng <lv.zheng@intel.com>

Microsoft Debug Port Table (DBGP or DBG2) is used by the Windows SoC
platforms to describe their debugging facilities.
Recent Low Power Intel Architecture (LPIA) platforms have utilized
this for the SPI UART debug ports that are resident on their debug
boards.

This patch set enables the DBGP/DBG2 debug ports as an Linux early
console launcher.
The SPI UART debug ports support is also refined to co-exist with this
new usage model.

To use this facility on LPIA platforms, you need to enable the following
kernel configurations:
  CONFIG_EARLY_PRINTK_ACPI=y
  CONFIG_EARLY_PRINTK_INTEL_MID_SPI=y
Then you need to append the following kernel parameter to the kernel
command line in your the boot loader configuration file:
  earlyprintk=acpi

Version 3 of this patch set is the first version that will be published
in the Linux community.  Earlier versions are reviewed internally in
Intel.  This patch set keeps the version number to track the history
that is known to Intel internal developers.

Lv Zheng (2):
  ACPI: Add early console framework for DBGP/DBG2.
  ACPI: Add Intel MID SPI early console support.

 Documentation/kernel-parameters.txt        |    1 +
 arch/x86/Kconfig.debug                     |   25 ++++
 arch/x86/include/asm/mrst.h                |    2 +-
 arch/x86/kernel/acpi/boot.c                |    1 +
 arch/x86/kernel/early_printk.c             |   25 +++-
 arch/x86/platform/mrst/early_printk_mrst.c |  186 +----------------------
 drivers/acpi/Makefile                      |    2 +
 drivers/acpi/early_printk.c                |  201 +++++++++++++++++++++++++
 drivers/platform/x86/Makefile              |    2 +
 drivers/platform/x86/early/Makefile        |    5 +
 drivers/platform/x86/early/intel_mid_spi.c |  220 ++++++++++++++++++++++++++++
 include/acpi/actbl2.h                      |    1 +
 include/linux/acpi.h                       |   24 +++
 include/linux/intel_mid_early.h            |   12 ++
 14 files changed, 526 insertions(+), 181 deletions(-)
 create mode 100644 drivers/acpi/early_printk.c
 create mode 100644 drivers/platform/x86/early/Makefile
 create mode 100644 drivers/platform/x86/early/intel_mid_spi.c
 create mode 100644 include/linux/intel_mid_early.h

-- 
1.7.10

