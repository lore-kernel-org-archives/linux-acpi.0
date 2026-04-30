Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB3F3AE6FE
	for <linux-acpi@vger.kernel.org>; Thu, 30 Apr 2026 07:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777534272; cv=none; b=scTBcUYGOCw5usOFkqQEHBvVS7QIVcAl5SZHp90rctoqmC5vvHxDuMklVVDM6vhahbOloP6+j6ahnsJ2Ma8UtO4yDZxjBhazq4UCFkqi5mNV/HzO/KFVJ+lvR1z6IhyRdSV28TPZPOT0xX/wCJMANFxWiTAI+wxzRZF0Z7kf48E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777534272; c=relaxed/simple;
	bh=J8vOAbxHqFIcemhsO1j1p/gwR3qJw56MPg1KBgWm1Zw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ttzl87Ox88isT2qjw7GQW+TVjYK2D7K8jFF3C2RNslfudbCxSn5LQBCVwCS3/dZZ8Nbj+0Kxo0C2dVSCnZFWKmW/4WSrUwQwSjVAn3xsoPrpJO8M5iHus3ezpnQFh0p7YSTHO2mnKtM30lpwHWhMbebHszGi+JnxuRMOq/85R+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=biQEilki; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TKTQfLI6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="biQEilki";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TKTQfLI6"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63U6N56V2534267
	for <linux-acpi@vger.kernel.org>; Thu, 30 Apr 2026 07:31:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IxYfci1kXSVxnQ7Is9It7s1mhDgddxrEV+/CL+oUtl8=; b=biQEilkiXpipI5BJ
	3ya0Lj73D3h7iTmWUk0Isp3hmgxiMFZepJVx6k4eAkdG0EvJZNI65pJSW54F/HYH
	/VTFnigFknR/CYAR5SmpVQgdlAz1xAdBUMPkF09gVI8zBKQ4YDvVeuHhBrrsugve
	WfShuZB/V6+xQv2DKwWB0No6gYMPzVsIFOAzAKwSDUJ/7YzIQkEKoOjI3cCKjxug
	KPj+LwwqewTkebdRzoKAY9kDfxuDo0Ff0X/ulc9jyGQwaqlqMT4xPAwvPVxgNJab
	L3LNzkU+IRXOkGa9p5wRnxMUNWSVtqtt2XeziAD23AyRqWmqJtjtUvOd31J1KtKz
	RCQsyg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dupe92h38-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Thu, 30 Apr 2026 07:31:10 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50fba8d8c40so12557041cf.3
        for <linux-acpi@vger.kernel.org>; Thu, 30 Apr 2026 00:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777534270; x=1778139070; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IxYfci1kXSVxnQ7Is9It7s1mhDgddxrEV+/CL+oUtl8=;
        b=TKTQfLI6Ws9q/B4H8CcHPtI35l1UPelW6LJeZ3t2fYs1XIy1nZUBHoYr9SVfx5qtY2
         vYUsDCHWGTUz/nIhBLlRGHxdo6ym5jepvwUPaFIAzbAzTxg2aGkjAhiO7ooDia0ecvCw
         Jeqk8djnueoSQLnVW32S+kvquFUkd6CwBW10OAVS6E0qoeMaYShqtwwZZL73DkUxzX20
         r3/BOK6CMofMWrBt46Qka15DriEWOvtCeQWeRSrHnVOAZXFPAjkeRxIU9N2zGxwvs4YD
         Wf3EiAOMZ60vG+m1QBXFJGD9gG1Hu+Xgree5XZ9QaqnaCK7/QOej+uTH1RwpDSj8GEgy
         MkdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777534270; x=1778139070;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IxYfci1kXSVxnQ7Is9It7s1mhDgddxrEV+/CL+oUtl8=;
        b=Lp8kHX5tsdgqh3ucoi5pzSsPNQ/ipN9O0o2qReawQqL/3yRQ1S8TWeHUElnmEw10K5
         dckBc75Lvcb8XmdoUv/01jHmFezm3bp+vG9kp1+V2A5Xi2tA4XxoalTQakH2UKZyZLg4
         lrZjtiIIWefu+rE0qYRMHEcc4GBLAVMGYAMx9hiMpNIdeadqlsx2vqIfKAxC9wvqqzM7
         QtR2z3CS+1NuNQmV4mw2A72U5tyJxE0EJFTwDxR1GOglCzQqfEJSBjlWUo3uE6JiXm62
         Tcxeto1reT7piFcXqPv3prh9oSw3H37fuT7CheHi0l3tEupnOLwErQgEgOwfLGITSQG8
         teyg==
