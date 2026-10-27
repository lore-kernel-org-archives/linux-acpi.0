Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793079140;
	b=rbKbdXMUnUfW35bpfHtb0Spjpn6r8kOOuCE0U36NpztGopcTQJ8OjF1v2LPVlrAMxeQC
	 Nn7VdzxT80x6I4U5ew6cGLav6U0n8n9N4/mAhgiBr9rBQhDbJd2yLLx7F33QPTA3DDe62
	 IKt2812cfYSE5iLdc2uAz38DzwzIPsdrk1Payve4Ry6P0XKRoAM+POPpOvHhiXyEqBAyJ
	 ibYjAzXwVdSp15wBbV8HLWOYoZNpAW0slOcy0DgTFe9Y+DPUAXuSPKljGgQW/f+/J4NGD
	 UnmL5KwYqJV1rrf9XvvCc53tdciW+m3uIB4EIHvpvmP8M2DDgRBRQZZyhqup2g2XFMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793079140;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=VpHSucyNN1LDa5ApCaatg77B1Q+sqWuq080vIR/b0Fs=;
	b=DaS2LP0PaTv3X6vVNBFA6uvFv4J/0zis7rWBs3zfDhVGfynmWt/oHx2X5YPRnL4TVmYb
	 cw3icZlK+Qb4XeB3Zvm518FQu3UicUyb5fwGrKQwqhvpq58bygMLVAO707kYio0XyiiXb
	 TxDJhlFW8pXvUpEVsPuWXfl7ySSQu553aIQapFxlsPuSJF9jBe70wdC99p0vli7pfom7d
	 NEMSYFRNGIVKo51iC3nExzPnbOVzQjlUROWzeseaAFY9BRDvUGtTc0nx2fbxh8eFopbZy
	 jJYlJ/C0rlNZ0ToXWff/vV93MxP9JhFUCspqvqJZb+cMQxyM8XWdg6CyAIucwRXckFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=S5u+X6ID;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bpI4Rkce;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314DB606A31B
	for <linux-acpi@vger.kernel.org>; Tue, 27 Oct 2026 05:32:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 314DB606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=S5u+X6ID;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bpI4Rkce
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69R2FGfS867632
	for <linux-acpi@vger.kernel.org>; Tue, 27 Oct 2026 05:32:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=VpHSucyNN1LDa5ApCaatg77B
	1Q+sqWuq080vIR/b0Fs=; b=S5u+X6IDdAqSFMJ/sWFXego0TywOvH3i2WaDBwXL
	mfDX8VulUGbMrrfYuEcCZ1izjFgzaIrtWd9yxtNA0qeqD7VOsM4ia5hN2HGXcOml
	uTQb9ugVR7xpwkYbLrCl6fiksvHkkO3Dd5ubaWPUyuxgkBtpIiw/h/Di7Lbko6as
	j/UPCPe3ww0utvfbRS54B5/lukNbt4BfwSkRCc6Yr4gmm9g2ggWG1idnUE+APZtG
	OHifiAhrl9MpdF6EFICaQa9Ufp7aMytkMHUCmcpLhjgnZvisX5hrbi6HSsSRWE25
	AksywJxYyO7jNCA0Y1dQSI6nbsRFx2rf/pb1AFANpAhyqQ==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj79xu8h6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Tue, 27 Oct 2026 05:32:19 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-147be78cd56so2087394c88.1
        for <linux-acpi@vger.kernel.org>; Mon, 26 Oct 2026 22:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793079139; x=1793683939; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VpHSucyNN1LDa5ApCaatg77B1Q+sqWuq080vIR/b0Fs=;
        b=bpI4RkceNKUc2NF0b7jmDkvKf5yHbHtt+mPy5Spyf/y7Cs2iFHyz3/9u4RScEuN8tl
         2mRXi/82SFU1A3/V3EU7DYuw04iS/cineFp7t5kdx2ZznsfTT2iEMIzk4XsVVGdGjENP
         /advAMN1d/Cm4vGH288m3RtRZ+BSKkcvJ3cw/Ich09XhUZS9ZSLVOAM5UN4idV1ffDx5
         Lh37qDxoGdpzjKWbgMwKD2l3ecVGZOLAvyGd6HwdtfrmFn/CpMur+hhbyUn5ub0YwFIW
         k/glP9Jw397nqZnB3iBDj/HElOMZR3AgeJFWIclGwovmhPeF1SlG0LQu7JWGTkkXHeRH
         dYHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793079139; x=1793683939;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VpHSucyNN1LDa5ApCaatg77B1Q+sqWuq080vIR/b0Fs=;
        b=bSuZ/DypE6lPl9tocccF9OeUVn8lYVAxbYBgZktUBKaWaDyOcDhENY/16brjh1Xyjg
         W8/G/NstPIDqg8/uFblZT8PgMiPR0YWI9nzvydoad6ENxIx5asabqp1C4F8BRbZYmE9F
         VyG/ryQDx4cLJP7wB2ZG3lEhDCMm7L82ppVyWGiwZeLtmjEBSPGnlXFSHlKYM1omaEal
         OSFyHOzWy0dytzvDu8CyAZgKAr9QGvVg6sixpOIrEtA0SRmvX8JhYmxexcED8VXGIG2C
         WqW4iTJOkK6GfwV70wL+AGz/68EaOgEaJ4bWnabn2Qz0cbEHoLcm3jUdkMfP6NV8JVN9
         HBeA==
