From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH] Fix the memory leak in acpi_evaluate_integer()
Date: Tue, 30 May 2006 18:03:31 +0100
Message-ID: <20060530170331.401.43131.stgit@localhost.localdomain>
References: <44797BEF.70206@gmail.com>
Reply-To: catalin.marinas@gmail.com
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932344AbWE3RDl@vger.kernel.org>
In-Reply-To: <44797BEF.70206@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

From: Catalin Marinas <catalin.marinas@arm.com>

A leak can happen because of the early returns from this function.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---

 drivers/acpi/utils.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index 6458c47..71afcd3 100644
--- a/drivers/acpi/utils.c
+++ b/drivers/acpi/utils.c
@@ -273,20 +273,22 @@ acpi_evaluate_integer(acpi_handle handle
 	status = acpi_evaluate_object(handle, pathname, arguments, &buffer);
 	if (ACPI_FAILURE(status)) {
 		acpi_util_eval_error(handle, pathname, status);
-		return_ACPI_STATUS(status);
+		goto out;
 	}
 
 	if (element->type != ACPI_TYPE_INTEGER) {
 		acpi_util_eval_error(handle, pathname, AE_BAD_DATA);
-		return_ACPI_STATUS(AE_BAD_DATA);
+		status = AE_BAD_DATA;
+		goto out;
 	}
 
 	*data = element->integer.value;
+ out:
 	kfree(element);
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Return value [%lu]\n", *data));
 
-	return_ACPI_STATUS(AE_OK);
+	return_ACPI_STATUS(status);
 }
 
 EXPORT_SYMBOL(acpi_evaluate_integer);
