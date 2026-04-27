Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FEF3B6C09
	for <linux-acpi@vger.kernel.org>; Mon, 27 Apr 2026 13:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777295914; cv=none; b=LiTe5MvLOZa4mZMZjnI08EKMnykkoEaF2xA8ewhtCEoJk4B2Ttdw8rO6PoavGdc8qqX58Y7ccyDaI95V7EyVgIs+/Ggyv9iNyCoYa+px/KbvT6K7JNbJ2rqsc5sKLC482imafEvGKn1RyU9r15lzZeIGCBemZUkbyejn1o3O7KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777295914; c=relaxed/simple;
	bh=qcZdDAZYcucxialNIwKMj7fy8LHoFUSymG/EEtHJ/94=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ycf3R/tMMbuKk8TPYb3FidbFtc2J0jwPZqYfoT+6BX0v91FuPcei9Kqa403Reca+/dYeBhG5ZUr94krEmUg3T72In24M7D027Us/T1P8eiNicqHm3uakq15jsb8M9wPX0TinAhUSQeoCf2jpx8NSc3IU7BH8aRjuJ/8w98UT05k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BPRs4Ri4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YzbXady9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BPRs4Ri4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YzbXady9"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63RA3nUG3123516
	for <linux-acpi@vger.kernel.org>; Mon, 27 Apr 2026 13:18:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=zkk15cs4HQuTAwcx0rFc4UdYWGmvwU5NjUq
	dwPsu1+U=; b=BPRs4Ri4eG80x+9Vb8VjxMScKoLcIBbFyXs1QYFv5rmc7ZCm9oC
	iCSuySrFoP5p2pKa0p79XuUVdB5Y5Wn0NtfQvl5qhwn2D8B9vnYP1jH7C5WDWhlx
	E1oaAYF/k0VL2h44fZZAOqvWMmpNtdiwmQm9B8lVX1LqTQ7J85d55HwEL1RQnpXx
	hsVd41VE3Zd46oFAwEX66HCoDihU02JheuJCr4X4s8rX40YyUYnB8zJ1+ggJRC4s
	xVqfJzTDE0t2v6DN+Rsw6ytWcK0JbC0M/pDNtCQ6eLcYszU52YnMKL7VH8QAhOTd
	0HwLYyITCRfBW+56DkdkCx5vHQSC81T9YLQ==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dt5qggp6y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Mon, 27 Apr 2026 13:18:32 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-612ef4e6c54so16786262137.2
        for <linux-acpi@vger.kernel.org>; Mon, 27 Apr 2026 06:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777295912; x=1777900712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zkk15cs4HQuTAwcx0rFc4UdYWGmvwU5NjUqdwPsu1+U=;
        b=YzbXady9dRiFTM1GTJeDdDUDj7H0pI3PDyDxhm9D+5ichusIuyeN0EVxYqh69fJtPr
         +HPXpHXMFEhxT2C8bHZxqtdTgFTX08Ycoe2nMCT+FcJLPFex1JPZIsjh/tAST7tada53
         Sno9TK0m4GU6zGxQJ2bUPNEp33A8YXGtCj2BD8AfCuf6YTyyv3hS2iyK1ESlpxE6NBea
         dRW/SHe1GLNHYdpCYm5YfOjqn4SM+B+3iXgEraCdsvf1KImU6d6C7s/P0+9RRr7fC53Q
         Zm/vvCkFbNSlMBdZ3Kxlo6wB6oXWBnCRLqiDIDJ14dqX2h9d8AAPPpwqtWHtlhzKk2eL
         4HLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777295912; x=1777900712;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zkk15cs4HQuTAwcx0rFc4UdYWGmvwU5NjUqdwPsu1+U=;
        b=dHUVDBgLQvCB94AXa/df07bsAEwCXvdNKcIxbkyW2LyB+CEl54ZsWxmej4CNL+E5OF
         UApEWrGHlbM9LtV4QSupZUYZ1dnFn8DChXZ75kTR9opiwsIZra881N8KbCktd3vH0zjU
         u7Yf/yj7A2sNF5wiytJV6kl8RTaZCsSq8maThefrAyrAlqwtRRL82TiJJJKNgPQlaYcZ
         juPuR954SS87ZmLjT3Bgz5Txz1E+XJHM2f1yBF7SWgxFvk9qxbxdP3PN/So9fIRa1QA0
         RPtx2qO1rVM385YPQyVEbdyd549iy1og34MIerVdf9SadqRAjLZTpk5dj7+PG5XNGwaR
         NFSQ==
