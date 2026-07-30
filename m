Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995C73AD534
	for <linux-acpi@vger.kernel.org>; Thu, 30 Jul 2026 19:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785438326; cv=none; b=ETbXuJwKwD+L4O7mrqvoWmEgN6dqPtaYetlYwKnMoGT4rARf+Fe5FgKaw2FHKJ82rGbwQb/k+j6ZxLVREiGH2CNfD67BPywnibBN9KGRKqfN+/NWcy+b90SSHGcgv1tqFtYF6qzvB0vglyU/UY0a23FxJWEiov0tS1Ty0Yw1KTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785438326; c=relaxed/simple;
	bh=GmvbZIw9FVSnGdEtAIA/a6EBcDxWnIXefHSmgFiJBcc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S9e2Md/C4TqMOitb+JT7VtCqdniCvPYd1rmAy0eBBAlnOfNHr0pWByWiF0t8p7vgQ0At0nTh9m221qcCb2qHMWkpgU24bEki+L5u50gWL7jbx1dq6RigOw0svOpCnqGiNVQGTIoZJ4M1D+deuI/iPA07NqN/eIxW0NpKpdRU2BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QpUixNTy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=egoJCji+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QpUixNTy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="egoJCji+"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UGWbWd1379476
	for <linux-acpi@vger.kernel.org>; Thu, 30 Jul 2026 19:05:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GqFouO/Y0c5A8aRED0hGU8nzTxnUOhLbljZSc3SPdr8=; b=QpUixNTyrWH4KVoV
	tVDCeqi0jYtHrpR/Z5/f0oC18+A+6h/iU14wotg513bT/EzpJ0HPkhpBVtA04Zw0
	r1g77haoJwdtQt+QGcQbaXdtynhR+TJoxHr5MZDIRlbDNy3lHKjtI1W3ZFfCx77O
	xcDxK220a1yqlEffKUy6vq5fJdQxRDLW2T/0FO98YBBVFZ79Yb+p0Y/GrXooFF1I
	hEriF+By07dbkwiisoCL89jA6GvJi9i0ubDZeQkK9hpyjrAQXKs3x+yrM/nZHNlx
	maGZxd5DUdJw++//nv8+h6Rw1sRCgitbC4Trot+SHsgBqg/HrVfebvD+k7um8Qmu
	EyQ+DA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr8kn1cw3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Thu, 30 Jul 2026 19:05:23 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cab048cdb3eso159463a12.0
        for <linux-acpi@vger.kernel.org>; Thu, 30 Jul 2026 12:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785438322; x=1786043122; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=GqFouO/Y0c5A8aRED0hGU8nzTxnUOhLbljZSc3SPdr8=;
        b=egoJCji+cg4axnrQaqYUbMuKRwHGZcyhmPCl78L8JzpNlys4Ta5JGTJQ75ozeDmo3c
         KCftqvNTAolrCzBTk212F92xboV31ueT1y+yrr8E+dgk9q3DyJDd4Z+4ovBl/xqt/NLv
         Ug/UeW/GjPuvdnC8Ts1dLJLk4xWvpEhPjOyBJgzRvzapcRvhPQ0xjqL32MJI61GPE9Gg
         NKiQssexAt4AW01l+plgDo8gBuKjVm4e2dLmkrqeYR4OLzpGUtyPsqsnd3/GH7hgLL4v
         wS4TVpFJHdKJse4M4uUhp9x6UrGfvyzJetI0iFQzStuipaodWN24ym3Sv4c0ENxoq937
         80Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785438322; x=1786043122;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GqFouO/Y0c5A8aRED0hGU8nzTxnUOhLbljZSc3SPdr8=;
        b=EPpqoKal5onZaiZerl3KDh5c/M8RQaaM9o19KA34ZGXhyeLhHJ1OVEDWKPazZpFCL3
         QaYg8h42281lpzI4eVtHLUj3ZHs8HaZiqVcF27AvudHPzHPDBpb1uvjsVbA1B9V+RGCk
         vCdhwlQIud7JyOml4Xf/kv9INOjHWORQcdofcbhtqr41+tuEf82zd9KDXXVNVE5KtFGz
         y+g0JhmE0sQwd2I2FTbW1GKsVY3mN0ouDsi65goXTQgCUPZ6BJxZOMrH5iInHtIph/EM
         RS/wZ52qLkWlXcBVwK5tZIZTx4NHBSHkTbDU/27CANw2XWcvWIxQwhp7CeWySkfnup6c
         lZTg==
