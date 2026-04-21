Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EDB3D8916;
	Tue, 21 Apr 2026 15:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776783750; cv=none; b=P3goIC6FtEOjVJHhNkerc20PAlvZuwpePSquz0NJmnBwJrSaFqWVazV6g6pONvaBbMxUu37VZQ6s6Zfst/eyPmaK3CDDo+XASFHH1P7tJ156e62rS0wTZLecdUXd5cF+934oUdGfScyjOzJ2lMdv7xL0XoeaVQfI9nZKo9fjCGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776783750; c=relaxed/simple;
	bh=JQ2bYN63fgfn9ocjvZHJv2SwjpU35WUbJTTi+e2QUzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K/cnzlF8XiNhIywSQqqXE0cX0r9XzHfaEcHlnHTolfa6dCexhMAMr5pUmitHugJ864MwcCzo4437ZVNRUyl7/Ro7JTkechRjG6Atj3NgKGvaaVe577ol8BwXuAqv00uyX/AHP9i6zsUD3CA+JR12Fwgvh6PjrLuBHQHh80BUyjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L9/smwRt; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L9/smwRt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776783749; x=1808319749;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JQ2bYN63fgfn9ocjvZHJv2SwjpU35WUbJTTi+e2QUzM=;
  b=L9/smwRtEZ740R7K6b3PROYVJq3rm1c0kOco6WLCpdzMd1w0U+OMQBU1
   HeXGzZ/N1n4SoNdhtfvS6oEXa17vddMq5g89svhqFe0IFe7/tbMqpWC32
   f7oqTJVK+mJBGLfbXBarOrblqromi9Yzl6gw+ewrAMdirK2O2WW75X6I2
   rLSrZkVpfjHDXYjfO8vbN/S1BZJ0bYF7FFXK4VYTRFJJT2kYT1XM5tlQg
   6v3kS6YeHtiiY+bJnKzUasnpT8gNXNYP0MZxT1O6JODcQvzEFcIoV9Tjn
   5ds3lkhPXa7wHNnBe/jSNLMep3b7JgplN2zRHwsygQRYnl/Y13UM9gPs+
   w==;
X-CSE-ConnectionGUID: fy5kwVctRJiQ5xrj1kuFgQ==
X-CSE-MsgGUID: 1Yk7MeUoRoq7n2VtUrdr1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="100375994"
X-IronPort-AV: E=Sophos;i="6.23,191,1770624000"; 
   d="scan'208";a="100375994"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 08:02:27 -0700
X-CSE-ConnectionGUID: lDRT3IckTQuVwX52KvGtUg==
X-CSE-MsgGUID: ecE/nRcyTzqn1O29iz+9wA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,191,1770624000"; 
   d="scan'208";a="227731226"
Received: from inaky-mobl1.amr.corp.intel.com (HELO agluck-desk3.home.arpa) ([10.124.223.220])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 08:02:26 -0700
From: Tony Luck <tony.luck@intel.com>
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Herman Li <herman.li@intel.com>,
	"Lai, Yi1" <yi1.lai@intel.com>,
	Zaid Alali <zaidal@os.amperecomputing.com>,
	Jiaqi Yan <jiaqiyan@google.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v4 1/2] ACPICA: Provide #defines for EINJV2 error types
Date: Tue, 21 Apr 2026 08:02:15 -0700
Message-ID: <20260421150216.11666-2-tony.luck@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421150216.11666-1-tony.luck@intel.com>
References: <20260421150216.11666-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

EINJV2 defined new error types by moving the severity (correctable,
uncorrectable non-fatal, uncorrectable fatal) out of the "type".

ACPI 6.5 introduced EINJV2 and defined a vendor defined error type using
bit 31. This was dropped in ACPI 6.6.

Signed-off-by: Tony Luck <tony.luck@intel.com>

---
Already applied to https://github.com/acpica/acpica.git as
commit e82d2d2fd145 ("Provide #defines for EINJV2 error types")


 include/acpi/actbl1.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 4e15583e0d25..f72e00517eb3 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -1386,6 +1386,12 @@ enum acpi_einj_command_status {
 #define ACPI_EINJ_CXL_MEM_FATAL             (1<<17)
 #define ACPI_EINJ_VENDOR_DEFINED            (1<<31)
 
+/* EINJV2 error types from EINJV2_GET_ERROR_TYPE (ACPI 6.6) */
+
+#define ACPI_EINJV2_PROCESSOR               (1)
+#define ACPI_EINJV2_MEMORY                  (1<<1)
+#define ACPI_EINJV2_PCIE                    (1<<2)
+
 /*******************************************************************************
  *
  * ERST - Error Record Serialization Table (ACPI 4.0)
-- 
2.53.0

