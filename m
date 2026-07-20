Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168BD3CB576
	for <linux-acpi@vger.kernel.org>; Mon, 20 Jul 2026 08:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784535621; cv=none; b=huFbFMSSHp52CvI0cdxJhEaEDny/YF2Fzoy6w19IvuqFHiYCMmXrw/aytDPscCOEXfRHWP/eAANdpT6hSTFFV8z8inCKImmcXlQsM+8dzvF8C8QP+Jb43lJF2cPMjgI+wLBb9Mw2V+PFOD2yXn5ZHTJt0Htd8tQf7k73z9HsgV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784535621; c=relaxed/simple;
	bh=Zs6yHyGlOkLBwoiIX0mmI9rr275yhsIp1tz4XYL5/N0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mp8/hZ3dlSAe24VKfihHe0fO/cxUjLvGSHWL3IO81psCBjiCVeXMFNSmaehOedgdM403vD+02qbp9c6R0Jcpt9BU26W8jfC4+M/WDW4EryvgEtQjaQIqjhtyWAfxcpDDoFX9QVr33q7iDgfFF3V7fSgFR1napnjvLlCRiT8UBAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XgBMffeA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KIIhFztv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XgBMffeA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KIIhFztv"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66K6RUxV1665561
	for <linux-acpi@vger.kernel.org>; Mon, 20 Jul 2026 08:20:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mxlznir44QT4fbT8ashR/NG4UbUm2QhST//sNV2T/EU=; b=XgBMffeA3/wA+Qiz
	M1O1dBSQme2yAP8BrVHsZkVasEn79SRhRD181yf1LU34+0vysRtodRWfk6jBJqc9
	3hLUCf+R8u9kGhzIbzRlJ2TwbB44OTiMcXCisEhn0+vm1AWHjgRhvIVeS6R8QW4q
	RbLwCr59F3XenaOeifiHsJwDfqnYEZiGd6ZlOB4XXumVsMIegDQg6cHbA4wfoq5P
	qDGeEElXacJdAWfhiLHs4JJXyPUP2ipIZ6+mv0mv3O2lblCZxK0fUw7b0ukvLf9S
	wKbzwyq/kZe8B2RPW1SXGC1LJTWNEXf4/Ad1SPM0BDaKDiyyR4YZtjb+NAjXQNfS
	3hhweg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fgd04v574-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Mon, 20 Jul 2026 08:20:14 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-384cb1637c2so2892484a91.2
        for <linux-acpi@vger.kernel.org>; Mon, 20 Jul 2026 01:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784535613; x=1785140413; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mxlznir44QT4fbT8ashR/NG4UbUm2QhST//sNV2T/EU=;
        b=KIIhFztvJ6VgHeNf6XIEjLWx4aLAeby07M5adtLLCuRxNJlydOWmvFA6qvCozUNFfZ
         BOrRD+dXZBV33wCWfASo1gk+wZJMhFUYp+nqsg5hHAn3eTMCPhUZqIuVBp1A/ys6oLFd
         bjQijOZ/UmHqy8E4KutRB0+Og1HAzQrYd8VYzmSdZ7DlPrvHkIEx5UdRaB6h2lLNUdvG
         Crtx1G1Yw0p0oGMYePYlXY/yrNXVwtH1iL8THs2hqsjqOGomQHvcy90eFqF4P+tC2l07
         QJZZXZ9gQUXCeB2AiGDKW7bo/04K5duYGGGLt3VJ1a+DSQhDWXeCFX7N1vqpeQabcymq
         yd4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784535613; x=1785140413;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mxlznir44QT4fbT8ashR/NG4UbUm2QhST//sNV2T/EU=;
        b=GY+ZfdigcZPJ9wun9jDJxcgUC/RG2ekO09oYF9r8KWl5V2v7BKVVzLlSUavBHbHng5
         u0JZ2ywv6OplOxqVGu5DC+IjteJrP9jheTltqI0nET+QOoizY+fuzCq0EtHIjKA0EKpx
         e1EfpsVCgrlXmzxOT6eLFdFrDPdFUUeIHsPGmepoQOE4JSMwVdYTx4FrrM6BF96WhG5i
         t+Xm1gpuKdfmCTF75G1yZgfdVDBkEHmzs2zgmYkYTUXCIcwU5eiqHtlfharNY/obYq9J
         EXVgRz+ZMdRbAfmS7lQW9mKMfgtWt6pF3/rtbYuQlx58gs5W7NJhEjyt1c5MUXkjcjcw
         CJrw==
