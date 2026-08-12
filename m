Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56AB2F363F
	for <linux-acpi@vger.kernel.org>; Wed, 12 Aug 2026 01:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786499494; cv=none; b=r9kGahs7Q/o9av/pts9GsnImnTEjtz9JNndNBBXUV6IRr6I8rL0/UI00F8IA/aUWnCkktfEBj3OO3Wndi0v6CIbNL/xP/ekrf6/2HqIlIQzZbWuz/yrDI+8XBt4Yo42DNpRBynmNl5qowhqol7HCiey7p33zYH4td5CFcRlIsRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786499494; c=relaxed/simple;
	bh=9fLIQk6TuvR90I9LdS7QqcZ+X7/8nWY9P2OtVaFesU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rt41YqFsIAe/GgjYd/VX8eAGJmQXR6yR8tip0RkWT31sUpAsaWdUnyvfkJgrhZf/+fy3AJjKwZgmX+AzeEPZKT1G4XtqPG6Oo5XzWg71FTnMp0DyL2SBWhAw5+w+s2gHLRYKBLnNNlHM4JHumpDoUFxYSFTY9yhf6MCA49HshZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TAortyfM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UTL44xU1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TAortyfM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UTL44xU1"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BNGhi01754704
	for <linux-acpi@vger.kernel.org>; Wed, 12 Aug 2026 01:51:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=pH2EITf4Eq9akr0q9vn46l3h
	PHYJbGOhQoINte5CyCM=; b=TAortyfMV5Iy8dEk1k+Xn/gsMJEXv9ohxSw1UCLA
	tExP1i4/0z2+/X8r1+KGQLk5WCUFbRFIAiMS82+tUf2UZLCZDNhkmBlL3wwo6jRS
	EBY0aENniSxjNLkhvhDEUxcv+407pqdQhQPNG5jc3h3VTLrA+wVv4e+kGqDskpyX
	7t0U2epbdl37TOWdYcYZYj15ZNz0lyG3Qwl89ZZnwSGsGHGuJcvQKBM+EZsHgVSp
	dUH7/6gss5tKp6KlYxnLHlhDRKX7y/UGP2Q0OIbDprTUm4hEjjZrFd/2mBOMRgtd
	TDYuFEAMtA1+i3RUz92eyKoHFqHfIWTq0Kch4qAU/Nj9+Q==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g049mjvh6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Wed, 12 Aug 2026 01:51:31 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cc88e22f92so12216655ad.1
        for <linux-acpi@vger.kernel.org>; Tue, 11 Aug 2026 18:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786499490; x=1787104290; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pH2EITf4Eq9akr0q9vn46l3hPHYJbGOhQoINte5CyCM=;
        b=UTL44xU1J2tAoRoJ8ibSXQtS3xLf0nDsmXIER9jgaISffLSed/mloxsESrlkp+qOw8
         fcS/DePXhwnhZjzgrDWEEYFtVgxs2E8KN1gSPcA3Qt1VuipZ6rz/ZpH0wKCd+nZY5uc1
         KTHoKrB0UOVLP3dwic6peO3DJfIZmUYVqW5MXrW5TJa1nozRLawF55uVz8LIcEABawkK
         6pZZNZ+FTkZxf7uuk7Jr6hsdTYmx/FZc/rMbhydu3+gfjqhwvVFLIy2gqx/zEkZXWHJj
         ZuAzG0odGU1udvcrVSNOj7QzREJHzVhDBSezjtIBQ5w4N53WCjOo0kqA8EZl38eiykWW
         aKlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786499490; x=1787104290;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pH2EITf4Eq9akr0q9vn46l3hPHYJbGOhQoINte5CyCM=;
        b=ClvzDQYES14dLTmBSYN2G9aaAQsyWHBYdD0hEH1L1JP4sZnzAiDiOX23Pnekq+vNE6
         PupjiN9dKcpTZ6jCNmDcm4Dv+F9KwkWwwW8bflQRj88S1wupeknSya/IdNlPMSY+d6u9
         QRXy+JVsmqxUMOunj/L6L6U3+/MBiyDSQZXfHqw8hpzqSw0Q40jAk14O1voT+FiFhXfp
         ySi2QpM52H3G5lVBbDT1Y81zq5FOcvmK5cA29e7Lftaz6x/lQmuyU3ggTg/BQK+qoylH
         w8OZ2Ww6INW7IMMTlB/64ygGuyJGd6gi6sfQc4rblrgbkVsfD9IZaGDddFmmGeSm33zP
         B6cg==
