Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABB83B19AA
	for <linux-acpi@vger.kernel.org>; Thu, 24 Sep 2026 22:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790288428; cv=none; b=RHcaGi3Lpn+oZaxU1MYNRyEhJbm1kElH1YXwTIek1JUkSdusvfD0Fp0iVWMXk7yAn0a9rn8hfZLpozhWTyTAGqqN8D0GFXroLTli75SGMBXEdY+gHpdY+BauRqVNoima7Yo5C8Gju5p+09rRu9XIJFfW6h8Bb4ZNeBvTnaE5fh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790288428; c=relaxed/simple;
	bh=yPDFtSzOArCINVVZkEx+dztNh/aGMUPCr8wwfmMt9Dw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H0jxgeKS54WM9e+pFBBYrdKHMoG3EcwgCRBvNBGKpp4FR9prXw2A90zfktg4zYfMggQnagqBoyf5vZNb8AMqPBc+91qZ8a7KpU6m2mCZyIs9rxjqVxSz0QnYmyYw6cIeNuidWcNfCd1nM0qf/cfx5Z7T4ZtRDydm0w0HbBRk27Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HrdbwMeI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FnbRnz1z; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HrdbwMeI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FnbRnz1z"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68OIdjeZ1672792
	for <linux-acpi@vger.kernel.org>; Thu, 24 Sep 2026 22:20:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4zZceZgWFQ3ZLDRQVIpqHYrcnvzmelr0JdvwQT4DK6A=; b=HrdbwMeIqm0nSjmN
	zCT4rY+9fjyOwZnb86hfmPeEx0yFmklUtVf2lzQL3djhfocyVLQPPLI4CTBUDgdv
	A+VIqqMUH5lo5eRQhxff+UQFhsGBr8lWbb3+8x+JRR++mjoBxqBZMyBeimadoZ+1
	9omb1qw4EQGcMJeHkkaO/jfpEHS5LPuw2yEw9TEPzsXbEvmjFf0tCHrTHXxJK09s
	EooV/JiZdiyFnqdFfbQLyTwyJw+RWyzmgHrG7IpO/MWKN07vrUGdxSUPwKrZVq8d
	tbbsm+RlLcKJf7XVMApEI+82DzfaCCejMFFBCBQ4xmvI9QGWQr3BFno4sqODbhPk
	URo0hA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw1scay25-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Thu, 24 Sep 2026 22:20:26 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-3284bbaa89dso932839eec.0
        for <linux-acpi@vger.kernel.org>; Thu, 24 Sep 2026 15:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790288425; x=1790893225; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=4zZceZgWFQ3ZLDRQVIpqHYrcnvzmelr0JdvwQT4DK6A=;
        b=FnbRnz1zJJqx/LNEGaPno3JPrzK8JNpzLR8DVkRg9m9FShV9bfm86oUSQWysA5JyTS
         JQaPvF0zn4OWBjwC3+Il0JoQN95IMNcvzyw2F1qTYIfqJNRD702JuE1ymS12QmSZiYCr
         yhNbQTtAPZtZZ4KhuPWmpDsV6Qz4PwwUGH2zIuEkOCDFTHNpmdgb0oAx9J0mj5uK1S4a
         glKZD0JzrrTCNeqTWS9WUV1bx6quJj1HwDlpsxmYCjSD/yeHqeguy7BS/uyMM6nJA2BZ
         iIhOOzHmqtICXt05anhb9BzKVOjlcAlgbiHG0ecXhD7S+lNNlcdabvRfobLNUjzKnXJO
         9DCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790288425; x=1790893225;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4zZceZgWFQ3ZLDRQVIpqHYrcnvzmelr0JdvwQT4DK6A=;
        b=TAI+jUwsTZf5RO0dpZQZTudjOlGuTF1AEGWw7XfPH2fMNNtw1rOw0fHrHcxXJx48Ry
         WgAyB8EnW95UFnT8OR4lzSmZ/HB/elG/kzwPqgpmTxz/iyHVPFNC51oDNoFT3QnHZ2hk
         hrVVCgSndGFe9eYl3TOVDgiu0rHjz0W4yJx1yi/VXYGNQKmIRtsnWuM3PpSJTt413Kmo
         P3WROAN0meua/PNt15GN6ObZcJTA9vc8hTR7RT5EdgH3fRPGIW054ICBuv+gLCPBlSEH
         M1hIq9qDGcuGAzww3TzcwRu3J6r0Qi7DtQq9tAEV4lm7VyDDv56tHYFUh3k0zlta0/S2
         1njw==
