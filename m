Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1F43161BE
	for <linux-acpi@vger.kernel.org>; Thu, 21 May 2026 08:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779353400; cv=none; b=OBRHu0gOauGZkeKP3Z/Vg6d/xqcbWbZ8TtWDzvQehyVOj1XT19gyJlJK/5troucwYzyJBaQZ3PvOTAgU6YbmWOHB5V/WFGLA653n/XDl3yDdC0ndoFOX48sXc48Y7wgS+HymlJgiii92Dor3ZKl4YwwKZqa2KMnkU60xQdhBa9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779353400; c=relaxed/simple;
	bh=WCZvhCtju2ALnNkB/dyRi/nnFp8xIIOr0dEsissD+fk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=szUt3sV1Uaj78Z70VxbzXtBT5oo49oUPzDiI09CQz0p2iHZwgu9DGhDpt7z9UByHNpX3BxGzlnF6bzkZXFNnAteWzcUHejRgdo9qPjUx4ip0tzJLjw8Y+Dt1dQv0Rqr6VTBKM6/uAIEmejy0nAk9To52/xb+IwHPooJEfOEYY/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kCun69/M; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=d1FutHMZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kCun69/M";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d1FutHMZ"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L6Afl92157876
	for <linux-acpi@vger.kernel.org>; Thu, 21 May 2026 08:49:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	e+eyYGxzLV0DgLeMRlYrMnVQl0ZZxnZ3h2lIptTAZys=; b=kCun69/Mp0PJRves
	Lau8l5tDEHendJ5/prEBN5XRB8asHhY61z2NVCIcD3rEDnotEQTvpXpdwxXBf5/Q
	gbcpVblnCwjHXSZpHHCypUWK1Dv+2PV4dWiloFUa5EVzKxbr8tu9RG0wsWyWgYZU
	gGBngjuPSFiCS0QArvh1ZX44+/NGUxjzv2LBBZ2Cz21fW7WYPCk0OzNmos8SmVXZ
	5995lZGnYKzFU/lqIzE5G6EF4rwxuv+0ffCn4QiGorlxY0cpfUGEXf3kOBEeZh5p
	JYUt/+P9VLUbjtSKEce7Z4NfhmJdM9QxGTH4ztwgcvOh2NP+4d4cP0X/weHhtDDy
	y+B3ig==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9ma42anu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Thu, 21 May 2026 08:49:58 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50d5d1c2289so172963541cf.2
        for <linux-acpi@vger.kernel.org>; Thu, 21 May 2026 01:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779353398; x=1779958198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e+eyYGxzLV0DgLeMRlYrMnVQl0ZZxnZ3h2lIptTAZys=;
        b=d1FutHMZDmjfS6L9w7a9QQtCzeXbbGWlnUaJzPUuyM4vBs687ATjg4na98hw11ZIXa
         gKam8EFbJf/sknzBDtE8uRTteFsHUbfgSBEjyxfjg3jcXMy+atM0K9Xck2iDEDdw641v
         YdDHiANdAIis6HEx27dQpXo/eWKee0Lufqe02UrMUmyKO8RmwGqvXo2MNQEr31M2ZUN+
         O8LtE04+15L7qrUFwfaADGcWMYVnUJzCZbQ/ES3R/KQVw49K4JGArWmwTEMVlF4gWV5T
         xc6aqYvZlfUoTq3x2J5BdbfKyt3GIl81CDsgT3ICgDthI9Dt6McgFJfyZok91EK9/ATq
         PdCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779353398; x=1779958198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e+eyYGxzLV0DgLeMRlYrMnVQl0ZZxnZ3h2lIptTAZys=;
        b=a7VX4URqlHUzdptjBC5C56ds8ZpiqLtlUi8w9tAK4Rq1nYGNOfXR3YW5YSuUihpAAo
         nfsFwvZIClQDrPJ/BX/ksXajr+KLdzbhBgZf4NM5xQDHExkqdBTFIQPtjyLfCsgFiTw0
         G25q9y+9TMb8cQ7jIyCnbIWveyShpj7CwnWfxbnEzqcsv/ajIGeBDSlXX+/IrQmoqDwC
         xbHXaAMKyttJXlIjZ5sDkwa6bM/BidC5DQOWlenAuMTbMvXXlcsjH5/JAt0klaoMLtna
         JYMQPkCqP0Znbjr4ZmMZwy7CJT/0LssKkXeefLp1NkiYwPvgXokb0gokVxWgNXrnIea7
         m7tg==
X-Forwarded-Encrypted: i=1; AFNElJ/7AQb7drRfPZUo8YQ/60S/tPccWlMZqq1ZW9zafQSdRpxZsoHAU4W02FTvBD0BAbGrvdfryUxAWhJd@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsb6LdSS/SeONQ3Lt8Bw1qBXK+m1X5EBfVdJNLETQEKnB/jATB
	1qlZWrjNPhbVPvIdbL75jvSIXceS7r6vYsNlHFsr6vmZlKu1pL10y7Gau0bFXPHydbTnXBeDcv2
	C1najok2X8TFarsiY8IwaHfCotiPg5H7aMJaCZxUuwDqSI4ypC7Nz1nNt+JmusGcg
