Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9DE3BF69A
	for <linux-acpi@vger.kernel.org>; Wed, 27 May 2026 08:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779869044; cv=none; b=kzoga52HWqmQwDdGzFlQwl9AvCXWxUGJufCxHIeAzqB5n+V2vRWZk6TSrNDlCmrKUhKCsMpnuG0ja/E0s65w7pVE76bM/JNzUerA1fWlET5wRbJlRf28OIWihgfCmnofatgxNPR/ECFYsoTIinZAzPGtwlnMS71eaFJDhI4mI24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779869044; c=relaxed/simple;
	bh=ZGqZL845qyTXPK+tlB9pFfWL1VcdzPYHM7htCSoE4r0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NVVuXQKoYsoGj09Mfmbb9upKxIYq7+jk8G71eE5TUDaIMzspqk8IvpBZzEivTODR1he2AgUUcSEOGW4slbM1Tzt1ojq1sceGHs73BXAYeJOHBuxihK4kIunYuVM/lWImJLomBWA4LyEi5hhDi/kwNI1wsEshDnAMgrZL8ppBWno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z5csz6s3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Z6yowKH/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z5csz6s3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Z6yowKH/"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64R6G6mX1804278
	for <linux-acpi@vger.kernel.org>; Wed, 27 May 2026 08:04:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7MkxY5VHM+Gf4iGD+fZqDE7SlRll0D0csA8BjLC9/20=; b=Z5csz6s3ut2SvmjU
	fXVeJy8Lmi41Gg1aCF3w/dxNeYKrIN3/op2Sz3iZjBvmxXaTF1Bn/+5BRgeuU+ty
	jygZ4bViqwOwsD7V1eoa+O4IiPUFuGmMz3+z7RqSBdFjAWjFggdZelmGmWGc1bwk
	V5nKBThxTppHXJxI3B5v5wQAIUZaw/hjmLurvo6WBJVqDCS2kD2XkaxXBFZwZGCW
	s2qsfnL+u9JgY7DnuXhzH0TygVPZjjdWdQxPwDkRTfa7WvwprKwaLGQZt4zZ1aic
	dnBff+nwfXjZ4+nyUHzAcCeYiBhxXpFhGonEHCrRjHUMN8TSJo+1Xc25uA1GQo5Z
	xqlggg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4edu6rgcv0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Wed, 27 May 2026 08:04:02 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-516eaf9fb76so69765801cf.1
        for <linux-acpi@vger.kernel.org>; Wed, 27 May 2026 01:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779869041; x=1780473841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7MkxY5VHM+Gf4iGD+fZqDE7SlRll0D0csA8BjLC9/20=;
        b=Z6yowKH/d69RVgPidTjwvqqQpKzGRTcdvXy1ltKQtFp/K+exOyzgfv/BbPCtC9rMJ+
         4sNi+sfKXzcnaIveW0nMxSDKBkSN2m7Je3kM/ONtBYH0OWLfeyADiQc6pgxw0TQxed+R
         DLqbLcsrLY/zLSFTY3aHcp1OsJymRXxJQXUPQOdYfAZzMzanOA31cV4nKBX3fHYtbrLP
         MFpfUnUfKgJqyfp6dHsSH8wuijJI/C2V4r6Mia0Af58RUEgM+/fhJmFFdkYOPTB1NCPS
         IJd++DeTT98xi/smh5X6m3nLuoj/sO5+8b/TiZRLnQ8L5rH9bT8GZqWzqb5LtD6hNz/J
         AgOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779869041; x=1780473841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7MkxY5VHM+Gf4iGD+fZqDE7SlRll0D0csA8BjLC9/20=;
        b=S/SVEM5GxlXZbvSz4dVc1jfK4hsRCSqWNRyzYFfn5v7gu30ikbeVFSqBzAhYJPsYoi
         C688WEwHYW/ZnEyelf8/pzdQb7qqk4DyOEI+BFlpEV5AbcpDVWGKmBkoxdOMDQK+eFS7
         LZC0Kcpt1ZE2E4sOVTvXJ31HoBe8e4I4ocCCtmoP+kZ4XE47xCCMf7GXF98BbSXau6w0
         DuiTdaLnLivJhdSINCH5XH7VksKtrSm7ucSLxQs4t+IeWl7DyMnVOegThfY6TR1Vm9NR
         zLdkFkj03YWesgXkJs2B0YCxg2BbxcDL44pNa8LeI3vuzI8McrpCFhDV+bQxDNbDHr6d
         Ogkw==
X-Forwarded-Encrypted: i=1; AFNElJ9Tflgbil64PoEmBGqHqhsNtd1QfY6h6tQ/prlqnqrvjrPgZbY0CAbLNikHkjtY+xSutRkzgrHJwgUe@vger.kernel.org
X-Gm-Message-State: AOJu0YyC6JuGd8Hfmpq+VMCtQaq/52VEC7+gz2rWgtJN5lP8eBadSuSN
	E8R9xfS91MbtsQuWGUGr6LkEGxb0Hv0D3xGXrSBEC7lWPxle6mrtwi6AiiNSNC708g7K6dVMgWn
	8d88gLR7PUN2uosskvB0LPw82ZCYau4zO2QaGma/yXRPnoCgGnfRvAWNMabegAOya
