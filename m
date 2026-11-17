Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794943166;
	b=00YRgSDaVyRhR23a2sYJje2I9eEX21UvZD+BcmBDnjBuzvnAUcEdrFE2BOJyi5Lzp6Oq
	 VdUPjS3AYYS2MWnB4dgtoOn28AS+XZ3WzgzzBV/MXcuYfbBFcDBPhoaegB7Ye+Dvs7xmq
	 DrDHLcwbjPTzI0XSxwQXmIbQ3/m372tAN+6k2abkquiObBqu+07jzZSD06CvcqCJtTjdz
	 FaGVH3YyiT1fYYHuuYVirUfcRRxb5IoXXjdcu07CgpM1yBWdsF3Zl2iIymGp6PaLL5KSd
	 tHTCj/tUAuTStRS1h4wl5pBXzGS4gXoKlxeyycKFaAzrFgqvPbbfQKbfEjTHtP4/QDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794943166;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=60Kl5Jhv1mOsJK3qcOKqjwIXh+EBJS44Vine9B7VtJQ=;
	b=tUBDHbwKK1Vf2BFYctfUwn/CPd/JM7/WbfeToLmGNphHNK8Oa32VAdYZl2UOo0cLNKb+
	 OnEHWp6ow2dFmZx9vc/X6pzmow+m/uj5YuFxoPqJ3fdLNq0r42K4cbgFlYYhKOEZu/fLM
	 HrasByz5iPWSY/NLsSoYR7tAZFyokQmaGuOLaDWPbW+z+JBEhO8YkU4Ihw4eyE4Zc3KGW
	 YezxQ2nrtxZ3lo2qEmZ6Nk3mWxDBX6bwjKKRbKfYj6wZAlSH5MynLfl4BgGW959CHtCJj
	 rfhDKrQu/Sa7yYy5E9SiJA9Max1q0QRww0futuPyZaRNmC4h9px5nQ4XzTo4OZ4dcYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bySchDoK;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=d0bCDLlP;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407BE606A893
	for <linux-acpi@vger.kernel.org>; Tue, 17 Nov 2026 19:19:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 407BE606A893
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bySchDoK;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=d0bCDLlP
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHJ65LQ2411497
	for <linux-acpi@vger.kernel.org>; Tue, 17 Nov 2026 19:19:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	60Kl5Jhv1mOsJK3qcOKqjwIXh+EBJS44Vine9B7VtJQ=; b=bySchDoKDpg5Lyxf
	LPhloKc4BcpgB9pLUWGjAuXw79fUW0N9QerIdmZa2zgUPU6hOlNyUtOWD9pX294u
	SWlI23EpZD5+X0oZM3Zm2C7ILJApd0GUOH2dVm9Fv6XBPgvNpcUqrGP7Y07A4ahf
	KApR5X8Tb0hMKNWby5sul0fQpuVNj97hrCEBbN7dWF/Hw+kdt9yo7ZGclNQC64j9
	L82FzEOeNwDkVE/9Ir/J0WGcZnoqkRvWkOWNZ1tL8doSs19JwqmtBEvrw78KGvqB
	YMjUH9PKmKO71JHA0Er3vPHS1T3NMzPUlNJsfA27Zz1AMIYB3TbI7AnK7EGcl6kT
	1YhWnA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0nc829xf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Tue, 17 Nov 2026 19:19:25 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-313c7315becso25588eec.2
        for <linux-acpi@vger.kernel.org>; Tue, 17 Nov 2026 11:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794943165; x=1795547965; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=60Kl5Jhv1mOsJK3qcOKqjwIXh+EBJS44Vine9B7VtJQ=;
        b=d0bCDLlPzEcPE+hzf+jM+ErIMdSfQ8LHN9hziWZfGze8HsmaSyfbPloaIIb1XbpmZu
         XxXwMf+cV7QbI7fTRgicLpKIsb0I7QzqBGHhTLU2a2O8I62MCnt1oM2QjuvT4+uCj8yS
         1jXJbxA8JxScfg8C3qniiLCNvjzLRd9W4u6MeIW+R5iRHBiOFXwuPcOpjVwQEnfe7cdC
         bXo66F0Ji8+ZMItaTo6Y3UrrGjfDnpIyjoCtFWc86dBHXF0TlM3aZm7TD9JpwUbDQZzy
         BWfXY4Fyhy/0FmyAB3pDjh8D/sUeWY2q4yLydGNqew4TaKeBzhNh/ckNgNUfkFRu2k1b
         sy4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794943165; x=1795547965;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=60Kl5Jhv1mOsJK3qcOKqjwIXh+EBJS44Vine9B7VtJQ=;
        b=R/u5isGBPNJx3OF9mrSA83pdXNd39A75NtVbt+cHHkfXjOxRzGKMlG0Rrm12CcB3Dp
         PP9THVS6vEME2CXeBi3XAC1b+YBhsHu5Vx4q05s54TpYcFBLPdxfndB0yY8xEFVNHy+y
         bSSs3rwYnACSRWDhC2Nn/IyJe0agv9ZPToLEpOEUh5gpmyFtgUOkngI09HHNy3Rg9VPh
         va7hzPFyK4IdXtpDf+rcTs3xhJnzMsQHWr7YJQfAUottfMjI2wovaz99i9lPAGaC7C/G
         S1KEQYGyE8Cu8TMUXpNsYT/A3ariblHeVsTrA8EEyzi1UMr7qmoKdpWoZd8GRWyU8PnX
         MEOA==
