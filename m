Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532CC3D955A
	for <linux-acpi@vger.kernel.org>; Mon, 20 Jul 2026 10:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784542509; cv=none; b=fC3Tpy0+BkepD3jbe1Hfz0w6LipeOdbMtDVFRWnyqqKczbz51jyJnPQTi+BJyKIafvsX4MWvgy/uTwRN7Q7ltZZYrjI/Cd3ipyepKD1FS7LB0ckZgiDGjoxwYbomJ0voUZKcPkVd+1AqZNIeoMGy681Y4dUYavgrcMRtlXbw/d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784542509; c=relaxed/simple;
	bh=cC/zmMj2BA27d70adCp6TV40MLwiZxOrTLBi3TyZkwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=npkyjTF0M8HNyziV+xanUo5s8brTs9bqCqQa8BfXhybPqTQGaBnI1XMEWHWN3/iNn3bYHne5buGVjxOLT48a7pNanHvVv9L8mQbrYuTxg2ui73sm4VibJxspJIMjd7O9eI9pqHs7XzqMnl6KgCDcp+C2Z8Rl1VoQzIVWU/4bTr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AWl9FDtf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jrYBx3o4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AWl9FDtf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jrYBx3o4"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66K9vTqq1941240
	for <linux-acpi@vger.kernel.org>; Mon, 20 Jul 2026 10:14:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YzASZJAIi+nZyqX50kjG+5tMwFSD3jcN0yYc8R+sHoQ=; b=AWl9FDtf4RJfvsGB
	B6mMGlEfvfkSHq6Cl+zOJjAKBvI4RhtELriKuJbrET8doA+hDgBqPRAlsQ4NPTbu
	K0br4iwyMFC/lo60DOsrDmq9V9YyfiJK5V40oXj5rNExPWK/DNAQ5XF1l6KdDjmR
	xt/Yn6wugVy9hd+KHlIc11ibCH2OoXXEz2pZQ/5cTbs5L1vSMSA5bO+9aJTmkX7O
	aVg+wNy60ysq/Dez8ApklyY5O1GrCF4thpz0UbsRhexVneJwBRMMRt+p2relHPbX
	0EIKolYqFoEw4YY4Q4Mz7g9vawLiGGsf4ZS+LYYDxPw89UE5uem1UxtHYzbEJL5U
	lXi0PA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhh5y04yx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Mon, 20 Jul 2026 10:14:59 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51a8db414c7so165484471cf.0
        for <linux-acpi@vger.kernel.org>; Mon, 20 Jul 2026 03:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784542498; x=1785147298; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YzASZJAIi+nZyqX50kjG+5tMwFSD3jcN0yYc8R+sHoQ=;
        b=jrYBx3o4MxQvPMpE8UzqD8kRA6H/DzItWThJO4NOpfPXotOrWOWTBdPAelxIILEezC
         s5rLOccGbleSCUvwAxO5qmTaXlRzNnBPhSo80ZsMhM1PnZ8ay1g9/TDSWRy+Xhh7DVWS
         /c0AYmMbLhrKBSkM84AUKDtoRqkzxft9ZMQbdNzfdtvk5cCnDN5/yXNFWygTUy4meVfs
         thDQTEY4MCZQNo0zG+VWVZ2/aOCL+LwWEgzOVKhyOdKQ1450deUdLIcFJvup7Vwnl4Hn
         7PJB6WmjSvedFPEZRVuy7iUj8ptz0Ni+LuJUUB5AKRvTQAr20564E9K4iy7Ht925Wl5/
         F12Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784542498; x=1785147298;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YzASZJAIi+nZyqX50kjG+5tMwFSD3jcN0yYc8R+sHoQ=;
        b=LqKfkkVJgFqDUiLgeYlVz6Yyzz7dk6DjNJ5jcUWnlC0Hk2fJ1fE9bRxBM+Rb7HbyQg
         CGXO2UJAsDLfoQ5txhf6iGPZbrLfhAxliillBqPiWH1MadoPoTngYjAI32kcT6KcH6Up
         uKMnfV/PTWoejAcdG9Y+RDNGLUYQ61Gy6goumU0g31ywUanEyGlqzA1NN0IRH4w1hbL1
         X35Sh92wtHQJCPhF4j2utp61X0QrfzLzP1ZKiRKSnIYkLRrbe0at15SjuK9yZtGt96da
         R1rFTBnPN9Ylgvo/bEJYN+wlYdor/FhVxfIklTCvlz9SPvMw8lDXYQU5kEcy8nsJiZKA
         gwaQ==
X-Forwarded-Encrypted: i=1; AHgh+Rog81zbV92jsTQWxkN8IJe3v2k89Hq4AS9BdITjmg0ORw5MV88EH/nydRc2eYD6cFyWlQtUd3c+Pmco@vger.kernel.org
X-Gm-Message-State: AOJu0YwOpFpjCQJ+hfwG4RfXJIovDxL7VYXt9RKLAFT+NaT+OzI6RkGm
	1T7Tc5h8nyRAFytE+MEW5+cPZDLb3jRreKoN6HRq6mgAVl4iJif4X5EQYbXNKuKtZnKby584vDm
	LvwDLnoXm9NQ9rgXJ3NYXI97SrQ7ZZR0RZnWVNnZoZK7o9KtA2Yk+GQz8ZNl6T6Vb
