Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10B53D1718
	for <linux-acpi@vger.kernel.org>; Tue, 23 Jun 2026 14:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782226367; cv=none; b=nESaK3HmxL86JawWnA6JZe+HE+UR70nOWv2snaDVe/B3mPrqJvisQtnoRagPG2nbW/VzNq44kbadGiA35DwSsaFbOIsanxJGAyiY750UXALfNgb2oT3Rjn7wFBR2Fo8eSfo7eoXEylR+7/s1b+ojQlVdK9AKBeSWkxBdKwoUP7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782226367; c=relaxed/simple;
	bh=w1Tg1h1Bgp5ctFJGKs+G8GxFeRFgC+541niNc4ABUxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VrDDphCl3vg6jt5IhvKxSjXFNidw0VqTM5dFG1LDTQBkqDf9g3WW1nYGGk8Jy71Q9IdNfejPn8vZf57duikjebpowphRMrGeWFo1ZqUw8p3NzGv3hqx45/320exJxcB5jr1yJ8v5GQpM8I5QDUNvcZNCqBB4YMquFXx1BcqWP0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mDG5jzQn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bjgtUzN7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mDG5jzQn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bjgtUzN7"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NBYco9113297
	for <linux-acpi@vger.kernel.org>; Tue, 23 Jun 2026 14:52:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=dXE06i8HxmQ
	Ol06JW6DpL6opd4+mAGICEb5DJaAD4dg=; b=mDG5jzQnapvPqXFTkgcr6HlUups
	W0uACFOPLpgBanmxEKmsM6mrC3TiW3v0ld1UgzvFr4cbXFQbCW/8+N1vdX77QSNr
	MEUsQ+y5vGawwrVExZ/Cd5uOWxCN+irjUIArWnipkBsp00Pse7GSQxERFeBaBwJh
	en+ikyPDgUgQadE+R9pyNJN37KYBRBQUE4k5dwgltx2KZXeiBqUdVaCQUwNCXJ8f
	ixFIrC5zfd867mE7q6BIQYJ44ILCGZtjTJZ+RUnbsUJ+PtwZTjMY8DQX4VwViHKH
	PAET6Q15VRujH/vWVMeimUeJ+hDfsVc/tWmsNON4DzLGaMuDi5O2dXMYd7g==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eymnvt39j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Tue, 23 Jun 2026 14:52:44 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-6cfd2a26ab0so2609701137.2
        for <linux-acpi@vger.kernel.org>; Tue, 23 Jun 2026 07:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782226364; x=1782831164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dXE06i8HxmQOl06JW6DpL6opd4+mAGICEb5DJaAD4dg=;
        b=bjgtUzN7M2iM7cwjH8snYqBkRhgqJAvMCKVIufWahNCQleBNGwOCDsXMYpKRVp2APv
         QoBdMv5F74BIPBuX3cl/7qYOAE0Pg8mJ6Thlx3T8sAJwoNUsWBZkNV6RpLOykUeVyNeb
         gJPFSbgkmLne8DC4PT/kM1aMOTmb8DL3kK3n0rccmMSXi7lAgRsJBfEKZCSGkN38Xzqd
         hxtGewwBZbqxWvPGM86shN7LzpQAKwY6Velh01cL82j6Ox49hwRuo2jhl+qk/YXhfjfU
         PS9bNcZzeUBAJcDxYOokJYH94W4cjvkUljeGTMCCg/mZ0r5hlF/COqmvU/UUVjgljjIw
         gVDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782226364; x=1782831164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dXE06i8HxmQOl06JW6DpL6opd4+mAGICEb5DJaAD4dg=;
        b=RuFHnIwWAJ1FpZMK4g7HDGY4WNVGcLy4nvCBx9yZcixkOp3k2RWDbemiFwD+spp9ze
         MOEC/k2gojxsFbIVxVmnJv5twWK41f65sfKKznYEgKUyLwFSDtJnR2l8CJSNxjRgHYfh
         Op/DbmvqP4V9jUS2vkyKB8xwx4rZYgFqVSy52zNZ8WZkGkNQ4ICuhFG50MfJfnO83V4J
         w1MbOwKLmHqoG3kpiHaSs1Y7cN70e5BC0uZtu5FLWzs7uKhuf+IwshFrrdvF6wE5xJ9N
         Z2zDQongAPeJe5RmxMjKRWV9tFBqONAUmTzkDCgfREbqayEb5iVlHJ2DN4z8W7Al8MkU
         wgAg==
