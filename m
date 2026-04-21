Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEB73D9030;
	Tue, 21 Apr 2026 15:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776783750; cv=none; b=iImbw7P+6NFJGhDAHZYXDLEGTSOmSDVnrtuoT84xkjNrfPWBgRGY9Rb1v40nLj7sl20u/BCVxNfYWnxVybSF03mopQXosz1Hflxz/Dp3+Ncq5YotY3UfauJcU7dHSot2xq9C2CB1eUrc0qahWWZwPRJ5nUlR+XkpayXVPg1+XdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776783750; c=relaxed/simple;
	bh=+kar+8SFmVDT8jtUZIegjK4JgoBjdB/8x6mrsj5Blk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MUCe1OoACQ6ku/6TkLlX1DguSJwDnCWjiUB/b0lULVOSie/W3Nj35ID2DdtmiEk92T3SlgM9oW7+EwUWcKKApFzOTsJXs8EBCdcxeh91E15KZoGrcSCcs51emtWHVSIs4qcCZnvJN+J1wk7Juy0fvGXCdX1bPczZFYTUiln7QHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BjGD8e0s; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BjGD8e0s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776783749; x=1808319749;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+kar+8SFmVDT8jtUZIegjK4JgoBjdB/8x6mrsj5Blk4=;
  b=BjGD8e0sAOPUIZs6eJSPrRm2DNyd2nR+3etGJnb8s8ARHUKv4wSZxFqb
   DOIbo9YZC4jYX5cG63BH+ezLC9t4beYgDQ+AkQtjmVdAXDkQINWf7ZnsE
   moaSk/0cK5yH4PmHzRdVwbn9J+ckBlhcYgWouVX3Rnnv9s5EOogWFffXw
   MY+gywDOOPu5BUb7MGkWxBAPYOjIo0Ow1LAitGh4ORU7qpNn2FnBYgMl4
   gyjx1kkyzlBjLux2Hx3QOxRla2/HqXGMtqHnuAItwYDGCJ/cD7r/efV/X
   qh6yWl+ptJPFV83+OyocnT/O9nYFrLKajJtIra5Mw74Id4qi6FcNtB4NA
   A==;
X-CSE-ConnectionGUID: xF69YqKSTFuj+xGmy9o1cg==
X-CSE-MsgGUID: 8fENgVe8QWiLPfcjSz+3PQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="100375998"
X-IronPort-AV: E=Sophos;i="6.23,191,1770624000"; 
   d="scan'208";a="100375998"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 08:02:27 -0700
X-CSE-ConnectionGUID: ea4WNSSER6qZbu8943+I8Q==
X-CSE-MsgGUID: jf7sor4cRYOVPdPUsnE7ZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,191,1770624000"; 
   d="scan'208";a="227731230"
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
Subject: [PATCH v4 2/2] ACPI: APEI: EINJ: Fix EINJV2 memory error injection
Date: Tue, 21 Apr 2026 08:02:16 -0700
Message-ID: <20260421150216.11666-3-tony.luck@intel.com>
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

Error types in EINJV2 use different bit positions for each flavor of
injection from legacy EINJ.

Two issues:

1) The address sanity checks in einj_error_inject() were skipped for EINJV2
   injections. Noted by sashiko[1]
2) __einj_error_trigger() failed to drop the entry of the target
   physical address from the list of resources that need to be
   requested.

Add a helper function that checks if an injection is to memory and use it
to solve each of these issues.

Note that the old test in __einj_error_trigger() checked that param2 was
not zero. This isn't needed because the sanity checks in einj_error_inject()
reject memory injections with param2 == 0.

Fixes: b47610296d17 ("ACPI: APEI: EINJ: Enable EINJv2 error injections")
#Reported-by: sashiko <sashiko@sashiko.dev>
Reported-by: Herman Li <herman.li@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Tested-by: "Lai, Yi1" <yi1.lai@intel.com>
Link: https://sashiko.dev/#/patchset/20260415163620.12957-1-tony.luck%40intel.com # [1]
---
 drivers/acpi/apei/einj-core.c | 45 +++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
