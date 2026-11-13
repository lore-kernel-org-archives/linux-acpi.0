Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794576415;
	b=CJMaUWZvzyjeSeZZXI2peqbUKI02X0rAfZX0qC/fBZFfEywgeue/2L+ybS/WsRpDvjTQ
	 kHgs+aYc4gXR2+eiRrj5U7iBoro2e/qxsxdBw698yffDvzgGEsiu+XBKGcjdj6SnhogCm
	 fftPyTH4TDuWOjWyhiPYOL8Vgz5RsKg86Rck6T5LlSwOvbA/QlbFRt5kOzdPQyR7ywDfw
	 8imHtyCWmE4WuBX9Fpy+m/rDGs2BKEnVf96zrqmKyqXIq61h5WMrjC+5ukJkSvtVQ/kWH
	 yQgQEC9fpznEHhPwnPkHW77cVivRmYllz/tqtubMernggwLEss01K94Cb/Uy3hBRFiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794576415;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=rNOJaBnJqIQh0BytQrI6oFmvY3g7gJCIY1b4dTBj6VE=;
	b=DqOMxeKaSHlSpW0KPtjl7QDs5lNaOo6/rkUDCDr0g+t0b92/pCc0rR3MtGZx1K5G5ROi
	 EIx4Qq2sc4Siunwdzdoiz1hlioCOOdmxcsBlPPkhKZ6FJ33h+v/PDNeq8AitG1l7oO5TK
	 pu7Sx/pdc+r707oITa5Uew+ZpmdbX+WOPFWKENPfbEZZdXCGViFrn0ljnMtFWY6nT7CpJ
	 qidvL97gZVt8ffBTYtoAfdL4I3IiLzWvcmjKNR4Ux+VW2kyeY3pBDy5DR38ya0K2WL/19
	 cmLQnhPYaTcsXi0K+1tcyXbwxN5kApEWKmFYxoZsn7lUkEI9KehzLjOtbrpyYb7qnAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=NattlqLc;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71243606A8A8;
	Fri, 13 Nov 2026 13:26:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71243606A8A8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=NattlqLc
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C15C5152B;
	Fri, 13 Nov 2026 05:26:51 -0800 (PST)
Received: from e135073.arm.com (unknown [10.57.14.137])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 74D1A3F85F;
	Fri, 13 Nov 2026 05:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794576414; bh=lx0o98oGcIWfZs1eRF4u77nrkIHJsj5SHWVSyZ3b47k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NattlqLcAT7eoz5Ro24Za5a6OOPjRDn4YFoT5LvS4ihS1DYVPx1aLPGON5l6MYEJ9
	 sGRmbbjVlqhO+MvAgqsMVg51tqjKcc499y9S8+Vesgu3bVxeoTGZNABoecTkL3DxGO
	 50fA6vqxdW96Hm9xyDu1uOR7fjdgUNFqaHhyRN5s=
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
	Dave Jiang <dave.jiang@intel.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Breno Leitao <leitao@debian.org>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Dan Williams <djbw@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Morduan Zang <zhangdandan@uniontech.com>,
	linux-acpi@vger.kernel.org,
	linux-edac@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH v4 04/12] cper: Return actual bytes written by DIMM location helpers
Date: Fri, 13 Nov 2026 14:24:46 +0100
Message-ID: <20261113132600.3355836-5-pierre.gondois@arm.com>
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

Use scnprintf() instead of snprintf() to return the actual chars
written to the buffer in:
- cper_dimm_err_location()
- cper_dimm_err2_location()

This allows to make the buffer progress correctly in
the caller function.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/firmware/efi/cper.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index 218f560a2796..d8587141f8b2 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -364,11 +364,11 @@ int cper_dimm_err_location(struct cper_mem_err_compact *mem, char *msg)
 	len = CPER_REC_LEN;
 	dmi_memdev_name(mem->mem_dev_handle, &bank, &device);
 	if (bank && device)
-		n = snprintf(msg, len, "DIMM location: %s %s ", bank, device);
+		n = scnprintf(msg, len, "DIMM location: %s %s ", bank, device);
 	else
-		n = snprintf(msg, len,
-			     "DIMM location: not present. DMI handle: 0x%.4x ",
-			     mem->mem_dev_handle);
+		n = scnprintf(msg, len,
+			      "DIMM location: not present. DMI handle: 0x%.4x ",
+			      mem->mem_dev_handle);
 
 	return n;
 }
@@ -531,11 +531,11 @@ int cper_dimm_err2_location(const struct cper_sec_mem_err2 *mem, char *msg)
 
 	len = CPER_REC_LEN;
 	if (bank && device)
-		n = snprintf(msg, len, "DIMM location: %s %s ", bank, device);
+		n = scnprintf(msg, len, "DIMM location: %s %s ", bank, device);
 	else
-		n = snprintf(msg, len,
-			     "DIMM location: not present. DMI handle: 0x%.8x ",
-			     mem->mem_dev_handle);
+		n = scnprintf(msg, len,
+			      "DIMM location: not present. DMI handle: 0x%.8x ",
+			      mem->mem_dev_handle);
 
 	return n;
 }
-- 
2.43.0

