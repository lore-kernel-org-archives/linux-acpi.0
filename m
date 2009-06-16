From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH 11/15] eeepc-laptop: sync eeepc-laptop with asus_acpi
Date: Tue, 16 Jun 2009 21:28:52 +0200
Message-ID: <1245180536-28009-12-git-send-email-corentincj@iksaif.net>
References: <1245180536-28009-1-git-send-email-corentincj@iksaif.net>
 <1245180536-28009-2-git-send-email-corentincj@iksaif.net>
 <1245180536-28009-3-git-send-email-corentincj@iksaif.net>
 <1245180536-28009-4-git-send-email-corentincj@iksaif.net>
 <1245180536-28009-5-git-send-email-corentincj@iksaif.net>
 <1245180536-28009-6-git-send-email-corentincj@iksaif.net>
 <1245180536-28009-7-git-send-email-corentincj@iksaif.net>
 <1245180536-28009-8-git-send-email-corentincj@iksaif.net>
 <1245180536-28009-9-git-send-email-corentincj@iksaif.net>
 <1245180536-28009-10-git-send-email-corentincj@iksaif.net>
 <1245180536-28009-11-git-send-email-corentincj@iksaif.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.net ([88.191.73.63]:60978 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752647AbZFPTb0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 16 Jun 2009 15:31:26 -0400
In-Reply-To: <1245180536-28009-11-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Corentin Chary <corentincj@iksaif.net>

In the default Eee PC distribution, there is a modified
asus_acpi driver. eeepc-laptop is a cleaned version of this
driver. Sync ASL enum and getter/setters with asus_acpi.

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
---
 drivers/platform/x86/eeepc-laptop.c |   19 +++++++++++++++----
 1 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index 7121239..8ef9f74 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -60,7 +60,10 @@ enum {
 	DISABLE_ASL_GPS = 0x0020,
 	DISABLE_ASL_DISPLAYSWITCH = 0x0040,
 	DISABLE_ASL_MODEM = 0x0080,
-	DISABLE_ASL_CARDREADER = 0x0100
+	DISABLE_ASL_CARDREADER = 0x0100,
+	DISABLE_ASL_3G = 0x0200,
+	DISABLE_ASL_WIMAX = 0x0400,
+	DISABLE_ASL_HWCF = 0x0800
 };
 
 enum {
@@ -85,7 +88,13 @@ enum {
 	CM_ASL_USBPORT3,
 	CM_ASL_MODEM,
 	CM_ASL_CARDREADER,
-	CM_ASL_LID
+	CM_ASL_3G,
+	CM_ASL_WIMAX,
+	CM_ASL_HWCF,
+	CM_ASL_LID,
+	CM_ASL_TYPE,
+	CM_ASL_PANELPOWER,	/*P901*/
+	CM_ASL_TPD
 };
 
 static const char *cm_getv[] = {
@@ -94,7 +103,8 @@ static const char *cm_getv[] = {
 	NULL, "PBLG", NULL, NULL,
 	"CFVG", NULL, NULL, NULL,
 	"USBG", NULL, NULL, "MODG",
-	"CRDG", "LIDG"
+	"CRDG", "M3GG", "WIMG", "HWCF",
+	"LIDG",	"TYPE", "PBPG",	"TPDG"
 };
 
 static const char *cm_setv[] = {
@@ -103,7 +113,8 @@ static const char *cm_setv[] = {
 	"SDSP", "PBLS", "HDPS", NULL,
 	"CFVS", NULL, NULL, NULL,
 	"USBG", NULL, NULL, "MODS",
-	"CRDS", NULL
+	"CRDS", "M3GS", "WIMS", NULL,
+	NULL, NULL, "PBPS", "TPDS"
 };
 
 #define EEEPC_EC	"\\_SB.PCI0.SBRG.EC0."
-- 
1.6.3.1

