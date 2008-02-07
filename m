From: Len Brown <lenb@kernel.org>
Subject: [PATCH 060/112] ACPI: CELSIUS_TO_KELVIN fixup
Date: Thu,  7 Feb 2008 04:34:22 -0500
Message-ID: <041d4bbf128f645fe53bb22309efb9db14dbf5b5.1202376824.git.len.brown@intel.com>
References: <1202376914-21030-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:48010 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753724AbYBGJgS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Feb 2008 04:36:18 -0500
In-Reply-To: <1202376914-21030-1-git-send-email-lenb@kernel.org>
In-Reply-To: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
References: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Thomas Sujith <sujith.thomas@intel.com>, Len Brown <len.brown@intel.com>

From: Zhang Rui <rui.zhang@intel.com>

Fix an imprecision in CELSIUS_TO_KELVIN and move these
two macroes to a proper place.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Thomas Sujith <sujith.thomas@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/thermal.c  |    3 ---
 include/linux/thermal.h |    4 ++++
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 7400363..aee371f 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -65,9 +65,6 @@
 #define ACPI_THERMAL_MAX_ACTIVE	10
 #define ACPI_THERMAL_MAX_LIMIT_STR_LEN 65
 
-#define KELVIN_TO_CELSIUS(t)    (long)(((long)t-2732>=0) ? ((long)t-2732+5)/10 : ((long)t-2732-5)/10)
-#define CELSIUS_TO_KELVIN(t)	((t+273)*10)
-
 #define _COMPONENT		ACPI_THERMAL_COMPONENT
 ACPI_MODULE_NAME("thermal");
 
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index e4b76c7..bba7712 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -61,6 +61,10 @@ struct thermal_cooling_device {
 	struct list_head node;
 };
 
+#define KELVIN_TO_CELSIUS(t)	(long)(((long)t-2732 >= 0) ?	\
+				((long)t-2732+5)/10 : ((long)t-2732-5)/10)
+#define CELSIUS_TO_KELVIN(t)	((t)*10+2732)
+
 struct thermal_zone_device {
 	int id;
 	char type[THERMAL_NAME_LENGTH];
-- 
1.5.4.23.gef5b9

