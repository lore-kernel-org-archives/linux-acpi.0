Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A86B377541;
	Sat,  4 Jul 2026 17:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783185869; cv=none; b=JrT4NZOt6fT9JZSGbYYHM9xiO0UTfDo1BH9meS2SdF4o7fGbX/ycUo+nCuML6m8lI0130vEYkCVfeLJIzzBJyfwo+aawFtx5z8h0Ev4iG26QylusAZ62dmNygR1mV5uUnep6fxb9q4MqjyhBW9eRYlL2H5mbEU+QSerR5KS886A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783185869; c=relaxed/simple;
	bh=GB/bvAuUnL8pcQEa+/v3DmUoOKXxg2XuWruD5vaMxSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rkBpO96hWSga3pyTayawDmkcivc22a507ZRaD/gWCmoFwzMWfhMkrhrZ2sTThawS7xLVrUAT2ASfpoghdP9UnsjxU915ThAwEzhLkJ4OVb6AWinj3CBAmwLA3crUqa8KDwXLxjn9v+XLIahUMoT40fYw5xnMSgCVRGn+uza0Lwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lg/Ssyk2; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lg/Ssyk2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783185867; x=1814721867;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GB/bvAuUnL8pcQEa+/v3DmUoOKXxg2XuWruD5vaMxSk=;
  b=Lg/Ssyk27ZTVAmwuXw051b3Vhfk2/brdzQ/AK1N+ezWWdNb9uRwRHqTi
   XLNuxa13tGf4iEMrbv5mGhtOE/5iH1hoGh9uWqQf5ZsXFFJlP4POUw2hu
   6F8afFTIudnmVKb1zZY4IJKP1cIewiKqaJcMbD76fUkcCy1xSjDyHuY86
   ftYQd/1KagPEafiFz+1k/xGRZWjlzE3uK/AyYE2rRODgRhxjai7JdAZns
   wQiIoaz5IqW4+GgTRytLhZ9u72LZe0A1Q56jZgMD1ZN8oA0C2wyEJ/PXs
   iLvPmSguZv8kDgEHZm/uTozQc3tFvvkoCQbzPUWDOE502FjlJKkpBCc5d
   A==;
X-CSE-ConnectionGUID: jk3b9j7tQqe3Rgvd3JnjVA==
X-CSE-MsgGUID: On9NvPRxQXCu/MQfwBQGNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11837"; a="101308166"
X-IronPort-AV: E=Sophos;i="6.25,147,1779174000"; 
   d="scan'208";a="101308166"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2026 10:24:27 -0700
X-CSE-ConnectionGUID: FfP6C3eDS+eTt/V6tbWCoQ==
X-CSE-MsgGUID: LEKYiajnQlOORQ+mmWH/cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,147,1779174000"; 
   d="scan'208";a="250677832"
Received: from intel-nuc8i7beh.iind.intel.com ([10.223.163.6])
  by fmviesa008.fm.intel.com with ESMTP; 04 Jul 2026 10:24:24 -0700
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
Subject: [PATCH v2 3/4] media: i2c: cvs: Add IPU8 PCI device ID
Date: Sat,  4 Jul 2026 22:48:54 +0530
Message-ID: <20260704171855.1462214-4-arun.t@intel.com>
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

Add the NVL IPU8 PCI device ID to the CVS driver match table so the
CVS driver can bind to IPU8 camera hardware.

Signed-off-by: Arun T <arun.t@intel.com>
---
 drivers/media/i2c/cvs/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/i2c/cvs/core.c b/drivers/media/i2c/cvs/core.c
index 4282f33c7295..8270d93f1abe 100644
--- a/drivers/media/i2c/cvs/core.c
+++ b/drivers/media/i2c/cvs/core.c
@@ -32,6 +32,7 @@
 
 #define PCI_DEVICE_ID_INTEL_IPU7		0x645d	/* MTL / LNL */
 #define PCI_DEVICE_ID_INTEL_IPU7P5		0xb05d	/* ARL / PTL */
+#define PCI_DEVICE_ID_INTEL_IPU8		0xd719	/* NVL */
 
 /*
  * IPU7 PCI device IDs not covered by ipu6_pci_tbl in ipu6-pci-table.h.
@@ -40,6 +41,7 @@
 static const struct pci_device_id icvs_ipu7_tbl[] = {
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IPU7) },
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IPU7P5) },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IPU8) },
 	{ }
 };
 
-- 
2.43.0

