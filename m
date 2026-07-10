Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4263537DE
	for <linux-acpi@vger.kernel.org>; Fri, 10 Jul 2026 18:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783708294; cv=none; b=UZV4dMPzpeipYGG0dpUEewutdK+I/NOu51vfpG3Xq1OrhrqYPVxUlWCMijmVZjyUEHICHxy0NEtIz7DxDm7JMPKul2gxCDlKnnSC4dCMMhOS2mmg+c3gYf/aoFo90o4nYMm/S26Hz4dV1mqUnW+6bfNRrQYzLjF70fz51srkSZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783708294; c=relaxed/simple;
	bh=fN4asx3uvotIsmPgpFyUVzMB/u1bFWe+wqxkFvCH47s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KMSC+Mh9YwMVnt88FKw1+2nMj3OfBB/Wo8dTlfRXR/nZdSVxwwbCLTDFNTOBkGyv6wljvh28+2047+DKhJszehhmElez94tqZ2ksY5+cV8C+AmIcLKWmtI9mqAK6D8+bo4JHrv4pcURLNaqPJYcDYrGoHW9umS+8A3KGOSvKjFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HqqklVdD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jt3A6lY8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HqqklVdD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jt3A6lY8"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66AH3c4N1453059
	for <linux-acpi@vger.kernel.org>; Fri, 10 Jul 2026 18:31:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wghtXrmA4tuz0gT7trc8nR/4s0EnIKsAEKP7KeyovOI=; b=HqqklVdD+5EcfmZD
	2b5Ipg0WJdkrZejWB+KijN8C1tb1DdbsoeFLxEUajqWw0yX8zryzGHUqXuHsL9Yf
	J7KmO1EfCNCFOwCeSB0NKDEGFBNRBl4p/n6KWQqTZj7zyjeUGwrUTOw953WmfrMc
	C8DPnTvjWJ9RHzX9sHdd9+7NritgVVnls6/EctOIFEV3fwWSrcskllX+obV8UvE5
	pTiWTSukYzem/mFz6uRSVfNiC65deXWzdzOo7ffsSZKdCuGRmgDir+GU1cpCHr5d
	YkpfByxd6uPQT81vJcvqSV4QMEp+PoYYZ7qSmokfPMQJjyDs2kBdBUjLvw7iD3wH
	gVsbKg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb3xn0h2n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Fri, 10 Jul 2026 18:31:32 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c88ab059052so1201451a12.1
        for <linux-acpi@vger.kernel.org>; Fri, 10 Jul 2026 11:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783708292; x=1784313092; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=wghtXrmA4tuz0gT7trc8nR/4s0EnIKsAEKP7KeyovOI=;
        b=jt3A6lY81wIhWCyb+Y0fAla2mGxWYnYkCgxUMFOZFkq0xV3l7fRghln6T770ak3qUO
         FVrQtg0oI5OYmFMt7IcOhPFi6IFIZhpOwuyXb3eMumjF+NWJU/CEzesArKOtTw6krmHi
         QJ4RSEnkHffy1nxK0RRpDVNbqZXB3OhBBHzK9ARu4AFWlnYOD+3JT9mOEa4fpYnitGum
         /FXilO6LeuktbPO1sUxZzPuMhJRZcwo7rtTxMEU842GxmGlqy7Ll7kGFcmNEa7btzmo7
         2LUoEa9kEMO4ovxqq4ohZtVYmtItTmiQgBbdydo2hsMnkPvOtJ1P+x0APm0DJa1XQagY
         Je2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783708292; x=1784313092;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wghtXrmA4tuz0gT7trc8nR/4s0EnIKsAEKP7KeyovOI=;
        b=lP4peANGZzzAt9EA3kg0f0h5zieZzTEMC8v8PdNib7vwWd4gvNUaeyU8Qw9Vg8xcFH
         pJ5TWqFe+7QRSmyrkGxMepfvh28wDxIxq7CNbpow+94erlYC1AvUlSxWre1ntfbkKQKp
         DHId68NylASFtPM3oRivlD1YBHMcJHaGZY+z5Cj6//XyYOEv18aKHegmBYc52XRkiRTj
         +sLYUqU91RMkIVSrR5JUK1f21WP6jFp02de3zTneReP+HquoaL5G8jsJ1ORrW3aOtHwc
         7zlORfdC3QQD6Zh0ylPZYDnpC58mNN+1ULWKuJkW5T8XeWbHFsyRlx742tcblyc1Kgfl
         ub5g==
