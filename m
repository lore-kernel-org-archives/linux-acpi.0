From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v5.1 11/13] of: Add nop implementation of of_get_next_parent()
Date: Fri, 17 Mar 2017 14:08:58 +0200
Message-ID: <1489752538-23543-1-git-send-email-sakari.ailus@linux.intel.com>
References: <1489667481-28521-12-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:63377 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751023AbdCQMJy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 17 Mar 2017 08:09:54 -0400
In-Reply-To: <1489667481-28521-12-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
Cc: sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, mika.westerberg@linux.intel.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com, frowand.list@gmail.com

of_get_next_parent() was only defined if CONFIG_OF was set. Using the
function thus requires #ifdef CONFIG_OF ... #endif in all cases. Avoid
having to use pre-processor macros around the function by providing a nop
implementation of of_get_next_parent().

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
since v5:

- Improved commit message.

 include/linux/of.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/of.h b/include/linux/of.h
index e5d4225f..cc212a0 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -586,6 +586,12 @@ static inline struct device_node *of_get_parent(const struct device_node *node)
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

