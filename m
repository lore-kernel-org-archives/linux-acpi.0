Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CF43BBA0B
	for <linux-acpi@vger.kernel.org>; Thu,  3 Sep 2026 10:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788431032; cv=none; b=MJltEJcUhyGCpWq36SfUrj2rIhzAY3sNtglqaB1udOK7gUSUlq1+d5RGMqcP0elhLPfE3t7/i9H4+j81JBp8I+IhxC+xGLm4mboIrkucTMTk3BC3s/OMJQe3u5a0dW1io6KLxal8F3h2zFdL+adpWe9krzzfjfZJxNcGIjQzTSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788431032; c=relaxed/simple;
	bh=odx09FB8/gdL958vYgn/vOV6oO41vdNuxUITtl31qQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZlpnfEqWAYCy19Aj655+ub+x01V5J6dRgYQRd0JcdtrG6hEstnb+Oy588529b0gykYbaB6oYvnNyZU6qiK9YySIpiHANgArE8/+I9VN6v9EZzExwnVQZztVMXBaQhJg55weQBSczDXqQAmqsVVUq6NYbJ7k3inPToazCAxy4nyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=c3Z8L62K; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eyJG6Gee; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="c3Z8L62K";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eyJG6Gee"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 683AHDD2440309
	for <linux-acpi@vger.kernel.org>; Thu, 3 Sep 2026 10:23:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OTzXRhSzRtnjRJ4J4oJH2ZZtAAGHA+EWF3AV+MLmAcI=; b=c3Z8L62KoHJrgPYP
	zXIrSHaSVau5D+wB2EZIqPDnNsoSj4Q59pm0A0bu3JnogaGg7QgJ39cIW4FI9+p0
	JaiywSkL/KpVde6wwafCkYEePWC2i4zz8Ll6uumPVQXe+am+8x5V2yy65Fgf8xfi
	SZw17v0RNhkWfds/HLLUyrUmXCgaWEGi+ORcjsqE6gh0JutYpFZyLOLNaaRXjNd6
	YP071Duv1AJWsrnMid0sSBdE7ztIK1vwim3yEkcxJBfhBA8Dqy2VrJyTY3N2gIuV
	rj1AmKadvbD4RAM2AK8HXxfQANEBL5kd+zvgLLvjS19BhPDde/BWkW55VCV/coVt
	FuTBFw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf6p703sh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Thu, 03 Sep 2026 10:23:46 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-399271df9d8so483980a91.2
        for <linux-acpi@vger.kernel.org>; Thu, 03 Sep 2026 03:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788431026; x=1789035826; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OTzXRhSzRtnjRJ4J4oJH2ZZtAAGHA+EWF3AV+MLmAcI=;
        b=eyJG6GeelpFWnQRE1MdAFVno7XahD68KPj05wUCmswQs33TZ1C51Ff5odWPKdknDeH
         rdgClsEtIf5nozAvgk7Hy25nHMsqu2lX7mbNDP4UQ3O91Iic/TfPm725FW84FaJMT2RR
         KdSIFuWBuA9Kl/26h28zTPIShM8/QAtnICag8XuUGnd9PwXCU24IDYgrh82dTz+rKZg0
         qZO7u/W5KDZ4EZKKC6yqt2MIknTPUn25fbDO0lUNUlc6rfw1fBLNvMR9lex+XXY0Z9qP
         TY4XNJJQib9jqXMA0LCaUYxQ7pMI443JmxjaZquerzvuDN9bVFJfiGwuKrW0mgisF+ZY
         JEXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788431026; x=1789035826;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OTzXRhSzRtnjRJ4J4oJH2ZZtAAGHA+EWF3AV+MLmAcI=;
        b=GWGZPpFUmR5OoS47WjP4+OkjDDbJM9n3MRe7R81iD/cMtaqHgiOVcuDJrYyKQH7iUO
         dV/tZ3Lz/LRdtG5T8UQojuGEjZqFlYw2oAAU7BQsGulhc5ygscpDO/rkz/tXEU6MtTGm
         ND3SKPixoed0WtFnl3Az9hLdn23uLV31g5xznpbkprau5VzoTSITV69TFIUHMsAOtqdw
         vm9O5vi7rtIdgB8y3WO+wAr58XAabYCfbjoloc0TE0j2Sz0wYteP0RgudlVN8UeTxVvN
         ZGLhI/EPhPiAa6eeY+LqwVMy0r1HwDuMv9A18pXgMYjKHWU421hx7RbgWcL/ZYu9OJF+
         /s1Q==
