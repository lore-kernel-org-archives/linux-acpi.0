Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFDC368D5C
	for <linux-acpi@vger.kernel.org>; Tue, 12 May 2026 06:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778568381; cv=none; b=lahC1kcFfHB+tilvsrVAX1Lf3DNhZ0dyM2BKmGju1K7ELmGlW0BszsT5/baoTbb01ouwoOiRY5k3IYXPbbc+Gziy2M6LM5yqdy3JJgLn5WNsqwaGjcTCAD5RPS2/s+KUzsmzSyGStIkgY6jrWG/H4UZRMTtxwoCRtJFyzSNKejU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778568381; c=relaxed/simple;
	bh=V/t792VyAJQ43idxgpGa60nXaS0FMldt5X8RwmJQK5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jlWyKBlJJXBMeXdDgiKqyZ3nFuNNG3Dn0hD5qOUmR14jW09ZHSxWVpUP/5VXLwB5qiJSdqN8NM/DSWwMh3EOW44jYyHxgCgJTwERUVtO77/wztek1I6mXitJ66iPYc4tzkbRvukzV/5qrQdryAkabZuQ7HsFjU6O4gybsSIxS4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DIgkPZMQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=d0Dz8fs4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DIgkPZMQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d0Dz8fs4"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64C5Amud2803828
	for <linux-acpi@vger.kernel.org>; Tue, 12 May 2026 06:46:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BinY4gnvTpca70aFjDGmAnSc0bvUH+YSKn9BhicIR3M=; b=DIgkPZMQDp2NGb+3
	E/R68lh9ebJ/T6wgTQNfC443HbNKOPuGstILWpRswN90Fpe7Nf6j+hQq5zMdoa92
	KfJGeXEehAUbViM3Em1QzXEaitc31c7IovJGsOYmKy/fctw3rGDWXFm3GLcx4XKH
	4JZ3nsLecpunENYA1csH2FH2vyDzU7hy7ZITq/DLLqUivb04YtNHHi+Y8ak7uKBw
	71gzY4wxXMBHb43HJ3k3jxh3rA2AccyO9mGR31fl9NAu4yD++bmGCONHH523DAI8
	FAxzXwMpNY6aFSTBm/FUx6QTJ/msYOL75MU8S7JCsp7cFOEP/Jl3O18ylY4o87Z4
	GsWYsw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3nv39x0q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Tue, 12 May 2026 06:46:07 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2bc74d14793so6216055ad.3
        for <linux-acpi@vger.kernel.org>; Mon, 11 May 2026 23:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778568366; x=1779173166; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BinY4gnvTpca70aFjDGmAnSc0bvUH+YSKn9BhicIR3M=;
        b=d0Dz8fs47zZd3M+hV/rrYZn4fPTAZdbCHovxnvQlelQbzA+fH53kzqHXGVQ70cTfFW
         j+A1f8UINtR272oFeH30mKYdMtw3Ypo+8lnE/iTptG2F9g9gs39iVOUwaHa/j99I9UDA
         un1z/jH5U8kGNMmjbjgExkvSbCQFOx4SZMGVVU7QrA/5w7NHlvIfu5VtjcTU0H8Yh+em
         YHOdAEPJDm/ktMzo31tYspcJ/vORWAHTAhCrfduCyv4iFYaagB6Y3QvrF2GA9/E5Bx5n
         z7JKxKuY9MeZCEiqbXJLrBCwxmvGnZcgLxgwMVObegIyindDV86uz6Ziohzu2XAJONqm
         R5Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778568366; x=1779173166;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BinY4gnvTpca70aFjDGmAnSc0bvUH+YSKn9BhicIR3M=;
        b=PJcbrmdPJyRlPHVg+gc6wgOTds/c6eAaaUdgR/IE67XlyHx7UpjCH+lMECnSTzqDAU
         wRsSJmmic84BOpv/C8BWPBP64H5jA9ck0aUPGh17IZ776fTVGcW+Wo30ZlLdweXUAIkG
         T+rmKEzCkTaFtd0uAdQRagGq6zOeRfsWt3cZ01EOKhBNUWBGM7BPTj/Mzu2EhnM7clBU
         ZLcjfIj0LydCg0JofCK2LNJKJ3i62Cr642QspOCD9Ugz6QVX7ORocUKCbnc89uH4xma3
         s87FRcH4SVmhiNhtDFChVL6+NjVfey00gkAvh/C7B/3oBp317+Q8T9RDHuh8glgpJAlf
         1hig==
