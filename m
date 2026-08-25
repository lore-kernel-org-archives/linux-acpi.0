Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79343B4EAB;
	Tue, 25 Aug 2026 20:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787690149; cv=none; b=C2G5Bh5JM5CGlxzS8pYRY+/ZgQFgElhxCjKPPhM4lbUhcUa8vMFu/nUaUjnftbjA5nVlJ6uF5khez8LdJ7o76p1NfmbZiF3QhkWHQsvgXYWaB8smgXQt1lDM1o6Fp90oceUqYRNzKstVrbJiqUDAzY/TuEGW9t+C0xsh8WJtZ5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787690149; c=relaxed/simple;
	bh=nYwrWeiJpQvEx8p+mHVcietcK4XfVvx+OHJhe7UBico=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LscGj8LZzbcyzuraDf8OsaFSeCeAa+QEFuwRcw+kYC7ZT/4+ZB9Wyh+W9FExSHw4ZEHjxrFYdIsngDSqfOCUWv4S68VzFE/cbyxYO+1lJtrUlukh/KCdOSF3pLdlBW3b6YKSukq6Nr1i3yv2nw7wRiUCetRT55xKUqdI4dQrwdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k4Idrn8e; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k4Idrn8e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787690148; x=1819226148;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nYwrWeiJpQvEx8p+mHVcietcK4XfVvx+OHJhe7UBico=;
  b=k4Idrn8e2hlCb4WIclB/e+I/HL1fxaEesq2CP4ra77+om9uVAyZUFJm5
   AO0ch7GnFJF59XmbhEHWhJmwu6gy0/QR0wkTFbZiRPWbHJzTJU8TFRLgq
   /RZTNeKAHSw4JYqS3h5QC2I2e4482Dspn3fxhepAMeg+KdYwB/py29/yS
   hGWV095H1m+pMadgvEksiGOPd8wkBZNUp1t/pqftNOntPCZHPn6p1svVp
   X7kCtldg3Ww7DWE9B4ifBVbRFHjMPAbPKnQzpTj/hOtN/glUJLCZcdO4C
   cy9dP+O1KIpEeTpIlVYZxwDSkdmN54sPBk6lkGyHlvTtrx4YQ2sRyGGS0
   w==;
X-CSE-ConnectionGUID: X4Rgemh3RdePLNgUJckwtA==
X-CSE-MsgGUID: 8BMP0y4lS8+Mz4kZGrC4gA==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="88194758"
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; 
   d="scan'208";a="88194758"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 13:35:43 -0700
X-CSE-ConnectionGUID: 2i38PWHyTnGac4JFqAzJYg==
X-CSE-MsgGUID: QA4ha/q0T7KbvrksOMKBfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; 
   d="scan'208";a="265579298"
Received: from carterle-desk.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.168])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 13:35:41 -0700
Received: from punajuuri.localdomain (unknown [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 63C20121C43;
	Tue, 25 Aug 2026 23:35:53 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.98.2)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1wyxs9-0000000Fd5F-2G3g;
	Tue, 25 Aug 2026 23:35:53 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-media@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	linux-acpi@vger.kernel.org,
	Len Brown <lenb@kernel.org>,
	Daniel Scally <dan.scally@ideasonboard.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH v3 3/3] platform/x86: int3472: Clean up GPIO parsing
Date: Tue, 25 Aug 2026 23:35:53 +0300
Message-ID: <20260825203553.3725132-4-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260825203553.3725132-1-sakari.ailus@linux.intel.com>
References: <20260825203553.3725132-1-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In skl_int3472_handle_gpio_resources(), only a single integer value from
the ACPI object is used so release it early and avoid having to call
ACPI_FREE() on it later on. This makes it possible to return an error
where it happens, except when we're holding a reference to a GPIO. ngpios
is also incremented earlier on but that does not introduce a functional
change.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/platform/x86/intel/int3472/discrete.c | 42 ++++++++-----------
 1 file changed, 18 insertions(+), 24 deletions(-)

