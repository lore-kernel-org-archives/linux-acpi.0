Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E333CC330
	for <linux-acpi@vger.kernel.org>; Mon, 20 Jul 2026 08:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784535606; cv=none; b=fNu7DHy24a5dWZMUNn7yxWW/CoH7IOkuJCkNFH4l6HDqsQfv1v3XSBf9uqHd5jYPKds595EIYMYxmm1JQ0HZlZmOH2NsxgDt8O/Wt2M3nkxGQ7nu2EPJtYVmOeOJPb7Y/BkAnKLzTOvYkaVoyMhmUVqYF4DClpHYDmkf5xEAf5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784535606; c=relaxed/simple;
	bh=XeAEXlpZvz1Kk9U20DPBoUr+0RBrXFDXeooUbCrFtfk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NsKwI/TA8UefrJBxRGMC+NOscvHqKFqnKd+o6aUv9SxSRnIYf3x1eHqKFDtO/bDFf4csxzhQLHz6XkrNLyzRjrFaYkTCUgX/NhSErACM/EjMDm3rIkvU0TeWyCDmsxwefux22T6jbUUZtl0WKXGQxwNZqNUbRDmJYQnZ4oBgJw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N9SMOOoj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JCLRmRkn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N9SMOOoj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JCLRmRkn"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66K774iC1896276
	for <linux-acpi@vger.kernel.org>; Mon, 20 Jul 2026 08:20:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=oywFt15nTUechSp1jVDxMiDTZuPB3zyGHsn
	nJBE7dAk=; b=N9SMOOoj2Mm0hUmIxeJ329kLUXKUlRm6qCARhXiWTSWz8BCGbRH
	5VlukN1qdTpTyTaUs1NreDG9b9YtAxC+6iis7af4bWIocsS2voFCHYCGvziyhp2A
	yxac23Siy/KAYuKnsbX14PwJ8vw6JWcNVihwll3VNdZHoVs2kP7Kiqn19vfFEL/+
	iSiNv6Tf+idp73fZxyUEqukK0QoOtWGFiVKATveIC46FQ31LYVUAqIrM4uBEViNy
	qMJNDA0K3lZ4D8FuIFzi9gwfkmkoyMzgIXYcJwHaBvBsiMVE23YMM/49QmWkCXdO
	3NGNyQbreWAUGdAjzse9v0m7JdAbXslMToQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhf0kr98d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Mon, 20 Jul 2026 08:20:03 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38459087607so2925923a91.2
        for <linux-acpi@vger.kernel.org>; Mon, 20 Jul 2026 01:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784535602; x=1785140402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oywFt15nTUechSp1jVDxMiDTZuPB3zyGHsnnJBE7dAk=;
        b=JCLRmRknsQLnSWHOGs+DgsHKMtM6sU+dor4/nVsnXAlsb+12899KzdqnmzXuFixE04
         v4gRXIflPz3ZqFpPzQ03Asicyc/+5CW34sK0ys4uDpYZRzjF1lWvfDbbSUTVvjRUVQQz
         igYhohukOswW6rAxsgWfFv9x/fBS9uXsOkCbVqVhNhdLp3wlYAdbj+wMC8lLbKouA0bU
         wMHv+eUKXJufH41733pSL10VKmgLzg9OcG1PipYdbFddh68Zz9qd8Fro8o/q6+dxI0Jx
         qqXHwliqL/u13d2T4/GiP1nHyTylTRv53HyLghDza1idaqkdwKYovPKHLgg34ImbJ9zW
         GwqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784535602; x=1785140402;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oywFt15nTUechSp1jVDxMiDTZuPB3zyGHsnnJBE7dAk=;
        b=PxZKaPlBSvxVL3I9/TjN65lynW7DaGBeg789hTBgQIF56y6K0TJRhpLiJ5sG85mXeR
         yuj8088iPSSK0myhaMrx6/FHcL/DVRRdnN5gvxKDRIMS9da2idZtpFgge0PJJjcOlYer
         PqzVDCFSRqHfBE8QYIHtlRuyIjm/StAawSvfn8TiZT5zvZO2IM21qf9vSZAJBvGuAoEu
         V0QdzSo0OxiIGTJ8kZPLePHL8Dwwen57cohLzyP2e0SBHMVew6Dj04OyusP929Qs57y7
         XsNxrhGAQv67srd0TPHB9BUHOuzuCb7FjP0ypZW0VDjnFPTaY7eai8sPM2Jp1UKQMwla
         ennA==
