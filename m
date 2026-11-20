Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795195233;
	b=DuwCgTCLdZ00QYLHXVpFV9UUZi5/qiJT8Y06gda8LVJSQvM5bdSX5h7it4ueB4+Yh9cz
	 3SfbCz2o/mHSurZgJ7OI6WotxLb78JhOieN3wkhKs+aCdLq8uWE0meH+J6mbXo0M4dNxb
	 Rlt5CaSzQQh2YscbzQwZNQiO8wzu92iVc8VxaCvjHLoBG2e8rLzhqfoO8PYg1Kof02Jbl
	 AerfhttPam1LxDVHxvJkw4DmNisd1Lntt2H1gjJLBabvOwTuZBpH0FuYqiJD8GzOXg9g1
	 TLJiMdIfGjPJdx1HB8Il6ylfnIJTaPwxHUFSBmhLxz1oiEJVSpF0VqiMled2DQXcLbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795195233;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vVr/dw32tBHePOh++2E7M4gRpSikVd+IKkh/FF/6SSM=;
	b=0mTEyai9f/6EFR//lsaEveUzbuHe+Sny4YSLl+35WkaAeEZ5m2qh26bdTfgP3PiZBmso
	 0qfFEYM02luOsm1G1MXwMHe6rfs3N1dhH1C0jSr9Urwf6yIFwt25Rlr2k/8ZQlBBIeB3m
	 M1VCnOJgF4dLCosZ98wUAgy/EyaMT5X1quvndavKQ5TGLZ5fnAVSUfTpYwUooOHU+Y+yo
	 KRtQ64Z8EneZAzZvII3cXYS87VuSUe8mkcxcfU8RNJX5kFqhc1wDaVFL9nlev06GGUPtT
	 f8CorFkGccBFKfCAy7ddN2QJwoe/XJ4y4drJxnoIWAUOouChKmPwHtuAeZ5syj2be2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZOONvQ8m;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AFC60A382D;
	Fri, 20 Nov 2026 17:20:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9AFC60A382D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZOONvQ8m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795195233; x=1826731233;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kejDiBptKITyb5a1IL9Qqc363efzUSjcEycVsyaxk60=;
  b=ZOONvQ8mBZM393DReER78xULHhpUY3GO3JXCNZzjY4vkS9XCiqO6n8c5
   KBtPZKI85ZOiFsCB8ZKS3YMTArMYlsHp/HSUsh4kAHkLpmIftBy6dnGtf
   MwdFcHPS9jIlqAHuUg1jqn23w8X5djEBrqT93zfsf+MEhW6oKKRX5hDb2
   EeFwCWdjt8XuqMVM0m1kuOyD33r32vlOVNQpRM0hSC080A0D19TbhOC2c
   2rEgBpUjcFd4iyx713dGXcCgWDj3fkdb28hC0dwqtmD2eNN/rg94shhzl
   KPtUrNtCrDckcp8XKDEZLR/Majau/uDveZvoJUAGHeOeolXwrEYHwZpOz
   g==;
X-CSE-ConnectionGUID: VUeKfg5oT3uOuEVS+7WfzA==
X-CSE-MsgGUID: JjGwiM0/QlGDac3VUcknPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4157325"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4157325"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:20:32 -0800
X-CSE-ConnectionGUID: ZFo8NJPCS6SULwnNiXCjow==
X-CSE-MsgGUID: HTIUXT2yTgmX936viOBDbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="10867916"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.245.215])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:20:29 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Len Brown <lenb@kernel.org>
Cc: ikaros <void0red@gmail.com>,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/42] ACPICA: executer: Add bounds checking for PCC field read access
Date: Fri, 20 Nov 2026 18:18:29 +0100
Message-ID: <abf60c5de07dfe3b6736a4a635c36321c36e2724.1795194329.git.maciej.wieczor-retman@intel.com>
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

Add validation in AcpiExReadDataFromField to ensure that PCC field
reads do not exceed the bounds of the InternalPccBuffer. Check for
a NULL buffer pointer and verify that BaseByteOffset + field byte
length does not exceed Region.Length.

Link: https://github.com/acpica/acpica/commit/661d2310fd25
Closes: https://github.com/open-acpica/acpica/issues/1165
Signed-off-by: ikaros <void0red@gmail.com>
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
 drivers/acpi/acpica/exfield.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/exfield.c b/drivers/acpi/acpica/exfield.c
index 50317fe0cbd5..6e86759162df 100644
--- a/drivers/acpi/acpica/exfield.c
+++ b/drivers/acpi/acpica/exfield.c
@@ -209,12 +209,32 @@ acpi_ex_read_data_from_field(struct acpi_walk_state *walk_state,
 		ACPI_DEBUG_PRINT((ACPI_DB_BFIELD,
 				  "PCC FieldRead bits %u\n",
 				  obj_desc->field.bit_length));
+		/*
+		 * Ensure the field access does not exceed the bounds of the
+		 * internal_pcc_buffer. The buffer is allocated with the region length,
+		 * so verify that base_byte_offset + field byte length <= Region.Length.
+		 */
+		if (!obj_desc->field.region_obj->field.internal_pcc_buffer) {
+			status = AE_AML_NO_OPERAND;
+			goto exit;
+		}
 
+		buffer_length = (acpi_size)ACPI_ROUND_BITS_UP_TO_BYTES(
+			obj_desc->field.bit_length);
+		if (obj_desc->field.base_byte_offset + buffer_length >
+		    obj_desc->field.region_obj->region.length) {
+			ACPI_ERROR((
+				AE_INFO,
+				"PCC field at offset %u length %u exceeds region size %u",
+				obj_desc->field.base_byte_offset, buffer_length,
+				obj_desc->field.region_obj->region.length));
+			status = AE_AML_BUFFER_LIMIT;
+			goto exit;
+		}
 		memcpy(buffer,
 		       obj_desc->field.region_obj->field.internal_pcc_buffer +
 		       obj_desc->field.base_byte_offset,
-		       (acpi_size)ACPI_ROUND_BITS_UP_TO_BYTES(obj_desc->field.
-							      bit_length));
+		       buffer_length);
 
 		*ret_buffer_desc = buffer_desc;
 		return AE_OK;
-- 
2.56.0

