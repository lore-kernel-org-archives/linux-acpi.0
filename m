Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA323D5658
	for <linux-acpi@vger.kernel.org>; Wed, 13 May 2026 08:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778661826; cv=none; b=rRov97iDj1xf30qBiQclkYxatBi4LiUoh/vAup0vd62foifw7RDiA4ORPHN0V5FCmNwbbQT+OUuf6LHzELU0Za/E5C8BNRxFFH7GzoHPpNITnID6u/2Kg1hoOkgb9qVx/R8Ils58jm51vAUgyshrZ2Oz5AfIL8LSq9/YKpqNGTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778661826; c=relaxed/simple;
	bh=zsnExNJxHb5CwPG/1WZiVXnXOtJfrgVhK0JTNumtgK0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NAKQxtm2RHMjwuT+2Gi7ZqiDo1JPiOdheRXRd4b5uvNdqua1rJz6XtCgBFklkR5dzsm79KOAG7mUohhH9+VFIBbp6BGmXdS4vCdqALhyKivi9jhgsmyhFM6TwvxtdoBpXdvgLAe7QnnYA/6aqR7mcmdCHofkam+wR5Dp6IEkfvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hwR7gbVU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OjMXX5Tu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hwR7gbVU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OjMXX5Tu"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64D6ii5H2965306
	for <linux-acpi@vger.kernel.org>; Wed, 13 May 2026 08:43:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=3aWzzWqgV1S+DaS5mlIRnU
	gf5ktWPNv26+QnmRkT+ME=; b=hwR7gbVUoxjURX6qLYAEAxMb+yk0dRG5EZ51x/
	dcXzldklHMzJYhJvk3EqH3s3UdMsgBWSt8bQ9ZADjslw4ciyf9IToJhxJCNvySQi
	isOf3KapTjbRuUG2qXNi92TTYlZfiCKt8HbhpAYZldXTCt1V/P5Rc30lM3tlC066
	NPTZviIYlHcFof+2pKdHhaQ+7RxyGjgotNU5iScDn3Io6YLzFu/OSeZnKzUTV0MN
	e+gIvbaxU+7XeDYSAvdT1xKhTpu4Te2mtjam8/70wbwXtlAiKt+/UP3MaixxEv+j
	GwGWOkUKak7iiRwD8LhOPgUfIRnRsLEzdsAvtKVh+INJSa8g==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4ma58exa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Wed, 13 May 2026 08:43:42 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-367cb6de61aso7699952a91.1
        for <linux-acpi@vger.kernel.org>; Wed, 13 May 2026 01:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778661821; x=1779266621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3aWzzWqgV1S+DaS5mlIRnUgf5ktWPNv26+QnmRkT+ME=;
        b=OjMXX5Tuuq2Bdo+ir+qtziqbQFNH0+kG1SlzealebGIk6CtKNC8pHQzmqDLl3Mi3zN
         nuPJuGPyP6xXUJKWttZd6l83LxdHB1pdp2Woe0zhmxc0tQoOp6Z09qhKCvUaMyukk7KT
         TKiP4yZjkzwADUSkzlBC4D8b+T/SZgGAJiSopqk4aAjuLIaP6/CTH43mB0WaAYPYn18H
         ioZLAXXRVkI/8sGbow1P4WbUsSES544OJq+vecNpCpuhjx6DWmdILdUCOzMf3Ldpp+nu
         yA3NzvlNasfK/pSeqlIz1JTckdL3fDR3ruF9jlJtcXVCnABmxfSdc0b2Xc+8wrkcRKHA
         CkWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778661821; x=1779266621;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3aWzzWqgV1S+DaS5mlIRnUgf5ktWPNv26+QnmRkT+ME=;
        b=naA5KksSPJheeHYJwOP/Srh7NNqa7EMtQlYa+YjesKvjRml6DUlerbnwQ0RWzyNWkg
         uyBxJ9GVAROjDcdRWzDL5Z8on5qQowQS92LSOvmX4G8xQIHVybDjZfI63U2cBa+vN/OM
         tpmVY6AMPY5kVgwf2OP49R157WANVGUTuIMHk7d21uEmzYpOyb9mFIkW1otaFfyKCDXd
         JMJ0xNhCGLIG9zCQbaMX2wYnjuNa2/YYKAOFTjLdZR32yMIll2FwOMaV403RWpiTYoxW
         m3c+vPb0U/rkGjL13PAeHyYdj+pQPOmtmpT9BmarChBNYk7d5slqWg82wB1fG5Fj8bq6
         o5ng==
