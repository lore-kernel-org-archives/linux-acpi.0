Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB38381B06
	for <linux-acpi@vger.kernel.org>; Fri, 10 Jul 2026 19:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783710065; cv=none; b=M99Cp1j6uxkRrUfR/1avR+lkofipJqGYuownLOtjByEXzlMuTuEuB1UNOVoxOgSgG03PLAHxFcyg2e60Wfw1TgNv8PMDxy/Yn3qrbEpzrUjJ9CJrnTzH5+bQ3pB7BkkjODiaeJoWiVJAJqqExy0OXfl4j9icRqpePltF6KdTjG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783710065; c=relaxed/simple;
	bh=c4pCxOSWNeyw9OA8quiOrInnSaw3jSzff/igS4xfCds=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IgtKLUCsakwDqX7E629vHunF+fTX9XJ0WOADhaOmfNsU4F5d+VtvxqZjgs5A8M4x6tg1VvHc8TemC1NTkZwQ7PPKtjIA2DxacQfgMmsseaTbY9CuIbhE0BRY0kH8nBLh4XrUfNhQVEdNeVS/yZY1//xwiSkoT8T/1W56b8dp3bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a4Su2zZc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Z39dhjmy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a4Su2zZc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Z39dhjmy"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66AIXEN71649859
	for <linux-acpi@vger.kernel.org>; Fri, 10 Jul 2026 19:01:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YUtnHG+BK9mkHTRK8KTulqBVc1mAgv0yZV42NgWuxko=; b=a4Su2zZcxKIbqtgu
	aVHcnGkUDhSYar4MzEDxWyLSpS4NWE2+g19EsgwmsWhLsUSsL7m32MHRiPAu2D4T
	sh86omXAqfp2ygLRoPNKcshw78PRkN3VggrXmpCky4LK2DvWKMrOtO57bKf3yy5C
	P4JHRNYGir07WoH8+7K8jNhorx/pZg9tn8O/onZuUmwfMyvFAOY9CkdEwpNL97mm
	FjkO3f1OKUSSN1p/04dREr4xSSsn0RjJhOD6QtRy4RDn10EdfAR8zdpAsCLMK/6T
	lc7X9nPNe15L572kbznEUYbeJ/MKziD+v0xpbtaFEvhFJVAE69rs0AXF811cECa1
	hOp/yA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb649r39j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Fri, 10 Jul 2026 19:01:00 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-380a638fb5bso1478158a91.0
        for <linux-acpi@vger.kernel.org>; Fri, 10 Jul 2026 12:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783710060; x=1784314860; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=YUtnHG+BK9mkHTRK8KTulqBVc1mAgv0yZV42NgWuxko=;
        b=Z39dhjmym8vqHrctv5qe16ug29QVXNMkirQ3v+OVADlecechJg3LITj31B68OQeZJL
         ZxfZpiVKuY1i1IawHQGwNf4bqUyJ60bmeWEqyJ5TSyfKJFWCLTK6JOdLCFNKKTZ3NNYX
         vi2Fkhw/zXIpgPWkFXnUktdQSrTQQe9qqVV3pR5Pk5ZjwVp+Sb4OyN5FvmwZT53hufFB
         wyWJW9l1mkvH/rU2aM6N7sSKSRDswe3nZ7qepheu9JBKwRvhHSq42eAmSkym8ogsQd4Z
         1dl3003bLruQTPXgyi8NZmiB1/2JMsSjWbdROmNMygQ/5ZRlxSu4/uM7Zm3os4Sq/0pj
         +//Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783710060; x=1784314860;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YUtnHG+BK9mkHTRK8KTulqBVc1mAgv0yZV42NgWuxko=;
        b=KdADfDpAkpmPaya+1zGRSba0cdpaK/AVxNmWXyebOyNwf3khMXsSCOjUuY8bRZ8f+W
         lbLUWVOUKlDOv+Fg2ya8bLIM8kV4WVkJGvA6KzK0/6DTpaIizCMIfrUJJhLMetICe1dO
         nXa7Nv9/0sd5ekRVkPNZ8hF4V/f6AA/euEFJfLuIlEliQG+qNb1Njkujic9u+B0GRD9E
         D54vumRNAvY1Vll6sxsNQH4pDiosJI7BEcahvMXvnWECBk2ih7enlh7RyRKVRh1xnJTz
         rU0fsgwS7NWGuUk9MJ0AbELgPiXF4ljcZJHOMsCA0tSEprnUnrqyi5VrxsLPGDtnHhd0
         ViFQ==
