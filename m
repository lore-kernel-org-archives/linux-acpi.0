Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6819D3E9584
	for <linux-acpi@vger.kernel.org>; Thu, 15 Oct 2026 14:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792075608; cv=none; b=nqI8YUIjaw3hT3fj+OnYX173s66ZvOeNZHzd/JP/21mqc8ZRXkl9YWLjIl3uGJc7WAo8x4xCHeKUsACXHmTi6oRofU9c8qyYLcF3EdrOcR1O3oZ35chI5c9vOcH8jixQBeZhaUCyOCwVD0TwrcKl24xqIEkKQRUEMp4EursMS7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792075608; c=relaxed/simple;
	bh=NHgIRIYeSxxBM4Z2O/FYMoXHETZQ8rwvjZE3GOfWUQc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bvy0N/exllRfmiVFU1bGKaGgTOqGbPbr+AxGTD//1ohdi0oEab5T6siY7MQuZ9Diq/1ShZU5FPQZTPb4AzM576n7LIzvItBB0e1TGmJRw/WbkKwUS1yJ3sr0YUhnbS1clSZQL7VSVH8npShjWNOStAHFh6fOmi9+9obqNrjdnR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EqmVQKLG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=I8r3fDGc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EqmVQKLG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="I8r3fDGc"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F9joLU3408870
	for <linux-acpi@vger.kernel.org>; Thu, 15 Oct 2026 14:46:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=u/nlLAyrIY971jI97tgUiI
	dOKUIdrmUXPoG94AIgOqI=; b=EqmVQKLG6kmBa3f0f+xOOJQCVN3EpYtnoes67G
	oiup/ZJJhnXDxfxd4OqlkzX0k79nVGrC1Fr7F7VvtfBbyhbS5HtKHq/7xgMnDejk
	P2k9Ya9ao0hl+z8xOwR+panrEL5/tMh6D5GgczradBvJAJPD8Q8Z7AOBkI9sd2sR
	XOcDFj54Mi0WTI4PU0MDRqpJZ6wwvJeej5itid90GhT0njk3qEp+sJJD/JPncXQH
	5saLnS22rO7/WbrtyHSwFVXqNeoFENL1dJSyA59/4fPzzYkJ5ceAwo28FQqcM3OA
	jv2O+8ut3eORaJWLFAzhgS6KPX88+ani+Me7Z+mlR3P++J3Q==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hakwn39sg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Thu, 15 Oct 2026 14:46:45 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5ea71263f4dso175526e0c.1
        for <linux-acpi@vger.kernel.org>; Thu, 15 Oct 2026 07:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792075604; x=1792680404; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=u/nlLAyrIY971jI97tgUiIdOKUIdrmUXPoG94AIgOqI=;
        b=I8r3fDGcYcbdUMh3ZZinwq0DYI/ayV3p4LtS/kyHV9YUNM4BnG+6jKiORjejPfM4GN
         zvITZ4rOMHF4ljmXqqpEWOsrnPlqXrmck9yeS/9Wr1V/lmTAbSsszMT61oOaIc7MQm4F
         ULOkI0KmLlTUkAkxtSPeGmrl+q2LOEjJVAlZhGa4Fb67s9WgvTXXxbv1hn5XU86I3waI
         FNh/6cL3tNsvfKIld7kQReBbk73tIK5QtjnyyPBC5zrOzEwrm2bjrPD6n1iEkWBYKkvQ
         U1tS6FfRmb30b5bPZ56/UIhseALxL2gHp2wbd9ip3l3eprnt8+13fu8OwERyzjEbZCfi
         Aybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792075604; x=1792680404;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=u/nlLAyrIY971jI97tgUiIdOKUIdrmUXPoG94AIgOqI=;
        b=pTvun+7708U6Ag5jK1A/uj3doNuPvt/abUoFDbFKDDQGz06dHgvxaHbkF0xWJqxa0s
         cruev1uDpR34FQ6HYOW2Gm+nbd2OuvVo4zpz/43FKXHboWD9hUKrAA5odzbo2StNy567
         CBmQHsV1y5Ysi7nrSCWIyHcfe+p7fJoYfsBskrNyfQAQceQaw1Dt0yDyQRmoYx6FpaYF
         a5jwD5pge0zIoM1vlMcNZuiBgrrajWmlVi/XUKimfw1/+ysoT++DcWGdyi1SZrEZq81M
         wkfOniiZC9D5r5+BQI4yxoBiZzSg003Rx8g6iKGVHKLdIpU/2Jp20X65hFu8FAsRSbRp
         /jEw==
