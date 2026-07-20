Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4FD3CE0B8
	for <linux-acpi@vger.kernel.org>; Mon, 20 Jul 2026 08:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784535615; cv=none; b=fv4O1ToGfyn3FvnzbexOebxLfrDLuRSKjrjHeFCjZEHAYF9EAPGG7n/7sGtdKpxKKD0Z/pDuu+pdayIqDGgsptvK6wzlbEfgqIOgz33oD7E2C1lx+MPlpjh4+0hHazjvl1yFHmrJ0KyzHqTnv9NFYRtziliHLvOTF0GHLJjEJiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784535615; c=relaxed/simple;
	bh=iNz6bVPg/4hMr31LroaZwatYWh5fO709JGEdNlPpPIo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=opKbxv+VqM1FP6mvfrDrjk1jraZC5f26wi4qR3LJpgATZhvEkX5ga5mb3G1rQYIsqqcr1cci46a9ymeTCFfOXljgjnTcWxzSb9Z0zqld0Rm7E8NVjogzbPNyZczwS6imlWSyWkk6gOekKH+jfoSB2wqY/VGHKeNGvl830wY/CDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iELVpRNV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RtcSjZ0H; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iELVpRNV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RtcSjZ0H"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66K76QlI1712940
	for <linux-acpi@vger.kernel.org>; Mon, 20 Jul 2026 08:20:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iUicbWv1972dytQ4lxofWGDMjkj4G03jcO7S8W9fadg=; b=iELVpRNVbTkflcbs
	dO6/P7zwbj9VUYjyHPn8ZtFksczxMPBUVV2F8XKoWQgfAxzB0grJyDTc/4JsuB3o
	GhV5PQPXkGwliksXm9QLtJgGXd3t28tu2ZAmRbVLUt5r1sZzMrnAe9eUYUvLwiZ/
	5LGawhoNhbBmao2YcP7vycoHToejtnrNII5QVipebz9r0F17WlJljhvJV2teLkcT
	MlsWDB26ZzuMg6dkSvXW1yNhVAqvY9Bd5dMWm8LCz190LnboVtzdQuDWCtJ0noyZ
	KXmiPvjED3qG9fvYGkcP9N/uK9BGTSCISsOEvpoHVYUUFfmDuPLrkTeCuy+BxoLp
	PhXnDw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhf0c08ub-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Mon, 20 Jul 2026 08:20:08 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38ddc70b9d5so2185216a91.3
        for <linux-acpi@vger.kernel.org>; Mon, 20 Jul 2026 01:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784535608; x=1785140408; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iUicbWv1972dytQ4lxofWGDMjkj4G03jcO7S8W9fadg=;
        b=RtcSjZ0H+t3FHkFKgiTJasxc6HWiE+/KFFf7zGUdw5pHtCBCbx7Yw8DkjBvkJAs+k3
         rPemum1n59hDMTB0JpTn+3TpXbaGzZzSuDcIvh0fFYvzXLsa5hfpH2mWws6VIglSr7QA
         FiaTKo+Gg9RIiH6ehOeDmq2fBcyeTMeI5u4xCefXJ/uNMqc5sl7uU8F+MaKWTx83QCLM
         qf7cusKv4dS9VzynUJkS52QIpuxljS7uLw4PDjUAYe+kDyBe2NuJy1Ij2ZjEpazs7TdT
         nBxsQOsMs4D9J97cmP4/gX43vutIZBqj59G+azdD0+gRGSa3cZ3+ANnHTrPq3XDUMQAI
         vOcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784535608; x=1785140408;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iUicbWv1972dytQ4lxofWGDMjkj4G03jcO7S8W9fadg=;
        b=s77OAD/nATI+gxk7h+fWXnPvkV9Y1qcjyWJ90ViauTTz4YIvjyK4AkqEHIPUiXes9S
         RaZEMBbBo0pTsf1yB3CGrJreMncAKd5y4PQ61e/2PfgDLdm7DMPXfti1PaP8lLz1tsWE
         KlZxDeXteSgYOooNqbOnZpSYt6zr8mGjYPC4x8D/tQyYK1/dL/fW5IP6IvRyycc4TF71
         KLzujWaqXgRTvHMBlY1QpCrfV4xLEdlwQkCJDV4FYY5KgVAnchOT9upaHHPuND2d8KEa
         qsVdDNPE0ssZmDz/qBC3Vir5IRpertjQoBlG0rr93JyohOGxLMN/kluzasM7F5qkFPyO
         Mxog==
