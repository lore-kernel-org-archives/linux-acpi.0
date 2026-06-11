Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7393A6B76;
	Thu, 11 Jun 2026 20:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781210149; cv=none; b=gpbp0VEJ1+5HXh5hZKjpUsORv3SSBH1qUznvSLNbth2VTL8g+WU82TfwZDCPs2zgZXTsymZmtZ/knB0ynxrip8btZT9nch0cYmeHW98vRGftL6++QGi1gk39rYZd8F1o1xU90YbvMHtA1ZBviETbJi+rYOSlCplcrrMRrWlDkUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781210149; c=relaxed/simple;
	bh=C6OIarG6iVN7dquSssvxi6i1DiHTixrw0oqyWp2Vp78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W7IAx3A8PRwUXACV1r6/z1/jSKy6aOiHhMeAu1k1RAEdwty8hHTnpsvLBy8TfjNdesVTtOf7MQMNAg4oVO8efB58+NtnnS5i59A9TuNf+Mv6Msxz/VZyR7FeCV6QcN0tMZkvOBS5SB+1sUcaR63fWoQnKaZQho2JaQ4QQPbWLwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RicIyYic; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RicIyYic"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781210147; x=1812746147;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=C6OIarG6iVN7dquSssvxi6i1DiHTixrw0oqyWp2Vp78=;
  b=RicIyYic5c2WI8Z2B1nbbt7gI1V2ovGIJxYR0gyrABUrBhZUMrsomhCI
   M8eed4DDYBcUXd2Jm+zejjoJ4Z+YlYqpeFHXOkZUrOTfZ6CCgWHLzucPQ
   tB4TUudZ0j6vXeONHvpwu8IfnEYoGZWMF02vEuO1jLbTaxaCtbzxw073w
   uQ5uqK7pS475brU3ThWOhirsQHEkG1PdeLyqhhE7bfQh4RXHBsXf+gJI8
   kB9AgI7Urj66Xh8AOw7d9E65hcta7adk9e37rCiA/vdzGyEli1Y0qUFle
   7RtfuVhTz7qicvt+RtSRs26rqueFdHSUU6XkUoPssHyYoNoygTiDgRMzE
   Q==;
X-CSE-ConnectionGUID: r4sqcEudTgiOVht4I9kv2A==
X-CSE-MsgGUID: LRubJQe9TImPM6/NsWKIuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="82144676"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="82144676"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 13:35:46 -0700
X-CSE-ConnectionGUID: qe70sS8pS7i83GpM7lqeUg==
X-CSE-MsgGUID: L9qEze+IRBmawzmdWggMRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="270272997"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa002.fm.intel.com with ESMTP; 11 Jun 2026 13:35:44 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id CCDB699; Thu, 11 Jun 2026 22:35:42 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Xu Yang <xu.yang_2@nxp.com>,
	linux-acpi@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v4 2/3] device property: Refactor to use RAII approach
Date: Thu, 11 Jun 2026 22:31:07 +0200
Message-ID: <20260611203537.1786399-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260611203537.1786399-1-andriy.shevchenko@linux.intel.com>
References: <20260611203537.1786399-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a couple of functions code can be made cleaner with help of
__free() macro. Refactor these to use RAII approach.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/property.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index f7b30d9c8716..808e8a90c125 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -7,10 +7,10 @@
  *          Mika Westerberg <mika.westerberg@linux.intel.com>
  */
 
+#include <linux/cleanup.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/export.h>
-#include <linux/kconfig.h>
 #include <linux/of.h>
 #include <linux/property.h>
 #include <linux/phy.h>
@@ -517,7 +517,6 @@ EXPORT_SYMBOL_GPL(fwnode_property_read_string);
 int fwnode_property_match_string(const struct fwnode_handle *fwnode,
 	const char *propname, const char *string)
 {
-	const char **values;
 	int nval, ret;
 
 	nval = fwnode_property_string_array_count(fwnode, propname);
@@ -527,20 +526,18 @@ int fwnode_property_match_string(const struct fwnode_handle *fwnode,
 	if (nval == 0)
 		return -ENODATA;
 
-	values = kcalloc(nval, sizeof(*values), GFP_KERNEL);
+	const char **values __free(kfree) = kcalloc(nval, sizeof(*values), GFP_KERNEL);
 	if (!values)
 		return -ENOMEM;
 
 	ret = fwnode_property_read_string_array(fwnode, propname, values, nval);
 	if (ret < 0)
-		goto out_free;
+		return ret;
 
 	ret = match_string(values, nval, string);
 	if (ret < 0)
-		ret = -ENODATA;
+		return -ENODATA;
 
-out_free:
-	kfree(values);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(fwnode_property_match_string);
@@ -1128,8 +1125,9 @@ struct fwnode_handle *
 fwnode_graph_get_next_endpoint(const struct fwnode_handle *fwnode,
 			       struct fwnode_handle *prev)
 {
-	struct fwnode_handle *ep, *port_parent = NULL;
 	const struct fwnode_handle *parent;
+	struct fwnode_handle *port_parent __free(fwnode_handle) = NULL;
+	struct fwnode_handle *ep;
 
 	/*
 	 * If this function is in a loop and the previous iteration returned
@@ -1147,13 +1145,9 @@ fwnode_graph_get_next_endpoint(const struct fwnode_handle *fwnode,
 
 	ep = fwnode_call_ptr_op(parent, graph_get_next_endpoint, prev);
 	if (ep)
-		goto out_put_port_parent;
+		return ep;
 
-	ep = fwnode_graph_get_next_endpoint(parent->secondary, NULL);
-
-out_put_port_parent:
-	fwnode_handle_put(port_parent);
-	return ep;
+	return fwnode_graph_get_next_endpoint(parent->secondary, NULL);
 }
 EXPORT_SYMBOL_GPL(fwnode_graph_get_next_endpoint);
 
-- 
2.50.1

