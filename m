Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C154A2617
	for <linux-acpi@vger.kernel.org>; Thu, 15 Oct 2026 14:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792075609; cv=none; b=RORU/RFVTAuTgNqAwAALORukuPxQ6kG3IzkIZVQwoCk0htPr4do7UfE0Zer+1JC5tZXF6d/6FL5VULRD9EN9HZQ8g1H0542elwP+P1sKO3mi8Edd1nPixYpo+eFbpedJqlwfnFCVRiV8U1LwZOZRGr5XmJwQCF+hl8osBvc69Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792075609; c=relaxed/simple;
	bh=NDWirnr4vg3QN9XbIRUWUV1IvDXviUNFZMI/OP0DktY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IIOHBw/iuvm/j5T0M6XP9fE2Vs2OKEAm/kFgu1vtlKsDAM5rivZEiD7LFSdfgNpL84rG/p4AQYOilZvuxUsTxA5CEzlOEIMIEAYlOg+M2dSFCcWRwz8ocJuxQbbVXFnC+9jlQWZcOd5AKznFLPqXHD6FIAtnoWZJDpNl0QTkqQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cU5dHnhg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jNc+ulim; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cU5dHnhg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jNc+ulim"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F9jiDx2417235
	for <linux-acpi@vger.kernel.org>; Thu, 15 Oct 2026 14:46:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GJV2UsBufFSWGkCz1dtlwgPFuz884GffidJVAFetku8=; b=cU5dHnhgydKQmz8g
	Fa6xgQFxTMpsiTuD0tUYQuuC6TlVeN3KkRCKCZ0Rbc8UkDQiIGc2ciOSFcJQGlwb
	Ttmiu+zcnKJmH9bMB+iUVmILHz6//nKM+RPjbU4izcJWj7idEz0RVYJdDDrl/IyU
	ZmWZiIPvRlMwQwR/mjJXqlgUSrhew9XnPe02Cnqt+fsQNxWLexZFoa95lRqtOZLo
	trYmY3mdI0+o6Qx+ZhhKBtzbJQHmpPUYhQVzpe/hFQY1/bcNL+hd/pIdfEmMaCFp
	c8/cEGs3Wsdo1wA5GX4TriC5LtPDTUvxA8IhGXzriB4QQP8CCi2jL2db8OGxvJlR
	dDhILA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haqdhjn94-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Thu, 15 Oct 2026 14:46:47 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93caf7856ffso1103536685a.3
        for <linux-acpi@vger.kernel.org>; Thu, 15 Oct 2026 07:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792075606; x=1792680406; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GJV2UsBufFSWGkCz1dtlwgPFuz884GffidJVAFetku8=;
        b=jNc+ulim5W3PAkBGDdyk2h5VEGeqnXnZLn/HoxUAC1OidygH7DxGDH4Lsy0qUvPyqs
         DuBrDZczWsJgczcIs47xzsPTFrOctyhclERhOvQNVapEIvMxTDYyUtYgXt4AJHOa3Mgp
         TfKE8a9U/knhaycWtt3nlTubd7mORpmx6T//RCSDsoFdcLsE2bxum/5hI9NOnVjzluR0
         8cVk078PxmagLEIPNR8+Dsr+eGb8pYSetbHGwtCn2D77x+3JsXS/Zr62NpZs6ERXF4A4
         AsM9JrQul8+7IlFht2cgOIrwba6ez8flGtQmASgdaqWUHHpGIq7LT5Pi/IfseVmZY5om
         ouIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792075606; x=1792680406;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GJV2UsBufFSWGkCz1dtlwgPFuz884GffidJVAFetku8=;
        b=A//ORJQQJ2Z82kxD4vG40HhLbD0ZyXvxon7ls2iGGqkwyOHfGYdGQKkZXvREWhnPFy
         ZSNfZ2bMxgBcNs92P1Ne5A2nHQUpf2tsJtzkjNH/byOX7QlCCfizIlmIiwOxUcphSkTc
         GQoBvaN+T0Fw/LQiOYJNwOYCN/hVS104jIeYJsI6QE/iwC4s+ySzy/lkTmwfuqkBszEb
         2LXQKaVnBWM4y0z606+ScfQJuxRvGwNt9E/nb5QOBgqy8i94kPcesgJ6RdVqep8H7E9L
         +acPQaKYqsITIiN++vHhsbKp1/Nd3a7cFNFKewZc0zTEdLVaMlGNTWB6NseOzFWeb5Z8
         G4VA==
