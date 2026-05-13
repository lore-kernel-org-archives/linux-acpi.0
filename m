Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC443DBD55
	for <linux-acpi@vger.kernel.org>; Wed, 13 May 2026 08:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778661858; cv=none; b=FYP5ferBYEydsyK9RIUGeJLtwwA/5h+aX5cDjzzaXLnhmUybUayheRg+CO+jQxIR+hw03eFQyEclUEC5zwclj/T5vEBLAB25IH4kQDYZYQv7+Zk1G+HMqiUQFh+7Pk45A6HJChd71KuNfJxDGt8d7T2ZzthL/cpSGuaGf1oqI4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778661858; c=relaxed/simple;
	bh=wsh7T9Es8tm7G5+cVDm4V2UDNK5E6+Q1OUCLkFOrdYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eOmjcyEBKPpIAGloYZWTal16I3nlOWnPpfyG6Sy9iQxP1dDDQrUPiSTPriFAJLMvcH4wcEFl7NniwB4QV3NQSxXnsNJG62otIJv0f5X2R4rmp+GTtE8kZV1ARxMCgwpj4+IIcZ2JmRZU+QjDwAbnXsxSpwNpRTSpJU7s0Hz2Qg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ew1B5Uch; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kpIe/Oz6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ew1B5Uch";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kpIe/Oz6"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64D4p9aq3527643
	for <linux-acpi@vger.kernel.org>; Wed, 13 May 2026 08:44:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=V0HbiZ4P78p
	MMZLzC1v2KdG7nYX9gwkT4Ii7QaESwzY=; b=Ew1B5Uchu+VjkXeGWc9d3N/Pnp0
	nZzD6LFWdy1C5JumSy6HgxxxatVH7CrcEpiAr9tS75N2AIkHFhcuhJRYTQ8mgoyP
	k1wM/NjaJOAmnExQUkI3ZQALvNKL7NR6A92epgC9W1XZK9labvSiOzprUknX81XP
	UpnV7m3Y4Bttu2nKW79QfqCF4PFIRGybDVKuPRjTLw9qc4t2aI1vB8yBu89fjwzP
	fFdMdlBWmDobbsttc8VESNOP/+UnbmbEa23zIA9ufpAF+GWKY/+Ag75US69WBBTB
	h7+ga4OgAag/YdzmegpAqGLCjlOoUX3Xj2wXtuqPlacEWT0VTmuGmhuIz4g==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e44f340pu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Wed, 13 May 2026 08:44:12 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ba838d3fa4so72791405ad.3
        for <linux-acpi@vger.kernel.org>; Wed, 13 May 2026 01:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778661852; x=1779266652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V0HbiZ4P78pMMZLzC1v2KdG7nYX9gwkT4Ii7QaESwzY=;
        b=kpIe/Oz6ykWXUvJhNnyLvwjUHC4+XajEDczsanrbaCykuSR7nuBLUO7unfcbx7WOGn
         cFtuDbZHIy+nKqpH+rn/zAF+oVMR+nXw0wG1U6KUh6q6gJUVWpgrPN5PSwaRKaipupeI
         Pfh6L6IOyxIdqN9doA5oEPa2VRGfIUwp31ZRhX6+eTBsCHT46Pen2FPCPavNT+3dY4ed
         Vm/Hlxgtwyt8UslUpMUrwGLQ247tbRqapS7kc9pP6c5ZWebbm45xU9TZQ/AHAR3IK8Ma
         ve+vAbEeuPQ2kXZwe5igZCAolnbpc4+8BVgpWB5bRLirvRmt8u8xciuxZkJ+6q6Z3ALl
         DqwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778661852; x=1779266652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V0HbiZ4P78pMMZLzC1v2KdG7nYX9gwkT4Ii7QaESwzY=;
        b=m0Fr3Z0zHzhnfI0yaZ8IYjLW8jxwJhBASfJaHCR8KUyaCI4R+tuSBex6rbqn8SbmuZ
         WyDMTFbv+ANiMFXIYBb9NZ1ALOA+PRTqzaCx5j7/chnnFBU573TINj5TGVF+1wvgFIa7
         KzMrzY4mY/bi8+khGgLHDylM0CNpuSaLF/RdOn5w2976xGpbc6heQQkcI6M67n1Putw8
         lGMNUIUtpLJFCTfbOHCHnhFACFv/0hG6BZ6TbNCFY6W8FFipqYDr9/oIhw/tQfjaMuQz
         JG4akOAqr3WBZXG23O7dXPKiHpkDhH/kLT1ZfBaZ+NVGDOycBGn0oelsSaZdI9rgiL9p
         NjPg==
X-Forwarded-Encrypted: i=1; AFNElJ+uB1ZREzhh2S+2UxhT+wePgjW96Ttg5usT7/vuCv1FcRsrvkPd0mcuLWrvqOstqejwc75Ko89kiXcA@vger.kernel.org
X-Gm-Message-State: AOJu0YzB1XGAhS/3x+Nmcy9x/8WNNxTtL207K+7YRVZeU/WMlrNaCSQb
	0okzQGWom0os3jpKNaXd++RANMe47B7uohPvUFoS7t/VNwVI28FBolxq4GA1pKf20Up+nXnQ6S/
	ngoNL07Hdls7lOor8Gl+DY/OlVB+NToP3b1wN1YoEnE2/Z6zEsyKgECDxGAFz5rcS
