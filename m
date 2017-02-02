From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v2 14/16] of: Add nop implementation of of_get_next_parent()
Date: Thu,  2 Feb 2017 18:22:24 +0200
Message-ID: <1486052546-19257-15-git-send-email-sakari.ailus@linux.intel.com>
References: <1486052546-19257-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:2356 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751147AbdBBQYA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 2 Feb 2017 11:24:00 -0500
In-Reply-To: <1486052546-19257-1-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
Cc: sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, mika.westerberg@linux.intel.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com

To avoid #ifdefs where the function is used.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 include/linux/of.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/of.h b/include/linux/of.h
index 16b2054..e0ddb22 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -585,6 +585,12 @@ static inline struct device_node *of_get_parent(const struct device_node *node)
 	return NULL;
 }
 
+static inline struct device_node *of_get_next_parent(
+	const struct device_node *node)
+{
+	return NULL;
+}
+
 static inline struct device_node *of_get_next_child(
 	const struct device_node *node, struct device_node *prev)
 {
-- 
2.7.4

