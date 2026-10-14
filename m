Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8143B37D104
	for <linux-acpi@vger.kernel.org>; Wed, 14 Oct 2026 04:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791951161; cv=pass; b=jmOEyXJTGzlPRMsiUsyW4/zSQuh3bCYMasP1J3SGp5fqwILhklkgWfkPiYCYeEWewRs0BszvcwdJRob3IdposZcHkwEoljY/+Mavukf6iHh/4ZevFIBVpkfvGuYwYynWU2DxSI37feyctr9yebkfI0hNVnBSUF3/i6EhsjZhgts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791951161; c=relaxed/simple;
	bh=l8OShMunAP6CnTzML3fBuG0pGlsaDFB/65p8ok5Q4Lc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OC+21I+fyau/e5KNlCIKcJA/IraY6zcrfyCfHkVyfJtlmJ2uajXR8Wk76dWP2QXB6umwA7hJxPHPmED6ZFh3NQd3RN766z0ZYwbId4WkQKyg+/wX2M/gHpkxL/3rbHEozxmesq1YFjs5mSBG2TKW4uAMUV2Po6TUuUBEyUPAH2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SQpxAFcS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EknhqSZd; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SQpxAFcS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EknhqSZd"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69E2TjeQ3001160
	for <linux-acpi@vger.kernel.org>; Wed, 14 Oct 2026 04:12:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=0IToitMTYp/Rl/u3v1Im6m2B2/IkDFAQrOa2qxOYerA=; b=SQ
	pxAFcS+1SQ+AskTGAEMjYX4fMsFRgqxpslh90yM7fF594sep6OqAVAwInsXHsgow
	BL4dDj70qgx0yW/FdzUvYhHMO8SUBiok8zHTz6DSJBKyC0S4es+UWv/sZjUvtB1Q
	TxV5RCv2MGp+BxeFreqNTpTU7fXT2tpYrpmdEw6b7ZTBhWvN23zZqH0oOurCfQvy
	G3APDC2Bjgke2qis/y9PITSOfzrkrgKQsfmbESyB0b/xsLDCdGh6NNcuY6CZemZl
	CrTd8bOlb+4yZjuzD+VH5KQ6O+MpmOgd1goEeBssdRzvh3c8oFP+RtOb4dtVAjRx
	RRaASqepXNhztxsusPNw==
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com [209.85.128.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9sbet3ng-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Wed, 14 Oct 2026 04:12:38 +0000 (GMT)
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-8b0ab72a6e8so30273427b3.0
        for <linux-acpi@vger.kernel.org>; Tue, 13 Oct 2026 21:12:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791951157; cv=none;
        d=google.com; s=arc-20260327;
        b=qb5sPm+1dyrtr8MW1WjGU8vBYyYgv/f184usaFuwboRYaZZ+bz4JEjl3Yod+TGkCtS
         I/i6eI/8APbJR65Ho1OB6WEWc+ZNf0nCKcbI0NTSVWenYb/YxKREIX28M4FFNsjCpdP7
         5FnYxBrsHe9E1ebZoST89dJH1IVg4oFg4b5tVeLd9pRtAaJge0z/lD09KkD1dryAe8dY
         uESc8EAntdaaQC57cFa11YR0WgFQ0WZM8VitxrmMLA6PYjZL6GXDDkPpaSorpdFjPFuK
         sEUMpu8jooB2zC+7OPOLgwj4VPWMExJf1GEIutOB6LOhiN1SDDgqJJZS1AN5gkw7hAa3
         n9eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=0IToitMTYp/Rl/u3v1Im6m2B2/IkDFAQrOa2qxOYerA=;
        fh=eSqurMF6EonsqYeHD6A52Wlu1GYYDKlFoPPVajjQL0c=;
        b=cZrbSMq878VIz2H2C11N7nnWu7DrNRE/6uZJrhxZknwGuYbHvwpZcO+tnz+HmLWgCh
         09q85ctnvX3ON0qnYUjCa4pejQt7wXkOM/ogEjHsi965K/kbx2Yr1i82TVnwaNQ37RdH
         2J5uNaROPzu514Kfpbu+cfBjwb6Tu60/KE15fNdws/jtvHR6VcKn/b55nXeif+wJFLzQ
         r58NcPVyvaj9bo/zWXuwSUOMknwD74ynMCznMJtRzST8Ng51b17gVbljk1woTiSl1lvl
         PLwOJr8kEeYtaQq+XrqmBlDW5lb70G8l7vK47P1jRRhWfufNA9HgP47/AqecX6K+treV
         sooA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791951157; x=1792555957; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0IToitMTYp/Rl/u3v1Im6m2B2/IkDFAQrOa2qxOYerA=;
        b=EknhqSZdA02RjdPCdSlEE1sx7b/lKuo/EOOTg4GgHLOtey5qWTpLO/I1+0SlmOhSzY
         Oe3UP91lqEvde47yCSF1+ITa8aXYeQMjudEfLSCjnI5Rma/l1eAPqgfIFUBzg7tfpJvn
         K8Vv0TtqJTtrGx0kXDkPoo5CIvxUgjc1eGn6pBB/s10fNK3xO7dPt3nqXFj/LS74tu/m
         dECyzsMAI/wCFKS6r7H2YWcVgAOYehm//I5LS8q4sWFFvIyBI02uxhbNH0jX+VJierBX
         laCVYLuTMl9QdG7SmTnuYA3ghwO0udl8ZfF/kMqalrvGWSWt5dWtBMzfvvyvnJpIea6j
         BhKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791951157; x=1792555957;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0IToitMTYp/Rl/u3v1Im6m2B2/IkDFAQrOa2qxOYerA=;
        b=qsTzYzOB/g3NTmNDdN3addc+ZqJkauBrw35mhnzkNmTtolxBkQ3bopAiGPuZTOvcqV
         7KRXhLB0cbtCekmqnUid4mwJMyelK/CdUkeWY6T9n+l0wr6BAsc78PDLi9vAbF7Mf3zf
         MFeQ7tijJBDHaDaCYwXQqbjHJ37KqjVFpkG6b8a4yyYlKmQLgi8niZ+tUBOPQd0ixFZD
         L0OYo7RszxKZp4mcRav442kZId94eNHxUja9NikpGx4BgTVCgOwIAPzM43jJi763lgDs
         P3Wu5bRSV9zIh1DCoQYvTpshJef3Vn0X9nK3eixX5cIsDV6yCSZ7fP6NReRVjdKvnei0
         oATg==
X-Forwarded-Encrypted: i=1; AKwUvBxhtK5MnJgk1IM3vr2qn86QNVUrjFZVLXfh5Qj2q1GCTOZiX69n9mrf63jqOJI5oIowc5XYGP2h80lI@vger.kernel.org
X-Gm-Message-State: AFq9FYJ54o01FSr+mBDYvzooZeXT/EY9HINnt4PLs8DctkHHPVh0QMWy
	GUKRTTJgHb84L6Kdosvyk9/OS6sud6SmANhgO6afjA2YYIb+ZQteM25fGFYMgu40dOyi3HH1ylK
	i67XG52L63YQW6MI24YL8HZWugyjMAu6IPGhMzJvy38afro1XWGRPwnLAmlKsSvI1PHhFljAKF+
	4NitItcufFfns2/apMT2j0l18FzTYWFu+rfD/pOLg=
X-Gm-Gg: AYBFou2gZIvUEcqVuBdhyoL/7BKQQeA32JzRkebQ1iwpfpLf3i7teH98eG3toUio7Xh
	CwWWwnKJ/2EdMUoxs5mCfVpjQsIt23e5Mt/zvwBVjbxgJe0uBDJV+t48GLxojkEAVljsfeGZR5E
	PwOkTkTsBkNfwX9Di0zAN/TvXBVtxl217HMBs8oCYDYGY41jQB2O7P6wcnbKE=
X-Received: by 2002:a05:690e:128c:b0:679:8835:a554 with SMTP id 956f58d0204a3-6798835b6f3mr595920d50.94.1791951157067;
        Tue, 13 Oct 2026 21:12:37 -0700 (PDT)
X-Received: by 2002:a05:690e:128c:b0:679:8835:a554 with SMTP id
 956f58d0204a3-6798835b6f3mr595910d50.94.1791951156684; Tue, 13 Oct 2026
 21:12:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903140031.3684-1-fangyu.yu@linux.alibaba.com>
In-Reply-To: <20260903140031.3684-1-fangyu.yu@linux.alibaba.com>
Reply-To: sunilvl@oss.qualcomm.com
From: Sunil V L <sunilvl@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 09:42:25 +0530
X-Gm-Features: AclHuK86voQc4FUtiCdkEZEAZb2HJ7wq0GZX-kU_HOfP197uYVxA3KPb_kIuB4o
Message-ID: <CAB19ukELrF5wf3vKaPhoCLWmzGDExv1mZQAyEs8K6uq-zxqsKQ@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: RIMT: Enable PCI ACS for root complexes mapped
 to an IOMMU
To: fangyu.yu@linux.alibaba.com
Cc: rafael@kernel.org, lenb@kernel.org, pjw@kernel.org, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, alex@ghiti.fr, guoren@kernel.org,
        linux-acpi@vger.kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: BMwLvCqbsHaM-z8ZBrwnP2OJlvgKgS5o
X-Proofpoint-GUID: BMwLvCqbsHaM-z8ZBrwnP2OJlvgKgS5o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDAxNiBTYWx0ZWRfX3tUT//a5vTIw
 p8j6eZwjQrR2SuFo6qpBHL/qxSzc6dOBdaLK94Z2bW8r8C39ubUadaF5jy7+BawskUGOAb0gxxs
 8jjjqGrjsHHj1c/kpP8qFyQvwafPdXzhE7KYEMICSBoWnAfwVmC9AwOHea5brTBac5YyCTxYMzE
 9iRQtbJebjrAr/ORCeDrTBIVneemKD85lkmmJidrnVhMI49NldJXbvK29KP1NihLpxrbsUR1T3F
 DGX3Hn3a+EvIHcGTq/mmEOAwsrHjEgVPFW7r794Pyx+CKuXk/3mha3zGJdK7hj3zTt2N8Mph5rZ
 i8u45LpA0AFo18mumMQp5a2dpgyqJlF38T4TZjzMvCsEOkFpBzSuvqdz7g65Mv0alNFwoiwm/07
 K0MfxjQjT87eeV3jWjPmAYnVJECSxxWX1gsjzuZXqsvO03lXIR6v7a9vt3lZd6T3uN3UQN+bik6
 eyPDeMe6ts+OTRa5Gbg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDAxNiBTYWx0ZWRfX32grwDzoc+qi
 hB8evKazyAtE43nq6BajcqgvHyMYXTblCVKtYz5q0SuSk5vXm0/PU7kk6eESS+kXNFrv6xf6TPD
 PCtNCFy6risg3iatPbWFouJxVWvvRG8=
X-Authority-Analysis: v=2.4 cv=U7AHnuru c=1 sm=1 tr=0 ts=6acf0136 cx=c_pps
 a=NMvoxGxYzVyQPkMeJjVPKg==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=SRrdq9N9AAAA:8 a=EUspDBNiAAAA:8
 a=N72Xn8VYRMkAawgvMsQA:9 a=QEXdDO2ut3YA:10 a=kLokIza1BN8a-hAJ3hfR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140016

Hi Rafael,

On Thu, Sep 3, 2026 at 7:30=E2=80=AFPM <fangyu.yu@linux.alibaba.com> wrote:
>
> From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
>
> Mirror the ACPI IORT solution used on arm64 (see iort_enable_acs())
> by scanning the RIMT table for PCIe root complex nodes during
> riscv_acpi_rimt_init(), which runs before ACPI PCI enumeration. If a
> root complex node's ID mapping points at an IOMMU node, call
> pci_request_acs() immediately, so pci_acs_enable is already set by
> the time any PCI device is scanned and pci_enable_acs() runs.
>
> Only one call to pci_request_acs() is needed regardless of how many
> root complexes are found, so track that with a static acs_enabled
> flag, same as iort_enable_acs() does.
>
> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> Reviewed-by: Sunil V L <sunilvl@oss.qualcomm.com>
>
> ---
> Changes in v2 (Suggested by Sunil):
>     - Check the RIMT node type in riscv_acpi_rimt_init() and invoke
>       rimt_enable_acs() only for PCIe root-complex nodes.
> ---
>  drivers/acpi/riscv/rimt.c | 58 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
>
Could you please take this patch via ACPI tree?

Thanks,
Sunil
