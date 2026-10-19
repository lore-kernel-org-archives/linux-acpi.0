Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792437194;
	b=5Cx5BjcS0xYALJS4ZILVxgTmxWwiR28kzXqnXcYPaQpaLjEYJjAIJIFFl4cjrTiQegWr
	 BLOZhVUzwaTYcuthG6bhkSGtqMhAkFf2DLSrZyUUXNE0CHqxXD57u7gSbpzbrRv0MQbBF
	 OVSZOsmxlELj+Oua68RUlu7Uc1dIRyB8ldgeCaqUzoLZKLQK0Ly8KfajHWKvzYnmFVrIh
	 W59OwTcAqnsHvEhkgIi+So9RRNUW76lJq91PHI/c53YsQu/fCyEHagDG7vgM2I5j6ddCV
	 B0gB+LYGeXE9w/6J5RMovBKAMO7LjTXQHh2GzBiDzKRjS1+v9v/r7XeXK1BQ0/yBgng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792437194;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:In-Reply-To:References:Organization:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=jS+Bq8s7EUDu4GSq8520KkV5KJNW6foagnSih0NwpR0=;
	b=MPy/JlQgMXunyKSJydIadWW4iKqFVEvAc8tWnzpjM7dXdOpaZvJHAzDw5MiXFG7W1uI2
	 xWJZ0XkMK7euV12NM9fcwsXBfvdESS18GSZ80U9WekL8ghMEjsixMozjzs73Vye9jfy6i
	 4Fp1hU0uvCiPRTNRo6iDBRDoB4zG5FV0ZsQCP0rp+S0f+IbuuYNHY7ne27x+iBIJwD6p3
	 YTz+Bb+DGYRdF3rFENoAp/ydGkkguyxq6XOGV6s3J27qcdI9u32SDRlmpGC2kxH3fnAHJ
	 +pF6Kv6OhkueTlgeu8c9udEIBNppigCg7GKrIARYDx/TY2GF5YveacT3GWIKPkRdFaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=M0fMUZ6F;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kUTNr9WD;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1ACE606A331
	for <linux-acpi@vger.kernel.org>; Mon, 19 Oct 2026 19:13:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1ACE606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=M0fMUZ6F;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kUTNr9WD
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69JJ6MWl4161439
	for <linux-acpi@vger.kernel.org>; Mon, 19 Oct 2026 19:13:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jS+Bq8s7EUDu4GSq8520KkV5KJNW6foagnSih0NwpR0=; b=M0fMUZ6Fb4oNf5TM
	zLzNK2cgNvEfObJYq99kohKPazYP4z8CkhpecWaWG4uSRg/lDykGnxTofvOJFGij
	6is1UhUrjNIFLkzLYxGvLgo7s3t3+ymqXPoigLv8NYw+gIBI26wSaQofbhJO//Xk
	MozR5BsMBJ/nYXNnm68HrQpH9gKFKePu0KbV341ILBBDE/A2hKbmUOjIXFXJVUaj
	D8FEAJkg0Hvb0l/YgQtt3EO8IVJtweE1cWzips2vKQ8gh94OUoXisX85WicpcHZw
	ql7bYEGXh4GI+31H2fl2IDU/DEn1sq4QlnIW0AnbBxaF/NEQySYRHPltk6LadYNt
	hPasyw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf48ju9v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Mon, 19 Oct 2026 19:13:12 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-3510d0baf63so6222813eec.1
        for <linux-acpi@vger.kernel.org>; Mon, 19 Oct 2026 12:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792437191; x=1793041991; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=jS+Bq8s7EUDu4GSq8520KkV5KJNW6foagnSih0NwpR0=;
        b=kUTNr9WDAlUs7CLCDh3NOYzcnijYDxF5hGtkLTnqt17Dgjjro1z1UF42lk3VRwjWfN
         4p6I/uDgSH+0NJZmYt+7xzkxN2O6MQ830qAi301uQ7zHMV9uwhcEcNVAvuywyIIGCek0
         KxNGWKWi1M2cI2DZXgXjLKZeJkgyfAknGtQnqkqUmBKJqEWnT9T8/il+0PP6HQy2T5O1
         sYuTa2MNmNPQ5MwV299tCvmrCdb/W4n92ZOU9/WNaErWNkkougYjXNKdBvoi+38uRz2p
         Y8mfnIbCZ7Orm4SKMbx/bK1P1MZXyhOkthmGSYtvU0tDXr9ZVUJpm9Zqm9KezhN45SPb
         RdvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792437191; x=1793041991;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jS+Bq8s7EUDu4GSq8520KkV5KJNW6foagnSih0NwpR0=;
        b=byXs5n8l/3Q40VabZBioWMuh+1c3WBVssc8hlryPYDqSopg7/zLtjkUP+bGGTpP+vv
         6p5iRKWq6xWN+wSUmLFMpfDFf9RnT8loJohon2ZD4tSjsLaxn6gtuCzv63ZBx+HnD9Gd
         etdYxVvHq29pWAKoHJyBOqqDLX2hetnGhDFIylzlRKou1Ghc5oethOGsDXkGA1q/y+oz
         36eq5uoZGN4m21HLn9V/xYWwBZmilxZwy3xylfG8K4KTkSUAvZtErqHmVyYT+7y/uREF
         6QGeaqL5e6bqasWUNTsq+kmEuLF94I6s4OZFf3ohks/TrX9GRGahi5g87gkgVkxT2aeU
         ZOwg==
