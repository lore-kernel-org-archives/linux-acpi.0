Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD273EB7FF
	for <linux-acpi@vger.kernel.org>; Thu, 19 Mar 2026 16:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773936680; cv=none; b=NMvy18wYIF++kD/XbR0gffBdYiB8Sqc7gX8PPcxOgvnAsJKXhVo0YYYsIlQt9HVHo8LkxZev7Gd3drqiWEWM35vFqbPte9feSf7SxAYqdJEP9bmgl0BC244RkTtUvMBF8utz3+uL9AKBJh2rKyrtJXixF+MN86jTfzG5sDyiD4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773936680; c=relaxed/simple;
	bh=I67SAyES6GkHk6EVmG3C77aUXjElzOIeuDKZj/y0SCw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kfTlwzM7gE/zu41nq6xOPQf+HlHla2qlvtF7Vd9zk0H7N+VHKfTLHYRW6YWGWKBcpL28xkvOBs4keniTixymXWF5VFKtv57Av6EdmJPI/5T0lR/DKfqDotZFoTV/G+N5Tk5i0K4bSSLHjvrpgX3cH/pVqfjZqZhBaUKDzpkefkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ae5QsglD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=duiKaGc2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ae5QsglD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="duiKaGc2"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62JF2ruC3370000
	for <linux-acpi@vger.kernel.org>; Thu, 19 Mar 2026 16:11:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2Q2GuadJ1cZYo7UfUMdzhOmnFdwm/5ltCsFBL4t2bdA=; b=ae5QsglDralovOmD
	W5BRrJob800EW4J5Bt5TPADNJHwm8d2oyEvwFqJxsT9PUob2yE0sKM9XBR9pwVgr
	IfBWroO0UjmT9RkVroOoXZh4CUeHNYycPWa1dFhld3gKgp/a9UYOlRan2duw+sQx
	qW+ITL3H+6bMORwRf6H36U54tJGyW8TqfGjxZzTidAP6ffk+K71pRicZfDl+WsZr
	9rEINrGjWTKYVVLilGUDZ+7G9/kQOscZskXHGvqg7AwFh+iaJRfLQDPwgp+A86KB
	OGVfWyaCuYBlyfa1HIWa2LdKXCZrKKVdbD63RhUoOFEfv84AwN6e17mKuWksiocj
	TYULhQ==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d00f9kvt7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Thu, 19 Mar 2026 16:11:16 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-6028957144bso1669193137.2
        for <linux-acpi@vger.kernel.org>; Thu, 19 Mar 2026 09:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773936676; x=1774541476; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Q2GuadJ1cZYo7UfUMdzhOmnFdwm/5ltCsFBL4t2bdA=;
        b=duiKaGc2jqJKJsguBVKGerzYGwgpe0IbfJK8UwyjnpBifwaBJVGv9WwhfND3XMwI9G
         47WYThcUtU1111sbCSXXL8vVGE6/xvayPOTR6w4Fn+FHMMbcKQmuuFeQ3p50hL0sQ2wY
         MFLjpErHTIbmXnbGibg2ayF5RFmH36+Iz/JfCK+CeI55pdNTZiYEjvC99YYqpFdx+h7Z
         mrnNELN1l9A5ykNvc+1ZDVbFsJQAYbyfjC42tUCqAStA+Stc67OoMZXNa2DTYY1Vdi/z
         ZIu0PUri/Cwj0u7JCSCsUbupk61tE7TGFC+88lFL2CgFI8lktcc4RLo97lz7JViM93Do
         7Hdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773936676; x=1774541476;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2Q2GuadJ1cZYo7UfUMdzhOmnFdwm/5ltCsFBL4t2bdA=;
        b=kIZsyR8wpH7lZsPPYi8XWAjXQU0qkwMWRHUHh+sXi8IQ7/MT6rXSgYLBJWVV2bq9iY
         Nc0sVTZH2rDA+rKjv/Oel4QFuTDPN6FfwYbXOKe57+c8DoA4dVaLDyTPwbrVPkC4Whhx
         zHucrk1cYN1iuw+08yY4QVzDlSisUIG4a/lSKecE6Vww8DrGWU+74QlYgrs3lBtnhCkD
         kEAssVw/X8HhZDLQ7ey53IZdeX1tZ+y34nlvjuGUbmgkVFxlZ8zL+X8pRK2epsH1o0gv
         gGrpd6gquZOvFPVMNvdmXqvUGnBSgCQg0MHbMlwW7d+I+/H/cKT5LC9NuAe3OojIuHFm
         PfNA==
X-Gm-Message-State: AOJu0YxVNOps1kDWxlIFiL+HzYHG7bteEwVpzBWPjYQhCIdhUu58k4VG
	M/5kmuR9bDMswmB7mkGM8TZ2XIcXBVQudoMd+WXHotyH5/SPToWbmT6fYDQAppOKrfubMlvgHFC
	s+3w+esYlayBTgnUIOKycs4n5LouPe+xK66ZnKC0CHZST2wcEKmzOd2v5/n/nkeET
