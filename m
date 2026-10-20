Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792505489;
	b=lQylNRni6x3NImdjudY+xF7j9UQDcqQcIog8++TkoNL7WqMqjwm0MadQgGF32WDJSXiz
	 DJhSrHLG9aiu22b/l7eOS11Isn9FxShnwmS7zjmOTz5ayvqctJwxTTeEsRolZCYxakneK
	 ETq21B3Ltjh/otj/O9QPj4tgcSMhf/p47CdkquKENDpyYrP/Qr2CtnuY+NBzUWFOSM6mw
	 cRvoYaH7obo1e+O7czXvRlq5QhLbqEAGsDNpQGe9HTy5cintmylVqEscTXSSRBs5YYuKU
	 bMcaoz1Lk/EjZ3ljV7iCfSEMskifi5eGC/Ita+6LOjO9ogSPZZSEHqZ6SZl+MXmxH5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792505489;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2mi39Kh/zUL3dYeeFUMr/NRlE29bfSlKJepGdGKn8c0=;
	b=1KR/89T6rI/GyY7q5cfyiKf0tDDdOUpGmC4RCOywNnii1Bm/JwGx+csgbjTqyoQ5LdLO
	 yLUFmpioCi5a8zVf0bsqzD6miuEgpSFNvubIQSRCnaV9MvqqOPhUYq4tvkhI8nRIWFhcU
	 fdesoF/qIY+HF5yc5+AGc+by4QeRzTUn0FevS1wGY1dnZXjcncxulsQVTMILh747Z6bnN
	 w5E6dszVUI8bFTnSiNU+qmei9PvGQFB4xqQ14hq79F/r5cg125GDpkj2HCfwy5jksljN0
	 dLWCXQKhnTMsiiap+6ggtFard4Ou4UvwSnbY0BfGxuZzxjff59HNB5qPLHg/mHQPddw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="C+Cj7/yw";
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6099C60A2606;
	Tue, 20 Oct 2026 14:11:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6099C60A2606
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=C+Cj7/yw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792505489; x=1824041489;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=09UbdD5GxNOpADfe69mBw2PdVZsEicBrMmo69Z1OXlw=;
  b=C+Cj7/ywjb/Gs43nC1umXywOk9JVWPs1jXWHoL9fls0p0tx8gqtVIvCh
   xaQR0DWGQn3d28PO2eVRcHxX5lPMKSWibeD/yEkF/SOYSrcQF47mgaPuv
   J815gOOsW727Sd8th425FnZsyqMlFb8iSwKF7h6ZGPClJ+/QY6fGiM1CP
   OC7Kq13jG+VCFQxLjMWmenY5Yw8XWoToU8nElamtLU8VibcnleIYt7jGH
   h4peTXz7x48aTaQt+gR9ALAlCOy6SDWX2ULdGulAKpGKlSTkPImuA5d9w
   /9RvgRmE8CjM9KeHvN+AxmRRhsIWucCtVY1vw402wxFPjOxvxyNEToms8
   Q==;
X-CSE-ConnectionGUID: ozvsrPEMSoWGJqjCoNen/w==
X-CSE-MsgGUID: XhGnypPKSpuQdN5qoQZVmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1222226"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1222226"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 07:11:28 -0700
X-CSE-ConnectionGUID: wedKsGngS2KgwBTTwh+Q8g==
X-CSE-MsgGUID: /CIw+Ha6S5S56+FhDSIyvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2887938"
Received: from igk-lkp-server01.igk.intel.com ([10.211.93.152])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 07:11:26 -0700
From: Pawel Chmielewski <pawel.chmielewski@intel.com>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	ikaros <void0red@gmail.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>
Subject: [PATCH v1 09/30] ACPICA: executer: Add bounds checking for PCC field read access
Date: Tue, 20 Oct 2026 16:10:30 +0200
Message-Id: <20261020141051.2194123-10-pawel.chmielewski@intel.com>
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

Add validation in AcpiExReadDataFromField to ensure that PCC field
reads do not exceed the bounds of the InternalPccBuffer. Check for
a NULL buffer pointer and verify that BaseByteOffset + field byte
length does not exceed Region.Length.

Link: https://github.com/acpica/acpica/commit/661d2310fd25
Closes: https://github.com/open-acpica/acpica/issues/1165
Signed-off-by: ikaros <void0red@gmail.com>
Signed-off-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
---
 drivers/acpi/acpica/exfield.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/exfield.c b/drivers/acpi/acpica/exfield.c
index 9a55524ed8f4..b9da19ffcd3e 100644
--- a/drivers/acpi/acpica/exfield.c
+++ b/drivers/acpi/acpica/exfield.c
@@ -208,12 +208,32 @@ acpi_ex_read_data_from_field(struct acpi_walk_state *walk_state,
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
2.50.1

