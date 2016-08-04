From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 02/30] ACPICA: Fix deconstification warnings (-Wcast-qual) with acpi_ns_root_initialize().
Date: Thu,  4 Aug 2016 16:42:34 +0800
Message-ID: <eb4515ca5ac1cfcb11cb001e719e717906209e2a.1470299677.git.lv.zheng@intel.com>
References: <cover.1470299677.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:37082 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932352AbcHDImn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 4 Aug 2016 04:42:43 -0400
In-Reply-To: <cover.1470299677.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Jung-uk Kim <jkim@FreeBSD.org>, Bob Moore <robert.moore@intel.com>

From: Jung-uk Kim <jkim@FreeBSD.org>

ACPICA commit 8b3b57c9d11d9c322e09cb06bedac7aa783458fd

Link: https://github.com/acpica/acpica/commit/8b3b57c9
Signed-off-by: Jung-uk Kim <jkim@FreeBSD.org>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/nsaccess.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/nsaccess.c b/drivers/acpi/acpica/nsaccess.c
index 426a630..73f98d3 100644
--- a/drivers/acpi/acpica/nsaccess.c
+++ b/drivers/acpi/acpica/nsaccess.c
@@ -108,9 +108,9 @@ acpi_status acpi_ns_root_initialize(void)
 		}
 
 		status =
-		    acpi_ns_lookup(NULL, (char *)init_val->name, init_val->type,
-				   ACPI_IMODE_LOAD_PASS2, ACPI_NS_NO_UPSEARCH,
-				   NULL, &new_node);
+		    acpi_ns_lookup(NULL, ACPI_CAST_PTR(char, init_val->name),
+				   init_val->type, ACPI_IMODE_LOAD_PASS2,
+				   ACPI_NS_NO_UPSEARCH, NULL, &new_node);
 		if (ACPI_FAILURE(status)) {
 			ACPI_EXCEPTION((AE_INFO, status,
 					"Could not create predefined name %s",
-- 
1.7.10