X-Forwarded-Encrypted: i=1; AKwUvBx9rtB8XYI57ic3f4ahlCLKY1BohEkNHt+Z7ufHHnvXtZRZMzzQ9pv9TpGVebUOYSrW+/F/beygh7bP@vger.kernel.org
X-Gm-Message-State: AFq9FYLkIuxr9YYK8SkFQkT3/R/JtAiyEbo0KE8CwdFdxzBGg6if5FET
	j05VSPtGJDvKQY3lPsbsjrBnqadEVgtNC9Jc9g7wfTfGB2RTD3WRBDfLAdAMc3WHRcbkZrrrAMF
	VoF1Syhn3tXLYiG0ZXPyzfNa4X1jtJ4w7kFrAMGlkzl/MK9Dht7X9hs+oV2IswXpv
X-Gm-Gg: AYBFou2CPQCPHDk5DL2+YELj+FXBzIdu+cCvDs4CBzLYLQCddcrpYc8T26MuPxpqRcu
	sCx8Z2fvAmh+atHdHfKRSdCFSHznc80Bxcjo4FtKQTyyAk7Y9M0S5UcOnGH1yflbILMNKZT+EJx
	V7aS7J3OB4PabUksHGqzE+Pz9c1FrMqFdbKLLN0hCWt9xfgBjV1QG97e+t/AFhaY67UWa4Xqofq
	uLb7DZSf8aqCzc4hr5ut3Wk6VoLPUDUwFbIMM6neyd4DWddX4Yd1gMLtsFves/Xpxj3UAtbDRk8
	411DUWYqcDt2cyjjZWzb8NHPqboTDA2p+FBeWCdZLO5FJsWws9R2YjSrSMRGuTXQhPg9MRRV0sK
	3+hjfPdly2mliV8+PPpUKDJFlYZSO1Jbs1GqWLhwNnQ==
X-Received: by 2002:a05:693c:87ca:b0:35b:c1d2:eab9 with SMTP id 5a478bee46e88-361a2e3d3abmr11230573eec.39.1792437191353;
        Mon, 19 Oct 2026 12:13:11 -0700 (PDT)
X-Received: by 2002:a05:693c:87ca:b0:35b:c1d2:eab9 with SMTP id 5a478bee46e88-361a2e3d3abmr11230522eec.39.1792437190619;
        Mon, 19 Oct 2026 12:13:10 -0700 (PDT)