X-Forwarded-Encrypted: i=1; AKwUvByUaODCcx0D/e1QRMDqvo/K/5HNyelO0PNQdyOHDUelR5DfeSxPDA+/KEUQAuY/RNMBnWScTzDUzPqW@vger.kernel.org
X-Gm-Message-State: AFq9FYLW4kaWg6TEyZevXjiRFsBThc8S+3Seer4Pz41VIXtJKk2057uf
	Xh2iS3OSMOnT2xLBo1mB2QzWpSztUaLyT7o81KdRcu7P0WfUZwjrzxKAa8QdTF+XAQdVYvUVHUo
	wG8UWcv3URmb6wtctD/PHqNwAdydLKqu8PmB/bwkQR+L75PWbxfxRPECiCZbAv2Ei
X-Gm-Gg: AYBFou0fyVYAY0YVjPKxp0e7MW9EPmD4zPD3TqDG6S2MnQZs/scpPS6MCmGafkX0Y+P
	GOzhLyKSOb74AlqupWgzAKQc5UavS1SUr8vjvEM0XbCQo7U6ZoU+aWSvM6k1hpk5JBJIBThKFWK
	xmRAdaRvLtRpDxVkdfyatLIfEJGuxnaX8/Ow/1elqSRE8AFqbIaVG7d7hObw+A/Rym+gY69BRj+
	4chA94RuQzRKyA4+1fCMO/GnTEjSqwiJj3Sab/2eG0SY9EOCJU37bCY2vyhFUG8aiBHIqJxx1Wl
	z92IeDCthBSid1Vs4PHm93Gkm9MdkwTDiSAbAYsxYJL75BEL65RgY16kL3IB0HBCKRv9gXMeKtK
	yvdRqmyf4JiEd11XuBSIgfTD568cs
X-Received: by 2002:a05:620a:4449:b0:93a:17c8:a1e7 with SMTP id af79cd13be357-93ebd263d3amr3070954385a.44.1792075606395;
        Thu, 15 Oct 2026 07:46:46 -0700 (PDT)
X-Received: by 2002:a05:620a:4449:b0:93a:17c8:a1e7 with SMTP id af79cd13be357-93ebd263d3amr3070950885a.44.1792075605880;
        Thu, 15 Oct 2026 07:46:45 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd9b8ebdsm86840625e9.10.2026.10.15.07.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 07:46:45 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 16:46:22 +0200
