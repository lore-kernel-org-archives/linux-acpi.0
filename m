Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F70B3ACEEA
	for <linux-acpi@vger.kernel.org>; Mon,  8 Jun 2026 09:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780911940; cv=none; b=ET2GgFukHVZTpT48dk94/vMIo4pVnrVl55+lO6A6F25yL4gdDORGVuj2EImmPtAhxdi0ukwcjNv3jbY27KNQGqYa0BpatyNG61HZ65GEkELVWCnKyzSA0omTVpk3+UvRrCbQICy2YhdZxTvyu44pQgW6NoZusTDNev7Q3wW6KSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780911940; c=relaxed/simple;
	bh=9RRZpASQS41qwqOO37RHHFfJF8TpxC/j+aBOgczgifQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lu2X3lUsDT7vMrz7jPpJK3juaAnwaJytf13cvHRqynGPNHPieDySI6IAHGwNsQoQzY7jOFu+GyP/MQQcHacwFims6g7Gy98pXDDd+BtJjFoyr8e6SsORpm6sYViUJXXLLrJC5yZF9nH3Q6h0i7ntw4pIqeuFGepxWlyrrT175+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JKftAluV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AprmnVGK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JKftAluV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AprmnVGK"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6586Oro12274527
	for <linux-acpi@vger.kernel.org>; Mon, 8 Jun 2026 09:45:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wPnIboRKsGmpiz5atmsmV6r9S0cjd+eGf5563PqK//E=; b=JKftAluVGr8ERP6D
	Mm5q9pRK+wS6Gs5IGCvN9sELS8zKr5H79eMz456wQ9gjONeneQR9H7e/Nxdibkp9
	PZRdKAbduWTrgQkkV49c4gaFkJA5sk2IM1182fsyGRlMzwPGxtOjhCyTlJRTYkVt
	FtxKuxtvJDCV7+VH2QIn4Wn/6wB/n6dsdZuyAx4W5DOQsKt1vkaef4lZhFJuTS0Z
	uHGMBedyBtW8Hw0l7weJV+vI5StrhRh16tct1rfwXUGPjPn4WaXWtdY62dsTM2FW
	CpOfPQwcFSHzdQ8s7epGoHDMQ+r+978RNCiLq0XHbu54zWIgYiYYyQAoXVsp9l8o
	3yB7jA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emcqgxvhe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Mon, 08 Jun 2026 09:45:37 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-36d6d07d2edso1105929a91.1
        for <linux-acpi@vger.kernel.org>; Mon, 08 Jun 2026 02:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780911937; x=1781516737; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wPnIboRKsGmpiz5atmsmV6r9S0cjd+eGf5563PqK//E=;
        b=AprmnVGKkRq2UCtWvF8OwCvx76iJbGbBjToLPTyN9pknbgCEuVz1rWqluQM3IT4m9n
         du+o3m72O8lDcwvWQDdkypcRDXyRgcXp/aLixSwAfDwucvV2DSfLo61AMe9lUo/u1OeM
         CRRUPtnLGrD6FHYxin6rkACBxG+RWkAYleCdSHCop19PX8hWqzN/PcGveM+1oepwmymt
         IShvMHYIPtegGxGObNaRYRn7X2SqEQf7hJdH94FpiSAoU8EInunHsA7NxYqUHUI+Pf42
         Wg00xkQwKwLqpZ4o/ccqf3cECcHiF6cexuNpS3vnyYFcF+57FcAwl/dfAN5B2xQM+j7f
         J7PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780911937; x=1781516737;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wPnIboRKsGmpiz5atmsmV6r9S0cjd+eGf5563PqK//E=;
        b=su7HYLJE+mbKtK/UQqZfAk3yENE7QoEmOs/TE5l6TgJ2MrwWei8VvOYsWf+Nr853D6
         4kfRxPRIx+7FPZLbOBglAdGELy2LJh8j0BYh3hhCzAfNWTif3QsEdJRKXu3KEj+xDXBs
         osWj4rxYWVEemjVIBOR8VfW2N+wMQPw33rSOP9nSGdZ6QG8NndnfLycs46nSyt56TqYV
         I+QWAfmxvXwxS2oIpdY91AX7Frw+NOCkqS3tTKM7KjdH2Xcn/JacBRXbOl+gDUchvT5y
         7eAJi6zxN+e0zTFsk/J18lQblOiabTFbt0m6AMfraekKQN5zk14x2k/9ZU3YW3QpPTYi
         vV8g==
X-Forwarded-Encrypted: i=1; AFNElJ9r48d3B4r5UJBCS6UEM6vY1UVErl3v3HFEzKVqIUALiFZ0c34Eq8pQPubr7nCUemGtINmAP9J4f+80@vger.kernel.org
X-Gm-Message-State: AOJu0YwpqCkqdaCGejDdAFQc3rFt8qA8Y1FxyK/7tRD/LIeBG4sFjKR3
	546b0jHYTZ8PyavslZcwA0V24vvWOwca28Y8mMVE4JiqseGTOfNq/9JHRO7valpzZ9nwXDgDOke
	aEPRt2M5I0lB2LbtPFyDq8wTofbIBzTq1dibuHdXFTRuY2WgB7EE1E2Xz8gKojocO
