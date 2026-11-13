Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794584844;
	b=LAvssxSCTcsiyJU4NGoE8K/3Ucs+7zbu/OyEKfY3AigYup9vUvO5vxoZlJpR1m6dMOqm
	 HPFbpB+fNMwoTr9/ncevLH19utKsbIYZq9K5Om8OblB+EYWDwm6qQTe0RlEtswz5ZADgM
	 NNgW2vug8+gHCMmmIqLTVRd/jYsPrI60SGscVBrzPgc3WCYwMzaONs3FPMl/oU1L6uiqX
	 QYTRzBX5OOyu+g+XS+JNatf4Rapsakal0GsMNTS6ZxeOqc0xU44dFNj8k+RsUIIr3w5bX
	 9D8Xdo8su0mibl5weWSIpOX0ARedadSHWJwBw0i+iKHQJ7JaQviQ02zKC29DyexnV0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794584844;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=/aAsP0tWsYUKW0MBNVosDOUf3N/w5cc7B/jroRraKSc=;
	b=wV9faGwZDHI6h9F1T1xkx19M+NJufR/RxKeT/p0oIH+DqdcIIsKDIpvOvIeheBNobx6m
	 LwhAH5o8OVtbVAVwvSUrID0yF/FSFKtuGR+K7pvaVvISrzqeDUTm7L3+4+JTPIP+Z7oe5
	 NT384BRb1j+Z6lMcwRmh6RB0p6xXsbZcqjf8kEctGVsOR+MpuOTn+dH2zdHHUi2B5FhXw
	 M2xTLcnrAPmy7oCOo1hrHj3oxR9iY79PVb6F9bgjKXoxv7A++JhCN/zP+iBC4vUFYHzjd
	 lPsWGJ36ODyPBFLPt2t8frboQyioaooNL0ujs7I3j7UeCWWYhQXrFEgyRG1ftWtPPhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Mn32ISWt;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GduzSAZn;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A06606A338
	for <linux-acpi@vger.kernel.org>; Fri, 13 Nov 2026 15:47:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80A06606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Mn32ISWt;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GduzSAZn
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADFRKuk3619307
	for <linux-acpi@vger.kernel.org>; Fri, 13 Nov 2026 15:47:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/aAsP0tWsYUKW0MBNVosDOUf3N/w5cc7B/jroRraKSc=; b=Mn32ISWtPOu8SjRi
	6wISpvzdFB4EPXb+HA8JcIMo9+woDIKwXpvt20MwmRmsU29q+sc1DS8GSpg8uqeu
	h1CQMoWKyRc0X8kir+YJ3xL0Osm8u0oQ99+Cqh51BvOp+N4hNsQ5wKmeUiH2Tlk5
	r6I+iFkC15OsldKvhgr7AhhYk72ZYagYOYTRAPo/OSxGhZkN3BszpQvoXGqJ5nsx
	h/KfO1sXMWMse4rlfqmJCkQU+mQ3IECDRC9n668GfxTDyxbxEMecbu78ToQfF8/l
	SaKYtZXW8JqgCGj6TUwGmdm634hiesmWzeO8WD5HH/uhXWAryRn4AJl1KXw6ohdk
	t4sNFA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwg1bcpuh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Fri, 13 Nov 2026 15:47:23 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-947a607ec40so110030685a.3
        for <linux-acpi@vger.kernel.org>; Fri, 13 Nov 2026 07:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794584843; x=1795189643; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/aAsP0tWsYUKW0MBNVosDOUf3N/w5cc7B/jroRraKSc=;
        b=GduzSAZnO4oHTc+NA0HJRhN9v1up6oUoVT6V4nrvGld0rWEhUkWKFwZ1MqiRiBbZBO
         pBROpAa2SxB0sKquGG4At8FrTYOTCJWXAixlVWmE7ExuxESX9+uA+rJ2xgewvEBN5LMo
         QSCOxPKsjBS1MDTUAWI6L17v9tR/78XO6vQtFqbRvcpDE6crxl14el4mwwNhlWyN/BER
         dwYfbnxa8e0tK086OnOUK9QcvSzLbkUHsPxh2E53OJ9bPZYAD5j7sN6VQDUocu5qHiJz
         LSEsY3dFn9hVJPjF4OWfbs0P7yXKva0iEvxYTh/A4nfMXpzzNTD1dV6heDhO/a21GQiU
         UWww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794584843; x=1795189643;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/aAsP0tWsYUKW0MBNVosDOUf3N/w5cc7B/jroRraKSc=;
        b=mQVHVluiKggpfLV0xa2IqmF2/gIVmqd/2X3PbkJpT3t4osLxz9+6HMzBFqkZYcngwm
         UvYp4Y9JyCuJ17Q+mVgRZ4LFwH10ez3bl0mOcosmwIfGWHdpMf5jBiHIedRUYFpqo8Rg
         auOhR+BJmo1dIjBfHNGb+XGoXm/bcq2WmShn9dsyuVQlpnAxcfAOjR52xaQJWji0/qsK
         pfPAs5g8t14qSwdlgmBlnxHjjeKLOWa0G7ndXtCUguZ5ZZakc4JxvwN8XNSyFFP+WF6z
         jybDIWR0eOFogMi9edEo6bNt/2zybQKKeMOGTv6CwsuoBtyuqWLWBFeSyKM/tJ9R0OCp
         /XpQ==
