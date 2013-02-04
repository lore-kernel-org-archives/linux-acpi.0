From: liguang <lig.fnst@cn.fujitsu.com>
Subject: [PATCH 0/5] acpi: do some changes for numa info
Date: Mon, 4 Feb 2013 16:43:41 +0800
Message-ID: <1359967426-32629-1-git-send-email-lig.fnst@cn.fujitsu.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:30215 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1753691Ab3BDIoJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 4 Feb 2013 03:44:09 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, x86@kernel.org
Cc: liguang <lig.fnst@cn.fujitsu.com>

just do some trivial changes to make acpi's numa info
operation more cleaner.

Li Guang(5)
	numa: avoid export acpi_numa variable
	acpi/numa: check if parsing acpi numa info disabled earlier
	acpi: move x86/mm/srat.c to x86/kernel/acpi/srat.c
	acpi: add clock_domain field to acpi_srat_cpu_affinity
	remove include asm/acpi.h in process_driver.c


 arch/x86/include/asm/acpi.h   	 |    3 ++-
 arch/x86/kernel/acpi/Makefile 	 |    1 +
 arch/x86/mm/Makefile            |    1 -
 arch/x86/mm/numa.c          	 |    2 +-
 arch/x86/mm/srat.c          	 |  207 +++++--------------------------------
 arch/x86/xen/enlighten.c    	 |    2 +-
 drivers/acpi/processor_driver.c |    1 -
 drivers/acpi/numa.c 			 	 |    2 ++
 include/acpi/actbl1.h 			 |    2 +-
 8 files changed, 13 insertions(+), 208 deletions(-)
 
