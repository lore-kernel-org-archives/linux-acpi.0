Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D495F3DE43F
	for <linux-acpi@vger.kernel.org>; Wed, 13 May 2026 08:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778661840; cv=none; b=oKWywVdifyvTx+OZTyQkGQ17rMIF/cG5qLezC7NoYWoo21vpMDGpUUB2xvSp6xueIP8XuU9w0/vJrI2vhdCVzILdF8mypOrb4rExi7LJ8AWesiGMNwWi3KepBqyTw0Ir3AXrUnAx1UtdBbNEfdsGHE77YOx5bMw+Ym2P3gnbTxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778661840; c=relaxed/simple;
	bh=Z4ltDVtB39Gu5KX9iCO88y5JLOWBAk8es078Y80/iFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AmGqKhVyGBCrHzlhhP7+qpdyJO1Y5trVszyOy72UguamEta0DQZwF8kHRizx7D/I8ycRIITb5eaaMpi3Vbzduu2VKST9aSF1m5Xty+9r1txJiiwKdp0UOyaDkdTPnJIxpAWvX2wYbx1MtC3IcF3KI3umiCiw9xNi5GXR6oVQem0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=khGZ0Nny; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TW9OAvM2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="khGZ0Nny";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TW9OAvM2"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64D4p8ZG2331397
	for <linux-acpi@vger.kernel.org>; Wed, 13 May 2026 08:43:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=ZktuxFKbZoJ
	xn+4CgM4kaOVJh9P4Xaw+uozUmzXsWPk=; b=khGZ0Nnyp4YYx9eMqzTrHGOSLJt
	yp6TarjLJRwnDAd9pOEmLPPBDiwreDO3XEuzRiFgosLbCmKgyMCPghK9Z8N3btH6
	od4Z5l+o9xne+x0N2Hmkr7gr/SwsBBdDmjZBE+KzkJH5mZqTqME0qMMmm45yXG3N
	iYbAlGvE//QJRO9HXDkbTcDuPQ0jI8nYobZncMMMh1OTd1pN4ZJFPlsXYTYJl3SI
	Sh3mPtZYU2u6Utf1cyxRbZl72JbjXV5h7IpUGZA5neNsZN10uN58bsTW3kgzs/yG
	LFYsJrwcCOhF/VzgOdVfGmHgu25JW7pXF6uxxNnmHO6wPxj+o1PAm0X4G8g==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e43ypc8ev-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Wed, 13 May 2026 08:43:56 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2b458add85aso69789725ad.2
        for <linux-acpi@vger.kernel.org>; Wed, 13 May 2026 01:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778661835; x=1779266635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZktuxFKbZoJxn+4CgM4kaOVJh9P4Xaw+uozUmzXsWPk=;
        b=TW9OAvM2B94WOB/4annMi2ujYtCLL62Sr280/TQTebBFMYAcUStuA/a6Tyz5F3wNDs
         rcO4NsvSN9mjszpbu2u6kd1Zae1mjDyMSHJWLFZbMrbHWlfKrEJg5yqllyqs8jbrgttu
         toiHgEKgmVsnn+sXWHO1fwVMUhyr7WELuEcwwQWYvgqHG435n+raxUjTwxgydjyN6eKD
         1SzuyPUNAQs7pJ6QfCQBGAZAJUedHD1g6mw0K5BBlFrm4WXTTplgEZDg04Q22oqGHOc0
         VFT1tdOqJecJVPwsd/5/Jrr7EiLESoVZIg1fsG3NH+o4q7O8XyGTJoCdffLx5mL47UK1
         yIuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778661835; x=1779266635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZktuxFKbZoJxn+4CgM4kaOVJh9P4Xaw+uozUmzXsWPk=;
        b=INRRd06UxEWQp2GZZVyQiLJFCZIb8QfChy7l+U4Y8s6D9ZTTP0FLUgWwsAFkM64BBU
         BWha89YiIUAilOa5Oo1Q8ke9cAc3IkNv30IdrHX8WuldEnTOvs2L1S4rYm56AT2Gwo2F
         gFjnv0H1OXdvGJPGkzMcqRTlIXHebzcw0cUaoLLCkOV6qm7wd6jj/4tRr2BosDjTUV0B
         yyGPKenkw9TSmXgYFLbsu5lN9sy2rQk6SebLqEm7aKwoQZqWwzrGkclqY7VwRhNGgWVV
         gE3Vrmh1umsdu0nlqQbqszUfMB7VMykGs3k3WJtsNM4PtGOnyeDtFPNK2zQQPQJ/2jxf
         AUoA==
