Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C301923ED5B
	for <linux-acpi@vger.kernel.org>; Fri, 10 Jul 2026 13:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783691516; cv=none; b=A9sK/tXUBgJ9zv7hmBAkk1IB7nguGn7Cxcp9L9nOS8brQ1ABUbxO+Q+WNVbSrp8fvstyXXo3f6q3G81HGEw6ZbMKT3r+0wDz+MviS3D6Xir5xzHkms8Hp+gbLL4c9GUK+FwzRPs2svK7WxlOnNrgKrPyoBZZ0UIdPEyI1KykKZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783691516; c=relaxed/simple;
	bh=p8na6W0xPTYfTVnsE7Dd5eOOL46+fWqxiXgdhhhwMHA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ymv/O/BnjzSugXFEKfroYMa+Slgf5OJUjSmsXMTQeyGLeWwUWDTgaWgzqhIboiC3W+xc0GttIHvbCyvOG4RRLDVD3bJMO6ikcLlMRez2Lfy3X6kiL7xxE6VUqRE6bN+91hKYBsxiDaQM8dWcVGnAMD5DxoCrhbDeXkkddbed3aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IYl0CLl/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RlMxoBRe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IYl0CLl/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RlMxoBRe"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66AD78Cx919608
	for <linux-acpi@vger.kernel.org>; Fri, 10 Jul 2026 13:51:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9GOJMry5Lrk7UCqJP9VX7WgzjsId57wM52BDwYMyHQM=; b=IYl0CLl/uU5b+dI8
	Lovkgm3fAEF4TsSsmneucnzMeAyzWBOf4saM55b/qA59n5b+TfQUPAnbOQTj3BXY
	GjaTYapxfv3i19G1hCWYB6yZG+VUt493aou7sY1N1PLnzlfH6F+F8t7IS1bYqFyK
	UtlNq2ZTUhp378gNYidl/1PfmXU6iUtViKYc+TfwVeWw4PU9XZkk6Z7i6yMBYBgN
	eWng8LRH59RX6DtHpAjQwQ6HRDLPUfKvw20u6N4OLPHnzTA0nP950384BrCbwLn2
	Nzkg5EmueT3quxeBT64n53YlxeXYt5DUjFVcIoKumDfYO/jmCG05PqSvpE4HaBBt
	BsfOmw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fas6n24cw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Fri, 10 Jul 2026 13:51:53 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c07f25de2so7400561cf.3
        for <linux-acpi@vger.kernel.org>; Fri, 10 Jul 2026 06:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783691513; x=1784296313; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9GOJMry5Lrk7UCqJP9VX7WgzjsId57wM52BDwYMyHQM=;
        b=RlMxoBReF3SNMi1H76drkXWVb47y4NZOkQNFL/W2DtX6aomZmZnuOxEytmkn8E/RM0
         +1t8dUkzBOvU1kLUkIcm9+mkxSz3l0sTcSNyCOkupLIBi8VKdlaobKi9b9i7iPhCn1/r
         Z8LfzXHU2ssovpBGmtGox+Cu2Qlwy0m6eV5n3yepTR3B6CYARLvVxIvmfFIEU3EUoOSM
         rk1364XzrNPHjW3rlJqcxYVDaRu6sEs4Bv6sKn8UiHYWUkEkDH476LyswoC+z2ZHPw3t
         pqnFAiD5491kt/CYb01VNRDv1Uemk5M+hu7qBVuYWlP/lKmcPqGFhE0xcUevjR7FWNKc
         BRkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783691513; x=1784296313;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9GOJMry5Lrk7UCqJP9VX7WgzjsId57wM52BDwYMyHQM=;
        b=Ps4Lk9gHgipl1KKT7EGDuS9c1rHZUUwwJk79vl1+VYqh+uzaAILB6RKHEhlRcumvV9
         QCEtnmrv8HP+vQxtEHA7o4AdaZVdpAW84s9eaRFEo1Koe0FdoEAumENKelIECQrx4X4Z
         2jlcxa1g3H9vifHTWPPnTeULm04zWnXMvs3civrb1wW9rK7/DtjcF1x7yYUNWsJl1fBR
         utJ8MuZZuJe5n9J9/s+oRIuz6PRtnxmZtdJllYU1YaDBl+ZDF09/xGYRuWVqeTAvJ+QJ
         gaDhe0442CoENwPqt6ykXDKUFcLmYozuteTiXbxScn/jkp+nYYittadSCT7iituNJzWV
         zzuA==
