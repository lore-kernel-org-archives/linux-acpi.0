Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FBD3B7764
	for <linux-acpi@vger.kernel.org>; Thu, 30 Apr 2026 07:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777534272; cv=none; b=rc9DcZVFgQVngTaXdzVIN3wKG58bVFFr90Gi1wk4TpgW86gWbJFFr6gvG0FsMhuqP7aLbK2tYeCWTRMQDgzpKcu8msGo4WjDO/fuph+NTVjT8hzxxhecQ0ZO3h121Xi5PSssemJGo4HbM/Y1QOXHYy28rBN5ZlVRWu5futGGZnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777534272; c=relaxed/simple;
	bh=1N+EfBQB45Tp1UHYeYYJOHZLrrWLfb06n+j18VwGZl0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jWABB8grusGC57PITHTxvXwuoLqw679MdY6hSIiexw38cyVB5f8+79MgzVv+0sG0MedtJfUWQGpboaO+diaIM1hkGcSK0p3UHplImMaOQZKAA8cg3f42smJ7/OraFcoBMvL2ly68yqF/ZjqcDtMZ9VunQzDuSc2ilguzhXUywBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=V8jz7+3A; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EmKE9ZJo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="V8jz7+3A";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EmKE9ZJo"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63TNuHWQ3636515
	for <linux-acpi@vger.kernel.org>; Thu, 30 Apr 2026 07:31:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=V7JzakOUT7akT5SMUuhE/h
	DcVBqqxoGfQexPvwrbb6Q=; b=V8jz7+3AoG34ijaiBiEbTr4kmX8Rik2a6KYneJ
	Doj57lZyjxXF0z6D26a68iHGLzvn8qVa1adh4GMHKWdP2SrO/hERoa8Lu8hS5skT
	Z1BbbWM6Fkm23aIzorC3jTNkSlF6PrUJInlTJrUiD7flh4qNhgBBzWf0WmpBfd1y
	KrdRNnYA/mUUu+zkY/TUx3HybctQuiNlDme/2w6sOwjdUPTNOU673Bbw8rVM+vJN
	3tbNVTnQOfKBpXIWT8ytNTeN29b+a8KO9wKACxZkbde8KX29lrXdMu7OkQNjvMJD
	qB6Lpm2ufwOqACpDdoLv441tT9i1VyOG0Nk2YG/aCk4jQWnQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4duv3q1cv6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Thu, 30 Apr 2026 07:31:09 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50e5a336b44so11438791cf.0
        for <linux-acpi@vger.kernel.org>; Thu, 30 Apr 2026 00:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777534269; x=1778139069; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V7JzakOUT7akT5SMUuhE/hDcVBqqxoGfQexPvwrbb6Q=;
        b=EmKE9ZJoeuQpfrePo6zaWRuepcnqkApy3JNISZRyrWsRyUPVECKobiVlygHV6J7TuV
         MiNlkJfTJbp3sYiRKpYP0H/D49cmPNhIPkVa61G0X73LII40Ifa2kU4Bqk+vou0XLWl+
         zagJTyf0GKT79zOuI/2nMSBxrQ/HTnKC+tcnzB1EEKoaQsO+nTzwdrB96sw/oGtNmP7d
         SzcZErlaHh/E39CYH1FXkGuswUBYc/J5iJaA+12+GT3jSV/j0SuvtaNv92GrucMPfnT5
         JKB11FKxQ7//51D6h6q4TCZnGk5NfaS5hquX00TJPDo7GSoOsJhnU8PmWEUFozBEoFWU
         ciow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777534269; x=1778139069;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V7JzakOUT7akT5SMUuhE/hDcVBqqxoGfQexPvwrbb6Q=;
        b=B+hzX8WATXg+WTuY6zThwnN5kLfxEgeH1liZ4SRfGzY/tEwqnVjhRLhVY11gH1XbMg
         6Gzh7QSLIzXH9xUsEG39OCS6qu0f69vfpSv+tnWqiJL2xPUEpeo/85FeERKRSJWKwmwI
         jfk3gC9jlUzDHAjyPb4AG3CCFVFK5E7Q8l095Cf8aYTDTirYNQrNxQtjKZqQxAxBDXN+
         X3e0koIA06QtmJG8hgKVFaIW1K9LEzwc+Y1udfKftcYIH7rgh30JJ4qoJClddUfZYM/F
         hynDcFayiEuB2NfHGCqTp6x/xcxnQKSjBzCBAMeEmCzeGnYwowlBjuN2k1CkTWVJGwqF
         UZWA==