X-Forwarded-Encrypted: i=1; AFNElJ809fpG2BTY6hs+Y6Cp975xsOrV8cCQnhdER7Yh+fYj38Jv7J3fiEdyuRZlCO+IjeO37ydXsEwieB23@vger.kernel.org
X-Gm-Message-State: AOJu0YzHfj7gp3DFwyMfs4M5+O21aLq+a9VeTOWNcGE1SUbZbpeCW8+F
	6QBRgczYnPjrMAUuuMJMYucYWoFx+EkHpbznIKIdsyt5ucMGXeJrF698Lj8NowAzhrgdQ7V9ilW
	12ljOui3KwOBKb09Ph2ZtERctHTDEW2ISCtMyrVOkH+lkPyx8CTshBa0ojhvMIFu8
X-Gm-Gg: AfdE7cnPjfT+I7JAP7vJkAPhdEfMJY5EHdmpm/nMxa+sC1Jh5QP0n5cX37yNwZKvI60
	udRpj9Qmy+nTkfg3FgneqT9CJeSj+YqlRkw7hRd6w6F1xUPKPiScbBmeTvntCxlOpVeKHMsIo6u
	4gFNT2ZVNxkwOz1pjWHIqUQpN+9pv1AH57ME8ou/IBSASdU70h3a198lrsgNRopfdyc+vXFz8oF
	Rn9DQS+t9dVTeWb07A48HWdPnuboYO6+qAi/wYmeS438vqC7hfD7B6NL1Af936edlfVdLtaSDvp
	AbK+c8hGR7xcDGmL2egA5I9NH8LDkn68eYF1uS93IjUD3ZlDOqSlM/wbzwWqPWmjMJ4EMGyWo69
	xGVBUBJmG2QUD8TMfcWSz16P1yBefn0MGsXrg7e35Shm1Vw+VJ4eq8h7cczmMQ/iMhPbWx/X7ku
	hcULTtTBKhHTxEVvgCbTd6KosuAQ==
X-Received: by 2002:a05:6102:2928:b0:6ef:db57:ed3f with SMTP id ada2fe7eead31-72ff73a4640mr1396820137.29.1782226364222;
        Tue, 23 Jun 2026 07:52:44 -0700 (PDT)
X-Received: by 2002:a05:6102:2928:b0:6ef:db57:ed3f with SMTP id ada2fe7eead31-72ff73a4640mr1396795137.29.1782226363700;
        Tue, 23 Jun 2026 07:52:43 -0700 (PDT)
