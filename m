Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7001D3D16E6
	for <linux-acpi@vger.kernel.org>; Mon, 30 Mar 2026 12:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774874462; cv=none; b=FBSF9tDtLahVqZvRnSzfLqRl2cZ0fexi+9+iktYxv7+XZXyVhDowhb4JzZe/X4bUxlN88QExmtdcqtmf8BJw9WlITXEbE/DELOcwStNTOKORhyMLWTI3nul3Iv/zsbXM6419VHHrjNlYn1cytgWizZi3X5ACOlx0UOe4SAhssqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774874462; c=relaxed/simple;
	bh=ebXxP6oyGThso9D20ueCVw32ARrB2td9WDVDT4mVQlQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=j8T1Rs9GGFgrdcHeN3ZoyXbl03HA7ffbbyIyrayK8g/r2VJ+NF36r+n7mYIgxufPYT22141jNkXWeETu51x0bCuOHYpNbhT5dzdiU2vHkwojrINNZm6dlnSlblWyimvoVPHM9Pye4e1MP4s2gQ7UQAjMNpkracd7Cn5FYUzg+g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Opung/CB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RmpMwLQh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Opung/CB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RmpMwLQh"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62U9SAl12952604
	for <linux-acpi@vger.kernel.org>; Mon, 30 Mar 2026 12:41:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=m1ZC22yEKqv0I/CPaWdZHN
	u0Gid8fUMzBO/v5Cza4Sg=; b=Opung/CBz/HA4ZQjM+P2dBde1ixiEOI+r+me5E
	Hy/q9anjFRYMLlBqwA5yumdAL2X1hfnAv5nk7j5jTRqm1cZjhNrFvXvOfRq3iLaZ
	F0F2NEEq2sHgVFoxHjy3sUVSFi7fYzlHFXJwmpFvZVpn7mLHG48YDOuUIdNlt+4V
	j8eZeId7VspsS33LfIfwMn/O48kGvKq+c5SnxwGY1yi5bmfS9xt4XmLvZFjdIdhK
	6ZepZTY3k91HdXQgOLahDJGoxhA2tWmL4ih07lE/F7taPjWmUgnWD7e7jYhmhmy7
	fxrqDWRhu6eJzJXu3AxZiYceQQva4IJkzKI5cbxBlcs698Rw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d6wqem42g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Mon, 30 Mar 2026 12:41:00 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-5093a985e21so92681651cf.3
        for <linux-acpi@vger.kernel.org>; Mon, 30 Mar 2026 05:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774874460; x=1775479260; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m1ZC22yEKqv0I/CPaWdZHNu0Gid8fUMzBO/v5Cza4Sg=;
        b=RmpMwLQh4hQ+xrxr6hPNCm+J5Lwo7hctnLYWnpr8bM3HhpHSVsVD7M4re6d6OPKK4w
         0dE3mlwnqRmQCMyRV+RO/swOoHJR6r4ct0Ey2Ppk/NCOazz+DPU9a6FVUOM0dHF1dUEc
         5OPR9zvc30uorGVILhoFI+vpIv7GQDxTQJQbGmBFGjpANYDNos5liYgNmBWLCuSkD96E
         M4h6b2JEIx3YSPtFPo8d6hEpwPDSBqqY1/QoMGMz06OICLhPFKfFYc30rKu+cKKIwJox
         2EVh/uH9OtxA/lgoj9NKQ2qM+gv9p7nps7SnY0yu0AnlwB2l3KUrP7AOZFKphcYFmmJ4
         BVyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774874460; x=1775479260;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m1ZC22yEKqv0I/CPaWdZHNu0Gid8fUMzBO/v5Cza4Sg=;
        b=VXaXjO98ue8tnLOwXHQzARTxNkIPSiv+C89Rh56CQdl5tB/1eLeY19rVjh89GPrYke
         QoEnK4sylvWqEeMo1CEyqSSFlumucVUYwOrFtExZ2ntVhaVRu8iU2dhPKH+YgLk2cG+q
         58ehV6vH3p2MpEl6nf8bOklnjFNh2Mih9SbsuA/kGx/nExC6ycG89yoEguS6tLpfLCmt
         jGoOYZgbwqEXyLVWnbPPrnMhUtZxHbzEv8+u/Zd6ksjF2dmvne672lR5Hrg7JzhpR0kY
         cRwfXp4XuTOvWujxqvMilrHACH3Bkq9lz48G288fc+EHwuaDcne9QXQqW6n5yd+2FhgZ
         In0w==
