Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F0A3B42CB;
	Tue, 25 Aug 2026 20:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787690148; cv=none; b=JvMsKSNAKPTpg59SdE7mnt3Ic5SNKm2q+B3/cr5t/VSonwMukXGv0z4875lrQ+Nal9FBdVyiNcUP5dWXDyOftnGntxPSKLiS0/BNj19CV2dFh8aAJDQ+M8+T8u4k6bLPO8S6tarqtMhF3iRUcts6oYWPYv8DhX4bZv7rLbxbIHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787690148; c=relaxed/simple;
	bh=EaD0EzR9N7ujpWgd+3EvntEwo+0Sgp52oBTnd9xUt9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iNaCdbrQG4EuEkOt+eTJ/Mit+/V8X2zK4L8GK7GxgBM33IzXV8mVHaRpfQkb/f9rfPXuNrdzqFM8elSHHt7GW7KYWI8Uw+vu8/c1KQGd00TOoMb6UQXrRWfrvq1Jk0Pd1DyIxAh7o/4bwxdvxkum4d2tKT+XqT4EPr+ReDrTNkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kpj8yKnY; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kpj8yKnY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787690146; x=1819226146;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EaD0EzR9N7ujpWgd+3EvntEwo+0Sgp52oBTnd9xUt9Q=;
  b=kpj8yKnY5nSf54nGSRPgbjoOXAlzMmyME/5+IEWqQF+K/ifNucPhaG3F
   8xB3/86BYvjcBVlFrrrQflsIQ9XpzoaVB7UY0R417TbiLRIc2/Jv+81IB
   0O/ow59UnSDy9ifgAKbX8+fBUhnj2Q7Mg7aPTknRBSprFCDASuhy1sqMH
   VHFTV/hYH45aDhkAroaCJzjJgQ1t15mu7FEI3a9Y1fLdYSkBxgQaqN8iZ
   Iir2GhCxtBAZMXMgkNzhNM0avJGTH3BBYyxr0ar713On0ikWdrPRsI8SW
   RvRp5/aiI00y697rBejuySYBub85r5PkjWUheQ7Uj+uYbsWpabk/4X6a5
   w==;
X-CSE-ConnectionGUID: PDbOxsaES6ekejw97qzsXA==
X-CSE-MsgGUID: eRLg64W6RqG7I6Nf5ioyhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="88194752"
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; 
   d="scan'208";a="88194752"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 13:35:43 -0700
X-CSE-ConnectionGUID: SWuaOiYaTg2RDTbgc/46CA==
X-CSE-MsgGUID: zCnjqGM+QCGY57/r4+SxsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; 
   d="scan'208";a="265579297"
Received: from carterle-desk.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.168])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 13:35:41 -0700
Received: from punajuuri.localdomain (unknown [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 61C91121C42;
	Tue, 25 Aug 2026 23:35:53 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.98.2)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1wyxs9-0000000Fd5B-2A8o;
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
Subject: [PATCH v3 2/3] platform/x86: int3472: Fix uninitialised variable warning
Date: Tue, 25 Aug 2026 23:35:52 +0300
Message-ID: <20260825203553.3725132-3-sakari.ailus@linux.intel.com>
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

Fix a smatch warning about uninitialised err_msg variable, by printing the
error where it is handled.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/platform/x86/intel/int3472/discrete.c | 25 +++++++++++--------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/platform/x86/intel/int3472/discrete.c b/drivers/platform/x86/intel/int3472/discrete.c
index 6c729fcfce5d..9cd4f78875ab 100644
--- a/drivers/platform/x86/intel/int3472/discrete.c
+++ b/drivers/platform/x86/intel/int3472/discrete.c
@@ -329,7 +329,6 @@ static int skl_int3472_handle_gpio_resources(struct acpi_resource *ares,
 	unsigned long gpio_flags;
 	union acpi_object *obj;
 	struct gpio_desc *gpio;
-	const char *err_msg;
 	const char *con_id;
 	int ret;
 
@@ -375,7 +374,8 @@ static int skl_int3472_handle_gpio_resources(struct acpi_resource *ares,
 	case INT3472_GPIO_TYPE_HOTPLUG_DETECT:
 		ret = skl_int3472_map_gpio_to_sensor(int3472, agpio, con_id, gpio_flags);
 		if (ret)
-			err_msg = "Failed to map GPIO pin to sensor\n";
+			dev_err_probe(int3472->dev, ret,
+				      "Failed to map GPIO pin to sensor\n");
 
 		break;
 	case INT3472_GPIO_TYPE_CLK_ENABLE:
@@ -387,7 +387,7 @@ static int skl_int3472_handle_gpio_resources(struct acpi_resource *ares,
 		gpio = skl_int3472_gpiod_get_from_temp_lookup(int3472, agpio, con_id, gpio_flags);
 		if (IS_ERR(gpio)) {
 			ret = PTR_ERR(gpio);
-			err_msg = "Failed to get GPIO\n";
+			dev_err_probe(int3472->dev, ret, "Failed to get GPIO\n");
 			break;
 		}
 
@@ -395,14 +395,16 @@ static int skl_int3472_handle_gpio_resources(struct acpi_resource *ares,
 		case INT3472_GPIO_TYPE_CLK_ENABLE:
 			ret = skl_int3472_register_gpio_clock(int3472, gpio);
 			if (ret)
-				err_msg = "Failed to register clock\n";
+				dev_err_probe(int3472->dev, ret,
+					      "Failed to register clock\n");
 
 			break;
 		case INT3472_GPIO_TYPE_PRIVACY_LED:
 		case INT3472_GPIO_TYPE_STROBE:
 			ret = skl_int3472_register_led(int3472, gpio, con_id);
 			if (ret)
-				err_msg = "Failed to register LED\n";
+				dev_err_probe(int3472->dev, ret,
+					      "Failed to register LED\n");
 
 			break;
 		case INT3472_GPIO_TYPE_POWER_ENABLE:
@@ -413,7 +415,8 @@ static int skl_int3472_handle_gpio_resources(struct acpi_resource *ares,
 			ret = skl_int3472_register_regulator(int3472, gpio, enable_time_us,
 							     con_id, second_sensor);
 			if (ret)
-				err_msg = "Failed to register regulator\n";
+				dev_err_probe(int3472->dev, ret,
+					      "Failed to register regulator\n");
 
 			break;
 		default: /* Never reached */
@@ -436,11 +439,11 @@ static int skl_int3472_handle_gpio_resources(struct acpi_resource *ares,
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

