Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F4045C711
	for <linux-acpi@vger.kernel.org>; Wed, 29 Jul 2026 16:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785341645; cv=none; b=FBlAjw8kBAJET/7Amw7OzHqojjWbNhEUrDsA0RjYU1nTEaw7WdRCNF6Z+nDu/xmeM/2LNO7O+G/dLcC3+QvtqI5GmJRYjqlsrZA5WKVm3661MYnLMGKwHIpzFOORzfeygMP44QGjvs9K787oP88S+Z67IhTOShyyE5KVzrhC2+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785341645; c=relaxed/simple;
	bh=hov2h3Z1EUh1GziRhZOO4nZBp+b43B8ChPso37zVEEE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kEcfxapDWI21lpsfeDUPOZQnqc+ZYuSCUTVFLRxLAFV2uP/a0+Z4R5FlsSoFV8ihQrn2T7LmUfZHM3JzzW9nqtBM+7PzE+JYEZnopVAkOpRWCHU4TRq37yhedkzl6+UtUh55632g1VZacT+zUHk/+M3dqAWlGH+8Q0ngfDbjI54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lvgnEwpj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WZ4HoP5d; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lvgnEwpj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WZ4HoP5d"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TG45Wp2326425
	for <linux-acpi@vger.kernel.org>; Wed, 29 Jul 2026 16:14:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GtYBRYkMyjgKc49xlFkoQO1F9A58aLCIWeCaVY6Pjxo=; b=lvgnEwpjfWRtmA+B
	JHI9tKoEhTeuHvbgG1P9KMSUtjIvDwyN2emEV0Tf2Ub+1lYlKJfOF2m4gzwc522F
	TRQdRvRFKS9BpgXMqEa+OwLSHX2FzLT7pc7Ns4jtn5mzOe6PUOvdiVZP3/TzcWGR
	kr5nsFddtRNegqXhIbmugDuno+9jXjud6cuyebxxH6Y4H0V8jGxDsQIPG8qGGyQq
	bqO9dgdQ2jwrQN/OqbAsMzZ267MnP6hx9mn3q310NuiDiAMJcqJ8ZaLSm7fYyu1L
	SqdiWndtx7ViD7rWCHiXGnttYT2hLo3BQkKyZsAi5S154HdJ1G5QWfU60DfFCSgf
	9R4o7A==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqmqc020w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Wed, 29 Jul 2026 16:14:02 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c856470fe9fso1001351a12.2
        for <linux-acpi@vger.kernel.org>; Wed, 29 Jul 2026 09:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785341642; x=1785946442; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GtYBRYkMyjgKc49xlFkoQO1F9A58aLCIWeCaVY6Pjxo=;
        b=WZ4HoP5dURml2Hyj/tYRTxs93581zirT5q3a3bI6Ee1OlhmQurZloFbd8Q8xeki620
         qD0m/2cek4V3bBLEKOHjxxC15jBg38YOZTfFY/aoodDvXpT//wOfBktCqRbzbxmfmEgM
         PONP3Cq6FSM8cDucIw2HEK8UoR+az+wWOKcrJNuxS4LX1Vb633NxQxE2/rqdLkD4hUzI
         E8OwzAvOurpPC+sYYq0xBkEYs34tW5j1GKHP6SgUonps0cpaXBpAIof6pu+pkOEO1ux5
         s6ZwgAUYlYGwQv5aNoyqGOnlDgnIwOKieVE4SyJDm1WmQxWgQRNG7VGNLCRjlycc3FCn
         auFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785341642; x=1785946442;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GtYBRYkMyjgKc49xlFkoQO1F9A58aLCIWeCaVY6Pjxo=;
        b=nsUZ1pabjB5RqWCbHVzVGa51YKHfz4XpbDnIk9o9zAzNIj/CazWGoqeXaGwvaYnhO9
         BDmIOcFLJg2KzlYQ9Texb4RLFTP5SQd/pApeltGzKNIE0OF5hBC2BPF+HNBD+a8xzv9u
         0MJGoNlcYxNkUc86N+cEfJ5qHl+1VMY02kzYrdhbdOUfkVYjcQ+xRBUkyRm1gNikPsWs
         CUAgrvgTq5UVInbf8wNotv1HQeDwAKlFVGtr+i/pzC7ugSNUgXMHXAzJJ5kNMddcgTX3
         GSfJjT78SrAtwp2NRWw3IaMnnsghfYIFWac2JfMUwV35nPumQI5q0d+kN48myAp/QFTb
         y1ig==