X-Forwarded-Encrypted: i=1; AL+hErG3KdXBfe7ZYPkkk5o9t3YPv1Tk+1TByRLBYM+R39U5FZTZmYJQNAqQSq0/P6Ccf4M2yhMkno15mIpY@vger.kernel.org
X-Gm-Message-State: APuU4Z/TOYArZ6rf5zHl9Kf+1yrG8swu3Z3IJL0jbmdW3Nrxu9fbk4Am
	98yBe4h+2ku3JWdgXt7Nwm3Sj2zUVv+o/gu0K9cAa/P7LcKDfl9NHGbDwack/oTLiVkxMA3kuN6
	zxTIGcHxIkAJ5Vj6KWCojUfZChTL4IinyargAjwKR4LGEZfQbNxA3r9LDHKmMXm3X
X-Gm-Gg: AZFdTZe5dWrcds/tMLMp1PGxuNpKA/PTYwlmZS31DjeSvpYFfJxUTuawrUlQKc+OuJK
	0efgt4QPhha4fK++qPlVeQDv9a/8YPODWt7qp2fMYQGONGrRgTIyVzRS+FiAr2bvAAlK3wYl1Ku
	F7qFCS+krEFP3KPOF/OUWrEwfI6lvz8Tpx2zowViwxgyx1HCVX9y+moP8FbYMTeOk6TjnrlG4C1
	EH3KR4lhhvtV//M5YRXiIYvfp/sYOqUEr4SQQ8XS+CF/ygAZlLt4JMZI9ukD1U18BvP7qcOjVLW
	eqvR/SEDdqhz77KQbNBcRhNIC2pQ7PVCBdcVnm2bSwa71uOaXIcMTfzLdK9HlBMFalGtVEy3+d+
	T3v7M0ZKui0nEvkhHbb/6j10EQ2keEKH7NzP8RsQFMAst/L5jnRUGcCJB02s9K+PjhxLzB9cKbZ
	wiqKQ5
X-Received: by 2002:a05:693c:2a13:b0:35f:ea17:d171 with SMTP id 5a478bee46e88-38280a3c36fmr442130eec.2.1794943164704;
        Tue, 17 Nov 2026 11:19:24 -0800 (PST)
X-Received: by 2002:a05:693c:2a13:b0:35f:ea17:d171 with SMTP id 5a478bee46e88-38280a3c36fmr442083eec.2.1794943163858;
        Tue, 17 Nov 2026 11:19:23 -0800 (PST)
Received: from hu-uchheda-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a63059f8sm32197eec.9.2026.11.17.11.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 11:19:23 -0800 (PST)
From: Umang Chheda <umang.chheda@oss.qualcomm.com>
Date: Wed, 18 Nov 2026 00:48:24 +0530
Subject: [PATCH v4 5/5] arm64: dts: qcom: shikra: add RAS error source
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
Message-Id: <20261118-aest-devicetree-support-v4-5-936587251e8f@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794943110; l=1782;
 i=umang.chheda@oss.qualcomm.com; s=20260328; h=from:subject:message-id;
 bh=l4p+6RAlvNC5E20oYKN0nb7ff4u82f7dc2bTNZ2GTI4=;
 b=li63lc5/FvzsDhC0OVMhM2fAI1esfNRVndV37bAWoQ3HYHw9IMhiKeoAnPaF6wan56EyMZLvu
 4CD0N0soY2LCdmRX3A8h88fCBd4w+B9c0Tf1PKOMn3wPYEePiWS+WtX
