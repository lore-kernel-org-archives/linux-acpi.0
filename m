Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792421839;
	b=zXoN743aLFFGGyt5bJozwWBTZxb6d3ERV8IUs/+c7DL8wPIGBpnFbN2xBv1O1M9PYUy8
	 dlnZ9vXIq+r7bOFB+0uBnJw9RjqjxosP3SQhahXvHDftv4RPSTC4xkuwFmT3hXqAm9hft
	 wNXlPzJ85vsedLxx1pSsp+jRfTMZcmRDoiammBQSoCwtjeUKo5DL6cJvGnsk/2WiXrqn9
	 G6T7GPU4xMiXUsof7L+jl9iDhYMFXcECm8payn4mert2Nh7pDd5E/j3m2V2R8zU4pa0Cs
	 LMs37u0g6zNU9iplo3JkwjbKmOvL9Zl7ouP3PWhIxjXgRG/9A5lVy9tLU5FTtsKhPXQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792421839;
	h=Received:Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6DDtc8wxeAEpu3Wak1LH1tQfaUG3U8hnHc+H8USyYXI=;
	b=t0Iivuf2SvmqALW7ZuOrGmMMHuiXSuCOW8Y5dOFfSMCHppuJtww5ApvAMHDvhYNL9UPO
	 yY0r2z7DaxRGIexULvaGOQWaIceuPUqvt5TSxISVH/SBhUctmFNStWUl6NSjvr1Ni+sx2
	 dncil3B37P/92RlILmbn2FEPbL6VLAWQSxdcH3j5q1hrAjEJRi175gHRRDeaiBzeI6k/9
	 JCz59wQj6+ypiAln8rcxJhm+UPVumM+9bhc13KCknL7r/eiPQJ+cTK0cpv8FyjXgXUYrd
	 RMmYzmho9lKxfToV1Ge+AoPCsoJ9BVpS/W9+Wk/EYNsFlQ5ssTP5hp+WvnF8OGx6pPA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=W9ykK07A;
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
Received: from aws-us-west-2-korg-listserv-1.web.codeaurora.org (ip-10-30-226-211.us-west-2.compute.internal [10.30.226.211])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BAE5607409F;
	Mon, 19 Oct 2026 14:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=W9ykK07A
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDE63451CE;
	Mon, 19 Oct 2026 14:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792421839; cv=none; b=J43D5SCL4PcKtzB+aU0QOsLf7hcP3QEQonmRvZTZ+uxZaWh4Ot/ChApIse1z+To1UhbrIDes1L9qHUgpRWk8aX5zRcQOkm/WUEoHivDW5FpXdQr13JcdCgPLG4P9XNHeSZSmyGWbzzt59W+NxJA+t1Keu7+BArkb84SewoWdc9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792421839; c=relaxed/simple;
	bh=Y7YY6ziWSYZSPQgVFJy9NrWn7wr6WuIgSOPuIixICKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JvwzZf4Wn6R+Hhx0BKbn+qJOptblsLGV3MrE28XQ7lj/mEkO250qdd1g5EjtvdWrVSW2wDD22jnJpTt9+h+fhtn5br4eaYO71LUvDoA3sKwl1+TzF0k85xSfGUw3WA1ElkANc8VFPmMAQ60kNyzBQypj0puZH44kiiKtLTqlwA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=W9ykK07A; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 026C71682;
	Mon, 19 Oct 2026 07:57:13 -0700 (PDT)
Received: from e135073.nice.Arm.com (e135073.arm.com [10.34.111.131])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 052303F673;
	Mon, 19 Oct 2026 07:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1792421836; bh=Y7YY6ziWSYZSPQgVFJy9NrWn7wr6WuIgSOPuIixICKk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W9ykK07AXvBgqmSa7qlWvIGFSXodw5eoPAdWVuDzlq1eL/lmqD1wfesX0i6A5tx7p
	 Xsi+aevSFqOKeqI9qBBpsUW1oPyvlWHR5LKRpoab6eqhoc099jHENKIt8sZlUjGC7A
	 ZlOiUgPPoxoaDQIuJJ5yeleka988sU0niOUw/ZJA=
From: Pierre Gondois <pierre.gondois@arm.com>
To: linux-kernel@vger.kernel.org
Cc: James Morse <james.morse@arm.com>,
	Mark Brown <broonie@kernel.org>,
	Pierre Gondois <pierre.gondois@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Hanjun Guo <guohanjun@huawei.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
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
Subject: [PATCH 2/6] cper: add Memory Error Section 2 structures
Date: Mon, 19 Oct 2026 16:56:09 +0200
Message-ID: <20261019145643.1877246-3-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019145643.1877246-1-pierre.gondois@arm.com>
References: <20261019145643.1877246-1-pierre.gondois@arm.com>
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

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 include/linux/cper.h | 54 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/include/linux/cper.h b/include/linux/cper.h
index 440b35e459e5..76e82a8d29a2 100644
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
 #define CPER_MEM_VALID_BANK_ADDRESS		0x100000
 #define CPER_MEM_VALID_CHIP_ID			0x200000
 
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

