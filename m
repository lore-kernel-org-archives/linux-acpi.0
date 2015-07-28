From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 0/2] tools/power/acpi: Fix ACPI tools build issues.
Date: Tue, 28 Jul 2015 13:25:12 +0800
Message-ID: <cover.1438060971.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Currently tools/power/acpi is broken:
1. acpidump build is broken because utnonansi.o is not linked.
2. ec build is broken because descend build is not supported.
This patch fixes the above issues.

Lv Zheng (2):
  tools/power/acpi: Add descend support in ACPI tools Makefile.
  tools/power/acpi: Enable build for EC userspace tool.

 tools/power/acpi/Makefile                |  168 +++---------------------------
 tools/power/acpi/Makefile.config         |   92 ++++++++++++++++
 tools/power/acpi/Makefile.rules          |   37 +++++++
 tools/power/acpi/tools/acpidump/Makefile |   53 ++++++++++
 tools/power/acpi/tools/ec/Makefile       |   33 +++---
 5 files changed, 213 insertions(+), 170 deletions(-)
 create mode 100644 tools/power/acpi/Makefile.config
 create mode 100644 tools/power/acpi/Makefile.rules
 create mode 100644 tools/power/acpi/tools/acpidump/Makefile

-- 
1.7.10
