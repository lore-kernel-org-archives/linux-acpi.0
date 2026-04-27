Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DFA3B4EAA
	for <linux-acpi@vger.kernel.org>; Mon, 27 Apr 2026 10:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777286821; cv=none; b=rH5o222w629D/BAmsN1/t3J7uInk/eYB66yqxJBoTYacDFv+bLanTYFU3tM+0vxSBrit6rvc+XjELOaEVM6PRHcvPszWBvwqN8OLTdps0SGgrNjaUjNjWzQ92wrcoecvgdaWHo6t9FgqZEiSOjUYxx+iDv8vwi1fdB99qMcQ08c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777286821; c=relaxed/simple;
	bh=bzdvpv3oXCtAm3pD+12sDLx1Xj/eF5XT07wIxOiRgEU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XB39pmH0przotnyzSUclp31SddCymmkCaMv9PbPwj4to7/UTDeIjCjLfWv1aLpjA4laN7sG49o6gNvcjDai0LQKFGGT5MeSuhYx+WK8XAlTJLpvVaW2hgJ+cOI2e8jniZ3Rmx1T97akdPLENHBFSgQOC+BcfJhs4Sh1NTpobwtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ObMX86bP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bO0bWUiK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ObMX86bP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bO0bWUiK"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63R8TGXL665743
	for <linux-acpi@vger.kernel.org>; Mon, 27 Apr 2026 10:46:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yMBhjJ4gM4j7t6ItG9Ak3kejPO8aRcxBWs0HcVt7qno=; b=ObMX86bP460I3rov
	h/HnTRn/J888NwsUFC7X30KH9RWzLkpfQlIvbFDg8E0/S6OL8yJVGVlICY3E3WCQ
	ahs96rT9rWMOdKBOYYz2Mo/bVcjLveADkGe8M2EzCmR3AsXmh0968Q9jlJh9SCtM
	te7fq1Ld4VVx99aZ9IQZd6YBON67cHKCpb4ggttqcSslMkF6o2ltGNmmFGpPSqps
	2l1+70eXTloPdYwsaTJE9gTkd/ix4bzX41OtUIRUXtMl48aSa0TjLyAUL3gzX4Ew
	rKUH3eQhVr6zDzX6H4F5ANDPOd4WL/jMKgZ1ySQe9grYwcpug1wmXhuiz0H/xdlt
	+13mvQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dt30n10jh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Mon, 27 Apr 2026 10:46:58 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50fb3c7b989so112138541cf.0
        for <linux-acpi@vger.kernel.org>; Mon, 27 Apr 2026 03:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777286818; x=1777891618; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yMBhjJ4gM4j7t6ItG9Ak3kejPO8aRcxBWs0HcVt7qno=;
        b=bO0bWUiK+yo10miCGi7xLzYx5YOsFbsTLQXb8SPlnpp6jb1cfC0dMVs+xv+UtUOWiB
         S/E/jBawqg2KrxcLdt+D6W6LVn4tOD+riQUgNwNNosrmBE4YZW+heeCLRhU9YOeLcMsp
         9mpfrd5Wmb4zE5ofD/5XRb39ltaZ3UwCfTjyaoZLHDvgOIRpZWGpzkggpMupEcV3CGOK
         eIFgR3ho/Va0ywrF+N6IYH0HNbWdflhboqfYY3glIVdonLeiB0znsmByaIbcWsWid5DN
         rxsFfjwSPrulvH6cILaVOYewURwJnqN9N0fyzS52NmRg4NSVayKvDdfwE4S548VmKFd/
         KROA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777286818; x=1777891618;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yMBhjJ4gM4j7t6ItG9Ak3kejPO8aRcxBWs0HcVt7qno=;
        b=bJhb7U34vM700Vj+wZzhaYJNScI6MmFANc4IQ9zE7u3eYuUENCz3mH6pDUCzDO5ypW
         AJh3EJ/R4DVhOnzkVov+rim4JK7RPORCn/PYK1mR2GCZdiqRfvni8X94pZ3WuHb7D7ei
         5o2ZfO25/KuD0vwaNaUZqvZd+PletyiK9ohYgI/MMYt8S+PChOdKNvJgYaMpliSF8Tg7
         3KS7sc/LqEvd89Og4wBTXS7SLnFejes5GjXDRQJtR1b694KZ3mCpQPA0g3KVWQT1PFzJ
         v5+BCCGc02VF3SWUJu6XnSVbWqgSkBMf2TlXJqeiprwp78LcnADYUHG/ia9s/o+71I3b
         IeIQ==
