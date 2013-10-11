From: Alex Hung <alex.hung@canonical.com>
Subject: [PATCH 2/2] ACPICA: remove AE_NOT_FOUND errors for non-existing _Sx objects in AML
Date: Fri, 11 Oct 2013 11:07:11 +0800
Message-ID: <1381460831-26241-2-git-send-email-alex.hung@canonical.com>
References: <1381460831-26241-1-git-send-email-alex.hung@canonical.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:56026 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752264Ab3JKDHY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Oct 2013 23:07:24 -0400
In-Reply-To: <1381460831-26241-1-git-send-email-alex.hung@canonical.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, rjw@sisk.pl, lv.zheng@intel.com, robert.moore@intel.com, linux-acpi@vger.kernel.org
Cc: Alex Hung <alex.hung@canonical.com>

After 48ffb94f9e6f9b11c26884f26199e3d51bb22e54, AE_NOT_FOUND errors are shown
in dmesg as below:

ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S1_]
ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S2_]

However, neither _S1 nor _S2 are defined in AML and thus these are false
errors. This patch restores the related control flow to it was before
48ffb94f9e6f9b11c26884f26199e3d51bb22e54.

Signed-off-by: Alex Hung <alex.hung@canonical.com>
---
 drivers/acpi/acpica/hwxface.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/hwxface.c b/drivers/acpi/acpica/hwxface.c
index a0488b4..7a137c0 100644
--- a/drivers/acpi/acpica/hwxface.c
+++ b/drivers/acpi/acpica/hwxface.c
@@ -499,7 +499,7 @@ acpi_get_sleep_type_data(u8 sleep_state, u8 *sleep_type_a, u8 *sleep_type_b)
 	    ACPI_CAST_PTR(char, acpi_gbl_sleep_state_names[sleep_state]);
 	status = acpi_ns_evaluate(info);
 	if (ACPI_FAILURE(status)) {
-		goto cleanup;
+		goto cleanup2;
 	}
 
 	/* Must have a return object */
@@ -571,6 +571,7 @@ cleanup:
 				info->relative_pathname));
 	}
 
+cleanup2:
 	ACPI_FREE(info);
 	return_ACPI_STATUS(status);
 }
-- 
1.7.9.5

