Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DE4248F73
	for <linux-acpi@vger.kernel.org>; Fri, 10 Jul 2026 13:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783691525; cv=none; b=Q9Rc32X5xHiY1RmNqyImkPheysmRlKqpPa3blkaMnjnmmd4Ioi03FIbsbRHzYE8JYjS4906/366iqonX0lVuc+4L26FRbsGS1ULQxMQtYb+LO8ntuhkklETx5B71YKOgZU13XwCdBkemA7qsXqFBhstWnUb97CUcETLq/Ufa4EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783691525; c=relaxed/simple;
	bh=CFrdgZbVB79JRVdgy1NMnyDL7oZ1pLItVngC17HzSWg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Omicx3ULgKQE5g7kTGKZZn2BaHeMLT2XPDBZ6BEMIX2ODH4+yWPPj+KwAC3Y+6LRXuY4AxhRLiIdc+TYgxwKamv9QM+MPFGs6pyeJVOhLfY+NM0jD4Vu8utdyUgQl/ppoTrkZLlMj/DKnRZ0ha50p3ZUOHMDKki/EX3yjHiaPrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BRkIObGH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Dn5lUw59; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BRkIObGH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Dn5lUw59"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66AD6QFU874086
	for <linux-acpi@vger.kernel.org>; Fri, 10 Jul 2026 13:52:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KjEgunGRHSr6O/b0XycHyRTbVCGHQqSoducIqInOUVA=; b=BRkIObGHJpZ/RvTr
	tXdoYM1EKR19XU+559sJYPB2JiCfJB740ay4heYLA+HnIkcM/gPVCus0vMOYgVyP
	mxSIgwnXwpYQs3nwwUO6ilMHxABSrHsaKkSUF0KDerMPIuQhd9R3t5SfX7q5Zd8i
	grZuLy7rA5yhsJsV4BOencQq/h96kVkCWKdThCWro2Vn2TUaSrXrVYRoHyR54FW3
	agrfZUmJAgqSp1hB8yvQD9A0Qw8RIqkjQtLRvghi5rWuoGKlcPufiPOpV112e0eK
	SbU1fxW/j1k19CMM3VjhxOlgtuNhu0bM8LWJPze4T7Sz8giosVuFIaq8TGnuzTMP
	ikMvYA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fax5f8wpr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Fri, 10 Jul 2026 13:52:01 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51bec738909so7660861cf.1
        for <linux-acpi@vger.kernel.org>; Fri, 10 Jul 2026 06:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783691521; x=1784296321; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KjEgunGRHSr6O/b0XycHyRTbVCGHQqSoducIqInOUVA=;
        b=Dn5lUw599XmR8TN7pGUwcYL7sG0uhpqsU35kXDwsctvuGDkRvGjndenscgy8WZAn60
         M2vEnbYTf5uoRH3VLfI/z11pvz/Vs+KVhZATB6svTgLaOxAC+Zv2S9nDpp9xwGNgJwsP
         jXu78fR58Erq3Ds6uoUqlLDAaZBBuz2gSov0u9AhwA7PNtEQde8pjjsxcXiSSen/E9//
         ytSdhYsoVbFf3yiSIt8uAf9MfK5p8JggqgR0q6/n5q0mMAeeFHKC6Y1/jet886dFCWe5
         ldveNoV9E4l8772RYgK75A1+F4iwoQBEXfRmEV1E3K1x4L92O/XNXLtwpbN8EuvYur1f
         xEqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783691521; x=1784296321;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KjEgunGRHSr6O/b0XycHyRTbVCGHQqSoducIqInOUVA=;
        b=ppmfk1m/G+87Lq2+jQm1haMjwPQUqzW9sXWd9yUiPXONyaL4bX7UE0uQ+fSciqzc8y
         XSIUn8AlWpmht7WbhYIjZTo4tOXpxfngmNYOvQzMTy9cRkz0tIoZMBUnbebR2WUm0B4U
         Jnb0ARVqjhxod1h5Rtu9ykPI3tDwmkG29kHIkSXXM+iRXC/UNc+DCPx9GIW/YgB3L6H+
         OZnAT6ygIjp6Fff1honEUtxE+SxhptbHVTn9iAEO5hn/IgO4xs7US37kW29hOF6Ek2w0
         nOuCIpu2iuadt5dLjXRMXAqap1b5Uyp2BjMgGPVDfVq+bhCqtvE2WmHJImOO2leIvs6V
         mPsg==