X-Forwarded-Encrypted: i=1; AKwUvBzEFC3S8gWUDwq4+LztZocIh9h5aW6Vcksxj563yOcMTEZOLmbUW12jpI8BYlyF8bxzfWQoIb/TLJF1@vger.kernel.org
X-Gm-Message-State: AFuF++nW3XSVLJAFjnscFD5Up1PouTlsZIw2lMH6ZUJ0GPOUzEoppKBq
	WEUTSef/KCB0Jy1EAD6eZrBETV4viQc1ofgJfUzH4C/5lpU73xQ8Tlz7dXG4GGph6OWJgfAGEVO
	iChc3wRxqwUlyURfodEys2MXyN/a0fz/Il3xGsu3603MAUVEk9arMn0QPv9iSbb8G
X-Gm-Gg: AYBFou3bVwnIz63q3WNDQqrbyFwdAxPngMPvtMAgYzJzfEBIJGW1hQrOq3vm5eN5SSr
	e4NMbkhitMYfHmvrbtqTAxKkZrQOzmfmX1VSDxwQOoLhk7phBDxO8GvYSWNJjgzArny6XsLnfs6
	02UTGRn6S/ELLjzdEV4amOY6mq6FDp0YmyBGDuT/L+c71i5tGuNB1qk6WCCYyjvWc21dR6uRJuC
	jVG5rxsJOOZj5Dwpl85z5CUfWRLGPOKo3UrNWsp9ZcWs8b1MgZr1dV92Vci9UrvBOoD5T/1XXfL
	49e8/yVQTZkHe/TEcVQCy3brLzptqAqQgMCenmGWpsbAaFG6ZedKFRfyXuegMMEI3hLaxTz6WJl
	svX7Aj74lK7sgEJY8XLr/OCoUIytjPQ==
X-Received: by 2002:a17:90b:4b8b:b0:38e:76f8:fcbb with SMTP id 98e67ed59e1d1-39aee1c6d08mr10332170a91.4.1788431025599;
        Thu, 03 Sep 2026 03:23:45 -0700 (PDT)
X-Received: by 2002:a17:90b:4b8b:b0:38e:76f8:fcbb with SMTP id 98e67ed59e1d1-39aee1c6d08mr10332093a91.4.1788431024756;
        Thu, 03 Sep 2026 03:23:44 -0700 (PDT)
Received: from [10.219.30.245] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3325592ebb3sm5588824eec.14.2026.09.03.03.23.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2026 03:23:44 -0700 (PDT)
Message-ID: <d03f0298-967c-4fe0-86c4-a27641701697@oss.qualcomm.com>
Date: Thu, 3 Sep 2026 15:53:37 +0530
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] dt-bindings: arm: ras: Introduce bindings for ARM
 RAS error sources
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Ruidong Tian <tianruidong@linux.alibaba.com>,
        Tony Luck
 <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org,
        faruque.ansari@oss.qualcomm.com, avaneesh.dwivedi@oss.qualcomm.com
References: <20260720081954.1858180-1-umang.chheda@oss.qualcomm.com>
 <20260720081954.1858180-2-umang.chheda@oss.qualcomm.com>
 <20260728-fervent-optimal-auk-7850ae@quoll>
