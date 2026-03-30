Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352753D1CCD
	for <linux-acpi@vger.kernel.org>; Mon, 30 Mar 2026 12:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774874468; cv=none; b=Ks/pQxx6Idz7Is+5rQtqJsMxvDs/0kiZqK0kWBvxw9ySkV+DaKql2TWap1R6LcPfvatMQPi7vjXLB3dikIJw0y0VHUSUwk3eO+U//wEP4WvvIGOYsXnKCnInMpl/hKGyn0twbYTfa1rJafbi3KUZ0K/NISUmwXcT5tZkzu7rQK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774874468; c=relaxed/simple;
	bh=gJwyjiXRCnugGv/qc4veSv3kjlfeyPx7bWEjN+IOvTI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FmdazxxPp+lFBN8HlIqWToRARDaw15ZEPEUE+xC9Pzrs1h7P0Zm53ZPlwOxGwVNJjTr0Ko+/QkvdDz7TrysDR9ZbNWNlulUN4acbLnqOTwplF9i5CX3JWbJUM0DaMWe8FXHVwrVyMRGPzmgPWfNfoIjT5H2AiXjSgIKyMnDO630=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TaGPeOVr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=G739hVYn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TaGPeOVr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="G739hVYn"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62UCb2nZ3508658
	for <linux-acpi@vger.kernel.org>; Mon, 30 Mar 2026 12:41:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	opfaxOPhT6iAK402N9SQHjFMmnwGP8bV8DD5Qr7SvFM=; b=TaGPeOVrGR9zBgAD
	nstkMpeQuy/3ZwmqZiD2EHTWs+/Ub6gGDHdwcs+Lz4sEaMZhbabQ3yBVe106p2zy
	vZ//VJlc9jU/nwKsZIOWeRLatPCZTBj5j7N20ICgVYFS8OYDiG4113C86OUMKWwJ
	ufogVcYrLECvo/CzTye+eemjNJTGXvkMmijtHarHcCWzP6yfPCzv/ofCa+U+o79i
	v/oFgEojvMnckzxT9PEMEJd6ScET9hS42yVJeH/rirA+8BFu1PEqhXDvVhkzqJE6
	vWFYyUnvuLm5Z54L24XDEYdHqE0hA1o/BQNShWUB2C2+vB2CnzioKpxhxI5zG2ax
	pbyLOg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d6v9c45q1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Mon, 30 Mar 2026 12:41:05 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cfc61fc9b8so1225256785a.1
        for <linux-acpi@vger.kernel.org>; Mon, 30 Mar 2026 05:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774874465; x=1775479265; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=opfaxOPhT6iAK402N9SQHjFMmnwGP8bV8DD5Qr7SvFM=;
        b=G739hVYnZab8yFz20FbHGd5lOXIaEjtu7sevmR9Fx5doMdnW6Kg0T77oWNABL37X0H
         0xXOX+R7iyvTk5oyKPYN0pig+Z6ffaCaVwF1CjRGVNckQKTJ/zDxs6kbPvRmFzFwlYL5
         KgC7rgpaK6l1WHgsiwwzfTcyU2NEvaXGtq/MibtjmMh3RQzkliaYV93CpX/g1KLSmRLu
         7BStW1TwHMWgphkvlFuwUwaOWTKXj4xGOQC7I2gOqJYMcEwYfO6viKhNp7oda8761YNd
         69XvVCN1esD86YGGv2qaOQwnA2IyTyrpHhuivcW+0/2TeZRzSKnaST9jgGuwnmFr5yWc
         9oWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774874465; x=1775479265;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=opfaxOPhT6iAK402N9SQHjFMmnwGP8bV8DD5Qr7SvFM=;
        b=W/0jtEsg0YZ5qF3Z7AgpPdo/I+NTEEzJMl+lGQ9mCmjF1FcwczAPw63WsWAGAqAWQk
         L1WHQyg98iIKYlZ62TCyPP4W5kWOTaEfYyK+3tumMMIBNjRXmYExZw0dbOlxyg+MOpH/
         65lNxx7HPlkH+xAwwNF1rSfnoRkOxz+UEWIaSgJie/dEU+lZNXdgvgZ42QpKIi+TyOeB
         I2u74ZrmMXicWjePVFtv+HrIiQ+ohS9Tt8Ot17l0/FdsOUVl2bPfe8sf+4EHPx4Yxjo0
         VlJtZVLYGMu18p3NSWxjHQiRQ1XRpfeBBYm7TLhCePrR5ev7bruykbU4SjpK04V11hUo
         Oi6w==
