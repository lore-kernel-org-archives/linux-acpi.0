Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A020F4A3D5E
	for <linux-acpi@vger.kernel.org>; Tue,  6 Oct 2026 18:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791310793; cv=none; b=RmNd2NOCezVi3o7xllHjvOGiEFiIZ23+5hXhgTxUatJy+mtihxCtlIIKtbHGjlxlB9Ar3Unk5Reg6NCWL004dD8YVLibqpWAkNHcYI4+DfqPE9eM3fqFZ2q+FVK7nwS8qh5ZsFHrB2Ex/j2VNF+PyqGlEz00xs84m+zYWyZgXw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791310793; c=relaxed/simple;
	bh=Wod9oGeD5WufeLQ9GfctH6+LN61xeZrD+JrPx+0eSfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KNgPHMYnCN1ir5qc6YDsUjAa6pQv3A1cc6nC2QhoCuvV2Jxr7DXGupIty+v5CdJe6II0ma+KmmcMRa1NIGy99rxu+rARMliRtWTcZxHnmVNYynmWUSgJbA9WLPWZ/CXYwojfnYi8NqjeEI50MmRvwZohyXBNWmdMlIBHyaYMBJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=I285338H; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kj3cH20A; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="I285338H";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kj3cH20A"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 696HfUXY519163
	for <linux-acpi@vger.kernel.org>; Tue, 6 Oct 2026 18:19:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=eErMTVv+GI4Tv4XbuyvCgn3L
	WQksVnWHpw5fdcoGEqI=; b=I285338HN6WS3wZTHKFiclQi87+58QmBhveu9Oaa
	PirLWkvMUxQq9UvUOJUFIolv122tUDXOUsE2Ugw0sbxN2xK3T6NtgIcUocti9/JO
	7zL3yfK9ZvPTjfcY/t7ETBBvxtrbwWwAvt79vZizt4yyt4S/gSym3vBxwvikiJ55
	JnnwprW3rdM7rM3GKSy2EZTo3n+YrFr1/GgvJtZ5JU2XIN8edDF3+I7woCzQCyDv
	9hLMhqokP0+KLqFq/UwL5A7uWW9ug59X7o0dk8rUrMz6vXVTdPgb80ezqbY5/TIY
	3D067Coff3bBeq/dJzDuRhvapbZQs5Yh3KdIJ/+Ny3M0CQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h53asgwp3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Tue, 06 Oct 2026 18:19:50 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-313d1015161so9382652eec.1
        for <linux-acpi@vger.kernel.org>; Tue, 06 Oct 2026 11:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791310790; x=1791915590; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eErMTVv+GI4Tv4XbuyvCgn3LWQksVnWHpw5fdcoGEqI=;
        b=kj3cH20AovK4Ze2C4NLzBpqKo/frCmOvdCoLYnGYjRZDMebEtGLZzHQ0+MVUxm1dXS
         wd68NQvje6qO8v27FyH9c6NEJtHzai0sQabLYmE3VJbHuDqjNvIgix6hfHVHso3l8YAH
         eq9+qEam149/mZ808CSnM46FoM1qBOisLxUkD5iDQQtQlk0yE5fDoHS8gI8+RheYKYVR
         s6CTV/tX2HupbeWsYV+9cCQMUIlP+GFT8UCkLBofChiua8sjSTeoiBh+Kuzpt55BtfgJ
         LbZTZkztdfop0BBBFdPrrb/B1RrpjoMJmgJcklN5UvKMw3DsXMSAp6CD4TNUjJZ+iI2o
         WpKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791310790; x=1791915590;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eErMTVv+GI4Tv4XbuyvCgn3LWQksVnWHpw5fdcoGEqI=;
        b=CLgolFdoIr0GoGSjhA6hE+flYDnhzT5rKsjhgyWntG87lTWeSY/bKW9A5kj2ymoHEk
         2qfoZ1y0XkdEwqKfzLx9rrGUSCT1Y8QDKaYb6GqXqNyD0UtGUpgstxvjhhgyRrahD7I3
         LAThGSyivrG/W2oIwcay/nhQhV0451ulDDd1Hr7aopCSdV4UzT0+nPw+EkXz/qpGzyFz
         +Hv0zk2NgALdsRVVtKwusnVEjCRR48HONHciqBDD92AMZOOeSEAyvPreuD0bqjU8nTR/
         yNfVx42gSDgavpFWmLm63rjHPHTtGQtt5tGZhbFgF2qx1sYVjc2ZRVfFyVyo2QM10w1a
         SZ9w==
