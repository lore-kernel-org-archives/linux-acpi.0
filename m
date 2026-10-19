Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792438146;
	b=GZDOEM4R6WdoTloKQfylPmv5wcvodYwrpEQT4mMiOjiYO+uVm3srbLuMwN4cvGNJsj2m
	 NGWP+zIHoaUmPuwEwm1u98mR/XvT7hq+VBuC/3ItVTLydSmyYc/5UKoedGgTXq/vLMwoB
	 ke4Ks3GIvyzwNE15dvwbZu0rSq71WXjPC9pgQwJAp2HgS13w0I9cNbMq9JwnlqyjxN4vg
	 cHY3wTKsqR3O8N2/azbePawxjmd4wTjNmDE3ACwpXNNNGHijBr02OwFGKc2ef1DIa4ddc
	 aJQm9nxjRm3WKonglCGtMrxqaT/o68mZfQw8WnBY+5B7/+fdfmzhfE9ixVB+o1AgX3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792438146;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:In-Reply-To:References:Organization:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=HTr+bxbq66BXfG6Xfngcx7CALmbZE47aY8OHfPSSUbQ=;
	b=o+6lXrrK8+PSYVNwJEbPUIIo6f2wbeF5D1KlHsi8Oy9BQDp/6xjw/5U3Chht+AggrJsY
	 5by2pb9WfDehC87SRmpADbLD5a5uKe3JMiXAU207rKrPDbqZkb4HcorDE0MGNFOgIC0b0
	 1x9B6ootWi3YTW7WLy9TpDIWtYLw9XqFlWs63/G4mELLOWrifQ7ah2RF07EPRwiQZrWJU
	 O3H9BWDS2hb/re9W3yAeQv/IbRgkCDm8AwUADW6+NnpN0ITQN/Qga7jxr/aRbjtJ3uthj
	 AD9SOBNptztm5fvNvn+c8CD/XCWq2iXImYFBKxsEs/wdNTnRDBt++E3vCpjhk+hV4lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="SS/rmX7J";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bBtiWEl1;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A42606A320
	for <linux-acpi@vger.kernel.org>; Mon, 19 Oct 2026 19:29:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21A42606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SS/rmX7J;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bBtiWEl1
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69JJJwqe3103316
	for <linux-acpi@vger.kernel.org>; Mon, 19 Oct 2026 19:29:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HTr+bxbq66BXfG6Xfngcx7CALmbZE47aY8OHfPSSUbQ=; b=SS/rmX7J69jv854K
	k6MYKuuktMkMKa56Fl1yxD1LV2ygTDQvqgdK8dPvPdZlOpL8zrxqpx9kHI28gBnq
	c9G9slGZ8HAfXo5PP8qKCplKLa9k9oLmOFprlF3rOM4v5uFC2qEiHdO421kY/Y6U
	ACeRgV8WsFawbBLYvcR3IB1kn2sB/Z+ZDd6ZbKmyb+TDsIVSPTBI8qbGn+pv0WhV
	2Bd7KQJBN4rdXRYuUXvCMKXL08zzg+DYIs+0ER9g8OToavQC4Mxwa4LI4DsX3QaX
	rYV39n4h+5KDRa3Xsa7vNr5j4zUO9UN6kWMt9xhxNDaDDZPKss3g89ej2nvlxN/r
	402beQ==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdr4q0a89-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Mon, 19 Oct 2026 19:29:05 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-151ba226e1bso3948007c88.0
        for <linux-acpi@vger.kernel.org>; Mon, 19 Oct 2026 12:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792438144; x=1793042944; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=HTr+bxbq66BXfG6Xfngcx7CALmbZE47aY8OHfPSSUbQ=;
        b=bBtiWEl1lGHf72/8jyeel4rRs0qjlVLNeDBfGnaYm2OTQk4nvOjAx7FYFURRy5F9Be
         BcZXMCvDmkerS8fDEnyOfa+PtNZYJguIi+4BRAaq6XexEH1OqVbud94Xp8d0BYRTxJMN
         XOPWIzPGC0Q7vN6XI5KDpniV44XQOu9XGxPVYbEZMjWLrALf00mSbIr4aRNT7PpjAElJ
         5UtTpNsH0QiqUM+BfMOF3uVqI3jttoenPShRzw4VYv7i4g7E6hvxxiXp0CCJ7iIUOAyX
         yOB+gzgVi7GZbY2DfXN+YODExo4Nrb7XEIMNBtJlXxDTPZLh2/1x5w1n6mfIcjTTVDMy
         Ts/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792438144; x=1793042944;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HTr+bxbq66BXfG6Xfngcx7CALmbZE47aY8OHfPSSUbQ=;
        b=TlzODrTPtfxhlA/StybuV6BgSFewBBMLd4eEoIHZh5XCpd2Sbm683musD43/sk/SDy
         LTxIvcaPZvNbQFgxDYga4t/l8WO2j4QyeTTA4nraGxVWynFpAnmfDD5fGnlRUsGMMxQX
         XSJ2n6CCqGnZL1CLzb4ED1TIjxhwlJU5hIDCCkQwci2dbagL7a6O8MBPlhYjy24KtBym
         YmbmCaCygDCsc0xavnsK5bwtabLaCcqOuVULXT9MX2hVtr9mEv6cnlrS04M4Hjqg7Tiw
         LtCtkMlfew0cN2Q6bOt1rrDC/kOS5Lb4RXgKv16f/zYGvBcbb5pPFmqLqFvF65nSH8ug
         6Y/g==
