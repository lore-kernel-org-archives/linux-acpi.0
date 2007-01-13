From: malattia@linux.it
Subject: [PATCH 10/11] Allow multiple sony_acpi_values for the same .name
Date: Sat, 13 Jan 2007 23:04:40 +0100
Message-ID: <11687258813008-git-send-email-malattia@linux.it>
References: <11687258812893-git-send-email-malattia@linux.it> <1168725881764-git-send-email-malattia@linux.it> <11687258811866-git-send-email-malattia@linux.it> <11687258812417-git-send-email-malattia@linux.it> <11687258812248-git-send-email-malattia@linux.it> <11687258811707-git-send-email-malattia@linux.it> <11687258813214-git-send-email-malattia@linux.it> <1168725881949-git-send-email-malattia@linux.it> <1168725881872-git-send-email-malattia@linux.it> <11687258812443-git-send-email-malattia@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from aa011msr.fastwebnet.it ([85.18.95.71]:58149 "EHLO
	aa011msr.fastwebnet.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751442AbXAMWGA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 13 Jan 2007 17:06:00 -0500
In-Reply-To: <11687258812443-git-send-email-malattia@linux.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Mattia Dongili <malattia@linux.it>

From: Mattia Dongili <malattia@linux.it>

The acpi handles are kept _only_ if both the requested .acpiget and .acpiset
are available in the DSDT.
Currently only the SCDP/CDPW dualism is known.

Signed-off-by: Mattia Dongili <malattia@linux.it>
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
1.4.4.2

