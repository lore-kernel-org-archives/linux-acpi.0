Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8605436C580
	for <linux-acpi@vger.kernel.org>; Fri, 10 Jul 2026 19:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783710167; cv=none; b=Ttqq7os/qsKQODoV5Qkmf6lPDvUb8QBYD10hmysycqZCOidh0OEdCNThKqigWbNypOMfGETpnzzyTHVF12mmi8w5LXQnUJIxitNKXYcCvAvifnhYBbPSqECAP32He9YPFATxz7jCYavjr6P9sSW73lVVzjFV3rRF9kSNxIOhbhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783710167; c=relaxed/simple;
	bh=1T9gokRYZBM92qfmp7viGGj5kqC68GaJKggSj3xg8dk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HH1mvZekj3Fp9XTghsSwiR5I4gOMyJHnphJt4Yhc2kkPx6l6l+iDghFX/kDa3KRbG+KKz4dQlVxVjxDgm7RxGzrzseXw9LIjY7x+HKU5YlBSJVF2Xh8qHcBOn48r/bjTJTca7UYJAiM4ZXV41aEQ7wH+F/EwPFwdIt045QbZFxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q8n8HNXA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=F8fhhfSL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q8n8HNXA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="F8fhhfSL"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66AH3s0l1400425
	for <linux-acpi@vger.kernel.org>; Fri, 10 Jul 2026 19:02:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HbI/3Z6Uv0qa6+qosAFvTVjIg/YJF+zx3k1VAkMd4hg=; b=Q8n8HNXAtl5a0NYs
	2v4L3coJYaWCmb3rNaffYnsPrg8b5U6HwUG5pUPuGcB1SSNPhjXCJWCa+R4/tFCO
	MTsAX2/z5YD4rp9dy83CApG+ynJsS+i/g6h73mSeJqnt0u3CLq5TESPQ0BxLcCt+
	QtKdnKuUZ7DieQORjRT7B2v1b/eH3RlgClJQD4kDLY7PcMnT+aZFtY+vA0aSLxVL
	BIQ6nlWCSTdWKn1/9x2tvttdvlVhvZUiqNDLXJhKAkXboNN8u5FeSM/K+Vs9n2xd
	+SrzadYrMMJroREaEELQsse17gT27CtHmbak6hSMuq2GApcwflptMPdy/5wldEY+
	/PCXLw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faxyg9vwu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Fri, 10 Jul 2026 19:02:45 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8482b95574dso1328413b3a.1
        for <linux-acpi@vger.kernel.org>; Fri, 10 Jul 2026 12:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783710164; x=1784314964; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=HbI/3Z6Uv0qa6+qosAFvTVjIg/YJF+zx3k1VAkMd4hg=;
        b=F8fhhfSLi3Bgohjr+uenqjjlaJRc3udsmvmr/U+uH+/3x6tH650SGTFaf3JB49Jz1X
         TNnBbitFooJyskE5ID0n86Iria2hGQ8q3bwkdPzjqjGW3h7mlv5pU1YB44c6ffnTIDW6
         KPY9D9CzKq9YoY/SAttXowlPB5xMs+Lx2P+K0NtBenKER3RFO9CpFovdK0bIOQCYtseq
         JYNeqMXGmEekHGa2PXadIojM3MOx4M3Js26xK29W17t9s4P59jDU91l6WqMwijueN9Bd
         /zIZJNUMc9XyJkSwHvvTackgvOuS1WIb/ZNu9DLnbe8eIc0ZZG4oRitlPoKCBhaegGuo
         WlpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783710164; x=1784314964;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HbI/3Z6Uv0qa6+qosAFvTVjIg/YJF+zx3k1VAkMd4hg=;
        b=Ew2W4g/oaYB3JDUgBZ40xzrgcaCCXNkSz0Wn610WlD5BAZf1DLE4TvsqSqGcS6+VqF
         +DwR44BQx2T4qSxsXRvPC1mKsN1IATPupjXMxcJhSz1EXHXTQENxDEbQcyKXtv4e5WgE
         OOYOkeqz699TvN/Z489C1SMvAcZZbklE/n/3ROIgfN70yUnWkUiy9chcddwlneSs7EDU
         eZpAq+27euMR47bArT1eLKNZx6HlVjpZQF4JZHvHHr8EuWDeW2mlCL7GOvov+n7AkUiW
         Q0cAtjFigad6BLEiJfwLAzXFcdS2vBH03MZRCGfFMmxnldRni7IJ0dVrNKgxsHRVX9Gk
         DGMQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp/9tH4s5s03r1Av1smprRHPKjLs5k1fJEokzAhripVVRzQgFv+7V3wRpdeZuL01oBMbOxkfKGyrXAp@vger.kernel.org
