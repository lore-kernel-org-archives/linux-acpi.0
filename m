Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA7A4014A9;
	Wed,  8 Jul 2026 08:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783499315; cv=none; b=GJkdQWYY1+gzXpmhxnWc5KmHHigW8fcGyCrQjHS+GY73FtI7xzwW/94OP6o+PtJJeJMB9wFWPXYvhqZojjAFI5NJ8RBhcJ9FK6bXyTwN7h1Pbnv0gMzni8f48N/kSTBYNWV5vBbtjn/2BV6tbN//NCjKU6PNBlpQJMe70Gs2Y4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783499315; c=relaxed/simple;
	bh=tgkfhUmsZKWADF8cAE40xBoAD1FIFnP+WaYLOPjr6aw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BADgPDrDEp2isUVX9FUTbiECRmLvVUUS8iTrUztI68wt0UDb/U19ffaucf/eAHKbLx80l04JIxVWhAhD4bHE01jgAi3Fi5YFJbDh61MNREDBu3/btypW+daMhV9bwCVEN3H9uktbWxYPyZk6hOwfdRN2TGOrEvqOYBtQLhT9HvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=nJNt57ML; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="nJNt57ML"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=m7OCS9ttjcsJjAtXg7NkqqhNNIFwWFmPdzpD3nDuHjg=;
	b=nJNt57MLrEVPte5Syar1+jRTg+YWjqen7Dz1aoXFz0/qSO1DjzXv/s+xQNLHSzE2c8xL6ZBJO
	a8y4KdgCkrkIT4/D1eHnyiTb+dVxJULuS1y8JNOd26kzKJaZ5ZCBJbWx/LBaSt617rIK3iiTjW3
	CHxgZjTGpR1jcm5e7Z9DaDo=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4gw9wm2VTLz1prPP;
	Wed,  8 Jul 2026 16:19:04 +0800 (CST)
Received: from kwepemr200004.china.huawei.com (unknown [7.202.195.241])
	by mail.maildlp.com (Postfix) with ESMTPS id 51A1A4056D;
	Wed,  8 Jul 2026 16:28:20 +0800 (CST)
Received: from huawei.com (10.50.163.32) by kwepemr200004.china.huawei.com
 (7.202.195.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 8 Jul
 2026 16:28:19 +0800
From: Pengjie Zhang <zhangpengjie2@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <rafael@kernel.org>,
	<lenb@kernel.org>, <saket.dumbre@intel.com>, <beata.michalska@arm.com>,
	<zhenglifeng1@huawei.com>, <sumitg@nvidia.com>, <zhanjie9@hisilicon.com>,
	<geert+renesas@glider.be>, <cuiyunhui@bytedance.com>,
	<vanshikonda@os.amperecomputing.com>, <ionela.voinescu@arm.com>,
	<jeremy.linton@arm.com>, <viresh.kumar@linaro.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<linuxarm@huawei.com>
CC: <prime.zeng@hisilicon.com>, <wanghuiqiang@huawei.com>,
	<xuwei5@huawei.com>, <lihuisong@huawei.com>, <yubowen8@huawei.com>,
	<zhangpengjie2@huawei.com>, <wangzhi12@huawei.com>
Subject: [PATCH v2 1/2] ACPI: CPPC: add paired FFH feedback-counter read hook
Date: Wed, 8 Jul 2026 16:28:17 +0800
Message-ID: <20260708082818.808041-2-zhangpengjie2@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260708082818.808041-1-zhangpengjie2@huawei.com>
References: <20260708082818.808041-1-zhangpengjie2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemr200004.china.huawei.com (7.202.195.241)

cppc_get_perf_ctrs() reads the delivered and reference performance
counters one at a time.

Allow architectures to provide both FFH feedback counters in one
operation when that either narrows the sampling window or avoids extra
cross-CPU reads. Add a small FFH-specific hook for that case and fall
back to the existing per-register reads when unsupported.

Tested-by: Sumit Gupta <sumitg@nvidia.com>
Reviewed-by: Sumit Gupta <sumitg@nvidia.com>
Tested-by: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
Reviewed-by: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
Signed-off-by: Pengjie Zhang <zhangpengjie2@huawei.com>
---
 drivers/acpi/cppc_acpi.c | 50 ++++++++++++++++++++++++++++++++++++----
 include/acpi/cppc_acpi.h |  7 ++++++
 2 files changed, 52 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 9f572f481241..b6356476a46e 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1004,6 +1004,22 @@ int __weak cpc_read_ffh(int cpunum, struct cpc_reg *reg, u64 *val)
 	return -ENOTSUPP;
 }
 
+/**
+ * cpc_read_ffh_fb_ctrs() - Read FFH feedback counters together
+ * @cpunum:	Target CPU
+ * @reg1:	first CPPC register information
+ * @val1:	place holder for first return value
+ * @reg2:	second CPPC register information
+ * @val2:	place holder for second return value
+ *
+ * Return: 0 on success, error code otherwise
+ */
+int __weak cpc_read_ffh_fb_ctrs(int cpunum, struct cpc_reg *reg1,
+				u64 *val1, struct cpc_reg *reg2, u64 *val2)
+{
+	return -EOPNOTSUPP;
+}
+
 /**
  * cpc_write_ffh() - Write FFH register
  * @cpunum:	CPU number to write
@@ -1496,6 +1512,33 @@ bool cppc_perf_ctrs_in_pcc_cpu(unsigned int cpu)
 }
 EXPORT_SYMBOL_GPL(cppc_perf_ctrs_in_pcc_cpu);
 
+static int cppc_read_fb_ctrs(int cpunum,
+			     struct cpc_register_resource *delivered_reg,
+			     struct cpc_register_resource *reference_reg,
+			     u64 *delivered, u64 *reference)
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
+		if (ret != -EOPNOTSUPP)
+			return ret;
+	}
+
+	ret = cpc_read(cpunum, delivered_reg, delivered);
+	if (ret)
+		return ret;
+
+	return cpc_read(cpunum, reference_reg, reference);
+}
+
 /**
  * cppc_perf_ctrs_in_pcc - Check if any perf counters are in a PCC region.
  *
@@ -1561,11 +1604,8 @@ int cppc_get_perf_ctrs(int cpunum, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
 		}
 	}
 
-	ret = cpc_read(cpunum, delivered_reg, &delivered);
-	if (ret)
-		goto out_err;
-
-	ret = cpc_read(cpunum, reference_reg, &reference);
+	ret = cppc_read_fb_ctrs(cpunum, delivered_reg, reference_reg,
+				&delivered, &reference);
 	if (ret)
 		goto out_err;
 
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index 8693890a7275..5acebe62feac 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -176,6 +176,8 @@ extern int cppc_get_transition_latency(int cpu);
 extern bool cpc_ffh_supported(void);
 extern bool cpc_supported_by_cpu(void);
 extern int cpc_read_ffh(int cpunum, struct cpc_reg *reg, u64 *val);
+extern int cpc_read_ffh_fb_ctrs(int cpu, struct cpc_reg *reg1, u64 *val1,
+				struct cpc_reg *reg2, u64 *val2);
 extern int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val);
 extern int cppc_get_epp_perf(int cpunum, u64 *epp_perf);
 extern int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable);
@@ -250,6 +252,11 @@ static inline int cpc_read_ffh(int cpunum, struct cpc_reg *reg, u64 *val)
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

