Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726B943C05A
	for <linux-acpi@vger.kernel.org>; Tue,  5 May 2026 12:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777983936; cv=none; b=fOi9Kaw85gySAnF0CtAVY3pgg8MVTb1Y1UWO8Qi4lPeCTUSSct2AEuNrkPi9/56U9ODKzXpg64kHRhq1jmRkwdsywfI/zuisTcgf/I81trx4VtVWYHog/8o7TomkTYruRVZVxL3MVo3auZl/Gqq1mrzEBCKhAqdRYzyCkjzwV5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777983936; c=relaxed/simple;
	bh=65Yo679j9JdoH++1dzuklMEm65xTb9swYVmBmaMWTaU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G9iZVZMoDsLh+DpQ8/P3hCvg2c7AD6KxKWioff68SCuNrtzrU11DuOpL/EV5VGnGO7EHW6FLhyWUbBfLct38qe1N9slTPE1oEvCe30SDTkNvnOfatI7iytSMCI8P+vXkwtTkTveLPVfuwAfpjZn0Y7J31E2SrFVkuE6TVGhD8Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T8bQqHuA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QE5b8UX1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T8bQqHuA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QE5b8UX1"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6457U6cN366321
	for <linux-acpi@vger.kernel.org>; Tue, 5 May 2026 12:25:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	V1Jrhr9jCcCWctKELqOybzuqbjqdo+EAqKZTIX3ir4Q=; b=T8bQqHuAhWIHBa+G
	NA6rnWnZDFH5sqvXcXHTVFOu84pHFNLuqZ88kCP+iemQ4dX2us7UuTg6UIc7Goey
	jtwfusxOq7HoC70JqQoTzyBnCr1tMRdnmxrxXatiWGcwBtOh3fM3OoK0WRI8Cd5O
	nlkP0U5cZA51qPe8XnRG6Mwf6dOzJ1jW6Z4ggfpjJDB13+IjeIE/4gVcIOOesU2b
	Pd75tPqDmy0oAvl8g/ctETZCP9L/cCmloUzbjqe/G5EfiCJITCR7NzQ0b1F+SnMq
	2DYfibFIu87l8sdDdZIQPAd/Npg95pOHBeTLkglZ+SBuWDAE6Nhcnpz7iABgjoZ+
	LOOgeA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dxvn6vdct-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Tue, 05 May 2026 12:25:32 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-35679eb61b5so1815045a91.0
        for <linux-acpi@vger.kernel.org>; Tue, 05 May 2026 05:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777983931; x=1778588731; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V1Jrhr9jCcCWctKELqOybzuqbjqdo+EAqKZTIX3ir4Q=;
        b=QE5b8UX1QigyT7/IV4gcTxVjgOKp8b3r0H1pWZQm5f+1klfQwIeKHbSnSq24r4Bb+m
         UYvySRDTU8husSTJwUvMbHMkH347JkKxnSkOEGpQ67Dxrt7gOCZChpJYUsAtwDyivPqq
         WHhBJpKNWUpj1M74pFk42CYEaiwPePXPrEXkYwSNSibFJtjrye1cMXkn2Tf4O3fPLSPi
         zrDPUgvgDcM2eU8g7OwMK3CGjd3kCouP+ZerttwPFoybS2/0Ib7plflwKScaJv+i+ZxA
         OYjafPpgy1CAZWYZ8kXAT+okbX14VL6A2dY7L5eQkIEdBWOv25amOButFN97wF8N+9S5
         yinw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777983931; x=1778588731;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=V1Jrhr9jCcCWctKELqOybzuqbjqdo+EAqKZTIX3ir4Q=;
        b=LAsro9i1EstCqo7nYRwK0VxU1Z3BUFTaCv1HjdFCIb5xPubY4JeTYq7IZehDCFXLoa
         d03Pco29l7/Ftdla1fF4a7C4N4Qe+w7qUfkrY+mLW3JA/G66qjSPxg0OBdeuPrEHRqfa
         FPWNUImb8dyUIR4HvkRSQkGuTYFjh2OM7smzv1w1x881fU50aiL4lLjTAs/WkehCRkRN
         JTD2Qz9y1r3tTU+VtRBKaLUkZ//ay7dwDYCMsdww1YDGIW1iqVt/RlekSzQfT8gTSOan
         KqpzEeUROzbFBAnQ45ZEpFdAIZvcoWDyPY6Wd/uZyxiCMMVK+t3MSwLT/jeOkpN455ev
         O9HA==