X-Forwarded-Encrypted: i=1; AFNElJ9pXUnoj3TkXRTY8CH106LwNy/XqyWPPD9vidDNDrLkLczmzWh5afPm0mI0uIvZaQNp8Z/RgVPVUHzo@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw8+FQkDTqYDCcMMGIayi+gqkFhspWGQAUoGCmnVi6UdgECF7Y
	+16YNIGsuR9ndZbxye4nZKCWxDMbvTyzmJFI3Rd1boLN8vWUXIV58EQ7O2BKGD9FojvVoNkrPOJ
	PcH5vUNu7TaknI3zx0PT51zk2xXuq5sbiryjyRfyv92lgaYR3zDmsNBwWGfaFzVOP0ptY2Za2
X-Gm-Gg: Acq92OEk7zkkqlyKJBsvVvD5pQwHkEU3wkL7cXRQ536RqSgX1dNFsoZpYT21EYqQxDn
	nZNnMiSPfXimjMvmYaBGlJ/ujntCo83AXK8pBSz9+ObX3yP673OY5uVBY/Jcu5Kd5c8JytThj65
	6UFva4APqt3OAiyljTIBaDd77gur++WiB+OFONHncZ7DU5M6TCPg/xL26B0UhFapihMdALkkn2w
	v00C2jgDhAlKsIyfypyXUMBY0LMXqID0f81IHPGPHU2Qu7SQu1N9AVv4a3HPt7aANEM+XjLQR7s
	ZFRMpvhb5huksPsNHFbrh2tZSVb2HeKbhxsOIe/ZyuaER+He0LcRS3i8CpDPE8V6r4Nkodb8LVU
	wjTNi70g7BQSe3yb3ULhOE/cTmgj5XzHekmD6nQDyckhbEgPNdfSP1Vo7W8YCCpN0rT4JFT0QkI
	/BTvRmVdD7lUPOIATlIWKfzz6TGDupP49oVmbj6NjbrlfduQ==
X-Received: by 2002:a17:90b:2ccb:b0:367:db13:aca6 with SMTP id 98e67ed59e1d1-368f7a26e42mr2102562a91.26.1778661820922;
        Wed, 13 May 2026 01:43:40 -0700 (PDT)
X-Received: by 2002:a17:90b:2ccb:b0:367:db13:aca6 with SMTP id 98e67ed59e1d1-368f7a26e42mr2102502a91.26.1778661820245;
        Wed, 13 May 2026 01:43:40 -0700 (PDT)
Received: from hu-himchau-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d2709bsm169158725ad.5.2026.05.13.01.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 01:43:39 -0700 (PDT)
From: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-efi@vger.kernel.org,
        acpica-devel@lists.linux.dev, paul.walmsley@sifive.com,
        palmer@dabbelt.com, lenb@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, ardb@kernel.org, conor@kernel.org,
        cleger@rivosinc.com, robert.moore@intel.com, sunilvl@oss.qualcomm.com,
        anup.patel@oss.qualcomm.com
Cc: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Subject: [PATCH v4 00/10] Add RAS support for RISC-V architecture
Date: Wed, 13 May 2026 14:13:15 +0530
Message-ID: <20260513084325.2176952-1-himanshu.chauhan@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDA4OSBTYWx0ZWRfX5PZXo+FmjIKB
 SY7ItjmZB2BbhVsdUIm2zM3zfVgJqRKPOjPfoq4s8NqlO9MmAfBLLQZcjF/z5xlIj3bI6Vx7bGf
 08MKYe+7TRWXJK8xgqwSDuNJtj1oetYgAoTwI4cEljV6KXxen/vFQszLotlFOnBeoHS0ig60Clj
 pH1HLlcKqtwHHDl5OmiozgCXYJ3rpZ4N4SNtsCe2eCfD7f5naOSWB6d4jAzbbYCSVT7oKgaltzK
 M8ag/KAegfqJy3xZ6Qsp66Q4PnGK9MMKV2NNaVuuxxnQ8k8pPPKiGDaT04aEtNydzL+jfeXhR32
 myXEiY0gwUa1XwVU4moTc1XuggmnSGq/9fmsWI/Dfi+LNPy0aE8SmQXUTDB7H9PTkThL77rtJzZ
 /jA/k0juRzP1ubS/NyVdwK18kc9a44nLEAk60hTF+zA7/1i0VXv+UP4NdYSBgcZJbLMlq9vBrJO
 Q8iNTwFFP9gyaqqngbw==