X-Gm-Message-State: APuU4Z8zObO+SGLjjA2zfQ/Q7j15b0QJjYn8jUO2xmJJZscmyVkqZBcR
	NXPFUDemtbgCAPmSVCRwEVVE9fkOwV5vODXiTN16+oj6wp1bwgxAbZi7I0unP49SNpCtP9Z6sy4
	3AanCCeSeO7VNUeRdMpFJpC+xgld2j3uKySgw+9gu8FJcDpviSmftjzCxQc/bcxL3
X-Gm-Gg: AYBFou0DVQhDbpDUmz/aVqOm6YKW0QW+fBm7AWbKg8sGUtYJY1ZiFXxOtpWMkp+PeO2
	OCnxs3nEDX3gqmcBYd1K2YPb3XXc5XzyyfarCa+DmPUVFWrsk8WszR9CzyfOxyXestq1HQV0hEt
	b9SZRPyWMC0lFKnbyGCmaHd1pHTdphA2uPIjOd3S4/T3+jaZPoEAlIy3hdTa2Hfd59MT1sWUtNv
	KINgPTz80sHc+fdYuU3GMjMKqaRxEFkPpCePwZpu04azQOLp7cTD60t8ividU88ia+epdkGzb+F
	+3cLG78tot8j8XDBZP641BGkK3mb6H8NKroPYdJd/P4eWRNY6SzaBpcHU0cSuRDRj23LrzK3tqf
	YJwHJcwnEf145pvjp6tz1FnMEKT89e6xweZIMS4E2+oRUrtleApLXO3+3/0Y/UsyyGGLdLeZrMp
	Uu4Q==
X-Received: by 2002:a05:620a:618d:b0:940:f224:5a63 with SMTP id af79cd13be357-9494bc6933cmr505820785a.64.1794584842639;
        Fri, 13 Nov 2026 07:47:22 -0800 (PST)
X-Received: by 2002:a05:620a:618d:b0:940:f224:5a63 with SMTP id af79cd13be357-9494bc6933cmr505814085a.64.1794584841984;
        Fri, 13 Nov 2026 07:47:21 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5f5972a7sm5636519f8f.21.2026.11.13.07.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 07:47:21 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Fri, 13 Nov 2026 16:47:07 +0100
Subject: [PATCH v2 07/10] device property: provide
 fwnode_property_count_references()
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
Message-Id: <20261113-fwnode-for-each-prop-v2-7-4edc23d5cf50@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2812;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=mWA2E75AM7RdS21w8SMPhz1qTA6x/LrBIO16v2e7+rY=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBq9zD3vLRqqStrOg9MZCOt5UJJl4En/a/w/DCgw
 ZRgTPvt5fCJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCavcw9wAKCRAFnS7L/zaE
 w0+1D/42FVdmrc9hu4OiQ+Js+HePkQUPtxTzx+0ytD4qEDg0CVUZvZhGn5nfXw9K2w1F3Y/1vP9
 Cjf7w/D1FdJWuPgfbc/68QwwkDedx6wbxNrZEHuNo/ynRxuZ0K6EiGAtuOY2nBWhCXj7LU7LYh+
 0D7U02xiL5KxOEnYE6jAWCnBs2i2p4tbzah3o5Ag0+T4UC3WmfozKdTyzkwrZrL8+AFVOa58WTB
 lPTQj4ZXv9METtVJmgW4OQ7rW8m6iqQaGe9+ilohwB6KNz3GwlwC4IPRVemRMUVDLOEFTXt6RRd
 RjI4rC0tsTq9O40tEueKGJEPIFDZuzpikorX15LisKGRq+obdwOmW92WyV21NV/c6ZXnbvElutV
 ZcCMaBAwgK4JuAFQCFQc9BVbiiYPSRdIdzylx+zb54N4av2Jad9EoZEH5Spqw4hxuMxjJlKl+6e
 UA6shFSPb1IjTn/mbnB7C2NLtJA2qrWPUXJjZLeqCs7lbonEmRuTjPW/VH6NJ01dhM5i2GNvBsf
 TBbuB0FoTZZey8P5JQfbC0Ololgw0LYOkDQPP0d/fyXtTzQmnjO3MAJjNJhlEdSWPWAR0d9w0pc
 8b/Y5PfbxCpUWGWvB8rclTruGIcmxgrdsc1Tv3BjYWYGB2shLwlUOmC5gLdZQNBgwIpF4DN0whx
 GvSo9up9ZdOdZxQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=c6Q+0h9l c=1 sm=1 tr=0 ts=6af7310b cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=SSMJkwzw4Xnz0fcc0q0A:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: JxknfLre9Nwf8KVc0C6Iy0l3GdhRyKF9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA2MiBTYWx0ZWRfX24/ekY2h0vze
 qoTcTQJENveXuxRkZiiC8Rur6IvEYIEttNetl0zJMqPdIWxKnrtbH8bMGMvrKRWzpH+CrkbPaAG
 R/oTaBizGYW2HhdJiekbXmwMuqZYrD/zP795rezoxXKWbRCfT1jCB3JVV0pHSKsDpTPeP47FWMK
 lI0urlXbxisbWUuA3P9CPY5/+l5GFUhk8Ik6xwDpDB6VVLp2mp3IswbCiNxnDtDCtUiqDxKf3cl
 1NC9lrElctd6lr5Y1fTDtQ53aZXOAA7d9YQk2YLC1GSx7cgiUrJkUclD8nuUqNj6pJAx/m+b6U6
 JT/64lUPPYmIpApYd3iig5RF2sCo2J336JwvEZkEC16ELbDgcAyfNmT0GEtSIBBy6ojc6FzQiqi
 T0wLtPB03ayT+zAAwhK/vFW0wp7TH3sq4ejYsK4Mwd+U2uVfg8meuG0c9VAUFp3FyTT3Fw7evcu
 ey9zdABpKbc1R8viYrw==