X-Forwarded-Encrypted: i=1; AHgh+Rq2426VXTl5Xt2a6DG1+tZKaRFMUrqa/b+WLxSdVbl5vD2rgS+U1v7Ai0ZrguYAwq7sfEAcQh4Bh9ar@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9+70TvD6m776e3Q9ucye00fr3YYpE1NJmcccyjg2f8sJrBEeD
	7A8DJobV6YWBGxUnoMswSsjcS8VmIiJWI0tz8Je+jK8Vy5MNIZmLFkpIo/Dlq0hTJZL/2YlZ0RE
	3BLsaUUmVvNQspALcKCofG87oVbSy/4o5YJbs3n4AUx2qFIuoPPsSn+z7enp3rU2l
X-Gm-Gg: AfdE7cmP+9B5KJ7voO7nGlYrP2d8cniSaBXD3o80i3bYNchwwEzDxTGsPcB2LwP8ZAi
	QQXhF0W2a1ZWnxfPCpcR7kyjI4BZDV5FDTGIVTJ3wONVu7D+30dYaoQHL064YXeis9wek/kYpTJ
	1p3aTAmKj7Inp7AooYZWBPHRxqLHAc3nDYMz9i/SZnaCZ0gayzNbUIgZUtUeZO7u1rfJxyOLYVo
	yZaeTzKZKURsH4UVobg/FSjPc4NWXN+eOFbeKsWvDrpqRdTxXPR3l8pAz6kkhnyma8VOWdVXiwY
	ZGd4Pnn/ruFjS9xEaBdquJpkEcRX8aTybP6m7i9TIXh1LXpvZIXPAtz0vd9bDJL+y6vBMA8drbA
	ctXMEcb60YM7QSuwPORXLU3DoNC42OqNbNEKhkCsH
X-Received: by 2002:a05:622a:4290:b0:51a:8c9b:649c with SMTP id d75a77b69052e-51c8b411e7dmr129533361cf.64.1783691513060;
        Fri, 10 Jul 2026 06:51:53 -0700 (PDT)
X-Received: by 2002:a05:622a:4290:b0:51a:8c9b:649c with SMTP id d75a77b69052e-51c8b411e7dmr129532901cf.64.1783691512576;
        Fri, 10 Jul 2026 06:51:52 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:adb6:d740:6427:4097])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb670a41sm135669295e9.0.2026.07.10.06.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 06:51:51 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 15:51:21 +0200
Subject: [PATCH v3 2/5] software node: add fw_devlink support
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-swnode-fw-devlink-v3-2-993f31874e40@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5927;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=p8na6W0xPTYfTVnsE7Dd5eOOL46+fWqxiXgdhhhwMHA=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqUPjrpyCZS0mjk0G0cGCkbItm0SHjyb8xeL7R4
 rb5T7biiRKJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCalD46wAKCRAFnS7L/zaE
 w6ixD/9kkAISCrEhTTLyc3rb9FGcOP9AOwfUlXm4ABpAf3CTU7noD+xkmDj6r+aZdfC9sTh2Tss
 vRMLRtJroMPuqRDma94T3LqCCVCzJ7eHRj9LyK3NhxGllXjSaNCnMW0JsD5KW1pqjRzQxwpXqG4
 5bC/++mv7aWzd+j9TZ1AxSfQpinywvKTtRxT+HqIPgXQNpHAfh2n1AB6uddVf7VJ4Sjn3y5cedJ
 PmvjilckDiqRQ0iE65HCic23vT/hhmg3b4cZ7g5ExaOwwX4fQ7TYQ+JGvnvuiyW0FBihy4gXuya
 FbpUxN5sz1tqfUMk1p8i+4puupIK1Kxr+zORkIARU5HGjP4p3E17gd2h6LODmtflvlVU3idQMzL
 1TBBjwTTaYG3n0dO+fwHiL1EfT9yXWJ1K0oMa46q6hxVYPgZVyb9DzmIEQ0zSv+kWlEqhKJA7GR
 6FfOZDGjoTIjXommDRasgfWy/kRWC0UNMC6PF9FO98wI+2pR577zOGi55zGlvKEHdE8UCnDJ9UT
 DPJQrbGuSiLUClACqLaUNEVuqe91mwXfPWI8SAE8tWrMOX4xAaQO4/4M2nxOpPp/WMfRv0t6RdU
 rnRlheItrq34/50fscAY1Zk7RfEiKQujLTIY6I6Sx3bwju0+s/SH7+DbGpDKLlk21fMjvccoSzg
 vxna1u3RgzFKMRg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDEzNyBTYWx0ZWRfX+9cJoKikfCIF
 HI1T6pfg/MU2StMGzadfs0puRtjHP9/uKL7nZ7K8AJ0r4uOlYmpG5jFIsUa/AgA3M6/jIzDwpxx
 /I01bilhUBzfjfmlT52h+qE/dSVRPdo=
