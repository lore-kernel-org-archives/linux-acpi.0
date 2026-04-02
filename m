Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB8E317153
	for <linux-acpi@vger.kernel.org>; Thu,  2 Apr 2026 12:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775134493; cv=none; b=Ahjwkc4Q8sonmD3iyWEHxvJiIOyRhX7XQfjsevuxPcHYXtujHtQr9ZAB2bptE12ly604coXgKdYvbRxP0uwCSWQ710wh0Y/QzvH76t6EH27oT/jhG0cNVfhcHVIGS67QOynBaESOGY0piA3rj6PcEb/YdkxyBOqUUaIHIHIaTT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775134493; c=relaxed/simple;
	bh=24xsLOLqRXtbnsDwXrWse/dU9b+cDN9cnJP9rjTfD5s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lqNLtaZkBxV6rUSzb5YakcBKdG+s32q1sBDpL8nveS3PwbhW3UWh8FlMpccspC5kCxPVX9bFvw0AvrgtrgkrdI3kbYL8eZ63YT/uyXtzBqrC0jpaa3hyqDz/yvuVnv5cDM/3yuDnEge6WB3ZNGg+DWvJSmHXAcrgbwc2Z3a1/cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l9q9ic80; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IxCKBX6n; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l9q9ic80";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IxCKBX6n"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 632B8lVp090872
	for <linux-acpi@vger.kernel.org>; Thu, 2 Apr 2026 12:54:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=iHpwT6BpFrGCwQLSTIvU7u
	gWc2ffjsjtwWY7Mv0HlDY=; b=l9q9ic804wX1OprEwpopvI7FlqTuHPZMobXpiS
	bSWu97RBIUtXE7sXQqNFFxoijxPJ9nBOFGnfzeqv/C42XkwM/Io37oXo9vFOWeOw
	e+q2LqxhADjWr5np/OeE4MLYu1Of2NSyrtat+kzFQUZjLyEFLYtOIcVP4RFnN8yu
	wAFS1vqHdl9K0LeUeREnImJFAJgfnEvVcUkRvfGa0GzzO12jLrb0QkQ0O1+wDB74
	XwXutTzd7h92MHx4gmJZIoK1DTW2XT/m8vUtLqfpNv3gr58NkdZhJa9jPd2iWl4q
	TFOgFQCqWcDIAAIL3fyTJ2bUjAuHusYt+r0LvaZNPmSUSerg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d9jcu9rvn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Thu, 02 Apr 2026 12:54:46 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8d3bb62cd2bso43096085a.1
        for <linux-acpi@vger.kernel.org>; Thu, 02 Apr 2026 05:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775134486; x=1775739286; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iHpwT6BpFrGCwQLSTIvU7ugWc2ffjsjtwWY7Mv0HlDY=;
        b=IxCKBX6nn2h2bVcpaPjMGIFpXXRZyaCaAPnzsFhSbk8lN5nQaczuJU1O3jSkBCYRCC
         UDzdL/eaNkAlPl7bzbn8vCYYXP1zRd2VpeGx7uy0VZbQu3X8pr7+oPHTLh5UiXxuTiG1
         9BBGq6Q3birWfcMEcSrH6cZ/EWG3V7gUT6s/2xxaGZcgYTnVcNRfuIXfCgxrQzkqRRgt
         A85UnvFccbOuC0Fj0NfggCm5tZGCudTBqYGcY+eO4rcwcdkdgeBZPIe7zxF1aW8HgR8l
         C/C8pRSONE9vJDRqxXxInMt2igG6wbAFMibJlrFDCT+e+fOFwxErt4L7QFArIhLKfLAw
         FcRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775134486; x=1775739286;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iHpwT6BpFrGCwQLSTIvU7ugWc2ffjsjtwWY7Mv0HlDY=;
        b=au7f1bqjelAcI/CatdokNxsw3VDY86OUnbuEn0qlpc3llMK9Domc8QmQsrHv8FEDWY
         VHYX+63WI53UsR87sQ5r9rCe2+kJeFS0dI0HBamwYqY2VYSK8aPfpHGQ+Gmrm+0KKrlO
         4q5rOmoadMRzzPveTlIRGBEQux30qPok0bfINmeFrJ/NYW/sgbx/UUiWSquvYTOS496w
         +6KV+wLD7jOxCqG9UwOTJT2YKFwIIMAFlsdHNr1GQ/JABWfA3W6S32v2wl7zEIejR0xf
         KG0o4fwxidBFDXv4tpLhf/IJQ0B66Rk9LYvmAGjXtccDXx28RNoDA+4Ym6COgE9IG4zX
         3Lpg==
