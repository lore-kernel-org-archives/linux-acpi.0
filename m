From: Jonathan McDowell <noodles@earth.li>
Subject: [PATCH] Add EEE Bluetooth ACPI details
Date: Wed, 3 Dec 2008 20:31:11 +0000
Message-ID: <20081203203111.GA28234@earth.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758537AbYLCUje@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: corentincj@iksaif.net, linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>
List-Id: linux-acpi@vger.kernel.org

Although rfkill support for the EEE bluetooth device has been added to
2.6.28-rc the appropriate ACPI accessor definitions were not added, so
the support was non functional. The patch below adds the get and set
accessors and has been verified to work on an EEE 901.

Signed-off-by: Jonathan McDowell <noodles@earth.li>

-----
diff --git a/drivers/misc/eeepc-laptop.c b/drivers/misc/eeepc-laptop.c
index 02fe2b8..9d93cb9 100644
--- a/drivers/misc/eeepc-laptop.c
+++ b/drivers/misc/eeepc-laptop.c
@@ -90,7 +90,7 @@ enum {
 };
 
 static const char *cm_getv[] = {
-	"WLDG", NULL, NULL, NULL,
+	"WLDG", "BTHG", NULL, NULL,
 	"CAMG", NULL, NULL, NULL,
 	NULL, "PBLG", NULL, NULL,
 	"CFVG", NULL, NULL, NULL,
@@ -99,7 +99,7 @@ static const char *cm_getv[] = {
 };
 
 static const char *cm_setv[] = {
-	"WLDS", NULL, NULL, NULL,
+	"WLDS", "BTHS", NULL, NULL,
 	"CAMS", NULL, NULL, NULL,
 	"SDSP", "PBLS", "HDPS", NULL,
 	"CFVS", NULL, NULL, NULL,
-----

J.

-- 
/-\                             |  umop 3pisdn w,I u3ym hx3s os w,I
|@/  Debian GNU/Linux Developer |
\-                              |