X-Forwarded-Encrypted: i=1; AHgh+RrSD/M7BQ4jiSpIHnTz2Jfbx2CwLxUk8QsubDWgD+tC3zvVRTC9LV9zTvl7bsXUqBo1bEeGQYkyhUGG@vger.kernel.org
X-Gm-Message-State: AOJu0YxEgC9OL+NIwYsM4KW8wpyn99xMCaGcnP5M+SHTyWWtPFpm6mFS
	yHFwN1IoKgBnLPvumiZb4KvUdrCsNnPLbrOyEgyDmX9zLxvIBTvFVKfv8v8IrPWShb9wJvCE0/H
	eAqW/iuXvslUW3iu9fR7a/pPMIFHwfIdjajIlg8WQ4k55cH0EkfG99uwmSS59SYOi
X-Gm-Gg: AR+sD136GCIJz4mtZvnFyIXDTgVKXoRpdYf5AVEPBuy23ZmPh7jGwKkEH8DFOoKdDrn
	utSYkqplAaJKVCGDWD7mqDiPjY7mRO69JstMLdEu/I+6FIYN3rKVjDvSsCymI5ZCZfMYQMD4P2y
	O1nt99+L4ybVlL+q8QahYg02UCSsH3rYCmACxO/z9E1oEErYEknvoJIKMI5zutHKEV8IKo75EYz
	E2dgFLplLgvoAnhdnggXz7pw2Va47SLVHgJ0uQtMd0pJlHmn3H0oyZ5kXNCbFFkwIPScsBYem+R
	7Jc3Jr32gRa+yS1cp+DtdBCDgkQVSBN3/GGxJ+D6vxlfeAZPViWk1hhcrjtGzPBCfSFVPg36SqT
	1YfbQ4usMqc7zYqgIdQi85dyb5g==
X-Received: by 2002:a05:6a21:692:b0:3a0:bc61:62e6 with SMTP id adf61e73a8af0-3c90d3da39fmr1381065637.8.1785438321812;
        Thu, 30 Jul 2026 12:05:21 -0700 (PDT)
X-Received: by 2002:a05:6a21:692:b0:3a0:bc61:62e6 with SMTP id adf61e73a8af0-3c90d3da39fmr1381039637.8.1785438321357;
        Thu, 30 Jul 2026 12:05:21 -0700 (PDT)
Received: from localhost ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504b15f77sm25603658eec.4.2026.07.30.12.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 12:05:20 -0700 (PDT)
Date: Thu, 30 Jul 2026 12:05:16 -0700
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
Subject: Re: [PATCH v6 08/10] arm_mpam: add MPAM-Fb MSC firmware access
 support
Message-ID: <20260730120516.000059aa@oss.qualcomm.com>
In-Reply-To: <20260730152539.2712312-9-andre.przywara@arm.com>
References: <20260730152539.2712312-1-andre.przywara@arm.com>
	<20260730152539.2712312-9-andre.przywara@arm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDE0MCBTYWx0ZWRfXxhHKfFPkhOnZ
 ZZftcN7RS7+ZauPmJCnLoHKS905foFvgt9bFOYnMbfPuq404DJ8BnykdRSfSwz6DSGuuJjJxp6u
 KxAy95zhSXC4Z4+eiYL1lQizT0EhM3s=
X-Proofpoint-GUID: 65j9iWccAzc7GZ4L1gbo6aI1qMQaypJw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDE0MCBTYWx0ZWRfX17+9/S/XiFKT
 35ICOBEmljyxYLGMDRUbbn3JyjNVXTmuOGgPf01W2+pZWgECcD6Cqu5EnRHA6SY/Kv+HV8YuLdI
 HKO4G09tIcyY/6h7Hkl+tI5dSjcvvHp7GJfP/IjPo/spgquFulOSg66QzLcfZaT9oUuH0KiVyTd
 toqDCvSE5H8GZJiSjOgmIYo28t2mCvhZHfDDAudGE96AAdMOqX6zoNKKpaFqubg/qcXJ6Unyatl
 Y2tlEwkVGE3R0M2Tdzas8jMzNgZ74eJYRJZplk1pTf0rJbNGOSsqx9I4KmR3h4XEaX/midM8Cnd
 CrwqcuhtpOLVWCp4Xy22Vdcw+0yRXlXQ38fBQUmOVyUx+0/QD46VjErDwtIJ4i5ZcasyuMoZSJJ
 SsPzSUFVpr0eS0Ya8CFHfrcu6ewqx6CPHZdS65SaGHy7CwguMFdUEU42VuBagK/K+kLZBIVIOzS
 GQZ3L9IJH7z33PCdhvA==
X-Authority-Analysis: v=2.4 cv=V7NNF+ni c=1 sm=1 tr=0 ts=6a6ba073 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=7CQSdrXTAAAA:8 a=EUspDBNiAAAA:8 a=irsnRLeOcCLjm4-ghIcA:9 a=CjuIK1q_8ugA:10
 a=bFCP_H2QrGi7Okbo017w:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: 65j9iWccAzc7GZ4L1gbo6aI1qMQaypJw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_05,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300140

