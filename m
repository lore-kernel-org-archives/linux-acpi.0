Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5714279F4
	for <linux-acpi@vger.kernel.org>; Tue,  5 May 2026 12:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777983947; cv=none; b=N3Za8lr4sKSpsAoiFMaSnVV0TBoRgXqhFS2a6cNejHKtD3h1vwHeN6eqlNlP2zfexZcVYlbWOZjQUmiUoZh7U8R5k5bL5kq0EO4GnFyHKYJeR+5nxNIviA6h26eRE41adXgMA34hfdxr99Nxjo3+VUSAYm/vNTdcybv872SVGZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777983947; c=relaxed/simple;
	bh=YOcZgnUU7aNUADZbewVlvFKcPy4NxigrSCC0vnQKVC0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=USfKvn44ueUVvy4WMjVZmCHcSojes//g5wDtTLHIu3vyUy1EE8tW8fDT4FW6YzYfEnNCMYZuuPgYfSIOs3Oig2RfVMOo7FiNuZRueDjk6gIJKn9JECn7MuLU1E8PwQy2GHVqTpwuMtD0bI4cGbFmk7OXstpYcoWpP+4/vzEjsjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=elXwbKAS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hjY39Sqp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="elXwbKAS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hjY39Sqp"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 645B6L7l3091349
	for <linux-acpi@vger.kernel.org>; Tue, 5 May 2026 12:25:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cezRDIDuuGgXSugZUDs0zZVIa3d2l+pmJWevmxHgvlI=; b=elXwbKASq3qWKy3v
	e4Npmt6BrwzXXhMyMhh8mMOfkCkGaa2hCjj9DdHm4ZHNhyPS/5nNEZphaOsBeAMP
	hya9Due/LQzDgnRGwcT5kieWSAqSpbCj/xWXVlr0c7NbhYkgvZ27AVLgAyqTrLAY
	bJ5EMqtI/thEr3G/LluNuy7EGovejlgM50GPfuzpMeOlCX8mtfCupYjbFLPRi1JK
	XmdIAAY+kFnEKTGkMbduOMFMw3DPfahp4ME50z27QQ85SXsmBGIeEMnFYnYReP+2
	vl1kl2hjRBn16/FflTPzhJFkVaVVyBIuPvMvZ/syTEJCJZxdKBFMxLac/pgK5WTy
	eFqcNg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dyfct07hy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Tue, 05 May 2026 12:25:45 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8217f2c9359so846153b3a.1
        for <linux-acpi@vger.kernel.org>; Tue, 05 May 2026 05:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777983945; x=1778588745; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cezRDIDuuGgXSugZUDs0zZVIa3d2l+pmJWevmxHgvlI=;
        b=hjY39Sqpci5KhWFzV5YMtKt2Wca7Y75nZa/k6Mikm9F9w8cnZ3TqZ7LnkrEazU72ly
         ciIyqCv1qvSk9wYa7cBRUCou5qmSRXcmDU+T37XgO+xZSwAWMAounojzDpKN16Z81HWL
         DEkTd3S2o3kFlWE5leX3f/OgCFYys09ukeCGPcvaePIWE9aCiVhznPA9rKT7sEsrYqmp
         UK80Ijs1i5glSWaFFXxgn3UB0RTnH7UDN4PtQ+6nPVYbXaPb/CqcjFEI9uK+SjV2mOCK
         ppVLpxU7gkJAs1TIXD1XDMbQwzddKuVHeZOnozGflqG0nXs0H3wTRFmv/mEgT31E+d4C
         RTYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777983945; x=1778588745;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cezRDIDuuGgXSugZUDs0zZVIa3d2l+pmJWevmxHgvlI=;
        b=EU9WlCuiJJDpbaVo7YaVodjsDimEfi2KI4bS6UETUBIi24FKsNs92ITk0anOwqP7Me
         J87IO+yM1pk8gksYhxtwmdlxmzocLIQckChDd/e/06Qimyet4fHDkdB0/OYNvpnRh7J8
         qrWXY/FTlx+7xvsGVkUz1zWvx8mAcIA9RaSGMOpE+cmLQvMxN95BI+y2D37t8lH4THSi
         uFxsKuplDXNlfAvQtMlsl7zqUqqmdQMBXvCNY2uLTz12aLknv2nSvmBJjCAobJuXxXio
         Lq0qESU6u17Deqdzc2HHKnYUkpzTZSrqEa/yKmdChw9Nz+faFw1FmGOik4pFShEIuKFz
         y8ww==
