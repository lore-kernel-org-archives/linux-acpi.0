Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D04A374E63
	for <linux-acpi@vger.kernel.org>; Fri, 10 Jul 2026 18:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783708842; cv=none; b=mui11hVft9ISPBBULIilo6oYfx0lagYlmTepQPv6hbEOMc1nnAGrVuhSHw55+i+VojHxa9QBvk1ns/uqrS68gifWA2Ufcqu4ojRv+pZWfhIAiW7Bmrc3sxz4f+mW99mfcxJqvzWDhHeudsdRngB/pipFfIvC+zdg5ef4hwZnIw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783708842; c=relaxed/simple;
	bh=E0l7+kMNWQmATWMlRzv69azlDpKbWFAxKvJDytWmvGA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TjLX8kVTd/lEQGM5rzLze2v7OeIlRlquFIPmXQLWxuivqv0PbiyxJ+0TxkSQFbrKpfcKqM8nuAt42xO3JPyGdZHWjuL+DZ+f4q+XPcvTe2kqO5bwfKbdNo11V5b+B0SIyYisHu5IGwiaD6XdKxFGqQxwSaxKUQL3RhOb149hhBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=A74IRlRJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=awiYCfcf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="A74IRlRJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="awiYCfcf"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66AH3gx51307173
	for <linux-acpi@vger.kernel.org>; Fri, 10 Jul 2026 18:40:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sIpvr9LYvApRcbIP0ivQOlJFsKZAMdUrM1YtqwpVgaE=; b=A74IRlRJnNjrcxXb
	UQ7z646iDwLE/mBnMm4EPorid6bO0fVIm2OHjSDMNKETLXoKYCe38K/ZK6pUj0nz
	Dfg+oBJbeeBd1oeJsg7ziEgISMfJelHuAqL0W0Yd3sJYH9BUv6cQjJANgmlOFR2D
	fh9FjNAi/cCk7VbwZXmFOxpCd+njt3Tj5RgMTKxGKh6bGHLlOLHoj8pg6GayFQ3S
	VlDht69mJxsOJLtbhIuDMyeVMCSqoEoobnLNHmhLg9RKCpyY1De8j0WNkKW0y3Gc
	4OZfvDsrs2e9pLibkybRhVtyPwrWcBcYiw4ZLSgvu5mktlxYQucI+TFWx93zrNAD
	NMvoTw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fax5dj0mv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Fri, 10 Jul 2026 18:40:40 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c856470fe9fso1114199a12.2
        for <linux-acpi@vger.kernel.org>; Fri, 10 Jul 2026 11:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783708840; x=1784313640; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=sIpvr9LYvApRcbIP0ivQOlJFsKZAMdUrM1YtqwpVgaE=;
        b=awiYCfcfLggFAp7z4k572qRkVc2FiWcmRVaAWG22Kf6kfbx2ifxqOn72yp0PQLQiCB
         zITtSRvze5DYb/mi6ahfzuoVwnLxJiUGSC6dNed4AKIkjdKrNbTNgXkVzPRbtECpfSws
         PWLAaP11ITwAcfhWWUqJ9j6TAAj58t9k383Zx7rLKkrGAcs/njDklbHC6PdcCRuECbXs
         giiU7QZA32VH/ISvyJP2YGVrEHQrAD1ur3ESEvZyaucI4QAaIAXmkXeh4WvNjMkG3Hi8
         SqD+GhU64s0Y7QZ0ZCWkNiSJPpqYx5TiLdG+EbCw8LeQcvPOGp0SovEiEA9XVjdGOmtC
         B0yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783708840; x=1784313640;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sIpvr9LYvApRcbIP0ivQOlJFsKZAMdUrM1YtqwpVgaE=;
        b=kBuYJa5gTzdOs95ErEFmhTbnJQp/uBR+EFiXVwavmIIPJmOTDfndLzXMO4oitmpaWY
         3kJSkjUG0Ji4BiyASy0/V4Ak+e8lnZfi1Yo07MnM95C2kVU3QZep0qkM6lGsiJZu7Iin
         1+Z65S5h/u+NmIwf/xA8lMdG/Er9KN+EL5EFqk4tf5/2JRsiK0zy3Gm0np16YPZBMtZa
         SsETYrj3RG/m/UZ7NkeS//yc1m9bB317a8saOmtcuiMu/idw1uISZDi7AcQ/k2LAM/vE
         R11e69GYgaQE/HBaODYS+7PhyvAOVdJmJ2ihJ0Xl1qvw7bu+hjqZ9EjyPY+dEjJ+XY6M
         91cA==