X-Forwarded-Encrypted: i=1; AHgh+Rpshe2byS9fHDhshG2/1WMffU9tt0ZuW2ImhoUTpTfCFTYH2SVoxtmmqfw9fQtjcufdC6DNGv9CKNsc@vger.kernel.org
X-Gm-Message-State: AOJu0YwCJwDXqL/4k9OUHBxyTkMCkIfq6vbe1/zxRKeCZgGcKAlX9E6b
	0KbAq0ehIXRLOgkDI9zHD0mfIyxMJUKcKW+bpkFRrN0wfrkbMxGoJfcha7pkDObyIZmpZ1yvE8+
	BIZ9aKwPagfj++37L9sCwX1k6k4jtcIuo/NkNYPx7AMwecbxwZQ1jj+HuDknHN5n5
X-Gm-Gg: AR+sD13NX3kEFzDjx4w/HkSX2bI4kuFCYrp3JAaxQ2Wg0/EcDOX9w4OesVZYuWkt5AR
	loVllE54Z9t3v9QPk9ypW89iclecHZbofr4DU1twaQSpyuOTN4ych4I+kFboA242FI6h1GnJ/24
	6C0I7jKyfFZoUZLx73IaxinUdLoZ/J7H47PUsRF/BjYjsd3brYfHjGAHNhsaNygYQKfSgxfEpoN
	yMqImZFAEmhC9T//qtgKx0RYW3nP4cGjx14jSoPyCrN8KPD1C04QFnJ7aP+8snpkPh/bIPKDNIi
	n/sdQKIGD910lHRf1hFTcGO4rFEpWDZXXoboThplrB8h++L2v79M2dfkWSuy4KoopPmC9Ow9Q8Y
	t5kl+9cQ52HZNPHPehi2M2ZBrslKvbc4EfDg66lbwMf7F/iioIQ==
X-Received: by 2002:a05:6a20:2445:b0:3bf:6fb1:ce0d with SMTP id adf61e73a8af0-3cc3f73428fmr1392408637.21.1786499490453;
        Tue, 11 Aug 2026 18:51:30 -0700 (PDT)
X-Received: by 2002:a05:6a20:2445:b0:3bf:6fb1:ce0d with SMTP id adf61e73a8af0-3cc3f73428fmr1392349637.21.1786499490016;
        Tue, 11 Aug 2026 18:51:30 -0700 (PDT)
Received: from hu-ashoraj-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31cf6d7a366sm4645303eec.27.2026.08.11.18.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 18:51:29 -0700 (PDT)
Date: Tue, 11 Aug 2026 18:51:27 -0700
From: Ashok Raj <ashok.raj@oss.qualcomm.com>
To: shijujose2008@gmail.com
Cc: rafael@kernel.org, bp@alien8.de, akpm@linux-foundation.org,
        rppt@kernel.org, dferguson@amperecomputing.com,
        linux-edac@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org, tony.luck@intel.com,
        lenb@kernel.org, Yazen.Ghannam@amd.com, mchehab@kernel.org,
        jic23@kernel.org, linuxarm@huawei.com, rientjes@google.com,
        jiaqiyan@google.com, Jon.Grimm@amd.com, dave.hansen@linux.intel.com,
        naoya.horiguchi@nec.com, james.morse@arm.com, jthoughton@google.com,
        somasundaram.a@hpe.com, erdemaktas@google.com, pgonda@google.com,
        duenwen@google.com, gthelen@google.com, wschwartz@amperecomputing.com,
        wbs@os.amperecomputing.com, nifan.cxl@gmail.com, tanxiaofei@huawei.com,
        prime.zeng@hisilicon.com, roberto.sassu@huawei.com,
        kangkang.shen@futurewei.com, wanghuiqiang@huawei.com,
        Ashok Raj <ashok.raj@oss.qualcomm.com>
Subject: Re: [PATCH v23 1/2] ACPI:RAS2: Add driver for the ACPI RAS2 feature
 table
Message-ID: <anvRn4g9Ihn5eyVq@hu-ashoraj-lv.qualcomm.com>
References: <20260726212812.89266-1-shijujose2008@gmail.com>
 <20260726212812.89266-2-shijujose2008@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260726212812.89266-2-shijujose2008@gmail.com>