X-Forwarded-Encrypted: i=1; AKwUvBw0wOoSzt6w2qfF4fC3OHSBwBi/wWxxMyRsjqev4Sw9sDhx3JVsf/gP6XujqlZYQlcW/qMVRqKBys8l@vger.kernel.org
X-Gm-Message-State: AFq9FYKf408chlEIfhXtbIkR0TBVo7jD474zlvqAKTtpBwnYDVFf9KYL
	ThAp4iF/xJhwZUsjTcy0oqEyZc5TQy8DhxTllxd/gZWTbAhJcZIBWG+mtuCiS/DR92ESHcc5s6K
	RrI+gCG57TUNzEOn7KfH5jWrywLtNV6Bne+7/jTRbYkMsWlJTnXVgBn26SWGb2WZt
X-Gm-Gg: AYBFou1qTEL8JvtBnKi9cyD/hXF+RNYKo2G0v1SrsZPZ7ZIMqmRwqpDHUMjUar4jCiN
	YZZTpHELXwxTt1zwFDPy6jGCaJ18X5e+crUEk0oYkpP/nj89yfwXwbe15gwCckY/YYVn3g3XOuU
	UvKeeEUzY1/vQZaEwOrAkI1/zJbW+AiAOl4OGe7cM9/NCq0of/WIesRsceo0ak57J/Q4qJ7ucKU
	KMMVKSkqYrt5X5NZEDQKb6ANNQdQxRws3CUfWAarYXEUGqvmp27SECreSURKpPxHzfxhLu48DqR
	ItMZ9E1k+rlAh9W8CLV3tIL38I56pI7Md6dVVc1S9Bgla1fIhpEjNUBvC66uMbzBdPxyI68ou4/
	CK3W4rEQumweFkSoLdl9s556ZryLNr4XudsV55BvRRg==
X-Received: by 2002:a05:701b:2902:b0:16a:c6f2:60c2 with SMTP id a92af1059eb24-18512c381bdmr9816935c88.12.1792438144220;
        Mon, 19 Oct 2026 12:29:04 -0700 (PDT)
X-Received: by 2002:a05:701b:2902:b0:16a:c6f2:60c2 with SMTP id a92af1059eb24-18512c381bdmr9816894c88.12.1792438143497;
        Mon, 19 Oct 2026 12:29:03 -0700 (PDT)