X-Forwarded-Encrypted: i=1; AFNElJ93yedQ/6YVTh4z9jzGViQJOCHDGafbG5DTqC/BHMDbVXwToLNo/ibu3d0I6cmG31jRf3Ewiwz7Qa38@vger.kernel.org
X-Gm-Message-State: AOJu0YxBLXcPtn/kbar3dASLcmY8b7iPUBQRfPs4d5CpW6IE9mFP2589
	jb+Xtufu+wt/Ih4dXBsDoMpKJrjXjOptcsN3f17/GKeZ/2eFcljBfFQOISGhkUf1idXQqGjisP9
	2B66vqCCacxrpOGLmhg6FMbXzxwrIjOjawdCvZ4pUxfA4V63wFSUT9kOZ6wkS8pa5
X-Gm-Gg: AeBDietBgdCilS5h0d70vnJDa6yPNXq+Im6iARFjz4Z4dM/vSSuMmr5GY/uUAASbpa0
	FIQJyGEFjAfHKtzIJ7G5SIPiVGztSRH+BYtqA6Oh03l4UA5AjaGgamUI2Cg/2WPe2bVnn+6VSjb
	d1ac4cYIZf90YkdHj5bLsjfuzBJ7Act+keAQMVm8ikdR8ztEi1TOEUidG84a5uGokQ0q3ulHFKc
	QZgGy8bxgqycmFQ7B/IlhQksrhRI7VUTBBs5Y18P8aW4hrTni1/8ldsip6jvS9rYX6rlTULEVqE
	Mp0BgvBREQ+HNRDlEDjk4Yfqgfe4TkwGpSZ+Wqx3fhmGhEE480YBbCTAKeVZVyEDh5cpu8OT0k3
	pcRLRhSiVB+fnb7rmxMqZNISz/6oblLyTnAOQZvvWd7kCJoBRb0JGqq+7Bxbl5g==
X-Received: by 2002:a05:622a:58c7:b0:50b:577c:e259 with SMTP id d75a77b69052e-50e36c1277emr560394201cf.35.1777286817584;
        Mon, 27 Apr 2026 03:46:57 -0700 (PDT)
X-Received: by 2002:a05:622a:58c7:b0:50b:577c:e259 with SMTP id d75a77b69052e-50e36c1277emr560393961cf.35.1777286817174;
        Mon, 27 Apr 2026 03:46:57 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:5062:ae86:23aa:702c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cc2cacsm80353681f8f.13.2026.04.27.03.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 03:46:56 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 27 Apr 2026 12:46:33 +0200
Subject: [PATCH v6 2/3] ARM: omap1: use platform_device_register_full() for
 GPIO devices on OMAP 16xx
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-nokia770-gpio-swnodes-v6-2-b693296c1985@oss.qualcomm.com>
References: <20260427-nokia770-gpio-swnodes-v6-0-b693296c1985@oss.qualcomm.com>
In-Reply-To: <20260427-nokia770-gpio-swnodes-v6-0-b693296c1985@oss.qualcomm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>, Arnd Bergmann <arnd@arndb.de>
Cc: brgl@kernel.org, driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5830;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=bzdvpv3oXCtAm3pD+12sDLx1Xj/eF5XT07wIxOiRgEU=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBp7z6XnHxXLbQ5/CCsvyIBlDuIW5n7WWWzycWjr
 PSV19KUtheJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCae8+lwAKCRAFnS7L/zaE
 w4bKEACPiNJFn33zMYyRDA+LIFkjWo/O3e5YsekS5di2eUt0NBw3FxcR3usc1yz7G01/ZatGQEu
 2FOZSg1BRM8iSqTOE6uTWrlZVs7TC5jGMP3wYXr8KHMWxlaKga+eg0IJ9VUUcbfeWA6yrgzSuUe
 rEa5XgQi7Rf5QTpkthcejRuIOojoyIidI3FQMOnJh28Ct5i1tYdRr7fE886KoSwCb/Xc1LDD0O0
 SS3HNHyy42KAhSkTwDwQ8qhKSDvxgoRGTmqUf777NbXOvEUkT3mTduQtw843Z7btOJnfWuLBigE
 b3UXDdl4w7xShIYRq7b9Sv2AtTaOaPljLiWoksKb+qR9izqZyP5FFE9zn3jBu8lphIs3fUn1PuM
 H0S5KvamU5V0frfEoMpsh/0KOeSrPy3U3R8KPMNJDUudj2oknT34c6hk8lDOA1K/UybEAysFyWh
 CMj35cUgryxQMKejE2Fg02nvQBzI5m1fINDI8cq9WlyUua2W9j7601/izTeG899K2FnCT1z9eq/
 1sz3Sks0eJDxpkWHNGECwZqn1pkyZp4F1JVkScDXZtxvgY5hq+HgJxU/3YbFNw3voCCnOxg1a3s
 nouMp8PRNA2P91t7qnuSUG2MShXLZWvp2pJtQlsAf2jqmvneSXcpQMBKS/y+h96NEXsp3cYPLSC
 jSvinHE1dlM0cyQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDExNCBTYWx0ZWRfX5chA39YkKTS4
 Zup8VJhMg1jdnBNC/uFveXHrzj8d7HIfiOrvZqfRWjFSiE4c8TPppeU8K+9MXgPptUMR+anlypj
 N6JEy6Ha7u5unRHthalSrrQjt2q/+iW3wr9OynWK0r/I7pFxTN/4INwB3CtZI8Iyiqx/SN8vbI5
 p8qCGtQg7jOb9Zlz2T3dL2dBwKjiJzhurwgLDY5JkCX5PnWoqYlNE79el+9tRI4bgpMuFxzBHf7
 VnPqiMq5YX0PkoFJs4yZgjQATU+qy0PBeWC7HfLD2Dfp1uE1RPtbPlDfrbl4W2g3Uah0nVshA4H
 U/XlQD8ywceJaGH+bUI1+9lXgme+UmKPUlV19baWgfFilMoc73ZtP2n7rTXn02uCF454T6ICPQV
 Fji/u6FkpQfQ9POIvGiKO2bPhU+GGtemhphT4FYvzfK3bWL4ie3dXw2xJccbjlG+lOt+ysiAwl3
 rNIiChXTp8BZMhzDN+Q==