X-Forwarded-Encrypted: i=1; AHgh+Rre3Ii7ecVnXN2UIdtguD30wOZHQfxmb6kxY/DHcSqN7Q9efjBYXT5YSeUZ6WcX2xPzZ8fXM5Y9i6Ja@vger.kernel.org
X-Gm-Message-State: AOJu0YzugcuOibTZHzA35AapmFcQAdkV41XC024rck/rx2W1gabCzwmK
	JJaRk3yyBSdIxhh+omhhDZ++p9SIP0Q5myJxGCss0QFmurAupxsCc+bY7eOqAb+A36vJbBoWvCo
	2SUGPdlr5we8YoMIF8F1W4chwVN/IKDPReUih3LKCbPNKH8z32Y7/Uk1oPp+pcOhN
X-Gm-Gg: AfdE7cnfl9vvJi4fgIRVSdJ/prp7mQcHw9i2Ru5hZlSxUHiIRdxnODhXUMlbgrqZ7sz
	57AaSTZS1FvU5jWhIAst5WAAZjfn67Kx+My8LYakocgpAmXq/1sxAxvCRSZELeo2Mqj2UYcOSXF
	dPHmLh9LriXqSvjXaQ6GBqzigMK0lTIonlrYIe4YV8f4ui3ptupdqqkLZFvgl9pGhf/WnqJWCUg
	TbVh9Y+mjmoBBNpBqggonK0Z4hj0yMtS9yn5XjEnDMUFdNh2uRAPuoM3NZdNAe1SlI1XIYMk5Eo
	uR7vsCZxI2z5b1hu1xoGi/tGlAO1wZ8iPuBcG2FTTAtcRQMaQ/lza6AsJljreFjzfyHklIJ+22E
	Q0aSANFGIeTgdc6rthpSvhbKxtjM3jHg=
X-Received: by 2002:a17:90b:4c0f:b0:38e:89ec:5254 with SMTP id 98e67ed59e1d1-38e89ec53c6mr600800a91.7.1784535602422;
        Mon, 20 Jul 2026 01:20:02 -0700 (PDT)
X-Received: by 2002:a17:90b:4c0f:b0:38e:89ec:5254 with SMTP id 98e67ed59e1d1-38e89ec53c6mr600761a91.7.1784535601850;
        Mon, 20 Jul 2026 01:20:01 -0700 (PDT)
Received: from hu-uchheda-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e39e0531asm7233688a91.5.2026.07.20.01.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 01:20:01 -0700 (PDT)
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
Subject: [PATCH v2 0/4] arm: ras: Add DT frontend support for ARM RAS
Date: Mon, 20 Jul 2026 13:49:50 +0530
Message-Id: <20260720081954.1858180-1-umang.chheda@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: lbCj3fdNWgVSSNvqY73sTq5Or-4wekqD
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA5MSBTYWx0ZWRfX7Hx3PUHRjBTm
 81PJwNUeAsHeLGUTL29a2ajyWFq3lbtZTzhhDw70z4cwRt7sM6qOVvmp2zTW8xXLAAo5ruo9h2s
 YkibNQaSktBfnZxgW0CQLFgb8hEvClo=
X-Authority-Analysis: v=2.4 cv=G58s1dk5 c=1 sm=1 tr=0 ts=6a5dda33 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=SRrdq9N9AAAA:8 a=tHe252CdNFHeNeq8tAEA:9
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA5MSBTYWx0ZWRfX9zF+PF4WYpYc
 cGFIOh5+9Bm0Yk5TtA9RNEu1No7iqjfl3qph+hrZ8afSv5ulqH4eCiUhnajP54epuSyuFRA84io
 UChITXFSPZEHPt0apXUyIzWSV1QM9fh9WK4PA2LaUvuB7K+aSqfnpV+G5Rod5T4UH+/DHiaXg9v
 3agAAfxwx3cTuhSQmVbXFqWLvJe4HmyM/GSC3iR8oQkZ2LBpm+HSqiNHpxpCdC6Im49TAITNsQK
 d6uYbCLuXQ8CPwtMW2TbTgi+rYd6zaBlpnr4vjUm3K5Mnh5Mk/DqY7zf1qPlpd4241tCQuaBDbH
 HvKL2KAmtYo3fpZsqJ/PAszhSV+xp/U8uOpFIocYuz2nKvsiZJpHt62rS8oAtBMRS8PxEAIzLld
 K2YBymFAVCcPyCcqliZAJHtgMhSzvNJbU+XlH1caPbeRsFnzA9Mj+NPLaWYGln2XP7vWQg5wwyq
 iYMF6S7prQRCLE9IeNg==
X-Proofpoint-GUID: lbCj3fdNWgVSSNvqY73sTq5Or-4wekqD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1011 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200091

This series adds Device Tree support for the ARM64 RAS driver
introduced by Ruidong Tian [1]. The existing driver supports ACPI-based
platforms via the AEST table, this series extends it to DT-based
platforms without any changes to the core driver.

How to test with QEMU
--------------------------
Tian Ruidong's QEMU fork [2] emulates AEST MMIO error records on the
virt machine.  To test the DT frontend:

