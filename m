Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BF73C5DDF;
	Wed, 18 Mar 2026 14:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773843854; cv=none; b=b0dkVipPb1X9yRRWw6T/o1LzxG4C7LLljoJNW6WfCTAang8/k8xb/6cFrd70QiIbndCgPK0Jb4eUIggHXSLEZIkmJmAGPaSPBlQ8qU/DDaK1f4yNLtAOKTZ7rujsBpW2ENOx5CelmqnIlSqB7Yy8E4ls2N6sphA02CY1919Dl5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773843854; c=relaxed/simple;
	bh=pugTX89iJRjbHjTU0WAVgbPEN3I3RiY1egvayprlrg8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tOcJbv0uTY5IggzokFMOvjKvkZaQvpI2jZOrwDHH0yk1wK5GRvarqfCVIfUTGFXTto890huEGLe1u1Q57faPhbUy7/PwSUmdlwoCVb8EHm+zftLEq3gMy8LvJry87hsHCqlJUOZ0Oql3idEshqPcu4FtJI5yE0fLOfqjFqbuNWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jb41noOa; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jb41noOa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773843852; x=1805379852;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pugTX89iJRjbHjTU0WAVgbPEN3I3RiY1egvayprlrg8=;
  b=jb41noOaPzVl1zkvjwflVjHctzzpxD96f/Vg2mrcLCDO/928ZmEMruT/
   h5pm4zYnnzCqfGaK6kLLw3WNMSAkUC8jSHkxawZ945Ms02S4xOIH8eT/6
   FVvrgoIiFkZ6bI3xqLjkQD9SeH66yZplLLS3SOLceAYiFkNL+4S3cCdLu
   8obByBl9w3FUog30OiSGA44PunkJ1+7ALSk4B3Vn0vkxdOrAgLoITj2u4
   R2ykzAw360Y70qQplvdXvYGE+d1np+PTPOZo+RbRVhcvgGlzuDvX4bago
   zDsjcKmZcXxNthrdKrZ13CwILbPYI9lwIwrhMqTYyNcVdRJQ6kR5Y8TLt
   w==;
X-CSE-ConnectionGUID: FwSj5o9cSQ+FPo98gY+/dA==
X-CSE-MsgGUID: Bws4KGnFReOteW4e9azlqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="85598053"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="85598053"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 07:24:12 -0700
X-CSE-ConnectionGUID: s7V3ewFLS5a4q7ReC+aijQ==
X-CSE-MsgGUID: T/wVz5kvR/28R1O2vSV/HQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="260544997"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa001.jf.intel.com with ESMTP; 18 Mar 2026 07:24:08 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 6B4CD99; Wed, 18 Mar 2026 15:24:07 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-acpi@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	devicetree@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 1/1] device property: Document how to check for the property presence
Date: Wed, 18 Mar 2026 15:21:40 +0100
Message-ID: <20260318142404.2526642-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently it's unclear if one may or may not rely on the error codes
returned from the property getters to check for the property presence.
Clarify this by updating kernel-doc for fwnode_property_*() and
device_property_*() where it's applicable.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Closes: https://lore.kernel.org/r/4b24f1f4-b395-467a-81b7-1334a2d48845@roeck-us.net
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

In v2:
- dropped "In order to ..." in *_property_read_*() docs (Sakari)
- replaced 'correct' with 'unambiguous' in the doc for *_property_present()
- fixed Closes link (Geert)
- Cc'ed to DT (Geert)

 drivers/base/property.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 8d9a34be57fb..d16e9c5f1921 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -38,6 +38,8 @@ EXPORT_SYMBOL_GPL(__dev_fwnode_const);
  * @propname: Name of the property
  *
  * Check if property @propname is present in the device firmware description.
+ * This function is the unambiguous way to check that given property is present
+ * in the device firmware description.
  *
  * Return: true if property @propname is present. Otherwise, returns false.
  */
@@ -52,6 +54,10 @@ EXPORT_SYMBOL_GPL(device_property_present);
  * @fwnode: Firmware node whose property to check
  * @propname: Name of the property
  *
+ * Check if property @propname is present in the firmware node description.
+ * This function is the unambiguous way to check that given property is present
+ * in the firmware node description.
+ *
  * Return: true if property @propname is present. Otherwise, returns false.
  */
 bool fwnode_property_present(const struct fwnode_handle *fwnode,
@@ -75,9 +81,9 @@ EXPORT_SYMBOL_GPL(fwnode_property_present);
  * @dev: Device whose property is being checked
  * @propname: Name of the property
  *
- * Return if property @propname is true or false in the device firmware description.
+ * Use device_property_present() to check for the property presence.
  *
- * Return: true if property @propname is present. Otherwise, returns false.
+ * Return: if property @propname is true or false in the device firmware description.
  */
 bool device_property_read_bool(const struct device *dev, const char *propname)
 {
@@ -90,7 +96,9 @@ EXPORT_SYMBOL_GPL(device_property_read_bool);
  * @fwnode: Firmware node whose property to check
  * @propname: Name of the property
  *
- * Return if property @propname is true or false in the firmware description.
+ * Use fwnode_property_present() to check for the property presence.
+ *
+ * Return: if property @propname is true or false in the firmware node description.
  */
 bool fwnode_property_read_bool(const struct fwnode_handle *fwnode,
 			     const char *propname)
-- 
2.50.1