On Thu, 30 Jul 2026 17:25:37 +0200
Andre Przywara <andre.przywara@arm.com> wrote:

> The Arm MPAM Firmware-backed (Fb) Profile document[1] describes an
> alternative way of accessing the "Memory System Components" (MSC) in an
> MPAM enabled system.
> 
> Normally the MSCs are MMIO mapped, but in some implementations this
> might not be possible (MSC located outside of the local socket, MSC
> mapped secure-only) or desirable (direct MMIO access too slow or needs
> to be mediated through a control processor). MPAM-fb standardises a
> protocol to abstract MSC accesses, building on the SCMI protocol.
> 
> Add functions that do an MSC read or write access by redirecting the
> request through a firmware interface. For now this done via an ACPI
> PCC shared memory and mailbox combination.
> 
> Since the protocol used is only a small subset of the full SCMI spec,
> and the SCMI protocol has no full ACPI support anyway, open-code the
> (simple) SCMI message generation, for just the fields we need.
> 
> [1] https://developer.arm.com/documentation/den0144/latest
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
On trivial style consistency comment. Otherwise looks fine to me.

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> diff --git a/drivers/resctrl/mpam_fb.c b/drivers/resctrl/mpam_fb.c
> new file mode 100644
> index 000000000000..e2ce28a602aa
> --- /dev/null
> +++ b/drivers/resctrl/mpam_fb.c
...
> +static int mpam_fb_send_request(struct mpam_pcc_chan *pcc_chan, u32 msc_id,
> +				u16 reg, u32 *result, int mpam_fb_command)
> +{
> +	unsigned int token = atomic_inc_return(&mpam_fb_token);
> +	struct acpi_pcct_ext_pcc_shared_memory __iomem *pcc_shmem;
> +	struct pcc_mbox_chan *chan;
> +	void __iomem *payload_ofs;
> +	int mpam_fb_err = 0;
> +	u32 status;
> +	int ret;
> +
> +	if (!pcc_chan)
> +		return -ENODEV;
> +
> +	chan = pcc_chan->pcc_chan;
> +
> +	/* prune token to fit into the 10 bits inside the command register */
> +	token = FIELD_GET(MPAM_MSC_TOKEN_MASK,
> +			  FIELD_PREP(MPAM_MSC_TOKEN_MASK, token));
> +
> +	mutex_lock(&pcc_chan->pcc_chan_lock);
> +
> +	switch (mpam_fb_command) {
> +	case MPAM_MSC_WRITE_CMD:
> +		mpam_fb_build_write_message(msc_id, reg, *result,
> +					    token, chan->shmem);
> +		break;
> +	case MPAM_MSC_READ_CMD:
> +		mpam_fb_build_read_message(msc_id, reg, token, chan->shmem);
> +		break;
> +	case MPAM_PROTOCOL_VERSION_CMD:
> +		mpam_fb_build_version_message(token, chan->shmem);
> +		break;
> +	default:
> +		dev_err(pcc_chan->pcc_cl.dev, "unsupported MPAM-Fb command %d\n",
> +			mpam_fb_command);
> +		ret = -EINVAL;
> +		goto out_err;
> +	}
> +
> +	ret = mbox_send_message(chan->mchan, NULL);
> +	if (ret < 0)
> +		goto out_err;
> +
> +	pcc_shmem = chan->shmem;
> +	payload_ofs = chan->shmem + sizeof(*pcc_shmem);
> +	status = readl(&pcc_shmem->command);
> +	if (FIELD_GET(MPAM_MSC_TOKEN_MASK, status) != token) {
> +		ret = -ETIMEDOUT;
> +

Slightly odd style. I'd drop blank lines in places like this.
They aren't consistent as things stand.

> +		goto out_err;
> +	}
> +
> +	mpam_fb_err = readl(payload_ofs + 0x0);
> +	if (mpam_fb_err < 0) {
> +		ret = mpam_fb_translate_error_code(mpam_fb_err);
> +
> +		goto out_err;
> +	}
> +
> +	if (mpam_fb_command != MPAM_MSC_WRITE_CMD)
> +		*result = readl(payload_ofs + 0x4);
> +
> +	mutex_unlock(&pcc_chan->pcc_chan_lock);
> +
> +	return 0;
> +
> +out_err:
> +	mutex_unlock(&pcc_chan->pcc_chan_lock);
> +
> +	mpam_fb_disable_mpam(ret, mpam_fb_err);
> +
> +	return ret;
> +}
