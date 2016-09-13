From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 0/3] ACPI / sysfs: Cleanup sysfs table handling code
Date: Tue, 13 Sep 2016 17:48:14 +0800
Message-ID: <cover.1473759814.git.lv.zheng@intel.com>
References: <cover.1471337441.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:39000 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752883AbcIMJsV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 13 Sep 2016 05:48:21 -0400
In-Reply-To: <cover.1471337441.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

There are issues in sysfs table handling code:
1. It cannot handle table loaded by LoadTable opcode executed after
   acpi_sysfs_init();
2. Its signature handling code is not correct.
This patchset fixes these issues.

This patchset also contains a regression fix, fixing a mistake caused in
ACPICA upstream due to a rebase problem, the wrong commit is released in
the ACPICA 20160831 release cycle.

Lv Zheng (3):
  ACPICA: Tables: Fix a regression in acpi_tb_find_table()
  ACPI / sysfs: Fix an issue for LoadTable opcode
  ACPI / sysfs: Update sysfs signature handling code

 drivers/acpi/acpica/tbfind.c |    2 +-
 drivers/acpi/sysfs.c         |   66 +++++++++++++++++++++++-------------------
 2 files changed, 37 insertions(+), 31 deletions(-)

-- 
1.7.10

