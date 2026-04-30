Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E0B3B961E
	for <linux-acpi@vger.kernel.org>; Thu, 30 Apr 2026 07:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777534275; cv=none; b=W8QFpqXkKKzOrBu/bdA920lU3RpTZ7fK+LVTFTAIGV6PoUi44vNvTCH2zpUaIhBgIKQtNBqEcOWlRtV97vF6+g01+Wavak0IdqwnNeM5/hosaYv3eBwJVkvDhNEKiMRplsvdNOZ9wAU/2I0I1/lrnLJYZBty3Dr27JtClqgjb+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777534275; c=relaxed/simple;
	bh=PHpDrTZXHmNwZUSRWJMw+i4wybcuMgJ3uN1C9wMAxi4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QrX/jKHPmg/tGYk9xASxGWhh5YoSM8Aeexc9f/5CMSpsKV1H0DwiihI9aUx9l2cpBb2C+JcSVCzVORJri3rdiRWB0S335TCIzWG6NqX6bj1b0yydEXmVrdWWUkOP+UPYCiBB3SIyJ3C3CMf51pLf1ER1n3OYiah6gg/hFbLkLqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=e8ZEcTAZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UsfqAM3+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="e8ZEcTAZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UsfqAM3+"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63TNvDO93733556
	for <linux-acpi@vger.kernel.org>; Thu, 30 Apr 2026 07:31:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/b/CPdx/UP9zJB8T5L7o6k+fxq4JskuiICzDFnr9ggs=; b=e8ZEcTAZndD7gvDd
	xk7RR6Poc+Z3TLgW4S1as3l4G182g+5Y+a3wT7kEvQnteuRD6Lt3D4dLtI3Yl689
	Wmd48IfyZq28fVE7l3CO9vC1azul95ORfkpoEDWmTigo3EZRBrDmV5+dj3NmJ/xZ
	+Hbk61dmTcH4LE+m6IU25Cr6PekHMJpOqrLi4axzUhLUmfLyYhdsnoyeYBhGl9O+
	bjq9/V1c4zJhCBmbQIvjmAVmAiqoE0D6wAa6LaajksvVufwg5UCq3sCsmXeR1056
	M4FbAgvnZev88GbC2MV04CcYUtTyh7gznGtH5869RkHah4HnddTrI2YIOq8xsbkk
	x36O1g==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4duv3x9byt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Thu, 30 Apr 2026 07:31:12 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50fb007bc36so12530461cf.3
        for <linux-acpi@vger.kernel.org>; Thu, 30 Apr 2026 00:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777534272; x=1778139072; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/b/CPdx/UP9zJB8T5L7o6k+fxq4JskuiICzDFnr9ggs=;
        b=UsfqAM3+T672P06jkMZzBiPiycGbLr8yyObnTRy09vkyB/E03OeQUJLTbmAbOvtRaX
         FudJhkdaD6rreWiUutD+NcYaoRi47VzsHoPjOKdENCN/Z1kqtEzdMrXNmMf4zSJ395mG
         DFugObCPsUvaMAuL6SxBb5Gg7Zc7eU4P8YcWWe7emMSNTRq4wz687MVfTrzbR14Q/FOr
         CSTI47cdcIZnogydesF1dQpLoql2Rx8gp3suMCyBIMyGEEtaOUrVUlCjtFQw6r6Vz7Bn
         TJHjuH0/O9HG8RsNUKil+yg9xfsG6E54z+Ey05llrD5OvVd9bv/HWfK7YW7ya+mRo8j7
         46mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777534272; x=1778139072;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/b/CPdx/UP9zJB8T5L7o6k+fxq4JskuiICzDFnr9ggs=;
        b=f3EVV6x0CMGR1aYieqLZjs9cSHh4ncqj05qFr3NQV754Ud5qiPqb8rL00NRNUf9+Y8
         n60ytfv6mlAi61lA+ApE5fFORvxCqxBoIm4bmIs4mDVMFnXKktCGgCi1G2H+Mw1VLZIX
         /4bLFt073lCH8GDD5I3oxA+w5lf5MYKifQSh0CQiaPRQjzT8+DezWmA0bLrbQff++4iU
         i4hzIfUmqunVWZ9V/Ax4hFjbn4lz0tNv83gA+noQR/HWy92OBrR9ZBRbXubOx5I1J6vI
         HU01LO2ukKy+xut4kC+BwhZfgXPExXZNXhkTU5q9/xg8atiM/mUFywQxGzSv+MolWDXX
         GGrA==
