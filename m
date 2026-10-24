Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792800596;
	b=CrGQ+HJ8cyU05ptZ2v9yfiVw9WGJHRQN7AuefkkIg3f5i0YTkUZZOgODTJd1Er8vXI34
	 F4nQtdAQSzx1+nSWZA5O4P/eFd6q3cdSGnFdvOUu3dnzhMxzmrGl6dXrCrn18CmpeMRSS
	 YD/8rd4jQafor2S8jLpE9pzEzd+V05FnlXtLiBiUy8EkXyv+2q3fketxAWd5xzy1zxa9q
	 uhzYvZzUcLmqlw8H3QbhHa2xWBHb7JnCFFJXYJpkTwnqN7XlhirQuYvcT9J9vFGuOvVbx
	 dvvNiBd3cZyV/1/ULejiAYc8djyTJtpDHXc69QpJnB883Uz081dioU1aX1z6TADMocQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792800596;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:In-Reply-To:References:Organization:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=oHnBaDBiTFLamKq5NGOdIg3Rc+UCACis/kFyJn6z/tk=;
	b=FRrDnwpeg/gFoOSOXsJ2qRfPujkBTyQi0CuuxDNRPjGyfJ2sym2NFKzApcLF8OeQyqFJ
	 qHm5+8iofP57G6/cmwIfbQeLfGfS+U1jACh+XLfAHPAk//K9EEdgm8Srg0tfe1Gg7NQyd
	 UgxM+MAF6WQOBGeAeg7n7xOvU4Wpbqw0gsQiSkz+ULVOVvOg1NIDGpkChw+uifX3fMv+e
	 7+jkZKPZG0Q/1RcqgjOig1JUumRIuZ0WswT2HfY5TpffhkpdN8u2/FFZajenKrn+zVIFw
	 LhNWgqN6Dr23md0eawUDQjZbovINQz2fgr0X4OIZ50K7nganAMHmCeAfQxwm1MLATmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=an5WwwQJ;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OW4ZL+bB;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F0C606A327
	for <linux-acpi@vger.kernel.org>; Sat, 24 Oct 2026 00:09:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75F0C606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=an5WwwQJ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OW4ZL+bB
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NLuvj6877173
	for <linux-acpi@vger.kernel.org>; Sat, 24 Oct 2026 00:09:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oHnBaDBiTFLamKq5NGOdIg3Rc+UCACis/kFyJn6z/tk=; b=an5WwwQJwdtacYzX
	YJ8cLxGoL+zkrqCAPNMPb1Bo0l+rmin4NW2dGTwQaowfVy1NE/u8anbBNJQff6oD
	9iRQO7hAN9qqHc1egF3y/x3ZPjBYwVfQwVxRYVJ6YFoGl0MKYr3jK8b9nPkhXmLs
	KuItwHvGmLAK88dmjtMkQwQ9A+E+HZzhXWqQF8vryy3K6pARLXxxH+XzQLJ+x+r7
	ukOGjazpt0nJDkepfdt+abjQkWoOtJ6Ydgbib2b+YXAGbKLPXqV5iD8cEOdVsTyN
	vQCKf3YhQZ2fKRHPYFTx4ICxpE3XpO/wHt9uDfI0Vb+9+0uuWFb2I4K4lIDeS0Di
	MvN1wg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgcr68yq1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Sat, 24 Oct 2026 00:09:55 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-3662e7a9299so6004940eec.1
        for <linux-acpi@vger.kernel.org>; Fri, 23 Oct 2026 17:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792800595; x=1793405395; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=oHnBaDBiTFLamKq5NGOdIg3Rc+UCACis/kFyJn6z/tk=;
        b=OW4ZL+bBSQhax3H16xLZGHXs85h23cZYtiGm0drz7kgAsetQBOgktC2WChpbmUYCsh
         LYgeKDaJ47TjeJwGiWJYaiiHptoUdy1sbhb2wNBTkHWhzn5qL+ok8u6COijgDhSS3YPA
         4jE6sgaRsk3na85wmj8zPzejuMvQIkevoeA8pssb48xeEoU5vM3KCj9Yrgvy9D0h2yry
         d9Py7udCV3DRtvb6rkOGQc2zYFeP7IswotkcfI7QQJF5tjzuk8BdO4TcDePpF4jkMTkk
         djCAPHzYvePHadLhweOtIMA1XxxRuIc9RJ8YRTTy9/K7Vb4cMQOS0XJ2bYwb31FR+kUD
         X7BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792800595; x=1793405395;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oHnBaDBiTFLamKq5NGOdIg3Rc+UCACis/kFyJn6z/tk=;
        b=NMtczKD7TuZypTa26YJCSygNQ0Z0Nb08oRVktw/8bAMxp1SNWt2MjucLdAHcNZrPU5
         KljknHkJurczOHQaHiPWabClbs929Gb5EHw3NVZ9FvrhWgVDfNp6oZZS6P1nwQXpSqYZ
         TZjwDhk3zoBQZJR/EDJz9vGdBRubgYN+11r/GecUoCI3PAG1CPB80WBuJUqTjwZUfDfZ
         JpgA4PLzmCQXqmBV6xTIFGAfIAzlSCg+fz6UgVtQbnS2YkB0cyEy4y1bvfo6do3S+3wp
         HWM9Xfd1NcDChWzAPlaFIZ9m/zDcOJkYZPsh+8Hr14UgNpJGPA7rENXwJiNhlLR420TC
         gn+g==
