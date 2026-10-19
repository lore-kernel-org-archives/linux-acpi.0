Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792427817;
	b=2Q/UJaINpmh/wy2L7SKE2WhrjjIc/NSn1ibv/JBLC/lW9tHxjoiY6lCzkqXXEYVjgixc
	 ftg5+NvXwab6g4+ga9eQaPKzPZy8wjqk6M7nqSxoD4OTXoHGUQBqTVMgpux0hUllFkoeX
	 h1Cr0Df80E3U1HXsGBkYP/2NVfbG5016JRiUZ39JK2pgH7H8cB0tgAoF24q/FQ1Ugg+c8
	 zuwsxPOVxKDErTzja2z8LkfFlQkVBchsst2SLk/JuO80o2qSQK7TUvjGCtC6iqHlhaAWP
	 AiFHS46OYfp14TNQnDerPH33KnEUy/TZSFwhUw5rhOgetr0muM9KT+2YLvF3/6uO48A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792427817;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:In-Reply-To:References:Organization:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=uTVSO8ab0jQ/KjHFQURA4S+jRgewRPU6KcTy4l+JKt4=;
	b=4XIE+8l/MfD4GbooyJyP0mvVbQZjgFYjVVyLI7/vTzK6ItiSrrdASRJfLOkwPl5S5dvw
	 3slVxyusIbclClTf00LMCCE/T/fmo9MZesmmsj2KlQgw5AEnqV60koGkDC514bwjm/vGW
	 q8V/8J3EC6WgC0Lu8Ew7daUnjgR7tbBLD8K6svY2Frv+Vj00NVoDz3Iw6Aa/VptQCZGOK
	 qgy0HqyLIEQyEmhv8jOIZFmtqQquAwymIj9OcjbWv2g0UouYOtCIJ2/jVq4fC+7OioqLl
	 ehRLVtj3GlrRSSkrVdQ7RkBF9jIoP2TISfwW3F8GD1XKlyHhWBN2ULs/731iJ8Bpweg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=azHp1q7f;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=G2Z2JlTn;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D72606A31E
	for <linux-acpi@vger.kernel.org>; Mon, 19 Oct 2026 16:36:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72D72606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=azHp1q7f;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=G2Z2JlTn
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69JFOt4j2268952
	for <linux-acpi@vger.kernel.org>; Mon, 19 Oct 2026 16:36:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uTVSO8ab0jQ/KjHFQURA4S+jRgewRPU6KcTy4l+JKt4=; b=azHp1q7fFlayj682
	T/VARjrDTiPkCoAzbrEhkv5N4zr9RyByqFCSUaojW32+2aUJK1SkDMuw39ScaRKc
	OnvAmeMXBTQdg/azB3dFJt2fog+F/NLMl9/aubFu74LcqLgotTAuJ+rKPqBvWIqN
	6NvzGdqW8yQ/ru2SjpIwNuGOPnJT+qOPA6NJCVLDqN/NHp3tyEZQlayHYaDfWx4S
	uy0S/gBW7qBIXOj3IBUTkQ5jFZhu8Zz1ngzQ/PnSDPjzx9eDTmFTQgkKkYBS6hzc
	me0gddDb9T/COwyB/Mn8kWfh156r5vLsUaygLKEOgNSYwhBqu65yYt3uvUWtSx4K
	aLcSXw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf4rj6kn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Mon, 19 Oct 2026 16:36:56 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-3592749a017so2381289eec.1
        for <linux-acpi@vger.kernel.org>; Mon, 19 Oct 2026 09:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792427816; x=1793032616; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=uTVSO8ab0jQ/KjHFQURA4S+jRgewRPU6KcTy4l+JKt4=;
        b=G2Z2JlTnCQObFnglXbWhjlwKZbzzNZSy9LvfaWBKq+nU/9ftzJ8i3tNYCMiBENuf8N
         HG/0Be72qS8GdVSSg5Qr3uchXfRrNlRkVfj0chISzazgA1malT9mtZHNzfYUheJucrm2
         YngrLpm0GGW9wu97gpSBywoI5fIsGARfoPWHYZ6muMHoJ6dKJCWruZWyRL+eU9VGJgej
         6Ac6TdqK7AVwUnEU9zbabhfyGHqNOplEke98+U1L3BgaAl7B5kvVwbS0130xXnSoplmo
         8GfJsqXzQfrfT8EpyQ5992MBHVlbID18PiIfVoH5U774oj6N9r6kS3eeysBVRHNHEUeX
         IiSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792427816; x=1793032616;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uTVSO8ab0jQ/KjHFQURA4S+jRgewRPU6KcTy4l+JKt4=;
        b=B0QMp3prUbY4e6HJd9zDilA1eFcYFLjWFBmt76+f5bpXmApj38RfCLsLhqUIL4A7c2
         uyD1tcXQq0YDLRM9WFIr7G0XfcViUJSEna2mW+3+dsfciT9sRAwezNMv31XuJ2n3VFsh
         UoS0Op3RP+l0lARQEbTDvgEtXjEzY7vqSYpnzrvJQB2361FTjxVZ8kxJ7uOnxoXs7d9O
         bPsxuXBbJ0a2SPeN0RAkqjbqFGbGa2pQSaSR1HZkY4WRZd/e6Dth9YSN/tGK5rIP0Rmt
         ZNM5nyM1JVuVhhyiqgdeTFFRJeMaYQ3zTbNe7aMxKwHpQf5XzEtiRoGR9Ix68B00cabT
         /7OQ==
