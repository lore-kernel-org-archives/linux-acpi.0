From: Len Brown <lenb@kernel.org>
Subject: [PATCH 07/15] ACPI: fix allowing to add/remove multiple _OSI strings
Date: Sat, 11 Dec 2010 02:06:32 -0500
Message-ID: <12d3206466d2074ef0684aaf7759ae01a0a92560.1292051119.git.len.brown@intel.com>
References: <1292051200-13689-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:61811 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751099Ab0LKHHD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 11 Dec 2010 02:07:03 -0500
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LD900JT953Q6456@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 11 Dec 2010 01:07:03 -0600 (CST)
In-reply-to: <1292051200-13689-1-git-send-email-lenb@kernel.org>
In-reply-to: <212967c69afd348342548272aedbe4d46a9325d6.1292051119.git.len.brown@intel.com>
References: <212967c69afd348342548272aedbe4d46a9325d6.1292051119.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Lin Ming <ming.m.lin@intel.com>

commit b0ed7a91(ACPICA/ACPI: Add new host interfaces for _OSI suppor)
introduced another regression that only one _OSI string can be added or
removed.

Now multiple _OSI strings can be added or removed, for example

acpi_osi=Linux acpi_osi=FreeBSD acpi_osi="!Windows 2006"

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/osl.c |   66 +++++++++++++++++++++++++++++++++++++++------------
 1 files changed, 50 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 6867443..d0a1bb5 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -110,9 +110,6 @@ struct acpi_ioremap {
 static LIST_HEAD(acpi_ioremaps);
 static DEFINE_SPINLOCK(acpi_ioremap_lock);
 
-#define	OSI_STRING_LENGTH_MAX 64	/* arbitrary */
-static char osi_setup_string[OSI_STRING_LENGTH_MAX];
-
 static void __init acpi_osi_setup_late(void);
 
 /*
@@ -1054,16 +1051,47 @@ static int __init acpi_os_name_setup(char *str)
 
 __setup("acpi_os_name=", acpi_os_name_setup);
 
+#define	OSI_STRING_LENGTH_MAX 64	/* arbitrary */
+#define	OSI_STRING_ENTRIES_MAX 16	/* arbitrary */
+
+struct osi_setup_entry {
+	char string[OSI_STRING_LENGTH_MAX];
+	bool enable;
+};
+
+static struct osi_setup_entry __initdata osi_setup_entries[OSI_STRING_ENTRIES_MAX];
+
 void __init acpi_osi_setup(char *str)
 {
+	struct osi_setup_entry *osi;
+	bool enable = true;
+	int i;
+
 	if (!acpi_gbl_create_osi_method)
 		return;
 
 	if (str == NULL || *str == '\0') {
 		printk(KERN_INFO PREFIX "_OSI method disabled\n");
 		acpi_gbl_create_osi_method = FALSE;
-	} else
-		strncpy(osi_setup_string, str, OSI_STRING_LENGTH_MAX);
+		return;
+	}
+
+	if (*str == '!') {
+		str++;
+		enable = false;
+	}
+
+	for (i = 0; i < OSI_STRING_ENTRIES_MAX; i++) {
+		osi = &osi_setup_entries[i];
+		if (!strcmp(osi->string, str)) {
+			osi->enable = enable;
+			break;
+		} else if (osi->string[0] == '\0') {
+			osi->enable = enable;
+			strncpy(osi->string, str, OSI_STRING_LENGTH_MAX);
+			break;
+		}
+	}
 }
 
 static void __init set_osi_linux(unsigned int enable)
@@ -1110,22 +1138,28 @@ void __init acpi_dmi_osi_linux(int enable, const struct dmi_system_id *d)
  */
 static void __init acpi_osi_setup_late(void)
 {
-	char *str = osi_setup_string;
+	struct osi_setup_entry *osi;
+	char *str;
+	int i;
 	acpi_status status;
 
-	if (*str == '\0')
-		return;
+	for (i = 0; i < OSI_STRING_ENTRIES_MAX; i++) {
+		osi = &osi_setup_entries[i];
+		str = osi->string;
 
-	if (*str == '!') {
-		status = acpi_remove_interface(++str);
+		if (*str == '\0')
+			break;
+		if (osi->enable) {
+			status = acpi_install_interface(str);
 
-		if (ACPI_SUCCESS(status))
-			printk(KERN_INFO PREFIX "Deleted _OSI(%s)\n", str);
-	} else {
-		status = acpi_install_interface(str);
+			if (ACPI_SUCCESS(status))
+				printk(KERN_INFO PREFIX "Added _OSI(%s)\n", str);
+		} else {
+			status = acpi_remove_interface(str);
 
-		if (ACPI_SUCCESS(status))
-			printk(KERN_INFO PREFIX "Added _OSI(%s)\n", str);
+			if (ACPI_SUCCESS(status))
+				printk(KERN_INFO PREFIX "Deleted _OSI(%s)\n", str);
+		}
 	}
 }
 
-- 
1.7.3.3.480.g2f76a

