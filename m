Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792516661;
	b=AJzf/IbgsfuiK1JPTm2297uuUDOw2DqI4bFzk9TjJkfHj4OHEfsnmaSWImpv2Jf3V5uM
	 trrWslC7MbUFZe4f+cC/zpxeY6+F8VfLw2IEaKDzVceNoO1osn4XL7Rk+udSUSlOfTql/
	 7zp4Qx87AP7YJyxI4/F4j3JvvklqzClKgYQFEZqBmDk+mPnFuilKYDJ2wPIVx6+TcO9D2
	 hZQQgbu0u2eh+Hgbw2758DYBS6hhGNLhAHjnORdUScwpFk+kd744EUE0fWcRm80SU/QGt
	 tjuNiP8gu128sXnyLiyAv+Mc+l6X7VWzDVDkc9nLnQSKvz5tnXiZ4hMyLzl+j8ZmHwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792516661;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:In-Reply-To:References:Organization:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=8QpGW0NKviFKo87+h3Yw2MqyJCFWY8ItSyPAh+yd9CU=;
	b=MpMXselTzJ2iVAlf5BYLhfHqOvS7Y5wLKUKyfEUJBCghKLxdA5JN0anC5ZCOkbScmsrP
	 dnrcmKWPQNQCjF2T63owrg80WORZBYuZY7kS5ZE9u2LWdGcS0zhbZwZX8RfgaEBQZ8xbl
	 i+KKHMHlmOC1T7GRTeThq8+SPjDXVStEDL15zLINdKn7elKJq3wZqxdibLstQBHYNlzUL
	 wOiZw+c57KUl0iqqrwd+cBO2C0XGXqo/tVfb5D+CZbpoBv1WC+VouIqmCs+myNFNfS2NX
	 eXCApZkNycmvHfCYGKbGMB+J1It0y2KgcoakO/G6iX5Hfnp4Q8bEDJMe1/3fRLNp7TQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=o38bSjL8;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="UAup/2JA";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCAA606AA20
	for <linux-acpi@vger.kernel.org>; Tue, 20 Oct 2026 17:17:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACCAA606AA20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=o38bSjL8;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UAup/2JA
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69KH8fT82825419
	for <linux-acpi@vger.kernel.org>; Tue, 20 Oct 2026 17:17:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8QpGW0NKviFKo87+h3Yw2MqyJCFWY8ItSyPAh+yd9CU=; b=o38bSjL8gGuVcSTR
	84CM4Pq1EbcbZXg06gl55UxMOt3BBBFXAaXlhz0Nc/GShV6IEjkXFGHydvYGngD2
	VWDoa1cxKjLCUINW6x8og6Dtz14ENY1wHuXJZjFmXtCs7UHDtkyuYfUOZctxHUMG
	RU7zRXlVTOEjoJXk1XJZTpa7bD+Dxx/ObdjSI1IHfj6nZO/ALnZPQKUz/AB84XqC
	6+lm/dnxdyJClEsJ0v6Kj75y8szAaCKkgPjuu3eS1oHzKvAuYzHxbkueXhY9l8DV
	LWibtU0pGo0GN0B+p5+rf0WBZMCTpZeHcXMQCFoftLI47o+VrrEDr64el1XjtOu+
	1D4cOQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5pknc3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Tue, 20 Oct 2026 17:17:39 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-35d4538fd74so11282860eec.1
        for <linux-acpi@vger.kernel.org>; Tue, 20 Oct 2026 10:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792516659; x=1793121459; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=8QpGW0NKviFKo87+h3Yw2MqyJCFWY8ItSyPAh+yd9CU=;
        b=UAup/2JANjHlehgL4D457pnNmE8SaXSCFIq9vhT/3GZbCc5kgLioH1qZjPgndMYLZh
         0ihez8m1TcJ8kAoxbnLUw9j5z4psxJTz2KWfmmxJAks+pdEYhDACJl1p4/m1JADl/oGH
         zqhW20dcNUElmvSM+jftJIkiMBihLMIn4J2lFUaCviR1aBpujwepCGxEvDB6x/2atg44
         yoXhRtVkvwZUbBhMXlTcZpEsGaPnkivcf15dfIEtOtQKZFVF4BlCZbQChWS21Ddiz6DZ
         JpwCtm4THAnJmFn+RZa0haEhUj31VcaFGnwokplqp2SeWg+9660Q3W3RRNO1iKD5Y0J2
         wlzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792516659; x=1793121459;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8QpGW0NKviFKo87+h3Yw2MqyJCFWY8ItSyPAh+yd9CU=;
        b=nKfKdeokMTSlbLWKHkdk5cbup0neCweGlvWHX690Ykebxmov99dbUyWer6oLMhH8Iz
         iGI2nkX96+uVWdznjaH9nqbY6GE1Zk9Tk2mkI5ybEprEM6Dm3zyn+ezWpQ/GymNj9PMo
         zgOf9dHEKDNEe8eUlpCmKHCtu/Tz8Lp+nfztwH9lh1cpxCiz6hL06mLAi6xYaYO1EG4P
         nwvri/gtyGIZI+KzjTY23NZ/zw3zxxedyUi7Ws6A7STBLaGgKk/fta+G8bxNdaphZhq8
         dTIm6gxL6LpLvtGvVdU49Q1a4SqoQJDDcXt1eGBOmyw7hgOW7a1bRxHabEpbE3JiUXdF
         BuDw==
