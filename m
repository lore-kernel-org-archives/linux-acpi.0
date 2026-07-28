Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56607448B95
	for <linux-acpi@vger.kernel.org>; Tue, 28 Jul 2026 14:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785247660; cv=none; b=TH2FHO9nR9VKdqTlswsJrCtekvqeZk87WPW4x4wBedBsEOXEdVnCIBthKgRemwZGgd8VQ9nZ6FNsmg4L1Om2wJyWtZPJzzM3BnqqVmGpMzJM+AWmXWSAv/pVfsysS2hi8UhsV7NzRo9Mhdlp2Yo8NUjxia+ltHK9S1gdfI4k4wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785247660; c=relaxed/simple;
	bh=609zGTHd2sXvyAIn/6xwzneEt26Mg2SLydEgvviJjaU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X9LhkQXMs6lbH+Uv05cwvC9G6fYI2Yc2kQNzBWioGfsRXoU/cAaNzykzjeBbg4rq7KTQQvgNuskCE7MlO6b6n8BQlKxln1WnYRDlQU3nNGZUHytfUJR0krStXT4j3yuhfihWBG0VpLFg3EYZKMPKYfg2m6sDxmEBcowz3fqoLDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aqZCTTBD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AgT8IkTg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aqZCTTBD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AgT8IkTg"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66SDPJ8J3112316
	for <linux-acpi@vger.kernel.org>; Tue, 28 Jul 2026 14:07:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MLk3uWuhIbtTq5azyeYc0c82fp77L8vjc/P1AiWnxX0=; b=aqZCTTBDuzXa5nI4
	d+RCnoJV+TSWm+CXJPGv1+b4QxJ4w6WVfFCq6PdSCX0ku4QbqdLGrhn4fnJh4vDs
	HiONHu7rCXDYAPKKXip33oV17u69Y4AfwxJmm02sdWH1kyazM0eHEZP+e9tjfeJB
	3CJ3QuPgoAO6/sfY6sdtyc+zHl6gp7ki2GpDhmaq3RuXxmcd2ZM9q+JlqiBwFlGP
	+wPHbW7yvuNC4Udm+gCK56xWbAa3gTDFaFTZl+KFszIJFKdFmJFeZwyUlG+352Z2
	giNnX/O++W1l/+l5CClhdzigMn8gY40I2KNvKgwrhxlblbFctXcZFZ/SaWQ8jFQK
	IZnuoQ==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpn3y2c2c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Tue, 28 Jul 2026 14:07:38 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-5c2ae99be7eso736311e0c.0
        for <linux-acpi@vger.kernel.org>; Tue, 28 Jul 2026 07:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785247657; x=1785852457; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MLk3uWuhIbtTq5azyeYc0c82fp77L8vjc/P1AiWnxX0=;
        b=AgT8IkTg5DOo0TpCuUpqAZLxIIPzphGeGja4fj8XULFeSwChzSMrW49hj+Y6HoU5wd
         qmySlYGkHLQjY82SX8+N6BlkPaJ+NP3QOLVP2OB65TljDvS0blgURdnb2GGENR8cSo7i
         wrZJxvjClJdYn0YhDYr8ngCvz/MCxflZeZQHKf11WM/eXIyxXSCRfrmqcgdlHIZnKX5r
         F1Izdvmqd3S42tPaHT/H9BCPJoAMXCFiV4PHUI1dzZihEyVzfk0JxmonUUYnabw7H+VJ
         FOKORd3uGaB+CUWwDuTzIYMux/AUKNMws0sya2UAAbkfJhp6QfVd2I60OMZvFf2BvHsf
         QAVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785247657; x=1785852457;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MLk3uWuhIbtTq5azyeYc0c82fp77L8vjc/P1AiWnxX0=;
        b=f6pUacWvstEfJwNHCDxy3O2R+45TnwD3DVosxczGZkjD3lqOROS6Bm+VDmDMeq2Kgu
         kmbFwfqlbHLpt85kYBm9THr0GjwIIu44k1yvvGdBjZWoE2BmeUKzwT8YiH2GY3iINoU/
         2UvN9QabS4RP7/mYPTzS66IaHfTMZPuaAQZTK+IOeX/rDeMwZUKogPzt2aYzRueTStGA
         Q5wGDYZAOX7qUHD7SMB1HBruCYLjqEfb6wIZcIshcYdDTxBEzIFKbXPh/R/eea4wo459
         +PAM0KJjobLam76YnyNwENJQ1wFPMSWn+Zq5SRKvJJS6iwIEarOwxIs+G0vdQ6q+adV9
         WK7A==
