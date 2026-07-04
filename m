Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E6D25B099;
	Sat,  4 Jul 2026 17:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783185859; cv=none; b=dkm4jzZw9wwEz9RqRoXiBzqyK+2jx084j4CkGyRTod8ygt7yV6pF2xtuLwjczlUDIBiJswo4z/JU+33utgu3QZ74Qo20PWQmVURBw9BR7UiQj/DisSVd9mUD9wYf1Lj+znP510nWGPfdBzlwd5EEvhsx64ZP5oilAhzoqYLQSEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783185859; c=relaxed/simple;
	bh=YIUNVjVMRCV0zPA4GTAAkceNEBIJj6m9M3C6VQ1rCRc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CR283gbionw4ZZI8WEwqPe33iDiScnVbfIflPubMz/cabBvc/90DTrlQMZKvhOM4ybtNCZHjZgOlg5OWntTprpBHdLvM5JMwXQyZ8S+zbGkk79C/j0Ag1fIq4UsYaobVNnzVycSFhGe897URF7PYWToq3RLmGK8ZLWrg9I6QD+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cByrfRWw; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cByrfRWw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783185857; x=1814721857;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YIUNVjVMRCV0zPA4GTAAkceNEBIJj6m9M3C6VQ1rCRc=;
  b=cByrfRWwi+ARysDX2+HwHKzpb2ME4Msp3Kh+myCi43On9uokTL524V5R
   vqoJdKTiT1vygzmfCvHfrPQdkiw09fDpzUuWkfDrPjyWx3T1xbgrbf+pI
   pAB2Lk+PTdhFhLPOpAC4L31WEYFd2ChAv/gAjPnJx5I2OxrcUQ+7BMtus
   pIZiSDjDjusJFzny+aaMsu0fUAeWdmaiYfMKnswWwoijrqpeD3CK6jz7F
   ROrCB1u1mVVZawwpj/rgkuDLmb/mR8iEi02BFxsHjEFHPrcvdIlqMgkLv
   HwAf/vGFlffWN1YC8jH1HD2PFe71xs2b+vajhqvuQI/sVtfSvvx2gSKjq
   A==;
X-CSE-ConnectionGUID: FnGpTAxhTi2mO5tZ9n0esA==
X-CSE-MsgGUID: bwrUaIyCQMe7MoKwAyJTNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11837"; a="101308159"
X-IronPort-AV: E=Sophos;i="6.25,147,1779174000"; 
   d="scan'208";a="101308159"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2026 10:24:16 -0700
X-CSE-ConnectionGUID: L7JCFJxiS62b96EpF61mmg==
X-CSE-MsgGUID: 7RVCWWmGQ5GhAmRZgQrjTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,147,1779174000"; 
   d="scan'208";a="250677810"
Received: from intel-nuc8i7beh.iind.intel.com ([10.223.163.6])
  by fmviesa008.fm.intel.com with ESMTP; 04 Jul 2026 10:24:13 -0700
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
Subject: [PATCH v2 0/4] Add NVL CVS/IPU8 camera support
Date: Sat,  4 Jul 2026 22:48:51 +0530
Message-ID: <20260704171855.1462214-1-arun.t@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds NVL CVS support to the ACPI dependency handling,
the IPU bridge, and the CVS driver. It also adds the IPU8 PCI device
ID needed for the CVS driver to bind on NVL camera hardware.

Changes in v2:
- Add a cover letter for the multi-patch series.
- Add Reviewed-by from Sakari Ailus to patch 1.

Arun T (4):
  ACPI: scan: Honor ACPI _DEP dependency for NVL CVS
  media: pci: ipu-bridge: Add NVL CVS ACPI ID
  media: i2c: cvs: Add IPU8 PCI device ID
  media: i2c: cvs: Add NVL ACPI ID

 drivers/acpi/scan.c                  | 1 +
 drivers/media/i2c/cvs/core.c         | 3 +++
 drivers/media/pci/intel/ipu-bridge.c | 1 +
 3 files changed, 5 insertions(+)

-- 
2.43.0

