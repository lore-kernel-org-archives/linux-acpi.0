Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB4CCA4E
	for <linux-acpi@vger.kernel.org>; Fri, 17 Jul 2026 00:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784247139; cv=none; b=XHsWl/WTty8aa/4AFHWkjp9p5hNe1SCjP+gN/MFCLdX2qpLn04NGOZucu90cob/2NgtWIXuoKmvt62NltdWPFHB+DRDYIS75snVo5LIVup5oqB3eoC/g9B+Hde8dyFFARr2S8oSRQP6f9ZsVFVLfH/XlN5V1Ng7+FlwD0yw2d7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784247139; c=relaxed/simple;
	bh=/vgmyQkIOL2iV+iyAfRIfdtC4eSube7VTTsIgIQ7bB0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IGA9zpJLOrcMWhkuY0/27uD1IOLUYOiodfxJqEylA/YAoRaCHyypnOZ8UVO7I5FgGaBSfgLv5YtswLGypAzn4aPScn8J211jXnoAeJig9M93TfdqjXhjQkFPp6XUK3fEFw/UtN9K5bul3eANvWeLzB8tYEEnACm3HesYYmQs/Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=etx8nOte; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Y8f0JnVn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="etx8nOte";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Y8f0JnVn"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GNINRZ188784
	for <linux-acpi@vger.kernel.org>; Fri, 17 Jul 2026 00:12:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HAu6FAZrz/0nPKw/nvzZjGq46uTuC6g/2xv9LMCM1sI=; b=etx8nOtefC7yx9k/
	wcbgY5CWWROFa/aoyBhgrxlIeDoz2e4Dvp73L6PXFnzFXRe2NyxM1csusGqZB1Ib
	uQvBBdt/Jt9nRPPJ3O7owtuA/Z3OzUs2c2H8lXRMnhJscqHpX3jXKF7zl4/0thsB
	6ZlUwX43/3mx7vfSjMaXp9JIhrrVV7Ce6LvkSB9gQN6wOeNtGN9vjCiyx9Nlum2h
	xUzcuuZW6YkQWEN32DisDNRXm7Ei0AMwh2eURNyksFAerjCBcwUzgMeemkx+FZ8g
	EgUklHG9xptAn7JKDoE6kWzMd+BRGtY7lWrk+s+eukOYv2MJYinPZG162u5V0ZKo
	cYX/Jg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fetcf406r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Fri, 17 Jul 2026 00:12:17 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cec4226c70so96460155ad.1
        for <linux-acpi@vger.kernel.org>; Thu, 16 Jul 2026 17:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784247137; x=1784851937; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=HAu6FAZrz/0nPKw/nvzZjGq46uTuC6g/2xv9LMCM1sI=;
        b=Y8f0JnVn33nZPFneK98PSRYdMUGqsA+ocSj4XUW2afgNLBvlFAa6wQdghdly52NNgw
         msJbrIwasr2VJ88QMBe76k8MvKcy63RIAmK7KV7YKuyEBcxugEgC8q6pf/C7nMeCXshO
         XerDpcWQxl333z0eE0V2orRTvI23wHYvqBbKOjxz82AXKX9spU0F84sfs1BQTDZYxV3I
         jxGCIEBSalo8ktKrMtpmRg5FVYBkP3TdI2Agdjiz0+TlLB6bk2M/WyHGz1ei+T2tS6cy
         Ua6upbSWNnusxwvjs5siuzzPWed0fyfTD5pCuOjHysB5mzdzstZwBDwyMsnJWUUjQI1z
         qv7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784247137; x=1784851937;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HAu6FAZrz/0nPKw/nvzZjGq46uTuC6g/2xv9LMCM1sI=;
        b=QTxvWwDiLj3Bwv2dHRQePRE9hoJqp4PaL0wLIi1h3a/SiHS+QIaeVI6e7zRJ9l2jLw
         CPbUJY6psNrBjir7pYfSPAZhIvUX0miex1KBqQ9EriaenQH77XJV4qszgzx+YJu1SSqg
         RnJjd2JARMbq9KjflAn+EIVZKnBJyQMzBfK1HAD5XjiMQhJYWeIEfjk80slAQ3R353Ud
         w7U1ptllSMWxwXPv3WQmbr7ZVXeku4Srx2gJLzHG05I92UVmwyPx67O4BNT8VrVNUcIS
         TX/D+RhflL+JSumnFGv7aWgaN8KMfGCcuTW9wn3PZMbIk0Yhwq/g+AXZ3LsRx6n5VsvI
         CEsA==
