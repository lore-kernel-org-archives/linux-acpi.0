Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4311237C0F6
	for <linux-acpi@vger.kernel.org>; Fri, 10 Jul 2026 18:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783709346; cv=none; b=mWxGrJqFfiJtyehp/XK5XkjAG1oGUa6JgmAJt9oYzHx7EkQCJMeZpJs6I7iPuhQMS35BKB0+fnD6k0PBxrpWU+wWOh1b0giJvWpQNpsv1EBovlmiXxuqlkjW8bwdLLVeKyvP9cBoaHEYOqa7E04HhoS/jP89POsPdIWoXBZtVBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783709346; c=relaxed/simple;
	bh=E8wcVnSLIw/E0nvCX4sBW0uvspXfiv3BgUShxKOeQd8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mOa+Rzm1LBkpEAHQltcjHjgCzVFCjQA2oj3uv0s35H7gAnAiJSvH+u5gs3l71gvLl+dYuQtPVgn3ih3Z2u27BLopJ+8NcUuwDO5LNFoH3iCM5bFM3S4Ame1CdJPrl6sqGxqHOovTISKEZOXdtcML4c3mahcGuQLXE362no+kvBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KFStoFOE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=a0m7ChoI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KFStoFOE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="a0m7ChoI"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66AH43VW1400639
	for <linux-acpi@vger.kernel.org>; Fri, 10 Jul 2026 18:49:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0Ss9oAhVsJIGIgV741scL9PWQQaX3OT8OnIGzEUK6To=; b=KFStoFOEL5/meHet
	eMjesuOr55KGrdbwXnsmgYk2tN+eR2tLXO+SmKQpB06g1ee6iYOTIBqs3A+uLDKs
	jR07lo44K4lu7VO+3aqrg85AEsPsKk/Ob8Gn5M30ekwrN+l3sKqDvfywMvruzMTw
	oneSgcr0gy0xhw4p/CXGAAxJS/smftIXS6+NDo5H7qEEDg+LAHRcc6avMRpMzQ+d
	A0R3ErXvEvsDy9BYjA9o0bbKAXaNoPHe24ZmxlrXsgKnDz2ATA2aokUxOZlPO2G5
	cuw45vAO8HN4nj2BzemCi0VFTypfc2xKzHZayqgy3ZC9LYlDEH03AlJMoWDGIFkv
	LvPm9g==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faxyg9u7k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Fri, 10 Jul 2026 18:49:03 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3811ae55313so1235970a91.3
        for <linux-acpi@vger.kernel.org>; Fri, 10 Jul 2026 11:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783709342; x=1784314142; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=0Ss9oAhVsJIGIgV741scL9PWQQaX3OT8OnIGzEUK6To=;
        b=a0m7ChoIuoWOCcNDGmFlnzJyZtVn7Ow3wHIXW0y9fnhUUZ+pWz9voO2P/PJ1bJlD61
         rgh8fHSP+MzDAAFiP6b+OhUo6fLyCUNm3YVY0caf1m4qf22S8Xm6WyUxZi5aqmjXKsBd
         QHLZgSEq3Km/H3UCvfK7z7yE7Fy70rjTUrS4AlJRmJULsMcp+fdMrJ9ZftuBREtJ4wL0
         4sZ7Xdnc6xOa53qVeApm97WwYt2bbMxw9SICt8jiV9q+MjzGpjYmQ7HoZvZ1x4NmxnWB
         Zo7ka6dRHIuTB9MTLVjMydohWjUV8L8mQySQGcjib1EWQ3KXRydVew9mjpIYluA+LIRU
         DZ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783709342; x=1784314142;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0Ss9oAhVsJIGIgV741scL9PWQQaX3OT8OnIGzEUK6To=;
        b=CpnsdaQJF+FdPlldb2mWGXDXKXkAboV4qj/+MFzLB583Ob7q9lSSBVcfQN5PvjK5RB
         zu4iVuVTwyMrzNi+F9ExY9+iR722wRiX/b7Gr8HfMUi1gLMY11IryMhAhVD3g1eJyeUK
         H1Zy+27f5YsLh3D1QZK2CplEkBj5fv1z9tV+Xlw374MZa1l2Ix6hrwYXQTMFI372MJAi
         CWYNv1T1nB4tEUsPlx9bxukpjMbh9zZo7PJ2sspu1Xgp7d+PlAHa8W/PiU7evzvQChim
         +80Wc4aAeNLuZ69Bl3d8UNzp+S2II18RYjEOtkmYvKhK/fVSnW/qzVUA9wZMRw6hxext
         9VSA==
