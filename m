From: Adrian Bunk <bunk@kernel.org>
Subject: [2.6 patch] make drivers/acpi/scan.c:create_modalias() static
Date: Tue, 14 Aug 2007 23:22:35 +0200
Message-ID: <20070814212235.GY18945@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailout.stusta.mhn.de ([141.84.69.5]:38404 "EHLO
	mailhub.stusta.mhn.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756305AbXHNVWs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 14 Aug 2007 17:22:48 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

This patch makes the needlessly global create_modalias() static.

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---
08005ed26370f24624bc7d88ced619318f4c0f56 
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index be74347..64620d6 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -35,8 +35,9 @@ struct acpi_device_bus_id{
  * e.g. on a device with hid:IBM0001 and cid:ACPI0001 you get:
  * char *modalias: "acpi:IBM0001:ACPI0001"
 */
-int create_modalias(struct acpi_device *acpi_dev, char *modalias, int size){
-
+static int create_modalias(struct acpi_device *acpi_dev, char *modalias,
+			   int size)
+{
 	int len;
 
 	if (!acpi_dev->flags.hardware_id)

