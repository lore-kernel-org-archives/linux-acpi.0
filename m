Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793808937;
	b=ksA67qj+IIoAX/NsgigjpREURRDD2kUo1urjejNicfW6a4H04pI8UAAWLIccaOlf6Ytg
	 t3d7XX93+ZjQJB+CnpiLlP/wRBOuJSg99s5SZ38nKhfwPrk5JQ6T13x808wy458Vj/bYa
	 /XwxHctBURfBYZxiIDX28I9GLABsvWHQqYMu7q7gdbhKxbCAiY7JfK0BJwoTmvsUwg/Zn
	 KX5VpJzjsIavDWqnOMZ5WThHtKcbc8hgDkcNZR4Fekhfc7LGxxoDZbT1+ZUhFria1ZZeP
	 IuCRPcEqmEIk0ArbFnUi2E37UbH3sf+TfvY/wOyHV87h12XXbxT3RJ6SG+/QO6+uBRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793808937;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:X-QCInternal:
	 X-QCInternal:X-Proofpoint-Reinject:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=R4FPde2GWtG41w/uDmZTrFrc8SLeDn7eMq8Wxt8FBm0=;
	b=dV5ZeVMIFJ78JHnX1DUszP0FifGRX6NDU7bGeAUnWv2ykyZkhQpjsWjvtAPjUaFa02nU
	 GmNS29ZBwRUrWH8yHBI78qjBsSYitOQhJTbWxDlkcyBwMC0zlJe9T8qulW070sP3uuLqY
	 anLCNFw0huSHtZ9B6TX898+5I3LBudSDV/UQxy7E9A+V1LQQdyKjnvTmvj7IsnVgEvEPk
	 75qhm7cHpxuqDPv6Ulg4/jKK8V2CffJiUaYgPZxFL9LPcPwYAXSVse3D705OrUJNjQ2Qu
	 FzsPRsYxFFi3Lyws+rZEGthjt517Xlh2ydVqmmNofp1gcRiJGr8ty3CzbwWNcfI04jQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZXxEQTL7;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EEB606A32C;
	Wed,  4 Nov 2026 16:15:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95EEB606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZXxEQTL7
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A4Fj98N3208786;
	Wed, 4 Nov 2026 16:15:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=R4FPde2GWtG
	41w/uDmZTrFrc8SLeDn7eMq8Wxt8FBm0=; b=ZXxEQTL7POCIi7RiKvgXcxOwBbF
	SjmClz2EQoyk3KPCP0FZHm6HQ1UmXAil8qV2V96OaSRB6dEvqIsycNDiGL8PyHGY
	HMxfNSNC21enF8Aad5sp1DoryIHias513hl+oa7Kl5LZ2AdGcNZsU55De4GoUs8i
	x8WZ2h6AnuECeKrqQCWMHMXImvgOr/4uZEeoTzzpMNqKe5EAxsodKcJvTNMa9m0G
	1N4i/xqEdphfOw4h04rP8pWD33jGHIJIEGflRHOQlCC1rJ9rYh+8Js+g5bSUdg89
	V2WCn4m0dQ78aQpwUzPjNkY4VQaVCB1V9SnrCCmQuakDxdB/QXE3dethIAg==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hr6bj0ev5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 16:15:16 +0000 (GMT)