X-Proofpoint-ORIG-GUID: HwgAiblhjFhb5EbdBiV_PnbuEW8aZnBK
X-Authority-Analysis: v=2.4 cv=TJZ1jVla c=1 sm=1 tr=0 ts=6a0439be cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=NEAV23lmAAAA:8 a=V1jnuoLLAAAA:20 a=VwQbUJbxAAAA:8 a=h0uksLzaAAAA:8
 a=dw0t6H4-AAAA:8 a=j7arexpxAAAA:20 a=WC7QRpXXAAAA:20 a=F-tpdftpAAAA:20
 a=hVMvMyeA2jgiXT6_RH4A:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
 a=MSi_79tMYmZZG2gvAgS0:22 a=wVJa4CU9-Z26yuRAZDil:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: HwgAiblhjFhb5EbdBiV_PnbuEW8aZnBK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130089

RAS stands for Reliability, Availability and Serviceability.

This series implements the RAS support for RISC-V architecture using
RISC-V RERI specification. It is conformant to ACPI platform error
interfaces (APEI). It uses the highest priority Supervisor Software
Events (SSE)[2] to deliver the hardware error events to the kernel.
The SSE implementation has already been merged in OpenSBI. Clement
has sent a patch series for its implemenation in Linux kernel.[5]

The GHES driver framework is used as is with the following changes for RISC-V:
	1. Register each ghes entry with SSE layer. Ghes notification vector is SSE event.
	2. Add RISC-V specific entries for processor type and ISA string
	3. Add fixmap indices GHES SSE Low and High Priority to help map and read from
	   physical addresses present in GHES entry.
	4. Other changes to build/configure the RAS support

Changes in v4:
 - Rebased to Linux v7.1-rc3
 - Changed RISCV to RISC-V
 - RISCV32 and RISCV64 to RV32/RV32E and RV64 respectively
 - Raised a review request for patch "Introduce SSE in HEST notification types" in ACPICA
   https://github.com/acpica/acpica/pull/1170
   Keeping the patch here for complete functionality

Changes in v3:
 - Dropped RFC tag because the related ECRs are now approved [6][7][8][9]
 - Changes to be conformant with SSE v8 patches

Changes in v2:
 - Made changes to be conformant with SSE v7 patches
 - Fixed some bot warnings

How to Use:
----------
This RAS stack consists of Qemu[3], OpenSBI, EDK2[4], Linux kernel and devmem utility to inject and trigger
errors. Qemu [Ref.] has support to emulate RISC-V RERI. The RAS agent is implemented in OpenSBI which
creates CPER records. EDK2 generates HEST table and populates it with GHES entries with the help of
OpenSBI.

Qemu Command:
------------
<qemu-dir>/build/qemu-system-riscv64 \
    -s -accel tcg -m 4096 -smp 2 \
    -cpu rv64,smepmp=false \
    -serial mon:stdio \
    -d guest_errors -D ./qemu.log \
    -bios <opensbi-dir>/build/platform/generic/firmware/fw_dynamic.bin \
    -monitor telnet:127.0.0.1:55555,server,nowait \
    -device virtio-gpu-pci -full-screen \ 
    -device qemu-xhci \
    -device usb-kbd \
    -blockdev node-name=pflash0,driver=file,read-only=on,filename=<edk2-build-dir>/RiscVVirtQemu/RELEASE_GCC5/FV/RISCV_VIRT_CODE.fd \
    -blockdev node-name=pflash1,driver=file,filename=<edk2-build-dir>/RiscVVirtQemu/RELEASE_GCC5/FV/RISCV_VIRT_VARS.fd \
    -M virt,pflash0=pflash0,pflash1=pflash1,rpmi=true,reri=true,aia=aplic-imsic \
    -kernel <kernel image> \
    -initrd <rootfs image> \
    -append "root=/dev/ram rw console=ttyS0 earlycon=uart8250,mmio,0x10000000"

