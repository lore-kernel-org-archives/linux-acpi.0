From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 0/3] ACPI / tables: Add table upgrade mechanism
Date: Fri,  8 Apr 2016 15:35:12 +0800
Message-ID: <cover.1460100857.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

This patch introduces a table upgrade mechanism based on the existing
initrd table override mechanism.

Lv Zheng (3):
  ACPI / tables: Move table override mechanisms to tables.c
  ACPI / x86: Cleanup initrd related code
  ACPI / tables: Convert the initrd table override mechanisms to the
    table upgrade mechanism

 Documentation/acpi/initrd_table_override.txt |   65 +++---
 arch/x86/kernel/setup.c                      |   12 +-
 drivers/acpi/Kconfig                         |    8 +-
 drivers/acpi/internal.h                      |    1 -
 drivers/acpi/osl.c                           |  274 ----------------------
 drivers/acpi/tables.c                        |  312 +++++++++++++++++++++++++-
 include/linux/acpi.h                         |    6 +-
 7 files changed, 366 insertions(+), 312 deletions(-)

-- 
1.7.10
