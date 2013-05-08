From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 2/3] ACPICA: _OSI support: Fix possible memory leak
Date: Wed,  8 May 2013 12:01:49 +0800
Message-ID: <3aab426e1eb13518b8e71ceec3c92cbccf98414e.1367912853.git.lv.zheng@intel.com>
References: <cover.1367813690.git.lv.zheng@intel.com> <cover.1367912853.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:49265 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751188Ab3EHECS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 8 May 2013 00:02:18 -0400
In-Reply-To: <cover.1367912853.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, stable@vger.kernel.org, linux-acpi@vger.kernel.org, Jung-uk Kim <jkim@FreeBSD.org>

From: Jung-uk Kim <jkim@FreeBSD.org>

Fixes a possible memory leak in the error exit path.
  From 388a9902074c3cfe57d2425d766c491d072d2948 Mon Sep 17 00:00:00 2001
  From: Jung-uk Kim <jkim@FreeBSD.org>
  Date: Fri, 12 Apr 2013 00:24:34 +0000
  Subject: ACPICA: _OSI Support: handle any errors from acpi_os_acquire_mutex()
Jung-uk Kim (jkim@FreeBSD.org), Bob Moore.

Signed-off-by: Jung-uk Kim <jkim@FreeBSD.org>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Cc: <stable@vger.kernel.org>
---
 drivers/acpi/acpica/utosi.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/utosi.c b/drivers/acpi/acpica/utosi.c
index b15aceb..7e80772 100644
--- a/drivers/acpi/acpica/utosi.c
+++ b/drivers/acpi/acpica/utosi.c
@@ -349,7 +349,8 @@ acpi_status acpi_ut_osi_implementation(struct acpi_walk_state * walk_state)
 	return_value = 0;
 	status = acpi_os_acquire_mutex(acpi_gbl_osi_mutex, ACPI_WAIT_FOREVER);
 	if (ACPI_FAILURE(status)) {
-		return (status);
+		acpi_ut_remove_reference(return_desc);
+		return_ACPI_STATUS(status);
 	}
 
 	/* Lookup the interface in the global _OSI list */
-- 
1.7.10

