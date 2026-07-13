Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9FE28CF5F
	for <linux-acpi@vger.kernel.org>; Mon, 13 Jul 2026 11:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783941312; cv=none; b=pNj2AmREV3RcRe5kLYlpg+1cqi0mdFpqx4Xqqwbc/If9uMh1/MzHE4BtmKyKPYmjG7qCUIIp4aYlOsKVXpDCZZKa7r1OGvBXuIJ16mDeoBBlJmcoydE42vXpln5QA1uxwVy3RPquHEvN7MrBQdy49a0yIAFcq99N3qm0B5dh/R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783941312; c=relaxed/simple;
	bh=O9NkHL6JYILIp7mfm0RnOgr/0S6YPfzPn6jbv5EJbjU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IFDj40h0CR/7a2ENhk4pSI1XM38qKkmMP8/Via/c3GHGvFO3P+oeSS1af0nAMbF8LfCkhrehBCKAu0OJruGO5V/zlsr2ZzR+qyLFoBPkPYNapVgn5tGw1qVyGXEV0CCjtwS1dpXTsku/yGb1hBISAiEJmnpsSlkmqg0ToXCjSfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RYh6cDyp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=e804GtkK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RYh6cDyp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="e804GtkK"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D9RHND1123152
	for <linux-acpi@vger.kernel.org>; Mon, 13 Jul 2026 11:15:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	okGnys6Dq42n97G+YBE9VPTayEfByn7CtWc7od0TY/Y=; b=RYh6cDypsF1bP+QG
	Z4qVwPP2cR80gKUg1fPaK8tCo5IUPTfgtNOdxx+2W7pEdbGDur+HOudFcd4TDtbh
	br1ltp21Qa7t10NW2C13DhyQTGwIK71YNSCB1xv2dFKwz626Uxpvm49ksJixSCZR
	JV1mvp2ZRzKutzAqRYbuxK6FXhJQiyLM9NewJ++A4ctoJrtyQ1e5XAzf0S+XsrS4
	AcXrWrf7Y6eDycSdp0Bt1Nce1QdWrW+WvoltYjX09lzXXwT3A39XFJTifJsuHB8d
	piaGTAp/oXfq9Ji6N9qRkptvEKBb1dP3j4qVhDQXFnZxSo6hPRpF3dW+rIC6WNbx
	pnKJkA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcwda0cd4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Mon, 13 Jul 2026 11:15:09 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c07f25de2so30660271cf.3
        for <linux-acpi@vger.kernel.org>; Mon, 13 Jul 2026 04:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783941308; x=1784546108; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=okGnys6Dq42n97G+YBE9VPTayEfByn7CtWc7od0TY/Y=;
        b=e804GtkKWN5OmZVmVLIfFexGIRJyT4gFtr1kEljNz0eEJVOJpIpcytCC2xCCNwGz75
         zDP0tsjMok31G9W6qaIYfQGSuMLsDWirT0dMfyCRaRVA/XvKhVM93SKu+RhxGPkqbQZX
         i5amrqULikyoXlEzSb/9D9Uwm8wQMHS6AcXfyXkTFxclNLa+wmsOS1ZQ8EFq456TDStX
         DzVJRmgRYy/qrHOlcBI14EHj0Xb+jFSr0ExwUpGoFsF0uIrfI8LdIwirxqfXlEdjNBev
         7/taCwkJdfQ2nHDrxNyjWSqED2o+XAPawrLih08vXhm0nhRIvh3GgkrPf3qM3kd9SYTU
         WDQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783941308; x=1784546108;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=okGnys6Dq42n97G+YBE9VPTayEfByn7CtWc7od0TY/Y=;
        b=WT3RJ+3aEMGsia4QtZJ6Xjstm1QX2L5/z8URL567E9WoOMdIac8Ia2r/TPizYuLgkm
         sSubBXIk6ZUpJLer6OP8MwcZyG+MqoajQnEOoP1mqLRWp/q3iMhbYNCYU4gLvBCChWQa
         vjNGU/sqvSSLlgkP6X0Z2EsgqNKRC/alen9R4iyPYW+/ynFBot1SaxSxxqLceOsLEBPa
         rZ5M+D13obuy7b2v+4gHf+HO2mpqJOkVTW+BcnErQLbhVYPA03KzT9RTCtJdLRcp561t
         jVsthzf5u/UEVElmPdxEfaqxJt3m2ExzLITKTzSPIE865gDv0OCLBfwXtRi6cQz4W6xG
         K1Xg==
X-Forwarded-Encrypted: i=1; AHgh+Rq4fer/eUnT/7xomTzEGYzrgt3l+gNjmgbkszoHYS7juLl/FPYFysLlkzPSJ8XWaqukE21a4pEDWuBN@vger.kernel.org
X-Gm-Message-State: AOJu0YxOxlbUMWsZR6/LJHWM97OiYKGQLK8wQeDllqRCFRoTzf40XoMJ
	RK82oWRX5gNFYvHJF189ZPa/Jes8RD/CqgnR9oeIWSsqO9ICHd+G2Kz3K3QYkTLI7G9tkCjj3yN
	rFS9k648nxKOZZ9RlvukS4zakHpdfgJ//Aqu9C7SpTp5NQxr49w988rVCEUpMqQAU
