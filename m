Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB6E44E671
	for <linux-acpi@vger.kernel.org>; Wed, 26 Aug 2026 17:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787765881; cv=none; b=IlgaJjRsW1iBirG2zQ51S6BcOY2IkGAirxAuwXzoy61yGfaCM0MGfMNnJ3KMM1xhHgiqIKKb60IvJvcGFQlAKsX+qYWhc+VwzDsvkkRB9ojJVSYm3CRzK92+69TrwoO2UyNNkaaXf/ELV+ymhi8g8+2iqldJa96DNZsISonJ8VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787765881; c=relaxed/simple;
	bh=g8Vsl1EHgsRDKVc85V1MtwOll8+JTVmQkGsyc8i4j8g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tBVoycLTJwtKsCj9UX5uruYrqj1/Q2tkq1O2yl4BifLVEGKmmtVuu02hVLhlN/FmfcfB1jmIpZjUTD9U92sEMWV9t7jHOSnvMFjV2RLLxSm6OZCJf/7frGWG5086FeBxex2SHczOav9D8mbsjimNtruZvBi7e4PYB4RWp5iyWKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P63suP+j; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WtSKLw0J; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P63suP+j";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WtSKLw0J"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67QGukVf343384
	for <linux-acpi@vger.kernel.org>; Wed, 26 Aug 2026 17:37:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+R6hz3Ifukcx5+qCcKIeT65fs+yH+pDKRs1un5ctVZ4=; b=P63suP+j/s6DPKCg
	ovVjzlbWXwxiFUPv7eykvOe4rjDnRgBsEQTTBhfcbLlPTjlgQBHHMEFmfA4SUANV
	3HEzgnpbs8R91lCczhlSQ4WQ3pZtWxW1rmvQNEvU2DFZkuxVCjSfCgV3LY1HJmt6
	E/Is/TnvCKITt/lfVwQ7AcatIYIP0VZRRj9QaspjNGseh8ODd154/y8QsYEs2uLY
	UNctkPxoqvmb0pVYWwcfnRbWy+0Ul2qR6c4SjESjOi/t8nA+ZVNHcVXcStCAQQb3
	Uwj9U8PV+Mu5ay00eld5g2SkjYOGijgesxx3cBpix+hCUZv4JPCqJagBVjOlKFaA
	uPFkDQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9uthtb81-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Wed, 26 Aug 2026 17:37:43 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc1c057f480so1228945a12.0
        for <linux-acpi@vger.kernel.org>; Wed, 26 Aug 2026 10:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787765862; x=1788370662; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+R6hz3Ifukcx5+qCcKIeT65fs+yH+pDKRs1un5ctVZ4=;
        b=WtSKLw0JeMAnlc+1ZtSXQQS7fPp5sG7+De3L0ckysmWy5EnvhQSNescfpHsBbKNFUI
         5xaTHb6HeH7nD21P/N7Yl7Ifeir59moM9mi9zv/SmpF1SmxSEDdEw8Am5asIDlTbFLTa
         bZR4eq9yPGvN4c7CrFipnKKgvQ5T80Y8FHHZ0zE/KNKinfHeCS6yU1MiPgYdWccArtla
         sBSn4V4EwSNFmI5F8d0E8XLhLvjYkrgRxBMSCsIe3Ec0mTiUyEvT4y5xm/OglMRwFoVO
         XGJmb2wNS8pCQ7GD2PvnGbY2DO8+iq2tHe0E5hWCPLg7U6inEqFKqKWcVOe2QEjawvfs
         SQTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787765862; x=1788370662;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+R6hz3Ifukcx5+qCcKIeT65fs+yH+pDKRs1un5ctVZ4=;
        b=Of5mVywBDwitpwJ9o2NSBHpUBTOzmCvwl/BMkFu40xkTMsNXKiX8IqB6e1aWiBGYwa
         c4nnwA5hO9lx6OWafXx6Lcx6B0VqMWkoW1Qjw0r/JpeLogIYZ7Qi7y1rzOYMsknILIby
         1wS7+7c2S34rF2bhJF6dWaMiZgHbv1CBrj/4/tAJQzfdKV+pCZ8LZ0Y+umTBiXbu66Vy
         Y0kAVtlNBWXBmH280HPl1tKxVZglXuTkrZN9qJsXHD8VMaLmoe98oXGElZOJLxYwFbA5
         +PEFNMEw58R0KnEwSL90PzSaY8tzDJP+kVt+mtQqKLV9e/pntO4nKF8e3BtEHeaEHqYI
         aGXg==
X-Forwarded-Encrypted: i=1; AHgh+RqCb9/dNd7s11/XwqKMxgstlEYA7Qb+5627XpXdJFhGfqr3CHhTqoT0lB5ztPnjKsF6nNMc63Cj1Pzi@vger.kernel.org
X-Gm-Message-State: AFuF++kYCrN57A/djEBuBVx4c2Kea2xCbkL1943/hhWEZk/ykTHUdX5+
	jwnjuQjD/1ro8yxk6BTKuQeKhWFE/Aj/EMedjpVb1GidFo1pJrRhCoOVI2F0YCtOuMtSuQZpNOw
	7NSCHd3y5KbE7MRb9SOth9j/hNV/mJpsyg2voSMpHoA2m3uenz7FwaRMrU7S7hsMB
