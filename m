From: Adrian Bunk <bunk@stusta.de>
Subject: [2.6 patch] make struct sony_nc_ids[] static
Date: Sun, 29 Jul 2007 16:58:06 +0200
Message-ID: <20070729145806.GU16817@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:47812 "EHLO
	mailhub.stusta.mhn.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1764245AbXG2O63 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 29 Jul 2007 10:58:29 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mattia Dongili <malattia@linux.it>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

sony_nc_ids[] can become static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---
--- linux-2.6.23-rc1-mm1/drivers/misc/sony-laptop.c.old	2007-07-26 16:05:54.000000000 +0200
+++ linux-2.6.23-rc1-mm1/drivers/misc/sony-laptop.c	2007-07-26 16:06:05.000000000 +0200
@@ -845,7 +845,7 @@
 };
 
 /* SNC-only model map */
-struct dmi_system_id sony_nc_ids[] = {
+static struct dmi_system_id sony_nc_ids[] = {
 		{
 			.ident = "Sony Vaio FE Series",
 			.callback = sony_nc_C_enable,