X-Forwarded-Encrypted: i=1; AHgh+RrxN7UBLJt08CGJX90gGiP6/zvO/meKkY8zbyGqm1S/WEH/loEuBRnmvkVRF7sfdeE4m8Gl88CCxqWY@vger.kernel.org
X-Gm-Message-State: AOJu0YygX4t9LtSnhfHtLvcJSwjTDN3NBqK7GTnP9jqI61/8Rc2tJxuS
	m9krfhVB+7JPPWvDGylc6Eb9WxJMsOP2boFiuICOjaRo0fnm1QG+IsFqYs+yzEHr7kylhX2a8eu
	p1FJfvhfZ6Ze0IAi3YqdngDwqkTw245pKxL1V2vag09WuKPabAut4YZzrs8SjIHLz
X-Gm-Gg: AR+sD13JU8pBqHHRB61sjC5HR7pNN3qxVSG66EomrCQzo/SjeI/PpZ2//kVGUmONJwH
	HQ3eod1WJ5UXqkx1i/bgx6QP+1lWuBC4aUuNB6T0X+PlLX9HbAHrNeVFB0NzQNs9CC6yj4monMc
	IglpExXb+ELwCn7Q0c2+wzHQ42CUDMGWC9JJ/RngHnGcYFSzkUwITASUUZYe4gNZ6sQGqmu+fx+
	lbvAzq8NmLCEEiTA2W3obUZ3FIj1sUZpelfZxLA8puJ7xXGIcOjUgpnmKPGkOg7qrWJjVSPTjli
	0F5Pb3Z2pX++vMf9/i0C1vRUqnD7Z2mk8X1KJEzTxl6CwVz477xpg5Aj86Nx3Tq7qNdPkfexdNW
	c9NXMZ9oTqBjiacCCmTHshA2z55uDj03g
X-Received: by 2002:a05:6a21:60c8:b0:3c3:7762:5d5f with SMTP id adf61e73a8af0-3c8addec942mr8580106637.19.1785341641452;
        Wed, 29 Jul 2026 09:14:01 -0700 (PDT)
X-Received: by 2002:a05:6a21:60c8:b0:3c3:7762:5d5f with SMTP id adf61e73a8af0-3c8addec942mr8580067637.19.1785341640954;
        Wed, 29 Jul 2026 09:14:00 -0700 (PDT)
Received: from [192.168.1.106] ([106.51.199.55])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504cc64c2sm11928425eec.19.2026.07.29.09.13.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 09:14:00 -0700 (PDT)
Message-ID: <c74c2a72-a343-45b8-b77b-61e0efafe345@oss.qualcomm.com>
Date: Wed, 29 Jul 2026 21:43:52 +0530
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/10] arm_mpam: add MPAM-Fb MSC firmware access
 support
To: Andre Przywara <andre.przywara@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Hanjun Guo
 <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        James Morse <james.morse@arm.com>, Ben Horgan <ben.horgan@arm.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghuay@nvidia.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Ganapatrao Kulkarni <ganapatrao.kulkarni@oss.qualcomm.com>,
        Trilok Soni <tsoni@quicinc.com>,
        Srinivas Ramana <sramana@qti.qualcomm.com>,
        Niyas Sait <niyas.sait@arm.com>, Lee Trager <lee@trager.us>,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20260729134124.2506269-1-andre.przywara@arm.com>
 <20260729134124.2506269-9-andre.przywara@arm.com>
Content-Language: en-US
From: Srivathsa L Rao <srivathsa.rao@oss.qualcomm.com>
In-Reply-To: <20260729134124.2506269-9-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Wfc8rUhX c=1 sm=1 tr=0 ts=6a6a26ca cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=PO1FP6gy+OYP9C5qPHjZag==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=7CQSdrXTAAAA:8 a=ehkn1hlfaFW1UOOq6FcA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: i_3h7nARzYvda7wJH4tKRZ5ikSQHLdwC
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEyNyBTYWx0ZWRfX/AbddB8zqkP0
 uWW8tfDKa8TSQlS/l7wYwdrjnIY8dv5rAHl7ClgfR17AY7JYT87FLm8S5+ytxzPGF1vp1xK9CEE
 YmWEdUk/uQ76/yvMKM73LLARHNNyS+c=
