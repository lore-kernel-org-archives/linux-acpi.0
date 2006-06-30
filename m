From: Karol Kozimor <sziwan@hell.org.pl>
Subject: [PATCH 5/10] support A4G
Date: Sat, 1 Jul 2006 01:05:56 +0200
Message-ID: <20060630230556.GG31642@hell.org.pl>
References: <20060118212110.GA7199@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hell.org.pl ([62.233.239.4]:31750 "HELO hell.org.pl")
	by vger.kernel.org with SMTP id S1751444AbWF3XGA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 30 Jun 2006 19:06:00 -0400
Content-Disposition: inline
In-Reply-To: <20060630225905.GB31642@hell.org.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org

This patch adds support for Asus A4G.
Originally by Giuseppe Rota.

Signed-off-by: Karol Kozimor <sziwan@hell.org.pl>

--- a/drivers/acpi/asus_acpi.c	2006-01-18 17:36:00.000000000 +0100
+++ b/drivers/acpi/asus_acpi.c	2006-01-18 17:44:03.000000000 +0100
@@ -120,6 +120,7 @@ struct asus_hotk {
 	enum {
 		A1x = 0,	//A1340D, A1300F
 		A2x,		//A2500H
+		A4G,		//A4700G
 		D1x,		//D1
 		L2D,		//L2000D
 		L3C,		//L3800C
@@ -189,6 +190,16 @@ static struct model_data model_conf[END_
 	 .display_get = "\\INFB"},
 
 	{
+	 .name = "A4G",
+	 .mt_mled = "MLED",
+/* WLED present, but not controlled by ACPI */
+	 .mt_lcd_switch = xxN_PREFIX "_Q10",
+	 .brightness_set = "SPLV",
+	 .brightness_get = "GPLV",
+	 .display_set = "SDSP",
+	 .display_get = "\\ADVG"},
+
+	{
 	 .name = "D1x",
 	 .mt_mled = "MLED",
 	 .mt_lcd_switch = "\\Q0D",
@@ -1122,6 +1133,8 @@ static int __init asus_hotk_get_info(voi
 		hotk->model = S2x;
 	else if (strncmp(model->string.pointer, "L5", 2) == 0)
 		hotk->model = L5x;
+	else if (strncmp(model->string.pointer, "A4G", 3) == 0)
+		hotk->model = A4G;
 	else if (strncmp(model->string.pointer, "W1N", 3) == 0)
 		hotk->model = W1N;
 