X-Forwarded-Encrypted: i=1; AFNElJ8CDjb2t3Ymb5sxlPGMzkvuUxceRPo0tV4u1aXg7yBj8mbFPSPA4cupDQLlBhMEg/VYyqr4WtAH5S+z@vger.kernel.org
X-Gm-Message-State: AOJu0YwH43iQvo1tftzS0N5HmDMaob1MfoumFxsH3Z0x9CP2pAkGmYSD
	AIkDyWbcNbFuoVodMN5JiPYCgOHcM/N5h3MDxQU1T3CDU0prO8aXFkxjfsHOEsSr1yUFoP0UJIa
	lMJOjGOtECPBj2fb7I4BBGFqkzcb0ZafppJtg3yZ320cPFq0JEDPE9zc8AWBKmdbo
X-Gm-Gg: AeBDieuLTpjxhkHE6oGYIX0At10BvymXZSxJuO8u/ebajKD5o4LnwQteD6Z4d31kjwe
	87DMS8hCvryhO9+D/Vs40TTMKVuEHin/2/O4eEZmSksMB/7E6UGbkDfwgFpL+9d8ceOgaBfP10m
	us6xeh43abTgjVLaqVgjy1lNfd1dNDJKwbN9vNEpd1UTQNWQAbD3t6+lmOET1VEuEEMRL4zeT/R
	y5dSNgP6buV6MCJwKPUALaU6DLZSWgEkC/rtBYjsWpqnATWfkZhMsNLvm8SwbOLP9fAhkrTKg3J
	Y4aSpAebgLlEdw3qm3NgvnolHdRhRowZThBMElhXSWL3VHsOzbwwS8HeQDazBbBvg83Ff3XgNfo
	leYmS02qFtX4LvvtRe6WjOBOz/1hfTcXJJ39u+sRhTt7GNvyJNlvCEb/DFRLW
X-Received: by 2002:ac8:588f:0:b0:50f:c26d:f309 with SMTP id d75a77b69052e-5102aac21fbmr23257251cf.9.1777534271645;
        Thu, 30 Apr 2026 00:31:11 -0700 (PDT)
X-Received: by 2002:ac8:588f:0:b0:50f:c26d:f309 with SMTP id d75a77b69052e-5102aac21fbmr23256831cf.9.1777534271174;
        Thu, 30 Apr 2026 00:31:11 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:79a:f446:21cb:22e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a81ed69fasm59515035e9.3.2026.04.30.00.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 00:31:10 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 30 Apr 2026 09:30:56 +0200
