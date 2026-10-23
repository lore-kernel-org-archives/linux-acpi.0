Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792750455;
	b=rZahDYMSqDeQbLoHMyEI/VSLErs2b2g8A1sAtmw3sXiCm+BJr/GraBWNPvma2qIT2gbl
	 6TUP0XuG8Az9VGQ7kgoeRGAUTzdR+/iOVIbVHpz3sn8EoW8jyrTvGMueXshJmGfaxLDLe
	 poWRwnyZ4x091IxIyYdnwS8jjd08IX1wnDY7GGSHXFh9L1DBN9rQZyg6v53YbdVOsT5uO
	 fc2ADSr4X31jnCtoEo9wdX1Hr7XCwgLQoshxxeeD3lZ1suNZY1njAqHzhfZkkfQFwok+q
	 /uh6et5oT4RmcyG/x8fqW07H2GEggmuF4WgxMlyzjKZUbgjctty/AeTdFdVOaaEAglg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792750455;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=HAeWxfZTcHlKlNt7pgixx+1a1cs5BFavajxZrxnqPSU=;
	b=SHhLxO5N69zYd8PcLGYW79CY6TC56HpTVPe9Fhazb8gJ/p2B80TNrpX6XpAAEgqx3Afh
	 UZqVGIVRPXEcBHor2Nmdf/KLwGf3sLs2RvyZpp0vabjvekD1LOhm907Ai8Bfp2LARiy4J
	 Gr+HDZWw4qdWQAveU4SQVLLMo+BCbGWE7gXzhEwUQ+BXAyImUHCFrXZDmSbbIZrQhgoca
	 XpN+I4MQ/15aVszF/ucIfrhbJXicxHT6pYc0G2XDSg83Te4ItExKRTCHR6Alp4Peni/K1
	 gTmU/Ybdvfeonk5syNVRnW/E+FjnCIB85iFwgIEwj+wVybmA4upswkvkldWFVLba0dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CKWpjrfU;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Nghnq4Ei;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D726606A31D
	for <linux-acpi@vger.kernel.org>; Fri, 23 Oct 2026 10:14:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D726606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CKWpjrfU;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Nghnq4Ei
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NAAYFb2489870
	for <linux-acpi@vger.kernel.org>; Fri, 23 Oct 2026 10:14:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=HAeWxfZTcHlKlNt7pgixx+
	1a1cs5BFavajxZrxnqPSU=; b=CKWpjrfU33uGEonVYMJy2m8zQoYRqjtB28+6Bj
	g+1KXTkF9M2PuBUL5aFsvI0pDLmtg3vgQU49/V8+QXimJjyn857YeRzv59i8pJkE
	mjJU7uWnhXy0YThoBbZqrpWZc/Ww/NZUnRnJphAhkNyYResyqVCitX9PxbYmJa9Y
	pZkky6Esoo/LHTUC3UMIEmuQdlsEXYMKuvrei9JVatBmC01d6YGINLv9TSwIEatZ
	p3O8hXl3dPE7OGeEhwDCjknZ4tBY7HPKO9zhwUH+i9rlBCMpdnp3/ntxD0rW7ZBu
	DmPGdqlUmVk8tADOMhNyYzRAeiTI4uWpSNP4KARUA3TlGPTQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hftygact0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Fri, 23 Oct 2026 10:14:14 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93909014c85so132414785a.0
        for <linux-acpi@vger.kernel.org>; Fri, 23 Oct 2026 03:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792750453; x=1793355253; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=HAeWxfZTcHlKlNt7pgixx+1a1cs5BFavajxZrxnqPSU=;
        b=Nghnq4Eim8BXfzav67zzlUl1PlCoj6N/+OxEtEyTyhIJZHhpMZcpyKqbDanpltpuHT
         h0f1FNevNeGh5v1+mShP/ghsQy1Ckqj1vc23Q42EsOkVDs/6rMiD7hrvDKl2v3FcqEYf
         7MUDfjzIkJlg/DnFRa+1r8sPxjHRvk50wWFD1vxxov9S6LLwlAOChBRTxqIpMQxdOMT0
         /mzQGwgQOyakn5KmgIKm96XfAEEd1D3OFQ16Z2HCJHwUdNBKul2ss2BwwuGIWSgx7Xzf
         UO6kwh3SgMax2EHmhCh+aEP6Tga8K6XR1Zeygg4x8IB034DK3W+j58fQwJjSF145NGSm
         HP6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792750453; x=1793355253;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HAeWxfZTcHlKlNt7pgixx+1a1cs5BFavajxZrxnqPSU=;
        b=GY4I7Du1SF272+xYVk/dGBSRPmw6MUf7gPAnyvOJARqytbPzy43Y//JEY6cX4JENsm
         U4wujaGHFnuHi5uhkZAyxfxKAy9rQekPkDB0+o9CtCkbtfLhDHhSuuYM2S0iKDIt4ttV
         sEeuhS5s6KYqs0A5LHOvlsaxAorsibted162cJn3KkDsYjxig3kspMsZqf12x4eXxzRJ
         sPaHz0oIxs0WeNVttlW/e4anqr3NwEcdVOmPVxali7QbkPaCdtF+kBQNa19m46NnjJpw
         +yIC8JxBn9i10nW/K8uc5qmYip1cE5EqNmHIV2/rgRgZ6gh8AtaeC6ZqeskETBUJsaab
         uC4Q==
