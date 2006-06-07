From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 2.6.17-rc6] Fix the memory leak in acpi_evaluate_integer()
Date: Wed, 07 Jun 2006 12:33:54 +0100
Message-ID: <20060607113354.9720.85323.stgit@localhost.localdomain>
Reply-To: catalin.marinas@gmail.com
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:34725 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S1750868AbWFGLeE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 7 Jun 2006 07:34:04 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

From: Catalin Marinas <catalin.marinas@arm.com>

A leak can happen because of the early returns from this function
(discovered by kmemleak).

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
