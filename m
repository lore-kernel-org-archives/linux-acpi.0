Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E8A30C16E;
	Fri, 17 Jul 2026 17:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784308197; cv=none; b=CH3t4ZkZcPkjZ1ZbSe9W6UZ+Jgj5UrC8iXRCJDLqb/LmM8rWdo5/KPjoaYbZPJn3+ewKYdB2NuVpPyRAhg4hl+SaaogvviyewOvxM5BOwsm204kcjecp/sQnoimSUBDpelID7BuMUYDQbaMntFlkbfKLfakEd/48V5qeztWwpaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784308197; c=relaxed/simple;
	bh=MFEUxCv1QUX3luoU//bOx5FEkJ0M9NCwlVxU/5iALTs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PxI6neBz1eYLIyD4niBOFnleJYaemhIFtD5fJXxD5Gifg7NZGxauQf+tf+uk/KJfjt1Qz7Gj1eBLqndF48pfgtx3PUGxKtDfN/KmAv/GqxGAC32T6ooz5GgenuFJSIFNKD+a1W6+Y9fU7lxSTMp/vrmEHCJ38xTebGvKtTpNMgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YgzRVgzL; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YgzRVgzL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784308196; x=1815844196;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MFEUxCv1QUX3luoU//bOx5FEkJ0M9NCwlVxU/5iALTs=;
  b=YgzRVgzLM6knJ44oF5bVGgV35b1RzSQe1HKAV2I/1gljFO/WUPRxUDP4
   okV+9Me2pXHY2liDmm+6W+ghzTEFy7dG0Jfttm1PgePG9ubmpj4JWx7NW
   vEMINTAG2v7q8s01ZoFusbjUSaWuoIY8vUzYlXG7Tl0mHDW2QXNpaZvJX
   W1UZLGCv69ypLWUd2E55dEuCZVSIKMiomVIPO8/qC4lqAnqw30XzV9vRR
   e3+zkggWV2KkhmnUjXW++wPWKC8f7sPFFx8/qcyd+M5WeKPoVyA5zXcfu
   CgWWVOAW97bbKzGq00B1BiyxPH/amZhXUtr240cVrolTGHk53x/2WNiP/
   w==;
X-CSE-ConnectionGUID: KDbN5iZ8S3eC2ZmedXj2TQ==
X-CSE-MsgGUID: GfXfPPLBSMyWPSRYqFDT8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11849"; a="88883531"
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="88883531"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 10:09:56 -0700
X-CSE-ConnectionGUID: IxWX8uM9QRe3/oW2XIYuQg==
X-CSE-MsgGUID: Dvd7azkzSO+ny+k+QG++DA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="281286477"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa001.fm.intel.com with ESMTP; 17 Jul 2026 10:09:53 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 937B298; Fri, 17 Jul 2026 19:09:52 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Armin Wolf <W_Armin@gmx.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Subject: [PATCH v1 0/2] ACPI: fan: Ad-hoc cleanups
Date: Fri, 17 Jul 2026 19:08:28 +0200
Message-ID: <20260717170951.1782863-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The main purpose of my work is to clean up always included linux/kconfig.h.
But there is room to improve the drivers/acpi/fan.h. Hence this small series.

Andy Shevchenko (2):
  ACPI: fan: Don't use "proxy" headers
  ACPI: fan: Update ACPI fan IDs to follow modern style

 drivers/acpi/fan.h | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

-- 
2.50.1