X-Forwarded-Encrypted: i=1; AKwUvBwrhLFeKaTn/QjBQ92zsw128pxBqoHG+3AkAAqKMxJEA4tOKqGXEhM5yYHyVleQeFbjd5ksE0mzbj58@vger.kernel.org
X-Gm-Message-State: AFq9FYIXBBsZSVRgYPOZCOzvxgyAIOKn5khYPy3jHhKxBV+HLYFYOJ3+
	7f5v4B3bLJLfuLxkv26WFAroaqzSBjzxaM7mvGZwnjoc1AT2WyoXXDAj+UMrnLZZQnqISPWG+42
	bYZxsrL6YvtdWkJ3NStIfhMcB4pWU0PUmz9/BF9Znsb1YLd4yro447XGAnBKRMNuR
X-Gm-Gg: AYBFou1f2xHo3XpaAAajpDexk01aL6QQLtgBcG3ObNawB3LWawgtN/QA4Swl6c43rKc
	l5yOvj2AxW1Fx888tiz6WuptHa1Z0PqhRDlrjQHTDTLaARB2+PlzFhx8h3yQYnn8SDdwaFKRznL
	WHid/9M+JH0TBoFxmnH28cXECV+yeXFNs4Epl6Qf4c/XloYchHjigZeqRfjO5EQ+ezfBTZnYm1L
	wLdV9RqQdMmBeb5WNvRsVIhF/O5gypvdBfK4B+nws9GgHyAUwXbyPBQWUyrlNFM0/SZsqGmsHfH
	q/ATTjMKKbgZNu0p8lCBXNsykNeDr9mcI1QAr+Q8Hgd7mbZ7RtSN1ro5TRw51YRnHV764Y21niC
	Mu1xmAhuxE1oFLr6N7iov68zdyFFNIpsV7DUc8YMxzQ==
X-Received: by 2002:a05:7023:a47:10b0:15a:9834:73c9 with SMTP id a92af1059eb24-1851453f752mr15327635c88.40.1792516658210;
        Tue, 20 Oct 2026 10:17:38 -0700 (PDT)
X-Received: by 2002:a05:7023:a47:10b0:15a:9834:73c9 with SMTP id a92af1059eb24-1851453f752mr15327601c88.40.1792516657378;
        Tue, 20 Oct 2026 10:17:37 -0700 (PDT)
