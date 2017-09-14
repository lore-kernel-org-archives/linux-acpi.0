From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [RFC 3/5] of: Return total number of entries in of_count_phandle_with_args
Date: Thu, 14 Sep 2017 15:29:12 +0300
Message-ID: <20170914122914.14122-4-sakari.ailus@linux.intel.com>
References: <20170914122914.14122-1-sakari.ailus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nblzone-211-213.nblnetworks.fi ([83.145.211.213]:32864 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751768AbdINM3R (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 14 Sep 2017 08:29:17 -0400
In-Reply-To: <20170914122914.14122-1-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: devicetree@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: rafael@kernel.org, robh@kernel.org, mika.westerberg@linux.intel.com, frowand.list@gmail.com

of_count_phandle_with_args used to count the phandles until the end of the
list or when the first empty phandle was encountered. There may be valid
entries after the empty phandle as well, include all entries to the count.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/of/base.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index fb2fd90f525c..4c8b93cfd06c 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1418,14 +1418,14 @@ EXPORT_SYMBOL(of_parse_phandle_with_fixed_args);
  * @list_name:	property name that contains a list
  * @cells_name:	property name that specifies phandles' arguments count
  *
- * Returns the number of phandle + argument tuples within a property. It
- * is a typical pattern to encode a list of phandle and variable
- * arguments into a single property. The number of arguments is encoded
- * by a property in the phandle-target node. For example, a gpios
- * property would contain a list of GPIO specifies consisting of a
- * phandle and 1 or more arguments. The number of arguments are
- * determined by the #gpio-cells property in the node pointed to by the
- * phandle.
+ * Returns the number of phandle + argument tuples within a property
+ * including empty phandles. It is a typical pattern to encode a list
+ * of phandle and variable arguments into a single property. The
+ * number of arguments is encoded by a property in the phandle-target
+ * node. For example, a gpios property would contain a list of GPIO
+ * specifies consisting of a phandle and 1 or more arguments. The
+ * number of arguments are determined by the #gpio-cells property in
+ * the node pointed to by the phandle.
  *
  * Returns the number of phandles + arguments tuples within a property
  * on success, %-ENODATA if the property isn't found and %-EINVAL on
@@ -1441,12 +1441,12 @@ int of_count_phandle_with_args(const struct device_node *np, const char *list_na
 	if (rc)
 		return rc;
 
-	for (rc = of_phandle_iterator_next(&it); !rc;
+	for (rc = of_phandle_iterator_next(&it); !rc || rc == -ENOENT;
 	     rc = of_phandle_iterator_next(&it))
 		cur_index += 1;
 
-	if (rc != -ENODATA && rc != -ENOENT)
-		return rc == -ENOENT ? -ENODATA : rc;
+	if (rc != -ENODATA)
+		return rc;
 
 	return cur_index;
 }
-- 
2.11.0