X-Gm-Gg: AfdE7ckWwEtnOiXZs7rwG8NCupyY9suVPnkcaU6JDEAc0xYr8ikyX9oMclq1y33ASGY
	41UlFga85v7Mq9cuUAmkfmq8LarJ6ieh2qsHv87qJiMBgnBfStaYtdqxvisK4XiQ7rMvlrWFo3X
	zBRsqPrENFKpGxXw4ze1eqGc6XiZPKq1zOZFeAZpPB7P+haIndIWuk8A8x2FIm2n825CzPVQbsS
	HK8LhThCEcNZ6/z/32+xIwadzac9Rg+JntMseNumifP/OlbZbVa+aPph2R24YATJeVxvV+YUaXx
	IsYf7BDV07WQhqZUcRCkOJn9Z5jGJ0uWxr8JKUdC76gnFsOHnkP/HWeUsRNAhXOGlZfjdViFUw/
	GocOgXj02MJ/s0aXrs7KgB6zIa3He
X-Received: by 2002:ac8:5845:0:b0:51c:c67:2042 with SMTP id d75a77b69052e-5213e77d7a2mr130027731cf.53.1784542498149;
        Mon, 20 Jul 2026 03:14:58 -0700 (PDT)
X-Received: by 2002:ac8:5845:0:b0:51c:c67:2042 with SMTP id d75a77b69052e-5213e77d7a2mr130027431cf.53.1784542497790;
        Mon, 20 Jul 2026 03:14:57 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:65fa:60cb:c205:d511])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f6fa848fcsm18620675f8f.0.2026.07.20.03.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 03:14:56 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-acpi@vger.kernel.org,
        driver-core@lists.linux.dev, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v5] gpio: kunit: add test cases verifying swnode devlink support
Date: Mon, 20 Jul 2026 12:14:53 +0200
Message-ID: <178454248867.23896.4781577626735793708.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260720-swnode-fw-devlink-v5-1-ec250ae6af91@oss.qualcomm.com>
References: <20260720-swnode-fw-devlink-v5-1-ec250ae6af91@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDExNCBTYWx0ZWRfX3hNnzB7prfz9
 z0eKmXudTCTSXCfmORDxbaYmtkPYlWRWAVUJfTFLEURUkmbuqyiR0aGSg0tQ6wNizSGunp0y2Ie
 swS8g390eJ4abqv1cUZC5FmvBXN2xsc=
X-Proofpoint-GUID: El4x78tWKpNzv7wtcRHjyMYWmu5PBkyW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDExNCBTYWx0ZWRfX0dhy5lv3O3c/
 Nc0eu4LvJM+Xt9LOB/iRHKUJBISYoBrdafti343vud1gDxqj6cosKvLkBMn3DPLMREvTVbYnDmx
 tfwnwERkRQgils9z3snjboKAPkltL8Hk0rubj/0SV4MwZ7Y1D7PVfhcU4EYExDfAfIRHpb9jK3w
 Oc+h2GX/8NDGEJ1pC/O6sHlt4uQ5S8x/rPNG/byXL248ErbY8iTvpgEcZYChkZm753R5JihBsYW
 XyQEZC6xp9qUlnBpC2bqagvJPZnkvYnWi6rofiCVUBPwCZYJj5LeUhGCNn0ZIHKRdurRsJJANA2
 I7CR07+73duiMIORwn9LvmC4yyKr4w7XfMqwjmts+EsS+QqxOgHVTxuPnlI5SnSeTukUNPiJxvb
 4kDOsTEXoWvlfz+/51j2Nxq2WoLNNn0smYOgTydduGxAb0IomAA5rB/q6T3xr/NTmT9H+W0lEId
 CSqXT6+KiKoKWdZs0wQ==
X-Proofpoint-ORIG-GUID: El4x78tWKpNzv7wtcRHjyMYWmu5PBkyW
X-Authority-Analysis: v=2.4 cv=f/x4wuyM c=1 sm=1 tr=0 ts=6a5df523 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=N-8F-g_hktDZAXegwvoA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_02,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200114


On Mon, 20 Jul 2026 10:15:31 +0200, Bartosz Golaszewski wrote:
> The software node fw_devlink support already has its own kunit suite, but
> that verifies the fwnode links in isolation. Add GPIO tests that prove
> the ordering works in a real-life use-case: a GPIO consumer that
> references its provider via a software node.
> 
> The first suite registers the provider's software node, adds the consumer
> device first and checks that fw_devlink defers its probe until the
> provider has been added and bound. The second covers the fallback:
> with the provider's software node not yet registered no supplier link is
> created, so the consumer probes, devm_gpiod_get() returns -EPROBE_DEFER
> and the consumer only binds once the provider shows up.
> 
> [...]

Applied, thanks!

[1/1] gpio: kunit: add test cases verifying swnode devlink support
      https://git.kernel.org/brgl/c/9672edf75bc7ba3fb5b7d529936548de38b5908e

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