X-Gm-Gg: ATEYQzypt9RIkCuzB1Ja3kHdQ0D7nxeL/bPCwDHgJ1y72+v0EuYHCsofBQNPr5uWu4b
	laXl25V1dJ2EzYZAVnBoV0yZ5DejSWpT2KGQTsN4ucOMlZHDHCCJLcJVKb6MQiS+B1xwYSKwz+T
	agfpzR6GudGzjfX+h6nYWmEIeYar3zKlBmhK1MXc9ZxMAAhiTkX6qE1zlU++hzVnNUbz3hsLnLv
	wY/JGwCe9khPPeOfBFNsTBy05y1x71vQa2PdqkZxIqAtax0Msv9aoyFdXJyL7djJRwKT6+nC54S
	qewIqKrhbxwA2M5vumGHBsOiN8MtYxgEHOgFlgv1BJQdt7w3vIspvfPx+Cx2eGN8TP9Xw5roZ/H
	OlcWKSAgHTnFu7wHXiTX+UTMhgwBbKBj/I4+PhsPwWHugsGA1X2kb
X-Received: by 2002:a05:6102:578c:b0:5f9:3aaf:fa27 with SMTP id ada2fe7eead31-602aeac9366mr64392137.6.1773936675912;
        Thu, 19 Mar 2026 09:11:15 -0700 (PDT)
X-Received: by 2002:a05:6102:578c:b0:5f9:3aaf:fa27 with SMTP id ada2fe7eead31-602aeac9366mr64347137.6.1773936675430;
        Thu, 19 Mar 2026 09:11:15 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:9d74:8015:408c:d719])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f4e5495csm83756915e9.2.2026.03.19.09.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 09:11:14 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 19 Mar 2026 17:10:56 +0100
Subject: [PATCH 3/4] pinctrl: intel: expose software nodes for cherryiew
 GPIO devices
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-baytrail-real-swnode-v1-3-75f2264ae49f@oss.qualcomm.com>
References: <20260319-baytrail-real-swnode-v1-0-75f2264ae49f@oss.qualcomm.com>
In-Reply-To: <20260319-baytrail-real-swnode-v1-0-75f2264ae49f@oss.qualcomm.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Hans de Goede <hansg@kernel.org>,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-acpi@vger.kernel.org, driver-core@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3561;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=I67SAyES6GkHk6EVmG3C77aUXjElzOIeuDKZj/y0SCw=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpvCAXEnJzDyeXAAVMRIOFLd0zwqHan4F1WlNDA
 lZleC9Bf/OJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCabwgFwAKCRAFnS7L/zaE
 w7rKD/9ebc0m2OnjoRJCvYcI3h+8uUAgw8SmyXwbhEMtyuB22rwIi+20Uvm2hQC81KqwRrOLzFl
 nOhDRzRajq9qFORRtv4ZfkqGx5Rpushh9f4Rs766oexYU92ifOlerWTAjmVlrrCes3mR4qRHvoH
 JA9pz2ihldbfUK4rpJELslC3DWsnQOPc1ePChrZmjpxHmQqvkAsifhrRpAWZFoQx/v+H8ALtPr8
 I6nb6gg6gCADVrjIAOn1IUlH5BWubBZQvq5WoDtRlVRfAxGNcRXumvhWIKYUNL0Vtl5O0pS2G/W
 ZvBLUY2VkUuVjeoCNXVED2wUcfQx+ujYK+RCZ8NGVdvdkcyF7moB+Bc63mlvBoccTlMuWC/lmUY
 mv52A8XCMB3WBibL3H20AznahHrp7uiIeTL3u/bSJ04+lABriXB1B9tGDQyGbRfsnq3hHHRcEDw
 R4dl/iwlA6RUWMp6TDdgUQJJsqQfELHD/zfn7RMGiPHoMGznoxUkz/TmuA/W9L0SsFBZuk8S8eT
 aKQa63Tp+J4WCZFZnP5QdQI9nPvacHN3xJ4Apgf1/Y15kCVx8eo+wzR8P4zw/jVOrIc7jdf8K+w
 wSUR9ikK6ednoWiCSEAZzmSVkIDceM3m1Vtd/NK7QRfTvt9AYbtDWJaewQjMwLFPs8xgnylW9dW
 rG2r49dLtIW8VEQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDEyOSBTYWx0ZWRfX15wnGngRHkxY
 uNrXnju3/fPR6XpimEcN4P0dm6aMifyJb9f4xKiuS/wFoq084cToJW7WYSzwO/4kBQCTEn3BFJu
 NxcgpCfKSq/f8gFKsFL7I+Gg1TmCzWWjCxVVYP82xpHf/8SIX6Ho/kv/bsd/p6eUF/ycAtg4ySm
 j5ZFnm3Bza6PRZF6mTsHAe34Mo1o9v+vcLIH3/evQhazlBjgJK0IGGymF9MAIfIOG77aVkWx5PP
 I8CYXl1002E9tC9FhPDHMDcd1VNz3Cr/pCM7LXFwAQZ0TYVfMcVTMrmCRnBFvnfaKCFdMoHxd0W
 bu/EH7goaC53XZh9BmvzyaNqQntRuQya9W4oODRMxflWmEzTH6R8PXLYweVEYWSlOfqcKXgYtdT
 Ehjzm1qNrhD04unvRyYNfawqckA997kIxlIsOaU46wt3VMKpMBrl84c8wrNxohyZDIdtLDouUQr
 5WK2jFPNOJqw0vlQYMw==
