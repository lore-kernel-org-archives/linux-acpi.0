Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E22331D375;
	Wed, 15 Apr 2026 01:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776218218; cv=none; b=pmriudOb30MXnehVsebb/l3K9GuiIxuZkfwGEgDhd8Bk9Rb0FKhyFoB7UrlJhno7YJpxtjX2z9InpBVoHCIzH2sCKnaaldIl3esU56DLevS0Q4bZDk3Ak50iq7w1kOjxjP5na8LQ6NFleq+VWEVYrd8vy7MDb107unXa2/Wd8LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776218218; c=relaxed/simple;
	bh=0N3/ljaEoSaUAHRrhb7+qug0MyFe8aVMQaHOTujWe+c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M2YaMInZZxN9EdroZAPRN9a8KL5dqlHIOHMHb+J48KKO3wXbYrHxgBZ+c1qPy/x7996YuLCMUFZ9LAjjUDU+ze8bESaYgNC+I6r0RUikM8oj0fOd0D6jc/QwrgfblNvpLWVkwYBVgdgm2FZYjOLjzf4B8Yon0MfKZFagb5T2yEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=COednS5x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="COednS5x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FF4DC2BCB6;
	Wed, 15 Apr 2026 01:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776218217;
	bh=0N3/ljaEoSaUAHRrhb7+qug0MyFe8aVMQaHOTujWe+c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=COednS5xkmkPeIH5UZ9fhjGZh6IFHWQ870eksHvpTxUC82DvVrVKrvMvFcSlDciKc
	 lKjjyNUULxL+ywqyR7ZG4i6mPUZA0DG09/pbn0LpEMcHgHPfhe++uDIBaYHpndbAV1
	 0+Ar3lFDCCuDCMinwPXXU3RCi5Q+9OrPeL5E89boZ78CEmzCpEPmorN6WqDF9qys3F
	 LT8RPrJ6k0mTUyCIEPKw+Rq19tvFXI406fCQX3orBB7YxsWvBXVFEoVfWfed0cMIWh
	 5dSS/TbpSHiw+OXbx2RTnKPotdRZ/RdjBUGrtxkKh714C49JPyOc4Gdlhb7RXE2kNG
	 mAk5+BXpNnxJA==
From: Drew Fustini <fustini@kernel.org>
Date: Tue, 14 Apr 2026 18:54:03 -0700
Subject: [PATCH RFC v3 09/11] DO NOT MERGE: include: acpi: actbl2: Add
 structs for RQSC table
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-ssqosid-cbqri-rqsc-v7-0-v3-9-b3b2e7e9847a@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2611; i=fustini@kernel.org;
 h=from:subject:message-id; bh=0N3/ljaEoSaUAHRrhb7+qug0MyFe8aVMQaHOTujWe+c=;
 b=owGbwMvMwCV2+43O4ZsaG3kYT6slMWTe+5AsfEfuo747Z9cOma99R+4qpVT97FPlOZ8tPXGSW
 XS1bPCDjlIWBjEuBlkxRZZNH/IuLPEK/bpg/ottMHNYmUCGMHBxCsBE4n8xMuybaPnTJbxsb+cl
 rYRpn7cL3t9+qMb203z9qt7l77/t7FVi+O/54Zqc6nT/faF/nP6Wrtnaav/ShddS1IV3bwXvMgu
 VPQwA
X-Developer-Key: i=fustini@kernel.org; a=openpgp;
 fpr=1B6F948213EA489734F3997035D5CD577C1E6010

Add structs for the RQSC table which describes the properties of the
RISC-V QoS controllers (CBQRI) in the system. The table also describes
the topological arrangement of the QoS controllers and resources in the
system. The topology is expressed in terms of the location of the
resources within the system and the relation between the QoS Controller
and the resource it manages.

Note: This is a placeholder for RFC review purposes. The actbl2.h
change must go through upstream ACPICA first and will be replaced by
the auto-generated ACPICA commit once the RQSC spec is ratified.

Link: https://github.com/riscv-non-isa/riscv-cbqri/releases/tag/v1.0
Link: https://github.com/riscv-non-isa/riscv-rqsc/blob/main/src/chapter2.adoc
Signed-off-by: Drew Fustini <fustini@kernel.org>
---
 include/acpi/actbl2.h | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 5c0b55e7b3e4..d6f272e848fa 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -55,6 +55,7 @@
 #define ACPI_SIG_RGRT           "RGRT"	/* Regulatory Graphics Resource Table */
 #define ACPI_SIG_RHCT           "RHCT"	/* RISC-V Hart Capabilities Table */
 #define ACPI_SIG_RIMT           "RIMT"	/* RISC-V IO Mapping Table */
+#define ACPI_SIG_RQSC           "RQSC"	/* RISC-V Quality of Service Controller */
 #define ACPI_SIG_SBST           "SBST"	/* Smart Battery Specification Table */
 #define ACPI_SIG_SDEI           "SDEI"	/* Software Delegated Exception Interface Table */
 #define ACPI_SIG_SDEV           "SDEV"	/* Secure Devices table */
@@ -3351,6 +3352,41 @@ enum acpi_rgrt_image_type {
 	ACPI_RGRT_TYPE_RESERVED = 2	/* 2 and greater are reserved */
 };
 
+/*******************************************************************************
+ *
+ * RQSC - RISC-V Quality of Service Controller
+ *        Version 1
+ *
+ ******************************************************************************/
+
+struct acpi_table_rqsc_fields_res {
+	u8 type;
+	u8 resv;
+	u16 length;
+	u16 flags;
+	u8 resv2;
+	u8 id_type;
+	u64 id1;
+	u32 id2;
+};
+
+struct acpi_table_rqsc_fields {
+	u8 type;
+	u8 resv;
+	u16 length;
+	u32 reg[3];
+	u16 rcid;
+	u16 mcid;
+	u16 flags;
+	u16 nres;
+	struct acpi_table_rqsc_fields_res res[];
+};
+
+struct acpi_table_rqsc {
+	struct acpi_table_header header;	/* Common ACPI table header */
+	u32 num;
+};
+
 /*******************************************************************************
  *
  * RHCT - RISC-V Hart Capabilities Table

-- 
2.43.0