X-Forwarded-Encrypted: i=1; AHgh+RqSQkyzb2LC2wn3CFu+dz9OOqlYlyw3GGytYj0YOlNKEhOuLthRSkx7AY2iuMY/XnGA90bVnAMLbVRu@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn7v2XHZqkKax7HfqAN8LOF2myMZdJ854aD74dU7Z+4bLhN/Z+
	XJg4XAESjyld9pboesn5af/Z8KpTx9ZpgknrDxmtWj/9Suq0zkLrn0nIQ9JFhv89Ws+8ewXtLZs
	k372KQzk72ffPEjLWok3z3zfIFxGWY1OyzLlkdrrOYat+sw1Wsdw2PyxQmhLKsh6M
X-Gm-Gg: AfdE7cmZb8n+Dhf8O+38lsWKFJz/oExHPUUbg/vVxUGCwMlTloQgWEYWgMgmRWxSgjx
	gKNsut/tkkLzXgsIvUzM11oj8wmq3P6h+hGeF5AvLZ+aScI7rzpZcft2Q0xnn/Q9vo8gXePNngX
	oNpmm5u+AdqLAI1+Z5n4K4fKYjnrtMAVaHzGNr9T13rhge7t45d2hxH603+eoGhhge15ES4zDxu
	OZr0ws6bZzhkBodMdjicn9aTX6Pt+fH9nFkpvt9dtLk4bh2qzk8OJ3uMBoEJo0mXJgGia4Gyzrk
	iqx/a9E9go/iM4GU7HL0VMPFjL98Z781Xph9dlltzfii3q1NQzSSYO74nqqSNXv+uxRN8YBjrcX
	zswzue1FiOmLxFdxINEav8VdHMCKszyUZ28+O
X-Received: by 2002:a17:90b:1b06:b0:381:dd0:94e6 with SMTP id 98e67ed59e1d1-38dc7777d42mr196167a91.22.1783710059579;
        Fri, 10 Jul 2026 12:00:59 -0700 (PDT)
X-Received: by 2002:a17:90b:1b06:b0:381:dd0:94e6 with SMTP id 98e67ed59e1d1-38dc7777d42mr196123a91.22.1783710059153;
        Fri, 10 Jul 2026 12:00:59 -0700 (PDT)
Received: from localhost ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3117483dec6sm44214111eec.11.2026.07.10.12.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 12:00:58 -0700 (PDT)
Date: Fri, 10 Jul 2026 12:00:54 -0700
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Hanjun Guo
 <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@kernel.org>,
        Catalin
 Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Rafael J
 . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        James Morse
 <james.morse@arm.com>, Ben Horgan <ben.horgan@arm.com>,
        Reinette Chatre
 <reinette.chatre@intel.com>,
        Fenghua Yu <fenghuay@nvidia.com>, Jonathan
 Cameron <jic23@kernel.org>,
        Srivathsa L Rao
 <srivathsa.rao@oss.qualcomm.com>,
        Ganapatrao Kulkarni
 <ganapatrao.kulkarni@oss.qualcomm.com>,
        Trilok Soni <tsoni@quicinc.com>,
        Srinivas Ramana <sramana@qti.qualcomm.com>,
        Niyas Sait
 <niyas.sait@arm.com>, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 08/16] arm_mpam: propagate MSC read errors for state
 saving functions
Message-ID: <20260710120054.000035dc@oss.qualcomm.com>
In-Reply-To: <20260710144520.917375-9-andre.przywara@arm.com>
References: <20260710144520.917375-1-andre.przywara@arm.com>
	<20260710144520.917375-9-andre.przywara@arm.com>
Organization: Qualcomm
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: ZGpBOxsRtZUCErlac3FaN-zNbtuoHQrZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDE5MCBTYWx0ZWRfX2cSY1Q4zQwU0
 fa+vFZlx/NQRQTPU2WTA2DlUcU+ULRY9DMhllHNj8UDO7brkuPvIVLsHbtrczv2TwObvmh49Dz1
 1RbYv8d7EUJsC5rPq2PROGEG2RxOST9T3GHtS4rUdTtLPx599tfai/TpSypdOTDF07MpQHPBKjB
 taAUo6P+BGnUvO9F6DLX07DskvkEDjqM8Aghd6+VoH53A/r6ebtPrzINWZ5BhaxpuFJeD1igKYL
 tjVAmNatxMQ70zwBExGDzoS1NhY+JSDyHXTBNf7ZVqdN/oXVpkLL/tV2En2RGj2Z6faqmFr0ofW
 jGdgVEFxrAsYXO/8InUf/C05FB5ZzFi1wkNuoAqM5PQiIpuW+a3NgOnBkFA+OTvZCdr/hsHAXKV
 pmYqN250AneT6cV8I/pwUcJjqBOhk/zcXBLQhHHDqqWB1im85tN8XbdF1rS7A1OAA95CMzHSrzH
 gRVtW2L15nBXSwcuWPg==
