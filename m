Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13E2377EBF;
	Sat,  4 Jul 2026 17:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783185872; cv=none; b=MdhI3cz5Ki4x9qARX2eTNn8o3k2ktw1hkgdd07kZVriug0YfkIv/XCWoEFT9Q4JAPTmb1v/GFB0/X5le5p+Z0E9R/01RGCKFVf5WgviZKHOfzTzdaYippD7rIaM8S3Z8gMi1pnuLW6Ju0p6HEjgoelqgdKxCSAHblEJYb4VOyHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783185872; c=relaxed/simple;
	bh=bwJgzEjDtCiFYLEBeDIfh4X6nAtb+oau958LGiGYgO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nAY0ZoyjJk+cg1edsed98mL41MWP+fK+TX39EdSxn3eh6QFBgcr6L1zDXMmBOEJmIib+niDTH+RLc0Lgh9ZfjaLlIUOZtAIURh3tVmpCtAoHku+Fjzh1W4VytCr/xDGbvDmwYnPNZ4sWz0twx+U5801XvH49D3wV3TPS6JvVGOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CbNG1xlV; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CbNG1xlV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783185871; x=1814721871;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bwJgzEjDtCiFYLEBeDIfh4X6nAtb+oau958LGiGYgO4=;
  b=CbNG1xlVm9uOc7svsgKsWKJA6i/pJfwLxjfC2QcSoQSdsJn6j0vJxvEr
   j9Puq/fBQJ4bWYIw5BIRqDn4WE2inzsNL1IJp1zcAZKcBMqfStkSZZmGw
   1xEbM4vGh3vM0SYZ5RhkNf2nrK+52+LLwTxGqhMUOqrVdFBnIP6SSGLUK
   jlKuW40Przq2ZrGDP4D9WOfx35TFT4AUbXFadmdtVjn7CRmeLujcjv3kw
   ukrIdZArSapuhZUYo+p0Qi7PbGC6NNI8xYE3BMXw5j/YAhdz4jkAfglhb
   RA03BPH1JydPgDxLbO0BeVeqRkDWjnx0nxDQk30O0QoL25sclZbninw/n
   g==;
X-CSE-ConnectionGUID: ZhuEyJ8JTZ2qqroQckM5Xg==
X-CSE-MsgGUID: Rt6IwC6KQ4ChnWpWtKXXDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11837"; a="101308168"
X-IronPort-AV: E=Sophos;i="6.25,147,1779174000"; 
   d="scan'208";a="101308168"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2026 10:24:30 -0700
X-CSE-ConnectionGUID: xnaQ0srgQg6clww9XUhblA==
X-CSE-MsgGUID: oWrLnH+ERbWeFU20URqSeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,147,1779174000"; 
   d="scan'208";a="250677835"
Received: from intel-nuc8i7beh.iind.intel.com ([10.223.163.6])
  by fmviesa008.fm.intel.com with ESMTP; 04 Jul 2026 10:24:27 -0700
From: Arun T <arun.t@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Miguel Vadillo <miguel.vadillo@intel.com>
Cc: Len Brown <lenb@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Mehdi Djait <mehdi.djait@intel.com>,
	linux-acpi@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] media: i2c: cvs: Add NVL ACPI ID
Date: Sat,  4 Jul 2026 22:48:55 +0530
Message-ID: <20260704171855.1462214-5-arun.t@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260704171855.1462214-1-arun.t@intel.com>
References: <20260704171855.1462214-1-arun.t@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add INTC10FA to the CVS ACPI match table so the driver can bind to
CVS devices exposed on NVL platforms.

Signed-off-by: Arun T <arun.t@intel.com>
---
 drivers/media/i2c/cvs/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/i2c/cvs/core.c b/drivers/media/i2c/cvs/core.c
index 8270d93f1abe..7486815b16bd 100644
--- a/drivers/media/i2c/cvs/core.c
+++ b/drivers/media/i2c/cvs/core.c
@@ -965,6 +965,7 @@ static const struct acpi_device_id intel_cvs_acpi_match[] = {
 	{ "INTC10DE" }, /* LNL */
 	{ "INTC10E0" }, /* ARL */
 	{ "INTC10E1" }, /* PTL */
+	{ "INTC10FA" }, /* NVL */
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, intel_cvs_acpi_match);
-- 
2.43.0

