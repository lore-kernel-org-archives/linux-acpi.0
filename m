Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4822330569D
	for <linux-acpi@vger.kernel.org>; Mon,  8 Jun 2026 16:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780936247; cv=pass; b=WG6EOMg2Xxe89UjGPrfLNXlqE3rZpNuTr2VhI+12tuqHklcLk04ywaBlPHn2/CiCeCY8o67XYRpISjTDKn9leseyID1UsVFwDwd6hasYLXuGFDMC6lXEZR0TXZAAQXEtJXmHLUyIkpu9JFeKn/Yp5OReUcESb/TntKoFSRfMhBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780936247; c=relaxed/simple;
	bh=iVjGZf74sddO0VwaK0/NVSR5ujcgEOoJofNUxGTnP8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WDdjM8P6N2LlpufksYko1JooLjW2i7bvZYCABXDjpgxKVNDBaqZUpjLysyvkYJLcuKzBuVJCFpBFaMuA5ygfOfkLj0mJuT3AhH2m8NplPr8H7lJBZqnLa+OgdljMfpB0sNXyTe5SnLAUVYpU0E2NOQmy5bKxCg6IFmV0Hocgjbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JcShYuEj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aernk+Yc; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JcShYuEj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aernk+Yc"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658FFWkG4041683
	for <linux-acpi@vger.kernel.org>; Mon, 8 Jun 2026 16:30:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=DUE+ny+UnvWaJEVXkhAnSWXizCbQqgAqEbs9h0LudUU=; b=Jc
	ShYuEjajO11QNx+P9XS8wV9QDiTTs4AcyuiWhZop6oA4R9vpZ/xuIk3VJ2UdMP+Q
	VlhjAXtHNd9pPr5psE0IzXfZYONSAiBszhF0CHHLiAssX93R/s/ov0pnNY+VxI9h
	cc/uAg63M5E/lbbbFSOLxpdvIjy9piS03SS9/QsQwhQ/chI/zRMAhd96k1KBqYYT
	DZIaBhu3e62xqVfo3MbNxxoS998MXMxlsuzkyWTTA2y2AltD+UyHqwqUYVFSbsQ/
	DU9NJKE+MdXMxcp0OsN+/eA3ASnZpuLWKbWz0gt/sUDQpCZpJ2e29vUlhcBDcq3r
	jno72HC2CrKW3VjfocPQ==
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com [74.125.224.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4enwsv98qv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Mon, 08 Jun 2026 16:30:45 +0000 (GMT)
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-66053e40709so4978077d50.0
        for <linux-acpi@vger.kernel.org>; Mon, 08 Jun 2026 09:30:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780936245; cv=none;
        d=google.com; s=arc-20240605;
        b=OMZFyoaH6t+hFlscctq+5FBnAaJhk3oRXsalkQrEn2N8VTRbTgzEXSnWnrQeMf3eve
         +udm6IZ5goKfybZovk+4YtmQRipy/TMxMvYvGQ3Wzh9QmW4d3BX2TQOWgBWBvbznsK3N
         bh8rtZSAuI4+et1i8n6svHK19MSP/R+7co7gzccO+NCfSDWSRKWMZVhgJ3G3tsHi71wM
         MqcVu8Ta9moyS4ZRdRcaekYgONsvt9iD355ruTXr0MYHOL8jBvS0xvMSnrVU665/Kjd3
         F1dmq6OY6cGtZ7habA6tHch2wdEhS2Sfl+E14CDMIT5zXna+xVEyF9VovGldVJETI11N
         ip5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=DUE+ny+UnvWaJEVXkhAnSWXizCbQqgAqEbs9h0LudUU=;
        fh=3BNXEgTKS1UDSPv8KHNAvP5K1e8zLNkurFW+lmUJQes=;
        b=WEYXX+yxaionJF5PqlekLvm8ZIeM0yHToHoq1K5oHpW1yDFgZMAkuDing5iqf0pHlb
         U4i/Gaq93Ok/NFMHHDvOA//uw35uHYvAhEv0Pr5+zufA1tuVTo7d0nuKsldPj1Hl+WIZ
         v4L9lAEljOIjJ1PBvsRZYI5cxVDg89buT/f5tDHQQr9IKfiZa3qjsTQ94tmXMUTkf+Of
         +G2oNlno5AYf144ku1AKI9HUX2R3bg+/8ywaYWx/9Tc3IYRuOmaxHwJLiG8iWU4duV5V
         jDz9yWNpxj0cMcuG6MXclqje8Vj5QN0Wpl0pRKcGZc/bVX1G8DLC9CY0YG6uJwOoPNBD
         UnwA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780936245; x=1781541045; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DUE+ny+UnvWaJEVXkhAnSWXizCbQqgAqEbs9h0LudUU=;
        b=aernk+Ycd8ETBsV6fAp/GmwFxZWtVKJAUVbkEjxKDZvZqFdlNorDquuBKo/E/CtJlm
         KCt7XIr+hIlXH6Ep7PUEaNxvdD7/HWppPUSeyZofCCLN9HMHfvBAY+vndbUwjGfllH93
         gMkyWcN3lg5hd4JzOXkdZFNyAvoZmnglpihdDgNMb4mtZnjkAWrdsNb7pft+i7B3DL/E
         kOZ39zADlQjMcRqUxe+ftoII1dtYsorV4soCXXANeJVbiSFK5PH7n3TRr6l1cegrmQrt
         1VOVqcaQTXWowELbg/02sCClACXSx0RKdK7OobUqelqskbq4Wd9uLshrSAwF/a4rH0pg
         Kecg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780936245; x=1781541045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DUE+ny+UnvWaJEVXkhAnSWXizCbQqgAqEbs9h0LudUU=;
        b=ruOsRjqwMo04y/IIdWyeM+EWb1F25mW9PIZ7T4bW6Y+vH4TmABAoSw6SGK4LP837TM
         L0kYdrx4CCVc21ToMAaPeMzSG0rJmEh45Bk/VIKo+C0V5jXEsKOlXMS4NnW9lydhoeG7
         tzx0a8ojIpc0srH5HR9WK/D6+TJpiAB5gwKAQSiAcBUP09+CjJCNQT+Ti9yUS7jnkyP6
         w20WFctLh57K22XpV0dT06RBeWuYwrbIzl2q/TqoQMAPiecHKgxGYZPtILhkzYc08OHe
         B88RShJVEH8EpV2hODjhlGvElB6V5k8uqFbPIv/s5qoKSIKO7a3UGfsALYOuTqD0iEFf
         8PeA==
X-Forwarded-Encrypted: i=1; AFNElJ86Rb0VCrkRFUqSmXpsGPjFSLJaOkcvZzyksy5ROyusvdZ2aeBL3nGFqztJb7yCwcThCVADcy6+sxUY@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4EmXO7LznNOvb/Fa5RuMALwtad5oO5if0O3q4/Xrcl7Wp6tzG
	tbAiDGrzpGgw4Wuv5OarMg7pVgwCcwITOpcHA+ZMO3XAVMR0lw7PiNt9oI7DugqIdk8WVA9cvXf
	g1p4Wa+yQNDB4eN+EQLVelciA54xTH3IVQWt35gsAFQl79QY7alPvw+jufbY+0YkPIdprF2sdcB
	y7KCOBq3/MhPkxP5e+SFQtGQPYpsomQTRhHa2NW9c=
X-Gm-Gg: Acq92OFYugFQVd2TkrkJwf1LBSaEg3R6u9yfyoZ9du5NKBCJno2Rw+TZeOTEseG5hV1
	Bst4NqQyOHZw7s+mSeSVRSfY8nOhovWRubK/StWUw95weEz6SC7d0Ch5Jx9An/E4mWpl369AOsO
	EO7FdNlMi6vRq1Ue+DzSLLrgHuyV7ZKDHENhTUtJw0BHxaE6PyD/4laV5GPKTa3p1dFXMfqd7Hz
	v6bMxvAmNd0Op/mpQ==
X-Received: by 2002:a05:690e:138d:b0:660:529f:76c2 with SMTP id 956f58d0204a3-6610a62ba9dmr11112990d50.8.1780936244693;
        Mon, 08 Jun 2026 09:30:44 -0700 (PDT)
X-Received: by 2002:a05:690e:138d:b0:660:529f:76c2 with SMTP id
 956f58d0204a3-6610a62ba9dmr11112955d50.8.1780936244186; Mon, 08 Jun 2026
 09:30:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603-gic-v5-acpi-iwb-probe-deferral-v2-0-23ffa16b6ebb@kernel.org>
 <20260603-gic-v5-acpi-iwb-probe-deferral-v2-3-23ffa16b6ebb@kernel.org>
In-Reply-To: <20260603-gic-v5-acpi-iwb-probe-deferral-v2-3-23ffa16b6ebb@kernel.org>
Reply-To: sunilvl@oss.qualcomm.com
From: Sunil V L <sunilvl@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 22:00:32 +0530
X-Gm-Features: AVVi8CcjdmtpKU9pycNL-hwxjKIaJHrcR5nC3cRzrIaKxh71BhOXsVMQNx-uaR8
Message-ID: <CAB19ukFw34et9YULib7i-xXPirrW-TVK96PH3KKR0Nb0iiwjNw@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] ACPI: RISC-V: Fix riscv_acpi_add_prt_dep() loop handling
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
X-Proofpoint-GUID: ckXi-uNbIOKeWzGvszDaGPRFC72OBl_Q
X-Proofpoint-ORIG-GUID: ckXi-uNbIOKeWzGvszDaGPRFC72OBl_Q
X-Authority-Analysis: v=2.4 cv=dIaWXuZb c=1 sm=1 tr=0 ts=6a26ee35 cx=c_pps
 a=S/uc88zpIJVNbziUnJ6G4Q==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8 a=bDdBU3oEAAAA:8 a=EUspDBNiAAAA:8
 a=_MyEUG9zEuNOLPre8u8A:9 a=QEXdDO2ut3YA:10 a=nd2WpGr1bMy9NW-iytEl:22
 a=DN7SgORnOiO7RqxRx1GC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDE1NyBTYWx0ZWRfX0xr4+JILbmrN
 vRhkJPRRBwwLXqlboEq5HwIRWfD10uciGD5R2hNKmw+4ouzKCrtwKAr4TkH8QoppB64Qlj1FEXO
 eojurOLRnBkE+28Jj89bVj1qsloelBRaH3MnquIsxMH/o6I3UfWeNvNYF3LNTARq1C+KRJko4Nv
 TtMyRDsPD4RsyQ3SFh4heuX/xwVGl5u/TMSCfmNqfznPmJvdHaEOLzf6CMo/ZG/CPHRTTOICEiM
 Hvh8QLnwpWLtpYmxoqsG1PBrM/UhP+42tTwzuQE2Gl31F5HMBgJjAo9d4ALeiXJ08iCh2usGbIx
 Muekk9qIRbBoRP4jy/Xi0ZpaqMZgigOS5qU5o4YbrkQ0liATHtxQVrFbS9rMCbRhiCf7qxzNoMz
 hIg7rQkLuWLyJWPzg2yDd5Gwqv3J10LWASYf56EW7cI0vTZMtWXtGr2rx3DgmV6sHSYpaUVW8G5
 AvtGOVtsRS73xrkzSww==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0 bulkscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606080157