X-Forwarded-Encrypted: i=1; AKwUvBzU32GTTwb92gnkFTPw+fOSV0H9T2+SYLadN69hRv6z9agXFXDBpve8qa68zobT3RpV3hglXdL3a7No@vger.kernel.org
X-Gm-Message-State: AFq9FYIKhd1PisrbpJZbN7lIQ8v1xl+XXc2Ve/NJ/joNrQySpvHa/UjD
	h/xeUFYUw6ej5dLZivf7VHHmCNCVsduUr2FB1h/M+JGZBBGYKgjzzAA+Iy2pTsIZZzG45RYsrGR
	ED4QngZOTsGuXdLAGRIBa/pUr8tzmaYgERor90I9Wad+YtUzyDnhEKjUxMjC4qo07
X-Gm-Gg: AYBFou0vE6ZtGI1RaC18ZbryiOQWGtLzCcUUmvfeG/JGDFZfcukqK62VEX7bLTNfEHK
	8J2HzsQdpZZSzrfFXYdU87jtFlk8M0fQw1R6Y/3LmWuF3at+k3CCeR4yG9/17/vqNWi6sh4CikJ
	NhovOKHFQdB9KqS730/yv+ShkaXERYHhqOxSh8kajMARTbL7GUHutaHAhvPKicHUevWhM+HjzFq
	UoUKHIGMfS7xd8EAoN4krIvca08NjrTUZgm+n1+8Kr4abrYcET4YReYiYYc1MitW+otb6Nc/P+g
	Qswc0CywjbQ8lfVONmDBZkN25dgaNnEAQ39kZl+fp/Nbpio5z18TQi60DSz2Bgpx0ldMF6rduRh
	J9CBBywUeWxilj9o48XsIcgM2NkKP
X-Received: by 2002:a05:620a:3184:b0:93e:c12c:f11e with SMTP id af79cd13be357-93f6f858af6mr297885085a.74.1792750453247;
        Fri, 23 Oct 2026 03:14:13 -0700 (PDT)
X-Received: by 2002:a05:620a:3184:b0:93e:c12c:f11e with SMTP id af79cd13be357-93f6f858af6mr297883085a.74.1792750452772;
        Fri, 23 Oct 2026 03:14:12 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e38025da3sm4397734f8f.19.2026.10.23.03.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 03:14:11 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v2 0/3] driver core: fix unbalanced reference counting for
 software nodes
