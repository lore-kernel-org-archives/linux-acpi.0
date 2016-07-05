From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 0/5] ACPI: ACPI documentations and trivial fixes
Date: Tue,  5 Jul 2016 19:17:39 +0800
Message-ID: <cover.1467717304.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:46347 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754095AbcGELSA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 5 Jul 2016 07:18:00 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

This patch adds ACPI documentations related to:
1. AML debugger
2. Control method LID device
3. ACPICA release process
This patch also contains several trivial fixes detected during the
documentation work.

Lv Zheng (5):
  ACPI: Add documentation describing ACPICA release automation
  ACPI / debugger: Fix regressions that AML debugger stops working
  ACPI / debugger: Add AML debugger documentation
  ACPI / button: Add SW_ACPI_LID for new usage model
  ACPI: Add configuration item to configure ACPICA error logs out

 Documentation/acpi/acpi-lid.txt         |   42 ++++++
 Documentation/acpi/aml-debugger.txt     |   56 +++++++
 Documentation/acpi/linuxized-acpica.txt |  251 +++++++++++++++++++++++++++++++
 drivers/acpi/Kconfig                    |    7 +
 drivers/acpi/acpi_dbg.c                 |    6 +-
 drivers/acpi/button.c                   |   20 ++-
 include/acpi/platform/aclinux.h         |    4 +
 include/linux/mod_devicetable.h         |    2 +-
 include/uapi/linux/input-event-codes.h  |    3 +-
 9 files changed, 381 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/acpi/acpi-lid.txt
 create mode 100644 Documentation/acpi/aml-debugger.txt
 create mode 100644 Documentation/acpi/linuxized-acpica.txt

-- 
1.7.10