X-Gm-Gg: Acq92OEMJ39+VrAjC5ErKeM6hRYwtSIuvJ2DF+DZVXY5riPArGdqflXEjxvdZXuHX6g
	kMY+eD6pkf0WtqQM5PaK8oLPgPpevGeRvK4U0JfWFq/Zy8clESLnWdiI0qNtIyxdFz+bLlTyyZQ
	HraMybZnBaar9Pxbf0tSM6s1t0Jf3on0jLJ659cyPGq4SEa08wjWw2V7x+QL4YMVGjbvN/mrvJl
	3JO2gZYXef+ZfmFSQge58iJMXpDN0GBuwOqj/M2tMSJH3T/syqbEubFgrTqm0nY9fi4hViQlvqo
	Bz8aGleoZehVZM3kG9PMlCZuo90P3xhjaGkIcgsmPbdMJ4wk8+M0URwYENizIbxb9kSKnhWHoYA
	P106hg2wDNmoMzcLIHibiq9ykjSQBuCWkpGt5IpMsJ7GX0NCw3A==
X-Received: by 2002:ac8:5dd0:0:b0:510:1543:31eb with SMTP id d75a77b69052e-516c560ae9emr22797301cf.53.1779353397801;
        Thu, 21 May 2026 01:49:57 -0700 (PDT)
X-Received: by 2002:ac8:5dd0:0:b0:510:1543:31eb with SMTP id d75a77b69052e-516c560ae9emr22797071cf.53.1779353397341;
        Thu, 21 May 2026 01:49:57 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:bb10:ae82:b7c3:d15a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4903cadc03esm9295345e9.9.2026.05.21.01.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 01:49:56 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Hoan Tran <hoan@os.amperecomputing.com>, Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Thomas Lin <thomas_lin@lecomputing.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-spi@vger.kernel.org,
        braden_zhang@lecomputing.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: (subset) [PATCH 0/2] Subject: [PATCH v5 0/2] arm64: Add LECARC ACPI IDs for DesignWare GPIO, SPI
Date: Thu, 21 May 2026 10:49:55 +0200
Message-ID: <177935339258.17744.11531359965950896952.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260521-lecarc-acpi-ids-v1-0-ae0ae90b2817@lecomputing.com>
References: <20260521-lecarc-acpi-ids-v1-0-ae0ae90b2817@lecomputing.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=K9kS2SWI c=1 sm=1 tr=0 ts=6a0ec736 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=XCN6OSF3ifbBXE_oKz8A:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: 6Fui-Jx38TnNvmFsaJIZJctk8xjwtJ2V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA4NiBTYWx0ZWRfX+4DxgyAHdNEt
 rwCfr31hNHaIcO7VIV/yp0rmirfpc4wlgg1sveUFaYJu6sNy6LLy6s+HH92lXtYywSoUMVrvnMA
 +dPOc1c5FBdkjFKub6YNGd4329EikfXPZkaogYCaPRDySZorxXpUpBR1DStlGYRU8VlZQ30wQ8X
 X9/haOIFIxODf8cnA4LsH4LES40bLfbjPqUzi8LjabW1yTPl7uP9bcUZeIBXQgy3wEtn5qs6+3A
 gUtG1tI/DLj5pgYnwTCM2y8K0QZuLrLpjjKyjbJ1edfkxTiR6Y7TTgU4uT/7DGbNEAyCDoYGfI3
 B0RH6qRJ/RfdAiLhdfjo1sdRCMH8G2JHJ6cvVoCEx4RTCHP8OOn43doDywQtDUNSSweDTNvDxRs
 wZJD009xctT3fnR2hhEIMHIx/bXltRZ8DAePEaphu4qHUkMOjkUBCtIY1v4YBz4IzpevqcPJ7e3
 +vVfi/s59SqbNLlnj2A==
X-Proofpoint-ORIG-GUID: 6Fui-Jx38TnNvmFsaJIZJctk8xjwtJ2V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210086


On Thu, 21 May 2026 10:34:48 +0800, Thomas Lin wrote:
> This patch series adds ACPI identification for LECARC SoCs that
> integrate Synopsys DesignWare peripherals.
> 
> LECARC platforms use the following ACPI HIDs:
> 
> GPIO: LECA0001 (V1 register offsets)
> 
> [...]

Applied, thanks!

[1/2] gpio: dwapb: Add ACPI ID LECA0001 for LECARC SoCs
      https://git.kernel.org/brgl/c/d01bf517cbbd5a4b0c16ba2d5107bda0e361b00c

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
