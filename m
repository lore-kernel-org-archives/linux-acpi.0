Received: from va-2-37.ptr.blmpb.com (va-2-37.ptr.blmpb.com [209.127.231.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0143EA976
	for <linux-acpi@vger.kernel.org>; Wed,  9 Sep 2026 07:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788938159; cv=none; b=ajd0zBdZwfqxHzMVzgrHhPxs4pfZOYXktsNL9nlDhXzQ4xaPGlQuQdREzIXzT2GQ+q1AXuMhe4xxpLienixkLzD8n/PTUVq7YOrx4++Dp/OcIShjbE1jg/jFRQ965KFIoa9R7BBDsAM/8YaIJpdg9+rOlr3BY3Ut4N65q6/YwPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788938159; c=relaxed/simple;
	bh=NQTpoQMjTwrCXkdydfrXo2bBKVzkbXeNVwN15Rwdkxc=;
	h=In-Reply-To:Content-Type:Mime-Version:Cc:From:Message-Id:To:Date:
	 References:Subject; b=cRL2TeUHrgaGOMYW+9zHTDsJ7prHhit33ScV3ldVTD76wB+XiX9PKkY4yvo/56Xa18GUs1E/d+17BrPI8QEPMc1l0+jiSUbLZjBrrHrBcdb5FBgkoZfExuV9hYdrlZCrMaJsQ5t9ULrAjuywofi4ajbnrdNHzkYIQ7vSgLsSyZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=picoheart.com; spf=pass smtp.mailfrom=picoheart.com; dkim=pass (2048-bit key) header.d=picoheart.com header.i=@picoheart.com header.b=S9Ig77aP; arc=none smtp.client-ip=209.127.231.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=picoheart.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=picoheart.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=picoheart.com header.i=@picoheart.com header.b="S9Ig77aP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604151535; d=picoheart.com; t=1788938145; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=pt6OOx+B8k3wCTl+qYRiKurKqWDpmNuDdbbpDKUT/dY=;
 b=S9Ig77aPEWp1vGgG992NNoQS1SPCJqP+2D9+g4PlrLXSUapQSbx42TqWvQvkk1GvcS1FH1
 1KBRIWGD44zKi/mhVYk1oToIu6NBKUYkcvxQERK/j8Ax5T+5SHo89R0k7Cfut9iIOA7zor
 RLEmmwU3FGJYmBT9c9s/QZh9SVHckpBvUd/OfpRU73CaXfYetIHSrLzGZcO4KTns97TClQ
 AqUbdnDXqTpc6pKy7qfQJWrIFXWXGBgsac+UyDpMJfqbTrYX/yLhKPhmfuFh0JPwsT+7RM
 ZlDjUM//pDxl8bX2yWVOSyPjbaNhPc+BI7+wuCPU1mzAKSIwmnoizYNKZw3vig==
In-Reply-To: <20260902083450.2348-1-douyufan@picoheart.com>
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Yufan Dou <douyufan@picoheart.com>
X-Lms-Return-Path: <lba+26aa1079f+1ad786+vger.kernel.org+douyufan@picoheart.com>
Content-Transfer-Encoding: 7bit
Cc: <yuchao.46@picoheart.com>, <zhanjie9@hisilicon.com>, 
	<yang.yicong@picoheart.com>, <lihuisong@picoheart.com>, 
	<geshijian@picoheart.com>, <wang.yechao255@zte.com.cn>
From: "Yufan Dou" <douyufan@picoheart.com>
Message-Id: <20260909071541.1545-1-douyufan@picoheart.com>
X-Mailer: git-send-email 2.53.0
Received: from 5CG30262N9-QAP.localdomain ([120.234.49.250]) by smtp.feishu.cn with ESMTPS; Wed, 09 Sep 2026 15:15:42 +0800
To: "Sunil V L" <sunilvl@ventanamicro.com>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, "Len Brown" <lenb@kernel.org>, 
	"Paul Walmsley" <pjw@kernel.org>, "Palmer Dabbelt" <palmer@dabbelt.com>, 
	"Albert Ou" <aou@eecs.berkeley.edu>, "Alexandre Ghiti" <alex@ghiti.fr>, 
	<linux-acpi@vger.kernel.org>, <linux-riscv@lists.infradead.org>, 
	<linux-kernel@vger.kernel.org>
Date: Wed,  9 Sep 2026 15:15:41 +0800
References: <20260902083450.2348-1-douyufan@picoheart.com>
Subject: [PATCH v2] ACPI: RISC-V: CPPC: Implement cpc_read_ffh_fb_ctrs()

On RISC-V, reading FFH feedback counters on a remote hart through
cpc_read_ffh() requires a separate IPI for each register.
cppc_get_perf_ctrs() therefore samples the delivered and reference
counters in two separate IPIs. Variation in the delay between these
reads distorts the delivered/reference ratio and thus the frequency
reported by cpufreq.

Implement cpc_read_ffh_fb_ctrs() to read both counters back-to-back
in a single callback on the target hart. For remote reads, this
reduces two IPIs to one and narrows the separation between the
counter samples. Support CSR-type, SBI-type and mixed-type pairs.
Pairing SBI reads does not reduce the number of SBI calls, but
still avoids a separate IPI for each counter.

Factor the execution-context handling into cppc_ffh_read_on_cpu(),
shared by cpc_read_ffh() and cpc_read_ffh_fb_ctrs(). CPPC frequency
invariance (FIE) reads non-PCC counters directly from the scheduler
tick, with local interrupts disabled. Unconditionally rejecting
such reads prevents the frequency scale from being updated.

Following arm64's counters_read_on_cpu(), invoke the callback
directly when interrupts are disabled and the target is the current
CPU. Reject remote reads in that context. Otherwise, use
smp_call_function_single() and propagate its return value before
accessing the callback results.

Frequency accuracy testing used CSR-type delivered and reference
counters, with CPU1 kept busy by:

  # stress-ng --cpu 1 --taskset 1

On a CPU with cpuinfo_max_freq of 3000000 kHz:

Before:

  Maximum observed cpuinfo_cur_freq: 3201369 kHz
  Maximum observed deviation:        +201369 kHz (+6.71%)

After:

  Maximum observed cpuinfo_cur_freq: 3009646 kHz
  Maximum observed deviation:          +9646 kHz (+0.32%)

The maximum observed deviation from cpuinfo_max_freq decreased
by 95.2%.

Additional testing covered the CPPC FIE tick path and SBI-type
FFH register reads.

Co-developed-by: Yicong Yang <yang.yicong@picoheart.com>
Signed-off-by: Yicong Yang <yang.yicong@picoheart.com>
Signed-off-by: Yufan Dou <douyufan@picoheart.com>
Reviewed-by: Sunil V L <sunilvl@oss.qualcomm.com>
---
Changes in v2:
- Support SBI-type and mixed-type counter pairs in a single callback
  on the target hart, reducing remote reads to one IPI.
- Factor out cppc_ffh_read_on_cpu() for both FFH read interfaces.
  Allow local reads with interrupts disabled and reject remote reads
  in that context, following arm64's counters_read_on_cpu().
- Propagate synchronous cross-CPU call errors in cpc_read_ffh().
- Test the CPPC FIE tick path and SBI-type FFH register reads.

v1:
https://lore.kernel.org/all/20260902083450.2348-1-douyufan@picoheart.com/

 drivers/acpi/riscv/cppc.c | 102 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 97 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/riscv/cppc.c b/drivers/acpi/riscv/cppc.c
index 42c1a9052470..0f580cd6c21e 100644
--- a/drivers/acpi/riscv/cppc.c
+++ b/drivers/acpi/riscv/cppc.c
@@ -85,6 +85,55 @@ static void cppc_ffh_csr_write(void *write_data)
 	data->ret.error = -EINVAL;
 }
 
+struct cppc_ffh_ctr {
+	struct sbi_cppc_data data;
+	u64 type;
+};
+
+struct cppc_ffh_fb_ctrs_data {
+	struct cppc_ffh_ctr first;
+	struct cppc_ffh_ctr second;
+};
+
+static void cppc_ffh_read_fb_ctrs(void *read_data)
+{
+	struct cppc_ffh_fb_ctrs_data *data = read_data;
+
+	if (data->first.type == FFH_CPPC_SBI)
+		sbi_cppc_read(&data->first.data);
+	else
+		cppc_ffh_csr_read(&data->first.data);
+
+	if (data->second.type == FFH_CPPC_SBI)
+		sbi_cppc_read(&data->second.data);
+	else
+		cppc_ffh_csr_read(&data->second.data);
+}
+
+static int cppc_ffh_ctr_errno(const struct cppc_ffh_ctr *ctr)
+{
+	if (!ctr->data.ret.error)
+		return 0;
+
+	return ctr->type == FFH_CPPC_SBI ?
+	       sbi_err_map_linux_errno(ctr->data.ret.error) :
+	       ctr->data.ret.error;
+}
+
+static int cppc_ffh_read_on_cpu(int cpu, smp_call_func_t func, void *data)
+{
+	if (irqs_disabled()) {
+		/* Remote reads require IPIs, which are unsafe with IRQs disabled. */
+		if (WARN_ON_ONCE(cpu != smp_processor_id()))
+			return -EPERM;
+
+		func(data);
+		return 0;
+	}
+
+	return smp_call_function_single(cpu, func, data, 1);
+}
+
 /*
  * Refer to drivers/acpi/cppc_acpi.c for the description of the functions
  * below.
@@ -97,9 +146,7 @@ bool cpc_ffh_supported(void)
 int cpc_read_ffh(int cpu, struct cpc_reg *reg, u64 *val)
 {
 	struct sbi_cppc_data data;
-
-	if (WARN_ON_ONCE(irqs_disabled()))
-		return -EPERM;
+	int ret;
 
 	if (FFH_CPPC_TYPE(reg->address) == FFH_CPPC_SBI) {
 		if (!cppc_ext_present)
@@ -107,7 +154,9 @@ int cpc_read_ffh(int cpu, struct cpc_reg *reg, u64 *val)
 
 		data.reg = FFH_CPPC_SBI_REG(reg->address);
 
-		smp_call_function_single(cpu, sbi_cppc_read, &data, 1);
+		ret = cppc_ffh_read_on_cpu(cpu, sbi_cppc_read, &data);
+		if (ret)
+			return ret;
 
 		*val = data.ret.value;
 
@@ -115,7 +164,9 @@ int cpc_read_ffh(int cpu, struct cpc_reg *reg, u64 *val)
 	} else if (FFH_CPPC_TYPE(reg->address) == FFH_CPPC_CSR) {
 		data.reg = FFH_CPPC_CSR_NUM(reg->address);
 
-		smp_call_function_single(cpu, cppc_ffh_csr_read, &data, 1);
+		ret = cppc_ffh_read_on_cpu(cpu, cppc_ffh_csr_read, &data);
+		if (ret)
+			return ret;
 
 		*val = data.ret.value;
 
@@ -125,6 +176,47 @@ int cpc_read_ffh(int cpu, struct cpc_reg *reg, u64 *val)
 	return -EINVAL;
 }
 
+int cpc_read_ffh_fb_ctrs(int cpu, struct cpc_reg *reg1, u64 *val1,
+			 struct cpc_reg *reg2, u64 *val2)
+{
+	struct cppc_ffh_fb_ctrs_data data;
+	int ret;
+
+	data.first.type = FFH_CPPC_TYPE(reg1->address);
+	data.second.type = FFH_CPPC_TYPE(reg2->address);
+
+	if ((data.first.type != FFH_CPPC_SBI && data.first.type != FFH_CPPC_CSR) ||
+	    (data.second.type != FFH_CPPC_SBI && data.second.type != FFH_CPPC_CSR))
+		return -EINVAL;
+
+	if ((data.first.type == FFH_CPPC_SBI || data.second.type == FFH_CPPC_SBI) &&
+	    !cppc_ext_present)
+		return -EINVAL;
+
+	data.first.data.reg = data.first.type == FFH_CPPC_SBI ?
+			      FFH_CPPC_SBI_REG(reg1->address) :
+			      FFH_CPPC_CSR_NUM(reg1->address);
+	data.second.data.reg = data.second.type == FFH_CPPC_SBI ?
+			       FFH_CPPC_SBI_REG(reg2->address) :
+			       FFH_CPPC_CSR_NUM(reg2->address);
+
+	ret = cppc_ffh_read_on_cpu(cpu, cppc_ffh_read_fb_ctrs, &data);
+	if (ret)
+		return ret;
+
+	ret = cppc_ffh_ctr_errno(&data.first);
+	if (ret)
+		return ret;
+	ret = cppc_ffh_ctr_errno(&data.second);
+	if (ret)
+		return ret;
+
+	*val1 = data.first.data.ret.value;
+	*val2 = data.second.data.ret.value;
+
+	return 0;
+}
+
 int cpc_write_ffh(int cpu, struct cpc_reg *reg, u64 val)
 {
 	struct sbi_cppc_data data;

base-commit: 89a312991dc6e638a36adc43ccb91dbc25504c04
-- 
2.34.1