X-Forwarded-Encrypted: i=1; AHgh+RqreSiY9uXBzffQr5YjQVX11b7+BAtCo55GC6Q1b0EJhE4OUj3niqLDczFxP4Lm4v1pEmWyNqr2Lc9n@vger.kernel.org
X-Gm-Message-State: AOJu0YyoU65ljkS10aHKC+rXkBnP1VF5q3NLzj+xtTYWrx+kqpp+ge1q
	1UuOLEGVEe6xXTAYttgp7BL5PBDD4Hu7NK+9jfczELJpJhs1zLDbl9sF+kpD/EX9w1wc7tUz6Tj
	LHhCAJzrQPWQZwOdOayLefvwXOg/qWfL2syyfiZwHNgk1rUODqMocoFCDHCd+6CWh
X-Gm-Gg: AfdE7ckDJM1Mn9rAvX+kv8LNSKKdmP13OPvulQ8Q6sq8qyD/Ap2hig5xo2BdDXGJnFP
	uOn2tH3fz860U13qAHfCgrRnB6fuI9k0NFkybZ943gtud53Kl9pHi4CO3dEqGDjqaoTrhneQvvU
	9UF7+fuj4n4tc+F2W8JfiSpb6upNHcb29xiAwe9g3N2DNsr/q7tQLfNOr5Ptx+WqeeYZJi0doG0
	+kywcZx7V9vfHfDiPwHOG+5VFCrAoCI/PjaNCIbClS2Ad/9xhlUnG7pwMmAbUoleTA8ZFlJHZRW
	sXm5pVkw4dAEpQ6lG1xkNAfHMspsi4iqI5rHhWngMEIP3UKSppTjUOyhqb3CavRUee25d9g4jc+
	TyDMxhhEFo+hafJJrEhRm8iUBJV3D+PocTrIGokgI
X-Received: by 2002:a05:622a:94d:20b0:51c:8dee:964e with SMTP id d75a77b69052e-51c8dee99c0mr79277801cf.57.1783691521005;
        Fri, 10 Jul 2026 06:52:01 -0700 (PDT)
X-Received: by 2002:a05:622a:94d:20b0:51c:8dee:964e with SMTP id d75a77b69052e-51c8dee99c0mr79277411cf.57.1783691520473;
        Fri, 10 Jul 2026 06:52:00 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:adb6:d740:6427:4097])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb670a41sm135669295e9.0.2026.07.10.06.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 06:51:59 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 15:51:24 +0200
Subject: [PATCH v3 5/5] gpio: kunit: add test cases verifying swnode
 devlink support
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-swnode-fw-devlink-v3-5-993f31874e40@oss.qualcomm.com>
References: <20260710-swnode-fw-devlink-v3-0-993f31874e40@oss.qualcomm.com>
In-Reply-To: <20260710-swnode-fw-devlink-v3-0-993f31874e40@oss.qualcomm.com>
To: Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-acpi@vger.kernel.org,
        driver-core@lists.linux.dev, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=11893;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=CFrdgZbVB79JRVdgy1NMnyDL7oZ1pLItVngC17HzSWg=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqUPjvL2HjJuGt7YLd4fcBkX1g9NoN6biwfYpp9
 gtdKaCEhMaJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCalD47wAKCRAFnS7L/zaE
 w/TVEACkrSG5GWFakHjwZcx76ywa5Daf3KasZhOxBAU5ZkO3p791QFyumsb04oSzWDJaPZUhtkj
 azES/YungvYC+wldy6E+6Szv2zFDSpp1cNeatSo8XWPHeueP6Jqg4/FvRAJYd52TJcxV7VRuLWP
 XBsVLNJIJdmuPTLimmZ4IA81DGDXlSvk3F1rJxuPMfGxjSgrn86VyVNzIu04KCTdW3rDatSGvio
 1OCg9FoK5J/H2ao00hJKCENlYMs5IgpN5BpQJ58/ZKQrR1rEgQHN3T/3FCiwyhLlqEqmUkfze96
 jqY/bD7GY4ipoIsxTzIXXnUkjTgbiqHe4uVoeGuLUxSUT28CTdkoJCpeCiBX0Co7MEYkoLcY0Xk
 4gRzDm158P9RG10sm6/CXOchX4b4JW5QGJ+89zymKWwsXx4aKZHv+28WsRqOcr7GojfbS6sEpm1
 R7tqzouAUbisPevad8Ahb6f7lIdvR4PKETIMCMw9xHA6qYDe2b1yyDXU/bOlKUQWDqSd4sZoa33
 pkhyRYa4VcWRNMFZXkhc8MgobBjahV+4MSJVo2phldSJ8+6hCtpf+PE2f0BjwBPN2Eni3T3zKPI
 oRbIsZE9gVjhtkamEx7pvmq8fO6tKPxWylgusHdqgv/8werkOPDo+4nQH6EjPjuc17Ah64Kk+uU
 0/qvcyzS6J+/F3Q==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=Ab2B2XXG c=1 sm=1 tr=0 ts=6a50f901 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=QyXUC8HyAAAA:8
 a=EUspDBNiAAAA:8 a=r134EpD-t8S8Nhkp70wA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: Ihcn6BbkH4FJOVcahflGkTgQcTK7WIHk