Subject: [PATCH 1/3] driver core: provide a test-and-clear device flag
 accessor
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-swnode-dev-notify-balance-v1-1-9e7537bd2869@oss.qualcomm.com>
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=914;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=NDWirnr4vg3QN9XbIRUWUV1IvDXviUNFZMI/OP0DktY=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBq0OdPWsRp5kvFYVqOM/F9vDktvQv7TiGE+He9l
 H3hp1ja8QaJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCatDnTwAKCRAFnS7L/zaE
 wy7xEAC6MgYZiI3qCgL9uauMenPEogWQJFEc9/AXz7T8xhIegqAWOgGl5fPh5cGLtcvC3T1n2Xy
 yyHH4RKt1EAz+ZaisSUTnp3nwt9Txt7bjqa2egUFNhIdWPr91RMVeWWfVPSk7edu702+l4MlmxJ
 TLi/nLcb25EG731aJ+6SQ2UoDaaS7ktbx+DHH7kX7fbRs+9mGHzbgExIayd3x3kLWCrHrTGmVMO
 lkpeHyZXTIJiym0BxasyCWHkXdg3V/jhLBgmvZsw99XQTyC4CM/D9jGZOAsbnfL+g+nu9sA3zSc
 wzKaXPtnFCgJaFcy5/wPGz/3tg+L15egtgXDrX6A77fYW10KRMAq5fbpe3ywq0yUxt1tufxu8U1
 gqyF7c6rPrye20D9UW9znOEX+Z/Pg+fOtQI+i1z1bsCScdTIrd0KfVAf3YNfZ4NCnOVPzWJ4tMx
 0uo+RAir9xNMTp2amUBQevB1GOzeUXoh1qMqad7Bj59RErcdD/WEopsL1mHQywQOkv5mm/dLw3z
 X3TBPo0465yCR3M3B+svxhWO1eEOByii3FqaEPj15D6Ka89c0omMLujHWjz/iguhipIOTy53Ukp
 9inAuBhKErGKh8ehVHcV4g00IiNbmH0+1pSPuSO79sgH8oOdQ7K6xb/qtHVR2hStjXrhjESzPl/
 Jx/r6rbl3qaLWPg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA1OCBTYWx0ZWRfX8ZZX4PVVE3Lg
 FNaJt2cWuAZNMWYp5SOBjkdX/5WrvsivQ9gmpFGfYuF945DrcyseOU9uBtfJBpZMqzq6H0/4NZq
 i+l5js+OfHnQ9Rdi3Y2b6x6RWzsLgm6Lkf9fQ1JmQBDN2rbnKqD3PomYaMIcgTSBeRgvtgSBqqm
 bBwbV2+E4yH7vhgyf/7QcyBmhzBmByFPtVknvUXAn/qkPkbacip3mfOlFzlzaJQer9E+he5QPXM
 /vofiEbPI0fPcdFC3Fx7CQwbdSY0LzpEXt0f1Zx6aytxuuXFaq828Yk/lsc1c7aeeuyqYEaS2Ic
 qZ2vLjM3Ghz3ChaPupGSTUZ6Q6baoMm5J6VpbYfJe5Y72hsJ3lgS15l1mUaWNudkAJyoRRzT46Q
 2WY7Bh7LnQz3T5lF5bKsqKuSWQlWoI81yEW1ZitxCjuxWaJkWOdmNlKPQlUyRn9dsWI+ZoWm+td
 T3dl5Q2n3YrT5udHAuQ==
X-Proofpoint-GUID: mOy19bf4MA2eEIsY3eWvHxgyMY8W6opR
X-Authority-Analysis: v=2.4 cv=DeeCOftW c=1 sm=1 tr=0 ts=6ad0e757 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=0Wdk4a6BYWEShyIiZzoA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA1OCBTYWx0ZWRfX99eDoSYsKLhN
 +u4GK/GmRH09gPnmWtAJPUCxZJvfWZt7ZKF3xh+8f+nbTPVGCvyGDImQSRdQvaD7KkdQXjASSXG
 KlQz6ky4Hi/ax2CKNUh+Cn8FG+7wgYM=
X-Proofpoint-ORIG-GUID: mOy19bf4MA2eEIsY3eWvHxgyMY8W6opR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0 phishscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150058

Extend the device flag accessors with a test-and-clear operation.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 include/linux/device.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/device.h b/include/linux/device.h
index 879eb758b5eec3f634d4fee0e4a57433fb537801..c8de370d877f978dd4a160f0094812a1d8441078 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -817,6 +817,10 @@ static inline void dev_assign_##accessor_name(struct device *dev, bool value) \
 static inline bool dev_test_and_set_##accessor_name(struct device *dev) \
 { \
 	return test_and_set_bit(flag_name, dev->flags); \
+} \
+static inline bool dev_test_and_clear_##accessor_name(struct device *dev) \
+{ \
+	return test_and_clear_bit(flag_name, dev->flags); \
 }
 
 __create_dev_flag_accessors(ready_to_probe, DEV_FLAG_READY_TO_PROBE);

-- 
2.47.3