X-Forwarded-Encrypted: i=1; AFNElJ9bw9eETlS9/sEbtspGv0UYd+r6jG1Y+fsMlTnxSWdkDMqKZMI6W8q8cTQJyNmzTpiJWjrEtdppB/eY@vger.kernel.org
X-Gm-Message-State: AOJu0YxMis1rk0336+P7+7tGOfLUjqFlYG5D1PosE7NsbVBwGGq9FYD8
	4me7Cn68lKLwiGIp79cGhC12SLqjG+IY3/GPy9KhyH6eP4I3pr94okctbSThIFRhIGde33LtxLK
	ntqqYnTApRYfMtRXwkZ3hp+/FTrVybWIqaWTt74cKmyZ/Up3eQrIBndZoEBaYvo9L
X-Gm-Gg: AeBDieuRlOiliU0/hcIdgb8NeZiEo2BwiJWyq8ZQX/p/ZOsodmLGhNen2AD+HnawRCq
	VNot4YJqU5eAru36XxFjuveqHu+128QE+gsyTOB18nvjj8yAfmn5DJG8go4lDFhQcuCDQK3BjsO
	teulJGLQrpcEKaaBwzGdwS4xnjVObb0V06RK8lfLKQvYit/vkWeLCSoTIAGnrqX4bKLuLF4qYY3
	HhqVdemCTpi2RpHqrHYJAY6rW5Vi0cOUMlC5v+M1S98A5DINR7nTli5H4StSGemMtIkMckqXh7m
	GW75DYgvtSuUdP5r6GDOT3aaGltTJYFbmADuHx0JoRls+2RnAScsYx/tYnGgQQIVGkwOXbcZL/N
	nMo3bxGnMMqKghHJ4+fKIu+WsnAztkGGvLMkOzHZ5hhXOl70C7Usajpgfd1BHdak=
X-Received: by 2002:a17:90b:2f47:b0:35d:9d38:5363 with SMTP id 98e67ed59e1d1-3657ae50cb6mr1320692a91.5.1777983931117;
        Tue, 05 May 2026 05:25:31 -0700 (PDT)
X-Received: by 2002:a17:90b:2f47:b0:35d:9d38:5363 with SMTP id 98e67ed59e1d1-3657ae50cb6mr1320667a91.5.1777983930535;
        Tue, 05 May 2026 05:25:30 -0700 (PDT)
Received: from hu-uchheda-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7ffbbaac5bsm12597998a12.6.2026.05.05.05.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 05:25:29 -0700 (PDT)
From: Umang Chheda <umang.chheda@oss.qualcomm.com>
Date: Tue, 05 May 2026 17:53:50 +0530
Subject: [PATCH 6/8] ras: aest: Add DT frontend for ARM AEST RAS error
 sources
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-aest-devicetree-support-v1-6-d5d6ffacf0a5@oss.qualcomm.com>
References: <20260505-aest-devicetree-support-v1-0-d5d6ffacf0a5@oss.qualcomm.com>
In-Reply-To: <20260505-aest-devicetree-support-v1-0-d5d6ffacf0a5@oss.qualcomm.com>
To: Ruidong Tian <tianruidond@linux.alibaba.com>,
        Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, catalin.marinas@arm.com,
        will@kernel.org, lpieralisi@kernel.org, rafael@kernel.org,
        mark.rutland@arm.com, Sudeep Holla <sudeep.holla@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-edac@vger.kernel.org,
        Umang Chheda <umang.chheda@oss.qualcomm.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777983885; l=20560;
 i=umang.chheda@oss.qualcomm.com; s=20260328; h=from:subject:message-id;
 bh=65Yo679j9JdoH++1dzuklMEm65xTb9swYVmBmaMWTaU=;
 b=xnvRqu4TgwjxmP07s3wawOdWDgnkSvQJOvOMvoRhYjtqLIeLDSJEsZAIXpIwJ0KrOoCiri/PM
 0H6+WU5nYuCD89Tv17liM8Yd/lqvQDJKfaCBW8xabxJLJGw5NZFlY2O
X-Developer-Key: i=umang.chheda@oss.qualcomm.com; a=ed25519;
 pk=3+tjZ+PFFYphz0Vvu4B14pBQSzqcG0jZAQspTaDRQYA=
