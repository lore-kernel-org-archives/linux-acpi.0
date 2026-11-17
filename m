Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794943133;
	b=c3/HtBBcagpJ1QtrwIxTtek0AR5POa2LheylsJhAZtrNcOxPi4D5569P5i5QFYn5SZHP
	 whH1YNYLuPx/w0LfIXYCjaewotgtM5fu0Rb9k6Ax/fzHMsHs9dUbkzuotKraxDdlI7TTt
	 sRCDYoBW/NzTjG5XcqlkEzw/jitxNHunajXxJP/oYbUQbIQq0hQPvaZsqCbkc9qd4Xid8
	 YByLFg1azgmO1NhvDjaG6k5OhrIRL0oaYUj+qCCUV+ukrswcLzqOa+4hxHAPlTRDR3yDv
	 7IWR25vVwyfO91wdUhzbIkNInItgcklk4389FmVC+6hxsFyc5eh701CbY9UokHGv99A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794943133;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=6WtNEBbnNONmenOZy/udY419hxtAl9Rorvbbwtls2Jk=;
	b=faaKSSadCZ2CKIe5PZyvlcsqcAugECmJOOiMxUz4G+bjYXymbbZXPp7iK2H7+kRlzzQM
	 LEOdk9c9OY9ie/OSA/WuDchA20BJ+hyhF5yiIsrKkqyzjil0O3sTYwOuswP6T5VpM5mTu
	 3r+sCmXfgUgolAf30baJTyYxX6pe+OJRBSmA4snID7cyqhW1mic6g689HUDowxomruZ0F
	 oFIeowrnAIa11s3sAkRUnmzPKWsqu3xWf0tFiP5Bhwj5CUgJOD9yh2gHju5LRSYFJwUhZ
	 KU1joaxWWFYUHxGkNGW/i1Zsl5z+zQjGN76e3GC8cLsZTc4au+xH2XqN2HbatOQw0DQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=d3TXfaxo;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=D91nJgkH;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D9E606A332
	for <linux-acpi@vger.kernel.org>; Tue, 17 Nov 2026 19:18:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3D9E606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=d3TXfaxo;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=D91nJgkH
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHJ6MZg2160922
	for <linux-acpi@vger.kernel.org>; Tue, 17 Nov 2026 19:18:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6WtNEBbnNONmenOZy/udY419hxtAl9Rorvbbwtls2Jk=; b=d3TXfaxohU+UGELs
	rUaS8C24inW+N1r8qXo1ev31vnfAzxglCnk7PBk92XhoF9xGsG8GrWZQ/CDuaIvx
	0MQbuXSpRZo6I1nAGIkH4A261xpoV3ge9aXIrdNrGu0vmNiWya5q4g8ehu/ufGWJ
	L83XsUworFJ6xABgRqfvEyzI0mzd2Qs4XK6yGcg5VFkgIBtNrs11K3QmEn12+pmc
	GuGBqAYMt9BvAtyTgXqEqvbMEe65mbJADf2lAD/veE9OSs6OC4fqx+q/x1oQYega
	2bsntFTvJZj7wUJgVuJRMxKl/e/3NqG65zmDnD/z6rnXgLe9sRVQHTyVckgROFlX
	sp75MA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0kccaqpu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Tue, 17 Nov 2026 19:18:51 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-382666ea479so19662eec.1
        for <linux-acpi@vger.kernel.org>; Tue, 17 Nov 2026 11:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794943130; x=1795547930; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6WtNEBbnNONmenOZy/udY419hxtAl9Rorvbbwtls2Jk=;
        b=D91nJgkHI0+LeDRXZlDxstbNadzvvMa5leQHfe/83Jbhm6C5LdEbHpOTK962gHX4M3
         7DEtPh8G6l7OIRAT3FWAN5EnCyzD0kJmRWhMzvGWPiVLOYSTBYTDal4k4IMT2ByhdbGT
         ZrCcoPkaDw+gUlYXFXxmPAV6+ocryfMVcoffcFA83XH2XgzEP/upIhY8EA8r9lTPxeMd
         vrMzRdbuQR5W33Vye9x5xlqzX2z0sSnW8dSGPNzP2YbbU7z54h9PrP9C21j9tT4BJTen
         XyzGGKCGrqrtBWlkKzBT0nv3PzZz/01d3mX1V2ca1i63+dvARWD/Bd8XB5OFG3msYumE
         nuDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794943130; x=1795547930;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6WtNEBbnNONmenOZy/udY419hxtAl9Rorvbbwtls2Jk=;
        b=DioW+GF6gQ8AqA6UHfpojqv1+fozKxYXtmQEoOmT5wCZYxU6lpGW8ZMpSs8p1ekri8
         YTCTB7lgwldf/fW3nPpEKb+aFUXNopF2lhs8SaWnxeKeG2hQaRLq2QUvuU4F4+5WuaL1
         Rs02ELWRYYMdQb2vPDTO8jLjlPQeGNxlHQgv57jKWEiw26oaezPHpQkp1/NPLdbBN/B+
         OKHvJhoAjmEeBvO8i4H3QBgL4gAnbwPLPSnRmkzz+0fAXS3gg+nWbcaE0AbL3q6kBSr0
         6S47R0C4pXMHQIZBMPYKRNsle4LmrPIBIjkJHPuZcFUsSmKYQUdz+T+eVzaHmne7t+MP
         HrtA==
