Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793790283;
	b=JTkCZnkzsYeCNPpX08dZp3Fw4vuXdXABUIzpCm0+8hsoktqql+K2wU95pwkbhXFjGv0V
	 zFqX3lVrGk9MPBtl9eBxHqD2YyZws2GOS40mxnWaJoYz0ME/6q+qbmQrO4CxvTyoA5Kha
	 d8170uBOGAAWXlS3hDrSx6W1RSJHW2t5LeGffdv/yTcWb78JC8Igcz/6s4z1PnmHNAbZQ
	 0jJF+s+UUDqH2cStxLxdFSAyMA7oK7YIzHFlXviReN/hYVuzcb5G01k1U6BEsQhkwk0kd
	 47/QN2fJDDRSI0n735Hlw4L/oVrCRxU6dnqfnRyClfaqPzLW6M8DNLdwv/an+QfuAgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793790283;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=lMf8e4nkDMYSVYGvtvN74k9+RxU8tnF0FV8aM7fGeSI=;
	b=Tft2Uy/zj4d9yKwVcN9qypoyU+ZzQEWoIFtGlOI/0PlAbLx3HTmhCVNbPC+X+LGOcPze
	 /rNiRHl842YXmiXn/mtKPJZX6Y/HHFkm3OqA2vyYltkcmZR6X4VzjaPu8QN6fXw9qiM1Z
	 wuMPYPVILzCOHTDDyyKAuQj+J9uxF4rjD0EKLXToJLk5I30e+iroS/rC6zBgq/qowPMN7
	 3LqaeI5ibGRngxLtZ8HDHLV/VlSSuMdxMyFv0x2z93PxfyBhgqk1SAm6ppUcTFNWZsGbW
	 Pn1Jn69a1kWB7bZGDwFtLQHAf09eE6LiVrL/byCrKkNZkkpBtnAAl4H9liDJPPcY1yg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=LH0wKGiY;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF036606A31B;
	Wed,  4 Nov 2026 11:04:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF036606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=LH0wKGiY
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F5891476;
	Wed,  4 Nov 2026 03:04:39 -0800 (PST)
Received: from e135073.arm.com (unknown [10.57.64.194])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7A5933F632;
	Wed,  4 Nov 2026 03:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793790282; bh=NXZU1xHRJos2+kj5C7mbZ3HoqRfBoS9k5eiVFwWjD+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LH0wKGiYTFKCiAOUMrCcbg1vPKY0YXVu4n5zE3AyyLTjpZaureTQ13EAYXlhbgW0+
	 udvnPzzhIQvgASNE0fWbtzOj/IoNhGOzVWopFtWfRNVuVLOtEZF2FLwkn0UOeTvYZT
	 OLkSyBYHsItg8UDkC2VIKWE/Nmrxisl444zdhL0E=
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
Subject: [PATCH v3 2/7] cper: add Memory Error Section 2 structures
Date: Wed,  4 Nov 2026 12:03:10 +0100
Message-ID: <20261104110355.1437249-3-pierre.gondois@arm.com>
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

Add CPER Memory Error Section 2 definitions to the CPER headers.

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Reviewed-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 include/linux/cper.h | 54 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/include/linux/cper.h b/include/linux/cper.h
index 81cda9874b25..ed355b240685 100644
--- a/include/linux/cper.h
+++ b/include/linux/cper.h
@@ -198,6 +198,10 @@ enum {
 #define CPER_SEC_PLATFORM_MEM						\
 	GUID_INIT(0xA5BC1114, 0x6F64, 0x4EDE, 0xB8, 0x63, 0x3E, 0x83,	\
 		  0xED, 0x7C, 0x83, 0xB1)
+/* Platform Memory 2 */
+#define CPER_SEC_PLATFORM_MEM2						\
+	GUID_INIT(0x61EC04FC, 0x48E6, 0xD813, 0x25, 0xC9, 0x8D, 0xAA,	\
+		  0x44, 0x75, 0x0B, 0x12)
 #define CPER_SEC_PCIE							\
 	GUID_INIT(0xD995E954, 0xBBC1, 0x430F, 0xAD, 0x91, 0xB4, 0x4D,	\
 		  0xCB, 0x3C, 0x6F, 0x35)
@@ -262,6 +266,30 @@ enum {
 #define CPER_MEM_VALID_BANK_ADDRESS		BIT_ULL(20)
 #define CPER_MEM_VALID_CHIP_ID			BIT_ULL(21)
 
+/* Memory Error Section 2 validation bits, UEFI v2.11 sec N.2.6. */
+#define CPER_MEM2_VALID_ERROR_STATUS		BIT_ULL(0)
+#define CPER_MEM2_VALID_PA			BIT_ULL(1)
+#define CPER_MEM2_VALID_PA_MASK			BIT_ULL(2)
+#define CPER_MEM2_VALID_NODE			BIT_ULL(3)
+#define CPER_MEM2_VALID_CARD			BIT_ULL(4)
+#define CPER_MEM2_VALID_MODULE			BIT_ULL(5)
+#define CPER_MEM2_VALID_BANK			BIT_ULL(6)
+#define CPER_MEM2_VALID_DEVICE			BIT_ULL(7)
+#define CPER_MEM2_VALID_ROW			BIT_ULL(8)
+#define CPER_MEM2_VALID_COLUMN			BIT_ULL(9)
+#define CPER_MEM2_VALID_RANK_NUMBER		BIT_ULL(10)
+#define CPER_MEM2_VALID_BIT_POSITION		BIT_ULL(11)
+#define CPER_MEM2_VALID_CHIP_ID			BIT_ULL(12)
+#define CPER_MEM2_VALID_ERROR_TYPE		BIT_ULL(13)
+#define CPER_MEM2_VALID_STATUS			BIT_ULL(14)
+#define CPER_MEM2_VALID_REQUESTOR_ID		BIT_ULL(15)
+#define CPER_MEM2_VALID_RESPONDER_ID		BIT_ULL(16)
+#define CPER_MEM2_VALID_TARGET_ID		BIT_ULL(17)
+#define CPER_MEM2_VALID_CARD_HANDLE		BIT_ULL(18)
+#define CPER_MEM2_VALID_MODULE_HANDLE		BIT_ULL(19)
+#define CPER_MEM2_VALID_BANK_GROUP		BIT_ULL(20)
+#define CPER_MEM2_VALID_BANK_ADDRESS		BIT_ULL(21)
+
 #define CPER_MEM_EXT_ROW_MASK			0x3
 #define CPER_MEM_EXT_ROW_SHIFT			16
 
@@ -506,6 +534,32 @@ struct cper_sec_mem_err {
 	u16	mem_dev_handle;		/* "module handle" in UEFI 2.4 */
 };
 
+/* Memory Error Section 2, UEFI v2.11 sec N.2.6 */
+struct cper_sec_mem_err2 {
+	u64	validation_bits;
+	u64	error_status;
+	u64	physical_addr;
+	u64	physical_addr_mask;
+	u16	node;
+	u16	card;
+	u16	module;
+	u16	bank;
+	u32	device;
+	u32	row;
+	u32	column;
+	u32	rank;
+	u32	bit_pos;
+	u8	chip_id;
+	u8	error_type;
+	u8	status;
+	u8	reserved;
+	u64	requestor_id;
+	u64	responder_id;
+	u64	target_id;
+	u32	mem_array_handle;	/* "card handle" */
+	u32	mem_dev_handle;		/* "module handle" */
+};
+
 struct cper_mem_err_compact {
 	u64	validation_bits;
 	u16	node;
-- 
2.43.0

