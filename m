From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 0/5] ACPI / sysfs: Cleanup sysfs table handling code
Date: Tue, 16 Aug 2016 16:52:32 +0800
Message-ID: <cover.1471337441.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:15740 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752357AbcHPIws (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 16 Aug 2016 04:52:48 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

There are issues in sysfs table handling code:
1. It cannot handle table loaded by LoadTable opcode executed after
   acpi_sysfs_init();
2. It's signature handling code is not correct.

This patchset fixes these issues.

Lv Zheng (5):
  ACPICA: Tables: Remove acpi_tb_install_fixed_table()
  ACPICA: Tables: Remove wrong table event macros
  ACPICA: Tables: Add new table events indicating table
    installation/uninstallation
  ACPI / sysfs: Fix an issue for LoadTable opcode
  ACPI / sysfs: Update sysfs signature handling code

 drivers/acpi/acpica/actables.h |    7 +---
 drivers/acpi/acpica/tbfadt.c   |   24 +++++++------
 drivers/acpi/acpica/tbinstal.c |   73 +++++-----------------------------------
 drivers/acpi/sysfs.c           |   39 ++++++++++-----------
 include/acpi/actypes.h         |   16 ++++-----
 5 files changed, 51 insertions(+), 108 deletions(-)

-- 
1.7.10

