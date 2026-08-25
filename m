Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A53D3C1D70;
	Tue, 25 Aug 2026 20:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787690147; cv=none; b=see7Br0U2jMtnsTNW4iAS3sLhZMWLZP7e7m7HXGad0qIrX9Ssh2TZIldRYk/AvjdEYQq9lBYs6JbAEZ3rdwafGE2ikGw7EswslzK4//+igVTx8iB1T6vAM1mYKRJjOaPfAsZ8gbFQhE6R0Mw3whU9bALA1BsP5RgFl+6CYl3nEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787690147; c=relaxed/simple;
	bh=MrErzkKwo7FZ4YB58FLImWBUlsupof/B69RwcZHD/h8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FDeGya13A6CT+xqx5PTajT8q5PkTtrDWXWafDFegX1j/YJTDHCk5xOz0O5hWLCkhQEa7cukwdvz9G9aC4/1Bb/HFYg8i/+Th1UWAo7+n5mwOpnYhboEGwbAIQn2YtLhZoNfYXHUOMfPat3jNCby+k/PLgXh5ttdByqHOfl8tdno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D8rHUUBG; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D8rHUUBG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787690146; x=1819226146;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MrErzkKwo7FZ4YB58FLImWBUlsupof/B69RwcZHD/h8=;
  b=D8rHUUBG4A3tV0ZrQ88LyNhAGCXSQ0UN3d4cxDegU/p/xxxS1xyV7JkI
   CY52CgF7PlCn9JsCX4jD0ji3kXMhmWFyXcIDQm9KeqEvYfkgUN8ewlPwv
   pSlrhDVqIrmXtxNlJ+4UZjIoqkySf07xiMjEtokBF8P8PygyLh+By4Aym
   emeHiHg2aKqzsVnfL7Gylwj3F3qDRhs83N47+0/hGVSZwj/bIUInCo7wg
   DWwIxxPP9tcEW+QU7Fvyqh9KMTLhuYPmo7TWRZaS7Qif+zBqzFvR9W959
   98NTD42icyWFfDokzEcB/XotmIougCsj0CE0FR42o7pCkIvMa34K08l4X
   w==;
X-CSE-ConnectionGUID: +yQ7F6/6SOGtnKOweYiV+w==
X-CSE-MsgGUID: 83ErtHelSeqwzYlq6rFBaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="88194755"
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; 
   d="scan'208";a="88194755"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 13:35:43 -0700
X-CSE-ConnectionGUID: nPW9YwceTp2JwGYzzG4ajA==
X-CSE-MsgGUID: Wlm4PZJ4QWuStxvyYNLMwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; 
   d="scan'208";a="265579299"
Received: from carterle-desk.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.168])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 13:35:41 -0700
Received: from punajuuri.localdomain (unknown [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 610FA121C10;
	Tue, 25 Aug 2026 23:35:53 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.98.2)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1wyxs9-0000000Fd57-24Rv;
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
Subject: [PATCH v3 1/3] platform/x86: int3472: Address Coccinelle warning on an error print
Date: Tue, 25 Aug 2026 23:35:51 +0300
Message-ID: <20260825203553.3725132-2-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260825203553.3725132-1-sakari.ailus@linux.intel.com>
References: <20260825203553.3725132-1-sakari.ailus@linux.intel.com>
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