X-Proofpoint-ORIG-GUID: Zc9R1CuQ6lHRvo4Gocnn0naIdH0Ajaud
X-Authority-Analysis: v=2.4 cv=Z+vc2nRA c=1 sm=1 tr=0 ts=69f9e1bc cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=LU4bSowTPqSwvI73UiUA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: Zc9R1CuQ6lHRvo4Gocnn0naIdH0Ajaud
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDExNyBTYWx0ZWRfX5Xv7I2DdQgGD
 ZjrupWCHt75idkq7uHCfBnQM5rBfMQK+MXTRxkCrIERkCYUSOIdaSnTT8ihYboouiHRn02tzIGT
 EkHKGAlkCHaIch2a5oW0gBw4yWDGOlkloG5Kqt2RQYvQU4VwQNO0bC0tKHsyGvmp1M1OdX6DO1P
 Wt7QSozR0MRW7xo2PvpDD8YRtozT5OD/E5/AFViMvjnX961ezaOdowztdfj5L795IysGVDHuDzA
 6Mwdpnm71sx0zUKYpZAGScz4HHuUWxmZYJbG27LXNenjkOxgrvNjpaLJztPXcTQnBi49Vc4VCBu
 8to6MDy4WFvYd9JrxNhx8y9WrtsE1lT6yUO8/1vS2Gk5RriQN8fsqJY8jWpXklktugdByehZJXI
 o18rhxCTN2HuyFe1pTWKk1l5GvLLokjJOqEMrhVoGxH1n1h/msxgKo7lMEfhcGTwStnJqvPzLvk
 dJ4AYH1lTo90ZMLag3g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 impostorscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605050117

Add a Device Tree frontend for the Arm AEST RAS framework, allowing the
existing AEST core driver to be used on DT-only systems.

The DT frontend parses the "arm,aest" Device Tree hierarchy and populates
the same internal structures as the ACPI-based implementation. It is
initialized at the same layer as ACPI and is mutually exclusive with it,
ensuring identical behaviour regardless of the firmware interface in use.

Signed-off-by: Umang Chheda <umang.chheda@oss.qualcomm.com>
---
 drivers/ras/aest/Kconfig   |  15 +-
 drivers/ras/aest/Makefile  |   2 +
 drivers/ras/aest/aest-of.c | 673 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 688 insertions(+), 2 deletions(-)

diff --git a/drivers/ras/aest/Kconfig b/drivers/ras/aest/Kconfig
index 0b09a5d5acce..ca034255fadd 100644
--- a/drivers/ras/aest/Kconfig
+++ b/drivers/ras/aest/Kconfig
@@ -7,11 +7,22 @@
 
 config AEST
 	tristate "ARM AEST Driver"
-	depends on ACPI_AEST && RAS
-
+	depends on ACPI_AEST || OF_AEST
+	depends on RAS
 	help
 	  The Arm Error Source Table (AEST) provides details on ACPI
 	  extensions that enable kernel-first handling of errors in a
 	  system that supports the Armv8 RAS extensions.
 
 	  If set, the kernel will report and log hardware errors.
+
+config OF_AEST
+        bool "ARM Error Source Table DT Support"
+        depends on ARM64_RAS_EXTN && OF
+        help
+          Enable support for discovering ARM RAS error sources using the
+          Device Tree based Arm Error Source Table (AEST) specification.
+          This allows the kernel to enumerate and manage hardware error
+          reporting blocks described in firmware for ARMv8 and later
+          systems. Select this option if your platform describes AEST
+          nodes in Device Tree and relies on RAS error handling.
diff --git a/drivers/ras/aest/Makefile b/drivers/ras/aest/Makefile
index e5a45fde6d36..2997952901c0 100644
--- a/drivers/ras/aest/Makefile
+++ b/drivers/ras/aest/Makefile
@@ -6,3 +6,5 @@ aest-y		:= aest-core.o
 aest-y		+= aest-sysfs.o
 aest-y		+= aest-inject.o
 aest-y		+= aest-cmn.o
