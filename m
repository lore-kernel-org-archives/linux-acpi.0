Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A009D346AE8;
	Tue, 17 Mar 2026 21:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773781716; cv=none; b=W9fUnvIXTUc7d1dm47D/viDXSK0Vm80QoQw95t2U2XDbFymAGwzXOjrMT+ykMo1DqTVZX26SLGByL1LsyXlJ4Gysu4Zy4Rr29OfbOeGkAKk3zfV78wZlxdNYbPukY8i9cnCqaZRRljXhGsNYhF51y76Rsub5hhcO/e2esFxdyU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773781716; c=relaxed/simple;
	bh=F98MMCjNZ9nCU6nsk/DO3WA4Y/k1Gdu8X5kuOq098ck=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BohuLUDf20LOzPUJm8TChrL2hmeD9YALzfX+2+GykiE+gogS1brQTRR7nt5ib7/gNwIIC2HTqZ9UZGjBvEq4hNzeYbwBdHX2AA0ikaX6B+JaOkcqTMeZxOQeI1u/sbA4qmtIIfObqSNoKH46QH6/c8fV/j9mx1C+ZdR6Y3e6szE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iQSD/GYd; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iQSD/GYd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773781714; x=1805317714;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=F98MMCjNZ9nCU6nsk/DO3WA4Y/k1Gdu8X5kuOq098ck=;
  b=iQSD/GYdu0gckIgDN86EasAvzcEepUAXTZDelwee/3wTlfyIeYHN0wp8
   UhkjkRfA3btO7Wb0xBoWDR/mI0GHsYQpWkTaDoml7fHDETcU2WTtaWv0Z
   wkCZidp73V0ZeSjoPBiZWvb6Ci0P5R/dxCT4lk9/BTuwlC7Co/HFoNfbF
   H7J2ObbXLPWzOYAkRjPPDydBv00xnSP+lifbfvmzOLmhUM3Oav9osLzDS
   yMqvfTZodClStigaEnVzmB5jgbovXgoBntVp3OnpOgZU1ARIIiu8aURVD
   qs14tIOv0kbTwUDHIUR3WSIuKHX/S8xj7LHx+qEyREokGQdlwapEUh5Dz
   g==;
X-CSE-ConnectionGUID: y3kW/y6zRAupehNRJ5Z9YA==
X-CSE-MsgGUID: tfoGLr2vStaMk+svNG0Ejw==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="78435693"
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="78435693"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 14:08:34 -0700
X-CSE-ConnectionGUID: BsO03Z0hSXiUe2rSpOs1KA==
X-CSE-MsgGUID: WDM4rAHwQpOtYyzq+TB/zA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="245418330"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa002.fm.intel.com with ESMTP; 17 Mar 2026 14:08:30 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 833E595; Tue, 17 Mar 2026 22:08:29 +0100 (CET)
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
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v1 1/1] device property: Document how to check for the property presence
Date: Tue, 17 Mar 2026 22:08:28 +0100
Message-ID: <20260317210828.2117631-1-andriy.shevchenko@linux.intel.com>
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
Clarify this by mass updating kernel-doc for fwnode_property_*() and
device_property_*() where it's applicable.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Closes: 4b24f1f4-b395-467a-81b7-1334a2d48845@roeck-us.net
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/property.c | 38 +++++++++++++++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 8d9a34be57fb..bffa0070ab13 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -38,6 +38,8 @@ EXPORT_SYMBOL_GPL(__dev_fwnode_const);
  * @propname: Name of the property
  *
  * Check if property @propname is present in the device firmware description.
+ * This function is the correct way to check that given property is present
+ * in the device firmware description.
  *
  * Return: true if property @propname is present. Otherwise, returns false.
  */
@@ -52,6 +54,10 @@ EXPORT_SYMBOL_GPL(device_property_present);
  * @fwnode: Firmware node whose property to check
  * @propname: Name of the property
  *
+ * Check if property @propname is present in the firmware node description.
+ * This function is the correct way to check that given property is present
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
@@ -121,6 +129,8 @@ EXPORT_SYMBOL_GPL(fwnode_property_read_bool);
  * It's recommended to call device_property_count_u8() instead of calling
  * this function with @val equals %NULL and @nval equals 0.
  *
+ * In order to check for the property presence, use device_property_present().
+ *
  * Return: number of values if @val was %NULL,
  *         %0 if the property was found (success),
  *	   %-EINVAL if given arguments are not valid,
@@ -149,6 +159,8 @@ EXPORT_SYMBOL_GPL(device_property_read_u8_array);
  * It's recommended to call device_property_count_u16() instead of calling
  * this function with @val equals %NULL and @nval equals 0.
  *
