From: Len Brown <lenb@kernel.org>
Subject: [PATCH 1/5] DMI: move dmi_available declaration to linux/dmi.h
Date: Thu, 17 Jan 2008 05:24:46 -0500
Message-ID: <a4d865fcfc9913f3d2428bc2b7ab1683227a6096.1200565331.git.len.brown@intel.com>
References: <1200565490-29619-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:15353 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754605AbYAQKZF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Jan 2008 05:25:05 -0500
In-Reply-To: <1200565490-29619-1-git-send-email-lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/firmware/dmi-id.c |    2 --
 include/linux/dmi.h       |    2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/dmi-id.c b/drivers/firmware/dmi-id.c
index bc132d8..313c99c 100644
--- a/drivers/firmware/dmi-id.c
+++ b/drivers/firmware/dmi-id.c
@@ -173,8 +173,6 @@ static struct device *dmi_dev;
 	if (dmi_get_system_info(_field)) \
 		sys_dmi_attributes[i++] = &sys_dmi_##_name##_attr.dev_attr.attr;
 
-extern int dmi_available;
-
 /* In a separate function to keep gcc 3.2 happy - do NOT merge this in
    dmi_id_init! */
 static void __init dmi_id_init_attr_table(void)
diff --git a/include/linux/dmi.h b/include/linux/dmi.h
index 00fc7a9..b1251b2 100644
--- a/include/linux/dmi.h
+++ b/include/linux/dmi.h
@@ -78,6 +78,7 @@ extern const struct dmi_device * dmi_find_device(int type, const char *name,
 extern void dmi_scan_machine(void);
 extern int dmi_get_year(int field);
 extern int dmi_name_in_vendors(const char *str);
+extern int dmi_available;
 
 #else
 
@@ -87,6 +88,7 @@ static inline const struct dmi_device * dmi_find_device(int type, const char *na
 	const struct dmi_device *from) { return NULL; }
 static inline int dmi_get_year(int year) { return 0; }
 static inline int dmi_name_in_vendors(const char *s) { return 0; }
+#define dmi_available 0
 
 #endif
 
-- 
1.5.4.rc3.14.g44397

