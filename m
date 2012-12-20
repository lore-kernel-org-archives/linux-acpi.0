From: Lv Zheng <lv.zheng@intel.com>
Subject: [RESEND PATCH v2 08/19] ACPICA: Enhance error messages.
Date: Thu, 20 Dec 2012 09:09:02 +0800
Message-ID: <881d3ba770bdf23430fb084f255505e623787bba.1355810294.git.lv.zheng@intel.com>
References: <cover.1353491652.git.lv.zheng@intel.com> <cover.1355810292.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:51996 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752016Ab2LTBJK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 19 Dec 2012 20:09:10 -0500
In-Reply-To: <cover.1355810292.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>

This patch decreases 29 lines of 20121018 divergence.diff.

This patch updates error messages that already have been enhanced in
ACPICA. This patch can also help to reduce the source code differences
between Linux and ACPICA.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
Divergences fixing result:
  Before applying: 2011 Lines, 71.6 Kbytes
  After applying: 1982 Lines, 70.5 Kbytes
---
 drivers/acpi/acpica/evgpe.c  |    2 +-
 drivers/acpi/acpica/utmisc.c |    8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/acpica/evgpe.c b/drivers/acpi/acpica/evgpe.c
index a137ce81..4cbb600 100644
--- a/drivers/acpi/acpica/evgpe.c
+++ b/drivers/acpi/acpica/evgpe.c
@@ -765,7 +765,7 @@ acpi_ev_gpe_dispatch(struct acpi_namespace_node *gpe_device,
 					 gpe_event_info);
 		if (ACPI_FAILURE(status)) {
 			ACPI_EXCEPTION((AE_INFO, status,
-					"Unable to queue handler for GPE%2X - event disabled",
+					"Unable to queue handler for GPE%02X - event disabled",
 					gpe_number));
 		}
 		break;
diff --git a/drivers/acpi/acpica/utmisc.c b/drivers/acpi/acpica/utmisc.c
index 9286a69..2881992 100644
--- a/drivers/acpi/acpica/utmisc.c
+++ b/drivers/acpi/acpica/utmisc.c
@@ -748,12 +748,12 @@ void acpi_ut_repair_name(char *name)
 
 		if (!acpi_gbl_enable_interpreter_slack) {
 			ACPI_WARNING((AE_INFO,
-				      "Found bad character(s) in name, repaired: [%4.4s]\n",
-				      name));
+				      "Invalid character(s) in name (0x%.8X), repaired: [%4.4s]",
+					  original_name, name));
 		} else {
 			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-					  "Found bad character(s) in name, repaired: [%4.4s]\n",
-					  name));
+					  "Invalid character(s) in name (0x%.8X), repaired: [%4.4s]",
+					  original_name, name));
 		}
 	}
 }
-- 
1.7.10