X-Proofpoint-GUID: JP0ZRbwbVdNysmcBJildh5uEkoW975D7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDAxMSBTYWx0ZWRfX9FtUh9UlVejZ
 qL8HlDXHJKnas3W8mU0X1dCHsgmp9vU1oV5YBMR73bXcq8hUAx8RvqwxwBf4Rq7CMnhB0h7Bf3b
 G7ruMovuFAe1Hmd5xuH51qQbd+Q9oplUggMZ4bb0UHispxIZsOyKmrEmjG2c6j1EKqcpnxuRUYU
 kalJ1PzXS9TICqrtiXmn2OU65ID91gkBZTdkh7BIzUm94z2h9zWcQLKGTnJVZxQLV5kodQEUNAM
 3KdgpunSL44Fwlsm0LXXHNkM+IOcVu07kpIpg3rjGBI/8QXIaMiiUMrO6Xi0PrC4SO1No8ACcsm
 MnuCY+w2sYF9vLHSC3/cTjHZT+1wliB82BVQXdawzTJQVSsP99UvSX3CUAXBmjpREu0oTQmvGeV
 Fvh13F9IAmrYU5ZBj/WJPw6rEL9PROavFgL0dcjGq7NVrO8YftBLG5Iz4xnysomoFNsKrLlz9Jd
 2K30kwXZXLcM7BIjBVw==
X-Proofpoint-ORIG-GUID: JP0ZRbwbVdNysmcBJildh5uEkoW975D7
X-Authority-Analysis: v=2.4 cv=FbkHAp+6 c=1 sm=1 tr=0 ts=6a7bd1a3 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=pGLkceISAAAA:8 a=MvuuwTCpAAAA:8 a=VwQbUJbxAAAA:8 a=vzhER2c_AAAA:8
 a=EUspDBNiAAAA:8 a=O74ldG2G9i_vyk3S-34A:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=0YTRHmU2iG2pZC6F1fw2:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDAxMSBTYWx0ZWRfXxeLK9YV5z2aU
 x24kM/5X35Yh99fBYYlQ1mLLL5JS2g9yUfnwQ094axFZ51jQ/QlVFPm7abaiSuUcQtqASq1Vh48
 ZX1pMkREvB/ag8HJ0k/+diFJWzYnDNw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_06,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120011

Hi Shiju

On Sun, Jul 26, 2026 at 10:28:11PM +0100, shijujose2008@gmail.com wrote:
> From: Shiju Jose <shijujose2008@gmail.com>
> 
> ACPI 6.5 Specification, section 5.2.21, defined RAS2 feature table (RAS2).
> Driver adds support for RAS2 feature table, which provides interfaces for
> platform RAS features, e.g., for HW-based memory scrubbing, and logical to
> PA translation service. RAS2 uses PCC channel subspace for communicating
> with the ACPI compliant HW platform.
> 
> Co-developed-by: A Somasundaram <somasundaram.a@hpe.com>
> Signed-off-by: A Somasundaram <somasundaram.a@hpe.com>
> Co-developed-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
> Tested-by: Daniel Ferguson <danielf@os.amperecomputing.com>
> Reviewed-by: Ashok Raj <ashok.raj@oss.qualcomm.com>
> Signed-off-by: Shiju Jose <shijujose2008@gmail.com>
> ---
>  drivers/acpi/Kconfig  |  11 +
>  drivers/acpi/Makefile |   1 +
>  drivers/acpi/bus.c    |   3 +
>  drivers/acpi/ras2.c   | 509 ++++++++++++++++++++++++++++++++++++++++++
>  include/acpi/ras2.h   |  57 +++++
>  5 files changed, 581 insertions(+)
>  create mode 100644 drivers/acpi/ras2.c
>  create mode 100644 include/acpi/ras2.h
> 
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig

[snip]

> +int ras2_send_pcc_cmd(struct ras2_mem_ctx *ras2_ctx, u16 cmd)
> +{
> +	struct acpi_ras2_shmem __iomem *gen_comm_base;
> +	struct mbox_chan *pcc_channel;
> +	struct ras2_sspcc *sspcc;
> +	s64 time_delta;
> +	u16 val;
> +	int rc;
> +

[snip]

> +
> +	/* Ring doorbell */
> +	rc = mbox_send_message(pcc_channel, &cmd);
> +	/*
> +	 * mbox_send_message() returns a non-negative integer for successful submission
> +	 * and a negative value on failure.
> +	 */
> +	if (rc < 0) {
> +		dev_warn(ras2_ctx->dev,
> +			 "Error sending PCC mbox message command: 0x%x, rc:%d\n", cmd, rc);
> +		/* Restore CMD COMPLETE bit on error */
> +		val = ioread16(&gen_comm_base->status);
> +		val |= PCC_STATUS_CMD_COMPLETE;
> +		iowrite16(val, &gen_comm_base->status);
> +		return rc;
> +	} else {
> +		rc = 0;
> +	}

Minor: 

Sorry, I missed in prior review.

Can the else after return be removed?
just set rc = 0 should be sufficient.

Cheers,
Ashok