X-Forwarded-Encrypted: i=1; AKwUvBz7kVeR3fwh9/CG3pcvrGFqYiiMwXo0GxsmnzH8RMveLUkQXIdNgKxrB0eqpaDfSeOPveU0w5l5GMtC@vger.kernel.org
X-Gm-Message-State: AFq9FYKkDIPKmRvpGzbIXKbYpy1AAIUpuFcmt5hycUw25qhOpmMH2uog
	7OMYzflQ3Ts3HCi2GhuHzo5XtbFKl+UzlUggv+fHdoJDAPTckaJRD4AuGz9nWGS8rVlWRh+gVVJ
	+gdo6NDMdBQG0HChmZSDLFfEPtnMQrSynFzQVgfCCKZba5sP1wHdOdAuO0cTMiyV4
X-Gm-Gg: AYBFou2cP+B37PdZks6VtJGYW9dRNxghakJDnhJibjLOQBKeX+OK4LZJB/+k953gtT9
	fM4kZca332XYnIPA5dogqIBOTCPAFvggMBpnmt5VyLWL74zjgSDAmNt09cHdL81bhyErAnXNM/g
	9DE/CQ89OtPCrsRAzoowL83hAnrhiRAKdvHT0HS6BFbMk/JqtMTFaUiLE5plXK4b2+HRnYbokmK
	au091q1RQhzOb0tGJka3/zRC8X306eBQXi7eWg4vGK3TqdGCkEPPwpFtDcIuqvS8MdyHdsyTa+h
	uGOEh4CfShiSo78lm4CVVYSts6aH/dyciHareyMfjAP2deB1WiMzQ391j4woDKQmER1PrtvCeWj
	Z2NBVfLLgvN4b3xV/dYDKLHMzZyx2y6h4bHSz10/xh/GpNFKJoa67NHg=
X-Received: by 2002:a05:7301:1694:b0:366:eda6:8dae with SMTP id 5a478bee46e88-369e84b9a3amr1452592eec.18.1792800594703;
        Fri, 23 Oct 2026 17:09:54 -0700 (PDT)
X-Received: by 2002:a05:7301:1694:b0:366:eda6:8dae with SMTP id 5a478bee46e88-369e84b9a3amr1452555eec.18.1792800594047;
        Fri, 23 Oct 2026 17:09:54 -0700 (PDT)