Content-Language: en-US
From: Umang Chheda <umang.chheda@oss.qualcomm.com>
In-Reply-To: <20260728-fervent-optimal-auk-7850ae@quoll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: PWpMvZ7HLElWBE-Tv81NIArU4Q-vZjQ0
X-Proofpoint-ORIG-GUID: PWpMvZ7HLElWBE-Tv81NIArU4Q-vZjQ0
X-Authority-Analysis: v=2.4 cv=OZyoyBTY c=1 sm=1 tr=0 ts=6a994ab2 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=P-IC7800AAAA:8 a=gEfo2CItAAAA:8 a=UXIAUNObAAAA:8 a=EUspDBNiAAAA:8
 a=8vMulZHAkAiH2yylmEoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=d3PnA9EDa4IxuAV0gXij:22 a=sptkURWiP4Gy88Gu7hUp:22
 a=a1s67YnXd6TbAZZNj1wK:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA4OSBTYWx0ZWRfX+gI2Y+2j4ivj
 x9WXi/e7CIpwiGf7wDxhBMp9AmjuIPSkUp5+g0YR7cNLcclielwL7rBJwFTikOsYXp2nxhsycKg
 Z7stxft7nM6okbebG+dY/9zrreClKjk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA4OSBTYWx0ZWRfX7tcEXp4fJ3vB
 5oYJQ2lo/TvZfmrfHV/Gj3O380VRANEVyArkQQaFtoENfQ35cgc9zw6TUOvz79bj6Go9ZwEP8nR
 4DYLf4+yQlV51mdSK4QbUtNrEmU/t2DuBXFZU59UuOQ06rZG3+sc/pluiUta9nCeYgOrB4oyJJZ
 H0YjfkfQt9XHazFsILf/ZvUMWm5j2JfLSz/dOnmr4cvK7jeHWTZt7aP7zG82HE/2FfcckcZAtAm
 W4IhppO+TEVI8mrZQ415Joeir+6TCp3vv1i6MmSaXagwzQ/npm6wWwuCB/Pddwe6qn0hEUxtAzQ
 OcHFsSS3i00FTK27hl3453S8wwOujj/HMELlwxoggfs/8DlUAdubfyGZPErl1MB2F8xK7vQNUT4
 rdN+HbTbWNk3W5BsQ58MDMvGxWHiSJKAl9okzss+UqOxuUudvPCX93c7hm+O9UBudeL5utV8naM
 eH3qwHcMHbRxwP9n0ag==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030089

Hi Krzysztof,


On 7/28/2026 2:23 PM, Krzysztof Kozlowski wrote:
> On Mon, Jul 20, 2026 at 01:49:51PM +0530, Umang Chheda wrote:
>> ARMv8 and later processors implement the RAS (Reliability,
>> Availability and Serviceability) extensions, exposing hardware
>> error records through a standardised register interface.
>>
>> Add Device Tree bindings to describe RAS error sources.
>>
>> Signed-off-by: Umang Chheda <umang.chheda@oss.qualcomm.com>
> 
> A nit, subject: drop second/last, redundant "bindings for". The
> "dt-bindings" prefix is already stating that these are bindings.
> See also:
> https://elixir.bootlin.com/linux/v7.1-rc7/source/Documentation/devicetree/bindings/submitting-patches.rst#L23

Ack, will fix the subject text in v3.

> 
>> ---
>>  .../bindings/arm/arm,ras-error-source.yaml    | 330 ++++++++++++++++++
>>  include/dt-bindings/arm/arm-ras.h             |  11 +
>>  2 files changed, 341 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/arm/arm,ras-error-source.yaml
>>  create mode 100644 include/dt-bindings/arm/arm-ras.h
>>
>> diff --git a/Documentation/devicetree/bindings/arm/arm,ras-error-source.yaml b/Documentation/devicetree/bindings/arm/arm,ras-error-source.yaml
>> new file mode 100644
>> index 000000000000..add7063a1a62
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/arm,ras-error-source.yaml
> 
> Filename should resemble compatible, so "arm,ras.yaml"

Ack, will change the filename as suggested in v3.