Received: from shalem (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c0c60aca46csm534042666b.36.2026.06.23.07.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 07:52:42 -0700 (PDT)
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
Subject: [RFC 08/12] irqchip/gic-v3: Always call acpi_set_irq_model()
Date: Tue, 23 Jun 2026 16:52:21 +0200
Message-ID: <20260623145225.143218-9-johannes.goede@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=dOWWXuZb c=1 sm=1 tr=0 ts=6a3a9dbc cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8 a=L1rKWosBgnsSvNafh98A:9
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDEyMiBTYWx0ZWRfX8XHd/pLU3a+Y
 0Vv3OmmVhlsOPoBtp5xZ1UMXjDEKHxVgECJP/4faZlnCUNe8e3FB1HQMZsJ6xyRyzWZ3JgKksss
 AWannSNhm/VuT10IZAPztRZPNLpIAfs=
X-Proofpoint-ORIG-GUID: lddu2GsgMHoQcwyIxR_qoknfJpZe-17m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDEyMiBTYWx0ZWRfXyBkCbW3PnPG6
 d8K7VEe87FT+xruAf2Pkd4i6rSaZX2kZezpG7TW8Vu4BWh0gD4XTjh1qzMXYNAcJjWwYblM1P78
 /f1NuLNwCn0hmXEN+piw98eRSfAxH+nlnLavi3QvJwP7xQGdshX8fSMvg/OA4pvllg3gyQJ9WXj
 B8y7sPjR/akmmteJmB5+3xISwnv95Hj6MGKxyi5zNuEkA0QYPfz7tn2ZFhl17UhJUECKixLYwFr
 vjheOADeoodaNXz/OlqSHK+J/Yq+lQONb16aihzNdd1QvcpTMp8W0xSRDgZ5HubTaCY3CfjP+jM
 MVPerQ21H+4dLL7PeBz48HVHHZ5uMqC/Rk3mpYu4TGJiujIy0S1VWOENK18R0RkLSnviNQd8/0f
 Tsbb8TKq8kvHm/Wa1UqYjDpMQ/mZCjlWzFwnyHKOO+Vg1DfGKnbUE/iErue0H/31SdYqGE92ZNw
 L4Qa3WH5fdEpT2s1McQ==
X-Proofpoint-GUID: lddu2GsgMHoQcwyIxR_qoknfJpZe-17m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 bulkscore=0 clxscore=1015 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230122

The gic-v3 code used to only call acpi_set_irq_model() when the GIC is
enumerated through ACPI.

This causes problems for DT-ACPI hybrid mode, where the GIC might be
described in DT but then a driver using info from the ACPI tables might
call acpi_dev_get_irqresource(), which results in a NULL pointer deref
when acpi_set_irq_model() has not been called.

Always call acpi_set_irq_model() when CONFIG_ACPI is enabled to fix this.

Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
---
 drivers/irqchip/irq-gic-v3.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 99444a1b2ffa..2ccd04689a04 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1974,6 +1974,23 @@ static void gic_enable_nmi_support(void)
 		gic_chip.flags |= IRQCHIP_SUPPORTS_NMI;
 }
 
+#ifdef CONFIG_ACPI
+static struct fwnode_handle *gsi_domain_handle;
+
+static struct fwnode_handle *gic_v3_get_gsi_domain_id(u32 gsi)
+{
+	return gsi_domain_handle;
+}
+
+static void gic_set_acpi_irq_model(struct fwnode_handle *handle)
+{
+	gsi_domain_handle = handle;
+	acpi_set_irq_model(ACPI_IRQ_MODEL_GIC, gic_v3_get_gsi_domain_id);
+}
+#else
+static void gic_set_acpi_irq_model(struct fwnode_handle *handle) { }
+#endif
+
 static int __init gic_init_bases(phys_addr_t dist_phys_base,
 				 void __iomem *dist_base,
 				 struct redist_region *rdist_regs,
@@ -2063,6 +2080,9 @@ static int __init gic_init_bases(phys_addr_t dist_phys_base,
 			gicv2m_init(handle, gic_data.domain);
 	}
 
+	/* Also do this when enumerated through DT for DT-ACPI hybrid mode */
+	gic_set_acpi_irq_model(handle);
+
 	return 0;
 
 out_free:
@@ -2534,13 +2554,6 @@ static void __init gic_acpi_setup_kvm_info(void)
 	vgic_set_kvm_info(&gic_v3_kvm_info);
 }
 
-static struct fwnode_handle *gsi_domain_handle;
-
-static struct fwnode_handle *gic_v3_get_gsi_domain_id(u32 gsi)
-{
-	return gsi_domain_handle;
-}
-
 static int __init
 gic_acpi_init(union acpi_subtable_headers *header, const unsigned long end)
 {
@@ -2588,8 +2601,6 @@ gic_acpi_init(union acpi_subtable_headers *header, const unsigned long end)
 	if (err)
 		goto out_fwhandle_free;
 
-	acpi_set_irq_model(ACPI_IRQ_MODEL_GIC, gic_v3_get_gsi_domain_id);
-
 	if (static_branch_likely(&supports_deactivate_key))
 		gic_acpi_setup_kvm_info();
 
-- 
2.54.0

