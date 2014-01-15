From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 0/3] ACPI: Integrate tools/power/acpi Makefile into tools Makefile.
Date: Wed, 15 Jan 2014 12:03:10 +0800
Message-ID: <cover.1389676901.git.lv.zheng@intel.com>
References: <cover.1376378577.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:62753 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751071AbaAOEES (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 14 Jan 2014 23:04:18 -0500
In-Reply-To: <cover.1376378577.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

This patchset updates tools/power/acpi folder to integrate its Makefiles
with other tools.

Lv Zheng (3):
  ACPICA: acpidump: Cleanup tools/power/acpi makefiles.
  ACPICA: acpidump: Enable tools Makefile to include acpi tools.
  ACPICA: acpidump: Update MAINTAINERS file to include tools folder for
    ACPI/ACPICA.

 MAINTAINERS                                      |    2 +
 tools/Makefile                                   |   16 ++-
 tools/power/acpi/Makefile                        |  149 ++++++++++++++++++++--
 tools/power/acpi/{ => man}/acpidump.8            |    0
 tools/power/acpi/{ => tools/acpidump}/acpidump.c |    0
 5 files changed, 152 insertions(+), 15 deletions(-)
 rename tools/power/acpi/{ => man}/acpidump.8 (100%)
 rename tools/power/acpi/{ => tools/acpidump}/acpidump.c (100%)

-- 
1.7.10