X-Forwarded-Encrypted: i=1; AFNElJ8NObBUH9IUL9tKeQcYjG7b/9oIKvtRkiCIyeCKYvknkC7h4anYjIC0P995hd+jlmVX74cdu6jqfVbk@vger.kernel.org
X-Gm-Message-State: AOJu0YyISZNPWZrspZPg0YoQIOetaPAjnr2pU+08oNtAiwGYMvgYF/34
	eAZMTzAg3GIEeTWuHD7ekajLKPXHigX2Ul3EKWN/TNaWNTQGzpCFwMj3F2y5sXhzbQTcURmMjiE
	gIYl8XquOm++QhOtfda3CPG4teX133odrJX4jWKzK8yGfP90w1veQPYR2Wv5VnQFB
X-Gm-Gg: AeBDiett6EZJDTNqTorOfaOapfQ2UplQM2q9MLVTVza1dGXx4lFyta0/xGFa6o7pJZp
	Jz8XmLNEj21AFpduAd0caq/cFfKMT7WoIWq+K9DyBRGcWJwT++UFrEFSJRcLar1Z6iMbVyUm5+Z
	RKJqHY967zerbElmpEfq4we9gSyunEscbiilbcrkrhp8ZZaa1IcZxg+zxVzpI6AyCzAM6KMRu7E
	ZBoW5NRabP9S0irgCBAZ845xF3DtzYPDtPCYmiOTHtPovRMyQ/6lqT0jz2Lto7Zs7FuJHcZitZj
	n9Ov6wIWWRQfYuq2uBLJY6WAaE9qJhnURklS/8KzsVxUvsMbA+njfhbvChqz9j7la2Wm3ZU0LJG
	Ewf1iMUAaLV/zmzUJv9HLv8AMHhDPSkUx99DpejtDVo1G2pLuvmcwNYSt1LEn
X-Received: by 2002:ac8:5fcd:0:b0:50f:b181:6ae7 with SMTP id d75a77b69052e-5102d10aa50mr12953601cf.17.1777534268540;
        Thu, 30 Apr 2026 00:31:08 -0700 (PDT)
X-Received: by 2002:ac8:5fcd:0:b0:50f:b181:6ae7 with SMTP id d75a77b69052e-5102d10aa50mr12953271cf.17.1777534268014;
        Thu, 30 Apr 2026 00:31:08 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:79a:f446:21cb:22e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a81ed69fasm59515035e9.3.2026.04.30.00.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 00:31:07 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v7 0/3] ARM: omap1: use real firmware node lookup for GPIOs
 on Nokia 770
Date: Thu, 30 Apr 2026 09:30:54 +0200
Message-Id: <20260430-nokia770-gpio-swnodes-v7-0-c88f74c90dd6@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC4F82kC/4XOTQ7CIBAF4Ks0rKVBfosr72Fc0IIt0UIFRU3Tu
 0u70YWNm0neJO+bGUE0wZoIdsUIgkk2Wu9yEJsCNJ1yrYFW5wwwwhwRgqDzZ6uEQLAdrIfx4bw
 2ETKtqloRJik3IHeHYE72ubiHY86djTcfXsuZROftPzFRiGDNKyaxkUJotPcxlte7ujS+78s8w
 Awn9sEowmsYy5gWBOmaaI2lXMH4F4bFGsaXzyTBkjdbWbEf2DRNb7Gr5lBbAQAA
X-Change-ID: 20260330-nokia770-gpio-swnodes-5da8ba35946e
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2254;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=1N+EfBQB45Tp1UHYeYYJOHZLrrWLfb06n+j18VwGZl0=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBp8wUyVo05YkXyeGq+r5+ABl8MGaLWfVKJhfYwF
 D7bkHjP0hGJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCafMFMgAKCRAFnS7L/zaE
 w9P6EACPoKJBjfy/3HccBoDT7Vcxp56X8dUSIvSER+/ZKPQewE2NBo5IZzxEV/l3HA32Hf0FhVQ
 oysmoXhqs8RnVWNT/Q70oqtl9lSqOyGAal61LnzUp5+8agcZsJWBaAZnTOYqLQl9B/SP8ggwmJF
 SbeDEwtEoVHSGZ5JtBXLe8XQ0UteLBNUiZoI9fb+Ro93mao8ECJWVnAZQWds7mCF1RVdlWPyvVn
 De28hheIiN0Lh6ykp8hNj76km/Op/kji2yrcn/9aRhoodq4RE2hFKHvzmPYUfyMpASWQ/JK23Uf
 3ixXMRIFHjpOj0nIWigGy1UVgCtZpGmYVk1wyZwS0xmC8C20LeTw3G21blZLXB9sYewBn+ioUD6
 HRhIhh+ltOQf2XodXwNHPhV5lcY9iHKPIRoDGdrjAq/Ib2ObsyLNLkl0PBdTD5p8y9ZRwUnOnlN
 AGPAjG4iPHhPY7yqnKKEN0AYF+2uIdv8xRYXiED6smIEbQKizoe4ou52MrIuqkSTAGlDxvTl58L
 BVuM9O0hK77+vI844XLP2G1kTqYg85XIwQKQsW51eKDSdvzaZZTDYgBrYHiLRxm+IRKmF2DwF/l
 2xT1vPiAPOS63bz61/KDdlxHnnc1axlJukOwTvP8q0olX8XRFqnp4ysQsF9y50eyqIhWr63OmlW
 Y/JpsT6kYEjqTfg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: wGZ79x_o3B4CfmVFziiUxuOQMXSQX5MN
