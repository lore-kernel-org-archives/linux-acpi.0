Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4A63D75D1
	for <linux-acpi@vger.kernel.org>; Thu, 30 Apr 2026 07:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777534470; cv=none; b=F1h7F4If7rVAy7l+u6+GfehH//0kGV8YaLEKff0EcZSqj4LedxCqafLKDHgSuRoE2ttf83d3P2vAPUJWC47msmMtYYaofP+1UQZeE4Sv/F2PuUYQXkOLDq4OVDyjhHVh4nPEnyWK6saLFm1E9JzhEFreLCfOAmKRv+FE4AbX5uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777534470; c=relaxed/simple;
	bh=hnY9WhAyyswSQD7bqI8rIpBTtRvYyhwb49eFS9MHNTU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nrJZW4+eyxFcB9GrxJPaMoqTMdb0y9z3fYibmzygdnPyrX/E6iVA2Hihk4dr6iNvaAyCs9I2NTba72DYErtxzQYnX40xGSFAT8mTjSAP+OCfYYYwXUOP4V1lXLDyCXw22+g5/+H3GItmGqL74JZu2Oc9HaRI3I3Eim1QM4kyOGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YMxdWEtY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UJ5SlQ6N; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YMxdWEtY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UJ5SlQ6N"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63TNerhn832273
	for <linux-acpi@vger.kernel.org>; Thu, 30 Apr 2026 07:34:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=xSv3gA37ufigJREMdqvUyj
	/7VPLNmpcCpiHXmZyc9xM=; b=YMxdWEtYEBezN5qNojXlVdTG2RjdWsC08rfClz
	2usFSEIU/RFcr8/5AAFiRvE2fz0T6V/MiQLJUyVw3RW2Jjk7BHiE/vHnpbbaEalY
	gxLshA4CwzxKTJHox1HvKhWcJdEm2dDnD57xpGRIQM1OSyYOhU1qLn7a/BJhNv9s
	GSUIcZyfeGb8xnJl/XLo0qU1p72SAA90Hj34JmF7qYzl5Lg8nOlUM+unYB/FP4de
	UIH+h+01ZUVoG82oiGwD3IVn8dyj1s1IFF4Zt6jXMveWgJzPwEV01MOW4t14iKzG
	JweHelkr3c24m3jUT2fpNRUDCcweBI7Sb4+8zAritR40nx3Q==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4duuvb1djc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Thu, 30 Apr 2026 07:34:14 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50faf1ecd1dso17217191cf.1
        for <linux-acpi@vger.kernel.org>; Thu, 30 Apr 2026 00:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777534454; x=1778139254; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xSv3gA37ufigJREMdqvUyj/7VPLNmpcCpiHXmZyc9xM=;
        b=UJ5SlQ6NFEVrr4f6oplkL40y3uYXhgr8LPEHTnL6PFZQ6hqtMftcK9awUltkJ05IQm
         1B08jpA27NkSFZB2Rdfrlzar+nZpeIvC0RQveq6IFA1N0isAI0vT+D0CwzY5GJWXOLPN
         xw0It3DRxJIKZ0QKkOpsUlVbtvpXqerDAEFsqlCqaQBJTwHkQPSZo1lqtGJK6px6C3VF
         PsBzHfum4HbQjQonCnYfsgFA3Zg7XnAtKEu91ofUUKD9gdH/S82kgM3nC8Ht64ePFqOT
         H02j8JtYc9U+/evQPq1u+gt7VaNKseJvT6C7G+5HJzuJvlms9+YhvGzaKvRAgV1DJDTU
         IUXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777534454; x=1778139254;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xSv3gA37ufigJREMdqvUyj/7VPLNmpcCpiHXmZyc9xM=;
        b=jnTLluAsFQoFMW2a4041+sdSA1c5l8fdePEMFicjaeGBTFBbkPvxV/ctmlG+ihfDNu
         zt21wo5fppj+FBnchdL98Zyu9AxZ25k6JbT5qWAvppsVVHwfceHnMV5PSPa9eZ0FMxz5
         GxmNOrtNd7/KYHH2LkSddB9oraxU1IQ8El1ymQmUDxubV2oGpXOA7J/ou1SjlyybJqkp
         l628yolcXDYH4+/OfAGt5AVoLI04BCRYkLFehZol5wlZyELDStRJIVUR4i3W/aRs6umj
         SeozdV9zBtjv4s/GAkhxhdiuLTCsHyaSF4rYhOO9ntOPrSrZ0v1XuGKKvB4g9pCfq0nG
         3wQg==
X-Gm-Message-State: AOJu0YypN9CK7m82CmJcYNHqWOIxXbAI1OiNULlYd2XTsY1d5XpuT7zf
	f5TZgRa8rVjcAxgsCZhI5o9C46qH4Mh77CDRrrQ/FJbv6uYkc7U0lvsU4JYfRV3YqkrYDCjCBB6
	BTptGOuPULj4Ie5/QfUIcn5juND93dYs5OiASHj3mOUY3/vvmlGRNVUa4eS3gm2y/VCzKFR3r