X-Forwarded-Encrypted: i=1; AKwUvBwmVjmpKGaQpDfkXBIWMYPTVlKbz19I0NE2mlZTBxs59a+9ceO/XFhMUHfJw/dlkt71oCXloq44/hIN@vger.kernel.org
X-Gm-Message-State: AFq9FYIAh06V2HNOg9rQ/0AujV6E0/5FmawJbDL37zzhfpsDxwX9VTDy
	Og3OpWVzhnwa/IfpmI+N4cmHP/Ih8eFc/MKsMJaGTPtDaxvuc8080PlR+Hah/9oa1expHoqUxi4
	5aGJBgS54DbgZ3kgPQAAzoTjHiXKwa20+7EkxapYC9i2a4t1M3uvNhMFyn9FI2J0Z
X-Gm-Gg: AYBFou3L+PrvwS/Eb99Q47ONQHlzv2+S6+zRggflotQKDRqk0lOtrGoMMHr7ZsewDrS
	E6SobkzRPtjvIgWjlaBvf9T4u722UZRmdixd1BkbWXACiwAR7kaNCE8BA2Tba0DVoi9yCU3Efyf
	ZOrue06YCdjp5sQ7lsTsZ8rhydIeA7kmBGg1MhBVQDysoy+Ps31u27yeJZRqp/BCQ+XDWyDE0H8
	D3n60tSSzqruobx3kupE30PNjlfs+8ARBqI1ucNxtZonzGNW46OaqP/67vMd/R8i0zVI+NYS9F2
	+eTyIJiJvuoI8seFahO0Fcf4PHR3aknCuP4FvvR76HVnpGO++LXayqYxzKo5OeFTBIG9n5tC1Jh
	tLjErX24N7nTBmpJQyN1ZEr02Ov1z
X-Received: by 2002:a05:6122:1828:b0:5c7:a9ee:dcfb with SMTP id 71dfb90a1353d-5e91f46ca9amr6094207e0c.5.1792075604375;
        Thu, 15 Oct 2026 07:46:44 -0700 (PDT)
X-Received: by 2002:a05:6122:1828:b0:5c7:a9ee:dcfb with SMTP id 71dfb90a1353d-5e91f46ca9amr6094164e0c.5.1792075603775;
        Thu, 15 Oct 2026 07:46:43 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd9b8ebdsm86840625e9.10.2026.10.15.07.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 07:46:41 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH 0/3] driver core: fix unbalanced reference counting for
 software nodes
Date: Thu, 15 Oct 2026 16:46:21 +0200
Message-Id: <20261015-swnode-dev-notify-balance-v1-0-9e7537bd2869@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD3n0GoC/x3MQQqDMBBG4avIrB0wogF7ldJFNH90QCYlEW0R7
 25w+S3eOykjCTK9qpMSdskStcDUFU2L0xksvpjaprWmMT3nQ6MHe+yscZPw59GtTicwbOhtGAf
 X2YFK/00I8nve78913cqYpxFrAAAA
