Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794943149;
	b=Ocev7q3/11r6X2y0Xd202onF5ebTaVwg2+4aEWu7LnVv/XzMmSE/biA27Xc6YA0uC5oR
	 vbQLqPEQ6fPzA9AAsrfHUOPcNXtlmLiDigr+NQxSGmdIGdbm0rVWJW9U/iXDMvvEcbA9h
	 XFvXLGkEwhvji/G7mk6Q8AaTLnkyUGP8FGs/2lBC/N6oq9XPYtdNwxinZp2hQ/HxXjsm0
	 C77OQRKWrc4wgvPCLWYJeleIiaDh+isFkZyGSLycT2YCIvgUe/iJaP4d1UhSgCTu4XOqL
	 mrLOroFdxmVFz0BktyUVZIJzoB6dOezZb/KtkJjScgFv9Fuy6BDJoPamjX4WR2jrcPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794943149;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=P64yP0RrCxgP9qn5wf8Xtpf3P+cqpGU4XTo5fll5/sk=;
	b=nXVkAmsjgrY89S5XayPZUaq0p+NG+IrCi/5tOij79VT5i/GZzq2GoyBKPtnoTebAG7Ja
	 e1DAbs0IuQ54qdtjWz57s+SFTOBdgzwey4jIe1ubw4GcwZOhEegirZhiaVthsRNir8xMi
	 tn+EFYVNzxF5VoTjUzPhdBaF4Aq152IrE869UxROsMEh+tF4hlj8Fu2fzAsYBYj7Fxwmz
	 jV1FUdfuDVqX7Nb+4TL3MU67OUt3pgLWLOVg70cugyOsjqKtXW4SkAuQZMuTUvlZmOCpL
	 uAElDkWAWJlqkG3DOs/q1YMuN/uvqOF8FCygpfPUJAJ7RTTDLf5OTz9n6RrVyhAlB1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hkXSH2lU;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dZ7o9Sh6;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44324606A32F
	for <linux-acpi@vger.kernel.org>; Tue, 17 Nov 2026 19:19:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44324606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hkXSH2lU;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dZ7o9Sh6
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHJ6mC41494626
	for <linux-acpi@vger.kernel.org>; Tue, 17 Nov 2026 19:19:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	P64yP0RrCxgP9qn5wf8Xtpf3P+cqpGU4XTo5fll5/sk=; b=hkXSH2lUnTJOZgeo
	cw2HIU8tUsiI3jryBWqsAgMWzxIno/nxpSwM0W+PUou0vwlBNq2eik1MGWw+6D7u
	KfXYpcW2OmsHrTPlrrUA98z0/BzzRIjsDtyVBWVgYy3GKhsVSGqEuoEPW0Ug/WY/
	jKk3qiBuzqK8d5uznp+UvxlV5MEte8euEbmL3wiD9sigkUjeF3subD1RSotLkxTr
	pew1BMfDzEpY4si+fLOjC9mbpDFRvQ39mAZTS5Tqv6Dl2BWUpq0yxWxYqDg9oj21
	hxszz4pyS57oSXOLf7UW0LLYso55IBJGqy/BmP2OGI7Hdxd6QATtKZ8gCCgktBy3
	7dOW7w==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0hkd384f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Tue, 17 Nov 2026 19:19:08 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-36e61c89e2dso19250eec.3
        for <linux-acpi@vger.kernel.org>; Tue, 17 Nov 2026 11:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794943147; x=1795547947; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P64yP0RrCxgP9qn5wf8Xtpf3P+cqpGU4XTo5fll5/sk=;
        b=dZ7o9Sh6Y3a4okWmZPl2nuoXKfCGLd3a7beYoH6pNZcuogpZ04BjsnYQqEdiwYg9He
         h+Ueqmxmc3F6yJZknJkk/nTHmcMpzkYzWgL+4CHeMGmV1UWDDdqskfRK55yb7KGUM1A8
         q/n5G8F/zwskgq3lj6uQ0ofbzgyiDlaY2XZNCjuDzTo60brdNmlKXAkYyUdML1o7AZW/
         vqgjbA5hYAmHV+G1NU2w80YdPrRSAiOvuPwwfU1jg7tbJuKMlGvvt9mZSQWJzE6A8gK3
         LjrHYQnNtl1BsiT1gtnBVh7q/7oyq7N/llpAdRz4AdzgoDROG1UyAIGcr0vs6RdYUxk6
         gKnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794943147; x=1795547947;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P64yP0RrCxgP9qn5wf8Xtpf3P+cqpGU4XTo5fll5/sk=;
        b=lLjydznGnJoPfbJoyL8/QDKOXfGfZFPV2r9wzaRcZOIH1dbtzfpX3ybgR05f7yFmE3
         elXaxKlCdABz9cTyOlLtXWV0gLrmJ2NpBYZHs5xvGK16k/DmJyfJw+CLW6W8jopYr7yD
         H+3zrFII6WzsskxKkmiScpBURHqXfXJ2Yxon9deykifD80nhFEnqluBCvhNX8mQyRnyB
         8kSMMFWAEoHhMa346jOJU+BRWx+wYKwTeJ7K7I9ocpZRA444lH6j2SDbMj6/ptq2SU+N
         IKtZWR1gnOniFiopMSo5JAaAvc1OWeZATRQrRSA86BwN5T1NxZFVmXfBxdA0w2zUtI0r
         cANw==