X-Forwarded-Encrypted: i=1; AKwUvBzS242CaZkCEGCDkthy/5Wcv1Ojyj5/l0BTLUSbnDRCWuqFvRH2jbcZ69B6pzKdUHsWBQrUjNiJm0jg@vger.kernel.org
X-Gm-Message-State: AFq9FYJjnYl1IMJ+5IHS+2rV9KsKEQpcK4PT+nwofyuck6fqHiLldLra
	GNx9PCWFZXtDJK+dvjezpzXihved2w003nIOXQYmWrdbB/nL2ZnJAO/bw0KlHT6KJe1rwRGHg5X
	CpPP8/dPtUHp8wW5MFeOw5uKHuuBmRx4nhpMTqUVJAKnGDyt/TSWQYYD0rZgvTX6E
X-Gm-Gg: AYBFou03zzlXd7o35x+6j4B0o1dfUR0U36qsW0psMg6Jt8wdqUWmUS/hgp0PWmVoDNY
	lgwfIPmvzCIZ1AnwQujEfk8QkO/283HuF8sn6R/N8pr2dBoUXkrq1gVUt5/hfrwWczNoEY4zQG5
	9oQGL0NxAl+jQPIR4rXZogkncjiddLhN6++dsnUYUA9mHcMvgL6jHH1QjwXHwuLosuTPz9gyJcv
	C9oLbNlyRVVwXD1MAKBPl202WenJ2IBOlo0nrJgLhNNlCyx2cZCwIDb+OPZ1paxca754u/GUnQz
	8H8EEmG2TrjjpwEETnHL5E0z4WBWA3RJ2i1GhQEqwUm5Y0Qwfm7MmFYLEonvRboH4AtrNb32ehL
	JgAPQg31JfIorMF8iMSTOYkPInVaHoim661Xgt0QwNCUrZPvj
X-Received: by 2002:a05:7300:e9d9:10b0:34c:bc38:e2ee with SMTP id 5a478bee46e88-3514e2f4ca6mr2599967eec.8.1791310788850;
        Tue, 06 Oct 2026 11:19:48 -0700 (PDT)
X-Received: by 2002:a05:7300:e9d9:10b0:34c:bc38:e2ee with SMTP id 5a478bee46e88-3514e2f4ca6mr2599280eec.8.1791310773165;
        Tue, 06 Oct 2026 11:19:33 -0700 (PDT)
Received: from hu-ashoraj-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3515abb67e5sm302800eec.4.2026.10.06.11.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 11:19:32 -0700 (PDT)
Date: Tue, 6 Oct 2026 11:19:30 -0700
From: Ashok Raj <ashok.raj@oss.qualcomm.com>
To: Borislav Petkov <bp@alien8.de>
Cc: shijujose2008@gmail.com, rafael@kernel.org, akpm@linux-foundation.org,
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
        Ashok Raj <ashok.raj@oss.qualcomm.com>, ashoraj@qti.qualcomm.com
Subject: Re: [PATCH v23 1/2] ACPI:RAS2: Add driver for the ACPI RAS2 feature
 table
Message-ID: <asU7svV8g2Hb5DZl@hu-ashoraj-lv.qualcomm.com>
References: <20260726212812.89266-1-shijujose2008@gmail.com>
 <20260726212812.89266-2-shijujose2008@gmail.com>
 <20261005235021.GBasQ3vXTivT3NLbBq@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261005235021.GBasQ3vXTivT3NLbBq@fat_crate.local>
X-Proofpoint-ORIG-GUID: NQa_OZs0S7_T16yosBgPn8IzBo5g_-Ct
X-Proofpoint-GUID: NQa_OZs0S7_T16yosBgPn8IzBo5g_-Ct
X-Authority-Analysis: v=2.4 cv=Xt5vqlF9 c=1 sm=1 tr=0 ts=6ac53bc6 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=bC-a23v3AAAA:8 a=pGLkceISAAAA:8 a=MvuuwTCpAAAA:8 a=VwQbUJbxAAAA:8
 a=vzhER2c_AAAA:8 a=EUspDBNiAAAA:8 a=NDcxwIbCrCWPj7GKXwgA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22 a=FO4_E8m0qiDe52t0p3_H:22 a=0YTRHmU2iG2pZC6F1fw2:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA3MyBTYWx0ZWRfX1vC0mVBeWbVN
 4XNHQIzPbmiyPeaD/ohCbBb2HQjkmm9KOWWWebCdms0Tm/IZLVs9svePi9lTTtVeJN6nyHd5Zm2
 t7WNcV48gBF7Ypt2EK/HWmyfD6Y/1va4QOtq3DWl/1PixRXQuG4YGcibSVrbC7I6WfMav4a+O5r
 NzeYcNiogm/rpIKACtI8SsQNe2w3D4aja31T2zj1dKF92U1jj0CGymyTbYbkfydXYYkk96Cyp20
 RdaMdzc+t5AmQNBEtkiBA6sbMTzlKfGzgC4DV+4kztdrAh5TPwhVmAEtWv9HxpozLRipvmOxQfW
 jmsBCuAkZTXqmkpMu0OPuqlNQ0AiRBtPwQU+DDBlRotcA0ze0rJsXpCC37yUL6QGSlqjDNP5VIg
 1kWlmTMMpJo3b7VDc7ETRlLlWFr7CzGEKyQse6g4NHodLyya1pMxGDf/lhtVaahG6Jv33A4uSip
 +DcZ/Z2ylnxmsNR3d2Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA3MyBTYWx0ZWRfX8oIAu4mhlTvS
 HnOXeGA5wm5bum/2QbwX2eR0xJ9/D5Djf8IkTYnhYD7P7FhQREzpQDA63A6Z2cEm2T6qyeSuoF0
 +yTB1VEk53vJPFNTiVgDjyxhFlOf16w=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_05,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 clxscore=1015 phishscore=0
 impostorscore=0 suspectscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060073

