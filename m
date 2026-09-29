Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D82388899;
	Tue, 29 Sep 2026 07:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790668128; cv=none; b=s+hAolM6w1AwTaimYCQn8dynYcGPTvZqm19uHDrD+gjasVDyKcQH7ZYgSa6w402h5+vON1nBXWxsAkjG3kJZSJknt++EqmrY8gdILj5CHVi8EmqU1jOgT1EGBwUe1n6A+Imobpv5LLriDGEvuWrBSXiie9YOoMMGhCswVGBa8Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790668128; c=relaxed/simple;
	bh=3LWKKd7tUGCVa4QEx7TKGiPJJE2RNNPRyN0LVyZ0eeU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mcjVrNUth1bOYuuZuJ1HzysMmZ1W/Vj7oprq+/3CHrUbFH6iZzvJfGbrfBAvkfHm9m0Sz7E2uDrwuVZqZHSsHgtBsPLQv/xYqY1maDRLX5fp+eglytPfWiXtZeGoZKwZsHjTeYBmMQliQnMxEFFtaT+RqTUcDztK+/FlAmgzOFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=KAGJE1gu; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="KAGJE1gu"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E0C11756;
	Tue, 29 Sep 2026 00:48:42 -0700 (PDT)
Received: from e135073.nice.arm.com (e135073.arm.com [10.34.125.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4FFB43F85F;
	Tue, 29 Sep 2026 00:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790668125; bh=3LWKKd7tUGCVa4QEx7TKGiPJJE2RNNPRyN0LVyZ0eeU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KAGJE1guM8tSj/FYLI+ar12bc0IqmQX7KmrPvlrzpKqCqCkrhOU6fC+1lGB0M2LWW
	 kUAgTwtqy3P8AM99nue4w2zJFxmU1QR/INWk9WrOJfYhjRWWQhKnFe4nqo/6AfXajI
	 o5bk4Khmg0eyhJEW+q5xmG0tVbtRrZWM1ClTvVJY=
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
	Radu Rendec <radu@rendec.net>,
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
Subject: [RFC PATCH 6/6] cper: make cper_mem_err_pack() static
Date: Tue, 29 Sep 2026 09:46:05 +0200
Message-ID: <20260929074659.2587216-7-pierre.gondois@arm.com>
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

Make cper_mem_err_pack() local to cper.c and drop its public
declaration as it is only used in the local file.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/firmware/efi/cper.c | 5 ++---
 include/linux/cper.h        | 2 --
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index e0ba2ca498e75..066359c549aff 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -392,8 +392,8 @@ static void cper_mem_err_old_pack(const struct cper_sec_mem_err_old *mem,
 	cmem->error_type = mem->error_type;
 }

-void cper_mem_err_pack(const struct cper_sec_mem_err *mem,
-		       struct cper_mem_err_compact *cmem)
+static void cper_mem_err_pack(const struct cper_sec_mem_err *mem,
+			      struct cper_mem_err_compact *cmem)
 {
 	memset(cmem, 0, sizeof(*cmem));
 	cmem->validation_bits = mem->validation_bits;
@@ -419,7 +419,6 @@ void cper_mem_err_pack(const struct cper_sec_mem_err *mem,
 	if (mem->validation_bits & CPER_MEM_VALID_CHIP_ID)
 		cmem->chip_id = mem->extended >> CPER_MEM_CHIP_ID_SHIFT;
 }
-EXPORT_SYMBOL_GPL(cper_mem_err_pack);

 static void cper_mem_err2_pack(const struct cper_sec_mem_err2 *mem,
 			       struct cper_mem_err_compact *cmem)
diff --git a/include/linux/cper.h b/include/linux/cper.h
index ac236043ce859..dac8e0b83a9fa 100644
--- a/include/linux/cper.h
+++ b/include/linux/cper.h
@@ -627,8 +627,6 @@ void cper_print_bits(const char *prefix, unsigned int bits,
 		     const char * const strs[], unsigned int strs_size);
 int cper_bits_to_str(char *buf, int buf_size, unsigned long bits,
 		     const char * const strs[], unsigned int strs_size);
-void cper_mem_err_pack(const struct cper_sec_mem_err *,
-		       struct cper_mem_err_compact *);
 bool cper_sec_is_platform_mem(const guid_t *sec_type);
 int cper_mem_err_parse(const guid_t *sec_type, const void *mem, size_t len,
 		       struct cper_mem_err_compact *cmem);
--
2.43.0
