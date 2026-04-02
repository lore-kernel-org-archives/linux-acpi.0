Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECB23CCFBA
	for <linux-acpi@vger.kernel.org>; Thu,  2 Apr 2026 12:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775134507; cv=none; b=YUgR0YBgCtaQAVUcyjEpMn8jre7r1Cgc0XQW36T/3TfB1zLRfHivZEQ0qoWN5oLXa2HjUNpNJhzwHxCfsYSLQvk2mutXuCjIgK7ZJsU0wLO27M5xumdxDyu6aaM+PiOgm5JzcQdZXJ0EgDiY4+w0Qn0380OoCIFIFNqiOW+ab90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775134507; c=relaxed/simple;
	bh=l4lnny3dGBJZoHOBatk5qgjCf18AZd9xMDIK67fuBWk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TS7QbYI0kQtHuJJoBymum8PfJQJc7VFqTGvGNYa2AbL8cnXmFZ1EIdWHkTaLSntFmgXYJSCr870cXpaEjMsNhzJ5M65sJd36KAtOYJ5ukpOETCpmRwG20oyC4HJrf9Lpgw1/Rlf+G+ouH6LRnAZC2cmAygNO8pbiS7jTytiUO0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Gjy5tC9H; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZRbqAa7l; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Gjy5tC9H";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZRbqAa7l"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 632BZWkK1965398
	for <linux-acpi@vger.kernel.org>; Thu, 2 Apr 2026 12:54:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iM/iRe3Y9krYEM1ss3kFNB7NzrAjyV60b2tj+n+iAZU=; b=Gjy5tC9HSrvA4MBe
	ft7EyL8vxe85ZjKbVY2cC7FBFLVBxAs/u8oR3EWpZ4Jtb562VrkBB+ACGPv/hCkW
	C+5kNFh1NBq2jZN/KQr+OHx2qgxwPzRFwxHGkMLyFJi7WvlNtdtH+XsWbLD1GVt9
	Re8qJc1OvAlsHGWWAamMs6vmnFlkhcOVygQiQk5/cybCxoojB0j0mqRKPAkaFpbk
	JUGNaQXxAcF3/y0qMFzWiEZhuEoZSYuxr8gwVADixo9XVMoAjDUt0eJ7ElJBuyZu
	CwL5GF3JKk8T6dVDAgLwJhgUX/aZLyp8vuS9WCJFk3oFsUcoJ9NqqozMU4sXxGU3
	0079mA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d9b9h38gu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Thu, 02 Apr 2026 12:54:55 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5094741c1c1so23515641cf.1
        for <linux-acpi@vger.kernel.org>; Thu, 02 Apr 2026 05:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775134494; x=1775739294; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iM/iRe3Y9krYEM1ss3kFNB7NzrAjyV60b2tj+n+iAZU=;
        b=ZRbqAa7lUEpayD57Igl2dXFVIE43Ti/FaSALIbp+u5OipNMC8HAXIgp8mp5LH+xV2u
         6sz/6Ski6Fi9zz3MtuVI1LUZoGoXIMKFEmmIm9G5rniYtGyVx2L8jbNgGXQ6DEKd6c3o
         6sSM4LecdySn9k8VGVK4KymdjVwYzrJ/5/5rk8nj68ItqdJEFSw012VApFqwx6Le05Cl
         0EWsKr1owWQ0MeCRBNsBGh0QbTkdugRdUgpXtRCHbU0cM1ZFZjhDj9FPy0qaFcvzEIQ6
         MSDfgQCqGbvkbyUne1hLM47ThKmCRAINpaPi0GRem1cIjIT5kHS1WbtiTCFNHllw9r8i
         iXxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775134494; x=1775739294;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iM/iRe3Y9krYEM1ss3kFNB7NzrAjyV60b2tj+n+iAZU=;
        b=LVUFSzh5zNzXAhpCRafQEnLJPaIy1ogMfs0AJTDg8C78zxjGAWugv4CDzItZTFGQPc
         KfKK+nyN9V/uyxpeYcPwanZu0mEk750R5XFyk9HRMWR+S8DcfShgq+ueXGocbcf2q7cO
         7Fc/SyUU7qAdNQ52ELuUTPTsTLn0QFRAtk4v1vrdQGdDrZmqeTEVqosoJcRWZKQOGqAJ
         rCcCN8GPPF9yrRthH6s8ezlp838i+taCFG8ksN4WvTQSmy823DHxdmYL5SvTllpDkatc
         e2xbMVMW2IXiFUfEw15YDqEaDfwfOGbFJMwHyvzi+yrzTC0MqBU3IWUFmBEAWQcEuSYw
         P0gQ==
X-Gm-Message-State: AOJu0Yz1cET0PExtp8/AtYtMR1Q95Cofu3nkYbQpKfgBf//++E8mzWiN
	YCdjEEXK2xxtsdnJ984CbawjmKbHbQcEbcOZxjOlw0K/nWuJvy8IzoyeyxdUgUcODkcSbpkJXRe
	4QlWO8U0ZnTZvazZLHEkoJJQQg3Wo4nZxSs3pjMzLuOZpE+Qia+jwJhOa+1qicRvK
