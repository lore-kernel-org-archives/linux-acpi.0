From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 20/21] ACPICA: Object repair: Allow 0-length packages for variable-length packages
Date: Fri,  8 Mar 2013 17:23:51 +0800
Message-ID: <701301ea0d890d29e91d41c383e3f5c78d37419d.1361292877.git.lv.zheng@intel.com>
References: <cover.1361292877.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:17131 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933331Ab3CHJYC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 8 Mar 2013 04:24:02 -0500
In-Reply-To: <cover.1361292877.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>
Cc: linux-acpi@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>

From: Bob Moore <robert.moore@intel.com>

For the predefined names that return fully variable-length
packages, allow a zero-length package with no warning, since it
is technically a legal construct (and BIOS writers use it.)

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/nsprepkg.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/nsprepkg.c b/drivers/acpi/acpica/nsprepkg.c
index a401554..77cdd53 100644
--- a/drivers/acpi/acpica/nsprepkg.c
+++ b/drivers/acpi/acpica/nsprepkg.c
@@ -112,9 +112,15 @@ acpi_ns_check_package(struct acpi_predefined_data *data,
 	elements = return_object->package.elements;
 	count = return_object->package.count;
 
-	/* The package must have at least one element, else invalid */
-
+	/*
+	 * Most packages must have at least one element. The only exception
+	 * is the variable-length package (ACPI_PTYPE1_VAR).
+	 */
 	if (!count) {
+		if (package->ret_info.type == ACPI_PTYPE1_VAR) {
+			return (AE_OK);
+		}
+
 		ACPI_WARN_PREDEFINED((AE_INFO, data->pathname, data->node_flags,
 				      "Return Package has no elements (empty)"));
 
-- 
1.7.10