X-Proofpoint-GUID: G_-_bBRGq7_0oDyRaJOljK9N7JU36V6h
X-Authority-Analysis: v=2.4 cv=efANubEH c=1 sm=1 tr=0 ts=69ef3ea2 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=Ng6QAm6ffPCIYYv3ADMA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: G_-_bBRGq7_0oDyRaJOljK9N7JU36V6h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 spamscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604270114

Ahead of changes attaching GPIO controller's software nodes referenced
from the Nokia 770 board files to their target devices, switch the
method for registering the platform devices to the
platform_device_register_full() variant. This is done to leverage the
new swnode field of struct platform_device_info which automate the
software node's registration and assignment.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 arch/arm/mach-omap1/gpio16xx.c | 68 ++++++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 36 deletions(-)

diff --git a/arch/arm/mach-omap1/gpio16xx.c b/arch/arm/mach-omap1/gpio16xx.c
index e8dbe173bd33fae72c7c884f930a530f78096839..2904ce38c001505d48d0996f7053369bbf683209 100644
--- a/arch/arm/mach-omap1/gpio16xx.c
+++ b/arch/arm/mach-omap1/gpio16xx.c
@@ -55,14 +55,13 @@ static struct omap_gpio_platform_data omap16xx_mpu_gpio_config = {
 	.regs                   = &omap16xx_mpuio_regs,
 };
 
