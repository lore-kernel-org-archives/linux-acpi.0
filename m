Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795195242;
	b=BjsUBMfLZSJBjjZs86yYHwZc+9iFN0DBsu8Mmvb5Qz+ihk90v2RSVUhDN1ScmjSgxpZr
	 caGL8HFUEhMTYHjNymbf1Is55pqgsX0GqGLwxbebeMvg77BS/LnIIPaxJXL/ys0nRpuw8
	 C30rEFX4rEhnTktj03nKTiwqwPUmGngnOL3fupWQe2iIkTG79xlC6wn58IDOWnrq2nung
	 oYmmuhovhai/yaSgeDIK3l1pUoQabpqb0qsOyqJ6IXFRTD8FeRpYm5aNgdNX4VW9K3wXf
	 uNc77CC1ncXQf78a6N9ijHw3kVClxoGRqyW6jIG/VmfJU7ZrM+ugPlYO+R+r8ZFhiEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795195242;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=fxVJmrU9ZBUXIPtHmB8DcRC6H8qadtEcDwa2Z4bykpY=;
	b=UfYO8DLAG3W3cMswCOsO2WnfJRIr6mEwQfhOn8suVoRWUW1QD7feMbbiPQlrKbWWKyw1
	 1pv7sRstN8FtqnN7V6+pgOiPiH6WvzP63ja9STlU+wfgdyFT1oy+zgGcbhstnCHU/KcGW
	 eslI3sXTXufu82bicTv4Si5/zMbbBiRWKvWOvVPVfPkfyLJBG4jTXKvYMNnL/Dih5SlMc
	 yjj9vyfxK56O6xH2wATEd8YWOt0XrIfe+awhKSnY0HHCP1qSfYOsJN7ew2jY9ZdmxQ2BC
	 +MWim2XlDpOem0S8r52uloZap5zqvisomdx6iCBtGrROKxC8n9VMFCXIOz/QxxopBVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bZKIa9DW;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC17160A3838;
	Fri, 20 Nov 2026 17:20:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC17160A3838
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bZKIa9DW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795195241; x=1826731241;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QZEggnyGKzBGzEvjAW3d4cpip03eUHBMMxsS2puPKms=;
  b=bZKIa9DWy4S2Q17s4eHM8Sbwla81u9ilc68I+VUNqI3a1q+5XLpnUndU
   gMlo0+oH567ZiV2NkTN+yQka+F6VG4jX6SKu7hzZbLZLscOZknn4A26uo
   OrPezbu6nxV4xRvNVdo5dRw6YOPQJBOZGpkDxzsrLp4cmKfaso2qDXUiC
   DQhSnKKSHCwKfr8pNpuEdg0/8UEACRt/wOgoeZdpmSYwqfDpcVyJ01TBJ
   iNLkw/z7IFUxi/u0Or4SLw8d8L0Hd/x7EfbPMzntG7fv6ikuDFAjGu/ZZ
   6014CGufz98tparpoYbBZl4AMbmnEEYHJEAPk99V0vLgpx+7FhorydWGd
   A==;
X-CSE-ConnectionGUID: MHhrUe5tTwCi/XQinA5Eug==
X-CSE-MsgGUID: 2J7EvLknTy+P6hIFxo/yzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4157350"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4157350"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:20:40 -0800
X-CSE-ConnectionGUID: cz0c2BFlTjWe0c3MQavm0w==
X-CSE-MsgGUID: oOD8R/GtSK6aMp8Tk7c4nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="10867956"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.245.215])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:20:38 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Len Brown <lenb@kernel.org>
Cc: ikaros <void0red@gmail.com>,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/42] ACPICA: executer: Add bounds checking for PCC field write access
Date: Fri, 20 Nov 2026 18:18:32 +0100
Message-ID: <75a5752bc41966592499a5e206b0ea919abf806c.1795194329.git.maciej.wieczor-retman@intel.com>
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

Add validation in AcpiExWriteDataToField to ensure that PCC field
writes do not exceed the bounds of the InternalPccBuffer. Check for
a NULL buffer pointer and verify that BaseByteOffset + field byte
length does not exceed Region.Length.

Link: https://github.com/acpica/acpica/commit/1cba59bce8e0
Closes: https://github.com/open-acpica/acpica/issues/1175
Signed-off-by: ikaros <void0red@gmail.com>
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
 drivers/acpi/acpica/exfield.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/acpi/acpica/exfield.c b/drivers/acpi/acpica/exfield.c
index 6e86759162df..632fc8693f23 100644
--- a/drivers/acpi/acpica/exfield.c
+++ b/drivers/acpi/acpica/exfield.c
@@ -347,10 +347,28 @@ acpi_ex_write_data_to_field(union acpi_operand_object *source_desc,
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
2.56.0

