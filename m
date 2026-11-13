Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794576496;
	b=J9+Uxx5Q29OV9sbvj4EfCUDgiLzg6MxjQF64JiOy74LvgYB2oV06vPmfTduTJ2QgYYLq
	 1fiMXkS8ZhtH51WXUoyYLj/FMW0nI0CIISQPwof4q466fu5j6TQMvx0c2wu95X7d3jZ0d
	 JZ0c9rB7QI4i78xYM8NWzRjttMwd7p5fPl1EXidYUTGYJ7V9DgSV1p+H6PI+78udepxtL
	 rCK5mcA2JFYVPbJ8n5BClnVyL9pOhnxPFggYey9E2RXwdZg5vnKTr8n6XZfCFUsJxjwvM
	 7j6XdAut4QmjKOUy2P718QUMUdwN33s4VRB0pkn+vQxj+kIBLg2m7D32ScBYbpxMUeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794576496;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1+aHLi2UtIuBlcJCbpbAPaiJvtL7eNx9R7my6J/Wo6I=;
	b=D4hExSM/DkG90NCySZIoG8VE6SdxpMKBiBn/ByDl7oB1JofyIAQ4lGKqZfNFlAUC1/9W
	 XCxdi3H9Ml+YJyIRij4M+CIm1MzTUila1y1wPjPTeB3zPbV70P+aX9FIg9F5BdXEPqKUt
	 5hNe2o1k1MAksHacYHTaNwvD9Jo/84Sh67EyLxr2NkIGefTLUiuoXUM0FbkAgYis7zfqp
	 Sp0D9nDtme+ZB3FxdIOZQ7DV+XhtOyUsJuQ9NfvEPiCGzi6eAreLc+p3A9WGABkG6y0Fe
	 /2vnsa6gPBIG2WxHHbklCp1saUYn9VDJ8FhY3eQclbSPIAgieDF7PjqAdL1seUz1XAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=SmeRqcZi;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988B160A6F7F;
	Fri, 13 Nov 2026 13:28:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 988B160A6F7F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=SmeRqcZi
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F1D8C1BB2;
	Fri, 13 Nov 2026 05:28:11 -0800 (PST)
Received: from e135073.arm.com (unknown [10.57.14.137])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 299A53F85F;
	Fri, 13 Nov 2026 05:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794576495; bh=o0mvMz7Hkgc98u3XVYb9ZY3WvbaHGaD0B1hl0lPQEk0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SmeRqcZigWsajIP8sYoa3JsAi8Y6QEfkmYzM/Baj7a2mEEJmN5TCy82jGV6wtHaCC
	 5xvoqeFyM0+g86zVsLGw0TF2Xb9k+vZFfP7hpJ8t53k47xuJ7LpBJO1ZmySFohO4+O
	 nirc16pEnX+l915yFVqjq6nmHiuOVAef2tggG04c=
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
	Dan Williams <djbw@kernel.org>,
	Terry Bowman <terry.bowman@amd.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Morduan Zang <zhangdandan@uniontech.com>,
	linux-acpi@vger.kernel.org,
	linux-edac@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH v4 12/12] efi/cper: Increase memory error location and detail buffer sizes
Date: Fri, 13 Nov 2026 14:24:54 +0100
Message-ID: <20261113132600.3355836-13-pierre.gondois@arm.com>
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

Memory Error Section 2 descriptions can exceed the existing buffers.
Helpers require:

1. cper_mem_err2_location(): ~263 chars:
    node:65535 card:65535 module:65535 rank:4294967295 bank_group:255
    bank_address:255 device:4294967295 row:4294967295 column:4294967295
    bit_position:4294967295 requestor_id:0xffffffffffffffff
    responder_id:0xffffffffffffffff target_id:0xffffffffffffffff
    chip_id:255

2. cper_dimm_err2_location(): 17 + strlen(bank) + strlen(device):
    DIMM location: <bank> <device>
   Or ~51 chars:
    DIMM location: not present. DMI handle: 0xffffffff

3. print_mem_error2_other_detail(): ~65 + strlen(location) +
   strlen(status):
    APEI location: <location> status(0xffffffffffff13ff): <status>
    section_status:0xff

Increase the size of:
- CPER_REC_LEN: used to store the output of [1] or [2]
- LOCATION_SIZE: used to store the output of [1] + [2]
- OTHER_DETAIL_LEN: used to store the output of [3]
  (which includes the size of the location buffer).

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/edac/ghes_edac.c | 3 ++-
 include/linux/cper.h     | 4 ++--
 include/linux/edac.h     | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index 33e3aa897c18..d3544dc20649 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -17,7 +17,8 @@
 #include <linux/notifier.h>
 #include <linux/string.h>
 
-#define OTHER_DETAIL_LEN	400
+/* Allow 65 formatting characters plus the longest status description (63). */
+#define OTHER_DETAIL_LEN	(LOCATION_SIZE + 128)
 
 struct ghes_pvt {
 	struct mem_ctl_info *mci;
diff --git a/include/linux/cper.h b/include/linux/cper.h
index db69995a43bf..a8eedc098bb0 100644
--- a/include/linux/cper.h
+++ b/include/linux/cper.h
@@ -29,9 +29,9 @@
  * CPER record length contains the CPER fields which are relevant for further
  * handling of a memory error in userspace (we don't carry all the fields
  * defined in the UEFI spec because some of them don't make any sense.)
- * Currently, a length of 256 should be more than enough.
+ * Allow room for the wider fields in Memory Error Section 2.
  */
-#define CPER_REC_LEN					256
+#define CPER_REC_LEN					512
 /*
  * Severity definition for error_severity in struct cper_record_header
  * and section_severity in struct cper_section_descriptor
diff --git a/include/linux/edac.h b/include/linux/edac.h
index f7a8218f9cc0..ef0569aa97be 100644
--- a/include/linux/edac.h
+++ b/include/linux/edac.h
@@ -48,7 +48,7 @@ static inline void opstate_init(void)
 #define EDAC_MC_LABEL_LEN	31
 
 /* Maximum size of the location string */
-#define LOCATION_SIZE 256
+#define LOCATION_SIZE		512
 
 /* Defines the maximum number of labels that can be reported */
 #define EDAC_MAX_LABELS		8
-- 
2.43.0

