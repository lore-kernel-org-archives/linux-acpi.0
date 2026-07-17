Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733392F7EE4;
	Fri, 17 Jul 2026 17:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784308196; cv=none; b=W5O8bTAH/kxeLP75InPWtvuVQu8fHLWuAeQXiPPWRjSJLryD9ussEReo7NG6dd7NdEKT0q1TGT0Nm73AJjk0bGXbOoufJUvPrz1wPEUbaNCMZ6AFPlNM9zCNxXZHIdKOgDiCEZvuvQ29oj8ibBqwr+uMvx/DZUX/KM1NYJhsz5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784308196; c=relaxed/simple;
	bh=smJ4mpiUv9ut2U0Ic18fxs5zDWGVvmxUzsW/a9RxD6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uOhNCDUuBDJAIVKOg8bWsTM7UeUWu48n/QPllVZPuPLgBdcH5gHco+deIpLVpx8H2QbFkfp8HrFSIPas42kldb1z0s9DXuteZYZZ0Cgtt2NmQoOIcZPqrRD1iTreM5sYsx1wRNAJIB7nMRO0NkHj7w2Fs8QVQRlHv4wGNNb1p8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MYmaOmRK; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MYmaOmRK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784308196; x=1815844196;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=smJ4mpiUv9ut2U0Ic18fxs5zDWGVvmxUzsW/a9RxD6o=;
  b=MYmaOmRK7QB5efTZcd7gXTE2oqtPxVgddsWgpvKHlbM5vJ+4MzqOSB7q
   d2C/5998Svfs2nfmxOn/VUGgpxYW6mmovU941znYGPN1en4C81XIsT2sX
   8Rfo24FflPQPVgnG2J3rpzfi20n93fNwgp73sBsN0R2rSyR3e6tiiNdv9
   g9sCRF1GXGwr2o3ekLOfNjnOUZ42ck4wgvom51rKmbhDawWnYxuk1TI0p
   p7n4InRxcyETb8heHU3Avgo3mFXzBBREK+AwwEQd+sLRAQHCDg+Ix7wL5
   Heony3YLUFjs1VXvkO5M5LYf3t8gsNgYzSumyaBeeP3Bv0r0p69UebKHK
   w==;
X-CSE-ConnectionGUID: 5E5yFV9PRheQn4yGWanK2Q==
X-CSE-MsgGUID: RFjCrH2aQ0+ZXCfUxfJARQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11849"; a="85025197"
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="85025197"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 10:09:55 -0700
X-CSE-ConnectionGUID: pMuJLN+tSgioaarinpT/Cw==
X-CSE-MsgGUID: BrSczC6nS6ijEUoUaE5P6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="250486225"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa009.fm.intel.com with ESMTP; 17 Jul 2026 10:09:53 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 96C0A99; Fri, 17 Jul 2026 19:09:52 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Armin Wolf <W_Armin@gmx.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Subject: [PATCH v1 1/2] ACPI: fan: Don't use "proxy" headers
Date: Fri, 17 Jul 2026 19:08:29 +0200
Message-ID: <20260717170951.1782863-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260717170951.1782863-1-andriy.shevchenko@linux.intel.com>
References: <20260717170951.1782863-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update header inclusions to follow IWYU (Include What You Use)
principle.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/fan.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/fan.h b/drivers/acpi/fan.h
index 97ce3212edf3..e06c055a8bb6 100644
--- a/drivers/acpi/fan.h
+++ b/drivers/acpi/fan.h
@@ -10,8 +10,9 @@
 #ifndef _ACPI_FAN_H_
 #define _ACPI_FAN_H_
 
-#include <linux/kconfig.h>
+#include <linux/device.h>
 #include <linux/limits.h>
+#include <linux/types.h>
 
 #define ACPI_FAN_DEVICE_IDS	\
 	{"INT3404", }, /* Fan */ \
-- 
2.50.1

