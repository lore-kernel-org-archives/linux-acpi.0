Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E57D227BB5
	for <linux-acpi@vger.kernel.org>; Mon, 27 Apr 2026 10:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777286816; cv=none; b=nVqDAqKw/jEcfSWC2NB0oin7+P3tt3hePe4vixyBfrzQhh5zrOyDdngtP7i2D3/LqplTlQcZHsR0bTy/BQaW1puk0YyaKNTyBW1FBC8RZQxK7VfjcAo8UmAZEVFqkeYvArlsaa+gRUjsKHOOLzufNivsdCom7fkUm67W+OwHyFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777286816; c=relaxed/simple;
	bh=YRML3/4wubgO3BKLVRzWveh6hjcAaWgMYaQc9TCSNb8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jtERPGRIWt0I4MirlCXBMXlwECitNZLCVA9xzxUTzvVvv35zyR5Yk8weOPxaYWlEBmTvYBceZwtzv+PEUWK00IEtNas7qDUwj6oAo+Y2nlV2e5L5PYa5LqhJWhdSce3819FaF+CZfV1s7kabFG+O4a7ouOx2WL561BcNRQtHbr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ry9QQjob; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FCbl8QFW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ry9QQjob";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FCbl8QFW"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63R9OgJK3825281
	for <linux-acpi@vger.kernel.org>; Mon, 27 Apr 2026 10:46:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=8BXF30rYIbp1AFSMQS7md7
	DuGRyYvVsJVET8/FPU4oo=; b=Ry9QQjobYnoN0yZY5QYzJCvfP/8S9zvBWQgLlt
	n/nvl3ogvZPaWQAnVYq0nGzk5jd8SNKIqudewE8X0wuzGnpgNZzLuR4Gh+v0K24M
	1ndKEvpi2U7IAjllwV/UC3Fdatt0vjl42rORzQBNAxqG5A8Pn9EYi/koproGgaCt
	+J993EA6pDClMijoH7uMnjlr/4LXIxBcC9VJuDvAEYfbGsHYhUMTfEpAXBxK1V8t
	t7eD4bFeJTf8acCGTr7QKj+VUaPt8N7LvILZTWXwnHrPiIge0aype5VmPfsdqZyd
	U5GRBs2zdMvNr2tZusNcJafAm8vijDkLTvhR0jABSMv2iz1Q==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dt5550bjc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Mon, 27 Apr 2026 10:46:53 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50fbc70cfbdso149038181cf.2
        for <linux-acpi@vger.kernel.org>; Mon, 27 Apr 2026 03:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777286813; x=1777891613; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8BXF30rYIbp1AFSMQS7md7DuGRyYvVsJVET8/FPU4oo=;
        b=FCbl8QFWMp1NCwp5JpGKPgD5wGkK1EsrHlaIQrtiqCItaUIhOZGOPK2JixQ+S768HR
         4Y+Kgcwyik7UdPPC/4Kan6IePmu4kXV5RCTj+pHK5bDMdUmqvZs7Fslzv321YyDsIoVr
         KCnaShO3ubiB/8AHDTQ2QN9VnD3Sw4bxkKniYStaHE4Qt0huST5qSeqwkpun52noW/YC
         YP9obt3LFG20KEhQRNTHMJofEhpsnS2Rwemqv3w0wf5piMT8360rQQSKNCAiRB1RAlUN
         eC+1y7Ba2ielziLqE1LgMmfRqSuxVIQEGdKmxYrBUY96PoTmw5woGGWQGnedwWe4Nmmm
         Ch6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777286813; x=1777891613;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8BXF30rYIbp1AFSMQS7md7DuGRyYvVsJVET8/FPU4oo=;
        b=BmqoIBnw4OUp18zxWiBLq0tjMvhyAMhZiN1lq1fKcRMOEBZZMryGzlx2K965e18fpS
         Js4NIlw9CC7ErisBMsuwY5rYapU3+rDG7lWTN+sKkoHeATBUqFOOII6+ey/m1lRB93m8
         DJ+BY4YUfY3jbr7dulzL7UZJ7DdSe8v6ubxQeb9HpjSPgYRtN3YolxuM51k/xL0Oxm2H
         OTlHN5A3njSBOe65185/UWsEn6mbB+Qi6BmfoAnYQFzY+hsIP6uGeGLXZ7sFKaT+vpmh
         dqdSHIwDFbFGSSadwfRauOjmz9Fu8kmLUn7zgHrmDwfSDUFsnsWIlB8k4qgIuzRmpwHs
         sZ6Q==