-static struct platform_device omap16xx_mpu_gpio = {
+static const struct platform_device_info omap16xx_mpu_gpio = {
 	.name           = "omap_gpio",
 	.id             = 0,
-	.dev            = {
-		.platform_data = &omap16xx_mpu_gpio_config,
-	},
-	.num_resources = ARRAY_SIZE(omap16xx_mpu_gpio_resources),
-	.resource = omap16xx_mpu_gpio_resources,
+	.data           = &omap16xx_mpu_gpio_config,
+	.size_data      = sizeof(omap16xx_mpu_gpio_config),
+	.num_res        = ARRAY_SIZE(omap16xx_mpu_gpio_resources),
+	.res            = omap16xx_mpu_gpio_resources,
 };
 
 /* gpio1 */
@@ -99,14 +98,13 @@ static struct omap_gpio_platform_data omap16xx_gpio1_config = {
 	.regs                   = &omap16xx_gpio_regs,
 };
 
-static struct platform_device omap16xx_gpio1 = {
+static const struct platform_device_info omap16xx_gpio1 = {
 	.name           = "omap_gpio",
 	.id             = 1,
-	.dev            = {
-		.platform_data = &omap16xx_gpio1_config,
-	},
-	.num_resources = ARRAY_SIZE(omap16xx_gpio1_resources),
-	.resource = omap16xx_gpio1_resources,
+	.data           = &omap16xx_gpio1_config,
+	.size_data      = sizeof(omap16xx_gpio1_config),
+	.num_res        = ARRAY_SIZE(omap16xx_gpio1_resources),
+	.res            = omap16xx_gpio1_resources,
 };
 
 /* gpio2 */
@@ -127,14 +125,13 @@ static struct omap_gpio_platform_data omap16xx_gpio2_config = {
 	.regs                   = &omap16xx_gpio_regs,
 };
 
-static struct platform_device omap16xx_gpio2 = {
+static const struct platform_device_info omap16xx_gpio2 = {
 	.name           = "omap_gpio",
 	.id             = 2,
-	.dev            = {
-		.platform_data = &omap16xx_gpio2_config,
-	},
-	.num_resources = ARRAY_SIZE(omap16xx_gpio2_resources),
-	.resource = omap16xx_gpio2_resources,
+	.data           = &omap16xx_gpio2_config,
+	.size_data      = sizeof(omap16xx_gpio2_config),
+	.num_res        = ARRAY_SIZE(omap16xx_gpio2_resources),
+	.res            = omap16xx_gpio2_resources,
 };
 
 /* gpio3 */
@@ -155,14 +152,13 @@ static struct omap_gpio_platform_data omap16xx_gpio3_config = {
 	.regs                   = &omap16xx_gpio_regs,
 };
 
-static struct platform_device omap16xx_gpio3 = {
+static const struct platform_device_info omap16xx_gpio3 = {
 	.name           = "omap_gpio",
 	.id             = 3,
-	.dev            = {
-		.platform_data = &omap16xx_gpio3_config,
-	},
-	.num_resources = ARRAY_SIZE(omap16xx_gpio3_resources),
-	.resource = omap16xx_gpio3_resources,
+	.data           = &omap16xx_gpio3_config,
+	.size_data      = sizeof(omap16xx_gpio3_config),
+	.num_res        = ARRAY_SIZE(omap16xx_gpio3_resources),
+	.res            = omap16xx_gpio3_resources,
 };
 
 /* gpio4 */
@@ -183,17 +179,16 @@ static struct omap_gpio_platform_data omap16xx_gpio4_config = {
 	.regs                   = &omap16xx_gpio_regs,
 };
 
-static struct platform_device omap16xx_gpio4 = {
+static const struct platform_device_info omap16xx_gpio4 = {
 	.name           = "omap_gpio",
 	.id             = 4,
-	.dev            = {
-		.platform_data = &omap16xx_gpio4_config,
-	},
-	.num_resources = ARRAY_SIZE(omap16xx_gpio4_resources),
-	.resource = omap16xx_gpio4_resources,
+	.data           = &omap16xx_gpio4_config,
+	.size_data      = sizeof(omap16xx_gpio4_config),
+	.num_res        = ARRAY_SIZE(omap16xx_gpio4_resources),
+	.res            = omap16xx_gpio4_resources,
 };
 
-static struct platform_device *omap16xx_gpio_dev[] __initdata = {
+static const struct platform_device_info *omap16xx_gpio_dev[] __initconst = {
 	&omap16xx_mpu_gpio,
 	&omap16xx_gpio1,
 	&omap16xx_gpio2,
@@ -210,8 +205,9 @@ static int __init omap16xx_gpio_init(void)
 {
 	int i;
 	void __iomem *base;
-	struct resource *res;
+	const struct resource *res;
 	struct platform_device *pdev;
+	const struct platform_device_info *pdevinfo;
 
 	if (!cpu_is_omap16xx())
 		return -EINVAL;
@@ -224,9 +220,9 @@ static int __init omap16xx_gpio_init(void)
 					ULPD_CAM_CLK_CTRL);
 
 	for (i = 0; i < ARRAY_SIZE(omap16xx_gpio_dev); i++) {
-		pdev = omap16xx_gpio_dev[i];
+		pdevinfo = omap16xx_gpio_dev[i];
 
-		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+		res = &pdevinfo->res[0];
 		if (unlikely(!res)) {
 			dev_err(&pdev->dev, "Invalid mem resource.\n");
 			return -ENODEV;
@@ -234,14 +230,14 @@ static int __init omap16xx_gpio_init(void)
 
 		base = ioremap(res->start, resource_size(res));
 		if (unlikely(!base)) {
-			dev_err(&pdev->dev, "ioremap failed.\n");
+			pr_err("ioremap failed.\n");
 			return -ENOMEM;
 		}
 
 		__raw_writel(SYSCONFIG_WORD, base + OMAP1610_GPIO_SYSCONFIG);
 		iounmap(base);
 
-		platform_device_register(omap16xx_gpio_dev[i]);
+		platform_device_register_full(omap16xx_gpio_dev[i]);
 	}
 
 	return 0;

-- 
2.47.3