X-Forwarded-Encrypted: i=1; AKwUvBwpqlFQHbjjXK5Dcqb2SYRPRgPe0odjXJ1CSbrvSqPobMGVfcF5UiVgb0G8hGtQIMwU8D3dfHVsrxda@vger.kernel.org
X-Gm-Message-State: AFq9FYKT1VyDIbwle8GSV0tZSafvoe0EAtYiAvgyL7IMYTA7dQdyDj46
	VHW/NsPI8UN3+QnT/pe1WCEEiAuAe2lF4ehupVpdlNVzR70XjhPWrWoN6F0lEVW6cmtTs8o2tTQ
	ylWtif0fAF1yS+JX5Pbb8Ne1e7hdFjmbYoMCW2wkgARh3YnIhNovVZD6jw8aVWJZP
X-Gm-Gg: AYBFou0cMsosEpYKgy1pB6WJ/8DhaAH8B5G9AMOQ8iKag7sfpNODHFx/SmXGj8fFTmw
	EqhhsTlaa2Pfjq+xCVqUB/S7hIhSDGUJ0T6NyT4Y2ohA0lEmlrmIfNJDPZe/atbtb2fP7MRYRiz
	mnzbcaznN5KgfGmDvzSXZd44KDAD3wogOsDCDFs5cv8xghj9ldqroUSqDyH6wGVsrlT8uHR8c/L
	inq0CAm5BSxL2NH1XFoTXaxeILvKPwmTPorThAfV7iV3rvbzd4mcyupL90N963KSlLYwnmmY1XR
	UpiE3XQyzVUTKl5pegOdXhDZ6n2o9Vy4yv0tfp7ALc7uTt0UtsIzrK8J3ZBoytklW33WdBHMqdJ
	pcggWayxvFjd9hwOen4PN0Sl7tG4KMXWrO6+fBPpq5qfDHU2lzmNugo3w2KkIljBura78pAPNBq
	vq+wBTbXPZA1/XQ1g4UVTSES8=
X-Received: by 2002:a05:7022:68f:b0:1a4:c892:b130 with SMTP id a92af1059eb24-1a4c892b30emr987460c88.15.1793079138457;
        Mon, 26 Oct 2026 22:32:18 -0700 (PDT)
X-Received: by 2002:a05:7022:68f:b0:1a4:c892:b130 with SMTP id a92af1059eb24-1a4c892b30emr987444c88.15.1793079137877;
        Mon, 26 Oct 2026 22:32:17 -0700 (PDT)
Received: from hu-himchau-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a37c88aasm27316225c88.23.2026.10.26.22.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 22:32:17 -0700 (PDT)
Date: Tue, 27 Oct 2026 11:02:09 +0530
From: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-efi@vger.kernel.org,
        rafael@kernel.org
Cc: acpica-devel@lists.linux.dev, anup.patel@oss.qualcomm.com, ardb@kernel.org,
        conor@kernel.org, james.morse@arm.com, lenb@kernel.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, robert.moore@intel.com,
        sunilvl@oss.qualcomm.com, tony.luck@intel.com,
        zhangzhanpeng.jasper@bytedance.com