X-Gm-Message-State: AOJu0YxyEVQN5/CluljJcNSLAtmMQxomAn6DSyo3oCl7IR0+JLjUdnJu
	u5M34mMFb221+5ZXnOKFEInSXwb9X3Nhc0TqmaQk73IZhZ3ltt//Pe+/xPwNLgPy8VuOgOPNFOp
	Te0q/8ppVFZfhM4vnHfaVNdweoW95ie/AGKNm79aaQZaNKgP1LkrEMCgjhsuD27fJ
X-Gm-Gg: ATEYQzxNc7XGZ5gawxdxvxr8WhfHSXUUctGmavWY49PN//MOoedlBmlmGqEBje4DqWO
	E71nkWmtOmNl7H4YnsEeARK4R2B/cpJIiMw6EuzKU0uu20egWE648KGDekrq1zgtox78ROpt5po
	W5c6nLpXkkR9skPWcfew/taKApMparwoX2hUOAc+nEkP9a4+t3BwTJBx5IaHYqnikbk6vsmur0T
	loW0OTZFWval0ztv/IOFG4S4DPnTpREME8m1sFKrVuQ1XyrTflFc/v/k4GKkz/q4nruqIUJWIcd
	L39OnWA3rWuP9lBS/dtrtGenfxDtx0W5YTqyhYPBJSvlk1qofiO6xek/VbU6Ezf1B2N1l4CdZrM
	SiF4gCngqRzz+9NhEaNeeb85aJYhPyigSOkkMF+LEMHyj3XcLbKNa
X-Received: by 2002:a05:622a:6851:20b0:50d:4b46:823e with SMTP id d75a77b69052e-50d4b468869mr38706611cf.20.1775134485924;
        Thu, 02 Apr 2026 05:54:45 -0700 (PDT)
X-Received: by 2002:a05:622a:6851:20b0:50d:4b46:823e with SMTP id d75a77b69052e-50d4b468869mr38706311cf.20.1775134485440;
        Thu, 02 Apr 2026 05:54:45 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:4ff1:3e57:22ec:dadc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e735532sm235790765e9.0.2026.04.02.05.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 05:54:44 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v2 0/4] platform/x86: x86-android-tablets: use real
 firmware node references with intel drivers
Date: Thu, 02 Apr 2026 14:54:25 +0200
Message-Id: <20260402-baytrail-real-swnode-v2-0-6f5054a4cc07@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAFnzmkC/4WNQQ6CMBBFr0Jm7ZBSkIIr72FYVJjKJEC1g6gh3
 N3KBdz85P3kv7+CUGASOCUrBFpY2E8R9CGBtrfTjZC7yKCVLlWe1Xi1nzlYHjCQHVBek+8ITUf
 G5pVRzlQQp/dAjt+79tJE7llmHz77y5L92j/CJUOF5ui0LgtLRe3OXiR9PO3Q+nFMY0CzbdsXr
 kv2+L8AAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4394;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=24xsLOLqRXtbnsDwXrWse/dU9b+cDN9cnJP9rjTfD5s=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpzmcKtOfrCbWj8euir8BYMdxK6ZZuyNL16OrwU
 5zjEG1gv6uJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCac5nCgAKCRAFnS7L/zaE
 w+02D/48rQakAgxHkrMTeefUE0Y7FqI2ba7FUzazTRLVY98B/EI9LLBDXeYd+7BvWzMrJTeKHu9
 GUai0WuqtygVuOnaVaZ8fXTKOdusREI0OAhl0fnHQOHPWLDnYeVsKRrk5YFOq3R43gnXr89ZoDH
 RCtzwtiSJuXKKXhaa/B98LVGhq54CPTlrQvwEawuo9OJreom3Ep44NXrEozDpBTyJlkw325LSQk
 3s0pGW0JOwO2Wlb7K9SJBDzOdlmmHPE/SNrMe0ZfisB8VJq3hGeXsdKL5i8X38I0dhCQ8d6pUaI
 X5rU46AE3sgY22xZYZtp/l4+pzryCGQkjPT7KtjOBelQqOmeg+RQb8bZqPoTNp7X1EWzxBau4x7
 FfgoDLg4ySmDjDYvIn4L/6TxPs0iVgjPLVtxJZ9Jp1wTGQm8lpnyHP2j9MXJpMalanRo4CGuzWG
 ezRxYYSCXNoAM0k+ffKbrLkDRAghXxwAexbrUkj5FjG+l0FjVYMe/XDFcxQQ6y1lJRmvLvnDkfm
 fJ3VMPvrAesWBKwgctLcCjz1UBM1ko5kGaXlD4qE2fpjMRgeJ9fL8x/zBSAuDKp1Kqu+sv1r//6
 M9VDnSTyGvd6Pxpn/4bS6Y2jwICpgud3OOgO7e1JgHaQNiE4cfuYL/D+vRl8rjOSkybPc5kSZnF
 V1aSS0KJFxLnsFg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDExNSBTYWx0ZWRfX6OyFejiQiCee
 2ZVpN/rfINk6QsvfpaaA+qqwmDnRTLBhFSh1wlX/D4rESf4WC06AeFv29bI9tGeUV47GPjJh+xj
 +zcEj/yIT9LF+RST9hc2HWAb7fGWtxwTSzqk2vycMBaG0zufZK4p4sQUwhU+xWlU69a08jJhM5g
 ik1pZKX4SVIyhoBjr7eZDnG84azs6th4dW7FXCC9RSf2f9OEaTX7UfflUbkLoCylWmayRwXHcRg
 JkAY4OGy6K+APiQArG++nHOsc4kClkua2sex0uXs1w/xuwcTrKqDP2aEdagcCxbwKzRnHVg7sV6
 YqHxk4ml/a8Y/g8uGlDtsiWK/JxHtHIzEPshCswwqI8Bb89jaGGfLj255TP5I0cs4+Wc8S9gzPl
 zY2xBRQbcp/AO3cLOb+GXKQNXhruQstlJI8Y0c+G95o+NBcJlHC4d1jyGPJNyLskixFT9pFVeGM
 uuBs/8Z/Hhwy/V9Srxg==