X-Forwarded-Encrypted: i=1; AL+hErGVyVePceoJk4yjw/RidR2O4eTmr+YLn9/k7FmyXsKcQRhu2+nOxf6jQYtMcoryCSX/Id4b4h+joflx@vger.kernel.org
X-Gm-Message-State: APuU4Z+QyWkk36n5cDQU+e/TU/ijoBMuDJnOs+Zu04f+cRymWQZ9bVuI
	u7Tr+LKb/yFoJGofPrsLZ7tTKTRDq9l68S0ThhHrY0LKu/GHSrahVdoczEFrDNr/uepRgF8PMzz
	NXk/lwnzEsiEzMMuTuont3q6nbT//rqrh9EFvoGZ9QOyGa6Op4QeIlGuFM2+poC/0
X-Gm-Gg: AZFdTZdh0uguxYShHOhEBNQ520mHUtpBHT/QlRYKVWL91bA0bccAemiINrHy19rHQK+
	uXSZcmdSbPSHj5Xo2HkSifEJs/RMRLZjok2B/NNBDIBgCprCY8M3yuWC1NtX20UdrvGhi/A48Gg
	3k/C+RrB4sA/sF5G0NYc4L8+2SwIx66cmCyFmN0ny86+MbvI0oWFAT7RJYmHkSxTon83t+pM6KS
	ecI39Jjzfl3DWwgeWmZ5aUK2csMG8FhOsoP6S6lL2arkElrUXEfFWQayE8Dq2b542YJ5GkUsFxg
	NolNqyLymNgMx4l/GfXV3QgIx4Bs047afueeSjm1HUBuBZ/knthdTd6Oxwmtck+Wdf4b3Zt8tpM
	7R7HT32kqmACWJ2AT+BtKu/ePGYjVT1z7ccHmnElD60ZCeY3w/EQQzMRWNkbx88jbwEVIjjzgE2
	eSxx5R
X-Received: by 2002:a05:7300:ce88:b0:36e:66d8:1424 with SMTP id 5a478bee46e88-3827b0ca41dmr541547eec.0.1794943130224;
        Tue, 17 Nov 2026 11:18:50 -0800 (PST)
X-Received: by 2002:a05:7300:ce88:b0:36e:66d8:1424 with SMTP id 5a478bee46e88-3827b0ca41dmr541493eec.0.1794943129531;
        Tue, 17 Nov 2026 11:18:49 -0800 (PST)