X-Forwarded-Encrypted: i=1; AL+hErFzmd3aRn2Md7PDjNaMObw1OJvqc289C7NPPQqxrLXw6bHWl6yIVeAM/dPscqMA9LeYSzlgVlmNSa95@vger.kernel.org
X-Gm-Message-State: APuU4Z9SfoFW7IDmz6QnEbbdPC1Gti5SHvN4kFY6JXTTnsAGUvH4k0Wz
	Zz1g44mDOhnEbQFNdYB9iEQgoB6j3YdXXVjRgkQQDzOXFUhxUQba12RtOjbittz7OHSbpG9CCSg
	pJih8t99wjV01uLYEEAOEolasYftxGayD8yMc+IxZy7UpucUbmen7caGDOO9xkZ/J
X-Gm-Gg: AZFdTZdoVP/qc6VKjnx5lgiAzWzCeJ5baNu2BjbXVjFDl/Stad5KzLITKl2lwvmbZZO
	f6F1r34MaNdx+Q4/8MNnVc3fk0XSYrrwxs7i8fbJmAfEAny9uRKrpwYQfocoXWvzvS6BVIxpw2P
	yS1qHwJvlh5jUI92ZThKMaoG9fkgMppro/iQ+20ZZMNxO7tdLOCOk9NFjJK2jct97tuZYzGcV+h
	eC1wnBMsxLhWA/Z/MawCYWMqTNlkr+LZQdi1cwk3Rah9/dGrcuBb5Dpx17Q+e58Asve5aMK7Dfv
	AuuJtcZ7AvQyhDy6SXoY6aw96+SMY8xugqtP311mkhsHLEv33CmNMR/gpNKzARPHQXBP5dHerjf
	+Tj5Aki8niz9AaacytJ+/P5gbJ/MGEfBW2WOy4vVW5jdF7gcJdIizVV6yggNkSCFSAQp0DtgORM
	IPIiTl
X-Received: by 2002:a05:7301:92c:b0:381:dc3c:4c16 with SMTP id 5a478bee46e88-3827afccfd8mr520360eec.0.1794943146961;
        Tue, 17 Nov 2026 11:19:06 -0800 (PST)
X-Received: by 2002:a05:7301:92c:b0:381:dc3c:4c16 with SMTP id 5a478bee46e88-3827afccfd8mr520311eec.0.1794943146404;
        Tue, 17 Nov 2026 11:19:06 -0800 (PST)
Received: from hu-uchheda-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a63059f8sm32197eec.9.2026.11.17.11.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 11:19:06 -0800 (PST)
From: Umang Chheda <umang.chheda@oss.qualcomm.com>
Date: Wed, 18 Nov 2026 00:48:22 +0530
Subject: [PATCH v4 3/5] arm64: dts: qcom: monaco: add RAS error source
 nodes
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-aest-devicetree-support-v4-3-936587251e8f@oss.qualcomm.com>
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
        Avaneesh Dwivedi <avaneesh.dwivedi@oss.qualcomm.com>,
        Faruque Ansari <faruque.ansari@oss.qualcomm.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794943110; l=2183;
 i=umang.chheda@oss.qualcomm.com; s=20260328; h=from:subject:message-id;
 bh=rzIMy+dr2O5MmVR74ypVHrojU5YGoqey7SSKaB74tcU=;
 b=Cqehjv7sxt8HmB6BRMDrXCbGAdNFBY66C3nTKtWUTzfRwuHm3f0cD+YCdB0dJs76q/VA4mOuW
 7W+AFJKELTqAy8VkBh5ve3jTuZ1w0NyNMOsCc8C4vxQBn2t7Cnxf+lG
