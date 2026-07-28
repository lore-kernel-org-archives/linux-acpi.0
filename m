Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119D44477EF
	for <linux-acpi@vger.kernel.org>; Tue, 28 Jul 2026 14:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785247656; cv=none; b=U2AjTYDHxnrFW5oL0Qalw7Kl2hWlpik+rdhDn0Ei3oyUDltAsG5SeZsNw2O28sj/Lqlx4GJIA/pNXpl5pLncMJZhE+Dc0Bc/u2uk4ja4U4tYUxL9qdAouvU8e+F0e5SwXxVSsitYLQu0C4IqPOsZDkFjx9cPxBhLq4p3hTBifdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785247656; c=relaxed/simple;
	bh=X9iWrt01a0N1nePUzdckSKX+wCmzxqLgNdh/jIQjCXY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=S9lCc2/rsD4SZ5zhOBrgwwoowfHjO5HrZ0KTXxzNC7iz3fsefT+SejefvKH4yqkgClezk8Q6axSMMRt6eu7PWoFQ1NRVJdvXNaSMYbaDHsqj7HqcLR3K8G1NB8FJ4sGCbeqUmF5mqPn63z9SnoehnoQifyN+kI8wNBbYBRxIXiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MXt5Cj+z; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=T3xWee2H; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MXt5Cj+z";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="T3xWee2H"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66SDOjYt2881298
	for <linux-acpi@vger.kernel.org>; Tue, 28 Jul 2026 14:07:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=c5fc7ww9/HSIAlazJaxeZx
	fMvt8Px9TwkVtADywhlKI=; b=MXt5Cj+z6FZRE+LpyaUzwfxitW/j0LjVYyxKs4
	DDqMKo1zwSgiH50T2yVEfn4SGoIHMoxjITNCxiREmOyy/UcARh7500fpbF5Wa1/H
	4pBb1LLK9zY0BIHYT3Z+XRWMgqGSv0kF0deFZhKITBkBXbmgCdJGIxKM8e5yAyE8
	/3AtAgTA/r7TVldQlIFwpWmPvr/sxpNT2oh6g1UYW27kK5WOrxq2AAWgaIdkMtp5
	BPDA0VzebnbQ3g+rubBepsc6Udx7UKGjo4nE8eBv/iiRBpLN7GBOSenAbM2nm5Sm
	k5E4MoMis0lq7S2URTUmY+7RMOUuMQa2nYbueyOkqlTmuLdA==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpuyg8k5w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Tue, 28 Jul 2026 14:07:33 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-963d7c11611so457524241.0
        for <linux-acpi@vger.kernel.org>; Tue, 28 Jul 2026 07:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785247653; x=1785852453; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=c5fc7ww9/HSIAlazJaxeZxfMvt8Px9TwkVtADywhlKI=;
        b=T3xWee2HGwJEz46sy80Uj84sh34XNvUtKU3Bfbtmu1hDGm7JzisFe5fz5GVLgNB5pq
         huwqNsj2NDIm9b71x1waQHMdlg1u9bAnpgXDoa43QgfVsrkRZb0RQszbVfcX1gy8FEVb
         QmuExTuI0ZmRxarL57Zih924mi1Z01ulsXjQ11fcVLoTpfIaPEmEz5pU4QtZHaoF1pX8
         HFcTitr3XHdwHoQ+jqIVmXQogoJ3EfTBL9AVMKUhJuFIsHeKN/5VHqFNuHI9VC7KYz4G
         nMSf2xPN2YudyInQYG+mGiBItlPxf9dsfEiPWeJBi1uVERv1GzOcE3Zhqfu3haJwF6C1
         75JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785247653; x=1785852453;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=c5fc7ww9/HSIAlazJaxeZxfMvt8Px9TwkVtADywhlKI=;
        b=BOvdAbaNyaPsihHNglKsqr+37VQVmuxRgJMh6Dxv/V5sq2m+vZfN6DeM5+yGQ9qQPI
         2F7TNrxMv55A71H0l0328t2Us2YzE4wDdeNEZHtNQJg+HSB47L6KbwpwMmr1cIT0EsXi
         Zy8JEgBBpljynlpX1sIIyWx0h65XJ5pGBe+mH33OgVn1LM0AY78VzXsLMPsqRGZM7R3C
         rldagMbWjZJuM6M+PPZuldkAQBcLWfnamYsx7snCwrlo7eCYRZ679DRhME4tu/ANY1oA
         t6VboyG1e9vPLJCf/kVtMx2NbeqX3w3eMTVx2vPDxAtgQU/FcmyFqIii3yfFiZev/UUC
         rytA==