X-Forwarded-Encrypted: i=1; AHgh+RprI5VzOqnuPcYUgnmRjeM2pa0cqOYegBqO/SJqfVqucCSPkjKpLLbd/8McF7/deZfLTlV1L8yKrjpm@vger.kernel.org
X-Gm-Message-State: AOJu0YxUbE7Bk/Zsje2xJJ8y/18fFRjTR6YK4J9tYF1hc3q9uYaqfkS5
	A41eZ9AztZCdydPl1lFSxB4g5KyhuFaZa8JDTPSxa9ib7PLzvRYRYqvHNJGd5OnvkZOWqEZKvaR
	N02xAVi+Y+gKGakTPti3RmrVMDRkrPyr/iIJOOQpYYtFR4hRFz7T+EJDjwLceUKevpUpQXMaP
X-Gm-Gg: AR+sD11MAYFFn9LpMK9C8T6nIBdyhO7lqRqgxk0YiSgZ4yL77vGRBchlHObTrDMn4jq
	IS4usSPbNsXkLtL0gIXa6X7tY4tb8gFBYHJVW+pni+GbWAMoVBLHebAEbHdgxBg0a9ovAZwEugg
	J7xBq51NqezTeaUiwPzkNEwDjMLVE4++Zs126EqvSeXIEv3PtRBoQLjMCngX1eZFYI6mrKJSgHu
	6K8I2/3ySTPdqEFsKGvTr7FJeJIvTMup/ZW8xM5XriFif1Y/lMAQWf7kwZkBeTkYDp5tFzeFMkE
	Xg6g6pq3QBedrleyo57zhZcvSL2B1sZtGFSwcBaicZod7E6iu1w9f+lbQNvLKNt9/mTUaCUYdfb
	IoQoehNxhRYmn8dIBwmdkNycXdG9Zfjk=
X-Received: by 2002:a17:90b:5887:b0:380:9cd1:d985 with SMTP id 98e67ed59e1d1-38e4b698d49mr10706366a91.6.1784535613186;
        Mon, 20 Jul 2026 01:20:13 -0700 (PDT)
X-Received: by 2002:a17:90b:5887:b0:380:9cd1:d985 with SMTP id 98e67ed59e1d1-38e4b698d49mr10706341a91.6.1784535612706;
        Mon, 20 Jul 2026 01:20:12 -0700 (PDT)
Received: from hu-uchheda-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e39e0531asm7233688a91.5.2026.07.20.01.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 01:20:12 -0700 (PDT)
From: Umang Chheda <umang.chheda@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Ruidong Tian <tianruidong@linux.alibaba.com>,
        Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        Umang Chheda <umang.chheda@oss.qualcomm.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org,
        faruque.ansari@oss.qualcomm.com, avaneesh.dwivedi@oss.qualcomm.com
