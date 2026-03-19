Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE9D38E121
	for <linux-acpi@vger.kernel.org>; Thu, 19 Mar 2026 16:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773936677; cv=none; b=qAycuJFxQ1HAYJsxviY7k9Z78SkLNNVHrH0mtmsQIB/02479t4ntfOigpGi/dOtJDUPYV+xZ0o7cmGr9aEeum01HkPDuhNirRlZQmAZkYfgGczQT0jkpb2G7xt60YeQ2bDmphlSOFoSQ/liDoajOzAEsU/JO/x5k52dZMLcWPCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773936677; c=relaxed/simple;
	bh=GXiegH5SRMfYAHFveVz49Jd/VzeFD4+D1OYGYQfjqbw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A+sbJeUXrJIZpAlW2UF7amBmqxQa5MrQE1fIh/aVNNEtsz7cMt1VjDjUnjvMijU4r614maUTp2g4SuwBj0dfrRCsLVvKXCuGV7zA1UYSW7vviPo+tkQ3z5WSiSGXGbO2fpyarqwoS8r1hqCWcjDe7Ly55jmAkpd4iJ4UFTQweOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Yl6232p3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CHtTMjyC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Yl6232p3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CHtTMjyC"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62JEWCsZ2981547
	for <linux-acpi@vger.kernel.org>; Thu, 19 Mar 2026 16:11:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gNEZb3fCa4ZhfpQFG8JrK/v/wHOU6VGHlluFvh+xrDE=; b=Yl6232p3sgiIdBpj
	2/UsPXQfBQ9ugWU7BkCKfQK/bQOjGcQ5ti7kkP6JiHOi39f9ojbaoW/hCKp+XvBj
	CTWO2h0ITqAMq2E0zlquoPRPQqvEwce2006dzV+7pZMhc79lkyN+yrAbbegPob76
	IrRCeKLoA6SV4ELbeTa0JvqNZsCZUeYaxmZ3HBNiZrNtCpeLmSVQPNf83XUeAWWn
	uTGh+XCujiFq+UL3Ez+owaZBwss0DrZ3GaEnSNe2BPlqC1nvO+UjVAy+JPdD8LSk
	679lX7leYBWPKHeMZ+kFWlQ/bJTJghqQjF+DpTxTRzio8B+R2pLGYvOtgGIJoX45
	POTjIg==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d0k080bmk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Thu, 19 Mar 2026 16:11:12 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-5ffcb2bef48so1522190137.0
        for <linux-acpi@vger.kernel.org>; Thu, 19 Mar 2026 09:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773936672; x=1774541472; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gNEZb3fCa4ZhfpQFG8JrK/v/wHOU6VGHlluFvh+xrDE=;
        b=CHtTMjyCESW4cC0SZjZBHEYovmhbhygCHeQPgd5ShPW7SdcYn21rCvxsbW4Itgc5sa
         eq0xWJ6r5BwvnsKtNVNuYpCW310Y62JguxAeQyfxozxZ8BNqVURER1H4wyURPrDllibT
         rQUE16q8te1PbHviov42G6OU4+PmHZKd0276rEbS7TpVHk1TROwV0N/jbn4AfN6EKM/j
         DeSgxaA/vopXUrxbpvdqhwfThpNe2FnDcwBqWk/jlx+FQ6BmHeUJqZL2g2fLKyn9RHat
         4q05NTnIIgxoll98fUttDzjSaGdzFc0YkdRVnPveq0KSnakHVYcG3v9XNGbI1hVEwmJ7
         EmzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773936672; x=1774541472;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gNEZb3fCa4ZhfpQFG8JrK/v/wHOU6VGHlluFvh+xrDE=;
        b=eiJ8nZmL/wqy+oSDxxPIbkcS/Fluh1+y1k645NePBfRg1tPTM3HsxzKj2fhnZQy1Jh
         FvugBMlknQE2fNXw6N3fob3HyH4MJWry06s8p5RIQBi3C536GhJiOyTz8T2P5vkBIYFq
         WqsVcLMmdkJA8DHQb99qOjvsPXpvS09V0T44o4TJkrox65Rht3cGSoFLPh0CCzEhxYEp
         6n1cV3F8+K4xDxO7iDB+lBR0tYTRCDVy2VTp/fZLS1EdoKIyvo+wCyaFOHlQnlWsupBD
         mb1KldR4HhClStutS0hG5sm0s89fGZ6JgVi+SrRY7/yW4S8XElPeccNCq7zWjE2Dqxna
         URsQ==
