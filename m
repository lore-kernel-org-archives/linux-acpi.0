From: liguang <lig.fnst@cn.fujitsu.com>
Subject: [rebased-again][PATCH 0/4] acpi: do some changes for numa info
Date: Mon, 25 Feb 2013 10:38:33 +0800
Message-ID: <1361759917-5195-1-git-send-email-lig.fnst@cn.fujitsu.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:39335 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1759464Ab3BYCmz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 24 Feb 2013 21:42:55 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: tglx@linutronix.de, hpa@zytor.com, pavel@ucw.cz, rjw@sisk.pl, lv.zheng@intel.com, jarkko.sakkinen@intel.com, dave@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, x86@kernel.org
Cc: liguang <lig.fnst@cn.fujitsu.com>

just do some trivial changes to make acpi's numa info
operation more cleaner.

ChangeLog

v3->v4
 1.fix srat_disabled function
 spotted by Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>

v2->v3
 1. rebase on linux-next
 2. bring back lost Makefile changes
 spotted by David Rientjes <rientjes@google.com>
 spotted by Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>

v1->v2
 1. fix-up several coding issues
 2. finish srat.c change
 spotted by David Rientjes <rientjes@google.com>

Li Guang (4)
	 acpi: move x86/mm/srat.c to x86/kernel/acpi/srat.c
	 numa: avoid export acpi_numa variable
	 acpi: add clock_domain field to acpi_srat_cpu_affinity
	 remove include asm/acpi.h in process_driver.c

arch/x86/include/asm/acpi.h     | 2 +-
arch/x86/kernel/acpi/Makefile   | 1 +
arch/x86/kernel/acpi/srat.c     | 299 +++++++++++++++++++++++++++++++++++++++++
arch/x86/mm/Makefile            | 1 -
arch/x86/mm/numa.c              | 2 +-
arch/x86/mm/srat.c              | 278 -----------------------------------------
arch/x86/xen/enlighten.c        | 2 +-
drivers/acpi/processor_driver.c | 1 -
include/acpi/actbl1.h           | 2 +-
9 files changed, 296 insertions(+), 292 deletions(-)
 create mode 100644 arch/x86/kernel/acpi/srat.c
 delete mode 100644 arch/x86/mm/srat.c
 
