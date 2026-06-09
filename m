Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E7638E8B1;
	Tue,  9 Jun 2026 11:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781004554; cv=none; b=DqD4I/8nXGoPIG9GK7cbRL68z487enNf6SBKXctRQyjsc8yb4DCY8NNXRRxfdmL9HYtUU/i7dflOMf1KIgfWFi7MekZ69wMZxsH9R025FRwJCRg0EIHBs2SBTCRYrQV2gigvtJmhPiBer6CVI5PpLAZpR0kgGbd6ZtR97QLwqsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781004554; c=relaxed/simple;
	bh=kek5km7h23Z7XnuInanqGbSuQdOfDDWiXvpc/yT5UCA=;
	h=Message-ID:Date:Mime-Version:From:To:Cc:Subject:Content-Type; b=TQGJv5QixK/AIYdnnAD0yMw6JklODPUjaHE+yboej3Oi/P+5Dum5GY5QfOvZnLoWYXenuhcpfvBfggOBmCea/8R2Iql6j88+O9IsKsPYbmOC/uJoqRf3b3VGlJJvAr9DKZHEGybz1rpQCmIajFIv8wg5UXewE80j+BEo/GxpUnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4gZRWL1Dvlz8XrrZ;
	Tue, 09 Jun 2026 19:29:02 +0800 (CST)
Received: from szxlzmapp02.zte.com.cn ([10.5.231.79])
	by mse-fl1.zte.com.cn with SMTP id 659BSrsS033473;
	Tue, 9 Jun 2026 19:28:53 +0800 (+08)
	(envelope-from wang.yechao255@zte.com.cn)
Received: from mapi (szxlzmapp01[null])
	by mapi (Zmail) with MAPI id mid12;
	Tue, 9 Jun 2026 19:28:56 +0800 (CST)
X-Zmail-TransId: 2b036a27f8f811d-2718c
X-Mailer: Zmail v1.0
Message-ID: <20260609192856874Y8AaPpKL5TnmbgiWI8DI3@zte.com.cn>
Date: Tue, 9 Jun 2026 19:28:56 +0800 (CST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <wang.yechao255@zte.com.cn>
To: <linux-acpi@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Cc: <sunilvl@ventanamicro.com>, <rafael@kernel.org>, <lenb@kernel.org>,
        <pjw@kernel.org>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <alex@ghiti.fr>, <zhenglifeng1@huawei.com>, <pierre.gondois@arm.com>,
        <viresh.kumar@linaro.org>, <zhanjie9@hisilicon.com>
Subject: =?UTF-8?B?W1BBVENIXSBBQ1BJOiBSSVNDLVY6IEZpeCBmYWxzZSB3YXJuaW5nIGluIGNwcGNfcmVhZF9mZmgoKSBmb3Igc2FtZS1DUFUgcmVhZHM=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 659BSrsS033473
X-TLS: YES
X-ENVELOPE-SENDER: wang.yechao255@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Tue, 09 Jun 2026 19:29:02 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A27F8FE.000/4gZRWL1Dvlz8XrrZ

From: Wang Yechao <wang.yechao255@zte.com.cn>

Commit 997c021abc6e ("cpufreq: CPPC: Update FIE arch_freq_scale in
ticks for non-PCC regs") changed the CPPC Frequency Invariance Engine
to read AMU counters directly from the scheduler tick for non-PCC
register spaces (like FFH), instead of deferring to a kthread. This
means cppc_read_ffh() is now called with IRQs disabled from the tick
handler, triggering the warning.

This is the same fix as commit df6e4ab654dc ("arm64: topology: Fix
false warning in counters_read_on_cpu() for same-CPU reads").

Fixes: 997c021abc6e ("cpufreq: CPPC: Update FIE arch_freq_scale in ticks for non-PCC regs")
Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>
---
 drivers/acpi/riscv/cppc.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/riscv/cppc.c b/drivers/acpi/riscv/cppc.c
index 42c1a9052470..5dce0377a8df 100644
--- a/drivers/acpi/riscv/cppc.c
+++ b/drivers/acpi/riscv/cppc.c
@@ -98,16 +98,19 @@ int cpc_read_ffh(int cpu, struct cpc_reg *reg, u64 *val)
 {
 	struct sbi_cppc_data data;

-	if (WARN_ON_ONCE(irqs_disabled()))
-		return -EPERM;
-
 	if (FFH_CPPC_TYPE(reg->address) == FFH_CPPC_SBI) {
 		if (!cppc_ext_present)
 			return -EINVAL;

 		data.reg = FFH_CPPC_SBI_REG(reg->address);

-		smp_call_function_single(cpu, sbi_cppc_read, &data, 1);
+		if (irqs_disabled()) {
+			if (WARN_ON_ONCE(cpu != smp_processor_id()))
+				return -EPERM;
+			sbi_cppc_read(&data);
+		} else {
+			smp_call_function_single(cpu, sbi_cppc_read, &data, 1);
+		}

 		*val = data.ret.value;

@@ -115,7 +118,13 @@ int cpc_read_ffh(int cpu, struct cpc_reg *reg, u64 *val)
 	} else if (FFH_CPPC_TYPE(reg->address) == FFH_CPPC_CSR) {
 		data.reg = FFH_CPPC_CSR_NUM(reg->address);

-		smp_call_function_single(cpu, cppc_ffh_csr_read, &data, 1);
+		if (irqs_disabled()) {
+			if (WARN_ON_ONCE(cpu != smp_processor_id()))
+				return -EPERM;
+			cppc_ffh_csr_read(&data);
+		} else {
+			smp_call_function_single(cpu, cppc_ffh_csr_read, &data, 1);
+		}

 		*val = data.ret.value;

-- 
2.43.5
