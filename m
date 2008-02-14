From: Len Brown <lenb@kernel.org>
Subject: [PATCH 11/11] ACPI: DMI: quirk for FSC ESPRIMO Mobile V5505
Date: Thu, 14 Feb 2008 02:02:32 -0500
Message-ID: <158c26a0f84e9c66995b44eb4d9acecd3933fc02.1202972422.git.len.brown@intel.com>
References: <1202972552-17953-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:35667 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756515AbYBNHKp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 14 Feb 2008 02:10:45 -0500
In-Reply-To: <1202972552-17953-1-git-send-email-lenb@kernel.org>
In-Reply-To: <b077fbada161479d9a32a7730d2822d5e737b306.1202972422.git.len.brown@intel.com>
References: <b077fbada161479d9a32a7730d2822d5e737b306.1202972422.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

http://bugzilla.kernel.org/show_bug.cgi?id=9939

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/blacklist.c |   16 ++++++++++++++++
 drivers/acpi/osl.c       |    2 +-
 include/linux/acpi.h     |    1 +
 3 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
index dfa4ac8..aa3b4f5 100644
--- a/drivers/acpi/blacklist.c
+++ b/drivers/acpi/blacklist.c
@@ -186,6 +186,13 @@ static int __init dmi_unknown_osi_linux(const struct dmi_system_id *d)
 	acpi_dmi_osi_linux(-1, d);	/* unknown */
 	return 0;
 }
+static int __init dmi_disable_osi_vista(const struct dmi_system_id *d)
+{
+	printk(KERN_NOTICE PREFIX "DMI detected: %s\n", d->ident);
+	acpi_osi_setup("!Windows 2006");
+	return 0;
+}
+static int __init dmi_unknown_osi_linux(const struct dmi_system_id *d)
 
 /*
  * Most BIOS that invoke OSI(Linux) do nothing with it.
@@ -434,6 +441,15 @@ static struct dmi_system_id acpi_osi_dmi_table[] __initdata = {
 		     DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
 		},
 	},
+	{
+	.callback = dmi_disable_osi_vista,
+	.ident = "Fujitsu Siemens",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
+	 	     DMI_MATCH(DMI_PRODUCT_NAME, "ESPRIMO Mobile V5505"),
+		},
+	},
+	/*
 	/*
 	 * Disable OSI(Linux) warnings on all "Hewlett-Packard"
 	 *
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 15e6023..0467171 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -1109,7 +1109,7 @@ void __init acpi_dmi_osi_linux(int enable, const struct dmi_system_id *d)
  * string starting with '!' disables that string
  * otherwise string is added to list, augmenting built-in strings
  */
-static int __init acpi_osi_setup(char *str)
+int __init acpi_osi_setup(char *str)
 {
 	if (str == NULL || *str == '\0') {
 		printk(KERN_INFO PREFIX "_OSI method disabled\n");
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index ddbe7ef..2c7e003 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -203,6 +203,7 @@ extern bool wmi_has_guid(const char *guid);
 extern int acpi_blacklisted(void);
 #ifdef CONFIG_DMI
 extern void acpi_dmi_osi_linux(int enable, const struct dmi_system_id *d);
+extern int acpi_osi_setup(char *str);
 #endif
 
 #ifdef CONFIG_ACPI_NUMA
-- 
1.5.4.1.122.gaa8d