X-Forwarded-Encrypted: i=1; AFNElJ9JvqYobSfcO8I3mzy3SX+LwjBM6CJhBYYmL/qYiPaUSgCfKXPpMXKvAW4T3U3eaan17LRwVuMrYEEq@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4y18zTRu844+1F1Sw7nDMFVGq3/oXdprkH3/ZV1WyPbd0wvBJ
	4qb0XYFAx0MWOa1HBT869dZXPJRGYW+I1VWUCb2Y37nKY2qzSaS0X112himhigK50zTJ5QkWz1Y
	2rIBCuiYmNrT4bp2ysDtasgaK2uP/n4fu0xgM/99JILc5bqbG9C7qiG0MNO66O83Y
X-Gm-Gg: AeBDieu1mkq1ulJQDhUU0TAq07AhOTtds41W7ToL2bqgRUNeS1vY/qoBs/Y5rDMO8Dr
	Sgq0dBr8sWNRC48RGXFxHJ6i080OTgpYFVN0e6zd7ig7VVKeSGP0yAGYrmNuI1pRzONBVZ08K44
	EQyhL8OckUF/cIleKIWhRct/Ux98iLxStA3zqohqautgMAUNWF9tT6vumQqONvYUfSJaEmwrTZs
	LNpWxnX7Yh+ijfP71qvfKIvX71WYOGY4CH4BCYJu2vgGLM/i7pZi5N+FwoFb9Vz6FSZebu975Iq
	X8yR0ojXM41Iz3d+JPhVGws0lYhxrOfy9IjWAYo9VNx5Gzyxe7GCScn0dCTx9qhvLu+okrP0swg
	HKKz9+pjqhur64gAWezqof6Mv/49kRqYOzwwbXm7k6r8rxmbFSmVn+z5kEq6t
X-Received: by 2002:ac8:5a0c:0:b0:50d:d1ea:65dd with SMTP id d75a77b69052e-5102ab5ce91mr26359711cf.14.1777534270010;
        Thu, 30 Apr 2026 00:31:10 -0700 (PDT)
X-Received: by 2002:ac8:5a0c:0:b0:50d:d1ea:65dd with SMTP id d75a77b69052e-5102ab5ce91mr26359251cf.14.1777534269537;
        Thu, 30 Apr 2026 00:31:09 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:79a:f446:21cb:22e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a81ed69fasm59515035e9.3.2026.04.30.00.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 00:31:08 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 30 Apr 2026 09:30:55 +0200