X-Forwarded-Encrypted: i=1; AFNElJ/Jxmn1dYolZriWiu1OV/pL789syxcxMAGKlPzqbbpUZd5kksxol2pOWjPyEWqK2+pEAxS9xj1yjBwR@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa8Gkebc+aTaQd+CcRTofSbbAhEiiUzYu2i+vTczdQ2Yakyvwf
	RITF+izKWWnOGEeX3ydY9vkXBi7sGJEzuaRgl+CLo1qImcFvRWns4ssLJvvMadng13SDARij1ii
	PEXn2laKiGaiq6aWn5ifSx3NxswwOT3K25hPVhSOiULv2t7deLVy5snLyL9/Y75uu
X-Gm-Gg: Acq92OHO9CdwmuNP/IszPgVzvtpq8WHiR70lhuLN/pbu6OvlcqqhZHB/aI+Sl48Q6z9
	FCGdMcjtZHLselFjmq4QNgreBHQPtv8INgBzBglL7Db2vfI4NFLxCVYh4moeoLdD2nHum+L6bKb
	kubR4QVzRUH/IhK6CL7gtIQkKKFE15vcJ32SBAd2BnSOitEgL+GEEndzkjY3cuGhBsp247iou/R
	Sof3BTcR7Pt6egtzXsa9dVIMcinJB54zNiAaGjaocUxmwncfqwQ8Mchx7ZhCvOgiTbL2/YMO6X6
	SOFN3jVeLCzZ0nBr8X9dqA8+OjOQNJnGTXMiP97EPxFLfI2ak476e0Ju7pitttRkohpci9bK+kw
	lnqA5uflvswsgSjvHIIDuRtJiwSxY0frGhXHlu6xKnHg4BdG9LP+rYfONCh4/CkmAITk9j+k630
	totG+TzzGM28qUdUEEXhTRpNwEFJIuKXcRHM186JSwTj/rIw==
X-Received: by 2002:a17:902:e156:b0:2bc:b80f:677e with SMTP id d9443c01a7336-2bd2fe21b60mr14244545ad.25.1778661835406;
        Wed, 13 May 2026 01:43:55 -0700 (PDT)
X-Received: by 2002:a17:902:e156:b0:2bc:b80f:677e with SMTP id d9443c01a7336-2bd2fe21b60mr14244275ad.25.1778661834836;
        Wed, 13 May 2026 01:43:54 -0700 (PDT)
Received: from hu-himchau-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d2709bsm169158725ad.5.2026.05.13.01.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 01:43:54 -0700 (PDT)
From: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-efi@vger.kernel.org,
        acpica-devel@lists.linux.dev, paul.walmsley@sifive.com,
        palmer@dabbelt.com, lenb@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, ardb@kernel.org, conor@kernel.org,
        cleger@rivosinc.com, robert.moore@intel.com, sunilvl@oss.qualcomm.com,
        anup.patel@oss.qualcomm.com