X-Forwarded-Encrypted: i=1; AFNElJ8mD/uwjYttGn79Tsw0AnZTfkNcfM4ahzbGuqT8CrMOre2NJsFmDrmQz0RasRaKdThYdPdoynpR8Vmt@vger.kernel.org
X-Gm-Message-State: AOJu0YyRE0MxAIDRQT+XVPJe6pyQbcKiTpgW21+Pje4o0X60NizvurXv
	7iwzexp9Jx0yKuQxHwF3zhueXuDW1Sbtvg4JTrG8IIKrIp6QDYK4os6yeZGGrUAexPB5Kcktosf
	gLHiqK5FSL2wkn8Fdu94+VAHVwua5Fd94nQOie4s1pg414DQP9b2ffKfxRLP4OyPr
X-Gm-Gg: Acq92OEp8IuNyq6SSgr8cWy6304gEUEMZWoZRkLXcPRmgnaeO0LGlxaae+pzAkmY4O9
	J3TYRf9XvPavNOqCp2lgVr1Euvg42WMnF4aZQttfqK/rItS1aER33CCYLz+Khxd83HNwIvTjaFn
	DJ8SFEuAJJw1PcG7aYTY8pPoSm3zuddDaNghSCr7Mpcuf/j/ijz9FVrVP7QTvt8i2QjhLrBDv/c
	EaWjFVDtYL2rkG0LJwONXHYJniZqvIJMx/bxmB60SUr1h9Hw0MBgMXst/SbctiRCUC5Er0W2s6i
	5Rsp5fMkDFoq32SEdn316GxJv5No8y8YP7CPoirbMaV4kyFvRS7k7a+7J4bHfq1hoK5IHNCQ+TG
	ZTvHsagZL5JgRse/a7tqFH2ICiMNx2Iv0lEkm6Qv2jTN7oBioErI=
X-Received: by 2002:a17:903:90e:b0:2ae:6220:1539 with SMTP id d9443c01a7336-2ba7b35425dmr139626695ad.6.1778568366120;
        Mon, 11 May 2026 23:46:06 -0700 (PDT)
X-Received: by 2002:a17:903:90e:b0:2ae:6220:1539 with SMTP id d9443c01a7336-2ba7b35425dmr139626405ad.6.1778568365456;
        Mon, 11 May 2026 23:46:05 -0700 (PDT)
Received: from [10.92.198.185] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e847d0sm119936625ad.62.2026.05.11.23.45.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 23:46:04 -0700 (PDT)
Message-ID: <f95584f8-220f-4bd1-a189-dc05ffd2a9bc@oss.qualcomm.com>
Date: Tue, 12 May 2026 12:15:47 +0530
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] ras: aest: extend AEST support to Device Tree
 frontend
To: Ruidong Tian <tianruidong@linux.alibaba.com>,
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
        Faruque Ansari <faruque.ansari@oss.qualcomm.com>
References: <20260505-aest-devicetree-support-v1-0-d5d6ffacf0a5@oss.qualcomm.com>
 <8f1529af-f6fe-44bc-a4b1-c47a19824d1e@linux.alibaba.com>
Content-Language: en-US
From: Umang Chheda <umang.chheda@oss.qualcomm.com>
In-Reply-To: <8f1529af-f6fe-44bc-a4b1-c47a19824d1e@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDA2NCBTYWx0ZWRfXzottWoQ8k/nO
 +jwANUXpxU12r+7mIj/pOfRGGSqKwjho7foBIAaze6VW4fMcjIN6T1fOsvcXJB+HU/b1i/iFWc6
 gWvWcuF1NNSD7Q0HqNFnte+B4IlYSUwZIPiwxHw1jBxabSH1Q6K8kWM/1mjvUZuEl4KhGno+nMm
 LkmmJSNrOTYpsBKE+Lz7u9fPRKSm3XpoIZ5bqjWmegzwaJY1OxNAPkNjPYqBRVP2KLm+gZU8VjG
 4KPTLnySnWwsPPXbahN329Buug8jsCWUwUodO3vVTnQ26uIh2icOaLsFEEeHqubz5KNws3+rHgE
 7SAnC3zWBk5CTF/vJSibAI+bSfZI/iY3LFh2JvqhOkOT4MKn1X2x2rdrAI8itTrsYXn1+S5nogl
 E3FFVW+Qy8d/phRKihTKYNoXcRH43GmfTneR1eAQHyhBCD6FK85wvtPdJ2zDig+HTvGbkpZUXzx
 5T57anHA0LrKDrcGKgQ==
X-Authority-Analysis: v=2.4 cv=Kvp9H2WN c=1 sm=1 tr=0 ts=6a02ccaf cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=SRrdq9N9AAAA:8
 a=EUspDBNiAAAA:8 a=2yO6rERebkD6Ods6SnIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: WX1ioQueXjoFQquj8MobRDN-_aPrY7s5