Date: Fri, 23 Oct 2026 12:14:02 +0200
Message-Id: <20261023-swnode-dev-notify-balance-v2-0-948d920a79f6@oss.qualcomm.com>
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGoz22oC/42NQQ6CMBREr0L+2k9olWJdeQ/DotBfaQKttlglh
 LtbOYGbSd4k82aFSMFShEuxQqBko/UuAz8U0A/K3Qmtzgy84oJVrMb4dl4Takro/GzNgp0ales
 JSZhamE6qk5CQ949Axn52963NPNg4+7DsV4n92n+siWGFkpr62HSan4W8+hjL50uNvZ+mMge02
 7Z9AYYbcyXJAAAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1509;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=zrXlaeL9N8MVODImAgm9MbC+6h+IDc0akesuGDJ2eXU=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBq2zNyFkupV32iqUVoj1WBjC+fBLY9RFjBnMFWC
 XW7VVu8Vn+JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCatszcgAKCRAFnS7L/zaE
 w4e7D/44N63Xe36AQO4g64J2DMWqXw7V7A/eBDcagvc/dCyMNtUYHxrEvKLuZW3OwXAGSyWpJ9+
 ToQpq8o8P4jTVf+oShFfgmltGLKb71rc3KnPF0Eixa3TxKVbWLlKqecWbmBjL0KFn/i8aQOxXZ4
 5+y737dQfpiRAf1RUfT8gTd5JFZCOpchju6GS/tAkQDKuk04Ztte1ET9v4oil3wQktCIhV7LDem
 0RX9ouvu73wGWP4d93EicSOFZDKToZZvqcCDi2F3FojSEhk10JdfftND3GLJcs4S5HWEI5hxUbv
 b1hqQi+BPw8vU4aUoaSI74F2Y0akErUIkpEUpwD9ujc6qUfwe2RBB4JPsDoeZStfGlIL+hrTsAK
 oowiEGDtT+9vE6ucK7NCdzqpM0sHR6DwjqLx2P9uEc61IeZz1Wju/sB4im7/dO4Qolp0WQvRjsy
 mBCz8eTMDyCx/JiFFpyNqRv5lcpSxATu6nRsoSH63r4zGl4zSep3QtXAd0D7hqDCGEljTRsaavW
 HdFYc7JXbxDY6rnQgvvA9cO1GlqWVuBa9IIjIvowjfiGNcXnQJDyeVlKFx/IJUIctzDtLGTCXpB
 dkCxyHzlmpIv4EQv4ai68iON+mnzmfSqIDchj9j8ZEmcXUryOHGUU0WVs+SgfBKOh3aRnPHXu/D
 JRQsYEL4jgCWBvA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=cZpHPXDM c=1 sm=1 tr=0 ts=6adb3376 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=kTkK-H-Q3wn9DOHkRvoA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAzOSBTYWx0ZWRfXwgwI2gSeIG/+
 q3/wCEYVoanzUi4pqw7AfK8shg9RRoFeLg2eXVHVtysFvLKeJHRT9248CfdRTD79ljZ4jCA8wG3
 UDATdXX708NPWRDH+X+q7OAmjz7a9MY=
X-Proofpoint-GUID: bUBXO1Royhy22xLAx_pV2FkEsvihvZBd
X-Proofpoint-ORIG-GUID: bUBXO1Royhy22xLAx_pV2FkEsvihvZBd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAzOSBTYWx0ZWRfX4iXm7ENpmdAR
 qnYkygUHVCiG4VSNwk1AnePfCGu+zLwgfQ+sxWI9euy1MyvJ9CQC78MIeqC22BX4Fv9oWlBz6py
 5z4yzwPZxyAFCNdYnkghYLaGQwiGiO7iyHE1VULfpQ9mdxkm6svsF9DQwlK9C/5nzeYQa0FZN6N
 u4T5t/wNURnXOj1krT8e7Z4E0RXsE7tqDfVR+iFIdb009X/pWwv/sItXK973w4ext9z9pKInW/u
 Ex7Jwty7NyiHtd+UkU8HiFovNYf7DnYHburlt1K0W/+I1j/zXp8FCFJBu6UFaUEoCETChi5TfQK
 sicIc5zijcoiBe6YTqGbh7EpbEFFz6krySi70oMlHpSJ2gK6FX2X2DWqEsABbDwj3HRNwGcNm5P
 ZMYRhhMWGqPNev7CpH7fwaX9dQRaolABWZV4X59gGt6PEI+nP2nSEvdZqVfrKsl/7tRdbe/7veY
 VDEfBoCcE4dn6tsAxMg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 clxscore=1015 spamscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230039

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
Changes in v2:
- Fix typo in kerneldoc for the new flag
- Link to v1: https://patch.msgid.link/20261015-swnode-dev-notify-balance-v1-0-9e7537bd2869@oss.qualcomm.com

---
Bartosz Golaszewski (3):
      driver core: provide a test-and-clear device flag accessor
      driver core: provide new device flag - DEV_FLAG_SWNODE_NOTIFIER
      software node: fix unbalanced reference counting

 drivers/base/swnode.c  |  5 ++++-
 include/linux/device.h | 10 ++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)
---
base-commit: bd1ecbb61afefc6a8b876ccbc31e9228b44e9eab
change-id: 20261015-swnode-dev-notify-balance-e6f56fb9a469

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

