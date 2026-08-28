Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05293EB102;
	Fri, 28 Aug 2026 08:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787906622; cv=none; b=dNOBdSZQrBpWDZ79kAHHjDThY4XmdRXeR8OKt0HDIVkgFYokj8PelMtVAFtTdzVyGDx+XyL1RKLatanPsG3ozOvs6gbVaczQHlquIbwWxyO8po0ZLNqwV83yfbJfvgQkacVT8KAj19DwM6/hbiDmo8rDm3HgvUcFqXn+y9WmWso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787906622; c=relaxed/simple;
	bh=ltxGWMz5lb5TGV6PNNv+0v/iWk1f4xZaefqFBf04p4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XX6D/bhhKxe444RUORSfVPmsdMdC3NCK4aMjkPnrADMGN+MsX10fyAEWfXVsAvYQO8C6mMQIBeRwL0LCbC2K23vKR5LC0uM7V330pJAExo3c5KssVOD8VAkp/m292TFNrXmEzAcluEFfjye51BQ4jWIYK3OuyN1nlaAPm8YKZNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jujlEHMM; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jujlEHMM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787906621; x=1819442621;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ltxGWMz5lb5TGV6PNNv+0v/iWk1f4xZaefqFBf04p4w=;
  b=jujlEHMMHrLEfiRCR7PqCMcDZs+17woVPwaCiMNMadAunmjTAQNTnnv+
   TlSYpQeBeOGc3JM8IWmJFywO24NvByq4+g9fhtXI2ipFnY+fOiYxLPAX9
   IinPekQJlbcMo3Jl/PVu5yb9oA8DpHmm25cX8GbjqYpZTaFuUqRIJq3FS
   5z4N1pBf2tWf0OPY/1F2jetlN1cu3Z24ohNa2znmL9GlYVZ6IwukhCh4K
   lOmgDoREP3Sa+BfPWlfM35NiquBxMLXn/6c8lFVrerxUyaq9hJNOLg6Vt
   d/5aALuyvs/pZI3yp6gD28XYyCf3x6hnCPeka8c8xhyVNHuxNTSLASo6f
   w==;
X-CSE-ConnectionGUID: vG9YeKoaS3+1+1SgN03clw==
X-CSE-MsgGUID: qXCC3GYkT9S7j5X04pd2cw==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="75955883"
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; 
   d="scan'208";a="75955883"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2026 01:43:34 -0700
X-CSE-ConnectionGUID: Ys+Y1hXhQziHHtX2b9WFdg==
X-CSE-MsgGUID: VKURa6J2RtaGZy3wkM80bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; 
   d="scan'208";a="261952412"
