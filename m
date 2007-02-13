From: Len Brown <lenb@kernel.org>
Subject: [PATCH 10/41] sony_acpi: Allow multiple sony_acpi_values for the same .name
Date: Tue, 13 Feb 2007 00:49:12 -0500
Message-ID: <11713457996-git-send-email-lenb@kernel.org>
References: <11713457831139-git-send-email-lenb@kernel.org> <11713457843659-git-send-email-lenb@kernel.org> <11713457871537-git-send-email-lenb@kernel.org> <1171345789246-git-send-email-lenb@kernel.org> <1171345790970-git-send-email-lenb@kernel.org> <11713457922756-git-send-email-lenb@kernel.org> <11713457941772-git-send-email-lenb@kernel.org> <11713457953042-git-send-email-lenb@kernel.org> <11713457971245-git-send-email-lenb@kernel.org> <1171345798129-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:39577 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751054AbXBMFuB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Feb 2007 00:50:01 -0500
In-Reply-To: <1171345798129-git-send-email-lenb@kernel.org>
Message-Id: <da375c9066d5c17bb8c52350c5a13b9c80ddf29d.1171345630.git.len.brown@intel.com>
In-Reply-To: <268d175f131e33fe1aed4cd5080884ab5d0badb2.1171345630.git.len.brown@intel.com>
References: <268d175f131e33fe1aed4cd5080884ab5d0badb2.1171345630.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Mattia Dongili <malattia@linux.it>, Len Brown <len.brown@intel.com>

From: Mattia Dongili <malattia@linux.it>

The acpi handles are kept _only_ if both the requested .acpiget and .acpiset
are available in the DSDT.
Currently only the SCDP/CDPW dualism is known.

Signed-off-by: Mattia Dongili <malattia@linux.it>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/sony_acpi.c |   44 +++++++++++++++++++++++++-------------------
 1 files changed, 25 insertions(+), 19 deletions(-)

diff --git a/drivers/acpi/sony_acpi.c b/drivers/acpi/sony_acpi.c
index 1f7dca3..c65f589 100644
--- a/drivers/acpi/sony_acpi.c
+++ b/drivers/acpi/sony_acpi.c
@@ -68,7 +68,7 @@ static struct backlight_properties sony_backlight_properties = {
 
 static struct sony_acpi_value {
 	char			*name;	 /* name of the entry */
-	struct proc_dir_entry 	*proc;	 /* /proc entry */
+	struct proc_dir_entry	*proc;	 /* /proc entry */
 	char			*acpiget;/* name of the ACPI get function */
 	char			*acpiset;/* name of the ACPI get function */
 	int 			min;	 /* minimum allowed value or -1 */
@@ -78,6 +78,7 @@ static struct sony_acpi_value {
 	int			debug;	 /* active only in debug mode ? */
 } sony_acpi_values[] = {
 	{
+		/* for backward compatibility only */
 		.name		= "brightness",
 		.acpiget	= "GBRT",
 		.acpiset	= "SBRT",
@@ -107,6 +108,14 @@ static struct sony_acpi_value {
 		.debug		= 0,
 	},
 	{
+		.name		= "cdpower",
+		.acpiget	= "GCDP",
+		.acpiset	= "CDPW",
+		.min		= 0,
+		.max		= 1,
+		.debug		= 0,
+	},
+	{
 		.name           = "audiopower",
 		.acpiget        = "GAZP",
 		.acpiset        = "AZPW",
@@ -356,27 +365,24 @@ static int sony_acpi_add(struct acpi_device *device)
 		if (!debug && item->debug)
 			continue;
 
-		if (item->acpiget &&
-		    ACPI_SUCCESS(acpi_get_handle(sony_acpi_handle,
-		    		 item->acpiget, &handle)))
-			proc_file_mode = S_IRUSR;
-		else
-			printk(LOG_PFX "unable to get ACPI handle for %s (get)\n",
-					item->name);
-
-		if (item->acpiset &&
-		    ACPI_SUCCESS(acpi_get_handle(sony_acpi_handle,
-		    		 item->acpiset, &handle)))
-			proc_file_mode |= S_IWUSR;
-		else
-			printk(LOG_PFX "unable to get ACPI handle for %s (set)\n",
-					item->name);
+		if (item->acpiget) {
+			if (ACPI_FAILURE(acpi_get_handle(sony_acpi_handle,
+							item->acpiget, &handle)))
+				continue;
 
-		if (proc_file_mode == 0)
-			continue;
+			proc_file_mode |= S_IRUSR;
+		}
+
+		if (item->acpiset) {
+			if (ACPI_FAILURE(acpi_get_handle(sony_acpi_handle,
+							item->acpiset, &handle)))
+				continue;
+
+			proc_file_mode |= S_IWUSR;
+		}
 
 		item->proc = create_proc_entry(item->name, proc_file_mode,
-					       acpi_device_dir(device));
+				acpi_device_dir(device));
 		if (!item->proc) {
 			printk(LOG_PFX "unable to create proc entry\n");
 			result = -EIO;
-- 
1.5.0.rc4.345.gb4d2