X-Proofpoint-GUID: Ihcn6BbkH4FJOVcahflGkTgQcTK7WIHk
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDEzNiBTYWx0ZWRfX0R+sWOTTQe+E
 6MblZAL2cNFcba+2fV0qN9mVsV7mNM6mRRWgReLf07cYN3nnkIKiqV6MkWeeUnlJM/KPvuamBXW
 d9XecZier4tClPL6uqofAHl20msYPE8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDEzNiBTYWx0ZWRfX/+z1hOfa+yYI
 8W2seh5FgSqLvpvx8VfvUMneur6s6mgYPWzY5uoha59IX67wxrkJDTXc4hoPiXoh5lfWf0Zrpb6
 DDkvDKpc85xgg0YcTpsKT1hv1slXlqE1lXyKTVW70XPln7761NiAmqjH6Jj0QC46T71p8X3GTwH
 04uWx/LNC79vKjU8pbon/AsyfPfFEPMhjmL+mwTtKP3PBA/WTaV1Hsab+T06IAf1kr4ibD1GIqr
 5Q0dyDUvaAeF+zFgjGfP3QmgM5vjX1KmnRyUdobypSMHVCjoqDlFUS/Uk+umLZZ7uoLX9yyScDL
 j92BJLBEZ8a2cU9YuXhFGdwOXrf35SOpoQnGeJgUQklcEtBLBAtJ57eEPT12CGBDQZEIH6TWKxc
 9AIqjmV7a7HXQa8IOBQANJMEZTwp7kYqp5kNB1PraZv2ZxkFufu0RJPJO4pUIt/Ha6j6L6Jlnln
 0XGSSZkSQiUkla/3BBA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 phishscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100136

The software node fw_devlink support already has its own kunit suite, but
that verifies the fwnode links in isolation. Add GPIO tests that prove
the ordering works in a real-life use-case: a GPIO consumer that
references its provider via a software node.

The first suite registers the provider's software node, adds the consumer
device first and checks that fw_devlink defers its probe until the
provider has been added and bound. The second covers the fallback:
with the provider's software node not yet registered no supplier link is
created, so the consumer probes, devm_gpiod_get() returns -EPROBE_DEFER
and the consumer only binds once the provider shows up.

While at it: the existing gpio_unbind_with_consumers() test keeps the
consumer bound while the provider goes away and then operates the orphaned
descriptor. With software nodes now being covered by fw_devlink that would
instead force-unbind the consumer along with the provider, so opt it out
by setting FWNODE_FLAG_LINKS_ADDED.

Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/gpio/gpiolib-kunit.c | 286 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 279 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpiolib-kunit.c b/drivers/gpio/gpiolib-kunit.c
index 380b68f879e55433668353bb88067d561142a5bc..ad961cf97aee7b1b6e3fb64c9f5d52be25486253 100644
--- a/drivers/gpio/gpiolib-kunit.c
+++ b/drivers/gpio/gpiolib-kunit.c
@@ -3,6 +3,8 @@
  * Copyright (C) Qualcomm Technologies, Inc. and/or its subsidiaries
  */
 
