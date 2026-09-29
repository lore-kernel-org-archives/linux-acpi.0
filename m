Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02EEC3AD53F;
	Tue, 29 Sep 2026 07:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790668065; cv=none; b=T/WTlO48L/jImMhJiBquHNcXhufpc+Yc4bCy3xL/6Z3FtLmsNAZDRFz68AcMWPo2N1fRqNSi89s6nYtl+7eUtqSrSKJi4WJkZihE0MU+ILnUGIAghvMGzGZlPTvcQz/zvaksswWJXX+UlsGUYzGh5RMMLaSarcz9acPGN6/lWZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790668065; c=relaxed/simple;
	bh=GqMAN+RnRu6qMuk/PQyyIscqhPvbIDcWurHJXsBBKkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rtYWw9u4kYWuLKml+lx4RV7rSGeQIRyqiXcAnvy1lxApiG7jXZCg5cO1VXBB9/kIolfS+oT+9rTA7HgG9h2L7sNo1zx4qDDpG1gKjcShUE4eyXwTSRpAwesaqF3odzhs0BNhN+sTggjnjhHhtSnP1cgNqNkymX/blL+U2IjOxHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=m/L2W+RI; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="m/L2W+RI"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D1843143D;
	Tue, 29 Sep 2026 00:47:39 -0700 (PDT)
Received: from e135073.nice.arm.com (e135073.arm.com [10.34.125.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D63FC3F85F;
	Tue, 29 Sep 2026 00:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790668063; bh=GqMAN+RnRu6qMuk/PQyyIscqhPvbIDcWurHJXsBBKkU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m/L2W+RI01NuB/lbq1TH9jK2oOWw6CU4XxsRDOUKIAath8QO8plYQXu7dQ39CiWHb
	 e9oxlhpWkoyybcGntuhay6TfClx6wbSSkbpCebrJQcajTV7Qe1/roexy602yVhv7Y6
	 c6aEwTlgLbD7Y4P/+qIO7PcrFNkmwhDN/qUTU8Do=
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
	Radu Rendec <radu@rendec.net>,
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
Subject: [RFC PATCH 1/6] ACPI: extlog: fix extlog_mem_event build issue
Date: Tue, 29 Sep 2026 09:46:00 +0200
Message-ID: <20260929074659.2587216-2-pierre.gondois@arm.com>
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

With CONFIG_ACPI_EXTLOG=n and with the following command:
make -j4 drivers/acpi/acpi_extlog.o drivers/acpi/

trace_extlog_mem_event() is not defined. Add a extlog_mem_err_event()
wrapper to fix the build issue.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/acpi/acpi_extlog.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
index 7ad3b36013cc6..699534b6a732d 100644
--- a/drivers/acpi/acpi_extlog.c
+++ b/drivers/acpi/acpi_extlog.c
@@ -180,6 +180,15 @@ extlog_cxl_cper_handle_prot_err(struct cxl_cper_sec_prot_err *prot_err,
 #endif
 }

+static void
+extlog_mem_err_event(struct cper_sec_mem_err *mem, u32 err_seq,
+		     const guid_t *fru_id, const char *fru_text, u8 sev)
+{
+#if defined(CONFIG_ACPI_EXTLOG) || defined(CONFIG_ACPI_EXTLOG_MODULE)
+	trace_extlog_mem_event(mem, err_seq, fru_id, fru_text, sev);
+#endif
+}
+
 static int extlog_print(struct notifier_block *nb, unsigned long val,
 			void *data)
 {
@@ -229,8 +238,9 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
 			struct cper_sec_mem_err *mem = acpi_hest_get_payload(gdata);

 			if (gdata->error_data_length >= sizeof(*mem))
-				trace_extlog_mem_event(mem, err_seq, fru_id, fru_text,
-						       (u8)gdata->error_severity);
+				extlog_mem_err_event(&mem, err_seq, fru_id,
+						     fru_text,
+						     (u8)gdata->error_severity);
 		} else if (guid_equal(sec_type, &CPER_SEC_CXL_PROT_ERR)) {
 			struct cxl_cper_sec_prot_err *prot_err =
 				acpi_hest_get_payload(gdata);
--
2.43.0
