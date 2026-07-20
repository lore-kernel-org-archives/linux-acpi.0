Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA8F3CCA19
	for <linux-acpi@vger.kernel.org>; Mon, 20 Jul 2026 08:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784535630; cv=none; b=WG5ITcIrpY7fP6p2xAeI0IVvlbQ6STk5deHsGjA60wJY6yj+bqiaHd+AO/s8ZfrQkS7ShCoJo6bifNFHqMG671ifAxiQKur4+W8T0FR2ZgQCuBhuiZZH6veRJS6EASz982pGHtZmlkWKz2Q5Dv+Ujsp1tlhxjH5mTGVjhRBAo8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784535630; c=relaxed/simple;
	bh=aiv0AD/suh5Q8DfpHWahqVpLMyb+b7u4U+TQtpkkaaU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Afqx2cARo+g1gZPaf/O89PbGz4rRwoAfnKxTikYEOQQ1X89apTKKLlZmDigV2yuQ0pF+KDAyAvPnWsy+XMvg+qV4gmDNPAgLtatY5KnBQ1IVvZCQw/n8C9N+xCnRql1Zhl/vGPH853dOP5e2eORc3oa3feamdv6iATJa9hVAuzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JIKteCJX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LyrFnLv4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JIKteCJX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LyrFnLv4"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66K6RTko1665546
	for <linux-acpi@vger.kernel.org>; Mon, 20 Jul 2026 08:20:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=AySNhEFQOTN
	/wXML7Im2LDtrkYAXvBDqSS652rSteso=; b=JIKteCJX8orE7wUxGG1lubywkxU
	FALVxjpDSMQVqIVSP9ni+w2B6tHuOHYHc/kCtGMBjdGA8LnIluT8WIZnkVmhSHZq
	pnk/PyPdcAlKRAiqbUUcKYjM8GaNBPnjtCzOCQENpd6FCwapIoy32gDfj9QRPXQO
	l0C51Wsj865NmqRz33R0kts1lPqUaiopCaTyy5zGD1pVBZ/Hc6m0rKSwLwJ9EWov
	oys9OPjkHFUSHVyVDQcKpK4WMBOG0gNeq+8NsJHQbg5RnYQvoPPrCFjwVqfR8dOI
	7H1kynKrkL2kDFV4z25X6KxSNUGgDgpw97n4jCMww3scxLQA16NwUALjwGg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fgd04v585-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Mon, 20 Jul 2026 08:20:24 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38dc0eee75dso2444540a91.0
        for <linux-acpi@vger.kernel.org>; Mon, 20 Jul 2026 01:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784535624; x=1785140424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AySNhEFQOTN/wXML7Im2LDtrkYAXvBDqSS652rSteso=;
        b=LyrFnLv4EslrdWwHJ0mDX0x3etbVQPgwRRD00utL/eLe6OypPROCB+bPGm0geLSava
         IcEyhX8AR3cfhc9T25FN3zHvuZChVP4v6eMp5kbe9OHWHL8prXXbx8BnN4p7NEflUssI
         XWgkYS9h8lpT+aJ0z9B6soc5OuRFczfUU1CehQ/xi7hFu0NBZFIIn2xVT01Pnb2qMY/p
         LMe55fBOMr/FuYAiB1VhnQ2Kt2AywW/UwprphzfTS3XmAnDBSQaOKkqm6qvGYsuBYVVz
         EmmfTljZwsnuGPaWj+JXWSWY6iMj9jfMxwtTq/jX9/dDGvIbs7fv9SQBc9sPUsvomEDu
         pgUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784535624; x=1785140424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AySNhEFQOTN/wXML7Im2LDtrkYAXvBDqSS652rSteso=;
        b=OEiKsk9NKgk15F0o1EZi2mmYvbOxHrei4gr2qoz4BinceHFQOlA1oRRjlwiA635+/H
         sfh6i6GhjH6KabM/Hc/c015wUnIAJN+Ymq2t2jqaTTdZI+PQlQDSJx8dHA19OQkc2wie
         gtg5bEgTrZExzy/Zez4u6WH+NdUj1ATVPv0Iqw89jxgx1drg4Y/VOVSKUTQo5UH9Tbcp
         SeJaizfReskcot/hMqW6Hh5F+3KA+ybsKEdHBTkruvl9Ii06vBiCtyP1jHzXbiHjcLbz
         oMuuWyMKHSdKJguweWb+FgGzFWCQxRJTBX1GAravP64KHvpC3vuUfJ0tZ13OiMEAKgr5
         Z1cw==
