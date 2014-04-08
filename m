From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 0/2] ACPI: Fix issues related to the DSDT customization.
Date: Tue,  8 Apr 2014 10:48:55 +0800
Message-ID: <cover.1396925060.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:20186 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754690AbaDHCtH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 7 Apr 2014 22:49:07 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

It is reported that there are several issues related to the DSDT
custmization.  This patchset fixes such trivial issues.

References: https://bugzilla.kernel.org/show_bug.cgi?id=69711

Lv Zheng (2):
  ACPI: Fix the issue that auto SSDT loading is conflict with
    customized SSDT that is included by the customized DSDT.
  ACPI: Fix the issue that the DSDT local copy is conflict with the
    customized DSDT.

 drivers/acpi/Kconfig    |    8 ++++++++
 drivers/acpi/bus.c      |    9 ++++++++-
 drivers/acpi/internal.h |    5 +++++
 drivers/acpi/osl.c      |   14 +++++++++++++-
 drivers/acpi/tables.c   |    2 ++
 5 files changed, 36 insertions(+), 2 deletions(-)

-- 
1.7.10

