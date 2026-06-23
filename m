Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2D23C9EED
	for <linux-acpi@vger.kernel.org>; Tue, 23 Jun 2026 14:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782226357; cv=none; b=G7v+pKN19Uud3sEatwddsK7/ZSStHXJ+vAh1hfZFatfaGf4nd2E2FYDNKhQnCbJBNvs2lwCEglE2SDqkYWgBsBWMRhciRy08KEGhV6Vyth2HdOLKwrmgVMm7hpeAADGHFn5+BxBfWQxLl1/ylzwYgmjo9ELxo3T9NQz9v36MD6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782226357; c=relaxed/simple;
	bh=zDre3UYfu+bNvtbqlWeBmCxN1oWAuVcva06ty0WiJv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YBkY/RwR+zgThBjChO1WS00KdoRz+NeiHflVoQQLV/RRJZiMAz6bRKyfoB0BKbH9cp/GGFpZAABs2BmvpjekyvkA6puwNlw0gBX5VddNyaLaS9cew31NZe6422w6Wcsb118pdBToTynqk0dGkjyScsNVDYHtp7RZUsPxzDaaoAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kwa28SvQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PaYpvCYY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kwa28SvQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PaYpvCYY"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NBZbEi134229
	for <linux-acpi@vger.kernel.org>; Tue, 23 Jun 2026 14:52:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=RJVm2brt1ck
	UIcHVwLv3uY92h4oMIvtxcJLYHJJ2Evg=; b=kwa28SvQrt3egBJ2d+tL9tOcFn5
	sIkZ2yhrfYBfbXSV4hdd9WJ7B6C/1ue1mD7MLD5hxaEolvu2Fg+a8GHgBX3kzRwe
	Hzvq7lNaNWrZjqYeA4LH+HxXrtod0Zl4i4hVlbuRDgTiVVhxy86pc1lhXi2SWmLq
	sYLfn0tgDIFR3URLK4IGxBpAKLNLBnYPEhePIQ5RjnMCZKAsQbKtJ8OhNrH6gt3y
	XjIEAbD2ER6nhyE7L1j3O3v6BSrI72Dq1MgPqz9p1Bf+Jt+7X74om9rY+BFueWPg
	8PJbIsYuuQUQiQJKZatYZ8alYE+Qqm5bzYcc7JdR8mteEzQw+HL5erE61eg==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eyr3214wt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Tue, 23 Jun 2026 14:52:34 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-71f4e6ff16eso6929747137.2
        for <linux-acpi@vger.kernel.org>; Tue, 23 Jun 2026 07:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782226354; x=1782831154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RJVm2brt1ckUIcHVwLv3uY92h4oMIvtxcJLYHJJ2Evg=;
        b=PaYpvCYYllwvnLPxaH83pzrNx3mTnqvdkgLMxT+Hi+AGv1jILQVSjeTDjQUtpnw01g
         nasktD+wcb9HZnIro+YwBTXN29TP+0CLBjIgXjh8yc/AkP6tneh3M3uhEDaLFLszPL8A
         bH2jR1gEqmWuNTZ35UC7jhcdAjJEq32Ml4CLvjNcRMBN2cyK9EQMzW0bwoiCkLOO8XzN
         MBDqfEdkBHvHAxzJwlRoGUD8R7pGk7wETFPQh1RWy3aI37o5zIZdPwOYVSpoMl5Socqo
         NHPWC6mlyQpSqrTvvgiW2+YkHlVXUE65U+Pu2jkbKQS/KW0xdHtUZtC7cf+xugdhJTzk
         NYVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782226354; x=1782831154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RJVm2brt1ckUIcHVwLv3uY92h4oMIvtxcJLYHJJ2Evg=;
        b=hRkODa3pZ/YQym0/xm6UwVvOQzx+pYHkbkt4RmEwy8YUSnkugg6bevwh4qgRNNFK2T
         DVQzo5kDrrWSAxKtDy9vLUBr2WTEsjA14/0NxnBusEk8Q/9CiUBTuzfoaKGTrCRBQ9iR
         rEY4OEbgzjtxC/+A8oWse6O5ggwDylZH8yT5qNAKAO6/9V7Daf1RLSbrzNTKkEzOK5Tf
         MZUDBtQxib+zdiqMwRJMtNExxaRkQnC59jqOx9LpO3SkSE+8MaPwzHU7tNAIi2R7v4xU
         ySbjETPLv2jwg4spGPGFQjXlYF+RkC+T5KHTlyAVWlWEmzbeEyDlgIr4BgAnLmoYaGfM
         rlvw==
