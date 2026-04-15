Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB852308F2A;
	Wed, 15 Apr 2026 01:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776218216; cv=none; b=bOBjbQcWzEILFeqFSSjV5/nJ+3Chf07ISfQVgkxHzHgHsKpWI1Y4R0pblTq7LY5VZkUsTfiXh7suJLPWlFtVSXdxaNmf37284TWj0xpTYNo14FFvYHfcI9sRhZG4nfIOjQ2RHYuJFPe7aexVr0m93cof10YFcQxpTwypNYAm6eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776218216; c=relaxed/simple;
	bh=CSELH8cHpzjOmF3alV9G48Nrn3aORTFDw3pzNP6kshc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WHO3OSKOHjbHSteNKrv08Dj9ktbpfItAL5vGl9ZFyiJ9NYqSj25EyCA7D/ERqGT1t7hH5m80kdO9+uiSEy7DX2lB47gdSG/BigUIhrIkkOYW8964g8Xnr5mr34Cvn0+dBrx3nmdx+QsBClJjOpgkGPdHGCeJSFfNHzmstxcz52I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dEPuZPdM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dEPuZPdM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 243DDC2BCB3;
	Wed, 15 Apr 2026 01:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776218216;
	bh=CSELH8cHpzjOmF3alV9G48Nrn3aORTFDw3pzNP6kshc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dEPuZPdMs1tRecUY1gZ7qQV1Da89cGCyopTPMPDWokXVkOSaUdpP/ZQqtWVHa7z29
	 j3YNBLkJuCuU/q7w0CBwfCLL1rrRD43/vhXi2d8R6c2pd+FrA5HSmd4HlIAAcGHqxp
	 kYAvduGrB4NNIk0cI8phJNDQgmLkJV0Fh2LcmyKGXBj1YnoYt5wKi6ZrTywhGGi01s
	 sKZJGS+jLULC+FicyJl3aaBFP4C65AfxE1AwgyBuQgRS5F1xbqW87npAwvydVBe8qX
	 w/+7JO7T8c9v9uF7LV0FKn7YJ1LZCTEGIbYmBYBVTYrkN3QnAiqLA+XcAd7yEzLPcT
	 2/CUmvFhNINzw==
From: Drew Fustini <fustini@kernel.org>
Date: Tue, 14 Apr 2026 18:54:01 -0700
Subject: [PATCH RFC v3 07/11] RISC-V: QoS: enable resctrl support for
 Ssqosid
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-ssqosid-cbqri-rqsc-v7-0-v3-7-b3b2e7e9847a@kernel.org>
References: <20260414-ssqosid-cbqri-rqsc-v7-0-v3-0-b3b2e7e9847a@kernel.org>
In-Reply-To: <20260414-ssqosid-cbqri-rqsc-v7-0-v3-0-b3b2e7e9847a@kernel.org>
To: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Adrien Ricciardi <aricciardi@baylibre.com>, 
 Nicolas Pitre <npitre@baylibre.com>, 
 =?utf-8?q?Kornel_Dul=C4=99ba?= <mindal@semihalf.com>, 
 Atish Patra <atish.patra@linux.dev>, 
 Atish Kumar Patra <atishp@rivosinc.com>, 
 Vasudevan Srinivasan <vasu@rivosinc.com>, Ved Shanbhogue <ved@rivosinc.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 yunhui cui <cuiyunhui@bytedance.com>, Chen Pei <cp0613@linux.alibaba.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Weiwei Li <liwei1518@gmail.com>, 
 guo.wenjia23@zte.com.cn, Gong Shuai <gong.shuai@sanechips.com.cn>, 
 Gong Shuai <gsh517@gmail.com>, liu.qingtao2@zte.com.cn, 
 Reinette Chatre <reinette.chatre@intel.com>, 
 Tony Luck <tony.luck@intel.com>, Babu Moger <babu.moger@amd.com>, 
 Peter Newman <peternewman@google.com>, Fenghua Yu <fenghua.yu@intel.com>, 
 James Morse <james.morse@arm.com>, Ben Horgan <ben.horgan@arm.com>, 
 Dave Martin <Dave.Martin@arm.com>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Robert Moore <robert.moore@intel.com>, Sunil V L <sunilvl@ventanamicro.com>, 
 Drew Fustini <fustini@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 x86@kernel.org, linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
 devicetree@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2796; i=fustini@kernel.org;
 h=from:subject:message-id; bh=CSELH8cHpzjOmF3alV9G48Nrn3aORTFDw3pzNP6kshc=;
 b=owGbwMvMwCV2+43O4ZsaG3kYT6slMWTe+5DkFH7kiI/X6n//ZzzMXvRU0evlyrQ9SprrDnxb+
 ONyVOfXnI5SFgYxLgZZMUWWTR/yLizxCv26YP6LbTBzWJlAhjBwcQrARO6mMfzTOXzuuVfmqRqm
 axwmzhZCoWw/tITNXzlkPmPffVBvyaMXDH8l311NSS3teLgztOn2jPI7712z3576pm8onTDpdvu
 aln0sAA==
