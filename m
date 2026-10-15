Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220A9515894
	for <linux-acpi@vger.kernel.org>; Thu, 15 Oct 2026 14:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792075614; cv=none; b=ZuApTIqyEeNfE+mitgD0BgfYRN4tC9y1R/ykV26GgWo9yzsDc4CKM53v12r2N/eJdaZgnAZzyICE8JZ8n/pJL3urQfaadBtNozNyfPFCag6v7PF38868QS7rBfMNr0arlx3IkLsh+tkSTWFt1t0rMKMCb3VjkkMIwwExC6319iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792075614; c=relaxed/simple;
	bh=b5psEhGu33J6XAeJBkiV8PWWEXQuiHu7lH/f7ufztzM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MAKbG1veTMdiozH55CxyqG8r05qGdvlGn2wWvu/2JfcMWm8QeMA3C4W9yMIowOQnhk89fNMtg9yp+UENMUJqqzRqj4FAX2nhvfOImRK48BJmfsY+ixSYb5xHEREnithM1PAN6zM94LsCyJE3hHUIuf3/7h+lBGSJ86Cy2vhOdtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Pj2pRZXh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gKlsCnH6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Pj2pRZXh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gKlsCnH6"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F9jTW42809294
	for <linux-acpi@vger.kernel.org>; Thu, 15 Oct 2026 14:46:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	G/BnLC9IlXI4LO5c2UlLKBTCYcBIOSWeobZN8MtWNZ8=; b=Pj2pRZXhZDHAO6o2
	1L0M/W8QrYfyPW/n8w/EwEIrtBLG5biGjdFyOSRjGVKzAQLzU+F/AjpU7syRPgP1
	aAHX8ynWAVeDtyyaV3Aab4KcrYC00QC+e4x2Jhl0uE1X2K8KFEM5coSJn+vzaLKb
	8aYBGUEW706t6LjZM/A8CZITR+le8OXM9a0HRtbm1n1mOzfHX2BTiVds+txQVcVJ
	W8+Ajh5uA1RAIBdxmstYNh63jbCIfH7TX3Um0hxjFv5KKD/ZmukIpQdkIrlVdQm+
	eyAwD/grVieLjnhedaYd0Or4Pe5hR5Wm71R5AomlTlE0TBLvrIjvAMghYRmXH26t
	xCTzow==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4han54u4pt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Thu, 15 Oct 2026 14:46:51 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-9907de400a6so53914241.0
        for <linux-acpi@vger.kernel.org>; Thu, 15 Oct 2026 07:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792075611; x=1792680411; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G/BnLC9IlXI4LO5c2UlLKBTCYcBIOSWeobZN8MtWNZ8=;
        b=gKlsCnH67mO8EobpLm/T7X6XCoKPrvAx1VAi3s2Ime3OHjHMNQxjFv9frKzKUWM3so
         zwuJC1e+IMix9OrCoiYyM63/cScURv77UAR7eqejCmJxP/SlLqjE5d+yFkskZfh+OXKo
         ZOd+R0E3XwJhSYNY1aa4LpKt9dL1PgCt+Ux/K8wCf2F6vuWsbnFVlP0TSF3LVJoPm8Ip
         bATlbEVXxtmHXTzE7evzcVnzWgK8l2bi6+moDg+G07yR8uqS8gqpE56zReDaqMogspem
         Wu7/qUAjJdpY1Vw0y05PE0wJm53GLsVm7/vgXNgzuAjkR9hQHwNo7g6lbw+DkJLwlsBB
         8woQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792075611; x=1792680411;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G/BnLC9IlXI4LO5c2UlLKBTCYcBIOSWeobZN8MtWNZ8=;
        b=dP37G1HjU50GEwj3hrZwYUZvSS6SJU6w41kJUBOrZdFlicI9GM00c/O1TrFFwro431
         sJfyGR7/u1tBKGCzkGQ9ZSixwQNLEys/Sm0SaqgZ6a0EvlSGXQfB8ZU2I8KIPGj3ID46
         0cVfKvn0qhdXVOTej8Je9/AsXO+NCgPNYwb3yuuJed6MWDY4S0kz0NKRMCqYxvPaooJY
         jN8KrrEY6g9/wIYCur4WimUU0kqhN1fGMoRxkfy96uTqIZxzqlir9z0h12MvZTRs3n12
         TS4zotTItAa8YNhOXFnLyyZseV2KfW5xUEkhHIJImae1yyIxbP4skEB9PAr+ydLDVP54
         ceUw==