X-Gm-Gg: Acq92OFMzDEy5e/47GMqfggSufyhpbBtCvmWiZo/x1ob0HOXNY3sv6VolgPC2Bj0HUS
	pjapv/NeTgMDy0ByP3WxGGVMl7HQ1s+gEZFEdYeLV4dSMkkx0W0iRZOqANtC4S21pRoMeYS00Rl
	1xT79FPNMKjmr5OKJGMVlx5fKYu/eAqtCcZrf/vwjmmjCfqsN0Sey5fMiauE0xPw3167CYaEMz0
	6fkrQgAODyKHGSKAcgKAY03jn6lv2Q0+ituzQXmVxmThLIoE3jLRw6VzWyNIBWUaZYzE9wzlVbS
	yCPAAfUM5OkSzlvuzOsavIHNCOayKAVx9asO4k43364JPZCAXRfOadRPH3v2py66FCTFuDvzKs1
	4QGoRHWeF/APCl7bsp5IWTvC1C5ph/X2NkDr2iWkLEBghCUYjlMxC7gQq/Q+IXtiPb11OxbO2Tz
	YjmoRIvczLXDlaTDX62zE5JHj+49aol1wwaHdR5I1CF1ylIA==
X-Received: by 2002:a17:903:11c3:b0:2b0:608d:d8a8 with SMTP id d9443c01a7336-2bd2f4cb703mr20265455ad.1.1778661851548;
        Wed, 13 May 2026 01:44:11 -0700 (PDT)
X-Received: by 2002:a17:903:11c3:b0:2b0:608d:d8a8 with SMTP id d9443c01a7336-2bd2f4cb703mr20264915ad.1.1778661851092;
        Wed, 13 May 2026 01:44:11 -0700 (PDT)
Received: from hu-himchau-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d2709bsm169158725ad.5.2026.05.13.01.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 01:44:10 -0700 (PDT)
From: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-efi@vger.kernel.org,
        acpica-devel@lists.linux.dev, paul.walmsley@sifive.com,
        palmer@dabbelt.com, lenb@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, ardb@kernel.org, conor@kernel.org,
        cleger@rivosinc.com, robert.moore@intel.com, sunilvl@oss.qualcomm.com,
        anup.patel@oss.qualcomm.com
Cc: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Subject: [PATCH v4 05/10] riscv: conditionally compile GHES NMI spool function
Date: Wed, 13 May 2026 14:13:20 +0530
Message-ID: <20260513084325.2176952-6-himanshu.chauhan@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: MAIOZm8KlbmTvUSlF5i9oVNn0jLqCbHD
X-Authority-Analysis: v=2.4 cv=SpSgLvO0 c=1 sm=1 tr=0 ts=6a0439dc cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=-FlRX8pefk0TmyAjS3oA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDA4OSBTYWx0ZWRfX6q41UzZl4sAr
 CylmgGU1ct4taTVfhe0RR+vtEOBMjGM8YwKrWu1SsJVRJz/6KljEponcR68Ogm0MJx5QJUzixHH
 nq5BWUL691Yt0KgCaTKoD7Z0uUyuT2TGXc2aCHJwdAjOcmNmavvZTjn8iXUGRcivG6YQG4xFdMz
 hBRXfqgrQLwGKLxy0zhApxbKJlrkCtNvDwYTeax4heGZm6G7t9tqxDP4dDJHgt7osKt/PqzZD9t
 PyAwL5jwTN4s8Jjbk/MdU2uhzEbPnJVA4cpCGfWdc+RME7oKmNOdBIWgqiV/WOnzpvmBiUprH4M
 pCS/Yy0hUyAE1h7rcamXHBe/OArnS4SP0p0uz071YlhUksDeZFV3yRxQ1ZwqKNOFQJuwWT2308+
 IkaLmOmPd0XLj86z0W9fYhRSx1/fST+jV6IcPSLm4ArqyWGU43lZaTnRtCBoSAyGaRXN2caW5W6
 DTbldjUVnDCrs6bnDcg==
X-Proofpoint-GUID: MAIOZm8KlbmTvUSlF5i9oVNn0jLqCbHD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 suspectscore=0 impostorscore=0 bulkscore=0
 spamscore=0 phishscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130089

Compile ghes_in_nmi_spool_from_list only when NMI and SEA
is enabled. Otherwise compilation fails with "defined but
not used" error.

Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
---
 drivers/acpi/apei/ghes.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 3236a3ce79d6..8edc2c8db1bb 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -1397,6 +1397,7 @@ static int ghes_in_nmi_queue_one_entry(struct ghes *ghes,
 	return rc;
 }
 
+#if defined(CONFIG_HAVE_ACPI_APEI_NMI) || defined(CONFIG_ACPI_APEI_SEA)
 static int ghes_in_nmi_spool_from_list(struct list_head *rcu_list,
 				       enum fixed_addresses fixmap_idx)
 {
@@ -1415,6 +1416,7 @@ static int ghes_in_nmi_spool_from_list(struct list_head *rcu_list,
 
 	return ret;
 }
+#endif
 
 /**
  * ghes_has_active_errors - Check if there are active errors in error sources
-- 
2.43.0

