From: Len Brown <lenb@kernel.org>
Subject: [PATCH 01/13] ACPI: processor: Fix null pointer dereference in throttling
Date: Thu, 24 Jan 2008 00:06:51 -0500
Message-ID: <d1154be3004e9db2d61533e16bb2cf85dd27a8cb.1201150939.git.len.brown@intel.com>
References: <1201151215-11203-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:7773 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751249AbYAXFG6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Jan 2008 00:06:58 -0500
In-Reply-To: <1201151215-11203-1-git-send-email-lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Alexey Starikovskiy <astarikovskiy@suse.de>

http://bugzilla.kernel.org/show_bug.cgi?id=9747

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_throttling.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/processor_throttling.c b/drivers/acpi/processor_throttling.c
index 6742d7b..1685b40 100644
--- a/drivers/acpi/processor_throttling.c
+++ b/drivers/acpi/processor_throttling.c
@@ -775,12 +775,12 @@ int acpi_processor_get_throttling_info(struct acpi_processor *pr)
 		acpi_processor_get_throttling_states(pr) ||
 		acpi_processor_get_platform_limit(pr))
 	{
-		if (acpi_processor_get_fadt_info(pr))
-			return 0;
 		pr->throttling.acpi_processor_get_throttling =
 		    &acpi_processor_get_throttling_fadt;
 		pr->throttling.acpi_processor_set_throttling =
 		    &acpi_processor_set_throttling_fadt;
+		if (acpi_processor_get_fadt_info(pr))
+			return 0;
 	} else {
 		pr->throttling.acpi_processor_get_throttling =
 		    &acpi_processor_get_throttling_ptc;
-- 
1.5.4.rc4.14.g6fc74