Cc: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Subject: [PATCH v4 02/10] riscv: Define arch_apei_get_mem_attribute for RISC-V
Date: Wed, 13 May 2026 14:13:17 +0530
Message-ID: <20260513084325.2176952-3-himanshu.chauhan@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260513084325.2176952-1-himanshu.chauhan@oss.qualcomm.com>
References: <20260513084325.2176952-1-himanshu.chauhan@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: KAblfuwCj9TmJEVAvRTLB9Y2VF3jy-PS
X-Authority-Analysis: v=2.4 cv=R5kz39RX c=1 sm=1 tr=0 ts=6a0439cc cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=eGWCFza2bnmXRcdnH9YA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDA4OSBTYWx0ZWRfXxreCmYmQASEi
 kOkr1Gmi4ygbWAI2S3vDdUPLfd0u522FLY1jTKQOcdebRzwj05zY9DJu6b93bQSbUZCKnGSft5N
 wHFUgoCtKP2D3DtCXUf8J1ybBbvE4QtttZWXKqobsafzopiOIuIRTT+5V0GwdjylG4ZFJn3p3yt
 qCUlD3XdwgB/PBByFW/Xg/ISsgBnkYG8VQ3M4h2NTAD6JPN4rzLmLaxS708BpC5Nt5G2F6baUmk
 gmujSHWe660nbcSaxJ3d09OzU2V3RIb/stLyJf2RGmSAqkKBPdIzLoJSm2aZFSUvXxKTxRNHrn5
 +Wf+9rpW6wOxeVCVOOQk29Ev6Rmbe9EUq0HSkPzu39MWddl/vrX3eJrz+/WZejjMp8KczOS+ydw
 qc/boNwKUo8eDWOL6GvRth6nA0MK8T2mSj1HqhTQDHO0cRZJZ898qVLl+1rLQX4x5OeOizChzBH
 7bdJ9VyOHlKbU+u5OmQ==
X-Proofpoint-GUID: KAblfuwCj9TmJEVAvRTLB9Y2VF3jy-PS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 bulkscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130089

ghes_map function uses arch_apei_get_mem_attribute to get the
protection bits for a given physical address. These protection
bits are then used to map the physical address.

Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
---
 arch/riscv/include/asm/acpi.h | 16 ++++++++++++++++
 arch/riscv/kernel/acpi.c      | 12 ++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.h
index 26ab37c171bc..c142db9f81a7 100644
--- a/arch/riscv/include/asm/acpi.h
+++ b/arch/riscv/include/asm/acpi.h
@@ -14,6 +14,7 @@
 
 /* Basic configuration for ACPI */
 #ifdef CONFIG_ACPI
+pgprot_t __acpi_get_mem_attribute(phys_addr_t addr);
 
 typedef u64 phys_cpuid_t;
 #define PHYS_CPUID_INVALID INVALID_HARTID
@@ -27,6 +28,21 @@ extern int acpi_disabled;
 extern int acpi_noirq;
 extern int acpi_pci_disabled;
 
+#ifdef	CONFIG_ACPI_APEI
+/*
+ * acpi_disable_cmcff to disable IA-32 Corrected Machine Check (CMC)
+ * Firmware-First mode. It is not required in RISC-V architecture
+ * and is present for compatibility
+ */
+#define acpi_disable_cmcff 1
+static inline pgprot_t arch_apei_get_mem_attribute(phys_addr_t addr)
+{
+	return  __acpi_get_mem_attribute(addr);
+}
+#else /* CONFIG_ACPI_APEI */
+#define acpi_disable_cmcff 0
+#endif /* !CONFIG_ACPI_APEI */
+
 static inline void disable_acpi(void)
 {
 	acpi_disabled = 1;
diff --git a/arch/riscv/kernel/acpi.c b/arch/riscv/kernel/acpi.c
index 068e0b404b6f..7a6770697999 100644
--- a/arch/riscv/kernel/acpi.c
+++ b/arch/riscv/kernel/acpi.c
@@ -204,6 +204,18 @@ struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int cpu)
 	return &cpu_madt_rintc[cpu];
 }
 
+pgprot_t __acpi_get_mem_attribute(phys_addr_t addr)
+{
+	u64 attr;
+
+	attr = efi_mem_attributes(addr);
+	if (attr & EFI_MEMORY_WB)
+		return PAGE_KERNEL;
+	if ((attr & EFI_MEMORY_WC) || (attr & EFI_MEMORY_WT))
+		return pgprot_writecombine(PAGE_KERNEL);
+	return PAGE_KERNEL;
+}
+
 /*
  * __acpi_map_table() will be called before paging_init(), so early_ioremap()
  * or early_memremap() should be called here to for ACPI table mapping.
-- 
2.43.0

