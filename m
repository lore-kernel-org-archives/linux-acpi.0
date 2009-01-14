From: Harald Welte <laforge@gnumonks.org>
Subject: [PATCH] panasonic: use snprintf with PAGE_SIZE in sysfs
	attributes
Date: Wed, 14 Jan 2009 14:01:17 +0800
Message-ID: <20090114060117.GM4791@prithivi.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ganesha.gnumonks.org ([213.95.27.120]:42381 "EHLO
	ganesha.gnumonks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754193AbZANGB1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Jan 2009 01:01:27 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org

Instead of just sprintf() into the page-sized buffer provided
by the sysfs/device_attribute API, we use snprintf with PAGE_SIZE
as an additional safeguard.

Signed-off-by: Martin Lucina <mato@kotelna.sk>
Signed-off-by: Harald Welte <laforge@gnumonks.org>
---
 drivers/platform/x86/panasonic-laptop.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/panasonic-laptop.c b/drivers/platform/x86/panasonic-laptop.c
index 54aa8c9..1e37f9e 100644
--- a/drivers/platform/x86/panasonic-laptop.c
+++ b/drivers/platform/x86/panasonic-laptop.c
@@ -367,7 +367,7 @@ static ssize_t show_numbatt(struct device *dev, struct device_attribute *attr,
 	if (!acpi_pcc_retrieve_biosdata(pcc, pcc->sinf))
 		return -EIO;
 
-	return sprintf(buf, "%u\n", pcc->sinf[SINF_NUM_BATTERIES]);
+	return snprintf(buf, PAGE_SIZE, "%u\n", pcc->sinf[SINF_NUM_BATTERIES]);
 }
 
 static ssize_t show_lcdtype(struct device *dev, struct device_attribute *attr,
@@ -379,7 +379,7 @@ static ssize_t show_lcdtype(struct device *dev, struct device_attribute *attr,
 	if (!acpi_pcc_retrieve_biosdata(pcc, pcc->sinf))
 		return -EIO;
 
-	return sprintf(buf, "%u\n", pcc->sinf[SINF_LCD_TYPE]);
+	return snprintf(buf, PAGE_SIZE, "%u\n", pcc->sinf[SINF_LCD_TYPE]);
 }
 
 static ssize_t show_mute(struct device *dev, struct device_attribute *attr,
@@ -391,7 +391,7 @@ static ssize_t show_mute(struct device *dev, struct device_attribute *attr,
 	if (!acpi_pcc_retrieve_biosdata(pcc, pcc->sinf))
 		return -EIO;
 
-	return sprintf(buf, "%u\n", pcc->sinf[SINF_MUTE]);
+	return snprintf(buf, PAGE_SIZE, "%u\n", pcc->sinf[SINF_MUTE]);
 }
 
 static ssize_t show_sticky(struct device *dev, struct device_attribute *attr,
@@ -403,7 +403,7 @@ static ssize_t show_sticky(struct device *dev, struct device_attribute *attr,
 	if (!acpi_pcc_retrieve_biosdata(pcc, pcc->sinf))
 		return -EIO;
 
-	return sprintf(buf, "%u\n", pcc->sinf[SINF_STICKY_KEY]);
+	return snprintf(buf, PAGE_SIZE, "%u\n", pcc->sinf[SINF_STICKY_KEY]);
 }
 
 static ssize_t set_sticky(struct device *dev, struct device_attribute *attr,
-- 
1.5.6.5
