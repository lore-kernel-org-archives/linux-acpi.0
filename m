From: Helge Deller <deller@gmx.de>
Subject: [PATCH] move DMI prefix strings into struct mafield[]
Date: Fri, 21 Nov 2008 17:59:49 +0100
Message-ID: <200811211759.50021.deller@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:46176 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756615AbYKURA0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 21 Nov 2008 12:00:26 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, linux-acpi@vger.kernel.org

Move the DMI prefix strings (which are max. 3 chars long) directly into the
struct mafield[], instead of storing a pointer to them.
This introduces no functional changes, but gives the advantage of 
saving some bytes in the executable (additional stringspace and the relocation
table entries are gone).

Signed-off-by: Helge Deller <deller@gmx.de>

--- a/drivers/firmware/dmi-id.c
+++ b/drivers/firmware/dmi-id.c
@@ -70,7 +70,7 @@ static void ascii_filter(char *d, const char *s)
 static ssize_t get_modalias(char *buffer, size_t buffer_size)
 {
 	static const struct mafield {
-		const char *prefix;
+		char prefix[4];
 		int field;
 	} fields[] = {
 		{ "bvn", DMI_BIOS_VENDOR },
@@ -85,7 +85,7 @@ static ssize_t get_modalias(char *buffer, size_t buffer_size)
 		{ "cvn", DMI_CHASSIS_VENDOR },
 		{ "ct",  DMI_CHASSIS_TYPE },
 		{ "cvr", DMI_CHASSIS_VERSION },
-		{ NULL,  DMI_NONE }
+		{ "",    DMI_NONE }
 	};
 
 	ssize_t l, left;
@@ -95,7 +95,7 @@ static ssize_t get_modalias(char *buffer, size_t buffer_size)
 	strcpy(buffer, "dmi");
 	p = buffer + 3; left = buffer_size - 4;
 
-	for (f = fields; f->prefix && left > 0; f++) {
+	for (f = fields; f->prefix[0] && left > 0; f++) {
 		const char *c;
 		char *t;
 
