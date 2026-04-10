Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7715C33263F;
	Fri, 10 Apr 2026 09:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775814113; cv=none; b=Z1Rj8N2GBQH+KYLM3PZFUxatt3o9cJJA274G9eUsXa9YACmwmxWQ3tq88NlO5Lc/nqXvNvH9lkHDlYY359T4p6xXw3aUsBmyEEBb5WMzxi6a7RXXInz4e//G0YWJDNq3ydTn7/Pz5VLRvekfr4d6tM9HpM3DAM5owSygP58ee/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775814113; c=relaxed/simple;
	bh=F4ryKXUAEmlZ4yDcjSFw3cplbvom8lVuZFR/S2jceLk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PgxzZKAJlHvkTD+J3ZKyPUa1NS1LT9pSUX3euAM2OL94/SkLiSc6Nr0VQ4lXoFynBGR4BkpE/ndlYNLf2zHLUq6t6InBl9zMziqingBKmvsrrX5TssLmAZ8vyf7NcmLoknVwsWhaMrqrrxFoYsfi82egab2ibyO2hzHCrgLTFAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=XQbtAW8P; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="XQbtAW8P"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=bwFRFS4W6cPblkf+h6/g3f55xTUa33U6wkzy7Jalz+k=;
	b=XQbtAW8PTuHSGpxk6Z9BfBydwcSWs3+sgRnHXvomEmj5xWtEFWbhDzqJqop8TaUsXBNToyPHm
	hBYWYzu0V0om/AO6aBqPOS2pIcAx3GhJaKskNk6jVNxZwKm/81qCoEEv6zKWnNFoYkYXqPn4gYu
	zJCzRQ59C+wjHjsE2dsAuRg=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fsWr33LNzzKm5f;
	Fri, 10 Apr 2026 17:35:31 +0800 (CST)
Received: from kwepemr200004.china.huawei.com (unknown [7.202.195.241])
	by mail.maildlp.com (Postfix) with ESMTPS id 9890E40571;
	Fri, 10 Apr 2026 17:41:48 +0800 (CST)
Received: from huawei.com (10.50.163.32) by kwepemr200004.china.huawei.com
 (7.202.195.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 10 Apr
 2026 17:41:47 +0800
From: Pengjie Zhang <zhangpengjie2@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <rafael@kernel.org>,
	<lenb@kernel.org>, <robert.moore@intel.com>, <beata.michalska@arm.com>,
	<zhenglifeng1@huawei.com>, <zhanjie9@hisilicon.com>, <sumitg@nvidia.com>,
	<cuiyunhui@bytedance.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<prime.zeng@hisilicon.com>, <wanghuiqiang@huawei.com>, <xuwei5@huawei.com>,
	<lihuisong@huawei.com>, <yubowen8@huawei.com>, <zhangpengjie2@huawei.com>,
	<wangzhi12@huawei.com>
Subject: [PATCH 2/2] arm64: topology: read CPPC FFH feedback counters in one operation
Date: Fri, 10 Apr 2026 17:41:45 +0800
Message-ID: <20260410094145.4132082-3-zhangpengjie2@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260410094145.4132082-1-zhangpengjie2@huawei.com>
References: <20260410094145.4132082-1-zhangpengjie2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemr200004.china.huawei.com (7.202.195.241)

arm64 implements CPPC FFH feedback-counter reads using AMU counters.
Because those counters must be sampled on the target CPU, reading the
delivered and reference counters separately widens the observation window
between them.

Implement the paired FFH feedback-counter read hook on arm64 and sample
both AMU counters together before decoding the requested CPC register
values.

Also factor the FFH bitfield extraction logic into a helper and reuse
it from the existing single-counter FFH read path.

Signed-off-by: Pengjie Zhang <zhangpengjie2@huawei.com>
---
 arch/arm64/kernel/topology.c | 75 ++++++++++++++++++++++++++++++++----
 1 file changed, 67 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index b32f13358fbb..b90a767b2a1f 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -50,6 +50,16 @@ struct amu_cntr_sample {
 	unsigned long	last_scale_update;
 };
 
+struct amu_ffh_ctrs {
+	u64 corecnt;
+	u64 constcnt;
+};
+
+enum cpc_ffh_ctr_id {
+	CPC_FFH_CTR_CORE  = 0x0,
+	CPC_FFH_CTR_CONST = 0x1,
+};
+
 static DEFINE_PER_CPU_SHARED_ALIGNED(struct amu_cntr_sample, cpu_amu_samples);
 
 void update_freq_counters_refs(void)
@@ -397,7 +407,7 @@ static void cpu_read_constcnt(void *val)
 }
 
 static inline
-int counters_read_on_cpu(int cpu, smp_call_func_t func, u64 *val)
+int counters_read_on_cpu(int cpu, smp_call_func_t func, void *val)
 {
 	/*
 	 * Abort call on counterless CPU.
@@ -447,24 +457,73 @@ bool cpc_ffh_supported(void)
 	return true;
 }
 
+static void amu_read_core_const_ctrs(void *val)
+{
+	struct amu_ffh_ctrs *ctrs = val;
+
+	cpu_read_constcnt(&ctrs->constcnt);
+	cpu_read_corecnt(&ctrs->corecnt);
+}
+
+static u64 cpc_ffh_extract_bits(const struct cpc_reg *reg, u64 val)
+{
+	val &= GENMASK_ULL(reg->bit_offset + reg->bit_width - 1,
+			   reg->bit_offset);
+	val >>= reg->bit_offset;
+
+	return val;
+}
+
+static bool cpc_ffh_ctr_value(const struct cpc_reg *reg,
+			      const struct amu_ffh_ctrs *ctrs, u64 *val)
+{
+	switch ((u64)reg->address) {
+	case CPC_FFH_CTR_CORE:
+		*val = ctrs->corecnt;
+		break;
+	case CPC_FFH_CTR_CONST:
+		*val = ctrs->constcnt;
+		break;
+	default:
+		return false;
+	}
+
+	*val = cpc_ffh_extract_bits(reg, *val);
+	return true;
+}
+
+int cpc_read_ffh_fb_ctrs(int cpu, struct cpc_reg *reg1, u64 *val1,
+			 struct cpc_reg *reg2, u64 *val2)
+{
+	struct amu_ffh_ctrs ctrs;
+	int ret;
+
+	ret = counters_read_on_cpu(cpu, amu_read_core_const_ctrs, &ctrs);
+	if (ret)
+		return ret;
+
+	if (!cpc_ffh_ctr_value(reg1, &ctrs, val1) ||
+	    !cpc_ffh_ctr_value(reg2, &ctrs, val2))
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
 int cpc_read_ffh(int cpu, struct cpc_reg *reg, u64 *val)
 {
 	int ret = -EOPNOTSUPP;
 
 	switch ((u64)reg->address) {
-	case 0x0:
+	case CPC_FFH_CTR_CORE:
 		ret = counters_read_on_cpu(cpu, cpu_read_corecnt, val);
 		break;
-	case 0x1:
+	case CPC_FFH_CTR_CONST:
 		ret = counters_read_on_cpu(cpu, cpu_read_constcnt, val);
 		break;
 	}
 
-	if (!ret) {
-		*val &= GENMASK_ULL(reg->bit_offset + reg->bit_width - 1,
-				    reg->bit_offset);
-		*val >>= reg->bit_offset;
-	}
+	if (!ret)
+		*val = cpc_ffh_extract_bits(reg, *val);
 
 	return ret;
 }
-- 
2.33.0

