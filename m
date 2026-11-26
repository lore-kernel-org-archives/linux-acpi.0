Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795685805;
	b=lGz6tWu1gqdVFyUGj5jApCJ0xKQmivZlh4JrtUgi0/KY2JeVHluWCQ8hsTSfdzoZjooG
	 xVL6Ifqi8uvjlB/0tzBUO3rfjgVtmx7tJIeH5gWPzfNdRboRdEkAlNgCDXZ42sBxzCXq3
	 wwgdhRGdTUhIro9eiRoOGPTMkRui5m5/4QyzWHZDBd/qmA6sDjKHfJcqR2Mqy6E0C2nEA
	 Dbf5Yar6D8EaRyw9wR/nGu5+W+Ite6vn1WI0omgHZ50SMTmKSOwnJz4URz3NWaQZ6YKEl
	 5MCVJ0USvQvawhojlPT9DIqNrkAHTaRomSmRcThiojvqqlDnVryoh62Qpsv7N3GwdEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795685805;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=M/aoa2SC+DkCU84CzIID9inpDxzA1WGETgXSIeteeJI=;
	b=W19UIcawZ8lHGJoxtAhbdbgAi11It7/h+FvV4jiyPtKM2kb+EPOpz3QKjIiXI2AmgrpB
	 v2e5teUEMneffDJatbED76Hy1CtWsZuGFAvGW0r1RUUjXGr6/SAX/W3JiwIq0Xz81XUVP
	 aDiDvvlwh2lTmn/1GEFyWB77oUa5mxDQ5ncQ2HV1z9xjP+Fy/tQpFKuY+PCmzT2ddRct7
	 wUsREno/QkI9vvnsZZS2GazBz2BNvn/pay2RTX/npe7AWZCmgCytcZ5a6v9ogEBfIbxD7
	 G3URDbu8iaFsIq7dS9s+lgLIK98S9pMxw3qnnPe2MbCrLfsA0aCNuw4QF44l5Cc0u0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eQ1Uzgh1;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="jUiL6e+/";
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1E160A2613
	for <linux-acpi@vger.kernel.org>; Thu, 26 Nov 2026 09:36:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A1E160A2613
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eQ1Uzgh1;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jUiL6e+/
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQ7B8TS3548451
	for <linux-acpi@vger.kernel.org>; Thu, 26 Nov 2026 09:36:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	M/aoa2SC+DkCU84CzIID9inpDxzA1WGETgXSIeteeJI=; b=eQ1Uzgh1R3dpWvBQ
	Qc1BxFchNB+lggK6/aSLkCJXgQB8mMrq04s8FkDGJx7IR31VtdrP9BeingYme7v9
	CIwFYaZ+Db4vgpadfe1o0FxIdiy22Avam88BShLDmrYBKASLQsf7pL8NnGyjrsu4
	m/DShDkzCGeC1cK6aCcKuCI1QwrHKQDPt0SzIZokbdg6/uKJ49EXNRxIU0yj/GC2
	puGajCDeUVliAZBV9w7MbU41SSKqDrVwtTJ/Gph800ZP/+jwJc9ZxLcDh4Pgtt/N
	SocD+g5V5g8UzVfPbXCnhyWIpGJlK4eDdS/kYFjxMfKUeNJjJiEmn3uLOoumCaG4
	4cVhlw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j62vauafd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Thu, 26 Nov 2026 09:36:43 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-94960131befso976734085a.0
        for <linux-acpi@vger.kernel.org>; Thu, 26 Nov 2026 01:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795685803; x=1796290603; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M/aoa2SC+DkCU84CzIID9inpDxzA1WGETgXSIeteeJI=;
        b=jUiL6e+/7go+N9aNbHo8OTR90sNuZ+AhchS8yHCp33+qWN6GRqKJn17uMmUHCcEtcJ
         ZPXgVd0MKfFtagupSC1MTepGM0P2KuxtcNVNVKR+Hsi//YLu+DIS4LSkr+5/n/Ri4BWa
         v1Kl5w3CU1chNALjSfCe/mY6epSXmeWKdq0F8+lNsOyNbT7PL5tk0sZm+1fWruSS6zOv
         t50EkOFIVx2CzR7BrTHdtJI1ovICHotoScOxMkqLO6zw9Nr9dRxYqm2H1ktyYQ83A0mo
         PIaM6TLRUwLUy63MvDSei9e+uwKvtZMV3O6H1n7yYULlfaGnH7azON7vsDKfS6BX7LL0
         Uvkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795685803; x=1796290603;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M/aoa2SC+DkCU84CzIID9inpDxzA1WGETgXSIeteeJI=;
        b=pdbnc4N+6rD1Qv6MS79oYl6vocCXbKA3BW+bYAqAJrTI17gYwvXGd0flvPpdinI72B
         bdTLbQ+Xr8A/xekyd1G+MFEVtIFtoIOcMWP/FiYLnWx+dxqDZ1taWLFxRvjYpsjuPVlm
         qnUSnbA6SwSe0hV48oktYypzgYQm095InyKaLJAdb2DWJnn5PsgNjt9URqfPZGPA3u8f
         FOIQ+CcPQaZKjFcghUfN5GG17ZAW2dJ7lo8fFS/U0OJuTIeaVqjAgKgMLcMJ42M97Or0
         lWefNJTANZzxPy0NryN6wgI3XUOmSeXdJL+RA8tXhS5J1zz3sbQZiGAmyDNWzHDMnd68
         VFYw==
