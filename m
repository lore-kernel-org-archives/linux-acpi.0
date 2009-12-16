From: Len Brown <lenb@kernel.org>
Subject: [PATCH 018/103] eeepc-laptop: disp attribute should be write-only
Date: Wed, 16 Dec 2009 03:35:29 -0500
Message-ID: <6dff29b63a5bf2eaf3313cb8a84f0b7520c43401.1260952472.git.len.brown@intel.com>
References: <1260952614-3152-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:47226 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762010AbZLPLGJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 06:06:09 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KUQ00BZPS5OJK34@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 16 Dec 2009 05:05:58 -0600 (CST)
In-reply-to: <1260952614-3152-1-git-send-email-lenb@kernel.org>
In-reply-to: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
References: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alan Jenkins <alan-jenkins@tuffmail.co.uk>, Corentin Chary <corentincj@iksaif.net>, Len Brown <len.brown@intel.com>

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
Signed-off-by: Len Brown <len.brown@intel.com>
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
1.6.0.6