X-Forwarded-Encrypted: i=1; AKwUvBz0zzkmQ1IN7WAjP3oPyqYBoazJVCmP1FEqEg0K1OTyitTRt7VZcQLvnKubQnqYe80zBugDpPPClRlS@vger.kernel.org
X-Gm-Message-State: AFuF++m+DhbIsRsbrjPv5MRBP5A3RlrnrTxwdTPEYfxTocUJvorJ6xA/
	UVWcjWgIlskbblFv9kH5wpEW+YQOsy9G0UmRNMM6SaHp/Sk8KKjp3UJ9no2aWvtXrxVAgHrRbKV
	mUdm/K/sn9Z02ColkeCnwXsWvjgqyvy1jwl02I74deojpeVXkmhqRHKi5vcCDM7V1
X-Gm-Gg: AYBFou3gT0Wx4ztM4oEKhc+KJUMEGQm3mqQXcreBtz2eHT+fXpziBw8v0/1kGwl648Z
	xF8rIdmF+PDIZAVWIMVdOfQEyqJDYZDpdhQYbuNTYdVgAwHIXFsOZiZvhJvfdOkezeYhruF/5ck
	5X3e6PrdiQyzEXbMSNQFL8568NhEIvtPV9FrAQetPOMFlzHyw+Z7QZEDm/kh7moYT/2JsHPbRyb
	NUN4mjhV9471/pje8kQ8XJ9/rQ4g6EZmhgwfCKt+FXG3aQ4+YYmhK/j7tCkDNiuiARFgmVIfOQ1
	jYyB8N75BG+FmGJdqANTQ0oswmF9ibDGJDUcgarb6FQG178hpnkD0IgJ7Vkw4K7a8zc1AOcfYlU
	Us4esKVVJkTHeXzzEkAYh4mHPsVCjigycVNKKaiIKDCRPzSEDAM8YZg==
X-Received: by 2002:a05:7300:cf90:b0:339:7b3b:236d with SMTP id 5a478bee46e88-34001f081bcmr3059393eec.15.1790288425266;
        Thu, 24 Sep 2026 15:20:25 -0700 (PDT)
X-Received: by 2002:a05:7300:cf90:b0:339:7b3b:236d with SMTP id 5a478bee46e88-34001f081bcmr3059364eec.15.1790288424751;
        Thu, 24 Sep 2026 15:20:24 -0700 (PDT)
Received: from localhost (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34145c166cfsm1343887eec.28.2026.09.24.15.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 15:20:24 -0700 (PDT)
Date: Thu, 24 Sep 2026 15:20:17 -0700
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
 <ritwick.sharma@arm.com>,
        Gavin Shan <gshan@redhat.com>, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 08/13] arm_mpam: propagate MSC access errors for
 interrupt control
Message-ID: <20260924152017.00004ec8@oss.qualcomm.com>
In-Reply-To: <20260924152739.2865510-9-andre.przywara@arm.com>
References: <20260924152739.2865510-1-andre.przywara@arm.com>
	<20260924152739.2865510-9-andre.przywara@arm.com>
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
X-Proofpoint-GUID: DQ3g72w065qMaVQusPxv9y1QNWRutqbY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA5MSBTYWx0ZWRfXyLLPwhjISkfG
 IcQyHDzYUlcMb7ANi78DDknVE3sj2JfOSDI9hmLXQugXTrHj/FWMDCrJaWX0qTCIUaISwocXUeo
 FNVtGRsM9xJHCA+9ehjGRskHP6hk32WqeJsPNDKq+lQs5s28I19C3AQbRHbDAwZ3eiJwgYMAq4a
 GN/bL91IaqTjkbodGTU9fWvknkys6iNqJaSF/9uDGyfbHqnm1Jqr63ERYQhApHdWjN/rKCkD5vM
 aafiR70g2rySlf4HPf5N8xugrRsEAbfg8oxdVoKcG2U7V2MFIdFQqIrj2bPBdw9oQ+jF3r0mjbM
 7+ZPorILBs736Nrose/GjH8wmi4HtzmFdZT6kqzIBAqVdw2TrpVH4KZ5KohuRaX4p/A5th4RZBr
 NHC18WTg2NLuZXBOLQ3FGIJBalperrHmInxm+4HcqAYEbKdjwRwrhHzNckdGdHkY9AiMiPrZB5K
 bDSkh9CUN2MJr1MotVw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA5MSBTYWx0ZWRfXwYTIyCsUfHUP
 Cz4AExijfhbrciJksfEjuC7xJYaisQNQpxb1vDlH3RKRs2azMxnj12SU4+QvDvGKCXQb6QlNp4g
 niyJEyKvWsfhX9+4NrM9NarIqT+5V+c=
