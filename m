Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19123CC7DB
	for <linux-acpi@vger.kernel.org>; Tue,  4 Aug 2026 05:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785823066; cv=none; b=i7WDrp4J0L81dV6AOsKyUPfafVk9XCoHogqDsuLjEVB7W6U1yIxn6E4RA9z+dLE0aZZ7lpwjkdxpXfygHy7ipilNWMA7sRZOoBUG4AqCwrInwmZGv7/s9we4H8AREzYo1l4oOLxx+h54wxeW/QezAxzyJiNS7N4HjKVrpWfK0vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785823066; c=relaxed/simple;
	bh=m0NsdDce54ol1izYWh/1KQyK0pQRXZRwfpts3RT5AHU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vb8g5ZNVfwf4thJZ1WND1gGefbSOyXVl5aF03OseZpZQESuZcGItIdhE88IbUWo2ZlYQSGmViUiXokYp1zvcoz+Acyfdz8Ilo0Rz8MYI3SCDYNxz6yeIBuZzBw/SAy6T0OG9884Au2bViVTwlOy39ywAQmuAZtxMmjPglT+QyYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IXPhU9ET; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=O5FwVT1X; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IXPhU9ET";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="O5FwVT1X"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6741752n2818168
	for <linux-acpi@vger.kernel.org>; Tue, 4 Aug 2026 05:57:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	q8Zu/1UwTQMaSAqsyU+Lu1vFa2zKo9mX+0Gf5nDY3uU=; b=IXPhU9ETEQEb9g9X
	cHMrF90DQPcHxBQvgVxTybBIQ4uIEht2F80DnPb7z1FN9fHDuy4ZuRUhDkXS4BVZ
	AIQcyur7SXQrmbmc3BSfYoRpiQtjl4D+bWRzRrqvBK9biw9fGuGixW/v5Cv/QHTv
	zDmumJTxJVCVmnbgt5UZ4c9AoawVHIZTXYYpgv6BqHma0bsvKwjWU1Mbxuy0BwLr
	Cwtmcfcfi5HJDfXGkGGjX9zP/pb4xgSeJvV5Da8D/E4eayE/AU0XtEI69KYon2Cy
	h/r2I+FgiKw/kt8xkcpIFEqsO8jyT/nOtgbJ5Pl9yM0cQDy2eQySV7bTrAR1jfrS
	wDPVDA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fu1p4sy2v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Tue, 04 Aug 2026 05:57:43 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c85798977dcso7106087a12.0
        for <linux-acpi@vger.kernel.org>; Mon, 03 Aug 2026 22:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785823063; x=1786427863; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q8Zu/1UwTQMaSAqsyU+Lu1vFa2zKo9mX+0Gf5nDY3uU=;
        b=O5FwVT1XS9XklipQth/lAu5tmenUQvlHP1efQTyBmFkItWXuAJB2JC6WRR+MRNo3G5
         N8mnhf+YZjKuoswk5/QcgbavJAGD60tbpUyB0ed+99fqoWn1oUg/sdIK9cW7rWL31RID
         YU5N+1XdtmaDAOz2StYWGAltoqVGX5JYa9YZwsWUrYM6ibzBlRwuNR+f6SbNSY5+dCuM
         FXcCfMudJbtukRZw+yEHYGVagyg79VGbEXjNwl+JTNXgaRUZVMSm+DxwEbi484rbijVR
         3hXzBDpeRtLOW4VSIKg4hfgRFxEfK9BA8PG8RgGhn8+PnP2ph1AkhvpMXKh71hjzh3tD
         odZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785823063; x=1786427863;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q8Zu/1UwTQMaSAqsyU+Lu1vFa2zKo9mX+0Gf5nDY3uU=;
        b=YimpIhxL9g1u75pzXjNqzUdL+an2SDC+KXnzY0VNEkVUDiwXXBiTqWGOKu2p868oy7
         7forF+0DYlSCBI/DNVuq+Ndtb4GbpkEHMBRlVFD309FGDIjoMg8U0hJIv6jcQzSEcb6D
         NL+vBMIGVuNvXy5qWXqygl86nOCGOJsN77qal6ZIvxZSpz0daHQBBczjZbCdYERGh0N6
         /Q5vOF2ila2vEcwfc6jTyRqxOuvgh3EBA/hFU4BKRQLEjtw3SvllMo2ATp7gae722iAQ
         y9s4AZf3RFHcib93cwl4DKrSOg58O9yiBNaGO6V5Mm3JDkTnrE9wOSroCvIQ1OXq9sNo
         gs/Q==
X-Forwarded-Encrypted: i=1; AHgh+RrGRWBiMyjhpcobhRhHm5nsNUDIiB+p9oF7f76aDuOoalXaSFSWj4q+X9qo1BTkVUywUv3GrujI/EuW@vger.kernel.org
X-Gm-Message-State: AOJu0YwG7tJjVVTOMsVq2TOlhzWSwEdLNS51zr++wMYzCblUHX7R5xyo
	ulKIa7/w1aE6s2wX3PxhNEX33EW5/Itg+MsVa27XGxyFKAVK3C1eP9vSc2rJfO9c5Mu1vMkYUNo
	vZIaNNXNBpxaClGMYftJDgKimaY39oS+21miSjZaNElBdWRlt6JXhNv09EEpykk+t
