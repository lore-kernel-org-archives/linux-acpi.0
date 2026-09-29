Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B764F3ACA65;
	Tue, 29 Sep 2026 07:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790668090; cv=none; b=JXDzPtLRcXSrBlYFohgxd+VcaXiEkgDcom+06yAeggKbXBZ+cNiQXTfGJZh8KfCMfq0N7sQZae0wUCpkWuqOi5bsngd/lUxeYSZSVVrq0lSmmdpSPvQEhz2/zFZ4IGBKGGQvi9rt1Bn8rNsmcPt+Dh9CQH4wk8i/G0d0QrPoMZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790668090; c=relaxed/simple;
	bh=QhdoheglfZU1xEIJYQWDAG5Js026GvE/3h7aT0ahMoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CE8dAv/c9CClYUmHa7huZ/wzY2mQr8kr6Nx4L/A5ATSz27+SchnCeq4pOf7nRoU1h/E7hxoR5KQHBR5Fz0upN2FMguXysAamuHRnolg4s68z1H+bjanPRxRzEAsmnSKqJiIbtUOnKR7TlHJ2W07Urch5OaFxgHvldvjHxCFQGfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=kiAThnZ6; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="kiAThnZ6"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C62C51576;
	Tue, 29 Sep 2026 00:48:04 -0700 (PDT)
Received: from e135073.nice.arm.com (e135073.arm.com [10.34.125.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9D0843F85F;
	Tue, 29 Sep 2026 00:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790668088; bh=QhdoheglfZU1xEIJYQWDAG5Js026GvE/3h7aT0ahMoI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kiAThnZ6LK/u3ugl1Pzz7Hy7+DxJlRGOSU8O3haeLBCJcxH7/QKc+Y2dO7HU36xD+
	 3BG/duvPrW4UwP5lgOzJpSye8ur2VQBS0MoaY1lotg9JPGGqZRv0LGLReYrBnAoOO9
	 RYXSOV5uImvm1tlBwUCyDWW8zTr8h1NMVYkzpGvI=
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
Subject: [RFC PATCH 3/6] cper: extend cper_mem_err_compact struct
Date: Tue, 29 Sep 2026 09:46:02 +0200
Message-ID: <20260929074659.2587216-4-pierre.gondois@arm.com>
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

Extend cper_mem_err_compact struct to prepare for:
- additional support of Memory Error Section 2
- widening the usage of cper_mem_err_compact struct for both
  Memory Error Section 2 and Memory Error Section (1)

Remove the extended field which contains Memory Error Section (1)
additional bits that can now fit in the larger (u32) fields.
Add fields that were previously not populated (physical_addr, ...)
to prepare for using this cper_mem_err_compact struct for both
Memory Error sections.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/firmware/efi/cper.c | 21 ++++++++++++---------
 include/linux/cper.h        | 22 ++++++++++++++--------
 2 files changed, 26 insertions(+), 17 deletions(-)

diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index 06b4fdb59917a..6285b67e8fcd9 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -325,12 +325,8 @@ int cper_mem_err_location(struct cper_mem_err_compact *mem, char *msg)
 			       mem->bank & CPER_MEM_BANK_ADDRESS_MASK);
 	if (mem->validation_bits & CPER_MEM_VALID_DEVICE)
 		n += scnprintf(msg + n, len - n, "device:%d ", mem->device);
-	if (mem->validation_bits & (CPER_MEM_VALID_ROW | CPER_MEM_VALID_ROW_EXT)) {
-		u32 row = mem->row;
-
-		row |= cper_get_mem_extension(mem->validation_bits, mem->extended);
-		n += scnprintf(msg + n, len - n, "row:%d ", row);
-	}
+	if (mem->validation_bits & (CPER_MEM_VALID_ROW | CPER_MEM_VALID_ROW_EXT))
+		n += scnprintf(msg + n, len - n, "row:%d ", mem->row);
 	if (mem->validation_bits & CPER_MEM_VALID_COLUMN)
 		n += scnprintf(msg + n, len - n, "column:%d ", mem->column);
 	if (mem->validation_bits & CPER_MEM_VALID_BIT_POSITION)
@@ -347,7 +343,7 @@ int cper_mem_err_location(struct cper_mem_err_compact *mem, char *msg)
 			       mem->target_id);
 	if (mem->validation_bits & CPER_MEM_VALID_CHIP_ID)
 		n += scnprintf(msg + n, len - n, "chip_id:%d ",
-			       mem->extended >> CPER_MEM_CHIP_ID_SHIFT);
+			       mem->chip_id);

 	return n;
 }
