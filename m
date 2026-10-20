Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792505503;
	b=N3UlsGdFKOfjMoXtETCpihLc86T5hbYm9BtYinQvs8RkggknwPObWGCANkPQkDD1Djf+
	 bxRiFa3bZ1Bvum13bVDIVrgNmuLK/hlQsymJoNj0UUOluxjmJ6+/cdhdAyH3mO1QUMIDi
	 EjGWejFqmpRGrlPu5gNuCWiOeaJsu7T925q9589ERT1aAVSX+2aBfBD1xrkDav3dafw3A
	 MZLBt7CAjZ6gei/Tp5NQj8wPHQac/bW1yvX2LLgxFpHk/U3s+ioln2N58/BX32x82olUq
	 EXVpag8RefDScDomio/12vKAOs/YYBTPqCx91cyvNHcUcn1FRdY+POIqOPso2w3VzmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792505503;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=c2B3Ioaf1ALNXrTm7tAgxCa+mnhuTNI3JwU0ozqyJlU=;
	b=Rzt9o7IGgUxFbejiO1wKytsmDbyn8kA388klsL6oqPNJ+0mb2m5N9/suL/fGqDbOLm8k
	 Glpy3flFVD1BVoO9gkpYfVg1msz1uVoaEsauJoDyzXBegsQdQLb9iUT/eZc31fEo5EUI4
	 9Zm/WBbXhmdb1sNcijkoDg4SCUg7yLywHS7fHjuWR3KPttL6Y/DAHl8sDbQ/ZWRlWuxMC
	 CH2/fCrrR91N3A+hH2/DbrRoKK35CFcfqTrTAArfVzPsXNhb1yUbp5qmSsb+SpM1rDoIx
	 CaL/ahRMCjJN150j99Kwa+yitjc1Z5IGmWKgEokp1cYKbJIcD9EQmXm0H2h6wr+rZiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iho9s5Y3;
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AE460A382B;
	Tue, 20 Oct 2026 14:11:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1AE460A382B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iho9s5Y3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792505503; x=1824041503;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4q1lOVfX43m0U/HN7B0W1qvGNjSHUml5CiR4WrDy52Y=;
  b=iho9s5Y3N+G2lmpHDsbNDvZrfhJ/MFHhAPRvmJmcQdOoUGM1DRsvUh8D
   /So9X3bi7BWLEuXWp0qO/vqEvd9xYDqEwd4SybVZgYqPCi+npdiIg0BHe
   LTTUqOioQyQmz5uKVYlnrFovNprE/vafV7L4/c97UwiZrYhlz1ydKPwH6
   AJ4jCScNLJkOV4FiUA6LszQpxDyYxPz+BCsrEO6xeBFecUHak/hJlhBGo
   mib2j19bbFlErIHOZTYyWiaC3osorGt4sFVgkcU6icV6sRex7+g5l5HKb
   0nzIZ+WRGJYM+3RFwdVil2EEbuQ01PDwIUqyqBpba1rhIR3CPb0J6fiXG
   g==;
X-CSE-ConnectionGUID: JdlBejQcT2Wrv8fikOXbZg==
X-CSE-MsgGUID: QhCuORD8SEqSRdkoi7dJaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1222264"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1222264"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 07:11:42 -0700
X-CSE-ConnectionGUID: b7mhsD3TTzGrejA2KX+rbw==
X-CSE-MsgGUID: KPJsc21AS2C2Ga/C1cazgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2887976"
Received: from igk-lkp-server01.igk.intel.com ([10.211.93.152])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 07:11:39 -0700
From: Pawel Chmielewski <pawel.chmielewski@intel.com>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	purofle <yuguo.or@isrc.iscas.ac.cn>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>
Subject: [PATCH v1 16/30] ACPICA: fix: build error with gcc 16: unused-but-set-variable
Date: Tue, 20 Oct 2026 16:10:37 +0200
Message-Id: <20261020141051.2194123-17-pawel.chmielewski@intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261020141051.2194123-1-pawel.chmielewski@intel.com>
References: <20261020141051.2194123-1-pawel.chmielewski@intel.com>
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
Signed-off-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
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
2.50.1

