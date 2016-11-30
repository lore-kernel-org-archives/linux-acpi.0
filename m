From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 02/11] ACPICA: Back port of "ACPICA: Dispatcher: Tune interpreter lock around AcpiEvInitializeRegion()"
Date: Wed, 30 Nov 2016 15:20:59 +0800
Message-ID: <26416a54d74f43b07e27cf6f79d6b8f2976f84bb.1480490191.git.lv.zheng@intel.com>
References: <cover.1480490191.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:49943 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755359AbcK3HVr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 30 Nov 2016 02:21:47 -0500
In-Reply-To: <cover.1480490191.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

ACPICA commit bc481e758e54f7644fd0b657119ca7763d8b6a9c

This is a back port result of the following commit:
  Commit: 8633db6b027952449e155a316f4ae3a530bbe18f
  Subject: ACPICA: Dispatcher: Fix interpreter locking around acpi_ev_initialize_region()

Link: https://github.com/acpica/acpica/commit/bc481e75
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/dsinit.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/dsinit.c b/drivers/acpi/acpica/dsinit.c
index 54d48b9..5de3f10 100644
--- a/drivers/acpi/acpica/dsinit.c
+++ b/drivers/acpi/acpica/dsinit.c
@@ -221,8 +221,8 @@
 	 */
 	status =
 	    acpi_ns_walk_namespace(ACPI_TYPE_ANY, start_node, ACPI_UINT32_MAX,
-				   0, acpi_ds_init_one_object, NULL, &info,
-				   NULL);
+				   ACPI_NS_WALK_NO_UNLOCK,
+				   acpi_ds_init_one_object, NULL, &info, NULL);
 	if (ACPI_FAILURE(status)) {
 		ACPI_EXCEPTION((AE_INFO, status, "During WalkNamespace"));
 	}
-- 
1.7.10

