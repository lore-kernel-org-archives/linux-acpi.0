Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3EA33260F
	for <linux-acpi@vger.kernel.org>; Fri, 10 Jul 2026 19:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783710619; cv=none; b=SSsQPg2Mubi8Jhcu2V3o7+z10XRZASLo8A/N6Ot6AjQhQWl8ldmneLInYVJ7phbh7GoE+nNlFUCsl+Osm/xY2Nmau8C1TPjn6MVV3j+E2GOcTEW+hsJXs98ytDXvhx98ypexTdmNS+ZLUio2iSoA3X/CvkOyqVbc4VHTVJzNFKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783710619; c=relaxed/simple;
	bh=Ffbatdc5Fa59iuCARmPs2MW6Lua9xDQOzvqphL3H428=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=daWn1Hpe7WB+nVDV9IjnuMEGikGMdSFVqgbLth6TwBpuI/CHOkuapQvSeYXM5FnJduJo5KJvhZxM0h9K1aOEkxxjYjm2hR9PSW+Y3km0S6qX42AOd2AgxlVv5QqmSDgyZB8HBOidtcfPukGiYCOogaXMeQsnxLe0BnoDfm0PYM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TDCoOXLA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HcWvqi/h; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TDCoOXLA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HcWvqi/h"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66AH3iLK1361434
	for <linux-acpi@vger.kernel.org>; Fri, 10 Jul 2026 19:10:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+DHqMEOdVsuBepGS7JMZXAEJfhCwLxJixrbwAJYSTc0=; b=TDCoOXLA7YmhBjjM
	LYocPeisAfFi7KH40QdIBy0911Ah3S6Cwc18ZclmLnQOY8liL9xZbCn2MhCrL0T2
	G3Eoyv9vz58f7keRLDZY1BLDBaM0dqZIQWXK7LdlG2/KSif4drABUj026e2ORqhn
	hG0YG2pZXObSY0ppgrFRZ0+cmwwKhMeRssi7UHw9NsXUt2S5xRKhw4t6lyO1Mhcd
	+2USH5YD9BOYxG0DWOOt8FvVHHg7hbCfHsVRFTRiCNjDnpM8lvnBNgHLIw6xB9kC
	HXFmIdKkWChnGYOCwjKvzwLZNuzuFJFIGozPjvKSqi+n6vzynHzuYtP7yYGj0KFJ
	AGGsmw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb2pc9327-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Fri, 10 Jul 2026 19:10:16 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c892143db7fso1210830a12.1
        for <linux-acpi@vger.kernel.org>; Fri, 10 Jul 2026 12:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783710616; x=1784315416; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=+DHqMEOdVsuBepGS7JMZXAEJfhCwLxJixrbwAJYSTc0=;
        b=HcWvqi/hRIzLw+zcdrus8oKhJLE9hafwr4j+v5lV5pJY2oTu8eFbICqe/bGvt5/mPZ
         AZpv208v61de+Deo5dRXNe8PqmqbzQnhwVdhVbb6Tw2dnXDUXqZrBuDop1UA36kW68WC
         MYMXuezuwEcWPQpHfj9jMq3oFwpIW/jSZel5okH+wLDUCNQ0JdAaTkFrsM693UfqWdjO
         mPazt1ZmMz+KJijBJTsOoODKaYaahleGwSjvLufz5nEgNjrxmXD6pDNXUW/n8FrBPbNg
         HdgD/ZSWZLZTZC9dJ0MxjZc5Ai7gec+xJ5D8RUGfWx6knHzpNExm5lTr/YJxNUXu+9oQ
         k1iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783710616; x=1784315416;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+DHqMEOdVsuBepGS7JMZXAEJfhCwLxJixrbwAJYSTc0=;
        b=YLXkjPolFYdqEzDXRoPwpkECRNAa3Tbsj1fpMVvvLKELg4BdhEu8s0kEaiG9Dd6XUx
         PVgxOyi40dwakq9ju/kBc2OhNI7KX4HnJT1tJBK+xpTWyhZCVM5ApeX5vzpSCZK2n9Nq
         9KoHL+oBgwlSpl4xzLqSkZICcTJrHZNqo/qcXRcwrh9pe6jQOHwHfk8snPOJFrXMkZlY
         2B60Bs1MUItoI5th5AlT3T7eLUQ64Hz/5NVZ1IcDnda8YuzSSaWmAiehJ3mlzScJm5sy
         wAW4aXzRCFpEXMG9IkDXIk9WsSqfsNtT2JK7Zt4UJzdZtsLRZc6uWsyOSXvLOuCShEWp
         wjhA==