X-Gm-Message-State: AOJu0YykhViKbQdjw8jK2PaA0dEmguwVrzcAMLg7sqjsOUt2ttpQ7RWI
	/Ek8LxxQGxX80t4csySTnfh5tlpnAqrug4/5bjRPT4GsScZNAOm3L9myQWZhYbe+FuexTkILWv1
	DsCMdz9yp/6ECF724vT7p/LoX6tN82pBeEVAF9uajDBjunyAo9po6abner6VjaJWj
X-Gm-Gg: AfdE7cnxPhcT73lvWkMibQ6xcoG3aCIyjl+vWMgzdNG2qV8gC03JatFdfp+LjunpBK3
	TijjKh3ipD90jpclJyxRbBUMBatB29+t157hdecdLnVfir9Pq/jz0IC2MTysSpMcflnZdVSD0vO
	GYrLDVjEEfT8fO4BGSp4KmxnCqL8CRAcSNemEVmJ4KgBvhGIw9XYz4a4exBDfhoz060tIkeqNT8
	lmeAvvWddznKGrxzdaKZV+/vyWcX06SUVsNhTCcPzFik5E/xaW+gGgrb3B6Ivafx45UW5on5/Oh
	rFMaccc6U2hCUl5Q1RUk6TonlFbndML55HRFKK7uPC5GMvs2gHO7d3dZ4lK7U+vlnmVLz13oTh+
	S116AZbr71y5AbHEucJyHa/Qr3zzbNPDZOGVm
X-Received: by 2002:a05:6a20:9f8c:b0:3c0:9c19:659c with SMTP id adf61e73a8af0-3c110b7ba39mr273338637.68.1783710164233;
        Fri, 10 Jul 2026 12:02:44 -0700 (PDT)
X-Received: by 2002:a05:6a20:9f8c:b0:3c0:9c19:659c with SMTP id adf61e73a8af0-3c110b7ba39mr273287637.68.1783710163656;
        Fri, 10 Jul 2026 12:02:43 -0700 (PDT)
Received: from localhost ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659d8da9sm78063641c88.14.2026.07.10.12.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 12:02:43 -0700 (PDT)
Date: Fri, 10 Jul 2026 12:02:39 -0700
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
Subject: Re: [PATCH v3 09/16] arm_mpam: let low level MSC write accessors
 return an error
Message-ID: <20260710120239.00002f99@oss.qualcomm.com>
In-Reply-To: <20260710144520.917375-10-andre.przywara@arm.com>
References: <20260710144520.917375-1-andre.przywara@arm.com>
	<20260710144520.917375-10-andre.przywara@arm.com>
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
X-Proofpoint-ORIG-GUID: Q6L3A0mlX1WuJulqm-t6JLl9aGcMJud4
X-Authority-Analysis: v=2.4 cv=PLg/P/qC c=1 sm=1 tr=0 ts=6a5141d5 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=7CQSdrXTAAAA:8 a=LvQbmhgH5lkxUdBqBIQA:9 a=CjuIK1q_8ugA:10
 a=zc0IvFSfCIW2DFIPzwfm:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDE5MCBTYWx0ZWRfX02mClrRGeE6p
 2xoqj7BPN1w3IFFTXDgwu/F7hIvpKrQ2AjTtF4WWEnfcv8Oe63thAM9kyLHmI43+h9yaeJxdTCA
 PBMKgvUzGMOS9KvNIyVlpbnqpayikvY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDE5MCBTYWx0ZWRfX5p7KPrM9yhTn
 l8yyUN8dvACf5h4mREL1bZcdepJqh+BGT4fQZZthVAxOStnqyuY1hRpzcx4T95844xlOCpwUPCS
 kueEv3dDSjErLjkxPgPLIAnavYeNNToOleArxjDUra+Yjk3CLndjb0DpIM4pelUUKaAgxK6pIhi
 GLRfxuSQekDpX5oRvIA9eZF+B0wO9WDA2OrKMfsmUDyM5BmB76pN2GNJVqOD8jcCoU5Ev6103Lg
 T6/7fcZzfqVwSre86XaNT0PWwUlXkQd+QIEAXiIUcYozsP42SFPXvqd8kZ2Eqhr45x16CtMfuG6
 n+6q5BeFb522fQlHGVimvXUluJ8putxsJxfRasOxkdEXBS4jWThat7lYF3kuld00aB5Nfbl1gGn
 NV+IdUd1CVEDNowmwDrgm2NGI7tHnaF9tInsQOz/C5kWAynof3SN86WY/7eiLRCEXopZDw6mB8E
 HhB+drB/iGvN3ipatww==
