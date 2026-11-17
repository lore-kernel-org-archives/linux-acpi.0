Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794943142;
	b=4gbJDTDHiOtPB0XnIYqwuwq4sc3wY4BM9Q2lewq6AauErqkka1vMn4Nsbr+dpvpjxIsA
	 1wVRp2k2K00CFjLSe2DkpJMWc6j0fzmFTyW74e4rHhWDAtNfi3XIgdmIZaMM1I7G/q0pf
	 YDg+O35KF3zyQWFM/qlVdMDZxH94uc+GT+U1x+T7ixEdeXplK7scfb4ZF3MCdCXvtPr6m
	 0GI/UtGS5wmUOaRPj4ymAKr+pLeXOln7L8o70/gsbCPRNZxMv7Qc1RHSr2NJj6jSwJViR
	 8yvoNt+BN8FsU/LtxBVqzWXwqSBM36Z1QxrCifvx7YIiEGkU+0m+XBehaUELJ+CJiXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794943142;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=KPHTWd9iAHWemteejR12WVzHkTcvAkIXFYlVZZE2Gzw=;
	b=XD6ge4jwSgdky6FlOXeyZ4GBm7cQBeX7Xa2EqaP9FizyacMsWMKQyFubLpcZrwcpmZum
	 x57wJD0ITXcc3U+FaCduDuLOlfxPD+e5NYKDVIsWpdjq3Bw5NIGf84PN7moQvmqUoXApu
	 og5HCdKOtRln0a3owSmouet0zCdTm+KpQxV5IoYKkGB/4InBoBn14u7cxxe7pWaPeuFYy
	 zteMRjvC5W/QoR7/YD0tPW0pvzrNqY/2jBOL0Dz+8Klgj5iFvCt0F/VBotW+uveDMeJda
	 s3O2sTezG3RBCFQhhytjRtCx4hrrVtkth5AZHzIyqwKg2D0PGJ1J2d33sAU4f/fqv/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dLP1ki0B;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RVVNd8MS;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816FB606A331
	for <linux-acpi@vger.kernel.org>; Tue, 17 Nov 2026 19:19:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 816FB606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dLP1ki0B;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RVVNd8MS
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHJ6a143093087
	for <linux-acpi@vger.kernel.org>; Tue, 17 Nov 2026 19:19:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KPHTWd9iAHWemteejR12WVzHkTcvAkIXFYlVZZE2Gzw=; b=dLP1ki0BPPq2LGgo
	VyVXC7oxByohw61fkS1tqRYqEXgagznui+Ke8alEn9dtJFdOCBJyaa1TTp7H/RTK
	8TpymRaV/VPOHlJD+UjE1OJ/ey5dnasjveEXQKjY6IhQbr7joAC6O8Cvt4c1N1lE
	F5R+c6FHRxTmhdiAlUIi2TJ7n9dupGYsp3WYl+SsDnBIc7s7bHQ4RZ9aVDg2MZQp
	065IgE3FvzsAFg43FEY7FPOOBjqZ9eDppgMCNA2yC2f+EMtPdt73Rm9s7HyZideG
	WI9lXPloYKVNg4R1XgI6rOPdN69EBE4rh+aCoZ/iD1hLnYS3HYdYUNL03G4lS6Vg
	9hlREQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0tjm0skf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Tue, 17 Nov 2026 19:18:59 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-30c58d35c0aso53370eec.0
        for <linux-acpi@vger.kernel.org>; Tue, 17 Nov 2026 11:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794943139; x=1795547939; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KPHTWd9iAHWemteejR12WVzHkTcvAkIXFYlVZZE2Gzw=;
        b=RVVNd8MS4mXHhACVWDZ7fZBMRdEgLQJs95Lh85ta511USb7hR2YdLEqcEpPPdQ9jgD
         i30OQ8lCx5HgEg8+Ig4YK5xizhSSkLBslifVqF7+e0n4Lz9TEBQZQUU2uwxqDnhug842
         FdWLYJqBPN5W/wScP6sZvR/T/611FLjV1mvy0zOjWwcovdKYL5kQS+BJZCAoI32M3dNc
         9posEIaSCndf31H4rdaGlDsXbr7h+0HqR7gMkfR0zBy1rL30MXTKnqCdXy3K3Tv1LNgN
         HOscyQz6deP7fNAV8Ac/b+via/wF9YAITdEH+mBuCXeAEv1hycUmFvo0bUGJOSftbb8P
         crfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794943139; x=1795547939;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KPHTWd9iAHWemteejR12WVzHkTcvAkIXFYlVZZE2Gzw=;
        b=Q6f1VMhMxrE/pe+3lPyqjEe7IK8admOaR9Pzy2alNTRqK+jG56KPEwFQ8PVLs8oRYh
         OvLjZhSSC1Mrf13CnOywY4g4NCT8K98OB9TcpMw5x6K8ER3mjBCuMK6fvLHsy9yWzRuM
         JG9k2i3oCGP0BO42cFMKn+b+BWghyjFPCvixiVJuzRc/JDQTxT6F+3Bv0Uku00/lCcyN
         0kzohtQGc0yzP7z6qvN5SSkq2tzyXLICmYBnxn/s/nyKGOxpKtUGPzR0vKQR5iYVWpz+
         lp/EpRV02dFSoUFpsN7jyeP8+iOy75M151jEb5xaYLvFaq64ORObba1KHueeSMQieroT
         rs8g==