On Wed, Jun 3, 2026 at 2:18=E2=80=AFPM Lorenzo Pieralisi <lpieralisi@kernel=
.org> wrote:
>
> The loop in riscv_acpi_add_prt_dep() includes error conditions that are
> handled in a dubious - if not outright wrong - way, by continuining the
> loop (which skips and misses the entry pointer update to point to the nex=
t
> entry).
>
> Rewrite the loop as a for loop (that handles the continuation correctly)
> and wrap the condition and update statements using helper functions to ma=
ke
> it cleaner.
>
> Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Sunil V L <sunilvl@ventanamicro.com>
> ---
>  drivers/acpi/riscv/irq.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/riscv/irq.c b/drivers/acpi/riscv/irq.c
> index 75170151c614..0cdec5dd575e 100644
> --- a/drivers/acpi/riscv/irq.c
> +++ b/drivers/acpi/riscv/irq.c
> @@ -319,6 +319,20 @@ static int riscv_acpi_irq_get_dep(acpi_handle handle=
, unsigned int index, acpi_h
>         return ctx.rc;
>  }
>
> +static bool acpi_prt_entry_valid(void *prt_entry)
> +{
> +       struct acpi_pci_routing_table *entry =3D prt_entry;
> +
> +       return entry && entry->length > 0;
> +}
> +
> +static void *acpi_prt_next_entry(void *prt_entry)
> +{
> +       struct acpi_pci_routing_table *entry =3D prt_entry;
> +
> +       return prt_entry + entry->length;
> +}
> +
>  static u32 riscv_acpi_add_prt_dep(acpi_handle handle)
>  {
>         struct acpi_buffer buffer =3D { ACPI_ALLOCATE_BUFFER, NULL };
> @@ -337,7 +351,7 @@ static u32 riscv_acpi_add_prt_dep(acpi_handle handle)
>         }
>
>         entry =3D buffer.pointer;
> -       while (entry && (entry->length > 0)) {
> +       for (; acpi_prt_entry_valid(entry); entry =3D acpi_prt_next_entry=
(entry)) {
>                 if (entry->source[0]) {
>                         status =3D acpi_get_handle(handle, entry->source,=
 &link_handle);
>                         if (ACPI_FAILURE(status))
> @@ -365,9 +379,6 @@ static u32 riscv_acpi_add_prt_dep(acpi_handle handle)
>                         dep_devices.handles[0] =3D gsi_handle;
>                         count +=3D acpi_scan_add_dep(handle, &dep_devices=
);
>                 }
> -
> -               entry =3D (struct acpi_pci_routing_table *)
> -                       ((unsigned long)entry + entry->length);
>         }
>
Reviewed-by: Sunil V L <sunilvl@oss.qualcomm.com>
