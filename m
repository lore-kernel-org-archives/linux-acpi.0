From: Lv Zheng <lv.zheng@intel.com>
Subject: [RFC PATCH 0/7] ACPICA: Tables: Cleanup table sanity checks
Date: Wed, 15 Mar 2017 14:36:42 +0800
Message-ID: <cover.1489558845.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:13165 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750884AbdCOGgy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 15 Mar 2017 02:36:54 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, "David E . Box" <david.e.box@intel.com>
Cc: Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, devel@acpica.org, Hans de Goede <hdegoede@redhat.com>

Originally AML table sanity check is only done for Load opcode, as
acpi_tb_compare_tables() is only invoked in
acpi_tb_install_standard_table(). While LoadTable opcode cannot be covered
as it directly invokes acpi_tb_load_table() without invoking
acpi_tb_install_standard_table(). Furthermore, standard table load also
cannot be covered as acpi_ns_load_table() is invoked instead of
acpi_tb_install_standard_table() and acpi_tb_load_table().

So it becomes a problem if a duplicate table is in RSDT/XSDT, there is no
such check implemented for static load tables and LoadTable opcode.

This patchset combines code paths (in return reduces some redundant code
blocks and enhances checks/locks) so that duplicate table detection can be
applied to all cases.

Lv Zheng (7):
  ACPICA: Tables: Cleanup table handler invokers
  ACPICA: Tables: Add sanity check for load_table opcode
  ACPICA: Tables: Add sanity check for table install
  ACPICA: Tables: Fix an unwanted exception for table reloading
  ACPICA: Tables: Enable acpi_ut_is_aml_table() for all ACPICA modules
  ACPICA: Tables: Add sanity check for static table load
  ACPICA: Tables: Change table comparison using table header for static
    load tables

 drivers/acpi/acpica/actables.h |   7 +-
 drivers/acpi/acpica/acutils.h  |   4 +-
 drivers/acpi/acpica/exconfig.c |   2 +-
 drivers/acpi/acpica/nsload.c   |  18 ---
 drivers/acpi/acpica/tbdata.c   | 288 ++++++++++++++++++++++++++++++++++++-----
 drivers/acpi/acpica/tbinstal.c | 197 ++++++----------------------
 drivers/acpi/acpica/tbxfload.c |  46 +------
 drivers/acpi/acpica/utmisc.c   |  27 ++--
 include/acpi/actbl.h           |   1 +
 9 files changed, 325 insertions(+), 265 deletions(-)

-- 
2.7.4