X-Forwarded-Encrypted: i=1; AL+hErGFgASIs/D1SHp120NmGXozfkAcBBpT8ZJggDquDmfxBQdGF6DqdeZWQtgIIIqu13yAqKYivoQioJ0a@vger.kernel.org
X-Gm-Message-State: APuU4Z9klejwwtFsV5GjwmXUSxARvJN1VpGdnIXV6HmO4YtbTK0qckoe
	VEzvrO7+hi1RMiO/gxs9v4ajM4hoknpQBMarH8uDgJYo9IlZfYOmLhuDH8W/v+6PYOuxMc6Chjm
	LTF63F8f7kxGNEtUY7BZetqJOXSvME2waesSJbKOBftiLwx1pepczlrPk67qD2Gkv
X-Gm-Gg: AYBFou3i99CWqU9kMq5YrpHPDPP8m0iP8c8YMdy1Vbop3DQaEExI+JFbREbHLLaJv69
	iSm9DGe3aYbSev6Yunb8hAz9u6jxiIFiMqcDQxv3faXZkWucDuxUbVczrhJt/IoyKwt/RtAL/I0
	/2Yrl9QCxjtaZQngbKz2tibcAp7ShpjqjBh/9OJP66e9YchuGWMPTyz8+h6YTjg4JZPgeyvx6Iq
	r2A4pRayzxHh/mATMGiTNgyUd8odQpqOksCH+SOFvBZLjzKdta3MyKCnwh2oSm9LDzEWkmIIu0d
	hqdVbCu62bH9iFrsUiWMHrSm6Mts+sHj3Wy4EdqaqBNhtuTjl+kpHNb+RDmSCMoj99ViZcC4SBx
	D7Rddx07u7GQHjVxVbpiEeZYWjZFIPIC/i8RZxsFtAPebMdl8UcjN4ktWfef/7ANtaHl3RK0BZ/
	wlvAOt
X-Received: by 2002:a05:7022:698b:b0:1b2:5884:a039 with SMTP id a92af1059eb24-1b543a1715bmr1033640c88.0.1794943138631;
        Tue, 17 Nov 2026 11:18:58 -0800 (PST)
X-Received: by 2002:a05:7022:698b:b0:1b2:5884:a039 with SMTP id a92af1059eb24-1b543a1715bmr1033587c88.0.1794943137888;
        Tue, 17 Nov 2026 11:18:57 -0800 (PST)