X-Gm-Gg: AeBDietzJG7K+Obm7a2YAx1dTJ9VnwTpeta6/M5IV//gfUQ1vdZYLOWt6X7U/Ox+8Mj
	WoNb7ZrTR+N2xN9mBmu5eh4PdtP8WwrtViswZSGu0fNKz3sa12TMekEn+dbbsu9mD5ImXU51h10
	rTHz5mZ1lJu6u0p+tB028eEiXUs9doZF5sBZp+0F4SsRKVUTk6iSzsNs41LxYnOHoMpUEhkz4bA
	dXQSmPP1VaPFb0n39w6fZ8Pw6iJSLVCKJ6ESLEjJmDXskdVfL3FI39uxwK3sm99GP6ZJrEonolQ
	aLbH0vDbYqY5JPvIU08pbvS8HjbjDY6oIwLKKuozsF0jNmYMXPZm8gIZ43koDAOzfaUV3kYZIec
	sQ+s/vvEYC2OjvQ7Vw/ECTEiH/Mx1bBxrEEqOXcvXbAxmc3y1zO3MBQlPEctY
X-Received: by 2002:a05:622a:988:b0:50e:5e8d:87d2 with SMTP id d75a77b69052e-5102aad8465mr23024701cf.1.1777534454190;
        Thu, 30 Apr 2026 00:34:14 -0700 (PDT)
X-Received: by 2002:a05:622a:988:b0:50e:5e8d:87d2 with SMTP id d75a77b69052e-5102aad8465mr23023991cf.1.1777534453455;
        Thu, 30 Apr 2026 00:34:13 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:79a:f446:21cb:22e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a81ed6bafsm76132625e9.2.2026.04.30.00.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 00:34:12 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v4 0/2] platform/x86: x86-android-tablets: use real
 firmware node references with intel drivers
Date: Thu, 30 Apr 2026 09:34:04 +0200
Message-Id: <20260430-baytrail-real-swnode-v4-0-767bcda6667f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO0F82kC/4XNwQ6CMAyA4VchOztStsHQk+9hPMzRyRJguiFKC
 O/u4KIHiZcmf5N+nUhAbzGQQzIRj4MN1nUxxC4hulbdFamtYhMGrACe7elFjb1XtqEeVUPDs3M
 VUlmhVLyUYGRJ4unNo7GvlT2dY9c29M6P65chW7Z/wCGjQGVuGCuEQrE3RxdCen+oRru2TeMgi
 zuwjyWAbVgsWoXJIRdKaA1yw+JfFpMbFo8WAHAUOpNQ6h/WPM9v3HysSlcBAAA=
X-Change-ID: 20260319-baytrail-real-swnode-7de7a3870f78
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Hans de Goede <hansg@kernel.org>,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, driver-core@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, brgl@kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4046;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=hnY9WhAyyswSQD7bqI8rIpBTtRvYyhwb49eFS9MHNTU=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBp8wXww0JXJj3cUPpeN7kyGC5vtRjoLvkMHCdCU
 WuBTlcVtyWJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCafMF8AAKCRAFnS7L/zaE
 wwVpD/99JfqwXsAJ4nP6xbzNU+tqUqCOObItl3aVI1FsBjcqzPTo1/VLEe6RUQ3IFgmezepeDeX
 XR8oTT/nb0mY+On9XTyLV/0esyKnvoz1TtLsgodHzQ1W0YgyZqRXeUa6g9lEeygSJQzELFqfjju
 PIIRSWNgIRsba9wct5mE1nizxHLBXCHUXGNDlQkdnLf8sAKZyxIs1bfWnRSaXOzG5Im4VY4+Fmw
 RQpDsBDqRnSDVfqchGIXbiSjJ67GhY4UU0kBqddKKIaYO/lGftF2JbME77k3DKAi4T7U2bj5rcd
 2IljBtKYlru8JQtY/yWw010zR3asyeClZ2eAjzZcnLYoPC/E7fads9l6B5SJQB2umfOsWa6r32A
 LfRoj0eSlKNxBgI+CFMuA2RcnPIvC6nRZCjQpgyZYSvX2n0tf6GmVMteTXu3Rs2LsoTXQz8iFlj
 RFf9Bf9STlq4ouBMKKlIWos5jbO5vwthtzI79gWulWEiQaiz1WAQunSCysFfkkOo+C6pWAeURjG
 afv9U/vVZYJcdEXFqIbb1B9hSDH/X+QWbyvzGtlf9vs/Vhg1/vgxcOvqbMjX50910lcxuv0/VAt
 L7nCrAjjIT5K9KGk9YFtHHMI7DTCUs4Dv64SYOVXw6Pf5rBkFByQ99tc3G32UbRTrk0KFSCKNh6
 /+jbRspnZIckYCw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: Xv8nOalCSC69PXJRik4qhZ1TjbyidSK3