X-Forwarded-Encrypted: i=1; AJvYcCVRQO/FEFjL7EaLercuch5PySLfpJybvvpZSKmnuPoWlUhhzg/Rpt6t4Sas6cZskyKccnTpZpyMxGiw@vger.kernel.org
X-Gm-Message-State: AOJu0YxTMBihtsIYo4/gC/NgBVKAGqieEZE6WJrMQajCM7mzggNQB6nU
	47S/6qT8NgnxpLTsmTEQk1ddYBBbm3YkPgeQiWLQwbq3/GA4gXaG1CyoOvGvDigxzJG/YKo8DKF
	leDWEPLojAtbUNvCG9Q+zFWdUrDFbzzco2W0lrRB8+f+/yNn7XE7ZdYjlXqwWdTS1
X-Gm-Gg: ATEYQzzj8YzbHLySUyye8cc1qHCQkuCVOelYkAS6fT0h2UhEa+iq+BwFjWOxjMOFMC9
	PQAzKO8CmdWvm8OM0HX/z5dulI6gW2Yj+BPkfQSrrXViJiRS+ZD5fJBbhB6EMVi8U7Djka5UUKX
	VHugu8zgGfEPXVnnZj+c2BBfzhTpu0wtkJBhAomOzFjbrErw6CPXAgAOnjRIcF21vD5x6j2mRfI
	rlzHVR8gOvAWD4yTcDWKRIGzLt24Ym47z7ykKBDWHwTujGscCfwgZNEAmFYfaTg2UfLXHQj91BD
	n63zmJEhhGGEQ1HHSvYZguixyVmonr0XcxKExtC/U8wWfYKNAdvromf46Sy7cJmM1NR3kLTqiIp
	i02X6TtgeM2HeWPiuHgI99NLHx7gS2pXn1VRmbSstx6QLVeoJRQBR
X-Received: by 2002:a05:622a:4807:b0:50b:3a6d:db5f with SMTP id d75a77b69052e-50ba39bae92mr157209411cf.64.1774874465208;
        Mon, 30 Mar 2026 05:41:05 -0700 (PDT)
X-Received: by 2002:a05:622a:4807:b0:50b:3a6d:db5f with SMTP id d75a77b69052e-50ba39bae92mr157208621cf.64.1774874464360;
        Mon, 30 Mar 2026 05:41:04 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:e931:8d81:9955:76ef])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf24739easm19576153f8f.30.2026.03.30.05.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 05:41:03 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 30 Mar 2026 14:40:47 +0200
Subject: [PATCH v4 2/3] driver core: make software nodes available earlier
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-nokia770-gpio-swnodes-v4-2-b68592e977d0@oss.qualcomm.com>
References: <20260330-nokia770-gpio-swnodes-v4-0-b68592e977d0@oss.qualcomm.com>
In-Reply-To: <20260330-nokia770-gpio-swnodes-v4-0-b68592e977d0@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2409;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=gJwyjiXRCnugGv/qc4veSv3kjlfeyPx7bWEjN+IOvTI=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpym9XXiSQyC7OynNfgLxf03QB4HoghAslTf5Kn
 jeVOS7U8YOJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCacpvVwAKCRAFnS7L/zaE
 w6QpD/9XIROG3IAgmmHH1FUKBarIpLInEIqyvgVn4+D5u9EYIZqOmm8qK28LuCy2r+XGYofsJmr
 HBMDO98ZjZHo8YCEoD61fK+414ewpgTeAIn8pEsxv/zTAHrbFRiAuizAdCtTDBUnDpRXZGtHdYi
 N354SgY3nGnp1nVldydHpYHbsoGi8gDzOhedaKxKM+S0sYpGaTFaEQdpFlkRIKgRY+vShICU/gz
 ANsxjc85EB5iYpuQail204re8lL67/AmfUOOwVxyeZeTuMXqY+w8qcfjj9IT7FFDSogeeqnKdR3
 dX8WHQDSAOZPFgoUFVVndqOy251BMcBHpMdGlszmE/2IM+dBo/5cPm2OdQYvuVeGVKdJYFzlo6O
 +AFEYhpFuIPn5UIDvoaHr2dXxVgx3WQHRo/LXScWe7n9qokYokPHxWJ+bVp358tqhekgpeRJVIo
 qsg6D7m9aDt9PmPsYy5vuAdaa4NKH8oJimvi68NcJCg3P7xvk5alF94cWBc9rGNyv6CxXLVo3zW
 duLeuK2AZgBWp3CUpkNKBcr90rswv70jRDFpI9kcQweSe/wLdlwXCkrosciwDkGLAbeufagU6q+
 h7G57YM53sWxGuXvtwSkiobFnUQAnLyvQMowiIKJg8PSWgbqZ5CBebTrT+zwfiy0dpsU7p8chvf
 L/eWTFVN7jTl1WQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDA5OSBTYWx0ZWRfXx9smyDg51VVc
 BL5yB2POa6QeeyAsqxpdLDAEN6vFvgGeOMZnW5fNX0FLxW6Hcp3Ia2kKJD7mpzZGEi63qWRFuyc
 a6s3NNn+Xg1X6Eqd+u9q0vl7jZ3THfYtCD/tIKTj2qHiuPonPyspA5T+3q4GmF+CimXwWw+TNor
 2bmQuICwSEJaQDVb4UArd/DaBUEzUrvbvYDW0gPW2nZ5mcxT3TQ6y70FllIFbjOeIFbjrLA1Ptd
 Bn/zjLAornr6sxXiWyGgitBxwFb8xh4vgKx5X0ATxqh8aa/3TLc+XGGtC6KowDIAejuSOTgYfvm
 P4GxYS8I2s23Th1OpDbishRsH3eTNEC0Tql5cqm99NYPdpgdKnvZsc1WC0xcNDTm/dOrh81PIji
 Hc8bdoSoX07aKtHV09lcGeKCRDNfZXZeOVxT3KwMn4V+Kdh3Y180G0x+xRkTdx8exEMd21ih5Qr
 +7jmEE2KHOE4hexQJ9g==
