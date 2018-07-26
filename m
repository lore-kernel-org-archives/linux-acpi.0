From: David Archuleta <darchuletajr@gmail.com>
Subject: [PATCH] acpi: processor_throttling: fixed a few brace coding style issues.
Date: Thu, 26 Jul 2018 13:23:41 -0700
Message-ID: <20180726202341.9816-1-darchuletajr@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, darchuletajr <darchuletajr@gmail.com>
List-Id: linux-acpi@vger.kernel.org

From: darchuletajr <darchuletajr@gmail.com>

Fixed a few brace coding style issues found by running
./scripts/checkpatch

Signed-off-by: David Archuleta Jr. <darchuletajr@gmail.com>
---
 drivers/acpi/processor_throttling.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/processor_throttling.c b/drivers/acpi/processor_throttling.c
index fbc936cf2025..75cc179b352b 100644
--- a/drivers/acpi/processor_throttling.c
+++ b/drivers/acpi/processor_throttling.c
@@ -298,9 +298,8 @@ static int acpi_processor_get_platform_limit(struct acpi_processor *pr)
 
 	status = acpi_evaluate_integer(pr->handle, "_TPC", NULL, &tpc);
 	if (ACPI_FAILURE(status)) {
-		if (status != AE_NOT_FOUND) {
+		if (status != AE_NOT_FOUND)
 			ACPI_EXCEPTION((AE_INFO, status, "Evaluating _TPC"));
-		}
 		return -ENODEV;
 	}
 
@@ -431,9 +430,8 @@ static int acpi_processor_get_throttling_control(struct acpi_processor *pr)
 
 	status = acpi_evaluate_object(pr->handle, "_PTC", NULL, &buffer);
 	if (ACPI_FAILURE(status)) {
-		if (status != AE_NOT_FOUND) {
+		if (status != AE_NOT_FOUND)
 			ACPI_EXCEPTION((AE_INFO, status, "Evaluating _PTC"));
-		}
 		return -ENODEV;
 	}
 
@@ -516,9 +514,8 @@ static int acpi_processor_get_throttling_states(struct acpi_processor *pr)
 
 	status = acpi_evaluate_object(pr->handle, "_TSS", NULL, &buffer);
 	if (ACPI_FAILURE(status)) {
-		if (status != AE_NOT_FOUND) {
+		if (status != AE_NOT_FOUND)
 			ACPI_EXCEPTION((AE_INFO, status, "Evaluating _TSS"));
-		}
 		return -ENODEV;
 	}
 
@@ -596,9 +593,8 @@ static int acpi_processor_get_tsd(struct acpi_processor *pr)
 
 	status = acpi_evaluate_object(pr->handle, "_TSD", NULL, &buffer);
 	if (ACPI_FAILURE(status)) {
-		if (status != AE_NOT_FOUND) {
+		if (status != AE_NOT_FOUND)
 			ACPI_EXCEPTION((AE_INFO, status, "Evaluating _TSD"));
-		}
 		return -ENODEV;
 	}
 
-- 
2.18.0