X-Forwarded-Encrypted: i=1; AHgh+RolKeVymDeFMZ2FCkOCMnNUor9ZrARX2cwBz8fPsK3ZScAjdByo5hr6gW1AcPga6t7Y37c0pOqYCTk+@vger.kernel.org
X-Gm-Message-State: AOJu0YzB0CWJN59mITkaJ7FsyivWBd7XOUoZapxABqkf3dNII24lh0uI
	4SISVH5tdYUyYnvFmVVj/LovySDhpiwTU5+pAUDyS3OzwOg0k6XSx/1h+O2DvxEzC9nYhktfeg8
	A6bxR2FwjoAETjEp6sqARmaqxMLpXkV0MudbSwJbfe+gqQ2bjQBBUTb7YSaImFmO9
X-Gm-Gg: AfdE7cm9Tned00+A9K31gaeAXDiCSo8y7+SpErm//iIcsvIyaF6n1yD4PreIsHUlW3W
	qCptSHUq5HEjlSRai5y9cvw5jqJXvM8tQhZmrUv3+cadCfxYADdEp6YsdkwCeV6OOjO6p9Gi9ar
	kSJREyQ+CUvJwzq5M0xOyOS08IJ31NnY+NICO2aT15YLR30zMV7vK7bTXTk32g48PPMzxIic1ie
	qv1iiLG6KmKIvX1vlpxcTvaOhDOKfQpOz1JFMpvU7ZQX3W4kQuP3NFs+VGPYfsC1i/bOQjAxCEO
	naxoIyf7h5UIsmefwC5d+/l+H4mV/btP52aPjT55VTTWftIG+VRI1YChIWMdjAxKJ3pLWmKWh7c
	Fi/uT9xJKEABt+3MUvNhPLqrHCLIiH/+rMpEU
X-Received: by 2002:a05:6a20:3d02:b0:3bf:e761:626a with SMTP id adf61e73a8af0-3c110a74637mr214294637.38.1783708839862;
        Fri, 10 Jul 2026 11:40:39 -0700 (PDT)
X-Received: by 2002:a05:6a20:3d02:b0:3bf:e761:626a with SMTP id adf61e73a8af0-3c110a74637mr214261637.38.1783708839424;
        Fri, 10 Jul 2026 11:40:39 -0700 (PDT)
Received: from localhost ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174ac14f2sm45594006eec.27.2026.07.10.11.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 11:40:39 -0700 (PDT)
Date: Fri, 10 Jul 2026 11:40:35 -0700
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
Subject: Re: [PATCH v3 04/16] arm_mpam: propagate MSC read errors for
 mpam_msc_read_mbwu_l()
