Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D883CD8D3
	for <linux-acpi@vger.kernel.org>; Mon, 20 Jul 2026 08:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784535625; cv=none; b=XsazEFBNULWE/MCMTZUD6q/XF+tOjbjkjm5AUgfBgQvwYly06ONTY3mWyMz3nMOlUeU04F+mNoWiRSehOXJxT716Yc+lYkxzzcieU3ioVs31HwGxLLSJqcyxAGxjl7SSES8UTgwc9B9Q+U0+nJPyr2aXSHOzxj9VvhIOdmbbE4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784535625; c=relaxed/simple;
	bh=LguZjT7GKeUUgrj51jQx7Dm0HFaF/8/45Y0SLA/wlxc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rnlvyBg0zw0+/Jfpp4Ov70eFk5Oy/CkxXf2lCGp+hGP8YiiCUEbisvpQdv3z17zYmtyzTUr6Li7TS7vs7t7K2gcDUBDRlTniHSa+/ukk1ojG+28DFB0MeQbRytYSjQ99Z+q7vnt7m0D5ggTqv3k9e6UaGwXn9D8frW3D3GV4qyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TgiQ0gpR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=A3q6HSE3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TgiQ0gpR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="A3q6HSE3"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66K76vPv1896152
	for <linux-acpi@vger.kernel.org>; Mon, 20 Jul 2026 08:20:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=NfCf51RUqor
	XyFdsLGdUkQI+nh5Md50HAkZl5LCPKlQ=; b=TgiQ0gpRl1uVJFXlCuHqBR+t/kE
	0rcRDizbw6p1LpqnEqV16LB5z7n09pK3ru+4QI1V5TyFpm/9OO+DvLZuzq8uisDY
	WYQvxhhXuktnpHzXhIfczeHNAp/n46dyNqgZsUBum/TbZup0TW5LwFnEmRKajTCS
	bFRQ99ldAbk3h/jfRq6lMLZPWiHPOaQuhsNB7bsncDLASXJWnn0QVhUMrxLkxCta
	3CBV/WVqNiHhSumZq9E0o86l66JTG8wlIgMIkUoGI9hMvICIVLKldDJFVWRbWDZr
	DRU6TfBczFXMfKVG/9cQ0CJ/+9MjjfH6/fu0s4Wcmk8iywQqIe6YCRkYasA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhf0kr9ap-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Mon, 20 Jul 2026 08:20:19 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38105cc58e1so2410297a91.3
        for <linux-acpi@vger.kernel.org>; Mon, 20 Jul 2026 01:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784535619; x=1785140419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NfCf51RUqorXyFdsLGdUkQI+nh5Md50HAkZl5LCPKlQ=;
        b=A3q6HSE3n3Kf46HZFOcLEZbfuUhaDhUZYXbhV1gzJiFBXKPI7tcoatP5pjvldMts/3
         XbXZXS657x+SpTEAajf1jg1kAUI+T134fuDogiR2WDnfBdMmohk0dmBjTldRuhtdxWVA
         0/cI63ja8Sckkvkc8yf/Wl0ZfyWzs+cuyDzoiFPc81JFNgPGPol/0syZ1jKaPZuNwUzq
         pLLIAiOD1uHRwfwkAAU/IVCIL6I79nck/pTPlVQDHjSPsnFiXIwXbCqsyfsaLEQDKcx3
         2l5zC/iGy7QqlsXu83TnjXQffi1tZcqKtNC/4vnYGvIl4EF1ROQN3UAl4GsXdfxB8Dh7
         aE7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784535619; x=1785140419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NfCf51RUqorXyFdsLGdUkQI+nh5Md50HAkZl5LCPKlQ=;
        b=eHf1zjSnGRP/wDZDnjAfsb52FZBtqiSfLkMM7MBza8HwxX5XZaJBBGOnl0gSlozIXJ
         7RhRXBra9VjGAVKVeNtOhooIHRKOANEc4GLEOd91MdrF9NDBL/jQtkkCdU+NQMD2rK1U
         yTL5jUptPs74lWcGTiYAdq1NulsZs62USVUdGzCtzXkKYlwvuxIG7Yi9UInKjJ3CuXeh
         VMl7j3O0B8JbhoMlao8u8B/zrRKddyYZnz0x/g0qM8HHc/SCxdLrczCoxEQ+vlW079n5
         QogDq59wD+uHAmx1qc27rE71KK/VVNlQcv/a56iYECQNNdCQeTJKT/c0jk//ttHNBuJb
         7V3w==
X-Forwarded-Encrypted: i=1; AHgh+Rp7dTC9ny5zFsVAZ6ZCJXmTHf0339enr4leRNY5HZ4lfBGI75WbfSJO15vwsWLEjhp6Sh5kg1sQMvcp@vger.kernel.org
X-Gm-Message-State: AOJu0YyOIJrxK9AfCxErVZ9dYIIqmBFtoT1ZJuqzktoLnE1FgI3wkQTc
	4nvJsMQeZIGypHdLJXGrNNb8XYY2yERxsOCIfjbHeH1zdj6+x3icpFPAImydi7he7XDI69nog78
	jnw2Qhsbtyc8qoSR3EfPjQVm8LCR1eYFTVzd/WJmxOAVE9ZYxsN9Bjvlug4UjoqnE
