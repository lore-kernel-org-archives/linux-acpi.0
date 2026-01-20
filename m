Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18672310784;
	Tue, 20 Jan 2026 15:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768923615; cv=none; b=cByVhr39tz+7T9fGtpxy5dWbx++PbQfLrMU0WkYrXAePHvJQMxAKyTVvgiwlCj9UymsFNAqiPU1lPpAg9eiFirVZZTuW18CcfQh8h+ihAy11JHcJIOQDxcMBP9v/CkVgEXIVxM16jLLt5toN3EIXE6f/Eva+3RIqsWrpQn62DMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768923615; c=relaxed/simple;
	bh=c2K6hQ3LuTh8Q7jFXguAbEtsQ8baJyILYHzPneFbXx4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A1d54jUER3lcVsKTcfvWuvlolBPoXyeT12/1H4VjsZP8bGUd/1oA/dsfi9je0vrZS/0fdBWVCYFFL2z5EN8Ht6uCqzDF09GWNHVd4vd4q/Ll5E4h5jYSn5BvgvUZ8ecvx14KrUlQrgegrzOUF3IQqnPxaLPMfprqCVHIrYnMc7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K/m1GRM4; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K/m1GRM4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768923613; x=1800459613;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=c2K6hQ3LuTh8Q7jFXguAbEtsQ8baJyILYHzPneFbXx4=;
  b=K/m1GRM4mLMB3fFo989H8f+nRleMmDAAa4zb9/Usf3An5oz6apE8fl7Z
   JRuy1sxd8WCsCIh/5yiC9gfX9U1w+OmhzgmwXXhdCXtsu0J98nMRKA3Ov
   x2bKAtNJlZIiWaO2OmuDMcUJhWWWwKmq8R+jzgfjNyWgru2rcx9VG6nPL
   y71iGTK2p0pIGncHB6ixVRn2zYGfUmP+SnnC6JE4Wp0xKMMvJuXhrWMNL
   XORHygvsWCtiaICKQSih75O2Y1lmjbUqs3BQ8o0Ll426GXiZPcrtAkauT
   F6++qCc1B0O6vzCOSgtKXkm4xRqztCrBxIWeJGCZ0TTTPxEz3WcuOul4g
   A==;
X-CSE-ConnectionGUID: 42MtdU5RQJOpotYpFcdX7g==
X-CSE-MsgGUID: IVvAy4FJT5C77XNq63qnzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="74003565"
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="74003565"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 07:40:13 -0800
X-CSE-ConnectionGUID: BCcgccTQRjylRJk7tf0OUg==
X-CSE-MsgGUID: ESNBE+h1Q7COyqK7F6GGBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="237410789"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa001.fm.intel.com with ESMTP; 20 Jan 2026 07:40:11 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 484D498; Tue, 20 Jan 2026 16:40:10 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] ACPI: video: simplify code with acpi_get_local_u64_address()
Date: Tue, 20 Jan 2026 16:40:08 +0100
Message-ID: <20260120154008.1763983-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now we have a helper so there's no need to open-code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/acpi_video.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 944aba605c1a..7cde285a85f1 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -1134,13 +1134,12 @@ static int acpi_video_bus_get_one_device(struct acpi_device *device, void *arg)
 	struct acpi_video_bus *video = arg;
 	struct acpi_video_device_attrib *attribute;
 	struct acpi_video_device *data;
-	unsigned long long device_id;
 	acpi_status status;
 	int device_type;
+	u64 device_id;
 
-	status = acpi_evaluate_integer(device->handle, "_ADR", NULL, &device_id);
 	/* Skip devices without _ADR instead of failing. */
-	if (ACPI_FAILURE(status))
+	if (acpi_get_local_u64_address(device->handle, &device_id))
 		goto exit;
 
 	data = kzalloc(sizeof(struct acpi_video_device), GFP_KERNEL);
-- 
2.50.1