index a9248af078f6..1f3fa2278584 100644
--- a/drivers/acpi/apei/einj-core.c
+++ b/drivers/acpi/apei/einj-core.c
@@ -401,8 +401,18 @@ static struct acpi_generic_address *einj_get_trigger_parameter_region(
 
 	return NULL;
 }
+
+static bool is_memory_injection(u32 type, u32 flags)
+{
+	if (flags & SETWA_FLAGS_EINJV2)
+		return !!(type & ACPI_EINJV2_MEMORY);
+	if (type & ACPI5_VENDOR_BIT)
+		return !!(vendor_flags & SETWA_FLAGS_MEM);
+	return !!(type & MEM_ERROR_MASK) || !!(flags & SETWA_FLAGS_MEM);
+}
+
 /* Execute instructions in trigger error action table */
-static int __einj_error_trigger(u64 trigger_paddr, u32 type,
+static int __einj_error_trigger(u64 trigger_paddr, u32 type, u32 flags,
 				u64 param1, u64 param2)
 {
 	struct acpi_einj_trigger trigger_tab;
@@ -480,7 +490,7 @@ static int __einj_error_trigger(u64 trigger_paddr, u32 type,
 	 * This will cause resource conflict with regular memory.  So
 	 * remove it from trigger table resources.
 	 */
-	if ((param_extension || acpi5) && (type & MEM_ERROR_MASK) && param2) {
+	if ((param_extension || acpi5) && is_memory_injection(type, flags)) {
 		struct apei_resources addr_resources;
 
 		apei_resources_init(&addr_resources);
@@ -660,7 +670,7 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 		return rc;
 	trigger_paddr = apei_exec_ctx_get_output(&ctx);
 	if (notrigger == 0) {
-		rc = __einj_error_trigger(trigger_paddr, type, param1, param2);
+		rc = __einj_error_trigger(trigger_paddr, type, flags, param1, param2);
 		if (rc)
 			return rc;
 	}
@@ -718,35 +728,30 @@ int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2, u64 param3,
 		      SETWA_FLAGS_PCIE_SBDF | SETWA_FLAGS_EINJV2)))
 		return -EINVAL;
 
+	/*
+	 * Injections targeting a CXL 1.0/1.1 port have to be injected
+	 * via the einj_cxl_rch_error_inject() path as that does the proper
+	 * validation of the given RCRB base (MMIO) address.
+	 */
+	if (einj_is_cxl_error_type(type) && (flags & SETWA_FLAGS_MEM))
+		return -EINVAL;
+
 	/* check if type is a valid EINJv2 error type */
 	if (is_v2) {
 		if (!(type & available_error_type_v2))
 			return -EINVAL;
 	}
-	/*
-	 * We need extra sanity checks for memory errors.
-	 * Other types leap directly to injection.
-	 */
 
 	/* ensure param1/param2 existed */
 	if (!(param_extension || acpi5))
 		goto inject;
 
-	/* ensure injection is memory related */
-	if (type & ACPI5_VENDOR_BIT) {
-		if (vendor_flags != SETWA_FLAGS_MEM)
-			goto inject;
-	} else if (!(type & MEM_ERROR_MASK) && !(flags & SETWA_FLAGS_MEM)) {
-		goto inject;
-	}
-
 	/*
-	 * Injections targeting a CXL 1.0/1.1 port have to be injected
-	 * via the einj_cxl_rch_error_inject() path as that does the proper
-	 * validation of the given RCRB base (MMIO) address.
+	 * We need extra sanity checks for memory errors.
+	 * Other types leap directly to injection.
 	 */
-	if (einj_is_cxl_error_type(type) && (flags & SETWA_FLAGS_MEM))
-		return -EINVAL;
+	if (!is_memory_injection(type, flags))
+		goto inject;
 
 	/*
 	 * Disallow crazy address masks that give BIOS leeway to pick
-- 
2.53.0