X-Forwarded-Encrypted: i=1; AHgh+Rpwn4k4qQGmPYSisIkc7uWihfb2EEroAMsQbJs5cyb7BO9PUMgWwOcXJi2KesxLoWmqS74cmzbSGWK4@vger.kernel.org
X-Gm-Message-State: AOJu0YwC1oIx5Hzh8p1zmJkVzv2QN/JuTWl3geaO1+ZG0xRvhzrV/99B
	lj0O4yQP7lnl9u5VbPSzz2KWA5kTTt0xyRa2N/bVWbmrSUK/MNllO8Hyrd16soHGJuY4E41+FV4
	9bIJBznEkHnfPpzHnXfjhrRlz08YoKGUvY8F9pgDVwyrJgk1CJp8IhjI+WzLEyoTM
X-Gm-Gg: AfdE7cn8FPeVzDPxe77e96W3dYdSlo5hYMk6M8eGNjqEtKkvzLWw4uLsziC5LAbZ1NG
	7GHHKcWIyp1G7H7NRFdVAA96F7r4LBy1vW+cRGbe2ECrKVSRa/oXUKus6eA3XCcRwUg9E1fVMD9
	RHE3pxNQzz69G5k7pJIvyBgifbBqrEMIDNu+hIf6nr13eoWigoiyy8oibcWT+Awb+dkEq2ThoKg
	zuc6tYyJGvjnQIRSu51y9VME/OM5pbWDe/X/EJY/X9P/bbXh1UvpPy6SC9D0YmFYEgft7HMplIh
	lfMxuGWdCnGXsJzhhB3F/2TXfaauVb9AipaUy1emeqtpKficWwhv9kB5olM5QjVtydYKDsytFX3
	KbPDovL3RyLu1rrqN9vSO2YV04YygyN8=
X-Received: by 2002:a17:90b:264a:b0:37f:fc3a:382d with SMTP id 98e67ed59e1d1-38e4b6044fcmr10163021a91.6.1784535623926;
        Mon, 20 Jul 2026 01:20:23 -0700 (PDT)
X-Received: by 2002:a17:90b:264a:b0:37f:fc3a:382d with SMTP id 98e67ed59e1d1-38e4b6044fcmr10163000a91.6.1784535623504;
        Mon, 20 Jul 2026 01:20:23 -0700 (PDT)
Received: from hu-uchheda-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e39e0531asm7233688a91.5.2026.07.20.01.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 01:20:23 -0700 (PDT)
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
Subject: [PATCH v2 4/4] arm64: dts: qcom: lemans: add RAS error source nodes
Date: Mon, 20 Jul 2026 13:49:54 +0530
Message-Id: <20260720081954.1858180-5-umang.chheda@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=POs/P/qC c=1 sm=1 tr=0 ts=6a5dda48 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=isxhWOj3iQD9eQR5az0A:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA5MCBTYWx0ZWRfX5+7j4XgdMkwF
 0XV7P+9dAdTfMFThAkxjmbUToYGJtu5iCSpMAfbANX6fHZZLPBl8RfJAa3j7q416IljuagcpJeS
 7EPPKxumf/JcfDXePmFqt3EY5ttbQ0xHwoG3pcClvzhN42piIrB7njLKQmv9pDP8Fe1AWWaweoM
 FASnx8n4IpDUYaKrVHbSe99QjMtnuBbh5BrVGLFlFj50shSuKBsJ9X+ZwDMPo+DgM/IjfFgSBZ5
 jNRE5fZcORH30cLyP/VjqyyRoxKHjTq/MrI099M+ATk+pfrwybj60CPIo0bR7DLuzRDaAqjeABX
 3Tf37blCzr1o33hxGkv3E+enshmMiwc5Zvjtgka+c+vDF+LtnWkJEVjvDByocFtBKNFUoosTk8d
 m0P0MeoMp8PT6klmU6dcXJZYLzJQiJuQR8dWWvaJ9PzzUXAL77WGKTlOEa91t03hA4FwC3s4Ejb
 TdY+wtQWPCm3x/xZ/cg==
X-Proofpoint-ORIG-GUID: Qs7d9sMJLdnU5a0RiHeUbWDLH8tcYgpr
X-Proofpoint-GUID: Qs7d9sMJLdnU5a0RiHeUbWDLH8tcYgpr
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA5MCBTYWx0ZWRfX6RAcSrZ+4zxw
 ptrC96uVYdVWFuvXw5jhHBk5ImkMXiau47CZnVvUIYZ8jph69dCraeN5lsygJoKU7MKiOgBwOwf
 wYE18r99RZROfSm71iAvT3EMdvsFwLs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200090

Add RAS error source nodes for the Lemans SoC.

Two processor error sources are described: a per-PE node covering
the L1/L2 cache hierarchy using a PPI, and two shared L3 cache
nodes for the two CPU clusters using SPIs.

Co-developed-by: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
Signed-off-by: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
Signed-off-by: Umang Chheda <umang.chheda@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans.dtsi | 30 ++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
index 3b0539e27b51..64d3370cba82 100644
--- a/arch/arm64/boot/dts/qcom/lemans.dtsi
+++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
@@ -619,6 +619,36 @@ system_pd: power-domain-system {
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