X-Proofpoint-ORIG-GUID: i_3h7nARzYvda7wJH4tKRZ5ikSQHLdwC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEyNyBTYWx0ZWRfX8JpghLDVN2N1
 zLxeslWW5FNrbs1DBeTjJ1CxBWL7LAFxG/mrHW4MNVQxFG91ir6nuTiaMfVoMiEJ0BgtPjxDWCv
 PL8kJY9hepbYWA4JWtDZz2yByOvYEyf58Y/waLva42OEzsgbrcXFR4LvpZaKc97+bx80miCQSCc
 1KSDyKjPSXpcZ/cRLOPInL/NpFgDbZRuJjeeUG0/1WMBu08s6miKYGqC9KEQR0dsl3PFnGFIP1q
 ajePxOdgVKmuN/cuKFuv+PjF2jqVfo+qOG4/2SGQGxSNYmt59V/nVvBYZVnTZyiJlWIoM6B+mBq
 QaHwK/niV+e9B225KyKLDmfMMaU4ncorY93mj9Cy/iQ22GIljo2XAvCTq1KpgMsCRM8teKVbDSu
 st8bESwb+HPMGaUm9v9sjaUrG0oWhilAvBR6MdBb2t3q9E8U2BqH6HcIU+jgqvQx1DrDR3Q//yj
 akJn2tYIs2LLU1tHUZA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_06,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 adultscore=0 clxscore=1015
 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290127

Hi Andre,

