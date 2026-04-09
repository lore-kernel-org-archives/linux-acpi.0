Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD773DA5A0
	for <linux-acpi@vger.kernel.org>; Thu,  9 Apr 2026 14:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775743214; cv=none; b=kVcc4q/r8IEN97ri+Pz6nXzSgrn5cmqlUVhJ/RHwIu6YuyfCTjGNyWUgfBGhjipDAzOmTK4h2j1mXzyb/iSr2WweSqXdQpog4C2jBsWJ8gRooPyhmR2zujZ53+dCaerHsLwfnz3tTguS0qn8UJrs9/fEciM6T1Q8pQZgXUS22xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775743214; c=relaxed/simple;
	bh=SZcr7dFFx/HqG0JBLpYgsFWXkSiAbQ2w8LnHJcDf3+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BnmpJSm1Xz8/dPnrpS1QKRV22a1D3swhJKYeIKLMtzdNz3K8F874o0303v1Viny5//Tkv4TyBnrQ7pE0MI09XP8eIzDynyNCCk68DXXhsxOI806XvLF4y1omkidCU+fzmkcsVHDAqLHgZ2ybuA0HK0XYRPcyqo6RkI0rFABAUeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=erBFKGmE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=K0m47IL2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="erBFKGmE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="K0m47IL2"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 639AH9RR1727349
	for <linux-acpi@vger.kernel.org>; Thu, 9 Apr 2026 14:00:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	r31whLi7CQ0J1EL5aLItfX5SVplnR48JHc5fhjXLdz8=; b=erBFKGmEWFstHqVH
	W+0mQ9qVcsShfVKoVuUM2/XIIDXjGEZGaq1wseDsDNhqYDAWOoYTspdcZGmakeMc
	p4/jOnQiCMvqBQroyjl2ackELhwpZm7sauHLFo0v6qnsUTBlD9ReWbRbCYODKQsD
	5uJ5sGG0MRBi6IUhFR5bzJ32zA4Ce/WCTE/REqjikMFIFNxi80j96QR3ewbRTpky
	QGtLHuMyY/A6e/UFu5LtLZqH0WVrP7M9GMjRkQhT7XIdscqPGmUgSMBrv2jsO0Zf
	yuMUfyM9C3sn5jUXgrwThkfy+PHQbnXwM4Rdmz4eRnjAxG8uGfWthAs7lph6DAGt
	XPMYIA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ddwcrumhm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Thu, 09 Apr 2026 14:00:01 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50d76f460b2so3605621cf.2
        for <linux-acpi@vger.kernel.org>; Thu, 09 Apr 2026 07:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775743200; x=1776348000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r31whLi7CQ0J1EL5aLItfX5SVplnR48JHc5fhjXLdz8=;
        b=K0m47IL2ETGQ1CQtSDwgo/ARu7y10FzVOQfiyxKUjiUhreIM0tBKUrN4xXJ25KkJvy
         GxXh4oUXd08pZ1dLVXL91yhi7q/7jNXrkBy/L9aA9PIsh37kkuNk7RW7YRZOBfuBN4Z/
         ahhCsCAlRnwEdP7k3o4IDM1O1SA7UFPsGwumkNXYuIps3v8CGKhKLectiZP5h0ssV2X4
         v0qInsngvIn1yErc+RIZkUdUQyomz+LBuZo2m+XjRrYafY8GOHChYnfU6VgfwYRFmYEn
         ULkTyIaRgVHtl8OVnhlTezYlcydF5a/hoDiv1StIokx217xx8QCSpCZagWbV6SV8yPcI
         j6tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775743200; x=1776348000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r31whLi7CQ0J1EL5aLItfX5SVplnR48JHc5fhjXLdz8=;
        b=aF09N5fovXux74DEEpGCs/3JMK2cJ28NYX30RC0k7LaQn7xnh1rZa7Oso63fMB6uQa
         fYH09CJxNBSn76alpAabzbu+cJXaQGl+k2LlFXMml9oe0enKyxmqq8oyhkCNOEVapTfW
         w8T9Oq14958eKIEFpHDj/tiskja9Cl/zLZRnYWAueQJ6IWaAlISB6D2qw44hAxdH3i8q
         uXzwpyuyfBd0rR4ytW0q6XX6N3x9NfaSm4iguw/Ser34akwsDMKcfAtRE1jXTdD48Z8T
         zYS8RgiHIn+TPWGacZkP27ktnK//7k11kLvxn4R8NY1wm/EaJM93kFODBtTd81UwRUTr
         6jig==
X-Gm-Message-State: AOJu0Yw9oP7+S4IoYXpFrsNTS4uMTdJy5LkoCLv1v+yhBrDRoytcbmsa
	57jUd0ACAZ65KEM39NCHe0CA/03jeYuzcnWl4KvTmrojbyFIlPzHdzJd4lYOsyxix+gzfGWxgT7
	Ksj5dtS4UkxDkbyYHcSJWrBImJnP7khXmosXzJpprXIhNAi8b4dJN2pKaeP1xUTG1