X-Forwarded-Encrypted: i=1; AHgh+Rqr4b03CYRxt0LptYmyBJ3QKjaILmEFYJz2wBgwSaT3KpQzkDkrLI6bIvwj0YlF2OqeFQy23Q/YLjZs@vger.kernel.org
X-Gm-Message-State: AOJu0YzeOfOoHZMi5UpyYk2fjSJllKYwHDvdF+EQ2FjbZ1Fcu0cpGtE+
	jZZWOhAV+tK4AJsrlsizPTNIyQCXgyaKPmckClQc4udPqCspBZsqBJLZnwu6h7eTvMaqKYxvMh+
	ngLusIl8H6JbvGIBGpG2WiBnJP9EGEM5gb+HpjFWCSxxt6pXMvebTJwMhqXIltPbA
X-Gm-Gg: AfdE7cmlD4SpXGYCDUjPvwZ1OdjaZyaUFXD4yeze5fQYhsQwkI7KjYRAaBw9a/0/jht
	cHiOe6IUgcDTNDdXsnUXZgxxBZoW3lvUyBoCOPaTmG6TTN2R8LdJQdotFIbThpTo8zsQJsZTP19
	WVle4LntdGwZ5tIa9Ykb0RJ1OKC8HofgXtTd1hIPUc5CeUqPVwbkyVpb3BjknDVkJUY4lmrHbm2
	T1loidngMZ4I0ckGw67/ZqHILqHGL0iSymVcT0EXdQ1F33du/Z7QF09u3AKhjRCQNYV5DzWlLzC
	ehcitxIoJ/XGF5a2OrU194KpHzFtWpEljaEHyDPNmX0/5Wn36qUFXvFbfpZx0NfXImWOciq2ACb
	7G0OzKXaB73dYJ8bG2r4XPIKknaP1WMs=
X-Received: by 2002:a17:90b:2642:b0:38e:4480:a518 with SMTP id 98e67ed59e1d1-38e4b57c5e8mr9750132a91.3.1784535607799;
        Mon, 20 Jul 2026 01:20:07 -0700 (PDT)
X-Received: by 2002:a17:90b:2642:b0:38e:4480:a518 with SMTP id 98e67ed59e1d1-38e4b57c5e8mr9750110a91.3.1784535607258;
        Mon, 20 Jul 2026 01:20:07 -0700 (PDT)
