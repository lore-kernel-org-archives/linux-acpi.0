From: liguang <lig.fnst@cn.fujitsu.com>
Subject: [PATCH v3 0/4] acpi: do some changes for numa info
Date: Tue, 5 Feb 2013 15:35:58 +0800
Message-ID: <1360049762-6349-1-git-send-email-lig.fnst@cn.fujitsu.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:60114 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751010Ab3BEHgX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 5 Feb 2013 02:36:23 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, x86@kernel.org
Cc: rientjes@google.com, isimatu.yasuaki@jp.fujitsu.com, liguang <lig.fnst@cn.fujitsu.com>

just do some trivial changes to make acpi's numa info
operation more cleaner.

ChangeLog

v2->v3
 1. rebase on linux-next
 2. bring back lost Makefile changes
 spotted by David Rientjes <rientjes@google.com>
 spotted by Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>

v1->v2
 1. fix-up several coding issues
 2. finish srat.c change
 spotted by David Rientjes <rientjes@google.com>

Li Guang(4)
        numa: avoid export acpi_numa variable
        acpi: move x86/mm/srat.c to x86/kernel/acpi/srat.c
        acpi: add clock_domain field to acpi_srat_cpu_affinity
        remove include asm/acpi.h in process_driver.c

 arch/x86/include/asm/acpi.h		|    2 +-
 arch/x86/kernel/acpi/Makefile		|    1 +
 arch/x86/kernel/acpi/srat.c 		|  212 +++++++++++++++++++++++++++++++++++++++++++---
 arch/x86/mm/Makefile			|    1 -
 arch/x86/mm/srat.c          		|  198 -------------------------------------------
 arch/x86/mm/numa.c          		|    2 +-
 arch/x86/xen/enlighten.c    		|    2 +-
 include/acpi/actbl1.h       		|    2 +-
 drivers/acpi/processor_driver.c 	|    1 -

 9 files changed, 212 insertions(+), 208 deletions(-)
 create mode 100644 arch/x86/kernel/acpi/srat.c
 delete mode 100644 arch/x86/mm/srat.c

 