X-Gm-Gg: Acq92OEr6IiyYgfr6L2NplMlsyhbvnOvzb7oRbB9CFg3vAjoqar9iXqpDdVo8/gl53h
	7UpeIkW4C7DXLgdFHA/ASasCHQ1ziG8xrOe5YKJyhQ+SDR6REp91EWKzcx0/wxgAQQk9upStfI1
	9D1Za1A0NzAJh24+6vDST7FYbNIQJxogO8eEP5/hu3ACVV3BzkB8FQKO77Smn/ZO9QXS3Lgwgmd
	SyWI+DozgSWgHgYYre/oh8CLjiNjBV4S4u4wTPVhIATURjvtIvTifjoBnBAthZAWHT1w48AAMYm
	6RnDF44p+HxqCtmpu/zZYCCY5RDUuyF5a/Jvva/d+3pBN9O1t2lF4BvaW5Ij+nk5aAZDt+Lhy4W
	k0EYav6zbrciZ3G1pSHcj/No2tVQa19drcscYvVSlKDL6YS4fDNKtE3z6Xi+amWMWATh5x1INCD
	DVrC75QLoJ63vgJSc6NjMGQUEuCKktWPLfSpuEBkI2R/LuPVM6xQ==
X-Received: by 2002:ac8:58d4:0:b0:50f:ccdd:13f1 with SMTP id d75a77b69052e-516d45b200cmr299429671cf.16.1779869041103;
        Wed, 27 May 2026 01:04:01 -0700 (PDT)
X-Received: by 2002:ac8:58d4:0:b0:50f:ccdd:13f1 with SMTP id d75a77b69052e-516d45b200cmr299429381cf.16.1779869040697;
        Wed, 27 May 2026 01:04:00 -0700 (PDT)
Received: from brgl-qcom.local (2a02-8440-e500-3194-8c70-1be9-4d87-8bf7.rev.sfr.net. [2a02:8440:e500:3194:8c70:1be9:4d87:8bf7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4904561a198sm371665135e9.10.2026.05.27.01.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 01:03:59 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
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
        Kevin Hilman <khilman@baylibre.com>, Arnd Bergmann <arnd@arndb.de>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: brgl@kernel.org, driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH v7 0/3] ARM: omap1: use real firmware node lookup for GPIOs on Nokia 770
Date: Wed, 27 May 2026 10:03:56 +0200
Message-ID: <177986887080.4201.14057302691715759454.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260430-nokia770-gpio-swnodes-v7-0-c88f74c90dd6@oss.qualcomm.com>
References: <20260430-nokia770-gpio-swnodes-v7-0-c88f74c90dd6@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=MoJiLWae c=1 sm=1 tr=0 ts=6a16a572 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=akhc-qRKS61dJtW-bLwA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDA3NiBTYWx0ZWRfX6a3jpcho3esY
 XsWUIm8ELjThTkP9KNk1Uftcz71q3P6q9z5E9lTR7BEuD2HUdfnJCY5n7kYV7QueXE9aqnW9e+3
 0s9/NY/i1zKV4MXjIiJBnFiDWAeM6kJaKzeYtutz4NY1tsT712k+KjjWa9qj7hdYTtggbZPzrdm
 1pl5fOnZ7nJeW3a1UUF47FpYNiMcJOCm8UTxjIZlmYJZ23Cz7AMZQT+Cj/yjRXolqvzppZOs1d4
 v6LbwWxHvFYUWF+d2VO9Z4KtvSHBjroSrin0RvNtuvlq/VSYzeTd3YfGmVIG0+OyeJeOoR+YXPf
 FGVfFXGgOuhY9H/yVkyzumVpsYmsl2Yd48PVmnDxEdn29Lg9JdIj3e+ete45mgef5768Wxr3IUf
 lSBhKoOpZxG8Ow4/y6lHispeJ6Ymr/BNlyrBs/ULUNnpvIJS+cDkdeb1AUEmYkVzBfTKXGPsmt3
 BZz4+rDYotmjU+9Ra7Q==
X-Proofpoint-GUID: g5ppO5LIKP4B_IcqXfeOgLc3vxCf14QW
X-Proofpoint-ORIG-GUID: g5ppO5LIKP4B_IcqXfeOgLc3vxCf14QW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_05,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 clxscore=1015 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605270076


On Thu, 30 Apr 2026 09:30:54 +0200, Bartosz Golaszewski wrote:
> This converts Nokia 770 to using real firmware node lookup for GPIOs by
> attaching the software nodes describing GPIO controllers to their target
> devices.
> 
> 

Kevin told me in person I can take this through the GPIO tree as it already
has all the Acks from Aaro and Janusz. I've queued it for v7.2.

[1/3] ARM: omap1: drop unused variable from omap16xx_gpio_init()
      https://git.kernel.org/brgl/c/3288e99f9968c37a8b654d5f4251382fe11bf854
[2/3] ARM: omap1: use platform_device_register_full() for GPIO devices on OMAP 16xx
      https://git.kernel.org/brgl/c/2bdf432e15818a81575e691e4ba0e3a3259d1711
[3/3] ARM: omap1: enable real software node lookup of GPIOs on Nokia 770
      https://git.kernel.org/brgl/c/61442e46fb9de57718a36f54c9ce1ce66ff7750b

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
