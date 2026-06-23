Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94E2326D51
	for <linux-acpi@vger.kernel.org>; Tue, 23 Jun 2026 14:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782226353; cv=none; b=Ua9qVziMcYccDaBwWcEAK4HU+s/VIgMJ11GKTkVhdhyUnCAvjBgy3vpXWtYXvYfmiAYfkIndIkJM4iDcCTGe6ZflItjw3IA8wtJEDjrQyqYoOF0dTdty/6xzPKY+k7iZuno6jbOIProDrZ5z3sZJ2+3Pj1fHrHUFydSaORIp67k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782226353; c=relaxed/simple;
	bh=uxj9woUUStYpWcJNNk45RBrZFAL9TKwZJYdD4yHBm/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JDN1MFYzMpurmXxau3DIDH+rIcHg8Kdmt5vhOuB4EtzLCMgNUawGAFxhTM4UljNwfzfdTBjhl/rGlgxoH0jg1w5JqYKeD9cJSqLVspykUkNewPJ6jzwRLE8OWdU79pAjtPFZlYCHSHQ1DFTV7JRSYnAQghBfuhvFAtCzlYOxCMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n6vBdKXg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=grf+A23W; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n6vBdKXg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="grf+A23W"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NBZZ7b134187
	for <linux-acpi@vger.kernel.org>; Tue, 23 Jun 2026 14:52:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=iKdSrgybcUN
	V3KAPOhBBYGNc4u6LS0z8F4/c8uw0wqw=; b=n6vBdKXg+4Lsv47+TI+6r7GsnUl
	Jh/CnKN3kaaGlYRG6683MExMoM19flWseqE7fxOneBEPHd54ndDjEVmm+cTxIiM9
	2sseQP/b63+f8t8Eqd+D7S4biZUmTpTEkUeEGTUCkrzlhHv/LsZM4DHJUYpnQJKy
	CJprX6lBayt3nL3v0wBhzigHNU937VmEn2BH0Xdr/GIXKyM6mIvlLWeeZFdL8HnA
	KXbPwzY4w82+gLQg7ZRMs+SOBd1lVRvEsL8mrWIRv8gf/cb/ypO0uG5vYM9RX+pb
	KvXYIyuVmP2Ke2jgQGVFnOjBfYiDdDjX3XgCAebVMV0YSGiBRsIllKdE3Mw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eyr3214wh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Tue, 23 Jun 2026 14:52:30 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-9157de5360fso213991085a.0
        for <linux-acpi@vger.kernel.org>; Tue, 23 Jun 2026 07:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782226350; x=1782831150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iKdSrgybcUNV3KAPOhBBYGNc4u6LS0z8F4/c8uw0wqw=;
        b=grf+A23WEK6ZvuGIrKgy/3Rs5zWQ607wter5F89yI2VG2plqO9m/0aifS9pu45MsVQ
         Rxrp3RtNQh6kKnGZwWK+9NaGV3GVNO6Orni8RbeR6JZEMc3bXdB15BIMU0YvD5cheh6t
         lDMWP72hFZwZzrCbbTOaU7crqu0dn8Cr3fO4IlhPMMW3xw88E/0G3HB2bZnREdcm7xLZ
         TIRnZ1P7yDavvuQ4SNtdqrOHYua0yWx4r2hWB6elwsOegSprUxTJtlazP7RMEaU88jfF
         r+tadru1ThPvqF+/q1T3xDsbbAFAWMDQCRDX9zuF67bGqD0KKJwzz6LBLNN8H0j8y9+j
         Zvlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782226350; x=1782831150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iKdSrgybcUNV3KAPOhBBYGNc4u6LS0z8F4/c8uw0wqw=;
        b=XLrocHCFTp65zCGC3FINSrP/ieXfxo9FZdKlaZYoB1lhkbpucN6WZQvylj3dC21R/8
         aIcvPA3usmoSjKCp1x/SYh/Vr6lwFDoY4JnYMPuQmulFisvXcmgxoyykB7nsXXcE94hx
         OyWk0LN9V3FUtaF7jMrfonjEW+1MxrIqMfrCGwMEoI7ZdPGm4FYIn2NIKGtM5DmCXflZ
         1x2anB5Zv/ehPXDyJN0aQUdPIV25zdGVB4L6YFQRJC34DdrLU9O28WpQ/0AA6Zzx99Jk
         5NbDiCkhoFjRZgbGpq7g3ezscUBFY5se1Jh2pxp6+4HRRO1iG4ZAo7/txQPD7HL4I/Cd
         Z3RA==