X-Authority-Analysis: v=2.4 cv=DYgnbPtW c=1 sm=1 tr=0 ts=6a50f8f9 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=fLzRGSmVK1lo7flavS8A:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: 7izIwnK8dRp_HB6NEMLo4Ztk7XErXRzC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDEzNyBTYWx0ZWRfX/LYe+uwxYjhH
 TiVxKQz0mNMoj6c/ESYKb7fN9s8SAF1OATfhTPybz7Y0oUrhBSiSUUlzn5X2h9OBPFVDX/T0u3B
 hWAxxE0Dxvx95B7bQOpw+bXp5IHKLEcw1flB4XOqhFuiknSewu1Nu+2w2uE56DTC88Q+z7G3b8+
 hCIhKp2N9OL7+CHidqlnEhpwlT2TEx6FbQnmzl4JHCMThd5xl8CoWnjaVjMnJjan+/ANOPxnV8+
 IG7VfgfFB3aXvlyM+V7AgthDWefoqSsHn1hZysGCeXI65cGXAE7iOU8PF4NjaPOgLFjRBzJ2mgr
 PWarypeooG5iUTlR4YIul07bYL87M4D0i6yLL2ZwZCefZ0DkUyke9a9yx/ezyVerBA4x8Hp3wt+
 4SMsc2xMMzUF0RN8RTImXbUzpttr0MvhPkMHKoobwleMp1XZre7Rs3tLavG6OSDr8iE7L7o7R84
 hfj0STa5irPgJHpQGHA==
X-Proofpoint-GUID: 7izIwnK8dRp_HB6NEMLo4Ztk7XErXRzC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 phishscore=0 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100137

Software nodes can be used to describe supplier-consumer relationships
between devices they represent using reference property entries. Unlike
for OF-nodes, driver core cannot yet use these references to create a
probe order that avoids needless probe deferrals on missing providers.

Implement software_node_add_links() modelled on of_fwnode_add_links().
For every DEV_PROP_REF property we resolve each referenced supplier and
create an fwnode link from the node to it. The driver core later promotes
these to device links and defers the consumer until the suppliers are
ready.

There's no allowlist like the one DT needs - devicetree phandles appear
in plenty of non-supplier contexts, but a software node only carries a
reference property when its author explicitly points at another node, so
we treat every reference as an intentional supplier dependency and link
all of them. Graph "remote-endpoint" references are skipped for now: they
go 2-ways between endpoint nodes and would create graph cycles without
the port-parent lifting DT does via get_con_dev(). References to
suppliers that aren't registered yet and self-references are ignored.

fw_devlink resolves the supplier device through fwnode->dev but the core
only records the owning device on the primary fwnode. When the software
node is a device's secondary fwnode, mirror the device pointer onto it in
software_node_notify() so the consumer can actually find the supplier
instead of deferring forever.

While at it: purge the fwnode links in software_node_release() now that
software nodes can own them.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/base/swnode.c | 79 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 869228a65cb365567ddac7db6ad7b8743e0dbca9..1f2315858cc3e04c7ff197324f1862c32a2ffa31 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -699,6 +699,62 @@ software_node_graph_parse_endpoint(const struct fwnode_handle *fwnode,
 	return 0;
 }
 