Received: from hu-uchheda-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e39e0531asm7233688a91.5.2026.07.20.01.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 01:20:06 -0700 (PDT)
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
Subject: [PATCH v2 1/4] dt-bindings: arm: ras: Introduce bindings for ARM RAS error sources
Date: Mon, 20 Jul 2026 13:49:51 +0530
Message-Id: <20260720081954.1858180-2-umang.chheda@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=HeYkiCE8 c=1 sm=1 tr=0 ts=6a5dda39 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=-Bc3UrWjzRgJN9FlZoEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: lXQwvGGhg0uVjS7eE36xTj7Hd8IdXSfB
X-Proofpoint-ORIG-GUID: lXQwvGGhg0uVjS7eE36xTj7Hd8IdXSfB
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA5MSBTYWx0ZWRfX9ZttFRI3NpfV
 Wo9U8prl1IkwCMhgKD1fnyzVoz7mQ44fH3FPQIDMBju9PPD8hQqxXF10CdgXTUplnTuVmHjrY+q
 atz9ZEZGQH7iGjT5ODVTmIlUYg76jqc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA5MSBTYWx0ZWRfX9/b53Otx8s9d
 Hjigba51W32BnIfq5THhiJtdV+UABmPuD00wT8gpfMwEz8035nYkIrLSWENkHhH3slUsIqkokvB
 LYUslzxHRX/Wf1i13B6AdMrJFDq0mYzIpU2gtWgSmtgSBgtmoHzXaiBMMUdpZi3KgajSOHOtN/5
 vNZWfg7Xo2JRHEAd7iR/T9FRxF+HLfzUnekVK/pHygZhw/kJO8FpejmXMIrIM9QyOdDjzygh1qj
 B8PtL+ZFiPB7f4KRvs0GEgUpcAGdZhmpH1q1UsgHnMTezwyoB12LQK40lrp4OZuB3EjjDjVsBFG
 nkWLYNsf6z41xqVWI5HptCXkm4ExD2kLI7ukHqmH0pNF1U1K3rbgsec07X3Gc2dRmsMB5Vd9QPI
 4N7mCPIRBSDb44+DnfhCAV/OX1yfFMUzs6k3fY3FXkdn4W6j2xrFTxpZF9gnPYhRxlxR0ICtsZO
 DwDQQ6J2uW3AmXt+iQw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200091

ARMv8 and later processors implement the RAS (Reliability,
Availability and Serviceability) extensions, exposing hardware
error records through a standardised register interface.

Add Device Tree bindings to describe RAS error sources.

Signed-off-by: Umang Chheda <umang.chheda@oss.qualcomm.com>
---
 .../bindings/arm/arm,ras-error-source.yaml    | 330 ++++++++++++++++++
 include/dt-bindings/arm/arm-ras.h             |  11 +
 2 files changed, 341 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/arm,ras-error-source.yaml
 create mode 100644 include/dt-bindings/arm/arm-ras.h

