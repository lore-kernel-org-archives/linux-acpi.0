Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795195255;
	b=ZUQQ4OTglCtWQQIVVuqaNDuHYe2Z/kbZ1Z1ht1t5X2o2TVH+PcEAA6EFIr0MoSg4w03e
	 xJnNR+qJ4Kc6k9Rj88ygziVR6B9BYYOqA21SBbgCd0LegNRMw7vTiSGb82bqYysmxTw1M
	 jmheHdnJYqwVi8gWjLdwMmcwEpTyShq/VhzNH8HXxmx/1G8wc2yhSSwwvD/7aKHy2rE2I
	 ycFXqGGTJ0udNanD1FsGwxlrwdR5emjyFJIljHwW5IHlnQytK2gLBJqTFg+E9nH7XRk8p
	 Na1c8Lv1XrY3fGnC6Dzf1Ew4vu03KOuRMuqccRraq4L5ryhcVa0lgbN5WAXp0fMRfbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795195255;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=r/5RkRn1Z3L2Dwca4BiPjvIqgMtGcuRZM1pDWqyLQdg=;
	b=tDbEAJwMFSHF5e35u9+/ZT/4cRCLDUpqloJDrbu1R8kodzemKSE6E3jBitElgSg/p62F
	 RuJgS2UDoD3rljnmP1VU4Iy57Lgquec4FLI3xCN5OA97mjecm5tqaVi6z73prB+kCBLB5
	 sZ0w+DelGpSAMiWfX4TALv2qRDo7sK7e5gAb6f9h3TJBbogadiVx2uzV/e+M4tL+HspNH
	 macKsblZcUF2Wk3icr4MK6PkTamcp6UaN5TWtzq4zbBo7UKtEW/3DxDTWlII0JeChIXET
	 /jRcwwVPAJn2fegEy3zlxWEuqVlPL0rZvm+IGz04uGxC+ZHF9+mQN3WDE1vpMLuN9cA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MugT1Ifd;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944AC60A2628;
	Fri, 20 Nov 2026 17:20:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 944AC60A2628
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MugT1Ifd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795195252; x=1826731252;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tqk4JJs8vRu7ms0BoH0oS14UkD7CYOH+5R3RPcE5fLE=;
  b=MugT1IfdRa9QgOjRA6WDNBuoW1NOhLuv8b73iXg9FyiLew9LItUILHwC
   DOn+x5Dx9M8T5mcEjCTzjbMl1aNt499R57c5swHaBFLxLiwPfwsRAwkyG
   4z34xiXCqQfCHKVgES3fV10K8QR76VRZDl2gTIkxm9qjdeSsTn4U77JMo
   8rlfm5qKTpT14Ss5GSjDR73fiRHD5ZDIywX/WDIe2pbgDWeciaS4YoMGy
   fzJEdpR5Bvly6wbHNCkEC/JHaTfx3ks5/uFS2e3DEFfN5EFBh7j7V87f6
   KkTA6Rf67vq6ahr8pZsCfOdu1ivy/3Pmoqe842eL6j8UxDvNCGr5p06yI
   Q==;
X-CSE-ConnectionGUID: 0F6LkVomSHOYeXQHW9BlAQ==
X-CSE-MsgGUID: zVAVDSmLRAKR9pBvELo5Qg==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4157393"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4157393"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:20:52 -0800
X-CSE-ConnectionGUID: l8/YC00OSN2oBFp9A7UOFA==
X-CSE-MsgGUID: 1SLFENSkSNa+wPVDijJLSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="10867993"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.245.215])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:20:49 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Len Brown <lenb@kernel.org>
Cc: purofle <yuguo.or@isrc.iscas.ac.cn>,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 15/42] ACPICA: fix: build error with gcc 16: unused-but-set-variable
Date: Fri, 20 Nov 2026 18:18:36 +0100
Message-ID: <cfbb1329ac34adbe6e18d5dd68b42eb8f58c096a.1795194329.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1795194329.git.maciej.wieczor-retman@intel.com>
References: <cover.1795194329.git.maciej.wieczor-retman@intel.com>
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: purofle <yuguo.or@isrc.iscas.ac.cn>

Since GCC 16, -Wunused-but-set-* warning options have been extended to
have multiple levels controlling what kinds of uses disable the warnings
for variables which are otherwise unused. Older versions of GCC only
implemented what has become -Wunused-but-set-variable=1 or
-Wunused-but-set-parameter=1, while the new default for
-Wunused-but-set-variable or -Wunused-but-set-parameter is =3 (the new
defaults are also used when these warnings are enabled by -Wall or
-Wextra, respectively). =2 ignores pre/post inc/decrements on the
variable, =3 also ignores compound assignments if the LHS variable is
not also used on the RHS.

Use ACPI_UNUSED_VAR on the NumCarats variable. This variable causes the
unused warning because its use is only compiled if ACPI_DEBUG_OUTPUT is
defined.

Link: https://github.com/acpica/acpica/commit/24aa4f85589b
Signed-off-by: purofle <yuguo.or@isrc.iscas.ac.cn>
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
 drivers/acpi/acpica/nsaccess.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/nsaccess.c b/drivers/acpi/acpica/nsaccess.c
index a0c1a665dfc1..1e7945ccff84 100644
--- a/drivers/acpi/acpica/nsaccess.c
+++ b/drivers/acpi/acpica/nsaccess.c
@@ -292,7 +292,7 @@ acpi_ns_lookup(union acpi_generic_state *scope_info,
 	struct acpi_namespace_node *current_node = NULL;
 	struct acpi_namespace_node *this_node = NULL;
 	u32 num_segments;
-	u32 num_carats;
+	u32 ACPI_UNUSED_VAR num_carats;
 	acpi_name simple_name;
 	acpi_object_type type_to_check_for;
 	acpi_object_type this_search_type;
-- 
2.56.0