Received: from pps.filterd (apblrppmta01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A4GFD4R3122608;
	Wed, 4 Nov 2026 16:15:13 GMT
Received: from hu-devc-blr-u24-a.qualcomm.com (hu-anuppate-blr.qualcomm.com [10.131.36.165])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 6A4GFDVh3122589
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 16:15:13 +0000 (GMT)
Received: by hu-devc-blr-u24-a.qualcomm.com (Postfix, from userid 486687)
	id 498D821C8D; Wed,  4 Nov 2026 21:45:13 +0530 (+0530)
From: Anup Patel <anup.patel@oss.qualcomm.com>
To: Sunil V L <sunilvl@oss.qualcomm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Alexandre Ghiti <alex@ghiti.fr>, Len Brown <lenb@kernel.org>,
        Atish Patra <atish.patra@linux.dev>, Anup Patel <anup@brainfault.org>,
        Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-acpi@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>, Nutty Liu <nutty.liu@hotmail.com>
Subject: [PATCH v7 1/1] RISC-V: Add common csr_read_num() and csr_write_num() functions
Date: Wed,  4 Nov 2026 21:45:12 +0530
Message-ID: <20261104161512.883885-2-anup.patel@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104161512.883885-1-anup.patel@oss.qualcomm.com>
References: <20261104161512.883885-1-anup.patel@oss.qualcomm.com>
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
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA2NCBTYWx0ZWRfXwAnxk2ghwFsN
 QjgTAYugO/iPijqI5vSNEA75+MKhjd2EBZZwIlCR9O08fSacjJWOnibgHfDPLl3gkZ2+e+i6Gfo
 VZQpXzXBykv11X5vPvhKLngAgg2b2qE/OCM/1vPOryWjaH0ZdRBWF9FFuhScC8KPZYuEwq+9mMH
 DxBmO32Ye5UXRsXfA8mIEpFHlEWZkTBSzoPHNKpUtSylADuVtPeQwL4HIBs99egtEXpF3dlnsIS
 1Wza0PKHAMSWVA0anMaEUynvNwav+J2lekfqK6rs6jF7VLzv3r56/gIiRie7bzDJlmv7SOGNrSl
 D6V983vxhISW5BqawAUYk07GqX/qK8vWFpghzFvYPur3i+S2e6utwe/VDdOvu4OV7T9ZSm46fIv
 CZSkBVMDm/09ZgeFD4x3XUjPrpDK+RqqGfGLqPxFcErnml+7SowrhLtcEmMpHqDCWz7rqCuff3W
 H1a4ON97cqJCuDePBlQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA2NCBTYWx0ZWRfX78z2Tzn+gzKh
 aWni1KcnHsR/0GFpo5xN5oNWAO5zEByHx3C345JPSNCbxwPKhM8R7fqrRltjA2nq0p3oUlg5Ieu
 I8LMXMv9ToHVuVrCgy2oLKj0Y7m4tPs=
X-Proofpoint-ORIG-GUID: moeEZhs-_lkqvMMILrN7eIUg7vde-6aM
X-Proofpoint-GUID: 5waNPHu7YVJJLm-fpegN97azIOMLoIxF
X-Authority-Analysis: v=2.4 cv=N/u8hG9B c=1 sm=1 tr=0 ts=6aeb5a15 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=bDdBU3oEAAAA:8 a=h0uksLzaAAAA:8 a=69EAbJreAAAA:8
 a=UqQj9CUkGb5smqcBsEgA:9 a=DN7SgORnOiO7RqxRx1GC:22 a=MSi_79tMYmZZG2gvAgS0:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040064

From: Anup Patel <apatel@ventanamicro.com>

In RISC-V, there is no CSR read/write instruction which takes CSR
number via register so add common csr_read_num() and csr_write_num()
functions which allow accessing certain CSRs by passing CSR number
as parameter. These common functions will be first used by the
ACPI CPPC driver and RISC-V PMU driver.

Also, the RISC-V ACPI FFH specification allows arbitrary CSR number
as CPPC register and the RISC-V SBI specification allows arbitrary
CSR number as PMU hardware counter. This means ACPI CPPC driver and
RISC-V PMU driver no longer need to do sanity checks on CSR number
which are now done by the common csr_read_num() and csr_write_num()
functions.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Atish Patra <atishp@rivosinc.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
---
 arch/riscv/include/asm/csr.h |   3 +
 arch/riscv/kernel/Makefile   |   1 +
 arch/riscv/kernel/csr.c      | 165 +++++++++++++++++++++++++++++++++++
 drivers/acpi/riscv/cppc.c    |  17 ++--
 drivers/perf/riscv_pmu.c     |  54 ++----------
 5 files changed, 184 insertions(+), 56 deletions(-)
 create mode 100644 arch/riscv/kernel/csr.c

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 621f84d1898f..ebd82043430b 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -672,6 +672,9 @@
 			      : "memory");			\
 })
 
+unsigned long csr_read_num(unsigned long csr_num, int *out_err);
+void csr_write_num(unsigned long csr_num, unsigned long val, int *out_err);
+
 #endif /* __ASSEMBLER__ */
 
 #endif /* _ASM_RISCV_CSR_H */
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index f54c336bf547..7f52ae724225 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -51,6 +51,7 @@ obj-y	+= soc.o
 obj-y	+= alternative.o
 obj-y	+= cpu.o
 obj-y	+= cpufeature.o
+obj-y	+= csr.o
 obj-y	+= entry.o
 obj-y	+= irq.o
 obj-y	+= process.o