X-Developer-Key: i=fustini@kernel.org; a=openpgp;
 fpr=1B6F948213EA489734F3997035D5CD577C1E6010

Wire up the RISC-V QoS resctrl implementation:

Add a late_initcall that checks for the Ssqosid extension and, if
present, calls qos_resctrl_setup() to probe CBQRI controllers and
initialize the resctrl filesystem, then registers CPU hotplug callbacks.

Make CONFIG_RISCV_ISA_SSQOSID select ARCH_HAS_CPU_RESCTRL and
RESCTRL_FS, and depends on MISC_FILESYSTEMS.

Add qos_resctrl.o to the build when CONFIG_RISCV_ISA_SSQOSID is set.

Co-developed-by: Adrien Ricciardi <aricciardi@baylibre.com>
Signed-off-by: Adrien Ricciardi <aricciardi@baylibre.com>
Signed-off-by: Drew Fustini <fustini@kernel.org>
---
 arch/riscv/Kconfig             |  3 +++
 arch/riscv/kernel/qos/Makefile |  2 +-
 arch/riscv/kernel/qos/qos.c    | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 92d2265a0c61..b2fef15b3d4f 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -597,7 +597,10 @@ config RISCV_ISA_SVNAPOT
 
 config RISCV_ISA_SSQOSID
 	bool "Ssqosid extension support for supervisor mode Quality of Service ID"
+	depends on MISC_FILESYSTEMS
 	default n
+	select ARCH_HAS_CPU_RESCTRL
+	select RESCTRL_FS
 	help
 	  Adds support for the Ssqosid ISA extension (Supervisor-mode
 	  Quality of Service ID).
diff --git a/arch/riscv/kernel/qos/Makefile b/arch/riscv/kernel/qos/Makefile
index 9f996263a86d..9ed0c13a854d 100644
--- a/arch/riscv/kernel/qos/Makefile
+++ b/arch/riscv/kernel/qos/Makefile
@@ -1,2 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_RISCV_ISA_SSQOSID) += qos.o
+obj-$(CONFIG_RISCV_ISA_SSQOSID) += qos.o qos_resctrl.o
diff --git a/arch/riscv/kernel/qos/qos.c b/arch/riscv/kernel/qos/qos.c
index a3c2b910e2e0..560607abf10a 100644
--- a/arch/riscv/kernel/qos/qos.c
+++ b/arch/riscv/kernel/qos/qos.c
@@ -1,8 +1,40 @@
 // SPDX-License-Identifier: GPL-2.0-only
+#include <linux/slab.h>
+#include <linux/err.h>
+#include <linux/cpu.h>
+#include <linux/cpumask.h>
+#include <linux/riscv_qos.h>
+
+#include <asm/csr.h>
 #include <asm/qos.h>
 
+#include "internal.h"
+
 /* cached value of srmcfg csr for each cpu */
 DEFINE_PER_CPU(u32, cpu_srmcfg);
 
 /* default srmcfg value for each cpu, set via resctrl cpu assignment */
 DEFINE_PER_CPU(u32, cpu_srmcfg_default);
+
+static int __init qos_arch_late_init(void)
+{
+	int err;
+
+	if (!riscv_isa_extension_available(NULL, SSQOSID))
+		return -ENODEV;
+
+	err = qos_resctrl_setup();
+	if (err)
+		return err;
+
+	err = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "qos:online",
+				qos_resctrl_online_cpu,
+				qos_resctrl_offline_cpu);
+	if (err < 0) {
+		resctrl_exit();
+		return err;
+	}
+
+	return 0;
+}
+late_initcall(qos_arch_late_init);

-- 
2.43.0

