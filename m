From: Len Brown <lenb@kernel.org>
Subject: [PATCH 2/5] DMI: create dmi_dump_entries()
Date: Thu, 17 Jan 2008 05:24:47 -0500
Message-ID: <b453c8fd7383e5505944d04edd0fdff92254a74f.1200565331.git.len.brown@intel.com>
References: <1200565490-29619-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:15353 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754643AbYAQKZF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Jan 2008 05:25:05 -0500
In-Reply-To: <1200565490-29619-1-git-send-email-lenb@kernel.org>
In-Reply-To: <a4d865fcfc9913f3d2428bc2b7ab1683227a6096.1200565331.git.len.brown@intel.com>
References: <a4d865fcfc9913f3d2428bc2b7ab1683227a6096.1200565331.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

Create a routine to dump the requested DMI entries to the console.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/firmware/dmi_scan.c |   19 +++++++++++++++++++
 include/linux/dmi.h         |    2 ++
 2 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/drivers/firmware/dmi_scan.c b/drivers/firmware/dmi_scan.c
index 0cdadea..11e475d 100644
--- a/drivers/firmware/dmi_scan.c
+++ b/drivers/firmware/dmi_scan.c
@@ -470,3 +470,22 @@ int dmi_get_year(int field)
 	return year;
 }
 
+/**
+ *	dmi_dump_entries - print DMI entries to console
+ *	@entries:	bit-mask specifying dmi_field(s)
+ *
+ *	Returns 0 on success
+ */
+int dmi_dump_entries(int entries)
+{
+	int index;
+
+	if (!dmi_available)
+		return -1;
+
+	for (index = 0; index < DMI_STRING_MAX; ++index) {
+		if (entries & (1 << index))
+			printk(KERN_INFO "%d. %s\n", index, dmi_ident[index]);
+	}
+	return 0;
+}
diff --git a/include/linux/dmi.h b/include/linux/dmi.h
index b1251b2..61469f6 100644
--- a/include/linux/dmi.h
+++ b/include/linux/dmi.h
@@ -79,6 +79,7 @@ extern void dmi_scan_machine(void);
 extern int dmi_get_year(int field);
 extern int dmi_name_in_vendors(const char *str);
 extern int dmi_available;
+extern int dmi_dump_entries(int entries);
 
 #else
 
@@ -89,6 +90,7 @@ static inline const struct dmi_device * dmi_find_device(int type, const char *na
 static inline int dmi_get_year(int year) { return 0; }
 static inline int dmi_name_in_vendors(const char *s) { return 0; }
 #define dmi_available 0
+static inline int dmi_dump_entries(int entries) { return -1; }
 
 #endif
 
-- 
1.5.4.rc3.14.g44397

