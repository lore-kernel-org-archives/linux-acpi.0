Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4498A3815F0
	for <linux-acpi@vger.kernel.org>; Fri, 10 Jul 2026 19:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783710881; cv=none; b=nurteZ/Iov1aNWY2flUd0yEz5RsKFJwVWciHsCVtJ5fTuZCkfxizB6X7fK9eIK63sa1EQH/JKb4Qs4F+9B9BFeVHlENODJyEJg0PJLUqq0IgDYKKgPRknphUz59HAthmE8xeaZvGwN8wZK2yxSagmoAMmCsd5WsCUkrmZ5hXWAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783710881; c=relaxed/simple;
	bh=TwJAPRC9IaDTEZIqHz1dSUvgEo9uURfjDLUssY/OXv4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fpbXHzlur2wSxvXVzdbtu1lBjjWxO0Zca1Tx5vqepPJdHYVKFd0p/V2ujUhfBG10bnx1dQ5K+QvTv9E2sf0LH0Xhhj8CJzh79e4Q4FlDA2igqtzLXCjRBUkgHQ75hBmqgpUtdJnGo673q+/QP4H5V9MbRhWuKYdPOPijT/nWwfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hPjRmohk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Unl3UaTb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hPjRmohk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Unl3UaTb"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66AH3g9k1307185
	for <linux-acpi@vger.kernel.org>; Fri, 10 Jul 2026 19:14:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oq8eejymhlI51ANjiVtGV60zs9lXc6+8/KrX0uDkPTA=; b=hPjRmohk/vrlMeM8
	+8/iXn3HzLYLkqDaQvit5Lc1xJV/MylWBBlxy+GKG9uV9T+/llYgAgIH4zcUdJ6b
	bjwLJC4cd0KkqX78iKy1sBFzOORhHUAEGKRwVzVCYzINXeOK7niFORe2FhUJVn8R
	GkWEQiUdT1K0GOd1RPw/7Mz1lzJ82t3tRN3ydnJWnUr5RUW793KiXX0/++DKCTn9
	TypQ4RFhQSh7XJMT41Md30QqaM2uY6m6J+N90CxK1Byx7pNj71qoBfE40sy3XT8B
	+U3+OwpoLrojvnDuWtIhCJyAPGiKku7vV3hHG36mwdPlvekRDdAxn9ZdAFr54aW9
	ll/yJw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fax5dj45s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Fri, 10 Jul 2026 19:14:39 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8485b7e18b4so2270542b3a.1
        for <linux-acpi@vger.kernel.org>; Fri, 10 Jul 2026 12:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783710879; x=1784315679; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=oq8eejymhlI51ANjiVtGV60zs9lXc6+8/KrX0uDkPTA=;
        b=Unl3UaTb5jBxyuXmdlT5igpFcem0iEjTRxRcS7H5wLESoo6Sz2K/RSo+RyAcNAGeVA
         vjd/mXHacoDTOzyx7WBsateZTOYZh4pSpehysehSLCJAe5hz5seF8y7s98+R+9AM04/N
         vhiWk6+8fKiIIfP/JzQoQIR1zRzIXRFHRA624280G/P6BMdbrYztmy35ABQClEq+Z+8l
         5YUAktMpMKM2wmvmfHtFtob0SVjHF2Bk9Vk4GR4JqD2qPDPrDx/3cWEDnVU6Ad/c2NzB
         +q+iI4kgeyY4kxWAh/MDU+PduEGjjuZ3NdsXLxZKI5iWAgpRGP5ja9ycy+/0XSqYNGWh
         jsqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783710879; x=1784315679;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oq8eejymhlI51ANjiVtGV60zs9lXc6+8/KrX0uDkPTA=;
        b=sfUtaE6HflP7DnNjZRg92pmPflFGOCSNoI3tGDZ3eUl2dQg+Yr6jx5uMP5dsVe0A41
         dI5r2ad/171HrUoJrKoTYWHuRvu1Rpu/480UTFVzKDj3ebt5atKNNEMgxmYRA3KVYFAU
         tcdoBQwBz0BXPPf663dETNWZ5aWKjE8HncJzuJMZmesFo1u+YzW9qmdWkDiDLw95b+Ns
         X0AI4w/8Ws6UmAdDcsDN0DmSh628bYKKFevybj86w0xhnghM0DcOVwfFlTwS7V5BQjUl
         9BVwVAwOzJauOKWi3t3c+xSeq7HIxLHWGEPxUAkk4qieBc3LaxlVLyHzWCpjfj0eaOpJ
         llHg==
X-Forwarded-Encrypted: i=1; AHgh+RqlBruCWcI650EQGlhgOFx1RRVvqnH/AV1d9Hm2dwyS8O8Zd/4VtfOvt25D2DHSk4LRA/c4O56GBcZD@vger.kernel.org
X-Gm-Message-State: AOJu0YwzQf3IOZOA/ltl3M5F3XciFicEHhIq/GuuAEmiUoH5a4WgsV7u
	t1Z9TrVj+hz5tNFAfOTKfPbLGY5Xl8pETRtNRX4KXq0Mammf5HRTrgSyzZ/mulrPJA1nrA49/NT
	DrYkmG19CbVrw6rIih5hYHy9whP/Gw06iAVktIlsI/1VOJ9dELloVy4e//k/G/OcT