X-Forwarded-Encrypted: i=1; AKwUvBy/5NpCXNIu0Q7oYW2e2FavH3F0WrFQkSndu38iuC5TZtdLwKrg0WUTbFViZFwyHdFNsPwO4Sg4wjFA@vger.kernel.org
X-Gm-Message-State: AFq9FYJJG5poeGk6lynxdGZmVI+HwTaQ5aOCCI+c8oQD4oBd+gPZ4j7q
	BZQLJJeJqCmTc/hzedPbzz+34uoUW3GRWI7w3FKFEgeUoBBa97PLIBwrw7cp9xybytAfvTp3lO+
	ihmT0lSHtcfW7JjdLaU78yUscTi0gUhLjctKoZOlavbSEfk2IY9Hkh3DDivKUoV+11032x8et
X-Gm-Gg: AYBFou0SAa3IZpDD8CnjuzxZ7sYehbyzYFFyUq+/NeCsw8o96RxvXDsmDvEyq/yEpvi
	DO+y7qo47GPm4GCdI3mMoi5NhJQR99Zl0uAcOsY7aUvS1wm4nqzoztTzmyXLxHXC4pubnlYlqEO
	qvnS9CX8HVo2oRCiSZdVnwz4zrNB8KAJd7bDXsD5Vsf5T/6IwI+yb9WA5OX8+r6zx8aVCy0cYY9
	QlEGPiLhOwdsPvBMxOJF8bBDxx0TDkz6A3qvgOiYhJOJLKqmbAj7LxlPZ2oaO5rlwm7rdE4EaDg
	v00VQAjF98A36pFNyeFAG93SC8EyL6t7eh769H8SMdUoAJ/glBP2x2wyCgYZE6vaC4CfFfpe9o+
	gmx6Y+XUDrRKctMZPWXjOGEnFJPGF
X-Received: by 2002:a05:6122:32c4:b0:5e9:7458:9bb2 with SMTP id 71dfb90a1353d-5e97458aed4mr1657877e0c.5.1792075611158;
        Thu, 15 Oct 2026 07:46:51 -0700 (PDT)
X-Received: by 2002:a05:6122:32c4:b0:5e9:7458:9bb2 with SMTP id 71dfb90a1353d-5e97458aed4mr1657805e0c.5.1792075610187;
        Thu, 15 Oct 2026 07:46:50 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd9b8ebdsm86840625e9.10.2026.10.15.07.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 07:46:49 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 16:46:24 +0200