X-Gm-Message-State: AOJu0YynWX04dIaL8b5Wls8Xolb5MAgczNYCRZNQUm/bIRqr4fOAumbh
	9nPE3sZZyHheEk9TiRTFoqfxaPL7ka5gqe9BcTVS+kLgmc7ITIuLtV2FBxRzPIRdxQdj1L/rXKp
	p2NnXkVou1HH4WpR7axWdXv/vP/WusAMz1ZI4RZcWvOe17W3mTZzVl0g7hJZ0fbay
X-Gm-Gg: AeBDievOhmX0rxPqgoMRr2zhrqFv6NcJ9icRCxYDfkghDfllZcxZpIq8mF0tzWK9ddw
	Oxz2oZ5p2Xtq1dbu4Yn9knC9VvIvImXDN8Pji4DTxU9vrOVXmUMXWEujegVk1vyassWAQaQgqdU
	KH0BVw2F9pN229jVXc7SRKPiiho9ZUN25bHXOiWQXTkFtXQARxk6YCm5qbLPH3e+qpEI/+F5aGb
	xW51bhFaqCs917x25kBKiAWRj6MT0Q+4rLphFnPl9b3W4jQj70FHydo8vv94M9Jugpv91s1AmT5
	EafLnH5shxfjaKL3lg2ySIp3zB/6Vv/sTv2+ZIuwvfO5eryUf+4Y0JIM+m36Gou9z5gkGp1J5Zl
	H00VqyTPBvwZvkUt00hS19pLHz9YwFFTVB2ym+j0tiGYU92Ea7CDP6LIU0VgF
X-Received: by 2002:a05:6102:dcd:b0:612:b3af:39f1 with SMTP id ada2fe7eead31-616f68d1bafmr21907521137.18.1777295911907;
        Mon, 27 Apr 2026 06:18:31 -0700 (PDT)
X-Received: by 2002:a05:6102:dcd:b0:612:b3af:39f1 with SMTP id ada2fe7eead31-616f68d1bafmr21907497137.18.1777295911521;
        Mon, 27 Apr 2026 06:18:31 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:83be:e944:7b0e:ef3d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a66533ff4sm112607135e9.6.2026.04.27.06.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 06:18:30 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>
Cc: linux-acpi@vger.kernel.org, driver-core@lists.linux.dev,
        linux-kernel@vger.kernel.org, brgl@kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v2] software node: provide wrappers around kobject_get/put()
Date: Mon, 27 Apr 2026 15:18:25 +0200
Message-ID: <20260427131825.15793-1-bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDE0MSBTYWx0ZWRfX8wm+UPF2vlHG
 LRnCY4uPYFitKlcwlprW1uWZOaoU6T/BcEgBrjKtyUhmb3exS5TjXk4nwZ+UnYLifyAAXSvz1xT
 DrozRtCyhzNe3CaUG8HKbsgzADtS1b7bBj8ClMGUCg3ZPRdEuTs11/rrGjO0LwMRe1Uk/d/V2PX
 gGwILEQuJYOWYXhxgD1/I/cV9dzsoXGdL41ehOQe8kxQsemakfupjKyrmkc0fV7vyOUnLSVT4XN
 EYo/6SrlSAkriGKo44Fj0Les+sLqr3CvAvNlxIs4FW/KCpHgPKrLDfF7P6AxtVsUqEwAeJrxhWa
 857Yy8W06inMZfma5qv6v53D1fCXcDih7u/iIemXvjheHIvMz5E1cMX7xdDaZ2omIsM/TH49NET
 QOOhQQ3ebZeRb3yNeJksevamVCN/xJbVPEl0z7uOuDhv+3a0YaSyiw9KmTdXqkCvzEzKBUds3Ji
 2b5s0AiBrj8NrDUz/RQ==
X-Authority-Analysis: v=2.4 cv=V69NF+ni c=1 sm=1 tr=0 ts=69ef6228 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8 a=bCnx2AzvNVCsJt7Mrv4A:9
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-GUID: qkC6CNiAHfUtr5AM85ah8mqBvUvHsS4Y
X-Proofpoint-ORIG-GUID: qkC6CNiAHfUtr5AM85ah8mqBvUvHsS4Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604270141

