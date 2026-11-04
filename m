Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793801080;
	b=b1iIvjbd64xCMSxgfsP+y7u9ksOb8sxvzZ+wMaxOdAXdk+xxuW1lafibn4wengv3LE++
	 GoTXRZgSBRb8zRnYCu+bOrE/uj+pRbI5GmYNIf4B0alSX2LdjzkUKiXj8ZerAcQINu4HZ
	 YA5zKyLZyDBANl/AOVkwXvz6+LVy8C2UHHp5iB4q1zUddfvi9Ym6ji9L+Tzfo4yfEZrbb
	 aQhynDL3YvVQkUcFO8Vpsu90LQKhNJEV/EjUTZCvEY6Dq+d+bFAxsVHshxzel4lgi8LBD
	 rLLtlVa6gLqFn7VNqzwk674iCFxNA3vtxdJbBzxoRdRCSa96n/9SPaB+ov5Qg2w4wag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793801080;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=RA2CSJdL7Exblpp4WzRIxFOf+cFemPFyxHbTRFzm9pI=;
	b=0pCD+Lm4ivdh1ficoVhvUinHg07jgpWWdMGOG2GOepcFhcJ6XfyXJjFloHD0Q8dpOUf9
	 JaYRy9nVxFkcvDMc6PDEd+aA6fbLxfq7I5Ahsa+BqxsDVjMilAzt5zJsUlKOm+YgEIe59
	 yjqfsXt5xDlOFQXR0gOutwB5IY8vLR47gDhCOMMvajp26H8wggQJeFdEwSkUMpDF6S3sl
	 jRw8H95sooWGi+5yHOEHqHJ4+7ybgFlRNRcbtyZ3/TIB0nSQwcWBgoPsa7uDHZoHt2O5e
	 e6PvMhPOGuxUD65AGXIvg01Tqppw58W6W9g1UYvwSSCsMI0xG18HCbL4QdKcStdbuqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=n6BlCfAp;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="NvbfJL/y";
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1011A606EEAF
	for <linux-acpi@vger.kernel.org>; Wed,  4 Nov 2026 14:04:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1011A606EEAF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=n6BlCfAp;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NvbfJL/y
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A4Ba0sv1667658
	for <linux-acpi@vger.kernel.org>; Wed, 4 Nov 2026 14:04:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RA2CSJdL7Exblpp4WzRIxFOf+cFemPFyxHbTRFzm9pI=; b=n6BlCfAplDkRIGJY
	OtZvEiHnmJxfVXUqgCmbQ3HY4qMos58f49uoPT2qpuxiyvNqXiZUg3EAZ5KwManW
	X/P1irYdeYwkWlRqhibdk0ToPW3KLNnTBRwQTibR6cnH0c2CL3909RF2qxFC5T4z
	MRmi9u6ZWWSk4u5RY207c56jDfI53aj3If+toqprwFx9Ltygiea/igBKX3yIXB1z
	2ASo1yVQ/7vqLDwKgTyjFS0FLODgtQOWhBH3BwSI9kvYT9eMd0/0Aucly+AJ/ijl
	ncAoe+ZbTi4hAD4DoJLZaXlEQGcrbpqC04GepOi+liW37GrSLDaBhRL1d4h7xKaf
	1U6CiQ==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqn8nm4d5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Wed, 04 Nov 2026 14:04:39 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5eab0467c89so810762e0c.2
        for <linux-acpi@vger.kernel.org>; Wed, 04 Nov 2026 06:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793801078; x=1794405878; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RA2CSJdL7Exblpp4WzRIxFOf+cFemPFyxHbTRFzm9pI=;
        b=NvbfJL/yWxdly0mzMB6/yTHY5+E/Ed5Ks5a5IdsMVPNmio7uI50dSuB7OPdrgmR/iJ
         YzLCDOysbwjZmCAMywp1x1GvF13tF2X9QjMhslJc25ut4RmcRt3DBjP11Xc4iBGPT5LG
         JsLzl1Qqh0aprVLr0n6i/Iz2oVbOVnPXml+LGzbZAn4dCjd8QOkXq+DVyI9bAuKnncvh
         eR4x0xTwt5J1NK2j1Ee6jnMv1eRQMybnj0OIj4P59aWcz7CRxzpPSI4hP9tVhkKr7JsB
         PudwoIpfe0kOpaNwiJeTBEvECxLxzoKJhXYEuT3MFMed7j/Nt4xx2Q93r/0kRIZOZUrj
         wE7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793801078; x=1794405878;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RA2CSJdL7Exblpp4WzRIxFOf+cFemPFyxHbTRFzm9pI=;
        b=p0XIf2lhwkvUXQO0pIEvsoyddos+KgWUjOH2GEDdjt3VCTWoUHk1OZG56EuASoGq/l
         LHvFB0NGa643MWBUUqDVExafZkxecNiQ7SfzqqAT8vFmBL7ZdFylr01mI0oxiQF4yv0C
         ZQoqRYnNaa0ipJ9X/0/TvWNTvWRdFU9sI3Mxi8ZvG16Ia0tRp3Kz7+WaXUOFlLDzvvsK
         yay2RKXYZGsxzWipES91+Jf7G158LApJiNAtogVph7CnvJFcYUGxJJXrHp1zn0QYPsz6
         M6VszmiHa8wlKzAW/PBZS+Q4bcAM/57R97tAPIMyRiw7Hog5ldMcz6x/AdCgbtg8wc+W
         2GmQ==