X-Gm-Gg: ATEYQzwROT1TNKBD4j8w5cjTxJ1QByuFHxgHW4sLhha57Zu1SIfhE/5Ux8A3wsX4rJv
	w+bF3adXDUevpG/vSqtv1E95apxXGVwhBas21c57vLpUDk/h5DB6tD52onjA8bgDyoEPLJqxDWn
	qiEit4k9LWN4Dx+gqtTL5rxzL/FtMHqMpp9pwcAeBqfNW45AcHVydWFeY0+fU4KK6vZlYJsiQ+A
	lnCoMKz7FYENyLK/xySskyAGCmtBNQN+HvWce8V5IRBQgfAckrDeCK679oVCwbhzH2cKiQwn6P6
	phbjipI7jTewEv3L60L2HooePI4Houd6qcNi1+/T29ZVmLHfJ93ZPzulJvbuC28oyEG/Le15cV7
	ldo53179zDSPtYkfny6lw+AGuyOqlwwQTfy0x/rZBz5NUd4IdvPk2
X-Received: by 2002:a05:622a:8c4:b0:509:61:b22 with SMTP id d75a77b69052e-50d3bdfce67mr102813171cf.57.1775134493999;
        Thu, 02 Apr 2026 05:54:53 -0700 (PDT)
X-Received: by 2002:a05:622a:8c4:b0:509:61:b22 with SMTP id d75a77b69052e-50d3bdfce67mr102812851cf.57.1775134493581;
        Thu, 02 Apr 2026 05:54:53 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:4ff1:3e57:22ec:dadc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e735532sm235790765e9.0.2026.04.02.05.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 05:54:52 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 02 Apr 2026 14:54:29 +0200
Subject: [PATCH v2 4/4] platform/x86: x86-android-tablets: enable fwnode
 matching of GPIO chips
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260402-baytrail-real-swnode-v2-4-6f5054a4cc07@oss.qualcomm.com>
References: <20260402-baytrail-real-swnode-v2-0-6f5054a4cc07@oss.qualcomm.com>
In-Reply-To: <20260402-baytrail-real-swnode-v2-0-6f5054a4cc07@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5641;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=l4lnny3dGBJZoHOBatk5qgjCf18AZd9xMDIK67fuBWk=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpzmcSDJFevJiDAeVlynB8mr3GoSDutTpLPSkiz
 e/4bjE89PSJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCac5nEgAKCRAFnS7L/zaE
 w1vnD/9rZfMZ2QuxGkRgddz00Bqvn0zAJcdUasDuGcCPuP4CeV/PY+00l1VWHuhkhdujGGkeX7/
 +9v1S5Htf3bM+YuVWITrs0Gv6er0+m6fv4RwUkPUz1NWTyrh1TChJ+abvmEfhp0cTeOBbcpIrBY
 gI8DJ8d+MGIl0aRWaj2kJm5alDN8NS0IbtXLabnZh52KHuqB0mQLstLgHsw13mnDtQdXoZRcMH2
 lnWGI2vnj/IN3HNTJszaoznfzEkzk8e9bVTejROmslYLUUSUgm2HNhJ33OaGRiDiSMJEQd36qHv
 rG8suBE6nX/CQWMitTpEP7X2sR/COz+9iZwg+yT1Trq4+t2TfsBTUTSkMUiF39UcVQPIgaSQCV+
 2rSOasJKGEx7NbUi6f9XoD/Ut/beI549qYEWrxi1+UHLbsgnqqUS8J15f9NC2U05ynruz0xtTPo
 kQRhdnqesm4ftCZcFzn8666KmOaI22QQ5S1hgRyoG3vcd6qTR4ryjO78K5ysvOzlJNt+FTfWatS
 XenNDc846EDPJPHgFgiAC9Tv5ctleTUIHarEgimgatG6M88BX1qRv5YdiIAl5FTvrunIo9ST2wD
 8jjbTxwHNqdYVzz2OUecmpL2OPeE4gXggVc4R3uosGasezJtGDFh6jjnuFGPifvcYwAA/G6R0nT
 4acWO63D4oXa/Gg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=TqLrRTXh c=1 sm=1 tr=0 ts=69ce671f cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=6VCG6zWJw881NgsJBYMA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: uzXEJypuF8Z9-AVS6fVcGnJzf7EkE3by
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDExNSBTYWx0ZWRfX7lK45B/YrXxH
 GbUh9iWsoI4JowwQKAGQsh1raq+mKLubnFxntdxpD+cylKjR3aGyWrTWFPa9h+md6CN30KRnuy2
 RwQwjAeb7hHszQUoUFrwM1+WdBfbDaKV3C+nUTNoLXnTWrBdi6OtoZ7WlKrbb1Ac0qT3UQBM969
 rq5JIAxNOWJ3nVVx9lbDxl8VyJ2rUJ3IBuk5vIB5NVZFmFux7ueDooYTl6Yt5q/TdYzoriRsJHW
 DhMsKAOJTb15KexudJTcnShN2fHIs78Mldp6W2OrHBJPR0Gvxs6Td8Un/78mDR5X7rBakIDZtwi
 zrNbeURaaEdL0j61DpWm2hwWvNaSYJegCv2XPZsGr7cNu/EYQdg9U+jEOFfA7NVBEafSzqAkcCA
 JMMEByuIeOt5pE+51kwJvBEHmmRazp81SLjiMHXBnXvJILt/pp5BEq4UsAQCPcm8Sas0VdDgZFH
 8pmRVdUy7fmxUJ+LkPw==
