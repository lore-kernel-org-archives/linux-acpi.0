Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1563D7D91
	for <linux-acpi@vger.kernel.org>; Thu, 30 Apr 2026 07:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777534474; cv=none; b=AUmGoaeRfismzb/4hrpyyrIA+w7ICtrB8FwfVFGKnSyke60kNj3ewu1m3obFr/YbR7WuAK1a8F8Qu7nAu4ffNGWJtlt1MnQfmEsvc4EO6Hjpq8XYnZjwtMjGbR4pw8PJmGCKgu9Lg9YpF7Iu8mKqO1I9COZqU2Pr2BUuVuG6MkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777534474; c=relaxed/simple;
	bh=ftejCI4cDYR15DURdSwoo+KUTTkz4glwgHDYbKITpyw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oQWb3D/F6pdjl+sgMwi2CDH+JImDEDAxnfWdIe33gFdQvQ+E45bIRZfZHib6b8Gekq7TJbop889pN22ar9h90wzSXEJl8I1W8ZuFFNRtOdDOrXng7l8YM2jmX2B+gb9ii75hHXeDrgpYlFEC4QN0Fs1tigTevPyk+TiPQGcVkP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YkXGUqc0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AGnpajaL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YkXGUqc0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AGnpajaL"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63U5nNM42533833
	for <linux-acpi@vger.kernel.org>; Thu, 30 Apr 2026 07:34:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	U1lg30DyGHdc17+B9LzqWTA6Lt4/KitzUTkvawVH9l8=; b=YkXGUqc0UwwFKQda
	PE1GWHQR2rLBvZZuCvHXOt537eZxo7bpxUkuhu/01yPufMEdgsCS46y3dh2vjshm
	yOBLMyqduCPu+m8TK48Ct32cK7HWZLIQpgsrW8Kr/mL3VJr2dBJAYN32bWr73v9a
	sV6yeNJB6MkMuCvDr5qzEshW9EcHuZBSM6XNx6mCL5ZOB9zodEy76yVbvSS5o7Z6
	eTpCVHLQ/30HKkVVJ9vYAZmXpuqMLLXRsi33P0AIgfYjEVQApvfjQU13xzkm1aTE
	KU7qJ14v3rNPnlFNoG1sXF4CE8vXEYqBVY8TZ4uxqjOr/TkOg7U7cl9289PmVSeM
	xpbHEA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dupe92hdf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Thu, 30 Apr 2026 07:34:18 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50da529ff48so11131341cf.3
        for <linux-acpi@vger.kernel.org>; Thu, 30 Apr 2026 00:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777534457; x=1778139257; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U1lg30DyGHdc17+B9LzqWTA6Lt4/KitzUTkvawVH9l8=;
        b=AGnpajaLlAqaHH9EQX2in9CzyIyIvN2OzhTDs/pf6TRE9/HQbDz8vNsFqackNwhQ7T
         IMloXvno0aERnnbpq/HPZEKpbgv5RBYa1AR/EbI6ZWGQZ9osiGFerSY9vdr+YLpZ8M+g
         pHlo6XaMKFdh1n8wRCnwSTSdI+GH1yEoyXAup4WAyWNu/SLgJP7WIrYGkyuQUShQKZ0u
         su3zkP/KTzB01ixAmJBFDME/mDwFp1Xykd/cSTwUyAC1uFWy1tUPSRZONrJpEz/9CVz5
         iw888GMsZ1+O/9G3r1CFcAIZ/BBmdWavduf1Zpr1kpJF20besdnQdZBjhyVrnu3SueHS
         C5BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777534457; x=1778139257;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=U1lg30DyGHdc17+B9LzqWTA6Lt4/KitzUTkvawVH9l8=;
        b=hZKOG6ZoL3JZycCxszyYyfBicCgSSi7jiOTpiPhQh+fsWK4A5M87xdGfffDcG9otvA
         kT7A5BLErYK2zIAoaRn2AEjei2IeSq2SizYpwlGWKH/TRR6vbyBVhYTYaw5gyXJwrwoh
         qTqqXfl57WRJlgo3RdcXjj5l164nZjHRV1Zb/sLDiPR5+60FyFtBz3MaSK1LHLv9qvNr
         ClKk3jXm2u1N3xTmZcZrZ6Re11QhEc3A3klH1fWU2/zSupYHYsgw//sIKi//77+pwWnJ
         842b8ZZdVGMC9iPkWYaxX1mjiEK8Rk/8ulT+ZE3vq692ZVqHPVbMn5BFyEntZ0mgBOFQ
         aroQ==
X-Gm-Message-State: AOJu0YyfKy9rAdQ5qw00zOHqKkaCwHcwZrZwYtJq5PKPrWoueQKqzUxw
	OuCXD0ki6Um8sC/knqg0y97D7gEFm5L5nCQGHrHmawuDiVWNCV7BE/yLD2aX8dLm8hY1INUw/HV
	+iiXXS5RXvnfV3unkonATcvBPTUz6Ky5gMK8ANmY6VsL9GichLEKnZPDv6EdBUBU8bgNVhgSf