X-Forwarded-Encrypted: i=1; AFNElJ/58+oZFR2463+/7ey2VTB/ZfUn4sG3c298eNEBLhF/T4foZWyx13kMfMGcLdgCKKxQvq1fEVPVK2s5@vger.kernel.org
X-Gm-Message-State: AOJu0YyjAZbGsjH/mxAFlGclj4uHzg2RBvzSKS+bRkURZnIiMGSmvOeO
	WALM8tld25VFXKCLtOsU1JOLW+9KDqYsoRbEH6N5VOu7j5mVGDKC2VOczS46CAFio6pYQy10Eeb
	HnVgEnXHSbGW2EYGubF9a7emoG7kMwTEyolSjESy5PLw855Z2ncx7ekGLvH6khr/o
X-Gm-Gg: AeBDievWC3QEtbQZ5Ny3OulociQgrW5C1peegSCH3dL95ie9j2huynCrE3zhoUx4e6L
	gMOW1JK2CaJk8WVBwpsvDGeln4aCwLOAIycbyU9rdTe2VcK1dnXE4QdOftk7IubWqoJxu5g/cIR
	UKfu2tzInCKa9aYgf5D5mKS1evcs0hKB+tajsfiHw4vBJ8flV0aSl+yUCUU9ZVb/2SlexOqRfLp
	sw51LKse6yU2gZ470FOfx4EgkTTMeD1etowhngH6/vPYMNw5oWaIgqpySRvFwep3YPsqUkuz5bA
	P2c0GU8KAz6i1ITzF71OttDsbcs2tgrfHlcsil1iVDd0lxKkv0nZsSGG/WsZYUUvFzGQcFsu1Tn
	ECXAIN8vtEvOR5x4UbuG3EjIN5i3UE8CJFllAUzzbcOvY3w1QkKxxdJxU1T0pHw==
X-Received: by 2002:ac8:5790:0:b0:50d:8cad:2381 with SMTP id d75a77b69052e-50e36f18d42mr627543601cf.54.1777286812948;
        Mon, 27 Apr 2026 03:46:52 -0700 (PDT)
X-Received: by 2002:ac8:5790:0:b0:50d:8cad:2381 with SMTP id d75a77b69052e-50e36f18d42mr627543071cf.54.1777286812430;
        Mon, 27 Apr 2026 03:46:52 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:5062:ae86:23aa:702c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cc2cacsm80353681f8f.13.2026.04.27.03.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 03:46:51 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v6 0/3] ARM: omap1: use real firmware node lookup for GPIOs
 on Nokia 770