X-Gm-Message-State: APuU4Z8m/0LcJ8GTopA6VOjge8oqRHAA1+IbscoMFyDVgcmvbJlvv2/V
	i5Kn22qXSth0bgEklJPPZ16vrHVcuZXYhCc7cD+niMesORaYmkzhMvQ5xy/IKag/CfvLpCS2fEQ
	TJL08yFpwKcAoDWNXdCAWHoKfNKuGYlzkks3LTzgXoGUlmtato5NBn/N3AKuiVi9x
X-Gm-Gg: AZFdTZctWnYujNf2GpngMMTzdTQslEW9B4FcV//cqXnAu35HTYqpFfSwYI+FmdPNIuf
	kPhixdQQYLsIkdwv/bZIXHTKZP1cqE8kVzvNR4ukv0R/By5U+lO2wjEvFSl3vaOcO1FPqlXUp/Y
	8dKW637oTa1fm5dLDsj4I5txzkF8qt7MJvowLOx3wMMhVoyYCwGoVuC25GLjQq3UXvyZ1WXSPy2
	Qjg3TDovL8B/A2XAGFEQCA77nvpTnXXQ0h6Q91VX+OgqLODR94x8wthwUXKyFcLKRjMqCeBpyc+
	mBAGKu5t5AWQBwS2L3dlaAfGeqFU0qyq+XPCijo7dMG0sGnXz3UI38cWZ+LdpTui2Mp5YJ4I5Y2
	XfSrcou1wBWzl9UnZp5mDbd7wBsaLX82j7KHOHsDxa/klz+cIuW1EmnA5TJFaBX6j9jCZrqrkM9
	LXCQ==
X-Received: by 2002:a05:620a:a408:10b0:94a:889:5a41 with SMTP id af79cd13be357-94a08896148mr539864085a.71.1795685803006;
        Thu, 26 Nov 2026 01:36:43 -0800 (PST)
X-Received: by 2002:a05:620a:a408:10b0:94a:889:5a41 with SMTP id af79cd13be357-94a08896148mr539861485a.71.1795685802479;
        Thu, 26 Nov 2026 01:36:42 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8960068fsm227079335e9.4.2026.11.26.01.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 01:36:41 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 10:36:25 +0100
