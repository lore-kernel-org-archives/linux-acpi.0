Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DC93B775D
	for <linux-acpi@vger.kernel.org>; Tue,  7 Apr 2026 13:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775568493; cv=none; b=Qj7K32WubK6BfRTYpS16h/JEzy39aBnrq1x3KUgeFzrbm6WxVdpV2gBQM1DHfY3UPyqIwSBNbcBqRj4sfBKhEEpjGNoLd2q37AeFfLmluekxsppqBSuT3Vyt4vU3Mxg8pvxWcPw0RgBE/lVZ1koIL9JzVgQJHWfE9hVsgjxdKkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775568493; c=relaxed/simple;
	bh=FY1Q+9TehUyqcI3x63wa7twcfgql+CA2aOd6U6lMKvc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fQNF/YNldg0R/eG1G6nnuFaPF1m98AEw2fq2gcyL5Hii650S76Ozp44gRQPIZCchPYCUIImgRotaAC435FGCaid0KNwLpohDRNrHG1IHOdHBHyvQEBGv3dtyN2QJYKa8fg2n8mM/BsAq8oIfoZPgRJ0y9MpCiwm25uP7re7rPnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Jr5d872v; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PhRoGAul; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Jr5d872v";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PhRoGAul"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637Cgqip3816989
	for <linux-acpi@vger.kernel.org>; Tue, 7 Apr 2026 13:28:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=8TW/+a9osElnYtdm6J7vNB
	bKaFrjmY7Woc9TQkl3Gng=; b=Jr5d872vvMd/DQeVILhek9Peqlq6sKHQBkAC9Y
	ZaHrbZNDCY8ZR9rc8VoCelfgmJSWr/vRFXsHT70jGYhWTWRMGtH0NzYcBoPawuJU
	PqwLO2WtVNTegojA/WnE5IzxVyhS775ACqIIcaII3oEZiHbj8GBXqmWbYAzUQM81
	FTWe8cNSdJ1X4Rxu3GN84U8fere/21L6gs3Wh+JfFB8JZmg23yFg+HshuT98oMrs
	vleukvJgyaTRksAVTUXOIZeiLOqPcR3Ef40lBYh/W+8zAByqXD/eJmOrrTmE/Lu2
	sDq/XPt7MoTJe7nW38NQHkfg36P3v0vEZ3FENauAu89kj7RA==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmr4twn9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Tue, 07 Apr 2026 13:28:11 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-953b0e67a8bso1209136241.2
        for <linux-acpi@vger.kernel.org>; Tue, 07 Apr 2026 06:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775568490; x=1776173290; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8TW/+a9osElnYtdm6J7vNBbKaFrjmY7Woc9TQkl3Gng=;
        b=PhRoGAulWMAqsei4BaI0H1AJ9CADmTGPFs+34OXJWsjxwsly2wwbHgTpVWR9tsqhVT
         pk0EZzz09OQUbj3a4NKhDtmUttrwQexvBgh5+PxUNVVoK6s/Kyr9NbA63Vtwi25dHTnY
         S1Ac5jglub4ii888rwTL9JZF4KdFr7t/v+xi036omIX8lxlVvRSl7y152s/UIBUAEWwP
         9oX5WX/Hd9UFZlQrx7pM2CYJu4mcE/nnr0D8trQYDX2ctjg2ZIFP9pyW+ClE6ZjEyiZs
         n5fVABMimX1zFPlO6hY+R5PLIQLlpcrQjnskdUYZkv72v2EwOJB/4yH5obmTVpCxzYcP
         o0OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775568490; x=1776173290;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8TW/+a9osElnYtdm6J7vNBbKaFrjmY7Woc9TQkl3Gng=;
        b=FCwd+8htIqqq17t1dLj8QS/EkwTkOQg83BI7uLDg5ySF3Wq9TyvoorzrjlRkiK4ydn
         L9FceQtihbCUogZR9cSMDF9jAYY8y8bvxWUFfW/O27HW8BeYeRutf5mtDakxWV3BWuRq
         2FW3cUgUt4NgP/9g/dML99QTX7l4Rhq6jIhEzh+3iT4RmM4V9lxP43ah6n5Bd2blfLhw
         B4h6nSIapjdcXNM7NQIsyEzvTSZZJmyHeYR2G6l4+i5oAa5pAlQ2Qq8/44vk1QKZWQjs
         F+HvsyvrwOi9aVjL8qAInxnvHqgU4WGN6dR8E1wBNF6WKiIzIwKHzmDuUUpMzR/2bb99
         17Kg==