X-Proofpoint-GUID: ZGpBOxsRtZUCErlac3FaN-zNbtuoHQrZ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDE5MCBTYWx0ZWRfX2okBiohhDWCD
 6EPH4z+7D+fQech/kDkEXYvWn3GH0G1pMxZB5MiinIoR6Mx2yJJZZf0zJXMuMYAp2xPkBSN9CX7
 L0Od8+JW9DIQ0aH5o88/7uvWD9JPHtQ=
X-Authority-Analysis: v=2.4 cv=VZfH+lp9 c=1 sm=1 tr=0 ts=6a51416c cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=7CQSdrXTAAAA:8 a=rMF2o8FrK2TGcKdZMuAA:9 a=CjuIK1q_8ugA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 phishscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100190

On Fri, 10 Jul 2026 16:45:12 +0200
Andre Przywara <andre.przywara@arm.com> wrote:

> Allow the mpam_save_mbwu_state() function to return an error, and
> propagate read errors from the lower level up.

I'm not following why propagating errors is related to the
if (val != MSMON___L_NRDY)
as nothing in this patch is changing val.

> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  drivers/resctrl/mpam_devices.c | 30 +++++++++++++++++++-----------
>  1 file changed, 19 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> index 530ac0fe97b5..b2ecaba29fcc 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c
> @@ -1782,7 +1782,7 @@ static int mpam_save_mbwu_state(void *arg)
>  {
>  	int i;
>  	u64 val;
> -	int ret = 0;
> +	int ret;
>  	struct mon_cfg *cfg;
>  	u32 cur_flt, cur_ctl, mon_sel;
>  	struct mpam_msc_ris *ris = arg;
> @@ -1799,8 +1799,12 @@ static int mpam_save_mbwu_state(void *arg)
>  		mon_sel = FIELD_PREP(MSMON_CFG_MON_SEL_MON_SEL, i) |
>  			  FIELD_PREP(MSMON_CFG_MON_SEL_RIS, ris->ris_idx);
>  		mpam_write_monsel_reg(msc, CFG_MON_SEL, mon_sel);
> -		mpam_read_monsel_reg(msc, CFG_MBWU_FLT, &cur_flt);
> -		mpam_read_monsel_reg(msc, CFG_MBWU_CTL, &cur_ctl);
> +		ret = mpam_read_monsel_reg(msc, CFG_MBWU_FLT, &cur_flt);
> +		if (ret)
> +			goto out_unlock;
> +		ret = mpam_read_monsel_reg(msc, CFG_MBWU_CTL, &cur_ctl);
> +		if (ret)
> +			goto out_unlock;
>  		mpam_write_monsel_reg(msc, CFG_MBWU_CTL, 0);
>  
>  		if (mpam_ris_has_mbwu_long_counter(ris)) {
> @@ -1811,20 +1815,24 @@ static int mpam_save_mbwu_state(void *arg)
>  		} else {
>  			u32 val32;
>  
> -			mpam_read_monsel_reg(msc, MBWU, &val32);
> +			ret = mpam_read_monsel_reg(msc, MBWU, &val32);
> +			if (ret)
> +				goto out_unlock;
> +
>  			val = val32;
>  			mpam_write_monsel_reg(msc, MBWU, 0);
>  		}
>  
> -		cfg->mon = i;
> -		cfg->pmg = FIELD_GET(MSMON_CFG_x_FLT_PMG, cur_flt);
> -		cfg->match_pmg = FIELD_GET(MSMON_CFG_x_CTL_MATCH_PMG, cur_ctl);
> -		cfg->partid = FIELD_GET(MSMON_CFG_x_FLT_PARTID, cur_flt);
> -		mbwu_state->correction += val;
> -		mbwu_state->enabled = FIELD_GET(MSMON_CFG_x_CTL_EN, cur_ctl);
> +		if (val != MSMON___L_NRDY) {

with ACQUIRE() you can just do
		if (val == MS_MON__L_NRDY)
			return;

and leave the rest where it was.
However I don't actually see what this has to do wiht the main purpose of the
patch to propagate errors. Perhaps a bit more detail in the commit message.

Thanks,

Jonathan


> +			cfg->mon = i;
> +			cfg->pmg = FIELD_GET(MSMON_CFG_x_FLT_PMG, cur_flt);
> +			cfg->match_pmg = FIELD_GET(MSMON_CFG_x_CTL_MATCH_PMG, cur_ctl);
> +			cfg->partid = FIELD_GET(MSMON_CFG_x_FLT_PARTID, cur_flt);
> +			mbwu_state->correction += val;
> +			mbwu_state->enabled = FIELD_GET(MSMON_CFG_x_CTL_EN, cur_ctl);
> +		}
>  		mpam_mon_sel_unlock(msc);
>  	}
> -
>  	return 0;
>  
>  out_unlock:

