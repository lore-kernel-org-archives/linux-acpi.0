From: Karol Kozimor <sziwan@hell.org.pl>
Subject: [PATCH 9/9] add S1N WLED control
Date: Wed, 18 Jan 2006 23:04:20 +0100
Message-ID: <20060118220420.GJ7199@hell.org.pl>
References: <20060118212110.GA7199@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hell.org.pl ([62.233.239.4]:28433 "HELO hell.org.pl")
	by vger.kernel.org with SMTP id S932486AbWARWEY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 18 Jan 2006 17:04:24 -0500
Content-Disposition: inline
In-Reply-To: <20060118212110.GA7199@hell.org.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org

This small patch adds back WLED control for S1N models, this was
accidentally removed a while ago.

Signed-off-by: Karol Kozimor <sziwan@hell.org.pl>

--- a/drivers/acpi/asus_acpi.c	2006-01-18 18:20:11.000000000 +0100
+++ b/drivers/acpi/asus_acpi.c	2006-01-18 18:24:16.000000000 +0100
@@ -1202,9 +1202,10 @@ static int __init asus_hotk_get_info(voi
 	else if (strncmp(string, "L5D", 3) == 0)
 		hotk->methods->mt_wled = NULL;
 	/* L5D's WLED is not controlled by ACPI */
-	else if (strncmp(string, "M2N", 3) == 0)
+	else if (strncmp(string, "M2N", 3) == 0 ||
+		 strncmp(string, "S1N", 3) == 0)
 		hotk->methods->mt_wled = "WLED";
-	/* M2N has a usable WLED */
+	/* M2N and S1N have a usable WLED */
 	else if (asus_info) {
 		if (strncmp(asus_info->oem_table_id, "L1", 2) == 0)
 			hotk->methods->mled_status = NULL;
