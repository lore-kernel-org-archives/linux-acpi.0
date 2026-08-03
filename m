Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7023878F39
	for <linux-acpi@vger.kernel.org>; Mon,  3 Aug 2026 22:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785795434; cv=none; b=LS6jNbMtY7r/SEezPa3SldOlKfPT04YfPy3xSYQthZk3xlWeuoh+fYlcfQPkTpKnxlZL+1ImbfrZlh10UslFqu048q0GLjL1LO0voBMURGHDr7iFsxzQQahrY3w3INUhlVvfE3wnfPWEI9T+Xk3g1DfOsWZsnambRukdZdju4cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785795434; c=relaxed/simple;
	bh=tmsuUTAyD0B76ZoLl25Sy2DYjpwD3rFbPv+VGvOWMRc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mbb4kBgsaR2lWp+o01v8TO94M0DUYBjZEuF9183iPesTrBoFE0m1F+sP595nPpmoEbB+aOeM8IMfWCopMNEnUCHIHlTaian03meNTbZVVgEdqtxKJFc7dyH0MsBzavorSeUgK96Ts8hFGlVrPfLsTA3V2jXyymBMujOGflc3FIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ARY0490U; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bhgXdROF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ARY0490U";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bhgXdROF"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673JkggU1750275
	for <linux-acpi@vger.kernel.org>; Mon, 3 Aug 2026 22:17:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	U/aBEbyITsGpQyxAY6tp7ki8lSr5wOgar9R8n9o6Jkg=; b=ARY0490U81Yk+gJM
	EN4Ga8z3S3iHGpqDYUrdQ+OmU16PQ+cvdXOy5pTD7kSVRRfEj0rwdkMpYePBxpgu
	7gMsK9eTTY44CrxYvFXHFmZwjoreckigJWCe381vOWV4cQ/mKW+gMMIh4Rabi9W+
	n+JXSqCbrbOhb0zOrVEpiEK/R8ECuBzW36EDGhqhIO+Tkn38kS/hWZ3T1YBMoP6p
	LpLq0CTeCZHT4+ZC33I2LIE4LjKBLmfTEraT8pVS/B9QXlgH1aHFPRMdRtGthOd4
	L0/tFKVIEnohYlWnvL5Hrtzf97lkAtktxJc+ZmfDXFWeKGvSFvOeOT7O0torGN0G
	v7SEug==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fty3r185d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Mon, 03 Aug 2026 22:17:12 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cb835525b13so4836277a12.1
        for <linux-acpi@vger.kernel.org>; Mon, 03 Aug 2026 15:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785795431; x=1786400231; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=U/aBEbyITsGpQyxAY6tp7ki8lSr5wOgar9R8n9o6Jkg=;
        b=bhgXdROFwIfsH8CmccBRq8fSiZpa2EOYFHd4DSi4pjBGcduh3HXzR+ds7b/oou8N+y
         Pf2fym418jViGxgu3kMlybw5RWHpwW8FrCBHqgl/or3yW2FROVj2WXuSwlhUYhFmTZQ1
         TJxeLT193McTQEtTDEv7i8HDL+lDC9TLQcFach19jxsB4HNUL+7kOyGv102NNXFusZIz
         vtCg7Jdkn85v+VIjoF6yRDdyytIfudR8Gr3umyCSDz9N7br4XSoqJR79bQGnytpUPq8B
         ugVatPGqeWOnef/Z+trmLMmoK8U6VjH5056Cuxtpu9BlnLDCu4gba63B98flOvwfl0h2
         +BNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785795431; x=1786400231;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U/aBEbyITsGpQyxAY6tp7ki8lSr5wOgar9R8n9o6Jkg=;
        b=J210uxcTjF6rngA2VP1dkim/sOqrfz6DNfJ8SiC82uavXEASl9iQHhJnQ6HQcmsBXh
         4tvUiBZA2P31Rts9zq2hf3v7W2t+7pm+XGU48dVI71cgm62JYqzYjP0HAhoWkpmzjGCh
         opun6A+zugw9LusDgAeEU9KYnHmiR7sO4cSa9i3BSeKrWcyJ4vr1ymuuXhFhHswcpCHx
         jJgcvuiNRbsTQHA5nsABiil8YKHRw355ZyY8LAnsFH/S1jcZBupVOZ2Yp0iWLePkBWE+
         bQ0Wf3FPKTUv/dPNn1mJZem3kddeojkCSY8gWFN1ehj2OQC+3zxrpWDcyERSfyFA6tNX
         hgYA==
