From: Karol Kozimor <sziwan@hell.org.pl>
Subject: [PATCH 7/10] support L5D
Date: Sat, 1 Jul 2006 01:08:02 +0200
Message-ID: <20060630230802.GI31642@hell.org.pl>
References: <20060118212110.GA7199@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hell.org.pl ([62.233.239.4]:4623 "HELO hell.org.pl")
	by vger.kernel.org with SMTP id S1751567AbWF3XIF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 30 Jun 2006 19:08:05 -0400
Content-Disposition: inline
In-Reply-To: <20060630225905.GB31642@hell.org.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org

This patch adds support for Asus L5D and thus fixes
http://bugme.osdl.org/show_bug.cgi?id=4695

Signed-off-by: Karol Kozimor <sziwan@hell.org.pl>

--- a/drivers/acpi/asus_acpi.c	2006-01-18 18:08:48.000000000 +0100
+++ b/drivers/acpi/asus_acpi.c	2006-01-18 18:10:40.000000000 +0100
@@ -129,7 +129,7 @@ struct asus_hotk {
 		L2D,		//L2000D
 		L3C,		//L3800C
 		L3D,		//L3400D
-		L3H,		//L3H, but also L2000E
+		L3H,		//L3H, L2000E, L5D
 		L4R,		//L4500R
 		L5x,		//L5800C 
 		L8L,		//L8400L
@@ -1123,8 +1123,9 @@ static int __init asus_hotk_get_info(voi
 	hotk->model = END_MODEL;
 	if (strncmp(model->string.pointer, "L3D", 3) == 0)
 		hotk->model = L3D;
-	else if (strncmp(model->string.pointer, "L3H", 3) == 0 ||
-		 strncmp(model->string.pointer, "L2E", 3) == 0)
+	else if (strncmp(model->string.pointer, "L2E", 3) == 0 ||
+		 strncmp(model->string.pointer, "L3H", 3) == 0 ||
+		 strncmp(model->string.pointer, "L5D", 3) == 0)
 		hotk->model = L3H;
 	else if (strncmp(model->string.pointer, "L3", 2) == 0 ||
 		 strncmp(model->string.pointer, "L2B", 3) == 0)
@@ -1195,6 +1196,9 @@ static int __init asus_hotk_get_info(voi
 		 strncmp(model->string.pointer, "W3N", 3) == 0)
 		hotk->methods->mt_mled = NULL;
 	/* S5N, M5N and W3N have no MLED */
+	else if (strncmp(model->string.pointer, "L5D", 3) == 0)
+		hotk->methods->mt_wled = NULL;
+	/* L5D's WLED is not controlled by ACPI */
 	else if (strncmp(model->string.pointer, "M2N", 3) == 0)
 		hotk->methods->mt_wled = "WLED";
 	/* M2N has a usable WLED */
