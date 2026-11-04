Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793801077;
	b=RPMNfQYWRt6o+gHrm12P/q4i6aR36DBBC5N3Xy34Brg6BloFKOEyzwLsWWKLPocspS9L
	 84Q88tsSgg1OwU0bkJRycTRYdX4/bQLhlV6U7JI7I/kuIoJzSqmXQyzDKTPWIlRtQG1p3
	 ah4IPZWPcjglkDJG3Iuk1NfiDlM/us5LlFJvcmUM3t616Z1Bu/xeqzY0DDzunyZhRoEr+
	 ZJvOIax5MDGVX4v7lAW8o+kZHLm0ZQYD7Y+f10galpjnTUT1I6hehkcB7euW8pFQ2gU81
	 y5UZTgq4njyF2htte2acgGIoJKbQsIQsJ5o2K7XtWxqiaTRimpO34TyVqo7fJILbAxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793801077;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=6PXoe//bTeecJyPl555OIdQFJCsZxAnIbYF6rirmpkk=;
	b=E4GSegLnmn6TOYYWJ/L/egEofHGiT7a6PTd2yrLMj2u2RJtEzxUO7u3uSgoZw3gyQlgD
	 xS73eO4HV04jbit40wTjDpmoPEZFy5HYj1VWtCnJnsP+QOYfcYS7e+zLjSS0DROjOmEXt
	 lb5XrK+t0ck5Ryo2puTnwFLkjxxmSOl0X6Xnnhq/j+lTEHzareX+DwFiiyHHAdl5gZxvS
	 RVxsDow82tnzD5stCCRVrEXfZXT6VScSCl6Ay9WM8aqd1af84+QjXImLr3JBafbfFaRQF
	 fkhhUGIHy+42/mBF/hASIuhq7b9UeX753HpSioAh3qyhVlMmeoSsSvkQfR4HYJsUrkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gchuXv8r;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iOq2hzB8;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AC1606EE87
	for <linux-acpi@vger.kernel.org>; Wed,  4 Nov 2026 14:04:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4AC1606EE87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gchuXv8r;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iOq2hzB8
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A4BZvtH2310199
	for <linux-acpi@vger.kernel.org>; Wed, 4 Nov 2026 14:04:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6PXoe//bTeecJyPl555OIdQFJCsZxAnIbYF6rirmpkk=; b=gchuXv8rO9edzX4k
	9qDs7/iWqeOWA9XHdem3GvBvH613UiaHaQ4a2k3XuXl0vIk2+z09HP4L/ognem5D
	o8Xeue245re7R3yoKngvcRV1YcDMWvbWNF0j91pIJcumHa1wM5ODziKFoYFMiK/8
	LkzX1OmeefktfarLz+A3xY+nQHY9sso7EDRd78jzV9nFvR1jnURHIoqeQmARzK54
	FdbhvYqw1u3Hm9ieKzdPIG5R/+p0lkJvYxz+IwcBGWEGX1Puvd5Gm2oBaFfTuVD+
	GNRE9SLfjmKan6B8yCaF1PRHfhleWIBYdcklOPmFFvxKxK72c7zxHR7WUaRjrgzj
	dVO8yw==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqn8mv628-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Wed, 04 Nov 2026 14:04:35 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5ec17386b57so593256e0c.1
        for <linux-acpi@vger.kernel.org>; Wed, 04 Nov 2026 06:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793801075; x=1794405875; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6PXoe//bTeecJyPl555OIdQFJCsZxAnIbYF6rirmpkk=;
        b=iOq2hzB8ZIzAL0kATvijGaEyYH0ZXJ2EDRzy8FmBZhpsc3H5Nn+KlJb5Fxynl4CTVJ
         aCMoRE3jkUNa1MGQU66Yc8TZDSMILHk4oLNWsAP9C/ZYOmAi94VgUQjPboNwcLoLKA/+
         ysPF2FPbR1FwvEp4zFRJS6xIFkD5v2uMsVVjmUK0KNy4JtnrHz/hVboOYkRugEdhJD6u
         nHSMTLFqhksHYOehdjfFGEVvuYoC9me4jUoD9MUdTsUZyPSw86b78uRO/81c9I5/wKWP
         4fNUmfxX26nasD3GupuU6GkKWyiM7XygbkK6dIDm4DaKrBKZWvIWqVszAuoo0y+I/UAr
         0cjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793801075; x=1794405875;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6PXoe//bTeecJyPl555OIdQFJCsZxAnIbYF6rirmpkk=;
        b=Cn3F46UjK1IbRpYBKQiMXFnrmXOdoCIX9zQfULmhIWVekqmGoX1eiYxjBiK4s4/kiB
         Tojw/aKmp5iBeLXEYBvmz2S4WHExucjTzjBlAZ2/t36fGHI4aOklE2SmdCeen6msgqNv
         k4lLWfxW5v/NMBfauQiTHHHa5G1ElgZ/wwJKNBYt0nhdba18SetH0RSQPZBe2YD5pmUO
         c2ezvKLtEyefAei9C4kaS6L85wo4FfUKkW3XCkhXwYLhF1eZ2sVlwrPtj0Nl4R/1I58k
         DVveLcIkteX1warRG0lNXm+Sa19ewHPT/vacuXKx4xhZ6OgtOvfiBjOI/AIjUN5vAGXL
         H7Ow==