Received: from localhost (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831ba424a6sm30689377c88.17.2026.10.19.12.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 12:29:03 -0700 (PDT)
Date: Mon, 19 Oct 2026 12:28:58 -0700
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
 <leitao@debian.org>, Dan Williams <djbw@kernel.org>,
        Terry Bowman
 <terry.bowman@amd.com>, Ard Biesheuvel <ardb@kernel.org>,
        Morduan Zang
 <zhangdandan@uniontech.com>, linux-acpi@vger.kernel.org,
        linux-edac@vger.kernel.org, acpica-devel@lists.linux.dev
Subject: Re: [RFC PATCH 6/6] ACPI: extlog: add Memory Error Section 2 trace
 event
Message-ID: <20261019122858.00006cce@oss.qualcomm.com>
In-Reply-To: <20261019145643.1877246-7-pierre.gondois@arm.com>
References: <20261019145643.1877246-1-pierre.gondois@arm.com>
	<20261019145643.1877246-7-pierre.gondois@arm.com>
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
X-Proofpoint-ORIG-GUID: XmbFcUkfFqosDbzxbCiBDd_JB8T_GaMz
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA3NyBTYWx0ZWRfX3kEe8XTVZR77
 kPPzHPdBfo7hQqjBbncwF91BEb2isDQ1XwS+DWjInFmY4dHOo3GBjW2tNKIK1j1CNB6fVk7YlTS
 is9JZG1OfitxyocyhNMV+loZmibagQ0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA3NyBTYWx0ZWRfX5RCKTIcT7vPa
 Vx/+0B1jBrKLKZNldRca2TFeJDKHeW6mcSzh/LN37sop0ASlN0ZJ52QXMWzQBOuVZNTXYwoqGj4
 m430FONSqNtVTjKi8deBK5V2aMQfbynpEsCPEi+2i4ETrCK4tNlCUUt7/0j7oNery8vjOX/GJdC
 nWWT+PUeq3tzYbhUQDU0sLPXJUdlgw8c3X+C4refHgYmhcZtrbGh5A2AwUzUAl+5zpy3jy+lYeq
 tnO1d6RDSOAHd91mhutoDFfcFs4KM1VvnWbjhTlgzTvXsyXXL7I0Y9R/pAplCGigEWFyi+OKmAV
 4/TNaUpgbMtU909KTdyjM4I5cPFzo5pXCqzcc06I4JSa0lnRtXzqye0X/YL2oilIuf4PR4gA2md
 ZYzJndGwUSmB6dbxjEYUuBFRH/E24mYFWXVCXXRLQdzIyX6ykbPrEuJMAlOfGVHAMNy61xfwPkk
 LvJcL/IoHEa8P/8rfWg==
X-Authority-Analysis: v=2.4 cv=aqsnmiZV c=1 sm=1 tr=0 ts=6ad66f81 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=7CQSdrXTAAAA:8 a=EUspDBNiAAAA:8 a=U8d67ivYhA4UYEs2wG4A:9 a=CjuIK1q_8ugA:10
 a=vr4QvYf-bLy2KjpDp97w:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: XmbFcUkfFqosDbzxbCiBDd_JB8T_GaMz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190077

On Mon, 19 Oct 2026 16:56:13 +0200
Pierre Gondois <pierre.gondois@arm.com> wrote:

> Add a separte handling for Memory Error Section 2 trace events with:
> - extlog_mem2_event()
> - extlog_mem2 trace event
> The fields of the record are individually printed so userspace
> can discover the layout more dynamically if a new field is added.

How useful are the pair of handles?

Otherwise I'm fine with this - subject to same comment as on patch 1.

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> ---
>  drivers/acpi/acpi_extlog.c |  16 ++++++
>  drivers/ras/ras.c          |   1 +
>  include/ras/ras_event.h    | 102 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 119 insertions(+)
> 
> diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
> index e764d61f71ca..9c0b932e22bc 100644
> --- a/drivers/acpi/acpi_extlog.c
> +++ b/drivers/acpi/acpi_extlog.c
> @@ -189,6 +189,15 @@ extlog_mem_err_event(struct cper_sec_mem_err *mem, u32 err_seq,
>  #endif
>  }
> 
> +static void
> +extlog_mem_err2_event(struct cper_sec_mem_err2 *mem, u32 err_seq,
> +		      const guid_t *fru_id, const char *fru_text, u8 sev)
> +{
> +#if defined(CONFIG_ACPI_EXTLOG) || defined(CONFIG_ACPI_EXTLOG_MODULE)

Same comment as earlier patch about oddity of protecting stuff in a file
that is normally only built if they are set.


> +	trace_extlog_mem2_event(mem, err_seq, fru_id, fru_text, sev);
> +#endif
> +}
> +
>  static int extlog_print(struct notifier_block *nb, unsigned long val,
>  			void *data)
>  {
> @@ -241,6 +250,13 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
>  				extlog_mem_err_event(mem, err_seq, fru_id,
>  						     fru_text,
>  						     (u8)gdata->error_severity);
> +		} else if (guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM2)) {
> +			struct cper_sec_mem_err2 *mem = acpi_hest_get_payload(gdata);
> +
> +			if (gdata->error_data_length >= sizeof(*mem))
> +				extlog_mem_err2_event(mem, err_seq, fru_id,
> +						      fru_text,
> +						      (u8)gdata->error_severity);
>  		} else if (guid_equal(sec_type, &CPER_SEC_CXL_PROT_ERR)) {
>  			struct cxl_cper_sec_prot_err *prot_err =
>  				acpi_hest_get_payload(gdata);
> diff --git a/drivers/ras/ras.c b/drivers/ras/ras.c
> index 03df3db62334..c6b14202a5e9 100644
> --- a/drivers/ras/ras.c
> +++ b/drivers/ras/ras.c
> @@ -111,6 +111,7 @@ subsys_initcall(ras_init);
> 
>  #if defined(CONFIG_ACPI_EXTLOG) || defined(CONFIG_ACPI_EXTLOG_MODULE)
>  EXPORT_TRACEPOINT_SYMBOL_GPL(extlog_mem_event);
> +EXPORT_TRACEPOINT_SYMBOL_GPL(extlog_mem2_event);
>  #endif
>  EXPORT_TRACEPOINT_SYMBOL_GPL(mc_event);
>  EXPORT_TRACEPOINT_SYMBOL_GPL(non_standard_event);
> diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
> index fdb785fa4613..0c0dbe068dc8 100644
> --- a/include/ras/ras_event.h
> +++ b/include/ras/ras_event.h
> @@ -74,6 +74,108 @@ TRACE_EVENT(extlog_mem_event,
>  		  &__entry->fru_id,
>  		  __get_str(fru_text))
>  );
> +
> +/*
> + * Memory Error Section 2 exposes each field separately so userspace can
> + * discover its layout. Validation bits use the UEFI Section 2 assignments.
> + */
> +TRACE_EVENT(extlog_mem2_event,
> +	TP_PROTO(const struct cper_sec_mem_err2 *mem,
> +		 u32 err_seq,
> +		 const guid_t *fru_id,
> +		 const char *fru_text,
> +		 u8 sev),
> +
> +	TP_ARGS(mem, err_seq, fru_id, fru_text, sev),
> +
> +	TP_STRUCT__entry(
> +		__field(u32, err_seq)
> +		__field(u8, sev)
> +		__field_struct(guid_t, fru_id)
> +		__string(fru_text, fru_text)
> +		__field(u64, validation_bits)
> +		__field(u64, error_status)
> +		__field(u64, physical_addr)
> +		__field(u64, physical_addr_mask)
> +		__field(u16, node)
> +		__field(u16, card)
> +		__field(u16, module)
> +		__field(u16, bank)
> +		__field(u32, device)
> +		__field(u32, row)
> +		__field(u32, column)
> +		__field(u32, rank)
> +		__field(u32, bit_pos)
> +		__field(u8, chip_id)
> +		__field(u8, error_type)
> +		__field(u8, status)
> +		__field(u64, requestor_id)
> +		__field(u64, responder_id)
> +		__field(u64, target_id)
> +		__field(u32, mem_array_handle)
> +		__field(u32, mem_dev_handle)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->err_seq = err_seq;
> +		__entry->sev = sev;
> +		__entry->fru_id = *fru_id;
> +		__assign_str(fru_text);
> +		__entry->validation_bits = mem->validation_bits;
> +		__entry->error_status = mem->error_status;
> +		__entry->physical_addr = mem->physical_addr;
> +		__entry->physical_addr_mask = mem->physical_addr_mask;
> +		__entry->node = mem->node;
> +		__entry->card = mem->card;
> +		__entry->module = mem->module;
> +		__entry->bank = mem->bank;
> +		__entry->device = mem->device;
> +		__entry->row = mem->row;
> +		__entry->column = mem->column;
> +		__entry->rank = mem->rank;
> +		__entry->bit_pos = mem->bit_pos;
> +		__entry->chip_id = mem->chip_id;
> +		__entry->error_type = mem->error_type;
> +		__entry->status = mem->status;
> +		__entry->requestor_id = mem->requestor_id;
> +		__entry->responder_id = mem->responder_id;
> +		__entry->target_id = mem->target_id;
> +		__entry->mem_array_handle = mem->mem_array_handle;
> +		__entry->mem_dev_handle = mem->mem_dev_handle;
> +	),
> +
> +	TP_printk("{%u} %s error: validation_bits: 0x%llx "
> +		  "error_status: 0x%llx physical_addr: 0x%llx "
> +		  "physical_addr_mask: 0x%llx node: %u card: %u "
> +		  "module: %u bank: %u device: %u row: %u column: %u "
> +		  "rank: %u bit_pos: %u chip_id: %u error_type: %u "
> +		  "status: 0x%x requestor_id: 0x%llx responder_id: 0x%llx "
> +		  "target_id: 0x%llx mem_array_handle: 0x%x "
> +		  "mem_dev_handle: 0x%x FRU: %pUl %.20s",
> +		  __entry->err_seq, cper_severity_str(__entry->sev),
> +		  __entry->validation_bits,
> +		  __entry->error_status,
> +		  __entry->physical_addr,
> +		  __entry->physical_addr_mask,
> +		  __entry->node,
> +		  __entry->card,
> +		  __entry->module,
> +		  __entry->bank,
> +		  __entry->device,
> +		  __entry->row,
> +		  __entry->column,
> +		  __entry->rank,
> +		  __entry->bit_pos,
> +		  __entry->chip_id,
> +		  __entry->error_type,
> +		  __entry->status,
> +		  __entry->requestor_id,
> +		  __entry->responder_id,
> +		  __entry->target_id,
> +		  __entry->mem_array_handle,
> +		  __entry->mem_dev_handle,
> +		  &__entry->fru_id, __get_str(fru_text))
> +);
>  #endif
> 
>  /*
> --
> 2.43.0

