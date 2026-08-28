Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4E4199920;
	Fri, 28 Aug 2026 08:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787906618; cv=none; b=EXSqaHOAHLLY/D+HklYa5rDvwGvlC7ccwcDga5aHDfdBW4MmpoaTglod3QK2WbUBj7nL/3Yd/9iafTe/SkL7R/CwIyyIzUY7sx7vceRT+asr+jPpElvtqZe+MnFtt3OEQ01QiQmX3Bi4e3ymLAwioGkhS9Xfp8qEZYYyQnsdkEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787906618; c=relaxed/simple;
	bh=Uo2ZgVEnAbtMNgsvIUN+2SLzdrXEZ/vYUmjQA8oYPag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M/qdYGEssWi8yRTgZZ05BbB325nrpElZ9nO1cOBy2o4TascpaN/H8M/KXKIPvyVo9EUJV8u4bh2kmvq9ARfKEFDfefY+EkxJkU2aEWxr7allMGx29Ksf6BaY3++lV1URQ5q5jAeqtCAX7BIlKisUvcNVUYWF6w5zGCf4qsQT5xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N99n9Duv; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N99n9Duv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787906615; x=1819442615;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Uo2ZgVEnAbtMNgsvIUN+2SLzdrXEZ/vYUmjQA8oYPag=;
  b=N99n9Duvlrz3WfLB9ofxP/FOWfK97n1JWPwl3Sf+pKRfghDGmE+LfX66
   o4SDG2ri+foUo2BXvckK/R/ru/ZRw125x09BcEMF9jZn8o9BnlNUKtpzc
   i3SrMbj/xHP7k+NioBOGv97gjwqThK81QVFtyOKH3QvYDvrZfVIsjPOBh
   m0sAvt1vtm3K5NBAXKb3pIrvSfB6zkKnCkKXLknYY+lqwNA5KArKC1sAr
   811Twp5HdGCr3qByp0IH2VbCZnFoTqr7ws2bIeWhM10FNgDYxGO1UtJMJ
   1+w1J6KV0K+VHVtdRB6hojDfExR5F6FJs38MtWi4FC0NDKp7BOd0BlZqn
   g==;
X-CSE-ConnectionGUID: 6BL0VbMxT1ex8e2/XlH2qg==
X-CSE-MsgGUID: BrfyQljyRhGtnLssXohDcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="75955878"
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; 
   d="scan'208";a="75955878"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2026 01:43:34 -0700
X-CSE-ConnectionGUID: un+ly7c5Sc+VEcbfPGKCyg==
X-CSE-MsgGUID: NQ0+AdvzQAiVWKANLYkH4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; 
   d="scan'208";a="261952409"
Received: from rvuia-mobl.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.92])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2026 01:43:33 -0700
Received: from punajuuri.localdomain (unknown [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id DB038121C42;
	Fri, 28 Aug 2026 11:43:28 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.98.2)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1wzsBM-0000000152t-3I6Z;
	Fri, 28 Aug 2026 11:43:28 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-media@vger.kernel.org
Cc: linux-acpi@vger.kernel.org,
	rafael@kernel.org
Subject: [PATCH 2/3] ACPI: Use PTR_IF() for ACPI_PTR()
Date: Fri, 28 Aug 2026 11:43:27 +0300
Message-ID: <20260828084328.257703-3-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260828084328.257703-1-sakari.ailus@linux.intel.com>
References: <20260828084328.257703-1-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make ACPI_PTR() use PTR_IF() so __maybe_unused can be dropped from what is
being referred to.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 include/linux/acpi.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 10d6c6c11bdf..347763282f36 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -755,7 +755,6 @@ int acpi_device_modalias(struct device *, char *, int);
 
 struct platform_device *acpi_create_platform_device(struct acpi_device *,
 						    const struct property_entry *);
-#define ACPI_PTR(_ptr)	(_ptr)
 
 static inline void acpi_device_set_enumerated(struct acpi_device *adev)
 {
@@ -1073,8 +1072,6 @@ static inline int acpi_dma_configure_id(struct device *dev,
 	return 0;
 }
 
-#define ACPI_PTR(_ptr)	(NULL)
-
 static inline void acpi_device_set_enumerated(struct acpi_device *adev)
 {
 }
@@ -1152,6 +1149,8 @@ static inline int acpi_mrrm_max_mem_region(void)
 
 #endif	/* !CONFIG_ACPI */
 
+#define ACPI_PTR(_ptr) PTR_IF(IS_BUILTIN(CONFIG_ACPI), _ptr)
+
 #ifdef CONFIG_ACPI_HMAT
 int hmat_get_extended_linear_cache_size(struct resource *backing_res, int nid,
 					resource_size_t *size);
-- 
2.47.3

