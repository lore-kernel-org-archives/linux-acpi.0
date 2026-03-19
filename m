Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AB63EB7E1
	for <linux-acpi@vger.kernel.org>; Thu, 19 Mar 2026 16:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773936679; cv=none; b=NbfKrnZzztf6NEPzLM5O9b7EjmJPcaXGyLqf9r8TzeSJN67/AZjHp/bDtZjxf7svGnlzDlf1gR4YoYMtqEalignSQ9MQD6R1INJ9FWdUpoHLb9aXe8fkRLo+jra/TRl3/uvWnw3G0NMXiGC+wDbDSgmVUTgBCWROQ+W+PwO6MlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773936679; c=relaxed/simple;
	bh=kyQWpc+s6LyGB+cuyTPjoSS5DZ25LWb/g6VCYSKQJQ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IYqbKAkFaKw9JS5RgCY5M0EsQHRhZ9WmBgXcv7lgVm8YkbrqHhw5CeD57b/DJNE3GXY5OcyZUmNLMax2OvIWmRWjmj7I0kGsdlELTUAt9e4M91d/fWF4QGkW9nM6omtuXnQ+BWmJZanGSzWKHHKYTPDH9R9IiJkorZoE4ym6rI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HNaSJJna; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bnNZAjzh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HNaSJJna";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bnNZAjzh"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62JEWCsa2981547
	for <linux-acpi@vger.kernel.org>; Thu, 19 Mar 2026 16:11:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	n+3e6RrrE6nJ0WW2f1xgH0NuNkol6/On6k5K+mXa1Qc=; b=HNaSJJnaPZB/375t
	jgSeiStPttPRFUhjs/PQ8Ngrlbz+QGeqWvWPKcSOZEPFKw8yXBsf8jazlwlbB5HV
	h/B5bCoYECDdx54tSsVtMdHxcvXARd7FnnqU+P9qOrY8j78zeWmLz7t8AABsOuYb
	xTKYgIOoDTkSkK769CMn7liHQhlX+iTwX2Tl3FWqDva4iAMAblTIFESNRF+chLZi
	v/SwlISGNLOmDFswigvcpJ37whKpxSRFkf6hoI3ELK9Iuo9KmNKJULIrgony4/By
	+UyBbuW8Pb4Lx6GTvzteJBjcmfa6VKStWO1rt8JvaZSQj9JTQMour4OT+1j+xAYl
	TyQQHQ==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d0k080bmw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Thu, 19 Mar 2026 16:11:14 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-5ffc6cb5980so1356881137.0
        for <linux-acpi@vger.kernel.org>; Thu, 19 Mar 2026 09:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773936674; x=1774541474; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n+3e6RrrE6nJ0WW2f1xgH0NuNkol6/On6k5K+mXa1Qc=;
        b=bnNZAjzhvlrVCQkZ6J1fjE9i53NppxrDFQvNUDZSL7FRJeIU8ELmVMjFk2OdUxUa+6
         HSfhCd6CfNR5nmrcTiMKy57Txy/luDi81lxyDutsmAzgBZt1FhoiS7IixYcFObiOD87L
         l6pxpOHclC3KMqUzWWboIWgMKQBsubwrZ+2XI5bvvpWTCXs6no9IhOHX6uoZs43v3/Dn
         19r1E785uNCn6GHI9LIR3Wiy5uDxVY+XD4b3Zh/o9DhXDA9kB8/1q55a1RaLhkfpaddt
         zi416TDaGh9DN1/o2U0iYF0c5pU/AqRJYYP8ZAL3geKg/tVXwyh/Mg6HTW6SsPY87YMz
         MAjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773936674; x=1774541474;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=n+3e6RrrE6nJ0WW2f1xgH0NuNkol6/On6k5K+mXa1Qc=;
        b=QXRyCOxrCGQ4SE0OXe6q9KYkAMXWL6ypRi1CP1pswZEjTRAmavn8WhG2EpvzaOkenT
         /S4GykJ25ULNnHUbyy4pyFyEHJyefbAzk0yClZZHefUftmr6sWnzsslTYLjlhFDoo7O6
         9cEnt+0BBfkSMHrOtg0eBhf+gTAubt5cYuxubgKmqkDNPS5ajuTIsUybf9egZdy/vJ0V
         /hat2/x5frJADgkhc118YpumpMnGL9Dea8jbp9kSNip8CKynC/qM7rk78vXSTHXpZRIm
         XpE3GqFsbMFMl74YUgnEx4Zd55PGDCAfLiHK15/rR1Pnrfy+jZDtT8pKCQNaM9rqJj8B
         zGNg==