Message-ID: <20260710114035.00006b0b@oss.qualcomm.com>
In-Reply-To: <20260710144520.917375-5-andre.przywara@arm.com>
References: <20260710144520.917375-1-andre.przywara@arm.com>
	<20260710144520.917375-5-andre.przywara@arm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDE4NyBTYWx0ZWRfX/vytJx579k2R
 UytKwLeaDrzzXEh29UBx8YdiAEboqGM6y2q3tzMAcNMWi8+Vn1JZoaYl9UKCdYq0qF/DpAAG89g
 oT3Ah3CWhTXH2QtedOqwjJ4CASVD/WU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDE4NyBTYWx0ZWRfX56hIkyX9ipOZ
 Mp6vpNhz2CWe3wy46VFOR/Hf4PS0nhs9Bt1SAw2nKhJ79jFMHI9CqZAi4Tm0+sc5rRL3wsoPNNM
 3+3eU/tApyPQCrsgzt9ggN4CaLkox3XdMOIFdnaSVVk8RPMQIvLs4xe3bUd4wCl84Up2ncO7h1b
 GoQOFL75X7kE1pr699tphtYMIQk+jPjSahE8nGwpQ0kkhfplYw1qniM2sPuFhV0vmd8ugvIhQpV
 6bXdYb//yBMNDupId0DRpP+v9MESF+wFCqfOM88MrOcGTpoJ+LTZyx+jNEhnjOe1JnhJIqYiOMQ
 4b0Q20LDLi9Xp++0Og+B8oOyKxhLAeAEVjCGw6IqNKyF6Wd/cCAVgFNOOog4Jxa3ss4HjeGGBmX
 JddscDxmMeXckFM7oyA3EHCDE2byuxOvgJHLDxnDgE6I9CH7dsBNiyDSad//6QYNRYgpBHilLEu
 LQkTD0OR0DATmTM/WNQ==
X-Proofpoint-GUID: QasithLCA1buXvRP1U02r82Exbjr5APK
X-Proofpoint-ORIG-GUID: QasithLCA1buXvRP1U02r82Exbjr5APK
X-Authority-Analysis: v=2.4 cv=M/x97Sws c=1 sm=1 tr=0 ts=6a513ca8 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=7CQSdrXTAAAA:8 a=fCQIp7EH0RKNOWKKMFAA:9 a=CjuIK1q_8ugA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100187

On Fri, 10 Jul 2026 16:45:08 +0200
Andre Przywara <andre.przywara@arm.com> wrote:

