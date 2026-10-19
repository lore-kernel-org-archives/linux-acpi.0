Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792442378;
	b=kqYFHng2needH340spP6PZ+qLLqyjKiJmaoLXQ0zikId2wHfaeeudIb36mopdRsVUcTW
	 ORpsXbg2nUJkRdT7jPU/7wHnwi2ox8pBvBEsyXrDjGY/KRAk5G0vGOHbKuWNMZ81jbooS
	 40hflf6pO4LtbH7RghYs+GHXRbV3IwT04t38OqJUU9u/wTpnSbrKyoJzwQ6xh0CTbddv/
	 erNTgjkwY5geSsVOZVTx/LrQPnTR3ZWLPsl0f0jA2ZSarAlMIKIQu0245ApZG3G5KX3/F
	 HJ3XH5eUXSUjV83huYB3jZck4MFB0G6EhNP1uJrFcCAoaKJe1pOGV5l/XLj8L5WfbTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792442378;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=dEqidMqVnNOPmAhLaz7/Q54+QdvOrd+PmDWJ3ZZfzbM=;
	b=pkeSnsMQ3me48Hsk6QYxZGKGLJLg4Um+s37kQIVCsw4VuYtzmyfBlY2FPG5BMNeU9tm9
	 amt/hOjeB/aX8n/aL/DM0djJbLvTVD1Ffqda3U6evmtEQlDRYhJ/4Qkr763GWvIhXQiVD
	 5YnOvr462KIpb/Eep0q5Hte7CYU2dz45GWUosXKcOUjVDLDdt/OFb/tNhQN//s7qVOAu2
	 hzJsOksPYn+k6glCqQ8su9/CP2MK0uDDyyyv78mEUOTjXQtUksSE/yxA/TOVwF0z2ioII
	 +eRvvFQU9rkB9GCKRRuu6lc79JpE2NJ69ygObn/eXSnju1VQu8r9EjPNzs995JKVoNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=E9sNRxkh;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3669A606A321;
	Mon, 19 Oct 2026 20:39:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3669A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=E9sNRxkh
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A89822BE;
	Mon, 19 Oct 2026 13:39:33 -0700 (PDT)
Received: from e135073.arm.com (unknown [10.57.53.5])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D89FF3F871;
	Mon, 19 Oct 2026 13:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1792442376; bh=zW9v/aiBHsyWLVxs/RtRkE1p3cxHFr8DE3w7iZI1eVo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E9sNRxkhAMjVRRgNPBREQcOnAADOos3B4TyFUFzDN8hEP017QJq3Nbsr894z4nGn9
	 7rGl+WsaELOK1X25PBXPWO7O1WMAqDOP1fyk43pAURXZFwHyHBWMLEOMGxeYUGDv53
	 jn9oHHJvIBeqbs01AQ0NHPP/qRIoXVgHOF1CJHY4=
From: Pierre Gondois <pierre.gondois@arm.com>
To: linux-kernel@vger.kernel.org
Cc: James Morse <james.morse@arm.com>,
	Mark Brown <broonie@kernel.org>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
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
	Breno Leitao <leitao@debian.org>,
	Dan Williams <djbw@kernel.org>,
	Terry Bowman <terry.bowman@amd.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Morduan Zang <zhangdandan@uniontech.com>,
	linux-acpi@vger.kernel.org,
	linux-edac@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH v2 1/6] cper: use BIT_ULL() for processor and memory validation bits
Date: Mon, 19 Oct 2026 22:38:40 +0200
Message-ID: <20261019203915.2019037-2-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019203915.2019037-1-pierre.gondois@arm.com>
References: <20261019203915.2019037-1-pierre.gondois@arm.com>
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