X-Gm-Gg: Acq92OH44ldrXDRaU5Ft0qvqtBtReBGRBQ7/UIGqRcMzgnE8OjcuP9GURELEPyC7cvb
	GZtLhMJLOZE/AhIi5TsVqTAvLpbuFmFLTeFLpzb7M0QDBKnY9QNUQVe6Lg80xFpGwJSKnwmBhhO
	yLp/1K9BlYfS6j2XV6W6+PJtf0gT8YTYz9sPVesUxzua462APAGXBa3H5rx23IVYbsPNeBd0wB3
	LjqI/2rfwgzm9LVXn6BBhiHwdf+dG9gj/dCYyeLR1ZiZH6DvlC1JnYFTGIyg4sM+FDOn9VTrcLb
	o9P+eXOGo2zsi4HDlPlkaDKCPw5jaaxpvd49lMq3p34o5Ati9W6ZxWkhc2JYiJG9O+wWLQBbFm2
	J9w82AYk5BR33ii0HwgLEuu4fUJsgBFk3DnuM3r43mwiNnQwLt/IybFOJj8OB4w==
X-Received: by 2002:a17:90b:538b:b0:36d:f28a:c5e2 with SMTP id 98e67ed59e1d1-370f1eec20amr8065561a91.8.1780911937107;
        Mon, 08 Jun 2026 02:45:37 -0700 (PDT)
X-Received: by 2002:a17:90b:538b:b0:36d:f28a:c5e2 with SMTP id 98e67ed59e1d1-370f1eec20amr8065539a91.8.1780911936605;
        Mon, 08 Jun 2026 02:45:36 -0700 (PDT)
Received: from [10.92.194.172] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282379db0sm16632418b3a.24.2026.06.08.02.45.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 02:45:36 -0700 (PDT)
Message-ID: <d275959d-4a79-4804-a160-94a9aa89eea5@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 15:15:28 +0530
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
        Ruidong Tian <tianruidond@linux.alibaba.com>,
        Tony Luck
 <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
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
 <4eeeef74-8a27-470c-b516-095f029b9e9e@linux.alibaba.com>
Content-Language: en-US
From: Umang Chheda <umang.chheda@oss.qualcomm.com>
In-Reply-To: <4eeeef74-8a27-470c-b516-095f029b9e9e@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=dJGWXuZb c=1 sm=1 tr=0 ts=6a268f41 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=SRrdq9N9AAAA:8
 a=EUspDBNiAAAA:8 a=bAntFOdrss-Er4w7wzgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: 5cXdQRErQfWcbD3GyWLzlGqk5_4CLgV-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA5MCBTYWx0ZWRfX5eL5hXEawyPt
 fAfA6v0gGtDaeUp+62ipU1VrOwdkxqdwQp0wsQbnf+Weohh7vKCFzw0RvRXcCsKmGS8qZPX9nhc
 Q8LUDFK93O9y1rOAb4L6+7mMFAUQTm6o24/PhelrQJ4K62K52NUFR7ceOeSRnDm15mmrYCMznaB
 biz1GMziJGWHWjYFWXcASHEnqjPgjPDh4a5ZTZ2bAfjrXgEJ0ptt14Q4JdLjNygVPm6o0thSXy2
 1V7WVF3vSFQmB2z3eqKGoR7QomcQGl5BDrKW8CZs6S73hYYoE9YpJj8nKhHvE/7c0pCl7N0Oehd
 2HZY4dUeVLeruJn9nob+PXyhdMXndELlwAztPgP6D/Tb5xTxYpmnYqaSqlg0UjdGlF0um2LtFLN
 WRGikMUI1ctX1V9VC69sq8oJbHxrr3G090ThOUkqcG0Ya7ngXj1ScAcoXT41vJ/fJ+dT8UX4iwR
 67dchnil+Tm8ja2TArQ==
X-Proofpoint-ORIG-GUID: 5cXdQRErQfWcbD3GyWLzlGqk5_4CLgV-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080090

Hi Ruidog,

On 6/2/2026 12:59 PM, Ruidong Tian wrote:
> Hi Umang,
> 
> I have sent out v7, and I wanted to highlight a few changes to make it
> easier for you to adapt the devicetree support:
> 
> 1. I stopped passing device information to the driver through the
> acpi_aest_node structure. Instead, I switched to using the device
> property infrastructure and removed the aest_device abstraction layer
> (which was originally introduced to support CMN). This should provide
> good compatibility between ACPI and devicetree and avoid the need to
> write extra adaptation code for devicetree (such as aest_of). In the
> ideal case, adding just one of_match_id should be enough to make it
> work, although this will require you to update the DTB file accordingly.
> 
> 2. I removed the use of genpool. The current AEST driver only needs
> memory in interrupt context, so genpool is not needed.
> 
> 3.The driver has been renamed to arm64_ras.
> 
> I have already applied some of your previous fix patches and added your
> Signed-off-by.
> 
> 
> Best regards,
> Ruidong

Thanks for this summary and for re-factoring the code to make it easy to
adapt for DT as well.


> 
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