X-Forwarded-Encrypted: i=1; AHgh+Rqer4u5jGTQlvlU57zegp7U6M7Ikyz7pK+BsQ1CJ6/z3b2hLh64IcXZnBGTctW4OHtbVH03iX/srZEH@vger.kernel.org
X-Gm-Message-State: AOJu0YyIyAj5EHKB98Ig/dAJFLsPS+0brRGqr67pgYGDosJ/NsWVDgIb
	P6yRvuvY261ycXZVOtGZmRoHkpqUCeo6dH1ge0k999R1Owbl5ig/8d0pWIFlbQpRyeau/angAhi
	uZlGe9IuWlpL8BFMbfPQ7rL+i7iI+qcz36nW9RlhfBGrG+CC23sDTU5uBLZwLTZQ8
X-Gm-Gg: AfdE7ckfjLH45yVLN+PQy+ADr9EHcmvdPNTleD/SSNr64i62hIR3Nb+cqU1A9tbIT/Y
	uyZhLUTvuMv1SXKPqr9c157M8p1gUg2LIwDlM1KbaS0Gr2IaJouagUpiqt7xTTVzpSyfzCVws1Q
	mmKUH7LiNZCyoabzg5w+W7lop5ix9I6zGbq1YQhxOB/a/bSZJm7DmaR7jA+6hHceswywWkIxIAu
	vEtgu0ivoHe5W8ls0qqFDxN0UUmwrpKqLKeP5+CzETk+nT5/veMXjslw9fatj+2/4Mp5DmiPD3u
	YQGnv5Py9FFRtIMu5DA/nt0d0YAHfRGFLWur1ux9ryHim8yvNiiTj4YalpmJF6DgOZCuhhLM1Pg
	AZY5ev1xpFc/mF3QAgqgzKK1IEuSxcD1bEUE+
X-Received: by 2002:a05:6a20:3ca5:b0:3bf:a517:cdcd with SMTP id adf61e73a8af0-3c0f091831emr6662589637.12.1783708291948;
        Fri, 10 Jul 2026 11:31:31 -0700 (PDT)
X-Received: by 2002:a05:6a20:3ca5:b0:3bf:a517:cdcd with SMTP id adf61e73a8af0-3c0f091831emr6662533637.12.1783708291336;
        Fri, 10 Jul 2026 11:31:31 -0700 (PDT)
Received: from localhost ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3118ee6080dsm27861010eec.17.2026.07.10.11.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 11:31:30 -0700 (PDT)
Date: Fri, 10 Jul 2026 11:31:25 -0700
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
Subject: Re: [PATCH v3 03/16] arm_mpam: propagate MSC read errors for
 hw_probe functions
Message-ID: <20260710113125.00005752@oss.qualcomm.com>
In-Reply-To: <20260710144520.917375-4-andre.przywara@arm.com>
References: <20260710144520.917375-1-andre.przywara@arm.com>
	<20260710144520.917375-4-andre.przywara@arm.com>
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
X-Authority-Analysis: v=2.4 cv=JJYLdcKb c=1 sm=1 tr=0 ts=6a513a84 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=7CQSdrXTAAAA:8 a=sM7ngZJOnra7i-ukzE4A:9 a=CjuIK1q_8ugA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: q1vPAsC7c3Ufni5-tzp0S_E8Ygu5TEkS
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDE4NSBTYWx0ZWRfXw8nudL9g/roE
 dFgN+MspQF6yn/dhUQFB6exz3xPTsaEHpWF4esFEPiSCps61QZ0Oti8q29a2nTBn+bDvuttwgKX
 qjXtowCsmNQ8gcgNn+Un/PuYEcVKstg=
X-Proofpoint-GUID: q1vPAsC7c3Ufni5-tzp0S_E8Ygu5TEkS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDE4NSBTYWx0ZWRfX4BQS2lUqJrzU
 mVlg8d+NSLNBkYz21OzhHx1441N+jruc8BxHqVZ4VccnrHtrpBhr4Z+8gxa0uNclpoQjs5zRhJx
 J/lVBCszrBfpDPVhxdysE3pqdY+R1CrTXngnQu6oFtSjHZtejUu7urI+Oo1VThgVY8GYvUNZSTT
 te1F9RRDEdvY54mQUNw3lFCJC9tC9inC2v7AgWE3RMIvMQ1lQIxM7/jT7vQscVwIk053zMpxq/x
 7gNTSXeAxtWW2jLhHZ3cNOgvcbUA1AOIF2G6VjWkbuKCEPW2VMX86QLDY2pRcSxnTCHvZSrW/Ai
 wcCEGoQxPWB+me0dkjUKi0Z5UKe7mrh9E7InzJJUGqymYjbId5azjVfUtBo71+AqIBLHDs/Zdgb
 jEVmwg1pC4Q7lnKobgRPLxADIjLO5v/pMtEdKuBmzS5JGfBYgTsVNVBaiKVlhHhuMWtF1qYTXSH
 SBXuyp1Umt+4DAW7BxQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100185

