Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792516184;
	b=fpynzb0EcsO+aKgdu+SRyFM91XuoutJM+raPRtWMQHX2M/uxi7uTXgL2muGcMuGRDDEp
	 jpWpiOhEu38/srLa0pkcONsTj5wwkgKCdwqmv9hzVNDAwRsLvQyHOdlsIbfPrmtJp9Aqn
	 ZFv9poRPi0hluO+ce7p2zB57NnMdmiKYCGiDxGHYG+5RxjerdAUAlVTmLxRoqWTuRkgxq
	 j50TncDb0NGGNxLnG8B4KcRkyvLpsGRWm9xj25+X5RqCJDGUTFwSYi/vojVuS/tQgjnAR
	 HqKOTJKdxoT4951VH3J//gZVpiLk56oP0TUBJHDDaXXXmCUjJNHduPul0sV0BoJ1Zaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792516184;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:In-Reply-To:References:Organization:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=ohKpVZsSLKBqP3rLFRPbU8Ml4RClO3TAOr5rDUCda/w=;
	b=dotfbFFhXr1g4SpMeHi0B3+FfY2b4YDrP34nadleprjuHv9N48fexrzT9brb8Cs/6wQ0
	 qM9DkpFcRTD00m8wtEMKE078plxO9iqiYQ0zF4nAiQOHXBCJBs6xL2Ccq/OGlKGUlH5oS
	 zJuYCk3tP5zHuPwsZiPmKFjd/hwsi1ZDOuYlFnjRWaLZke6RhZT39AYi8YVw1sNhfDghi
	 7A4urXyYAfp/ueFhPStjeqJxJ6gNQhbaydj8IxKXs1MHN+sNfzCiU/vp8KvVNYHgvmmZU
	 B15qivFH1fvKAQcp4GhJTv6WLzgIlQp6jEc5dl4/ewVWuoKzCK4KCo69YkwFJnJakxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="Q/srjOz3";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Nfnimphx;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031D9606A319
	for <linux-acpi@vger.kernel.org>; Tue, 20 Oct 2026 17:09:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 031D9606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Q/srjOz3;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Nfnimphx
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69KGteEh1706500
	for <linux-acpi@vger.kernel.org>; Tue, 20 Oct 2026 17:09:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ohKpVZsSLKBqP3rLFRPbU8Ml4RClO3TAOr5rDUCda/w=; b=Q/srjOz30TRKb0h+
	4i5NmNJzhXLuqckNdw/mg0I4BdzGglVTPPTqazzLFsx/Egq97m2DlLg9ue++z7ip
	6WVn7ZjlY/g7VfeucNdjyKyQZBNhpJucWzQD5lIZza3YJBHioVSU/aQsJG5snWE+
	Im9EeDhgIeH6Tr6y7/Qg5R1Kx+t3F746jDmWcVzfNxurlDL8JrmGFSL4mbP/TR6Z
	aQTdpZjm32+Rfs1bQ91lVPuoYRNQ+jDPXKIX7UfBMgGyReFum7adrZOaF813VB8E
	Zsna3eTyugakMRuQrPgQRVqqJkEknK00/GysSDNSK6Mzns/CW3C2UlGAMBjbAmPT
	68aWnQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5pbk5k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Tue, 20 Oct 2026 17:09:43 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-30c0d568830so7539286eec.1
        for <linux-acpi@vger.kernel.org>; Tue, 20 Oct 2026 10:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792516183; x=1793120983; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ohKpVZsSLKBqP3rLFRPbU8Ml4RClO3TAOr5rDUCda/w=;
        b=NfnimphxzgfsO/GkUvcaO4SumU3i9GpUDe4RfT6pGXGqUBtDmLwb+DW1MbhTST0ekv
         WCPZb7Z9LZeKWrSovuhSbww/g7nd+4s6N+CWpMjqlBw6eOR0yA64jTFZamVdhpevlTI5
         341I7ZpmY+wQxmjT/YD6ujimF8Q2Rn3O5Um5DnDToAjWLwQhjjJzRs7LrwNvMUqsVJfS
         w6kWPm7REJdUtdjUael+6OQleEH0XekiZoA85/AEA2L/z+4lq9fVmXmV5JtfgqfufZJk
         GsmrgQ1MoiMMXhpj8t+yyEk1K7IVpZuLW1vyxgMgPYuvrMMSme4n9I8fkS5hyB2FCKQF
         3BdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792516183; x=1793120983;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ohKpVZsSLKBqP3rLFRPbU8Ml4RClO3TAOr5rDUCda/w=;
        b=zIlgQtxbmFFzCqpzjuR/jC56gikIEPfktiWzjsucbUoxwmzOphYxaXk9dWGCRxHXAi
         2Yl6VyP6YU4XuIipQDcWNYCGdTrHlg/PTAtEabNnvrTtgsuuYQxMjigZzXAGBXk5wzoT
         F4zPwuG8taPf4TReE3OW3dYIV1dYuoFEHQ+OzBDbtjFyHLMFJN5tkqbUx3N0kpAPWdXX
         YAmz9EDIqI7fWvvcX5y4tgyeIVxvjfgFoWjC9I5aA1NTzXSc1mKgNOwZE9TtwXRBNAX2
         +TOmIZe1qmSF/Sd7ofc+3P0YhITctUOK61y1fJiTT78ITA0YXgX7TN4z6NgOVaH3C4n4
         3f/Q==