X-Forwarded-Encrypted: i=1; AFNElJ+3+8YhuQOlW0N/8K8LPk50NZ3A4zH3UdwkWCr+vPGPW3VD7yzt1OlB/8AL8OIbtUHOO5Cd8nqkaZFT@vger.kernel.org
X-Gm-Message-State: AOJu0YxOijDzk7w+Vw+4CWyxNazJqQO+PvTppGMW8FrPO8Sp+BIHacMw
	ejeTkGcbe7oXhLVPj/ZuHLzy0Ch9UZ4NV3uAPdR5NMohNhEqPnaPLsq+W6kojvjWh1ADdDjIm9N
	GnWQrlO6adAt+kT/4c75DSR6xay+h/SHofSlpjDZEDc+9GvTb9dGGq5h7Ib5aUmYc
X-Gm-Gg: AfdE7ckdP8KhbFLZoQuYmrLpF3kbjc1nBAxqL6r+3TUZyBq7EroaoGMOLVZ3pUXSAHC
	lzAQxDrnZFAAQadmDpPUOnzbL7eZJp56Qs1p4tqHPckVurmRm3BEbgifW8B89xZr8sszwaXp2pa
	13bl1SYQpcCxQZL767/gNxuHqlTTjZqLsyan8L3vuC0jle1YF96+QDA7Xb9gxaYAcPuxjFuwZ1c
	pjUQU5r5H0e2MOHOmh6r6bpf7H8KAi2ODUnuCeV/VhkogZUjxzAm3yE9GVBiIzoaNUzh9QOrLnN
	NJlGqNJ0w8Y5+yoE2WWuN13N2EtCqTKE/L+2E8ML3eG+ypPhJ+h88rsmb/p5/7YsqqH9gHX88il
	n6jdBos0i4GGvG0tN6MLuc4kJqbEf2wFqtf5pDBINWemH/hOeKsfQjyUt81xenGpaQ4Hm/vUkFB
	F/01b/VrhWq4rpylAn2Yr6T2QVPw==
X-Received: by 2002:a05:6102:6a81:b0:6c6:432c:84d3 with SMTP id ada2fe7eead31-72fd5ea52b7mr1890219137.12.1782226353692;
        Tue, 23 Jun 2026 07:52:33 -0700 (PDT)
X-Received: by 2002:a05:6102:6a81:b0:6c6:432c:84d3 with SMTP id ada2fe7eead31-72fd5ea52b7mr1890185137.12.1782226353222;
        Tue, 23 Jun 2026 07:52:33 -0700 (PDT)
