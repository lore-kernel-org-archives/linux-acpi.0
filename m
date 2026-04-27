Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0713A3B52FF
	for <linux-acpi@vger.kernel.org>; Mon, 27 Apr 2026 10:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777286819; cv=none; b=Phh9OCSXaBRYUDqr7WhbXBTsGcqtwd0BYMnK7iMLK4b8K7w0LC5hAIqkBcKr83wZLSXCBdBE0f07llbmi1q0jzDaOW8qFYb3ddvkpUiLchApwQwgmSemqcP0vLMerlO/ynn3/FePvgj+12mjhonJZuA8q16hPrOt13dtC9WeGno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777286819; c=relaxed/simple;
	bh=V/jdywlesUY0uBqaYDi3Ugol9q+X2MLKHVotp1NpTxY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NR1oZvZmpSeZALzbRF3lVoFHw+WTjbqV6pJEx+YHC0M421guycRsWtVveyHZcHDNb5Di/hO2l45c4jzv1DrKUzf7j41mABbB0dTlMLhmMKg0E40mVuhykZWYLhUz3YryIZy+F5I5TgzE0uy+hyRMQxRbi3986ei5gqyTXEHntHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n13IzVUy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WchkbfMo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n13IzVUy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WchkbfMo"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63R8TD281762370
	for <linux-acpi@vger.kernel.org>; Mon, 27 Apr 2026 10:46:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RsbxN8Qz/wnXMZHP/0VohG1ZL4oE2/MEeGUw96S4+dk=; b=n13IzVUyrBWjUim1
	8TcZfdLeoeKQQVrz38vDMMheKdB1uxd6Pnf/v0/u5xrGsCTJjgpQiWgb3eEtpT7u
	e/LnT7n83kCvDDwtgZr2e0c9dlBGErYZMHqvK/ybI2uZN/P3lNrN+gUAWPpBIgU4
	NQmYDfyGma83bXA+9Ec05a53DIKfY+IGpWeYS25Jt3dKk6Y/nzxSFB7bG7xptV5v
	5D0HkNJP0D4g+v9F7oePyYPlmiC8lFQYBBB8HyvonLv83COX4pQwQo7sM26db531
	PvSj0zoMj1a55DcmbuhDUVWExV1p9/4iSmK7TGDJ+zb1NluMv6AwzBYWNyGXU6hq
	3ZiGZQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4drpw9dpnj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Mon, 27 Apr 2026 10:46:56 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50da31af14cso266691761cf.1
        for <linux-acpi@vger.kernel.org>; Mon, 27 Apr 2026 03:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777286815; x=1777891615; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RsbxN8Qz/wnXMZHP/0VohG1ZL4oE2/MEeGUw96S4+dk=;
        b=WchkbfMok9Bhjh8DpKXvwa15X0GEYTXN+RK+B2aDD5n+IC/4cuxgPhpIpZvds3Od5d
         yAS9oiVaATJUZ5W9iqfpU9kRzZX95HfLpSvYJI1p8KkjUU+hMCOJl+nQtgmkmEr+Qb9Z
         HAtPYnIuemiB0imSa8CATy2xSKEiumrj8oH+dH0OxnJPbPtTfLjmaW6r8iBJObpU91SS
         jbU/4wzuQxL2GyY8u/JpFjKvQyFpBIk1aSVvNKwkpJx76DxsC3+RkuXByOGbVOgOA+b1
         XXds6LTcRN05UbWYWK0tDIvC8hCY9oqM6rDgosJm/ddU117hirGuRrR81hf8P8/1PQe4
         wsIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777286815; x=1777891615;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RsbxN8Qz/wnXMZHP/0VohG1ZL4oE2/MEeGUw96S4+dk=;
        b=H0q0Zx/Iz7EsK63UAfkSY2ZiPTUo4AYuUEqzJHXAC5KGxlZzdfIT99+8+4zrERNIN4
         eVubUgSj6aSvmMtyZU/OAMM/WOV14IwB1vpR9z9PNcAgg33YDfWfFxZF90TTmkng9WDr
         Nsrogvjt7p2VVgaORi9ssJL2SlbHrSNzZLHdNzqQS1RJ0ICMpfTDGJfHiCEYOLZJFAvJ
         SDExoXSUKKgGHJb9BekCTjVb512hPMXErdnUzllwMbu8saPuLdi/XJDb8IB+dcaiDL71
         bZhJO2gu3RuoxUf4p9bhpZKhPbWSdridfHpEdoqqlrMw86neJuW8CosI9Xf7p3zFuKaU
         ULsw==
