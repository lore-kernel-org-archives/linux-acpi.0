From: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
Subject: [PATCH] acpi: acpica: add acpi status check prior walking through namespace
Date: Tue, 12 Dec 2017 07:59:20 -0800
Message-ID: <1513094360-1414-2-git-send-email-Vadim.Lomovtsev@caviumnetworks.com>
References: <1513094360-1414-1-git-send-email-Vadim.Lomovtsev@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-dm3nam03on0060.outbound.protection.outlook.com ([104.47.41.60]:59712
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752007AbdLLP7j (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 12 Dec 2017 10:59:39 -0500
In-Reply-To: <1513094360-1414-1-git-send-email-Vadim.Lomovtsev@caviumnetworks.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: robert.moore@intel.com, lv.zheng@intel.com, rafael.j.wysocki@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, devel@acpica.org, linux-kernel@vger.kernel.org
Cc: vadim.lomovtsev@cavium.com

From: Vadim Lomovtsev <vadim.lomovtsev@cavium.com>

While having kernel built with ACPI support enabled and booted over FDT,
the ltp_acpi test from LTP suite causes kernel crash while calling
acpi_ns_walk_namespace(). The acpi_get_devices is high level wrapper for
it, so we need to protect kernel from crashes by adding acpi status
check before walking through namespace which is not loaded because of
acpi is disabled.

Signed-off-by: Vadim Lomovtsev <vadim.lomovtsev@cavium.com>
---
 drivers/acpi/acpica/nsxfeval.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/acpica/nsxfeval.c b/drivers/acpi/acpica/nsxfeval.c
index 783f4c8..e0eb9ae 100644
--- a/drivers/acpi/acpica/nsxfeval.c
+++ b/drivers/acpi/acpica/nsxfeval.c
@@ -52,6 +52,8 @@
 #define _COMPONENT          ACPI_NAMESPACE
 ACPI_MODULE_NAME("nsxfeval")
 
+extern int acpi_disabled;
+
 /* Local prototypes */
 static void acpi_ns_resolve_references(struct acpi_evaluate_info *info);
 
@@ -812,6 +814,11 @@ static void acpi_ns_resolve_references(struct acpi_evaluate_info *info)
 
 	ACPI_FUNCTION_TRACE(acpi_get_devices);
 
+	/* check if ACPI disabled to prevent kernel crash later */
+	if (acpi_disabled) {
+		return_ACPI_STATUS(AE_NOT_CONFIGURED);
+	}
+
 	/* Parameter validation */
 
 	if (!user_function) {
-- 
1.8.3.1

