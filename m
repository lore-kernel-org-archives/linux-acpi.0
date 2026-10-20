Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792505498;
	b=AUAx7iygltHjH4a1yRIXw3BX8p4qvcr4OGrh+MarmWgnzwehYpkrLMJdkRYoMcNQzmHo
	 sebGD1gtCrjzcPalUdOsO3KS1e28ykbGm+BftKPDujVTwjkS1yXoExMERELCRxz+6g+yh
	 FdXuqnTb0izRoCqAwHyke2kYPY3+GgdXjuGpXQbBo7nu0ar6OfMD+5vpOSBXM5AOj6FpA
	 OBXrXe8eHPia/OZMnIcJr45dtJc/6KOi5gW5xgjcef9tjTNHbB87vxPswcKSoKxGjT/85
	 m3b5tmSuaF+ZMoBDSDDcr9hVxaho2U+rrTEo7z5CzGd1rMKhTNwKT18oikThAQSUoqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792505498;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2o2m+o+QoYiHQOvx02YB8LT94wFovuJ9AhOYOYQcOxs=;
	b=MgNSdvK3USdLlhFGOEt/Gb6BSVJFU3OjYutg4VF2m4fduzKV+Bo7Dsnd8gt7w4qR3oWa
	 5UlAikbrW5B+SOoSbI6SI1qyhmLUVT3U97oAm8g+xSQvMV+0/ytt7XUPVCxJyf7w5D/U/
	 /8vBOfdllHXrVMKsCrSWZZ/Je362dREAwVR396tSA5QAJVuuuqSLd9nRfvSpD6h4NeeUQ
	 piodLRraIMNQ4UiC1NAxDJK4tjklnInhDamo0c2BIMAfq2avshrG1KBQGOLEs4nwy2UtH
	 VPVlSSKVVzt29dgCDZmBefS98Q/wF/mdZqNPA+kV5t+lDqLdHYDVqUve+uv9QcfCSiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=D7BG80DZ;
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B293160A261F;
	Tue, 20 Oct 2026 14:11:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B293160A261F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=D7BG80DZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792505493; x=1824041493;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7vG0oy/P0/o0HyJZBq5uK2PIYGBdm4e9eDQccYzQjL8=;
  b=D7BG80DZIBjxKLCP2zJ6qzFyjYikd07sDQyXV03I8LcIiKbfE1S6666a
   MbXLO2ejU2M9w7eVxXg6XiiddZ4zoSfa8fTXEFBPvTKmF1VWjGseekP7W
   r4xa7dAUQcDMSDFSe2bk4fJLy3N/QQN0TP4IM7paDMDFFlJ28XiefTPsY
   mlUlI/R+VTc1PkujFlJLw2s5sR7aCj+MWQ0LS5Ec8DOwPO/39w3jI1fEP
   U+u7kfJCtLk3aBa7cDB/rYL4fGZWBjyOeMRratgSpCxy5V1ynsatRC0uH
   t1p1mKirpiVUyfT/ZzJq9V6C1ixFiBnhgNdw9o+uBRH7/5bJLYS9aZrrE
   A==;
X-CSE-ConnectionGUID: zKMc+3KkSyGy8bWGy6TesQ==
X-CSE-MsgGUID: 87DMfq1GRjay6NIqt4y67w==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1222241"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1222241"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 07:11:33 -0700
X-CSE-ConnectionGUID: XrHIuR/NRLOWKFBz7Qh/sg==
X-CSE-MsgGUID: Zsumzlr+QkSh/jNXaMGxzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2887950"
Received: from igk-lkp-server01.igk.intel.com ([10.211.93.152])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 07:11:31 -0700
From: Pawel Chmielewski <pawel.chmielewski@intel.com>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	ikaros <void0red@gmail.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>
Subject: [PATCH v1 12/30] ACPICA: executer: Add bounds checking for PCC field write access
Date: Tue, 20 Oct 2026 16:10:33 +0200
Message-Id: <20261020141051.2194123-13-pawel.chmielewski@intel.com>
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

Add validation in AcpiExWriteDataToField to ensure that PCC field
writes do not exceed the bounds of the InternalPccBuffer. Check for
a NULL buffer pointer and verify that BaseByteOffset + field byte
length does not exceed Region.Length.

Link: https://github.com/acpica/acpica/commit/1cba59bce8e0
Closes: https://github.com/open-acpica/acpica/issues/1175
Signed-off-by: ikaros <void0red@gmail.com>
Signed-off-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
---
 drivers/acpi/acpica/exfield.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/acpi/acpica/exfield.c b/drivers/acpi/acpica/exfield.c
index b9da19ffcd3e..937da115c375 100644
--- a/drivers/acpi/acpica/exfield.c
+++ b/drivers/acpi/acpica/exfield.c
@@ -346,10 +346,28 @@ acpi_ex_write_data_to_field(union acpi_operand_object *source_desc,
 		 * implementation will use the offsets specified rather than the name
 		 * of the field. This is considered safer because some firmware tools
 		 * are known to obfiscate named objects.
+		 *
+		 * Ensure the field access does not exceed the bounds of the
+		 * internal_pcc_buffer.
 		 */
 		data_length =
 		    (acpi_size)ACPI_ROUND_BITS_UP_TO_BYTES(obj_desc->field.
 							   bit_length);
+
+		if (!obj_desc->field.region_obj->field.internal_pcc_buffer) {
+			return_ACPI_STATUS(AE_AML_NO_OPERAND);
+		}
+
+		if (obj_desc->field.base_byte_offset + data_length >
+		    obj_desc->field.region_obj->region.length) {
+			ACPI_ERROR((
+				AE_INFO,
+				"PCC field at offset %u length %u exceeds region size %u",
+				obj_desc->field.base_byte_offset, data_length,
+				obj_desc->field.region_obj->region.length));
+			return_ACPI_STATUS(AE_AML_BUFFER_LIMIT);
+		}
+
 		memcpy(obj_desc->field.region_obj->field.internal_pcc_buffer +
 		       obj_desc->field.base_byte_offset,
 		       source_desc->buffer.pointer, data_length);
-- 
2.50.1