X-Forwarded-Encrypted: i=1; AHgh+RowctD10K1nRTeQlKA+I4ubvZm3iOvL1BVQs/tf5oXSWaKy4UWbI/EmoTN9crQcwWRU092ojWwpZUWx@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7xGy/zIfi7mf4AYX1+JZKWVo9uj7D4bw0YuJOL0uOrmDx4pLM
	ZdH+nWhH8oNUf4hyK/ndo+bqhFd39LRKg+t2N1qQIg8i2qDo4A28+sa4/nTzxy0VJVTPoWh3It2
	8qoHHS50TOi6/MNHWhtCK1fBfcqUswV95Xf7FhiJ6RDhlmRKfr4pokKZWm0V/lM3O
X-Gm-Gg: AfdE7cnvFIVupF0qaiPiUGfng9qrRyflVT4lrzk75j2isAW0v8wnDVnttzhRLkI8juO
	XGnYsnW3ng/yeae1YSvFTS/RFAf9Tcbpp1dpFTMfpAHDeltWeH87L5umBDGLD/UPH8oK+fjLIqB
	8uAyu8Xgod21uo6XgmX1Moas26zaF3UP/uF75eHr/S5Pesa+w5Wj8BBWPo/BrPcri8Kep3aPxqy
	lygTUKvCzpp8pn+KOFb1vjNpVSL5wREyUQJ4clSDWNDUSDZ71BscScs65VEmdMsT8r61ACmlDUU
	L7gnlOR+6co2n8w0kaKgYXRRGjE7wfKwiP1ohgfnKu2JIuPfPkUYVeMCGdycJ02PLTPivULAwZ9
	MMUjHBeRqABOhY4yNfCIR87aQ7cCPgUOnKiBE
X-Received: by 2002:a17:90b:2e8f:b0:380:8b14:d8e1 with SMTP id 98e67ed59e1d1-38dc7b3f8ccmr143455a91.24.1783709342089;
        Fri, 10 Jul 2026 11:49:02 -0700 (PDT)
X-Received: by 2002:a17:90b:2e8f:b0:380:8b14:d8e1 with SMTP id 98e67ed59e1d1-38dc7b3f8ccmr143416a91.24.1783709341636;
        Fri, 10 Jul 2026 11:49:01 -0700 (PDT)
Received: from localhost ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174839f89sm43384913eec.10.2026.07.10.11.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 11:49:01 -0700 (PDT)
Date: Fri, 10 Jul 2026 11:48:56 -0700
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
Subject: Re: [PATCH v3 06/16] arm_mpam: propagate MSC read errors for
 __ris_msmon_read()
Message-ID: <20260710114856.00000ab5@oss.qualcomm.com>
In-Reply-To: <20260710144520.917375-7-andre.przywara@arm.com>
References: <20260710144520.917375-1-andre.przywara@arm.com>
	<20260710144520.917375-7-andre.przywara@arm.com>
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
X-Proofpoint-ORIG-GUID: AqnjY2A3AbiOzfj9WOWEVnyTxOLHz_1X
X-Authority-Analysis: v=2.4 cv=PLg/P/qC c=1 sm=1 tr=0 ts=6a513e9f cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=7CQSdrXTAAAA:8 a=P_KzPmMKhQUQMaRR1ykA:9 a=CjuIK1q_8ugA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDE4OSBTYWx0ZWRfX8oaF1HaXraaP
 uQOnDuKcvGQ/5UcrLANpHkEGheuWex3HsTjT9b7MHVCNMjbOB1P6YL9p35clUtiteQYS79NYrUz
 drU4S/SpUeIhZrpsycsHWxqV31OhaGc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDE4OSBTYWx0ZWRfX9oaCn5Kx8sgv
 9JIttMrPQVmVbfwJqyWbj+nrrPsriXW8nWFulhPRiWvorm7pXc0hLSanwJSOD9mFfrSq5v/YACq
 A/V5y8tkQToM9eRlk/xdAej2rqa7WNq04wiOSvK4ISobf2tFkJzjj01mfqNxedXwoh5BzKcpiN7
 RGZ2BFI5HBGKw6HNfFCVDBVRV6GsLtYlE1eHMHrZnRMxakcoj/mztp3Of1Ei3oTDLvCfBQaL8zg
 LZ0SoCLYEPrAznCHyvTCR8fj61dFWzKA2BgMWZ2O8mnGCWTW+MgElXNA+lVgCmqLQEBZLyHNJe9
 xEY4/IcJ1FQB8pNTBJ+u7hsaLdKAAXgU3MYcLtdi+hiET+83RzhreiHjRmYwXwHCs7fAf6JcdmJ
 de36sU1ol/oGCUgIQ6Z8puJlVoYm7fiylzTV9ZGG+CHq3G1vsNFjgfzv/VEGFUI5INePSYpf1g3
 W4ofyzOKa8lzQR4rZBg==