diff --git a/arch/riscv/kernel/csr.c b/arch/riscv/kernel/csr.c
new file mode 100644
index 000000000000..e96b129c1a99
--- /dev/null
+++ b/arch/riscv/kernel/csr.c
@@ -0,0 +1,165 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Ventana Micro Systems Inc.
+ */
+
+#include <linux/err.h>
+#include <linux/export.h>
+#include <linux/types.h>
+#include <asm/csr.h>
+
+#define CSR_CUSTOM0_U_RW_BASE		0x800
+#define CSR_CUSTOM0_U_RW_COUNT		0x100
+
+#define CSR_CUSTOM1_U_RO_BASE		0xCC0
+#define CSR_CUSTOM1_U_RO_COUNT		0x040
+
+#define CSR_CUSTOM2_S_RW_BASE		0x5C0
+#define CSR_CUSTOM2_S_RW_COUNT		0x040
+
+#define CSR_CUSTOM3_S_RW_BASE		0x9C0
+#define CSR_CUSTOM3_S_RW_COUNT		0x040
+
+#define CSR_CUSTOM4_S_RO_BASE		0xDC0
+#define CSR_CUSTOM4_S_RO_COUNT		0x040
+
+#define CSR_CUSTOM5_HS_RW_BASE		0x6C0
+#define CSR_CUSTOM5_HS_RW_COUNT		0x040
+
+#define CSR_CUSTOM6_HS_RW_BASE		0xAC0
+#define CSR_CUSTOM6_HS_RW_COUNT		0x040
+
+#define CSR_CUSTOM7_HS_RO_BASE		0xEC0
+#define CSR_CUSTOM7_HS_RO_COUNT		0x040
+
+#define CSR_CUSTOM8_M_RW_BASE		0x7C0
+#define CSR_CUSTOM8_M_RW_COUNT		0x040
+
+#define CSR_CUSTOM9_M_RW_BASE		0xBC0
+#define CSR_CUSTOM9_M_RW_COUNT		0x040
+
+#define CSR_CUSTOM10_M_RO_BASE		0xFC0
+#define CSR_CUSTOM10_M_RO_COUNT		0x040
+
+unsigned long csr_read_num(unsigned long csr_num, int *out_err)
+{
+#define switchcase_csr_read(__csr_num)				\
+	case (__csr_num):					\
+		return csr_read(__csr_num)
+#define switchcase_csr_read_2(__csr_num)			\
+	switchcase_csr_read(__csr_num + 0);			\
+	switchcase_csr_read(__csr_num + 1)
+#define switchcase_csr_read_4(__csr_num)			\
+	switchcase_csr_read_2(__csr_num + 0);			\
+	switchcase_csr_read_2(__csr_num + 2)
+#define switchcase_csr_read_8(__csr_num)			\
+	switchcase_csr_read_4(__csr_num + 0);			\
+	switchcase_csr_read_4(__csr_num + 4)
+#define switchcase_csr_read_16(__csr_num)			\
+	switchcase_csr_read_8(__csr_num + 0);			\
+	switchcase_csr_read_8(__csr_num + 8)
+#define switchcase_csr_read_32(__csr_num)			\
+	switchcase_csr_read_16(__csr_num + 0);			\
+	switchcase_csr_read_16(__csr_num + 16)
+#define switchcase_csr_read_64(__csr_num)			\
+	switchcase_csr_read_32(__csr_num + 0);			\
+	switchcase_csr_read_32(__csr_num + 32)
+#define switchcase_csr_read_128(__csr_num)			\
+	switchcase_csr_read_64(__csr_num + 0);			\
+	switchcase_csr_read_64(__csr_num + 64)
+#define switchcase_csr_read_256(__csr_num)			\
+	switchcase_csr_read_128(__csr_num + 0);			\
+	switchcase_csr_read_128(__csr_num + 128)
+
+	*out_err = 0;
+	switch (csr_num) {
+	switchcase_csr_read_32(CSR_CYCLE);
+	switchcase_csr_read_32(CSR_CYCLEH);
+	switchcase_csr_read_256(CSR_CUSTOM0_U_RW_BASE);
+	switchcase_csr_read_64(CSR_CUSTOM1_U_RO_BASE);
+	switchcase_csr_read_64(CSR_CUSTOM2_S_RW_BASE);
+	switchcase_csr_read_64(CSR_CUSTOM3_S_RW_BASE);
+	switchcase_csr_read_64(CSR_CUSTOM4_S_RO_BASE);
+	switchcase_csr_read_64(CSR_CUSTOM5_HS_RW_BASE);
+	switchcase_csr_read_64(CSR_CUSTOM6_HS_RW_BASE);
+	switchcase_csr_read_64(CSR_CUSTOM7_HS_RO_BASE);
+#ifdef CONFIG_RISCV_M_MODE
+	switchcase_csr_read_64(CSR_CUSTOM8_M_RW_BASE);
+	switchcase_csr_read_64(CSR_CUSTOM9_M_RW_BASE);
+	switchcase_csr_read_64(CSR_CUSTOM10_M_RO_BASE);
+#endif
+	default:
+		*out_err = -EINVAL;
+		break;
+	}
+
+	return 0;
+#undef switchcase_csr_read_256
+#undef switchcase_csr_read_128
+#undef switchcase_csr_read_64
+#undef switchcase_csr_read_32
+#undef switchcase_csr_read_16
+#undef switchcase_csr_read_8
+#undef switchcase_csr_read_4
+#undef switchcase_csr_read_2
+#undef switchcase_csr_read
+}
+EXPORT_SYMBOL_GPL(csr_read_num);
+
+void csr_write_num(unsigned long csr_num, unsigned long val, int *out_err)
+{
+#define switchcase_csr_write(__csr_num, __val)			\
+	case (__csr_num):					\
+		csr_write(__csr_num, __val);			\
+		break
+#define switchcase_csr_write_2(__csr_num, __val)		\
+	switchcase_csr_write(__csr_num + 0, __val);		\
+	switchcase_csr_write(__csr_num + 1, __val)
+#define switchcase_csr_write_4(__csr_num, __val)		\
+	switchcase_csr_write_2(__csr_num + 0, __val);		\
+	switchcase_csr_write_2(__csr_num + 2, __val)
+#define switchcase_csr_write_8(__csr_num, __val)		\
+	switchcase_csr_write_4(__csr_num + 0, __val);		\
+	switchcase_csr_write_4(__csr_num + 4, __val)
+#define switchcase_csr_write_16(__csr_num, __val)		\
+	switchcase_csr_write_8(__csr_num + 0, __val);		\
+	switchcase_csr_write_8(__csr_num + 8, __val)
+#define switchcase_csr_write_32(__csr_num, __val)		\
+	switchcase_csr_write_16(__csr_num + 0, __val);		\
+	switchcase_csr_write_16(__csr_num + 16, __val)
+#define switchcase_csr_write_64(__csr_num, __val)		\
+	switchcase_csr_write_32(__csr_num + 0, __val);		\
+	switchcase_csr_write_32(__csr_num + 32, __val)
+#define switchcase_csr_write_128(__csr_num, __val)		\
+	switchcase_csr_write_64(__csr_num + 0, __val);		\
+	switchcase_csr_write_64(__csr_num + 64, __val)
+#define switchcase_csr_write_256(__csr_num, __val)		\
+	switchcase_csr_write_128(__csr_num + 0, __val);		\
+	switchcase_csr_write_128(__csr_num + 128, __val)
+
+	*out_err = 0;
+	switch (csr_num) {
+	switchcase_csr_write_256(CSR_CUSTOM0_U_RW_BASE, val);
+	switchcase_csr_write_64(CSR_CUSTOM2_S_RW_BASE, val);
+	switchcase_csr_write_64(CSR_CUSTOM3_S_RW_BASE, val);
+	switchcase_csr_write_64(CSR_CUSTOM5_HS_RW_BASE, val);
+	switchcase_csr_write_64(CSR_CUSTOM6_HS_RW_BASE, val);
+#ifdef CONFIG_RISCV_M_MODE
+	switchcase_csr_write_64(CSR_CUSTOM8_M_RW_BASE, val);
+	switchcase_csr_write_64(CSR_CUSTOM9_M_RW_BASE, val);
+#endif
+	default:
+		*out_err = -EINVAL;
+		break;
+	}
+#undef switchcase_csr_write_256
+#undef switchcase_csr_write_128
+#undef switchcase_csr_write_64
+#undef switchcase_csr_write_32
+#undef switchcase_csr_write_16
+#undef switchcase_csr_write_8
+#undef switchcase_csr_write_4
+#undef switchcase_csr_write_2
+#undef switchcase_csr_write
+}
+EXPORT_SYMBOL_GPL(csr_write_num);
diff --git a/drivers/acpi/riscv/cppc.c b/drivers/acpi/riscv/cppc.c
index 74a5e484f809..da1a849ddc29 100644
--- a/drivers/acpi/riscv/cppc.c
+++ b/drivers/acpi/riscv/cppc.c
@@ -65,24 +65,19 @@ static void sbi_cppc_write(void *write_data)
 static void cppc_ffh_csr_read(void *read_data)
 {
 	struct sbi_cppc_data *data = (struct sbi_cppc_data *)read_data;
+	int err;
 
-	switch (data->reg) {
-	/* Support only TIME CSR for now */
-	case CSR_TIME:
-		data->ret.value = csr_read(CSR_TIME);
-		data->ret.error = 0;
-		break;
-	default:
-		data->ret.error = -EINVAL;
-		break;
-	}
+	data->ret.value = csr_read_num(data->reg, &err);
+	data->ret.error = err;
 }
 
 static void cppc_ffh_csr_write(void *write_data)
 {
 	struct sbi_cppc_data *data = (struct sbi_cppc_data *)write_data;
+	int err;
 
-	data->ret.error = -EINVAL;
+	csr_write_num(data->reg, data->val, &err);
+	data->ret.error = err;
 }
 
 /*
diff --git a/drivers/perf/riscv_pmu.c b/drivers/perf/riscv_pmu.c
index 8e3cd0f35336..751a8651dc3d 100644
--- a/drivers/perf/riscv_pmu.c
+++ b/drivers/perf/riscv_pmu.c
@@ -16,6 +16,7 @@
 #include <linux/smp.h>
 #include <linux/sched_clock.h>
 
+#include <asm/csr.h>
 #include <asm/sbi.h>
 
 static bool riscv_perf_user_access(struct perf_event *event)
@@ -88,58 +89,21 @@ void arch_perf_update_userpage(struct perf_event *event,
 	userpg->cap_user_time_short = 1;
 }
 
-static unsigned long csr_read_num(int csr_num)
-{
-#define switchcase_csr_read(__csr_num, __val)		{\
-	case __csr_num:					\
-		__val = csr_read(__csr_num);		\
-		break; }
-#define switchcase_csr_read_2(__csr_num, __val)		{\
-	switchcase_csr_read(__csr_num + 0, __val)	 \
-	switchcase_csr_read(__csr_num + 1, __val)}
-#define switchcase_csr_read_4(__csr_num, __val)		{\
-	switchcase_csr_read_2(__csr_num + 0, __val)	 \
-	switchcase_csr_read_2(__csr_num + 2, __val)}
-#define switchcase_csr_read_8(__csr_num, __val)		{\
-	switchcase_csr_read_4(__csr_num + 0, __val)	 \
-	switchcase_csr_read_4(__csr_num + 4, __val)}
-#define switchcase_csr_read_16(__csr_num, __val)	{\
-	switchcase_csr_read_8(__csr_num + 0, __val)	 \
-	switchcase_csr_read_8(__csr_num + 8, __val)}
-#define switchcase_csr_read_32(__csr_num, __val)	{\
-	switchcase_csr_read_16(__csr_num + 0, __val)	 \
-	switchcase_csr_read_16(__csr_num + 16, __val)}
-
-	unsigned long ret = 0;
-
-	switch (csr_num) {
-	switchcase_csr_read_32(CSR_CYCLE, ret)
-	switchcase_csr_read_32(CSR_CYCLEH, ret)
-	default :
-		break;
-	}
-
-	return ret;
-#undef switchcase_csr_read_32
-#undef switchcase_csr_read_16
-#undef switchcase_csr_read_8
-#undef switchcase_csr_read_4
-#undef switchcase_csr_read_2
-#undef switchcase_csr_read
-}
-
 /*
  * Read the CSR of a corresponding counter.
  */
 unsigned long riscv_pmu_ctr_read_csr(unsigned long csr)
 {
-	if (csr < CSR_CYCLE || csr > CSR_HPMCOUNTER31H ||
-	   (csr > CSR_HPMCOUNTER31 && csr < CSR_CYCLEH)) {
-		pr_err("Invalid performance counter csr %lx\n", csr);
-		return -EINVAL;
+	unsigned long val;
+	int rc;
+
+	val = csr_read_num(csr, &rc);
+	if (rc) {
+		pr_err("Failed to read performance counter csr %lx (error %d)\n", csr, rc);
+		return rc;
 	}
 
-	return csr_read_num(csr);
+	return val;
 }
 
 u64 riscv_pmu_ctr_get_width_mask(struct perf_event *event)
-- 
2.43.0