X-Gm-Message-State: APuU4Z+VzpX4Dh9Z/Q0Qa/wBdNBxdZdbzSDWZR+LKJrnmno25G++GLmN
	+LrikcBbdjIVhgqGMbSI2eKXhzVBwmrABP+4ILorh1jwX1MMXiH5CxdZhLo3d4n+KOfleY0h11N
	QItDI43sptsz4utMq5mD8I7zbCKr5WvPSCmtIr28pKK0stQ+3pzBlRFfmrRFHUhkW
X-Gm-Gg: AYBFou2o8zKaga3ERwb1uvJ4YKBpPQ/MpWgyTjx6bkgO7QIqYTEOtPncAmdTEPkROq6
	f1MaFS3jfghlBBbZ61c3zgIcxZf/KPgbDExAUJld/Hq5XgINAibZbg4BcM0NK0zj2q2VMINlv1V
	3unhjxz0q2TXwlmeDVgAk6i4GM80xAD8uwGc6VZrWTQ4WwHFKRoROZfzaex8BdZ35fsJqZlm6Sc
	4mTJTnOGBN1tyg3VZe4U9EHHcBZAQGdYdqBigKqBsJSUQpvvppDQmpS4LBrzePWXPZcA4KYvT8f
	R3bzbevK0zfNEl6T5PyaH9P4rDrudRW6YPTXcHGLR19CDfo8867YOiL1uaDNqMyc1zkxn8Y7I+F
	a+Njvc+m/mRyHeM6UjIUHawaSQ7LzpXx/RwhqhckTwjaaipekTTPMLX3wWheReeYEFVwRFynAQ1
	s5jg==
X-Received: by 2002:a05:6122:c89:b0:5c9:c60e:3a48 with SMTP id 71dfb90a1353d-5ec689f696dmr7593990e0c.20.1793801078335;
        Wed, 04 Nov 2026 06:04:38 -0800 (PST)
X-Received: by 2002:a05:6122:c89:b0:5c9:c60e:3a48 with SMTP id 71dfb90a1353d-5ec689f696dmr7593898e0c.20.1793801077646;
        Wed, 04 Nov 2026 06:04:37 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fec8d87b5sm3968358f8f.11.2026.11.04.06.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 06:04:35 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Wed, 04 Nov 2026 15:03:50 +0100
Subject: [PATCH 8/9] of: property: implement the count_references() fwnode
 operation
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
Message-Id: <20261104-fwnode-for-each-prop-v1-8-6e28fe1c72c4@oss.qualcomm.com>
References: <20261104-fwnode-for-each-prop-v1-0-6e28fe1c72c4@oss.qualcomm.com>
In-Reply-To: <20261104-fwnode-for-each-prop-v1-0-6e28fe1c72c4@oss.qualcomm.com>
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
        Linus Walleij <linusw@kernel.org>
