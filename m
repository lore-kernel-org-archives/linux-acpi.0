Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795195250;
	b=c5FKe3FYKaVy0tEIoz8maGY06LpdFLgS0pJy6B7dxjy8l6/JP3CRVCDNjcCCpXTw8O9V
	 JEzekJhscLpmz2CHQTVF8EeEtOSC/dhX3FWDD3FJKAIWKce92nd5rRf2ZbNWrFZETVxle
	 z2Qcus2NieYOfuPDVbPRt/1fnM14QTqf8skMb0qs6M6cqt8+YrZoTbK+B1Erc1iPcEnUd
	 DpsjDn6fMpFVk25YxEUCCuJy62k/0FA05+3EkAjNnH3gTETxB9uJxLh2kJOYhXkG+mcLM
	 07N42mlkhro3di/ngSLFNlFBXDlkaJiXjrwbsICex4MrNbUXrb4uTCH0s6pzaTuaQVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795195250;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hoN3rI/JfJuBtrS0uHg+y9yoQPNvBwwbOz2yJNWNU3Y=;
	b=tNazvqBmC0vs8RLxJS6yAhb20CpvA/vL7jZmdK1SuxfzhzDdnxfG+5nuxIB8q33tjnEE
	 UQeGm7ADpB0/UeUGye1OwjSh1twPDkNPh3qfJadb3dq+cUWrrPIt1yFTGHVRc5+yfPdRc
	 jRIYcFdWoyng67v8SSlhLHXt3s9QS42DLVAVRkg+DEnkQwbN8ZYPd1G/xBe44cPZ0J4rz
	 1QjqBjJGVaa9hY0ZR936kjOYiNOrZ4acAni35P6gSCkwYScdpy/ByRfPVrjrekMvuEn0O
	 /rKEHN0tJnUPvObxiWbGIJaok7sFT8LTx+/OnkGryVzEEJ8021Z/943Xx5emeWnd8ZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OMw6ttz7;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0244660A5BEB;
	Fri, 20 Nov 2026 17:20:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0244660A5BEB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OMw6ttz7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795195244; x=1826731244;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KcRvU4aEbI5RkWfVjR8G+k29robNQYANT/HWoJSAbTs=;
  b=OMw6ttz7oXgfSC1rN/GAx+geXgTFAk3BI3BP2znY5vpJW3G9Ysk07q6R
   PGG7jmLCoOOfnumdrpNoeYoNQe/qr+aaXF4wQKSA9yS7OyD1ND6xERi2f
   dQjMI7CAUCoTBjTKR9/NMaMMHrdN/efenAkuYo5qWChNI7kEQY5wKNwqX
   brOisP3fiz95ys7uHuwWafegb5dV3Zuv8OUSg1ObnyZA8l2qib2tJczdH
   6qgs8iha57Dp+D5zV09zQPJBOHb9pucsnqpAxZB/9QAoLDXx3RL3f6ekt
   e4B2n14mUUskBi1BPNop1daEQQ9lEbYhPDFjRNv8o0AzXdKIL/6GE4xnO
   Q==;
X-CSE-ConnectionGUID: /86a6OT5TK+jdJT1IJy4dA==
X-CSE-MsgGUID: YRYPO6q/T5OEHO4nifpf3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4157357"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4157357"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:20:43 -0800
X-CSE-ConnectionGUID: FtoTMcaMRTW9/42vQ5BhaQ==
X-CSE-MsgGUID: wQ19FXYJQ+yY4Kwnnqu7mA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="10867967"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.245.215])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:20:40 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Len Brown <lenb@kernel.org>
Cc: ikaros <void0red@gmail.com>,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 12/42] ACPICA: tables: Fix heap-buffer-overflow in AcpiTbFindTable
Date: Fri, 20 Nov 2026 18:18:33 +0100
Message-ID: <890d6f3dee8413a1fd05d287a0a165e65459be90.1795194329.git.maciej.wieczor-retman@intel.com>
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

The OEM ID and OEM Table ID string operands passed to AcpiTbFindTable
can be shorter than ACPI_OEM_ID_SIZE (6) and ACPI_OEM_TABLE_ID_SIZE (8).
The unconditional memcpy reads past the string allocation when the input
is too short. Validate string length before memcpy and copy only what
is available, relying on the prior memset to zero-pad the remainder.

Link: https://github.com/acpica/acpica/commit/dfb5b18ef458
Closes: https://github.com/open-acpica/acpica/issues/1179
Signed-off-by: ikaros <void0red@gmail.com>
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
 drivers/acpi/acpica/tbfind.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/tbfind.c b/drivers/acpi/acpica/tbfind.c
index 60a772c87f42..f36a9b34058f 100644
--- a/drivers/acpi/acpica/tbfind.c
+++ b/drivers/acpi/acpica/tbfind.c
@@ -57,8 +57,20 @@ acpi_tb_find_table(char *signature,
 
 	memset(&header, 0, sizeof(struct acpi_table_header));
 	ACPI_COPY_NAMESEG(header.signature, signature);
-	memcpy(header.oem_id, oem_id, ACPI_OEM_ID_SIZE);
-	memcpy(header.oem_table_id, oem_table_id, ACPI_OEM_TABLE_ID_SIZE);
+	if (strlen(oem_id) >= ACPI_OEM_ID_SIZE) {
+		memcpy(header.oem_id, oem_id, ACPI_OEM_ID_SIZE);
+	} else {
+		memcpy(header.oem_id, oem_id, strlen(oem_id));
+		/* Remainder is already zeroed by memset above */
+	}
+
+	if (strlen(oem_table_id) >= ACPI_OEM_TABLE_ID_SIZE) {
+		memcpy(header.oem_table_id, oem_table_id,
+		       ACPI_OEM_TABLE_ID_SIZE);
+	} else {
+		memcpy(header.oem_table_id, oem_table_id, strlen(oem_table_id));
+		/* Remainder is already zeroed by memset above */
+	}
 
 	/* Search for the table */
 
-- 
2.56.0

