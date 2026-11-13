Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794576436;
	b=4jP2UVmSKy93I2Rpfklfn1QIEk0h0qLqDCTEmyARr9rhwcRx8uHRSGVlsOyMVZWC2nP2
	 oGM7kcvpd0gkxRTwIJCpRz0grbfDrJXyX7fjNqsA14ulTjyy6wfl31W6x0pxe+q54ejjU
	 8WnY7DcSgKplocdr7VtucDlirfV+of6yY1LIcQ1txTuTAhF0NQlfs4nGr61AYQOG4Xey7
	 O1mVkuatoJJyCCL1bv630OwbD8Q3R3Q+5tSwlJJLUl5cmSarQrmw5Ryte4YOwn+AfGevy
	 tXTOL94CXUd1QR17OeAG+T8uDgKrZz+KpI5iP7JY7CihYnJ5BTBxrxUqIG2wNWX8OXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794576436;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zWO9fTY1l00I493GwG+dvXsBJFpaNYO5JVcgTmMBdGw=;
	b=K2KfODa0vZY1zqh1Ejebq3ccz918HcpQ/wU1DzlpxuXJXw9g2rg9YHrnKbXTnOM+2NQm
	 mzsl46FXga/8x7wKT8tMaK7gWp++Fyj3BZwjZPvG/qWM9/A/cn7nM4+DCK+oMgT21JzxJ
	 PoRusHzp6tp2JLz76rDf2Q0xeZkpsArcZm8tMp0lkDD19QoJLY66bSZS6B41NdaFsUCjc
	 qyEZZRp0NvXc+clS3J41L+HBK7qZd5ZsnIWHYiLftwH1HKeIqMgNwKs3uI6JdDZcII5YB
	 Fu/mHe1tNMv3I5MkFxVZkgA1oywHh3bObtGvarWSgfEuAtAEZcV1vpOlCdndM4fy6nA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Y0RIv9vK;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5AFF606ABAA;
	Fri, 13 Nov 2026 13:27:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5AFF606ABAA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Y0RIv9vK
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11E351476;
	Fri, 13 Nov 2026 05:27:12 -0800 (PST)
Received: from e135073.arm.com (unknown [10.57.14.137])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2A24C3F85F;
	Fri, 13 Nov 2026 05:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794576435; bh=XXjfz1gd37X3boaZweOwGCsLH8DHwjpk9PRswkXYj20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y0RIv9vKI8srtvsbK0zbZfHPs1cxq9pYzTWnADUfK/JSymF8W5/5Q/kyECEOFnADy
	 x7HsDr7h9sc+ig2nisyohdCFE9fMdpUOqulLdPU3C0SbzgZmoZK3vTgeSjQVSSongp
	 fF2z5YyJc4k0dN8V5s6oPRkpaAlb9GgSd+Kq2U08=
From: Pierre Gondois <pierre.gondois@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Ashok Raj <ashok.raj@oss.qualcomm.com>,
	James Morse <james.morse@arm.com>,
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
Subject: [PATCH v4 06/12] ACPI: APEI: Extract common memory failure handling
Date: Fri, 13 Nov 2026 14:24:48 +0100
Message-ID: <20261113132600.3355836-7-pierre.gondois@arm.com>
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

Extract ghes_handle_memory_failure_common() to share the severity checks
and memory failure dispatch with the upcoming Memory Error Section 2
handler.

No functional change.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/acpi/apei/ghes.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 663dc2e601cf..d6bbee466b48 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -528,15 +528,11 @@ static bool ghes_do_memory_failure(u64 physical_addr, int flags)
 	return true;
 }
 
-static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
-				       int sev, bool sync)
+static bool ghes_handle_memory_failure_common(struct acpi_hest_generic_data *gdata,
+					      int sev, bool sync, u64 physical_addr)
 {
 	int flags = -1;
 	int sec_sev = ghes_severity(gdata->error_severity);
-	struct cper_sec_mem_err *mem_err = acpi_hest_get_payload(gdata);
-
-	if (!(mem_err->validation_bits & CPER_MEM_VALID_PA))
-		return false;
 
 	/* iff following two events can be handled properly by now */
 	if (sec_sev == GHES_SEV_CORRECTED &&
@@ -546,11 +542,22 @@ static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
 		flags = sync ? MF_ACTION_REQUIRED : 0;
 
 	if (flags != -1)
-		return ghes_do_memory_failure(mem_err->physical_addr, flags);
+		return ghes_do_memory_failure(physical_addr, flags);
 
 	return false;
 }
 
+static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
+				       int sev, bool sync)
+{
+	struct cper_sec_mem_err *mem_err = acpi_hest_get_payload(gdata);
+
+	if (!(mem_err->validation_bits & CPER_MEM_VALID_PA))
+		return false;
+
+	return ghes_handle_memory_failure_common(gdata, sev, sync, mem_err->physical_addr);
+}
+
 static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
 				     int sev, bool sync)
 {
-- 
2.43.0