Received: from hu-uchheda-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a63059f8sm32197eec.9.2026.11.17.11.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 11:18:57 -0800 (PST)
From: Umang Chheda <umang.chheda@oss.qualcomm.com>
Date: Wed, 18 Nov 2026 00:48:21 +0530
Subject: [PATCH v4 2/5] arm64: ras: Add Device Tree frontend
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261118-aest-devicetree-support-v4-2-936587251e8f@oss.qualcomm.com>
References: <20261118-aest-devicetree-support-v4-0-936587251e8f@oss.qualcomm.com>
In-Reply-To: <20261118-aest-devicetree-support-v4-0-936587251e8f@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Umang Chheda <umang.chheda@oss.qualcomm.com>,
        Ruidong Tian <tianruidong@linux.alibaba.com>,
        Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        James Morse <james.morse@arm.com>,
        Sudeep Holla <sudeep.holla@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org,
        Avaneesh Dwivedi <avaneesh.dwivedi@oss.qualcomm.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794943110; l=14332;
 i=umang.chheda@oss.qualcomm.com; s=20260328; h=from:subject:message-id;
 bh=SA+WFB18bCBLL8m5hfHN69rlj4xnrx6aPqTp76I1liI=;
 b=CZYAriH/5s8birLHoX/eamOwfPL/jDsMiTkIZhSeAKVf4RBaCAS9zS67OlI+25M9jNebL4dJ7
 1x2f3UfFBruCnOd8Oq8fPz7vNSXGvXI4lLAC2akzcAvZLpuWrMqZQhZ
X-Developer-Key: i=umang.chheda@oss.qualcomm.com; a=ed25519;
 pk=3+tjZ+PFFYphz0Vvu4B14pBQSzqcG0jZAQspTaDRQYA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA3NiBTYWx0ZWRfX8aYbnZ9p+ugG
 HUt6zYYZlzmLHvlY2rJYKMVFTaLcz9O2OP6ClLQK3z7lXXGfL6kWapN6pSkUgzJSLkqRKB4WcAW
 8lUW/iEe+LyFqoU7+czrZlQj70Si+YJZ0rJnkjEd49+BYjt3LTXKzEvJTVq8UnDCUmbKSV1EWeM
 JaaT4WankyrXB0rKDaw+RhKSJTxRHBSUIhvCYVroSEay7A35K7SHVBYULePbX1zutgF2eomuUqs
 Xgd0TcB2A7k7bXb0BcXYglbS1KVKEvbAwwoBQfQQjBTzT2MtZOiRgcXmTRvNw39CXGq77BWHUhM
 SAdIPfz4qbAh/vFqVK+E/c7eemAdoZSeJj6hu2zxHEGKHeKVR1aXUgr05Y84NQt0c2jkO2WC02Z
 x6n1x9NCYRIc9PjiTcsfGxgbMP+Vwx/7zk+KSlBZiTyeJk9fnu1zsOJbVnaoBpjEQmN+bP77TYt
 YAHLz8flLJ+aeSC0Rvw==
X-Proofpoint-ORIG-GUID: zbwouoHVlEAl90jn7lppiXpBPmv-TzbY
X-Proofpoint-GUID: zbwouoHVlEAl90jn7lppiXpBPmv-TzbY
X-Authority-Analysis: v=2.4 cv=Br8IUoX5 c=1 sm=1 tr=0 ts=6afca8a3 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=aBVxLUBa_37c2xUlyAEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA3NiBTYWx0ZWRfXxCmoY+XqmbsU
 9dXU+a8TCXrB99chHLo7lJZJG104FhBJWKwawczL3j4JnFNj2BTRTLwKVJyw0Yr65kRQ+wKSHhK
 m3TXBgfOgN86oWv5ZhaSZR7LBNFaa8s=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611170076

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
 drivers/ras/arm64/ras-of.c | 383 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 405 insertions(+), 5 deletions(-)

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
index 000000000000..d876031f2474
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
+		cache_np = of_parse_phandle(np, "arm,cache-ref", 0);
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
+		smmu = kzalloc_obj(*smmu, GFP_KERNEL);
+		if (!smmu)
+			return -ENOMEM;
+
+		smmu_np = of_parse_phandle(np, "arm,smmu-ref", 0);
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
+		gic = kzalloc_obj(*gic, GFP_KERNEL);
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

