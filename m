From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 11/11] ACPI: DMI: quirk for FSC ESPRIMO Mobile V5505
Date: Thu, 14 Feb 2008 02:49:12 -0500
Message-ID: <200802140249.12240.lenb@kernel.org>
References: <1202972552-17953-1-git-send-email-lenb@kernel.org> <158c26a0f84e9c66995b44eb4d9acecd3933fc02.1202972422.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:58874 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758179AbYBNHt2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 14 Feb 2008 02:49:28 -0500
Received: from d975xbx2 (c-65-96-213-102.hsd1.ma.comcast.net [65.96.213.102])
	(authenticated bits=0)
	by hera.kernel.org (8.13.8/8.13.8) with ESMTP id m1E7nIl0006348
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-acpi@vger.kernel.org>; Thu, 14 Feb 2008 07:49:21 GMT
In-Reply-To: <158c26a0f84e9c66995b44eb4d9acecd3933fc02.1202972422.git.len.brown@intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

From: Len Brown <len.brown@intel.com>

http://bugzilla.kernel.org/show_bug.cgi?id=9939

Signed-off-by: Len Brown <len.brown@intel.com>
---

(previous message had some syntax errors, courtesy of git cherry-pick)

 drivers/acpi/blacklist.c |   14 ++++++++++++++
 drivers/acpi/osl.c       |    2 +-
 include/linux/acpi.h     |    1 +
 3 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
index dfa4ac8..ea92bac 100644
--- a/drivers/acpi/blacklist.c
+++ b/drivers/acpi/blacklist.c
@@ -186,6 +186,12 @@ static int __init dmi_unknown_osi_linux(const struct dmi_system_id *d)
 	acpi_dmi_osi_linux(-1, d);	/* unknown */
 	return 0;
 }
+static int __init dmi_disable_osi_vista(const struct dmi_system_id *d)
+{
+	printk(KERN_NOTICE PREFIX "DMI detected: %s\n", d->ident);
+	acpi_osi_setup("!Windows 2006");
+	return 0;
+}
 
 /*
  * Most BIOS that invoke OSI(Linux) do nothing with it.
@@ -434,6 +440,14 @@ static struct dmi_system_id acpi_osi_dmi_table[] __initdata = {
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