X-Gm-Gg: AfdE7clbedomsgyq1n5jMMs2Id8KhGG9mvXuiU1yt0jgHdDK3FsTLOLXavlCrtiSnrP
	YkONnDtKDS0pMEe56Y8kENUndUrFqDXlD/16UEyBESRasipJhMDVbuceLXsoomgb57vfjpmhIId
	fF62V9RjgJCNViPOjLmSlTN8iGtJMjQWVDrMlbxkI+2qS9OmjM7/e5xmWnpC7DtmZW2ED0pIrjC
	TahBcVLLHI5/snDJbeDN4HvJNSasON9O0uVCL6k4Ea3/m1cYbfTl+Bl2XscqW7F/Csl9EfUMIgv
	bHqE0ZJazFKk32RYrCimTuuzy+JViRArGKQN59t/EGoJ50G+jWAP0XOvBHHH4IsAg8F378MwuqM
	MldbPPRYeiiD3bvwOCEDs97r/pKhlNAX/2wLg
X-Received: by 2002:a05:6a21:6e96:b0:3bf:b523:2aed with SMTP id adf61e73a8af0-3c1100383fcmr321998637.8.1783710878672;
        Fri, 10 Jul 2026 12:14:38 -0700 (PDT)
X-Received: by 2002:a05:6a21:6e96:b0:3bf:b523:2aed with SMTP id adf61e73a8af0-3c1100383fcmr321970637.8.1783710878257;
        Fri, 10 Jul 2026 12:14:38 -0700 (PDT)
Received: from localhost ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311747f5975sm40574288eec.4.2026.07.10.12.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 12:14:37 -0700 (PDT)
Date: Fri, 10 Jul 2026 12:14:33 -0700
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
Subject: Re: [PATCH v3 13/16] arm_mpam: prepare mon_sel locking for MPAM-Fb
Message-ID: <20260710121433.00001ad6@oss.qualcomm.com>
In-Reply-To: <20260710144520.917375-14-andre.przywara@arm.com>
References: <20260710144520.917375-1-andre.przywara@arm.com>
	<20260710144520.917375-14-andre.przywara@arm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDE5MyBTYWx0ZWRfX1coU4lqMM1on
 YhbpNSGS/pNB8CC6QV/uYGthJobyXPS1khoBug4OklB7VfZ8xlyv6zOeOL4LohfmlauZwfs4vlH
 UNnWz+F/RRTUx+OYote9ROPCH5vVX30=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDE5MyBTYWx0ZWRfXwV70g9BNIpa8
 SfDcmUjIoSc7ffAej4RPhYkG/vbTkULh3vBYubQ7KnKoufdDn4dvBLH4hxEwocTqKM4y+gFE3mm
 nghfhmEnjyNy3RKDuhJldhlBl2AsTkbdJtGdCfmeVN2ylN5LjbYoECtYr5DHp4bEoWYaX7pyWUs
 PV5Ui6bvhNuPXRA74CAoneFeSRZIQRar82nxGQJwM9FYDcy7owdCVkbnErKP5eVjJouY75Xl4aj
 zLYuk6qzP8LNQdgZMFgFb3v8FK9+kUZhsOFOoFimTiNh9bzxx2VNuLdY6E1p/wuVjooOIotRXi5
 1Pv/BQGGwPhDqcRfG2cC253aHF2A1Ff5cROuCu9F73v1U2ZIiI/Tpu+Xrlp66gvtedRCNkjH+qj
 yFq5jMHH5Lza1KL3SDMKiUeov+q2yMUKjyi2vJuPCf158qZssOnoRkVUZJNyb0++hQ/lVxBGl0a
 QmQ8IV6NNJMUmlmnPDg==
X-Proofpoint-GUID: 2dnkJKkrJd7QeVQ7v57Z4x6rlo74AAxl
X-Proofpoint-ORIG-GUID: 2dnkJKkrJd7QeVQ7v57Z4x6rlo74AAxl
X-Authority-Analysis: v=2.4 cv=M/x97Sws c=1 sm=1 tr=0 ts=6a51449f cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=7CQSdrXTAAAA:8 a=TWr3UOjz1xACnXJDHjEA:9 a=CjuIK1q_8ugA:10
 a=OpyuDcXvxspvyRM73sMx:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100193

On Fri, 10 Jul 2026 16:45:17 +0200
Andre Przywara <andre.przywara@arm.com> wrote:

> The MSC MON_SEL register needs to be accessed from hardirq for the overflow
> interrupt, and when taking an IPI to access these registers on platforms
> where MSC are not accesible from every CPU. This makes an irqsave
> spinlock the obvious lock to protect these registers. On systems with SCMI
> mailboxes it must be able to sleep, meaning a mutex must be used. The
> SCMI platforms can't support an overflow interrupt.
> Clearly these two can't exist for one MSC at the same time.
> 
> Change the mon_sel locking wrapper function to only use a spinlock when
> the MSC is accessed directly via MMIO. In case of MPAM-Fb, we use a
> mutex, but only if we are in a sleepable context. If that's not the
> case, we return an error. This should not happen, as MPAM-Fb by design
> does not require an MSC access to happen from a specific CPU, so there
> is no need for any IPIs or preemption disabling to satisfy CPU
> constraints. And since overflow interrupts are not supported at the moment
> anyway, we also wouldn't meet the other case.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

I've not been paying attention to this topic, so I might come back
with some more feedback after I've had time to think about it a bit!
So trivial stuff only for now.

>  
>  static inline void mpam_mon_sel_lock_init(struct mpam_msc *msc)
>  {
>  	raw_spin_lock_init(&msc->_mon_sel_lock);
> +	mutex_init(&msc->mon_sel_mutex);

I'm not that fussed, but maybe add a call to mutex_destroy().
Most likely it'll never help catch anything in this code though..

>  }
>  
>  /* Bits for mpam features bitmaps */