> 
>> @@ -0,0 +1,330 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/arm/arm,ras-error-source.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: ARM RAS error source
>> +
>> +maintainers:
>> +  - Umang Chheda <umang.chheda@oss.qualcomm.com>
>> +
>> +description: |
>> +  ARMv8 and later processors implement the Reliability, Availability and
>> +  Serviceability (RAS) extensions.  Hardware blocks that support RAS expose
>> +  one or more error records through a standardised register interface.  Each
>> +  error record captures information about a detected hardware error (cache
>> +  ECC fault, TLB parity error, interconnect error, etc.) and can optionally
>> +  signal the OS via an interrupt.
>> +
>> +  Each DT node described by this binding represents one RAS error source —
>> +  a hardware block that exposes a set of error records.  Error records are
>> +  accessed either through system registers (for processor-local resources
>> +  such as L1/L2 caches and TLBs) or through a memory-mapped register window
>> +  (for shared or off-core resources such as L3 caches, SMMUs and GICs).
>> +
>> +properties:
>> +  compatible:
>> +    description:
>> +      Identifies the class of hardware block this error source belongs to.
>> +      arm,ras-processor covers processor error sources (cache, TLB, etc.).
>> +      arm,ras-smmu covers SMMU error sources.
>> +      arm,ras-gic covers GIC error sources.
>> +    enum:
>> +      - arm,ras-processor
>> +      - arm,ras-smmu
>> +      - arm,ras-gic
>> +
>> +  reg:
>> +    description:
>> +      Register windows for this error source.  When absent the error records
>> +      are accessed through system registers (ERRSELR_EL1 + ERX*_EL1).
>> +      When present, the first range is the primary error-record window;
>> +      additional named ranges are identified by reg-names.
>> +    minItems: 1
>> +    maxItems: 4
>> +
>> +  reg-names:
>> +    description:
>> +      Names for the optional additional register windows beyond the primary
>> +      error-record window.  err-group is the error group status register
>> +      window (ERRGSR).  fault-inject is the fault injection register window
>> +      (ERXPFG*).  irq-config is the interrupt routing configuration window.
>> +    minItems: 1
>> +    maxItems: 3
>> +    items:
>> +      enum:
>> +        - err-group
>> +        - fault-inject
>> +        - irq-config
>> +
>> +  interrupts:
>> +    description:
>> +      Interrupts signalled by this error source.  The first interrupt is the
>> +      Fault Handling Interrupt (FHI), fired when a corrected error counter
>> +      overflows or a deferred error is detected.  The optional second
>> +      interrupt is the Error Recovery Interrupt (ERI), fired when an
>> +      uncorrected recoverable error is detected.
>> +    minItems: 1
>> +    maxItems: 2
>> +
>> +  interrupt-names:
>> +    description:
>> +      Names identifying the interrupts.  "fhi" is the Fault Handling
>> +      Interrupt; "eri" is the optional Error Recovery Interrupt.
>> +    minItems: 1
>> +    maxItems: 2
>> +    items:
>> +      enum:
>> +        - fhi
>> +        - eri
>> +
>> +  arm,group-format:
>> +    description:
>> +      Page granularity of the memory-mapped error record group register
>> +      window.  Determines the ioremap size and the number of error group
>> +      status registers (ERRGSR) available.  Required when reg is present.
>> +      Use the ARM_RAS_GROUP_* constants from <dt-bindings/arm/arm-ras.h>.
>> +      0 (ARM_RAS_GROUP_4K) is a 4 KiB window with 1 ERRGSR supporting up
>> +      to 64 records.  1 (ARM_RAS_GROUP_16K) is 16 KiB with 4 ERRGSRs and
>> +      up to 256 records.  2 (ARM_RAS_GROUP_64K) is 64 KiB with 14 ERRGSRs
>> +      and up to 896 records.
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    enum: [0, 1, 2]
>> +
>> +  arm,num-records:
>> +    description:
>> +      Total number of error records in this error source, including both
>> +      implemented and unimplemented slots.
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    minimum: 1
>> +
>> +  arm,record-impl:
>> +    description:
>> +      Bitmap of implemented error records.  Bit N set to 1 means error
>> +      record N is present and active in this error source.  Bit N set to 0
>> +      means record N is not implemented and must be skipped.  The array
>> +      length must equal the number of ERRGSRs implied by arm,group-format
>> +      (1 element for 4K, 4 for 16K, 14 for 64K).  For system-register
>> +      nodes (no reg property) a single u64 element is used.
>> +    $ref: /schemas/types.yaml#/definitions/uint64-array
>> +    minItems: 1
>> +    maxItems: 14
>> +
>> +  arm,status-reporting:
>> +    description:
>> +      Bitmap indicating which implemented error records must be polled
>> +      directly by the OS.  Bit N set to 1 means record N does not report
>> +      through the ERRGSR and must be polled by reading its ERX_STATUS
>> +      register directly in the interrupt handler.  Bit N set to 0 means
>> +      record N reports its status through the ERRGSR and will be discovered
>> +      via the ERRGSR scan path.  For system-register nodes (no reg property)
>> +      there is no ERRGSR, so every implemented record must be polled
>> +      directly; arm,status-reporting must equal arm,record-impl for all
>> +      system-register nodes.  Array length as for arm,record-impl.
>> +    $ref: /schemas/types.yaml#/definitions/uint64-array
>> +    minItems: 1
>> +    maxItems: 14
>> +
>> +  arm,addressing-mode:
>> +    description:
>> +      Bitmap indicating the type of address reported in the error address
>> +      register (ERX_ADDR) for each error record.  Bit N set to 0 means
>> +      record N reports a System Physical Address (SPA) that the OS can use
>> +      directly.  Bit N set to 1 means record N reports a node-specific
>> +      Logical Address (LA) that requires platform-specific translation to
>> +      obtain a SPA.  Array length as for arm,record-impl.
>> +    $ref: /schemas/types.yaml#/definitions/uint64-array
>> +    minItems: 1
>> +    maxItems: 14
>> +
>> +  # Processor error source properties (arm,ras-processor only)
>> +
>> +  cache:
>> +    description:
>> +      Phandle to the cache node (L1, L2, or L3) that this processor error
>> +      source monitors.  The referenced node must have compatible = "cache"
>> +      and a cache-level property identifying the level in the hierarchy.
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +
>> +  # SMMU error source properties (arm,ras-smmu only)
>> +
>> +  iommus:
>> +    description:
>> +      Phandle to the SMMU node that this error source monitors.
>> +    maxItems: 1
>> +
>> +  # GIC error source properties (arm,ras-gic only)
>> +
>> +  arm,gic-ref:
>> +    description:
>> +      Phandle to the GIC node that this error source monitors.
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +
>> +required:
>> +  - compatible
>> +  - arm,num-records
>> +  - arm,record-impl
>> +  - arm,status-reporting
>> +
>> +allOf:
>> +  - if:
>> +      required:
>> +        - reg
>> +    then:
>> +      required:
>> +        - arm,group-format
>> +
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: arm,ras-processor
>> +    then:
>> +      required:
>> +        - cache
>> +      properties:
>> +        cache: {}
>> +    else:
>> +      properties:
>> +        cache: false
>> +
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: arm,ras-smmu
>> +    then:
>> +      required:
>> +        - iommus
>> +      properties:
>> +        iommus: {}
> 
> 
> What is with this syntax. There is no such style, drop.