X-Gm-Gg: AR+sD12w/7jXWJMjNMYfK3fdVO2Tlfxnx0+8bxCdMEo6uTKIu3pktXjxLGtVmx6mzr0
	02eaTyIYdJSe2xX1WjAKINeSmk9sHxRnonxX1zMLz/XfJ/5UhZawT2xQo7X4anBAx7joSHepqYB
	SZ0F4QLKeGKmHtXMTHLkksyYwE0BBf4RQW1kQfGM2M7GCkhf73+EUyvd2Yx2Vjma0/0PqawRKik
	yTTOqlwjJnOKNScUixlIKh9MWaf0ROQdwQosBC1r6or2b/koC5qlNgtTxVhS6gZkzR73MhpfvNS
	w6FKaftXcVWKgsZctbtTUwxgg8HMAX+l7OKjgpxDTIRRWaAoYsge4xICox+Tqhf62fOsCaqHMRZ
	HCp6KSEDaltxRWj0odiN9oGFFRG208VPf
X-Received: by 2002:a05:6a00:4fca:b0:84c:4bf4:10c3 with SMTP id d2e1a72fcca58-84ee490ac3bmr10830767b3a.38.1785823063170;
        Mon, 03 Aug 2026 22:57:43 -0700 (PDT)
X-Received: by 2002:a05:6a00:4fca:b0:84c:4bf4:10c3 with SMTP id d2e1a72fcca58-84ee490ac3bmr10830735b3a.38.1785823062703;
        Mon, 03 Aug 2026 22:57:42 -0700 (PDT)
Received: from [192.168.1.106] ([106.51.192.47])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edc29ebbcsm4598548b3a.34.2026.08.03.22.57.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2026 22:57:42 -0700 (PDT)
Message-ID: <836c6c2b-6ab0-4dba-9964-aa65ddcb7381@oss.qualcomm.com>
Date: Tue, 4 Aug 2026 11:27:34 +0530
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 07/11] arm_mpam: propagate MSC access errors for
 mpam_reprogram_ris_partid()
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
        Ritwick Sharma <ritwick.sharma@arm.com>, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260731170324.2927758-1-andre.przywara@arm.com>
 <20260731170324.2927758-8-andre.przywara@arm.com>
Content-Language: en-US
From: Srivathsa L Rao <srivathsa.rao@oss.qualcomm.com>
In-Reply-To: <20260731170324.2927758-8-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=auOCzyZV c=1 sm=1 tr=0 ts=6a717f57 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ugN4vXIPUBCZxoiA0ovN8A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=7CQSdrXTAAAA:8 a=PF9lGtfeLRIEAocP7poA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: gQc5c1wnY31g4lGBHHJWVPPtUnfDGRID
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA0NSBTYWx0ZWRfXzkFVEHmFI1+G
 If36LKECSb2CkYDnKxJguLWODoPo75Bbr7SZo4dWk1QrB/4YgWr6LYsPUc367gqa/7/HWqoohE8
 +grHgejnM3LxIZzUSX7sGyZ0sAp4zio=
X-Proofpoint-GUID: gQc5c1wnY31g4lGBHHJWVPPtUnfDGRID
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA0NSBTYWx0ZWRfX/Dsl2eZOUHNx
 uTc4ZVj8Spiax3AvC97LrVWMXfUBTYCjSRF+R9LXUkmDbVivGK7cLWieVaiLyV93vGcOk4re7j9
 A5HBJa9TJOeg6niOeaST0BW0X2XupNaCpTnURoJoq7pINVoVvacyvhvUWpN+idGPNdc0VJ59Si2
 CoUfl0Lt5uZ4IkuHxm4inP81iLvc4HLLE8Lz8g02SDClDlQLcRN8ClGy5lUb//Zy6uX3z7K8lFQ
 5FopTLpy6ZE1/CdNd9r1U1wZTlaAR2YsTpd8kKKnIlx4SnYYJi9DHlUXeZbcgeFEiZXl1vwpo64
 85zQiTZ08RMANgQY8tT6Gv1fC2o82FYmTaLdjy8VZClWd6CPS1GeebZdwuEQTkaZ7SQuNgoDFl9
 +fMELLKsiS/1GcLDs807Vs5o02t2K2LKOEOXQ5EEzgYHvSTohuTOgHk65esPLtNQw//Wa+x0YI2
 Y6Ae47FaGVzUJTWz2HQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_01,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040045

Hi Andre,

mpam_reprogram_ris_partid() writes hardware registers sequentially.
If a write fails midway (possible on PCC MSCs via SCMI), the earlier
writes are already committed and the hardware is left in a partially
configured state.
Currently this is safe only because mpam_fb_disable_mpam() tears
everything down on any firmware error. If that behavior is ever
relaxed (e.g. for transient BUSY handling), a partial state could
persist and produce weird behavior?

I wanted to point this as a design note.


On 7/31/2026 10:33 PM, Andre Przywara wrote:
> Allow the mpam_reprogram_ris_partid() function check for and return
> errors, and propagate MSC read and write errors from the lower level up.
> This also covers the callers of this function: mpam_reset_ris() and
> apply_config().
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>   drivers/resctrl/mpam_devices.c | 136 ++++++++++++++++++++++-----------
>   1 file changed, 93 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> index 38450c55e45e..32088ad1d67e 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c
> @@ -1601,7 +1601,7 @@ void mpam_msmon_reset_mbwu(struct mpam_component *comp, struct mon_cfg *ctx)
>   	}
>   }
>   ...

> +static int mpam_reprogram_ris_partid(struct mpam_msc_ris *ris, u16 partid,
> +				     struct mpam_config *cfg)
>   {
>   	u32 pri_val = 0;
>   	..
> -	mutex_unlock(&msc->part_sel_lock);
> +	return 0;
>   }
>   
--

Best Regards,
Srivathsa