X-Forwarded-Encrypted: i=1; AHgh+RpPSJep7jdSW6UH5mQVQ43Z7mlLhR3sXJXMXq77hGlu4imgPjJH8J/7BGys9AlTmNncCPddAWbeUrQM@vger.kernel.org
X-Gm-Message-State: AOJu0YwaptfNSypr9m8EwzI9Ev7r1VYdz+9ryCwEy8YATK8gOUqBGgDh
	qLMOkLpZkADLvVU2dnVG2T0b1pp6JtGCmMLKgZX1sq41wbG2mZx9bHBCdAafn3R4r+dYTgnXVUL
	H0v1YS0PqBnTLOU0dshN0u1sd7TVzgZuT+Y1ogksiiG+StLQe83aPg84tFyFaPdAA
X-Gm-Gg: AfdE7cm7BlFOlbVG8yzczjZtha1V6/fZkeQjuoiaKiLGAZNeeGEXO9z18bf20xom0PM
	8g4XdYdIm5qByVUDAAjdfS1Et1aDmsanctwUOU4rnHVG9nYaz2fdRw1v0Z5/3whn6TbY0TkfuHR
	/ccEgtjXxXxxd1X0SJyzF1eSD9haLstAU/+MHJdiov0iYrovz+j16i0QxaebT6GifolMWjcGunS
	FyV5wpoVp63bWCEzhPStuPluONEcel0eG02m6A0uFRBQ7MbBpcPTSe4afuwyAB4d8Tkxo5aahpI
	ONDYSp+sGp2cEWMFsXgrmorhScoF+r6IwZcEMDcnuZl0l0dJAPSt9t7dp6syXASlmOj9+NhWYvU
	uPLsybwp+olbciGAakAe1xajxDQ==
X-Received: by 2002:a05:6a20:430f:b0:3c0:9c18:d5a4 with SMTP id adf61e73a8af0-3c3ad997edbmr163334637.65.1784247136987;
        Thu, 16 Jul 2026 17:12:16 -0700 (PDT)
X-Received: by 2002:a05:6a20:430f:b0:3c0:9c18:d5a4 with SMTP id adf61e73a8af0-3c3ad997edbmr163313637.65.1784247136490;
        Thu, 16 Jul 2026 17:12:16 -0700 (PDT)
Received: from localhost ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13cd42a155bsm14958468c88.7.2026.07.16.17.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 17:12:16 -0700 (PDT)
Date: Thu, 16 Jul 2026 17:12:13 -0700
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: will@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com,
        ilkka@os.amperecomputing.com, bwicaksono@nvidia.com,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 3/4] perf/arm_cspmu: Improve sub-module error
 reporting