X-Forwarded-Encrypted: i=1; AJvYcCUf0SoqXExU90dDFV9dJAFmSpCqTSyi2Gm0KcBqGmuMkvRzAFfPedK9Td80mUNY5dwucUR/YNM/S7Sg@vger.kernel.org
X-Gm-Message-State: AOJu0YwDvA13lLLlidPzmLaHeTPTya1n6SZFIPkPqT6RbXsVd5y+hBa2
	PQbNnJEORXwb96dBXcgrRgwYMlNBNHBU8wK6jD3gHlseKDO8tiygkOYueYXPpmTRNBFtFVl/kJv
	sL1qo9EI75y4n7z3c6Dx8yQncQFNIeEyQ8mkLZbZUAX6+Xt2lkrYcZQf45lZKskoM
X-Gm-Gg: ATEYQzz3Tw7RyjTAgZHIQQIIbqaFLrvNRMQ4MpckD3gVuZy93yKPQqmGIYKUq3zF8p/
	yw7j99hgfndg9y//r+s3cETS8H65C6QCuxEnihDjAs3uVjp8VuDmufEWlLELQPYJvGj1eKcZTtV
	M4QbeuqQIx6qZav58mmYINuh4ZI9NTNrm5Bgyw2EZaDZo+2X/vn4NX0B//Ub684yLAbAL9JAczf
	IySKYuBwquvdYN1aXY84+SYG7N47UnbGlaGGkJjiNJlFbMdEVLzSqC/AFiWH+nt5f2b4ATSXU0Z
	u/5GcnpVYvt2kXbR+L630/4DRrxwgez3hXF7aH5NlgDkIl2johoILK9uE0Ax6aWsRHLMhh6uqBd
	/PZzVHIHzJ4vZCko9ep7BRKuZjkj1B3lEtEtAnsDvAA5FmA7Uv5vl
X-Received: by 2002:a05:622a:229d:b0:509:1d4b:f860 with SMTP id d75a77b69052e-50ba397bc8emr179975181cf.58.1774874459617;
        Mon, 30 Mar 2026 05:40:59 -0700 (PDT)
X-Received: by 2002:a05:622a:229d:b0:509:1d4b:f860 with SMTP id d75a77b69052e-50ba397bc8emr179974841cf.58.1774874459199;
        Mon, 30 Mar 2026 05:40:59 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:e931:8d81:9955:76ef])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf24739easm19576153f8f.30.2026.03.30.05.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 05:40:58 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v4 0/3] ARM: omap1: use real firmware node lookup for GPIOs
 on Nokia 770
