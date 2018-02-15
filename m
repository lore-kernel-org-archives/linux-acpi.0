From: Erik Schmauss <erik.schmauss@intel.com>
Subject: [PATCH v2 2/7] ACPICA: Update error message, no functional change
Date: Thu, 15 Feb 2018 13:09:27 -0800
Message-ID: <20180215210932.15490-3-erik.schmauss@intel.com>
References: <20180215210932.15490-1-erik.schmauss@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:43730 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752361AbeBOVJ4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 15 Feb 2018 16:09:56 -0500
In-Reply-To: <20180215210932.15490-1-erik.schmauss@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: rjw@rjwysocki.net, Bob Moore <robert.moore@intel.com>, Erik Schmauss <erik.schmauss@intel.com>

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 0787fda3b224a78369e26ac6046658beb2b64c12

Clarify error when an attempt is made to evaluate things like
devices, events, etc. -- these objects have no data and cannot
be "evaluated".

Link: https://github.com/acpica/acpica/commit/0787fda3
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
---
 drivers/acpi/acpica/nseval.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/nseval.c b/drivers/acpi/acpica/nseval.c
index c2d883b8c45e..bdf94ec19c10 100644
--- a/drivers/acpi/acpica/nseval.c
+++ b/drivers/acpi/acpica/nseval.c
@@ -187,6 +187,7 @@ acpi_status acpi_ns_evaluate(struct acpi_evaluate_info *info)
 	 * 3) The object is not a method -- just return it's current value
 	 */
 	switch (acpi_ns_get_type(info->node)) {
+	case ACPI_TYPE_ANY:
 	case ACPI_TYPE_DEVICE:
 	case ACPI_TYPE_EVENT:
 	case ACPI_TYPE_MUTEX:
@@ -194,11 +195,12 @@ acpi_status acpi_ns_evaluate(struct acpi_evaluate_info *info)
 	case ACPI_TYPE_THERMAL:
 	case ACPI_TYPE_LOCAL_SCOPE:
 		/*
-		 * 1) Disallow evaluation of certain object types. For these,
-		 *    object evaluation is undefined and not supported.
+		 * 1) Disallow evaluation of these object types. For these,
+		 *    object evaluation is undefined.
 		 */
 		ACPI_ERROR((AE_INFO,
-			    "%s: Evaluation of object type [%s] is not supported",
+			    "%s: This object type [%s] "
+			    "never contains data and cannot be evaluated",
 			    info->full_pathname,
 			    acpi_ut_get_type_name(info->node->type)));
 
-- 
2.14.3