> Allow the mpam_msc_read_mbwu_l() function to return an error, and
> propagate read errors from the lower level up.
> So far we were using a special value to indicate the "unstable read"
> condition, replace that with the actual Linux error code, since it's now
> easy to do.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  drivers/resctrl/mpam_devices.c | 54 +++++++++++++++++++++++++---------
>  1 file changed, 40 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> index b1bd047da203..3b6f9e552a9f 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c
> @@ -1112,8 +1112,9 @@ static bool mpam_ris_has_mbwu_long_counter(struct mpam_msc_ris *ris)
>  		mpam_has_feature(mpam_feat_msmon_mbwu_44counter, &ris->props));
>  }
>  
> -static u64 mpam_msc_read_mbwu_l(struct mpam_msc *msc)
> +static int mpam_msc_read_mbwu_l(struct mpam_msc *msc, u64 *res)
>  {
> +	int ret;
>  	int retry = 3;
>  	u32 mbwu_l_low;
>  	u32 mbwu_l_high1, mbwu_l_high2;
> @@ -1123,20 +1124,30 @@ static u64 mpam_msc_read_mbwu_l(struct mpam_msc *msc)
>  	WARN_ON_ONCE((MSMON_MBWU_L + sizeof(u64)) > msc->mapped_hwpage_sz);
>  	WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(), &msc->accessibility));
>  
> -	__mpam_read_reg(msc, MSMON_MBWU_L + 4, &mbwu_l_high2);
> +	ret = __mpam_read_reg(msc, MSMON_MBWU_L + 4, &mbwu_l_high2);
> +	if (ret)
> +		return ret;
> +
>  	do {
>  		mbwu_l_high1 = mbwu_l_high2;
> -		__mpam_read_reg(msc, MSMON_MBWU_L, &mbwu_l_low);
> -		__mpam_read_reg(msc, MSMON_MBWU_L + 4, &mbwu_l_high2);
> +		ret = __mpam_read_reg(msc, MSMON_MBWU_L, &mbwu_l_low);
> +		if (ret)
> +			return ret;
> +		ret = __mpam_read_reg(msc, MSMON_MBWU_L + 4, &mbwu_l_high2);
> +		if (ret)
> +			return ret;
>  
>  		retry--;
>  	} while (mbwu_l_high1 != mbwu_l_high2 && retry > 0);
>  
> -	if (mbwu_l_high1 == mbwu_l_high2)
> -		return ((u64)mbwu_l_high1 << 32) | mbwu_l_low;
> +	if (mbwu_l_high1 == mbwu_l_high2) {
> +		*res = ((u64)mbwu_l_high1 << 32) | mbwu_l_low;
> +	} else {
> +		pr_warn("Failed to read a stable value\n");
> +		ret = -EBUSY;

I guess this may get more complex in later patches, but for now why not just 
		return -EBUSY.

> +	}
>  
> -	pr_warn("Failed to read a stable value\n");
> -	return MSMON___L_NRDY;
> +	return ret;
>  }
>  
>  static void mpam_msc_zero_mbwu_l(struct mpam_msc *msc)
> @@ -1283,6 +1294,7 @@ static u64 mpam_msmon_overflow_val(enum mpam_device_features type,
>  static void __ris_msmon_read(void *arg)
>  {
>  	u64 now;
> +	int ret;
>  	u32 now32;
>  	bool nrdy = false;
>  	bool config_mismatch;
> @@ -1358,8 +1370,9 @@ static void __ris_msmon_read(void *arg)

Relevant bit of context isn't show, but as before looks like
ACQUIRE() and ACQUIRE_ERR() will make this simpler by just
letting you do direct returns on all error paths though
you will need to set m->err = ret in each one.  To me that
is simpler, but feel free to disagree.

>  	case mpam_feat_msmon_mbwu_44counter:
>  	case mpam_feat_msmon_mbwu_63counter:
>  		if (m->type != mpam_feat_msmon_mbwu_31counter) {
> -			now = mpam_msc_read_mbwu_l(msc);
> -			nrdy = now & MSMON___L_NRDY;
> +			ret = mpam_msc_read_mbwu_l(msc, &now);
> +			if (ret)
> +				goto out_unlock;
>  
>  			if (m->type == mpam_feat_msmon_mbwu_63counter)
>  				now = FIELD_GET(MSMON___LWD_VALUE, now);
> @@ -1397,10 +1410,15 @@ static void __ris_msmon_read(void *arg)
>  	if (nrdy)
>  		m->err = -EBUSY;
>  
> -	if (m->err)
> -		return;
> +	if (!m->err)
Above ACQUIRE() suggestion relies on it not being a problem to hold
the lock a little longer and incorporate these sets in m. I haven't
checked closely but I think that's fine.

> +		*m->val += now;
> +
> +	return;
> +
> +out_unlock:
> +	mpam_mon_sel_unlock(msc);
>  
> -	*m->val += now;
> +	m->err = ret;
>  }
>  
>  static int _msmon_read(struct mpam_component *comp, struct mon_read *arg)
> @@ -1747,6 +1765,7 @@ static int mpam_save_mbwu_state(void *arg)
>  {
>  	int i;
>  	u64 val;
> +	int ret = 0;
>  	struct mon_cfg *cfg;
>  	u32 cur_flt, cur_ctl, mon_sel;
>  	struct mpam_msc_ris *ris = arg;
> @@ -1768,7 +1787,9 @@ static int mpam_save_mbwu_state(void *arg)
>  		mpam_write_monsel_reg(msc, CFG_MBWU_CTL, 0);
>  
>  		if (mpam_ris_has_mbwu_long_counter(ris)) {
> -			val = mpam_msc_read_mbwu_l(msc);
> +			ret = mpam_msc_read_mbwu_l(msc, &val);
> +			if (ret)
> +				goto out_unlock;
>  			mpam_msc_zero_mbwu_l(msc);
>  		} else {
>  			u32 val32;
> @@ -1788,6 +1809,11 @@ static int mpam_save_mbwu_state(void *arg)
>  	}
>  
>  	return 0;
> +
> +out_unlock:
> +	mpam_mon_sel_unlock(msc);
ACQUIRE() would avoid need for this handling so I think this is another
good place to look at using it.

> +
> +	return ret;
>  }
>  
>  /*