Subject: [PATCH v4 08/10] of: property: implement the count_references()
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
Message-Id: <20261126-fwnode-for-each-prop-v4-8-d4b370ecfd52@oss.qualcomm.com>
References: <20261126-fwnode-for-each-prop-v4-0-d4b370ecfd52@oss.qualcomm.com>
In-Reply-To: <20261126-fwnode-for-each-prop-v4-0-d4b370ecfd52@oss.qualcomm.com>
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
 bh=vpHcZaLg1iuY8wj6IMHjWOG6qRHq+3ydzmu44JzsEu8=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBrB/2UJXfVTy+LhvtNE560ipdr+7qsCNpwsh365
 sHEwfwrLSiJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCawf9lAAKCRAFnS7L/zaE
 w47fEACiduOFuZ5D39+RtQMC82XPATkIZP00Ln/9WqBR4IAiUKBKohur+TZsFpIJzt9wOSyiKaM
 J6T6Qf6Kf0chV4Xm2uHvg0kLvQffYIqPPgkr399d4uxYBFqMAmnXEqsIl2YHhozmGjHoK/CLj/A
 eUEhj/wL+RE3gjCdm2DUj9G3cWRLJctMBZQzoQjiGyXgWBbPlfXpAqqOJaYEVdBGu9mAVtoV9+M
 m16dtpnDB2JPrDq7YmukkIxiU66d4pwkUaWfk0O8vQXoWs3Zu37knwKld92AXaPXR/x9ABBN5jB
 rUJw7rtSfVGIN/7BCBxgZjVGeNc3zw1TnKz8yKdLsUJRNlhUsKCCv+MelNjEtGjuebWIRlkqGWt
 d10L5ydRJQv7o/CJkLmXM2yrxMHVhlCJHUwLnY/p3lQeUGnhFIo/YxkaV0p7aEP+QAyaE6lIGwy
 3j5IGagl0G9WX/0Jaz3lKs6SdRdmLX5UO7+EEoabQwBvcelQPhNHYe7A7nVfcBcCyEnZzk+zWqn
 mZ+Lv2dyHoDY2yLPXtmGr55DUaLdOyYLbl6XjXE6F/anA61Fw44QakDHCd5c/mbTR3noyVzBUxx
 s2eTq5/lj2J9kriliFpQukiddxj0GPcE0x2hIlHDvsAkI2HX3ZPofSHrm1mHNkCIyxPaW7L0vno
 WIhmYhAYEomBamA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDAzNyBTYWx0ZWRfX8NYEO2toCMtq
 QgkaE/FY7XEDL2nANDCjFBUi2LHVCbJsRUTuI9EUcVtsC7pMdauJKRDGjg1mfopxSUx3fW+6sl1
 kwDWjMuGc2vXeT1kMaagV0/TS/ej93Y=
X-Proofpoint-ORIG-GUID: h-EIsSh7O8WpL6da3LFpZBkz9GBVD-UL
X-Proofpoint-GUID: h-EIsSh7O8WpL6da3LFpZBkz9GBVD-UL
X-Authority-Analysis: v=2.4 cv=QZPzLcbv c=1 sm=1 tr=0 ts=6b07fdac cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=zSBz9IY8uK3Zdpgw7pcA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDAzNyBTYWx0ZWRfX5APaGP7Uc6ld
 oYO2FNi5h74e4pgHWc3BcYoufd7kHdJsYKSZisQlCap7efv9zY1GLUbuoGC3XM1SDmKrEd+l2bo
 QbTd9IuR8N7SJI47GbBgTh9wTl7pblvJH78axcCdAaecdYrcF+CU+HsgJuzUYDs9lVUR9ac/mQr
 o0dH1lE5zU8uFGYRLQ9KNDHKNJSNX38p5XiV991UI8NEnxmZr3z/CY+2Af8YsGivxcBQLI6xTQZ
 OjYBFqTPHHdXGzRGqPrBIXQ9A8fJTQ33ieJaR2ymdRCnzXUSV8jOWO8CY8OR2HVOoWLarHpRD/t
 v4LlT/5+pGWcRlVMy8jDRDpy9tqyavR+lSpja6wogadRVm+KtlmvzvmNgJ/wL8icO5HDNAcdh9v
 5z0IJk93ENI393RLChOQFK87LurPBgnNl5H8+yCPTi+vEttUjqrZ5XtCEuVAmAL05GEYBQzuId0
 EeUhCiaWx/OgoL+bdsw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_02,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 bulkscore=0 phishscore=0
 adultscore=0 malwarescore=0 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260037

Implement the property_count_references() fwnode operation for OF nodes
by wrapping the existing of_count_phandle_with_args().

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/of/property.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 00349e78fa51455696d0b34ee02ae55c20cb23d6..bf2e8ada7cb32d28437174b0cef1fb5958f2cefb 100644
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
@@ -1774,6 +1780,7 @@ const struct fwnode_operations of_fwnode_ops = {
 	.get_parent = of_fwnode_get_parent,
 	.get_next_child_node = of_fwnode_get_next_child_node,
 	.get_named_child_node = of_fwnode_get_named_child_node,
+	.count_references = of_fwnode_count_references,
 	.get_reference_args = of_fwnode_get_reference_args,
 	.graph_get_next_endpoint = of_fwnode_graph_get_next_endpoint,
 	.graph_get_remote_endpoint = of_fwnode_graph_get_remote_endpoint,

-- 
2.47.3