X-Authority-Analysis: v=2.4 cv=dOyWXuZb c=1 sm=1 tr=0 ts=69f3053d cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=WeWpliTHXVVyQaQyHOwA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDA3MiBTYWx0ZWRfX01HmIIY8xHnS
 2d83bYnGAzP5neepftTGjPUfTaiLpbiHd8Sr93zeSQXcvyvT6vvO8XMfZpUKjxhbtvH3sualPNe
 7jfawuwOx1z/V74oI8uGH9pg2FaI4SxwSI7Q+efrg1cbTAM/juCKH32SMYbdhhiSWAxRPslpELd
 EoarJ2FesOZTyiUAhddZ9Sa3y8w30M/7myAhzeF1r2lcm0df6KVJnAoZNVO8HlfIIGkKmp0sJkq
 aEzwG4BDzM03WBblXJM8jXNfbTDW/a3OzSQnyjmwC0zdZtqrNxkU/E5eP5fWORIqSj1gweQHm5b
 hD35+b1+wO/oFWm10JFD7+kFi4s+zGQJwCMQAVQ9LRfzqjBZC/29rRqkIkROlDif+U5J9AX2BSh
 IHvcAoIVb+SlJEcRxmfhNVeKeR3b2lYjTBJ0YWFDpO/tVwgngHMmX+HCfoQHDrTyH/JVtFEI0OB
 XGw6j9vkFU8424K/aJw==
X-Proofpoint-ORIG-GUID: wGZ79x_o3B4CfmVFziiUxuOQMXSQX5MN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_02,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604300072

This converts Nokia 770 to using real firmware node lookup for GPIOs by
attaching the software nodes describing GPIO controllers to their target
devices.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
Changes in v7:
- Drop ADS7846_PENDOWN_GPIO define from patch 3/3, move the value to the
  property entry
- Convert the second dev_err() to pr_err()
- Add the device name.id in the pr_err() output
- Collect tags
- Link to v6: https://patch.msgid.link/20260427-nokia770-gpio-swnodes-v6-0-b693296c1985@oss.qualcomm.com

Changes in v6:
- Switch to using platform_device_register_full() and pass the software
  node via the swnode field of struct platform_device_info
- Drop driver-core prerequisites from the series
- Rebase on top of v7.1-rc1
- Add patch dropping an unused variable
- Link to v5: https://patch.msgid.link/20260402-nokia770-gpio-swnodes-v5-0-d730db3dd299@oss.qualcomm.com

Changes in v5:
- Put ksysfs_init() in a separate new header
- Remove software_node_exit() in a separate patch
- Link to v4: https://patch.msgid.link/20260330-nokia770-gpio-swnodes-v4-0-b68592e977d0@oss.qualcomm.com

Changes in v4:
- Add patches making software nodes available earlier
- Remove stray newline
- Link to v3: https://lore.kernel.org/all/20260212112508.73500-1-bartosz.golaszewski@oss.qualcomm.com/

Changes in v3:
- fix references to the MPU node

Changes in v2:
- fix build with CONFIG_I2C_CBUS_GPIO
- only export the two symbols that are actually required by the nokia
  board file

---
Bartosz Golaszewski (3):
      ARM: omap1: drop unused variable from omap16xx_gpio_init()
      ARM: omap1: use platform_device_register_full() for GPIO devices on OMAP 16xx
      ARM: omap1: enable real software node lookup of GPIOs on Nokia 770

 arch/arm/mach-omap1/board-nokia770.c | 33 +++------------
 arch/arm/mach-omap1/common.h         |  3 ++
 arch/arm/mach-omap1/gpio16xx.c       | 80 ++++++++++++++++++------------------
 3 files changed, 48 insertions(+), 68 deletions(-)
---
base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
change-id: 20260330-nokia770-gpio-swnodes-5da8ba35946e

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