X-Proofpoint-GUID: WX1ioQueXjoFQquj8MobRDN-_aPrY7s5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120064

Hi Ruidong,


On 5/6/2026 1:40 PM, Ruidong Tian wrote:
> Hi Umang,
> 
> Thanks for your patch.
> 
> Would it be okay if I include this patch in the next version of the AEST
> patch series? I will make sure to add your Signed-off-by line.


Yes, you can include this patch in the next version - we will represent
it and respond to all of the queries received on DT specific patches.

How should I be sharing the patch fixes based on comments received from
maintainers to you ? so that you can include in your patch series ?

Also, when is your plan to post the next version fixing the comments
received ?


Thanks,
Umang


> 
> Best regards,
> Ruidong
> 
> 在 2026/5/5 20:23, Umang Chheda 写道:
>> This series extends Tian Ruidong’s [1] ACPI-based AEST support series
>> to also cover Device Tree based platforms.
>>
>> While the existing AEST driver relies on the AEST ACPI table [3], many
>> embedded Arm platforms use Device Tree exclusively and cannot use the
>> driver today. This series adds a DT frontend that mirrors the ACPI
>> implementation and feeds the same core driver, keeping ACPI and DT
>> paths functionally equivalent.
>>
>> Along the way, several correctness issues were identified in the core
>> driver and are fixed in the first part of this series.
>>
>> The DT frontend is mutually exclusive with ACPI and does not introduce
>> any DT-specific logic into the core.
>>
>> How to test with QEMU
>> --------------------------
>> Tian Ruidong's QEMU fork [2] emulates AEST MMIO error records on the
>> virt machine.  To test the DT frontend:
>>
>> 1. Build QEMU:
>>
>>       git clone https://github.com/winterddd/qemu.git
>>       cd qemu
>>       git checkout c5e2d5dec9fd62ba622314c40bff0fbecb4dfb34
>>       ./configure --target-list=aarch64-softmmu
>>       make -j$(nproc)
>>
>> 2. Build the kernel with:
>>
>>       CONFIG_OF_AEST=y
>>       CONFIG_AEST=y
>>       CONFIG_ARM64_RAS_EXTN=y
>>       CONFIG_RAS=y
>>
>> 3. Add the following DT node to your virt machine DTB.  The QEMU
>>     fork maps DRAM error records at 0x090d0000 (SPI 44) and CMN
>>     vendor records at 0x090e0000 (SPI 45):
>>
>>       aest {
>>           compatible = "arm,aest";
>>           #address-cells = <2>;
>>           #size-cells = <2>;
>>           ranges;
>>           interrupt-parent = <&gic>;
>>
>>           /* DRAM memory node — MMIO at 0x090d0000, SPI 44 */
>>           aest-dram0@90d0000 {
>>               compatible               = "arm,aest-memory";
>>               arm,interface-type       = <1>;
>>               arm,group-format         = <0>;
>>               arm,interface-flags      = <0x22>;
>>               arm,num-records          = <4>;
>>               arm,record-impl          = /bits/ 64 <0x0>;
>>               arm,status-report        = /bits/ 64 <0x0>;
>>               arm,addr-mode            = /bits/ 64 <0x0>;
>>               arm,proximity-domain     = <0>;
>>               reg                      = <0x0 0x090d0000 0x0 0x1000>,
>>                                          <0x0 0x090d0800 0x0 0x200>,
>>                                          <0x0 0x090d0e00 0x0 0x100>;
>>               reg-names                = "errblock", "fault-inject",
>>                                          "err-group";
>>               interrupts               = <GIC_SPI 44
>> IRQ_TYPE_LEVEL_HIGH>;
>>               interrupt-names          = "fhi";
>>           };
>>     };
>>
>> 4. Boot QEMU with acpi=off:
>>
>>       ./qemu-system-aarch64 \
>>         -machine virt,accel=tcg,gic-version=3 \
>>         -cpu cortex-a57 -m 2G -smp 4 \
>>         -kernel Image -dtb virt-aest.dtb \
>>         -append "console=ttyAMA0 acpi=off earlycon" \
>>         -nographic
>>
>> 5. Verify probe:
>>
>>       dmesg | grep "DT AEST"
>>       # Expected: DT AEST: registered 1 AEST error source(s) from DT
>>       ls /sys/kernel/debug/aest/
>>
>> 6. Inject a CE error via the QEMU MMIO fault injection registers.
>>     The QEMU device accepts 64-bit accesses only (use devmem with
>>     the 64-bit width flag):
>>
>>       devmem 0x090d0808 64 0x80000040   # CDOFF | CE inject
>>
>>     This triggers QEMU's error_record_inj_write() which sets
>>     ERR<n>STATUS.V=1 and asserts the IRQ.  The kernel driver's
>>     aest_irq_func() fires, reads the status, and logs:
>>
>>       AEST: {1}[Hardware Error]: Hardware error from AEST memory.90d0000
>>       AEST: {1}[Hardware Error]: Error from memory at SRAT proximity
>> domain 0x0
>>
>> Testing
>> -------
>> - Validated on Qualcomm's lemans-evk and monaco-evk board with DT boot.
>> - Validated CE and UE injection via debugfs soft_inject.
>> - Tested ACPI path is unaffected: ACPI boot continues to use
>>    drivers/acpi/arm64/aest.c unchanged.
>>
>> [1] https://lore.kernel.org/lkml/20260122094656.73399-1-
>> tianruidong@linux.alibaba.com/
>> [2] https://github.com/winterddd/qemu/tree/error_record
>> [3] https://developer.arm.com/documentation/den0085/0200/
>>
>> Signed-off-by: Umang Chheda <umang.chheda@oss.qualcomm.com>
>> ---
>> Umang Chheda (8):
>>        ras: aest: Fix shared processor node handling and error log
>> messages
>>        ras: aest: Fix CE/UE error counts not incrementing in debugfs
>>        ras: aest: Skip unimplemented records in debugfs
>>        ras: aest: Add panic_on_ue module parameter
>>        dt-bindings: arm: ras: Introduce bindings for ARM AEST
>>        ras: aest: Add DT frontend for ARM AEST RAS error sources
>>        arm64: dts: qcom: lemans: add AEST error nodes
>>        arm64: dts: qcom: monaco: add AEST error nodes
>>
>>   .../devicetree/bindings/arm/arm,aest.yaml          | 406 +++++++++++++
>>   arch/arm64/boot/dts/qcom/lemans.dtsi               |  41 ++
>>   arch/arm64/boot/dts/qcom/monaco.dtsi               |  41 ++
>>   drivers/ras/aest/Kconfig                           |  15 +-
>>   drivers/ras/aest/Makefile                          |   2 +
>>   drivers/ras/aest/aest-core.c                       |  63 +-
>>   drivers/ras/aest/aest-of.c                         | 673 +++++++++++
>> ++++++++++
>>   drivers/ras/aest/aest-sysfs.c                      |  27 +-
>>   drivers/ras/aest/aest.h                            |  15 +-
>>   include/dt-bindings/arm/aest.h                     |  43 ++
>>   10 files changed, 1310 insertions(+), 16 deletions(-)
>> ---
>> base-commit: a67b7fd0dd1f6ccf3d128dc2099cdb07af1f6a09
>> change-id: 20260505-aest-devicetree-support-a3722d90e1f5
>> prerequisite-message-id: <20260122094656.73399-1-
>> tianruidong@linux.alibaba.com>
>> prerequisite-patch-id: c5a7c6431c6c1e6351241e694ee053800039d41d
>> prerequisite-patch-id: 1f6e2c20829eee41a210dd8a538f1e8efcc65872
>> prerequisite-patch-id: 5556287e3f46c2ed2c0431c53c7782e87bcbd866
>> prerequisite-patch-id: 2edae0a136d7779b8f686181720e71d044a73311
>> prerequisite-patch-id: b5190b2844dcb01e72f87a59f3a29548795fdb82
>> prerequisite-patch-id: 7ba848583708b2ae776a7ce847bb056e3de7f77b
>> prerequisite-patch-id: 397e5b22802b67942435f4f2968f0b1e210ba0e8
>> prerequisite-patch-id: 2169f4b65537eecbd0ccbd2ad6b28c64ec44655d
>> prerequisite-patch-id: b626f85d98747595b3240bc49e6ad9c9dd5c0fa9
>> prerequisite-patch-id: 1323dfd2eebad2ef6514dbbce58ba08e8859f894
>> prerequisite-patch-id: 95b826e5e329408437a3ef336c4f45d4d74f82bb
>> prerequisite-patch-id: b60ff489a5a33c5d5220fa8144af7b7511769cba
>> prerequisite-patch-id: 43f35a52b8a3d13c938ff08083403c1d3bd0df8b
>> prerequisite-patch-id: c55d4e9117ca36d3c2cba82d550a618cb82bb745
>> prerequisite-patch-id: 3885e10f318ae8101d6909b35d92a976cc359e3c
>> prerequisite-patch-id: 92958cde05577f069c5659018a274bb39cfb6b24
>>
>> Best regards,
>> -- 
>> Umang Chheda <umang.chheda@oss.qualcomm.com>
>>
> 

