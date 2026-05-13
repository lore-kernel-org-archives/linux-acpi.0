Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68BF3DD861
	for <linux-acpi@vger.kernel.org>; Wed, 13 May 2026 08:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778661881; cv=none; b=PX/pldfxrG2LGAhCWMD80WqlOwRidNGEDxm1Rf1eMy6gcT9lfYPqnW6Rl50ClpGKRl3x5Gev8xQhEVRQEz7rf/E/ZDa/Ir4u2X13X2lCCTcvebqqMLFNz9icrErTv381I4WbWYGtmr/AyaABjV9u94WY0GeOpH1dan120gmzQOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778661881; c=relaxed/simple;
	bh=x20EfRadjM6gyYzz8ZMp33hiN2k9tRrW3Dio918LssE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Aigz/GtKBsIR/22Hu2jG6Vlg3DfenjEyMsILbmetLcCG2lYXygfUaAeejg/imoLTyLKo4sixgQBOwNPiZ28PINuQxfuvjWEsAPLblAakpvFwDSHPuJyuy5txdNybyD9JV623tTo6J+X9FvKr7vFFVdOJCPTsPPVhT4TRDn4Rc4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iVz425xm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JfptrReL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iVz425xm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JfptrReL"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64D4pCJv2321270
	for <linux-acpi@vger.kernel.org>; Wed, 13 May 2026 08:44:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=zmAbegcUREx
	UMu9LBa5XbR8BKHL2qZB12gzd9RXImJ0=; b=iVz425xm8NrnarAFsAX5H+HUYOk
	UupNDRM0cum8UeBq+sX4nbv6ktka9JpEftA+rUacYqi1jirP8l1ku/xlW47Z/SmQ
	gBg6/yreQLGjB/YhRmi3TDQ9+BDohxcLaw7Lp4WHKRPiS8gAYSyB2DfEWcbXXNzX
	ZGoxnZZVb240KftcGC9Za+JzSgFh+2tAY7ZlTs9Bu199r/EX7K3yGQfQEt/zNmaH
	f7FKO8Qeisg4eu5QEIoUHSaDwHHgxaq2dhKFA24DAqnIQQBq5FbGmh8umsTneYvu
	cN0DiryRjmRxMnumLqySOn021o/3lSjwwH60BeVLTnsEmOIIdJm67l57apQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4hgu93d6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Wed, 13 May 2026 08:44:39 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2bc860066a6so30896165ad.0
        for <linux-acpi@vger.kernel.org>; Wed, 13 May 2026 01:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778661879; x=1779266679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zmAbegcURExUMu9LBa5XbR8BKHL2qZB12gzd9RXImJ0=;
        b=JfptrReLG7w74m43Xj0a6Jbhm3i1UO6dnDoNi+olaSYdrJHtKfpYKQ6g7vdIueN0LD
         6QcTc6HALuYpBy5d8JXJuEXdb5GKWajil/QFY2FD9kDeihYJarjRs/kbeAcqjd0O4HYr
         pRhTQ5i6EqQmbrvEj6oP5LIrLpeec/GAT3J70v2LgSPUabTr81vC/Gg9zJvFqeuv8MYd
         MHPkV0UsfcU6Xgeaia4TTmyPy7EP6IPv9Xb4s1yWD8NeZvRZX+bz7YARKWEBkv39Mzwn
         C1GPvUclRtZRvg3yIZmhIOg/v6zD+RBDqsE6FiM8IhKAnalXCwtMw4mHbH5nZesKAfjc
         8v2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778661879; x=1779266679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zmAbegcURExUMu9LBa5XbR8BKHL2qZB12gzd9RXImJ0=;
        b=TkgOjknSrZyhULg7lz9ujClce1XagT13nbKpHC4H9Yspjmh0RW3m5UG+P4HsGDc/xi
         HNO29iIexyYWBsJ+OhKokrRzARCu9Ak0OHdX/MB+pa2eOKppc+flJDuKzW5qCMv4BAnz
         08pEfhraK+cUNQGWyKPtqPcY+KKpvQULSOpJFiC8JfQNfp98OHm9uANdqTY6nPPQBg79
         VRxbfUMV2sAaV2W4dufCleSlUAWntzaw4/nh7lZwLYxKzrks7IGqNPDkiXegRLuCSXj+
         gdcWTut3yslEjFQWndN/6JGQxcBhIqwYy765K8adUqQ5fJJIPefOD695IZQJPa7ZfD/7
         vDjw==
X-Forwarded-Encrypted: i=1; AFNElJ98/cBbWgq8axUiVLnAO3YTtoCSPseN6td2KQAqh7lgyWgzAws9NacBuiToNp76AkxTC4jGVHNP3Qz6@vger.kernel.org
X-Gm-Message-State: AOJu0YwqSu4JDZzBVCRV8jNO1vbuOFkzP+J9GhDNe/ANPjF+wnwKtCBS
	9JXh6vZBffh7eyV/2JyQHj7fEsGOf3ifz3R9b+NkNCi+5TmRMIGF4rZd8U5soBkzsHZ/fBbje+n
	tG//cQNWmLDFiU8IEgDsoZXu0TkzQ4M/7p4sIew5GvoBYh7ehxL41+GRcQHk8JxMe
