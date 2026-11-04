Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793790302;
	b=hMqFfANIGs9Zc5dKRNIULeNKQ+RXn+GKp8gXIpQwWWcpb2HIarujN/ky8Z5ZmIvNBe/m
	 Z8kuVL0BApwXd6rl2CNBIfpvdgmqimeNqr2bOPJhunlEbRTFkY4L7KmGE19/udigJ/NJa
	 Fn7oNuEzZLIJdMBveeHzU7ptT8MSSqXMx44r3OQMzi/1emXJiikaTS2sixUr6p78/0nDA
	 SYbhTipPcx5ilLljpxup2SfTlvgGOtfPmENZ0nEb0w5nCRVmr7KMOpJtuGb/56ywEvWPg
	 xfqoYyyN82I+xEPshqwmA/l1SG0LSn1duyvJiLHwD/Vpy3bxGrYHBdyTSd5XV7RuOog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793790302;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=43pGp9axAlQuZS9lLRlDeoeo4DzZJaL1zS+zyaWjVvc=;
	b=VrCSYwizLfjzUNNNMO7OjtJ2P+lcQg97XVpdog7wijNG21n+LnTJT7lTOe9rVX3E49/H
	 ol9sR2DWTHM1wd06oz8NNX7ly1MsQbIS4ogQTMYrk0w5eMLmA55VX1/hW0Mm3rkcorxMd
	 wXKJLudRK5KpB4cCva38SSXNu0Gv7y2/Ht4ixTdeOCPZwZgUKZg1kP+xcEusTqHGEuX6L
	 mhHt1k2trEQDI5zkT9eVwJx1IL+dR37eTTFepEg7+7ktQJ04zuJz0FQAwbqTbVWudwE+E
	 8j4ftMZ0YNUjBrlxhSmuBg8RAm3KFoZ7fb4MFvIx7bOPuNvfK1UPq5eTHHjcRfEcLsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=WTIrqR8f;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECBDA606A335;
	Wed,  4 Nov 2026 11:05:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECBDA606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=WTIrqR8f
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C36B1476;
	Wed,  4 Nov 2026 03:04:58 -0800 (PST)
Received: from e135073.arm.com (unknown [10.57.64.194])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8AC0C3F632;
	Wed,  4 Nov 2026 03:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793790301; bh=v9oHqHBPDYFoQAX8i62P0hF9Sv4ORzOKE4sgoztAFLE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WTIrqR8f8p3WufM+mXB2h/8dvJjiCVM0ibKa07TyNu9Dc7RvScvNlBpAvs1wPf/WW
	 KjeGXdQURrpAg9evg92ab7AwK+K8ovkucZZloaZ7EiTnAZJl9jav1UizgBvRpd065w
	 hRr5I3NMvCUkc6mqf9JiRTI64EhyrqHXQKGzRz+w=
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
	Dave Jiang <dave.jiang@intel.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Breno Leitao <leitao@debian.org>,
	Terry Bowman <terry.bowman@amd.com>,
	Dan Williams <djbw@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Morduan Zang <zhangdandan@uniontech.com>,
	linux-acpi@vger.kernel.org,
	linux-edac@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH v3 4/7] EDAC/ghes: Extract error report initialization
Date: Wed,  4 Nov 2026 12:03:12 +0100
Message-ID: <20261104110355.1437249-5-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104110355.1437249-1-pierre.gondois@arm.com>
References: <20261104110355.1437249-1-pierre.gondois@arm.com>
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

Extract a ghes_edac_init_error_desc() function to prepare for
Memory Error Section 2 support (and re-usage).

Also use a guard in the caller ghes_edac_report_mem_error()
function for code simplification.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/edac/ghes_edac.c | 70 +++++++++++++++++++++-------------------
 1 file changed, 36 insertions(+), 34 deletions(-)

diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index d80c88818691..f1cf4d640d68 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -267,6 +267,39 @@ static int print_mem_error_other_detail(const struct cper_sec_mem_err *mem, char
 	return n;
 }
 
+static void ghes_edac_init_error_desc(struct edac_raw_error_desc *e,
+				      unsigned long sev, char *msg, char *other_detail)
+{
+	lockdep_assert_held(&ghes_lock);
+
+	/* Cleans the error report buffer */
+	memset(e, 0, sizeof(*e));
+	e->error_count = 1;
+	e->grain = 1;
+	e->msg = msg;
+	e->other_detail = other_detail;
+	e->top_layer = -1;
+	e->mid_layer = -1;
+	e->low_layer = -1;
+	*msg = '\0';
+	*other_detail = '\0';
+
+	switch (sev) {
+	case GHES_SEV_CORRECTED:
+		e->type = HW_EVENT_ERR_CORRECTED;
+		break;
+	case GHES_SEV_RECOVERABLE:
+		e->type = HW_EVENT_ERR_UNCORRECTED;
+		break;
+	case GHES_SEV_PANIC:
+		e->type = HW_EVENT_ERR_FATAL;
+		break;
+	default:
+	case GHES_SEV_NO:
+		e->type = HW_EVENT_ERR_INFO;
+	}
+}
+
 static int ghes_edac_report_mem_error(struct notifier_block *nb,
 				      unsigned long val, void *data)
 {
@@ -274,9 +307,7 @@ static int ghes_edac_report_mem_error(struct notifier_block *nb,
 	struct cper_mem_err_compact cmem;
 	struct edac_raw_error_desc *e;
 	struct mem_ctl_info *mci;
-	unsigned long sev = val;
 	struct ghes_pvt *pvt;
-	unsigned long flags;
 	char *p;
 
 	/*
@@ -287,41 +318,15 @@ static int ghes_edac_report_mem_error(struct notifier_block *nb,
 	if (WARN_ON_ONCE(in_nmi()))
 		return NOTIFY_OK;
 
-	spin_lock_irqsave(&ghes_lock, flags);
+	guard(spinlock_irqsave)(&ghes_lock);
 
 	pvt = ghes_pvt;
 	if (!pvt)
-		goto unlock;
+		return NOTIFY_OK;
 
 	mci = pvt->mci;
 	e = &mci->error_desc;
-
-	/* Cleans the error report buffer */
-	memset(e, 0, sizeof (*e));
-	e->error_count = 1;
-	e->grain = 1;
-	e->msg = pvt->msg;
-	e->other_detail = pvt->other_detail;
-	e->top_layer = -1;
-	e->mid_layer = -1;
-	e->low_layer = -1;
-	*pvt->other_detail = '\0';
-	*pvt->msg = '\0';
-
-	switch (sev) {
-	case GHES_SEV_CORRECTED:
-		e->type = HW_EVENT_ERR_CORRECTED;
-		break;
-	case GHES_SEV_RECOVERABLE:
-		e->type = HW_EVENT_ERR_UNCORRECTED;
-		break;
-	case GHES_SEV_PANIC:
-		e->type = HW_EVENT_ERR_FATAL;
-		break;
-	default:
-	case GHES_SEV_NO:
-		e->type = HW_EVENT_ERR_INFO;
-	}
+	ghes_edac_init_error_desc(e, val, pvt->msg, pvt->other_detail);
 
 	edac_dbg(1, "error validation_bits: 0x%08llx\n",
 		 (long long)mem_err->validation_bits);
@@ -375,9 +380,6 @@ static int ghes_edac_report_mem_error(struct notifier_block *nb,
 
 	edac_raw_mc_handle_error(e);
 
-unlock:
-	spin_unlock_irqrestore(&ghes_lock, flags);
-
 	return NOTIFY_OK;
 }
 
-- 
2.43.0