diff --git a/drivers/platform/x86/intel/int3472/discrete.c b/drivers/platform/x86/intel/int3472/discrete.c
index 9cd4f78875ab..1f8751a7db0c 100644
--- a/drivers/platform/x86/intel/int3472/discrete.c
+++ b/drivers/platform/x86/intel/int3472/discrete.c
@@ -328,6 +328,7 @@ static int skl_int3472_handle_gpio_resources(struct acpi_resource *ares,
 	u8 active_value, pin, type;
 	unsigned long gpio_flags;
 	union acpi_object *obj;
+	unsigned int obj_value;
 	struct gpio_desc *gpio;
 	const char *con_id;
 	int ret;
@@ -343,24 +344,27 @@ static int skl_int3472_handle_gpio_resources(struct acpi_resource *ares,
 				      &int3472_gpio_guid, 0x00,
 				      int3472->ngpios + 2,
 				      NULL, ACPI_TYPE_INTEGER);
-
 	if (!obj) {
 		dev_warn(int3472->dev, "No _DSM entry for GPIO pin %u\n",
 			 agpio->pin_table[0]);
 		return 1;
 	}
 
-	type = FIELD_GET(INT3472_GPIO_DSM_TYPE, obj->integer.value);
+	obj_value = obj->integer.value;
+
+	ACPI_FREE(obj);
+
+	type = FIELD_GET(INT3472_GPIO_DSM_TYPE, obj_value);
 
 	int3472_get_con_id_and_polarity(int3472, &type, &con_id, &gpio_flags, &enable_time_us);
 
-	pin = FIELD_GET(INT3472_GPIO_DSM_PIN, obj->integer.value);
+	pin = FIELD_GET(INT3472_GPIO_DSM_PIN, obj_value);
 	/* Pin field is not really used under Windows and wraps around at 8 bits */
 	if (pin != (agpio->pin_table[0] & 0xff))
 		dev_dbg(int3472->dev, FW_BUG "%s %s pin number mismatch _DSM %d resource %d\n",
 			con_id, agpio->resource_source.string_ptr, pin, agpio->pin_table[0]);
 
-	active_value = FIELD_GET(INT3472_GPIO_DSM_SENSOR_ON_VAL, obj->integer.value);
+	active_value = FIELD_GET(INT3472_GPIO_DSM_SENSOR_ON_VAL, obj_value);
 	if (!active_value)
 		gpio_flags ^= GPIO_ACTIVE_LOW;
 
@@ -368,16 +372,18 @@ static int skl_int3472_handle_gpio_resources(struct acpi_resource *ares,
 		agpio->resource_source.string_ptr, agpio->pin_table[0],
 		str_high_low(gpio_flags == GPIO_ACTIVE_HIGH));
 
+	int3472->ngpios++;
+
 	switch (type) {
 	case INT3472_GPIO_TYPE_RESET:
 	case INT3472_GPIO_TYPE_POWERDOWN:
 	case INT3472_GPIO_TYPE_HOTPLUG_DETECT:
 		ret = skl_int3472_map_gpio_to_sensor(int3472, agpio, con_id, gpio_flags);
 		if (ret)
-			dev_err_probe(int3472->dev, ret,
-				      "Failed to map GPIO pin to sensor\n");
+			return dev_err_probe(int3472->dev, ret,
+					     "Failed to map GPIO pin to sensor\n");
 
-		break;
+		return 1;
 	case INT3472_GPIO_TYPE_CLK_ENABLE:
 	case INT3472_GPIO_TYPE_PRIVACY_LED:
 	case INT3472_GPIO_TYPE_STROBE:
@@ -385,11 +391,9 @@ static int skl_int3472_handle_gpio_resources(struct acpi_resource *ares,
 	case INT3472_GPIO_TYPE_DOVDD:
 	case INT3472_GPIO_TYPE_HANDSHAKE:
 		gpio = skl_int3472_gpiod_get_from_temp_lookup(int3472, agpio, con_id, gpio_flags);
-		if (IS_ERR(gpio)) {
-			ret = PTR_ERR(gpio);
-			dev_err_probe(int3472->dev, ret, "Failed to get GPIO\n");
-			break;
-		}
+		if (IS_ERR(gpio))
+			return dev_err_probe(int3472->dev, PTR_ERR(gpio),
+					     "Failed to get GPIO\n");
 
 		switch (type) {
 		case INT3472_GPIO_TYPE_CLK_ENABLE:
@@ -427,23 +431,13 @@ static int skl_int3472_handle_gpio_resources(struct acpi_resource *ares,
 		if (ret)
 			gpiod_put(gpio);
 
-		break;
+		return ret < 0 ? ret : 1;
 	default:
 		dev_warn(int3472->dev,
 			 "GPIO type 0x%02x unknown; the sensor may not work\n",
 			 type);
-		ret = 1;
-		break;
+		return 1;
 	}
-
-	int3472->ngpios++;
-	ACPI_FREE(obj);
-
-	/*
-	 * Either return an error or tell acpi_dev_get_resources() to not make a
-	 * copy of the resource.
-	 */
-	return ret < 0 ? ret : 1;
 }
 
 int int3472_discrete_parse_crs(struct int3472_discrete_device *int3472)
-- 
2.47.3