X-Gm-Message-State: APuU4Z+6V8HNKj9uYUMu5Hvrkpfyt/A0gwYUTx72UZ7QdlhohuxgyLVJ
	BdYJl7AuYzM5S0rEpPNe5oePPdmDc2nTi3nD/0Ls8hJC6DZyZ9ET0WSk6Hirpm3PUjUD5S5qX3g
	oxmpQYqYZfa3qxQQDCo9DwOZWYsRcA3OMF6MxmjL8s89TxbTTH5tSlWu3DuzRxw3b
X-Gm-Gg: AYBFou2EZipaDFaewYeSQq8f2FNRH5t5TgxNkaf2b1Gd6c9SlvvJ5S7IIMSGEiqcomW
	vtGR1vikR+s31GMc1aHYnD8namO9dNM4fhrQ2VHYkV9rs79OxSNtzc5M5rRd1VFOi21mtt9CitX
	gS6c8w9O06gApcw+d4MTtUfzS2UQPCeujc8hCn+6/DPxPSpwVRINPPb9+dKDm6RIruTNLoer1Qd
	YeySUp738250BYEupuxv30g6mEVOoGOjgQM4ACsBTB2K3P6q8IsJL8Tx/e1DG3xJecmIiwKp+uI
	6hlunl/gff7ZxdukOVo4AzyrvHz6xoZAHR23ywvR9jKOVm/ETqIqcoyKal0WaKJwKX8aBS7VZcK
	7beydRAQ8Zd0MrYq59wQ813RsJdHipxzWqeEt2nMSbQ1a81K0zjIDBt5RqXJa0fAD26gmugaO65
	kpaw==
X-Received: by 2002:a05:6122:1b05:b0:5ea:cd69:7cda with SMTP id 71dfb90a1353d-5ec6895329amr7314487e0c.7.1793801075047;
        Wed, 04 Nov 2026 06:04:35 -0800 (PST)
X-Received: by 2002:a05:6122:1b05:b0:5ea:cd69:7cda with SMTP id 71dfb90a1353d-5ec6895329amr7314419e0c.7.1793801074572;
        Wed, 04 Nov 2026 06:04:34 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fec8d87b5sm3968358f8f.11.2026.11.04.06.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 06:04:33 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Wed, 04 Nov 2026 15:03:49 +0100