Boris, Hi

everything looks great, just one minor ordering bug we discovered, noted
below.


On Mon, Oct 05, 2026 at 04:50:21PM -0700, Borislav Petkov wrote:
> On Sun, Jul 26, 2026 at 10:28:11PM +0100, shijujose2008@gmail.com wrote:
> > From: Shiju Jose <shijujose2008@gmail.com>
> > 
> > ACPI 6.5 Specification, section 5.2.21, defined RAS2 feature table (RAS2).
> > Driver adds support for RAS2 feature table, which provides interfaces for
> > platform RAS features, e.g., for HW-based memory scrubbing, and logical to
> > PA translation service. RAS2 uses PCC channel subspace for communicating
> > with the ACPI compliant HW platform.
> > 
> > Co-developed-by: A Somasundaram <somasundaram.a@hpe.com>
> > Signed-off-by: A Somasundaram <somasundaram.a@hpe.com>
> > Co-developed-by: Jonathan Cameron <jic23@kernel.org>
> > Signed-off-by: Jonathan Cameron <jic23@kernel.org>
> > Tested-by: Daniel Ferguson <danielf@os.amperecomputing.com>
> > Reviewed-by: Ashok Raj <ashok.raj@oss.qualcomm.com>
> > Signed-off-by: Shiju Jose <shijujose2008@gmail.com>
> > ---
> >  drivers/acpi/Kconfig  |  11 +
> >  drivers/acpi/Makefile |   1 +
> >  drivers/acpi/bus.c    |   3 +
> >  drivers/acpi/ras2.c   | 509 ++++++++++++++++++++++++++++++++++++++++++
> >  include/acpi/ras2.h   |  57 +++++
> >  5 files changed, 581 insertions(+)
> >  create mode 100644 drivers/acpi/ras2.c
> >  create mode 100644 include/acpi/ras2.h
> 
> Ok, went through it one last time, I hope. Caught a bunch of things, see
> changelog. See below if it still does what it should.
> 
> Thx.
> 
> ---
> From: Shiju Jose <shijujose2008@gmail.com>
> Date: Sun, 26 Jul 2026 22:28:11 +0100
> Subject: [PATCH] ACPI:RAS2: Add a driver for the ACPI RAS2 feature table
> 
> The ACPI 6.5 Specification, section 5.2.21, defines a RAS2 feature table
> (RAS2). Add a driver supporting that RAS2 feature table and which provides
> interfaces for platform RAS features, e.g., for HW-based memory scrubbing, and
> logical to PA translation service. RAS2 uses PCC channel subspace for
> communicating with the ACPI compliant HW platform.
> 
>   [ bp:
>    - Massage commit message
>    - in ras2_send_pcc_cmd():
>     - check check_pcc_chan() retval
>     - remove else assignment to rc = 0 after mbox_send_message() call
>    - Do proper error unwinding in register_pcc_channel()
>    - Do proper error unwinding for auxiliary_device_init() in
>      add_aux_device()
>    - Cleanup parse_ras2_table() some
>    - drop ras2_ prefix from all static functions
>    - unbreak long lines
>    - minor touchups ]

Your cleanup and unwind path is good!