X-Proofpoint-ORIG-GUID: JxknfLre9Nwf8KVc0C6Iy0l3GdhRyKF9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA2MiBTYWx0ZWRfX7zrHYL9g+aGS
 vk7ZNkIirnVnY2k26UE3bXkdY9cPd81Zo7WxcaFMgBIR4RFFd9X9EZmJ8+/pXGVY4c4VCwZvnDM
 Oi1kYCzoTESAKXHsIjjfp05axR9B9cA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130062

Provide fwnode_property_count_references() - a new fwnode function that
allows callers to retrieve the number of references in given property.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/base/property.c  | 35 +++++++++++++++++++++++++++++++++++
 include/linux/property.h |  3 +++
 2 files changed, 38 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index d3c54c3d11c42ba4aef68687fc27291c7f33beb6..3cbeb147134143cf68af3213ee75c371af363f2e 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -655,6 +655,41 @@ int fwnode_property_match_property_string(const struct fwnode_handle *fwnode,
 }
 EXPORT_SYMBOL_GPL(fwnode_property_match_property_string);
 
+/**
+ * fwnode_property_count_references() - Count the references in a property
+ * @fwnode:	Firmware node where to look for the property
+ * @prop:	The name of the property
+ * @nargs_prop:	The name of the property telling the number of arguments in the
+ *		referred node. NULL if the references have no arguments.
+ *
+ * Empty references count too, so every index in the range [0, count) can be
+ * passed to fwnode_property_get_reference_args(), which may still fail for
+ * empty entries.
+ *
+ * Return: Number of references on success,
+ *	   %-ENOENT if the property was not found,
+ *	   %-EINVAL on parse error.
+ */
+int fwnode_property_count_references(const struct fwnode_handle *fwnode,
+				     const char *prop, const char *nargs_prop)
+{
+	int ret;
+
+	if (IS_ERR_OR_NULL(fwnode))
+		return -ENOENT;
+
+	ret = fwnode_call_int_op(fwnode, count_references, prop, nargs_prop);
+	if (ret >= 0)
+		return ret;
+
+	if (IS_ERR_OR_NULL(fwnode->secondary))
+		return ret;
+
+	return fwnode_call_int_op(fwnode->secondary, count_references, prop,
+				  nargs_prop);
+}
+EXPORT_SYMBOL_GPL(fwnode_property_count_references);
+
 /**
  * fwnode_property_get_reference_args() - Find a reference with arguments
  * @fwnode:	Firmware node where to look for the reference
diff --git a/include/linux/property.h b/include/linux/property.h
index a70f3c4c087dd85390951da950c3632f89c6cfd1..9f0b9aab5920513cd468572fa96dbe3371609591 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -137,6 +137,9 @@ int device_property_match_property_string(const struct device *dev,
 	return fwnode_property_match_property_string(dev_fwnode(dev), propname, array, n);
 }
 
+int fwnode_property_count_references(const struct fwnode_handle *fwnode,
+				     const char *prop, const char *nargs_prop);
+
 int fwnode_property_get_reference_args(const struct fwnode_handle *fwnode,
 				       const char *prop, const char *nargs_prop,
 				       unsigned int nargs, unsigned int index,

-- 
2.47.3