X-Gm-Gg: AR+sD11mu38l4hNypWB+g57+q/4zcQrO4iSaEnQ3smoJT6FLdfD+U8/KHDz4U7Qpp1f
	1uuGkM9WgEYJ1kVmUGe599QHnv6TNz8bOF3dKH6obwE2AiszWrto4lNWp7o1ibtERnMVZ4/l+kP
	WVV2NfBGqXV0XYEokLK82RDwt/OinbCOl9nxhQ/OCoP9o6PSDGXdg8oI+4HN/Vq2RIdCilVxZOG
	LfyRioTUEz8lZ7oxodQXIg3V6MYk4BLesLq3w7+Lj43dEaReGzh6zb+OZLSq4iR3hYEHerYbDsL
	LIB1F0B9hLJO2VF5t9L/FOGZ+S3RAoQD2b7UDDUrBDxxp6BoAXclCgSrsM4CK7Ukw5smO3tBYZR
	Cn/gsxYkCGhEgNCW40KJkStvv7uo+d1lBfgV/aOn1JeIrMJZT2z1y797ZeZdzFuayqIMZ2S4n70
	tQl1htIfHN5Vv4S4UFgw==
X-Received: by 2002:a05:6a20:728a:b0:3b4:6026:6c5d with SMTP id adf61e73a8af0-3cf75e8e9d5mr16110494637.5.1787765862354;
        Wed, 26 Aug 2026 10:37:42 -0700 (PDT)
X-Received: by 2002:a05:6a20:728a:b0:3b4:6026:6c5d with SMTP id adf61e73a8af0-3cf75e8e9d5mr16110404637.5.1787765861893;
        Wed, 26 Aug 2026 10:37:41 -0700 (PDT)
Received: from [10.50.45.102] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc1beb0f15dsm1281557a12.9.2026.08.26.10.37.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2026 10:37:41 -0700 (PDT)
Message-ID: <315588d8-2a82-406b-a1e5-bcd00128c545@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 23:07:32 +0530
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 08/12] arm_mpam: propagate MSC access errors for
 interrupt control
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
 <20260807105451.3728284-9-andre.przywara@arm.com>
Content-Language: en-US
From: Srivathsa L Rao <srivathsa.rao@oss.qualcomm.com>
In-Reply-To: <20260807105451.3728284-9-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=EMA2FVZC c=1 sm=1 tr=0 ts=6a8f2467 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=7CQSdrXTAAAA:8 a=EUspDBNiAAAA:8 a=JeWy39_HCiB1Np-THXYA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: jCJd3RmYxLe_1cjlcB1gcYbJEJjOhTI-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDE0NyBTYWx0ZWRfX/8aHLn92dIWH
 8BshPrwo+7qq9gK7c8L6ogApuotMtN5yLXe99YaeDKhnGCBLXaEH9lwIvCtuTVahZEUKXzNa7/a
 /I1+9833A0ovJem7C4AZfdGDs2S1y9iLvwngzoHqWrKJhodbDs1FlDzPVrVDg4ieEqyiRPJtQSc
 9wvM3ciCkUDT8r9sBm0vCgaf0JW4jani5ALLza7DMlDBIruPD9dycT6Vmo7ySHwQeuJZp7eu0OA
 g14IelL0XDf+c4U/zEzryIj5PnyziHj5s7RcWpiUscAJmF8m2DdwIrWuvf+22dHEkb9ge4k4Ipe
 91kpUokD8fzfKYiFdzb+zNK3txkZFGXwpOU2IWWCBVqiHsOaYxCu03p1oqAUOew2Ijjqgl09G9u
 La3KH5TPOYxAzz+vpeQZysNqSmMnFIUVHpJUtxwCuSIK5BqCLfc0cwbW2fZ7jCiC/aIgMZNDjtB
 IF8sP/qvcMchtBxOpNg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDE0NyBTYWx0ZWRfX2IqeaJm8xKRr
 95ZJ8gBzVQ10NZvz5eWkPhpVwtKCetjlOIjCrx7mo6hP4klCcD1iXbLQB5jcgk/JJhp36HVoX4P
 Jx+Z9TgflGBg5nA6zdpDzmbKDKC7248=
X-Proofpoint-GUID: jCJd3RmYxLe_1cjlcB1gcYbJEJjOhTI-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_05,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0
 clxscore=1015 phishscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260147



On 8/7/2026 4:24 PM, Andre Przywara wrote:
> Allow the functions dealing with interrupt registration and enablement
> to check for and return errors, and propagate MSC read and write errors
> from the lower level up.
> This does not cover the IRQ handler yet, as this needs some more
> attention.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>   drivers/resctrl/mpam_devices.c | 31 +++++++++++++++----------------
>   1 file changed, 15 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> index 49239b15a27f..1b07f7765f96 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c
Reviewed-by: Srivathsa L Rao <srivathsa.rao@oss.qualcomm.com>

