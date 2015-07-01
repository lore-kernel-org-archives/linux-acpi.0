From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: [PATCH v1 05/10] device property: add fwnode_get_name()
Date: Wed,  1 Jul 2015 08:47:58 +0200
Message-ID: <1435733283-19244-6-git-send-email-tomeu.vizoso@collabora.com>
References: <1435733283-19244-1-git-send-email-tomeu.vizoso@collabora.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:36137 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752443AbbGAGs2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Jul 2015 02:48:28 -0400
Received: by wguu7 with SMTP id u7so27787197wgu.3
        for <linux-acpi@vger.kernel.org>; Tue, 30 Jun 2015 23:48:27 -0700 (PDT)
Received: from cizrna.lan ([109.72.12.160])
        by mx.google.com with ESMTPSA id r9sm1319220wjo.26.2015.06.30.23.48.26
        for <linux-acpi@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jun 2015 23:48:27 -0700 (PDT)
In-Reply-To: <1435733283-19244-1-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Getting a textual representation of a device node can be very useful for
debugging.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

 drivers/base/property.c  | 15 +++++++++++++++
 include/linux/property.h |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index a7fb46b..3280b04 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -556,3 +556,18 @@ struct fwnode_handle *fwnode_get_parent(struct fwnode_handle *fwnode)
 	return NULL;
 }
 EXPORT_SYMBOL_GPL(fwnode_get_parent);
+
+/**
+ * fwnode_get_name - return the name of a device node
+ * @fwnode: Device node to find the name of
+ */
+const char *fwnode_get_name(struct fwnode_handle *fwnode)
+{
+	if (is_of_node(fwnode))
+		return to_of_node(fwnode)->full_name;
+	else if (is_acpi_node(fwnode))
+		return acpi_dev_name(to_acpi_node(fwnode));
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(fwnode_get_name);
diff --git a/include/linux/property.h b/include/linux/property.h
index f47092d..020a53c 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -65,6 +65,8 @@ struct fwnode_handle *device_get_next_child_node(struct device *dev,
 
 struct fwnode_handle *fwnode_get_parent(struct fwnode_handle *fwnode);
 
+const char *fwnode_get_name(struct fwnode_handle *fwnode);
+
 #define device_for_each_child_node(dev, child) \
 	for (child = device_get_next_child_node(dev, NULL); child; \
 	     child = device_get_next_child_node(dev, child))
-- 
2.4.1

