Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CEA496919;
	Thu,  2 Jul 2026 13:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782998608; cv=none; b=Lxb58RTA2GT5T8yqYS0GwU9yMbMmh08QRoWr0UUI7Hfa4QNF13enj4KCCPDOxvXNaQcLZe9SLG3PrBSkTE4E32ZwVWaNJBOOGow7coUplCQZxRnWbNZfzmpLbjxAPfC+UF8/Utc6qI8ZtVGv+mYFTwPIa93DNmDjvQ/RcXQLwW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782998608; c=relaxed/simple;
	bh=mtGVqSt4EOZRepAmTc8xjqGS3MzfsgmhjOOs8bI6nrk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hQYDzw/5uoxEiYmUMqltRUbdlnxh/DbB6CoMRM6/BJpwmiTziqat5FtRONy9MDEFP+51BYyREyNGOG3ZPcBusyjt64OayTgRk8MLQT532mhwGq4I4BGUrc0n5W/EmZNPGaJuUDoXAOr0j3lOtlqaobV/t8V76gWq7x9xaq1CJG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bvxX8i5F; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bvxX8i5F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782998607; x=1814534607;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mtGVqSt4EOZRepAmTc8xjqGS3MzfsgmhjOOs8bI6nrk=;
  b=bvxX8i5F0ambdQpgb8X5mpCUhQD3vHOtmVCg8jETWg1liWY05jJfMHwc
   M4SFaFLVbRoGN/Yytlj8EztKvpmNWOd0LmCFqyAr0GuvSdcjLrpNkguqk
   DeLogJCmS9VkR7ZcKyBb7N9ofFX0taA1u7LN4QHQG6rQYMsNLYnUCXycl
   HVV9+nck5zWxJ81eVmGt/b4yb94+anT/cOirbhnCXFnXT42QIqf4Nes1T
   SUSPgMtvpRw+Ih4X0E6QUxShJnmVjxcmy4tIcsixXfvnn5CKHnEUUxQnY
   D6v5tzd09QwQXm4hyciXJC1+7LxGnjt+tZhsdruAFQsxt/qfVvHI16Vf9
   w==;
X-CSE-ConnectionGUID: RbLS1bG8TDe8MDbn19i7Sw==
X-CSE-MsgGUID: U+oK8w/bQ2afgymWfu522g==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="95133049"
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="95133049"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 06:23:26 -0700
X-CSE-ConnectionGUID: 4uLfnlCxTwWc4P9PnCWXcw==
X-CSE-MsgGUID: gPFgC0pbT0qlZUmYWDN/5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="246502769"
Received: from intel-nuc8i7beh.iind.intel.com ([10.223.163.6])
  by fmviesa009.fm.intel.com with ESMTP; 02 Jul 2026 06:23:24 -0700
From: Arun T <arun.t@intel.com>
To: arun.t@intel.com,
	rafael@kernel.org
Cc: sakari.ailus@intel.com,
	sakari.ailus@linux.intel.com,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mehdi.djait@intel.com
Subject: [PATCH 1/4] ACPI: scan: Honor ACPI _DEP dependency for NVL CVS
Date: Thu,  2 Jul 2026 18:48:09 +0530
Message-ID: <20260702131809.1224895-1-arun.t@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add INTC10FA to the ACPI dependency honor list so the CVS driver is
loaded before dependent camera devices are probed on NVL platforms.

This matches the camera dependency handling already used for IVSC-based
platforms and ensures the camera streaming path is initialized before
sensor access or pipeline setup depends on it.

Signed-off-by: Arun T <arun.t@intel.com>
---
 drivers/acpi/scan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 9a7ac2eb9ce0..21937912a1a5 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -862,6 +862,7 @@ static const char * const acpi_honor_dep_ids[] = {
 	"INTC10DE", /* CVS (LNL) driver must be loaded to allow camera streaming */
 	"INTC10E0", /* CVS (ARL) driver must be loaded to allow camera streaming */
 	"INTC10E1", /* CVS (PTL) driver must be loaded to allow camera streaming */
+	"INTC10FA", /* CVS (NVL) driver must be loaded to allow camera streaming */
 	"RSCV0001", /* RISC-V PLIC */
 	"RSCV0002", /* RISC-V APLIC */
 	"RSCV0005", /* RISC-V SBI MPXY MBOX */
-- 
2.43.0