X-Forwarded-Encrypted: i=1; AHgh+RqXb1Pz0XVfDW8778MOAvklBu9EdegAgz0rzGJASAir9DICJVhihFiJA8dUZgehA/peRrGLSo2WBHJe@vger.kernel.org
X-Gm-Message-State: AOJu0YwZOezlcu9wWVvu7StrSCb/LLgEp1rDqeFlzheAT/9tL8V2Qlze
	dC3d9jqlgKqC9jRWgRfD6gYdtH1H+zlkh/mkPqvuTS2u3K/WBEMfDGfjrWjG+H3Y7tjl4mmU0xZ
	MxLJvWzTByM3NBx/W7XewU6Y3fQX8aOBOwWVfYiSYrG23baFJUT43InVmt6/HsP4N
X-Gm-Gg: AR+sD13qd3paCjpL+oh5RIYwG4/ihQq94kcWR2lHqje0JuJ0Qutd5tn/qkw/hzoksWr
	Tep0CoKcAwqUktmQnx9BmcGzWlArgOopeTdI9B2B2G1kUi4H8ykoKOeLS1DW8ZxOVwl3TsdKYPq
	oEWmkMSVqOWNzUFFOzoYCr024881uoxvJIAMGsPXM/1OPX6ADdEkovVXHms50A+PvN1osgPKnFn
	ABnxiIpeay5ZoxNpOXIBS3OTAGZlzqjAQSOfJL+oC8dXtXExr2N0plQ56v9Q5Z8Irh+uOHBr4Ar
	PuUhCVRQ3Doys5t5V2xeASm/NQj/V0KR+QalTy0TiO9Kfbnx6feO34/Efa9WTvMRXLwotZ5uTVh
	ovrcUzx7So/t6hb2qpHRDdSl4ybfKVQ==
X-Received: by 2002:a05:6122:da1:b0:5a4:ac74:f5ba with SMTP id 71dfb90a1353d-5c33fa0ee4dmr1011777e0c.11.1785247657384;
        Tue, 28 Jul 2026 07:07:37 -0700 (PDT)
X-Received: by 2002:a05:6122:da1:b0:5a4:ac74:f5ba with SMTP id 71dfb90a1353d-5c33fa0ee4dmr1011727e0c.11.1785247656815;
        Tue, 28 Jul 2026 07:07:36 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:d2e3:b407:476e:c977])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496c44a9451sm91612285e9.1.2026.07.28.07.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 07:07:35 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Tue, 28 Jul 2026 16:07:17 +0200
