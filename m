Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDC6364E92
	for <linux-acpi@vger.kernel.org>; Mon, 29 Jun 2026 10:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782730371; cv=none; b=uEt/+IwZnqXMDX0yOPfVMFD30Va5n1a5CuhP1916UTSJY0DKtdhdRXxihCXfHaGWeJ5pve+dmvIqI/gkLRJ6uS4mtpmzcxlUyhTVS0Kf9Pr3Rl14UGQouoEB1JHFKzSDyEMTdyiluZXPNZ9qZ+K/bs1gkOVKHUjKxJE7tRkCYTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782730371; c=relaxed/simple;
	bh=5ZYuxtVNXiy5hSdL+C+93oIsymaS+bqU3K2XV8qrldc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t/rywrGUIiQxe63IRHSMy/90E3+3yC4y2xaRUSdX7MmXEDWvdqrix+wFo+vZRGN9pGYo0dxPF9LmGMwY9fr/v5Bf7rdLw/g9W8PzkGmqtEmKCcW/RzaP73DlyfgCAdXpWtcNZSjzbWvpfL7Rb7wOS2By9/+XpNn6gllKwnPwidU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=faSEqvcA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=V1MIqbhE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="faSEqvcA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="V1MIqbhE"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65TAT7i52627945
	for <linux-acpi@vger.kernel.org>; Mon, 29 Jun 2026 10:52:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	v9u/dWN+tesK5LB6sPBgJ7HTGERuPeKrSaSRCLi4Ip0=; b=faSEqvcA+pJv8InT
	cNq0Np5SG+ld9e3NXoHgKZuYJAQWqAgyLhwTbnW9tYW30gBMndZZWhqhZF4nTMmD
	sA/VZXMutKHNHlwj+iOEv31+B/qtZdQEtZStlZXdqcbvP6+0fcBIAhYi6/aZyrRE
	ux6kzEiIs8PRtFT+d7Agvf53iYRDnqEf2rkfVVbu3ZAoVzSPvNP5tkMU8evVXvyl
	auVg3gPdTjzITd+AY1/Ua62EFAZetlcDWPJ1mLB3UvmPPSyvAbY9R/dibL1jniCa
	8euoKj5TCDyV7dMKPii0zVZIVUigA20S8cj/Yzj+XIClVf+BjpKlc8AYCv3nZc7y
	u+VP8Q==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3nbgrgya-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Mon, 29 Jun 2026 10:52:45 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92158791d14so388879485a.2
        for <linux-acpi@vger.kernel.org>; Mon, 29 Jun 2026 03:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782730365; x=1783335165; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v9u/dWN+tesK5LB6sPBgJ7HTGERuPeKrSaSRCLi4Ip0=;
        b=V1MIqbhE/vtbXHuLrVnWPvV/S1aGwOcxp8hva+hiiDto+boyX2Rqu5FyyjFB0PoO8F
         9wlT9CEOZ1cnB9UUn71d5MpK1Xl7GeU8Y6C2hAlbgfNudFY+Rk6puO3KfZXjST3Cz/Gb
         vMIuSL+GrPfp76DeGLZKl82pFghdaCb3GyNnjKy9QE5i8QkEXMN7NJsyF7kx/17ikVBe
         Vow4vgf2EMJZ2oeHjXzjDrKaYJO4B9601T9OOzSFZUY8wU/mdV9Zf856/ASOJ1puPNt1
         MxW9y2AGhc9xMuhTNk5peazzusnG+eF0Kmhqd+1c265Hhi77+PsueAS6XKtbnbZivYSr
         lLgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782730365; x=1783335165;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=v9u/dWN+tesK5LB6sPBgJ7HTGERuPeKrSaSRCLi4Ip0=;
        b=G694obg8HwDqH5lXwL+mbQpiOeZ65S/CPYifzGYeye8Wx/XS5IRCi9C7RXKGnIvald
         ZPmUG5zrVrSkq4EoaPXH5Ay4HCNZmP9frW3XKkebT48SNf9/U4M/Dgz7mtvCDTWf9S8w
         5JyEfTouRONa2sCWBzGf+lcXWbXJu/UPqenvVaZqmSP3X5ugiwRTjSAaEgm+DeqpYLTG
         37GGCFiRZSnoJ6EWpQq1byRHok6pJWR516JmCuJa+E+2qm87kYDQIK9zYPpyS/bu6TFE
         j2Dd28ai6uyLhi/PUZBiLNiZSB3hxzjm5+F9HXChY81xNm9EtjUAlHHHGJL8A6/eDwsG
         fOUw==