X-Forwarded-Encrypted: i=1; AHgh+RppRisWte5LmQBjCbrkzeXfesJev2iJHAjOthio1FFLl3Sq/DfVFlIRIlFD4akHq7hIT/Xmr1fKliT0@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf/5jtdGFonIx96ODUMIfNQtI6O0S1Z+zzXBIkob+sjlIme5M0
	r0dM1BXSAWrXCCuYKB9vWlzXDEKp8zclobauAvG4OCzV0DHkCXLLADqWXJRVwZ60yqQHCwzi9w8
	jYvkZXv0bXJVcUDPeOjpvX0zDpINJDE641iL+xTxFhpNSiFaq+6ReGYhsH2QVOX/V
X-Gm-Gg: AR+sD11GUtBZEMSZaL2K4PTv+tnaof8uE8JkDk6MfzXmGjExUJvGHURTW6R1mhyoiP/
	jYUTolnR5OyTdcROAm2+UnYp/7wjzJYXcNhWC1k0Z8yNSPa3I+HjtlsfoyPvlNxmg4X6OFbWTvo
	D+/Wkn69CQGj7FlVKigCSFsyAvK8oVNZPnMPdoHUz9edt159w0mdQvHLpa7O9AFZOhSOE5stXCi
	dmSBUwnBDbGwbSUqPSQWPfbFMwFc3/hY7WM1MLcujkDrRmRKVtzITsixtdtjmJej9OWaCFmWxZt
	Ka8W1F3Z0hdkQKbMwFaLedgZlsfTJ7XVzdFdcN6tkuscpW2bzGxbtconAoC6EzJnWhwTQNct8WT
	2RN+/HNE+iD8W27OuIdzMtoIOdw==
X-Received: by 2002:a05:6a20:2d09:b0:3b1:cce5:9140 with SMTP id adf61e73a8af0-3c92a75ec8fmr11363093637.33.1785795430834;
        Mon, 03 Aug 2026 15:17:10 -0700 (PDT)
X-Received: by 2002:a05:6a20:2d09:b0:3b1:cce5:9140 with SMTP id adf61e73a8af0-3c92a75ec8fmr11363071637.33.1785795430445;
        Mon, 03 Aug 2026 15:17:10 -0700 (PDT)
Received: from localhost ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153dd4f197sm43287766eec.6.2026.08.03.15.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 15:17:10 -0700 (PDT)
Date: Mon, 3 Aug 2026 15:17:06 -0700
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
 <niyas.sait@arm.com>, Lee Trager <lee@trager.us>,
        Ritwick Sharma
 <ritwick.sharma@arm.com>, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 06/11] arm_mpam: propagate MSC access errors for
 state saving function
Message-ID: <20260803151706.000027e6@oss.qualcomm.com>
In-Reply-To: <20260731170324.2927758-7-andre.przywara@arm.com>
References: <20260731170324.2927758-1-andre.przywara@arm.com>
	<20260731170324.2927758-7-andre.przywara@arm.com>
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
X-Authority-Analysis: v=2.4 cv=caPiaHDM c=1 sm=1 tr=0 ts=6a711368 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=7CQSdrXTAAAA:8 a=EUspDBNiAAAA:8 a=CJK1izrmERu_2sfnVPYA:9 a=CjuIK1q_8ugA:10
 a=x9snwWr2DeNwDh03kgHS:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDE5NSBTYWx0ZWRfXxnaq6npTvzFq
 owoLHr7cI802Nsz1dcxewF15M2L16IslpAnMqXcVVle7cxOOlxWCI6noiyt1g9dC7ZXEFJFjTGL
 BgaoP2cTEm8rocgmDoCduHXz7xZHcME=
