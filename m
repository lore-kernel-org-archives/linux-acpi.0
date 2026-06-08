Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835DA34A791
	for <linux-acpi@vger.kernel.org>; Mon,  8 Jun 2026 16:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780935884; cv=pass; b=hKH6BazwFjq8UM1IbDYMsjbMk9FN1p5WIA+VN43Q2QHzQSeaJVV3QyML5q2VUQwP6lNEcftAdS8wPLRvcv9if9E7UnzJ9+pj997MBs6wvVlIJ1Tyb/M6vJKs0AVXvUTvKWP53zsfINQ5z/n65H5YSQD5Zr/5xg5pWZZrMdUt/go=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780935884; c=relaxed/simple;
	bh=LHtZeQs0Tz+U0h0N9Ycucp24b8vvsudRGqoVRlKP4lY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W2mlWMwv+GAIzMjcztOcXF5vomTGIc9ZWZ6QuHVUdk37I+iNvd/pF+MkCKS/Xilgnybw0xs3jFI4CvqzC3B4Mt1Io0owoRHFozx28OcryB0INjBlFxAin4xji/qd+07/SkPqQanEOEOD7T3XPQbF6uNAi9ESr5K5nIiVLmQKGOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CIoqh3I7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=K+HdWOm4; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CIoqh3I7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="K+HdWOm4"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658FFYCE3524832
	for <linux-acpi@vger.kernel.org>; Mon, 8 Jun 2026 16:24:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=omE+o90JVMH1c7abLG/VTyLnn33GZG5/r9bSbPT2L6M=; b=CI
	oqh3I7IcyG/H02/RR9QY59roYBIBZCHhjF20nryzSkdGX9jFL1GYb5ZWrxtoNBNz
	P6gJKZcqLfYkRev1cXr/PJPRFcjxAED0USSsoam8+QonnPfDW1e4ruqcOe6Hw5/W
	7SPF7k0BTM+Hy2ZlbB/sekwRDyNPZCNjZpGEPJNr57AwW8djS4RrpTAQrPEZH0Xm
	NNgJUEvFgqCjNOYiuiJOet+bM7/RrUL+YoMQEi16G0mMaXUsRAtwntl3L1YRjoTh
	k30l132C1F26TWS6ladsXlcxx1wa2x8SEHioDW5H1JYYLQ4Fr0cHgZQg7Xj3nk/q
	Fcyn+p0Jc1Krn1Yq0K6A==
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com [74.125.224.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4entrkt1yv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Mon, 08 Jun 2026 16:24:41 +0000 (GMT)
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-6603b45ec02so3718773d50.3
        for <linux-acpi@vger.kernel.org>; Mon, 08 Jun 2026 09:24:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780935881; cv=none;
        d=google.com; s=arc-20240605;
        b=ChYm8+DjH0PngvzNPRFbN1my8apl9x9TCBAVWx2Su+abcZAGoM+im30iCftuAfzV5a
         NEUS0tZieR1sf5V+oMGhN0jZKzM3A/qRRCoB9yf4o4/iB+jfdaIA7ZzAKFS+/o/mYBSJ
         BEb2mwzhDwjw4hlgwnULLj02FE0DyJpLmaJFb2gfPgqAUstIwGvMceY+0EWjnwmho2or
         to7MSdhjYEB8rzpnrz9PrKp0t5Oh8EBy4fkK/LtmRt1aKD/qeQVk7IXnHH6WP+TyDQFG
         2tHD+FIODg8KwqKT1EE7eRy+cU03xFWHWIUHriZlIXgUFyahoyNJuPoUv5WUkyDItRmr
         B6ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=omE+o90JVMH1c7abLG/VTyLnn33GZG5/r9bSbPT2L6M=;
        fh=00CAbwzXazr0O3maq4ozAT2YLOIiSC2A5MJvPlRvXqY=;
        b=KcHyu+GIkRZnCuL7YgyDZe4CUbNrf/u1b/alnMAqbORoxdBkl32anBha+yyCLTScRG
         d2r9QwpXcW7mcaLEDsThsbPpiolAEDh3JDT2H1vSCFEkqU0XTCPW9FzVsQuDu5jo3nfg
         cLZd39+4NNmAC/U7U9vwxKA6o7jsRrCJVDfaTj74hhw+HC3GEWIJiHwCqu5lwe5bUfOF
         F4KsJK4Nc82KVrB5YRVMykXHC1fw/eW3d0izyzL4iD72uzc9erMyGkdYqFxYdUki7ap8
         LZWtxq6ya3csUWhMgupGOWDwKQZxQjYs0b12zsnnufxhpVkFSpmzu7SrVQYpY5i/E3eN
         oTPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780935881; x=1781540681; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=omE+o90JVMH1c7abLG/VTyLnn33GZG5/r9bSbPT2L6M=;
        b=K+HdWOm4WnWmnqkoLGNxsajJO3eGDF1FU0mUZw0MvbV+YCoJZjM6eQinZCo7jjI1ma
         +50jVPv/AvYskclmWziGj2Wf+YDg1sQ030UCt2A/kkyfn7R3IOmxXwY9dQiSpTx4ZOuN
         WPlNPpui6ppb9+rbkGpmIbkpdSZaPkiyIhOxBZW2ERj4ZEhQdKUNseiXZAKZeosUfKIi
         I5TLX2EW4yPaLKpb9eisDtUESPJ3k6XE1rayG/IQyUilgsmMKHB5Hi/v9fk223/gqrgG
         hZ7APAVGHe1e1Gev23mCVTlM2NravkU3qqjeySIIlrtBxxiROLcbTTzAaKzrYYeqb6SI
         iCmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780935881; x=1781540681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=omE+o90JVMH1c7abLG/VTyLnn33GZG5/r9bSbPT2L6M=;
        b=rW2crg6vEyVO0sSUBnC5OOayNSrMmb9zzWwuWr0B/U/+daSxjM/4umi97/gITSyYHC
         apCj5na4OCpBDUCcq0ZiTU9SRIDZH7diPG280hRy13SY70P7M25RzMK4wGQD22CuNCRn
         aQX97TaZ0IjWQuE4dkkXgRPXjkPGTrZ21k/HAU18zPf6+RVUzw0WjL4t+SCqJfi9zosw
         Hg2CkUFZIvFKCRxl+//agEM5UZ8lhR4/XiY86L4bmSrAKfwxgkzRv0OufMpgFThj92jN
         TWNsRtF3V4FaGMAluw+JjPhrwqixVS84ymNQd++Eky1KwEFgMV2saWBBMxx165CBDjoC
         +3yQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Mpkmj259gjoDnh/9tk7MkCdnMC4xJgkNcF4IZcFNN7OcFJPvSz22tpKQTxRkVqkgAFg7RAaKetd2b@vger.kernel.org
X-Gm-Message-State: AOJu0YwK8uY5HyKUj1PaPJAQjyCkJ55NYP58D4+49RAiM+9xAhdvYLCO
	dQL9766mBi025kW5VD4vQOxC56Yt/pxkTl1SdVOUDeduo0N0xukJv+HeJZwozMYd5uVLWtOHcAZ
	K+Nb8tZqByWtc9estJv4UJ58p6BGBq570PxB0fiGiJ3NtSht9tmkGL4/6Sw9uS8pligZK4/c0+Z
	Glf3/cmaF058GGExFQFWYfFJNVAa7+k0a+DJBkSFU=
X-Gm-Gg: Acq92OFtLzqZrLQO443mF2UsRA8C89CfTydf4eshHaYjPVfy1JDckSgBg/ALnaZzq6X
	O1IymZv5DGMZvb2oN9nM9PkWSVtZe2Nfgl73Z7ml9JrxaVKi8kvvQR26czZAkoIsKLIFn0mGjMT
	q2J5f7x11MBYEOPEC3pBI5rgimMIHfp0ioIepFtfHpEO5ft7aypUBrJ1D2JFMc+d0kW08HFsd6M
	Pl5ROi2gV+IeFSNNQ==
X-Received: by 2002:a53:c5c3:0:b0:65e:48cd:7fd2 with SMTP id 956f58d0204a3-66106f6a47bmr10491411d50.54.1780935880730;
        Mon, 08 Jun 2026 09:24:40 -0700 (PDT)
X-Received: by 2002:a53:c5c3:0:b0:65e:48cd:7fd2 with SMTP id
 956f58d0204a3-66106f6a47bmr10491371d50.54.1780935880148; Mon, 08 Jun 2026
 09:24:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603-gic-v5-acpi-iwb-probe-deferral-v2-0-23ffa16b6ebb@kernel.org>
 <20260603-gic-v5-acpi-iwb-probe-deferral-v2-1-23ffa16b6ebb@kernel.org>
In-Reply-To: <20260603-gic-v5-acpi-iwb-probe-deferral-v2-1-23ffa16b6ebb@kernel.org>
Reply-To: sunilvl@oss.qualcomm.com
From: Sunil V L <sunilvl@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 21:54:28 +0530
X-Gm-Features: AVVi8Cd5IwkMkDgaeTWHmXts8_fu2m7CAyoGep37i45EZYnSM24rOUfn-o0eV7g
Message-ID: <CAB19ukFFwm3ehzkBFr+oXRjA7VK_4_=XHFSuqdEpbVqUz8Do4Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] ACPI: RISC-V: Fix riscv_acpi_irq_get_dep() loop termination
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Sunil V L <sunilvl@ventanamicro.com>, Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
        Anup Patel <anup@brainfault.org>, Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: -Chd-WBRi9lawq8ADv5Kx8fNdLstlOXS
