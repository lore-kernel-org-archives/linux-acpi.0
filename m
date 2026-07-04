Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4766D374A0F;
	Sat,  4 Jul 2026 17:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783185862; cv=none; b=ZSMEQqcnF2eUSLwuMO9316dcGiTBphyLfzm3b/KUwHRaW5tlXCatrV/lG3UI0UXywcdWc9RhUKrE+h8cwl1Ay/3sZE4c3WO73rpmOiN9JHew31uGpRI5zdu09h3Ooti1YcFr+rlLvCIoYstmt3kTFoUgS/fdBrspYkXxYSsLpDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783185862; c=relaxed/simple;
	bh=xpggDYBxCajznnp+jYuwmCUI39zKlPSYDeK3/hqUosM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W9lkypCUovc6CGoClvX5dd3xTeN0sUb2aqykAXrLz+7Bv7gKbYB7pqBFKp09ppGkla8X1NltcLvqKy0Lg/ky47wW9ENTYMkmkjU8xAi2pJkmpve38GlfY9P7MWeCCtOd/jTWRBvl3N0c4UAWsPk3h4J/cGddIu+aMzQuKz/Gl7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OrVO3cnT; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OrVO3cnT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783185860; x=1814721860;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xpggDYBxCajznnp+jYuwmCUI39zKlPSYDeK3/hqUosM=;
  b=OrVO3cnTMiSLjk0RvkG1VTZ3qvV2B2+OJhv/dhLp6b372uaUyHIGK7wR
   MJ/0A+DvQG563d4V2S6iPD78gyLkfALLb4PTJc+IvDdxIL/LuFobWfv/T
   UpSN+GR0f5R3iXHfI4zOTQ+RZumJu1yX0AgM2aNPiQ1p50QyO3R3roaz6
   6xzK9hQSQ5STeVjPJ7b7ylrxDdp9xfj7vRBX9hC3ss5R2LlTGiObsVjjA
   LH3KJ3uEfdQnL8jnEbBeJe0LWn0kOx2nYpGdS9cNaeKkAQz3p1YMv7cTr
   aQJ8DbGN4maZmbFu0ErnWUJ+oopcOIcUDBsKe5JdM+XKUm36+pfiap13K
   Q==;
X-CSE-ConnectionGUID: VUrKXIxiT/ySCRvhl9fFWA==
X-CSE-MsgGUID: LBxeeQSSTp2It25tGeRi+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11837"; a="101308162"
X-IronPort-AV: E=Sophos;i="6.25,147,1779174000"; 
   d="scan'208";a="101308162"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2026 10:24:20 -0700
X-CSE-ConnectionGUID: T69KTTv6T7GhK8qmH4im7A==
X-CSE-MsgGUID: 4x8ZUlwmRuql/53qEZ9eww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,147,1779174000"; 
   d="scan'208";a="250677817"
Received: from intel-nuc8i7beh.iind.intel.com ([10.223.163.6])
  by fmviesa008.fm.intel.com with ESMTP; 04 Jul 2026 10:24:17 -0700
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
Subject: [PATCH v2 1/4] ACPI: scan: Honor ACPI _DEP dependency for NVL CVS
Date: Sat,  4 Jul 2026 22:48:52 +0530
Message-ID: <20260704171855.1462214-2-arun.t@intel.com>
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

Add INTC10FA to the ACPI dependency honor list so the CVS driver is
loaded before dependent camera devices are probed on NVL platforms.

This matches the camera dependency handling already used for IVSC-based
platforms and ensures the camera streaming path is initialized before
sensor access or pipeline setup depends on it.

Signed-off-by: Arun T <arun.t@intel.com>
Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
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

