From: Zhao Yakui <yakui.zhao@intel.com>
Subject: [PATCH 1/2]  ACPI : ACPI cleanup in ACPI power resource driver
Date: Thu, 25 Sep 2008 13:22:19 +0800
Message-ID: <1222320139.4023.50.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:54722 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752203AbYIYFRi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 25 Sep 2008 01:17:38 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org

Subject: ACPI: ACPI cleanup in ACPI power resource driver
>From : yakui.zhao@intel.com

It is changed from state to *state in the function of acpi_power_
get_state.

Signed-off-by: yakui.zhao@intel.com

---
 drivers/acpi/power.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: linux-2.6/drivers/acpi/power.c
===================================================================
--- linux-2.6.orig/drivers/acpi/power.c
+++ linux-2.6/drivers/acpi/power.c
@@ -153,7 +153,8 @@ static int acpi_power_get_state(acpi_han
 			      ACPI_POWER_RESOURCE_STATE_OFF;
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Resource [%s] is %s\n",
-			  acpi_ut_get_node_name(handle), state ? "on" : "off"));
+			  acpi_ut_get_node_name(handle),
+				*state ? "on" : "off"));
 
 	return 0;
 }