Subject: Re: [PATCH v5 3/9] Introduce a new HEST notification type for RISC-V
 SSE events.
Message-ID: <auA3WZf5rLlx4Lve@hu-himchau-blr.qualcomm.com>
References: <20260924073714.1650588-1-himanshu.chauhan@oss.qualcomm.com>
 <20260924073714.1650588-4-himanshu.chauhan@oss.qualcomm.com>
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924073714.1650588-4-himanshu.chauhan@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: f6zgDBM6erzP4RndcT3qx5OODe4x4b5x
X-Proofpoint-GUID: f6zgDBM6erzP4RndcT3qx5OODe4x4b5x
X-Authority-Analysis: v=2.4 cv=FPyOVOos c=1 sm=1 tr=0 ts=6ae03763 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=wNwvQHF-ByPSNzcBtQ4A:9 a=CjuIK1q_8ugA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDAyMSBTYWx0ZWRfX33ENilJVImNG
 YAZxbHwC3qpjX+PSmvmwQIS+zLOLDllopU8ZGFhGRHgvOCWjsU70Tx5fgZDQNelaUMf4ITkOH0C
 ez+89fqpN4h2mTtMBrGvnBFv7svW4dpYkNzUMt0FpBlL5CXKQtsf6oF9TX+bypDE4jZmvewFIRr
 OWK7tAiyyH+Cn8xhO+phLHrGdc+x9oLRQpHMEWO/5UzP3GwcoSYexmlNtktW95wFQEIs/mOh715
 rPAVhXkjjssC8Uyf8ZWi45IRcKSFA0WXT5VXyAmys8p/z+f7N/BzUVJ+YesrygV2aIPju99V0ql
 uoNyQUWmwRyC//8q0TQliWONlGJHOAQKmYw/dMeDmiXVnpnWKGn2FVacg1YaGEEieY+cMYkFvFw
 4JylnYWKdK8V73doHSgOYzXHvqIojF/CEdNbPXj02OxvlYhMHQjzm+2XxTfzaQQCcjiO+tHZaC2
 LoRVRly5+dAccaQTqWw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDAyMSBTYWx0ZWRfX2OJkm2XTckKF
 uD0GVgROct93yqNpyuB32R0/nw2ISwVLgEkHZDQBtvme4zWTwNqOfSiuvA1AZLhWU/uHMck3M4G
 d3hIqS81qC3P5oByaMZaVKX7fD67nvQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 adultscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270021

On Thu, Sep 24, 2026 at 01:07:08PM +0530, Himanshu Chauhan wrote:
> The GHES entry's notification structure contains the notification
> to be used for a given error source. For error sources delivering
> events over SSE, it should contain the new SSE notification type.
> acpi: Introduce SSE in HEST notification types
> 
> ACPICA commit f73f39352c1170464afe812cc96b20cc9db1d822

Hi Rafael,

This is merged in ACPICA. Could you please pick it up for Linux kernel?
Once you do that I will drop this patch from here.

Regards
Himanshu

> 
> Link: https://github.com/open-acpica/acpica/commit/f73f3935
> Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
> ---
>  include/acpi/actbl1.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
> index d824838cb7af..105fd51f83ec 100644
> --- a/include/acpi/actbl1.h
> +++ b/include/acpi/actbl1.h
> @@ -1798,7 +1798,8 @@ enum acpi_hest_notify_types {
>  	ACPI_HEST_NOTIFY_SEI = 9,	/* ACPI 6.1 */
>  	ACPI_HEST_NOTIFY_GSIV = 10,	/* ACPI 6.1 */
>  	ACPI_HEST_NOTIFY_SOFTWARE_DELEGATED = 11,	/* ACPI 6.2 */
> -	ACPI_HEST_NOTIFY_RESERVED = 12	/* 12 and greater are reserved */
> +	ACPI_HEST_NOTIFY_SSE = 12, /* RISCV SSE */
> +	ACPI_HEST_NOTIFY_RESERVED = 13	/* 13 and greater are reserved */
>  };
>  
>  /* Values for config_write_enable bitfield above */
> -- 
> 2.43.0
> 