X-Gm-Gg: AeBDieu3P6ZL2HnYBCBTOxHDTXYIdnRdcFMVOds87O/irqlpsCoZuBWuzS1ifbiZfOq
	RNA4Y8AlgPy808rY/6xY2tGGercYRrUwXW2upzwMX3RLK9dYRskJn5PO/GzKxKaamnv54SdtO4Y
	0KyiH1Ee5N/jtdwCzd8W8zk1h86s4URsPuZtyYAfTJQj0YJ9RjiVno8/7y4KFVMrixp01z1yfWS
	diYfkPBymtfzUICszAWiU5nR7LVsApPOXK1CXgkVsfqZbRSQBHOnloUungkHGkiuL5s70CN6Bcs
	0Dt87NcfyTGytzG8s8Mq5sAwjgoy18zzJH9oj5v2iWiywW3/g81jaqhmAw/ChSesF/yS3O0icVC
	He/SQl+ZTEp+cMc0qecrRqilsjwVZDuSRu3mCg6UY95/ScZK/rQ==
X-Received: by 2002:a05:622a:558b:b0:509:3098:819a with SMTP id d75a77b69052e-50dc22dd2a7mr55274481cf.44.1775743200027;
        Thu, 09 Apr 2026 07:00:00 -0700 (PDT)
X-Received: by 2002:a05:622a:558b:b0:509:3098:819a with SMTP id d75a77b69052e-50dc22dd2a7mr55273731cf.44.1775743199450;
        Thu, 09 Apr 2026 06:59:59 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:2346:762:14f4:8b01])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9d3ba180ffsm117373666b.35.2026.04.09.06.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 06:59:58 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
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
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Len Brown <lenb@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: linux-acpi@vger.kernel.org, driver-core@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, brgl@kernel.org
Subject: Re: (subset) [PATCH v4 0/2] driver core: make references to unregistered software nodes a special case
Date: Thu,  9 Apr 2026 15:59:55 +0200
Message-ID: <177574318973.111981.5466026181315933610.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260407-swnode-unreg-retcode-v4-0-1b2f0725eb9c@oss.qualcomm.com>
References: <20260407-swnode-unreg-retcode-v4-0-1b2f0725eb9c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDEyNyBTYWx0ZWRfX7NHPbjLJceqZ
 FulggGhbXFIv8IkUQw2wgZTYXcOEVAhTtRs4ZMy5WxGEcQkpO3HgzQwxAeKexu57D8UZLB5IDlC
 RYqWan8HgtiawCFgdkzvrSqurylUtRjlALi/lxsHjB6Oc2Wwib1+noYeguqVNk+7lO7JRC1w3Ia
 5SPtKC48rDgsDYDsTtAGijQIm0mug4wo8T1OcLnbbGNRILI0MyRUedCAE8rXKOTbU0+WHA2pMz9
 +KPKLRsxSf9qI36IgLw9mK/0eFauuKfjFtE2DtQBpJSsYj8+eVlk3ccaFo5+JoigCzmiFGXEprB
 k4GwEGgKubEqBouKdIJn349XxNpg9o88r54gVB6OsD3fheKk9Rp74kQjnUP1XngHdOsNumqgI6p
 ohmYPHH6SVu5iUQ7wNBjFMw8g2rsC+PlMlFLqNd0coAgJk8M92F10L08ZYPfq+4t3AKLw416StG
 AnqyG10tG0zj+N1OYwA==
X-Authority-Analysis: v=2.4 cv=SsWgLvO0 c=1 sm=1 tr=0 ts=69d7b0e1 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=-2faNgSI12pgEayDPOwA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: ueNQ6pYFxx39iU7_Rk3tvq54dV2qQj3X
X-Proofpoint-ORIG-GUID: ueNQ6pYFxx39iU7_Rk3tvq54dV2qQj3X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604090127


On Tue, 07 Apr 2026 15:27:56 +0200, Bartosz Golaszewski wrote:
> I spun this out of the bigger series (see: link to v2) in hopes that we
> can get it in for v7.1 and make follow-up development easier next cycle.
> 
> This series proposes to make unregistered software nodes (ones that have
> an address but which have not been passed to software_node_register()
> yet) a special case with its dedicated error number. This will allow
> subsystems to defer probe as if it was a firmware node not backed by
> a device yet.
> 
> [...]

Applied, thanks!

[2/2] gpio: swnode: defer probe on references to unregistered software nodes
      https://git.kernel.org/brgl/c/ca13ab654064fee86d6e7c9e87d0af7789561509

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
