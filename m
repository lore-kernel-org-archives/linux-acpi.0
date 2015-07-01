From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: [PATCH v1 08/10] device property: add fwnode_is_compatible()
Date: Wed,  1 Jul 2015 08:48:01 +0200
Message-ID: <1435733283-19244-9-git-send-email-tomeu.vizoso@collabora.com>
References: <1435733283-19244-1-git-send-email-tomeu.vizoso@collabora.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:35147 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753482AbbGAGsc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Jul 2015 02:48:32 -0400
Received: by wiga1 with SMTP id a1so116476392wig.0
        for <linux-acpi@vger.kernel.org>; Tue, 30 Jun 2015 23:48:31 -0700 (PDT)
Received: from cizrna.lan ([109.72.12.160])
        by mx.google.com with ESMTPSA id r9sm1319220wjo.26.2015.06.30.23.48.30
        for <linux-acpi@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jun 2015 23:48:30 -0700 (PDT)
In-Reply-To: <1435733283-19244-1-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

This is being added so code that is independent of the firmware being
used can match firmware nodes to devices.

This commit only implements it for OF nodes.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

 drivers/base/property.c  | 9 +++++++++
 include/linux/property.h | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 92cdbb3..9c8be31 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -585,3 +585,12 @@ const char *fwnode_get_name(struct fwnode_handle *fwnode)
 	return NULL;
 }
 EXPORT_SYMBOL_GPL(fwnode_get_name);
+
+bool fwnode_is_compatible(struct fwnode_handle *fwnode, const char *compatible)
+{
+	if (is_of_node(fwnode))
+		return of_device_is_compatible(to_of_node(fwnode), compatible);
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(fwnode_is_compatible);
diff --git a/include/linux/property.h b/include/linux/property.h
index cfd1eb2..bf10074 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -80,6 +80,8 @@ const char *fwnode_get_name(struct fwnode_handle *fwnode);
 
 void fwnode_handle_put(struct fwnode_handle *fwnode);
 
+bool fwnode_is_compatible(struct fwnode_handle *fwnode, const char *compatible);
+
 unsigned int device_get_child_node_count(struct device *dev);
 
 static inline bool device_property_read_bool(struct device *dev,
-- 
2.4.1

