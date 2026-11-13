Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794584835;
	b=gWNpAiEsBYI2PyoM3kGh4olZrVfgfTp9RlQ80qIrul6IKeuS9wv0fTJzJ/36DHYprKSL
	 WnAz5jxyF09YmXBTLxaPSUE1HIbxXZsEq+nThqyypP37oBr9pMWbz9PvZ/Sna+UkDQLYA
	 2QyOwJYQpsY9CD0krYr9YAF6RsJVJwarIZUrFE0lnwdZAqNfzOqLRXxaf67oyvyf1/FN4
	 qupCT+yWZBDUf5/fU7NUbc0ThJKJ4kIlLSbDDnbdMDbFqzV85Q0t9ictyAC1a1p6tSwFl
	 3JUAZoquQt2DCoytDa/UGFgxEm4vWR88b1PBqiVqJyBN4tLNuqwKp+qNPkKnFzeKOPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794584835;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=pxZg8c2Cz//qVnbPlOJ1FgV+cIcIhYnMUtcgwkzh4NI=;
	b=m6q6PHkY+SZXcOtQf2quaJSzzQdkIH4+O6vfa7mMoVr7M/wJg62VJc8hKrBqjXXIb1Ep
	 /RpU651wdG5YzsTbch3jb1LmixZBOmYrUMfL/iwMGEIsen7dquUqbPCiyBAOJg4YYaSvM
	 AU0VrftinxJzU8lwtxF962YKt9QiY6/vk0hc1M+FkLlW6hJdEmAqN+Zw3DoT70OMrlwH6
	 OIhn1pIymxwNrsWG9Z0zNOLTNJh9K1Tly4FvPETnONX/KyK8dbiO/IX2aEoOJ8eCbHghE
	 ZEocGX2YVudryNRpkG6G4lke2vZYG2Ek2+n8za1QRkN0j9BOENWFOLFrim0roENdq/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ayi6Eg+O;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=H25Q8O25;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556DE606A8AA
	for <linux-acpi@vger.kernel.org>; Fri, 13 Nov 2026 15:47:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 556DE606A8AA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ayi6Eg+O;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=H25Q8O25
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADFRS2l3296060
	for <linux-acpi@vger.kernel.org>; Fri, 13 Nov 2026 15:47:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pxZg8c2Cz//qVnbPlOJ1FgV+cIcIhYnMUtcgwkzh4NI=; b=ayi6Eg+O63IiTBLO
	aqwR1MzJcaQbQY+c3boQA+MX5zk2g6EET6JG3rVQX8Woz0bMlHrl5OM9GU6w71aa
	+/dZsWCbKNphMNNbckUtmF7riqhc2Y+jOnlFRS+OzZktvQRCKbh3ADhAuypPOKaC
	BVxLJUscjeaSjGGSNgZj9ts7Lx/8oA9Hks3saOq/BdDFn0b8IQ1mIzL71o4H8Aha
	k0aE5YOmIO2oJP/y+d0IQe19Twc4Vs0z4EMgX00Z4yvFTYQ3lOvCreIDzt/OM4gw
	xVGS4wMHGm0SGrMJMAXdZJjwJ+uInlv42CT/5THt2xc8OWUVFTKbrnRf1K55YaiB
	D33sGg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwvu6t0ms-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Fri, 13 Nov 2026 15:47:14 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93f37c94ceeso436376985a.1
        for <linux-acpi@vger.kernel.org>; Fri, 13 Nov 2026 07:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794584834; x=1795189634; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pxZg8c2Cz//qVnbPlOJ1FgV+cIcIhYnMUtcgwkzh4NI=;
        b=H25Q8O258Gtu9tPQnl785AIBqPlebbC+4+2PjuOZ4AcRn1TN2x2mD23GADMsB0yrwR
         KBTDy/foJsKvjp2YgQADeGQghCENyGqtjzATRhgQtA/6Zu/NtEMkNchEqse1MUrfZF4g
         XcoBlYQjHFYiLYCRU05jmR4PUtsVuv4O/gULM54kQNcAPbxObeWMlbXszhRMj7fHOoli
         3Nh/1d0SG4R9yI33cJKlN6nezmrur4+enxKYkZ3mBaXTx1e1gAjdkcS4vAzhs9vhDKMu
         XbQu+Aov5V0LpWltdzFjFPu8kibqaqnIv4/+czdf+K4BwHaXP0K++L9dBkr3yiefXys/
         urXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794584834; x=1795189634;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pxZg8c2Cz//qVnbPlOJ1FgV+cIcIhYnMUtcgwkzh4NI=;
        b=poO1MUi1YJc7DDThAWJ3nhVCyvGC8bW38G5vf0F5zpkjgZxhA5+xb65pQVspg7Nayc
         6mJ6Ofj2B7DIl5ykh5wyByGtsztmSY8zDsLlFL8bKzRIOk5CD5KfzNhe+pyR2NDP0xs3
         QQQKFBt1XF6IoL8NOXlLTAjioSLsac5UfXIYpubvOYdeMEJZx/qok2iU7uKYK/VxYs3P
         Rb45o8Qavlp+lncrnLqN795i5vMRUYuLyvhr59nuLvaprZB3Y/mmAvg4yT6EPYkFs/+R
         sH8YNUelzFfoxwkWH5ClIYINSvBsiWkvri3dWx/Vafq0K1YVFS81gfS7DwBV9ii24XY/
         G+Ug==
