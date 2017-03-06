From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v2 02/17] device property: Add macros for calling fwnode operations
Date: Mon,  6 Mar 2017 17:42:48 +0200
Message-ID: <1488814983-25695-3-git-send-email-sakari.ailus@linux.intel.com>
References: <1488814983-25695-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:23419 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753781AbdCFPnd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 6 Mar 2017 10:43:33 -0500
In-Reply-To: <1488814983-25695-1-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
Cc: sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, mika.westerberg@linux.intel.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com

Not all implementations may implement all fwnode operations. Instead of
leaving this up to the caller to figure out, add a few macros for the
purpose.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 include/linux/fwnode.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index ede74fb..75e2a00 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -82,4 +82,19 @@ struct fwnode_operations {
 				    struct fwnode_endpoint *endpoint);
 };
 
+#define fwnode_has_op(fwnode, op)				\
+	((fwnode) && (fwnode)->ops && (fwnode)->ops->op)
+#define fwnode_call_int_op(fwnode, op, ...)				\
+	(fwnode ? (fwnode_has_op(fwnode, op) ?				\
+		   (fwnode)->ops->op(fwnode, ## __VA_ARGS__) : -ENXIO) : \
+	 -EINVAL)
+#define fwnode_call_ptr_op(fwnode, op, ...)		\
+	(fwnode_has_op(fwnode, op) ?			\
+	 (fwnode)->ops->op(fwnode, ## __VA_ARGS__) : NULL)
+#define fwnode_call_void_op(fwnode, op, ...)				\
+	do {								\
+		if (fwnode_has_op(fwnode, op))				\
+			(fwnode)->ops->op(fwnode, ## __VA_ARGS__);	\
+	} while (false)
+
 #endif
-- 
2.7.4

