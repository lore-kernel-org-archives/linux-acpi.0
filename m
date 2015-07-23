From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 0/4] ACPI: Update method tracing facility.
Date: Thu, 23 Jul 2015 13:06:37 +0800
Message-ID: <cover.1437627661.git.lv.zheng@intel.com>
References: <cover.1437627016.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:32171 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750702AbbGWFGq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 23 Jul 2015 01:06:46 -0400
In-Reply-To: <cover.1437627016.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

This patch updates method tracing facility according to ACPICA 20150717
release changes.

Lv Zheng (4):
  ACPI / sysfs: Add ACPI_LV_REPAIR debug level.
  ACPI / sysfs: Update method tracing facility.
  ACPI / Documentation: Update method tracing documentation.
  ACPI / sysfs: Add support to allow suppress leading "\" in
    trace_method_name.

 Documentation/acpi/method-tracing.txt |   53 +++++++++----
 drivers/acpi/osl.c                    |    8 ++
 drivers/acpi/sysfs.c                  |  133 ++++++++++++++++++++++++---------
 3 files changed, 145 insertions(+), 49 deletions(-)

-- 
1.7.10

