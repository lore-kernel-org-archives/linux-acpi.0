Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794576487;
	b=VUBCT5IPeJjRHDQ9Lqc2JQwmhRPD3O9s89cBaoxpQik2qobcol3NkBieQytu92ojOp43
	 mV5u8cvhDKFe7zcLrgbhnqeDjS2FYdzxBbl6grgzYAbrMPerpHKPTPgFsu2xIGY/LGxGN
	 aeQD7jny4ndfe1vA+VkllTgOexMr3nyYBpeD3duM9VpeTWBU7nW86Ul7CGmjKFIcmCdFw
	 fujun5Qdimd7GP/7ZAtxStOzSCRojknOMywZZbBaL766P9gUDFN9+fGIov1XSgfDNLqS0
	 SdF0SvURNQrSh2nst3JTHE6znHbcDiOi9mokgpN5B7oeMzchLEWPKY7uWfgNiwy1mlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794576487;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=eU2UARUAckPhr4q/P8tKBwfdhmsSzqQma9MHJ//hXQc=;
	b=3VE0qiSldLEeIpuJJU94H6JSqHE9+CYa1DV2msIaVnkVc/dfprwKKw6S07NsMSodtP/Y
	 CmcNNuLpUvma+xH0FYRx21jYAPWs41C49yFRpApZ46cpZrLKcnt+nNmyDkTFjWCzf7WDS
	 N2FS6u7s2HBPeo7kyPnQ/u2akvfS4FawkIOVkWawlQwE03aCuQuUp8yFmDwQN6s5LVtcd
	 kqwv3HuluwJXZEkPbemcRiqylRTqLx/twKsI6X8oWO+JnRsS8MzANbMf89yGBvLnsr09U
	 gfyGetBIn8Yfo2IlAj9lguIGGlKu5b+Ok6BlHFn9UjhkWPOe2Vo1O1gj76rhbn7jPJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=jxD4Brxm;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D342A60A6F65;
	Fri, 13 Nov 2026 13:28:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D342A60A6F65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=jxD4Brxm
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 57CE816F2;
	Fri, 13 Nov 2026 05:28:02 -0800 (PST)
Received: from e135073.arm.com (unknown [10.57.14.137])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 52D7E3F85F;
	Fri, 13 Nov 2026 05:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794576485; bh=OvrW+o6ubR6y6R+n3mv0g5zTzffEVhjDila+yiH1P7o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jxD4Brxm6b5UNRyqxxQOHWP+VfpSN8qirnzwo7jRUOWvbv0vyzfKRkR1+7d8RidPI
	 qwGX4bn9csQ2+gX9TTPAxPCifdvX8qRW1SN0fBIYdwbSd+s2D8HuDv59GBga/MhXIg
	 FYry9HdtGyfOfVdbJV01JTrqaqJEuBkJXsFniuKs=
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
	Breno Leitao <leitao@debian.org>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Dan Williams <djbw@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Morduan Zang <zhangdandan@uniontech.com>,
	linux-acpi@vger.kernel.org,
	linux-edac@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH v4 11/12] EDAC/ghes: Small buffer fixes for mem other_detail helpers
Date: Fri, 13 Nov 2026 14:24:53 +0100
Message-ID: <20261113132600.3355836-12-pierre.gondois@arm.com>
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

scnprintf() already reserves space for the terminating NULL,
leaving one byte unused and under-flowing the capacity when len=0.
Callers also remove the last character unconditionally, which
can discard valid text after truncation.

Update the following functions to fix the above issues.
- print_mem_error_other_detail()
- print_mem_error2_other_detail()

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/edac/ghes_edac.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index f0ca61bddee6..33e3aa897c18 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -243,15 +243,14 @@ static void ghes_scan_system(void)
 }
 
 static int print_mem_error_other_detail(const struct cper_sec_mem_err *mem, char *msg,
-					const char *location, unsigned int len)
+					const char *location, size_t len)
 {
 	u32 n;
 
-	if (!msg)
+	if (!msg || !len)
 		return 0;
 
 	n = 0;
-	len -= 1;
 
 	n += scnprintf(msg + n, len - n, "APEI location: %s ", location);
 
@@ -377,8 +376,8 @@ static int ghes_edac_report_mem_error(struct notifier_block *nb,
 
 	/* All other fields are mapped on e->other_detail */
 	p = pvt->other_detail;
-	p += print_mem_error_other_detail(mem_err, p, e->location, OTHER_DETAIL_LEN);
-	if (p > pvt->other_detail)
+	p += print_mem_error_other_detail(mem_err, p, e->location, sizeof(pvt->other_detail));
+	if (p > pvt->other_detail && p[-1] == ' ')
 		*(p - 1) = '\0';
 
 	edac_raw_mc_handle_error(e);
@@ -392,15 +391,14 @@ static struct notifier_block ghes_edac_mem_err_nb = {
 };
 
 static int print_mem_error2_other_detail(const struct cper_sec_mem_err2 *mem, char *msg,
-					 const char *location, unsigned int len)
+					 const char *location, size_t len)
 {
 	u32 n;
 
-	if (!msg)
+	if (!msg || !len)
 		return 0;
 
 	n = 0;
-	len -= 1;
 
 	n += scnprintf(msg + n, len - n, "APEI location: %s ", location);
 
@@ -494,8 +492,8 @@ static int ghes_edac_report_mem_error2(struct notifier_block *nb,
 
 	/* All other fields are mapped on e->other_detail */
 	p = pvt->other_detail;
-	p += print_mem_error2_other_detail(mem_err, p, e->location, OTHER_DETAIL_LEN);
-	if (p > pvt->other_detail)
+	p += print_mem_error2_other_detail(mem_err, p, e->location, sizeof(pvt->other_detail));
+	if (p > pvt->other_detail && p[-1] == ' ')
 		*(p - 1) = '\0';
 
 	edac_raw_mc_handle_error(e);
-- 
2.43.0

