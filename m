From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 11/26] ACPICA: Fix for predefined name loop during ACPICA initialization
Date: Wed, 31 Oct 2012 10:26:36 +0800
Message-ID: <958db923c8d1514acffa813f1f62610101d85776.1351649951.git.lv.zheng@intel.com>
References: <cover.1351649949.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:21254 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753797Ab2JaC0n (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 30 Oct 2012 22:26:43 -0400
In-Reply-To: <cover.1351649949.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, Robert Moore <Robert.Moore@intel.com>, Bob Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>

From: Robert Moore <Robert.Moore@intel.com>

If a name cannot be created, simply continue on to the next name.
Do not attempt to use the name, do not abort.  With assistance
from Colin Ian King.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/nsaccess.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/nsaccess.c b/drivers/acpi/acpica/nsaccess.c
index fc168e6..d70eaf3 100644
--- a/drivers/acpi/acpica/nsaccess.c
+++ b/drivers/acpi/acpica/nsaccess.c
@@ -110,11 +110,11 @@ acpi_status acpi_ns_root_initialize(void)
 		status = acpi_ns_lookup(NULL, init_val->name, init_val->type,
 					ACPI_IMODE_LOAD_PASS2,
 					ACPI_NS_NO_UPSEARCH, NULL, &new_node);
-
-		if (ACPI_FAILURE(status) || (!new_node)) {	/* Must be on same line for code converter */
+		if (ACPI_FAILURE(status)) {
 			ACPI_EXCEPTION((AE_INFO, status,
 					"Could not create predefined name %s",
 					init_val->name));
+			continue;
 		}
 
 		/*
-- 
1.7.10