X-Authority-Analysis: v=2.4 cv=EIQLElZC c=1 sm=1 tr=0 ts=69ca6f62 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=XRX4SzNu4mOsujJFFI4A:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: DFP0sbCxUIqz58h4PglVTH6Qog7ZkFpB
X-Proofpoint-ORIG-GUID: DFP0sbCxUIqz58h4PglVTH6Qog7ZkFpB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0 adultscore=0
 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603300099

Software nodes are currently initialized in a function registered as
a postcore_initcall(). However, some devices may want to register
software nodes earlier than that (or also in a postcore_initcall() where
they're at the merci of the link order). Move the initialization to
driver_init() making swnode available much earlier as well as making
their initialization time deterministic.

Suggested-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/base/base.h   |  1 +
 drivers/base/init.c   |  1 +
 drivers/base/swnode.c | 13 ++-----------
 3 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index afeda89fd4710c4c5492b5f19134e2aa8e1e581e..30b416588617bbc3fb433654c999c9b533d73752 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -312,6 +312,7 @@ static inline int devtmpfs_create_node(struct device *dev) { return 0; }
 static inline int devtmpfs_delete_node(struct device *dev) { return 0; }
 #endif
 
+void software_node_init(void);
 void software_node_notify(struct device *dev);
 void software_node_notify_remove(struct device *dev);
 
diff --git a/drivers/base/init.c b/drivers/base/init.c
index 9d2b06d65dfc6bf8759f6c232e2d3f753da139ac..af8014416c2460fac91b08ce919c082bf961fcce 100644
--- a/drivers/base/init.c
+++ b/drivers/base/init.c
@@ -34,6 +34,7 @@ void __init driver_init(void)
 	 */
 	faux_bus_init();
 	of_core_init();
+	software_node_init();
 	platform_bus_init();
 	auxiliary_bus_init();
 	memory_dev_init();
diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 51320837f3a9f1bf4f65aa161d9b941affc74936..a80575bf598b509eb1469cae8a09c601726ce0c8 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -1127,18 +1127,9 @@ void software_node_notify_remove(struct device *dev)
 	}
 }
 
-static int __init software_node_init(void)
+void __init software_node_init(void)
 {
 	swnode_kset = kset_create_and_add("software_nodes", NULL, kernel_kobj);
 	if (!swnode_kset)
-		return -ENOMEM;
-	return 0;
-}
-postcore_initcall(software_node_init);
-
-static void __exit software_node_exit(void)
-{
-	ida_destroy(&swnode_root_ids);
-	kset_unregister(swnode_kset);
+		pr_err("failed to register software nodes\n");
 }
-__exitcall(software_node_exit);

-- 
2.47.3