Subject: [PATCH 7/9] device property: provide
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
Message-Id: <20261104-fwnode-for-each-prop-v1-7-6e28fe1c72c4@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2812;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=8CscP3j7PWUDfKaYGcKxatd6g2T25BK7kN4l1KEUd28=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBq6ztSs2vnFhnUytszIj7K0MWGPjj4eH7eynMe/
 zjl1O2hEWCJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaus7UgAKCRAFnS7L/zaE
 wxbqD/9x7yrGNGnGGwHE/5F84SboRgKxOd9v7VsB83upksyfCmrNUJdCvj8btxeeA9qzgCSClcD
 T2+FVNnhuq+bimeEhLsXJVc5Mj/CfnYLlLf2HjYTBw5XKhY77RyYO3/zL0ion/h+N/o3GU/Lhma
 VF8h2/k11CBVzYr1/hKVcN2UC5jnTB2dHJyx6lZhWY/gjBebAny99BGE6EyfNNQLD+HHJFgqtX/
 C0uKfmTKduexOOQX36t60DS2U2psmBug0DC+dc4AXDLq3lbfkgndojubKYsuBF0p+/D1sDt0zI0
 ZIruV+1C+7YdqLbPhKHvqcweY6qAQoQn6IFFQnJJD819mEy47NLuqS0pL+SfoZdF7UpNz8G0FrK
 fdryDWH7y14b0ytPPljq6G0ngevcTwf7meR0wMlSLH/HWzp0doxh1r45gpfIzbU1Sg//kXPHGMH
 iGn8BXYBDykkG/EysgPwId5ZbrCICEEpOUVEi0CaqYpNfiLGCvLIht1Jwmhp4NgoesgamhlX8ch
 UWI331eV85JS8aVnHQMp9Qd4WdJlUN7LCUSDkEwzGKUa341ySKsI7OzA4xdmVhWtsUoLSCMGjQe
 aNX0J13UCtBnpMjdzB/6iszkDHGi5e0UDr1TJjXcQAMUb5v/Aw9JnI15RStkZJ+fAr6N012X6iK
 zmmFwOT8akGpUaA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: BL6rwdeRxjQiFwpxV6WfEGGoB8m-i5RD
X-Proofpoint-ORIG-GUID: BL6rwdeRxjQiFwpxV6WfEGGoB8m-i5RD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA1NSBTYWx0ZWRfXyayyFf+skV+y
 wjo5WfPqk71i5NQaHDUCJvAO1ZsFTnpxikVo+OO7g/QdYddGGgl5SKEadme6BUjzIT+nxkRtlMq
 tBVAg++loM9jhMWSC5MRnt4Koby2NBTqmGJiSBBvL1XRbKUiRDBhJAqbAkZqkqEwFJ0c2TjNUpR
 vQNWl5OrQbLaBLKqqU2DS3QuX4nSAAF67cBMcCTjAp1Oz6ZVJHdrJYw6U6FIx5UySYn09ATD4ko
 zPLJIfdkjyplM3Nd0af+QzisZcTZtgenF4ABJPvPV3Fuwo+8QZkaBsRpqv9775IlSJWG4CsgVhA
 R3j7/TtK9L0gfY7nTGs6djLjPUZLCOgOAzsGGlTsU4ozmZ+IuuA8oRHenA9PoSgdnJHAys1905A
 U7h9Z0qIPrAXPsKkvqwrSgOCO+130ouzsCW+alhpAD2Bm+MQ0y2CDi9MfgDHeMkTieBoo4XWItZ
 VWQ1ZZMEjiBSgkrHmIg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA1NSBTYWx0ZWRfX0AZNgF38hmRd
 51NEU7N6HqfjLP1UpfHBMwgf82ngnxQ8HTbPhr+v08VaHyfiMunKAzmdqoUB3O5GSubOwOdvZ4S
 GaLRSDwsqunIkOfqtsTNJKcVzowf4RY=
X-Authority-Analysis: v=2.4 cv=HbWB3SE8 c=1 sm=1 tr=0 ts=6aeb3b73 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=SSMJkwzw4Xnz0fcc0q0A:9 a=QEXdDO2ut3YA:10 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_04,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040055

Provide fwnode_property_count_references() - a new fwnode function that
allows callers to retrieve the number of references in given property.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/base/property.c  | 35 +++++++++++++++++++++++++++++++++++
 include/linux/property.h |  3 +++
 2 files changed, 38 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 7b0df3dfae53b6377dba91330aac746684e8adec..259ecc4dc31a7b07e2ae5f53aa2424de54ba8236 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -654,6 +654,41 @@ int fwnode_property_match_property_string(const struct fwnode_handle *fwnode,
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

