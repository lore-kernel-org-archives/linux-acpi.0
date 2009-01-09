From: Len Brown <lenb@kernel.org>
Subject: [PATCH 70/94] ACPI: power.c: call acpi_get_name to get node name
Date: Fri, 09 Jan 2009 04:27:12 -0500
Message-ID: <60a4ce7f4148155d3f28eea4a213f7ee47cd57b7.1231492611.git.len.brown@intel.com>
References: <1231493256-11678-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms044pub.verizon.net ([206.46.252.44]:51676 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753458AbZAIJ20 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 04:28:26 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0KD700AZN6BDW5V9@vms044.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 09 Jan 2009 03:28:26 -0600 (CST)
In-reply-to: <1231493256-11678-1-git-send-email-lenb@kernel.org>
In-reply-to: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
References: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Lin Ming <ming.m.lin@intel.com>

acpi_ut_get_node_name is an internal acpica function.
use acpi_get_name to get node ascii name

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/power.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
index bb7d50d..c926e7d 100644
--- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -139,6 +139,8 @@ static int acpi_power_get_state(acpi_handle handle, int *state)
 {
 	acpi_status status = AE_OK;
 	unsigned long long sta = 0;
+	char node_name[5];
+	struct acpi_buffer buffer = { sizeof(node_name), node_name };
 
 
 	if (!handle || !state)
@@ -151,8 +153,10 @@ static int acpi_power_get_state(acpi_handle handle, int *state)
 	*state = (sta & 0x01)?ACPI_POWER_RESOURCE_STATE_ON:
 			      ACPI_POWER_RESOURCE_STATE_OFF;
 
+	acpi_get_name(handle, ACPI_SINGLE_NAME, &buffer);
+
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Resource [%s] is %s\n",
-			  acpi_ut_get_node_name(handle),
+			  node_name,
 				*state ? "on" : "off"));
 
 	return 0;
-- 
1.5.6.6

