Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9F41FC110;
	Mon, 24 Aug 2026 21:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787606012; cv=none; b=hNSv0iHkl6TxH7L8mAVmo970Q8c4RqCgzuriqLonkJuh6EQRlOXbadShXKl8MEkVSiUIROzZ8YHTTxj0yE9HZ4CkkHZcv76FdFItChbDcuPG6pRqN05Yt+s6kz3FoQkm1a7TNcKHYguHl1OdFWQ+A+anAGvpKZLr45I0kviBfH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787606012; c=relaxed/simple;
	bh=wJxSWNoMJ1OEYJrQW6vonyJ8H+ysrv1zDv8j8JhoXkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fu5oUKYxKLR2t7PAACo13xVh4wZ0K1+vVBpVA27S0cmzMt83/6nihtXm6A+NFqFhPWnIWq65j+8YCkzze2wln0xZ4KOpmGqNNFeb2XbyDuKjWIceabEdV7OAHTGPHgcFCnKZR9cnSPfJE0+mdiJnSES3hmUxWxLhX06ncrQF7TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gcp0iNdc; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gcp0iNdc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787606010; x=1819142010;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wJxSWNoMJ1OEYJrQW6vonyJ8H+ysrv1zDv8j8JhoXkM=;
  b=Gcp0iNdcwbEabkQFuKXOtQdtRkOP3DTWY+BOwdKDCBq9VYAezWDkpJcQ
   kx03SIstfMQ04VTHdiMC8zADvT49zP0GYj+SQnzwnpIeUkaoPanMJMn9k
   kaJnRP5wDjQYgE1kuaVcd5KN6SZgcOU2VDXj5Ur1al1kynHlvKLt15KVX
   P9Jv8EmW2qVU3fByiVA6d7kFOq0THBMS3FAmQLz7aMzgpTaXA7JRNiOQB
   VFSmAqOPjqzrwKZ4FdJ8dOim1LgrPzyzAPxuybcgrpqNUKnr6tTstdYhq
   s1u6wQu0CPUp8rvCG5C2eAxiFUdPhyk7Rdf/cLS2cZgFVZE8F1lsn3Z+/
   g==;
X-CSE-ConnectionGUID: CRcGlx0CR5+MLnGtpHsRzw==
X-CSE-MsgGUID: oS6ELlCUS0qcSnOqvT34Xg==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="88125304"
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="88125304"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 14:13:30 -0700
X-CSE-ConnectionGUID: 27vpJo12QaqkkxrGDfnFfg==
X-CSE-MsgGUID: 7agKjTQnRIa4Njp1zNz7Pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="290634201"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.9])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 14:13:27 -0700
Received: from punajuuri.localdomain (unknown [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 14361121C43;
	Tue, 25 Aug 2026 00:13:38 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.98.2)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1wybz8-0000000F2MX-0nhR;
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
Subject: [PATCH v2 2/5] platform/x86: int3472: Fix uninitialised variable warning
Date: Tue, 25 Aug 2026 00:13:35 +0300
Message-ID: <20260824211338.3583976-3-sakari.ailus@linux.intel.com>
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

Fix a smatch warning about uninitialised err_msg variable, by printing the
error where it is handled.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/platform/x86/intel/int3472/discrete.c | 21 +++++++++----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/platform/x86/intel/int3472/discrete.c b/drivers/platform/x86/intel/int3472/discrete.c
index 6c729fcfce5d..b4a95b583edb 100644
--- a/drivers/platform/x86/intel/int3472/discrete.c
+++ b/drivers/platform/x86/intel/int3472/discrete.c
@@ -329,7 +329,6 @@ static int skl_int3472_handle_gpio_resources(struct acpi_resource *ares,
 	unsigned long gpio_flags;
 	union acpi_object *obj;
 	struct gpio_desc *gpio;
-	const char *err_msg;
 	const char *con_id;
 	int ret;
 
@@ -375,7 +374,7 @@ static int skl_int3472_handle_gpio_resources(struct acpi_resource *ares,
 	case INT3472_GPIO_TYPE_HOTPLUG_DETECT:
 		ret = skl_int3472_map_gpio_to_sensor(int3472, agpio, con_id, gpio_flags);
 		if (ret)
-			err_msg = "Failed to map GPIO pin to sensor\n";
+			dev_err_probe(int3472->dev, ret, "Failed to map GPIO pin to sensor\n");
 
 		break;
 	case INT3472_GPIO_TYPE_CLK_ENABLE:
@@ -387,7 +386,7 @@ static int skl_int3472_handle_gpio_resources(struct acpi_resource *ares,
 		gpio = skl_int3472_gpiod_get_from_temp_lookup(int3472, agpio, con_id, gpio_flags);
 		if (IS_ERR(gpio)) {
 			ret = PTR_ERR(gpio);
-			err_msg = "Failed to get GPIO\n";
+			dev_err_probe(int3472->dev, ret, "Failed to get GPIO\n");
 			break;
 		}
 
@@ -395,14 +394,14 @@ static int skl_int3472_handle_gpio_resources(struct acpi_resource *ares,
 		case INT3472_GPIO_TYPE_CLK_ENABLE:
 			ret = skl_int3472_register_gpio_clock(int3472, gpio);
 			if (ret)
-				err_msg = "Failed to register clock\n";
+				dev_err_probe(int3472->dev, ret, "Failed to register clock\n");
 
 			break;
 		case INT3472_GPIO_TYPE_PRIVACY_LED:
 		case INT3472_GPIO_TYPE_STROBE:
 			ret = skl_int3472_register_led(int3472, gpio, con_id);
 			if (ret)
-				err_msg = "Failed to register LED\n";
+				dev_err_probe(int3472->dev, ret, "Failed to register LED\n");
 
 			break;
 		case INT3472_GPIO_TYPE_POWER_ENABLE:
@@ -413,7 +412,7 @@ static int skl_int3472_handle_gpio_resources(struct acpi_resource *ares,
 			ret = skl_int3472_register_regulator(int3472, gpio, enable_time_us,
 							     con_id, second_sensor);
 			if (ret)
-				err_msg = "Failed to register regulator\n";
+				dev_err_probe(int3472->dev, ret, "Failed to register regulator\n");
 
 			break;
 		default: /* Never reached */
@@ -436,11 +435,11 @@ static int skl_int3472_handle_gpio_resources(struct acpi_resource *ares,
 	int3472->ngpios++;
 	ACPI_FREE(obj);
 
-	if (ret < 0)
-		return dev_err_probe(int3472->dev, ret, err_msg);
-
-	/* Tell acpi_dev_get_resources() to not make a copy of the resource */
-	return 1;
+	/*
+	 * Either return an error or tell acpi_dev_get_resources() to not make a
+	 * copy of the resource.
+	 */
+	return ret < 0 ? ret : 1;
 }
 
 int int3472_discrete_parse_crs(struct int3472_discrete_device *int3472)
-- 
2.47.3