X-Gm-Message-State: AOJu0YyFlZ0kVdnczuWsHRJDBNs8pB6S1tjdiC8eXsc6woiWR+kbPWbC
	xehlrvsyOqv6m4e9ruj4s00Pu6eozBsGugSKpQiB16k2ow0cCmklucJdIYMDF0sKEig0s0xzHns
	GyjRCYgY7QGjEEzeGoWzYNu1JHldNado/4ERpqrA6nm8Wo4HqdUdXn1eFrsfLCNVa
X-Gm-Gg: ATEYQzzsqCFghzGw2NwFzkEQVNrTwtVaZjk2I2hUt8hpzw/RgnRh+jeCa2c8kLto2K6
	TEpPzz4DlVHFUsYPngR2p42blSf3kl4a1L2A5lH7AWskMYsfQF7o8DvVvv1uv7zYICUwHRjewwm
	DK0CS2LatmJHMtV+Bqxdomu094ysGFLr8LUgJAL1Ob4Et/UjkqKEo6ZGnGxhNpbDINXkS3luGBt
	rcyJkNEEE11FdxOdP0I7pqdJkoyJpkdHvsc3kXtXZt4fzAxgpHm0afo7Jp3Sbl579/YErKELAdU
	wgoacgD7sPGBwzbTUDR6hzZp4oIehiEpCpbx4ceTGCnZPlvZB4nwV5rXGBo4hzI8lPk+ZxagVBE
	UH73V66EUKKdKIzQ9gjckaj3FO6HWrJkkfGgQojoOHAvg5a1BMqF6
X-Received: by 2002:a05:6102:1620:b0:5f5:4d9b:bd67 with SMTP id ada2fe7eead31-602aea8d87amr64305137.6.1773936671654;
        Thu, 19 Mar 2026 09:11:11 -0700 (PDT)
X-Received: by 2002:a05:6102:1620:b0:5f5:4d9b:bd67 with SMTP id ada2fe7eead31-602aea8d87amr64249137.6.1773936671012;
        Thu, 19 Mar 2026 09:11:11 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:9d74:8015:408c:d719])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f4e5495csm83756915e9.2.2026.03.19.09.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 09:11:10 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 19 Mar 2026 17:10:54 +0100
Subject: [PATCH 1/4] software node: support automatic secondary fwnode
 assignment
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-baytrail-real-swnode-v1-1-75f2264ae49f@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6123;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=GXiegH5SRMfYAHFveVz49Jd/VzeFD4+D1OYGYQfjqbw=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpvCAVp+475D0wjSe7sNWCHgFiPzD5xfW+6V8+s
 e56aQ4t7r6JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCabwgFQAKCRAFnS7L/zaE
 w4rMD/4mXJtbJEJDhQSrVx5z5ehAjOrKhwEW/rwBEzb2I/foHLrrJfCNVaCUxCcItm3N2Y3lCrl
 ItGljm9OhedLjGBvsMlw8Tdpdn1qxv2NEuLi5poDmB3Su1cvljGHDwBQo32mbFl4SMOoQlgRzUM
 9BbdtP5Crgdq1JgJrFPXLw9tSFLHNKEBXqxKqIb0Z+fbTbcI5KkimEdZFj7q/XUMrZut1pyCE5l
 NNDRieumg0PzpjQxqXTNlktCxsBCvvrhjsxztNodt0VcWYR7YxrWYBpn//h1PE3Rg73nDuSTjSH
 IhdVfsjwFvTxxIEi5UmB8DcC6Z67IPobAqt4fIaFmDvQbbMWVMX62Y4s+zT1onQgxC6Yi3JuF2W
 X+TWiyhMPsd5f7oRLjMoRmI8VPsptJnSKeGLo0JMSdvnrlNTlbESzXKrEdmk3pNDFOY6UYslVjX
 JX8LmPFyClN9sZiBlTle3fuv1Ji0WiRgzbe7bJk8lygR2AnVPptiD1xHLlLMJKtSiJ9GBA5mjCp
 JvAaCBhXbDi1F1+0hh54Ynvhj3tv8gqveh2g/l1Ke1aKCRqJ/Z513d0mVLe3b4gPvhE9NaFjRJg
 7ExTgQEOtVVlHmEL+4BbY08i20ec9aXk47D3ing4v2AvwMrSKoVlagq1uEhuR9ngkiZ/eFguR6J
 TOrPj0sO8UkykQA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=MYhhep/f c=1 sm=1 tr=0 ts=69bc2020 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=QyXUC8HyAAAA:8 a=lzMY5pp4uJb4PBOz-uUA:9 a=QEXdDO2ut3YA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-ORIG-GUID: qFJFPx9nfry_dsF6OYmQpVlXTrih6Z2D