X-Forwarded-Encrypted: i=1; AHgh+Rrs0PFY56mG5+mU99jidE/PxBLTrXT/DVFzvkWaVGlAJJzASZ/6ZvJrbeYottjvAgPzhu3K0kB6UhDp@vger.kernel.org
X-Gm-Message-State: AOJu0YxGuuQVoMBHX46Nxkm/xXjyrNH+kWiO/v+lPqSF20PUkSFBnPMX
	JLcnaiaXRGEnHF4BHh8xdwyhDQFsH9yfop/goeTYPW9P7qem2tIrc0QUIonqFf1Y0G51ra3i1Ab
	4bRJz/oo/t3EMyTPlrX8M9zzD5H/zeL4KpeafnzB5h3g3eGDgCC6MReyJb3ZXsSW1
X-Gm-Gg: AfdE7ckQptR1fnDACSzZzgPPSb0HrlFa+aP28t8xTgTLpROZOltTTbtVDkyn++OsCBN
	M05CV932i6B5SIGjvnSLpiavwis769zT3c80CpenGIoYvEo7H+bOMHniphuZGKLJcnQ1Z7ATYca
	s1wX+ApzLaRatKiw3ADqN15jZg5Wh6QOPy4/t7i6fom9nE7rE63XTpy/j8cHpxyFhJjrjeySoyH
	NLMqYL0RjUKrpu8ZyqYebXPeCgBC5ts0Gam3noekjzCdk8/C73YRlg5n1EkcdXpSOJs1RITTInU
	kCBCoZGH9yMWeGg32GFDRaZXfgjs6wPGMaM/3qIU8i6R3nxtTXJT70gLMJpRx5MfsajV11cqk8o
	r7Bbdj9uXz9xtwQMPET1nPb1yj2NUlM6DHFHH
X-Received: by 2002:a17:90b:1a8e:b0:37f:ca19:36c6 with SMTP id 98e67ed59e1d1-38dc7847d0cmr241662a91.11.1783710615768;
        Fri, 10 Jul 2026 12:10:15 -0700 (PDT)
X-Received: by 2002:a17:90b:1a8e:b0:37f:ca19:36c6 with SMTP id 98e67ed59e1d1-38dc7847d0cmr241626a91.11.1783710615214;
        Fri, 10 Jul 2026 12:10:15 -0700 (PDT)
Received: from localhost ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311a6115e61sm22568961eec.22.2026.07.10.12.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 12:10:14 -0700 (PDT)
Date: Fri, 10 Jul 2026 12:10:10 -0700
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
Subject: Re: [PATCH v3 12/16] arm_mpam: propagate MSC write errors for
 remaining MSC write users
Message-ID: <20260710121010.00005a45@oss.qualcomm.com>
In-Reply-To: <20260710144520.917375-13-andre.przywara@arm.com>
References: <20260710144520.917375-1-andre.przywara@arm.com>
	<20260710144520.917375-13-andre.przywara@arm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDE5MiBTYWx0ZWRfX6q+I9elNuymK
 F6I83/vB4fYk4ULc1NweHXiLjM60NpQYS2HA4PeVMX+nUjZY9d6k+mnUiRxAmMJSAKxNkHHuTKB
 j4VrERJprqGudg4v3I0tqlXjSy9xkgpoPNtN/UiXID1txxEZsiblHjSvjrXOOwpD/VOROriA+Vn
 KIADTIMM5N/aRVvTT9gzZXwSm7QLwSurkrz3KPEEcVEWx21GUaEfMzFPQFEKukztQ2mrOVX0koz
 RYd4V7Q77EGe49rW5P8WljlOHdBEFZTylmrWnKn5+xO7NiE048AxFwYnSjcQMEol7t1mtgrS6Co
 QewOX7jfU+FhzyT3MojNWjCvIvbdjHUG23Mv8OfGj5UhllIdibf1TcLEWsgtd6PYTkENJHn0WSd
 iBr1+PnyEZY5ytLITmTx0qbHVNcJ1PJt1sO6NOLTpKLYu1eLWd4F8lbZ6Y2Q3+T+gM34eP9S4Aq
 bjc6GOWDi2ziD1UyzVA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDE5MiBTYWx0ZWRfX4jURQ1z9RjH9
 JU5DJfhUOWT52ZYghxR0ZXhhlCcg4laZxPAGWW/BZkHE95kys1m3fbDowiMHQVUB1iAuR4dsWFg
 eHobqeYnRf40Yv6WeHcLbDZJpXgZJYE=