X-Forwarded-Encrypted: i=1; AKwUvBzpXTYWcOV0UJpjFGAMUJI7yjb5zJNySgxJDmGDNGvKyAHtdYYa1ObL/1SlnCEtMuWE3zFegLUMsT1W@vger.kernel.org
X-Gm-Message-State: AFq9FYIfPPBH0EAQEA0SpJxHRWZBSPqLUsOm0P2EbcrqflAe3vJEvxNa
	5GuQLgm4Zy9+Jm9ujQxT2bo1Th8+s2YGd+AS9zSsyDNzyAZPXdaOaik+QIzsifedUxPVS3gSMnv
	vpVTS+wt+y+luHXIoS4WCUCOetMoUI6ufZC+xxy6psUhmVg1Y54Fl9dvfBdoPrGUC
X-Gm-Gg: AYBFou3yn0bJdeYamh7UYRtzEakcKH1Gyvx1IsJ+DDuXlUIAVNXZKt+g9hBbvSz0bfO
	KQVlqHNqrsVH+aRrly1HWIXSPHm/fGIkzYUBOAnSAO4w1X8s/KyPZ1dl/ZZk3PQlTXhaop36ZFe
	X32s1Ly+uVPa63bgy5PjiIZxc1NUF80x/ZFpe6TsO8sy0XLENwXVh8AEXLHuTxR39VPrEvY9huG
	nu6YKHXTRJFHI/NHfojCyQddiADiFhKIbZ/ygV89w7B4/BExwEat7JpUjJmFZSp/eSPtzXtvHzN
	HQ42MHKBnpjH/k5jfNk1w3gyCyk+qsroPZA6mSb4A7Cc07Vu8zH3haJnWydnkBvNgpjlRDbudae
	us48pHAJQx5XdrN+i4qCI1Cw9qrOSUlZjcC7lxcsxIVE=
X-Received: by 2002:a05:7300:10d:b0:351:1e89:66ab with SMTP id 5a478bee46e88-361a0e85fc5mr16354990eec.7.1792516182370;
        Tue, 20 Oct 2026 10:09:42 -0700 (PDT)
X-Received: by 2002:a05:7300:10d:b0:351:1e89:66ab with SMTP id 5a478bee46e88-361a0e85fc5mr16354944eec.7.1792516181614;
        Tue, 20 Oct 2026 10:09:41 -0700 (PDT)