Subject: [PATCH v2 2/4] arm64: ras: Add Device Tree frontend
Date: Mon, 20 Jul 2026 13:49:52 +0530
Message-Id: <20260720081954.1858180-3-umang.chheda@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260720081954.1858180-1-umang.chheda@oss.qualcomm.com>
References: <20260720081954.1858180-1-umang.chheda@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=POs/P/qC c=1 sm=1 tr=0 ts=6a5dda3e cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=aBVxLUBa_37c2xUlyAEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA5MCBTYWx0ZWRfX4xwUUiJxpKk0
 QrszEp95JimOun4lYd1wJQC4puyJvQwAcJFn6qDRqIPh4f/KryXHjOq/HqtBYDwq3yCGjtMrYmX
 kXIugRmW/nRyuWgvZIH7kMVg6ckKJ5+9mxYfo/h8o0VmwQcktj0GH/cHODXhdLxY54ckJu525gQ
 UfDJeSp9wwMkRnBivBRQXcfwqjEBwzQComsvDv9VnZg/dTDv5EDhZuvcAfbPJ9WQ1DDvK/iQfC8
 0TatWdlPmjuQVBFEhdttru8ns0YDffUxaugpxo1aZrsN8Ksgl3jGx7gjh4ITLsl1dvxvVw321z5
 B7FbRowJX5pW/8GdY6sKQ1afQq4E00G8wYrlcPqFRflUZKIJjUq+RMYOueEOE0Jo/2ql1laRGBb
 7ZOCKA1VsBLZPvBU+/FFF85XB2YnR5suDLF61jWwQPFnfNZOnIjheUqGV2rwlu3ejDxPGc3p+kx
 p9Ts1u81rORG2IB0wAA==
X-Proofpoint-ORIG-GUID: 72dJRfNTJdeMiiej-38tQgRbbGjWFqP5
X-Proofpoint-GUID: 72dJRfNTJdeMiiej-38tQgRbbGjWFqP5
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA5MCBTYWx0ZWRfX9wIduH0rbi1Y
 mUOu5ZNMMUyQlUOUBYjWTs9P+sP1u1qHsP4olW5/0BdBgKSZ/+ihdlnMOBhSh5FVN5HySfA6/0W
 JrbgbFaQEeur7e/Vmpd9jkFOdxg/Y70=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200090

Add a Device Tree frontend for the ARM64 RAS driver, allowing it
to be used on platforms without ACPI firmware.

The error sources defined in DT are registered as arm64_ras platform
devices at boot. The frontend produces the same software fwnode properties
as the ACPI path, so the core driver probes DT and ACPI nodes identically
without any firmware-specific knowledge.

Signed-off-by: Umang Chheda <umang.chheda@oss.qualcomm.com>
---
 drivers/ras/arm64/Kconfig  |  25 ++-
 drivers/ras/arm64/Makefile |   2 +
 drivers/ras/arm64/ras-of.c | 383 +++++++++++++++++++++++++++++++++++++
 3 files changed, 405 insertions(+), 5 deletions(-)
 create mode 100644 drivers/ras/arm64/ras-of.c

diff --git a/drivers/ras/arm64/Kconfig b/drivers/ras/arm64/Kconfig
index dcdeaa216d67..8bdb219bc90f 100644
--- a/drivers/ras/arm64/Kconfig
+++ b/drivers/ras/arm64/Kconfig
@@ -1,16 +1,31 @@
 # SPDX-License-Identifier: GPL-2.0
 #
-# ARM Error Source Table Support
+# ARM RAS driver
 #
 # Copyright (c) 2025, Alibaba Group.
 #

+config ARM64_RAS_DT
+	bool "ARM64 RAS Device Tree support"
+	depends on ARM64_RAS_EXTN && OF
+	help
+	  Enable Device Tree support for the ARM64 RAS driver.
+
+	  When selected, RAS error sources described in the Device Tree
+	  (arm,ras-processor, arm,ras-smmu, arm,ras-gic etc) are registered
+	  as platform devices at boot, allowing the driver to be used on
+	  platforms without ACPI firmware.
+
 config ARM64_RAS_DRIVER
 	tristate "ARM64 RAS Driver"
-	depends on ARM64 && ACPI_AEST && RAS
+	depends on ARM64 && (ACPI_AEST || ARM64_RAS_DT) && RAS
 	help
-	  This is the RAS driver for the arm64 architecture. It depends on
-	  the Arm Error Source Table (AEST) to provide basic register and
-	  interrupt information.
+	  This is the RAS driver for the arm64 architecture. It uses the
+	  ARMv8 RAS extension register interface to discover, configure,
+	  and handle hardware errors from processor caches, SMMUs, and GICs.
+
+	  On ACPI systems the error source topology is provided by the AEST
+	  ACPI table (requires ACPI_AEST).  On Device Tree systems it is
+	  provided by "arm,ras-*" nodes in the DT root (requires ARM64_RAS_DT).

 	  If set, the kernel will report and process hardware errors.