X-Forwarded-Encrypted: i=1; AFNElJ/SkaNBLh7lABLJT49rezWcCmDVJrTUbqXyTFYR51QyRp6illaf5dNVHz6IqSAYwrYrb4wd+uEcPEEu@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+XClFOmfKWE0Fume8QfyH2aBxmbkR+CNpC/Z14IaKJFIyLQfq
	wmVk8H/CDCjyWPP89Ny8QlDrfIvNKWxKToO6pGTqjKtSKPeVDY+GcwpGP8QKuN3y4mGXEH8ezy2
	I1SAXu0iyIOLhetge0t2WHXDYwxXk24A8AX+5+J79O2nbTiZzdOSGNKzQhwejXicm
X-Gm-Gg: AeBDiesptBmqZ93V+MBBBWR6a7vidGO74uqrTCr/9N/2BcLLvIGdQb1AQrpU33xLnC3
	lcowsADFfHjuKb/mMlBqfIg7aQlvvcF7BUN+/EC0Dkvbp9FQ2kgL5qjw1qHHpw/wfWLDT/nCPl+
	64zQgU8ujxRWj+zWyGLPtc009qg33xcpb7dtTrUfjTfSPj8CWeqTRqE/VqvWqo2CseYIrYZwgR3
	7pegCofW5rz1YxSTLPnyqNdq7C7hyp5mZTEoBOiRZudHKHjKyxa8elNEmwVyMSqcI27dn0UW5Dl
	MgFKmEmfj/GoKVn3+fuZ78YNJ+Dfhckgq86CR5+MzdiOOcIk5yoFbzi9s+BlB+SJygN7SRjj5bX
	Wj6FD1JoZCsNzYQYuyqmpB8I3yCMCQBCnX1Jxzz17zb0WRokzm+r3iX/Y6roQsw==
X-Received: by 2002:a05:622a:10e:b0:50b:29a6:8696 with SMTP id d75a77b69052e-50e3681d042mr591454731cf.7.1777286815395;
        Mon, 27 Apr 2026 03:46:55 -0700 (PDT)
X-Received: by 2002:a05:622a:10e:b0:50b:29a6:8696 with SMTP id d75a77b69052e-50e3681d042mr591454421cf.7.1777286814970;
        Mon, 27 Apr 2026 03:46:54 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:5062:ae86:23aa:702c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cc2cacsm80353681f8f.13.2026.04.27.03.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 03:46:53 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 27 Apr 2026 12:46:32 +0200