X-Forwarded-Encrypted: i=1; AFNElJ9LHm2UTYG0Zmp8C2dcguuWgfc66WIkEul1AKcRpCEmvsqoFhqyR5coWJViXYZFmu0dLQK8FROfBnrQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzcDEcuWy/rujG1AfD5+PMguoHOHFCJEOsOeFj0OZ/s7YfAKZyZ
	Z6SZexqI/hcfQWIT4OST03ACjNJZTo6LBlolSdIabmjiZYtEsHpKfFHkcoprX6LBHTuyiQvK1iD
	Cez2BWi0jV8/XnFUiapiWKmarVAkvAqr9V4XSg+HD7/YpodG2RAE8TH5mpWXg2tMc
X-Gm-Gg: AeBDiesgV0TKJiHo8XxX9zkxgebQW5QhJcgpvMX0Yw5N5EfqhSTcrrq4E4ILP4iDp2W
	LnVHjAZFYqVY3Ayzg33EEYmmEDBg03QVUPFY2cOlNOFeTsTYx193sL34dmyPUSrYtzsTdj022DT
	diL6V1IpU7nwYlcE41C5UColE8FnoEsITk8bI024xsEReCn+8/Z4LRRNrDxM4LfDdHtzBUQ4okq
	wDJsgVwWYPeuFBGQhaWdNh85qZxXfSdcIcXS2OYLoRZPzT6ABfCJsBg1H3TRxBpt/dOLlS+hTOm
	i7QHZJY40Pljn64/TPwNoB24+ZX/iSr7AZhcbJibnZxMToQwlrcvL+Og3K5vvrtmqWkncg3lh90
	lwiWXT5+f5YzxNnlDlmshtG63aj6OKvLpSJkE1/AOT62YHaGa6nUpAmrL8Wd7cFs=
X-Received: by 2002:a05:6a20:6f87:b0:39f:6343:c6e6 with SMTP id adf61e73a8af0-3a7f1d53191mr7943153637.7.1777983944525;
        Tue, 05 May 2026 05:25:44 -0700 (PDT)
X-Received: by 2002:a05:6a20:6f87:b0:39f:6343:c6e6 with SMTP id adf61e73a8af0-3a7f1d53191mr7943130637.7.1777983943895;
        Tue, 05 May 2026 05:25:43 -0700 (PDT)
Received: from hu-uchheda-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7ffbbaac5bsm12597998a12.6.2026.05.05.05.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 05:25:43 -0700 (PDT)
From: Umang Chheda <umang.chheda@oss.qualcomm.com>
Date: Tue, 05 May 2026 17:53:52 +0530
Subject: [PATCH 8/8] arm64: dts: qcom: monaco: add AEST error nodes
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-aest-devicetree-support-v1-8-d5d6ffacf0a5@oss.qualcomm.com>
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
        Umang Chheda <umang.chheda@oss.qualcomm.com>,
        Faruque Ansari <faruque.ansari@oss.qualcomm.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777983885; l=2471;
 i=umang.chheda@oss.qualcomm.com; s=20260328; h=from:subject:message-id;
 bh=YOcZgnUU7aNUADZbewVlvFKcPy4NxigrSCC0vnQKVC0=;
 b=IHRZKVkkhxU9y02nDwnaD6SzrjQm04m+20HXWuq2/N4sWJObINqXltUQZ1/qyBP+tvKxUc5iD
 JMepAm3K+K8CN73vjyA6Efr0HTg9ztmpukLEzg04lLRt4vmu3gpMBMM
X-Developer-Key: i=umang.chheda@oss.qualcomm.com; a=ed25519;
 pk=3+tjZ+PFFYphz0Vvu4B14pBQSzqcG0jZAQspTaDRQYA=