Ack

> 
> 
>> +    else:
>> +      properties:
>> +        iommus: false
>> +
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: arm,ras-gic
>> +    then:
>> +      required:
>> +        - arm,gic-ref
>> +      properties:
>> +        arm,gic-ref: {}
> 
> Drop. This is not an object, but phandle.

Ack

> 
>> +    else:
>> +      properties:
>> +        arm,gic-ref: false
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    #include <dt-bindings/arm/arm-ras.h>
>> +
>> +    / {
>> +        compatible = "qcom,sa8775p-ride", "qcom,sa8775p";
>> +        model = "Qualcomm Technologies, Inc. SA8775P RAS example";
>> +        #address-cells = <2>;
>> +        #size-cells = <2>;
>> +        interrupt-parent = <&intc>;
> 
> Drop, irrelevant.

Ack

> 
>> +
>> +        intc: interrupt-controller@17100000 {
>> +            compatible = "arm,gic-v3";
>> +            reg = <0x0 0x17100000 0x0 0x10000>,
>> +                  <0x0 0x17180000 0x0 0x100000>;
>> +            interrupt-controller;
>> +            #interrupt-cells = <3>;
>> +            #address-cells = <2>;
>> +            #size-cells = <2>;
>> +        };
>> +
>> +        cpus {
>> +            #address-cells = <2>;
>> +            #size-cells = <0>;
>> +
>> +            cpu0: cpu@0 {
>> +                device_type = "cpu";
>> +                compatible = "arm,armv8";
>> +                reg = <0x0 0x0>;
>> +                next-level-cache = <&l2_0>;
>> +
>> +                l2_0: l2-cache {
>> +                    compatible = "cache";
>> +                    cache-level = <2>;
>> +                    cache-unified;
>> +                    next-level-cache = <&l3_0>;
>> +
>> +                    l3_0: l3-cache {
>> +                        compatible = "cache";
>> +                        cache-level = <3>;
>> +                        cache-unified;
>> +                    };
>> +                };
>> +            };
>> +        };
> 
> Drop all the nodes above, irrelevant.

Ack

> 
>> +
>> +        /*
>> +         * Per-PE L1/L2 cache RAS error source.  System-register access,
>> +         * per-CPU PPI.  Record 0 is implemented (arm,record-impl bit 0
>> +         * set).  arm,status-reporting equals arm,record-impl because
>> +         * system-register nodes have no ERRGSR; record 0 must be polled.
>> +         */
>> +        ras-l1l2-0 {
> 
> Node names should be generic. See also an explanation and list of
> examples (not exhaustive) in DT specification:
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
> If you cannot find a name matching your device, please check in kernel
> sources for similar cases or you can grow the spec (via pull request to
> DT spec repo).
> 
> Choose some generic name, but l1l2 does not sound like one.

Ack, will add some generic node name as suggested.


> 
>> +            compatible = "arm,ras-processor";
>> +            arm,num-records = <1>;
>> +            arm,record-impl = /bits/ 64 <0x1>;
>> +            arm,status-reporting = /bits/ 64 <0x1>;
>> +            cache = <&l2_0>;
>> +            interrupts = <GIC_PPI 0 IRQ_TYPE_LEVEL_HIGH>;
>> +            interrupt-names = "fhi";
> 
> I had impression we agreed all this is part of actual CPU/GIC/cache node
> or its subnode.
> 
> Keeping it separate does not feel right, if cache is the source of error reporting.

Thanks for the discussion Krzysztof !

As discussed, I'll retain the same node representation in v3. The
rationale is that the interrupt lines and address space associated with
the error nodes are independent of the parent monitored IP.
Additionally, the ARM PMU provides a similar precedent: like RAS, it is
represented as a separate entity in the Device Tree despite being
associated with a monitored component.

> 
>> +        };
>> +
>> +        ras-l3-cluster0 {
>> +            compatible = "arm,ras-processor";
>> +            arm,num-records = <2>;
>> +            arm,record-impl = /bits/ 64 <0x2>;
>> +            arm,status-reporting = /bits/ 64 <0x2>;
>> +            cache = <&l3_0>;
>> +            interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
>> +            interrupt-names = "fhi";
>> +        };
>> +    };
>> +
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    #include <dt-bindings/arm/arm-ras.h>
>> +
>> +    / {
>> +        compatible = "qcom,sa8775p-ride", "qcom,sa8775p";
>> +        model = "Qualcomm Technologies, Inc. SA8775P RAS example";
>> +        #address-cells = <2>;
>> +        #size-cells = <2>;
>> +        interrupt-parent = <&gic>;
>> +
>> +        /*
>> +         * GICv3 interrupt controller with RAS support.
>> +         */
>> +        gic: interrupt-controller@17b00000 {
>> +            compatible = "arm,gic-v3";
>> +            reg = <0x0 0x17b00000 0x0 0x10000>,
>> +                  <0x0 0x17b60000 0x0 0x100000>;
>> +            interrupt-controller;
>> +            #interrupt-cells = <3>;
>> +        };
>> +
>> +        ras-gic-dist@17a00000 {
>> +            compatible = "arm,ras-gic";
>> +            reg = <0x0 0x17a00000 0x0 0x10000>;
>> +            reg-names = "err-group";
>> +            arm,group-format = <ARM_RAS_GROUP_4K>;
>> +            arm,num-records = <1>;
>> +            arm,record-impl = /bits/ 64 <0x1>;
>> +            arm,status-reporting = /bits/ 64 <0x0>;
>> +            arm,gic-ref = <&gic>;
>> +            interrupts = <GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH>;
>> +            interrupt-names = "fhi";
>> +        };
>> +    };
>> diff --git a/include/dt-bindings/arm/arm-ras.h b/include/dt-bindings/arm/arm-ras.h
>> new file mode 100644
>> index 000000000000..c2f4e1f8243e
>> --- /dev/null
>> +++ b/include/dt-bindings/arm/arm-ras.h
> 
> Filename must match binding or compatible.
> 
>> @@ -0,0 +1,11 @@
>> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
>> +
>> +#ifndef _DT_BINDINGS_ARM_RAS_H
>> +#define _DT_BINDINGS_ARM_RAS_H
> 
> Best regards,
> Krzysztof
> 

Thanks,
Umang