X-Gm-Gg: AeBDiesfL9uMXOUj2sDWb2g2f210PU8WQ9t54f5eK3NbuymNXcDqv5ezer1qspcws2+
	wCJLmpO9+Dy2xP+5A/DzE0QS/m31GI0qPuf/BBC+R+uO1YdZ9B8j6v9Eao4EHtHVbVxh7RPvsaF
	QHiYIQz09uAS72EXMQcRBksGWSBI2x7B6nt/67dEK9mZhG4RMGIYt3otYrqleWUMvibJkA75BWG
	zKoQCL/Ze1LnTwLDBl98SnliWetvuLjOxCc3WQ8thhU9mOAe1eZJjnhuQnZhm9pn11rBCp3KaAX
	OCXVvq8b23Uddk4GewU/oe+lEF0AyrMX8B01xRs5Yba5inlnR8RH9EwNIWGp0F9OcP1H6g7jCJH
	/RlHethQk6U/Rl0hDS5TZ0ZlrfuV2s2P5/1a88MzdwC969sKx730jJOTn9gfh
X-Received: by 2002:a05:622a:2296:b0:50d:abc3:eed5 with SMTP id d75a77b69052e-5102ae1dd37mr24163301cf.29.1777534457257;
        Thu, 30 Apr 2026 00:34:17 -0700 (PDT)
X-Received: by 2002:a05:622a:2296:b0:50d:abc3:eed5 with SMTP id d75a77b69052e-5102ae1dd37mr24162871cf.29.1777534456853;
        Thu, 30 Apr 2026 00:34:16 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:79a:f446:21cb:22e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a81ed6bafsm76132625e9.2.2026.04.30.00.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 00:34:16 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 30 Apr 2026 09:34:06 +0200
Subject: [PATCH v4 2/2] platform/x86: x86-android-tablets: enable fwnode
 matching of GPIO chips
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260430-baytrail-real-swnode-v4-2-767bcda6667f@oss.qualcomm.com>
References: <20260430-baytrail-real-swnode-v4-0-767bcda6667f@oss.qualcomm.com>
In-Reply-To: <20260430-baytrail-real-swnode-v4-0-767bcda6667f@oss.qualcomm.com>
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
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, driver-core@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, brgl@kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4114;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=ftejCI4cDYR15DURdSwoo+KUTTkz4glwgHDYbKITpyw=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBp8wXyNbrBg8v29GzWwZQSXhoATQ3VfPNhBQPyX
 CBTZhwb0VGJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCafMF8gAKCRAFnS7L/zaE
 w74HD/9R4T00RQB0nP0oxJY0jbchVJlzM2HQLvTUIxu3XYf2kbK+9M5LCXFZDn6pP6shJQG8qg9
 jvbNZ48V+8pTQiu2nRdH5ofy4TTP97Be12edItD9zYZc3BZyaIIfoREEHbyOOXcNxbijgu2ZXgK
 aDnFxWjXdxmcJP3+44LmtBc2f66btigvbsfJ0bqpA+kXXU+pFBtW4do7ukRCaGucdQmblYoufqX
 aFul+BFkxk6RW4b1C1jMkOnsI57vXPULWviGGg1koW2eTe/uFbexumZFhUbk3lo0nZFqVQXeKTy
 w1QBbtvIGl07Q1FFKbkbuzNvJerte0vlk2XaTvUnOlqNViiKDhO5dJpPWYQT/Fl0lbJ07uv5yhc
 A7HAcqvh0fSpG0of8UbqGjbqxuRiZM+E4H8S3qIZXfof/N5D0WDZmfbNSLZVfsqz9gJwSBv1uja
 aSf/DmIUIvwc8Nq5HINCUozUGe05IUEvmVUyNfxIHkpe3JzYgUd+LNSMKGNXRx6ePOF1tSsQlOH
 4hzKHjmxsFkDi5IrYsP+BChzM7/DIcso0+CtHzTNy1fzq9x73NgmvHhL5plWj4KkJqSVDz9q7py
 BAbKRhko5Ya21J6x1Tg7FjUR0qHOE6OQUOmwLRRZ99r6LSdHxzDlZDihR8wbZyeP42Kh0pJQ1qI
 oz35jL4OLjuxAVg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: 98VlpUJcF7mExLBMzuTgPZ8M0gdH4egk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDA3MiBTYWx0ZWRfX4x7EfHPTv1g/
 Qg/Gkfv7GX/iPF2tJ4dmjK05mZxv7suwqbLrDtN4mzkUDWzA/hJAGyCKp16lt5hRFAJKbMbNWWZ
 IIHTLdtJzPMpXmwebfUB4wzzFpV0DCfUE+1NDHyFOqMMObFxnOJjbiIcLXFqfIEZ6weFMdatdSp
 aK0vCshpoIuAQ0J/pEUZ2d6PCmIdvSn8ROHBLonbKGOSNXv2itBisorIaTucWQDsUc4YwhlKPlX
 XMjdvrFNOTK1ich1ZrcAAAxwJvj+CGdPJW5Rv/uS4Lxy3CxYfGlZ8d8NQpV5UugrHe2Ks8eAm/9
 IQv5LUuBZU+ZIJ1vvTIY7Xev4zQ7BdQmdA/HPH3j/26q6WHb5bl4bnIDW9gpLdSir65EK1R9y9z
 +zFW52OTl6Ljj2kwTGB7RZZYHm6dr1flfYSiOMPDsm/cVnaVqWt31Byrs5/kseXzf5KLzVzOj0Y
 pXgccBlTTHzLmQcIP8g==