Received: from localhost (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903bb7f098sm5472c88.12.2026.10.20.10.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 10:17:36 -0700 (PDT)
Date: Tue, 20 Oct 2026 10:17:20 -0700
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
Subject: Re: [PATCH v2 5/6] ACPI: APEI: add separate Memory Error Section 2
 handlers
Message-ID: <20261020101720.00002545@oss.qualcomm.com>
In-Reply-To: <20261019203915.2019037-6-pierre.gondois@arm.com>
References: <20261019203915.2019037-1-pierre.gondois@arm.com>
	<20261019203915.2019037-6-pierre.gondois@arm.com>
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
X-Authority-Analysis: v=2.4 cv=a7WlZkSF c=1 sm=1 tr=0 ts=6ad7a233 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=7CQSdrXTAAAA:8 a=EUspDBNiAAAA:8 a=Rvnai5sDmRKbKYGs1KsA:9 a=CjuIK1q_8ugA:10
 a=PxkB5W3o20Ba91AHUih5:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: 008SKfbhbWPw3YpGE-Gq3joOxP6dCyE_
X-Proofpoint-GUID: 008SKfbhbWPw3YpGE-Gq3joOxP6dCyE_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA2OCBTYWx0ZWRfXxc9s7nDof41j
 qm8uQ53axtJSAijokBN1/oQXLrL6UVRxVrF+cXfLYA2Ig3AHHN/QqMiNzQonPWx6A6PP8jgL57b
 IM6+wReqNrsUwt0WsU3eiwC7gemG5PO+JBoTD6VZPWYbK4PQTZlG4fLuEEO8gCfLhqZaDjpaQq6
 T/O0MblpqgEuj/ZK8a/hWv7Ts7Q/aZsNZrwcHhNYWBKHr/wEx46dwYb4y7Cbl8AdWR+YeQVjKQc
 ppmQ8dgTP8TjfZRVg2Oxq1qcXBK+nzZoN23/f0vnz9zVbEcsmFOEK+DC1qwmbh5uXdONJyNPWPa
 uG5JfqEi8S7mPTIhHJ+ZWAJ/3yytd4+7vA4/Pae7W6lNfkwMw/4UoLgGPOJjgC3CQmEclQTTKjf
 tn48qzu3w5YMXVWU+U+RkMUJjFrossVjkrZVTCwalvim5avjHLpygw++2+URj0D59UA5raef9fy
 DTHRVcjrrmn4/5kztdw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA2OCBTYWx0ZWRfXyyvpMuZaOfnc
 hwpaPXII1jJKDeswKJ11YBc0pm/THd0+iHEEOeyBsR+hySlHnerAAI94wdDNcwTXrXQJ1xgZ+ke
 qOBsa2AE1n1t6R8h3IP/d0IiGuf+Mgo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_03,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 priorityscore=1501 adultscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200068

On Mon, 19 Oct 2026 22:38:44 +0200
Pierre Gondois <pierre.gondois@arm.com> wrote:

> Add dedicated GHES and EDAC callbacks for Memory Error Section 2
> records. Use a separate GHES notifier chain so existing consumers
> continue to receive legacy memory error sections.
> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
I think this is is ok. I don't love the dual notifier chains but
right now I also don't have a better idea.

So a somewhat tentative
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

Jonathan

> ---
>  drivers/acpi/apei/ghes.c |  49 +++++++++++++++-
>  drivers/edac/ghes_edac.c | 118 +++++++++++++++++++++++++++++++++++++++
>  include/acpi/ghes.h      |   2 +
>  3 files changed, 168 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index fe10ab0e02f6..c7fb15543b56 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -101,6 +101,7 @@
>  #endif
>  
>  static ATOMIC_NOTIFIER_HEAD(ghes_report_chain);
> +static ATOMIC_NOTIFIER_HEAD(ghes_report_mem2_chain);
>  
>  static inline bool is_hest_type_generic_v2(struct ghes *ghes)
>  {
> @@ -551,6 +552,29 @@ static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
>  	return false;
>  }
>  
> +static bool ghes_handle_memory_failure2(struct acpi_hest_generic_data *gdata,
> +					int sev, bool sync)
> +{
> +	int flags = -1;
> +	int sec_sev = ghes_severity(gdata->error_severity);
> +	struct cper_sec_mem_err2 *mem_err = acpi_hest_get_payload(gdata);
> +
> +	if (!(mem_err->validation_bits & CPER_MEM2_VALID_PA))
> +		return false;
> +
> +	/* iff following two events can be handled properly by now */
> +	if (sec_sev == GHES_SEV_CORRECTED &&
> +	    (gdata->flags & CPER_SEC_ERROR_THRESHOLD_EXCEEDED))
> +		flags = MF_SOFT_OFFLINE;
> +	if (sev == GHES_SEV_RECOVERABLE && sec_sev == GHES_SEV_RECOVERABLE)
> +		flags = sync ? MF_ACTION_REQUIRED : 0;
> +
> +	if (flags != -1)
> +		return ghes_do_memory_failure(mem_err->physical_addr, flags);
> +
> +	return false;
> +}
> +
>  static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
>  				     int sev, bool sync)
>  {
> @@ -915,7 +939,8 @@ static void ghes_log_hwerr(int sev, guid_t *sec_type)
>  		return;
>  	}
>  
> -	if (guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM)) {
> +	if (guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM) ||
> +	    guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM2)) {
>  		hwerr_log_error_type(HWERR_RECOV_MEMORY);
>  		return;
>  	}
> @@ -952,6 +977,16 @@ static void ghes_do_proc(struct ghes *ghes,
>  
>  			arch_apei_report_mem_error(sev, mem_err);
>  			queued = ghes_handle_memory_failure(gdata, sev, sync);
> +		} else if (guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM2)) {
> +			struct cper_sec_mem_err2 *mem_err = acpi_hest_get_payload(gdata);
> +
> +			if (gdata->error_data_length < sizeof(*mem_err)) {
> +				pr_warn(FW_WARN "Memory Error Section 2 length is too small\n");
> +				continue;
> +			}
> +
> +			atomic_notifier_call_chain(&ghes_report_mem2_chain, sev, mem_err);
> +			queued = ghes_handle_memory_failure2(gdata, sev, sync);
>  		} else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
>  			ghes_handle_aer(gdata);
>  		} else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
> @@ -1973,3 +2008,15 @@ void ghes_unregister_report_chain(struct notifier_block *nb)
>  	atomic_notifier_chain_unregister(&ghes_report_chain, nb);
>  }
>  EXPORT_SYMBOL_GPL(ghes_unregister_report_chain);
> +
> +void ghes_register_report_mem2_chain(struct notifier_block *nb)
> +{
> +	atomic_notifier_chain_register(&ghes_report_mem2_chain, nb);
> +}
> +EXPORT_SYMBOL_GPL(ghes_register_report_mem2_chain);
> +
> +void ghes_unregister_report_mem2_chain(struct notifier_block *nb)
> +{
> +	atomic_notifier_chain_unregister(&ghes_report_mem2_chain, nb);
> +}
> +EXPORT_SYMBOL_GPL(ghes_unregister_report_mem2_chain);
> diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
> index b90150c67f4b..01defc4e3bf1 100644
> --- a/drivers/edac/ghes_edac.c
> +++ b/drivers/edac/ghes_edac.c
> @@ -390,6 +390,122 @@ static struct notifier_block ghes_edac_mem_err_nb = {
>  	.priority	= 0,
>  };
>  
> +static int print_mem_error2_other_detail(const struct cper_sec_mem_err2 *mem, char *msg,
> +					 const char *location, unsigned int len)
> +{
> +	u32 n;
> +
> +	if (!msg)
> +		return 0;
> +
> +	n = 0;
> +	len -= 1;
> +
> +	n += scnprintf(msg + n, len - n, "APEI location: %s ", location);
> +
> +	if (mem->validation_bits & CPER_MEM2_VALID_ERROR_STATUS) {
> +		n += scnprintf(msg + n, len - n, "status(0x%016llx): ", mem->error_status);
> +		n += scnprintf(msg + n, len - n, "%s ",
> +			       cper_mem_err_status_str(mem->error_status));
> +	}
> +	if (mem->validation_bits & CPER_MEM2_VALID_STATUS)
> +		n += scnprintf(msg + n, len - n, "section_status:0x%02x ",
> +			       mem->status);
> +
> +	msg[n] = '\0';
> +
> +	return n;
> +}
> +
> +static int ghes_edac_report_mem_error2(struct notifier_block *nb,
> +				       unsigned long val, void *data)
> +{
> +	struct cper_sec_mem_err2 *mem_err = data;
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
> +	return NOTIFY_OK;
> +}