Subject: [PATCH 3/3] software node: fix unbalanced reference counting
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-swnode-dev-notify-balance-v1-3-9e7537bd2869@oss.qualcomm.com>
References: <20261015-swnode-dev-notify-balance-v1-0-9e7537bd2869@oss.qualcomm.com>
In-Reply-To: <20261015-swnode-dev-notify-balance-v1-0-9e7537bd2869@oss.qualcomm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Eduardo Ruiz Duarte <toorandom@gmail.com>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1783;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=b5psEhGu33J6XAeJBkiV8PWWEXQuiHu7lH/f7ufztzM=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBq0OdQPjTd4GxgYuJMtA5lOtb09Ol7UVKoKR4x/
 2YVbc0FKBCJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCatDnUAAKCRAFnS7L/zaE
 w6VxD/9BJiZbpWvTi5865mCNX2ReKRoFB0ADV5QZrYpCJpT5UiUolC9ZnSkJXQ5Jx1SkWXjkQYc
 TJdmeHFxa14DI5LD5CeVMLKuRayuepHi63Yv1/x4AGmKMWGLXiLW3sSjKnHzGy1Npk05hR7UXeD
 uA9ymDAhDBqtEr5pylUu6zgX4xcvcjL60pJ6MGulg/9OCGEoLFS2b8OqfaStyuV2CHDM4OMogUU
 /+a3wCpU6p2D2AflwMBlwWSBJxRs+0o5vBhlPoPomvoY3zzZFo6CQN50DI3uuthPJInedp6ur/9
 5/NmlvCDKpfjyRfb+m0wFcDVle25Dtj+PAg/aYYjGrAAtFS+CdETUQYwybTHLHlMahIohyQ3bsL
 d5SFkTxBsWDwR0iXwE4PqoNdx9A+N/2OCTU6KD+ewUMDj6J+PMJhClEeQlKwDR9DzQEbl42Qend
 0p5pa96qL/lCSttyucBVHmtc06pFpCfGmrm0sA9A4ikWWgQhHkzkCGLfDHhKIexD8gIiikkW9QB
 JHoFqHwyZeCau5ca8i1THq0mKhuXmZDbNJC7y4+L2EmJHyG1MJlmePkNEFf6SqASoLutPA5JcFb
 wJtVAHMUhtngb0fE2YbyQHukrq5C2/u5Q15c04p+ZMzX54k1H01S+8wyuudbreP1ZaHebLdKnME
 o3hg5gIDuarpSfw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=RYQFmFtv c=1 sm=1 tr=0 ts=6ad0e75b cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=HsDmPXzSDgUE5-xNsXYA:9 a=QEXdDO2ut3YA:10
 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA1OCBTYWx0ZWRfX3ZUz4tBNvVFS
 MeKBYUw6jnN+eb0SGOyFY0yI8+TRbu578ODG0sra0QZO4P72LXG8f4jCph9IbfNw1WQbP3sUeZx
 6V6up6hO6WB4wjdjXUbIvVRHF6OZlzsMw/RE6hzADcHeEqmE/3Xwbpq/MaG2wZ8hkVwDFFIQtSf
 A8VrpO80DhzrHOokGWkQRcQXuIcva8anZaaHGkVeYs3u5VO1PNI4WugedlNrjvK+22GYCFw8EC1
 GDm6cnFyL3iknYyG98CRzBqcxousP18ah14RcTzRZ0TSeAg9YIKCW3bEr7TpYNTP/nFKcQtsKcH
 hyv04AxtH+3lUZfXNpcNvs8NIUz1kkHiIP090kjEL8SsYLK8lkOuYb1hhXpy8VI2HkDexO8d9co
 Ts9SPBZrNRzw8rBpchLgnJRGA8z3K45wegqd0bhPWymv46NLUPDCL1npP3jL5mkX8LJcOgBl0pY
 JfBXHs/oRvdMM12tzRA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA1OCBTYWx0ZWRfXwJKdrECTRsv+
 k347X32c6TbmuztcyI3tEb9BEKUsm3AzkqE/Qo6sCLmK2zXpzggSVD3iNyjISFVmR9xIZzNgTTQ
 mWQXOqJ0b34JKUm28HaIUKwrcdcZs2o=
X-Proofpoint-GUID: et57hzYr-WgmsCk_vu5Qm_s3hgwmtxAV
X-Proofpoint-ORIG-GUID: et57hzYr-WgmsCk_vu5Qm_s3hgwmtxAV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150058

software_node_notify() takes a reference to the device's software node.
software_node_notify_remove() drops it unconditionally. A software node
attached with set_secondary_fwnode() after the device was registered
never gets it reference count increased but it gets decreased in
software_node_notify_remove() all the same causing an underflow and a
use-after-free. Use the new device flag to mark a device that needs the
reference to its software node decreased on device_del() and do it
conditionally in software_node_notify_remove().

Cc: stable@vger.kernel.org
Fixes: 384f5a857bae ("software nodes: Split software_node_notify()")
Reported-by: Eduardo Ruiz Duarte <toorandom@gmail.com>
Closes: https://lore.kernel.org/all/20261011131518.48838-1-toorandom@gmail.com/
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/base/swnode.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 84a77ffa3dc4bbcca62bbe67c3390693500b01ea..9207d7f96f20f8cfaff2a4eb8915609c499cce24 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -1176,6 +1176,8 @@ void software_node_notify(struct device *dev)
 		swnode->fwnode.dev = dev;
 
 	swnode_get(swnode);
+	dev_set_swnode_notified(dev);
+
 	ret = sysfs_create_link(&dev->kobj, &swnode->kobj, "software_node");
 	if (ret)
 		return;
@@ -1206,7 +1208,8 @@ void software_node_notify_remove(struct device *dev)
 	if (!device_match_fwnode(dev, &swnode->fwnode) && swnode->fwnode.dev == dev)
 		swnode->fwnode.dev = NULL;
 
-	swnode_put(swnode);
+	if (dev_test_and_clear_swnode_notified(dev))
+		swnode_put(swnode);
 
 	if (swnode->managed) {
 		set_secondary_fwnode(dev, NULL);

-- 
2.47.3