Received: from hu-uchheda-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a63059f8sm32197eec.9.2026.11.17.11.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 11:18:48 -0800 (PST)
From: Umang Chheda <umang.chheda@oss.qualcomm.com>
Date: Wed, 18 Nov 2026 00:48:20 +0530
Subject: [PATCH v4 1/5] dt-bindings: arm: ras: Introduce ARM RAS error
 sources
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
Message-Id: <20261118-aest-devicetree-support-v4-1-936587251e8f@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794943110; l=9889;
 i=umang.chheda@oss.qualcomm.com; s=20260328; h=from:subject:message-id;
 bh=79NjS3d8FLkHxoX2p2VWA63uMGScO/3PHtatyFaIXEo=;
 b=uf86oRyACdFsVDW/dEEUvCcvSDDZBrw3rFI3RVRe7znb15liCX7q1jett7B1hlljwmD49D5lB
 qS+iiOqhRfUBYpvWl20SNSWD56T5cT/IQcu8OJno9wmX5ZAPtDCNVew
X-Developer-Key: i=umang.chheda@oss.qualcomm.com; a=ed25519;
 pk=3+tjZ+PFFYphz0Vvu4B14pBQSzqcG0jZAQspTaDRQYA=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA3NiBTYWx0ZWRfX83bT9Gj3z2iF
 XrpjBtWYdI+lYIUnLwg3V1wnIyO3Gjf9oZqpiL9REpS5QL2u5I/rPzEvPY47skmxWnL8vYlUc0b
 zRa4elCI5Vk9DinsIV+d+l7hfCg1NyM=
X-Proofpoint-ORIG-GUID: QlGOT1SZTtV0lUXlVRiQkimijSFKI_RD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA3NiBTYWx0ZWRfXzr7QG0wxQkEB
 FNMH3aXlqTcbYkzLWbpHFP2YZ+YAAv3uNikglqEuUhHRwb97TNBC2f+lENotIyBOpjF1FGGuVj1
 efgLxVLlUqXfNE1Eo0bQhyl1/81+Sf1tKtkjWUgiYcMPMPbdcpikpLdJPISqfjIsqnac98BGIrA
 8Z6EzAQ9nt3RGK7cLYuaqDvaRp3GHcdELEr28DKhQbzU+P5bwZ97o/G/N4CQkV/fVgVvQ5Uhv9R
 R6WOJ6UnFimmswA8FzzXE9z/gOZc3l7u+2VCgbOT6uBp5YJQdKip7woDq3TJOUSEgJeDzJww/IY
 /ENoRWPsKrwsbKchvrUqEKdqJiR9uKOdMofAijhZlqXD2Io0vJqCfNifq6K3zNYs+tRBmwAC60m
 As16MC8TPKKHO7jBtwfcs1zs/0oLr9ypZX6MQhfupBAvwfcr9tn9ylG0dv6eWLUzvHDkJWw5L/n
 cNUKs/v7Y8X1tmD4X1Q==
X-Proofpoint-GUID: QlGOT1SZTtV0lUXlVRiQkimijSFKI_RD
X-Authority-Analysis: v=2.4 cv=ZP1CCn7b c=1 sm=1 tr=0 ts=6afca89b cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=Lrng1kJLq-4Mmy5ilNsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 spamscore=0 bulkscore=0
 adultscore=0 malwarescore=0 clxscore=1015 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170076

ARMv8 and later processors implement the RAS (Reliability,
Availability and Serviceability) extensions, exposing hardware
error records through a standardised register interface.

Add Device Tree bindings to describe RAS error sources.

Signed-off-by: Umang Chheda <umang.chheda@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/arm/arm,ras.yaml | 241 +++++++++++++++++++++
 include/dt-bindings/arm/arm,ras.h                  |  11 +
 2 files changed, 252 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/arm,ras.yaml b/Documentation/devicetree/bindings/arm/arm,ras.yaml