X-Authority-Analysis: v=2.4 cv=Z+3c2nRA c=1 sm=1 tr=0 ts=6a26ecc9 cx=c_pps
 a=J+5FMm3BkXb42VdG8aMU9w==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8 a=bDdBU3oEAAAA:8 a=EUspDBNiAAAA:8
 a=66Rqm3UGZClwUuHIDRgA:9 a=QEXdDO2ut3YA:10 a=Epx66wHExT0cjJnnR-oj:22
 a=DN7SgORnOiO7RqxRx1GC:22
X-Proofpoint-GUID: -Chd-WBRi9lawq8ADv5Kx8fNdLstlOXS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDE1NSBTYWx0ZWRfX6gA5WMNHLZPO
 63f2q4rlzAGwAMrLW/Sg4+aqKGm+GretgLCOZjXYVtPpM58MIPNKEzz4yjfOnX2FoglnZZ4xZkD
 YDrOUYOeuIAA2BKwi5FReUtT9O70Sr3NoOXfx2oY3OTrGKcP9T3Ras9DTc5JukB6nHJk4G/Qh29
 1z2UO9wMBNyOykW143er5hhtJnwJ8yCv8rXE8quzH4hAhxELPXYGjbcp0P1Qyu/lpxGuWSQf6wq
 aF+GjNGSQXopkJl1X2s/JiW9Zda2Ki41HkPrRqUYl9S40oJ9Kz/DRkPeU+iWuDOWYaC7Z2d578d
 ECRRM65Zb5Ht2Tcvz4wI+QXM6fn3jE9ctTuJEXwemSxykYLiomT9XrqT4/Gbp64/2l0TqAwX9hS
 90hPqMsF6DVN4GxJrzVM1TpwPT11lATBl1jD+NpCMQ3HoFC48GQQ4JsdbH4h2izHj6lYrRfmhWx
 GlihOtjJgmsFwLmg4Og==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0 clxscore=1011
 adultscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606080155