X-Gm-Gg: Acq92OFQzoBJV0UGw+NByqXPe+RFzOIu5wacBkeN+EFltgRR+6Ho8fr10CUh/7fieB6
	/mhSy85NVa89HDqr7i2xWy2ZTBv9tQUEXW2Zl3ygtxjDBp0yHQVNZx+Hhdts9gDQXVL1J62wEu/
	3k+kLg9YHnn1R/0WyUtMpu06f7Y1/e2UJa9dIJ9KgCPV5c13Z9iqokw6JgZMGsDedRkFPW5NLSj
	TT+0du5aYRUxFNz6u4wRdZh2JyL1oZ4b90voeEg2fCE/Gn3Y8Im4thoIPrQrGx+H+Ce9mP8NaV8
	TIrKwsGDLFTI18n4zDqa0floHV8Vf3mE0RCNhVQDJhb3hgyMflIeEzG1gGTKOvkWCGtD2eyd+uJ
	NwdyXANf59rVjrN7nDZdOvepgCDra7oNvcG2oWePhvAM8KeyH4aLLgSIRLdkRgDzHCwzWhEV8LM
	ZNNeyMx/p/5Kn8DjUfbkDn1pBWjJHF7OJ/wYsLemYH/jJYAw==
X-Received: by 2002:a17:903:907:b0:2b0:5ae9:ee4 with SMTP id d9443c01a7336-2bd2713c355mr27371455ad.5.1778661878573;
        Wed, 13 May 2026 01:44:38 -0700 (PDT)
X-Received: by 2002:a17:903:907:b0:2b0:5ae9:ee4 with SMTP id d9443c01a7336-2bd2713c355mr27371015ad.5.1778661877861;
        Wed, 13 May 2026 01:44:37 -0700 (PDT)
Received: from hu-himchau-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d2709bsm169158725ad.5.2026.05.13.01.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 01:44:37 -0700 (PDT)
From: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-efi@vger.kernel.org,
        acpica-devel@lists.linux.dev, paul.walmsley@sifive.com,
        palmer@dabbelt.com, lenb@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, ardb@kernel.org, conor@kernel.org,
        cleger@rivosinc.com, robert.moore@intel.com, sunilvl@oss.qualcomm.com,
        anup.patel@oss.qualcomm.com
Cc: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Subject: [PATCH v4 10/10] riscv: Enable APEI GHES driver in defconfig
Date: Wed, 13 May 2026 14:13:25 +0530
Message-ID: <20260513084325.2176952-11-himanshu.chauhan@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=X4di7mTe c=1 sm=1 tr=0 ts=6a0439f7 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=xUlk1AThICIXWUt23vsA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: 16gpzPpw_Qb_5vVWIReq_OExP2kyPD73
X-Proofpoint-ORIG-GUID: 16gpzPpw_Qb_5vVWIReq_OExP2kyPD73
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDA4OSBTYWx0ZWRfX7OcP7EPP2WrN
 X/kyZ6ObpipoKHGYC/BTcGyXo4ujC+c9ivE/c+WZjT4Au5ELYYyehx1o0bDVpwan/RDPEUR/aYO
 pcpCMoateaJr/hzxTt8t5MkDvTLrdra3n1324zJSCKq7PSXo5kOKzSuDfdEmDqcL6hCawZSR/Ll
 LHsvXyA/88MJFYnrd9oq2WvvsaCDb6i8yAsyVVVXM4F3Np4TWM074i1l+0oS0PA1mAa9LaEaF/F
 u/v0u9HoFlOOayLn3pglOYv7jGUU2PnZQd7R1SANWRM4KVTXRU7dF9amBxx7D5ZIppNtH4gdeLB
 Q2zE4O13UO4TrHTK3HwMN4q/E/ffLLkrGIuU+uANGr00uc4+sExKXDnMGBpV0FZDj/yC0AARZxw
 EiYgc4RjHWo2gq39sOURYLhD7uo3vFPMusRyJQCLY+h+tf2H2FavmfsQsfoY0bvz8QeQmcH+9qj
 L+4ACXlEjK3JIfPIRhQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605130089

The APEI GHES driver is very important for error handling on ACPI
based platforms so enable it in defconfig.

Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
---
 arch/riscv/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index c2c37327b987..eb0c45405cd4 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -46,6 +46,9 @@ CONFIG_ACPI_CPPC_CPUFREQ=m
 CONFIG_VIRTUALIZATION=y
 CONFIG_KVM=m
 CONFIG_ACPI=y
+CONFIG_ACPI_APEI=y
+CONFIG_ACPI_APEI_GHES=y
+CONFIG_ACPI_APEI_ERST_DEBUG=y
 CONFIG_JUMP_LABEL=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
-- 
2.43.0