On 7/29/2026 7:11 PM, Andre Przywara wrote:
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
> ---
>   drivers/resctrl/Makefile        |   2 +-
>   drivers/resctrl/mpam_devices.c  |  52 ++++++--
>   drivers/resctrl/mpam_fb.c       | 214 ++++++++++++++++++++++++++++++++
>   drivers/resctrl/mpam_internal.h |  22 ++++
>   include/linux/arm_mpam.h        |   2 +-
>   5 files changed, 279 insertions(+), 13 deletions(-)
>   create mode 100644 drivers/resctrl/mpam_fb.c
> 
> diff --git a/drivers/resctrl/Makefile b/drivers/resctrl/Makefile
> index 4f6d0e81f9b8..097c036724e9 100644
> --- a/drivers/resctrl/Makefile
> +++ b/drivers/resctrl/Makefile
> @@ -1,5 +1,5 @@
>   obj-$(CONFIG_ARM64_MPAM_DRIVER)			+= mpam.o
> -mpam-y						+= mpam_devices.o
> +mpam-y						+= mpam_devices.o mpam_fb.o
>   mpam-$(CONFIG_ARM64_MPAM_RESCTRL_FS)		+= mpam_resctrl.o
>   
>   ccflags-$(CONFIG_ARM64_MPAM_DRIVER_DEBUG)	+= -DDEBUG
> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> index f6910ab3bbc2..abe1e628928f 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c
> @@ -83,6 +83,16 @@ static DECLARE_WORK(mpam_broken_work, &mpam_disable);
>   /* When mpam is disabled, the printed reason to aid debugging */
>   static char *mpam_disable_reason;
>   
> +void mpam_fb_disable_mpam(int err)
> +{
> +	static char mpam_fb_reason[32];
> +
> +	snprintf(mpam_fb_reason, sizeof(mpam_fb_reason), "MPAM-Fb error %d",
> +		 err);
> +	mpam_disable_reason = mpam_fb_reason;
> +	schedule_work(&mpam_broken_work);
> +}
> +
>   /*
>    * Whether resctrl has been setup. Used by cpuhp in preference to
>    * mpam_is_enabled(). The disable call after an error interrupt makes
> @@ -179,8 +189,11 @@ static void mpam_assert_partid_sizes_fixed(void)
>   
>   static int __mpam_read_reg(struct mpam_msc *msc, u16 reg, u32 *res)
>   {
> -	WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(), &msc->accessibility));
>   
> +	if (msc->iface == MPAM_IFACE_PCC)
> +		return mpam_fb_send_read_request(msc, reg, res);
> +
> +	WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(), &msc->accessibility));
>   	*res = readl_relaxed(msc->mapped_hwpage + reg);
>   
>   	return 0;
> @@ -197,9 +210,12 @@ static inline int _mpam_read_partsel_reg(struct mpam_msc *msc, u16 reg,
>   
>   static int __mpam_write_reg(struct mpam_msc *msc, u16 reg, u32 val)
>   {
> -	WARN_ON_ONCE(reg + sizeof(u32) > msc->mapped_hwpage_sz);
> -	WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(), &msc->accessibility));
>   
> +	if (msc->iface == MPAM_IFACE_PCC)
> +		return mpam_fb_send_write_request(msc, reg, val);
> +
> +	WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(), &msc->accessibility));
> +	WARN_ON_ONCE(reg + sizeof(u32) > msc->mapped_hwpage_sz);
>   	writel_relaxed(val, msc->mapped_hwpage + reg);
>   
>   	return 0;
> @@ -1141,8 +1157,11 @@ static int mpam_msc_read_mbwu_l(struct mpam_msc *msc, u64 *res)
>   
>   	mpam_mon_sel_lock_held(msc);
>   
> -	WARN_ON_ONCE((MSMON_MBWU_L + sizeof(u64)) > msc->mapped_hwpage_sz);
> -	WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(), &msc->accessibility));
> +	if (msc->iface == MPAM_IFACE_MMIO) {
> +		WARN_ON_ONCE((MSMON_MBWU_L + sizeof(u64)) > msc->mapped_hwpage_sz);
> +		WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(),
> +			     &msc->accessibility));
> +	}
>   
>   	ret = __mpam_read_reg(msc, MSMON_MBWU_L + 4, &mbwu_l_high2);
>   	if (ret)
> @@ -1176,8 +1195,11 @@ static int mpam_msc_zero_mbwu_l(struct mpam_msc *msc)
>   
>   	mpam_mon_sel_lock_held(msc);
>   
> -	WARN_ON_ONCE((MSMON_MBWU_L + sizeof(u64)) > msc->mapped_hwpage_sz);
> -	WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(), &msc->accessibility));
> +	if (msc->iface == MPAM_IFACE_MMIO) {
> +		WARN_ON_ONCE((MSMON_MBWU_L + sizeof(u64)) > msc->mapped_hwpage_sz);
> +		WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(),
> +			     &msc->accessibility));
> +	}
>   
>   	ret = __mpam_write_reg(msc, MSMON_MBWU_L, 0);
>   	if (ret)
> @@ -1490,11 +1512,16 @@ static int _msmon_read(struct mpam_component *comp, struct mon_read *arg)
>   					 srcu_read_lock_held(&mpam_srcu)) {
>   			arg->ris = ris;
>   
> -			err = smp_call_function_any(&msc->accessibility,
> -						    __ris_msmon_read, arg,
> -						    true);
> -			if (!err && arg->err)
> +			if (msc->iface == MPAM_IFACE_MMIO) {
> +				err = smp_call_function_any(&msc->accessibility,
> +							    __ris_msmon_read,
> +							    arg, true);
> +				if (!err)
> +					err = arg->err;
> +			} else {
> +				__ris_msmon_read(arg);
>   				err = arg->err;
> +			}
>   
>   			/*
>   			 * Save one error to be returned to the caller, but
> @@ -1921,6 +1948,9 @@ static int mpam_get_msc_preferred_cpu(struct mpam_msc *msc)
>   
>   static int mpam_touch_msc(struct mpam_msc *msc, int (*fn)(void *a), void *arg)
>   {
> +	if (msc->iface != MPAM_IFACE_MMIO)
> +		return fn(arg);
> +
>   	lockdep_assert_irqs_enabled();
>   	lockdep_assert_cpus_held();
>   	WARN_ON_ONCE(!srcu_read_lock_held((&mpam_srcu)));
> diff --git a/drivers/resctrl/mpam_fb.c b/drivers/resctrl/mpam_fb.c
> new file mode 100644
> index 000000000000..dbe984241b0d
> --- /dev/null
> +++ b/drivers/resctrl/mpam_fb.c
> @@ -0,0 +1,214 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2024-2026 Arm Ltd.
> +
> +#include <linux/arm_mpam.h>
> +#include <linux/cleanup.h>
> +#include <linux/errno.h>
> +#include <linux/mailbox_client.h>
> +#include <linux/mutex.h>
> +#include <linux/types.h>
> +
> +#include <acpi/pcc.h>
> +#include <asm/mpam.h>
> +
> +#include "mpam_internal.h"
> +
> +#define MPAM_FB_PROTOCOL_ID		0x1a
> +
> +#define MPAM_PROTOCOL_VERSION_CMD	0x0
> +#define MPAM_MSC_ATTRIBUTES_CMD		0x3
> +#define MPAM_MSC_READ_CMD		0x4
> +#define MPAM_MSC_WRITE_CMD		0x5
> +
> +#define MPAM_FB_ERR_SUCCESS		 0
> +#define MPAM_FB_ERR_NOT_SUPPORTED	-1
> +#define MPAM_FB_ERR_INVALID_PARAMETERS	-2
> +#define MPAM_FB_ERR_DENIED		-3
> +#define MPAM_FB_ERR_NOT_FOUND		-4
> +#define MPAM_FB_ERR_OUT_OF_RANGE	-5
> +#define MPAM_FB_ERR_BUSY		-6
> +#define MPAM_FB_ERR_COMMS_ERROR		-7
> +#define MPAM_FB_ERR_GENERIC_ERROR	-8
> +#define MPAM_FB_ERR_HW_ERROR		-9
> +#define MPAM_FB_ERR_PROTOCOL_ERROR	-10
> +#define MPAM_FB_ERR_IN_USE		-11
> +
> +#define MPAM_MSC_PROT_ID_MASK	GENMASK(17, 10)
> +#define MPAM_MSC_TOKEN_MASK	GENMASK(27, 18)
> +
> +static atomic_t mpam_fb_token = ATOMIC_INIT(0);
> +
> +static void mpam_fb_build_version_message(unsigned int token,
> +					  void __iomem *msg_buf)
> +{
> +	struct acpi_pcct_ext_pcc_shared_memory __iomem *pcc_shmem = msg_buf;
> +
> +	/* .signature is filled by the platform */
> +	writel_relaxed(PCC_CMD_COMPLETION_NOTIFY, &pcc_shmem->flags);
> +	writel_relaxed(MPAM_FB_PROT_HEADER_LEN, &pcc_shmem->length);
> +	writel_relaxed(MPAM_PROTOCOL_VERSION_CMD |
> +		       FIELD_PREP(MPAM_MSC_TOKEN_MASK, token) |
> +		       FIELD_PREP(MPAM_MSC_PROT_ID_MASK, MPAM_FB_PROTOCOL_ID),
> +		       &pcc_shmem->command);
> +}
> +
> +static void mpam_fb_build_read_message(int msc_id, int reg, unsigned int token,
> +				       void __iomem *msg_buf)
> +{
> +	struct acpi_pcct_ext_pcc_shared_memory __iomem *pcc_shmem = msg_buf;
> +	struct mpam_fb_read_payload {
> +		u32 msc_id;
> +		u32 flags;
> +		u32 reg_offset;
> +	} __packed __iomem *payload = msg_buf + sizeof(*pcc_shmem);
> +	int msg_size = MPAM_FB_PROT_HEADER_LEN + sizeof(*payload);
> +
> +	/* .signature is filled by the platform */
> +	writel_relaxed(PCC_CMD_COMPLETION_NOTIFY, &pcc_shmem->flags);
> +	writel_relaxed(msg_size, &pcc_shmem->length);
> +	writel_relaxed(MPAM_MSC_READ_CMD |
> +		       FIELD_PREP(MPAM_MSC_TOKEN_MASK, token) |
> +		       FIELD_PREP(MPAM_MSC_PROT_ID_MASK, MPAM_FB_PROTOCOL_ID),
> +		       &pcc_shmem->command);
> +
> +	writel_relaxed(msc_id, &payload->msc_id);
> +	writel_relaxed(0, &payload->flags);
> +	writel_relaxed(reg, &payload->reg_offset);
> +}
> +
> +static void mpam_fb_build_write_message(int msc_id, int reg, u32 val,
> +					unsigned int token,
> +					void __iomem *msg_buf)
> +{
> +	struct acpi_pcct_ext_pcc_shared_memory __iomem *pcc_shmem = msg_buf;
> +	struct mpam_fb_write_payload {
> +		u32 msc_id;
> +		u32 flags;
> +		u32 reg_offset;
> +		u32 value;
> +	} __packed __iomem *payload = msg_buf + sizeof(*pcc_shmem);
> +	int msg_size = MPAM_FB_PROT_HEADER_LEN + sizeof(*payload);
> +
> +	/* .signature is filled by the platform */
> +	writel_relaxed(PCC_CMD_COMPLETION_NOTIFY, &pcc_shmem->flags);
> +	writel_relaxed(msg_size, &pcc_shmem->length);
> +	writel_relaxed(MPAM_MSC_WRITE_CMD |
> +		       FIELD_PREP(MPAM_MSC_TOKEN_MASK, token) |
> +		       FIELD_PREP(MPAM_MSC_PROT_ID_MASK, MPAM_FB_PROTOCOL_ID),
> +		       &pcc_shmem->command);
> +
> +	writel_relaxed(msc_id, &payload->msc_id);
> +	writel_relaxed(0, &payload->flags);
> +	writel_relaxed(reg, &payload->reg_offset);
> +	writel_relaxed(val, &payload->value);
> +}
> +
> +static int mpam_fb_send_request(struct mpam_pcc_chan *pcc_chan, u32 msc_id,
> +				u16 reg, u32 *result, int mpam_fb_command)
> +{
> +	unsigned int token = atomic_inc_return(&mpam_fb_token);
> +	struct acpi_pcct_ext_pcc_shared_memory __iomem *pcc_shmem;
> +	struct pcc_mbox_chan *chan;
> +	void __iomem *payload_ofs;
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
> +	guard(mutex)(&pcc_chan->pcc_chan_lock);
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
> +		goto out_err;
> +	}
> +
> +	ret = readl(payload_ofs + 0x0);
> +	if (ret < 0) {
> +		switch (ret) {
> +		case MPAM_FB_ERR_NOT_SUPPORTED:
> +			ret = -EOPNOTSUPP;
> +			break;
> +		case MPAM_FB_ERR_INVALID_PARAMETERS:
> +			ret = -EINVAL;
> +			break;
> +		case MPAM_FB_ERR_NOT_FOUND:
> +			ret = -ENOENT;
> +			break;
> +		case MPAM_FB_ERR_OUT_OF_RANGE:
> +			ret = -ERANGE;
> +			break;

While testing v4 on a QEMU setup with a fake PCC-backed MSC, I added a
small error injection mechanism to verify the firmware response status
code translations in mpam_fb_send_request(). I injected each defined
MPAM_FB_ERR_* code and observed the following.

> +		default:
> +			ret = -EINVAL;
> +		}
> +
> +		goto out_err;
> +	}