Cc: linux-acpi@vger.kernel.org, driver-core@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1446;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=jfcJL94RVspgN8CyK/snZo0rp9b0uidqlV9W3mfnsrY=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBq6ztSrVGZJPcf5ImbusE8w0YzObuzDwHNwk2vf
 XWwfHOBNamJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaus7UgAKCRAFnS7L/zaE
 w2USD/9+/oAE3ozJ0woCpNJfEKxkKc6OkP+Fp13bf7ApUWvG71blBdfNz430uIpxhii9lx9NSHF
 H5yKot93opIVe4f8X7I07vIwVAQBfP1dtTdnVWavMAELyhSWVOIQX2Lp3EFd4Rtky9afjzaw5CJ
 n2zulXoabInrDbALeCiYXy7xfflbtsynqdIjm6SLgnLpb4SURUSTbySU1yoF6hIZLyU9GmQ+Zm/
 A5D4lBHWrYNUZL0OIcWQvWX2Rq/S98QJJAzublBzvLUImTHuwL2SuDBQA/qMIjc8oKlukqHP+/l
 QGKLXZ/T5ru2K9z8VOZXMD6tyZBzMrVvhZSIBS3UqsgNlS5FSNVGiBR5bWprnwdgXI59W5smAKT
 toEgXdyTdb5o5ZUIziSIfpQabmoln4rKHRISWIGZQ8WuqucOi1iVa2XCEQKsUkLiy82wmALNRKD
 uPDnmLZQVGnDdSWcMrHPAQ/qWTFNV4K1lClnzSLHITbCd5uM4piou2+lxdYgbR9X36K5wP2jxS4
 areuRfuUDSYwSS/3EZBlTtUolLcKcPFlfrgY+TPvIuh8EPLSKz5Dc+BGF15ed3UqLsy8M2yU5GU
 GxstGJJLPGB+wYvlupd0Y9JXoZFvF0wuLIWD1XqR7FCCgW3to2+DXgWre+0LHZF5xUFVpyD9SjA
 YNWIV37TclMW99Q==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA1NSBTYWx0ZWRfX7Cybh1kTRuRo
 AhekKiIunGIIXa//4nmMm5VCosbTWOQkdmVHGtf8yloy3CkRrtqxvC7N1snvWaKYvUIaI48pUwz
 GnTkphGHr70UzPMNm6dL5Oe/WWmCx5y5KTONF8I17kn7TLdWkkp1ZrL2gCSMlmJb+ZNclrRS5SS
 6Ig0XFEoesHdLRc1gqal2xK08s7ZxLA7IEQi9TDoJXH7UIP/AUqS8gSOb+k5PSZi1TwaF3mS9fm
 gz9mXTWqpm2dFv9ncLMD0QlYfKzKK/25gmiTda17FYThjh99sm1VTk+yNPRu6BUBfJze9gp+uac
 cXS7He7fcVxpj17jhRecnXYoYMWgUZFSAixOwUXaEizpGeEUcLwuZxhfuz2jIQMLY5mzlXCUWL9
 zD68hPlr75j5GEXSPFNfnQeh98bKuT1RAZH0rIBsBO9QcFsUGdchJAUw5J0XyC7ZywlY8cbPuuR
 0M6P2TXC/vwg2GL4y5w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA1NSBTYWx0ZWRfXwq3HkoGGC/1t
 6uAapGGfN2QaW5mYuQoHU607wYR+WwVnaEQNuSkuEM0ZmSwsuOzhafNBuflpjEcaz945yWXFjvg
 ZwysxfSgrnAEBC2d6U3EzQ8yvDffBt8=
X-Proofpoint-GUID: KM36cyN20dYv_BTCOe-Xs936TwlTdbZO
X-Proofpoint-ORIG-GUID: KM36cyN20dYv_BTCOe-Xs936TwlTdbZO
X-Authority-Analysis: v=2.4 cv=As17T+9P c=1 sm=1 tr=0 ts=6aeb3b77 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=zSBz9IY8uK3Zdpgw7pcA:9 a=QEXdDO2ut3YA:10 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_04,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 adultscore=0 clxscore=1015 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040055

Implement the property_count_references() fwnode operation for OF nodes
by wrapping the existing of_count_phandle_with_args().

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/of/property.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 16c9c307633bdc7c9343782b1cd3bdb845552c6a..ae2561479e2382b241fd87dcddf52dc7f52a950e 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1231,6 +1231,12 @@ of_fwnode_get_reference_args(const struct fwnode_handle *fwnode,
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
@@ -1747,6 +1753,7 @@ const struct fwnode_operations of_fwnode_ops = {
 	.get_parent = of_fwnode_get_parent,
 	.get_next_child_node = of_fwnode_get_next_child_node,
 	.get_named_child_node = of_fwnode_get_named_child_node,
+	.count_references = of_fwnode_count_references,
 	.get_reference_args = of_fwnode_get_reference_args,
 	.graph_get_next_endpoint = of_fwnode_graph_get_next_endpoint,
 	.graph_get_remote_endpoint = of_fwnode_graph_get_remote_endpoint,

-- 
2.47.3