Subject: [PATCH v6 1/3] ARM: omap1: drop unused variable from
 omap16xx_gpio_init()
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-nokia770-gpio-swnodes-v6-1-b693296c1985@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=993;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=V/jdywlesUY0uBqaYDi3Ugol9q+X2MLKHVotp1NpTxY=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBp7z6WM0zyqbh4rTFe9OeYaJ8UORQWZy1TpMzVa
 Fi0Grpi4emJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCae8+lgAKCRAFnS7L/zaE
 w1UuD/9uvinlbPHUtBcDETd4JBQI3tGcCaYm3dMANDM8oRPAx4ZgZRpNut+RMPa+oxZaFwDka3I
 brxWcXTUT3RjbQ0KTNxh4S6x8xNEOEkb0VKj7C70UzoP2RoWJvpwo27eex2M5pofd3hNSGQz1uq
 6FRf233WbY/AjCdPyA3JqEJILDUdvbiVDfJah/hddCsgmcDwtV3qHSSWIVfVajy8nXdR0rX2Ko+
 vzNiLh7BfTV0ysgr/9TjEEES8t5D36TI/Fqc3xhU8CAQ4JxpBwsirpui5JZVFTqYZnEbf0NFbqY
 1NSoKzPsHsS/dSo1cVe55n1AKjDHfgQ0SPavGRlR2VV/3UhINnXx1OSuRXOMOw/z/72LKK6tVPz
 3wgKMQXE1D5WHnkhI/5dUWa1oWrO+NE//q7YLCxpcr0vXVOx4rrYGikiCaxjDsSAu7XaWqjoPVc
 3Dko5ivSBAGNLKokNcJ6uy25dvKI/aKn9A6ihm6GqlbYLeSNhrDqdO9t21JnECFvs3A0xVXq7Qt
 VUaNnCV/lN4GzoNNFedQCEB5il1OeF+QbJFZh7fXUTEVpI2IrljJNcfG8SQ266oT9Vdg44I/mH8
 ctoNnn9h6Qey9aLjAbRvh5Qpg9ODbYJ73uXif6SGYFZfnNM0zi4Ciwis0VrL3hFGnMFTQ35CAIt
 x7mWdFJZKlwvJUw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: 88BZZ-E_FfF35H-p7qyhpOZZ3-UgJO7z
X-Authority-Analysis: v=2.4 cv=H67rBeYi c=1 sm=1 tr=0 ts=69ef3ea0 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=JtOLnEVYxSPUHa-KuBYA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDExNCBTYWx0ZWRfX2czlTBRFqjH+
 5p7CTqmXFhCbqZczXg08t8OIySgEVAs00CoAytTJRI81GTJk8TdPCMszSMcJVI1upnxTFZbp4CT
 BlRa8g+Vf7BQBFhNnyuEMo8kjao5lFRZxpMll+PfI4qhCj6/KLEBGGLJWmO39k2EVP/q7l/lpPX
 ctvYz2y3a20hgj7Cj94wkPHWISy/iT1I3x9WeX39KHO7eKn+awbmBdp4HKPHgC/3TrqWYX/3WT6
 CK9yDeH7jtDQ5k5kcdsGXetO8TijThZOH+MnC9sfPyp6b/Wx9uhE5Tm5NZ2ywN2SAVj9UmqyMq+
 uuMeScT+em/lJuwf/rknl01NPMJCGUY8mffJpQkwc2uaUCyMoleP1KX6BWGH7D1jVMovE4pbwEj
 mWPJ+8wiXNGMI9/Z1Iof2Sj68xQDWWGMiEZXOpsyq/iqNsgK5S4uQyRcYADptvfdRTEO2UihV6M
 jc8GJ1430J6HqvNxI6g==
X-Proofpoint-ORIG-GUID: 88BZZ-E_FfF35H-p7qyhpOZZ3-UgJO7z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270114

The pdata variable is set but not used. Remove it.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 arch/arm/mach-omap1/gpio16xx.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-omap1/gpio16xx.c b/arch/arm/mach-omap1/gpio16xx.c
index 55acec22fef4e73f20935473602ef6cb2f4f379c..e8dbe173bd33fae72c7c884f930a530f78096839 100644
--- a/arch/arm/mach-omap1/gpio16xx.c
+++ b/arch/arm/mach-omap1/gpio16xx.c
@@ -212,7 +212,6 @@ static int __init omap16xx_gpio_init(void)
 	void __iomem *base;
 	struct resource *res;
 	struct platform_device *pdev;
-	struct omap_gpio_platform_data *pdata;
 
 	if (!cpu_is_omap16xx())
 		return -EINVAL;
@@ -226,7 +225,6 @@ static int __init omap16xx_gpio_init(void)
 
 	for (i = 0; i < ARRAY_SIZE(omap16xx_gpio_dev); i++) {
 		pdev = omap16xx_gpio_dev[i];
-		pdata = pdev->dev.platform_data;
 
 		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 		if (unlikely(!res)) {

-- 
2.47.3