X-Proofpoint-GUID: C2yPbhpibWnx2gOopaD1Kyukdw1Od0d6
X-Proofpoint-ORIG-GUID: C2yPbhpibWnx2gOopaD1Kyukdw1Od0d6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDE5NSBTYWx0ZWRfX3FRNkeDEd2fn
 HtsKUHnGv50EOxZbPPkFaf/zsLXHgHzkPM8bkFqah2npVKlAzMaXhLXTJ/Ml9rIIGehTjCXXTXT
 YoUBjE+2vaWK63GzNQY3AASZv7/0z4AZbkx7va+e9wzmsY5N4EN4iqfIPmKc8yZ649kuUMYNru+
 uJ4I5eGLJwFkXPdOo9lrB8T2SQ6llSu4uAeOPlUh8yq7Kc7rDZCt1PJk9jrocAszoQ6Yo8lv3Yd
 uwh2+6tBKAT7iNrkNyXmqsNHF/3MyRslg8DwrLLwrjOWB+vu7NFxQ4YvyQGdY2p3zmeoKNXukqj
 0vfUV8yA7o78sbhyUvXHFsZqa2BpOYC6uzgaHK5JTD+KSmgVdVDqqntI/GdqBhFaCR6oHCoeFMO
 w2j8UMN4nrSxSzduCtjnplmnBBPPdr/RQcldAiIlHI6huGORrSAffhwp8u4Q/xWJrh0bzcFQIbu
 jf7EdXR++Fa1tfJHi6g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_05,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 phishscore=0
 suspectscore=0 spamscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030195

On Fri, 31 Jul 2026 19:03:19 +0200
Andre Przywara <andre.przywara@arm.com> wrote:

> Allow the mpam_save_mbwu_state() function to return an error, and
> propagate read and write errors from the lower level up.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> Reviewed-by: Ben Horgan <ben.horgan@arm.com>

If you happen to be respinning i think the code grouping vs white
space in here could be slightly improved.

> ---
>  drivers/resctrl/mpam_devices.c | 29 ++++++++++++++++++++++-------
>  1 file changed, 22 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> index fa8ed20a6740..38450c55e45e 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c
> @@ -1838,22 +1838,37 @@ static int mpam_save_mbwu_state(void *arg)
>  
>  		mon_sel = FIELD_PREP(MSMON_CFG_MON_SEL_MON_SEL, i) |
>  			  FIELD_PREP(MSMON_CFG_MON_SEL_RIS, ris->ris_idx);
> -		mpam_write_monsel_reg(msc, CFG_MON_SEL, mon_sel);
> -		mpam_read_monsel_reg(msc, CFG_MBWU_FLT, &cur_flt);
> -		mpam_read_monsel_reg(msc, CFG_MBWU_CTL, &cur_ctl);
> -		mpam_write_monsel_reg(msc, CFG_MBWU_CTL, 0);
> +		ret = mpam_write_monsel_reg(msc, CFG_MON_SEL, mon_sel);
> +		if (ret)
> +			return ret;
> +		ret = mpam_read_monsel_reg(msc, CFG_MBWU_FLT, &cur_flt);
> +		if (ret)
> +			return ret;
> +		ret = mpam_read_monsel_reg(msc, CFG_MBWU_CTL, &cur_ctl);
> +		if (ret)
> +			return ret;
> +		ret = mpam_write_monsel_reg(msc, CFG_MBWU_CTL, 0);
> +		if (ret)
> +			return ret;
>  
>  		if (mpam_ris_has_mbwu_long_counter(ris)) {
>  			ret = mpam_msc_read_mbwu_l(msc, &val);
>  			if (ret)
>  				return ret;
> -			mpam_msc_zero_mbwu_l(msc);
> +			ret = mpam_msc_zero_mbwu_l(msc);
> +			if (ret)
> +				return ret;
>  		} else {
>  			u32 val32;
>  
> -			mpam_read_monsel_reg(msc, MBWU, &val32);
> +			ret = mpam_read_monsel_reg(msc, MBWU, &val32);
> +			if (ret)
> +				return ret;
> +
>  			val = val32;
> -			mpam_write_monsel_reg(msc, MBWU, 0);
> +			ret = mpam_write_monsel_reg(msc, MBWU, 0);
> +			if (ret)
> +				return ret;
The grouping via white space usage here seems less than ideal.
You have:
			ret = mpam_read_monsel_reg(msc, MBWU, &val32);
			if (ret)
				return ret;

  			val = val32; // this looks to be part of block below not above.
			ret = mpam_write_monsel_reg(msc, MBWU, 0);
			if (ret)
				return ret;

Probably:
			ret = mpam_read_monsel_reg(msc, MBWU, &val32);
			if (ret)
				return ret;
  			val = val32; // Now it is in groups with related code.

			ret = mpam_write_monsel_reg(msc, MBWU, 0);
			if (ret)
				return ret;

Or don't have a blank line in there at all.

>  		}
>  
>  		cfg->mon = i;

