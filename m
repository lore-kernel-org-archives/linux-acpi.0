Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794576385;
	b=sXZb6wsa+mgwSV8wQSeVxeGFqLmtrzCcm1fhlPTANce5VHpxH3lOnoZY2IMgn7ELij1r
	 T/z79Wzdu6QC4ivPmuEutxkxx9g9NuBHdsCcabgqRP4p1opADFfSNpsRhwzULunihNdhi
	 Pj/vbTMt8UL4aZ0lNmp8qGRGEoBEtEfsfpeIdH+Jv0Fcl1lW0T9Sxrb3ACaqcCAuqbvQA
	 uohlA9R9TEbQu/zeBCTgAeXeQ4yarSGDHE+IAEWxjZW4wHYLwmb1eFoYhyW/U5KarJs5+
	 jsIKW/MRnq7rq1MpHV/0lmt/2bbX3mocsDs/Ivfzs3J18pAViRzL9A5Rnj5feb4JmNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794576385;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=d7wDSG/SXruxgnunNSoyJ4CR7wmnL3FLA/2npqOXGqA=;
	b=gX5vRXwEOgpZl3TcPAIHHuJkLOt5nzR7EDphwhh2U61QJC1wKOi2cfQCqEbiOoki5J/y
	 raHydB0oYaIunLNcS23R0HhF8mW6rPbK65s5AM6YEKpKGKZ2kQDv7jR9o7J5Wer8Ugwdj
	 PqgPY1JJAudFJVbkNwyMjGDU33W69kyssFTkEd3CvNAs7fZEzna8MQmB1YihKxWv8wpJz
	 Nty5jFUfntahGLYioA5YpCP1PIVsW/+5Sw1IvNZWFeUOUvUgyfHfgePlTqdJdxH9QDtxm
	 UdhbJe5+TBG9PrtQhuMRm5Nqs47+pGgmANSPs+JKhhNwYJY6ptRwv/UqfJh5MKIpD7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=DmHafwSu;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367F8606A89E;
	Fri, 13 Nov 2026 13:26:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 367F8606A89E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=DmHafwSu
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C0241476;
	Fri, 13 Nov 2026 05:26:21 -0800 (PST)
Received: from e135073.arm.com (unknown [10.57.14.137])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EEC6F3F85F;
	Fri, 13 Nov 2026 05:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794576384; bh=rsozKlYlSQiIOPqJqT+17nALnlTop4O1X8/hATg6xB4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DmHafwSuy4w94GTb9rvTvouqGUnrwIUWlwL4lj/fAqRhRvHsfEvUPWDnfH/S4ATg/
	 ReEhCKT41OrFINVIt/hVFqhCxbd48h5vUuKGtqQjNeMZZ7hPum36U+t/gMbkoPpZvq
	 m0xnHLV1+O73ZTJdpC/rvxLgDnn9ye0kgVHa8usw=
From: Pierre Gondois <pierre.gondois@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Ashok Raj <ashok.raj@oss.qualcomm.com>,
	James Morse <james.morse@arm.com>,
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
	Terry Bowman <terry.bowman@amd.com>,
	Dan Williams <djbw@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Morduan Zang <zhangdandan@uniontech.com>,
	linux-acpi@vger.kernel.org,
	linux-edac@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH v4 01/12] cper: use BIT_ULL() for processor and memory validation bits
Date: Fri, 13 Nov 2026 14:24:43 +0100
Message-ID: <20261113132600.3355836-2-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261113132600.3355836-1-pierre.gondois@arm.com>
References: <20261113132600.3355836-1-pierre.gondois@arm.com>
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
 include/linux/cper.h | 73 ++++++++++++++++++++++----------------------
 1 file changed, 37 insertions(+), 36 deletions(-)

diff --git a/include/linux/cper.h b/include/linux/cper.h
index 440b35e459e5..f532a8a01411 100644
--- a/include/linux/cper.h
+++ b/include/linux/cper.h
@@ -9,6 +9,7 @@
 #ifndef LINUX_CPER_H
 #define LINUX_CPER_H
 
+#include <linux/bits.h>
 #include <linux/uuid.h>
 #include <linux/trace_seq.h>
 
@@ -225,42 +226,42 @@ enum {
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