Error Injection & Triggering:
----------------------------
devmem 0x4010040 32 0x2a1
devmem 0x4010048 32 0x9001404
devmem 0x4010044 8 1

The above commands injects a TLB error on CPU 0.

Sample Output (CPU 0):
---------------------
[   34.370282] {1}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 1
[   34.371375] {1}[Hardware Error]: event severity: recoverable
[   34.372149] {1}[Hardware Error]:  Error 0, type: recoverable
[   34.372756] {1}[Hardware Error]:   section_type: general processor error
[   34.373357] {1}[Hardware Error]:   processor_type: 3, RISCV
[   34.373806] {1}[Hardware Error]:   processor_isa: 6, RISCV64
[   34.374294] {1}[Hardware Error]:   error_type: 0x02
[   34.374845] {1}[Hardware Error]:   TLB error
[   34.375448] {1}[Hardware Error]:   operation: 1, data read
[   34.376100] {1}[Hardware Error]:   target_address: 0x0000000000000000

References:
----------
[1] [RERI Specification          ]: https://github.com/riscv-non-isa/riscv-ras-eri/releases/download/v1.0/riscv-reri.pdf
[2] [Chap-19 SSE RISC-V SBI v3.0 ]: https://github.com/riscv-non-isa/riscv-sbi-doc/releases/download/v3.0/riscv-sbi.pdf
[3] [Qemu source (RERI Support)  ]: https://github.com/ventanamicro/qemu.git (branch: dev-upstream)
[4] [EDK2                        ]: https://github.com/ventanamicro/edk2.git (branch: dev-upstream)
[5] [SSE Kernel Patches (v8)     ]: https://lore.kernel.org/all/20251105082639.342973-1-cleger@rivosinc.com/
[6] [ACPI ECR for HEST changes   ]: https://mantis.uefi.org/mantis/view.php?id=2522
[7] [RISC-V CPER Table ECR       ]: https://mantis.uefi.org/mantis/view.php?id=2551
[8] [RISC-V CPER Proposed Changes]:
	[PART 1] https://docs.google.com/document/d/1-Dd-T_QIUqjq3muyjfK8IUeXWr9QWkFAkFyzweXQL30/edit?tab=t.0
	[PART 2] https://docs.google.com/document/d/13y8kQqbVtCAPCMI4oJ80MtcUS5FL4xuO914NmfCi5vI/edit?tab=t.0
[9] [RISC-V APEI Proposed Changes]: https://docs.google.com/document/d/18rxA6JTyFTelEj0aiKdSFzxPgwyHyThj8EP8lXqWZdY/edit?tab=t.0

Himanshu Chauhan (10):
  riscv: Define ioremap_cache for RISC-V
  riscv: Define arch_apei_get_mem_attribute for RISC-V
  acpi: Introduce SSE in HEST notification types
  riscv: Add fixmap indices for GHES IRQ and SSE contexts
  riscv: conditionally compile GHES NMI spool function
  riscv: Add functions to register ghes having SSE notification
  riscv: Add RISC-V entries in processor type and ISA strings
  riscv: Introduce HEST SSE notification handlers
  riscv: Select HAVE_ACPI_APEI required for RAS
  riscv: Enable APEI GHES driver in defconfig

 arch/riscv/Kconfig                     |   1 +
 arch/riscv/configs/defconfig           |   3 +
 arch/riscv/include/asm/acpi.h          |  16 +++
 arch/riscv/include/asm/fixmap.h        |   8 ++
 arch/riscv/include/asm/io.h            |   3 +
 arch/riscv/kernel/acpi.c               |  12 ++
 drivers/acpi/apei/Kconfig              |   5 +
 drivers/acpi/apei/ghes.c               | 101 +++++++++++++++--
 drivers/firmware/efi/cper.c            |   3 +
 drivers/firmware/riscv/riscv_sbi_sse.c | 146 +++++++++++++++++++++++++
 include/acpi/actbl1.h                  |   3 +-
 include/linux/riscv_sbi_sse.h          |  16 +++
 12 files changed, 305 insertions(+), 12 deletions(-)

-- 
2.43.0