On Fri, 10 Jul 2026 16:45:07 +0200
Andre Przywara <andre.przywara@arm.com> wrote:

> Allow the functions probing for MSC hardware and features to return an
> error, and propagate read errors from the lower level up.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Hi Andre,

A few suggestions to use some newer kernel 'toys' to simplify this
code.

Thanks,

Jonathan

> ---
>  drivers/resctrl/mpam_devices.c | 70 ++++++++++++++++++++++++----------
>  1 file changed, 50 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> index 8fd2c38c821c..b1bd047da203 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c
> @@ -785,7 +785,7 @@ static void mpam_enable_quirks(struct mpam_msc *msc)
>  static bool mpam_ris_hw_probe_csu_nrdy(struct mpam_msc_ris *ris)
>  {
>  	u32 now, mon_sel, ctl_val;
> -	bool can_set, can_clear;
> +	bool can_set, can_clear, ret = false;

I know the surrounding code does this, but it is helpful to general readability to
not mix declarations with assignments from those that don't. I'd just
use an extra line for ret.

>  	struct mpam_msc *msc = ris->vmsc->msc;
>  
>  	if (WARN_ON_ONCE(!mpam_mon_sel_lock(msc)))
> @@ -804,20 +804,26 @@ static bool mpam_ris_hw_probe_csu_nrdy(struct mpam_msc_ris *ris)
>  	mpam_write_monsel_reg(msc, CFG_CSU_CTL, ctl_val);
>  
>  	_mpam_write_monsel_reg(msc, MSMON_CSU, MSMON___NRDY);
> -	_mpam_read_monsel_reg(msc, MSMON_CSU, &now);
> +	if (_mpam_read_monsel_reg(msc, MSMON_CSU, &now))
> +		goto out_unlock;
>  	can_set = now & MSMON___NRDY;
>  
>  	_mpam_write_monsel_reg(msc, MSMON_CSU, 0);
>  	/* Configuration change to try and coax hardware into setting nrdy */
>  	mpam_write_monsel_reg(msc, CFG_CSU_FLT, 0x1);
> -	_mpam_read_monsel_reg(msc, MSMON_CSU, &now);
> +	if (_mpam_read_monsel_reg(msc, MSMON_CSU, &now))
> +		goto out_unlock;
>  	can_clear = !(now & MSMON___NRDY);
> +
> +	ret = !can_set || !can_clear;

This is less readable than it could be. I'd be tempted to split good and bad paths.

Or better yet, now we have ACQUIRE() and ACQUIRE_ERR() can we use the cleanup.h
magic to do auto cleanup of mpam_mon_sel_unlock()?  Then the error paths can
become direct returns. I haven't read the rest of the mpam code for a few months, but
it might be much more generally useful given we now have a bunch more reasons
to return early.

> +
> +out_unlock:
>  	mpam_mon_sel_unlock(msc);
>  
> -	return (!can_set || !can_clear);
> +	return ret;
>  }
>  
>  
>  static int mpam_msc_hw_probe(struct mpam_msc *msc)
>  {
> +	int ret;
>  	u64 idr;
>  	u16 partid_max;
>  	u8 ris_idx, pmg_max;
> @@ -1016,10 +1040,12 @@ static int mpam_msc_hw_probe(struct mpam_msc *msc)
>  
>  	/* Grab an IDR value to find out how many RIS there are */
>  	mutex_lock(&msc->part_sel_lock);
> -	mpam_msc_read_idr(msc, &idr);
> -	mpam_read_partsel_reg(msc, IIDR, &msc->iidr);
> -
> +	ret = mpam_msc_read_idr(msc, &idr);
> +	if (!ret)
> +		ret = mpam_read_partsel_reg(msc, IIDR, &msc->iidr);
>  	mutex_unlock(&msc->part_sel_lock);

This is a classic pattern where cleanup.h magic can give a more readable
result with all error conditions easy to spot as each can be fully
handled on its own.

	scoped_guard(mutex, &msc->part_sel_lock) {
		ret = mapm_msc_read_idr(msc, &idr);
		if (ret)
			return ret;

		ret = mpam_read_partsel_reg(msc, IIDR, &msc->iidr);
		if (ret)
			return ret;
	}

	mpam_enable_quirks(msc);
> +	if (ret)
> +		return ret;
>  
>  	mpam_enable_quirks(msc);
>  
