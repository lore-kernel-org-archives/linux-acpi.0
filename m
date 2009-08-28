From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH 15/24] asus-laptop: Show HRWS in infos and fix output format
Date: Fri, 28 Aug 2009 14:56:46 +0200
Message-ID: <1251464215-6540-16-git-send-email-corentincj@iksaif.net>
References: <1251464215-6540-1-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-2-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-3-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-4-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-5-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-6-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-7-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-8-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-9-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-10-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-11-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-12-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-13-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-14-git-send-email-corentincj@iksaif.net>
 <1251464215-6540-15-git-send-email-corentincj@iksaif.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp22.services.sfr.fr ([93.17.128.11]:60843 "EHLO
	smtp22.services.sfr.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750851AbZH1NDk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 28 Aug 2009 09:03:40 -0400
In-Reply-To: <1251464215-6540-15-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, alan-jenkins@tuffmail.co.uk, Corentin Chary <corentincj@iksaif.net>

Show HRWS in /sys/platform/devices/asus-laptop/infos.
HRWS is a bitfield used to get information about Hardware
available in the laptop.
Also change sprintf format from 0x%04x to %#x.

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
---
 drivers/platform/x86/asus-laptop.c |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/asus-laptop.c b/drivers/platform/x86/asus-laptop.c
index db657bb..2344950 100644
--- a/drivers/platform/x86/asus-laptop.c
+++ b/drivers/platform/x86/asus-laptop.c
@@ -516,7 +516,17 @@ static ssize_t show_infos(struct device *dev,
 	 */
 	rv = acpi_evaluate_integer(hotk->handle, "SFUN", NULL, &temp);
 	if (!ACPI_FAILURE(rv))
-		len += sprintf(page + len, "SFUN value         : 0x%04x\n",
+		len += sprintf(page + len, "SFUN value         : %#x\n",
+			       (uint) temp);
+	/*
+	 * The HWRS method return informations about the hardware.
+	 * 0x80 bit is for WLAN, 0x100 for Bluetooth.
+	 * The significance of others is yet to be found.
+	 * If we don't find the method, we assume the device are present.
+	 */
+	rv = acpi_evaluate_integer(hotk->handle, "HRWS", NULL, &temp);
+	if (!ACPI_FAILURE(rv))
+		len += sprintf(page + len, "HRWS value         : %#x\n",
 			       (uint) temp);
 	/*
 	 * Another value for userspace: the ASYM method returns 0x02 for
@@ -527,7 +537,7 @@ static ssize_t show_infos(struct device *dev,
 	 */
 	rv = acpi_evaluate_integer(hotk->handle, "ASYM", NULL, &temp);
 	if (!ACPI_FAILURE(rv))
-		len += sprintf(page + len, "ASYM value         : 0x%04x\n",
+		len += sprintf(page + len, "ASYM value         : %#x\n",
 			       (uint) temp);
 	if (asus_info) {
 		snprintf(buf, 16, "%d", asus_info->length);
-- 
1.6.4