X-Proofpoint-GUID: 0jfPPbLY35nLFq0JEILocAZUBJiewM0c
X-Authority-Analysis: v=2.4 cv=eYYwvrEH c=1 sm=1 tr=0 ts=69ce6716 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=V8hzrGCVczdKLN6W0kAA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: 0jfPPbLY35nLFq0JEILocAZUBJiewM0c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 adultscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604020115

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
1. Switch to returning -ENXIO if we try to resolve a reference to
a software node that's not registered as a firmware node yet to
differentiate it from other situations in which we return -ENOENT.
2. In GPIO core: return -EPROBE_DEFER from swnode lookup if
fwnode_get_reference_args() returns -ENXIO as an unregistered software
node is not much different from the situation where there's a firmware
node not backed by a device yet.
3. Export the acpi_bus_type symbol. It's already available in the
acpi_bus.h header but it's not available to loadable modules.
4. Finally: implement support for dynamic assignment of secondary
firmware nodes in the x86-android-tablets driver. More details on how
it's approached are in the relevant commit message.

Merging strategy: I'd like to propose queing patches 1-3 independently
through their respective trees: driver core, GPIO and ACPI. The final
patch would make its way upstream after v7.1-rc1. I would probably
extend it to convert the driver to using more devres interfaces too at
this point.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
Changes in v2:
- Completely new approach
- Keep the cherryview and baytrail secondary fwnode handling as a
  driver-specific quirk for x86 tablets and don't introduce any new API
- Change the return value when resolving a reference to an unregistered
  software node and defer probe in GPIOLIB in that situation
- Export acpi_bus_type for use in x86-android-tablets
- Link to v1: https://patch.msgid.link/20260319-baytrail-real-swnode-v1-0-75f2264ae49f@oss.qualcomm.com

---
Bartosz Golaszewski (4):
      software node: return -ENXIO when referenced swnode is not registered yet
      gpio: swnode: defer probe on references to unregistered software nodes
      ACPI: bus: export the acpi_bus_type symbol
      platform/x86: x86-android-tablets: enable fwnode matching of GPIO chips

 drivers/acpi/bus.c                              |   1 +
 drivers/base/swnode.c                           |   2 +-
 drivers/gpio/gpiolib-swnode.c                   |   9 ++
 drivers/platform/x86/x86-android-tablets/core.c | 127 +++++++++++++++++++++++-
 4 files changed, 135 insertions(+), 4 deletions(-)
---
base-commit: d18fd67e5f09e800611b02e2afda430a870a136b
change-id: 20260319-baytrail-real-swnode-7de7a3870f78

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