Hi Lorenzo,

On Wed, Jun 3, 2026 at 1:51=E2=80=AFPM Lorenzo Pieralisi <lpieralisi@kernel=
.org> wrote:
>
> In riscv_acpi_add_irq_dep() the main loop condition would currently stop
> the loop if an interrupt descriptor contains an interrupt for which the
> respective GSI handle is NULL, which is not correct because subsequent
> interrupts in the interrupt descriptor might still have a GSI dependency
> that must not be skipped.
>
> Rework riscv_acpi_add_irq_dep() and the riscv_acpi_irq_get_dep() call cha=
in
> to fix it - by not forcing the loop to stop in order to guarantee
> dependency detection for all the interrupt entries in the CRS descriptor.
>
> Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Sunil V L <sunilvl@ventanamicro.com>
> ---
>  drivers/acpi/riscv/irq.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/riscv/irq.c b/drivers/acpi/riscv/irq.c
> index 9b88d0993e88..cd83c3035cf6 100644
> --- a/drivers/acpi/riscv/irq.c
> +++ b/drivers/acpi/riscv/irq.c
> @@ -299,6 +299,7 @@ static acpi_status riscv_acpi_irq_get_parent(struct a=
cpi_resource *ares, void *c
>                         return AE_OK;
>
>                 ctx->handle =3D riscv_acpi_get_gsi_handle(eirq->interrupt=
s[ctx->index]);
> +               ctx->rc =3D 0;
>                 return AE_CTRL_TERMINATE;
>         }
>
> @@ -314,10 +315,8 @@ static int riscv_acpi_irq_get_dep(acpi_handle handle=
, unsigned int index, acpi_h
>
>         acpi_walk_resources(handle, METHOD_NAME__CRS, riscv_acpi_irq_get_=
parent, &ctx);
>         *gsi_handle =3D ctx.handle;
> -       if (*gsi_handle)
> -               return 1;
>
> -       return 0;
> +       return ctx.rc;
>  }
>
>  static u32 riscv_acpi_add_prt_dep(acpi_handle handle)
> @@ -381,8 +380,11 @@ static u32 riscv_acpi_add_irq_dep(acpi_handle handle=
)
>         int i;
>
>         for (i =3D 0;
> -            riscv_acpi_irq_get_dep(handle, i, &gsi_handle);
> +            !riscv_acpi_irq_get_dep(handle, i, &gsi_handle);
>              i++) {
> +               if (!gsi_handle)
> +                       continue;
> +
>                 dep_devices.count =3D 1;
>                 dep_devices.handles =3D kzalloc_objs(*dep_devices.handles=
, 1);
>                 if (!dep_devices.handles) {
>
Do these fixes need the Fixes tag?

Otherwise, LGTM.
Reviewed-by: Sunil V L <sunilvl@oss.qualcomm.com>

Thanks!
Sunil