X-Change-ID: 20261015-swnode-dev-notify-balance-e6f56fb9a469
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1334;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=NHgIRIYeSxxBM4Z2O/FYMoXHETZQ8rwvjZE3GOfWUQc=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBq0OdGNQea/ZaQSE8NoGK5ssTDV3i6Yf8dWQp6K
 pyopKVXJwiJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCatDnRgAKCRAFnS7L/zaE
 w6x3D/4uzSSogfkEUqLZ2YYdjMOaAL7tIC5eATXPw7a/Wemsnjuwdv5Su5A9tLJXIKi5WY74Xeg
 95BMcLZR8h0F3aLL31c103khzaSKRvRqUo5EZHjjxVNiOwwu32B0khfs4gnD+ikiV3Tw5m0k2KW
 pzktdOuPz00z8akz6CAhuU5DwkFPIZXFeGEekgGZ2jJaF2oTnTUWQ7kod3JMbDCCsWScirMNWx8
 a9mCXPuZlgqAPvYZxS1rrBPkbjiXW5qbxbwz0k3JfmSIMi9dtunW4Aye5RDFDeXMVOAiCN4BQzT
 ciTcVp8j33yP6bT7XQpNvheuBYSiXtK2TDepKwXktsZxGa5e6rVNUnanFRogVpG1e1p7TqWle3P
 KhA6YfLPiLqRDSBnpAJeMeYMf8QjyBXSpLCawPbyHXBxxKgu55IEy7dlgGLqhtmCrb2DIDH9DhO
 vYyBtg1sHWDFvDxR+5nNYCFf2g3WepcqVybJAyl3mXwBlV3zmIyMjF6yAeYC8Uc0x9yXBK+XbAu
 /qf6NDR40SfsL4mJY51ylo1f7g6s+RHpGHY/CMa9ssAxYFeDKsv4rIZTw72LLXeRsICx/65Durt
 /pX6f/rfQxFr7614teLoIrqaSRA6FcCgjpAP3OAkBgAHsEL2hb+luTtDxCwItitOzMpZeTKC65Y
 zxwsOX1iKlAMNNw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA1OCBTYWx0ZWRfX27/58mapThIt
 vcDV54GBtAMBdBVglxDRTXGDf+QRS+uSf9XWvN8aC9yVspEnN1wSMR7uUU/UD5PSNVWbNhp/96B
 0GqmX+yJfMhdSKZN0L3JuPulNgF1HFKtAN/JHOiXwiBUQ/1hNs1z4992tuZf139+5LmtuGRP0x+
 /oikKTWKYLfr27SUk2mSDwaBT6eCDCjftvzooYDjlc4CBmzvL+lni5Gupql941ZZQ+qHwMKhpPi
 7YDrY7TNWTQLR3FpwtmNG1I9cSrXoZZp7TSRMYLnEdRAB8b+dXDF739IBTgHR7aR68QdTldRGOD
 XYbQvt25cfxfe0OPiQVlWksizwBvrrdVvxA7dxOBjc/monsQ1AabS69UX3atJofBe6cgGZRcTXy
 /oblV3K+0z5DNGot0s5yRxCpSEmoKTZEMIaP6ugzgpuLBdbHBn9DIDipD2t4ZiQhds/e/rtPK3S
 WFHtWfwNxPhVqKKpwGQ==
X-Proofpoint-GUID: TrPcUi7nr__PnHdRWeJErJ4MJDhACJ3D
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA1OCBTYWx0ZWRfX8GQCOPMrS+f6
 kFz9M20beFA0AlRyg2e6wkcHYoNTQC8NXgKTGCozmAPv+O1Ueo9GMSBwrTnZSPyx+IWyxZdS+XY
 h+lEYaOwYEF33p5+POYEObeUXkvCePI=
X-Authority-Analysis: v=2.4 cv=BqUIUoX5 c=1 sm=1 tr=0 ts=6ad0e755 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=kTkK-H-Q3wn9DOHkRvoA:9 a=QEXdDO2ut3YA:10 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-ORIG-GUID: TrPcUi7nr__PnHdRWeJErJ4MJDhACJ3D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 bulkscore=0 suspectscore=0
 clxscore=1011 malwarescore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610150058

Eduardo reported an issue with reference underflow when setting a
software node with set_secondary_fwnode() and then repeatedly destroying
and re-creating a device. This is caused by the fact that
software_node_notify() takes a reference to the software node which is
unconditionally dropped in software_node_notify_remove(). However the
software node can be assigned after device_add() so the latter should
only do it if it was bumped by the former.

This series proposes a fix in driver core. The first two patches extend
the device flag API with a new accessor and value. The third is the
actual fix in swnode.c and should be backported to stable (along the
first two as dependencies).

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
Bartosz Golaszewski (3):
      driver core: provide a test-and-clear device flag accessor
      driver core: provide new device flag - DEV_FLAG_SWNODE_NOTIFIER
      software node: fix unbalanced reference counting

 drivers/base/swnode.c  |  5 ++++-
 include/linux/device.h | 10 ++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)
---
base-commit: d419d682257d813f6cb7a28e42b35d0edf4ad038
change-id: 20261015-swnode-dev-notify-balance-e6f56fb9a469

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