new file mode 100644
index 000000000000..257a5f5375c3
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/arm,ras.yaml
@@ -0,0 +1,241 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/arm,ras.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ARM RAS error source
+
+maintainers:
+  - Umang Chheda <umang.chheda@oss.qualcomm.com>
+
+description: |
+  ARMv8 and later processors implement the Reliability, Availability and
+  Serviceability (RAS) extensions.  Hardware blocks that support RAS expose
+  one or more error records through a standardised register interface.  Each
+  error record captures information about a detected hardware error (cache
+  ECC fault, TLB parity error, interconnect error, etc.) and can optionally
+  signal the OS via an interrupt.
+
+  Each DT node described by this binding represents one RAS error source —
+  a hardware block that exposes a set of error records.  Error records are
+  accessed either through system registers (for processor-local resources
+  such as L1/L2 caches and TLBs) or through a memory-mapped register window
+  (for shared or off-core resources such as L3 caches, SMMUs and GICs).
+
+properties:
+  compatible:
+    description:
+      Identifies the class of hardware block this error source belongs to.
+      arm,ras-processor covers processor error sources (cache, TLB, etc.).
+      arm,ras-smmu covers SMMU error sources.
+      arm,ras-gic covers GIC error sources.
+    enum:
+      - arm,ras-processor
+      - arm,ras-smmu
+      - arm,ras-gic
+
+  reg:
+    description:
+      Register windows for this error source.  When absent the error records
+      are accessed through system registers (ERRSELR_EL1 + ERX*_EL1).
+      When present, each range must have a corresponding entry in reg-names.
+      The primary error-record window is named "err-records"; additional
+      optional windows are named "err-group", "fault-inject", and "irq-config".
+    minItems: 1
+    maxItems: 4
+
+  reg-names:
+    description:
+      Names for the register windows listed in reg. The first entry must be
+      "err-records" for the primary error-record window.
+      err-group is the error group status register window (ERRGSR).
+      fault-inject is the fault injection register window (ERXPFG*).
+      irq-config is the interrupt routing configuration window.
+    minItems: 1
+    maxItems: 4
+    items:
+      enum:
+        - err-records
+        - err-group
+        - fault-inject
+        - irq-config
+
+  interrupts:
+    minItems: 1
+    items:
+      - description:
+          Fault Handling Interrupt (FHI), fired when a corrected error
+          counter overflows or a deferred error is detected.
+      - description:
+          Error Recovery Interrupt (ERI), fired when an uncorrected
+          recoverable error is detected.
+
+  interrupt-names:
+    minItems: 1
+    items:
+      - const: fhi
+      - const: eri
+
+  arm,group-format:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Layout of the memory-mapped error-record group window.
+      Determines the number of ERRGSR registers available.
+      A 4 KiB group provides 1 ERRGSR, a 16 KiB group provides
+      4 ERRGSRs, and a 64 KiB group provides 14 ERRGSRs.
+      Each ERRGSR reports status for up to 56 error records.
+    enum: [0, 1, 2]
+
+  arm,num-records:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Total number of error records in this error source, including both
+      implemented and unimplemented slots.
+    minimum: 1
+
+  arm,record-impl:
+    $ref: /schemas/types.yaml#/definitions/uint64-array
+    description:
+      Bitmap of implemented error records.  Bit N set to 1 means error
+      record N is present and active in this error source.  Bit N set to 0
+      means record N is not implemented and must be skipped.  The array
+      length must equal the number of ERRGSRs implied by arm,group-format
+      (1 element for 4K, 4 for 16K, 14 for 64K).  For system-register
+      nodes (no reg property) a single u64 element is used.
+    minItems: 1
+    maxItems: 14
+
+  arm,status-reporting:
+    $ref: /schemas/types.yaml#/definitions/uint64-array
+    description:
+      Bitmap indicating which implemented error records require direct
+      polling of ERX_STATUS by software. Bit N set to 1 means error
+      record N is not represented in an ERRGSR status register and must
+      be checked by reading ERX_STATUS directly. Bit N set to 0 means
+      error record N is represented in an ERRGSR status register and can
+      be discovered through the ERRGSR scan path.
+      For system-register error sources (no reg property), ERRGSR
+      registers are not present. Therefore all implemented error records
+      must be polled directly and arm,status-reporting shall be identical
+      to arm,record-impl.
+      The number of array elements shall match arm,record-impl.
+    minItems: 1
+    maxItems: 14
+
+  arm,addressing-mode:
+    $ref: /schemas/types.yaml#/definitions/uint64-array
+    description:
+      Bitmap indicating the address type reported in ERR_ADDR for each
+      implemented error record.  Bit N set to 1 means error record N
+      reports a Logical Address (LA); bit N set to 0 means it reports a
+      System Physical Address (SPA).  When absent all records are assumed
+      to report SPA.  The number of array elements shall match
+      arm,record-impl.
+    minItems: 1
+    maxItems: 14
+
+  # Processor error source properties (arm,ras-processor only)
+  arm,cache-ref:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    minItems: 1
+    description:
+      List of phandles to the cache nodes (L1, L2, or L3) that this
+      processor error source monitors.  A single error source may cover
+      multiple cache instances (e.g. one per-core L2 error record group
+      that monitors all L2 caches in the SoC).  Each entry is a bare
+      phandle with no additional cells.
+    items:
+      maxItems: 1
+
+  # SMMU error source properties (arm,ras-smmu only)
+  arm,smmu-ref:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to the SMMU node that this error source monitors.
+
+  # GIC error source properties (arm,ras-gic only)
+  arm,gic-ref:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to the GIC node that this error source monitors.
+
+required:
+  - compatible
+  - arm,num-records
+  - arm,record-impl
+  - arm,status-reporting
+
+dependentRequired:
+  reg: ['arm,group-format']
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: arm,ras-processor
+    then:
+      required:
+        - arm,cache-ref
+    else:
+      properties:
+        arm,cache-ref: false
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: arm,ras-smmu
+    then:
+      required:
+        - arm,smmu-ref
+    else:
+      properties:
+        arm,smmu-ref: false
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: arm,ras-gic
+    then:
+      required:
+        - arm,gic-ref
+    else:
+      properties:
+        arm,gic-ref: false
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/arm/arm,ras.h>
+
+    cache-error-l2 {
+        compatible = "arm,ras-processor";
+        arm,num-records = <1>;
+        arm,record-impl = /bits/ 64 <0x1>;
+        arm,status-reporting = /bits/ 64 <0x1>;
+        arm,cache-ref = <&l2_0>, <&l2_1>, <&l2_2>, <&l2_3>;
+        interrupts = <GIC_PPI 0 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "fhi";
+    };
+
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/arm/arm,ras.h>
+
+    gic-error@17a00000 {
+        compatible = "arm,ras-gic";
+        reg = <0x0 0x17a00000 0x0 0x10000>;
+        reg-names = "err-records";
+        arm,group-format = <ARM_RAS_GROUP_4K>;
+        arm,num-records = <1>;
+        arm,record-impl = /bits/ 64 <0x1>;
+        arm,status-reporting = /bits/ 64 <0x0>;
+        arm,gic-ref = <&gic>;
+        interrupts = <GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "fhi";
+    };
diff --git a/include/dt-bindings/arm/arm,ras.h b/include/dt-bindings/arm/arm,ras.h
new file mode 100644
index 000000000000..cd11e360fdae
--- /dev/null
+++ b/include/dt-bindings/arm/arm,ras.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+
+#ifndef _DT_BINDINGS_ARM_RAS_H
+#define _DT_BINDINGS_ARM_RAS_H
+
+/* arm,group-format - error record group register window layout */
+#define ARM_RAS_GROUP_4K		0	/* 4 KiB,  1 ERRGSR  */
+#define ARM_RAS_GROUP_16K		1	/* 16 KiB, 4 ERRGSRs */
+#define ARM_RAS_GROUP_64K		2	/* 64 KiB, 14 ERRGSRs */
+
+#endif /* _DT_BINDINGS_ARM_RAS_H */

-- 
2.34.1

