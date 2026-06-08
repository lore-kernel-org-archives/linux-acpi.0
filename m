Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CD72C2360
	for <linux-acpi@vger.kernel.org>; Mon,  8 Jun 2026 17:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780940133; cv=pass; b=PlKg7O2UFC9oxT84EmWwUrcy3UyUFy1KpoRY4BBL+7mx9+yJzOKIX5i0HWMFaHdNtqQlpwMddsYPMLufDuj+fwMPinQMiAHZCiBWdjJxvkcGBYcQ5caDA7z0S5nZdxkVZCBmcBw7zU4ttqlFcB2OkucqY7zPYnlZK3aYWV08wP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780940133; c=relaxed/simple;
	bh=mlZU0/pgW+ejL50FpauU5Ho0DNaF5PbUOlmB72X0Aj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iXn4XEfvs9yuugPKVYCIYhmDcnalIdaJjOH74PYo2bXjFb/kIyZdl+4zkJ64gWYYM6d/71FChynjw4Jgfa/4cJ0f56mG5np1lU3IOWOotJgGZZUGuSMoib320FxhtWQXdXfGoMMwWDJPlob4MeL/vY8CIYvLFbrheYcAY1gcQLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DvTb5UH8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JBgUFszh; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DvTb5UH8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JBgUFszh"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658FFWMr3524804
	for <linux-acpi@vger.kernel.org>; Mon, 8 Jun 2026 17:35:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=mlZU0/pgW+ejL50FpauU5Ho0DNaF5PbUOlmB72X0Aj8=; b=Dv
	Tb5UH8ccM2oDsgKng2asrIeWtqzQCmYGDd08K8abr6WXPMPSilYEE+fNjH9+wLqq
	uiUYbkNN+XYso/8c9e9dTT8mmXVUzailRpo/OSWzz98UFA75e27we0p9IDj0BdB8
	gVaQ40tm+xjpCx9t0vJ4I8I8a75dO3I65N0lSm+eRB+EOX187AbT5nPd/iDYJZIf
	69+ikXT9VQ2Z/1tUQSApeDZG8Xur1SXZVeyNlGqMD8jKoLCVez+1C4PIJPtnwueK
	M6KDdDAhla51X686JX4H4W8G1VlkgYrIhj7+qG3EI++/Ik8lKqC2GaRznlKgQ+Xa
	8ar8m/oRojBK9UhbvKWQ==
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com [209.85.128.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4entrktd7a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Mon, 08 Jun 2026 17:35:31 +0000 (GMT)
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-7e87d888ca0so28226457b3.0
        for <linux-acpi@vger.kernel.org>; Mon, 08 Jun 2026 10:35:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780940131; cv=none;
        d=google.com; s=arc-20240605;
        b=azvBA7BtRqnk2TK1ChyZIismAH/igWdiNKkJBsBvsUHplJ8gb/2Yo5PAlEbEFqdTFD
         no8MinUJYisVrTGG/e6/1SZ5YHfhF00VGtwtgQ7IE6lXWUm0Bjy7LLztXR8Uq0xZ6IZc
         mlJoYwpzozS0YVGmhrMKqAPd1U29HoIY13KlD3FpYvmw3UDLjZZtJFoVRSH+/TJa71T0
         zsDtAeqEw3edvLxr0VrOKX9/Iaa2/Kpv+CxS9vHm1Sz4BlYD71rjGNcuu9gOIPG5Nw6k
         p7LvWWyHB686JnO/xsY+YLZIvW0sRzazSBM9YwCn12puWBiYjGcmLvvwRkeaJ3aVejFh
         OfVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=mlZU0/pgW+ejL50FpauU5Ho0DNaF5PbUOlmB72X0Aj8=;
        fh=6oJxv21xCJeTME9rMAZFezk0jck804z09r9il7l/L2o=;
        b=j80ekKwMwH7Ibc6TKVvomdFwQdOBHii3+PSK0wMbp1bfxIlk2+juleYwAewceV129Z
         krp/6fqhAqVLrHrp+vXu0RFJgXZzIfdQ74qYSiTrICP+bLoqhZ/w2VfpZ6kw5z2wM24S
         HD+cNR4+YJOaIndVM8xq8Ceg2aRI4ZPrYW2LOsc7IJyoTDZNMHWFr2kvgh/L+5AA7YA9
         9U6lQLcUNT6U6vs9afHT2fNMG9ddOpAYFapAFZUkf5o9FqD1PG+dCpXo8pv6K4BsCqaD
         T5X7Ju9o9Zr9qIJRoYb+ujWdqAvkpPfrXyEq5K9ThUs5BNd5bJz6lrd7CDXNpX7YxbT/
         2+rA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780940131; x=1781544931; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mlZU0/pgW+ejL50FpauU5Ho0DNaF5PbUOlmB72X0Aj8=;
        b=JBgUFszhGK8uISAiVE93ZniRUhb028mcjf0h4kjT7i/gvBpPND+sgxWcp0Db26OMnY
         cGvu+6xynzZg9nCHYOTPyCOV7BDvSdNvBpMyQmgTpcoEFsn1Qvuttxa+e21zLsxWhQ62
         ZxiyuWs2yT8m8HWTth1qKQo93dx6vB07HGm/FP0e37dVsa/4M6Ry53k38J+AtDQmyAwB
         AZE8LP3UWQWRpRtw3O/XzlPuBgbFV9xU/EpAG/GCxAUOMe6XtJ2h/yCZDs78H2VIHcsj
         uKquY1XlgtP/RzW1M42CS3nN8tWhPeoKDTCZk4RlJxeg2CFFaayZGyV1OjBEynqGrCxX
         W3LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780940131; x=1781544931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mlZU0/pgW+ejL50FpauU5Ho0DNaF5PbUOlmB72X0Aj8=;
        b=nFpcTc2t1iqDsO23AJ/Bokq3hvq3NNihvQodWK5lM4NZB9qK45zYzkJT8k52JGi7Nr
         ztwJpH9nxLNesi7inH7UBpiXLMZuJ1AhPA515zOCu7ZOsJTSA1qrQ2aeuZOOFOI/jP25
         NQ5r0lz3SYWQTKU8n6B6fLH8O86AmuIUkU5/Lai0Yu7ax88XLDsolZMacavXOi1X+aYw
         qdn8wSvhmPeGFgyXQ61nBoBnnRD3Od4AypjB1F7KB9LhyqyNocZRzfp2SSAcWWe96Jaq
         Ym6D3ODDSKHyJ2DldUFckFarATHr1f6mdMRU78zgZmnFs36GAwnDE1pwIp4h6j8lmVhA
         88Fw==
X-Gm-Message-State: AOJu0Yz9R/bCZ5cnqXN2O6Y7vdpyf/ZhP+yRDOr3UziEij6F08YSeoKo
	MOObC3S44d6tuvingcCc0mb1eJkIqvH4vRfV59fzHjV6MpWDCTxGBAPNwKciiTYqq4wSKEQK63T
	5OfL0B4/aWnuVoa0i+JVhj1+WJjlml457HOqGeGcxpvy4pY4PupPW5hVgmphfYensXaag5JzqMB
	V5zZoipvnCZFSq4TITPohzwtHcWoDqfKZxATPmXs4=
X-Gm-Gg: Acq92OFhExsNZta67pH5LF9JbqPwqKDg6VENjO0RhjMSEcg9w56eSL7f66C1R71ZAsJ
	iPNGggDeY8kV13yZ4Dq1674DiIRwcppmSo+jOWrKU17V2DgDWWEZb6yZuGOPKZ+YBFwwcQJyNCd
	CKUzgX5LIWIDthS4Fk/StIbdxKSF09/7omQbWKGO/FpqILFQkeiL0qriviB7TQur9QIPsTAmaGA
	06D4vOnC7+oUE+0sA==
X-Received: by 2002:a05:690c:e3d2:b0:7dd:3f36:59d8 with SMTP id 00721157ae682-7ed0cfdfdcbmr158839397b3.13.1780940130888;
        Mon, 08 Jun 2026 10:35:30 -0700 (PDT)
X-Received: by 2002:a05:690c:e3d2:b0:7dd:3f36:59d8 with SMTP id
 00721157ae682-7ed0cfdfdcbmr158839047b3.13.1780940130520; Mon, 08 Jun 2026
 10:35:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAB19ukEzQZktJcBAXi8X2Pwz+hO_FcR+iiaK9nsCAumP9BrHnw@mail.gmail.com>
 <20260608142206426CGB5DlYd1xVlR8wrOawWH@zte.com.cn>
In-Reply-To: <20260608142206426CGB5DlYd1xVlR8wrOawWH@zte.com.cn>
Reply-To: sunilvl@oss.qualcomm.com
From: Sunil V L <sunilvl@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 23:05:17 +0530
X-Gm-Features: AVVi8CcOHTT-aaiAsTR3LDPlyvyK1Yv-Td6vF48uAWWN7KC86YUXl0j5J289Oso
Message-ID: <CAB19ukFMu1tW5QkCOY2e=DWbKrehEDv_iO5T7vEfKEGkbTFEEw@mail.gmail.com>
Subject: Re: [PATCH] iommu/riscv: Add dependency between iommu and devices
To: wang.yechao255@zte.com.cn
Cc: linux-acpi@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        sunilvl@ventanamicro.com, rafael@kernel.org, lenb@kernel.org,
        pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
        alex@ghiti.fr, tomasz.jeznach@linux.dev, anup.patel@oss.qualcomm.com,
        andrew.jones@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: D-aQzF_Lc5QsJeTzyop8O3bGHb979dzn
X-Authority-Analysis: v=2.4 cv=Z+3c2nRA c=1 sm=1 tr=0 ts=6a26fd63 cx=c_pps
 a=72HoHk1woDtn7btP4rdmlg==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=1RTuLK3dAAAA:8 a=90lprICnAGeg8zAacqkA:9
 a=QEXdDO2ut3YA:10 a=kA6IBgd4cpdPkAWqgNAz:22 a=kRpfLKi8w9umh8uBmg1i:22
X-Proofpoint-GUID: D-aQzF_Lc5QsJeTzyop8O3bGHb979dzn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDE2NSBTYWx0ZWRfX/2wHECM6pfuC
 dUadryQYXiCKxjGrEmZmvjlLDN2szJLkHxicHEgol4g4XF9i7HJkBjMx9n8ytI2wfa8bFOT2Qp1
 bQvwYlXq2ORARQc6vrsqtDlO96UbFeXZb6kBQu9hZaZ/XGAilMM1IJiN7isOcyGh2loaFzDLN8o
 sXYos1ZLm7xBhWNnObdwzYNwnhZYqy1u1q82G1kGT/Lj+qZU3OdxvJmA0sj1TXW3a4QAz+WYir4
 g+8NdoVlB5rJJdc9vXLkEvN/V35AyRiQaY1uHaPul9r7k8pVpQVEvoBCMzk+4QAi4e2Yovf4P3G
 jgeTzSRG1SXVW8ymq7YGYTub5SlPDvnOZjMQtrJkl83qWiakJ4zEV2NnPAm0TjEEMbGpD/HH9oz
 gaNi+T4YDrEoKeJ7WnFa3LAL8Cm+X67qNCx2nvTRB0xGn00HLEKmW6zDpEd8eLp9HivjeTU3GHk
 NgQvzlDl1pIMfpW0P9A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606080165

On Mon, Jun 8, 2026 at 11:52=E2=80=AFAM <wang.yechao255@zte.com.cn> wrote:
>
> > >
> > > From: Wang Yechao <wang.yechao255@zte.com.cn>
> > >
> > > Commit 9156585280f1 ("ACPI: RIMT: Add dependency between iommu and
> > > devices") adds the dependency between iommu and devices on ACPI
> > > systems. On devicetree systems, the incorrect removal order also
> > > occurs.
> > >
> > Interesting. Why is it not handled by the fw_devlink infrastructure in =
DT?
> >
> > Thanks,
> > Sunil
>
> Thank you. I have noticed that commit e149573b2f84 ("of: property: Add de=
vice
> link support for "iommu-map"") adds support for "iommu-map" to the device=
 link
> supplier bindings, so that probing of PCI devices can be deferred until a=
fter
> the IOMMU is available.
>
> The QEMU RISC-V virt machine currently lacks the "iommu-map" property for=
 the
> PCIe bus when the iommu-pci device is used, which leads to this issue. Th=
erefore,
> I believe the correct fix is to add the "iommu-map" property for PCIe in =
QEMU.
>
For PCI IOMMU, the dependency should be automatically taken care since iomm=
u
should always be the first device in the hierarchy and scanned first.