X-Proofpoint-GUID: qFJFPx9nfry_dsF6OYmQpVlXTrih6Z2D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDEyOSBTYWx0ZWRfX3h5y6PNWlRbp
 NWG6631Ag54lIzpHIN9cLJTT7FhOxlVOGjKLKqphVX4UH70jzntEymFd4HYyL7Sk5bFQq+Z4nY+
 QQveWVSmnfQfO79wepuCrEZoc8IWVmHY3Zb6uA/HkLHZuD0F8/E4/+q77KiQORBcEzn6+oHxly7
 tVLrQqHOU8mR4IOZO609Q2v8i0UGyY9FQpFlV/H6+oxYleGlDxoaRgoB/PeFIZgLbProhk+045v
 JxF29bhs5VfBHgN7UGe8Xfy3cGPwSAynkwEXde3lJUqNXkhkt+FeEqt925WfYnkn1rFIJb40IZe
 QuoGWHWeweAWtU+G/ad49jQkrGztVQEohoXHBwVxd6fUi54hjwexU1suxM6bWQDLTfPGWNIV9Te
 yK1mOi5sSlwXg7eu1UFZatZlL88PjR1oeMwuS9GIFHGB1g+XJYcnMTtQrY4HnfKuCTnkH3hScP4
 IyNRUkkHg7+D5kA/yhw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_02,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 impostorscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603190129

Provide a structure and a set of functions allowing to set up automatic
secondary firmware node assignment for platform devices. It uses
a behind-the-scenes bus notifier for a group of named software nodes. It
will wait for bus events and when a device is added, it will check its
name against the software node's name and - on match - assign the
software node as the secondary firmware node of the device's *real*
firmware node.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/base/swnode.c    | 105 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/property.h |  18 ++++++++
 2 files changed, 123 insertions(+)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 51320837f3a9f1bf4f65aa161d9b941affc74936..97e3354cdafd94e175d29acb697a0dc61186a9c8 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -6,6 +6,7 @@
  * Author: Heikki Krogerus <heikki.krogerus@linux.intel.com>
  */
 
+#include <linux/cleanup.h>
 #include <linux/container_of.h>
 #include <linux/device.h>
 #include <linux/err.h>