Make the code more readable by avoid constant dereferencing of the
swnode's kobject when managing references. Provide wrappers that take
struct swnode * as argument and make them hide that logic.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
Changes in v2:
- Make swnode_get() return the address of the swnode whose refcount it
  bumps and use that fact in software_node_get()

 drivers/base/swnode.c | 40 ++++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index a19f8f722bc8e..869228a65cb36 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -374,20 +374,28 @@ EXPORT_SYMBOL_GPL(property_entries_free);
 /* -------------------------------------------------------------------------- */
 /* fwnode operations */
 
-static struct fwnode_handle *software_node_get(struct fwnode_handle *fwnode)
+static struct swnode *swnode_get(struct swnode *swnode)
 {
-	struct swnode *swnode = to_swnode(fwnode);
-
 	kobject_get(&swnode->kobj);
 
+	return swnode;
+}
+
+static void swnode_put(struct swnode *swnode)
+{
+	kobject_put(&swnode->kobj);
+}
+
+static struct fwnode_handle *software_node_get(struct fwnode_handle *fwnode)
+{
+	struct swnode *swnode = swnode_get(to_swnode(fwnode));
+
 	return &swnode->fwnode;
 }
 
 static void software_node_put(struct fwnode_handle *fwnode)
 {
-	struct swnode *swnode = to_swnode(fwnode);
-
-	kobject_put(&swnode->kobj);
+	swnode_put(to_swnode(fwnode));
 }
 
 static bool software_node_property_present(const struct fwnode_handle *fwnode,
@@ -493,7 +501,7 @@ software_node_get_named_child_node(const struct fwnode_handle *fwnode,
 
 	list_for_each_entry(child, &swnode->children, entry) {
 		if (!strcmp(childname, kobject_name(&child->kobj))) {
-			kobject_get(&child->kobj);
+			swnode_get(child);
 			return &child->fwnode;
 		}
 	}
@@ -737,7 +745,7 @@ software_node_find_by_name(const struct software_node *parent, const char *name)
 		swnode = kobj_to_swnode(k);
 		if (parent == swnode->node->parent && swnode->node->name &&
 		    !strcmp(name, swnode->node->name)) {
-			kobject_get(&swnode->kobj);
+			swnode_get(swnode);
 			break;
 		}
 		swnode = NULL;
@@ -835,13 +843,13 @@ swnode_register(const struct software_node *node, struct swnode *parent,
 					   parent ? &parent->kobj : NULL,
 					   "node%d", swnode->id);
 	if (ret) {
-		kobject_put(&swnode->kobj);
+		swnode_put(swnode);
 		return ERR_PTR(ret);
 	}
 
 	/*
 	 * Assign the flag only in the successful case, so
-	 * the above kobject_put() won't mess up with properties.
+	 * the above swnode_put() won't mess up with properties.
 	 */
 	swnode->allocated = allocated;
 
@@ -978,7 +986,7 @@ void fwnode_remove_software_node(struct fwnode_handle *fwnode)
 	if (!swnode)
 		return;
 
-	kobject_put(&swnode->kobj);
+	swnode_put(swnode);
 }
 EXPORT_SYMBOL_GPL(fwnode_remove_software_node);
 
@@ -1002,7 +1010,7 @@ int device_add_software_node(struct device *dev, const struct software_node *nod
 
 	swnode = software_node_to_swnode(node);
 	if (swnode) {
-		kobject_get(&swnode->kobj);
+		swnode_get(swnode);
 	} else {
 		ret = software_node_register(node);
 		if (ret)
@@ -1044,7 +1052,7 @@ void device_remove_software_node(struct device *dev)
 		software_node_notify_remove(dev);
 
 	set_secondary_fwnode(dev, NULL);
-	kobject_put(&swnode->kobj);
+	swnode_put(swnode);
 }
 EXPORT_SYMBOL_GPL(device_remove_software_node);
 
@@ -1097,7 +1105,7 @@ void software_node_notify(struct device *dev)
 	if (!swnode)
 		return;
 
-	kobject_get(&swnode->kobj);
+	swnode_get(swnode);
 	ret = sysfs_create_link(&dev->kobj, &swnode->kobj, "software_node");
 	if (ret)
 		return;
@@ -1119,11 +1127,11 @@ void software_node_notify_remove(struct device *dev)
 
 	sysfs_remove_link(&swnode->kobj, dev_name(dev));
 	sysfs_remove_link(&dev->kobj, "software_node");
-	kobject_put(&swnode->kobj);
+	swnode_put(swnode);
 
 	if (swnode->managed) {
 		set_secondary_fwnode(dev, NULL);
-		kobject_put(&swnode->kobj);
+		swnode_put(swnode);
 	}
 }
 
-- 
2.47.3

