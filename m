From: liguang <lig.fnst@cn.fujitsu.com>
Subject: [PATCH v2 0/4] acpi: do some changes for numa info
Date: Tue, 5 Feb 2013 10:37:14 +0800
Message-ID: <1360031838-26898-1-git-send-email-lig.fnst@cn.fujitsu.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:1087 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754780Ab3BEChi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 4 Feb 2013 21:37:38 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, x86@kernel.org
Cc: rientjes@google.com, liguang <lig.fnst@cn.fujitsu.com>

just do some trivial changes to make acpi's numa info
operation more cleaner.

ChangeLog
v1->v2
 1. fix-up several coding issues
 2. finish srat.c change
 spotted by David Rientjes <rientjes@google.com>

Li Guang(4)
        numa: avoid export acpi_numa variable
        acpi: move x86/mm/srat.c to x86/kernel/acpi/srat.c
        acpi: add clock_domain field to acpi_srat_cpu_affinity
        remove include asm/acpi.h in process_driver.c

 arch/x86/include/asm/acpi.h 		|    2 +-
 arch/x86/kernel/acpi/srat.c 		|  212 +++++++++++++++++++++++++++++++++++++++++++---
 arch/x86/mm/srat.c          		|  197 -------------------------------------------
 arch/x86/mm/numa.c          		|    2 +-
 arch/x86/xen/enlighten.c    		|    2 +-
 include/acpi/actbl1.h       		|    2 +-
 drivers/acpi/processor_driver.c |    1 -
 7 files changed, 211 insertions(+), 207 deletions(-)
 create mode 100644 arch/x86/kernel/acpi/srat.c
 delete mode 100644 arch/x86/mm/srat.c

 
