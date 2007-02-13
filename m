From: Len Brown <lenb@kernel.org>
Subject: [PATCH 18/41] ACPI: asus_acpi: Add support for Asus Z81SP
Date: Tue, 13 Feb 2007 00:49:20 -0500
Message-ID: <11713458071963-git-send-email-lenb@kernel.org>
References: <11713457831139-git-send-email-lenb@kernel.org> <11713457843659-git-send-email-lenb@kernel.org> <11713457871537-git-send-email-lenb@kernel.org> <1171345789246-git-send-email-lenb@kernel.org> <1171345790970-git-send-email-lenb@kernel.org> <11713457922756-git-send-email-lenb@kernel.org> <11713457941772-git-send-email-lenb@kernel.org> <11713457953042-git-send-email-lenb@kernel.org> <11713457971245-git-send-email-lenb@kernel.org> <1171345798129-git-send-email-lenb@kernel.org> <11713457996-git-send-email-lenb@kernel.org> <11713458001192-git-send-email-lenb@kernel.org> <11713458011379-git-send-email-lenb@kernel.org> <11713458021568-git-send-email-lenb@kernel.org> <11713458031539-git-send-email-lenb@kernel.org> <11713458041996-git-send-email-lenb@kernel.org> <11713458052158-git-send-email-lenb@kernel.org> <11713458062930-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:36316 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751065AbXBMFuJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Feb 2007 00:50:09 -0500
In-Reply-To: <11713458062930-git-send-email-lenb@kernel.org>
Message-Id: <1c0f0575fd02a3996f09cac2ef29c4cc5c2d279d.1171345630.git.len.brown@intel.com>
In-Reply-To: <268d175f131e33fe1aed4cd5080884ab5d0badb2.1171345630.git.len.brown@intel.com>
References: <268d175f131e33fe1aed4cd5080884ab5d0badb2.1171345630.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Matthew C Campbell <calvinmc@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>

From: Matthew C Campbell <calvinmc@gmail.com>

Adds support in asus_acpi for the Asus Z81SP laptop.  This preserves all
old functionality when improperly detected as well as enabling Bluetooth
support.

Signed-off-by: Matthew C Campbell <calvinmc@gmail.com>
Acked-by: Corentin Chary <corentincj@iksaif.net>
Cc: Karol Kozimor <sziwan@users.sourceforge.net>
Cc: <acpi4asus-user@lists.sourceforge.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/asus_acpi.c |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/asus_acpi.c b/drivers/acpi/asus_acpi.c
index 31ad70a..fa19a6c 100644
--- a/drivers/acpi/asus_acpi.c
+++ b/drivers/acpi/asus_acpi.c
@@ -141,6 +141,7 @@ struct asus_hotk {
 		W5A,		//W5A
 		W3V,            //W3030V
 		xxN,		//M2400N, M3700N, M5200N, M6800N, S1300N, S5200N
+		A4S,            //Z81sp
 		//(Centrino)
 		END_MODEL
 	} model;		//Models currently supported
@@ -397,7 +398,16 @@ static struct model_data model_conf[END_MODEL] = {
 	 .brightness_set = "SPLV",
 	 .brightness_get = "GPLV",
 	 .display_set = "SDSP",
-	 .display_get = "\\ADVG"}
+	.display_get = "\\ADVG"},
+
+	{
+		.name              = "A4S",
+		.brightness_set    = "SPLV",
+		.brightness_get    = "GPLV",
+		.mt_bt_switch      = "BLED",
+		.mt_wled           = "WLED"
+	}
+
 };
 
 /* procdir we use */
@@ -1117,6 +1127,8 @@ static int asus_model_match(char *model)
 		return W3V;
 	else if (strncmp(model, "W5A", 3) == 0)
 		return W5A;
+	else if (strncmp(model, "A4S", 3) == 0)
+		return A4S;
 	else
 		return END_MODEL;
 }
-- 
1.5.0.rc4.345.gb4d2