X-Forwarded-Encrypted: i=1; AFNElJ+k+F0TzWMHoCXEAKjDo1jfFNLkdtxEfveXESBLaqDtgyLO7sLsOPdLZIgduVSUY1zfy6D2QrSgzrv6@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9ZLa1P/1i+MywulIbG4hPLGSC0ZeUk5X0wPW9NmfG2CDSenE6
	bY8zy+n/nes+pG8Y+Xgy1Rpv4oeS9ZhySRMznNx10tHecd6/uLMGCGd3Mh5Is0OyBRd2vX5hKj+
	w+0q9lVZEr+c2ESc/mkCmR+aFxTwBwiI9yK1JLlcv4MbAQoz9ZOj4imblSEnhfSZY
X-Gm-Gg: AfdE7ckxPnGNu5PSqXwOugBBqMAPs7VkDhC/7UBgpjRfc8UktXyOTsAlQjWVs2UtV0b
	v8jd/j8ea6NGvPOBB0OlcyfhItOyNMB8jCK4ObjJ/OeIgKcKGkP+16920eOC19U25C9rJLUNmRC
	5CsXMM7FVgL1zkLg16BWVAyt8Joutduf//d4T6jIm/Wp2IxfZW2HMgVcIlZ00gviBV03VVmTInN
	Ny5tfTLwAHGk6qIaaPby0HGOY+OmQEvntvp2UTYaUh6IXe8miPsLL9dyjF/IgwFhaJDVEi8QsgO
	3Yoi/B3bvL1iSzkMlBs9O3ajfcfOZ48jsSKFpezS6HsM++Mu64iBPetWiUma9G6uf7emi5OqRho
	M9chZeHljSSJKv+hgLTVD+TiyXAbQe7ALUddC6vj3k4TiEMmRl/84aZcPGStJA8LrggU3JXj4f1
	gwm3XPNKu9IFJ+IVEwv1qxuQSR0w==
X-Received: by 2002:a05:620a:4456:b0:91f:27bd:ded3 with SMTP id af79cd13be357-92601f1b354mr617534985a.21.1782226350033;
        Tue, 23 Jun 2026 07:52:30 -0700 (PDT)
X-Received: by 2002:a05:620a:4456:b0:91f:27bd:ded3 with SMTP id af79cd13be357-92601f1b354mr617530885a.21.1782226349495;
        Tue, 23 Jun 2026 07:52:29 -0700 (PDT)
