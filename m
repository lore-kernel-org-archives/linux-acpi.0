From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 0/4] ACPI / EC: Fix ECDT and boot_ec support
Date: Wed,  7 Sep 2016 16:49:59 +0800
Message-ID: <cover.1473238007.git.lv.zheng@intel.com>
References: <cover.1472802172.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:2057 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754707AbcIGIuH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 7 Sep 2016 04:50:07 -0400
In-Reply-To: <cover.1472802172.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

Linux uses ECDT only in boot stage (before the namespace is fully
initialized), but there are cases reported that Windows allows ECDT to be
used for OSPM runtime, responding EC events by evaluating _Qxx methods
under the device node indicated in the ECDT.

This patchset changes Linux ECDT support to follow Windows behavior and
also fixes related boot_ec support.

v2:
 Rebased on top of recent linux-pm.git/linux-next.
 Addressed 1 comment from Peter Wu.
 Update patch SOBs.

Lv Zheng (4):
  ACPI / EC: Cleanup first_ec/boot_ec code
  ACPI / EC: Fix a memory leakage issue in acpi_ec_add()
  ACPI / EC: Fix a gap that ECDT EC cannot handle EC events
  ACPI / EC: Fix issues related to boot_ec

 drivers/acpi/ec.c       |  240 +++++++++++++++++++++++++++++++++++++----------
 drivers/acpi/internal.h |    1 +
 drivers/acpi/scan.c     |    1 +
 3 files changed, 195 insertions(+), 47 deletions(-)

-- 
1.7.10