Date: Mon, 27 Apr 2026 12:46:31 +0200
Message-Id: <20260427-nokia770-gpio-swnodes-v6-0-b693296c1985@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIc+72kC/4XNSw7CIBCA4as0rKUhPIsr72Fc0ILtRIUKipqmd
 5d240bjZpJ/kvlmQslFcAltqwlFlyFB8CXkpkLdYHzvMNjSiBIqCWME+3ACoxTB/QgBp4cP1iU
 srGlaw4Tm0qFyO0Z3hOfq7g+lB0i3EF/rm8yX7T8xc0xwKxuhqdNKWbILKdXXuzl34XKpy0ALn
 MUH44T+wkTBrGLEtsxaqvUXbJ7nN/iScG0OAQAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1928;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=YRML3/4wubgO3BKLVRzWveh6hjcAaWgMYaQc9TCSNb8=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBp7z6PK3nq1haznfGr8//ff9K8BQVl7mgRVhqYj
 +aI9ADMb8KJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCae8+jwAKCRAFnS7L/zaE
 w7nnD/9AMYdqg75oZStvRYC5FCyQ2IE2ivLl2cj1MByL/F7KHa5TAPL4LF8aDOusADUsd4Vgakg
 AJO23vfiElRCFVsqBY5W7BaTdW90nZRPr5zZmhqq9OkKThMiU/K1HF4bBuNP0cGEnep7lW0CoxZ
 6LruRyg4K6P2fDvlzH8u9x31q7g2r42VQsHg8za9Y7mr432v9+xQsUcfMAvZkDAfu+tNt/5+naH
 RQvRICsNPsXsxblDLO+qwLOcwFvoUPeiRfCC2DJaU8anql7CqdHch3QNjwp9q5exov3+I9WMU1O
 OK1HvP27Jso0PH7OPQohRYz2iDnzSvsESBVpVlaPwxXjT9/U+zmdmYiEKPGAHthmRwNWDg29ZB0
 fqV9VcdUVhVAdTAJzPm+Od+4kuBCQcfDTn4y9opqei9iXIr6ox55NItZdV3BSQcxiQSUH+YIUfp
 xDQjfc76y8My1uXMA9ZdZUr7tUkkV1ZCzr4i11EQP8VbL3NfCKmv0s+RVb5OKLuIX6NJmq8lx40
 1vBv1n73Iz36Xu66+PFeckqSSITHNnMfy/TdmjJv0xFBaAqyftoANFjx61rrCCRaQvXluMtVemX
 YmW13Yf615p1HgSgiskOrwLGVkaRMh7LTSMvJ/XnweiMAnK8DDGPXm6XKZdcBHyOgHtTZ7L1e+s
 2ygmuEHqFUOXj6g==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: A67FisL4YafxqrjZ8or50aS8PC7xte8N
X-Authority-Analysis: v=2.4 cv=CJEamxrD c=1 sm=1 tr=0 ts=69ef3e9d cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=vccPQ2CF_Qf-qLDx940A:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDExNCBTYWx0ZWRfX3+72/p9dGqyX
 LGg2nIfwfdGSM5/ViUM7HrLVAcl1z5jnsvxBwh2eAWJPJZvIrgMr6Opnll+s4Qrq+RdpOE+hhSA
 DFo7pttv2Har3y8JSPiObBKDZKASIdNns0F444V0Pi1DYMzGOIRcJqMI0AynCH/kmRKQ1APEn4s
 9+q56l1U8zPblodOjTqWa2zfICXSE/wcoqIvhdMczQTFK/KR7qPmSX8R9HjuuHrreYPJ6/v8epj
 a8F/yXVYYdFIGK/goe/Jo/L+w5yONcBuF9Jy6JQfkj39Y92Q5L5noaunQjyCzBcMo94LT3BPdNr
 Xs7bS1E1o9zGRDHUze1SPwsI02qIyOvrMp/FA4/fVbvQ5FgjCT33p3IW2vmlLzHKWsdFE/THA7v
 jQTPWNXB+B8Kd6u3dpCtfa6afJfQwGOVVf3c+CL5ulY5dF3p6QCTV9aUgha2B74yKOCJsdPnDEW
 pYnjOTFoh2OkLqGXCcQ==
X-Proofpoint-ORIG-GUID: A67FisL4YafxqrjZ8or50aS8PC7xte8N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270114

This converts Nokia 770 to using real firmware node lookup for GPIOs by
attaching the software nodes describing GPIO controllers to their target
devices.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
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

 arch/arm/mach-omap1/board-nokia770.c | 30 +++-----------
 arch/arm/mach-omap1/common.h         |  3 ++
 arch/arm/mach-omap1/gpio16xx.c       | 77 ++++++++++++++++++------------------
 3 files changed, 47 insertions(+), 63 deletions(-)
---
base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
change-id: 20260330-nokia770-gpio-swnodes-5da8ba35946e

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