X-Developer-Key: i=umang.chheda@oss.qualcomm.com; a=ed25519;
 pk=3+tjZ+PFFYphz0Vvu4B14pBQSzqcG0jZAQspTaDRQYA=
X-Authority-Analysis: v=2.4 cv=eqFKXYpX c=1 sm=1 tr=0 ts=6afca8ac cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=KdVUwichBgNWhWzcVTwA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA3NiBTYWx0ZWRfX2eyTnhc0TrWb
 3YcPFxaduUfrh5tmLgWVzIP09gWnGFmXgTJAsuTeuxNxnISBQeZnYWkr1K+He+/qqUOz9Ly5RNT
 SM9srJ2otkR73UVLP4Pj7USMSeaXaGk=
X-Proofpoint-GUID: gT_hAPx9-U352-pevx-5i1K1Dg4cF2n0
X-Proofpoint-ORIG-GUID: gT_hAPx9-U352-pevx-5i1K1Dg4cF2n0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA3NiBTYWx0ZWRfX8Xsv0qqeeIfy
 u5aBNX4g1kCmOlPmCVWQesclKD3ButjrIgirAl2lHRsHgKgITvGbIkAoeMrpoI/sLI7fPJ8ps+W
 2xUzS9WQS3CQAspR3JBAt8j/tRI7kYrwu37RQDWlh2YHIDxbID3Z0JXJJlsRXoXYL1yjEg0ht4H
 dX956eIHd9/jwzrRlK0qbhcILrUPHTjGABWPTUb6rq8+ukghk6IO4sQ4sytqFx8bOXQuJ0V/nJ+
 dRFyv2xTg8hQzyj+clulRHcA1YYJrn3a7u3YV1HihR9nqDQ5OODAmiyZta3IiBol2y45sTgMnBC
 WirKgwMQBmVUemnxyMT1JYs8eFXZ7pEmPqF8h2TjwjI0gykx+wwPAhxkSVZ+cvvf3nPCjLFFhmZ
 gKJYpEzQN0se2mPMIfeDN0wXYSL8EEHXmLwWfX2wVFusL3w+YPEUO6ZF7Du03x2Yk0PzXkheCvP
 skq5rEDqesHH0T74epw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170076

ARM Reliability, Availability and Serviceability (RAS) enables
processor components(for eg cache, tlb etc) to record and signal
hardware faults through architected error records and fault handling
interrupts. This allows software to detect, report and, where possible,
recover from hardware errors.

The Monaco CPU subsystem implements RAS error records for the L1/L2
cache hierarchy and the shared L3 caches. Describe these error sources
in Device Tree so that the ARM RAS framework can discover them and
handle cache-related error reports.

Co-developed-by: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
Signed-off-by: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
Signed-off-by: Umang Chheda <umang.chheda@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/monaco.dtsi | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/monaco.dtsi b/arch/arm64/boot/dts/qcom/monaco.dtsi
index 35fbee63d4c6..ea60d6ade02c 100644
--- a/arch/arm64/boot/dts/qcom/monaco.dtsi
+++ b/arch/arm64/boot/dts/qcom/monaco.dtsi
@@ -617,6 +617,37 @@ scm: scm {
 		};
 	};
 
+	l2-cache-error {
+		compatible = "arm,ras-processor";
+		arm,num-records = <1>;
+		arm,record-impl = /bits/ 64 <0x1>;
+		arm,status-reporting = /bits/ 64 <0x1>;
+		arm,cache-ref = <&l2_0>, <&l2_1>, <&l2_2>, <&l2_3>,
+				<&l2_4>, <&l2_5>, <&l2_6>, <&l2_7>;
+		interrupts = <GIC_PPI 0 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-names = "fhi";
+	};
+
+	l3-cluster0-error {
+		compatible = "arm,ras-processor";
+		arm,num-records = <2>;
+		arm,record-impl = /bits/ 64 <0x2>;
+		arm,status-reporting = /bits/ 64 <0x2>;
+		arm,cache-ref = <&l3_0>;
+		interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "fhi";
+	};
+
+	l3-cluster1-error {
+		compatible = "arm,ras-processor";
+		arm,num-records = <2>;
+		arm,record-impl = /bits/ 64 <0x2>;
+		arm,status-reporting = /bits/ 64 <0x2>;
+		arm,cache-ref = <&l3_1>;
+		interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "fhi";
+	};
+
 	memory@80000000 {
 		device_type = "memory";
 		/* We expect the bootloader to fill in the size */

-- 
2.34.1