X-Proofpoint-GUID: ahkTWAc9S8j-aP_rGx8Rl0wIlwtTlD-W
X-Proofpoint-ORIG-GUID: ahkTWAc9S8j-aP_rGx8Rl0wIlwtTlD-W
X-Authority-Analysis: v=2.4 cv=MJttWcZl c=1 sm=1 tr=0 ts=69bc2024 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=nG9bRbd_0SKyiAKh2pMA:9 a=QEXdDO2ut3YA:10 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_02,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 malwarescore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603190129

Use the new automatic secondary fwnode API to ensure that when the
cherryview pinctrl device is added to the platform bus, the static
software node provided for drivers not able to use ACPI will get
automatically assigned as the secondary fwnode of the primary ACPI node.

Update the existing intel.h header with new symbols.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/pinctrl/intel/pinctrl-cherryview.c | 47 +++++++++++++++++++++++++++++-
 include/linux/pinctrl/intel.h              |  5 ++++
 2 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/intel/pinctrl-cherryview.c b/drivers/pinctrl/intel/pinctrl-cherryview.c
index a33eca5eafc44ee3337c4665967682404cb6ece0..45e52a796c8201c844127dbab497b4b3002930dc 100644
--- a/drivers/pinctrl/intel/pinctrl-cherryview.c
+++ b/drivers/pinctrl/intel/pinctrl-cherryview.c
@@ -21,6 +21,7 @@
 #include <linux/types.h>
 
 #include <linux/pinctrl/consumer.h>
+#include <linux/pinctrl/intel.h>
 #include <linux/pinctrl/pinconf-generic.h>
 #include <linux/pinctrl/pinconf.h>
 #include <linux/pinctrl/pinctrl.h>
@@ -1769,15 +1770,59 @@ static struct platform_driver chv_pinctrl_driver = {
 	},
 };
 
+const struct software_node cherryview_gpio_node_00 = {
+	.name = "INT33FF:00",
+};
+EXPORT_SYMBOL_NS_GPL(cherryview_gpio_node_00, "PINCTRL_INTEL");
+
+const struct software_node cherryview_gpio_node_01 = {
+	.name = "INT33FF:01",
+};
+EXPORT_SYMBOL_NS_GPL(cherryview_gpio_node_01, "PINCTRL_INTEL");
+
+const struct software_node cherryview_gpio_node_02 = {
+	.name = "INT33FF:02",
+};
+EXPORT_SYMBOL_NS_GPL(cherryview_gpio_node_02, "PINCTRL_INTEL");
+
+const struct software_node cherryview_gpio_node_03 = {
+	.name = "INT33FF:03",
+};
+EXPORT_SYMBOL_NS_GPL(cherryview_gpio_node_03, "PINCTRL_INTEL");
+
+static const struct software_node *chv_gpio_node_group[] = {
+	&cherryview_gpio_node_00,
+	&cherryview_gpio_node_01,
+	&cherryview_gpio_node_02,
+	&cherryview_gpio_node_03,
+	NULL
+};
+
+static struct software_node_auto_secondary chv_auto_secondary = {
+	.node_group = chv_gpio_node_group,
+	.bus = &platform_bus_type,
+};
+
 static int __init chv_pinctrl_init(void)
 {
-	return platform_driver_register(&chv_pinctrl_driver);
+	int ret;
+
+	ret = software_node_register_auto_secondary(&chv_auto_secondary);
+	if (ret)
+		return ret;
+
+	ret = platform_driver_register(&chv_pinctrl_driver);
+	if (ret)
+		software_node_unregister_auto_secondary(&chv_auto_secondary);
+
+	return ret;
 }
 subsys_initcall(chv_pinctrl_init);
 
 static void __exit chv_pinctrl_exit(void)
 {
 	platform_driver_unregister(&chv_pinctrl_driver);
+	software_node_unregister_auto_secondary(&chv_auto_secondary);
 }
 module_exit(chv_pinctrl_exit);
 
diff --git a/include/linux/pinctrl/intel.h b/include/linux/pinctrl/intel.h
index d45f090adc1f532f866c98aeca144a4d83fa28f4..bd3e6ee8b15ebc492275a14ae6d53827b701f783 100644
--- a/include/linux/pinctrl/intel.h
+++ b/include/linux/pinctrl/intel.h
@@ -9,4 +9,9 @@ extern const struct software_node baytrail_gpio_node_00;
 extern const struct software_node baytrail_gpio_node_01;
 extern const struct software_node baytrail_gpio_node_02;
 
+extern const struct software_node cherryview_gpio_node_00;
+extern const struct software_node cherryview_gpio_node_01;
+extern const struct software_node cherryview_gpio_node_02;
+extern const struct software_node cherryview_gpio_node_03;
+
 #endif /* __LINUX_PINCTRL_INTEL_H */

-- 
2.47.3