X-Gm-Message-State: AOJu0YyrcKK8PfFAU+B1w3UchS0axUDfOq41ivhFIaBt7LpRKBuMRrdz
	fgLum1/j09VKwl8ihaZcJF923G3/uOjSiWqO26y+T8sY93+M863gFHUE7zTUTT0x/wVUCi73kIe
	2NBhr6jFWsbEOu3xYU/aYBbQfaBULdTElaj8spzqZvHSBjfwNlgZtidwJTNkKVYbnI+unkDgo
X-Gm-Gg: AeBDieu0cLcB/iKxezkY8cWtEz8sxPOU8mjMruqtz1Nt3DpQs3ROdxN0t/LG2+e/POA
	XIuPCBBSnXRfa8ba1muH6HsVSR24nVbKmtH9RgF/P1bnHHzlErgy8srGBT3hZW6LyoyX2vDeZeQ
	DdFG9UTr/1dgvl3Y0flRk/83+EC1OMQz6a+tviPnxUfFnOZhPnQP0FMZG74sICLwidQdbQxIzFw
	g5y8Drhl6xNPt0vEDsWLAnXytNsDNZDS7xcE/jelLjMuT8NbukYz4Ymq6U8KsXkaESjpHbfn/UV
	Bi2VxCm5iAe9SUirdJRuObb1fd1HSl4Hx2uJIXhKyD9KJ4/uVHIDa9bDyyMz85oC4MHECCCVxAl
	YtOMpgHLDSuqBV+NIiBWohsF91gsn4UNZq/3H3UWdRHsj435Zpq4=
X-Received: by 2002:a05:6102:f89:b0:605:1228:891c with SMTP id ada2fe7eead31-605a4de97bamr5435483137.15.1775568490558;
        Tue, 07 Apr 2026 06:28:10 -0700 (PDT)
X-Received: by 2002:a05:6102:f89:b0:605:1228:891c with SMTP id ada2fe7eead31-605a4de97bamr5435471137.15.1775568490098;
        Tue, 07 Apr 2026 06:28:10 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:b36f:5370:5f91:2d5])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2c6cccd2dsm4073807e87.67.2026.04.07.06.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 06:28:08 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v4 0/2] driver core: make references to unregistered
 software nodes a special case
Date: Tue, 07 Apr 2026 15:27:56 +0200
Message-Id: <20260407-swnode-unreg-retcode-v4-0-1b2f0725eb9c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFwG1WkC/4WNQQ6DIBREr2L+uhgC1mJXvUfjAvBXSSpYvtI2x
 rsXvUA3k7xJ5s0KhNEhwbVYIWJy5ILPUJ0KsIP2PTLXZQbBRc0rLhm9feiQLT5izyLOdiepzNk
 0ArURCvJ0ivhwn0N7bzMPjuYQv8dLknv7R5gk4+yiVM0bkZ2mugWi8rXopw3jWOaAdtu2H4/5r
 qC/AAAA