X-Developer-Key: i=umang.chheda@oss.qualcomm.com; a=ed25519;
 pk=3+tjZ+PFFYphz0Vvu4B14pBQSzqcG0jZAQspTaDRQYA=
X-Authority-Analysis: v=2.4 cv=LaipeTfi c=1 sm=1 tr=0 ts=6afca8bd cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=a7izLWPGlrKpK18tDBAA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA3NiBTYWx0ZWRfX7GsmFyNuLYxP
 g3pOPeUS1VZ9ksmgULGqtITe4yNRHJ1KXlHy2uVdzmwLhOAvR7Q2jKoy9xXE1ojiD61fxJT/n7J
 3xFqMV3ccamX6H7R0M0tDhFk4cVWiR4=
X-Proofpoint-GUID: NlYRQlaPlbaJDn3oaSsuTaZakehWSfM1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA3NiBTYWx0ZWRfXw94NHWUgyYsX
 fMQz23CUmbHJX8tHvY/qPtXA5hGuYm9x0mN9ozyXpjNPI50JAYbjpSzF4sBymEwrSk+sw7XwsZR
 Gs6u2YQyVCjK4SRiPuRroWyGMf5J+pfBGvEUnGVMuuIJFAEZJy4pgAA7TYSVbNfQ+kfNfSpvBZf
 12O8TTsM6c2vaoeThDAu7YOmEQ/pSwGSTHC5dzqtytLOFC2bYlfVpYR5rp9qfaqffSpaihgKFYt
 4yamUw9cPlBLWhtQF3bkz/f6Cu3F7Qyj4okvlk3kUCUWkBvMjS4iAi/r95ag4Y9gAjWd3qkTb8i
 nsD1OpQh2JB+JpMX0tN0ZWbKaISKFpZ8CX2X7yJ6QQcIHBjIBV6FQLeAjosDbNnm3kboL0ijym+
 DsKSwDPHGJja8K3VmQq5f8GepCxbCgBaYdFgRFF/eYHCWbmk70qPZ+fFDnSSFerHJhrbzOjZsHn
 KWzlqxYNP28XqIu1aMw==
X-Proofpoint-ORIG-GUID: NlYRQlaPlbaJDn3oaSsuTaZakehWSfM1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170076

ARM Reliability, Availability and Serviceability (RAS) enables
processor components (for eg cache, tlb etc) to record and signal
hardware faults through architected error records and fault handling
interrupts. This allows software to detect, report and, where possible,
recover from hardware errors.

The Shikra CPU subsystem implements RAS error records for the L1/L2
cache hierarchy and the shared L3 caches. Describe these error sources
in Device Tree so that the ARM RAS framework can discover them and
handle cache-related error reports.

Co-developed-by: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
Signed-off-by: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
Signed-off-by: Umang Chheda <umang.chheda@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
index 2623e139196f..5c4a3ce34717 100644
--- a/arch/arm64/boot/dts/qcom/shikra.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
@@ -332,6 +332,26 @@ opp-2208000000 {
 		};
 	};
 
+	l2-cache-error {
+		compatible = "arm,ras-processor";
+		arm,num-records = <1>;
+		arm,record-impl = /bits/ 64 <0x1>;
+		arm,status-reporting = /bits/ 64 <0x1>;
+		arm,cache-ref = <&l2_3>;
+		interrupts = <GIC_PPI 6 IRQ_TYPE_LEVEL_LOW 0>;
+		interrupt-names = "fhi";
+	};
+
+	l3-cache-error {
+		compatible = "arm,ras-processor";
+		arm,num-records = <2>;
+		arm,record-impl = /bits/ 64 <0x2>;
+		arm,status-reporting = /bits/ 64 <0x2>;
+		arm,cache-ref = <&l3>;
+		interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH 0>;
+		interrupt-names = "fhi";
+	};
+
 	modem-etm0 {
 		compatible = "arm,coresight-dummy-source";
 

-- 
2.34.1

