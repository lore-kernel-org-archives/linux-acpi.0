Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6273CAE68
	for <linux-acpi@vger.kernel.org>; Tue, 24 Mar 2026 23:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774394225; cv=none; b=T8iYph8V2aorwOOyorILBOVEVIzahCO2Lacr+ndDfxCz3ZpXY0PkfsDQG0XMyonpM0f4lm8GawFWV3M5LZ8cdNZ4bxdMwZo4jWT4h9eO2S5WGWytHfsUmIkATK0ot+w8mHrNC7rh4R6y01mEzuD4KHjv9G1lKjSEDqIBWXQYRRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774394225; c=relaxed/simple;
	bh=NECt5bb220jXhvMdk1n8+7N5KrEkEDqyRHaHPCEYcdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SLlHy2QI+rDTzZ/eFgJ+5ZLV09rsriTL4EOMvVBewjL0f7sT2Adk76DXMtkIq/0//bQHc1q7jClky3viykLLSc8Rg0yXW2vbMtt/5Wdi1p13TTutN8+U+9+1lk5auOCx7CQ3OyjKo0bblFL0A/iyocN6fewr7OdqhTvLQup40Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ed4VLLLU; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ed4VLLLU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774394224; x=1805930224;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NECt5bb220jXhvMdk1n8+7N5KrEkEDqyRHaHPCEYcdo=;
  b=ed4VLLLU8Tf3mkLIIQsB9tTLPvk/2sHKsa02mrWsRPichAiJjxvw9zpW
   WmTzmQ9Hs4VXyuH5h8AJJquKuF7MfrvFKEhjMr7wVyS54r1GcZVMkz+1e
   4/tlcGYnlmecoAFTPAt2b0A+nwt65snBJjCAIFnZP5ZJIvv9bAh3KrjR8
   ON7s5gSKvE/k4+rS5vYPfz7rfRaHt5PjERM52pvvgGqQFlf0JHriyCZhY
   jHVyJnXxsHqLoqcqagrbioMDW4xt1Tu/6wAKU1tpOnqdQZ3JUirXUv077
   YhA7AhWpSoBMevNO8E0+K90qnNZ3LrWZypph2kGRCjab0JMhLlluL0PuK
   Q==;
X-CSE-ConnectionGUID: Uk9EkdOiQZmKLOWmF+7g1A==
X-CSE-MsgGUID: PPARvalISomk9nFddmdjXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="79021663"
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="79021663"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 16:16:59 -0700
X-CSE-ConnectionGUID: 1ID6qg30TMOOsCqtsWX71g==
X-CSE-MsgGUID: NewtzoJ5RsarmV9PdOKdvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="228548643"
Received: from nldesimo-desk.amr.corp.intel.com ([10.53.80.57])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 16:17:00 -0700
From: Nate DeSimone <nathaniel.l.desimone@intel.com>
To: rafael@kernel.org
Cc: lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	tony.luck@intel.com
Subject: [PATCH v3 2/2] Documentation: ABI: add FBPT and S3PT entries to sysfs-firmware-acpi
Date: Tue, 24 Mar 2026 16:14:55 -0700
Message-ID: <20260324231456.701-3-nathaniel.l.desimone@intel.com>
X-Mailer: git-send-email 2.51.2.windows.1
In-Reply-To: <20260324231456.701-1-nathaniel.l.desimone@intel.com>
References: <20260324231456.701-1-nathaniel.l.desimone@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the FBPT and S3PT sysfs attributes under
/sys/firmware/acpi/fpdt/

Signed-off-by: Nate DeSimone <nathaniel.l.desimone@intel.com>
---
 Documentation/ABI/testing/sysfs-firmware-acpi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-firmware-acpi b/Documentation/ABI/testing/sysfs-firmware-acpi
index 72e7c9161ce7..fa33dda331f2 100644
--- a/Documentation/ABI/testing/sysfs-firmware-acpi
+++ b/Documentation/ABI/testing/sysfs-firmware-acpi
@@ -41,6 +41,12 @@ Description:
 				platform runtime firmware S3 resume, just prior to
 				handoff to the OS waking vector. In nanoseconds.
 
+		FBPT: The raw binary contents of the Firmware Basic Boot
+			Performance Table (FBPT) subtable.
+
+		S3PT: The raw binary contents of the S3 Performance Table
+			(S3PT) subtable.
+
 What:		/sys/firmware/acpi/bgrt/
 Date:		January 2012
 Contact:	Matthew Garrett <mjg@redhat.com>
-- 
2.34.1

