Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792442405;
	b=0CtX0/NeLYEiM6ABgr6wjauamxUzNLrVIKAK9kTCdCOzRlqARmOiviR8yd8XOdwRZsWr
	 /4pdS+0c9oUpc0TPnOV1YFAzOp7uK5mAHzQP2G62qIym21SefszORV2CrePNu+0A3JdQT
	 +TsVFR/HG/3lFGVuCi5G9CqnMQxiz3ypFPEA5eQVQXfgtPPA2NBe5dp4YrSqvAbPKuJkn
	 gJTuhwAKKFcTgw027FjGAnkM8IwmGMXLRW3ivvEIT+yCbNCjCIEnJNmSlEC3fV9iakyWb
	 Bvx0PVY0b8a27QrKXAsoaIoANjODO162XNiDDAsaIxVgfmyOhrDIRQ59iX+JDu5Y9Bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792442405;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=eRkeZ0ipYJ1MHWJlVPsvXCo4/sBajLX2SniI3PPfICQ=;
	b=eXjE4efqJRzm3v21hXltb/MU7gW9VtTPcqeOA8LO7Nz67cXNZnAb5j/5bTJOmeIJJXmw
	 RvzuiLSiN6A2tqKYt2vQ2NoVgQeM0qXslxCOOe+hgiyAtBFFx90er/vIgD8wpz1LRGPkd
	 aRmgQT2iZVZpM/RACbMLtunKCuHGA/8H69Ya0nhuor2ZGa2XZ+3+IXmbgplV/ReFGzeib
	 ZqfxlquhEUpaWcqu7C9xh7uThhGDfiLvIqD9+z3osnhSU8JRqQ9trg5tLl3TQlbncfCDI
	 M8wozigraUBzcNew3D/8KQa/O2zY4rvUN5g2/otXmINwhrWbiKMl+pSsbkG6jOBzcjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=DSx8P6Yw;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521D2606A31C;
	Mon, 19 Oct 2026 20:40:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 521D2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=DSx8P6Yw
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 751A622BE;
	Mon, 19 Oct 2026 13:40:00 -0700 (PDT)
Received: from e135073.arm.com (unknown [10.57.53.5])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 69F6B3F673;
	Mon, 19 Oct 2026 13:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1792442403; bh=qAtbFux6+hn9hPQBDC24nVRJXGjmaLFgxIYzgn0V3Ak=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DSx8P6YwlPvl8lm1YScGpzpPcCl/6OTsxtcuxJ6VL3cOUd/ETKta6GK0Pa5MWj3ss
	 mEeSkZVrkCP81Gjxy2/61Wax6B5VNbOkMM6RyXNknvL/UecYzJ5RBmbqUqIBbhUo/Z
	 tqiK4PeuqPzdELDbccpDLexDWS6bAAimPMpsAG8Q=
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
	Terry Bowman <terry.bowman@amd.com>,
	Dan Williams <djbw@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Morduan Zang <zhangdandan@uniontech.com>,
	linux-acpi@vger.kernel.org,
	linux-edac@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH v2 4/6] EDAC/ghes: Extract error report initialization
Date: Mon, 19 Oct 2026 22:38:43 +0200
Message-ID: <20261019203915.2019037-5-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019203915.2019037-1-pierre.gondois@arm.com>
References: <20261019203915.2019037-1-pierre.gondois@arm.com>
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

Extract a ghes_edac_init_error() function to prepare for
Memory Error Section 2 support (and re-usage).

Also use a guard in the caller ghes_edac_report_mem_error()
function for code simplification.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/edac/ghes_edac.c | 66 +++++++++++++++++++++-------------------
 1 file changed, 35 insertions(+), 31 deletions(-)

diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index d80c88818691..b90150c67f4b 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -267,37 +267,14 @@ static int print_mem_error_other_detail(const struct cper_sec_mem_err *mem, char
 	return n;
 }
 
-static int ghes_edac_report_mem_error(struct notifier_block *nb,
-				      unsigned long val, void *data)
+/* Caller must hold ghes_lock. */
+static struct edac_raw_error_desc *
+ghes_edac_init_error(struct ghes_pvt *pvt, unsigned long sev)
 {
-	struct cper_sec_mem_err *mem_err = (struct cper_sec_mem_err *)data;
-	struct cper_mem_err_compact cmem;
-	struct edac_raw_error_desc *e;
-	struct mem_ctl_info *mci;
-	unsigned long sev = val;
-	struct ghes_pvt *pvt;
-	unsigned long flags;
-	char *p;
-
-	/*
-	 * We can do the locking below because GHES defers error processing
-	 * from NMI to IRQ context. Whenever that changes, we'd at least
-	 * know.
-	 */
-	if (WARN_ON_ONCE(in_nmi()))
-		return NOTIFY_OK;
-
-	spin_lock_irqsave(&ghes_lock, flags);
-
-	pvt = ghes_pvt;
-	if (!pvt)
-		goto unlock;
-
-	mci = pvt->mci;
-	e = &mci->error_desc;
+	struct edac_raw_error_desc *e = &pvt->mci->error_desc;
 
 	/* Cleans the error report buffer */
-	memset(e, 0, sizeof (*e));
+	memset(e, 0, sizeof(*e));
 	e->error_count = 1;
 	e->grain = 1;
 	e->msg = pvt->msg;
@@ -323,6 +300,36 @@ static int ghes_edac_report_mem_error(struct notifier_block *nb,
 		e->type = HW_EVENT_ERR_INFO;
 	}
 
+	return e;
+}
+
+static int ghes_edac_report_mem_error(struct notifier_block *nb,
+				      unsigned long val, void *data)
+{
+	struct cper_sec_mem_err *mem_err = (struct cper_sec_mem_err *)data;
+	struct cper_mem_err_compact cmem;
+	struct edac_raw_error_desc *e;
+	struct mem_ctl_info *mci;
+	struct ghes_pvt *pvt;
+	char *p;
+
+	/*
+	 * We can do the locking below because GHES defers error processing
+	 * from NMI to IRQ context. Whenever that changes, we'd at least
+	 * know.
+	 */
+	if (WARN_ON_ONCE(in_nmi()))
+		return NOTIFY_OK;
+
+	guard(spinlock_irqsave)(&ghes_lock);
+
+	pvt = ghes_pvt;
+	if (!pvt)
+		return NOTIFY_OK;
+
+	mci = pvt->mci;
+	e = ghes_edac_init_error(pvt, val);
+
 	edac_dbg(1, "error validation_bits: 0x%08llx\n",
 		 (long long)mem_err->validation_bits);
 
@@ -375,9 +382,6 @@ static int ghes_edac_report_mem_error(struct notifier_block *nb,
 
 	edac_raw_mc_handle_error(e);
 
-unlock:
-	spin_unlock_irqrestore(&ghes_lock, flags);
-
 	return NOTIFY_OK;
 }
 
-- 
2.43.0

