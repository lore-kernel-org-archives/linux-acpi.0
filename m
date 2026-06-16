Received: from outbound.baidu.com (mx24.baidu.com [111.206.215.185])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 7E21A33D6C7;
	Tue, 16 Jun 2026 07:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781594802; cv=none; b=COdtFngSb5mwSXXqGtZ+PuCFyPc5GySR8eEaqnIdicAwKjCk77B9UMMnWv5sp3Be0L6xdF2xCppNtTYmHnd4PPEwfxKZhtVEM0MeLzNoV0BXdjNmbEL/ddiPQ8z57q+9tcEvt+ynl3vQWwzIIP6Qm2bPrl6eLlEKBUE2xHaacOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781594802; c=relaxed/simple;
	bh=uSV3Iy5CgYn2N9ZEfwICmsrk48hSZPr8FS9SCAOhmKU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kG7WyhdNeaZEr5hzQHqGdSVBwFJeuuX/Y/Wb5KvYLWRlP1s79kwXCW1WwCy3umF52/SRz6H/chsF8WjE0GpQPH4MQTwl2Vpj6qwn+u3KryKBGdwH1H51YdqSu9Tg5JSYg+p68tQ4q3818StGhnz4TCEku2RTogmpEn9/lF6KKoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b=AGnRxI7n; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b="AGnRxI7n"
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>, Paul Walmsley <pjw@kernel.org>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre
 Ghiti <alex@ghiti.fr>, Sudeep Holla <Sudeep.Holla@arm.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH][v2] ACPI: processor_idle: Mark LPI enter functions as __cpuidle
Date: Tue, 16 Jun 2026 15:26:17 +0800
Message-ID: <20260616072617.2272-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc2.internal.baidu.com (172.31.3.12) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1781594790;
	bh=ZKrl5XjHwKttwXLUUkKHS6jVNOGR3JbwSYr/ZCiHc2E=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=AGnRxI7nhOfpVAiodp9dQNb0Sx0sH88DFHW71/m0s8Nen1jCWs+WVCqf9+1q4eyY9
	 Wbr9xE0s1F1PVkJhBQ/eorVrNj/0AmkOSx0Ml68lN5d+7G6yXN+MHw7vvGdS9sGa9r
	 zRF9n2e8holAzSxqpbryeT2KZAxMF138l+qQnUdomtGtRcz6YrD0TMe0hNpT8Hx4JP
	 W1OTbTogR3MCBDgi+q0aPIZJj0Ocd3qGWfGrSEzq91kGIXAc0QuZgfU1PUKI3oLzpz
	 wg9YK3+hCHrlNrrjIYYueCvkOWwxmM6oabXIiOfbhv9OSgEgz7kEzpZkY+T6PMfXLE
	 /Sj2wdMRjMSlw==

From: Li RongQing <lirongqing@baidu.com>

When function tracing or Kprobes is enabled, entering an ACPI Low
Power Idle (LPI) state triggers the following RCU splat:

  RCU not on for: acpi_idle_lpi_enter+0x4/0xd8
  WARNING: CPU: 8 PID: 0 at include/linux/trace_recursion.h:162 function_trace_call+0x1e8/0x228

The acpi_idle_lpi_enter() function is invoked within the cpuidle
path after RCU has already been disabled for the current local CPU.
Consequently, ftrace's function_trace_call() expects RCU to be
actively watching before recording trace data, emitting a warning
if it is not.

Fix this by annotating acpi_idle_lpi_enter(), the generic __weak
stub, and the RISC-V implementation of acpi_processor_ffh_lpi_enter()
with __cpuidle. This moves these functions into the '.cpuidle.text'
section, implicitly disabling ftrace instrumentation (notrace) along
this sensitive path and preventing trace-induced RCU warnings during
idle entry.

Fixes: a36a7fecfe60 ("ACPI / processor_idle: Add support for Low Power Idle(LPI) states")
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
Diff with v1: add __cpuidle to acpi_processor_ffh_lpi_enter

 drivers/acpi/processor_idle.c | 4 ++--
 drivers/acpi/riscv/cpuidle.c  | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 390ab5f..4482cf2 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1143,7 +1143,7 @@ static int acpi_processor_get_lpi_info(struct acpi_processor *pr)
 	return 0;
 }
 
-int __weak acpi_processor_ffh_lpi_enter(struct acpi_lpi_state *lpi)
+int __weak __cpuidle acpi_processor_ffh_lpi_enter(struct acpi_lpi_state *lpi)
 {
 	return -ENODEV;
 }
@@ -1156,7 +1156,7 @@ int __weak acpi_processor_ffh_lpi_enter(struct acpi_lpi_state *lpi)
  *
  * Return: 0 for success or negative value for error
  */
-static int acpi_idle_lpi_enter(struct cpuidle_device *dev,
+static int __cpuidle acpi_idle_lpi_enter(struct cpuidle_device *dev,
 			       struct cpuidle_driver *drv, int index)
 {
 	struct acpi_processor *pr;
diff --git a/drivers/acpi/riscv/cpuidle.c b/drivers/acpi/riscv/cpuidle.c
index 624f9bb..c76dbab 100644
--- a/drivers/acpi/riscv/cpuidle.c
+++ b/drivers/acpi/riscv/cpuidle.c
@@ -66,7 +66,7 @@ int acpi_processor_ffh_lpi_probe(unsigned int cpu)
 	return acpi_cpu_init_idle(cpu);
 }
 
-int acpi_processor_ffh_lpi_enter(struct acpi_lpi_state *lpi)
+int __cpuidle acpi_processor_ffh_lpi_enter(struct acpi_lpi_state *lpi)
 {
 	u32 state = lpi->address;
 
-- 
2.9.4

