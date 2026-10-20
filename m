Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792505496;
	b=UXln4KYrSopHkM2i/kNv0AvX0euuPlO4SBosDSnCUOs7oUvk8fMxRvp1RwIbPsw+i3Y4
	 SRMzHswx8DfoD6w0Ae+0pfUmsvMrWvnsZCiFl/flFh+TfX16Vm2r4T53K1wiACh5FCfbW
	 6hJ+Dni2Acp2n4saVLBVR5vk5MnIDCLWLp/aRgYMmdlLboI3avq0eAdEVUWSpixK7GJS2
	 R1HKmw8cCjzYDL2tzY9yYLFqQzwvuktW9ZEKRiUnLjE5pwL8MlTZIGlJ/YdkoITvLiVWl
	 6bNuDn8k88RRTJbywrPT1dQw92UvkNFEwGzb5B4crrG3Omp1b/pwAvhaDSxOYd7eLJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792505496;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=yGL1R6EgVLITuVg4y11T13nnNnWXhe1BrzKDZACxpng=;
	b=sEpQDsZ2F1gWtYMs7jHE3NUpNoQL7gTPFd2SBO+kvnube1UD245Mb/QQ0WNq6780nF/f
	 BcN0nlFLtckgsLX5dMhEg7XM1JECO0cLMuoXj1Pzo/Lri84jgw1KyqNlI4jsdzDZ519tK
	 8nq5Kcu8LKWjBH7AKSRRzOu4sLdnDadh/dG9mtdVX5sINwqtamL103+0WUOr9cqIigpPK
	 4SmDl+KfscAuKcL/ojopr2YgmKTFQfSIZcVXW2Sxt8fpvtn+lFl9iKfOI472gkcHgqlzC
	 5LwEukgQRocGF5/aDzkPJY20Uco82SvidlVSauZBkSjaukGcsXntg4cFYtckoMaTFbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=F1Yev0G+;
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F75960A263E;
	Tue, 20 Oct 2026 14:11:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F75960A263E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=F1Yev0G+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792505497; x=1824041497;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hcFYrLal06KMyhsfbLfWCWUFgTl2ONKvXLvUvPtPHJA=;
  b=F1Yev0G+KPLbmEDyZihGeDgl74tQTKf6lUzI/piZ4rMiOY9TyF5wcIDt
   uVeXV4usXDEyX6ZYofkiqJCPsVvwbndzWHAWBLSLDSbZL6Yfd3mZSy8vB
   2i54/NAaZIlk+t+sX45NCLmvUO2Z2XquOVPLCJQCVNs25eqnHy+udI0pT
   MBKAfwwGeucBW9A8tXfCOLDeOip23t7mBV1mBdXOEZmcnoj2WXuHAn/cm
   vlanEfNtW01o0xQqYn2HEtWuZDMVHXdwd53UbmOtf5qXa1lifKZofrqgB
   p5IHQk1SQ0bWGdmk7/E+TfV+P7RpQxvrgeVhN144Hu5eudirNtD6zAw+Z
   Q==;
X-CSE-ConnectionGUID: Ig0sSTQzS2+qtTm/cckt7g==
X-CSE-MsgGUID: f0tgjkCMRMeeCyEYkhE1tg==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1222252"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1222252"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 07:11:36 -0700
X-CSE-ConnectionGUID: A8It73RqQrW8CG4oGEGetA==
X-CSE-MsgGUID: s/PEpdjfTy2zjVoDDiT38g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2887959"
Received: from igk-lkp-server01.igk.intel.com ([10.211.93.152])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 07:11:34 -0700
From: Pawel Chmielewski <pawel.chmielewski@intel.com>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	ikaros <void0red@gmail.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>
Subject: [PATCH v1 14/30] ACPICA: Fix object reference update to skip non-local notify types
Date: Tue, 20 Oct 2026 16:10:35 +0200
Message-Id: <20261020141051.2194123-15-pawel.chmielewski@intel.com>
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

From: ikaros <void0red@gmail.com>

Link: https://github.com/acpica/acpica/commit/53d7ddc850a8
Closes: https://github.com/open-acpica/acpica/issues/1181
Signed-off-by: ikaros <void0red@gmail.com>
Signed-off-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
---
 drivers/acpi/acpica/utdelete.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/acpi/acpica/utdelete.c b/drivers/acpi/acpica/utdelete.c
index e8180099d01f..57a0de6a49d6 100644
--- a/drivers/acpi/acpica/utdelete.c
+++ b/drivers/acpi/acpica/utdelete.c
@@ -517,6 +517,10 @@ acpi_ut_update_object_reference(union acpi_operand_object *object, u16 action)
 				prev_object =
 				    object->common_notify.notify_list[i];
 				while (prev_object) {
+					if (prev_object->common.type !=
+					    ACPI_TYPE_LOCAL_NOTIFY) {
+						break;
+					}
 					next_object =
 					    prev_object->notify.next[i];
 					acpi_ut_update_ref_count(prev_object,
-- 
2.50.1