X-Forwarded-Encrypted: i=1; AKwUvBwW1FO2voaW7/ap+nzw6ZbqQCkXPujjA0JkakrrBt0if8JaCHZJuv35G/KgktB42wzFMM7ALElfhG4j@vger.kernel.org
X-Gm-Message-State: AFq9FYIn5nNa2fY/k6h6YeOV2yuGBP0j1wdPhn8pO3aOW2DEzFz35T8W
	nVgtQ/DgfQZ0nLw63rF6PDZjoPJjzocmKXLXTShm4wHd2itqWKBJPuyTL+DvRPwX0RpPCZh/J9Q
	mR1ovjwtDSgLKE/Ym1NXQRJj79qvdcnkaR/CZBBs57Ubcs23wF0csrLCDZ19KflJ3
X-Gm-Gg: AYBFou0u5sHY92eYQTDqKN4nmwKGDanp1mDJxdo9bXLUHql/1iBF4QHTBNkbIjU8Sdz
	lEctgxT+a0mV8miHdYIKolKWpIKxGlnqaLNGwXt73Hfn6RF6CvtUexcslj/jofeg2YYIEV0RQHS
	SHLmTP7eTZLdFRE3fcNYrdJk32b4kS7RIDktkI6GC/wDv1ZV/lj7jrgY1j0bGNSwmueogEaC/6f
	s9ZJ3eeNC+JfBNOgypvkGwE0wsMetSR7rVjNOZCacifjDA4yYBcH/ggxEmSTQW0M1F2VV/vUY6T
	2IwJxG93PfJHHL6QUtCHqBqkLIKOUWEbiKEtzQqcRoYP+3wbeMp9yRv8HsAhOaDBz7McsPNj+26
	WPIoOZEdaQvlt7ibLYJ0Nl2pjRn+mG4of6EO4Z7cRZD8=
X-Received: by 2002:a05:7300:f0c3:b0:35f:ab1:4792 with SMTP id 5a478bee46e88-3602d6e460dmr15502758eec.6.1792427815621;
        Mon, 19 Oct 2026 09:36:55 -0700 (PDT)
X-Received: by 2002:a05:7300:f0c3:b0:35f:ab1:4792 with SMTP id 5a478bee46e88-3602d6e460dmr15502724eec.6.1792427814904;
        Mon, 19 Oct 2026 09:36:54 -0700 (PDT)