X-Gm-Message-State: APuU4Z/TtafqHkVV3JxF0lPy8yyifKSEWt8FmxQQUDhEI4mO4Nfy3Eil
	VE1IMbyR7r/pIi3RCbga4Y9i66WtWbJU/2Pw6qED08r092vI32cl3OUUjH2osyVYb8ONOrn/z8X
	FKv5Cq3vn19TxoXD2widwAYw1kdGVRg0mbnWDThNUpfXL08kwrFnNziHO/YveKwSO
X-Gm-Gg: AYBFou2VN5MpB/mOeazkLPoRRf0t9pB4MWiT6ViD+gWNMIUHQRplb/lqbcV6pbGlg/a
	/Lpbxv+OlTeGJKdtrNy7BYLiNinqKQGm7Ewffesv15CXGnNzZDUDC/m30h8Xe83iVTrdl98rWQ/
	di1iEMpkyrlCL3InUewYl2aCXnCyud4cNIbp0QQhVmV5vCMcYYBqDbs/FpRbSB1IsDpktsmjDNM
	98nRvqXm7lJBbWJgbP/IE6D0pc3e11OOF0usgfCxVx/hNk9xPhL3G4fQwSXSnDFZwCIUtlbZrOW
	m9PNQomL5cWrrrrO6V5OuF0tnyY7JRjYCwnr7pIni0peFVYGbbGZNPG7v5qqRKILFXN8Nmr91ng
	1U8xfbgqq9OV0kuqjlTok3SHdLB0bvkogSqMq1EaIgoUyimjpk5kFVyXFA7d2Tzn9zmIdUhbiWX
	3/2g==
X-Received: by 2002:a05:620a:470d:b0:93c:3863:ff7f with SMTP id af79cd13be357-94932adc85fmr983714485a.0.1794584833617;
        Fri, 13 Nov 2026 07:47:13 -0800 (PST)
X-Received: by 2002:a05:620a:470d:b0:93c:3863:ff7f with SMTP id af79cd13be357-94932adc85fmr983709185a.0.1794584832967;
        Fri, 13 Nov 2026 07:47:12 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5f5972a7sm5636519f8f.21.2026.11.13.07.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 07:47:12 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Fri, 13 Nov 2026 16:47:03 +0100
