Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76833324B23;
	Wed, 15 Apr 2026 01:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776218219; cv=none; b=MLh8iiD6peOLz1vHDNaLJOC8oXzhuMQJWEqElj8IH/UtBSafs2NdnDNtwtlysDf3IghKdjHiwCdBAvC9swtPI3bzmvd0ZHMbrrkilnuCEc7crthQMKMYBbTHHciR+mTOqKKrCEvIwKx+nHWs63sWn1PjOR7OaoCYyrvjbUH1Q8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776218219; c=relaxed/simple;
	bh=Av0Nv9qYcvDtXSrfBVWD8C8RBkR90ZNKGubCs7xRSJk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bj2Xlejpu1cG52J8aDSISRzvV5mNmwzL5f6PCKKIHUhJI6geq8oIvlK7bZcw3SGTusNmRJ7R7DhEVLdivGk6D6162Q2M5Y9YOxUFdh2inLt87npc+yqMnFujvOfvMLKBJ5mNXa6UEVZolaYUp1Lr8mXeQgmIvsjyayqYZBGg9n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I7HV+sm/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I7HV+sm/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF31AC2BCC9;
	Wed, 15 Apr 2026 01:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776218219;
	bh=Av0Nv9qYcvDtXSrfBVWD8C8RBkR90ZNKGubCs7xRSJk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=I7HV+sm/tIkU114gKkjZgkZD0WSpdiA8OxGnu5ffp6iizlNtje9BW8J6MjZ7Y0ihV
	 VNWcePI0q9B+GneSfXvMxj9PddssHjuR5bB5/UaA6K86yz3XCwAK/X478JMj/CX855
	 6rzZmbAQJO1ib3Ex+ojFWvM9P1a0E6GpYP7OYLkJy0hmojBkswrJ+5MJXmmSK6ZIuR
	 tJ/xELc8UrmWN0khc+o2rPjQRAm0150vEyD0J1RyDE08D5Veeu3CGUin7EG0JrVW9X
	 kd5dVMVW8tAdG9tJDpJQxnB1X5326gLSrm5acKChAnI22j7a5ykc/NOibX+6SEkaQ0
	 3GKg4EbEPsbwA==
From: Drew Fustini <fustini@kernel.org>
Date: Tue, 14 Apr 2026 18:54:05 -0700
Subject: [PATCH RFC v3 11/11] ACPI: RISC-V: Add support for RISC-V Quality
 of Service Controller (RQSC)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-ssqosid-cbqri-rqsc-v7-0-v3-11-b3b2e7e9847a@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1644; i=fustini@kernel.org;
 h=from:subject:message-id; bh=Av0Nv9qYcvDtXSrfBVWD8C8RBkR90ZNKGubCs7xRSJk=;
 b=owGbwMvMwCV2+43O4ZsaG3kYT6slMWTe+5D8zXvm26QrV/ZXV+k1PNTnvF/1mvlHw+HFPWtfL
 p7ae0wosqOUhUGMi0FWTJFl04e8C0u8Qr8umP9iG8wcViaQIQxcnAIwkVY+RobfriYrLjDtKriy
 9P1+IdfVYQcv3p9vrcOyeDHDLn+VHY8eMvwV4O5JmV1/ZuLR4JVrVt5meFP8+Jm1rlGrtVG3yAn
 3zn/sAA==
X-Developer-Key: i=fustini@kernel.org; a=openpgp;
 fpr=1B6F948213EA489734F3997035D5CD577C1E6010

Call acpi_parse_rqsc() from acpi_arch_init() to discover CBQRI
controllers when an RQSC table is present. The RQSC table is optional;
AE_NOT_FOUND is silenced since many systems will not have QoS
controllers. Other ACPI failures are reported as errors.

Link: https://github.com/riscv-non-isa/riscv-cbqri/releases/tag/v1.0
Link: https://github.com/riscv-non-isa/riscv-rqsc/blob/main/src/
Signed-off-by: Drew Fustini <fustini@kernel.org>
---
 drivers/acpi/riscv/init.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/acpi/riscv/init.c b/drivers/acpi/riscv/init.c
index 7c00f7995e86..8a74dff42dce 100644
--- a/drivers/acpi/riscv/init.c
+++ b/drivers/acpi/riscv/init.c
@@ -4,12 +4,35 @@
  *	Author: Sunil V L <sunilvl@ventanamicro.com>
  */
 
+#define pr_fmt(fmt) "ACPI: RQSC: " fmt
+
 #include <linux/acpi.h>
 #include "init.h"
 
 void __init acpi_arch_init(void)
 {
+	struct acpi_table_header *rqsc;
+	acpi_status status;
+	int rc;
+
 	riscv_acpi_init_gsi_mapping();
+
 	if (IS_ENABLED(CONFIG_ACPI_RIMT))
 		riscv_acpi_rimt_init();
+
+	if (IS_ENABLED(CONFIG_RISCV_ISA_SSQOSID) && !acpi_disabled) {
+		status = acpi_get_table(ACPI_SIG_RQSC, 0, &rqsc);
+		if (status == AE_NOT_FOUND) {
+			/* RQSC is optional; silence on systems without it */
+		} else if (ACPI_FAILURE(status)) {
+			pr_err("failed to get ACPI RQSC table: %s\n",
+			       acpi_format_exception(status));
+		} else {
+			rc = acpi_parse_rqsc(rqsc);
+			if (rc < 0)
+				pr_err("failed to parse ACPI RQSC table: %d\n",
+				       rc);
+			acpi_put_table(rqsc);
+		}
+	}
 }

-- 
2.43.0