Received: from localhost (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8d93663sm1724701eec.13.2026.10.23.17.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 17:09:53 -0700 (PDT)
Date: Fri, 23 Oct 2026 17:09:47 -0700
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
Subject: Re: [PATCH v2 6/6] ACPI: extlog: add Memory Error Section 2 trace
 event
Message-ID: <20261023170947.00003e37@oss.qualcomm.com>
In-Reply-To: <20261019203915.2019037-7-pierre.gondois@arm.com>
References: <20261019203915.2019037-1-pierre.gondois@arm.com>
	<20261019203915.2019037-7-pierre.gondois@arm.com>
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
X-Authority-Analysis: v=2.4 cv=HMRWhYtv c=1 sm=1 tr=0 ts=6adbf753 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=7CQSdrXTAAAA:8 a=EUspDBNiAAAA:8 a=dQPge2qhURPgFtmzFlYA:9 a=CjuIK1q_8ugA:10
 a=bBxd6f-gb0O0v-kibOvt:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDAwMCBTYWx0ZWRfX+4sSeSGPE76u
 6/10TMGSiV4ihREnFb3Pa0qyisdkyYdaqOeb7EU2A9XmoheuWozJqwn6GPOoa11cnhqu6aI96b8
 W0I2LsV0a+y7jp1/26roUf0y8gtgTA+VuGtQkwdCIAznvqet0Z1HXUVoMXjAHieD0akZ7Kgal/H
 U7jcg9MyuEE/LfjGxOHbBWeQxlP6bMB+ZzEhaBj3SMiCjJ5xAgNEo5G19KwSUc2I3EUU4QOVCcN
 m0kX2nV/r5sXc1HQ6DIWWz+jJO3ILAz25H4bmofFWGDb71CXN3Y9Z3KXQ0t2IIkAAYDJSHjFGj8
 +s4pyl13JEGJhYCZKg/b4cxFNegoJ+JFw8asjJt0rVfCbV2TIngrzR4JVwhINuJHMPYCywUt2jA
 Y5K7YKI4BHaBbx9gwpI5PtmePJFchYtRvkgqApIIbrIXq8Xg4D01vNuIKHspnw5Xvm8FyNkrXSA
 SsrjzCd4baKtd+JVuLA==
X-Proofpoint-ORIG-GUID: t0D_bK1yuonTOoON-POdJfBP05bwvG7L
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDAwMCBTYWx0ZWRfX0G9sXNMvKn47
 lLfV6UcZiG2T9R4SRKI8tdteIgf/uFqzxoKEaPDghONLC9QUbnagsO5Zs8/vdSvYIYw/bDD7751
 2HYqJipNt2P9l4wvhOSaYpvqTGtQmZY=
X-Proofpoint-GUID: t0D_bK1yuonTOoON-POdJfBP05bwvG7L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610240000

On Mon, 19 Oct 2026 22:38:45 +0200
Pierre Gondois <pierre.gondois@arm.com> wrote:

> Add a separate handling for Memory Error Section 2 trace events.
> The fields of the record are individually printed so userspace
> can discover the layout more dynamically if a new field is added.
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> ---
>  drivers/acpi/acpi_extlog.c |   6 +++
>  drivers/ras/ras.c          |   1 +
>  include/ras/ras_event.h    | 102 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 109 insertions(+)
> 
> diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
> index 7ad3b36013cc..9e4d16e06244 100644
> --- a/drivers/acpi/acpi_extlog.c
> +++ b/drivers/acpi/acpi_extlog.c
> @@ -231,6 +231,12 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
>  			if (gdata->error_data_length >= sizeof(*mem))
>  				trace_extlog_mem_event(mem, err_seq, fru_id, fru_text,
>  						       (u8)gdata->error_severity);
> +		} else if (guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM2)) {
> +			struct cper_sec_mem_err2 *mem = acpi_hest_get_payload(gdata);
> +
> +			if (gdata->error_data_length >= sizeof(*mem))
> +				trace_extlog_mem2_event(mem, err_seq, fru_id, fru_text,
> +						      	(u8)gdata->error_severity);
Was just giving this a spin and looks like mix of tabs and spaces (with the spaces
in the middle).  Git moaned when I was applying it.

J