> 
> Co-developed-by: A Somasundaram <somasundaram.a@hpe.com>
> Signed-off-by: A Somasundaram <somasundaram.a@hpe.com>
> Co-developed-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Shiju Jose <shijujose2008@gmail.com>
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> Reviewed-by: Ashok Raj <ashok.raj@oss.qualcomm.com>
> Tested-by: Daniel Ferguson <danielf@os.amperecomputing.com>
> Link: https://patch.msgid.link/20260726212812.89266-2-shijujose2008@gmail.com
> ---
>  drivers/acpi/Kconfig  |  10 +
>  drivers/acpi/Makefile |   1 +
>  drivers/acpi/bus.c    |   3 +
>  drivers/acpi/ras2.c   | 517 ++++++++++++++++++++++++++++++++++++++++++
>  include/acpi/ras2.h   |  57 +++++
>  5 files changed, 588 insertions(+)
>  create mode 100644 drivers/acpi/ras2.c
>  create mode 100644 include/acpi/ras2.h
> 

[snip]

> +
> +static struct ras2_sspcc *sspcc_get(int pcc_id)
> +{
> +	struct ras2_sspcc *sspcc;
> +
> +	guard(mutex)(&sspcc_lst_lock);
> +	list_for_each_entry(sspcc, &sspcc_lst, elem) {
> +		if (sspcc->pcc_id != pcc_id)
> +			continue;
> +
> +		if (!kref_get_unless_zero(&sspcc->kref))
> +			break;
> +
> +		return sspcc;
> +	}
> +
> +	return NULL;
> +}
> +
> +static int register_pcc_channel(struct ras2_mem_ctx *ras2_ctx, int pcc_id)
> +{
> +	struct pcc_mbox_chan *pcc_chan;
> +	struct ras2_sspcc *sspcc;
> +	int ret;
> +
> +	if (pcc_id < 0)
> +		return -EINVAL;
> +
> +	sspcc = sspcc_get(pcc_id);
> +	if (sspcc) {
> +		ras2_ctx->sspcc	    = sspcc;
> +		ras2_ctx->comm_addr = sspcc->comm_addr;
> +		ras2_ctx->dev	    = sspcc->pcc_chan->mchan->mbox->dev;
> +		ras2_ctx->pcc_lock  = &sspcc->pcc_lock;
> +
> +		return 0;
> +	}
> +
> +	sspcc = kzalloc(sizeof(*sspcc), GFP_KERNEL);
> +	if (!sspcc)
> +		return -ENOMEM;
> +
	__mbox_bind_client() reads knows_txdone at bind time to promote the
	channel off MBOX_TXDONE_BY_POLL. It must be set before requesting the
	channel, otherwise the channel stays on polling and mbox_client_txdone()
	later hits the mailbox core's "Client can't run the TX ticker" guard.

	sspcc->mbox_client.knows_txdone = true;

> +	pcc_chan = pcc_mbox_request_channel(&sspcc->mbox_client, pcc_id);
> +	if (IS_ERR(pcc_chan)) {
> +		ret = PTR_ERR(pcc_chan);
> +		goto ret_err_mbox;
> +	}
> +
> +	if (!pcc_chan->shmem || pcc_chan->shmem_size < sizeof(struct acpi_ras2_shmem)) {
> +		ret = -EINVAL;
> +		goto ret_err_shmem;
> +	}
> +
> +	sspcc->pcc_id		= pcc_id;
> +	sspcc->pcc_chan		= pcc_chan;
> +	sspcc->comm_addr	= pcc_chan->shmem;
> +
> +	if (pcc_chan->latency)
> +		sspcc->deadline_us = PCC_NUM_RETRIES * pcc_chan->latency;
> +	else
> +		sspcc->deadline_us = PCC_NUM_RETRIES * PCC_CHNL_DEFAULT_LATENCY;
> +
> +	sspcc->pcc_mrtt		= pcc_chan->min_turnaround_time;
> +	sspcc->pcc_mpar		= pcc_chan->max_access_rate;
> +
> +	sspcc->mbox_client.knows_txdone	= true;

        ^^^^ This needs to be set before request_channel above. 
> +
> +	mutex_init(&sspcc->pcc_lock);
> +	kref_init(&sspcc->kref);
> +
> +	mutex_lock(&sspcc_lst_lock);
> +	list_add(&sspcc->elem, &sspcc_lst);
> +	mutex_unlock(&sspcc_lst_lock);
> +
> +	ras2_ctx->sspcc		= sspcc;
> +	ras2_ctx->comm_addr	= sspcc->comm_addr;
> +	ras2_ctx->dev		= pcc_chan->mchan->mbox->dev;
> +	ras2_ctx->pcc_lock	= &sspcc->pcc_lock;
> +
> +	return 0;
> +
> +ret_err_shmem:
> +	pcc_mbox_free_channel(pcc_chan);
> +
> +ret_err_mbox:
> +	kfree(sspcc);
> +


Cheers,
Ashok
