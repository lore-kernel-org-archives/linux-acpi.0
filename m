Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7688638C2D4;
	Mon,  1 Jun 2026 23:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780358317; cv=none; b=jPlJhfaImg1GmIizR5LySwlfSvl3qaoJuEAFsqQjiGJG9dLDKACSzgmZh+0tV/RnNIC4/sXlcgcgmWro2Mml9iqXUAUjYCM9WTuq4ddUIo3/Gstxk52THgP5ZYc/MG4wwPqQfs2sEuE1ivVF5O8CO8OEf7/2+7O6/8jEMhTolpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780358317; c=relaxed/simple;
	bh=GsQw87ay9rNT2cnBiQV91l4lms7B0FUmaiHfIZ3V1fE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QpIIaznca1g4PZOhzXJnuGgn2Br9Qx+VYynoF/gC1+Zg478X/wXDlzHoHjXUeFoEmjwkc1hSeGdeGNTJebuklEkaJppGgd1th2dn5NAD1Gdk3cycJL5tJyoq8EynHHaXEHL0xZauWFbpjYoKYbLh9fUME7lvWXRI1bxVrr5Tf8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=i5oWnBVv; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="i5oWnBVv"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C67372A2A;
	Mon,  1 Jun 2026 16:58:29 -0700 (PDT)
Received: from u200865.usa.arm.com (U203867.austin.arm.com [10.118.30.58])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 830683F86F;
	Mon,  1 Jun 2026 16:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780358314; bh=GsQw87ay9rNT2cnBiQV91l4lms7B0FUmaiHfIZ3V1fE=;
	h=From:To:Cc:Subject:Date:From;
	b=i5oWnBVvhiBGii4rPBSHUu5y0wFTUbyc2EenuG1SHrVHvB+acsliIvOJOkR3oPz57
	 kfuvsgPQlJAvmfIm5HSbWa1FG9j+Y22xDuoN/1FGzpydQQ9j0zgYEOqNPQqBOFHicL
	 C4qu8UBbmdtlp7ZJwnWAN+q27y9LBgxxnTiVf9+I=
From: Jeremy Linton <jeremy.linton@arm.com>
To: linux-acpi@vger.kernel.org
Cc: jarredwhite@linux.microsoft.com,
	easwar.hariharan@linux.microsoft.com,
	lenb@kernel.org,
	rafael@kernel.org,
	linux-kernel@vger.kernel.org,
	Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH] ACPI: CPPC: Suppress UBSAN warning caused by field misuse
Date: Mon,  1 Jun 2026 18:58:08 -0500
Message-ID: <20260601235808.1113137-1-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The definition of reg->access_width changes depending on the
reg->space_id type.  Type ACPI_ADR_SPACE_PLATFORM_COMM uses
access_width to indicate the PCC region, which can result in a UBSAN
if the value is greater than 4.

For example:

 UBSAN: shift-out-of-bounds in drivers/acpi/cppc_acpi.c:1090:9
 shift exponent 32 is too large for 32-bit type 'int'
 CPU: 61 UID: 0 PID: 1220 Comm: (udev-worker) Not tainted 7.0.10-201.fc44.aarch64 #1 PREEMPT(lazy)
 Hardware name: To be filled by O.E.M.
 Call trace:
  ...(trimming)
  ubsan_epilogue+0x10/0x48
  __ubsan_handle_shift_out_of_bounds+0xdc/0x1e0
  cpc_write+0x4d0/0x670
  cppc_set_perf+0x18c/0x490
  cppc_cpufreq_cpu_init+0x1c8/0x380 [cppc_cpufreq]
  ... (trimming)

Lets fix this by validating the region type, as well as whether
access_width has a value. Then since we are returning bit_width
directly for ACPI_ADR_SPACE_PLATFORM_COMM, drop the code correcting
the size.

Fixes: 2f4a4d63a193 ("ACPI: CPPC: Use access_width over bit_width for system memory accesses")
Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 drivers/acpi/cppc_acpi.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index f370be8715ae..34edec0f2bde 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -185,8 +185,13 @@ show_cppc_data(cppc_get_perf_caps, cppc_perf_caps, nominal_freq);
 
 show_cppc_data(cppc_get_perf_ctrs, cppc_perf_fb_ctrs, wraparound_time);
 
-/* Check for valid access_width, otherwise, fallback to using bit_width */
-#define GET_BIT_WIDTH(reg) ((reg)->access_width ? (8 << ((reg)->access_width - 1)) : (reg)->bit_width)
+/*
+ * PCC reuses the access_width field as the subspace id, so only decode access
+ * size for non-PCC registers. Otherwise, use the bit_width.
+ */
+#define GET_BIT_WIDTH(reg) (((reg)->access_width &&				\
+			     (reg)->space_id != ACPI_ADR_SPACE_PLATFORM_COMM) ? \
+			    (8 << ((reg)->access_width - 1)) : (reg)->bit_width)
 
 /* Shift and apply the mask for CPC reads/writes */
 #define MASK_VAL_READ(reg, val) (((val) >> (reg)->bit_offset) &				\
@@ -1045,7 +1050,6 @@ static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
 		 * by the bit width field; the access size is used to indicate
 		 * the PCC subspace id.
 		 */
-		size = reg->bit_width;
 		vaddr = GET_PCC_VADDR(reg->address, pcc_ss_id);
 	}
 	else if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
@@ -1118,7 +1122,6 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 		 * by the bit width field; the access size is used to indicate
 		 * the PCC subspace id.
 		 */
-		size = reg->bit_width;
 		vaddr = GET_PCC_VADDR(reg->address, pcc_ss_id);
 	}
 	else if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
-- 
2.54.0