X-Gm-Gg: AfdE7cmOAJY4qW6I6J0ykMqmsvCAK0MsXr12hUb7YIIpHXQ7TYTks4flMsWaddRAnGS
	qJ11P4CPI9xbbMMhQyzNGC7radOrezFehRlJz0bIinrX37ulW7xRnrY9H/vRmS2X0KrTLYAQfLU
	RR8byP7sWYd4i60+Xywqra1RLiiS6enwmiy5IY4UR7991qlUUawaGxDgMWFO7mYrZqvH57UaR62
	ZD6A2aKjo0X3SOYjeJR1wRwFOh4S/kwPFpskj3xJkKn85fjQUjpREcPP1VW4pEcwkXjqsebboYE
	o+d9V9q3tLFrehjAaUnkjNlieUwfCxSWK9qrNtQBh5pldxMG+ozvDFVuibjF0YiWPIWdRoGjUyJ
	yaWnex9KaIwOQ/J3nnxGa8Skg6x97qWWnq+rw0Yqm
X-Received: by 2002:a05:622a:1828:b0:51a:8c9b:649f with SMTP id d75a77b69052e-51cbf38ef7emr84447471cf.67.1783941308484;
        Mon, 13 Jul 2026 04:15:08 -0700 (PDT)
X-Received: by 2002:a05:622a:1828:b0:51a:8c9b:649f with SMTP id d75a77b69052e-51cbf38ef7emr84446991cf.67.1783941308020;
        Mon, 13 Jul 2026 04:15:08 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8881:83b8:89fa:1a2a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0f214d2sm82323160f8f.33.2026.07.13.04.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 04:15:06 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 13:14:45 +0200
Subject: [PATCH v4 2/5] software node: add fw_devlink support
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-swnode-fw-devlink-v4-2-d4f2dee27ad9@oss.qualcomm.com>
References: <20260713-swnode-fw-devlink-v4-0-d4f2dee27ad9@oss.qualcomm.com>
In-Reply-To: <20260713-swnode-fw-devlink-v4-0-d4f2dee27ad9@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5990;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=O9NkHL6JYILIp7mfm0RnOgr/0S6YPfzPn6jbv5EJbjU=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqVMiv3n7DWmU3bTgDtMHhn+McKk6aAxv9PFD8+
 L/kGkkHH4mJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCalTIrwAKCRAFnS7L/zaE
 w1WRD/0fycoaLESQF+jB+f8IxtpFfiLvdJ4cwDu4+Kgo2CXBydcgbhsuo1LEVLLC4eTXh4qJuSW
 vApZWytxW6u84Gd7RM2JZAhrrfFH7sgRGvgkn9jSRG/kwqWkq4QrSm16TPglgLGyavF2tcwV3JP
 fojBN2IHhuKKAjC4IVvuV/GuJvRgQHaObu9v0SJcNT8WNjUkQU5uC6Bs3p/shCnyZcuwg17Q1Lh
 fdi+CpEr5nFWo2/g7j50IVzqAzswifIj9kPn0pMTuU7oVo1zNjrw89jGpoYYMGYP6WoYvHzNZkE
 ylnU9iiVIo4cBd/8oRK9V8We2blZBWx8AhhLXGiicXDt+mbJxmxhkx9kk58vMSjXhejoqa+B/5r
 /bolt61WnOR0t5DQWGt1raUCyJoNV8Lg5/g1NjvAtjUqZVBetnpHwFYUV3lW2VQ7v1fF/uOMKJK
 8uZU0ZqVUXOKd0gRaaz+e5j7QfOqwkXVjtnkxo59mY1TJmfGR+7udlroTFzyY8dL0sNw99k8a35
 0J6Auidrd1W+GLC9m6PGDGorsJBQin0gFlKR5mK+hZujM1D8+biy4yUcaFNGDDbdnXrbF4Zo+JH
 CEYzBnKn00I9as4is4jyBwNZIQckRnXjKh46IIROikmeDpe1hiD6ae0LUp1if2DVhMB0BaUGKAW
 vyjg97iHRtLLOFA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDExNyBTYWx0ZWRfX3U4I+eNGNzwR
 OOocyXPsQ23sKG0SMXLhEUo6RrY8PiYe7iFIY9judZxW6BZQWDDIHLQ6evC16t/HiwFC59E9pks
 3utLyyOVHcSiiNsorKaCq9H1FfHcSbw=
X-Authority-Analysis: v=2.4 cv=cNbQdFeN c=1 sm=1 tr=0 ts=6a54c8bd cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=QyXUC8HyAAAA:8
 a=EUspDBNiAAAA:8 a=fLzRGSmVK1lo7flavS8A:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: _fLrwTCmaSwp2eTrCZWaukLFKy9-VN3o
X-Proofpoint-ORIG-GUID: _fLrwTCmaSwp2eTrCZWaukLFKy9-VN3o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDExNyBTYWx0ZWRfX7600XA0qHPna
 hLxJdVET0Lpui+lDJgKyqV15QFetZ7woLmephQDR8bIdM+B0292zMwdgYRSkQXsIQ7Ks/rWy3kS
 ydFF1Xh3aPBxvUvwZALFd5/cmV6ZDhkwq8iE0jpyzzwVSsG9W40zjSM/24APU3GqZrK0wBGXEZa
 68aDIwHfTpbzeyrWnih5GDnuwicqhlV5BkMb3DXaw333qmkXrDJ9NiqmKYTzwIp4Kl36Uf0Ey1B
 WCls33AwmDbTylU8T91zRYCsCUG7Zw3mWd6Jkmn0evAYmaUbsXe1c/0GCFr14OmIpQS78nIWYrW
 B94H9iwnA/PsMv5uRjhHx8MQthZpguVIHamBOuUYFzksB5s/0tdOJcUSdbOlFoClTCw65kbcttf
 iXEuxPNDn7G+wbPrvoeIVUjlE6ZQ8dmXdnOHzUEUyllwxMD4jvE4jTTcu8gsHThH3uruqxQylwi
 c40vExhfoP6kI/JhyLA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 spamscore=0 suspectscore=0 impostorscore=0
 phishscore=0 clxscore=1015 adultscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130117

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

Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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