+ * In order to check for the property presence, use device_property_present().
+ *
  * Return: number of values if @val was %NULL,
  *         %0 if the property was found (success),
  *	   %-EINVAL if given arguments are not valid,
@@ -177,6 +189,8 @@ EXPORT_SYMBOL_GPL(device_property_read_u16_array);
  * It's recommended to call device_property_count_u32() instead of calling
  * this function with @val equals %NULL and @nval equals 0.
  *
+ * In order to check for the property presence, use device_property_present().
+ *
  * Return: number of values if @val was %NULL,
  *         %0 if the property was found (success),
  *	   %-EINVAL if given arguments are not valid,
@@ -205,6 +219,8 @@ EXPORT_SYMBOL_GPL(device_property_read_u32_array);
  * It's recommended to call device_property_count_u64() instead of calling
  * this function with @val equals %NULL and @nval equals 0.
  *
+ * In order to check for the property presence, use device_property_present().
+ *
  * Return: number of values if @val was %NULL,
  *         %0 if the property was found (success),
  *	   %-EINVAL if given arguments are not valid,
@@ -233,6 +249,8 @@ EXPORT_SYMBOL_GPL(device_property_read_u64_array);
  * It's recommended to call device_property_string_array_count() instead of calling
  * this function with @val equals %NULL and @nval equals 0.
  *
+ * In order to check for the property presence, use device_property_present().
+ *
  * Return: number of values read on success if @val is non-NULL,
  *	   number of values available on success if @val is NULL,
  *	   %-EINVAL if given arguments are not valid,
@@ -257,6 +275,8 @@ EXPORT_SYMBOL_GPL(device_property_read_string_array);
  * Function reads property @propname from the device firmware description and
  * stores the value into @val if found. The value is checked to be a string.
  *
+ * In order to check for the property presence, use device_property_present().
+ *
  * Return: %0 if the property was found (success),
  *	   %-EINVAL if given arguments are not valid,
  *	   %-ENODATA if the property does not have a value,
@@ -324,6 +344,8 @@ static int fwnode_property_read_int_array(const struct fwnode_handle *fwnode,
  * It's recommended to call fwnode_property_count_u8() instead of calling
  * this function with @val equals %NULL and @nval equals 0.
  *
+ * In order to check for the property presence, use fwnode_property_present().
+ *
  * Return: number of values if @val was %NULL,
  *         %0 if the property was found (success),
  *	   %-EINVAL if given arguments are not valid,
@@ -353,6 +375,8 @@ EXPORT_SYMBOL_GPL(fwnode_property_read_u8_array);
  * It's recommended to call fwnode_property_count_u16() instead of calling
  * this function with @val equals %NULL and @nval equals 0.
  *
+ * In order to check for the property presence, use fwnode_property_present().
+ *
  * Return: number of values if @val was %NULL,
  *         %0 if the property was found (success),
  *	   %-EINVAL if given arguments are not valid,
@@ -382,6 +406,8 @@ EXPORT_SYMBOL_GPL(fwnode_property_read_u16_array);
  * It's recommended to call fwnode_property_count_u32() instead of calling
  * this function with @val equals %NULL and @nval equals 0.
  *
+ * In order to check for the property presence, use fwnode_property_present().
+ *
  * Return: number of values if @val was %NULL,
  *         %0 if the property was found (success),
  *	   %-EINVAL if given arguments are not valid,
@@ -411,6 +437,8 @@ EXPORT_SYMBOL_GPL(fwnode_property_read_u32_array);
  * It's recommended to call fwnode_property_count_u64() instead of calling
  * this function with @val equals %NULL and @nval equals 0.
  *
+ * In order to check for the property presence, use fwnode_property_present().
+ *
  * Return: number of values if @val was %NULL,
  *         %0 if the property was found (success),
  *	   %-EINVAL if given arguments are not valid,
@@ -440,6 +468,8 @@ EXPORT_SYMBOL_GPL(fwnode_property_read_u64_array);
  * It's recommended to call fwnode_property_string_array_count() instead of calling
  * this function with @val equals %NULL and @nval equals 0.
  *
+ * In order to check for the property presence, use fwnode_property_present().
+ *
  * Return: number of values read on success if @val is non-NULL,
  *	   number of values available on success if @val is NULL,
  *	   %-EINVAL if given arguments are not valid,
@@ -476,6 +506,8 @@ EXPORT_SYMBOL_GPL(fwnode_property_read_string_array);
  * Read property @propname from the given firmware node and store the value into
  * @val if found.  The value is checked to be a string.
  *
+ * In order to check for the property presence, use fwnode_property_present().
+ *
  * Return: %0 if the property was found (success),
  *	   %-EINVAL if given arguments are not valid,
  *	   %-ENODATA if the property does not have a value,
-- 
2.50.1

