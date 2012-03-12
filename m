From: Matthew Garrett <mjg@redhat.com>
Subject: [PATCH V2 1/4] ACPI: Fix up _PLD methods
Date: Mon, 12 Mar 2012 17:45:44 -0400
Message-ID: <1331588747-1247-1-git-send-email-mjg@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:31553 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754249Ab2CLVp7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 12 Mar 2012 17:45:59 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-usb@vger.kernel.org, lenb@kernel.org, gregkh@linuxfoundation.org, Matthew Garrett <mjg@redhat.com>

_PLD is defined as returning a package of buffers, but many implementations
simply return a buffer. Fix this up.

(Original patch by Bob Moore <robert.moore@intel.com>)

Signed-off-by: Matthew Garrett <mjg@redhat.com>
---
 drivers/acpi/acpica/nsrepair.c |   15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/nsrepair.c b/drivers/acpi/acpica/nsrepair.c
index 9c35d20..6217cfd 100644
--- a/drivers/acpi/acpica/nsrepair.c
+++ b/drivers/acpi/acpica/nsrepair.c
@@ -151,9 +151,18 @@ acpi_ns_repair_object(struct acpi_predefined_data *data,
 		}
 	}
 	if (expected_btypes & ACPI_RTYPE_PACKAGE) {
-		status = acpi_ns_convert_to_package(return_object, &new_object);
-		if (ACPI_SUCCESS(status)) {
-			goto object_repaired;
+		if (return_object->common.type == ACPI_TYPE_BUFFER) {
+			status = acpi_ns_repair_package_list(data, &return_object);
+			if (ACPI_SUCCESS(status)) {
+				*return_object_ptr = return_object;
+				data->flags |= ACPI_OBJECT_REPAIRED;
+				return (AE_OK);
+			}
+		} else {
+			status = acpi_ns_convert_to_package(return_object, &new_object);
+			if (ACPI_SUCCESS(status)) {
+				goto object_repaired;
+			}
 		}
 	}
 
-- 
1.7.9.3