+#include <linux/cleanup.h>
+#include <linux/err.h>
 #include <linux/fwnode.h>
 #include <linux/gpio/consumer.h>
 #include <linux/gpio/driver.h>
@@ -11,12 +13,16 @@
 #include <linux/notifier.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
+#include <linux/types.h>
 
+#include <kunit/fwnode.h>
 #include <kunit/platform_device.h>
 #include <kunit/test.h>
 
 #define GPIO_TEST_PROVIDER		"gpio-test-provider"
 #define GPIO_SWNODE_TEST_CONSUMER	"gpio-swnode-test-consumer"
+#define GPIO_PROBE_ORDER_TEST_CONSUMER	"gpio-probe-order-test-consumer"
+#define GPIO_PROBE_DEFER_TEST_CONSUMER	"gpio-probe-defer-test-consumer"
 #define GPIO_UNBIND_TEST_CONSUMER	"gpio-unbind-test-consumer"
 
 static int gpio_test_provider_get_direction(struct gpio_chip *gc, unsigned int offset)
@@ -213,6 +219,262 @@ static struct kunit_suite gpio_swnode_lookup_test_suite = {
 	.test_cases = gpio_swnode_lookup_tests,
 };
 
+static void gpio_swnode_unregister_swnode(void *data)
+{
+	software_node_unregister(data);
+}
+
+struct gpio_probe_order_pdata {
+	unsigned int probe_count;
+	bool gpio_ok;
+};
+
+static const struct gpio_probe_order_pdata gpio_probe_order_pdata_template = {
+	.probe_count = 0,
+	.gpio_ok = false,
+};
+
+static int gpio_probe_order_consumer_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct gpio_probe_order_pdata *pdata = dev_get_platdata(dev);
+	struct gpio_desc *desc;
+
+	pdata->probe_count++;
+
+	desc = devm_gpiod_get(dev, "foo", GPIOD_OUT_HIGH);
+	if (IS_ERR(desc))
+		return PTR_ERR(desc);
+
+	pdata->gpio_ok = true;
+
+	return 0;
+}
+
+static struct platform_driver gpio_probe_order_consumer_driver = {
+	.probe = gpio_probe_order_consumer_probe,
+	.driver = {
+		.name = GPIO_PROBE_ORDER_TEST_CONSUMER,
+	},
+};
+
+/*
+ * Verify that fw_devlink orders the probe of a GPIO consumer after its
+ * provider. The consumer references the provider through a software node and
+ * is registered first. fw_devlink must defer it before its driver's probe()
+ * is ever entered, so the consumer probes exactly once - only after the
+ * provider is added and bound.
+ */
+static void gpio_swnode_probe_order(struct kunit *test)
+{
+	struct property_entry properties[2] = { };
+	struct gpio_probe_order_pdata *pdata;
+	struct platform_device_info pdevinfo;
+	struct platform_device *prvd, *cons;
+	bool bound = false;
+	int ret;
+
+	ret = kunit_platform_driver_register(test, &gpio_test_provider_driver);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	ret = kunit_platform_driver_register(test, &gpio_probe_order_consumer_driver);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	ret = software_node_register(&gpio_test_provider_swnode);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	ret = kunit_add_action_or_reset(test, gpio_swnode_unregister_swnode,
+					(void *)&gpio_test_provider_swnode);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	properties[0] = PROPERTY_ENTRY_GPIO("foo-gpios",
+					    &gpio_test_provider_swnode,
+					    0, GPIO_ACTIVE_HIGH);
+
+	pdevinfo = (struct platform_device_info){
+		.name = GPIO_PROBE_ORDER_TEST_CONSUMER,
+		.id = PLATFORM_DEVID_NONE,
+		.data = &gpio_probe_order_pdata_template,
+		.size_data = sizeof(gpio_probe_order_pdata_template),
+		.properties = properties,
+	};
+
+	cons = kunit_platform_device_register_full(test, &pdevinfo);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, cons);
+
+	wait_for_device_probe();
+	scoped_guard(device, &cons->dev)
+		bound = device_is_bound(&cons->dev);
+
+	KUNIT_ASSERT_FALSE(test, bound);
+
+	pdata = dev_get_platdata(&cons->dev);
+	KUNIT_ASSERT_EQ(test, pdata->probe_count, 0);
+	KUNIT_ASSERT_FALSE(test, pdata->gpio_ok);
+
+	pdevinfo = (struct platform_device_info){
+		.name = GPIO_TEST_PROVIDER,
+		.id = PLATFORM_DEVID_NONE,
+		.swnode = &gpio_test_provider_swnode,
+	};
+
+	prvd = kunit_platform_device_register_full(test, &pdevinfo);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, prvd);
+
+	wait_for_device_probe();
+
+	scoped_guard(device, &prvd->dev)
+		bound = device_is_bound(&prvd->dev);
+	KUNIT_ASSERT_TRUE(test, bound);
+
+	scoped_guard(device, &cons->dev)
+		bound = device_is_bound(&cons->dev);
+	KUNIT_ASSERT_TRUE(test, bound);
+
+	pdata = dev_get_platdata(&cons->dev);
+	KUNIT_ASSERT_EQ(test, pdata->probe_count, 1);
+	KUNIT_ASSERT_TRUE(test, pdata->gpio_ok);
+}
+
+struct gpio_probe_defer_pdata {
+	unsigned int probe_count;
+	int gpio_err;
+};
+
+static const struct gpio_probe_defer_pdata gpio_probe_defer_pdata_template = {
+	.probe_count = 0,
+	.gpio_err = 0,
+};
+
+static int gpio_probe_defer_consumer_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct gpio_probe_defer_pdata *pdata = dev_get_platdata(dev);
+	struct gpio_desc *desc;
+
+	pdata->probe_count++;
+
+	desc = devm_gpiod_get(dev, "foo", GPIOD_OUT_HIGH);
+	if (IS_ERR(desc)) {
+		pdata->gpio_err = PTR_ERR(desc);
+		return pdata->gpio_err;
+	}
+
+	pdata->gpio_err = 0;
+
+	return 0;
+}
+
+static struct platform_driver gpio_probe_defer_consumer_driver = {
+	.probe = gpio_probe_defer_consumer_probe,
+	.driver = {
+		.name = GPIO_PROBE_DEFER_TEST_CONSUMER,
+	},
+};
+
+/*
+ * Verify that a GPIO consumer referencing a provider whose software node is
+ * not registered yet, defers its probe instead of failing.
+ *
+ * The provider software node is deliberately left unregistered when the
+ * consumer is added. fw_devlink cannot resolve the reference, so it creates no
+ * supplier link and does not order the consumer - the consumer's probe() runs
+ * and reaches devm_gpiod_get(). The swnode GPIO lookup returns -ENOTCONN for a
+ * reference to an unregistered node, which gpiolib maps to -EPROBE_DEFER. Once
+ * the provider software node and device appear, the deferred consumer probes
+ * again and binds.
+ */
+static void gpio_swnode_probe_defer_on_unregistered(struct kunit *test)
+{
+	struct property_entry properties[2] = { };
+	struct gpio_probe_defer_pdata *pdata;
+	struct platform_device_info pdevinfo;
+	struct platform_device *prvd, *cons;
+	struct fwnode_handle *fwnode;
+	bool bound = false;
+	int ret;
+
+	ret = kunit_platform_driver_register(test, &gpio_test_provider_driver);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	ret = kunit_platform_driver_register(test, &gpio_probe_defer_consumer_driver);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	properties[0] = PROPERTY_ENTRY_GPIO("foo-gpios",
+					    &gpio_test_provider_swnode,
+					    0, GPIO_ACTIVE_HIGH);
+
+	pdevinfo = (struct platform_device_info){
+		.name = GPIO_PROBE_DEFER_TEST_CONSUMER,
+		.id = PLATFORM_DEVID_NONE,
+		.data = &gpio_probe_defer_pdata_template,
+		.size_data = sizeof(gpio_probe_defer_pdata_template),
+		.properties = properties,
+	};
+
+	cons = kunit_platform_device_register_full(test, &pdevinfo);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, cons);
+
+	wait_for_device_probe();
+	scoped_guard(device, &cons->dev)
+		bound = device_is_bound(&cons->dev);
+
+	KUNIT_ASSERT_FALSE(test, bound);
+
+	pdata = dev_get_platdata(&cons->dev);
+	KUNIT_ASSERT_GT(test, pdata->probe_count, 0);
+	KUNIT_ASSERT_EQ(test, pdata->gpio_err, -EPROBE_DEFER);
+
+	fwnode = kunit_software_node_register(test, &gpio_test_provider_swnode);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fwnode);
+
+	pdevinfo = (struct platform_device_info){
+		.name = GPIO_TEST_PROVIDER,
+		.id = PLATFORM_DEVID_NONE,
+		.swnode = &gpio_test_provider_swnode,
+	};
+
+	prvd = kunit_platform_device_register_full(test, &pdevinfo);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, prvd);
+
+	wait_for_device_probe();
+
+	scoped_guard(device, &prvd->dev)
+		bound = device_is_bound(&prvd->dev);
+	KUNIT_ASSERT_TRUE(test, bound);
+
+	scoped_guard(device, &cons->dev)
+		bound = device_is_bound(&cons->dev);
+	KUNIT_ASSERT_TRUE(test, bound);
+
+	pdata = dev_get_platdata(&cons->dev);
+	KUNIT_ASSERT_EQ(test, pdata->gpio_err, 0);
+}
+
+static int gpio_swnode_probe_order_test_init(struct kunit *test)
+{
+	/*
+	 * A prior test may have left a managed device link teardown queued on
+	 * the device_link_mq. Flush it so that software_node_register()
+	 * doesn't spuriously see the node as registered and fail with -EEXIST.
+	 */
+	device_link_wait_removal();
+
+	return 0;
+}
+
+static struct kunit_case gpio_swnode_probe_order_tests[] = {
+	KUNIT_CASE(gpio_swnode_probe_order),
+	KUNIT_CASE(gpio_swnode_probe_defer_on_unregistered),
+	{ }
+};
+
+static struct kunit_suite gpio_swnode_probe_order_test_suite = {
+	.name = "gpio-swnode-probe-order",
+	.test_cases = gpio_swnode_probe_order_tests,
+	.init = gpio_swnode_probe_order_test_init,
+};
+
 static BLOCKING_NOTIFIER_HEAD(gpio_unbind_notifier);
 
 struct gpio_unbind_consumer_drvdata {
@@ -310,15 +572,24 @@ static void gpio_unbind_with_consumers(struct kunit *test)
 					    0, GPIO_ACTIVE_HIGH);
 	properties[1] = (struct property_entry){ };
 