X-Proofpoint-GUID: oGgaTIrFgb0QLpfvnL4aZcZh_6_Q13OI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDExOCBTYWx0ZWRfXzmGpsmQQqUEA
 ozqTQnjy87qHoIAEjI+n5WktVEFrAjrTLNsR0MzZoZocMkErY9Z4RXfbdmveZC+bf84GtpveoAa
 HW47ejb28zyGxjnPGrk47xos+2hwu/ntgKOOz2RrhD1KdbzuSPfbZQXJ46qyW1nhB1Kh6KK6hD+
 sLtMiEAVmPhSuakPfjtwpLbpqTqaDmRm5F+iZFZ0f+BOHPFP6wl/fYYA1oyS/lFNdhgji4Wn8Ci
 WkvWjd1ZVDINshQoDUqkhuK6urcrJZqaZZvXbre3B1iOEC9N1ylEDuDPOx39NUB4Yp/I/bqcVcY
 jvFbZEFHBWij/e1AdtabNDqHb3WrleR2F/8gq1ny+7nLllysL27T+ewNzJP/cFdzvvzFL52ae6Q
 Slu5LzcPklJL/G71JcNLLJ3LhR7nSxaGOxi5+/Y/KW8zIbBghrxhzIYNegZMTsPevVYxcWf18BB
 qxTAE8wD57aMXZDQNfw==
X-Proofpoint-ORIG-GUID: oGgaTIrFgb0QLpfvnL4aZcZh_6_Q13OI
X-Authority-Analysis: v=2.4 cv=NtXhtcdJ c=1 sm=1 tr=0 ts=69f9e1c9 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=JAhf3ahiasQHMHGiI4QA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 bulkscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050118

Add AEST RAS error source nodes for the Monaco SoC.

The DT describes a processor error source covering all CPU cores and a
shared L3 cache error source for the cluster. These nodes model the
hardware error reporting blocks and associated interrupts as required
by the Arm AEST specification.

Co-developed-by: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
Signed-off-by: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
Signed-off-by: Umang Chheda <umang.chheda@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/monaco.dtsi | 41 ++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/monaco.dtsi b/arch/arm64/boot/dts/qcom/monaco.dtsi
index 7b1d57460f1e..8e43ceed7d84 100644
--- a/arch/arm64/boot/dts/qcom/monaco.dtsi
+++ b/arch/arm64/boot/dts/qcom/monaco.dtsi
@@ -3,6 +3,7 @@
  * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
+#include <dt-bindings/arm/aest.h>
 #include <dt-bindings/clock/qcom,dsi-phy-28nm.h>
 #include <dt-bindings/clock/qcom,qcs8300-gcc.h>
 #include <dt-bindings/clock/qcom,rpmh.h>
@@ -29,6 +30,46 @@ / {
 	#address-cells = <2>;
 	#size-cells = <2>;
 
+	aest {
+		compatible = "arm,aest";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		aest-processor-0 {
+			compatible = "arm,aest-processor";
+			arm,num-records = <1>;
+			arm,record-impl = /bits/ 64 <0x0>;
+			arm,status-reporting = /bits/ 64 <0x0>;
+			arm,addressing-mode = /bits/ 64 <0x0>;
+			arm,processor-flags = <AEST_PROC_GLOBAL>;
+			interrupts = <GIC_PPI 0 IRQ_TYPE_LEVEL_LOW>;
+			interrupt-names = "fhi";
+		};
+
+		aest-l3-cluster0 {
+			compatible = "arm,aest-processor";
+			arm,num-records = <2>;
+			arm,record-impl = /bits/ 64 <0x1>;
+			arm,status-reporting = /bits/ 64 <0x0>;
+			arm,addressing-mode = /bits/ 64 <0x0>;
+			arm,processor-flags = <AEST_PROC_SHARED>;
+			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "fhi";
+		};
+
+		aest-l3-cluster1 {
+			compatible = "arm,aest-processor";
+			arm,num-records = <2>;
+			arm,record-impl = /bits/ 64 <0x1>;
+			arm,status-reporting = /bits/ 64 <0x0>;
+			arm,addressing-mode = /bits/ 64 <0x0>;
+			arm,processor-flags = <AEST_PROC_SHARED>;
+			interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "fhi";
+		};
+	};
+
 	clocks {
 		xo_board_clk: xo-board-clk {
 			compatible = "fixed-clock";

-- 
2.34.1