Message-ID: <20260716171213.000026c7@oss.qualcomm.com>
In-Reply-To: <256bcb4c8c98dc95bfdf295adb66b917545c919b.1784213435.git.robin.murphy@arm.com>
References: <cover.1784213435.git.robin.murphy@arm.com>
	<256bcb4c8c98dc95bfdf295adb66b917545c919b.1784213435.git.robin.murphy@arm.com>
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
X-Proofpoint-ORIG-GUID: WuNylZGhcl_XsYE_fZiqnTsxkXq_HelK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDI0MyBTYWx0ZWRfX2LRyoPwtT0kY
 bhZezmJxT9Wr4gc3yeg8/LSI67n+OTRUiMOfcI62LwIPSHZEu7+AZQXQi6w6nz4+pZpOno/eckt
 tBYndst56GRegjZfciPPwSVjG7ZodxJUUnTXHXM6G68+Gy8OA3JB3mRH2iiOJjmgteFkOJocMWp
 PO+PWkgJB64MpHm447asAgMWO+/eUQIz/nGs6lSkfjhgiAhRkfn/LvKQQ97z2BRPkzAIOPgqMe9
 +sFgA9RbTRLlthvsS4pHxqIWmsGB0prF9fWmAoFsqPSIrIJgt0ANW3wQOI2X5Z/xSNTBzRPk7/N
 eWnJU/L4b1YOP69dpatFVRZn5kw2l4zsdC96Dk5Mj26+T0aEKY/JfNTa5sa+F3i8X+If6rt4enC
 3+SbCCiZ0UJD6ASCAoNq6VkqhevDrTLYrIeglSki9MZNVHiUqVw2csv6EeaDxC4TI/lS+BM1OLM
 IEhznRpN8imFN15vTyw==
X-Authority-Analysis: v=2.4 cv=f8R4wuyM c=1 sm=1 tr=0 ts=6a597361 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=7CQSdrXTAAAA:8 a=vzhER2c_AAAA:8 a=orpSRISjaG3fHkWwNWwA:9 a=CjuIK1q_8ugA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=0YTRHmU2iG2pZC6F1fw2:22
X-Proofpoint-GUID: WuNylZGhcl_XsYE_fZiqnTsxkXq_HelK
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDI0MyBTYWx0ZWRfX2LnFogLwGgK7
 fJQ6ycnA3VRNaMZJ2I2e1xqrxn/YEpiOdcQxRCusa15tAtZBJl50ksjIXzjUW3bH0TpqhsBvy3n
 cNR4kob/NnOoTRdbY+JpErZu1MEa9S4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_08,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160243

On Thu, 16 Jul 2026 15:56:36 +0100
Robin Murphy <robin.murphy@arm.com> wrote:

> When waiting for a sub-module to register, we return a bare
> -EPROBE_DEFER that ends up showing the end user:
> 
>   platform arm-cs-arch-pmu.1: deferred probe pending (no reason)
> 
> wherein it's not necessarily clear that they might need to take some
> action to ensure the appropriate module is available to load. Let's use
> dev_err_probe() here so we can show exactly what we're waiting for.
> 
> Similarly, in the case where something's gone horribly wrong with an
> already-registered module, we can use dev_WARN() to standardise the
> device/driver attribution rather than just open-coding "arm_cspmu".
> 
> Reviewed-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Hi Robin,

Maybe sprinkle some cleanup.h magic and use a guard(mutex)() and direct
returns.  Simplifies this function that you are touching anyway.

Looking more broadly it'd either take a scoped_guard() or some refactoring
if you want to go that way cross the file.

Jonathan

> 
> ---
> v2: No change
> ---
>  drivers/perf/arm_cspmu/arm_cspmu.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
> index 8c2dda17d73e..caad9a36651d 100644
> --- a/drivers/perf/arm_cspmu/arm_cspmu.c
> +++ b/drivers/perf/arm_cspmu/arm_cspmu.c
> @@ -437,13 +437,15 @@ static int arm_cspmu_init_impl_ops(struct arm_cspmu *cspmu)
>  				if (ret)
>  					module_put(match->module);
>  			} else {
> -				WARN(1, "arm_cspmu failed to get module: %s\n",
> +				dev_WARN(cspmu->dev, "Failed to get module: %s\n",
>  					match->module_name);
>  				ret = -EINVAL;
>  			}
>  		} else {
>  			request_module_nowait(match->module_name);
> -			ret = -EPROBE_DEFER;
> +			ret = dev_err_probe(cspmu->dev, -EPROBE_DEFER,
> +					    "Waiting for module %s to load\n",
> +					    match->module_name);
>  		}
>  
>  		mutex_unlock(&arm_cspmu_lock);