X-Change-ID: 20260403-swnode-unreg-retcode-38b5b92eab28
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2391;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=FY1Q+9TehUyqcI3x63wa7twcfgql+CA2aOd6U6lMKvc=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBp1QZg71Z+wr+p0t+XK8oNxJ9/Zw4HyvB7CLsx4
 FMepWEkFu+JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCadUGYAAKCRAFnS7L/zaE
 w3V0EACt2zQ196yh51EWACoKV8aPM7pEBuLyuUF+p+mNtH9c+vuBNQ5CoPA22LHeJSD/NubszeW
 AQVAi2Re+9HdduDDNHipiC+V7mVpYEUC6UVNAwVm6KZKyKCvHc6gQJMAEd4Up1F+UB211dnylF/
 Qo3W6VdoLeO+Czbw2Nnewqvscal9PsipLTVoajDoUn4VzcxGrOoM/gmpP5AS0g78z7rSlB0SO3p
 5omLJ2s4Dd64/vn5yDUg9c+yr63V6FCpYvlWx7UlWb7bC4cH4srGsILzutuSM+6fehhH74MCGY5
 JG4XTUY3gb7Ganak1gh65jyZtipJqSRwlFjtHyM3FLyXGiHCviWMZP+qafTectmya8c4rb2MYml
 M2hbwHfMsf3623r4ZMJYEEbls3jr+3Z1ZtO77Wpf4kIwoxCs2yfPiFt7wqXKypSg/BGsCgHOIEe
 oenvXI6SBo+8icJHAxpS9dEJkAkdb3kKc2VeQCPy6VoQu3CK6eQrAKuDiee09yrIadzf7M/y53E
 x9Ftv57KYIRDdj+UclR6AdkpwAm7F23mqYpX6QjY0fMF8lboYnw5xziDOiVLfQ/DM8YgOmDmZ2F
 vcDWq0td+YP7jdu4jlv94EnkPeJchT62ve+Ew4N3XeyKHzKkxTz27koBAX39jbPiqzu1K4XKKNx
 b+99shat5BHrmCQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=dO6WXuZb c=1 sm=1 tr=0 ts=69d5066b cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=h3m_6F4IQ1uC9WK5d8AA:9 a=QEXdDO2ut3YA:10
 a=o1xkdb1NAhiiM49bd1HK:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-GUID: 0ExPZsdqpUCdc0kIinWOqa0GH2-cUlQq
X-Proofpoint-ORIG-GUID: 0ExPZsdqpUCdc0kIinWOqa0GH2-cUlQq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDEyNiBTYWx0ZWRfX2FbVjcqyMdl/
 cpLwsO79dOOJYIZynKIAlTlVTBQaiksO86Td+BDtz53HO91CtCd+XUod18S/ZEj1w1E0WgYxvuR
 ASxURh0FqAbJld4SYNyiUns1R0cR+0PnM1gaEK0pgIXV6R8TOaTcq5Qsh9J13YNbyUQrvNIOE0h
 iHc0fqd9WyKo17sSNkzpsGqFGQm69LnMZUXcpxijxHD3VRbw1lfaohgzaNW33gHJ9yTl3KNPgYh
 xEwdCV1R2KDbTFY67Bi4kIaj1wLWM95U8PFF0hVcTdh307/xAHt9lJVPN16Z4mAzB8Tb8ec33ml
 NMg/HF4AEKaBd3+WJSH9Ee+H4q5AiZ80hI3wqIuLxdHlLapSUT46/1KmhzhglEeoXeoIuGPc1gM
 WLVvfh2mz7tjp2ui7yLysdALtFl8sndr9Sob/MP7P+rI+C3lgNQKhbXTe/xQ9Gw65npwYQzrSDN
 4m5ZCXcoRUtvM69AYyQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070126

I spun this out of the bigger series (see: link to v2) in hopes that we
can get it in for v7.1 and make follow-up development easier next cycle.

This series proposes to make unregistered software nodes (ones that have
an address but which have not been passed to software_node_register()
yet) a special case with its dedicated error number. This will allow
subsystems to defer probe as if it was a firmware node not backed by
a device yet.

This is done in order to allow easier attaching of software nodes to
GPIO controllers and the removal of current label name matching against
the software node's name.

The patches can be picked up independently into driver core and GPIO
trees.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
Changes in v4:
- Document the new error code in fwnode_get_reference_args()
- Simplify the logic in checking the new return value in GPIO code
- Link to v3: https://patch.msgid.link/20260403-swnode-unreg-retcode-v3-0-7886092b28b4@oss.qualcomm.com

Changes in v3:
- Drop x86 changes from the series (will be resubmitted later)
- Use -ENOTCONN instead of -ENXIO to indicate unregistered software
  nodes
- Fix retval check logic in gpiolib-swnode
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
      software node: return -ENOTCONN when referenced swnode is not registered yet
      gpio: swnode: defer probe on references to unregistered software nodes

 drivers/base/property.c       | 2 ++
 drivers/base/swnode.c         | 2 +-
 drivers/gpio/gpiolib-swnode.c | 8 ++++++++
 3 files changed, 11 insertions(+), 1 deletion(-)
---
base-commit: cc13002a9f984d37906e9476f3e532a8cdd126f5
change-id: 20260403-swnode-unreg-retcode-38b5b92eab28

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

