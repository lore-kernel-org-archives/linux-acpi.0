Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792437887;
	b=t9U8Vh0exLoMKNtnuiNFBb79tceXz98icLUUKKpYb6fb15TZGQxuOVXMMqd0pmoUxFXY
	 4ZXK5fwRGaxUwa05ps4iq/RarwZOEJ1d9iMEx624vT+C+S+ybkLvQ00NnAcXYAPgXM1m4
	 dCRkJiWCYp0uPOHm4RTwyp+AVtKELGPXfGupQUtp0FsOYP0m1ooBx2W7M07O58rP3wZf3
	 VCaTnuqO9fPJmjDT0d+gXS92WoQZFd7CQ/Z97xsqD7fEq2YvTXODvovLorsKy8vsxK6g8
	 656mSvh3CQ63W0w88Ku7HRzvpG3aOH53QMCar5CTYZZSL2pzmvnIYa8X1/uvZiG9TDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792437887;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:In-Reply-To:References:Organization:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=BMUhm5+GJQEDK7W/pa/hsK7Ip8Ta9HhXsuNAgIn4IXI=;
	b=pR2kRWHE3QHc70QGbYPxf6iVpDy4W+QrAJLiNg+RcpDTWFIb3QwxjkxbsCEPfaPcqkn/
	 S6zndniehsGgNjr9syjsym/b9Sio/PqxJUI4fIj6idgwJgeTs5OnTnC4vALzoEwkArFXz
	 62KYfKrvLOyupiZZtB4xIL2uMXx6FhG0HcJ9FM0a4+sIzEiV+Chh9ZHrd8U5mS0ZBDkZT
	 TbZtZ8uWSIi5YF5j24BgpKmAHX/7HYnzPLp0WDHJtEW/9b6mw2vAatAmf720lw2z45c/B
	 ZuC5b1HkeuQlmLbzGTnNLNaRvjAHDoPpiiu8PRtoWJQloTb8V0yD6o/y1M/GNvPqfHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CRwJAm+R;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HwYMibNg;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E969C606A31F
	for <linux-acpi@vger.kernel.org>; Mon, 19 Oct 2026 19:24:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E969C606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CRwJAm+R;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HwYMibNg
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69JJK2e33475507
	for <linux-acpi@vger.kernel.org>; Mon, 19 Oct 2026 19:24:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BMUhm5+GJQEDK7W/pa/hsK7Ip8Ta9HhXsuNAgIn4IXI=; b=CRwJAm+RXy3ZPfsk
	5y75LciccvrkroJApArGjvbL3WqdD5rIV/kvilAJo627eH2fu9ELzN90n+3tN3Ey
	OVo88iw9RoigRazM2oaGyz0oBqvnOYctvMHsYT5ECl3xWAX9z08SRLyWomJi3YkD
	MN0Z9pORPMppiZ7oqIQNUz+/YuQiyETnx5R+Kb68NqBNc6tABTfLKwkZ0Nh+eAlc
	tqDlldWEkZOln4AuvvnwKkAfoCi2Ijluszem9JSs+vPvqNoBInQ82Rx7Lp3kGCOV
	PcprY7NqODq584+bgpx5E8Oy4j1rgDS+P52Tqb78AdgH1UJozluk/nnG/QCaKe/R
	eVR16g==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdqtf8d55-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Mon, 19 Oct 2026 19:24:44 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-18b5ee75447so3295993c88.1
        for <linux-acpi@vger.kernel.org>; Mon, 19 Oct 2026 12:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792437884; x=1793042684; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=BMUhm5+GJQEDK7W/pa/hsK7Ip8Ta9HhXsuNAgIn4IXI=;
        b=HwYMibNgPmS0T0TZtOxNxsVoiIgehjEEU/TY5O05LL2dnOwIp+UTHW4PQ6ZevTjHKq
         sNC1vQuLh/atS0x/YFc8TCgD5CAa2w4QwjyOlnSjIIfaJ2ck6cwZhA5PLos+KegvVgOA
         aBy2zqkni6aNeLtIQNO+e0WryVMlz3xvQtNUeS/iUXrWEUMTGzu9bv7qUUex7E4XBwC8
         oxJ2MMdx24irMtSda5O5FiKRbckgDOoIj2WxFbUh3N7i45rW4AZEDBK7jQGeiSI3D05x
         CzC8irXB/2nJd3dsd9YvBx/fuEtU/fgU2t1r2BuRdVXU20JSic+8g8iA8JmdT/L/EOD2
         EUKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792437884; x=1793042684;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BMUhm5+GJQEDK7W/pa/hsK7Ip8Ta9HhXsuNAgIn4IXI=;
        b=Wgkx3XIpsTlD3kZUUnbvGk88M2jmSkuV4TCckb0lInqCDCTP4NmtKBxSrc5rqXWgGG
         ixUAJoLlkoeyk9hKPWGRfhLbsbHKG5candO4frMvsA7cIjdUgJqMDsPRrefdK2Rk9G8d
         jBt/HF/YCkaui0duPgvqLeCzf+uqRR0H+qGbeob7S7fake0LCVWjSQtpAaEoXjpedKac
         p7wJ+UDkGNUJnXjzFK54e8Ez6YYWJ4n1wKpXeHe3q9ughfFJBRk+uLoyDBmuoB7ICcfH
         l2S1V6fTln9vsGLtY8r4MqaEGfa4x1FI4kLbnM/g5y/0U0pHiJg4Ets8h4V1EoO3cxAe
         80QA==