@@ -1088,6 +1089,110 @@ int device_create_managed_software_node(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(device_create_managed_software_node);
 
+static struct software_node_auto_secondary *to_auto_sec(struct notifier_block *nb)
+{
+	return container_of(nb, struct software_node_auto_secondary, nb);
+}
+
+static void swnode_set_secondary_fwnode(struct device *dev,
+					const struct software_node *swnode)
+{
+	struct fwnode_handle *fwnode;
+
+	fwnode = software_node_fwnode(swnode);
+	if (WARN(!fwnode, "Software node %s should have been registered before", swnode->name))
+		return;
+
+	set_secondary_fwnode(dev, fwnode);
+}
+
+static int swnode_auto_secondary_notifier(struct notifier_block *nb,
+					  unsigned long action, void *data)
+{
+	struct software_node_auto_secondary *auto_sec = to_auto_sec(nb);
+	const struct software_node * const *swnode;
+	struct device *dev = data;
+
+	switch (action) {
+	case BUS_NOTIFY_ADD_DEVICE:
+		for (swnode = auto_sec->node_group; *swnode; swnode++) {
+			if (strcmp(dev_name(dev), (*swnode)->name))
+				continue;
+
+			swnode_set_secondary_fwnode(dev, *swnode);
+			return NOTIFY_OK;
+		}
+		break;
+	default:
+		break;
+	}
+
+	return NOTIFY_DONE;
+}
+
+/**
+ * software_node_register_auto_secondary() - set up automatic assignment of
+ *                                           secondary firmware nodes
+ * @auto_sec: Context data to use.
+ *
+ * NOTE: All software nodes passed in @auto_sec must be named.
+ *
+ * Returns:
+ * 0 on success, negative error number on failure.
+ *
+ * This registers the software node group passed in @auto_sec and sets up
+ * automatic assignment of them as secondary firmware nodes of real nodes
+ * attached to appropriate devices on the bus specified in @auto_sec. The
+ * software nodes must be named and their names must be the same as the
+ * devices they should reference. The assignment happens when the device is
+ * first added to the bus.
+ */
+int software_node_register_auto_secondary(struct software_node_auto_secondary *auto_sec)
+{
+	const struct software_node * const *swnode;
+	int ret;
+
+	if (!auto_sec->node_group || !auto_sec->bus)
+		return -EINVAL;
+
+	for (swnode = auto_sec->node_group; *swnode; swnode++) {
+		if (!(*swnode)->name)
+			return -EINVAL;
+	}
+
+	ret = software_node_register_node_group(auto_sec->node_group);
+	if (ret)
+		return ret;
+
+	auto_sec->nb.notifier_call = swnode_auto_secondary_notifier;
+	ret = bus_register_notifier(auto_sec->bus, &auto_sec->nb);
+	if (ret)
+		software_node_unregister_node_group(auto_sec->node_group);
+
+	/* Device may have been already added. */
+	for (swnode = auto_sec->node_group; *swnode; swnode++) {
+		struct device *dev __free(put_device) =
+			bus_find_device_by_name(auto_sec->bus, NULL, (*swnode)->name);
+		if (dev)
+			swnode_set_secondary_fwnode(dev, *swnode);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(software_node_register_auto_secondary);
+
+/**
+ * software_node_unregister_auto_secondary() - unregister automatic assignment
+ *                                             of secondary firmware nodes
+ * @auto_sec: Address of the context structure used at registration
+ */
+void software_node_unregister_auto_secondary(struct software_node_auto_secondary *auto_sec)
+{
+	bus_unregister_notifier(auto_sec->bus, &auto_sec->nb);
+	software_node_unregister_node_group(auto_sec->node_group);
+}
+EXPORT_SYMBOL_GPL(software_node_unregister_auto_secondary);
+
 void software_node_notify(struct device *dev)
 {
 	struct swnode *swnode;
diff --git a/include/linux/property.h b/include/linux/property.h
index e30ef23a9af3396455d5bb19bb6d41089d81d77f..2a7af60cbb8ecc2ba83819ce92562db42705b82a 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -15,10 +15,12 @@
 #include <linux/bits.h>
 #include <linux/cleanup.h>
 #include <linux/fwnode.h>
+#include <linux/notifier.h>
 #include <linux/stddef.h>
 #include <linux/types.h>
 #include <linux/util_macros.h>
 
+struct bus_type;
 struct device;
 
 enum dev_prop_type {
@@ -610,4 +612,20 @@ int device_create_managed_software_node(struct device *dev,
 					const struct property_entry *properties,
 					const struct software_node *parent);
 
+/**
+ * struct software_node_auto_secondary - context data for automatic secondary
+ *                                       fwnode assignment
+ * @nb: Private bus notifier data - don't use
+ * @node_group: NULL-terminated array of software node addresses
+ * @bus: Bus on which to wait for devices
+ */
+struct software_node_auto_secondary {
+	struct notifier_block nb;
+	const struct software_node * const *node_group;
+	const struct bus_type *bus;
+};
+
+int software_node_register_auto_secondary(struct software_node_auto_secondary *auto_sec);
+void software_node_unregister_auto_secondary(struct software_node_auto_secondary *auto_sec);
+
 #endif /* _LINUX_PROPERTY_H_ */

-- 
2.47.3