X-Gm-Gg: AfdE7cnz43hktT4m+iL0t0T5OHucFHcOckrrj8OMASEN5J1vD5Xyyy8oWk9zwAi328u
	8flr32BQUqV4jvQhOclaLZ7jjp/voc8kIXuyQKnoIpdJqxeDOnnwUOcEu9Ya4ZrMBEyaqnFI0nO
	+Ys407tj86BeEi5kQGqpHEt2SP4JgXUg/4O+C91wfqSAUtbzLWpiKyR++HCuf1/Kik/wBzNM5Tk
	8NpBkJgGoLWgwfzmEcKHUbz/zU7MCV8nNE/vxFzcLwKb1m91ZvawvpshY5Y0zg89VQZ5XLLdvVP
	Vzoey1T7sV/QDslw52OR3s1qVBvjaErlpznjInS4cf0kAhJ1dptU/RlnjpDl+ZnQE6W7tfz3MFF
	9sF96AOTzSwkRXNIiTff8eSOQviWZzyQ=
X-Received: by 2002:a17:90b:48cc:b0:381:2788:a437 with SMTP id 98e67ed59e1d1-38e4b45428bmr9482091a91.1.1784535618691;
        Mon, 20 Jul 2026 01:20:18 -0700 (PDT)
X-Received: by 2002:a17:90b:48cc:b0:381:2788:a437 with SMTP id 98e67ed59e1d1-38e4b45428bmr9482052a91.1.1784535618141;
        Mon, 20 Jul 2026 01:20:18 -0700 (PDT)
Received: from hu-uchheda-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e39e0531asm7233688a91.5.2026.07.20.01.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 01:20:17 -0700 (PDT)
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
Subject: [PATCH v2 3/4] arm64: dts: qcom: monaco: add RAS error source nodes
Date: Mon, 20 Jul 2026 13:49:53 +0530
Message-Id: <20260720081954.1858180-4-umang.chheda@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260720081954.1858180-1-umang.chheda@oss.qualcomm.com>
References: <20260720081954.1858180-1-umang.chheda@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: MATYgkaKVGFM6AlYQO8xKGPuhFCZxGoX
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA5MSBTYWx0ZWRfX7pHWi1bQn4Sn
 RNfaYlEyZPzo2qpS68nMb3LiI9ocgjkmb77gi6H3D34wB6M0H5Rxofw4PHDF3jFMn4xyRvhkFC2
 aJmQcUvIOyxUYIw0GiVLWB9+dthk4k0=
X-Authority-Analysis: v=2.4 cv=G58s1dk5 c=1 sm=1 tr=0 ts=6a5dda43 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=hf7YQE2i2jH5Ah-ZJM4A:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA5MSBTYWx0ZWRfX/kYp/9G/e6Cg
 wEvVnBxH6ZpO7wctYP0gcfHejNG5NH5p9GrhOBgBfDLukEtcr5veRSZ/W3jaT5AUMncGDMBXval
 Zs4Da41JnD9Ifi9PYBmaM09AT1R47TrcFjmYY/pjMoOsFDYDDXLtZs4bn3zpxrMl1kRf43Um7Bi
 AwOW8lufvCDet0RQeT7GUP1TLuzCsrIcLtKTwgObCaRB+9GbqvRHgCanspIVJ7/8aTt88NuxAjY
 mbZXk6JB0HbpToZFDZZ2C1DC9cUS7EAqybzPbex4wdN1yJJNn1bVTGM8yoOHnu/PAEUOMcJfmyY
 fzQjnismWc4+BSlh24fzSQhNNXFCTw/rC5XHQallYNcwErUltBbQvu2NdaZS7shqo6/MU/yKc+D
 hU7eB3F0RxCgdjezHr5y4hOedWfeBT0TaPVKXMCMBgWWov6mOhRAUykzJ6PSoLsL8I6n5/J9IOa
 GldvUONb9Qum5l251Pw==
X-Proofpoint-GUID: MATYgkaKVGFM6AlYQO8xKGPuhFCZxGoX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200091

Add RAS error source nodes for the Monaco SoC.

Two processor error sources are described: a per-PE node covering the
L1/L2 cache hierarchy using a PPI, and two shared L3 cache nodes for
the two CPU clusters using SPIs.

Co-developed-by: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
Signed-off-by: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
Signed-off-by: Umang Chheda <umang.chheda@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/monaco.dtsi | 30 ++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/monaco.dtsi b/arch/arm64/boot/dts/qcom/monaco.dtsi
index 64fc0d592282..4fbd1dc9a147 100644
--- a/arch/arm64/boot/dts/qcom/monaco.dtsi
+++ b/arch/arm64/boot/dts/qcom/monaco.dtsi
@@ -724,6 +724,36 @@ system_pd: power-domain-system {
 		};
 	};

+	ras-l1l2-0 {
+		compatible = "arm,ras-processor";
+		arm,num-records = <1>;
+		arm,record-impl = /bits/ 64 <0x1>;
+		arm,status-reporting = /bits/ 64 <0x1>;
+		cache = <&l2_0>;
+		interrupts = <GIC_PPI 0 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-names = "fhi";
+	};
+
+	ras-l3-cluster0 {
+		compatible = "arm,ras-processor";
+		arm,num-records = <2>;
+		arm,record-impl = /bits/ 64 <0x2>;
+		arm,status-reporting = /bits/ 64 <0x2>;
+		cache = <&l3_0>;
+		interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "fhi";
+	};
+
+	ras-l3-cluster1 {
+		compatible = "arm,ras-processor";
+		arm,num-records = <2>;
+		arm,record-impl = /bits/ 64 <0x2>;
+		arm,status-reporting = /bits/ 64 <0x2>;
+		cache = <&l3_1>;
+		interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "fhi";
+	};
+
 	reserved-memory {
 		#address-cells = <2>;
 		#size-cells = <2>;
--
2.34.1