Received: from shalem (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c0c60aca46csm534042666b.36.2026.06.23.07.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 07:52:28 -0700 (PDT)
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
Subject: [RFC 01/12] ACPI: Introduce DT-ACPI hybrid mode
Date: Tue, 23 Jun 2026 16:52:14 +0200
Message-ID: <20260623145225.143218-2-johannes.goede@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDEyMiBTYWx0ZWRfX6mcMOnmitFMV
 AnJQMMP3pk8EKdwKvuEzjSsB+pTQNm7K148jFi13GQ39LXMkkyT18VxvkVa+FNrcqyDZIP34eKl
 gfwFDboISXJHrC/zyZNHP7tbVSbQj4I=
X-Proofpoint-ORIG-GUID: g3rrOthtvfbq9lGzttBfgRIcl0C8UMMI
X-Authority-Analysis: v=2.4 cv=HrxG3UTS c=1 sm=1 tr=0 ts=6a3a9dae cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8 a=SyvYybavyfcVUkjtgKkA:9
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDEyMiBTYWx0ZWRfX+fJHSr0R0cpl
 bVKx0qMJoCpMvFCV/q7ZRbmsXRgRJ24b4QRL6e8YUSM+d0CLQltXEMyJYZ3uB7Hnu1Z02ogGbYq
 8t5ryTyjXPidJwETaxERg+x19xbGZ6lKFqcxebqIQ0XURdHfvYGwdLJvgeaALKRmUA4eAopf7fd
 c97crLEz8odOnCz02fOoVbsJJxB6mGBec6XdqGKXiuEVK6hbCSnUjtE/EfySobZELANhz/aH/IJ
 t7blGXhEdqLtvNXUOX1+tz/tlx5Dx66gNIzatNRkPfR/w2WDjBA6b3aOKgN9J0WT6g30ZPeoSzH
 xxGfSKPFO+VEAgBE9zGEoB564bzbl47rllc9Wj/CgxUejKQdIOHN7v9JYeq3P0jG2Ma4Sfl1r19
 gEP+OX8gQ6EgyxGGJJvXpa7WnVL2t1MKOrfFMMTFUpyytAkX1INunFlWgLzPXhBFhjgdCb5eqAA
 NCP8/YZRUMrSZTLK16A==
X-Proofpoint-GUID: g3rrOthtvfbq9lGzttBfgRIcl0C8UMMI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 bulkscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230122

ATM on platforms which support DT or ACPI as firmware interfaces ACPI gets
fully disabled when DT is in use.

In some cases it is interesting to at least parse the ACPI tables and
possibly also use parts of them.

One specific example of this is Windows on Arm laptops with Qualcomm
Snapdragon processors where Windows boots using information from the ACPI
tables but Linux uses a device-tree description of the hardware instead.

Since Windows is the factory OS, these DT descriptions need to be created
by hand.

Having the ACPI tables available at runtime allows the kernel to use some
information from these ACPI tables while still using device-tree as its
main information source.

Having the tables available at runtime can also help with creating and
improving these DT descriptions.

This patch prepares for a new DT-ACPI hybrid mode controlled by a new
acpi_dt_hybrid flag. When enabled this makes the kernel booting in DT
mode still load and parse the ACPI tables, without taking any further
actions like creating devices.

In this case the ACPI subsys will still parse ACPI tables and populate
/sys/firmware/acpi and /sys/bus/acpi/devices.

Note this patch itself is a no-op, since all the arch/*/include/asm/acpi.h
files define the new acpi_dt_hybrid variable to 0. All the added extra
"if (acpi_disabled)" checks are in paths which already check for this
earlier in the code-path. The new checks only come into play when
acpi_dt_hybrid is set to 1.

Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
---
 arch/arm64/include/asm/acpi.h     | 1 +
 arch/loongarch/include/asm/acpi.h | 1 +
 arch/riscv/include/asm/acpi.h     | 3 ++-
 arch/x86/include/asm/acpi.h       | 1 +
 drivers/acpi/acpi_apd.c           | 3 +++
 drivers/acpi/acpi_memhotplug.c    | 3 +++
 drivers/acpi/acpi_processor.c     | 3 +++
 drivers/acpi/arm64/init.c         | 2 ++
 drivers/acpi/bus.c                | 6 +++---
 drivers/acpi/scan.c               | 4 ++++
 drivers/acpi/tables.c             | 4 ++--
 drivers/firmware/efi/efi-bgrt.c   | 2 +-
 12 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
index 8a54ca6ba602..3116bb872f47 100644
--- a/arch/arm64/include/asm/acpi.h
+++ b/arch/arm64/include/asm/acpi.h
@@ -76,6 +76,7 @@ typedef u64 phys_cpuid_t;
 #define PHYS_CPUID_INVALID INVALID_HWID
 
 #define acpi_strict 1	/* No out-of-spec workarounds on ARM64 */
+#define acpi_dt_hybrid 0	/* No DT-ACPI hybrid mode on ARM64 */
 extern int acpi_disabled;
 extern int acpi_noirq;
 extern int acpi_pci_disabled;
diff --git a/arch/loongarch/include/asm/acpi.h b/arch/loongarch/include/asm/acpi.h
index eda9d4d0a493..5f725bba6e87 100644
--- a/arch/loongarch/include/asm/acpi.h
+++ b/arch/loongarch/include/asm/acpi.h
@@ -12,6 +12,7 @@
 #include <asm/suspend.h>
 
 #ifdef CONFIG_ACPI
+#define acpi_dt_hybrid 0	/* No DT-ACPI hybrid mode on loongarch */
 extern int acpi_strict;
 extern int acpi_disabled;
 extern int acpi_pci_disabled;
diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.h
index 26ab37c171bc..b72586fe650e 100644
--- a/arch/riscv/include/asm/acpi.h
+++ b/arch/riscv/include/asm/acpi.h
@@ -22,7 +22,8 @@ typedef u64 phys_cpuid_t;
 void __iomem *acpi_os_ioremap(acpi_physical_address phys, acpi_size size);
 #define acpi_os_ioremap acpi_os_ioremap
 
-#define acpi_strict 1	/* No out-of-spec workarounds on RISC-V */
+#define acpi_strict 1		/* No out-of-spec workarounds on RISC-V */
+#define acpi_dt_hybrid 0	/* No DT-ACPI hybrid mode on RISC-V */
 extern int acpi_disabled;
 extern int acpi_noirq;
 extern int acpi_pci_disabled;
diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
index a03aa6f999d1..ae1d3d588c06 100644
--- a/arch/x86/include/asm/acpi.h
+++ b/arch/x86/include/asm/acpi.h
@@ -25,6 +25,7 @@
 #endif
 
 #ifdef CONFIG_ACPI
+#define acpi_dt_hybrid 0	/* No DT-ACPI hybrid mode on x86 */
 extern int acpi_lapic;
 extern int acpi_ioapic;
 extern int acpi_noirq;
diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
index bed0791c17fc..0f9e22046e0a 100644
--- a/drivers/acpi/acpi_apd.c
+++ b/drivers/acpi/acpi_apd.c
@@ -263,5 +263,8 @@ static struct acpi_scan_handler apd_handler = {
 
 void __init acpi_apd_init(void)
 {
+	if (acpi_disabled)
+		return;
+
 	acpi_scan_add_handler(&apd_handler);
 }
diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
index 1d7dfe4ee9a6..00469a4b8897 100644
--- a/drivers/acpi/acpi_memhotplug.c
+++ b/drivers/acpi/acpi_memhotplug.c
@@ -361,6 +361,9 @@ static struct acpi_scan_handler memory_device_handler = {
 
 void __init acpi_memory_hotplug_init(void)
 {
+	if (acpi_disabled)
+		return;
+
 	acpi_scan_add_handler(&memory_device_handler);
 }
 
diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 00775b91bd41..f4ddd5e126e3 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -785,6 +785,9 @@ bool acpi_duplicate_processor_id(int proc_id)
 
 void __init acpi_processor_init(void)
 {
+	if (acpi_disabled)
+		return;
+
 	acpi_processor_check_duplicates();
 	acpi_scan_add_handler_with_hotplug(&processor_handler, "processor");
 	acpi_scan_add_handler(&processor_container_handler);
diff --git a/drivers/acpi/arm64/init.c b/drivers/acpi/arm64/init.c
index 7a47d8095a7d..9826c0b35715 100644
--- a/drivers/acpi/arm64/init.c
+++ b/drivers/acpi/arm64/init.c
@@ -4,6 +4,8 @@
 
 void __init acpi_arch_init(void)
 {
+	if (acpi_disabled)
+		return;
 	if (IS_ENABLED(CONFIG_ACPI_AGDI))
 		acpi_agdi_init();
 	if (IS_ENABLED(CONFIG_ACPI_APMT))
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 2ec095e2009e..1d5ea66cb99e 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1290,7 +1290,7 @@ void __init acpi_early_init(void)
 {
 	acpi_status status;
 
-	if (acpi_disabled)
+	if (acpi_disabled && !acpi_dt_hybrid)
 		return;
 
 	pr_info("Core revision %08x\n", ACPI_CA_VERSION);
@@ -1361,7 +1361,7 @@ void __init acpi_subsystem_init(void)
 {
 	acpi_status status;
 
-	if (acpi_disabled)
+	if (acpi_disabled && !acpi_dt_hybrid)
 		return;
 
 	status = acpi_enable_subsystem(~ACPI_NO_ACPI_ENABLE);
@@ -1494,7 +1494,7 @@ static int __init acpi_init(void)
 {
 	int result;
 
-	if (acpi_disabled) {
+	if (acpi_disabled && !acpi_dt_hybrid) {
 		pr_info("Interpreter disabled.\n");
 		return -ENODEV;
 	}
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 530547cda8b2..4836286968e8 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2253,6 +2253,10 @@ static void acpi_default_enumeration(struct acpi_device *device)
 					     ACPI_RECONFIG_DEVICE_ADD, device);
 		return;
 	}
+
+	if (acpi_dt_hybrid)
+		return;
+
 	if (match_string(acpi_system_dev_ids, -1, acpi_device_hid(device)) >= 0) {
 		struct acpi_scan_system_dev *sd;
 
diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 4286e4af1092..6aec547c0872 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -247,7 +247,7 @@ int __init_or_acpilib acpi_table_parse_entries_array(
 	int count;
 	u32 instance = 0;
 
-	if (acpi_disabled)
+	if (acpi_disabled && !acpi_dt_hybrid)
 		return -ENODEV;
 
 	if (!id)
@@ -330,7 +330,7 @@ int __init acpi_table_parse(char *id, acpi_tbl_table_handler handler)
 {
 	struct acpi_table_header *table = NULL;
 
-	if (acpi_disabled)
+	if (acpi_disabled && !acpi_dt_hybrid)
 		return -ENODEV;
 
 	if (!id || !handler)
diff --git a/drivers/firmware/efi/efi-bgrt.c b/drivers/firmware/efi/efi-bgrt.c
index 1da451582812..dc69342cdb38 100644
--- a/drivers/firmware/efi/efi-bgrt.c
+++ b/drivers/firmware/efi/efi-bgrt.c
@@ -31,7 +31,7 @@ void __init efi_bgrt_init(struct acpi_table_header *table)
 	struct acpi_table_bgrt *bgrt = &bgrt_tab;
 	int mem_type;
 
-	if (acpi_disabled)
+	if (acpi_disabled && !acpi_dt_hybrid)
 		return;
 
 	if (!efi_enabled(EFI_MEMMAP) && !efi_enabled(EFI_PARAVIRT))
-- 
2.54.0