diff --git a/drivers/ras/arm64/Makefile b/drivers/ras/arm64/Makefile
index 6897798f7314..aee2f9de37f6 100644
--- a/drivers/ras/arm64/Makefile
+++ b/drivers/ras/arm64/Makefile
@@ -7,3 +7,5 @@ arm64_ras-y		+= ras-sysfs.o
 arm64_ras-y		+= ras-inject.o
 arm64_ras-y		+= ras-cmn.o
 arm64_ras-y		+= ras-storm.o
+
+obj-$(CONFIG_ARM64_RAS_DT)	+= ras-of.o
diff --git a/drivers/ras/arm64/ras-of.c b/drivers/ras/arm64/ras-of.c
new file mode 100644
index 000000000000..e1aa8e13c077
--- /dev/null
+++ b/drivers/ras/arm64/ras-of.c
@@ -0,0 +1,383 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <linux/acpi.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/slab.h>
+
+#include <linux/acpi_aest.h>
+
+#undef pr_fmt
+#define pr_fmt(fmt) "DT RAS: " fmt
+
+/* Maximum number of software fwnode properties per RAS node */
+#define RAS_OF_MAX_PROPS	20
+
+static const unsigned long ras_of_type_processor __initconst =
+	ACPI_AEST_PROCESSOR_ERROR_NODE;
+static const unsigned long ras_of_type_smmu __initconst =
+	ACPI_AEST_SMMU_ERROR_NODE;
+static const unsigned long ras_of_type_gic __initconst =
+	ACPI_AEST_GIC_ERROR_NODE;
+
+static const struct of_device_id ras_of_match[] __initconst = {
+	{ .compatible = "arm,ras-processor", .data = &ras_of_type_processor },
+	{ .compatible = "arm,ras-smmu",      .data = &ras_of_type_smmu      },
+	{ .compatible = "arm,ras-gic",       .data = &ras_of_type_gic       },
+	{ }
+};
+
+static const char * const __initconst ras_of_irq_res_names[] = {
+	[ACPI_AEST_NODE_FAULT_HANDLING] = AEST_FHI_NAME,
+	[ACPI_AEST_NODE_ERROR_RECOVERY] = AEST_ERI_NAME,
+};
+
+static const char * const __initconst ras_of_dt_irq_names[] = {
+	"fhi", "eri"
+};
+
+static int __init ras_of_build_node_data(struct device_node *np,
+					 u8 node_type, int index,
+					 int fhi_virq,
+					 u8 **data_out, u32 *size_out)
+{
+	*data_out = NULL;
+	*size_out = 0;
+
+	switch (node_type) {
+	case ACPI_AEST_PROCESSOR_ERROR_NODE: {
+		/*
+		 * Allocate the processor header plus the cache sub-structure.
+		 * resource_type is inferred from the presence of the 'cache'
+		 * phandle: if present the resource is a cache, otherwise it
+		 * is treated as a generic processor resource.
+		 * flags (SHARED/GLOBAL) are inferred from the interrupt type:
+		 * a PPI is per-PE (global); an SPI is shared across a cluster.
+		 */
+		size_t total = sizeof(struct acpi_aest_processor) +
+			       sizeof(struct acpi_aest_processor_cache);
+		struct acpi_aest_processor_cache *c;
+		struct acpi_aest_processor *proc;
+		struct device_node *cache_np;
+		u8 pflags;
+
+		proc = kzalloc(total, GFP_KERNEL);
+		if (!proc)
+			return -ENOMEM;
+
+		cache_np = of_parse_phandle(np, "cache", 0);
+		if (cache_np) {
+			proc->resource_type = ACPI_AEST_CACHE_RESOURCE;
+			c = (struct acpi_aest_processor_cache *)(proc + 1);
+			/*
+			 * alloc_ras_node_name() reads c->cache_reference as
+			 * the name disambiguator for shared/global nodes.
+			 */
+			c->cache_reference = cache_np->phandle;
+			of_node_put(cache_np);
+		} else {
+			proc->resource_type = ACPI_AEST_GENERIC_RESOURCE;
+		}
+
+		/*
+		 * Infer scope from the FHI interrupt type: a PPI is
+		 * per-PE (set GLOBAL); an SPI is cluster-shared (set SHARED).
+		 * alloc_ras_node_name() uses flags to choose the name format.
+		 */
+		pflags = irq_is_percpu(fhi_virq) ?
+			 ACPI_AEST_PROC_FLAG_GLOBAL :
+			 ACPI_AEST_PROC_FLAG_SHARED;
+		proc->flags        = pflags;
+		proc->processor_id = (u32)index;
+
+		*data_out = (u8 *)proc;
+		*size_out = (u32)total;
+		break;
+	}
+	case ACPI_AEST_SMMU_ERROR_NODE: {
+		struct acpi_aest_smmu *smmu;
+		struct device_node *smmu_np;
+
+		smmu = kzalloc_obj(smmu, GFP_KERNEL);
+		if (!smmu)
+			return -ENOMEM;
+
+		smmu_np = of_parse_phandle(np, "iommus", 0);
+		if (smmu_np) {
+			smmu->iort_node_reference = smmu_np->phandle;
+			of_node_put(smmu_np);
+		}
+
+		*data_out = (u8 *)smmu;
+		*size_out = sizeof(*smmu);
+		break;
+	}
+	case ACPI_AEST_GIC_ERROR_NODE: {
+		struct acpi_aest_gic *gic;
+		struct device_node *gic_np;
+
+		gic = kzalloc_obj(gic, GFP_KERNEL);
+		if (!gic)
+			return -ENOMEM;
+
+		gic_np = of_parse_phandle(np, "arm,gic-ref", 0);
+		if (gic_np) {
+			gic->instance_id = gic_np->phandle;
+			of_node_put(gic_np);
+		}
+		*data_out = (u8 *)gic;
+		*size_out = sizeof(*gic);
+		break;
+	}
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/*
+ * Determine the register access type from the DT node:
+ *   no reg  -> system-register access (ERRSELR_EL1 + ERX*_EL1)
+ *   1 range -> memory-mapped access
+ *   2+ ranges -> single-record memory-mapped access
+ */
+static u8 __init ras_of_interface_type(struct device_node *np)
+{
+	int addr_cells, size_cells, reg_len;
+
+	if (!of_property_present(np, "reg"))
+		return ACPI_AEST_NODE_SYSTEM_REGISTER;
+
+	addr_cells = of_n_addr_cells(np);
+	size_cells = of_n_size_cells(np);
+	if (addr_cells <= 0 || size_cells <= 0)
+		return ACPI_AEST_NODE_SYSTEM_REGISTER;
+
+	reg_len = of_property_count_elems_of_size(np, "reg", sizeof(u32));
+	if (reg_len <= 0)
+		return ACPI_AEST_NODE_SYSTEM_REGISTER;
+
+	if (reg_len <= addr_cells + size_cells)
+		return ACPI_AEST_NODE_MEMORY_MAPPED;
+
+	return ACPI_AEST_NODE_SINGLE_RECORD_MEMORY_MAPPED;
+}
+
+static resource_size_t __init ras_of_mem_size(u32 gfmt)
+{
+	switch (gfmt) {
+	case ACPI_AEST_NODE_GROUP_FORMAT_16K:
+		return SZ_16K;
+	case ACPI_AEST_NODE_GROUP_FORMAT_64K:
+		return SZ_64K;
+	default:
+		return SZ_4K;
+	}
+}
+
+static u32 __init ras_of_virq_to_gsiv(int virq)
+{
+	struct irq_data *irqd = irq_get_irq_data(virq);
+
+	return irqd ? (u32)irqd->hwirq : 0;
+}
+
+static int __init ras_of_attach_fwnode(struct device_node *np,
+				       struct platform_device *pdev,
+				       u8 node_type, u8 itype, u32 gfmt,
+				       int index, int fhi_virq,
+				       u32 fhi_gsiv, u32 eri_gsiv)
+{
+	u64 rec_impl[14] = { };
+	u64 stat_rep[14] = { };
+	u64 addr_mode[14] = { };
+	u64 err_group_base = 0, fault_inject_base = 0, irq_cfg_base = 0;
+	struct property_entry props[RAS_OF_MAX_PROPS] = { };
+	struct resource res;
+	u8 *node_data = NULL;
+	u32 node_data_size = 0;
+	u32 nrec = 1;
+	int group_len, p = 0, i, ret;
+
+	of_property_read_u32(np, "arm,num-records", &nrec);
+
+	switch (gfmt) {
+	case ACPI_AEST_NODE_GROUP_FORMAT_16K:
+		group_len = 4;
+		break;
+	case ACPI_AEST_NODE_GROUP_FORMAT_64K:
+		group_len = 14;
+		break;
+	default:
+		group_len = 1;
+		break;
+	}
+
+	of_property_read_u64_array(np, "arm,record-impl",      rec_impl,  group_len);
+	of_property_read_u64_array(np, "arm,status-reporting", stat_rep,  group_len);
+	of_property_read_u64_array(np, "arm,addressing-mode",  addr_mode, group_len);
+
+	/*
+	 * DT binding: bit=1 means record IS implemented.
+	 * ras-core.c uses for_each_clear_bit() on record_implemented, so
+	 * bit=0 means implemented internally.  Invert before storing.
+	 */
+	for (i = 0; i < group_len; i++)
+		rec_impl[i] = ~rec_impl[i];
+
+	/* Named MMIO windows — only present on memory-mapped nodes */
+	if (itype != ACPI_AEST_NODE_SYSTEM_REGISTER) {
+		int idx;
+
+		idx = of_property_match_string(np, "reg-names", "err-group");
+		if (idx >= 0 && !of_address_to_resource(np, idx, &res))
+			err_group_base = res.start;
+
+		idx = of_property_match_string(np, "reg-names", "fault-inject");
+		if (idx >= 0 && !of_address_to_resource(np, idx, &res))
+			fault_inject_base = res.start;
+
+		idx = of_property_match_string(np, "reg-names", "irq-config");
+		if (idx >= 0 && !of_address_to_resource(np, idx, &res))
+			irq_cfg_base = res.start;
+	}
+
+	ret = ras_of_build_node_data(np, node_type, index, fhi_virq,
+				     &node_data, &node_data_size);
+	if (ret)
+		return ret;
+
+	props[p++] = PROPERTY_ENTRY_U8("arm,node-type",      node_type);
+	props[p++] = PROPERTY_ENTRY_U8("arm,interface-type", itype);
+	props[p++] = PROPERTY_ENTRY_U8("arm,group-format",   (u8)gfmt);
+	props[p++] = PROPERTY_ENTRY_U32("arm,error-records-count", nrec);
+	props[p++] = PROPERTY_ENTRY_U32("arm,error-records-index", 0);
+	props[p++] = PROPERTY_ENTRY_U32("arm,interface-flags",     0);
+	props[p++] = PROPERTY_ENTRY_U64_ARRAY_LEN("arm,record-implemented",
+						  rec_impl,  group_len);
+	props[p++] = PROPERTY_ENTRY_U64_ARRAY_LEN("arm,status-reporting",
+						  stat_rep,  group_len);
+	props[p++] = PROPERTY_ENTRY_U64_ARRAY_LEN("arm,addressing-mode",
+						  addr_mode, group_len);
+	props[p++] = PROPERTY_ENTRY_U64("arm,error-group-base",      err_group_base);
+	props[p++] = PROPERTY_ENTRY_U64("arm,fault-inject-base",     fault_inject_base);
+	props[p++] = PROPERTY_ENTRY_U64("arm,interrupt-config-base", irq_cfg_base);
+	props[p++] = PROPERTY_ENTRY_U32("arm,fhi-gsiv", fhi_gsiv);
+	props[p++] = PROPERTY_ENTRY_U32("arm,eri-gsiv", eri_gsiv);
+
+	if (node_data && node_data_size)
+		props[p++] = PROPERTY_ENTRY_U8_ARRAY_LEN("arm,node-specific-data",
+							 node_data, node_data_size);
+
+	ret = device_create_managed_software_node(&pdev->dev, props, NULL);
+
+	kfree(node_data);
+	return ret;
+}
+
+static int __init ras_of_init_one_node(struct device_node *np, u8 node_type,
+				       int index)
+{
+	struct resource res[AEST_MAX_INTERRUPT_PER_NODE + 1] = { };
+	struct platform_device *pdev;
+	u32 gfmt = ACPI_AEST_NODE_GROUP_FORMAT_4K;
+	u32 gsiv[AEST_MAX_INTERRUPT_PER_NODE] = { };
+	int virq[AEST_MAX_INTERRUPT_PER_NODE] = { };
+	int nres = 0, ret, i;
+	u8 itype;
+
+	itype = ras_of_interface_type(np);
+	of_property_read_u32(np, "arm,group-format", &gfmt);
+
+	pdev = platform_device_alloc("arm64_ras", PLATFORM_DEVID_AUTO);
+	if (!pdev)
+		return -ENOMEM;
+
+	if (itype != ACPI_AEST_NODE_SYSTEM_REGISTER) {
+		struct resource mmio_res;
+
+		ret = of_address_to_resource(np, 0, &mmio_res);
+		if (ret) {
+			pr_err("node %pOF: missing 'reg' for MMIO interface\n", np);
+			goto err_put;
+		}
+		res[nres].name  = AEST_NODE_NAME;
+		res[nres].start = mmio_res.start;
+		res[nres].end   = mmio_res.start + ras_of_mem_size(gfmt) - 1;
+		res[nres].flags = IORESOURCE_MEM;
+		nres++;
+	}
+
+	for (i = 0; i < AEST_MAX_INTERRUPT_PER_NODE; i++) {
+		int irq_num = of_irq_get_byname(np, ras_of_dt_irq_names[i]);
+
+		if (irq_num <= 0)
+			continue;
+
+		gsiv[i] = ras_of_virq_to_gsiv(irq_num);
+		virq[i] = irq_num;
+
+		res[nres].name  = ras_of_irq_res_names[i];
+		res[nres].start = irq_num;
+		res[nres].end   = irq_num;
+		res[nres].flags = IORESOURCE_IRQ;
+		nres++;
+	}
+
+	ret = platform_device_add_resources(pdev, res, nres);
+	if (ret)
+		goto err_put;
+
+	ret = ras_of_attach_fwnode(np, pdev, node_type, itype, gfmt, index,
+				   virq[ACPI_AEST_NODE_FAULT_HANDLING],
+				   gsiv[ACPI_AEST_NODE_FAULT_HANDLING],
+				   gsiv[ACPI_AEST_NODE_ERROR_RECOVERY]);
+	if (ret)
+		goto err_put;
+
+	ret = platform_device_add(pdev);
+	if (ret)
+		goto err_put;
+
+	pr_debug("registered RAS node %pOF as arm64_ras.%d\n", np, pdev->id);
+	return 0;
+
+err_put:
+	platform_device_put(pdev);
+	return ret;
+}
+
+static int __init ras_of_init(void)
+{
+	const struct of_device_id *match;
+	struct device_node *np;
+	int index = 0, ret;
+
+	if (!acpi_disabled)
+		return 0;
+
+	for_each_matching_node_and_match(np, ras_of_match, &match) {
+		u8 node_type = *(const unsigned long *)match->data;
+
+		ret = ras_of_init_one_node(np, node_type, index++);
+		if (ret) {
+			pr_err("failed to register RAS node %pOF: %d\n",
+			       np, ret);
+			of_node_put(np);
+			return ret;
+		}
+	}
+
+	if (index)
+		pr_info("registered %d RAS error source(s) from DT\n", index);
+
+	return 0;
+}
+subsys_initcall_sync(ras_of_init);
--
2.34.1