Received: from rvuia-mobl.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.92])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2026 01:43:33 -0700
Received: from punajuuri.localdomain (unknown [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id DCE59121C60;
	Fri, 28 Aug 2026 11:43:28 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.98.2)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1wzsBM-0000000152x-3Mat;
	Fri, 28 Aug 2026 11:43:28 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-media@vger.kernel.org
Cc: linux-acpi@vger.kernel.org,
	rafael@kernel.org
Subject: [PATCH 3/3] media: i2c: Use ACPI_PTR() for ACPI ID tables
Date: Fri, 28 Aug 2026 11:43:28 +0300
Message-ID: <20260828084328.257703-4-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260828084328.257703-1-sakari.ailus@linux.intel.com>
References: <20260828084328.257703-1-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add ACPI_PTR() to the ACPI ID tables where missing. The patch has been
produced with the following command:

git grep -lP 'acpi_match_table.*=\s*(?!ACPI_PTR)' \
	drivers/media/|while read i; do
	perl -i -pe 's/\.acpi_match_table\s*=\s*\K(\w+),/ACPI_PTR($1),/' $i;
done

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/media/i2c/ccs/ccs-core.c | 2 +-
 drivers/media/i2c/cvs/core.c     | 4 ++--
 drivers/media/i2c/gc0310.c       | 2 +-
 drivers/media/i2c/mt9m114.c      | 2 +-
 drivers/media/i2c/ov02e10.c      | 2 +-
 drivers/media/i2c/ov2680.c       | 2 +-
 drivers/media/i2c/ov2740.c       | 2 +-
 drivers/media/i2c/ov5693.c       | 2 +-
 drivers/media/i2c/ov7251.c       | 2 +-
 drivers/media/i2c/ov8865.c       | 2 +-
 drivers/media/i2c/ov9734.c       | 2 +-
 11 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/media/i2c/ccs/ccs-core.c b/drivers/media/i2c/ccs/ccs-core.c
index 8e25f970fd12..1d68d981d7f2 100644
--- a/drivers/media/i2c/ccs/ccs-core.c
+++ b/drivers/media/i2c/ccs/ccs-core.c
@@ -3679,7 +3679,7 @@ static const struct dev_pm_ops ccs_pm_ops = {
 
 static struct i2c_driver ccs_i2c_driver = {
 	.driver	= {
-		.acpi_match_table = ccs_acpi_table,
+		.acpi_match_table = ACPI_PTR(ccs_acpi_table),
 		.of_match_table = ccs_of_table,
 		.name = CCS_NAME,
 		.pm = &ccs_pm_ops,
diff --git a/drivers/media/i2c/cvs/core.c b/drivers/media/i2c/cvs/core.c
index 7486815b16bd..390cd0ff2c6e 100644
--- a/drivers/media/i2c/cvs/core.c
+++ b/drivers/media/i2c/cvs/core.c
@@ -973,7 +973,7 @@ MODULE_DEVICE_TABLE(acpi, intel_cvs_acpi_match);
 static struct i2c_driver cvs_driver = {
 	.driver = {
 		.name = "intel_cvs",
-		.acpi_match_table = intel_cvs_acpi_match,
+		.acpi_match_table = ACPI_PTR(intel_cvs_acpi_match),
 		.pm = pm_ptr(&cvs_pm_ops),
 	},
 	.probe = cvs_probe,
@@ -1000,7 +1000,7 @@ static void cvs_platform_remove(struct platform_device *pdev)
 static struct platform_driver cvs_platform_driver = {
 	.driver = {
 		.name = "cvs_platform",
-		.acpi_match_table = intel_cvs_acpi_match,
+		.acpi_match_table = ACPI_PTR(intel_cvs_acpi_match),
 		.pm = pm_ptr(&cvs_pm_ops),
 	},
 	.probe = cvs_platform_probe,
diff --git a/drivers/media/i2c/gc0310.c b/drivers/media/i2c/gc0310.c
index 754e82ad50ae..0f756a250536 100644
--- a/drivers/media/i2c/gc0310.c
+++ b/drivers/media/i2c/gc0310.c
@@ -768,7 +768,7 @@ static struct i2c_driver gc0310_driver = {
 	.driver = {
 		.name = "gc0310",
 		.pm = pm_sleep_ptr(&gc0310_pm_ops),
-		.acpi_match_table = gc0310_acpi_match,
+		.acpi_match_table = ACPI_PTR(gc0310_acpi_match),
 	},
 	.probe = gc0310_probe,
 	.remove = gc0310_remove,
diff --git a/drivers/media/i2c/mt9m114.c b/drivers/media/i2c/mt9m114.c
index e395e2d14e97..65aee72627d7 100644
--- a/drivers/media/i2c/mt9m114.c
+++ b/drivers/media/i2c/mt9m114.c
@@ -2684,7 +2684,7 @@ static struct i2c_driver mt9m114_driver = {
 		.name	= "mt9m114",
 		.pm	= &mt9m114_pm_ops,
 		.of_match_table = mt9m114_of_ids,
-		.acpi_match_table = mt9m114_acpi_ids,
+		.acpi_match_table = ACPI_PTR(mt9m114_acpi_ids),
 	},
 	.probe		= mt9m114_probe,
 	.remove		= mt9m114_remove,
diff --git a/drivers/media/i2c/ov02e10.c b/drivers/media/i2c/ov02e10.c
index 4a64cba99991..5e1ad6bdaaa1 100644
--- a/drivers/media/i2c/ov02e10.c
+++ b/drivers/media/i2c/ov02e10.c
@@ -939,7 +939,7 @@ static struct i2c_driver ov02e10_i2c_driver = {
 	.driver = {
 		.name = "ov02e10",
 		.pm = pm_sleep_ptr(&ov02e10_pm_ops),
-		.acpi_match_table = ov02e10_acpi_ids,
+		.acpi_match_table = ACPI_PTR(ov02e10_acpi_ids),
 		.of_match_table = ov02e10_of_match,
 	},
 	.probe = ov02e10_probe,
diff --git a/drivers/media/i2c/ov2680.c b/drivers/media/i2c/ov2680.c
index 78e63bd1b35b..6dd7f454242a 100644
--- a/drivers/media/i2c/ov2680.c
+++ b/drivers/media/i2c/ov2680.c
@@ -1312,7 +1312,7 @@ static struct i2c_driver ov2680_i2c_driver = {
 		.name  = "ov2680",
 		.pm = pm_sleep_ptr(&ov2680_pm_ops),
 		.of_match_table	= ov2680_dt_ids,
-		.acpi_match_table = ov2680_acpi_ids,
+		.acpi_match_table = ACPI_PTR(ov2680_acpi_ids),
 	},
 	.probe		= ov2680_probe,
 	.remove		= ov2680_remove,
diff --git a/drivers/media/i2c/ov2740.c b/drivers/media/i2c/ov2740.c
index 39003c1632ad..371f9f394aea 100644
--- a/drivers/media/i2c/ov2740.c
+++ b/drivers/media/i2c/ov2740.c
@@ -1470,7 +1470,7 @@ MODULE_DEVICE_TABLE(acpi, ov2740_acpi_ids);
 static struct i2c_driver ov2740_i2c_driver = {
 	.driver = {
 		.name = "ov2740",
-		.acpi_match_table = ov2740_acpi_ids,
+		.acpi_match_table = ACPI_PTR(ov2740_acpi_ids),
 		.pm = pm_sleep_ptr(&ov2740_pm_ops),
 	},
 	.probe = ov2740_probe,
diff --git a/drivers/media/i2c/ov5693.c b/drivers/media/i2c/ov5693.c
index 4cc796bbee92..5609c5ba5795 100644
--- a/drivers/media/i2c/ov5693.c
+++ b/drivers/media/i2c/ov5693.c
@@ -1409,7 +1409,7 @@ MODULE_DEVICE_TABLE(of, ov5693_of_match);
 static struct i2c_driver ov5693_driver = {
 	.driver = {
 		.name = "ov5693",
-		.acpi_match_table = ov5693_acpi_match,
+		.acpi_match_table = ACPI_PTR(ov5693_acpi_match),
 		.of_match_table = ov5693_of_match,
 		.pm = &ov5693_pm_ops,
 	},
diff --git a/drivers/media/i2c/ov7251.c b/drivers/media/i2c/ov7251.c
index 27afc3fc0175..ddd2c91ec057 100644
--- a/drivers/media/i2c/ov7251.c
+++ b/drivers/media/i2c/ov7251.c
@@ -1809,7 +1809,7 @@ MODULE_DEVICE_TABLE(acpi, ov7251_acpi_match);
 static struct i2c_driver ov7251_i2c_driver = {
 	.driver = {
 		.of_match_table = ov7251_of_match,
-		.acpi_match_table = ov7251_acpi_match,
+		.acpi_match_table = ACPI_PTR(ov7251_acpi_match),
 		.name  = "ov7251",
 		.pm = &ov7251_pm_ops,
 	},
diff --git a/drivers/media/i2c/ov8865.c b/drivers/media/i2c/ov8865.c
index c6d53c3d55ca..b676db6b2a08 100644
--- a/drivers/media/i2c/ov8865.c
+++ b/drivers/media/i2c/ov8865.c
@@ -3144,7 +3144,7 @@ static struct i2c_driver ov8865_driver = {
 	.driver = {
 		.name = "ov8865",
 		.of_match_table = ov8865_of_match,
-		.acpi_match_table = ov8865_acpi_match,
+		.acpi_match_table = ACPI_PTR(ov8865_acpi_match),
 		.pm = &ov8865_pm_ops,
 	},
 	.probe = ov8865_probe,
diff --git a/drivers/media/i2c/ov9734.c b/drivers/media/i2c/ov9734.c
index 0eaf33807fc9..b37ca79ceaad 100644
--- a/drivers/media/i2c/ov9734.c
+++ b/drivers/media/i2c/ov9734.c
@@ -980,7 +980,7 @@ MODULE_DEVICE_TABLE(acpi, ov9734_acpi_ids);
 static struct i2c_driver ov9734_i2c_driver = {
 	.driver = {
 		.name = "ov9734",
-		.acpi_match_table = ov9734_acpi_ids,
+		.acpi_match_table = ACPI_PTR(ov9734_acpi_ids),
 	},
 	.probe = ov9734_probe,
 	.remove = ov9734_remove,
-- 
2.47.3