1. Build QEMU:

     git clone https://github.com/winterddd/qemu.git
     cd qemu
     git checkout c5e2d5dec9fd62ba622314c40bff0fbecb4dfb34
     ./configure --target-list=aarch64-softmmu
     make -j$(nproc)

2. Build the kernel with:

     CONFIG_ARM64_RAS_EXTN=y
     CONFIG_RAS=y
     CONFIG_ACPI_AEST=y
     CONFIG_ARM64_RAS_DRIVER=y
     CONFIG_ARM64_RAS_DT=y

3. Add the following DT node to your virt machine DTB.  The QEMU
   fork maps GIC error source at 0x017a00000 (SPI 0x0d).

   ras-gic-dist@17a00000 {
       compatible = "arm,ras-gic";
       reg = <0x0 0x17a00000 0x0 0x10000>;
       reg-names = "err-group";
       arm,group-format = <ARM_RAS_GROUP_4K>;
       arm,num-records = <1>;
       arm,record-impl = /bits/ 64 <0x1>;
       arm,status-reporting = /bits/ 64 <0x0>;
       arm,gic-ref = <&gic>;
       interrupts = <GIC_SPI 0x0d 0x04>;
       interrupt-names = "fhi";
   };

4. Boot QEMU with acpi=off:

     ./qemu-system-aarch64 \
       -machine virt,accel=tcg,gic-version=3 \
       -cpu cortex-a57 -m 2G -smp 4 \
       -kernel Image -dtb virt-aest.dtb \
       -append "console=ttyAMA0 acpi=off earlycon" \
       -nographic

5. Verify probe:

     dmesg | grep "DT RAS"
     # Expected: DT RAS: registered 1 RAS error source(s) from DT
     ls /sys/kernel/debug/aest/


6. Inject a CE error via the QEMU MMIO fault injection registers.
   The QEMU device accepts 64-bit accesses only (use devmem with
   the 64-bit width flag):

   devmem 0x090e0808 64 0x40000001

   This triggers QEMU's error_record_inj_write() which sets
   ERR<n>STATUS.V=1 and asserts the IRQ.  The kernel driver's
   aest_irq_func() fires, reads the status, and logs:

   arm64_ras: {2}[Hardware Error]: Hardware error from AEST gic.90e0000
   arm64_ras: {2}[Hardware Error]: Error from GIC type 0x0 instance 0x8005
   arm64_ras: {2}[Hardware Error]: ERR0FR: 0x48a5
   arm64_ras: {2}[Hardware Error]: ERR0CTRL: 0x108
   arm64_ras: {2}[Hardware Error]: ERR0STATUS: 0x40000001

Testing
-------
- Validated Processor error nodes/sources for L1-L2 and L3 caches error
  on Qualcomm's lemans-evk and monaco-evk boards with DT boot.
- Validated CE and UE injection via debugfs soft_inject.
- Validated GIC and SMMU error sources on QEMU.

[1] https://lore.kernel.org/lkml/20260122094656.73399-1-tianruidong@linux.alibaba.com/
[2] https://github.com/winterddd/qemu/tree/error_record

---
Changes in v2:
  - Rebased on top of Ruidong Tian's v7 RAS driver series and reworked
    the DT frontend to match the new driver architecture.
  - Moved RAS error source nodes to the DT root, removed the arm,aest
    container node as suggested by Rob Herring.
  - Dropped arm,processor-flags and arm,resource-type properties, these
    are now inferred from the interrupt type and cache phandle
    respectively.
  - Renamed compatible strings from arm,aest-* to arm,ras-* and the
    dt-bindings header from aest.h to arm-ras.h to avoid ACPI terminology
    in DT bindings.
---
Umang Chheda (4):
  dt-bindings: arm: ras: Introduce bindings for ARM RAS error sources
  arm64: ras: Add Device Tree frontend
  arm64: dts: qcom: monaco: add RAS error source nodes
  arm64: dts: qcom: lemans: add RAS error source nodes

 .../bindings/arm/arm,ras-error-source.yaml    | 330 +++++++++++++++
 arch/arm64/boot/dts/qcom/lemans.dtsi          |  30 ++
 arch/arm64/boot/dts/qcom/monaco.dtsi          |  30 ++
 drivers/ras/arm64/Kconfig                     |  25 +-
 drivers/ras/arm64/Makefile                    |   2 +
 drivers/ras/arm64/ras-of.c                    | 383 ++++++++++++++++++
 include/dt-bindings/arm/arm-ras.h             |  11 +
 7 files changed, 806 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/arm,ras-error-source.yaml
 create mode 100644 drivers/ras/arm64/ras-of.c
 create mode 100644 include/dt-bindings/arm/arm-ras.h

--
2.34.1

