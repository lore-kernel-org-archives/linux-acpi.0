Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546EE2F7445;
	Fri, 10 Apr 2026 09:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775814113; cv=none; b=nP1qtwzOUir3iWJv0oO8H+YRPlAu1nqllDqH+Q07ogYcDO0KfItvcDD6nMCMxhb3KKglYRLahTTlKyJTF3OqR37i3tS2Bb0Gv0uJzeyofy+a/cp4zk11IGoRqGmbkvEPTX/1rI3MzOwRhFAfBOFCEAH7tSf+pcn8g3FlOY9kFXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775814113; c=relaxed/simple;
	bh=eJq/ip+RnCQ7nVrtbXpBQJA1u5yrmRxSgRtTeuONu4Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=inhmK9MHeOC/uTV0RK4DrJo7RT90xBD8BCfTHA0ePPY+t/eynJcFP8XsfgElHXbG7ei/MNeI1K0RWPpztAzeUf6QY0v/6XPETmccTfXP2+s+j1C4fEb6cSB34MxZ1cFc4WADN/ZTikVGJmLoao60hoj8AaU1/0EQQZJnfTGNFkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=aQ8pixy5; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="aQ8pixy5"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=7w8y8miPjLI8+H+UgNwPJIYCDw9RNOhgOGxRWFDonsU=;
	b=aQ8pixy5Dnci6R2bR1/8odw2eQxaQci0KFq4E4PYFZI5L1YKDjrIchIhmtK6Dyi2n/UmGdXGS
	h0UMMPrMKLwGyrIJ0W3HwaijhEy+Yu8FudonilIRPkaX7zsBoE/T0cVVh9OV1py5+C8ipTV9DAt
	Tju3oZQQ3gbAkck0R54hMyk=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4fsWrV2FZ9z1T4Fk;
	Fri, 10 Apr 2026 17:35:54 +0800 (CST)
Received: from kwepemr200004.china.huawei.com (unknown [7.202.195.241])
	by mail.maildlp.com (Postfix) with ESMTPS id DD27D40569;
	Fri, 10 Apr 2026 17:41:47 +0800 (CST)
Received: from huawei.com (10.50.163.32) by kwepemr200004.china.huawei.com
 (7.202.195.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 10 Apr
 2026 17:41:46 +0800
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
Subject: [PATCH 1/2] ACPI: CPPC: add paired FFH feedback-counter read hook
Date: Fri, 10 Apr 2026 17:41:44 +0800
Message-ID: <20260410094145.4132082-2-zhangpengjie2@huawei.com>
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

cppc_get_perf_ctrs() reads the delivered and reference performance
counters one at a time.

Allow architectures to provide both FFH feedback counters in one
operation when that either narrows the sampling window or avoids extra
cross-CPU reads. Add a small FFH-specific hook for that case and fall
back to the existing per-register reads when unsupported.

Signed-off-by: Pengjie Zhang <zhangpengjie2@huawei.com>
---
 drivers/acpi/cppc_acpi.c | 58 ++++++++++++++++++++++++++++++++++++----
 include/acpi/cppc_acpi.h |  7 +++++
 2 files changed, 60 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 2e91c5a97761..7b3e8b0597dc 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -988,6 +988,23 @@ int __weak cpc_read_ffh(int cpunum, struct cpc_reg *reg, u64 *val)
 	return -ENOTSUPP;
 }
 
+/**
+ * cpc_read_ffh_fb_ctrs() - Read FFH feedback counters together
+ * @cpunum:	CPU number to read
+ * @reg1:	first CPPC register information
+ * @val1:	place holder for first return value
+ * @reg2:	second CPPC register information
+ * @val2:	place holder for second return value
+ *
+ * Return: 0 for success and error code
+ */
+int __weak cpc_read_ffh_fb_ctrs(int cpunum, struct cpc_reg *reg1,
+				u64 *val1, struct cpc_reg *reg2, u64 *val2)
+{
+	return -EOPNOTSUPP;
+}
+
+
 /**
  * cpc_write_ffh() - Write FFH register
  * @cpunum:	CPU number to write
@@ -1504,6 +1521,40 @@ bool cppc_perf_ctrs_in_pcc(void)
 }
 EXPORT_SYMBOL_GPL(cppc_perf_ctrs_in_pcc);
 
+static int cppc_read_perf_fb_ctrs(int cpunum,
+				  struct cpc_register_resource *delivered_reg,
+				  struct cpc_register_resource *reference_reg,
+				  u64 *delivered, u64 *reference)
+{
+	int ret;
+
+	/*
+	 * For FFH feedback counters, try a paired read first to reduce
+	 * sampling skew between delivered and reference counters. Fall
+	 * back to the existing per-register reads if unsupported.
+	 */
+	if (CPC_IN_FFH(delivered_reg) && CPC_IN_FFH(reference_reg)) {
+		ret = cpc_read_ffh_fb_ctrs(cpunum,
+					&delivered_reg->cpc_entry.reg, delivered,
+					&reference_reg->cpc_entry.reg, reference);
+		if (!ret)
+			return 0;
+
+		if (ret != -EOPNOTSUPP)
+			return ret;
+	}
+
+	ret = cpc_read(cpunum, delivered_reg, delivered);
+	if (ret)
+		return ret;
+
+	ret = cpc_read(cpunum, reference_reg, reference);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 /**
  * cppc_get_perf_ctrs - Read a CPU's performance feedback counters.
  * @cpunum: CPU from which to read counters.
@@ -1547,11 +1598,8 @@ int cppc_get_perf_ctrs(int cpunum, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
 		}
 	}
 
-	ret = cpc_read(cpunum, delivered_reg, &delivered);
-	if (ret)
-		goto out_err;
-
-	ret = cpc_read(cpunum, reference_reg, &reference);
+	ret = cppc_read_perf_fb_ctrs(cpunum, delivered_reg, reference_reg,
+				     &delivered, &reference);
 	if (ret)
 		goto out_err;
 
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index d1f02ceec4f9..006b42dbbd4b 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -172,6 +172,8 @@ extern int cppc_get_transition_latency(int cpu);
 extern bool cpc_ffh_supported(void);
 extern bool cpc_supported_by_cpu(void);
 extern int cpc_read_ffh(int cpunum, struct cpc_reg *reg, u64 *val);
+extern int cpc_read_ffh_fb_ctrs(int cpu, struct cpc_reg *reg1, u64 *val1,
+				struct cpc_reg *reg2, u64 *val2);
 extern int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val);
 extern int cppc_get_epp_perf(int cpunum, u64 *epp_perf);
 extern int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable);
@@ -246,6 +248,11 @@ static inline int cpc_read_ffh(int cpunum, struct cpc_reg *reg, u64 *val)
 {
 	return -EOPNOTSUPP;
 }
+static inline int cpc_read_ffh_fb_ctrs(int cpu, struct cpc_reg *reg1, u64 *val1,
+				       struct cpc_reg *reg2, u64 *val2)
+{
+	return -EOPNOTSUPP;
+}
 static inline int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val)
 {
 	return -EOPNOTSUPP;
-- 
2.33.0