Received: from shalem (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c0c60aca46csm534042666b.36.2026.06.23.07.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 07:52:31 -0700 (PDT)
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [RFC 03/12] arm64: acpi: add acpi=hybrid support
Date: Tue, 23 Jun 2026 16:52:16 +0200
Message-ID: <20260623145225.143218-4-johannes.goede@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623145225.143218-1-johannes.goede@oss.qualcomm.com>
References: <20260623145225.143218-1-johannes.goede@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDEyMiBTYWx0ZWRfX5T51m1MsO/XP
 eQB7f3sfz34WjmCu0VwlwiyVsSlShp08GE/8bKCsoWPJOdgvMLXzWW95hukQq9IByzoMXz7ZmqM
 3FYl2ABGTAFYBOV+Ds0gkUKinNuFl3M=
X-Proofpoint-ORIG-GUID: d8cxrzG0ZBQG8jzvKFU9NTOZEbvax0Ig
X-Authority-Analysis: v=2.4 cv=HrxG3UTS c=1 sm=1 tr=0 ts=6a3a9db2 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8 a=ZBzCgZ0olsrJ8aaC5scA:9
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDEyMiBTYWx0ZWRfX1nE4SnFOvTxy
 FEmuOCHru8cbZwvWpjKZGXu1ml6iOcIBgWz/lDo3+Riv0MauQIYsmolAHDE27do1LnGI5tDUA1o
 8nxLt8ELugI/UYHuFB6yqzXm/emLBC1hc7G2QnZ4HwBHKZV4p40HMLuvCtuYCaCXIyV4Ghku1wf
 vqz2hcivHrNJthuLHSxQ4J6HC6vjbo4dJY//bS/P1qktd4b4ow7I2f8q7qbqADQIEJoH1pbJlwd
 h28lRdRvXAa/2QuRU349yl3NxJvCVfegFqwt9rsJTBODMoHLqKYA4FjebUdJEnNwoCvDWh9d076
 M+EC5xom040UmuqIgnQB6Iq5TZA6e/Vjqoqxz2FTIaHaEBW/7tfjbnjafNo0v6FocG6l+lcDjmV
 HolJU6qpbay+kOLNMlhKJ0X94ZUTSJJ/Krpz+dGk3xBhcHc+glTCrazPcHCgUqOFd3oo2mSsTxM
 AleClK74BoTyn9WdABQ==
X-Proofpoint-GUID: d8cxrzG0ZBQG8jzvKFU9NTOZEbvax0Ig
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 bulkscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230122

By default when a non stub DT is given to the kernel when booting, ACPI
gets fully disabled.

Add support for selecting a new APCI-DT hybrid mode where the kernel
booting in DT mode still loads and parses the ACPI tables, without taking
any further actions like creating devices.

This will parse ACPI tables and populate /sys/firmware/acpi and
/sys/bus/acpi/devices, which can be useful to e.g. get an acpidump .

Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
---
 arch/arm64/include/asm/acpi.h |  2 +-
 arch/arm64/kernel/acpi.c      | 16 ++++++++++++----
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
index 3116bb872f47..8f8a0b9e49c3 100644
--- a/arch/arm64/include/asm/acpi.h
+++ b/arch/arm64/include/asm/acpi.h
@@ -76,10 +76,10 @@ typedef u64 phys_cpuid_t;
 #define PHYS_CPUID_INVALID INVALID_HWID
 
 #define acpi_strict 1	/* No out-of-spec workarounds on ARM64 */
-#define acpi_dt_hybrid 0	/* No DT-ACPI hybrid mode on ARM64 */
 extern int acpi_disabled;
 extern int acpi_noirq;
 extern int acpi_pci_disabled;
+extern int acpi_dt_hybrid;
 
 static inline void disable_acpi(void)
 {
diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index 06ab3a9da64b..9d2c42375afe 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -43,11 +43,14 @@ EXPORT_SYMBOL(acpi_disabled);
 int acpi_pci_disabled = 1;	/* skip ACPI PCI scan and IRQ initialization */
 EXPORT_SYMBOL(acpi_pci_disabled);
 
+int acpi_dt_hybrid;		/* disable ACPI-DT hybrid mode */
+
 enum acpi_mode_t {
 	acpi_mode_unset,
 	acpi_mode_off,
 	acpi_mode_on,
 	acpi_mode_force,
+	acpi_mode_hybrid,
 };
 
 static enum acpi_mode_t param_acpi_mode __initdata;
@@ -65,6 +68,8 @@ static int __init parse_acpi(char *arg)
 		param_acpi_mode = acpi_mode_on;
 	else if (strcmp(arg, "force") == 0) /* force ACPI to be enabled */
 		param_acpi_mode = acpi_mode_force;
+	else if (strcmp(arg, "hybrid") == 0) /* ACPI-DT hybrid mode */
+		param_acpi_mode = acpi_mode_hybrid;
 	else if (strcmp(arg, "nospcr") == 0) /* disable SPCR as default console */
 		param_acpi_nospcr = true;
 	else
@@ -203,7 +208,7 @@ static int __init acpi_fadt_sanity_check(void)
 void __init acpi_boot_table_init(void)
 {
 	/*
-	 * When no ACPI mode (acpi=off|on|force) has been specified,
+	 * When no ACPI mode (acpi=off|on|force|hybrid) has been specified,
 	 * enable ACPI if the device tree is empty (it only has a /chosen
 	 * node, and a /hypervisor node when running on Xen).
 	 */
@@ -230,6 +235,9 @@ void __init acpi_boot_table_init(void)
 		pr_err("Failed to init ACPI tables\n");
 		if (param_acpi_mode != acpi_mode_force)
 			disable_acpi();
+	} else if (param_acpi_mode == acpi_mode_hybrid) {
+		acpi_dt_hybrid = 1;
+		disable_acpi();
 	}
 
 done:
@@ -257,10 +265,10 @@ void __init acpi_boot_table_init(void)
 		 */
 		acpi_parse_spcr(earlycon_acpi_spcr_enable,
 			!param_acpi_nospcr);
-
-		if (IS_ENABLED(CONFIG_ACPI_BGRT))
-			acpi_table_parse(ACPI_SIG_BGRT, acpi_parse_bgrt);
 	}
+
+	if ((!acpi_disabled || acpi_dt_hybrid) && IS_ENABLED(CONFIG_ACPI_BGRT))
+		acpi_table_parse(ACPI_SIG_BGRT, acpi_parse_bgrt);
 }
 
 static pgprot_t __acpi_get_writethrough_mem_attribute(void)
-- 
2.54.0