X-Proofpoint-GUID: Q6L3A0mlX1WuJulqm-t6JLl9aGcMJud4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 malwarescore=0 adultscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100190

On Fri, 10 Jul 2026 16:45:13 +0200
Andre Przywara <andre.przywara@arm.com> wrote:

> The upcoming MPAM-Fb support does not use MMIO primitives to access an
> MSC, but employs a shared-memory/doorbell based firmware protocol.
> Its complexity means that is must be able to handle errors, whereas we
> always assume an MSC access succeeds today.
> 
> Change the __mpam_write_reg() low level accessor function to return an
> error code. At the moment this is always 0, but this will change with
> alternative MSC access methods.
> 
> Also change some low level wrappers to propagate the error.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
I mentioned earlier that to me a split of read vs write into different
series of patches is making things more complex than they might be.
They are same 'sort' of change so I'd do them together.

Then a reviewer can quickly see if all new sources of error are
covered.

Thanks (and sorry I didn't look at v2!)

Jonathan

> ---
>  drivers/resctrl/mpam_devices.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> index b2ecaba29fcc..f1e40ce24f5a 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c
> @@ -195,18 +195,20 @@ static inline int _mpam_read_partsel_reg(struct mpam_msc *msc, u16 reg,
>  
>  #define mpam_read_partsel_reg(msc, reg, res) _mpam_read_partsel_reg(msc, MPAMF_##reg, res)
>  
> -static void __mpam_write_reg(struct mpam_msc *msc, u16 reg, u32 val)
> +static int __mpam_write_reg(struct mpam_msc *msc, u16 reg, u32 val)
>  {
>  	WARN_ON_ONCE(reg + sizeof(u32) > msc->mapped_hwpage_sz);
>  	WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(), &msc->accessibility));
>  
>  	writel_relaxed(val, msc->mapped_hwpage + reg);
> +
> +	return 0;
>  }
>  
> -static inline void _mpam_write_partsel_reg(struct mpam_msc *msc, u16 reg, u32 val)
> +static inline int _mpam_write_partsel_reg(struct mpam_msc *msc, u16 reg, u32 val)
>  {
>  	lockdep_assert_held_once(&msc->part_sel_lock);
> -	__mpam_write_reg(msc, reg, val);
> +	return __mpam_write_reg(msc, reg, val);
>  }
>  
>  #define mpam_write_partsel_reg(msc, reg, val)  _mpam_write_partsel_reg(msc, MPAMCFG_##reg, val)
> @@ -220,10 +222,10 @@ static inline int _mpam_read_monsel_reg(struct mpam_msc *msc, u16 reg,
>  
>  #define mpam_read_monsel_reg(msc, reg, res) _mpam_read_monsel_reg(msc, MSMON_##reg, res)
>  
> -static inline void _mpam_write_monsel_reg(struct mpam_msc *msc, u16 reg, u32 val)
> +static inline int _mpam_write_monsel_reg(struct mpam_msc *msc, u16 reg, u32 val)
>  {
>  	mpam_mon_sel_lock_held(msc);
> -	__mpam_write_reg(msc, reg, val);
> +	return __mpam_write_reg(msc, reg, val);
>  }
>  
>  #define mpam_write_monsel_reg(msc, reg, val)   _mpam_write_monsel_reg(msc, MSMON_##reg, val)