Subject: [PATCH 2/2] ACPI/IORT: use platform_device_set_fwnode()
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-acpi-arm64-pdev-set-fwnode-v1-2-b5aff9b2235a@oss.qualcomm.com>
References: <20260728-acpi-arm64-pdev-set-fwnode-v1-0-b5aff9b2235a@oss.qualcomm.com>
In-Reply-To: <20260728-acpi-arm64-pdev-set-fwnode-v1-0-b5aff9b2235a@oss.qualcomm.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: brgl@kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1091;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=609zGTHd2sXvyAIn/6xwzneEt26Mg2SLydEgvviJjaU=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqaLehTkYFSP92zuLtM/89zK0mw5GmTQ28kuEfS
 xESnjLd+/6JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCami3oQAKCRAFnS7L/zaE
 wwTZEACeYztdijfheHFs7GiXVPTB5Jlq26VbGxt+9MbRmjkwETqWTHDHXMVAeFVW8mLVcE1L3vS
 fDxh3NeTUya2clrg7SJxv0oJgboCtvEGv1snqQvwogBgZEmFKkBrnPK+6pMb0/gRTdKSooucict
 q0oOmzUms/fvnBRFwltwRNuh97N4sxGayfkc4zP0Ucaxa6wIUWmHNaW8QsfutOjQp8KBUorHX7Y
 sU1xFBh0Sd9izaT78U5WOketF+rwuBSpiRt0m8VOhIpWl5tyUJ9Jc3vl3DNgi0TLdhk9O1vAE3K
 KYa2ftyCoySAeewRKZIWaY0xAn6RNVoxt2XyicqacX6MP1vLv13cqTO5df4/OXUFotM50dhqsVP
 UiH/e4W2DZUiB3ipNFzKEnw3xvAuyxha2uQvIl96TOyr4p3UB7PjemdELsxLsgM30Imj2mkZ5DS
 nHPb+g85+ZsSrp4mqQL9IO0pc0kottYJzwVUTf++MnGK/vpgHRCk9aXQlhrh7U4cBVVXtqvXqEK
 IX2AGUqHbg+qMY59IjRKVCO00xuT1HhwqSvO562S40YKA4T9YLDJwpk3wI9h+fjjfTowMgIVsJH
 KzNZk+PIpj51XpzQzH9AeeuhR8TJHldmAoF2BLiHRiRQ5A0pn+MnEq5ggXZci95zxE+SSDeV+Xc
 Mc25f7+xftApDnw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=fbidDUQF c=1 sm=1 tr=0 ts=6a68b7aa cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=fqL1emIZdJcgNPYfUqkA:9 a=QEXdDO2ut3YA:10 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDEyNSBTYWx0ZWRfX8AJyduDTmBMx
 H4wZfqQbEiBaVWShJ2DdNhsQbcgpIS8zjSPHwsJTVXbvJ+lv58CiTMlqMiyuM5tOuWG6E3P6UUs
 0dMrN1hQIJm+dTzOxfmZtdheA8R3CNA=
X-Proofpoint-ORIG-GUID: -aT_r0ia7XD1NRz6mxa8xhWioS5HXYmk
X-Proofpoint-GUID: -aT_r0ia7XD1NRz6mxa8xhWioS5HXYmk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDEyNSBTYWx0ZWRfX5Q/CBVciCF9T
 FTGVqZcMrSJqsJHKBdAZpG7PHx8arPDeNaRBrFTzVxjDSaur8CtcKuGBta5zzqDzFH1TdfS4M68
 SwxOkqscYE7A3Jsz88pBXWfXbG9mFFpJq0qKeEjLFiqEB9jfzT2vjKOVaU42cTHTEtTkGvIh47H
 LcU9y8sFC+Waug0g+rXXFVAVZDKN1BB3HO7ZdIJjVh6FcgZDoLGjL6LmQrqGsDaybTMrRoYGnPB
 hdWhHoxLg4bmz7KKG7GEe3jDXfsaebS4T1y3bmNsMv9qMOVupzQZDORWP+qNpRbW6SCb8727N4m
 qoYvuF73HAAeOGv3YweTyp/p094qo9Gbq1By/O4Ki1GQHWaerTmgu189smT4SNjJDvmyIK3/MMa
 SIdsN/8s+uRVO6kOnaw/s5EjGNi9RKmEoHobeRsd9oa8Z48ngp4/SGV/2K4/JKPW6Hru4Dhc4f4
 7Woyc+vefgfkZiJxIpw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_03,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280125

Platform devices using the split approach of calling
platform_device_alloc() and platform_device_add() must not assign the
firmware nodes manually but use the provided
platform_device_set_fwnode() function which additionally makes sure we
track the reference count of the firmware node correctly.

Replace the manual assignment of the firmware node with a call to
platform_device_set_fwnode().

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/acpi/arm64/iort.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 34412cd697d8bdc3654c40ca539ddc695a926a26..1020ac953e428797b5b90bd73c6c6ae35e6fd352 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -1992,7 +1992,7 @@ static int __init iort_add_platform_device(struct acpi_iort_node *node,
 		goto dev_put;
 	}
 
-	pdev->dev.fwnode = fwnode;
+	platform_device_set_fwnode(pdev, fwnode);
 
 	if (ops->dev_dma_configure)
 		ops->dev_dma_configure(&pdev->dev, node);

-- 
2.47.3