X-Forwarded-Encrypted: i=1; AFNElJ/Tz9GOkaz94Qr0EVjKZMdcWF52E43LLbWuDZ/AIt/4ZdiZLhimcuvrzQhNSCCHFlg4nUB3WNB/UwAk@vger.kernel.org
X-Gm-Message-State: AOJu0YxUcYukGxnKIop4rGbivFgYDF2+cu5ZEjILZ09OmbmxI1HKWRe4
	GV5GLwxdgoTdgm7HNuiMqzaVn0y96ZT981q0Rc4/QDPynF8SB4tv1tcjEr5TVvvqjq+NOj7YOAD
	U60OmWmwzkT8oxJ3B1L+AEfqQw1NJxBHVSb/wnAi9rnzaHS6GBgspO3/vVYW2aSk4
X-Gm-Gg: AfdE7cnK0NtgAoCYUU/ANR7b/Z0ef94NohPSm8Wbb4LGOhph1SrPjYAOVNTmIlkL/Rp
	SejIjTpUm2RUin3AtO54VafnUP54VvVWM2RBb0nv3O75QXxLg7MGGnBDWMKJ3ZfHkT/ghacUZaU
	jrBelj5nJ1n2Rd/gleKO5WBnfIdOicFwZBdKXDTaR7FwYJsqd4rTApT7k7oLXr1u6OOrgEubcFO
	u8SxQfUJG7uPRGtGuNLsK2z7kbawsarpVmnlo6MC6UkUMqIaOnQw60sMwVMLdO1BhUF7/bJqxX5
	bNyiSs8P7uQXpKrSS9ZKMJmjX4h9SEg69sUeTYjon/T9bxAp7103aOYuWkiN6bWRmVn8yc5PnL0
	wr99sRzIuX9WJAzc/l/b89swpl7tI7nNUa5kO1DQn
X-Received: by 2002:a05:620a:319e:b0:91e:e613:9cca with SMTP id af79cd13be357-9293bd3b235mr2723046085a.21.1782730364682;
        Mon, 29 Jun 2026 03:52:44 -0700 (PDT)
X-Received: by 2002:a05:620a:319e:b0:91e:e613:9cca with SMTP id af79cd13be357-9293bd3b235mr2723039085a.21.1782730364003;
        Mon, 29 Jun 2026 03:52:44 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:4640:d76a:6126:9b65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4726b76e6f8sm18341754f8f.13.2026.06.29.03.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 03:52:43 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 12:52:10 +0200
Subject: [PATCH 5/5] gpio: kunit: add test cases verifying swnode devlink
 support
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-swnode-fw-devlink-v1-5-b90058b41839@oss.qualcomm.com>
References: <20260629-swnode-fw-devlink-v1-0-b90058b41839@oss.qualcomm.com>
In-Reply-To: <20260629-swnode-fw-devlink-v1-0-b90058b41839@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=11189;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=5ZYuxtVNXiy5hSdL+C+93oIsymaS+bqU3K2XV8qrldc=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqQk5w1zk+Mz9TW/IaUck8XEm8Emm5Zbx2HYxdW
 lTy/RxFo7yJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakJOcAAKCRAFnS7L/zaE
 w0YKD/wK69HCHBEyql5qyIMiBAV03zmpZVLBiVBpNuqGnlNI1Nrrt5qelYc2Y6FYkKha7fc7Dod
 KdsF/0AqQ8ErbVc9bPlH3UvpN/zWsfW/MQG1J/C1xZP/SpWtC5nQAx5GmJsJF+U+X/26ghZxIZH
 qX6cLSRXr/6FUEpsgVlSKFelGh66KBm1ynyj5ucH9QGhwleslvzkNX+e2tCUbSMtm7BEXPqT5bK
 76dAwdGBlanudXWRxpPL21Il/W0Mt6ovQsKvhhSQl7B8x9iAbzey2NmwYmo8pqy6iRM1ybeI7SC
 T3WDKYhaxZIkGGp+NGVyumCoiOC7xRBIz/QeapT+yG54l8rJQtXDeVEXWbqykl5UhmUk5wym95i
 bUz0rlJ8hrdN4uswK7zAQDEl5B1zn3Dc+mbxLbqqltAffkKLj27AdUvzdNHs7pTqWlTX/wYBhS8
 WtESN3eTQFGDYb2ArC+nSw0syda0/rsTO/2a+a7JdPbOgLudnUtRJjsprMGo0D3nxnfVw2rfJJF
 Ytqi/EzwZxdmmUKMVh2TsKglbIyvjpga+hB4chpD3RvppyxpflcyUiMJj2h2QmTr8hv8we84yMJ
 DAcz8lBOqejJ7I6xc43ciYxEamcIisgeBqUUx3fJCx7e3WRNrxPfSHuIVnrcy/5IIpC6GHYgLU1
 lKI5uXazPqEd27A==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: gdqv-lOpDlAF6Fi393M7jP1voyFfUGCJ
