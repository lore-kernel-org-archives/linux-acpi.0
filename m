Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793790273;
	b=aolJmUPL6Gq7rvGqe8QwU21ZGgDiA/9bHRMvfZTPUEa9UxtHcFYQJHV+LJLCePMi0oz7
	 0Od3z/C5RM40mafTYR2HOaNUzutTGR4swC03VuA6cDianL5kPnJjacLoOqudA1eQSEFbg
	 uzh4IKwbTMH8F+GTNcIukzaC0bK7zA9blI0cHPouRJm/zHSPna4r27RhXpKm6NYEqQmXa
	 UNJ3ywRCZQ6zQlJsV4cPPUuYQxsNlIIEdTd/wYXqS+0mlzVyT3C5qHJ9cPiIrKwvHMfRb
	 +fFGxu7mOrOzNFELdZ1Jk5Fzd+DOsy6mO8tOMZEBwgAvsde99OaKlHFF1jJOyGkLnxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793790273;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=tPfzTe/uykfEEWrdrHJnoC75amJ7o7EBnKJFliyYOEA=;
	b=L7nGoFy2YqFp9oVZGm1OYExkgfqRYu8IbDqwkgpNBv4RR+kdx7i/5nSYm/E6+0ffu7Cn
	 LYgYz39tt6pGLYDmlhSF+elfNPyAZNwGDOiLBTIKhlMn4DHysmljiMR0A50G+guySikcH
	 19wNCQ06hJhUjbuJ3F9DsK5jawD+6P6cKKbWDeT9eY63DyXELgBArKDSKT5cVDGH2rHH6
	 u2mYqNQkTCw2Yqcnj6sWgm2qRiV2CkBH+IYGI/ZiZRKoTujeAZ/1rX2avtBbtnVsBjZvv
	 8xohEmO/badysFdRgZi1UqkPMHSoTIsaoc2O8zJgTZ4FEgl7MILa+kIMMpZTea4H0DQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=C3Z0auJ0;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65053606A326;
	Wed,  4 Nov 2026 11:04:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65053606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=C3Z0auJ0
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A583D22EA;
	Wed,  4 Nov 2026 03:04:29 -0800 (PST)
Received: from e135073.arm.com (unknown [10.57.64.194])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CF8CE3F632;
	Wed,  4 Nov 2026 03:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793790272; bh=ZQLBqxVBqqzbYsgy4BWFGrsGfFMAsbGbkf3oPGznkRM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C3Z0auJ0rOFZYQ4nDFq9dt3RPMtqD0l1/Eh15ZvtHbxEXRNYAXTw6JC2yPw8UETB/
	 v/tDUEyk/1V/8lSZWb8dbgQf6U1uY3HS55C+A6H7K7oR7K9TArf245fErr+/g/oZ2K
	 nYax6/qFas0EYai91wJ0PKxKobKd6Dgi/wsQKMgc=
From: Pierre Gondois <pierre.gondois@arm.com>
To: linux-kernel@vger.kernel.org
Cc: James Morse <james.morse@arm.com>,
	Mark Brown <broonie@kernel.org>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Breno Leitao <leitao@debian.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Hanjun Guo <guohanjun@huawei.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Dan Williams <djbw@kernel.org>,
	Terry Bowman <terry.bowman@amd.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Morduan Zang <zhangdandan@uniontech.com>,
	linux-acpi@vger.kernel.org,
	linux-edac@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH v3 1/7] cper: use BIT_ULL() for processor and memory validation bits
Date: Wed,  4 Nov 2026 12:03:09 +0100
Message-ID: <20261104110355.1437249-2-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104110355.1437249-1-pierre.gondois@arm.com>
References: <20261104110355.1437249-1-pierre.gondois@arm.com>
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