MPAM_FB_ERR_BUSY (-6) falls through to this default and gets -EINVAL.
Would -EAGAIN be more appropriate here?  Callers could then maybe add a 
short retry loop inside mpam_fb_send_request() itself, or in the probe 
path, convert -EAGAIN to -EPROBE_DEFER so the driver core retries probe 
automatically.

The other unhandled codes also collapse to -EINVAL, like EPROTO, EBUSY, 
I guess that can come later.

> +
> +	if (mpam_fb_command != MPAM_MSC_WRITE_CMD)
> +		*result = readl(payload_ofs + 0x4);
> +
> +	return 0;
> +
> +out_err:
> +	mpam_fb_disable_mpam(ret);
> +
> +	return ret;
> +}
> +
> +int mpam_fb_send_read_request(struct mpam_msc *msc, u16 reg, u32 *result)
> +{
> +	return mpam_fb_send_request(msc->pcc_chan, msc->mpam_fb_msc_id,
> +				    reg, result, MPAM_MSC_READ_CMD);
> +}
> +
> +int mpam_fb_send_write_request(struct mpam_msc *msc, u16 reg, u32 value)
> +{
> +	return mpam_fb_send_request(msc->pcc_chan, msc->mpam_fb_msc_id,
> +				    reg, &value, MPAM_MSC_WRITE_CMD);
> +}
> +
> +int mpam_fb_get_protocol_version(struct mpam_msc *msc)
> +{
> +	u32 version;
> +	int ret;
> +
> +	ret = mpam_fb_send_request(msc->pcc_chan, 0,
> +				   0, &version, MPAM_PROTOCOL_VERSION_CMD);
> +	if (ret)
> +		return ret;
> +
> +	return version;
> +}
> diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
> index 2b81b6b0bf4e..a2193e7df57c 100644
> --- a/drivers/resctrl/mpam_internal.h
> +++ b/drivers/resctrl/mpam_internal.h
> @@ -11,6 +11,7 @@
>   #include <linux/io.h>
>   #include <linux/jump_label.h>
>   #include <linux/llist.h>
> +#include <linux/mailbox_client.h>
>   #include <linux/mutex.h>
>   #include <linux/resctrl.h>
>   #include <linux/spinlock.h>
> @@ -57,6 +58,15 @@ struct mpam_garbage {
>   	struct platform_device	*pdev;
>   };
>   
> +struct mpam_pcc_chan {
> +	struct list_head	pcc_chans;
> +	struct mbox_client	pcc_cl;
> +	struct pcc_mbox_chan	*pcc_chan;
> +	struct mutex		pcc_chan_lock; /* only one message at a time */
> +	struct kref		refcount;
> +	int			subspace_id;
> +};
> +
>   struct mpam_msc {
>   	/* member of mpam_all_msc */
>   	struct list_head	all_msc_list;
> @@ -66,6 +76,8 @@ struct mpam_msc {
>   
>   	/* Not modified after mpam_is_enabled() becomes true */
>   	enum mpam_msc_iface	iface;
> +	struct mpam_pcc_chan	*pcc_chan;
> +	int			mpam_fb_msc_id;	/* in its own name space */
>   	u32			nrdy_usec;
>   	cpumask_t		accessibility;
>   	bool			has_extd_esr;
> @@ -484,6 +496,9 @@ extern u8 mpam_pmg_max;
>   void mpam_enable(struct work_struct *work);
>   void mpam_disable(struct work_struct *work);
>   
> +/* helper function to call from outside mpam_devices.c */
> +void mpam_fb_disable_mpam(int err);
> +
>   /* Reset all the RIS in a class under cpus_read_lock() */
>   void mpam_reset_class_locked(struct mpam_class *class);
>   
> @@ -511,6 +526,13 @@ static inline void mpam_resctrl_offline_cpu(unsigned int cpu) { }
>   static inline void mpam_resctrl_teardown_class(struct mpam_class *class) { }
>   #endif /* CONFIG_RESCTRL_FS */
>   
> +/* MPAM-Fb Firmware-backed protocol wrappers */
> +int mpam_fb_send_read_request(struct mpam_msc *msc, u16 reg, u32 *result);
> +int mpam_fb_send_write_request(struct mpam_msc *msc, u16 reg, u32 value);
> +int mpam_fb_get_protocol_version(struct mpam_msc *msc);
> +
> +#define MPAM_FB_PROT_HEADER_LEN		sizeof(u32)
> +
>   /*
>    * MPAM MSCs have the following register layout. See:
>    * Arm Memory System Resource Partitioning and Monitoring (MPAM) System
> diff --git a/include/linux/arm_mpam.h b/include/linux/arm_mpam.h
> index f92a36187a52..002f56e15362 100644
> --- a/include/linux/arm_mpam.h
> +++ b/include/linux/arm_mpam.h
> @@ -12,7 +12,7 @@ struct mpam_msc;
>   
>   enum mpam_msc_iface {
>   	MPAM_IFACE_MMIO,	/* a real MPAM MSC */
> -	MPAM_IFACE_PCC,		/* a fake MPAM MSC */
> +	MPAM_IFACE_PCC,		/* using the MPAM-Fb firmware redirection */
>   };
>   
>   enum mpam_class_types {

Best Regards,
Srivathsa
