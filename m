From: Karol Kozimor <sziwan@hell.org.pl>
Subject: [PATCH 4/10] support W3400N
Date: Sat, 1 Jul 2006 01:05:09 +0200
Message-ID: <20060630230509.GF31642@hell.org.pl>
References: <20060118212110.GA7199@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hell.org.pl ([62.233.239.4]:48658 "HELO hell.org.pl")
	by vger.kernel.org with SMTP id S1751376AbWF3XFN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 30 Jun 2006 19:05:13 -0400
Content-Disposition: inline
In-Reply-To: <20060630225905.GB31642@hell.org.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org

This patch adds support for Asus W3400N.

Signed-off-by: Karol Kozimor <sziwan@hell.org.pl>

--- a/drivers/acpi/asus_acpi.c	2006-01-18 17:32:25.000000000 +0100
+++ b/drivers/acpi/asus_acpi.c	2006-01-18 17:36:00.000000000 +0100
@@ -130,7 +130,7 @@ struct asus_hotk {
 		L8L,		//L8400L
 		M1A,		//M1300A
 		M2E,		//M2400E, L4400L
-		M6N,		//M6800N
+		M6N,		//M6800N, W3400N
 		M6R,		//M6700R, A3000G
 		P30,		//Samsung P30
 		S1x,		//S1300A, but also L1400B and M2400A (L84F)
@@ -1090,7 +1090,8 @@ static int __init asus_hotk_get_info(voi
 		hotk->model = L8L;
 	else if (strncmp(model->string.pointer, "L4R", 3) == 0)
 		hotk->model = L4R;
-	else if (strncmp(model->string.pointer, "M6N", 3) == 0)
+	else if (strncmp(model->string.pointer, "M6N", 3) == 0 ||
+		 strncmp(model->string.pointer, "W3N", 3) == 0)
 		hotk->model = M6N;
 	else if (strncmp(model->string.pointer, "M6R", 3) == 0 ||
 		 strncmp(model->string.pointer, "A3G", 3) == 0)
@@ -1143,9 +1144,10 @@ static int __init asus_hotk_get_info(voi
 		hotk->methods->lcd_status = "\\BLFG";
 	/* A3G is like M6R */
 	else if (strncmp(model->string.pointer, "S5N", 3) == 0 ||
-		 strncmp(model->string.pointer, "M5N", 3) == 0)
+		 strncmp(model->string.pointer, "M5N", 3) == 0 ||
+		 strncmp(model->string.pointer, "W3N", 3) == 0)
 		hotk->methods->mt_mled = NULL;
-	/* S5N and M5N have no MLED */
+	/* S5N, M5N and W3N have no MLED */
 	else if (strncmp(model->string.pointer, "M2N", 3) == 0)
 		hotk->methods->mt_wled = "WLED";
 	/* M2N has a usable WLED */
