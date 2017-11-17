From: Erik Schmauss <erik.schmauss@intel.com>
Subject: [PATCH 08/15] ACPICA: Namespace: fix memory leak from building prefixed pathname
Date: Fri, 17 Nov 2017 15:42:23 -0800
Message-ID: <20171117234230.913-9-erik.schmauss@intel.com>
References: <erik.schmauss@intel.com>
 <20171117234230.913-1-erik.schmauss@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:39435 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759953AbdKQXqj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 17 Nov 2017 18:46:39 -0500
In-Reply-To: <20171117234230.913-1-erik.schmauss@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Erik Schmauss <erik.schmauss@intel.com>, Bob Moore <robert.moore@intel.com>

ACPICA commit f8ca5db30605467b851f86d152079631c27eeca8

Link: https://github.com/acpica/acpica/commit/f8ca5db3
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/nsnames.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/nsnames.c b/drivers/acpi/acpica/nsnames.c
index 4203d4589b6d..22c92d1a24d8 100644
--- a/drivers/acpi/acpica/nsnames.c
+++ b/drivers/acpi/acpica/nsnames.c
@@ -377,7 +377,7 @@ char *acpi_ns_build_prefixed_pathname(union acpi_generic_state *prefix_scope,
 {
 	acpi_status status;
 	char *full_path = NULL;
-	char *external_path;
+	char *external_path = NULL;
 	char *prefix_path = NULL;
 	u32 prefix_path_length = 0;
 
@@ -423,6 +423,9 @@ char *acpi_ns_build_prefixed_pathname(union acpi_generic_state *prefix_scope,
 	if (prefix_path) {
 		ACPI_FREE(prefix_path);
 	}
+	if (external_path) {
+		ACPI_FREE(external_path);
+	}
 
 	return (full_path);
 }
-- 
2.13.6

