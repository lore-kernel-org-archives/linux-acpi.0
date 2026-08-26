Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975D146A61C
	for <linux-acpi@vger.kernel.org>; Wed, 26 Aug 2026 17:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787766116; cv=none; b=iXGWcdLeo4zTlPER8SNf8eyZe714IlPrWyKkUnZ78cqpg+ERkXwDHhMTjcLkN9HzHp0MBoK1EGqMuQbP5e4vSW2V6A1Cye2nM/ZbJ959Aqxhz/5cgVAtJ24P83KsvKdwFddHGo+nuDJYjl5oIojFJj9vGF5SJrqgdOdor4ffIpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787766116; c=relaxed/simple;
	bh=lHCecGy1VB92c25R/o9DvKOH8VGvWZdaFyb4X9KC3lg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ca0TCWQkZov/MHXXGsxmioZOvINPyGr3wIbNK4S5QxEQGJO0ygmxXEkv99cefLHsr1CY2HmMPCQ7oyxDT9cvzhNtEjv0Yvi4Sd4VY4OhG820QYyZJtqXUxH2OBS+OFhHoUAI2wqZmYVyO7mVLM5pZgzmD69TNkOmSX03/VKEPZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X1ZJBQEI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SmSE7E/u; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="X1ZJBQEI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SmSE7E/u"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67QGukma343366
	for <linux-acpi@vger.kernel.org>; Wed, 26 Aug 2026 17:41:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DNs1y/XC3g0OnCiOoRpL2o87x4tEc7z7kiM7MFcFVrw=; b=X1ZJBQEI4m7075Qf
	RMJ9LsQNmoixFMkQeZXtBnHrVA6gkwQVkf+E9WO6BD8GhEeurHYQn05SEytvXNE9
	rnJw9zzSbCqyrFhMD5liUDwFi8h53vuc9knw2VByDe8GM1OCNDTJLjGMo8irFhZI
	4xwAMUHQeGHH75vWCdAb+54EJjMY39szLIODzPZiDZ3HLjpL1+Bk/YdchE6rdP+H
	EHhuPETBGl+ULvKdnXyXlOfWfeZaJIFPj39ohnk8wC1E7kDWPhNY5sEzK2vCSDuz
	jJ8DjURpQohW6eZnXkL2ren693FWHP3Iz6cF8dYUm6t2ehfhzHfnn+bIJmIsnhTy
	XIRNaQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9uthtbp3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Wed, 26 Aug 2026 17:41:45 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8535cdc2433so95806b3a.0
        for <linux-acpi@vger.kernel.org>; Wed, 26 Aug 2026 10:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787766104; x=1788370904; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DNs1y/XC3g0OnCiOoRpL2o87x4tEc7z7kiM7MFcFVrw=;
        b=SmSE7E/utRV56B+O14023JqK3EsE7WNm4ZA1ez9whN2GHXB3MdgB6wD06Q6WRIT4H7
         0SQUWVYVzB339y29V27mfm+VYA/5X8WXogJSbc+xQmPRUQUk0TTpzr87TWCwFdpZMsq/
         3pIfR8A2VMvJUNwocFL+SqGROdTFFJRX4fQBY8knC1TicPotmURuvksbq82kFP37WKk2
         qnd/Rl36jK8nxzJkqp1QoKRcmzV7WNgwb8SY896WQ+a+LpsDjxwZPryXGLe+J01zyp4G
         W/VCs2/svfrimVw9aRcUNpfXweLJ/KvCbOeUMScEaGbJgVhQ8dmvD/ihOtraYqVP5iek
         t0Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787766104; x=1788370904;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DNs1y/XC3g0OnCiOoRpL2o87x4tEc7z7kiM7MFcFVrw=;
        b=A/MSBhbxu536W3lV62aDJtP0LN8kzwgLWrVt7/wT3L2bcVsLhXno0f6AsYJjMOih1k
         vpt/QiK1zqFoGS1I2n/+RKJ97k9V8J7nUHAn6xxyMJC0PJNBPrhdsdGETLsVOzRgTj6Y
         338IAAAncJafFACDXj4UbHdA25U/CyCv9TA81Hk90ju/XflUIfzal8SSWelU7kufsemI
         YkqzzsqLmAe5cD+QqwA3RBEM/XZDqRWiXVkrQqvwppUZI0V0/I+jOIVSiNBXHPbfXFqc
         E87KaFa8zvktJ0QqA1tpPS5cyC+zeUwK6OlKucFOfPUeYBRToWLmFwme047DTISp8U84
         9POA==
X-Forwarded-Encrypted: i=1; AHgh+RrKn+Xqc5dK7Bm/aoNRQB9eLTgac17p++IZ8X2CK5zBca5s3jpYHdzwUR3RnltmCreYoVR2ITQdCZvQ@vger.kernel.org
X-Gm-Message-State: AFuF++mGupSg9N3Dgm54PRmO5bnU+jiaDNZCDCdal1lTx6yhMhGLMc5G
	rhJwJ+igpBj/t/Z8prKIiBdAeSb/FCK6zr/5UPFg2WZU3TOtWZQbCO9RJkKeCuuos1vwAzF6Ln3
	dtJTl5/H92XhvspDWDjP9KJNvZGBHuEhYyHvG8CTVg1jKXToLvRAr9pyH5FlbOjrt