X-Proofpoint-ORIG-GUID: 98VlpUJcF7mExLBMzuTgPZ8M0gdH4egk
X-Authority-Analysis: v=2.4 cv=PvmjqQM3 c=1 sm=1 tr=0 ts=69f305fa cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=k_IdGrc-7EcYSgGcGvIA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_02,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604300072

In order to allow GPIOLIB to match cherryview and baytrail GPIO
controllers by their firmware nodes instead of their names, we need to
attach the - currently "dangling" - existing software nodes to their
target devices dynamically.

The driver uses platform_create_bundle() and expects all required
providers to be present before it itself is probed. We know the name of
the device we're waiting for so look them up and assign the appropriate
software node as the secondary firmware node of the underlying ACPI node.

Scheduling fine-grained devres actions allows for proper teardown and
unsetting of the secondary firmware nodes.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/platform/x86/x86-android-tablets/core.c | 78 ++++++++++++++++++++++++-
 1 file changed, 75 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/x86-android-tablets/core.c b/drivers/platform/x86/x86-android-tablets/core.c
index 021009e9085bec3db9c4daa1f6235600210a6099..8fd0cffe351577182f31c90c104b616cec78c481 100644
--- a/drivers/platform/x86/x86-android-tablets/core.c
+++ b/drivers/platform/x86/x86-android-tablets/core.c
@@ -13,6 +13,7 @@
 #include <linux/acpi.h>
 #include <linux/device.h>
 #include <linux/dmi.h>
+#include <linux/fwnode.h>
 #include <linux/gpio/consumer.h>
 #include <linux/gpio/machine.h>
 #include <linux/irq.h>
@@ -360,6 +361,76 @@ static const struct software_node *cherryview_gpiochip_node_group[] = {
 	NULL
 };
 
+static void auto_secondary_unset(void *data)
+{
+	struct fwnode_handle *fwnode = data;
+
+	fwnode->secondary = NULL;
+}
+
+static int acpi_set_secondary_fwnode(struct device *parent, struct device *dev,
+				     const struct software_node *const swnode)
+{
+	struct acpi_device *device = to_acpi_device(dev);
+	struct fwnode_handle *fwnode;
+	int ret;
+
+	fwnode = software_node_fwnode(swnode);
+	if (WARN_ON(!fwnode))
+		return -ENOENT;
+
+	fwnode->secondary = ERR_PTR(-ENODEV);
+	device->fwnode.secondary = fwnode;
+
+	ret = devm_add_action_or_reset(parent, auto_secondary_unset, &device->fwnode);
+	if (ret)
+		dev_err(parent, "Failed to schedule the unset action for secondary fwnode\n");
+
+	return ret;
+}
+
+static void auto_secondary_unregister_node_group(void *data)
+{
+	const struct software_node **nodes = data;
+
+	software_node_unregister_node_group(nodes);
+}
+
+static int auto_secondary_fwnode_init(struct device *parent)
+{
+	const struct software_node *const *swnode;
+	int ret;
+
+	if (!gpiochip_node_group)
+		return 0;
+
+	ret = software_node_register_node_group(gpiochip_node_group);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(parent,
+				       auto_secondary_unregister_node_group,
+				       gpiochip_node_group);
+	if (ret)
+		return ret;
+
+	for (swnode = gpiochip_node_group; *swnode; swnode++) {
+		struct device *dev __free(put_device) =
+				acpi_bus_find_device_by_name((*swnode)->name);
+		if (!dev) {
+			dev_err(parent, "Failed to find the required GPIO controller: %s\n",
+				(*swnode)->name);
+			return -ENODEV;
+		}
+
+		ret = acpi_set_secondary_fwnode(parent, dev, *swnode);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static void x86_android_tablet_remove(struct platform_device *pdev)
 {
 	int i;
@@ -391,7 +462,6 @@ static void x86_android_tablet_remove(struct platform_device *pdev)
 
 	software_node_unregister_node_group(gpio_button_swnodes);
 	software_node_unregister_node_group(swnode_group);
-	software_node_unregister_node_group(gpiochip_node_group);
 }
 
 static __init int x86_android_tablet_probe(struct platform_device *pdev)
@@ -427,9 +497,11 @@ static __init int x86_android_tablet_probe(struct platform_device *pdev)
 		break;
 	}
 
-	ret = software_node_register_node_group(gpiochip_node_group);
-	if (ret)
+	ret = auto_secondary_fwnode_init(&pdev->dev);
+	if (ret) {
+		x86_android_tablet_remove(pdev);
 		return ret;
+	}
 
 	ret = software_node_register_node_group(dev_info->swnode_group);
 	if (ret) {

-- 
2.47.3

