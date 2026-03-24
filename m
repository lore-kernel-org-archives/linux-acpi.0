Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEC4156F45
	for <linux-acpi@vger.kernel.org>; Tue, 24 Mar 2026 23:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774394224; cv=none; b=J51u0sgN+VEDymSSwmlnhPo3dzy5B1Q3d4rdL9EimdLDVj1FupsGreO8ElnIo+rsgJzD3YqDMRR61wOyXOJqfLx5t06bfQBCcneWE+utVZoK9VIm/WGnSf0MoEEv7KOVIMtuK+2aX7Yw3RZFpqci/0yj/j31KGPbuLU51D2ZoaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774394224; c=relaxed/simple;
	bh=FtI7pnbRd5ma3fcGFzYC0HBITldZbnprZ+t8Wwj33YA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HQsDYKRqajrWWXsYhgNWO2jy11T89xLSFq2O9PPtDcAu/DxaX5xpbCBWAAj1D1+N8xzjmHei3SSCjQe980U7C/NnsgoYLckf2RUkOKn3MnOqDC4+jGRJW4LpXr06ooYOp2oVA0YCfqMlzICkZY1SGLXlcCfOfu6KJc3sKy8+69o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DBEOTx93; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DBEOTx93"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774394221; x=1805930221;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FtI7pnbRd5ma3fcGFzYC0HBITldZbnprZ+t8Wwj33YA=;
  b=DBEOTx93zo8HuMekLOtuShSpQFSr/+3bAb8Wvx0Guk4hcvXfyhzoWunK
   2gXG2JBgv60V8XKxEVv8NbFeYAiPYeKjNVvyKhjhZCY1EsEd36oX9oY+s
   AKU50u4A/lldwRo86vcrYko+bUhejQKKyBGz71h8YIlxsHQgKiQuub//r
   HOdlVOLCPVfZbsNWFvPclksXiuafPNMRJGF5shmaFuj6jVErDMHH+5R3P
   xo+ZUn6oFZGsFgcV+ZqjhCqmr74EPzIey9cCIpyBQfO1xOAOLcKsEfIdt
   WGBP5CNL63bAhyT9Snr8DWR1qh4/xd8TY8sWjW43TUV6AMoPG4Yqsf/kx
   Q==;
X-CSE-ConnectionGUID: 1DZLqt5NSCSTLNr5Mb2p7g==
X-CSE-MsgGUID: nTT25+5cRJG49qUnyf3Kkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="79021645"
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="79021645"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 16:16:59 -0700
X-CSE-ConnectionGUID: VZ42efELRA+D1EYe+RyD4Q==
X-CSE-MsgGUID: wHIa3GkxSMCD2TiJHWdacg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="228548637"
Received: from nldesimo-desk.amr.corp.intel.com ([10.53.80.57])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 16:17:00 -0700
From: Nate DeSimone <nathaniel.l.desimone@intel.com>
To: rafael@kernel.org
Cc: lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	tony.luck@intel.com
Subject: [PATCH v3 0/2] ACPI: FPDT: expose FBPT and S3PT subtables via sysfs
Date: Tue, 24 Mar 2026 16:14:53 -0700
Message-ID: <20260324231456.701-1-nathaniel.l.desimone@intel.com>
X-Mailer: git-send-email 2.51.2.windows.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ACPI Firmware Performance Data Table (FPDT) can contain two subtables:

1. Firmware Basic Boot Performance Table (FBPT)
2. S3 Performance Table (S3PT)

The existing /sys/firmware/acpi/tables/FPDT sysfs entry
only exposes the top-level FPDT header, not the subtables themselves.

This series adds sysfs attributes at /sys/firmware/acpi/fpdt/FBPT and
/sys/firmware/acpi/fpdt/S3PT that expose the raw contents of these
subtables. This mirrors the model used by /sys/firmware/dmi/tables/DMI
for DMI/SMBIOS data, and allows userspace tools to parse newer FPDT
record types defined in recent ACPI specifications[1] (e.g. String
Event Records, Microcontroller Boot Performance Data Records, etc.)
without requiring kernel changes for each new record type.

[1]
https://uefi.org/specs/ACPI/6.6/05_ACPI_Software_Programming_Model.html#performance-event-record-types

Signed-off-by: Nate DeSimone <nathaniel.l.desimone@intel.com>
---

Changes in v3:
- changed sysfs_create_bin_file() error handling to a non-fatal warning

Changes in v2:
- removed the intermediate /sys/firmware/acpi/tables/ subdirectory
- tightened file permissions for FBPT and S3PT from 0444 to 0400
- added documentation to Documentation/ABI/testing/sysfs-firmware-acpi

---
Nate DeSimone (2):
  ACPI: FPDT: expose FBPT and S3PT subtables via sysfs
  Documentation: ABI: add FBPT and S3PT entries to sysfs-firmware-acpi

 Documentation/ABI/testing/sysfs-firmware-acpi |  6 ++++
 drivers/acpi/acpi_fpdt.c                      | 28 +++++++++++++++++++
 2 files changed, 34 insertions(+)


base-commit: 24f9515de8778410e4b84c85b196c9850d2c1e18
-- 
2.34.1

