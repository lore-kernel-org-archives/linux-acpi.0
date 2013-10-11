From: Alex Hung <alex.hung@canonical.com>
Subject: [PATCH 1/2] ACPICA: fix label indent to meet coding style
Date: Fri, 11 Oct 2013 11:07:10 +0800
Message-ID: <1381460831-26241-1-git-send-email-alex.hung@canonical.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:56021 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752264Ab3JKDHW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Oct 2013 23:07:22 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, rjw@sisk.pl, lv.zheng@intel.com, robert.moore@intel.com, linux-acpi@vger.kernel.org
Cc: Alex Hung <alex.hung@canonical.com>

Signed-off-by: Alex Hung <alex.hung@canonical.com>
---
 drivers/acpi/acpica/hwxface.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/hwxface.c b/drivers/acpi/acpica/hwxface.c
index 5ee7a81..a0488b4 100644
--- a/drivers/acpi/acpica/hwxface.c
+++ b/drivers/acpi/acpica/hwxface.c
@@ -561,10 +561,10 @@ acpi_get_sleep_type_data(u8 sleep_state, u8 *sleep_type_a, u8 *sleep_type_b)
 		break;
 	}
 
-      cleanup1:
+cleanup1:
 	acpi_ut_remove_reference(info->return_object);
 
-      cleanup:
+cleanup:
 	if (ACPI_FAILURE(status)) {
 		ACPI_EXCEPTION((AE_INFO, status,
 				"While evaluating Sleep State [%s]",
-- 
1.7.9.5