Received: from localhost (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3608219f838sm33529919eec.19.2026.10.19.09.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 09:36:54 -0700 (PDT)
Date: Mon, 19 Oct 2026 09:36:48 -0700
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
Subject: Re: [PATCH 1/6] ACPI: extlog: fix extlog_mem_event build issue
Message-ID: <20261019093648.00002db2@oss.qualcomm.com>
In-Reply-To: <20261019145643.1877246-2-pierre.gondois@arm.com>
References: <20261019145643.1877246-1-pierre.gondois@arm.com>
	<20261019145643.1877246-2-pierre.gondois@arm.com>
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
X-Proofpoint-ORIG-GUID: X_4iBAOfrG1u-jWMC5h6vr4rAgtq-VyT
X-Proofpoint-GUID: X_4iBAOfrG1u-jWMC5h6vr4rAgtq-VyT
X-Authority-Analysis: v=2.4 cv=H7NOUOYi c=1 sm=1 tr=0 ts=6ad64728 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=7CQSdrXTAAAA:8 a=crxqeblGBJ-rV0e4J-MA:9 a=CjuIK1q_8ugA:10
 a=PxkB5W3o20Ba91AHUih5:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA2NiBTYWx0ZWRfX++vAxKYb3HH3
 85P54p6ZfzlM1PSmvtByeug69GnWYEwJBnFxt97xyPrN9ohAq5h/q1UUBWyAG16gU5TgiH+3fcE
 noE5YYsSHg7Pb6TIFIqdLVx8uZnX1DmKLEMgCpn5IVKfJshqqdBgjbySh4Bu8Nx5HhULgmBoUnT
 WUIZnhMIpW/QJg+12ZREZzkXZ2OJkYfBTdikPRGx57QlN5WZAPFHKtj3W6xnLeRrhuUJOlvi13u
 pvFRi2oIMJB4Xn8xsW6j9/zN9x28L3w7n2KBZBVHIFgMrGm9v8ZKcXS3JJpJtCuvkzMqmnhQj3l
 DfLP5v3vl5NRz8kkFXeIrd0nqvgdjMlm4yB6bEwaz3m9klxXPiHfNE1tQ2REJ+7MXKRHW1x8Sz5
 jDqqwRJEbL76a9qzQ4YDn5kjacdqnYti8k43qaxbEjLOrhqLYuiSrayO7J9DIpJg2QGMmB09Pe9
 GQ8PcgVEAAkFwf9kOag==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA2NiBTYWx0ZWRfX90LVyBrGlSsi
 1U9ZmvElSJbryOjrrnjCGY7tdaAFvoTXDaquTc79KEABX7I8Strzo/m/AzWvaiOAZG6QIuoqwmI
 GBnK/aSfxTVqGXYK9Urm8cqNI19MK5s=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190066

On Mon, 19 Oct 2026 16:56:08 +0200
Pierre Gondois <pierre.gondois@arm.com> wrote:

> With CONFIG_ACPI_EXTLOG=n and with the following command:
> make -j4 drivers/acpi/acpi_extlog.o drivers/acpi/
> 
> trace_extlog_mem_event() is not defined. Add a extlog_mem_err_event()
> wrapper to fix the build issue.
> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>

I'm lost.  This file is normally only built if
CONFIG_ACPI_EXTLOG is not = "n" so how do you get to this code.
Ah you are forcing build of a file...

If you do need to do this sort of ifdefery it belongs in a header with
the function cleanly stubbed rather than in here.

Anyhow, far as I can tell this doesn't make any sense for
upstream.

J

> ---
>  drivers/acpi/acpi_extlog.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
> index 7ad3b36013cc..e764d61f71ca 100644
> --- a/drivers/acpi/acpi_extlog.c
> +++ b/drivers/acpi/acpi_extlog.c
> @@ -180,6 +180,15 @@ extlog_cxl_cper_handle_prot_err(struct cxl_cper_sec_prot_err *prot_err,
>  #endif
>  }
>  
> +static void
> +extlog_mem_err_event(struct cper_sec_mem_err *mem, u32 err_seq,
> +		     const guid_t *fru_id, const char *fru_text, u8 sev)
> +{
> +#if defined(CONFIG_ACPI_EXTLOG) || defined(CONFIG_ACPI_EXTLOG_MODULE)
> +	trace_extlog_mem_event(mem, err_seq, fru_id, fru_text, sev);
> +#endif
> +}
> +
>  static int extlog_print(struct notifier_block *nb, unsigned long val,
>  			void *data)
>  {
> @@ -229,8 +238,9 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
>  			struct cper_sec_mem_err *mem = acpi_hest_get_payload(gdata);
>  
>  			if (gdata->error_data_length >= sizeof(*mem))
> -				trace_extlog_mem_event(mem, err_seq, fru_id, fru_text,
> -						       (u8)gdata->error_severity);
> +				extlog_mem_err_event(mem, err_seq, fru_id,
> +						     fru_text,
> +						     (u8)gdata->error_severity);
>  		} else if (guid_equal(sec_type, &CPER_SEC_CXL_PROT_ERR)) {
>  			struct cxl_cper_sec_prot_err *prot_err =
>  				acpi_hest_get_payload(gdata);

