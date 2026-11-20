Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795195260;
	b=WAMkp4u5U23Ju91h02lIhQbhTb6BrtfTLFu3mKhv/y2CEF08SjpGO1JRLWnI6fwGKXOY
	 M7iOJ+YzhNxYYbit1jIpYr3rlwhNEQ005am9lil21pYRU6FK469WhTD1FzQFhV6a7q6K1
	 q+UQKJLGarRL4HFxYkvSqYQMVb48b5qOaVzlD4aSk1h708xmhMYnodKos79xJx0TlkQ6H
	 QxEQ13K/tWuOv7n4AKd+ctmjrrRrSivev6zTD8tg7eFunFyTZuTUwwp12SqwYCspx7dVS
	 ZvfoNaVdbB+Fl9QA8J7bFY8yvSVRAqIypSMQyQCSf2Hzw9XCvXWYxfO76ZLRNNGfjAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795195260;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Li6ejt52DHk4KXg9bwK5xxn38o2Tm7LoLls+Q4JFXg8=;
	b=G+yCKBF+mQQwetU3sksA63WJzfC1xQHR1Jl+SNFZbO9ePVMNhBCuaP5Q51tOft+8TlI8
	 09bV02IPqEefLJcVt/Kmxm3uD+KXDoa32IS7H/JuGEVFGwbE7S4l7JTi7CcDiwovC6l72
	 YyAu0ldshBkAZTzSgcQiU1X2x08yt/26PDwLcqNoyweZUE4tLl8xgnsu+t7dj+rxqdseY
	 EQ/F3KRj6X6L2XMvbvjPGKw+LZkcnSkNWta3rgbBJpE+Fnex8aH8oLYNrGPeIUMFGWpT9
	 i0BTFep+fPYixMKMlvl8BHzriDf3gn5ba2PNLH0rxl4EGbd4Yga0fe8bfEToaXMLO4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EshNI8rH;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD83960A6F59;
	Fri, 20 Nov 2026 17:20:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD83960A6F59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EshNI8rH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795195258; x=1826731258;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=064zhbaCaerXAwaZVU+U8P0Hatp2QA1nT6IjIrq/wJ0=;
  b=EshNI8rHdrX43/SFtxpFA+iH3F87n8+urb3vIm3tXNg22VlKNHNcR7gC
   is46FFObKaUJpVv3YEgnYpieJHqpRuW4FlbJ+mbvDT9xYndgXrew6GTn5
   I2MmT+D//vOoM4+i+pLUKj7ODXafzNll5P6YJuu7yOKWLR9CZ1YQiuoo0
   0XiGfrBUxjhvfMjxUHe6Jy6Es+aaXAnsWJg7PnbJY2yNv6C3zlVxQSvmM
   OOpWyCi0/5Dd0wFK1BFhfSD1af6BSgBzJi9x2iU129iN4zVC/IdOb879r
   dj39PQD1+zdSGe0rpU8+vjPjC5udwAFyhMDBS9VU88Xw5paKllQIwO/JL
   w==;
X-CSE-ConnectionGUID: Iu2gpL3FRhOZiXTmFG/2yg==
X-CSE-MsgGUID: qHfT/X6LQMmNLvjWOoHmfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4157408"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4157408"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:20:57 -0800
X-CSE-ConnectionGUID: 2SYBeeCAS82SEPQ2P7VIFA==
X-CSE-MsgGUID: y/vAQ7HJQYicLGmFuy8ccA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="10868015"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.245.215])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:20:55 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Len Brown <lenb@kernel.org>
Cc: Dot Slash <jyjuykuytweg@gmail.com>,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 17/42] ACPICA: executer: Fix NULL pointer dereference in AcpiExStoreObjectToIndex()
Date: Fri, 20 Nov 2026 18:18:38 +0100
Message-ID: <ba9799356cbdc872dc0436a0ff03567637bca801.1795194329.git.maciej.wieczor-retman@intel.com>
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

Fix a possible NULL pointer dereference when trying to store an empty
buffer into an indexed string or buffer. Source-buffers are only
allocated if the Length is non-zero.

Similarly to AcpiExConvertToInteger() reject empty buffers with an
error.

Link: https://github.com/acpica/acpica/commit/077d74a42549
Reported-by: Dot Slash <jyjuykuytweg@gmail.com>
Closes: https://github.com/open-acpica/acpica/issues/1193
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
 drivers/acpi/acpica/exstore.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/exstore.c b/drivers/acpi/acpica/exstore.c
index 86be6bce1648..cd60fc366b08 100644
--- a/drivers/acpi/acpica/exstore.c
+++ b/drivers/acpi/acpica/exstore.c
@@ -295,13 +295,29 @@ acpi_ex_store_object_to_index(union acpi_operand_object *source_desc,
 			break;
 
 		case ACPI_TYPE_BUFFER:
-		case ACPI_TYPE_STRING:
 
-			/* Note: Takes advantage of common string/buffer fields */
+			/*
+			 * A zero-length buffer has no first element and a NULL
+			 * Pointer (see acpi_ut_create_buffer_object). Reject it, as is
+			 * done for the buffer-to-integer conversion.
+			 */
+			if (!source_desc->buffer.length) {
+				ACPI_BIOS_EXCEPTION((
+					AE_INFO, AE_AML_BUFFER_LIMIT,
+					"Source is a zero-length buffer, no data to store"));
+				return_ACPI_STATUS(AE_AML_BUFFER_LIMIT);
+			}
 
 			value = source_desc->buffer.pointer[0];
 			break;
 
+		case ACPI_TYPE_STRING:
+
+			/* A String always has a pointer; a null string stores a zero */
+
+			value = (u8)source_desc->string.pointer[0];
+			break;
+
 		default:
 
 			/* All other types are invalid */
-- 
2.56.0