-	pdevinfo = (struct platform_device_info){
-		.name = GPIO_UNBIND_TEST_CONSUMER,
-		.id = PLATFORM_DEVID_NONE,
-		.properties = properties,
-	};
-
-	cons = kunit_platform_device_register_full(test, &pdevinfo);
+	/*
+	 * This test deliberately keeps the consumer bound while the provider
+	 * is unregistered. fw_devlink would force-unbind the consumer before
+	 * the provider so use the FWNODE_FLAG_LINKS_ADDED flag to opt out of
+	 * it as a workaround.
+	 */
+	cons = kunit_platform_device_alloc(test, GPIO_UNBIND_TEST_CONSUMER,
+					   PLATFORM_DEVID_NONE);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, cons);
 
+	ret = device_create_managed_software_node(&cons->dev, properties, NULL);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	fwnode_set_flag(dev_fwnode(&cons->dev), FWNODE_FLAG_LINKS_ADDED);
+
+	ret = kunit_platform_device_add(test, cons);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
 	wait_for_device_probe();
 	scoped_guard(device, &cons->dev)
 		bound = device_is_bound(&cons->dev);
@@ -350,6 +621,7 @@ static struct kunit_suite gpio_unbind_with_consumers_test_suite = {
 
 kunit_test_suites(
 	&gpio_swnode_lookup_test_suite,
+	&gpio_swnode_probe_order_test_suite,
 	&gpio_unbind_with_consumers_test_suite,
 );
 

-- 
2.47.3

