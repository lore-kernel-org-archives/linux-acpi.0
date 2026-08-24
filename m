Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B83F3911B5;
	Mon, 24 Aug 2026 21:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787606015; cv=none; b=FXgw738eh1UMNv3CkFO8dT5WCQlu14HVMd9zndAMr7UYJ69JZ3aHBZPCD2nPV0eebNk2KD0TdzQWyBOo//948Ofna2xmX7e1tZC6TjSFNqJHqZwFAmL4HcVqdv25R/cu6QZh9lLO65Mtw4uZ9mAO2hAUkIGIc1KujcSZ45YQzv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787606015; c=relaxed/simple;
	bh=PiYIXiedSMvXFSpxiKMUHOD71ADF1kDbn/Q8nhKXQm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ezpks0ZSo0vBQmCIUFr6iMQ5uGmF/fsb3vc2xuWIWqJO2SkHWpFEqCRbM5tdQ8svuIYrTo6ciPjv+X+Lke2BqUNoY5s8V3bPt/RkgMiTUZWnCkP0K2R//qaBKqrwBhPv9uKGL26DoDR5Bcn8ivc3XhVKxZ4jidl+k9sm5NEcJfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FQ1SOoot; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FQ1SOoot"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787606014; x=1819142014;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PiYIXiedSMvXFSpxiKMUHOD71ADF1kDbn/Q8nhKXQm4=;
  b=FQ1SOootSFiipPkP6TZJnbBw+7xCvXaskRRTYNDG9JPBv9h+H+RRhsgH
   hJEBmKIoxOxKUADb+LLcqQ2Tpdqc1z1mfQGW/lkas8VVGw7BAaWUFxrdF
   o+6E+WUojIHrd/IDBahelSn1IaqZ2qcJx2PkUEURcbL4zM+fYnZY/u08l
   usirxu1RpRfg/DxNI7C3FwGaokJZl7Uy5rwhGqtnbvbgX4p9M8qsAo4tO
   MkynRnG4zAqBFwRLDLTJNSUifKGiZ6706FBIwctf6PKqvQjE6xdN3UoHE
   gBboI0SD9eIrjVNjIYabanaHSwCPo5Qnpd66f9EwVQ+rZs/a2adi7u1/k
   Q==;
X-CSE-ConnectionGUID: C0He+OW2RZGYjh6GAvtBsA==
X-CSE-MsgGUID: Tkpc1jzJTDypUh7KqWyWWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="88125313"
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="88125313"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 14:13:30 -0700
X-CSE-ConnectionGUID: pv78iTqbRt+gmGuldrTwbQ==
X-CSE-MsgGUID: 09qxok9uQmmYVgaz9XiNKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="290634204"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.9])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 14:13:27 -0700
Received: from punajuuri.localdomain (unknown [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 18196121C8C;
	Tue, 25 Aug 2026 00:13:38 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.98.2)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1wybz8-0000000F2Mf-0wbA;
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
Subject: [PATCH v2 4/5] platform/x86: int3472: Release ACPI objects using __free()
Date: Tue, 25 Aug 2026 00:13:37 +0300
Message-ID: <20260824211338.3583976-5-sakari.ailus@linux.intel.com>
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

Use __free() to release ACPI objects received from
acpi_evaluate_dsm_typed() without explicit ACPI_FREE().

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/platform/x86/intel/int3472/discrete.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/intel/int3472/discrete.c b/drivers/platform/x86/intel/int3472/discrete.c
index b4a95b583edb..2024eaa09033 100644
--- a/drivers/platform/x86/intel/int3472/discrete.c
+++ b/drivers/platform/x86/intel/int3472/discrete.c
@@ -4,6 +4,7 @@
 #include <linux/acpi.h>
 #include <linux/array_size.h>
 #include <linux/bitfield.h>
+#include <linux/cleanup.h>
 #include <linux/device.h>
 #include <linux/dmi.h>
 #include <linux/gpio/consumer.h>
@@ -327,7 +328,6 @@ static int skl_int3472_handle_gpio_resources(struct acpi_resource *ares,
 	unsigned int enable_time_us;
 	u8 active_value, pin, type;
 	unsigned long gpio_flags;
-	union acpi_object *obj;
 	struct gpio_desc *gpio;
 	const char *con_id;
 	int ret;
@@ -339,10 +339,11 @@ static int skl_int3472_handle_gpio_resources(struct acpi_resource *ares,
 	 * ngpios + 2 because the index of this _DSM function is 1-based and
 	 * the first function is just a count.
 	 */
-	obj = acpi_evaluate_dsm_typed(int3472->adev->handle,
-				      &int3472_gpio_guid, 0x00,
-				      int3472->ngpios + 2,
-				      NULL, ACPI_TYPE_INTEGER);
+	union acpi_object *obj __free(ACPI_FREE) =
+		acpi_evaluate_dsm_typed(int3472->adev->handle,
+					&int3472_gpio_guid, 0x00,
+					int3472->ngpios + 2,
+					NULL, ACPI_TYPE_INTEGER);
 
 	if (!obj) {
 		dev_warn(int3472->dev, "No _DSM entry for GPIO pin %u\n",
@@ -433,7 +434,6 @@ static int skl_int3472_handle_gpio_resources(struct acpi_resource *ares,
 	}
 
 	int3472->ngpios++;
-	ACPI_FREE(obj);
 
 	/*
 	 * Either return an error or tell acpi_dev_get_resources() to not make a
-- 
2.47.3