X-Authority-Analysis: v=2.4 cv=Z4Hc2nRA c=1 sm=1 tr=0 ts=6a424e7d cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=L6j-Bhk0s3QyjTGi4sQA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA4OCBTYWx0ZWRfX4Xc4SssZ5ZJh
 YOIkISZ/dvoZqzstAaYRVGsa10cu/qVYgRjdoMAmm+5mBZUEE6BZ4CgHL+zNXoc0vdvgd4FYi+D
 B3S2i3ARSGa9GPnwIs5B+Fb1ajz3cR0=
X-Proofpoint-GUID: gdqv-lOpDlAF6Fi393M7jP1voyFfUGCJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA4OCBTYWx0ZWRfX98BCftNF9/4U
 6+wjdZ0fdAssYgyuhahP6ShSIAb/ofKaQCLmN8q2vCJa/lPIi9IeVuoUej94LjsynMh4sYaie6U
 a4bR0hT9ukeVfOneRAEmDQCEvcw+LAWh8qf4m41dlzIvcwevd1QbLSlWS0b0ZoLQfRVotLE6+CY
 quqWKPZOTwoaZinc8LE/qm8Gf+4z8BQdu0Ts/XhCqYKvmdEWGqtrbvvCkOfDptlFu58oeePAtXD
 uGyZxlF1EIFAOp6UbWrh+pNrEJMjMI98wIJTy6xNYvoQ1k1CsT1Pf3HgXCCH7TyoM+4SDrwRX5m
 aIzU8wSL11BJMWD0M5Y5IQ4+OiRTC9wp0bugPx2RDQI6UoskbX3sUQ37cQ+wTACxYzWnmDc4821
 Qv2rdiden5PxYba3JN35h2dgp08IQ8rwT5I5Gl+FUaA55gANxNzsyIN2xsViItqmxxi1K0M0fWP
 AXeSN2rlS6rKWlj9b4A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606290088

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

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/gpio/gpiolib-kunit.c | 272 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 265 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpiolib-kunit.c b/drivers/gpio/gpiolib-kunit.c
index 380b68f879e55433668353bb88067d561142a5bc..3def39f11ece46557cbdf8bae8642b2ad21232f0 100644
--- a/drivers/gpio/gpiolib-kunit.c
+++ b/drivers/gpio/gpiolib-kunit.c
@@ -12,11 +12,14 @@
 #include <linux/platform_device.h>
 #include <linux/property.h>
 
+#include <kunit/fwnode.h>
 #include <kunit/platform_device.h>
 #include <kunit/test.h>
 
 #define GPIO_TEST_PROVIDER		"gpio-test-provider"
 #define GPIO_SWNODE_TEST_CONSUMER	"gpio-swnode-test-consumer"
+#define GPIO_PROBE_ORDER_TEST_CONSUMER	"gpio-probe-order-test-consumer"
+#define GPIO_PROBE_DEFER_TEST_CONSUMER	"gpio-probe-defer-test-consumer"
 #define GPIO_UNBIND_TEST_CONSUMER	"gpio-unbind-test-consumer"
 
 static int gpio_test_provider_get_direction(struct gpio_chip *gc, unsigned int offset)
@@ -213,6 +216,251 @@ static struct kunit_suite gpio_swnode_lookup_test_suite = {
 	.test_cases = gpio_swnode_lookup_tests,
 };
 
+static void gpio_swnode_unregister_swnode(void *data)
+{
+	software_node_unregister(data);
+}
+
+struct gpio_probe_order_pdata {
+	int probe_count;
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
+	struct gpio_probe_order_pdata *pdata;
+	struct platform_device_info pdevinfo;
+	struct property_entry properties[2];
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
+	properties[1] = (struct property_entry){ };
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
+	int probe_count;
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
+	struct gpio_probe_defer_pdata *pdata;
+	struct platform_device_info pdevinfo;
+	struct property_entry properties[2];
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
+	properties[1] = (struct property_entry){ };
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
+static struct kunit_case gpio_swnode_probe_order_tests[] = {
+	KUNIT_CASE(gpio_swnode_probe_order),
+	KUNIT_CASE(gpio_swnode_probe_defer_on_unregistered),
+	{ }
+};
+
+static struct kunit_suite gpio_swnode_probe_order_test_suite = {
+	.name = "gpio-swnode-probe-order",
+	.test_cases = gpio_swnode_probe_order_tests,
+};
+
 static BLOCKING_NOTIFIER_HEAD(gpio_unbind_notifier);
 
 struct gpio_unbind_consumer_drvdata {
@@ -310,15 +558,24 @@ static void gpio_unbind_with_consumers(struct kunit *test)
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
@@ -350,6 +607,7 @@ static struct kunit_suite gpio_unbind_with_consumers_test_suite = {
 
 kunit_test_suites(
 	&gpio_swnode_lookup_test_suite,
+	&gpio_swnode_probe_order_test_suite,
 	&gpio_unbind_with_consumers_test_suite,
 );
 

-- 
2.47.3