diff --git a/Documentation/devicetree/bindings/arm/arm,ras-error-source.yaml b/Documentation/devicetree/bindings/arm/arm,ras-error-source.yaml
new file mode 100644
index 000000000000..add7063a1a62
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/arm,ras-error-source.yaml
@@ -0,0 +1,330 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/arm,ras-error-source.yaml#
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
+      When present, the first range is the primary error-record window;
+      additional named ranges are identified by reg-names.
+    minItems: 1
+    maxItems: 4
+
+  reg-names:
+    description:
+      Names for the optional additional register windows beyond the primary
+      error-record window.  err-group is the error group status register
+      window (ERRGSR).  fault-inject is the fault injection register window
+      (ERXPFG*).  irq-config is the interrupt routing configuration window.
+    minItems: 1
+    maxItems: 3
+    items:
+      enum:
+        - err-group
+        - fault-inject
+        - irq-config
+
+  interrupts:
+    description:
+      Interrupts signalled by this error source.  The first interrupt is the
+      Fault Handling Interrupt (FHI), fired when a corrected error counter
+      overflows or a deferred error is detected.  The optional second
+      interrupt is the Error Recovery Interrupt (ERI), fired when an
+      uncorrected recoverable error is detected.
+    minItems: 1
+    maxItems: 2
+
+  interrupt-names:
+    description:
+      Names identifying the interrupts.  "fhi" is the Fault Handling
+      Interrupt; "eri" is the optional Error Recovery Interrupt.
+    minItems: 1
+    maxItems: 2
+    items:
+      enum:
+        - fhi
+        - eri
+
+  arm,group-format:
+    description:
+      Page granularity of the memory-mapped error record group register
+      window.  Determines the ioremap size and the number of error group
+      status registers (ERRGSR) available.  Required when reg is present.
+      Use the ARM_RAS_GROUP_* constants from <dt-bindings/arm/arm-ras.h>.
+      0 (ARM_RAS_GROUP_4K) is a 4 KiB window with 1 ERRGSR supporting up
+      to 64 records.  1 (ARM_RAS_GROUP_16K) is 16 KiB with 4 ERRGSRs and
+      up to 256 records.  2 (ARM_RAS_GROUP_64K) is 64 KiB with 14 ERRGSRs
+      and up to 896 records.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2]
+
+  arm,num-records:
+    description:
+      Total number of error records in this error source, including both
+      implemented and unimplemented slots.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 1
+
+  arm,record-impl:
+    description:
+      Bitmap of implemented error records.  Bit N set to 1 means error
+      record N is present and active in this error source.  Bit N set to 0
+      means record N is not implemented and must be skipped.  The array
+      length must equal the number of ERRGSRs implied by arm,group-format
+      (1 element for 4K, 4 for 16K, 14 for 64K).  For system-register
+      nodes (no reg property) a single u64 element is used.
+    $ref: /schemas/types.yaml#/definitions/uint64-array
+    minItems: 1
+    maxItems: 14
+
+  arm,status-reporting:
+    description:
+      Bitmap indicating which implemented error records must be polled
+      directly by the OS.  Bit N set to 1 means record N does not report
+      through the ERRGSR and must be polled by reading its ERX_STATUS
+      register directly in the interrupt handler.  Bit N set to 0 means
+      record N reports its status through the ERRGSR and will be discovered
+      via the ERRGSR scan path.  For system-register nodes (no reg property)
+      there is no ERRGSR, so every implemented record must be polled
+      directly; arm,status-reporting must equal arm,record-impl for all
+      system-register nodes.  Array length as for arm,record-impl.
+    $ref: /schemas/types.yaml#/definitions/uint64-array
+    minItems: 1
+    maxItems: 14
+
+  arm,addressing-mode:
+    description:
+      Bitmap indicating the type of address reported in the error address
+      register (ERX_ADDR) for each error record.  Bit N set to 0 means
+      record N reports a System Physical Address (SPA) that the OS can use
+      directly.  Bit N set to 1 means record N reports a node-specific
+      Logical Address (LA) that requires platform-specific translation to
+      obtain a SPA.  Array length as for arm,record-impl.
+    $ref: /schemas/types.yaml#/definitions/uint64-array
+    minItems: 1
+    maxItems: 14
+
+  # Processor error source properties (arm,ras-processor only)
+
+  cache:
+    description:
+      Phandle to the cache node (L1, L2, or L3) that this processor error
+      source monitors.  The referenced node must have compatible = "cache"
+      and a cache-level property identifying the level in the hierarchy.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  # SMMU error source properties (arm,ras-smmu only)
+
+  iommus:
+    description:
+      Phandle to the SMMU node that this error source monitors.
+    maxItems: 1
+
+  # GIC error source properties (arm,ras-gic only)
+
+  arm,gic-ref:
+    description:
+      Phandle to the GIC node that this error source monitors.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+required:
+  - compatible
+  - arm,num-records
+  - arm,record-impl
+  - arm,status-reporting
+
+allOf:
+  - if:
+      required:
+        - reg
+    then:
+      required:
+        - arm,group-format
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: arm,ras-processor
+    then:
+      required:
+        - cache
+      properties:
+        cache: {}
+    else:
+      properties:
+        cache: false
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: arm,ras-smmu
+    then:
+      required:
+        - iommus
+      properties:
+        iommus: {}
+    else:
+      properties:
+        iommus: false
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: arm,ras-gic
+    then:
+      required:
+        - arm,gic-ref
+      properties:
+        arm,gic-ref: {}
+    else:
+      properties:
+        arm,gic-ref: false
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/arm/arm-ras.h>
+
+    / {
+        compatible = "qcom,sa8775p-ride", "qcom,sa8775p";
+        model = "Qualcomm Technologies, Inc. SA8775P RAS example";
+        #address-cells = <2>;
+        #size-cells = <2>;
+        interrupt-parent = <&intc>;
+
+        intc: interrupt-controller@17100000 {
+            compatible = "arm,gic-v3";
+            reg = <0x0 0x17100000 0x0 0x10000>,
+                  <0x0 0x17180000 0x0 0x100000>;
+            interrupt-controller;
+            #interrupt-cells = <3>;
+            #address-cells = <2>;
+            #size-cells = <2>;
+        };
+
+        cpus {
+            #address-cells = <2>;
+            #size-cells = <0>;
+
+            cpu0: cpu@0 {
+                device_type = "cpu";
+                compatible = "arm,armv8";
+                reg = <0x0 0x0>;
+                next-level-cache = <&l2_0>;
+
+                l2_0: l2-cache {
+                    compatible = "cache";
+                    cache-level = <2>;
+                    cache-unified;
+                    next-level-cache = <&l3_0>;
+
+                    l3_0: l3-cache {
+                        compatible = "cache";
+                        cache-level = <3>;
+                        cache-unified;
+                    };
+                };
+            };
+        };
+
+        /*
+         * Per-PE L1/L2 cache RAS error source.  System-register access,
+         * per-CPU PPI.  Record 0 is implemented (arm,record-impl bit 0
+         * set).  arm,status-reporting equals arm,record-impl because
+         * system-register nodes have no ERRGSR; record 0 must be polled.
+         */
+        ras-l1l2-0 {
+            compatible = "arm,ras-processor";
+            arm,num-records = <1>;
+            arm,record-impl = /bits/ 64 <0x1>;
+            arm,status-reporting = /bits/ 64 <0x1>;
+            cache = <&l2_0>;
+            interrupts = <GIC_PPI 0 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "fhi";
+        };
+
+        ras-l3-cluster0 {
+            compatible = "arm,ras-processor";
+            arm,num-records = <2>;
+            arm,record-impl = /bits/ 64 <0x2>;
+            arm,status-reporting = /bits/ 64 <0x2>;
+            cache = <&l3_0>;
+            interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "fhi";
+        };
+    };
+
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/arm/arm-ras.h>
+
+    / {
+        compatible = "qcom,sa8775p-ride", "qcom,sa8775p";
+        model = "Qualcomm Technologies, Inc. SA8775P RAS example";
+        #address-cells = <2>;
+        #size-cells = <2>;
+        interrupt-parent = <&gic>;
+
+        /*
+         * GICv3 interrupt controller with RAS support.
+         */
+        gic: interrupt-controller@17b00000 {
+            compatible = "arm,gic-v3";
+            reg = <0x0 0x17b00000 0x0 0x10000>,
+                  <0x0 0x17b60000 0x0 0x100000>;
+            interrupt-controller;
+            #interrupt-cells = <3>;
+        };
+
+        ras-gic-dist@17a00000 {
+            compatible = "arm,ras-gic";
+            reg = <0x0 0x17a00000 0x0 0x10000>;
+            reg-names = "err-group";
+            arm,group-format = <ARM_RAS_GROUP_4K>;
+            arm,num-records = <1>;
+            arm,record-impl = /bits/ 64 <0x1>;
+            arm,status-reporting = /bits/ 64 <0x0>;
+            arm,gic-ref = <&gic>;
+            interrupts = <GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "fhi";
+        };
+    };
diff --git a/include/dt-bindings/arm/arm-ras.h b/include/dt-bindings/arm/arm-ras.h
new file mode 100644
index 000000000000..c2f4e1f8243e
--- /dev/null
+++ b/include/dt-bindings/arm/arm-ras.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+
+#ifndef _DT_BINDINGS_ARM_RAS_H
+#define _DT_BINDINGS_ARM_RAS_H
+
+/* arm,group-format - error record group register window page size */
+#define ARM_RAS_GROUP_4K		0	/* 4 KiB,  1 ERRGSR  */
+#define ARM_RAS_GROUP_16K		1	/* 16 KiB, 4 ERRGSRs */
+#define ARM_RAS_GROUP_64K		2	/* 64 KiB, 14 ERRGSRs */
+
+#endif /* _DT_BINDINGS_ARM_RAS_H */
--
2.34.1