@@ -362,7 +358,7 @@ int cper_dimm_err_location(struct cper_mem_err_compact *mem, char *msg)
 		return 0;

 	len = CPER_REC_LEN;
-	dmi_memdev_name(mem->mem_dev_handle, &bank, &device);
+	dmi_memdev_name((u16)mem->mem_dev_handle, &bank, &device);
 	if (bank && device)
 		n = snprintf(msg, len, "DIMM location: %s %s ", bank, device);
 	else
@@ -377,6 +373,7 @@ EXPORT_SYMBOL_GPL(cper_dimm_err_location);
 void cper_mem_err_pack(const struct cper_sec_mem_err *mem,
 		       struct cper_mem_err_compact *cmem)
 {
+	memset(cmem, 0, sizeof(*cmem));
 	cmem->validation_bits = mem->validation_bits;
 	cmem->node = mem->node;
 	cmem->card = mem->card;
@@ -384,15 +381,21 @@ void cper_mem_err_pack(const struct cper_sec_mem_err *mem,
 	cmem->bank = mem->bank;
 	cmem->device = mem->device;
 	cmem->row = mem->row;
+	cmem->row |= cper_get_mem_extension(mem->validation_bits, mem->extended);
 	cmem->column = mem->column;
 	cmem->bit_pos = mem->bit_pos;
 	cmem->requestor_id = mem->requestor_id;
 	cmem->responder_id = mem->responder_id;
 	cmem->target_id = mem->target_id;
-	cmem->extended = mem->extended;
 	cmem->rank = mem->rank;
 	cmem->mem_array_handle = mem->mem_array_handle;
 	cmem->mem_dev_handle = mem->mem_dev_handle;
+	cmem->error_status = mem->error_status;
+	cmem->physical_addr = mem->physical_addr;
+	cmem->physical_addr_mask = mem->physical_addr_mask;
+	cmem->error_type = mem->error_type;
+	if (mem->validation_bits & CPER_MEM_VALID_CHIP_ID)
+		cmem->chip_id = mem->extended >> CPER_MEM_CHIP_ID_SHIFT;
 }
 EXPORT_SYMBOL_GPL(cper_mem_err_pack);

diff --git a/include/linux/cper.h b/include/linux/cper.h
index 170bb15f616d0..b5e2a0d115ca2 100644
--- a/include/linux/cper.h
+++ b/include/linux/cper.h
@@ -542,17 +542,23 @@ struct cper_mem_err_compact {
 	u16	card;
 	u16	module;
 	u16	bank;
-	u16	device;
-	u16	row;
-	u16	column;
-	u16	bit_pos;
+	u32	device;
+	u32	row;
+	u32	column;
+	u32	bit_pos;
 	u64	requestor_id;
 	u64	responder_id;
 	u64	target_id;
-	u16	rank;
-	u16	mem_array_handle;
-	u16	mem_dev_handle;
-	u8      extended;
+	u32	rank;
+	u32	mem_array_handle;
+	u32	mem_dev_handle;
+	u64	error_status;
+	u64	physical_addr;
+	u64	physical_addr_mask;
+	u8	chip_id;
+	u8	status;
+	u8	error_type;
+	u8	is_section2;
 };

 static inline u32 cper_get_mem_extension(u64 mem_valid, u8 mem_extended)
--
2.43.0