X-Proofpoint-ORIG-GUID: V38N1LaJt4K-JChvk6gLnqBUxk-VcyX2
X-Authority-Analysis: v=2.4 cv=J9SaKgnS c=1 sm=1 tr=0 ts=6a514398 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=7CQSdrXTAAAA:8 a=QUh50r0uCS2WbTzk5IMA:9 a=CjuIK1q_8ugA:10
 a=x9snwWr2DeNwDh03kgHS:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: V38N1LaJt4K-JChvk6gLnqBUxk-VcyX2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100192

On Fri, 10 Jul 2026 16:45:16 +0200
Andre Przywara <andre.przywara@arm.com> wrote:

> Allow the remaining MSC device functions to return an error, and
> propagate write errors from the lower level up.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> 
> propagate write errors up for mpam_save_mbwu_state()
below the sign off?

> ---
>  drivers/resctrl/mpam_devices.c | 82 +++++++++++++++++++++++-----------
>  1 file changed, 56 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> index 222515a01b35..ca73029654b6 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c
> @@ -1162,15 +1162,20 @@ static int mpam_msc_read_mbwu_l(struct mpam_msc *msc, u64 *res)
>  	return ret;
>  }
>  
> -static void mpam_msc_zero_mbwu_l(struct mpam_msc *msc)
> +static int mpam_msc_zero_mbwu_l(struct mpam_msc *msc)
>  {
> +	int ret;
> +
>  	mpam_mon_sel_lock_held(msc);
>  
>  	WARN_ON_ONCE((MSMON_MBWU_L + sizeof(u64)) > msc->mapped_hwpage_sz);
>  	WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(), &msc->accessibility));
>  
> -	__mpam_write_reg(msc, MSMON_MBWU_L, 0);
> -	__mpam_write_reg(msc, MSMON_MBWU_L + 4, 0);
> +	ret = __mpam_write_reg(msc, MSMON_MBWU_L, 0);
> +	if (!ret)
> +		ret = __mpam_write_reg(msc, MSMON_MBWU_L + 4, 0);

Code lines are cheap.  Burn them for simple flow.

	ret = __mpam_write_reg(msc, MSMON_MBWU_L, 0);
	if (ret)
		return ret;

	return __mpam_write_reg(msc, MSMON_MBWU_L + 4, 0);


> +
> +	return ret;
>  }
>  
>  static void gen_msmon_ctl_flt_vals(struct mon_read *m, u32 *ctl_val,
> +static int write_msmon_ctl_flt_vals(struct mon_read *m, u32 ctl_val,
> +				    u32 flt_val)
>  {
>  	struct mpam_msc *msc = m->ris->vmsc->msc;
> +	int ret;
>  
>  	/*
>  	 * Write the ctl_val with the enable bit cleared, reset the counter,
> @@ -1260,26 +1266,37 @@ static void write_msmon_ctl_flt_vals(struct mon_read *m, u32 ctl_val,
>  	 */
>  	switch (m->type) {
>  	case mpam_feat_msmon_csu:
> -		mpam_write_monsel_reg(msc, CFG_CSU_FLT, flt_val);
> -		mpam_write_monsel_reg(msc, CFG_CSU_CTL, ctl_val);
> -		mpam_write_monsel_reg(msc, CSU, 0);
> -		mpam_write_monsel_reg(msc, CFG_CSU_CTL, ctl_val | MSMON_CFG_x_CTL_EN);
> +		ret = mpam_write_monsel_reg(msc, CFG_CSU_FLT, flt_val);
> +		if (!ret)
> +			ret = mpam_write_monsel_reg(msc, CFG_CSU_CTL, ctl_val);
> +		if (!ret)
> +			ret = mpam_write_monsel_reg(msc, CSU, 0);
> +		if (!ret)
> +			ret = mpam_write_monsel_reg(msc, CFG_CSU_CTL, ctl_val | MSMON_CFG_x_CTL_EN);

By now you can probably guess my comments on this.

If you ever find yourself with a case where you can't do guard/ acquire()/early returns
etc, use a helper function that can just return on each err.

It is more code, but I'd much rather see that on error we 'stop' and return
than try and follow the path to see if anything else happens.

		ret = a();
		if (ret)
			return ret;

		ret = b();
		if (ret)
			return ret;

etc.