Subject: [PATCH v7 1/3] ARM: omap1: drop unused variable from
 omap16xx_gpio_init()
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260430-nokia770-gpio-swnodes-v7-1-c88f74c90dd6@oss.qualcomm.com>
References: <20260430-nokia770-gpio-swnodes-v7-0-c88f74c90dd6@oss.qualcomm.com>
In-Reply-To: <20260430-nokia770-gpio-swnodes-v7-0-c88f74c90dd6@oss.qualcomm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>, Arnd Bergmann <arnd@arndb.de>
Cc: brgl@kernel.org, driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1037;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=J8vOAbxHqFIcemhsO1j1p/gwR3qJw56MPg1KBgWm1Zw=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBp8wU3IFS0fzm52KuRz8vZ9jnjkYXKp8dgiD8yg
 rUMlcVe6cSJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCafMFNwAKCRAFnS7L/zaE
 w06dD/4m9RCZVbL5FfpHf3Po0kybG/VDb7u9MGxFtkNWG5xQiIBAJB475iiNgui4Ilb6ysX3CFP
 FW6iC/AOp6MDFRfcNxEJuVKNS9uSIP1gCAnuUu0mcoeBCqbUuMz1sov3zIGB0EgQhC+xhWY+fjJ
 gWi4Z5D0jLFz3f1ulw4grvWwm4B3CC71KPbOIJ/IXFP29XalvEx+qfQ2INJwSHqmPS84xohI06t
 ZpIAOFw2H8GKeqjGZrGZELUG9NT+1/VvgETJqD57N8GNxpRJi/hewRe8u3DkOmDwUgGgK+Yzr0s
 LVqmAOuo1u41/st79UCc39NAKE4Urn4kZL8DdpThFMqCfjeu0jgAVR969FDPhzpI6FDQEzJ3Pnx
 nZreA7fqnu4pXkyay3EAhuBKFotprhRuF7GcuBjBAkwO/mRV+L7fpYdT5m0bK0w+vSbiPghwm8m
 AsbM3HlqmcLqGmWmT3wHZydHz8ifgpst5nGjnaZkPNN3GCGq6f1geqkpX+ew5eg1vBCgm5Lp+Hk
 398ejYLi6hbpjAbm99qXplqW6FhlCTsHNRSVDOJM37s+VrQznEKhqHDTKNs39gpYr3bU9e6z61w
 doZpXfuEpG+mUOvKuo0Rb6/EDu5tTl8KB1qlt7PFwTWKbCOnfcULJXFOhqcL3GWVq2Ok9rQ1pn2
 6xz0VLSU1838EAg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: pBXkMVgptf9DdCPSMy4d49UINZp55aoQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDA3MiBTYWx0ZWRfX0Lb8QT4IhCwo
 OFZTXLOLZwflMhRuVmXPXhrmfNqzBct48ef4YVJgqt3to9VVg7ZmMO8PMdMEdwu/LpwN813tDpU
 jyGdAmtl5B0Hu9H+/xNFUTvPvOrfP0hh/MbsGAvqx2aNpBv5dK4P+hzV7X566SA0qQ/WkZy6q3T
 e5bwbEdMHg0N0q9281tirxZCm4xs2xEB9QWL7sQd1ivnXZ5WfucC9FsepS5Z2eih/abpaL0SCHm
 sbPlyqk7SBo7N8w+hiHmgZSIipv+hY71dthfKmoggCGvQCxHkBs9EUsDFCQrpnwlfSFTfaX4mrz
 op1emLxgvKp7Oa0B3ZLhOHFc+u/D9MiFVY3Lg8WADH5yYCQh6usMfnTN1nxr2IcxKp9Qq3jRfBT
 jqZXNLyqIus/dlTbqb0IxJsJm49cP0HDv6xQlEHqg7yM6FJiXnaDTNWz2H8FcrJHchVRPNeDRKD
 XeQB9ztZvY2ajCAVkCQ==
X-Proofpoint-ORIG-GUID: pBXkMVgptf9DdCPSMy4d49UINZp55aoQ
X-Authority-Analysis: v=2.4 cv=PvmjqQM3 c=1 sm=1 tr=0 ts=69f3053e cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=FU2xtZrg5b9VnPq6Jt8A:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_02,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604300072

The pdata variable is set but not used. Remove it.

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 arch/arm/mach-omap1/gpio16xx.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-omap1/gpio16xx.c b/arch/arm/mach-omap1/gpio16xx.c
index 55acec22fef4e73f20935473602ef6cb2f4f379c..e8dbe173bd33fae72c7c884f930a530f78096839 100644
--- a/arch/arm/mach-omap1/gpio16xx.c
+++ b/arch/arm/mach-omap1/gpio16xx.c
@@ -212,7 +212,6 @@ static int __init omap16xx_gpio_init(void)
 	void __iomem *base;
 	struct resource *res;
 	struct platform_device *pdev;
-	struct omap_gpio_platform_data *pdata;
 
 	if (!cpu_is_omap16xx())
 		return -EINVAL;
@@ -226,7 +225,6 @@ static int __init omap16xx_gpio_init(void)
 
 	for (i = 0; i < ARRAY_SIZE(omap16xx_gpio_dev); i++) {
 		pdev = omap16xx_gpio_dev[i];
-		pdata = pdev->dev.platform_data;
 
 		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 		if (unlikely(!res)) {

-- 
2.47.3