Subject: [PATCH v7 2/3] ARM: omap1: use platform_device_register_full() for
 GPIO devices on OMAP 16xx
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260430-nokia770-gpio-swnodes-v7-2-c88f74c90dd6@oss.qualcomm.com>
References: <20260430-nokia770-gpio-swnodes-v7-0-c88f74c90dd6@oss.qualcomm.com>
In-Reply-To: <20260430-nokia770-gpio-swnodes-v7-0-c88f74c90dd6@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5930;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=PHpDrTZXHmNwZUSRWJMw+i4wybcuMgJ3uN1C9wMAxi4=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBp8wU4XukNO7TP55pg4f/67FONGRM2nuEafp/wT
 kRV24+CwxuJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCafMFOAAKCRAFnS7L/zaE
 w3vwEACMegZhfLDIQ41bJnAVGxvOM+tx9kxXuv0GdzvafYaKXSUamw6nOax3IPck2um/WXiok80
 oijfD99qGVMuGCgXiAVeJB3cnUwFGmNSYZNgRdu8cDD0Tbfn5wu6qxzZEPzBWuQ3q3Beet58xiC
 zUZwCZ2hfdTKAQINwI0kxqXrwNX3fYejHuH2EGJGrdM9fC+SRJSWFS1wMg+ExyHbVrceqlUOYKf
 b0q6f9feaBt8wptE6WJJXcNUyanIGiQFLN5ityIWCB9RAzcd6tBLBOzo2FfpGaKaleIRwjjEKkJ
 xUy252eNIl2x6oZbdoTfZTYA1nL85UsSwYRgRDMCEfiwra4dEv1KSXyix6YmaYCeeIObTUSbaab
 0NYI0YxJmUceuT/wXMyRh6kS0bO9gGXOpdWGH/PFq0TloUloHJuA6ZAQYRhTVnwibXdvtWD8cwx
 ks0jKWqs/aO739f/hzvZiMHd2zp4sQrLJSJ7P2Y329iI6lFCfsLzBMNI8vAPm5kIOn/4rNAc4ay
 GOfHfl2szvcTi94YtgvkrercKXtfuXDREpvuRas1ivYiUcDFH+NyrLOcMiTv9rGIa1ZZ5ouQOFF
 8jME7Cd0uZceegeS+xby6ZOagF1EIr08e0lJlyA6SQz/bM1Oqj5uVMoJwau+4ZlBXBBF9WRbkLN
 EdqOak95M9yCBpw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDA3MiBTYWx0ZWRfX5/FphaVkmVaF
 jPxBlUMCZSYSEvx2MoG4BdVja2jE6i42jKKE6ROOPNlDA0cCvxcQVU+Cl7+SkNrAe1QtOz5TiT2
 FoFz8pSNxE1WFdO6Fq8M5nhG+qKgZhLoIEDXlwoS10S+1FTf/ZOhPIRAHZPuGvAxd5JW0V9Mmge
 OZbkoPHoHnHqq6L/yZqVQ4Ma3mBXkyDOZ94Kg7ffFC3tA3Uz+8Z8JX5+m8m80H72kn3ODM/ME6f
 8v/vfmnnKcWfnHvRWB5p8tzG1xH6q2Wis5pLD9VWc1LkE9Q5puhZiMsgSnKzUdgd56IJ1D/dKVe
 EbOZaD4601cQ1uF0Ccd5JMBTm/PLW8er308nyKhcp+PHCtCVeywo7yHIs3W5cmq1VBQH6boxApQ
 dsOmnFKMXmfXCanm5VIVYLgVhH6qtVjxvaJUj4rJgGAh+IXWgscaIINeDoo8aPdFpIsvipxhbn4
 o3InD0AQBY21nTY+jlA==
X-Authority-Analysis: v=2.4 cv=Oc2oyBTY c=1 sm=1 tr=0 ts=69f30540 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=f8xzO-aaW-4QTlJhfLUA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: Ip5_FnCwvDqNsjhawaT26R7En02RqZbL
X-Proofpoint-ORIG-GUID: Ip5_FnCwvDqNsjhawaT26R7En02RqZbL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_02,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604300072

Ahead of changes attaching GPIO controller's software nodes referenced
from the Nokia 770 board files to their target devices, switch the
method for registering the platform devices to the
platform_device_register_full() variant. This is done to leverage the
new swnode field of struct platform_device_info which automate the
software node's registration and assignment.

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 arch/arm/mach-omap1/gpio16xx.c | 71 ++++++++++++++++++++----------------------
 1 file changed, 33 insertions(+), 38 deletions(-)

diff --git a/arch/arm/mach-omap1/gpio16xx.c b/arch/arm/mach-omap1/gpio16xx.c
index e8dbe173bd33fae72c7c884f930a530f78096839..9cca29f860544ddbec3734cec9b3246ce468543c 100644
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
@@ -210,8 +205,8 @@ static int __init omap16xx_gpio_init(void)
 {
 	int i;
 	void __iomem *base;
-	struct resource *res;
-	struct platform_device *pdev;
+	const struct resource *res;
+	const struct platform_device_info *pdevinfo;
 
 	if (!cpu_is_omap16xx())
 		return -EINVAL;
@@ -224,24 +219,24 @@ static int __init omap16xx_gpio_init(void)
 					ULPD_CAM_CLK_CTRL);
 
 	for (i = 0; i < ARRAY_SIZE(omap16xx_gpio_dev); i++) {
-		pdev = omap16xx_gpio_dev[i];
+		pdevinfo = omap16xx_gpio_dev[i];
 
-		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+		res = &pdevinfo->res[0];
 		if (unlikely(!res)) {
-			dev_err(&pdev->dev, "Invalid mem resource.\n");
+			pr_err("%s.%d: Invalid mem resource.\n", pdevinfo->name, pdevinfo->id);
 			return -ENODEV;
 		}
 
 		base = ioremap(res->start, resource_size(res));
 		if (unlikely(!base)) {
-			dev_err(&pdev->dev, "ioremap failed.\n");
+			pr_err("%s.%d: ioremap failed.\n", pdevinfo->name, pdevinfo->id);
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

