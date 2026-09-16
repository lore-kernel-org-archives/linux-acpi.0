Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894B236A02F
	for <linux-acpi@vger.kernel.org>; Wed, 16 Sep 2026 12:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789561126; cv=pass; b=W3uTbRGd53xQC+YWOk8sdlhxK7qtG05f5JEKxtsPpiOLHfBp162SK3AvdrO+h9V3qCOvh6NXJIbCttLCrgJ+yG+MmBBFTMyGpXtAoLy7ogTo0QQ2Fb/Q1FffYZgSLaGGwlQQXhwA7kkRX6qvI58ChbdolPkiZdnjdN+rMnnD37U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789561126; c=relaxed/simple;
	bh=cFuJnI/gnjp4xLrzIqNiRkV0rShV5E0vA0XrCKp3Nm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QFexxBHrigweBD0sO+3kYtSnXK/5j7qwDkDxLHVfpa+PBvvlFKBUPJAwLsjuxHcKPrzebNG+mdV+npwj5QApPMr9uZ1tnRLqiTAzQY093/dtV+ojmaibUx8UCfjLQqI6453/PTd7xf19KQKuulxslW40WXDJDfauH3SbaagQskM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k9V8GFXW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Rzwis56F; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k9V8GFXW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Rzwis56F"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68G930rf2822830
	for <linux-acpi@vger.kernel.org>; Wed, 16 Sep 2026 12:18:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=SZBupEoFPUauIn4/x4mdIDMsjjahDV5vgXK9nZDkKoc=; b=k9
	V8GFXWHIdnHp6Y4RnNpVLDr67AHxIWYMsbp2wmPOzH94cRlXMQtwXV7xIZ+9BXR0
	0nR/078w0RDY5npb796BNWhMuXLAAqG6YK8dtpYEurKNfXq7Fa/7aD8tX3wFdkE0
	6OHdaRuZIiumN1U6y20TE8eyAsSsgbwWzLMle0j74mNUcOwU9w13bLZnbHclBNtu
	moDljfiHU5n5r9RW2PtAkTPiqmbehLJGMTTfkBwrO4AQzmgh35DJCUDpox7iqzDr
	mGAcBB8eoI1ibcz/V3z+ZnEVL93hmW3Yer9TFDNbRPMORE3IkU6KVJOQnmPVv+Jg
	lOWWtHO7wLNgrboDzF0g==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com [209.85.128.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqfvfjrr1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Wed, 16 Sep 2026 12:18:44 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-8848dc67d24so63341747b3.1
        for <linux-acpi@vger.kernel.org>; Wed, 16 Sep 2026 05:18:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789561124; cv=none;
        d=google.com; s=arc-20260327;
        b=i12Jc6JpT6NVZqmHG8Zj3ETFIFhRrrDXNiqjvlQ6DRWDGyJzkzOw61jqT9puuv0DSz
         UEoRB4BoZAw8CKdordErSGpZj+LqKDmSYa1d+hum7Tkqsyv/n4L1oJLZPazPIolJk+qZ
         CGCEjCcnbknCcRmrUWrTxPEpc2axY1G8mHyViO9D4AGT8QRN+F9KtHpEEmQXOxEuSXj0
         67f+YHWBkCt/KLCoXxXb+oFsQMgWoLXJI48gCfihhLa5zkcjDQQ2VIyjX6L8c3Pt3h0P
         rcwXSTRncg/X46UzRjM/ufSW/GN2l6Dk1RCVHlYp2Ey86XQUaSGC6uhIt1GJEySe3ra6
         L+wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=SZBupEoFPUauIn4/x4mdIDMsjjahDV5vgXK9nZDkKoc=;
        fh=USI3l6CTC8O6f0EETlUb7hRzZ4fOw/SgD7BB3qYG9S0=;
        b=B28dI5n+XEhJKjbJthswl5fhXvuEbVUI88zPt+HZW0Oe2hIv5Dph73piHxhYZvVpWK
         o3EXLiKut5lyN+Mbbs6CF2ANrxaVyx+yEZLeay6xzJCqr+mWJZl4Hgbw2vMvevIw+d17
         6yZXFxE1AdqvDq0PgYkzfAPtBCJqlxbHkqxpodFrjoqHAahyzGWmmROh1j8OCkb6o0Zu
         H0ZVEPeshtRMap0c54qPHfMsOIWmWHG9QA2d/0kOEaT1HWLp5BmQcP+12AVrd5OdxsiP
         1LmyBKtuPfKS4OgSeAXfL0TGXbhEQmnZC5LtQ5Av4xMlherDB8xw/+tboIGIgVh5zckk
         2dPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789561124; x=1790165924; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SZBupEoFPUauIn4/x4mdIDMsjjahDV5vgXK9nZDkKoc=;
        b=Rzwis56FgaH8sujtwXImMu/XGDRDKeezaqOXX4/gVotf/qrkyG4CIbW2IM9Kry41r6
         6wUAlNTVMUqlmGopM9lUQWEEEH1FxKkIG+8KR+LsKvMSOObSC7YXPjAaEUdVDQrNktOd
         gXKUOE41/eJ0Gky14BIgtCO6Hl3TQGcnmhssPJ8/MKCs4FE307bGqFmUIlkiw7LUJ6Tr
         frcxBfFLytAv98EbiTO9xyFx3nky7jwPIJRBlZRCA0oQjei1vc3E8i28MPqp0askr0EU
         7nieIxT8E5bhcUn+DXSSl35qBmaTpGOnzc8N+3Qhuaop4ioJnaF99VXiUiRwTtmHrbRf
         /FQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789561124; x=1790165924;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SZBupEoFPUauIn4/x4mdIDMsjjahDV5vgXK9nZDkKoc=;
        b=2ZK6iBGWtwOMHVclQeq+L+rN7jOpnvcR61oqkiHHu9Ck8e02DK4wW1bbClFQJTAez2
         2Fs0N9NLk0mTqvggh80lDeWIKKa0/sYKMlEsvszV8ZUN6qOHvXSdgiBEDSaJV8R9LiYc
         +D629qrUvYFAbfc+ZxnH/thJ9+As7tC4vQPMT9OKIMMWnSs0Mx98MtdOe/gbyENKvdJW
         9c0fpAF2Q6J0+Aycgt4uKlwqsnewOczTdyGa2+kxEoXC4Etbgm6XJJEotRJw+FSAH9F2
         O0lvx3f5VTk/UHXxDzi1wUeVFXWXLgACeLgxVs3FVzGZERLwVW07ZVLvRgvNerel5z7o
         gvyA==
X-Forwarded-Encrypted: i=1; AKwUvBzg7Xfk1VXa/fueKvXiXAh4MBB+CQGCM7Nb+v4o1AabLjTzk/iiu3IQi41OfezYgrCm2SPLZmfYZUZb@vger.kernel.org
X-Gm-Message-State: AFuF++kqLCui1uX6/uQkW/t2258Zw/FSovJSpp3vcJFa8th4/VpY7pO0
	UQPIDLJ38DSz6mhI7SsGbmMMmZbkRnEUEZhOiS6CiZtkappwXCLxx+eRvVR8ousVC+Ho19LF8lw
	6NPpSqMSTiEM3ISxt0xGaDs6Sfx2t55Mbmi4M43+8jIpJNqNoGNGkpypliJbGVrNMUnnpvTbIb8
	0WODw66mKE2fK8lu0sxLBCf5fdFJ828N4QCToS7KI=
X-Gm-Gg: AYBFou135cu1jycdiitr//CVs7YiLlBfzbvhEnT6ZfE4qiU1lVHQ+rZV6Lui4jmNdng
	FS5KHFrgX5jT3UMJiZHFFPekDKu22aDvCP2d+ZoUR0CyOrABYQ3HumAK9bFZ0TgxRr8y3J3a3p5
	7dSAw6VAy8t9/sUx7RIYfxgUIY9Dc02PvEjpailX9vNPuHzpPx7dcHjYnBCzY=
X-Received: by 2002:a05:690c:34c9:b0:873:5bb2:6c12 with SMTP id 00721157ae682-892265e7601mr6043587b3.60.1789561123669;
        Wed, 16 Sep 2026 05:18:43 -0700 (PDT)
X-Received: by 2002:a05:690c:34c9:b0:873:5bb2:6c12 with SMTP id
 00721157ae682-892265e7601mr6043477b3.60.1789561123293; Wed, 16 Sep 2026
 05:18:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916112545.887461-1-xiangwencheng@lanxincomputing.com>
In-Reply-To: <20260916112545.887461-1-xiangwencheng@lanxincomputing.com>
Reply-To: sunilvl@oss.qualcomm.com
From: Sunil V L <sunilvl@oss.qualcomm.com>
Date: Wed, 16 Sep 2026 17:48:31 +0530
X-Gm-Features: AcwNN1W_xPwCRH9HhXLAxBaZmSSff5vjkIMgObB2TpK3jfnwJHHIzxaUu74RxEQ
Message-ID: <CAB19ukHfFXmuPEaWdNPvFRkvMGpDQfVEpCHfqsHL20tpBytQRA@mail.gmail.com>
Subject: Re: [PATCH] riscv: iommu: ask for ACS to be enabled
To: BillXiang <xiangwencheng@lanxincomputing.com>
Cc: sunilvl@ventanamicro.com, rafael@kernel.org, lenb@kernel.org,
        pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
        alex@ghiti.fr, linux-acpi@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, tjeznach@rivosinc.com,
        luxu.kernel@bytedance.com, guoren@linux.alibaba.com, jgg@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=JYkpPkKV c=1 sm=1 tr=0 ts=6aaa8924 cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=D19gQVrFAAAA:8 a=4BKX8IsyAAAA:8
 a=RP7urAqO3HFMDD4ElOsA:9 a=QEXdDO2ut3YA:10 a=MFSWADHSvvjO3QEy5MdX:22
 a=W4TVW4IDbPiebHqcZpNg:22 a=bflBWynC2lygM3eL1Mvi:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDE2MiBTYWx0ZWRfXx5zFAZEUtvMj
 /8XglqYMQWntOSoHntJbs92kVG8N0pTmP6XhRU5N1VyjRos/QjAqvOOcavwoM36zPhfD9qNUmKx
 VDu5DyPBp2+iL8YEUOIRH52w+XiUY6jIORsb6LGdJo/ffaZ6KciOGUA47fraG8qp7G19ygPbBMp
 Te32T92o00lTP54sesP/amowGleYCP0hX4lSdtE3/Dnbsi6GymbfN/heNyLCf2etHZvBzBqK2yC
 tqfad9P0iXdRZdhMg7eDNwunCXiSwupvf3tO0YASSyaz49djXkFZPm0HkgWUfwvEmaLzgpF1tNB
 Vol+kmknugk/morG97+C5wtK5wASbyOZ7r+oHW4TlJRCFWnHZ/NPdYoCdoHra4loCpazsSeK3WU
 fXzBbPyXPP3sMZ4oTfrsyQ1A6p91I5MrFgcE6QFeoqRsuerRudPEmgqVl+vBt+sDKwkfBnOpAAa
 sDoaCbS8g5+K25HjFMw==
X-Proofpoint-GUID: 9MdSVbCwbs44CntEj0_ZMCyEmVFPyQ8e
X-Proofpoint-ORIG-GUID: 9MdSVbCwbs44CntEj0_ZMCyEmVFPyQ8e
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDE2MiBTYWx0ZWRfXwy5roGBdBU5o
 JrFGeJF6fUArJ4dlxlUoyZhtQrkNiPBihEiT05xMPQT6eCx1kyI/xn/Pg2eimiYTDtM741x8Qny
 bHqpIJMTw4pZF+tSmLBvCpPfmHKYBzc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609160162

On Wed, Sep 16, 2026 at 5:15=E2=80=AFPM BillXiang
<xiangwencheng@lanxincomputing.com> wrote:
>
> Make sure ACS will be enabled during PCI probe
>
> Signed-off-by: BillXiang <xiangwencheng@lanxincomputing.com>
> ---
>  drivers/acpi/riscv/rimt.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/acpi/riscv/rimt.c b/drivers/acpi/riscv/rimt.c
> index e4538fa6c2c8..30d2d0211d5e 100644
> --- a/drivers/acpi/riscv/rimt.c
> +++ b/drivers/acpi/riscv/rimt.c
> @@ -525,4 +525,5 @@ void __init riscv_acpi_rimt_init(void)
>
>                 return;
>         }
> +       pci_request_acs();
>  }
>
There is already a patch in the mailing list for this.

https://lkml.org/lkml/2026/9/3/1930

Thanks,
Sunil