X-Gm-Message-State: AOJu0YymPr2kbuSlAasOmnmLwoFdKHdAGc3fZEQ9uCTZCvHmZGGANtrn
	7FGN8q/FOoI+cZz/4QkMMYpah4ntiaqPrPehiz0wQws8XwBlk2SX9jw+AxEyV/nYIi1hIWZglvl
	Ny94h7YcFK1TnhW/Rm/hztTTVJW4GpIj9CYdvdr7eprxcSKWVXV6UuoxATGAgFTCp
X-Gm-Gg: ATEYQzwnyacdUhH9ks7/dqzCR+8x36Vgy5+5Uf6/0pOfC9qASke0ieFS04UNMGd3yiu
	9ls2uk0XocN6apuuzieYkfWKML2YmWQHruaSBVGIZSeifxSlY5BD5DJ+LY1uHG1XE7VYeJeFtgf
	jlah3BoNmWYfwlyKpqWwOjtj6rqEOj1RqnPjDBR8yaalGQVkfWeixYmMEEUQVVQd622KHhDmeCY
	3MC2VWfAvscjC97fk22fpO1bkjeVbpoRnqcmKUMIdeeoC0slPkQSM9JYYYh8Kpx1Z3wneK3FHX/
	dSrfAcE4HDij3RCC7u4oPETk5ewD5iXE29SWrhkyLLsTqDsBQ3VDZ3ty95Kib+ZWS7VxpJLrh2Y
	S/5WIOaCAU2PUqaJoI1gy0ehOXt9CnzbRvYvCcqhavjxDrYCwA9hF
X-Received: by 2002:a05:6102:1620:b0:5db:fe0d:7fd5 with SMTP id ada2fe7eead31-602aeaffb34mr60908137.10.1773936673732;
        Thu, 19 Mar 2026 09:11:13 -0700 (PDT)
X-Received: by 2002:a05:6102:1620:b0:5db:fe0d:7fd5 with SMTP id ada2fe7eead31-602aeaffb34mr60853137.10.1773936673125;
        Thu, 19 Mar 2026 09:11:13 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:9d74:8015:408c:d719])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f4e5495csm83756915e9.2.2026.03.19.09.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 09:11:12 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 19 Mar 2026 17:10:55 +0100
Subject: [PATCH 2/4] pinctrl: intel: expose software nodes for baytrail
 GPIO devices
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-baytrail-real-swnode-v1-2-75f2264ae49f@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3084;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=kyQWpc+s6LyGB+cuyTPjoSS5DZ25LWb/g6VCYSKQJQ4=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpvCAWd/YCTQb1ZpJO3nLK2ALOKvuo/gh4sQpxD
 NZKbSmFQVyJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCabwgFgAKCRAFnS7L/zaE
 w0X8D/0bgfGvEb2pvErq1zJpsj5AKN2FholT28W7NlXp/35ot8SBkYRIp+s0nFspf20bQ7psQTz
 sWMAraTPQQ9rikZxk6pZ/38l0bUAl74JMpX21PBM4NBZBgoTwZJyLbRTLPWWh9FCFM0PeO5Wd5e
 Ir/aju4y5ybblGAWOLmnZ9E8CC+OpBod5fgduXJa9Xrfv9OpX1O4DueusUQilG6Id/LlBA0NS7z
 s2lxyePsa6rPEUGSFxTnyWQieC4bUVtvgynmTpBvIM5sN8oTWwSXISPKt/wvFu3CASmNtuBZr7u
 e9nIQvOuUUA3wHt2rCcON8UgCtU093uL0YY3LiHppMc0L4dU2FrczGPz08ilQ01RtE0o6vajcvL
 Yd+ZhjMX/JPa6z37M0W1Bk/Bzbky/Ooy6AgXtJKHuDxGDSbIPN78HMEzhEStMijexYkhkDNjWt6
 wJXTQyWX4NmzY/ImFOOn5yvEbat6yqUxyRrNYvAVIE1e7mj2EHw1FjtBPrgkY3iihR7sMAERCHA
 jAFkanfTkja73k5GyEJnRbqItJnuLeEeKw2RbHole9eevfAtSflfk6EoeReoO/ZHo1M3Vondc/J
 DTtHvihyA4Rs47Yo64ET4i0N+Web+EqtzT7xPQ2azvY9xzM/30fTYKrF8hLtE5jM+Y70LIDm+94
 MqdlioRoOi4r2bw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=MYhhep/f c=1 sm=1 tr=0 ts=69bc2022 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=kPuSsqDpjDp9iQEZ0-0A:9 a=QEXdDO2ut3YA:10 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-ORIG-GUID: 42WqExEfnA1SdZntJLHck0HK74W3NZNO
