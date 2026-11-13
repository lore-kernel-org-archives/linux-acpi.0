Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794584846;
	b=AKZBYBcr4+fHfy1XP+/PoJJxflNmDPOY1cINFTW/P06G2n9TbyNghENRx97/U9slOi4L
	 jYBR9fPW47+XqWCVEg7XD6ZAhYsiXXKvVOG//dLmB5r6z2RYnobYB4LmcAOE7cZxHSHRP
	 3IKMXeTZ0AB4OIKOIYemn8JBWLiz+BhMYCKhAFboX+20/ZLNfFoXfaqpGU/lj0FnGBpQU
	 GQ4+oqQAkTgGFk9DuDr0fnM8CduSpQjj2ApZeDpXQAgf4QnfYvbC8Vcl08tsIg80LUJ4v
	 IcBuLjsqJ/+j9cgaGRgi9bep/XO5I+8W59o/6fspM5dL/q4IkBWyiU/vTm88Xmgc8tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794584846;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=N2ybjt8AitZmOWyIeR+WIyasX0i10altN4SUehbofLs=;
	b=wUbEKtCdobYxjoVhFBzl8UzMQLQIE02fg470RQqo+sUM9+FKv4HwUT7rYk+kEcT9iXYb
	 ZmBF0sBZPx4Qyec0+aejZgbYWFYaAZezdKmxwtkT8tGw3amb4wivHXciJ1uWRdaQRgPSW
	 oi0pDyjKuE8pB3VfuDgTKGU8AiTbEF3FQEhgIwLh64QDQtP4fE8E3tThPf+08cQt2Wr3F
	 5YWqGFzQdEwawdCE6/mug0Zrzr/TPph2JADnjZjUu+X3EoQp57p/zRh+ZqcJbdkZ9bc3Z
	 oWNCTvZDuXjMpd3f5BlWDCKkQmRjhhtIPWEYZliETeSUMkyK4VaLqRi9VxspoQEt/9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iekG1suw;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="EoyJzVC/";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2819E60A3827
	for <linux-acpi@vger.kernel.org>; Fri, 13 Nov 2026 15:47:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2819E60A3827
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iekG1suw;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EoyJzVC/
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADFRVHg3296211
	for <linux-acpi@vger.kernel.org>; Fri, 13 Nov 2026 15:47:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	N2ybjt8AitZmOWyIeR+WIyasX0i10altN4SUehbofLs=; b=iekG1suwraLe5Iwp
	M4S1mk3eVyRSu1rhTFQzNkopKjX99A0qeNpQjDdXsC611k2wve3nYNcVv7yRBAEa
	3Roh+ewvTQ5+dTQqVgKX+AD25daTjH3RFnyWUeW1YQ6sGIB3EY4UUiIlCFdafRwL
	hv+LqyAYbx1ejFXkcMSqrOwxhH8V/u3HSHad1QaUVCqZKPbwexJpqAJdbU0jfz2X
	WQkUgYIn1dbWCyrYKrdy6KNrFxZOaYT8Juy1ExGUtBTNd0+RJCe3oIa6ArCbD5oZ
	L9ogVY1HpbJsUCUnNFnaKeKQ/ynQiaFvjpl7/C459O6Cn+p7P9qOtlgO3TZo59xh
	UVfJSw==
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com [74.125.224.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwvu6t0p8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Fri, 13 Nov 2026 15:47:25 +0000 (GMT)
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-67994010b21so1447284d50.3
        for <linux-acpi@vger.kernel.org>; Fri, 13 Nov 2026 07:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794584845; x=1795189645; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N2ybjt8AitZmOWyIeR+WIyasX0i10altN4SUehbofLs=;
        b=EoyJzVC/TB3buxg7jErJpRxJSLKJuz9g9v4bbI0K53fDYE4C2tXgUXlGOuT5ZQ3OeQ
         puEf2MpESJvJaEE3zqLLXZoqb5O6PBJkfu9g5O5HJtiCuZ2MwbgeZZRWH1c1cUgmWeKG
         ra27PECoiyLsPGj3mP0m+LSOC9o6tjR6/WxVp2JEZ14G/4+NIz6psY2j7rbUHPV3myT2
         Ph87oyxlWCsYw9jCxhrKxZQqrHaWdLzmR/iBEvdcXIvsh8jVz+HYaKeu4njcUVbZyGRN
         1DQfdPiRRx1FCbIB6QsIdIqsLk55yFWPKAT/B1qtQ7VhWoQ5G9FTcgVqkpa13ouifCZ4
         UkKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794584845; x=1795189645;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N2ybjt8AitZmOWyIeR+WIyasX0i10altN4SUehbofLs=;
        b=vARAR9AqN03rK0iKZAIex5+zSG/eOD5og3tHWGgRQn325tDX/PfuRhIeIGdfce2b0O
         pe8v6tDKSOiU+JaIS6r2CNFLROBEoo4jLSXxjVZBf8NaLSUJxl56Oo6wEOrsYhCn3W2U
         NROqMa5R3MjcWaTBnyMUuML6tvjRzBx24DjlWgiVX09w3XM8oUoSNgw1lWjgYXk8W+xr
         hSCvA+AapeiwxZCK6ceVjvTe6xbqwfhkXFBm5qxEgx84uJ8em1uYiS+pZhXAxN9wDkWW
         IHCQNv3cC8v390Xku/1EhuMnstT0wbJRRZmd5cYxAITSlTCZWuYklcGA/P+Pm4Ucv0fX
         gjKA==
X-Gm-Message-State: APuU4Z+LXL3rzLlnqLarODASvFZmoJ5zz7CJtW19UWR5F98U2ONuftUq
	TYawkc5tJbgcj1X8J1MEfvz5Zcr0QkO1mqqFS7W8AFgyH3r4mgYDHQuD8i6NyGko7kCEWAkn6GS
	LXwFlgIT0mQHIrfUMJAReYN+8VINvaueZvScARA1HafqYmcO3WxryQkCFsJf9h5gi
X-Gm-Gg: AYBFou3sBjuarPKW/tSNMqwoA6v1CciJf2AufwKlAqTbQHuI2gb5coez+E3VLq5gAzD
	NF8B5C9k1JNHb0FJ6gVaOi1DOJPEplDA4W6MUJFEXWGeEmkJFjleQDj+mylpKDBXNJ5nqjACcqH
	e5TPjzsDVfKms0Nf0LulZCNE1mnZnDP+WUXpkPg4IPYUbuJTDoYa/7BeQwyx5z+BoIvC3uS+xll
	foDT8OdwDGIXKue2n2vgVy9IAngt/TLTGHkT2twYnrB2RHoYK0lXCV2/6uNlMCQ2Z/xt8LopPPM
	PvlOTK763zmnf73b3OvD7Q2qUk6KkweZbIsRICtlkIH9HjHRzWNDFV8EpWAw6V70QmQ1WTiv1ei
	Ps2Q/nQs6WsJUEX/CNzlcOHpSmYDOSOyzDyy8GgD1gvrGJg+LZNrsnDftV/dXNI2Cv9kBQWDrkC
	RofQ==
X-Received: by 2002:a05:690e:bc3:b0:67d:8ef8:30bf with SMTP id 956f58d0204a3-67d8ef837d5mr1024488d50.36.1794584844721;
        Fri, 13 Nov 2026 07:47:24 -0800 (PST)
X-Received: by 2002:a05:690e:bc3:b0:67d:8ef8:30bf with SMTP id 956f58d0204a3-67d8ef837d5mr1024446d50.36.1794584844098;
        Fri, 13 Nov 2026 07:47:24 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5f5972a7sm5636519f8f.21.2026.11.13.07.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 07:47:23 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Fri, 13 Nov 2026 16:47:08 +0100
Subject: [PATCH v2 08/10] of: property: implement the count_references()
 fwnode operation
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
Message-Id: <20261113-fwnode-for-each-prop-v2-8-4edc23d5cf50@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1493;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=BHN0x24xd95rb2mhrKGRQETyCRuc9VJoqjjnbX570po=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBq9zD450ufs2CwVIpCs23mOJpPGkbNozDQSNWMs
 7IW9kDBc4WJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCavcw+AAKCRAFnS7L/zaE
 w+jCD/wIHVO68ZHJpmCBcn8RSkyF/jzaZvq1EgP1/4uD5r7F47ZOwTPPMLcD1RwLlOJbHtQ0Vq2
 YFupfXTyrv4pK+6fyFBX5JfE8Ev9v6AV0ylQZOJbesz7/bJz5gSestg/uBJc5ONJAfowsfNWmku
 nFh4LKwV4kCuJbfHCtc/AIMC9Jog5Vg3GzI2srmBCp5YHcweYKcpeYt+IpKwaBldPyNBk8avMK6
 qe/hSVFsRA5ADywQFRBGIy4ghvGgq7Hz70jx0Zv3vc2j8VitCD88MMuuQbOI47szWMpMZRR6L3h
 r0JKZ9EvpgMxFQmiQWSvVjMdUg5Y0/dUGjwuYFIWMa4RylfYWD4uydrXaYlvsVBLB9sWrAniRWk
 PS7fu92BO8MRfXGHEEeVSAle7/0w7C2uGUbHJumm4PXYtRhlbawUGgwgHTxh6dA3VNvhUvWY8Hv
 EyKYOt5kX6C7sMuCA9a3VCSiDZYdVICvSLovK5LfPxW+l1ROTDoPOMwb+qBNQ2jcUj98SOAagRQ
 aL65XoBIlV+qrUi1B8uW4JLGFynn8FNrA2cCSiLP3eUeb+tcxb3vV6psgj6oTJB8qia14sf1AsR
 auibpNS867CZQSAuPWaX0Q7uymbX/MoOMumWYasi7033hymL9Vk87MJPQz6YsAG6AvZqWlKcQEi
 YP1Gau68T3bcFmw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA2MiBTYWx0ZWRfX/3jueLabKiub
 yFrlhiZB6syGibeCrjt6IoSqO5kmd1OFja8h0O4kyxIQrSzmmFP7fIxIorZHUQjMNSrkh3iJV86
 9hwVNUshaRcb5fcwSu6vA9293XXAOQLUexfE5hN7mdb2ajapQo4W5fmzA+In0/xWzL6dw6py2q3
 OBOt5ZQH3yf+1zBHXwfBKXFB8nxIG9mFD5sXtI6NwNZfS7WQcvBWFRQhO0nkeDHhzHLzQho0ltT
 3VUW9zyySIYL/WBpqMGTA4xwZBF6SllcstHHprXczpqKJRstEXN7uKbJvIY4QDCOLFoauRkAWTv
 Pn8CCCcPYwMnGUL06oTy+B0qZCGs9hLbQ5f4IJWdxPYmac4mnuieigyQFk5VIdWdmBVkBd/Ef8K
 QK9nloVpn56NRI0wasinEnwLdjuf1u6Lni61RiItm0kRuFKrVtyqpi/6P1q3Uuf8+OPG3Kdh6du
 BzJTUFE4236rru0R54A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA2MiBTYWx0ZWRfX2cMB1lVzbHMj
 y2KLl5VebZ5l3kHIl96cbMVHHCB3TOayWQy8xT1/I3lwL3bUfjlVbS1cXDlFzeEBoOAwF0w9fQQ
 imSTkNB1E40ONKRinZY0XWw0Ue+khd0=
X-Proofpoint-GUID: Bki6FukosVigAzTyiTl3zvKopnqhsMVe
X-Proofpoint-ORIG-GUID: Bki6FukosVigAzTyiTl3zvKopnqhsMVe
X-Authority-Analysis: v=2.4 cv=JfcpPkKV c=1 sm=1 tr=0 ts=6af7310d cx=c_pps
 a=VEzVgl358Dq0xwHDEbsOzA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=zSBz9IY8uK3Zdpgw7pcA:9 a=QEXdDO2ut3YA:10
 a=uujmmnXaIg8lM0-o0HFK:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130062

Implement the property_count_references() fwnode operation for OF nodes
by wrapping the existing of_count_phandle_with_args().

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/of/property.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 53f2c84bcb96d3a00f3cd2371010628493d49bc4..c2f5c338b6d1e7f3515be76d21ba6ef097e65e04 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1233,6 +1233,12 @@ of_fwnode_get_reference_args(const struct fwnode_handle *fwnode,
 	return 0;
 }
 
+static int of_fwnode_count_references(const struct fwnode_handle *fwnode,
+				      const char *prop, const char *nargs_prop)
+{
+	return of_count_phandle_with_args(to_of_node(fwnode), prop, nargs_prop);
+}
+
 static struct fwnode_handle *
 of_fwnode_graph_get_next_endpoint(const struct fwnode_handle *fwnode,
 				  struct fwnode_handle *prev)
@@ -1749,6 +1755,7 @@ const struct fwnode_operations of_fwnode_ops = {
 	.get_parent = of_fwnode_get_parent,
 	.get_next_child_node = of_fwnode_get_next_child_node,
 	.get_named_child_node = of_fwnode_get_named_child_node,
+	.count_references = of_fwnode_count_references,
 	.get_reference_args = of_fwnode_get_reference_args,
 	.graph_get_next_endpoint = of_fwnode_graph_get_next_endpoint,
 	.graph_get_remote_endpoint = of_fwnode_graph_get_remote_endpoint,

-- 
2.47.3

