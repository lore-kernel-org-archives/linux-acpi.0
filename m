From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH 01/33] eeepc-laptop: disp attribute should be write-only
Date: Thu,  3 Dec 2009 08:44:45 +0100
Message-ID: <1259826317-18809-2-git-send-email-corentincj@iksaif.net>
References: <1259826317-18809-1-git-send-email-corentincj@iksaif.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.net ([88.191.73.63]:44205 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751329AbZLCHob (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 3 Dec 2009 02:44:31 -0500
In-Reply-To: <1259826317-18809-1-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Alan Jenkins <alan-jenkins@tuffmail.co.uk>, Corentin Chary <corentincj@iksaif.net>

From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>

Currently, reading from the disp attribute fails with "No such device",
which is misleading. According to CMSG table on acpi4asus project site,
no models have a getter method corresponding to SDSP. Change the file
permission to disallow reads.

If some joker changes the permission to permit reads, then return -EIO
to be consistent with sysfs' behaviour when no show() method is
provided.

Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Signed-off-by: Corentin Chary <corentincj@iksaif.net>
---
 drivers/platform/x86/eeepc-laptop.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index 4226e53..2c65a37 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -380,7 +380,7 @@ static ssize_t store_sys_acpi(int cm, const char *buf, size_t count)
 	if (rv > 0)
 		value = set_acpi(cm, value);
 	if (value < 0)
-		return value;
+		return -EIO;
 	return rv;
 }
 
@@ -389,11 +389,11 @@ static ssize_t show_sys_acpi(int cm, char *buf)
 	int value = get_acpi(cm);
 
 	if (value < 0)
-		return value;
+		return -EIO;
 	return sprintf(buf, "%d\n", value);
 }
 
-#define EEEPC_CREATE_DEVICE_ATTR(_name, _cm)				\
+#define EEEPC_CREATE_DEVICE_ATTR(_name, _mode, _cm)			\
 	static ssize_t show_##_name(struct device *dev,			\
 				    struct device_attribute *attr,	\
 				    char *buf)				\
@@ -409,14 +409,14 @@ static ssize_t show_sys_acpi(int cm, char *buf)
 	static struct device_attribute dev_attr_##_name = {		\
 		.attr = {						\
 			.name = __stringify(_name),			\
-			.mode = 0644 },					\
+			.mode = _mode },				\
 		.show   = show_##_name,					\
 		.store  = store_##_name,				\
 	}
 
-EEEPC_CREATE_DEVICE_ATTR(camera, CM_ASL_CAMERA);
-EEEPC_CREATE_DEVICE_ATTR(cardr, CM_ASL_CARDREADER);
-EEEPC_CREATE_DEVICE_ATTR(disp, CM_ASL_DISPLAYSWITCH);
+EEEPC_CREATE_DEVICE_ATTR(camera, 0644, CM_ASL_CAMERA);
+EEEPC_CREATE_DEVICE_ATTR(cardr, 0644, CM_ASL_CARDREADER);
+EEEPC_CREATE_DEVICE_ATTR(disp, 0200, CM_ASL_DISPLAYSWITCH);
 
 struct eeepc_cpufv {
 	int num;
-- 
1.6.5.3

