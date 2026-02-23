Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEADC37D12D;
	Mon, 23 Feb 2026 20:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771879470; cv=none; b=m19qNigm+VWed3GWfD57J1qgOSaMlqjWR0554rxOXUiHxaCOWnkkBxIKCfqfV9lpke0il3VHTKnK+nBoLfBsCmGTHad82ar0zCOFPwvyTkZTR5PBQ9rXmmsfjrlJTXP5imFqOmXCqCgEcmg/+Zi69sdQewl6H7iIxdHjoyVV2BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771879470; c=relaxed/simple;
	bh=hDo7vV4l0SXbcs1Xo9+74l02q5jsJ4F9mHa8kkrZXjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R+AP1+EhruxUIRRSHCmqV1N6vfckUGh5Hr5v5pUOY8q8gv2LNnVzNj9N0Iximatug1ExUMZUznrgL7GvpNhfM1JWZW0EtRiBD3NSVliFp+pJGfXfwS5PKoFAKZG9UtDAY7dVpWb2umc3HRDW9yxvm/XZJdd8T/CyGertOVpW+04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kERfU3m7; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kERfU3m7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771879467; x=1803415467;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hDo7vV4l0SXbcs1Xo9+74l02q5jsJ4F9mHa8kkrZXjk=;
  b=kERfU3m7qJskSzbTJaOu/bTMh7GZ9X0SJYOtdouYfe/jAUxLxsC0q0J8
   //Om9wt77g2q3YfAmr/YTHgMfufx9XJoZ3k5l+ocG3WvCCuGzGbEjhqz/
   VraQRuZV/lZp1iYUrF1MmuZEtSwq4zZh6XgAAXdvVFLX5v/wkw+scVjly
   IIQovyytoilFELQkTvxNy3IkyOySL1nunj9P6LG3JI6ngtCmwzmOPM1Of
   dvcNnyQEzdXYlX0gfZ/tckbieFKGaB+lpjhe/Nkyaq7iGTu3kI+TBoIBC
   Dtot0r09nMVnKZQ/MC7TiN2NRzl6upx/dFD8XX8/61I4lnIK7D9gpAdTy
   A==;
X-CSE-ConnectionGUID: 1Jzxn8DvRrSLLooIdkIxVw==
X-CSE-MsgGUID: A8QqalleQ0q8zB7+fNsCjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="72795338"
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="72795338"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 12:44:22 -0800
X-CSE-ConnectionGUID: E/8Q1/VRREiGblqjJnAi2w==
X-CSE-MsgGUID: 7pbjLTCcRXq+IeUj2e7gLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="215700222"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa008.jf.intel.com with ESMTP; 23 Feb 2026 12:44:19 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 39F1C9B; Mon, 23 Feb 2026 21:44:18 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Zijun Hu <zijun.hu@oss.qualcomm.com>,
	linux-kernel@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-acpi@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v1 3/3] driver core: Split device related fwnode API to device/fwnode.h
Date: Mon, 23 Feb 2026 21:30:32 +0100
Message-ID: <20260223204412.3298508-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260223204412.3298508-1-andriy.shevchenko@linux.intel.com>
References: <20260223204412.3298508-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

device.h is a huge header which is hard to follow and easy to miss
something. Improve that by splitting device related fwnode API
to device/fwnode.h.

In particular this helps to speedup the build of the code that includes
device.h solely for a device related fwnode API.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/device.h        | 17 +----------------
 include/linux/device/fwnode.h | 28 ++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 16 deletions(-)
 create mode 100644 include/linux/device/fwnode.h

diff --git a/include/linux/device.h b/include/linux/device.h
index 4ba6ae72ddf6..d2e2745243ea 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -31,6 +31,7 @@
 #include <linux/device/devlink.h>
 #include <linux/device/devres.h>
 #include <linux/device/driver.h>
+#include <linux/device/fwnode.h>
 #include <linux/device/types.h>
 #include <linux/cleanup.h>
 
@@ -38,8 +39,6 @@ struct device_driver;
 struct module;
 struct class;
 struct subsys_private;
-struct device_node;
-struct fwnode_handle;
 
 /**
  * struct subsys_interface - interfaces to device functions
@@ -603,20 +602,6 @@ int lock_device_hotplug_sysfs(void);
 int device_offline(struct device *dev);
 int device_online(struct device *dev);
 
-void set_primary_fwnode(struct device *dev, struct fwnode_handle *fwnode);
-void set_secondary_fwnode(struct device *dev, struct fwnode_handle *fwnode);
-void device_set_node(struct device *dev, struct fwnode_handle *fwnode);
-int device_add_of_node(struct device *dev, struct device_node *of_node);
-void device_remove_of_node(struct device *dev);
-void device_set_of_node_from_dev(struct device *dev, const struct device *dev2);
-
-static inline struct device_node *dev_of_node(struct device *dev)
-{
-	if (!IS_ENABLED(CONFIG_OF) || !dev)
-		return NULL;
-	return dev->of_node;
-}
-
 static inline int dev_num_vf(struct device *dev)
 {
 	if (dev->bus && dev->bus->num_vf)
diff --git a/include/linux/device/fwnode.h b/include/linux/device/fwnode.h
new file mode 100644
index 000000000000..4fe6107191a6
--- /dev/null
+++ b/include/linux/device/fwnode.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _DEVICE_FWNODE_H_
+#define _DEVICE_FWNODE_H_
+
+#include <linux/stddef.h>
+
+#include "types.h"
+
+struct device_node;
+struct fwnode_handle;
+
+void set_primary_fwnode(struct device *dev, struct fwnode_handle *fwnode);
+void set_secondary_fwnode(struct device *dev, struct fwnode_handle *fwnode);
+
+void device_set_node(struct device *dev, struct fwnode_handle *fwnode);
+
+int device_add_of_node(struct device *dev, struct device_node *of_node);
+void device_remove_of_node(struct device *dev);
+void device_set_of_node_from_dev(struct device *dev, const struct device *dev2);
+
+static inline struct device_node *dev_of_node(struct device *dev)
+{
+	if (!IS_ENABLED(CONFIG_OF) || !dev)
+		return NULL;
+	return dev->of_node;
+}
+
+#endif /* _DEVICE_FWNODE_H_ */
-- 
2.50.1