Subject: [PATCH v2 03/10] fwnode: define the property_get_names() operation
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-fwnode-for-each-prop-v2-3-4edc23d5cf50@oss.qualcomm.com>
References: <20261113-fwnode-for-each-prop-v2-0-4edc23d5cf50@oss.qualcomm.com>
In-Reply-To: <20261113-fwnode-for-each-prop-v2-0-4edc23d5cf50@oss.qualcomm.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>,
        Len Brown <lenb@kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>,
        Linus Walleij <linusw@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-acpi@vger.kernel.org, driver-core@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1855;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=vlyXEW90tuaHwDARKd4JGB2+R0K81QD4UYSlZBasTXQ=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBq9zD3CCYRkoz3LSF5VgDezGuy7MTYSM/0TdLmX
 qVEWgNL346JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCavcw9wAKCRAFnS7L/zaE
 w1UjD/0V570v+6T5CVF4PFoZpn9KSq17LrtfokidpFBT7RDjt0GRYJmyKILIOlVrVDojHSNz5IE
 ALF8BoTy6aoU6ezLy4spqH3OC2kZzdtzaAg2dkBDAsHLjeXT5/QA+l6C9Jtre2CDtyAV/2TZfu3
 vVClJn4JVhPMDmaHAFWQsvSEODTOv6nFe8kuJ+xlmjRkoJcmKxzO58MIdNod6070QXKsdAOj4Pp
 J1WlcbOE7ohJPbiImQO4upzTUygicE1gmchdSj4okHIh5n53012m5vpVLKBCRweFnbUpLzhu9Pe
 jQF9QzJw8Z0s9DMHUZg6D6jxI/i79YzJJ6KPK0LgGs43jQAFIg+e/GaN6z5hWcSVco+n0f/sWYg
 2r22Fsz9+qknrFCJ0ioxrQicw78BXXeOLMQsNOATM9G3cHzy4Nxoe//20p+12c+vEyLva04Z1wU
 l1n5RtZVdhGgO+6zL/L7aE5IO8ZG7mIV1aXSJ+JkbWyn6K9szQrV49Z3K2TNAfCLEQEWt4xlFou
 L5kKlZY8oi7mWvpB0XVeXi7qo18prewpNF8k8AyEit5hNe8OZkyWLdENpHK+kiJZ8WYoBWyaAh0
 ikNTb9r9ZSTfZLatbOnya7dMYksWgzSjJ/3zgN/YiAF19+LkWm9T5CqXHtHmOeWZ3fWSZOyd0Bc
 UU0maWv1yZ+Xrfw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA2MiBTYWx0ZWRfX8ZoNdSGy0OEQ
 lCcSTi9gtoIIP/urhwu9OmMDTg5dFgtCQUsjBVYO8P0mw/DYahLGk4Lg3ccVIiJmijW0Vm0X2t8
 n3VbcWl8Uu+it0TWEyG6sBnJ9e2b+t0UmKpveyt8lFr60+hxaFlhzP8UmEvUcbgQOGEhhkCc9Wa
 XPkJ06r3iQW97YSrU7jvUPTK5WOk+MltkGcUdRPUdVfqbjZpcivdkUhcxsWFQ5EMnrf4LNJGuMK
 kSJk4Sk+cRlnjZt4OT1GUxaktS/Y3+IMdCjdWnRKiVG3E461tO8wlDbGzK3pzXibl5BjB5pV7XB
 ufn0WUWG+OSml29e+uV7U5Mi3E6DJWlZyup9zVJGcpB0Wx5nbUyaNw2eUcyZYGMbFTXrBljJb2T
 brawpygZLHhROjMYhStBujpM3Hbdvw7kXS8fJ0XaVCT4Rc1jrL4blwZfn88S0Nes1vhAVCG+4dL
 78we0DLxl/EBKy0bt6Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA2MiBTYWx0ZWRfX0XzdFViT74FG
 F02cXRXVyygzC9ugRSljlFUM3jb/ywm08bLJwPp2FRgCsXxiu27f84UyOMYipD20Tu5zsKwWf98
 W2NtMHq3apDuBnleebduohZlRykbNCc=
X-Proofpoint-GUID: ocNapVvxD86Octi8i_pXqP07_QNKBBwq
X-Proofpoint-ORIG-GUID: ocNapVvxD86Octi8i_pXqP07_QNKBBwq
X-Authority-Analysis: v=2.4 cv=JfcpPkKV c=1 sm=1 tr=0 ts=6af73102 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=jHVjgif8OWDE08c-SeEA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130062

Define a new fwnode operation allowing to retrieve the list of all
properties of given firmware node in a dynamically allocated array of
strings.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 include/linux/fwnode.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index a9dcaf7e70765637a0c33af2ae0ac541e15752ad..2d7e0b9245d445d473c7317bd27058abe5750b40 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -125,6 +125,13 @@ struct fwnode_reference_args {
  *			     success, a negative error code otherwise.
  * @property_read_string_array: Read an array of string properties. Return zero
  *				on success, a negative error code otherwise.
+ * @property_get_names: Retrieve the list of all properties of this firmware
+ *			node. On success: returns the number of properties and
+ *			sets *props to an array of NULL-terminated strings that
+ *			must be freed by the user with kfree_strarray(). If
+ *			there are no properties, 0 is returned and the props
+ *			pointer is not changed. Returns negative error number on
+ *			failure.
  * @get_name: Return the name of an fwnode.
  * @get_name_prefix: Get a prefix for a node (for printing purposes).
  * @get_parent: Return the parent of an fwnode.
@@ -162,6 +169,8 @@ struct fwnode_operations {
 	(*property_read_string_array)(const struct fwnode_handle *fwnode_handle,
 				      const char *propname, const char **val,
 				      size_t nval);
+	int (*property_get_names)(const struct fwnode_handle *fwnode,
+				  char ***props);
 	const char *(*get_name)(const struct fwnode_handle *fwnode);
 	const char *(*get_name_prefix)(const struct fwnode_handle *fwnode);
 	struct fwnode_handle *(*get_parent)(const struct fwnode_handle *fwnode);

-- 
2.47.3