X-Gm-Gg: AR+sD10ajPCxXLQFOUTOONXCmwGZHpvfDcUu+15WB4MKRtirBMCO1oeKURwtQNsmD1D
	rtqlsH7ZZ+bton0va43RLnRWiQRIOWmqJ5Q7ZyDfWyIV7dPqctB/7js/XqvnFqg5Bk//4MJXJVB
	uISQLsuNXbrvXC0v0LD77FI7YClGJwcMo4u7/i21pe4ETwM8z8+Pxsc/PCAL8Wftg5TirfX8vBk
	9Wos6LjcXK+SUlRIRHn4hSrz25Ev3p6TjgnXIsrDRKzQn/63uezyAxtyL+/BxpKDlNmcWiys12y
	gq4xabctzrIsy7r9guKxOb8zwC20ZZwVlnEnd8hUCmV0ZDq10+fvu/CpuB7cdUZ6G4sLsR3Xtbl
	BveI8p+fZI1UjxUkQcCLRhOpOzDJwXqxINXLoEVF7Fff0lz/oBa3Xt2LctW7QMVsRvbsedZ/69K
	gIl2sLWkiDi/7s4ET/mg==
X-Received: by 2002:a05:6a00:2d0b:b0:851:80de:db56 with SMTP id d2e1a72fcca58-854c892307bmr887200b3a.13.1787766104003;
        Wed, 26 Aug 2026 10:41:44 -0700 (PDT)
X-Received: by 2002:a05:6a00:2d0b:b0:851:80de:db56 with SMTP id d2e1a72fcca58-854c892307bmr887137b3a.13.1787766103429;
        Wed, 26 Aug 2026 10:41:43 -0700 (PDT)
Received: from [10.50.45.102] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8535d345ecesm1230693b3a.59.2026.08.26.10.41.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2026 10:41:42 -0700 (PDT)
Message-ID: <39fbb239-ea0d-4168-bb20-07bfa10bc539@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 23:11:34 +0530
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 07/12] arm_mpam: propagate MSC access errors for
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
        Ritwick Sharma <ritwick.sharma@arm.com>, Gavin Shan <gshan@redhat.com>,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20260807105451.3728284-1-andre.przywara@arm.com>
 <20260807105451.3728284-8-andre.przywara@arm.com>
Content-Language: en-US
From: Srivathsa L Rao <srivathsa.rao@oss.qualcomm.com>
In-Reply-To: <20260807105451.3728284-8-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=EMA2FVZC c=1 sm=1 tr=0 ts=6a8f2559 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=7CQSdrXTAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=K_wyc9vDMbpTIRadLRgA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: KtbwUV0r0SYUF3CESYvzRvKETwKHJ2Om
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDE0OCBTYWx0ZWRfX+W/IbMcCEVAw
 Ik8GF7zNonaqwYTp0BR6qyzo0gVcbGMJYk4Wbr0WLlRydLxfM4BosEuATU29OhjW2Urv02Tc8tN
 K2dMwLjN60tSFuUN57PSEs7dtWJkAH09nBJipGANQ6K7vBU3kwER1k7SIuYBVbDog+E5qlNA1Yy
 KUmmtX1/lqo0JsL3meD458PArw4LVhFjniqvkL+JHuLj/HQKHNVWOBemPQOL3XY7CEc+mtocETi
 6Q2Sy70EOFazmZG4LL2a7vyRCnIplBG1gmVNwaBdk/HJietKc/Js6TvnGqrkGkR6ku+8Wh3FZYy
 YLXdX/2PL/C7Nqo+wnnuxZAbf3j2C6JLSUg1YmwPoWHkLVOq+Yyx+98NR9HoHHpvVJofmppgl7R
 SlXMmOa2zRJ/5ALTk6jPjkFltOFILDFi2H/Zaa2oBPXG89f+L+j2dGaDVMJOLDZiSCgF6uJ3m08
 d62HT1xQFoEB9GqTwbQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDE0OCBTYWx0ZWRfX/TrkCikPJv5t
 74IZdZfICK7Qe/CbiJBe4sGJ9Q7wct28E/ec6cl+oJ3RsWibHoF/Lh/De7Jb6CNXMjiLSxf75oa
 du6YdBwOv/GUZB2GPrzLTJBGVqMgJd0=
X-Proofpoint-GUID: KtbwUV0r0SYUF3CESYvzRvKETwKHJ2Om
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_05,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0
 clxscore=1015 phishscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260148



On 8/7/2026 4:24 PM, Andre Przywara wrote:
> Allow the mpam_reprogram_ris_partid() function to check for and return
> errors, and propagate MSC read and write errors from the lower level up.
> This also covers the callers of this function: mpam_reset_ris() and
> apply_config().
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Review-by: Ben Horgan <ben.horgan@arm.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Tested-by: Gavin Shan <gshan@redhat.com> # on NVIDIA Grace Hopper
> ---
>   drivers/resctrl/mpam_devices.c | 137 ++++++++++++++++++++++-----------
>   1 file changed, 94 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> index 96579178f0c3..49239b15a27f 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c
Reviewed-by: Srivathsa L Rao <srivathsa.rao@oss.qualcomm.com>

