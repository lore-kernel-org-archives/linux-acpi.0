Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425AE3911DF;
	Mon, 24 Aug 2026 21:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787606015; cv=none; b=o39jdTeAy6eNV/57z+kn5uXtu4kFys+vXnam20q52XCc8erdD7LZbgQ/SRK+YT1npIViuYoJqmdhlB1I8bVeyB80PrY20/uxDHuHuiXZ/7ELRTvPMHbHIsdcq/QQTkqEL0pz5bsbAiv0DixjPqRPHoFWEAd23wqZIQAv/qk5u74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787606015; c=relaxed/simple;
	bh=rI3fvuuQ6Qqe/wyCNG2Cgrw8LEYiCx0//rWsVapUW+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bu43RuqovyYXzfC7xIXgTM7s1dT0WIXiFV1iN4Th9cgg5reF3xPfHUqpF0DT4BoCSjn6rlOPl6WQdUJePTuCs7B+L5/ZA5est1LLAMhcsy0Ctyc+98zrEKxja5PTphZ8jobe88H8KFbEHJptWPO1COIpyrMuLaOWCGDSmmmaMpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IYqtHV8k; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IYqtHV8k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787606015; x=1819142015;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rI3fvuuQ6Qqe/wyCNG2Cgrw8LEYiCx0//rWsVapUW+o=;
  b=IYqtHV8k5UpyqyQa15qKgPJi9y076T4bjBujJpyOk6bxX+ndcz7vmFor
   90Ykq76ppPW+nWD6vOYmMoLJfg/J6mBEW1WYaEsp8C+phRsooDtuDDTQo
   ey8qOXVd7ZaFtRZGvLf+0TlL5tlF9a5felfy8lSEJ+BYL8FIIBQQD6mdq
   /zBxAzS24U+q1CE8nvZcn1gNNU+5vHuZPtu/WYO144jNgI4VvpsC1zsgU
   FtNgHhfe003WtcmfIjvltBMB2keHz+UywUf7FYkc9Gxp1i+cPjo438Wbx
   r07OYXkUAs61tpqkbBE2e5r85Fy6hCrlvg1R9RbFy/UaKoHRjTtLmj7Q2
   w==;
X-CSE-ConnectionGUID: eb4IfM1eS02/5pZ4FZoDKQ==
X-CSE-MsgGUID: 0hGKfVCiTOaAohEWYznJCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="88125320"
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="88125320"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 14:13:33 -0700
X-CSE-ConnectionGUID: 8mJLsFGCQsufQMOGToJqqQ==
X-CSE-MsgGUID: o611iiF/RouaxF/W0TYSiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="290634219"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.9])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 14:13:31 -0700
Received: from punajuuri.localdomain (unknown [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 1AEE9121DD7;
	Tue, 25 Aug 2026 00:13:38 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.98.2)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1wybz8-0000000F2Mj-11OG;
	Tue, 25 Aug 2026 00:13:38 +0300
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
Subject: [PATCH v2 5/5] platform/x86: int3472: Clean up GPIO parsing
Date: Tue, 25 Aug 2026 00:13:38 +0300
Message-ID: <20260824211338.3583976-6-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260824211338.3583976-1-sakari.ailus@linux.intel.com>
References: <20260824211338.3583976-1-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In skl_int3472_handle_gpio_resources(), return an error where it happens,
except when we're holding a reference to a GPIO. This involves
incrementing ngpios earlier on but that does not introduce a functional
change.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/platform/x86/intel/int3472/discrete.c | 42 +++++++++----------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/platform/x86/intel/int3472/discrete.c b/drivers/platform/x86/intel/int3472/discrete.c
index 2024eaa09033..400bee9e4cb8 100644
--- a/drivers/platform/x86/intel/int3472/discrete.c
+++ b/drivers/platform/x86/intel/int3472/discrete.c
@@ -369,15 +369,23 @@ static int skl_int3472_handle_gpio_resources(struct acpi_resource *ares,
 		agpio->resource_source.string_ptr, agpio->pin_table[0],
 		str_high_low(gpio_flags == GPIO_ACTIVE_HIGH));
 
+	/*
+	 * int3472->ngpios can be incremented here as it is an argument to the
+	 * _DSM, not e.g. an index to an array in C. Additionally, in case of an
+	 * error the value won't be used.
+	 */
+	int3472->ngpios++;
+
 	switch (type) {
 	case INT3472_GPIO_TYPE_RESET:
 	case INT3472_GPIO_TYPE_POWERDOWN:
 	case INT3472_GPIO_TYPE_HOTPLUG_DETECT:
 		ret = skl_int3472_map_gpio_to_sensor(int3472, agpio, con_id, gpio_flags);
 		if (ret)
-			dev_err_probe(int3472->dev, ret, "Failed to map GPIO pin to sensor\n");
+			return dev_err_probe(int3472->dev, ret,
+					     "Failed to map GPIO pin to sensor\n");
 
-		break;
+		return 0;
 	case INT3472_GPIO_TYPE_CLK_ENABLE:
 	case INT3472_GPIO_TYPE_PRIVACY_LED:
 	case INT3472_GPIO_TYPE_STROBE:
@@ -385,24 +393,24 @@ static int skl_int3472_handle_gpio_resources(struct acpi_resource *ares,
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
 			ret = skl_int3472_register_gpio_clock(int3472, gpio);
 			if (ret)
-				dev_err_probe(int3472->dev, ret, "Failed to register clock\n");
+				dev_err_probe(int3472->dev, ret,
+					      "Failed to register clock\n");
 
 			break;
 		case INT3472_GPIO_TYPE_PRIVACY_LED:
 		case INT3472_GPIO_TYPE_STROBE:
 			ret = skl_int3472_register_led(int3472, gpio, con_id);
 			if (ret)
-				dev_err_probe(int3472->dev, ret, "Failed to register LED\n");
+				dev_err_probe(int3472->dev, ret,
+					      "Failed to register LED\n");
 
 			break;
 		case INT3472_GPIO_TYPE_POWER_ENABLE:
@@ -413,7 +421,8 @@ static int skl_int3472_handle_gpio_resources(struct acpi_resource *ares,
 			ret = skl_int3472_register_regulator(int3472, gpio, enable_time_us,
 							     con_id, second_sensor);
 			if (ret)
-				dev_err_probe(int3472->dev, ret, "Failed to register regulator\n");
+				dev_err_probe(int3472->dev, ret,
+					      "Failed to register regulator\n");
 
 			break;
 		default: /* Never reached */
@@ -424,22 +433,13 @@ static int skl_int3472_handle_gpio_resources(struct acpi_resource *ares,
 		if (ret)
 			gpiod_put(gpio);
 
-		break;
+		return ret;
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

