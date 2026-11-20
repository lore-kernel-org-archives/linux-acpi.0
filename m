Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795195251;
	b=uj0yEewWKfxiObOCzZID7c3g8JY5R+JsVi6LbvOcgo1jlr+5BowZ1TP1sHgPaPcnOUkv
	 gZr7QGvJnPYyux3cpSzIU4LZkx1kGmkIWzg3ujQ+MtagvkTdJzFJBuNC5SkgS83RBTwMc
	 flxWbUh7FyzWesOCkEfyGXAyz6hf1E6SzSEges6vcd0My4UadAcC05ReDy6H2h0V2D4Yi
	 GGPqxQyc+TpQF1iWSYuEY1EHIm9kbm1LLyqn0Z9tIqs5JV9vc8sePZiD+bXn5H2MOKJY2
	 HE4KbL/rlx25R1QXOLoF99hJLU7Y5q2bs0/Qt62Uc3NcOUzw2t2ruNcVj1jiirdcu3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795195251;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=oPl6Fm7k6C0w0fOYmre6kId3JLuNwQWiJIvWNgvEQuQ=;
	b=ytNB6iRpeGMRbN+9Jcr6mrjD6r7/tevEoeHy30gQdAw4eNTCkQCoJQnohaSEneBsUSoL
	 q5Nr/fZjDoqNLmk7oljvQ0APduU/JvYNVsUU76vceBZOi4Jncjl1ferF6nz6AzJ2SGB9t
	 JO5mubDm088WdPTuL2j7pAmsPFlLIUcsVtixts3cedrScDjfXwWwv+O4A7CYFElpA1Cn5
	 uePExEBBGLRemL17FvKdDZBqwV32APBdUY6RMAc4E7xnECUqMj4EJvsqvSMLU92l3WKGe
	 EPiS9jw2ZNMFXTqtv8ckbI3FPbto0M3MWPi40BpU5vsHG8HFgMi1HzYeX2A0+vOGKOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fUrux4ve;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CDA60A3813;
	Fri, 20 Nov 2026 17:20:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0CDA60A3813
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fUrux4ve
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795195246; x=1826731246;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jjzuCUGTPS9NeooTCYIT0kb2dtW5hLkhmusAkgysMUk=;
  b=fUrux4veDv2V3Y9bkqj/FnSYSL/V7lWxYEbUSr/30AWnqRPFHj2YwzP7
   7hQz1QFouItaWVDCUGkcwDekOPp5Run5EyXK5IOkeeE+J+4xF12/hJbB/
   fMQurVr3w3Go0nOaQ7eJWYGVhh3LCfCFM+7auwtUipyLYNWm40bXhzK9h
   jYZEptMqsiSAQULwjkI0pmItw/3mXM8H47ubnugSUIwQHbM2BRsWEMdoW
   Bj41lcE8oYj8GAJeuP67FEbHGkjO1n2eje368R6kNas2Oa5afcv8LtGfF
   FMF1e02SAC06OT1V94ffhVLxFIwhZHEnPk3vI6s5XAcek15hjohNSu+VB
   A==;
X-CSE-ConnectionGUID: /WqiIdMMSMeHuzOU7JKPQA==
X-CSE-MsgGUID: GbFskiPASVu+oEzpLR7NrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4157368"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4157368"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:20:46 -0800
X-CSE-ConnectionGUID: Xu7fnT3vQz+CiKSOqkdLpw==
X-CSE-MsgGUID: fqqPAZU4RF6SoVn+DfFp4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="10867973"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.245.215])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:20:43 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Len Brown <lenb@kernel.org>
Cc: ikaros <void0red@gmail.com>,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 13/42] ACPICA: Fix object reference update to skip non-local notify types
Date: Fri, 20 Nov 2026 18:18:34 +0100
Message-ID: <acd59dc3f22a2bcb19980f5919d070583c4e9251.1795194329.git.maciej.wieczor-retman@intel.com>
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

From: ikaros <void0red@gmail.com>

Link: https://github.com/acpica/acpica/commit/53d7ddc850a8
Closes: https://github.com/open-acpica/acpica/issues/1181
Signed-off-by: ikaros <void0red@gmail.com>
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
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
2.56.0

