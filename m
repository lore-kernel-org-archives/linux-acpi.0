From: Prarit Bhargava <prarit@redhat.com>
Subject: [PATCH] ACPICA: AcpiGetSleepTypeData: Reduce warnings
Date: Thu, 22 Oct 2015 13:17:18 -0400
Message-ID: <1445534238-30447-1-git-send-email-prarit@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58995 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757916AbbJVRRX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 22 Oct 2015 13:17:23 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Robert Moore <Robert.Moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, Prarit Bhargava <prarit@redhat.com>

From: Robert Moore <Robert.Moore@intel.com>

ACPICA commit 7bb77313091e52a846df4c9c2bea90be31bfb9d8

Eliminate warnings for "not found" _Sx errors, since these
are optional. Original NOT_FOUND status is still returned.

Original changes by Prarit Bhargava.
ACPICA BZ 1208.

Before patch:

[prarit@prarit linux]$ dmesg | grep "Sleep State"
ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S1_] (20130517/hwxface-571)
ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S2_] (20130517/hwxface-571)

After patch:
[prarit@prarit linux]$ dmesg | grep "Sleep State"
[prarit@prarit linux]$

Cc: Robert Moore <Robert.Moore@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Len Brown <lenb@kernel.org>

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
---
 drivers/acpi/acpica/hwxface.c |   15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/acpica/hwxface.c b/drivers/acpi/acpica/hwxface.c
index 5f97468..ea0cee4 100644
--- a/drivers/acpi/acpica/hwxface.c
+++ b/drivers/acpi/acpica/hwxface.c
@@ -508,7 +508,11 @@ acpi_get_sleep_type_data(u8 sleep_state, u8 *sleep_type_a, u8 *sleep_type_b)
 	    ACPI_CAST_PTR(char, acpi_gbl_sleep_state_names[sleep_state]);
 	status = acpi_ns_evaluate(info);
 	if (ACPI_FAILURE(status)) {
-		goto cleanup;
+		if (status == AE_NOT_FOUND) {
+			/* The _Sx states are optional, ignore NOT_FOUND */
+			goto finalcleanup;
+		}
+		goto warningcleanup;
 	}
 
 	/* Must have a return object */
@@ -517,7 +521,7 @@ acpi_get_sleep_type_data(u8 sleep_state, u8 *sleep_type_a, u8 *sleep_type_b)
 		ACPI_ERROR((AE_INFO, "No Sleep State object returned from [%s]",
 			    info->relative_pathname));
 		status = AE_AML_NO_RETURN_VALUE;
-		goto cleanup;
+		goto warningcleanup;
 	}
 
 	/* Return object must be of type Package */
@@ -526,7 +530,7 @@ acpi_get_sleep_type_data(u8 sleep_state, u8 *sleep_type_a, u8 *sleep_type_b)
 		ACPI_ERROR((AE_INFO,
 			    "Sleep State return object is not a Package"));
 		status = AE_AML_OPERAND_TYPE;
-		goto cleanup1;
+		goto returnvaluecleanup;
 	}
 
 	/*
@@ -570,16 +574,17 @@ acpi_get_sleep_type_data(u8 sleep_state, u8 *sleep_type_a, u8 *sleep_type_b)
 		break;
 	}
 
-cleanup1:
+returnvaluecleanup:
 	acpi_ut_remove_reference(info->return_object);
 
-cleanup:
+warningcleanup:
 	if (ACPI_FAILURE(status)) {
 		ACPI_EXCEPTION((AE_INFO, status,
 				"While evaluating Sleep State [%s]",
 				info->relative_pathname));
 	}
 
+finalcleanup:
 	ACPI_FREE(info);
 	return_ACPI_STATUS(status);
 }
-- 
1.7.9.3