Date: Mon, 30 Mar 2026 14:40:45 +0200
Message-Id: <20260330-nokia770-gpio-swnodes-v4-0-b68592e977d0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE1vymkC/x3MTQqAIBBA4avErBuQLPu5SrSwnGoINByoQLp70
 vJbvJdAKDIJDEWCSBcLB59RlwUsu/UbIbtsqFRllNYKfTjYtq3C7eSAcvvgSLBxtputbvraEOT
 2jLTy83/H6X0/ncJbKGcAAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2086;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=ebXxP6oyGThso9D20ueCVw32ARrB2td9WDVDT4mVQlQ=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpym9QIpjWDEaGIC85qzZdl9V6Rcvu5F+r9iru9
 WKPqG41tIGJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCacpvUAAKCRAFnS7L/zaE
 w2kzD/9NUZiXDzZZSpnZvE7U0Y+j2FXJqL4tLwdObSeStH4IM9mpXwCRyn/c6oGyMD/91QDjPrv
 3DXHCm+kM5GEO5tKMe8LEuZjFE/6n/CuEagUvVTETyucDzV8y9mn6hNvCaLFKCwVWvoTGZR3s2U
 MxEFzkV6egJoA9Zd7G5plqtw1QJHQiAVnmjRj9X8JBwzwJJfrgoJwpxppBG7a/K1l1km1peQRZq
 7RyrC4AS2Cy8uYOOXoqVxD8VfwNE9UC5+ucjUO8sC9Pg/Htq62nkxrtNM31umoP15ttqXLLZqH6
 wxQf8yJpXDhfej5z9KIq/GA38t4XK3lYfga5Cpba6MhKUmPKyebmrL+J7IMuHZwwyXoqmmqEq4z
 iQDw/kik4wEW5u7QOSPYMsN+QMoDLimboGo/esNyyGuikM8eIAmOcSDqOmwfT0+YES8cWzAqyLC
 Ib2ejc/sqHiHKibK/QryIgqjglKpyQ97ashiz6vhHzB4yybu0d+L8IElKavAqTDymIYSvxlJnM+
 iXTd7S24TG/CcztQqKIWbtkbzcRIhiourzV4XFw350GW9vuoqyk64oC37G3/ke+o10XDFxePCdJ
 Z53nn7cIso/rW/Co9BqjlmdawBZ5GFo8Z4zveeJqZYEWgj4bBNvMMZn5KpgWfW3Jxu9JaTmrqt9
 0fLcx3SsNRH9aJA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=Jo78bc4C c=1 sm=1 tr=0 ts=69ca6f5c cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=WeWpliTHXVVyQaQyHOwA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: zHJOKI3xTTifol_dNBN5TcMPak2vk1vp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDA5OSBTYWx0ZWRfX8ZQ0GSOzF96O
 uYhKPorOMgz1uhUrMzjv4SObxQE0xCMGu/NV1FRosYH832gXY9bpW+FhQgxPA2tvBhV6M+KkGcy
 blWeza+surhiRudgRNlSny3lQwt/KojLVRN2Sv0fIez9slWVWyY+gAbktdK883hF0WdVXXccqI/
 U+gR/Ntz3pAIxbhDFFYjuk5eyJriJY94D2m1IiCmjg/lAKnGtOPUAVBP68QoiOsIRFzYaVgktjs
 8ebSFfXB7SrZ0UoxO852LY/eRIWQPwOsY8RfNkbWaj/kU9v2DcXQN0we+wN8WtBHO4Ct5shH8Dx
 66VvUfLpg702V9nKszbZjww3VhJzqG6ld030cq9SZkvb8xsz6VaUxamZRni2yqhMZ7osvQfXiFd
 gzxgylC71ThgaJ5ONdXRmfgFzMkO8P/was24LVuP+fIEblRzt9xwHHvqlSXbsMlpNcss1KkmRQK
 /7GmtigoR1Sj0KtU0uA==
X-Proofpoint-ORIG-GUID: zHJOKI3xTTifol_dNBN5TcMPak2vk1vp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603300099

This converts Nokia 770 to using real firmware node lookup for GPIOs by
attaching the software nodes describing GPIO controllers to their target
devices.

As determined by Aaro's testing, both omap16xx_gpio_init() and
software_node_init() run in postcore_initcall() so we need to make
software nodes available earlier hence the new patches in v4.

Please note that while the goal of this series is to allow Nokia 770 to
use software nodes earlier, we're not modifying core kernel code just to
accomodate an old ARM platform - more such conversions are coming up so
the change will be useful to more consumers of the software node API.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
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
      kernel: ksysfs: initialize kernel_kobj earlier
      driver core: make software nodes available earlier
      ARM: omap1: enable real software node lookup of GPIOs on Nokia 770

 arch/arm/mach-omap1/board-nokia770.c | 30 +++++-------------------------
 arch/arm/mach-omap1/common.h         |  3 +++
 arch/arm/mach-omap1/gpio16xx.c       | 28 +++++++++++++++++++++++++++-
 drivers/base/base.h                  |  1 +
 drivers/base/init.c                  |  1 +
 drivers/base/swnode.c                | 13 ++-----------
 include/linux/kobject.h              |  2 ++
 init/main.c                          |  1 +
 kernel/ksysfs.c                      |  8 +++-----
 9 files changed, 45 insertions(+), 42 deletions(-)
---
base-commit: e80f5dcc54bf5d494b725e2932571488daac33b8
change-id: 20260330-nokia770-gpio-swnodes-5da8ba35946e

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