X-Proofpoint-ORIG-GUID: DQ3g72w065qMaVQusPxv9y1QNWRutqbY
X-Authority-Analysis: v=2.4 cv=GI+dgeNK c=1 sm=1 tr=0 ts=6ab5a22a cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=7CQSdrXTAAAA:8 a=EUspDBNiAAAA:8 a=BicPeEsDMmYJQF04euIA:9 a=CjuIK1q_8ugA:10
 a=PxkB5W3o20Ba91AHUih5:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609240091

On Thu, 24 Sep 2026 17:27:34 +0200
Andre Przywara <andre.przywara@arm.com> wrote:

> Allow the functions dealing with interrupt registration and enablement
> to check for and return errors, and propagate MSC read and write errors
> from the lower level up.
> This does not cover the IRQ handler yet, as this needs some more
> attention.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Reviewed-by: Srivathsa L Rao <srivathsa.rao@oss.qualcomm.com>

A few trivial things below.  Anyhow, I don't really care about them so

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

> ---
>  drivers/resctrl/mpam_devices.c | 31 +++++++++++++++----------------
>  1 file changed, 15 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> index 558efab75f911..eb26c25b9f970 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c
> @@ -1105,7 +1105,9 @@ static int mpam_msc_hw_probe(struct mpam_msc *msc)
>  	}
>  
>  	/* Clear any stale errors */
> -	mpam_msc_clear_esr(msc);
> +	ret = mpam_msc_clear_esr(msc);
> +	if (ret)
> +		return ret;
>  
>  	spin_lock(&partid_max_lock);
>  	mpam_partid_max = min(mpam_partid_max, msc->partid_max);
> @@ -2668,9 +2670,7 @@ static int mpam_enable_msc_ecr(void *_msc)
>  {
>  	struct mpam_msc *msc = _msc;
>  
> -	__mpam_write_reg(msc, MPAMF_ECR, MPAMF_ECR_INTEN);
> -
> -	return 0;
> +	return __mpam_write_reg(msc, MPAMF_ECR, MPAMF_ECR_INTEN);
>  }
>  
>  /* This can run in mpam_disable(), and the interrupt handler on the same CPU */
> @@ -2678,9 +2678,7 @@ static int mpam_disable_msc_ecr(void *_msc)
>  {
>  	struct mpam_msc *msc = _msc;
>  
> -	__mpam_write_reg(msc, MPAMF_ECR, 0);
> -
> -	return 0;
> +	return __mpam_write_reg(msc, MPAMF_ECR, 0);
>  }
>  
>  static irqreturn_t __mpam_irq_handler(int irq, struct mpam_msc *msc)
> @@ -2777,11 +2775,13 @@ static int mpam_register_irqs(void)
>  				return err;
>  		}
>  
> -		mutex_lock(&msc->error_irq_lock);
> -		msc->error_irq_req = true;
> -		mpam_touch_msc(msc, mpam_enable_msc_ecr, msc);
> -		msc->error_irq_hw_enabled = true;
> -		mutex_unlock(&msc->error_irq_lock);
> +		scoped_guard(mutex, &msc->error_irq_lock) {
> +			msc->error_irq_req = true;
> +			err = mpam_touch_msc(msc, mpam_enable_msc_ecr, msc);
> +			if (err)
> +				return err;
> +			msc->error_irq_hw_enabled = true;
> +		}

Scope ends here so unless something else gets added in later patches, you
could just use a guard() and reduce the noise.

>  	}
>  
>  	return 0;
> @@ -2800,10 +2800,10 @@ static void mpam_unregister_irqs(void)
>  		if (irq <= 0)
>  			continue;
>  
> -		mutex_lock(&msc->error_irq_lock);

Given you don't return early as a result this is an unrelated change. I don't
really mind but in ideal world would be a separate patch.

> +		guard(mutex)(&msc->error_irq_lock);
>  		if (msc->error_irq_hw_enabled) {
> -			mpam_touch_msc(msc, mpam_disable_msc_ecr, msc);
> -			msc->error_irq_hw_enabled = false;
> +			if (!mpam_touch_msc(msc, mpam_disable_msc_ecr, msc))
> +				msc->error_irq_hw_enabled = false;
>  		}
>  
>  		if (msc->error_irq_req) {
> @@ -2815,7 +2815,6 @@ static void mpam_unregister_irqs(void)
>  			}
>  			msc->error_irq_req = false;
>  		}
> -		mutex_unlock(&msc->error_irq_lock);
>  	}
>  }
>  