+static int software_node_add_links(struct fwnode_handle *fwnode)
+{
+	const struct software_node_ref_args *ref, *ref_array;
+	struct swnode *swnode = to_swnode(fwnode);
+	const struct property_entry *prop;
+	struct fwnode_handle *refnode;
+	unsigned int count;
+
+	if (!swnode || !swnode->node->properties)
+		return 0;
+
+	/*
+	 * Unlike Device Tree, where phandles appear in many non-supplier
+	 * contexts and a curated allowlist is required, a software node only
+	 * carries a DEV_PROP_REF property when the author explicitly describes
+	 * a reference to another node. Every such reference is therefore an
+	 * intentional supplier dependency, so we create fwnode links for all
+	 * of them.
+	 */
+	for (prop = swnode->node->properties; prop->name; prop++) {
+		if (prop->type != DEV_PROP_REF || prop->is_inline)
+			continue;
+
+		/*
+		 * TODO: Graph "remote-endpoint" references go both ways
+		 * between endpoint child nodes and would create endpoint
+		 * cycles. Let's leave it out for now until we have potential
+		 * users.
+		 */
+		if (!strcmp(prop->name, "remote-endpoint"))
+			continue;
+
+		ref_array = prop->pointer;
+		count = prop->length / sizeof(*ref_array);
+
+		for (unsigned int i = 0; i < count; i++) {
+			ref = &ref_array[i];
+
+			if (ref->swnode)
+				refnode = software_node_fwnode(ref->swnode);
+			else if (ref->fwnode)
+				refnode = ref->fwnode;
+			else
+				continue;
+
+			/* Supplier not registered yet, or self-reference. */
+			if (!refnode || refnode == &swnode->fwnode)
+				continue;
+
+			fwnode_link_add(&swnode->fwnode, refnode, 0);
+		}
+	}
+
+	return 0;
+}
+
 static const struct fwnode_operations software_node_ops = {
 	.get = software_node_get,
 	.put = software_node_put,
@@ -716,6 +772,7 @@ static const struct fwnode_operations software_node_ops = {
 	.graph_get_remote_endpoint = software_node_graph_get_remote_endpoint,
 	.graph_get_port_parent = software_node_graph_get_port_parent,
 	.graph_parse_endpoint = software_node_graph_parse_endpoint,
+	.add_links = software_node_add_links,
 };
 
 /* -------------------------------------------------------------------------- */
@@ -787,6 +844,8 @@ static void software_node_release(struct kobject *kobj)
 {
 	struct swnode *swnode = kobj_to_swnode(kobj);
 
+	fwnode_links_purge(&swnode->fwnode);
+
 	if (swnode->parent) {
 		ida_free(&swnode->parent->child_ids, swnode->id);
 		list_del(&swnode->entry);
@@ -1105,6 +1164,17 @@ void software_node_notify(struct device *dev)
 	if (!swnode)
 		return;
 
+	/*
+	 * When the software node is the device's secondary firmware node,
+	 * the core only records the owning device on the primary fwnode
+	 * (see device_add()). fw_devlink resolves a supplier device through
+	 * fwnode->dev, so without this a consumer referencing the software
+	 * node could never find the supplier device and would defer forever.
+	 * Make fwnode.dev point to its owner in that case.
+	 */
+	if (!device_match_fwnode(dev, &swnode->fwnode) && !swnode->fwnode.dev)
+		swnode->fwnode.dev = dev;
+
 	swnode_get(swnode);
 	ret = sysfs_create_link(&dev->kobj, &swnode->kobj, "software_node");
 	if (ret)
@@ -1127,6 +1197,15 @@ void software_node_notify_remove(struct device *dev)
 
 	sysfs_remove_link(&swnode->kobj, dev_name(dev));
 	sysfs_remove_link(&dev->kobj, "software_node");
+
+	/*
+	 * Drop the device pointer mirrored onto a secondary software node in
+	 * software_node_notify(). For a primary software node the core owns
+	 * fwnode->dev and clears it in device_del().
+	 */
+	if (!device_match_fwnode(dev, &swnode->fwnode) && swnode->fwnode.dev == dev)
+		swnode->fwnode.dev = NULL;
+
 	swnode_put(swnode);
 
 	if (swnode->managed) {

-- 
2.47.3