Received: from localhost (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3608258aa66sm42939717eec.20.2026.10.19.12.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 12:13:09 -0700 (PDT)
Date: Mon, 19 Oct 2026 12:13:05 -0700
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
Subject: Re: [PATCH 4/6] cper: add helpers to handle Memory Error Section 2
Message-ID: <20261019121305.0000433f@oss.qualcomm.com>
In-Reply-To: <20261019145643.1877246-5-pierre.gondois@arm.com>
References: <20261019145643.1877246-1-pierre.gondois@arm.com>
	<20261019145643.1877246-5-pierre.gondois@arm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA3NiBTYWx0ZWRfX/CSiBaPQlR2M
 i59OExlTbnIbgBwdJaR6SHFCLwa3q/po23jyhY6GE4ZWhNzrQJ173tMpTPxhyPEqi5B0v1McO65
 DXURmOz1WvBEUxWiffoJ4s4Su6UmcMYY58oTNzmLW92J3CIF06KNMo8jKnTWAObGD+VhU6twOUz
 WMc+8/RSl856gdZcSxQn2uC8mTAAlX2wl1OmxrSzwQuN5jBV3by5h5MhEqx2vnf/OQOrExEdPvT
 Jnev4RJvfbI9MRcX6z2cLun3S120MHyWF2dk0ZF2jiaD6gnVX+TERUEQqR+eZ+2WwQGfE3wsdoz
 E2G+6iDCBYf9zvMY+Bdu0KDRy8US2x03crfuR4DoBrjmDaep1QgP9KtWnX1o9k6e2AHaM0Sg36N
 I00lqmWdrxDatD0XWQz+Nd6/sbc1931rBJPUZ5DXLgDJYxsHXcCjOR1HGF9l2F7elQMLz+rgf2a
 AbPTI+HmeNTBdxlI/RA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA3NiBTYWx0ZWRfXzh0IGqCpZnrK
 gz3QbT3BjmfAFr/LMUVwQDUOyiYZEOIfD8WjDnFB/YX9vXQHjvzYWshuHUNOl23+wnG9BP8WgHb
 0Snoauh/+Q76Xc6V7ZSskX93MhbX6B0=
X-Proofpoint-ORIG-GUID: 3GQRLJacSEc6eOZmq_PYKLsg8krtw222
X-Authority-Analysis: v=2.4 cv=Qr/LTlyd c=1 sm=1 tr=0 ts=6ad66bc8 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=7CQSdrXTAAAA:8 a=EUspDBNiAAAA:8 a=sh56xHOc4yr7ZHq0_TkA:9 a=CjuIK1q_8ugA:10
 a=bBxd6f-gb0O0v-kibOvt:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: 3GQRLJacSEc6eOZmq_PYKLsg8krtw222
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 impostorscore=0 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190076

On Mon, 19 Oct 2026 16:56:11 +0200
Pierre Gondois <pierre.gondois@arm.com> wrote:

> Add separate location and printing helpers for Memory Error
> Section 2:
> - cper_mem_err2_location()
> - cper_dimm_err2_location()
> - cper_print_mem2()
> 
> Similar functions/logic exists for Memory Error Section (1),
> but require a compact version of the record. To avoid relying
> and propagating a non-standard record format, the new functions
> diretly rely on struct cper_sec_mem_err2.
> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
A few comments but they are about spec confusion or trivial.

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

> ---
>  drivers/firmware/efi/cper.c | 108 ++++++++++++++++++++++++++++++++++++
>  include/linux/cper.h        |   3 +
>  2 files changed, 111 insertions(+)
> 
> diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
> index 06b4fdb59917..5c9b832b67a1 100644
> --- a/drivers/firmware/efi/cper.c
> +++ b/drivers/firmware/efi/cper.c
> @@ -445,6 +445,106 @@ static void cper_print_mem(const char *pfx, const struct cper_sec_mem_err *mem,
>  		printk("%s%s\n", pfx, rcd_decode_str);
>  }
>  
> +int cper_mem_err2_location(const struct cper_sec_mem_err2 *mem, char *msg)
> +{
> +	u32 len, n;
> +
> +	if (!msg)
> +		return 0;
> +
> +	n = 0;
> +	len = CPER_REC_LEN;
> +	if (mem->validation_bits & CPER_MEM2_VALID_NODE)
> +		n += scnprintf(msg + n, len - n, "node:%d ", mem->node);
> +	if (mem->validation_bits & CPER_MEM2_VALID_CARD)
> +		n += scnprintf(msg + n, len - n, "card:%d ", mem->card);
> +	if (mem->validation_bits & CPER_MEM2_VALID_MODULE)
> +		n += scnprintf(msg + n, len - n, "module:%d ", mem->module);
> +	if (mem->validation_bits & CPER_MEM2_VALID_RANK_NUMBER)
> +		n += scnprintf(msg + n, len - n, "rank:%u ", mem->rank);
> +	if (mem->validation_bits & CPER_MEM2_VALID_BANK)
> +		n += scnprintf(msg + n, len - n, "bank:%d ", mem->bank);
> +	if (mem->validation_bits & CPER_MEM2_VALID_BANK_GROUP)
> +		n += scnprintf(msg + n, len - n, "bank_group:%d ",
> +			       mem->bank >> CPER_MEM_BANK_GROUP_SHIFT);
> +	if (mem->validation_bits & CPER_MEM2_VALID_BANK_ADDRESS)
> +		n += scnprintf(msg + n, len - n, "bank_address:%d ",
> +			       mem->bank & CPER_MEM_BANK_ADDRESS_MASK);

I guess this makes sense. I couldn't figure out from the spec if there
are rules that say whether expected that VALID_BANK is not set when
VALID_BANK_GROUP and/or VALID_BANK_ADDRESS are set.
Safer to just over print than read stuff into the spec that isn't there.

> +	if (mem->validation_bits & CPER_MEM2_VALID_DEVICE)
> +		n += scnprintf(msg + n, len - n, "device:%u ", mem->device);
> +	if (mem->validation_bits & CPER_MEM2_VALID_ROW)
> +		n += scnprintf(msg + n, len - n, "row:%u ", mem->row);
> +	if (mem->validation_bits & CPER_MEM2_VALID_COLUMN)
> +		n += scnprintf(msg + n, len - n, "column:%u ", mem->column);
> +	if (mem->validation_bits & CPER_MEM2_VALID_BIT_POSITION)
> +		n += scnprintf(msg + n, len - n, "bit_position:%u ",
> +			       mem->bit_pos);
> +	if (mem->validation_bits & CPER_MEM2_VALID_REQUESTOR_ID)
> +		n += scnprintf(msg + n, len - n, "requestor_id:0x%016llx ",
> +			       mem->requestor_id);
> +	if (mem->validation_bits & CPER_MEM2_VALID_RESPONDER_ID)
> +		n += scnprintf(msg + n, len - n, "responder_id:0x%016llx ",
> +			       mem->responder_id);
> +	if (mem->validation_bits & CPER_MEM2_VALID_TARGET_ID)
> +		n += scnprintf(msg + n, len - n, "target_id:0x%016llx ",
> +			       mem->target_id);
> +	if (mem->validation_bits & CPER_MEM2_VALID_CHIP_ID)
> +		n += scnprintf(msg + n, len - n, "chip_id:%d ",
> +			       mem->chip_id);
> +
> +	return n;
> +}
> +EXPORT_SYMBOL_GPL(cper_mem_err2_location);
> +
> +int cper_dimm_err2_location(const struct cper_sec_mem_err2 *mem, char *msg)
> +{
> +	u32 len, n;
> +	const char *bank = NULL, *device = NULL;
> +
> +	if (!msg || !(mem->validation_bits & CPER_MEM2_VALID_MODULE_HANDLE))
> +		return 0;
> +
> +	len = CPER_REC_LEN;

I'd move this to...

> +	/* SMBIOS handles are 16 bits; never truncate a Section 2 handle. */
> +	if (mem->mem_dev_handle <= U16_MAX)
> +		dmi_memdev_name(mem->mem_dev_handle, &bank, &device);
> +	else
> +		pr_warn(FW_WARN "Memory Error Section 2 module handle 0x%x exceeds SMBIOS range\n",
> +			mem->mem_dev_handle);

here just because it isn't used until down here.

> +	if (bank && device)
> +		n = snprintf(msg, len, "DIMM location: %s %s ", bank, device);
> +	else
> +		n = snprintf(msg, len,
> +			     "DIMM location: not present. DMI handle: 0x%.8x ",
> +			     mem->mem_dev_handle);
> +
> +	return n;
> +}
> +EXPORT_SYMBOL_GPL(cper_dimm_err2_location);
> +
> +static void cper_print_mem2(const char *pfx, const struct cper_sec_mem_err2 *mem)
> +{
> +	char rcd_decode_str[CPER_REC_LEN];
> +
> +	if (mem->validation_bits & CPER_MEM2_VALID_ERROR_STATUS)
> +		printk("%serror_status: %s (0x%016llx)\n", pfx,
> +		       cper_mem_err_status_str(mem->error_status), mem->error_status);
> +	if (mem->validation_bits & CPER_MEM2_VALID_PA)
> +		printk("%sphysical_address: 0x%016llx\n", pfx, mem->physical_addr);
> +	if (mem->validation_bits & CPER_MEM2_VALID_PA_MASK)
> +		printk("%sphysical_address_mask: 0x%016llx\n", pfx,
> +		       mem->physical_addr_mask);
> +	if (cper_mem_err2_location(mem, rcd_decode_str))
> +		printk("%s%s\n", pfx, rcd_decode_str);
> +	if (mem->validation_bits & CPER_MEM2_VALID_ERROR_TYPE)
> +		printk("%serror_type: %u, %s\n", pfx, mem->error_type,
> +		       cper_mem_err_type_str(mem->error_type));
> +	if (mem->validation_bits & CPER_MEM2_VALID_STATUS)
> +		printk("%sstatus: 0x%02x\n", pfx, mem->status);
> +	if (cper_dimm_err2_location(mem, rcd_decode_str))
> +		printk("%s%s\n", pfx, rcd_decode_str);
> +}