X-Forwarded-Encrypted: i=1; AHgh+RrrOBjnMXiDf/UO4iLSUk/p3PbtzI6PobXTMT9DuG6wTOBo/gi8gLqZttqfajz3l1BHwhNLgazfymKY@vger.kernel.org
X-Gm-Message-State: AOJu0YzzjJv0TFPXuuHrDAb7wKESXSphMLWbAYVw4C0e/oCbi6e1oBx2
	eaW3QP2z5YAGaGjR7b799rAKNWsZNqYtM7fTifJ/eR4XyZZbljivBEJ5bhlZllg/LFPvwBQX2Sg
	aDow3/TECyR7M3VKtjedRyt1ua83REjzv43mCIuih5/+UGJ6XTaLkSq9Ncs/2oMR4
X-Gm-Gg: AR+sD10dglfGtgbflB3ysBMVz5lmsthhqn+wXplvMOrNC1K87ZAsyXGfru/zu8FTr2J
	ZRwXQv2p72gL2HolsG2iaGu8EAFwlAK+RfpaLFm8JhBpb2Dc8+M23ovcTSmvxM4ZJjj1TBuGx/W
	hODnXiVp5MVmKRqv1unzL3RlTTb9OPb91gHALFY4xM6IQZAgAbZYs+5Inz+mNZFIyfwEv0HlNfI
	iAC/w9PX5PZXa9xWkXYWyikuk7NCnvooLSS9L6E7b8IwGHcbzPdFkmIkpGu3ul3AEzv59onT6zE
	DbMkjEEvCuvPOf5/KYm4MsKFhh/PjwNmtQKcf1I4+HFzhnKJDaG40fDzOJMpZdhDm3PVqJr2nIH
	8Om5d+cYsx43nZ3eWHC1ofz/5YzyAmQ==
X-Received: by 2002:a05:6122:1690:b0:5bf:b500:c4f4 with SMTP id 71dfb90a1353d-5c33f87ed39mr1032837e0c.2.1785247653257;
        Tue, 28 Jul 2026 07:07:33 -0700 (PDT)
X-Received: by 2002:a05:6122:1690:b0:5bf:b500:c4f4 with SMTP id 71dfb90a1353d-5c33f87ed39mr1032759e0c.2.1785247652689;
        Tue, 28 Jul 2026 07:07:32 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:d2e3:b407:476e:c977])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496c44a9451sm91612285e9.1.2026.07.28.07.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 07:07:31 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH 0/2] ACPI: arm64: use platform_device_set_fwnode()
Date: Tue, 28 Jul 2026 16:07:15 +0200
Message-Id: <20260728-acpi-arm64-pdev-set-fwnode-v1-0-b5aff9b2235a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJS3aGoC/x3MSwqAIBAA0KvErBvQoR9dJVqIjjWLTDQqiO6et
 Hyb90DmJJxhrB5IfEqWPRTougK7mrAwiisGUtSpngY0NgqatHUNRscnZj7QX2F3jNq1ylNjWqs
 JShATe7n/fJrf9wN6ipR6bAAAAA==
