From: Erik Schmauss <erik.schmauss@intel.com>
Subject: [PATCH 03/12] ACPICA: Fix a regression in the acpi_evaluate_object_type interface
Date: Wed,  3 Jan 2018 15:06:22 -0800
Message-ID: <20180103230631.15939-4-erik.schmauss@intel.com>
References: <erik.schmauss@intel.com>
 <20180103230631.15939-1-erik.schmauss@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:43368 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751192AbeACXHl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 3 Jan 2018 18:07:41 -0500
In-Reply-To: <20180103230631.15939-1-erik.schmauss@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Erik Schmauss <erik.schmauss@intel.com>

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 9ab548ef154b992208524d61770caca90a9762be

The optional Pathname parameter inadvertently became required.
Introduced in April 2017.

Link: https://github.com/acpica/acpica/commit/9ab548ef
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
---
 drivers/acpi/acpica/nsxfeval.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpica/nsxfeval.c b/drivers/acpi/acpica/nsxfeval.c
index 783f4c838aee..9b51f65823b2 100644
--- a/drivers/acpi/acpica/nsxfeval.c
+++ b/drivers/acpi/acpica/nsxfeval.c
@@ -61,10 +61,10 @@ static void acpi_ns_resolve_references(struct acpi_evaluate_info *info);
  *
  * PARAMETERS:  handle              - Object handle (optional)
  *              pathname            - Object pathname (optional)
- *              external_params     - List of parameters to pass to method,
+ *              external_params     - List of parameters to pass to a method,
  *                                    terminated by NULL. May be NULL
  *                                    if no parameters are being passed.
- *              return_buffer       - Where to put method's return value (if
+ *              return_buffer       - Where to put the object's return value (if
  *                                    any). If NULL, no value is returned.
  *              return_type         - Expected type of return object
  *
@@ -100,13 +100,14 @@ acpi_evaluate_object_typed(acpi_handle handle,
 		free_buffer_on_error = TRUE;
 	}
 
+	/* Get a handle here, in order to build an error message if needed */
+
+	target_handle = handle;
 	if (pathname) {
 		status = acpi_get_handle(handle, pathname, &target_handle);
 		if (ACPI_FAILURE(status)) {
 			return_ACPI_STATUS(status);
 		}
-	} else {
-		target_handle = handle;
 	}
 
 	full_pathname = acpi_ns_get_external_pathname(target_handle);
-- 
2.14.3

