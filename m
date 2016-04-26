From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 0/4] ACPI / osi: Fix several issues in _OSI handling
Date: Tue, 26 Apr 2016 15:39:53 +0800
Message-ID: <cover.1461656216.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:30633 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752205AbcDZHkD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 26 Apr 2016 03:40:03 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

This patchset cleans up _OSI handling code and fixes several issues in it.

Chen Yu (1):
  ACPI / osi: Change default _OSI(Darwin) support

Lv Zheng (3):
  ACPI / osi: Fix an issue that acpi_osi=!* cannot disable ACPICA
    internal strings
  ACPI / osi: Cleanup _OSI("Linux") related code before introducing new
    support
  ACPI / osi: Collect _OSI handling into one single file

 Documentation/kernel-parameters.txt |    2 +
 drivers/acpi/Makefile               |    2 +-
 drivers/acpi/blacklist.c            |  196 +------------
 drivers/acpi/internal.h             |    2 +
 drivers/acpi/osi.c                  |  521 +++++++++++++++++++++++++++++++++++
 drivers/acpi/osl.c                  |  228 +--------------
 include/linux/acpi.h                |    1 -
 7 files changed, 533 insertions(+), 419 deletions(-)
 create mode 100644 drivers/acpi/osi.c

-- 
1.7.10

