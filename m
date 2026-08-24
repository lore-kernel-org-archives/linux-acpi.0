Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B928937648F;
	Mon, 24 Aug 2026 21:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787606014; cv=none; b=fnevy4mVfP2QpmJICCf+y30YZQfxOO2+KDEIM3UtcL2jastpLSlG5wKIOfboRSnp/OKQDZfONV9sdrGSoRlPvGcRHRn0GQdw9VjrDW3IYi/5+t8CMB2AlU8GXkjXEAoMgiBj9xK6KeoSWXZ9faWYvCQX6AGhKIB1RLX516YAh0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787606014; c=relaxed/simple;
	bh=MrErzkKwo7FZ4YB58FLImWBUlsupof/B69RwcZHD/h8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dvGtpvS6Wdo/2xQVtO69++l9/sLSlU313OdreHjejVTQgSWsYmm0Pmzzcmx7+8sikk3XJ7WFPsVsDq5NgLqiJL87hxnQealrpuqyMQLU59+P9DKKHZbaGMXTXDPdjkwNT6EYUkv+PwscuvrDOzzO3x8o4vBwk9rSQEwJc2jriuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IjrqtFcb; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IjrqtFcb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787606013; x=1819142013;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MrErzkKwo7FZ4YB58FLImWBUlsupof/B69RwcZHD/h8=;
  b=IjrqtFcbjA1aOfLYmR45WPoszVOvQMCXZGCL0b1Zh6Mv2Tgcz5fWEQc1
   oR3dYw0nxxmYZOjLwIOk6qt4xIX3NKkS8K2X+d7kePHu3e0QZYcgTIjBx
   Y3kLRLOK2HPFgPYQuMB4VgII+XkSxUK5cVDROzwtGTSDGXHTtoEnBTTFe
   M/t9vmSrZJkIUNL3iOdgh38+JddD+vMWwYwepHNweaip///YVvGavAGxU
   TShNEDnLo62OuEAGwcCNcn4RUChTLyAM6JRIj4sduvqTU1/leCBXXLKzk
   8c0DdTM7KoLnPWgAFQI7c4VeqRoCsSghwvxU7VJxXFzVH0N/o/gOBaIZf
   g==;
X-CSE-ConnectionGUID: lpS1/67jStaIt5SQL+FGQw==
X-CSE-MsgGUID: nnjjKMqJRqu9vDbqg5+UFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="88125310"
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="88125310"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 14:13:30 -0700
X-CSE-ConnectionGUID: SJP1I2plRx66hiR+E51QpQ==
X-CSE-MsgGUID: Wz5+NdnCSa+/tuhIV5MNqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="290634203"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.9])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 14:13:27 -0700
Received: from punajuuri.localdomain (unknown [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 0F92F121C42;
	Tue, 25 Aug 2026 00:13:38 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.98.2)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1wybz8-0000000F2MT-0k2H;
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
Subject: [PATCH v2 1/5] platform/x86: int3472: Address Coccinelle warning on an error print
Date: Tue, 25 Aug 2026 00:13:34 +0300
Message-ID: <20260824211338.3583976-2-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260824211338.3583976-1-sakari.ailus@linux.intel.com>
References: <20260824211338.3583976-1-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix the following Coccinelle warning:

./tps68470.c:164:58-65: WARNING: Consider using %pe to print PTR_ERR()

by using %pe specifier for printing an error code.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/platform/x86/intel/int3472/tps68470.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/int3472/tps68470.c b/drivers/platform/x86/intel/int3472/tps68470.c
index a77ed32abe55..dc777dbac61f 100644
--- a/drivers/platform/x86/intel/int3472/tps68470.c
+++ b/drivers/platform/x86/intel/int3472/tps68470.c
@@ -161,7 +161,7 @@ static int skl_int3472_tps68470_probe(struct i2c_client *client)
 
 	regmap = devm_regmap_init_i2c(client, &tps68470_regmap_config);
 	if (IS_ERR(regmap)) {
-		dev_err(&client->dev, "Failed to create regmap: %ld\n", PTR_ERR(regmap));
+		dev_err(&client->dev, "Failed to create regmap: %pe\n", regmap);
 		return PTR_ERR(regmap);
 	}
 
-- 
2.47.3