X-Proofpoint-ORIG-GUID: Xv8nOalCSC69PXJRik4qhZ1TjbyidSK3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDA3MiBTYWx0ZWRfXwKiEb6PlLQbz
 qo88jM4lJGmscju+1M5NkzXJpvw8SceVsL7kNNCNoYy3FV0l4bWqX1P7AlOTt2P/JbtUtIZNovL
 2zOTvGlXadD8HqE0rcj80QqJuFmfEtHcZYE8eI7wF/cIo9UkYbGYgl+TxaRVNbbG1PyI64pYWIo
 oMJCwbYKF4jK8tvakFbxwIX69OqwVeloMgcaOj5oGsAz9XO5a20ICV4FpEFTtpC962sxlAY+KxV
 UrEG6o863GS0XhmE/KMYtylo9NsZWMTK7gxgf/mv1ChZQyMvoJQMjevzLMsboJR6yZgAp9cUH4F
 cE/TSCylGcFuwQbShFpHDiN4URA34aZPNz2qV1VljENWy4St/TVYzyIZ840EFCOQyCKkQFTA68L
 4qIamXRZWOp/RW1VRUVmpeQJBderIFzo4MDktMkLaI3moR61QnzJoGOIBdfjYWMx2nl+g4yuqvo
 uQjtNyL8mGj8S4vzc7g==
X-Authority-Analysis: v=2.4 cv=V+JNF+ni c=1 sm=1 tr=0 ts=69f305f7 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=sB14MePOP5e2yt9b4dIA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_02,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604300072

First let me repeat the problem statement:

==

GPIO software node lookup should rely exclusively on matching the
addresses of the referenced firmware nodes. I tried to enforce it with
commit e5d527be7e69 ("gpio: swnode: don't use the swnode's name as the
key for GPIO lookup") but it broke existing users who abuse the software
node mechanism by creating "dummy" software nodes named after the device
they want to get GPIOs from but never attaching them to the actual GPIO
devices. They rely on the current behavior of GPIOLIB where it will match
the label of the GPIO controller against the name of the software node
and does not require a true link.

x86-android-tablets driver is one of the abusers in that it creates
dummy software nodes for baytrail and cherryview GPIO controllers but
they don't really reference these devices. Before we can reapply
e5d527be7e69 and support matching by fwnode address exclusively, we need
to convert all the users to using actual fwnode references.

==

Now for the new approach:

Now with the recent patches I sent or plan to send out, it turns out
that almost all existing users of software node lookup can easily have
the software node's representing the GPIO controllers attached to their
target devices as their primary firmware node. The remaining complex
cases are: pcengines-apuv2 and geode-common but in the first case we
have control over the creation of the GPIO device - we can assign it a
firmware node - and in the second case, we deal with an MFD driver so
can export the cell's software node in a header.

The only remaining use-case where we need to reference a GPIO controller
described in ACPI from a software node is the x86-android-tablets
driver. In this case, I think it no longer makes sense to propose a new
generic interface. Instead, I'd like to propose to keep it as a
driver-specific quirk.

This series proposes the following changes:
1. Provide acpi_bus_find_device_by_name() for looking up ACPI devices.
2. Implement support for dynamic assignment of secondary firmware nodes
in the x86-android-tablets driver. More details on how it's approached
are in the relevant commit message.

The dependencies in driver core and GPIOLIB are already upstream.

Merging strategy: Both patches should go through the X86 platform tree
with an Ack from Rafael.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
Changes in v4:
- As pointed out by Hans: we don't need the notifier logic so replace
  patch 1/2 with another, providing an ACPI helper for locating devices
  by name and simplify patch 2/2
- Link to v3: https://patch.msgid.link/20260427-baytrail-real-swnode-v3-0-0003e4c1708c@oss.qualcomm.com

Changes in v3:
- Drop dependencies that got upstream for v7.1
- Rebase on top of v7.1-rc1
- Link to v2: https://patch.msgid.link/20260402-baytrail-real-swnode-v2-0-6f5054a4cc07@oss.qualcomm.com

Changes in v2:
- Completely new approach
- Keep the cherryview and baytrail secondary fwnode handling as a
  driver-specific quirk for x86 tablets and don't introduce any new API
- Change the return value when resolving a reference to an unregistered
  software node and defer probe in GPIOLIB in that situation
- Export acpi_bus_type for use in x86-android-tablets
- Link to v1: https://patch.msgid.link/20260319-baytrail-real-swnode-v1-0-75f2264ae49f@oss.qualcomm.com

---
Bartosz Golaszewski (2):
      ACPI: provide acpi_bus_find_device_by_name()
      platform/x86: x86-android-tablets: enable fwnode matching of GPIO chips

 drivers/acpi/bus.c                              | 13 +++++
 drivers/platform/x86/x86-android-tablets/core.c | 78 ++++++++++++++++++++++++-
 include/linux/acpi.h                            |  7 +++
 3 files changed, 95 insertions(+), 3 deletions(-)
---
base-commit: 085f14acda1c46ab815605ecf2341afe5a691eb9
change-id: 20260319-baytrail-real-swnode-7de7a3870f78

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