X-Change-ID: 20260728-acpi-arm64-pdev-set-fwnode-1d50f24a5c12
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: brgl@kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1068;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=X9iWrt01a0N1nePUzdckSKX+wCmzxqLgNdh/jIQjCXY=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqaLecgpRoz1EVR/xySHZvL4LJ8+fldkg2iAUqX
 g/9ZYu95TqJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCami3nAAKCRAFnS7L/zaE
 wweXEACiogBZUO0KpBOSfIVdcyTPkEdhiBpe49Zv7WSZD8fXBpUd2iQe2gmYKXNBg5WLgmeY8lz
 hPf49ne0+GnnWfQX9efdQipHEGxL+RHRsilxP2eKijGNWDOs/55mm3F1PHzC626krpgbc/cw/7D
 daEiOJX1RKDBQu1P4BYNkhN5OwPgryUTJo65GY66RTSMENj/tBPEZeZRUpLubEEComzsc+BFJ7m
 dknDTi5kdBsB99ujnsiLXHTBGDUeMmeGQvmswGrl4AnEeYpHawsIbkckVwtOu90ucw00bNbyxoL
 zkw5KPH5RGjxVDOK9ibZEVm1gUIlWVYft8ejf+LxEC1lJu+eA8tdPEFKtVY9YsRFdmQy1L5sbog
 3UhYfJSCYhPHdYmewR1x5JeN26g3DK25JcQeJK0/Bgy24jNZmQgKiPFx/n/82G0U4xaDwY5ASTq
 HvZ+V5jbZghkXhGMg3EBgQ/ZmCaiK1Ik1+B0fdhva90uavQZgiVbUPdA8Mj49SLIykrfIfUs45j
 MZoaEVlUCIMaS8c8VT7YizUI+unlgGeYd4Z67thOw7xtI7Wt67HcCy91KBs+wP5X5ViPRk+syxW
 ZDRYo16U90LTnX/H03lVUmiM2KfJb2zwpJhEinSoVHLE2E9Et9A1t0tsup4zEULduLCf9pFnqmx
 c8gD0HVkcR+BWfA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: z3UyYZiFuRd8PpX1ZtmvHzgr9qBGmRI6
X-Proofpoint-ORIG-GUID: z3UyYZiFuRd8PpX1ZtmvHzgr9qBGmRI6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDEyNSBTYWx0ZWRfX9/8r7N6N0EzL
 BVzRj7tRFdGecAmKI828kjHYMetrE+jxh6xC8190h8eBv1OGcDYITzeNgQScKQQJCOQO++gUseI
 vy92JrD30eVjqt7Q3WUcbJdhjNCDnyWiQYlZymw9s17MTRpUSIFEtDAUyWm0/t0y86gx4eTsZ33
 Sp+gyrNH0jErFVBCjYcSKFxQQ3FdCTEVnktz42W1OqrpWINwfu7LJuxBrT2ctip6NZZ4779Acv2
 VhszX2WH9SBq4Nou4lGjBgL8Tq3DxPftU5aOM4WeuqR2mk3mAJSuc486II8pHtFyLck3qw1rtOM
 fr+NMX4OgszPc6st7T2Kpz5yRIwiznZQcQ2HwNkc5o6KUBZFvxeft7YfVPaLHvIwGZXXuR9/x+4
 ef9+zqzmcHU/5bUef0CzdHcounn6a3Bk6X7UEzZ6yDCvtPofwGuOWLmcYQ7pkO0y5j0kWjxKqUX
 v4GVHfqyBGP1sYWhTJQ==
X-Authority-Analysis: v=2.4 cv=aoWCzyZV c=1 sm=1 tr=0 ts=6a68b7a5 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=js6g1tapueaBODJy6MUA:9 a=QEXdDO2ut3YA:10 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDEyNSBTYWx0ZWRfX3la6HCYq+uen
 IDNHgeY5kmSMr8+lyvCUEBUs0nGa5MnUDV3zye1vFNHbhj7L/x2TXPRjjkbpCAR+t7fm7lCN3wr
 bsgIGfXgLxVI8DlO5v4IQdee05LV05M=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_03,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 spamscore=0 bulkscore=0
 adultscore=0 malwarescore=0 impostorscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280125

Note: This must go through the driver core tree where the prerequisite
commit 8877c06885ce ("driver core: platform: provide
platform_device_set_fwnode()") lives before the upcoming merge window!

A series of recent changes in platform device code provided the
platform_device_set_fwnode() helper but later changes converted all its
users to different APIs. The function however should be used whenever a
dynamically allocated platform device gets a firmware node assigned so
use it in two such cases in ACPI arm64 drivers.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
Bartosz Golaszewski (2):
      ACPI/APMT: use platform_device_set_fwnode()
      ACPI/IORT: use platform_device_set_fwnode()

 drivers/acpi/arm64/apmt.c | 2 +-
 drivers/acpi/arm64/iort.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
---
base-commit: 0d33d21e47d9dc66f91e44da3fc9220c74d93df7
change-id: 20260728-acpi-arm64-pdev-set-fwnode-1d50f24a5c12

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