Received: from localhost (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3673b1d0ab7sm123492eec.0.2026.10.20.10.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 10:09:41 -0700 (PDT)
Date: Tue, 20 Oct 2026 10:09:37 -0700
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
        Mark
 Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, Len
 Brown <lenb@kernel.org>,
        Tony Luck <tony.luck@intel.com>, Borislav Petkov
 <bp@alien8.de>,
        Hanjun Guo <guohanjun@huawei.com>,
        Mauro Carvalho Chehab
 <mchehab@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Maciej
 Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        Pawel Chmielewski
 <pawel.chmielewski@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>,
        Breno Leitao
 <leitao@debian.org>, Terry Bowman <terry.bowman@amd.com>,
        Dan Williams
 <djbw@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        Morduan Zang
 <zhangdandan@uniontech.com>, linux-acpi@vger.kernel.org,
        linux-edac@vger.kernel.org, acpica-devel@lists.linux.dev
Subject: Re: [PATCH v2 4/6] EDAC/ghes: Extract error report initialization
Message-ID: <20261020100937.00000d06@oss.qualcomm.com>
In-Reply-To: <20261019203915.2019037-5-pierre.gondois@arm.com>
References: <20261019203915.2019037-1-pierre.gondois@arm.com>
	<20261019203915.2019037-5-pierre.gondois@arm.com>
Organization: Qualcomm
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: b7BSbpEcKU6_CNSfsfH6J6cqN3rjhH23
X-Authority-Analysis: v=2.4 cv=fb84WEQF c=1 sm=1 tr=0 ts=6ad7a057 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=7CQSdrXTAAAA:8 a=rxnY8KSqnLZGKI4wGMoA:9 a=CjuIK1q_8ugA:10
 a=scEy_gLbYbu1JhEsrz4S:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA2OCBTYWx0ZWRfX92n25xjAP4te
 UFwyBNGgGrSvE3ixFhHzAomKg2obq+B2mDqNdrQ2S3gOGaAavQaxBLTGzC7wQobMWP0XTxxoAfZ
 DAvhmdaGGHtB/o9AbCDWsUkj4eAgrNWuwER+yndGXQV1Ajb8Yl/JjOS//XoiFaBGo4RhF+DzYxF
 1aM0Z025vTVkjFk2WTUp8tp82It5L8e6NzkL1/7z+HjC9Qi/T1GSVEEhz2Eb8x+3A73UVQh8ntr
 4iS+s1ifFYMppQ/9IpsumDF6YmIw7292Y7VmwFPigOk5+vk/dJA+dBxloT3RbGZCX+xlXKJ6q9d
 yo73qXD04rm9B6wueSwB0bPLSHzh5cZUnWua24Y+y72LU9LvlzBJxSppQEfuqpCiq1r2Imtezgc
 JiW9W5YIcBOS9hZO0+aunTKeRtuzcMbkOEasghluOukQyHLph9svxW4x39zRt4XGkKpcsSxClJa
 IWExsxU8B2M16P/fQkg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA2OCBTYWx0ZWRfX91UFWTCx8CQg
 ICeWN1b4QqffgILyMi7VW+9y/2BWApneilWZR7zg2GJ2AuqxEA0K+Pzh8KEStwnlgmqRedfQ74h
 Y8BWlKxmzdWnrEWniZMoGFtMZFjqXDo=
X-Proofpoint-ORIG-GUID: b7BSbpEcKU6_CNSfsfH6J6cqN3rjhH23
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_03,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 phishscore=0 clxscore=1015 bulkscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200068

On Mon, 19 Oct 2026 22:38:43 +0200
Pierre Gondois <pierre.gondois@arm.com> wrote:

> Extract a ghes_edac_init_error() function to prepare for
> Memory Error Section 2 support (and re-usage).
> 
> Also use a guard in the caller ghes_edac_report_mem_error()
> function for code simplification.
> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> ---
>  drivers/edac/ghes_edac.c | 66 +++++++++++++++++++++-------------------
>  1 file changed, 35 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
> index d80c88818691..b90150c67f4b 100644
> --- a/drivers/edac/ghes_edac.c
> +++ b/drivers/edac/ghes_edac.c
> @@ -267,37 +267,14 @@ static int print_mem_error_other_detail(const struct cper_sec_mem_err *mem, char
>  	return n;
>  }
>  
> -static int ghes_edac_report_mem_error(struct notifier_block *nb,
> -				      unsigned long val, void *data)
> +/* Caller must hold ghes_lock. */
> +static struct edac_raw_error_desc *
> +ghes_edac_init_error(struct ghes_pvt *pvt, unsigned long sev)

Slightly unusual to have an init function that doesn't directly take the thing
being initialized. I'd pass it in. The clearly of pvt->msg and pvt->other_detail
is also a bit of a surprise for a function that claims to be initializing something
else so I'd do those outside of the helper.

Or maybe rename helper to something like
ghes_edac_fill_error_from_pvt() 
Not sure that really conveys the modification of pvt data hidden in here though.

Perhaps this refactor was a bad suggestion from me and better to just duplicate
the code.  What do ACPI maintainers think?



>  {
> -	struct cper_sec_mem_err *mem_err = (struct cper_sec_mem_err *)data;
> -	struct cper_mem_err_compact cmem;
> -	struct edac_raw_error_desc *e;
> -	struct mem_ctl_info *mci;
> -	unsigned long sev = val;
> -	struct ghes_pvt *pvt;
> -	unsigned long flags;
> -	char *p;
> -
> -	/*
> -	 * We can do the locking below because GHES defers error processing
> -	 * from NMI to IRQ context. Whenever that changes, we'd at least
> -	 * know.
> -	 */
> -	if (WARN_ON_ONCE(in_nmi()))
> -		return NOTIFY_OK;
> -
> -	spin_lock_irqsave(&ghes_lock, flags);
> -
> -	pvt = ghes_pvt;
> -	if (!pvt)
> -		goto unlock;
> -
> -	mci = pvt->mci;
> -	e = &mci->error_desc;
> +	struct edac_raw_error_desc *e = &pvt->mci->error_desc;
>  
>  	/* Cleans the error report buffer */
> -	memset(e, 0, sizeof (*e));
> +	memset(e, 0, sizeof(*e));
>  	e->error_count = 1;
>  	e->grain = 1;
>  	e->msg = pvt->msg;
> @@ -323,6 +300,36 @@ static int ghes_edac_report_mem_error(struct notifier_block *nb,
>  		e->type = HW_EVENT_ERR_INFO;
>  	}
>  
> +	return e;
> +}
> +
> +static int ghes_edac_report_mem_error(struct notifier_block *nb,
> +				      unsigned long val, void *data)
> +{
> +	struct cper_sec_mem_err *mem_err = (struct cper_sec_mem_err *)data;
> +	struct cper_mem_err_compact cmem;
> +	struct edac_raw_error_desc *e;
> +	struct mem_ctl_info *mci;
> +	struct ghes_pvt *pvt;
> +	char *p;
> +
> +	/*
> +	 * We can do the locking below because GHES defers error processing
> +	 * from NMI to IRQ context. Whenever that changes, we'd at least
> +	 * know.
> +	 */
> +	if (WARN_ON_ONCE(in_nmi()))
> +		return NOTIFY_OK;
> +
> +	guard(spinlock_irqsave)(&ghes_lock);
> +
> +	pvt = ghes_pvt;
> +	if (!pvt)
> +		return NOTIFY_OK;
> +
> +	mci = pvt->mci;
> +	e = ghes_edac_init_error(pvt, val);
> +
>  	edac_dbg(1, "error validation_bits: 0x%08llx\n",
>  		 (long long)mem_err->validation_bits);
>  
> @@ -375,9 +382,6 @@ static int ghes_edac_report_mem_error(struct notifier_block *nb,
>  
>  	edac_raw_mc_handle_error(e);
>  
> -unlock:
> -	spin_unlock_irqrestore(&ghes_lock, flags);
> -
>  	return NOTIFY_OK;
>  }
>  