X-Proofpoint-GUID: 42WqExEfnA1SdZntJLHck0HK74W3NZNO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDEyOSBTYWx0ZWRfXzr+oceYl6Q14
 5Vsis5uoq/lS7nzwazsMzL5wGG+jSioCiYIEsi8Cl9xBUnR4GM16kwbSV0yUOB0Jjr2idI2Zr9O
 yZeFNYJK7irn81yEfTkKXzSFBxbRf6WZgoeXEf6ku2vA/rNdYDIL4AEGM17+VFG6vr8y9uhj3Hg
 HLj+Oq+ipT38u/zucwH6bzK140aTDkyseCwdcUSV7SpbHK6dKIkCveXL/1CJlStheq2tKx4ZCZz
 qVEOH/a+k3NXLoZsHDAqGOmRT38EdUUy+6pCh3sT/W/Aq7FdzUrR4VeSwhYxkEFjh43QEqH2H0j
 d13YguiFIeDe5YHLOSwOzt8LvAaSZggSxDLw8zsmFR4OIM6rwTNMyCxy3p2d5j2jEdB9kJOVZ+X
 VNepzzwDBFldobMc4svFB4SNkSVpypPjjIS3jcoDIzaE0OHz1BGe5MlUGezoV5s44ZO84AYPWXu
 /RNdteR0zGLyfukdwAA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_02,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 impostorscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603190129

Use the new automatic secondary fwnode API to ensure that when the
baytrail pinctrl device is added to the platform bus, the static
software node provided for drivers not able to use ACPI will get
automatically assigned as the secondary fwnode of the primary ACPI node.

Create a new header under linux/pinctrl/ containing intel-specific
symbols and declare the new variables there.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/pinctrl/intel/pinctrl-baytrail.c | 40 +++++++++++++++++++++++++++++++-
 include/linux/pinctrl/intel.h            | 12 ++++++++++
 2 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/intel/pinctrl-baytrail.c b/drivers/pinctrl/intel/pinctrl-baytrail.c
index 02fdadf2189afb0ff654c80c131f813b59d623d6..bd0ba7c3351c021584127b3679c59d7463cc8a57 100644
--- a/drivers/pinctrl/intel/pinctrl-baytrail.c
+++ b/drivers/pinctrl/intel/pinctrl-baytrail.c
@@ -22,6 +22,7 @@
 #include <linux/seq_file.h>
 #include <linux/string_helpers.h>
 
+#include <linux/pinctrl/intel.h>
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/pinctrl/pinmux.h>
 #include <linux/pinctrl/pinconf.h>
@@ -1723,9 +1724,46 @@ static struct platform_driver byt_gpio_driver = {
 	},
 };
 
+const struct software_node baytrail_gpio_node_00 = {
+	.name = "INT33FC:00",
+};
+EXPORT_SYMBOL_NS_GPL(baytrail_gpio_node_00, "PINCTRL_INTEL");
+
+const struct software_node baytrail_gpio_node_01 = {
+	.name = "INT33FC:01",
+};
+EXPORT_SYMBOL_NS_GPL(baytrail_gpio_node_01, "PINCTRL_INTEL");
+
+const struct software_node baytrail_gpio_node_02 = {
+	.name = "INT33FC:02",
+};
+EXPORT_SYMBOL_NS_GPL(baytrail_gpio_node_02, "PINCTRL_INTEL");
+
+static const struct software_node *baytrail_gpio_node_group[] = {
+	&baytrail_gpio_node_00,
+	&baytrail_gpio_node_01,
+	&baytrail_gpio_node_02,
+	NULL
+};
+
+static struct software_node_auto_secondary byt_auto_secondary = {
+	.node_group = baytrail_gpio_node_group,
+	.bus = &platform_bus_type,
+};
+
 static int __init byt_gpio_init(void)
 {
-	return platform_driver_register(&byt_gpio_driver);
+	int ret;
+
+	ret = software_node_register_auto_secondary(&byt_auto_secondary);
+	if (ret)
+		return ret;
+
+	ret = platform_driver_register(&byt_gpio_driver);
+	if (ret)
+		software_node_unregister_auto_secondary(&byt_auto_secondary);
+
+	return ret;
 }
 subsys_initcall(byt_gpio_init);
 
diff --git a/include/linux/pinctrl/intel.h b/include/linux/pinctrl/intel.h
new file mode 100644
index 0000000000000000000000000000000000000000..d45f090adc1f532f866c98aeca144a4d83fa28f4
--- /dev/null
+++ b/include/linux/pinctrl/intel.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __LINUX_PINCTRL_INTEL_H
+#define __LINUX_PINCTRL_INTEL_H
+
+struct software_node;
+
+extern const struct software_node baytrail_gpio_node_00;
+extern const struct software_node baytrail_gpio_node_01;
+extern const struct software_node baytrail_gpio_node_02;
+
+#endif /* __LINUX_PINCTRL_INTEL_H */

-- 
2.47.3

