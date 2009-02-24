From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 2/2] ACPI: fix broken usage of acpi_ut_get_node_name()
Date: Tue, 24 Feb 2009 11:48:18 -0300
Message-ID: <1235486898-27756-2-git-send-email-hmh@hmh.eng.br>
References: <1235486898-27756-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:38653 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755330AbZBXOsX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 24 Feb 2009 09:48:23 -0500
In-Reply-To: <1235486898-27756-1-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: stable@kernel.org, linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Lin Ming <ming.m.lin@intel.com>

acpi_ut_get_node_name() returns a four char fixed-size array, not
NULL-terminated.

This issue was fixed indirectly in mainline by commit
60a4ce7f4148155d3f28eea4a213f7ee47cd57b7.

This is the minimal fix for stable 2.6.28.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: stable@kernel.org
Cc: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/power.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
index bb7d50d..ad55db1 100644
--- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -151,7 +151,7 @@ static int acpi_power_get_state(acpi_handle handle, int *state)
 	*state = (sta & 0x01)?ACPI_POWER_RESOURCE_STATE_ON:
 			      ACPI_POWER_RESOURCE_STATE_OFF;
 
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Resource [%s] is %s\n",
+	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Resource [%4.4s] is %s\n",
 			  acpi_ut_get_node_name(handle),
 				*state ? "on" : "off"));
 
-- 
1.5.6.5

