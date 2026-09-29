Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28007282F0C;
	Tue, 29 Sep 2026 07:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790668077; cv=none; b=bzgrwH45UnaSBBJ3lDB+hA9MErnuLlmM04ABAi5J3EySqiwRGppUlygOr7UwVAPpgXvWj5wE3vP0mdC9NuDX+Ij14ZJOMViSJfUzkYvspBHjjDFDSGOh1rLBP4AnRo1Hg17+FvljamFonwfbdIyy3MqRuBHqAtRmXQwh+DXt8B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790668077; c=relaxed/simple;
	bh=R7fWRgbHF/X1CbGxX0zY/n0lChhaSe2lXpFDKyPvOIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JpQD17ywaIb4XaUgyJcVHbn8IE8a7byhRUJHEqG7fkcJ8Nf8oQzX7MoaeUZh19omL5MnLXpl06f44up4SMaPVaPwQ2l+GtUy5OmkhQ05eA+QSBQOtCnUHDJ/DSAiB4KFlTYeD4ubHENRUyJL8NYiRkXzdtmpUlqbbBOup9bTinw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=VLQazKZA; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="VLQazKZA"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E9A6152B;
	Tue, 29 Sep 2026 00:47:52 -0700 (PDT)
Received: from e135073.nice.arm.com (e135073.arm.com [10.34.125.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 56F0A3F85F;
	Tue, 29 Sep 2026 00:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790668075; bh=R7fWRgbHF/X1CbGxX0zY/n0lChhaSe2lXpFDKyPvOIA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VLQazKZAsRZ3PCaFrUOLou46wyESeIsFOTlEgD+BzXjnOq/HicL8By5H/9T3G8iES
	 RTJJkk/8xyMN7jV7hzd1BOpcLgMz08ks6BFCRH+1DCQIoDVDlByOqKwG7tXYILWMxV
	 4AWIzUKIZm8CnPWS5+T8/fMcGWgf49VPGm7/eJzk=
From: Pierre Gondois <pierre.gondois@arm.com>
To: linux-kernel@vger.kernel.org
Cc: James Morse <james.morse@arm.com>,
	Mark Brown <broonie@kernel.org>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Avadhut Naik <avadhut.naik@amd.com>,
	Kees Cook <kees@kernel.org>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Dave Jiang <dave.jiang@intel.com>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Breno Leitao <leitao@debian.org>,
	Terry Bowman <terry.bowman@amd.com>,
	Dan Williams <djbw@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Morduan Zang <zhangdandan@uniontech.com>,
	linux-acpi@vger.kernel.org,
	linux-edac@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [RFC PATCH 2/6] cper: add Memory Error Section 2 structures
Date: Tue, 29 Sep 2026 09:46:01 +0200
Message-ID: <20260929074659.2587216-3-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929074659.2587216-1-pierre.gondois@arm.com>
References: <20260929074659.2587216-1-pierre.gondois@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add CPER Memory Error Section 2 definitions to the CPER headers.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 include/linux/cper.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/include/linux/cper.h b/include/linux/cper.h
index 440b35e459e53..170bb15f616d0 100644
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
@@ -506,6 +510,32 @@ struct cper_sec_mem_err {
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