Use the BIT_ULL() macro to describe flag bits instead of
hexadecimal values which are harder to read.

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Reviewed-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 include/linux/cper.h | 72 ++++++++++++++++++++++----------------------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/include/linux/cper.h b/include/linux/cper.h
index 440b35e459e5..81cda9874b25 100644
--- a/include/linux/cper.h
+++ b/include/linux/cper.h
@@ -225,42 +225,42 @@ enum {
 	GUID_INIT(0x036F84E1, 0x7F37, 0x428c, 0xA7, 0x9E, 0x57, 0x5F,	\
 		  0xDF, 0xAA, 0x84, 0xEC)
 
-#define CPER_PROC_VALID_TYPE			0x0001
-#define CPER_PROC_VALID_ISA			0x0002
-#define CPER_PROC_VALID_ERROR_TYPE		0x0004
-#define CPER_PROC_VALID_OPERATION		0x0008
-#define CPER_PROC_VALID_FLAGS			0x0010
-#define CPER_PROC_VALID_LEVEL			0x0020
-#define CPER_PROC_VALID_VERSION			0x0040
-#define CPER_PROC_VALID_BRAND_INFO		0x0080
-#define CPER_PROC_VALID_ID			0x0100
-#define CPER_PROC_VALID_TARGET_ADDRESS		0x0200
-#define CPER_PROC_VALID_REQUESTOR_ID		0x0400
-#define CPER_PROC_VALID_RESPONDER_ID		0x0800
-#define CPER_PROC_VALID_IP			0x1000
-
-#define CPER_MEM_VALID_ERROR_STATUS		0x0001
-#define CPER_MEM_VALID_PA			0x0002
-#define CPER_MEM_VALID_PA_MASK			0x0004
-#define CPER_MEM_VALID_NODE			0x0008
-#define CPER_MEM_VALID_CARD			0x0010
-#define CPER_MEM_VALID_MODULE			0x0020
-#define CPER_MEM_VALID_BANK			0x0040
-#define CPER_MEM_VALID_DEVICE			0x0080
-#define CPER_MEM_VALID_ROW			0x0100
-#define CPER_MEM_VALID_COLUMN			0x0200
-#define CPER_MEM_VALID_BIT_POSITION		0x0400
-#define CPER_MEM_VALID_REQUESTOR_ID		0x0800
-#define CPER_MEM_VALID_RESPONDER_ID		0x1000
-#define CPER_MEM_VALID_TARGET_ID		0x2000
-#define CPER_MEM_VALID_ERROR_TYPE		0x4000
-#define CPER_MEM_VALID_RANK_NUMBER		0x8000
-#define CPER_MEM_VALID_CARD_HANDLE		0x10000
-#define CPER_MEM_VALID_MODULE_HANDLE		0x20000
-#define CPER_MEM_VALID_ROW_EXT			0x40000
-#define CPER_MEM_VALID_BANK_GROUP		0x80000
-#define CPER_MEM_VALID_BANK_ADDRESS		0x100000
-#define CPER_MEM_VALID_CHIP_ID			0x200000
+#define CPER_PROC_VALID_TYPE			BIT_ULL(0)
+#define CPER_PROC_VALID_ISA			BIT_ULL(1)
+#define CPER_PROC_VALID_ERROR_TYPE		BIT_ULL(2)
+#define CPER_PROC_VALID_OPERATION		BIT_ULL(3)
+#define CPER_PROC_VALID_FLAGS			BIT_ULL(4)
+#define CPER_PROC_VALID_LEVEL			BIT_ULL(5)
+#define CPER_PROC_VALID_VERSION			BIT_ULL(6)
+#define CPER_PROC_VALID_BRAND_INFO		BIT_ULL(7)
+#define CPER_PROC_VALID_ID			BIT_ULL(8)
+#define CPER_PROC_VALID_TARGET_ADDRESS		BIT_ULL(9)
+#define CPER_PROC_VALID_REQUESTOR_ID		BIT_ULL(10)
+#define CPER_PROC_VALID_RESPONDER_ID		BIT_ULL(11)
+#define CPER_PROC_VALID_IP			BIT_ULL(12)
+
+#define CPER_MEM_VALID_ERROR_STATUS		BIT_ULL(0)
+#define CPER_MEM_VALID_PA			BIT_ULL(1)
+#define CPER_MEM_VALID_PA_MASK			BIT_ULL(2)
+#define CPER_MEM_VALID_NODE			BIT_ULL(3)
+#define CPER_MEM_VALID_CARD			BIT_ULL(4)
+#define CPER_MEM_VALID_MODULE			BIT_ULL(5)
+#define CPER_MEM_VALID_BANK			BIT_ULL(6)
+#define CPER_MEM_VALID_DEVICE			BIT_ULL(7)
+#define CPER_MEM_VALID_ROW			BIT_ULL(8)
+#define CPER_MEM_VALID_COLUMN			BIT_ULL(9)
+#define CPER_MEM_VALID_BIT_POSITION		BIT_ULL(10)
+#define CPER_MEM_VALID_REQUESTOR_ID		BIT_ULL(11)
+#define CPER_MEM_VALID_RESPONDER_ID		BIT_ULL(12)
+#define CPER_MEM_VALID_TARGET_ID		BIT_ULL(13)
+#define CPER_MEM_VALID_ERROR_TYPE		BIT_ULL(14)
+#define CPER_MEM_VALID_RANK_NUMBER		BIT_ULL(15)
+#define CPER_MEM_VALID_CARD_HANDLE		BIT_ULL(16)
+#define CPER_MEM_VALID_MODULE_HANDLE		BIT_ULL(17)
+#define CPER_MEM_VALID_ROW_EXT			BIT_ULL(18)
+#define CPER_MEM_VALID_BANK_GROUP		BIT_ULL(19)
+#define CPER_MEM_VALID_BANK_ADDRESS		BIT_ULL(20)
+#define CPER_MEM_VALID_CHIP_ID			BIT_ULL(21)
 
 #define CPER_MEM_EXT_ROW_MASK			0x3
 #define CPER_MEM_EXT_ROW_SHIFT			16
-- 
2.43.0