X-Proofpoint-GUID: AqnjY2A3AbiOzfj9WOWEVnyTxOLHz_1X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 malwarescore=0 adultscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100189

On Fri, 10 Jul 2026 16:45:10 +0200
Andre Przywara <andre.przywara@arm.com> wrote:

> Allow the function for RIS accesses to return an error, and propagate
> read errors from the lower level up.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  drivers/resctrl/mpam_devices.c | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> index 041fca018e68..84a8715464be 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c
> @@ -1297,6 +1297,10 @@ static u64 mpam_msmon_overflow_val(enum mpam_device_features type,
>  	return overflow_val;
>  }
>  
> +/*
> + * This function might be called via smp_call_function_any(), so propagate
> + * errors inside the arg struct.
> + */
>  static void __ris_msmon_read(void *arg)
>  {
>  	u64 now;

Similar comments on ACQUIRE() making things easier here.
Note I'd introduce it as a trivial precursor patch before the rest of
this rework.


> @@ -1339,7 +1343,9 @@ static void __ris_msmon_read(void *arg)
>  	 * Read the existing configuration to avoid re-writing the same values.
>  	 * This saves waiting for 'nrdy' on subsequent reads.
>  	 */
> -	read_msmon_ctl_flt_vals(m, &cur_ctl, &cur_flt);
> +	ret = read_msmon_ctl_flt_vals(m, &cur_ctl, &cur_flt);
> +	if (ret)
> +		goto out_unlock;
>  
>  	if (mpam_feat_msmon_mbwu_31counter == m->type)
>  		overflow = cur_ctl & MSMON_CFG_x_CTL_OFLOW_STATUS;
> @@ -1364,7 +1370,9 @@ static void __ris_msmon_read(void *arg)
>  
>  	switch (m->type) {
>  	case mpam_feat_msmon_csu:
> -		mpam_read_monsel_reg(msc, CSU, &now32);
> +		ret = mpam_read_monsel_reg(msc, CSU, &now32);
> +		if (ret)
> +			goto out_unlock;
>  		nrdy = now32 & MSMON___NRDY;
>  		now = FIELD_GET(MSMON___VALUE, now32);
>  
> @@ -1385,7 +1393,9 @@ static void __ris_msmon_read(void *arg)
>  			else
>  				now = FIELD_GET(MSMON___L_VALUE, now);
>  		} else {
> -			mpam_read_monsel_reg(msc, MBWU, &now32);
> +			ret = mpam_read_monsel_reg(msc, MBWU, &now32);
> +			if (ret)
> +				goto out_unlock;
>  			nrdy = now32 & MSMON___NRDY;
>  			now = FIELD_GET(MSMON___VALUE, now32);
>  		}
> @@ -1748,6 +1758,7 @@ static int mpam_restore_mbwu_state(void *_ris)
>  {
>  	int i;
>  	u64 val;
> +	int ret = 0;
>  	struct mon_read mwbu_arg;
>  	struct mpam_msc_ris *ris = _ris;
>  	struct mpam_class *class = ris->vmsc->comp->class;
> @@ -1760,10 +1771,14 @@ static int mpam_restore_mbwu_state(void *_ris)
>  			mwbu_arg.val = &val;
>  
>  			__ris_msmon_read(&mwbu_arg);
> +			if (mwbu_arg.err) {
> +				ret = mwbu_arg.err;
return here.  It's consistent with some of the existing code and
general makes things more readable.

Obviously ignore any comments like this if they are about code
which will change later making the comment wrong!

> +				break;
> +			}
>  		}
>  	}
>  
> -	return 0;
> +	return ret;
>  }
>  
>  /* Call with MSC cfg_lock held */