X-Forwarded-Encrypted: i=1; AKwUvByIPQBbme7yeCl2s9JiPHzoeOvLpUiA3ebSaYBSXUWvfiGJW1pqefHft7LBQfFkt81skai/Q7+7K+Ka@vger.kernel.org
X-Gm-Message-State: AFq9FYL3HBcAVPL+u7pTSzAgRTVqGk2263+l7+444VF8kJLN4CIbcjYV
	3QqrzAoyOPEzk9lIKA5Nv6PT1UbmjNGCbPQfsjxgpJljKeDlDKpAq3uGMici8pNFhAC25O+H7M2
	Ipd+7GaJyw4lOEKZKt+D6jFci4FqmfZHxhzXTE9cdZABL7gbI2p5/hr16AUWZQ80H
X-Gm-Gg: AYBFou3UyDZ1VkJljvAdG3mfIxjMBe804xWQcqXFGX95KC5cwlYpsboxCncu7y+A4hh
	JTIIuDT6jlCX/7vQkOSY1Bgk3tX3mJd6WV5Zi3x0hAYchuIeXbdtGJbJBeR1P7+B1plP+zlp3BZ
	oPp0qGBcvUSv9mgkotAfvrp9I7001DDqFgUI6zA52qV6mQfplwhZebsONwvFt0MwrYwCS4eK2Dm
	cOrtUdutLM3epymvVbFZYyqLNg0AF4FVJD/nDWeyHku470EzeaoS9zHhMU+8NuMXAScCjTQgJL2
	6GlSZ52jlhbFQCpp7/LfFW1VwSwkDwAoWU38tcknB8OdJjN6Sj8I52335C4whJqrpgtQmEMB1wN
	ucKn1/70MXT5ZlmKV9YaICRKiGrzu+QJi7PHjDByMw2l9AVlOGppaEQ==
X-Received: by 2002:a05:701b:4308:b0:15a:2b63:a0cb with SMTP id a92af1059eb24-18511ad8bacmr13577099c88.13.1792437883592;
        Mon, 19 Oct 2026 12:24:43 -0700 (PDT)
X-Received: by 2002:a05:701b:4308:b0:15a:2b63:a0cb with SMTP id a92af1059eb24-18511ad8bacmr13577069c88.13.1792437882911;
        Mon, 19 Oct 2026 12:24:42 -0700 (PDT)
