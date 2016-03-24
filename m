From: Lv Zheng <lv.zheng@intel.com>
Subject: [RFC PATCH 0/8] ACPICA: Tables: Table cleanup and new APIs
Date: Thu, 24 Mar 2016 16:30:19 +0800
Message-ID: <cover.1458808078.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:16788 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752144AbcCXIa3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 24 Mar 2016 04:30:29 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

This patch is a linuxized result of ACPICA upstream pull request 121.
https://github.com/acpica/acpica/pull/121/
This is for review only. Please do not merge it.

Lv Zheng (8):
  ACPICA: Tables: Add an error message complaining driver bugs
  ACPICA: Tables: Invoke acpi_tb_validate_tableby_index() instead of
    acpi_get_table_by_index()
  ACPICA: Tables: Fix an issue the dynamic table loading contains code
    with MTX_TABLES released
  ACPICA: Tables: Cleanup acpi_tb_copy_dsdt()
  ACPICA: Tables: Remove acpi_tb_install_fixed_table()
  ACPICA: Tables: Correct function namings
  ACPICA: Tables: Add acpi_uninstall_table() to remove ACPI tables
  ACPICA: Tables: Add acpi_unload_table() to unload definition block
    tables

 drivers/acpi/acpica/actables.h    |   22 +++---
 drivers/acpi/acpica/dbfileio.c    |    2 +-
 drivers/acpi/acpica/dsinit.c      |    2 +-
 drivers/acpi/acpica/dsopcode.c    |    2 +-
 drivers/acpi/acpica/exconfig.c    |   18 +++--
 drivers/acpi/acpica/nsparse.c     |    2 +-
 drivers/acpi/acpica/tbdata.c      |   54 +++++++++++---
 drivers/acpi/acpica/tbfadt.c      |   24 +++---
 drivers/acpi/acpica/tbinstal.c    |  119 +++--------------------------
 drivers/acpi/acpica/tbutils.c     |   94 ++++++++++++++++++-----
 drivers/acpi/acpica/tbxface.c     |   18 ++++-
 drivers/acpi/acpica/tbxfload.c    |  149 ++++++++++++++++++++++++++++---------
 drivers/acpi/osl.c                |    3 +-
 drivers/pci/hotplug/sgi_hotplug.c |    2 +-
 include/acpi/acpixf.h             |    8 +-
 include/acpi/actbl.h              |    1 +
 16 files changed, 307 insertions(+), 213 deletions(-)

-- 
1.7.10