+
+obj-$(CONFIG_OF_AEST)   += aest-of.o
diff --git a/drivers/ras/aest/aest-of.c b/drivers/ras/aest/aest-of.c
new file mode 100644
index 000000000000..939db2c41742
--- /dev/null
+++ b/drivers/ras/aest/aest-of.c
@@ -0,0 +1,673 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/xarray.h>
+#include <linux/acpi_aest.h>
+
+#undef pr_fmt
+#define pr_fmt(fmt) "DT AEST: " fmt
+
+struct dt_aest_priv {
+	struct xarray aest_array;
+	u32 node_id;
+};
+
+static const struct of_device_id dt_aest_child_match[] = {
+	{ .compatible = "arm,aest-processor", .data = (void *)ACPI_AEST_PROCESSOR_ERROR_NODE },
+	{ .compatible = "arm,aest-memory",    .data = (void *)ACPI_AEST_MEMORY_ERROR_NODE    },
+	{ .compatible = "arm,aest-smmu",      .data = (void *)ACPI_AEST_SMMU_ERROR_NODE      },
+	{ .compatible = "arm,aest-vendor",    .data = (void *)ACPI_AEST_VENDOR_ERROR_NODE    },
+	{ .compatible = "arm,aest-gic",       .data = (void *)ACPI_AEST_GIC_ERROR_NODE       },
+	{ .compatible = "arm,aest-pcie",      .data = (void *)ACPI_AEST_PCIE_ERROR_NODE      },
+	{ .compatible = "arm,aest-proxy",     .data = (void *)ACPI_AEST_PROXY_ERROR_NODE     },
+	{ }
+};
+
+static int dt_aest_node_type(struct device_node *np)
+{
+	const struct of_device_id *match;
+
+	match = of_match_node(dt_aest_child_match, np);
+	if (!match) {
+		pr_warn("unknown compatible for %pOF\n", np);
+		return -EINVAL;
+	}
+	return (int)(uintptr_t)match->data;
+}
+
+static struct aest_hnode *dt_aest_alloc_hnode(int node_type, u32 id)
+{
+	struct aest_hnode *ahnode;
+
+	ahnode = kzalloc_obj(*ahnode, GFP_KERNEL);
+	if (!ahnode)
+		return NULL;
+
+	INIT_LIST_HEAD(&ahnode->list);
+	ahnode->count = 0;
+	ahnode->id    = id;
+	ahnode->type  = node_type;
+	return ahnode;
+}
+
+static int dt_aest_build_interface(struct device_node *np,
+					  struct acpi_aest_node *anode)
+{
+	struct acpi_aest_node_interface_header  *hdr;
+	struct acpi_aest_node_interface_common  *common;
+	struct resource res;
+	struct resource named_res;
+	u32 gfmt = 0, flags = 0, nrec = 1;
+	u32 itype;
+	int ret;
+	size_t body_sz;
+
+	/*
+	 * Deduce interface type from the presence and count of reg entries:
+	 *   no reg  -> system-register access (type 0)
+	 *   1 range -> memory-mapped access   (type 1)
+	 *   2+ ranges -> single-record MMIO   (type 2)
+	 */
+	if (!of_property_present(np, "reg"))
+		itype = ACPI_AEST_NODE_SYSTEM_REGISTER;
+	else if (of_property_count_elems_of_size(np, "reg", sizeof(u32)) <=
+		 (of_n_addr_cells(np) + of_n_size_cells(np)))
+		itype = ACPI_AEST_NODE_MEMORY_MAPPED;
+	else
+		itype = ACPI_AEST_NODE_SINGLE_RECORD_MEMORY_MAPPED;
+
+	of_property_read_u32(np, "arm,group-format",    &gfmt);
+	of_property_read_u32(np, "arm,interface-flags", &flags);
+	of_property_read_u32(np, "arm,num-records",     &nrec);
+
+	switch (gfmt) {
+	case ACPI_AEST_NODE_GROUP_FORMAT_16K:
+		body_sz = sizeof(struct acpi_aest_node_interface_16k);
+		break;
+	case ACPI_AEST_NODE_GROUP_FORMAT_64K:
+		body_sz = sizeof(struct acpi_aest_node_interface_64k);
+		break;
+	default:
+		body_sz = sizeof(struct acpi_aest_node_interface_4k);
+		break;
+	}
+
+	hdr = kzalloc(sizeof(*hdr) + body_sz, GFP_KERNEL);
+	if (!hdr)
+		return -ENOMEM;
+
+	/* Fill header */
+	hdr->type         = (u8)itype;
+	hdr->group_format = (u8)gfmt;
+	hdr->flags        = flags;
+	hdr->error_record_count = nrec;
+	hdr->error_record_index = 0;
+
+	if (itype != ACPI_AEST_NODE_SYSTEM_REGISTER) {
+		ret = of_address_to_resource(np, 0, &res);
+		if (ret) {
+			pr_err("node %pOF: missing 'reg' for MMIO interface\n", np);
+			kfree(hdr);
+			return ret;
+		}
+		hdr->address = res.start;
+	}
+
+	switch (gfmt) {
+	case ACPI_AEST_NODE_GROUP_FORMAT_4K: {
+		struct acpi_aest_node_interface_4k *b =
+			(struct acpi_aest_node_interface_4k *)(hdr + 1);
+		of_property_read_u64(np, "arm,record-impl",
+				     &b->error_record_implemented);
+		of_property_read_u64(np, "arm,status-reporting",
+				     &b->error_status_reporting);
+		of_property_read_u64(np, "arm,addressing-mode",
+				     &b->addressing_mode);
+		common = &b->common;
+		anode->record_implemented =
+			(unsigned long *)&b->error_record_implemented;
+		anode->status_reporting =
+			(unsigned long *)&b->error_status_reporting;
+		anode->addressing_mode =
+			(unsigned long *)&b->addressing_mode;
+		break;
+	}
+	case ACPI_AEST_NODE_GROUP_FORMAT_16K: {
+		struct acpi_aest_node_interface_16k *b =
+			(struct acpi_aest_node_interface_16k *)(hdr + 1);
+		of_property_read_u64_array(np, "arm,record-impl",
+					   b->error_record_implemented, 4);
+		of_property_read_u64_array(np, "arm,status-reporting",
+					   b->error_status_reporting, 4);
+		of_property_read_u64_array(np, "arm,addressing-mode",
+					   b->addressing_mode, 4);
+		common = &b->common;
+		anode->record_implemented =
+			(unsigned long *)b->error_record_implemented;
+		anode->status_reporting =
+			(unsigned long *)b->error_status_reporting;
+		anode->addressing_mode =
+			(unsigned long *)b->addressing_mode;
+		break;
+	}
+	case ACPI_AEST_NODE_GROUP_FORMAT_64K: {
+		struct acpi_aest_node_interface_64k *b =
+			(struct acpi_aest_node_interface_64k *)(hdr + 1);
+		of_property_read_u64_array(np, "arm,record-impl",
+					   b->error_record_implemented, 14);
+		of_property_read_u64_array(np, "arm,status-reporting",
+					   b->error_status_reporting, 14);
+		of_property_read_u64_array(np, "arm,addressing-mode",
+					   b->addressing_mode, 14);
+		common = &b->common;
+		anode->record_implemented =
+			(unsigned long *)b->error_record_implemented;
+		anode->status_reporting =
+			(unsigned long *)b->error_status_reporting;
+		anode->addressing_mode =
+			(unsigned long *)b->addressing_mode;
+		break;
+	}
+	default:
+		pr_err("node %pOF: unsupported group-format %u\n", np, gfmt);
+		kfree(hdr);
+		return -EINVAL;
+	}
+
+	if (!of_address_to_resource(np, of_property_match_string(
+					np, "reg-names", "fault-inject"), &named_res))
+		common->fault_inject_register_base = named_res.start;
+
+	if (!of_address_to_resource(np, of_property_match_string(
+					np, "reg-names", "err-group"), &named_res))
+		common->error_group_register_base = named_res.start;
+
+	if (!of_address_to_resource(np, of_property_match_string(
+					np, "reg-names", "irq-config"), &named_res))
+		common->interrupt_config_register_base = named_res.start;
+
+	anode->interface_hdr = hdr;
+	anode->common        = common;
+
+	return 0;
+}
+
+static int dt_aest_build_interrupt(struct device_node *np,
+					  struct acpi_aest_node *anode)
+{
+	struct acpi_aest_node_interrupt_v2 *irq_arr;
+	int fhi_irq, eri_irq, count = 0;
+	u32 fhi_flags = 0, eri_flags = 0;
+
+	of_property_read_u32(np, "arm,fhi-flags", &fhi_flags);
+	of_property_read_u32(np, "arm,eri-flags", &eri_flags);
+
+	fhi_irq = of_irq_get_byname(np, "fhi");
+	if (fhi_irq == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+	if (fhi_irq < 0 && fhi_irq != -EINVAL) {
+		const char *name = NULL;
+
+		of_property_read_string(np, "interrupt-names", &name);
+
+		pr_warn("node %pOF: failed to map FHI IRQ: %d (interrupt-names[0]=\"%s\", want \"%s\")\n",
+			np, fhi_irq, name ?: "<missing>", "fhi");
+	}
+	eri_irq = of_irq_get_byname(np, "eri");
+	if (eri_irq == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+	if (eri_irq < 0 && eri_irq != -EINVAL) {
+		const char *name = NULL;
+
+		of_property_read_string_index(np, "interrupt-names", 1, &name);
+
+		pr_warn("node %pOF: failed to map ERI IRQ: %d (interrupt-names[1]=\"%s\", want \"%s\")\n",
+			np, eri_irq, name ?: "<missing>", "eri");
+	}
+
+	if (fhi_irq > 0)
+		count++;
+	if (eri_irq > 0)
+		count++;
+
+	if (!count) {
+		anode->interrupt       = NULL;
+		anode->interrupt_count = 0;
+		return 0;
+	}
+
+	irq_arr = kcalloc(count, sizeof(*irq_arr), GFP_KERNEL);
+	if (!irq_arr)
+		return -ENOMEM;
+
+	count = 0;
+	if (fhi_irq > 0) {
+		irq_arr[count].gsiv  = fhi_irq;
+		irq_arr[count].flags = AEST_INTERRUPT_MODE | fhi_flags;
+		irq_arr[count].type  = ACPI_AEST_NODE_FAULT_HANDLING;
+		count++;
+	}
+	if (eri_irq > 0) {
+		irq_arr[count].gsiv  = eri_irq;
+		irq_arr[count].flags = eri_flags;
+		irq_arr[count].type  = ACPI_AEST_NODE_ERROR_RECOVERY;
+		count++;
+	}
+
+	anode->interrupt       = irq_arr;
+	anode->interrupt_count = count;
+	return 0;
+}
+
+static int dt_aest_build_node_specific(struct device_node *np,
+					      struct acpi_aest_node *anode,
+					      int node_type)
+{
+	switch (node_type) {
+
+	case ACPI_AEST_PROCESSOR_ERROR_NODE: {
+		struct acpi_aest_processor *proc;
+		u32 rtype = 0, pflags = 0;
+
+		proc = kzalloc_obj(*proc, GFP_KERNEL);
+		if (!proc)
+			return -ENOMEM;
+
+		of_property_read_u32(np, "arm,resource-type", &rtype);
+		of_property_read_u32(np, "arm,processor-flags", &pflags);
+
+		proc->resource_type   = (u8)rtype;
+		proc->flags           = (u8)pflags;
+
+		/* Processor cache/TLB/generic sub-structure */
+		switch (rtype) {
+		case ACPI_AEST_CACHE_RESOURCE: {
+			struct acpi_aest_processor_cache *c;
+			struct device_node *cache_np;
+
+			c = kzalloc_obj(*c, GFP_KERNEL);
+			if (!c) {
+				kfree(proc);
+				return -ENOMEM;
+			}
+
+			cache_np = of_parse_phandle(np, "arm,cache-ref", 0);
+			if (cache_np) {
+				c->cache_reference = cache_np->phandle;
+				of_node_put(cache_np);
+			}
+			anode->cache = c;
+			break;
+		}
+		case ACPI_AEST_TLB_RESOURCE: {
+			struct acpi_aest_processor_tlb *t;
+
+			t = kzalloc_obj(*t, GFP_KERNEL);
+			if (!t) {
+				kfree(proc);
+				return -ENOMEM;
+			}
+			of_property_read_u32(np, "arm,tlb-level",
+					     &t->tlb_level);
+			anode->tlb = t;
+			break;
+		}
+		default: {
+			struct acpi_aest_processor_generic *g;
+
+			g = kzalloc_obj(*g, GFP_KERNEL);
+			if (!g) {
+				kfree(proc);
+				return -ENOMEM;
+			}
+			of_property_read_u32(np, "arm,resource-ref",
+					     &g->resource);
+			anode->generic = g;
+			break;
+		}
+		}
+		anode->processor = proc;
+		break;
+	}
+
+	case ACPI_AEST_MEMORY_ERROR_NODE: {
+		struct acpi_aest_memory *mem;
+
+		mem = kzalloc_obj(*mem, GFP_KERNEL);
+
+		if (!mem)
+			return -ENOMEM;
+		of_property_read_u32(np, "arm,proximity-domain",
+				     &mem->srat_proximity_domain);
+		anode->memory = mem;
+		break;
+	}
+
+	case ACPI_AEST_SMMU_ERROR_NODE: {
+		struct acpi_aest_smmu *smmu;
+		struct device_node *smmu_np;
+
+		smmu = kzalloc_obj(*smmu, GFP_KERNEL);
+
+		if (!smmu)
+			return -ENOMEM;
+		smmu_np = of_parse_phandle(np, "arm,smmu-ref", 0);
+		if (smmu_np) {
+			/* Use the DT node offset as the IORT reference */
+			smmu->iort_node_reference = smmu_np->phandle;
+			of_node_put(smmu_np);
+		}
+		of_property_read_u32(np, "arm,smmu-subcomponent",
+				     &smmu->subcomponent_reference);
+		anode->smmu = smmu;
+		break;
+	}
+
+	case ACPI_AEST_VENDOR_ERROR_NODE: {
+		struct acpi_aest_vendor_v2 *vendor;
+		const char *hid = "ARMHC000";
+
+		vendor = kzalloc_obj(*vendor, GFP_KERNEL);
+
+		if (!vendor)
+			return -ENOMEM;
+		of_property_read_string(np, "arm,vendor-hid", &hid);
+		strscpy(vendor->acpi_hid, hid, sizeof(vendor->acpi_hid));
+		of_property_read_u32(np, "arm,vendor-uid",
+				     &vendor->acpi_uid);
+		anode->vendor = vendor;
+		break;
+	}
+
+	case ACPI_AEST_GIC_ERROR_NODE: {
+		struct acpi_aest_gic *gic;
+
+		gic = kzalloc_obj(*gic, GFP_KERNEL);
+
+		if (!gic)
+			return -ENOMEM;
+		of_property_read_u32(np, "arm,gic-type",
+				     &gic->interface_type);
+		of_property_read_u32(np, "arm,gic-instance",
+				     &gic->instance_id);
+		anode->gic = gic;
+		break;
+	}
+
+	case ACPI_AEST_PCIE_ERROR_NODE: {
+		struct acpi_aest_pcie *pcie;
+
+		pcie = kzalloc_obj(*pcie, GFP_KERNEL);
+
+		if (!pcie)
+			return -ENOMEM;
+		of_property_read_u32(np, "arm,pcie-segment",
+				     &pcie->iort_node_reference);
+		anode->pcie = pcie;
+		break;
+	}
+
+	case ACPI_AEST_PROXY_ERROR_NODE:
+		/* No node-specific data for proxy nodes */
+		anode->spec_pointer = NULL;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static struct acpi_aest_node *
+dt_aest_alloc_anode(struct device_node *np, int node_type)
+{
+	struct acpi_aest_node *anode;
+	int ret;
+
+	anode = kzalloc_obj(*anode, GFP_KERNEL);
+	if (!anode)
+		return ERR_PTR(-ENOMEM);
+
+	INIT_LIST_HEAD(&anode->list);
+	anode->type = node_type;
+
+	ret = dt_aest_build_interface(np, anode);
+	if (ret)
+		goto err_free;
+
+	ret = dt_aest_build_node_specific(np, anode, node_type);
+	if (ret)
+		goto err_free;
+
+	ret = dt_aest_build_interrupt(np, anode);
+	if (ret)
+		goto err_free;
+
+	return anode;
+
+err_free:
+	kfree(anode->interface_hdr);
+	kfree(anode->spec_pointer);
+	kfree(anode->processor_spec_pointer);
+	kfree(anode);
+	return ERR_PTR(ret);
+}
+
+static int dt_aest_init_one_node(struct device_node *np,
+				 struct dt_aest_priv *priv)
+{
+	int node_type;
+	struct aest_hnode *ahnode;
+	struct acpi_aest_node *anode;
+
+	node_type = dt_aest_node_type(np);
+	if (node_type < 0) {
+		pr_warn("unknown node type for %pOF, skipping\n", np);
+		return 0;
+	}
+
+	ahnode = dt_aest_alloc_hnode(node_type, priv->node_id);
+	if (!ahnode)
+		return -ENOMEM;
+
+	anode = dt_aest_alloc_anode(np, node_type);
+	if (IS_ERR(anode)) {
+		kfree(ahnode);
+		return PTR_ERR(anode);
+	}
+
+	list_add_tail(&anode->list, &ahnode->list);
+	ahnode->count = 1;
+
+	if (xa_err(xa_store(&priv->aest_array, priv->node_id,
+			    ahnode, GFP_KERNEL))) {
+		kfree(anode);
+		kfree(ahnode);
+		return -ENOMEM;
+	}
+	priv->node_id++;
+	return 0;
+}
+
+static int dt_aest_init_nodes(struct device_node *aest_root,
+			      struct dt_aest_priv *priv)
+{
+	struct device_node *np;
+	int ret;
+
+	for_each_available_child_of_node(aest_root, np) {
+		ret = dt_aest_init_one_node(np, priv);
+		if (ret) {
+			pr_err("failed to init node %pOF: %d\n", np, ret);
+			of_node_put(np);
+			return ret;
+		}
+	}
+	return 0;
+}
+
+static struct platform_device *dt_aest_alloc_pdev(struct aest_hnode *ahnode,
+						   int index)
+{
+	struct platform_device *pdev;
+	struct resource *res;
+	struct acpi_aest_node *anode;
+	int ret, size, j;
+	int irq[AEST_MAX_INTERRUPT_PER_NODE] = { 0 };
+
+	pdev = platform_device_alloc("AEST", index);
+	if (!pdev)
+		return ERR_PTR(-ENOMEM);
+
+	res = kcalloc(ahnode->count + AEST_MAX_INTERRUPT_PER_NODE,
+		      sizeof(*res), GFP_KERNEL);
+	if (!res) {
+		platform_device_put(pdev);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	j = 0;
+	list_for_each_entry(anode, &ahnode->list, list) {
+		if (anode->interface_hdr->type !=
+		    ACPI_AEST_NODE_SYSTEM_REGISTER) {
+			res[j].name  = AEST_NODE_NAME;
+			res[j].start = anode->interface_hdr->address;
+
+			switch (anode->interface_hdr->group_format) {
+			case ACPI_AEST_NODE_GROUP_FORMAT_4K:
+				size = 4 * KB; break;
+			case ACPI_AEST_NODE_GROUP_FORMAT_16K:
+				size = 16 * KB; break;
+			case ACPI_AEST_NODE_GROUP_FORMAT_64K:
+				size = 64 * KB; break;
+			default:
+				size = 4 * KB;
+			}
+			res[j].end   = res[j].start + size - 1;
+			res[j].flags = IORESOURCE_MEM;
+			j++;
+		}
+
+		if (anode->interrupt && anode->interrupt_count > 0) {
+			int k;
+
+			for (k = 0; k < anode->interrupt_count &&
+			     k < AEST_MAX_INTERRUPT_PER_NODE; k++) {
+
+				struct acpi_aest_node_interrupt_v2 *intr =
+					&anode->interrupt[k];
+				int itype = intr->type;
+				int virq  = intr->gsiv;
+				struct irq_data *irqd;
+
+				if (!virq)
+					continue;
+				if (itype >= AEST_MAX_INTERRUPT_PER_NODE)
+					continue;
+				if (irq[itype] == virq)
+					continue;
+				irq[itype] = virq;
+				/*
+				 * aest_config_irq() writes intr->gsiv directly
+				 * to the hardware IRQ-config register, so it
+				 * must hold the GIC hardware SPI number, not the
+				 * Linux virtual IRQ.  Convert here now that we
+				 * have the virq in hand; the resource still gets
+				 * the virq so devm_request_irq() works correctly.
+				 */
+				irqd = irq_get_irq_data(virq);
+				if (irqd)
+					intr->gsiv = irqd->hwirq;
+
+				res[j].name  = (itype == ACPI_AEST_NODE_FAULT_HANDLING)
+						? AEST_FHI_NAME : AEST_ERI_NAME;
+				res[j].start = virq;
+				res[j].end   = virq;
+				res[j].flags = IORESOURCE_IRQ;
+				j++;
+			}
+		}
+	}
+
+	ret = platform_device_add_resources(pdev, res, j);
+	kfree(res);
+	if (ret) {
+		platform_device_put(pdev);
+		return ERR_PTR(ret);
+	}
+
+	ret = platform_device_add_data(pdev, &ahnode, sizeof(ahnode));
+	if (ret) {
+		platform_device_put(pdev);
+		return ERR_PTR(ret);
+	}
+
+	ret = platform_device_add(pdev);
+	if (ret) {
+		platform_device_put(pdev);
+		return ERR_PTR(ret);
+	}
+
+	return pdev;
+}
+
+static int dt_aest_alloc_pdevs(struct dt_aest_priv *priv)
+{
+	struct aest_hnode *ahnode;
+	unsigned long i;
+	int ret = 0, index = 0;
+
+	xa_for_each(&priv->aest_array, i, ahnode) {
+		struct platform_device *pdev =
+			dt_aest_alloc_pdev(ahnode, index++);
+		if (IS_ERR(pdev)) {
+			ret = PTR_ERR(pdev);
+			pr_err("failed to alloc pdev for node %u: %d\n",
+			       ahnode->id, ret);
+			break;
+		}
+	}
+	return ret;
+}
+
+static int __init dt_aest_init(void)
+{
+	struct device_node *aest_root;
+	struct dt_aest_priv priv = {};
+	int ret;
+
+	if (!acpi_disabled)
+		return 0;
+
+	aest_root = of_find_compatible_node(NULL, NULL, "arm,aest");
+	if (!aest_root)
+		return 0;
+
+	xa_init(&priv.aest_array);
+
+	ret = dt_aest_init_nodes(aest_root, &priv);
+	of_node_put(aest_root);
+	if (ret) {
+		pr_err("failed to init AEST nodes: %d\n", ret);
+		return ret;
+	}
+
+	ret = dt_aest_alloc_pdevs(&priv);
+	if (ret) {
+		pr_err("failed to alloc AEST pdevs: %d\n", ret);
+		return ret;
+	}
+
+	pr_info("registered %u AEST error source(s) from DT\n", priv.node_id);
+
+	return 0;
+}
+subsys_initcall_sync(dt_aest_init);

-- 
2.34.1