Received: from localhost (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831b37ce3fsm27157689c88.14.2026.10.19.12.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 12:24:42 -0700 (PDT)
Date: Mon, 19 Oct 2026 12:24:35 -0700
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
Subject: Re: [PATCH 5/6] ACPI: APEI: add separate Memory Error Section 2
 handlers
Message-ID: <20261019122435.000079c0@oss.qualcomm.com>
In-Reply-To: <20261019145643.1877246-6-pierre.gondois@arm.com>
References: <20261019145643.1877246-1-pierre.gondois@arm.com>
	<20261019145643.1877246-6-pierre.gondois@arm.com>
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
X-Authority-Analysis: v=2.4 cv=SpEFe/O0 c=1 sm=1 tr=0 ts=6ad66e7c cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=7CQSdrXTAAAA:8 a=rtJ9AlOumMsWe6EQo_MA:9 a=CjuIK1q_8ugA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA3NyBTYWx0ZWRfX9y/sNBLW2Yqt
 +Vgjv+TFuHn595NxEDoG+3zacAtTa6Nq946w1a7mMHkP9V9dK5GQAFIuTqyzRTcTplR8bntoD9L
 ztkbOb4qdjpREJ4XiTAZTmyxSWoHT8+U/LYl02rhQhJEBfg+WLGiea2W1ZUbolBNXRHGb7oYW1f
 65PaRlNMOE5q6hpM0silOonSMJAFFXAEiw9V8Y1aOC4Dej1Y9u2Pq006Ra9rbMor6Cu74TDyBU9
 decqR2dkFrmqroBOn3B6Okm1Cu+vKU6lT2JpKe+vjyuusIAJGE0dqBaEAErXkCjhP10a6E4r4gL
 FQ3Hn0Y05rh+kroPVc1UHxRAVavFLR+0UukXFhCstzRFkvVsIltl8iP6OfzB9RbYfdZNTJRIB80
 m4bcQlqbLWbZUU4tXr/901RfKW1YWipXi41PbEsEbv6b222s5SFietlJ8WQHr15xqvjmFwJ71j6
 5VZ767GmhOGh0NpWjsA==
X-Proofpoint-GUID: 7AyMtokVEuRoqJ5kH56rks7RKvHs10FW
X-Proofpoint-ORIG-GUID: 7AyMtokVEuRoqJ5kH56rks7RKvHs10FW
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA3NyBTYWx0ZWRfX/hSyC8IpP0dB
 rRTc/Av6YP4V9GI7U20cIsGj/w1zAPJMQLPkHKwp6EZLJwVUrx20mxrELXQu8UQY6LntEIJGMD0
 VXYgGhlMhumXS7+LnwywGnL9wawYaZo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190077

On Mon, 19 Oct 2026 16:56:12 +0200
Pierre Gondois <pierre.gondois@arm.com> wrote:

> Add dedicated GHES and EDAC callbacks for Memory Error Section 2
> records. Use a separate GHES notifier chain so existing consumers
> continue to receive legacy memory error sections.
> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
A few trivial things inline. 

Otherwise I'm fine with this though as you noted before the duplicating
is a bit annoying.

> ---
>  drivers/acpi/apei/ghes.c |  49 ++++++++++++-
>  drivers/edac/ghes_edac.c | 150 +++++++++++++++++++++++++++++++++++++++
>  include/acpi/ghes.h      |   2 +
>  3 files changed, 200 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index fe10ab0e02f6..c7fb15543b56 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c


> diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
> index d80c88818691..b18460ba8f40 100644
> --- a/drivers/edac/ghes_edac.c
> +++ b/drivers/edac/ghes_edac.c

> +
> +static int ghes_edac_report_mem_error2(struct notifier_block *nb,
> +				       unsigned long val, void *data)
> +{
> +	struct cper_sec_mem_err2 *mem_err = data;
> +	struct edac_raw_error_desc *e;
> +	struct mem_ctl_info *mci;
> +	unsigned long sev = val;
> +	struct ghes_pvt *pvt;
> +	unsigned long flags;
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
> +	spin_lock_irqsave(&ghes_lock, flags);

Perhaps use a guard so you can simplify error paths a little.

> +
> +	pvt = ghes_pvt;
> +	if (!pvt)
> +		goto unlock;
> +
> +	mci = pvt->mci;
> +	e = &mci->error_desc;
> +
> +	/* Cleans the error report buffer */
> +	memset(e, 0, sizeof(*e));
> +	e->error_count = 1;
> +	e->grain = 1;
> +	e->msg = pvt->msg;
> +	e->other_detail = pvt->other_detail;
> +	e->top_layer = -1;
> +	e->mid_layer = -1;
> +	e->low_layer = -1;
> +	*pvt->other_detail = '\0';
> +	*pvt->msg = '\0';
> +
> +	switch (sev) {
> +	case GHES_SEV_CORRECTED:
> +		e->type = HW_EVENT_ERR_CORRECTED;
> +		break;
> +	case GHES_SEV_RECOVERABLE:
> +		e->type = HW_EVENT_ERR_UNCORRECTED;
> +		break;
> +	case GHES_SEV_PANIC:
> +		e->type = HW_EVENT_ERR_FATAL;
> +		break;
> +	default:
> +	case GHES_SEV_NO:
> +		e->type = HW_EVENT_ERR_INFO;
> +	}
> +

Almost everything down to here is not memerr2 specific maybe factor
out an initialization helper for the edac structure?

> +	edac_dbg(1, "error validation_bits: 0x%08llx\n",
> +		 (long long)mem_err->validation_bits);
> +
> +	/* Error type, mapped on e->msg */
> +	if (mem_err->validation_bits & CPER_MEM2_VALID_ERROR_TYPE) {
> +		u8 etype = mem_err->error_type;
> +
> +		p = pvt->msg;
> +		p += snprintf(p, sizeof(pvt->msg), "%s", cper_mem_err_type_str(etype));
> +	} else {
> +		strscpy(pvt->msg, "unknown error");
> +	}
> +
> +	/* Error address */
> +	if (mem_err->validation_bits & CPER_MEM2_VALID_PA) {
> +		e->page_frame_number = PHYS_PFN(mem_err->physical_addr);
> +		e->offset_in_page = offset_in_page(mem_err->physical_addr);
> +	}
> +
> +	/* Error grain */
> +	if (mem_err->validation_bits & CPER_MEM2_VALID_PA_MASK)
> +		e->grain = ~mem_err->physical_addr_mask + 1;
> +
> +	/* Memory error location, mapped on e->location */
> +	p = e->location;
> +	p += cper_mem_err2_location(mem_err, p);
> +
> +	if (mem_err->validation_bits & CPER_MEM2_VALID_MODULE_HANDLE) {
> +		struct dimm_info *dimm = NULL;
> +
> +		p += cper_dimm_err2_location(mem_err, p);
> +		if (mem_err->mem_dev_handle <= U16_MAX)
> +			dimm = find_dimm_by_handle(mci, mem_err->mem_dev_handle);
> +		else
> +			pr_warn(FW_WARN "Memory Error Section 2 module handle 0x%x exceeds SMBIOS range\n",
> +				mem_err->mem_dev_handle);
> +		if (dimm) {
> +			e->top_layer = dimm->idx;
> +			strscpy(e->label, dimm->label);
> +		}
> +	}
> +	if (p > e->location)
> +		*(p - 1) = '\0';
> +
> +	if (!*e->label)
> +		strscpy(e->label, "unknown memory");
> +
> +	/* All other fields are mapped on e->other_detail */
> +	p = pvt->other_detail;
> +	p += print_mem_error2_other_detail(mem_err, p, e->location, OTHER_DETAIL_LEN);
> +	if (p > pvt->other_detail)
> +		*(p - 1) = '\0';
> +
> +	edac_raw_mc_handle_error(e);
> +
> +unlock:
> +	spin_unlock_irqrestore(&ghes_lock, flags);
> +
> +	return NOTIFY_OK;
> +}