X-Proofpoint-GUID: uzXEJypuF8Z9-AVS6fVcGnJzf7EkE3by
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 clxscore=1011 malwarescore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604020115

In order to allow GPIOLIB to match cherryview and baytrail GPIO
controllers by their firmware nodes instead of their names, we need to
attach the - currently "dangling" - existing software nodes to their
target devices dynamically.

We deal with devices described in ACPI so set up a bus notifier waiting
for the ADD events. We know the name of the device we're waiting for so
match against it and - on match - assign the appropriate software node
as the secondary firmware node of the underlying ACPI node. In case the
event was emitted earlier than this driver's probe: also make sure the
device was not added before.

Scheduling fine-grained devres actions allows for proper teardown and
unsetting of the secondary firmware nodes.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/platform/x86/x86-android-tablets/core.c | 127 +++++++++++++++++++++++-
 1 file changed, 124 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/x86-android-tablets/core.c b/drivers/platform/x86/x86-android-tablets/core.c
index 021009e9085bec3db9c4daa1f6235600210a6099..9e6e8f272dfe16cda421b569802045c3d94fc0ab 100644
--- a/drivers/platform/x86/x86-android-tablets/core.c
+++ b/drivers/platform/x86/x86-android-tablets/core.c
@@ -13,10 +13,12 @@
 #include <linux/acpi.h>
 #include <linux/device.h>
 #include <linux/dmi.h>
+#include <linux/fwnode.h>
 #include <linux/gpio/consumer.h>
 #include <linux/gpio/machine.h>
 #include <linux/irq.h>
 #include <linux/module.h>
+#include <linux/notifier.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/serdev.h>
@@ -360,6 +362,124 @@ static const struct software_node *cherryview_gpiochip_node_group[] = {
 	NULL
 };
 
+struct auto_secondary_data {
+	struct notifier_block nb;
+	struct device *parent;
+};
+
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
+static int acpi_auto_secondary_notifier(struct notifier_block *nb,
+					unsigned long action, void *data)
+{
+	struct auto_secondary_data *auto_sec = container_of(nb, struct auto_secondary_data, nb);
+	const struct software_node *const *swnode;
+	struct device *dev = data;
+	int ret;
+
+	switch (action) {
+	case BUS_NOTIFY_ADD_DEVICE:
+		for (swnode = gpiochip_node_group; *swnode; swnode++) {
+			if (strcmp((*swnode)->name, dev_name(dev)) == 0) {
+				ret = acpi_set_secondary_fwnode(auto_sec->parent, dev, *swnode);
+				return ret ? NOTIFY_BAD : NOTIFY_OK;
+			}
+		}
+		break;
+	default:
+		break;
+	}
+
+	return NOTIFY_DONE;
+}
+
+static void auto_secondary_unregister_node_group(void *data)
+{
+	const struct software_node **nodes = data;
+
+	software_node_unregister_node_group(nodes);
+}
+
+static void auto_secondary_unregister_notifier(void *data)
+{
+	struct notifier_block *nb = data;
+
+	bus_unregister_notifier(&acpi_bus_type, nb);
+}
+
+static int auto_secondary_fwnode_init(struct device *parent)
+{
+	const struct software_node *const *swnode;
+	struct auto_secondary_data *data;
+	int ret;
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
+	data = devm_kzalloc(parent, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->nb.notifier_call = acpi_auto_secondary_notifier;
+	data->parent = parent;
+
+	ret = bus_register_notifier(&acpi_bus_type, &data->nb);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(parent,
+				       auto_secondary_unregister_notifier,
+				       &data->nb);
+	if (ret)
+		return ret;
+
+	/* Device may have been already added. */
+	for (swnode = gpiochip_node_group; *swnode; swnode++) {
+		struct device *dev __free(put_device) =
+			bus_find_device_by_name(&acpi_bus_type, NULL, (*swnode)->name);
+		if (dev) {
+			ret = acpi_set_secondary_fwnode(parent, dev, *swnode);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
 static void x86_android_tablet_remove(struct platform_device *pdev)
 {
 	int i;
@@ -391,7 +511,6 @@ static void x86_android_tablet_remove(struct platform_device *pdev)
 
 	software_node_unregister_node_group(gpio_button_swnodes);
 	software_node_unregister_node_group(swnode_group);
-	software_node_unregister_node_group(gpiochip_node_group);
 }
 
 static __init int x86_android_tablet_probe(struct platform_device *pdev)
@@ -427,9 +546,11 @@ static __init int x86_android_tablet_probe(struct platform_device *pdev)
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

