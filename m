Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EE8528454
	for <linux-acpi@vger.kernel.org>; Wed, 14 Oct 2026 13:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791985183; cv=none; b=rQcDPgKUeajeQFIwn3uaubquNluawGYlZKbkvzIuCnIjrQ5T6yKtegeDBogG7r1IPquh8hc3pQo8feRoyBw5Tmp+okzVoHX9v7iv7shS0iCkcEd2YMXQ6M960LNwmZZ2nLovhpPnmPY5mkQoqVC6N/wdXF1ANwEIsUdMEocerqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791985183; c=relaxed/simple;
	bh=yJRtTsx1Z/dlS18YF82FYZYEB/5T+QeuKE2x3uhnYLA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=iM8rquyRhd6UKEClGxnmeYn8ORGSWM0yP4LJ4szwp4SrVFAbOhBjkHaEaOUgP2rHsl/adpVv5l8dth57fRDQpzHHV5LvrUVfD/kRyrdZpq4d37jUvISbo8ZRC1ymQigNeYVv2qfgkf08MfsdMK0TpjZc70stroQQ3akKvOfZyyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YtA1vLiV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iu23Xd2l; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YtA1vLiV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iu23Xd2l"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69E9eBmk3696123
	for <linux-acpi@vger.kernel.org>; Wed, 14 Oct 2026 13:39:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LU5iwxOOYRR9huRXhO8Bq+2PBVQhVFp9657Vu6mwVmk=; b=YtA1vLiVcUl2KR1m
	No50nfDkZJL942+jlsU/WOkZtwrlW2gbPRPY1BCnktLUQvF5Cm8zcnXJfLCC5FC/
	faE0yendvZ2SgPCtTZAgwNr2Sy4p8rLENtynYy3geCT63vIuTRDhnvioRzYjFDXL
	VNXJp5htxGIwSdmtwH57RPHmnjjR8V2d6SuV8ewgB82LeuSNABEfgU5lbhzdYSzw
	6VL3brA6BH9nS6Ijk3X6ifXUe8fhl/4MndKm0vXT7iVEcsJPR3x/zX5dpb8hVjy4
	RahcgPvUYhLmx9lzBowBJT+0Wfw2mRmRLnS8BhIW9iU5cOHV8A735abU/haK8eqE
	Xyk9zg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha7aegwp2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Wed, 14 Oct 2026 13:39:36 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93a082c014aso235799985a.0
        for <linux-acpi@vger.kernel.org>; Wed, 14 Oct 2026 06:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791985176; x=1792589976; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LU5iwxOOYRR9huRXhO8Bq+2PBVQhVFp9657Vu6mwVmk=;
        b=iu23Xd2lZhb8w8e+PdqRY8mGPRhzwctcJLe9UOlmy7ulqyjKeWzqxm9bjRLmoyMIpV
         V73jbSPiXsocnQOlkvVM7OWBBPkvVFhTh0bkMPzqgw51bGJjjIY0EFhJZgxae52W9EkA
         VAHPj98bXPQEd56KuOnLimJ68tTvIurVMXcqVfYLJ7RQnrgU/zPdMmdAZ+qEJZTDIerG
         IEMOvV2Qqz8X9KdAySx/oV36+05kgmwzZ+Ns6s+VOPP4/OZr8gUyyv/Wggyw2w2mZ7Sz
         wbplWmgX7fE0bdiqViGp8ffj/6QC7fSiydJIa+QV4UtLnB/ocFBnhtUWOoYtnwsiaKiS
         AEsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791985176; x=1792589976;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LU5iwxOOYRR9huRXhO8Bq+2PBVQhVFp9657Vu6mwVmk=;
        b=h6jVR7DDnc3DfK0ZtTx0iTNAiaNziNIH87HBkJ454dEVI9+4f/x+VoOOgxqC1MR69f
         SWh5iojxNUnAtCbPTOXwi3WBnmBFtkdw4sTh8DLGgIOfD8bPr1yrTjrQfggHUxyKLne4
         Q2zMaeqiDc6xj3r6PQZKC0293i82YQ64nl66eGgzBZMOUVznjw7qXgw8+PNyTwaUAeRn
         qtnkOeY8pweOTtw2VqC9nrTqP9pTGmZAK7XPT/r9Pz4mycf+S1uddrtYINen1ZCHeA+R
         SOy72JLp0SDsE7gdqk3G1f7NRpyUamnRRZGj5jRnThksnHgWUcBDRQaTH4rqmgkgboVe
         O0wQ==
X-Forwarded-Encrypted: i=1; AKwUvBwfkqfnuhm6qtVB3twXEiaBWdX9vI384f9fkh1YG3bx7VyexAl+BFrUF6TpJw+DDsdJ8TTDGO53cDxb@vger.kernel.org
X-Gm-Message-State: AFq9FYKYVFS9nnbfnn3h33L7d3y1sU0AfWEOfIwK5yIVARbazphQ1ZkR
	1NRPiImzwUy+8BYeYuYPq3KbrFsPUHC/9IkL9EJKRQ0h7TiVSeeew+Gt4m6zVB10NH4s5i+jxzy
	ailaDpGcuK2/NYULTACi9piRf25CnreNGroLMEvg4VXyF0fUMeZ4eCEjsC/XLLbTM
X-Gm-Gg: AYBFou097/mIUDobZ8a89PO4ZxdCsKFDhbzBU90PluoC3fe7gJQDWN0tD8utCj3niiQ
	hz0xwW0GtvMom+iei2HWSxeTM0gr7w+Dfgs3G0wcUMallZZe1xp2TFA0cEJNdLQAV/0FdoB4g32
	JhK5yk7HgrR5Ali/ocnappVMDqpga0vJrY/2tg0aSmCyqBmhqEe1cMCoauxxL+CKzrWRgLuG0aP
	RKPRVbwbZLFJzoZZSqHmZNcuqzCYFPDdNGpbsXbyF/dTedRE3jJ6rru5Yhj8IQXE8tHzpfON4Hx
	MTGafCI+no0rxOUDzpV/NpLSbwF99vWMCVRV670P8ufaXBA6sDtzE7m4b97MPAXNkkAP/5BGAjR
	ls0df5K8XKYiOlvQhkSZlR1rx7A48204jsc5hToWwyR5bsI8qNsqH60S1VjZkMJ0RWml2R2xA1P
	4Rn7PWGp7SqtgNoQzpXhv3RIl9NmkxJd2b9Elq2wUf1EfV3lXRQ+c0BYhfLXQg+ckhLg==
X-Received: by 2002:a05:620a:294a:b0:93e:60e8:c9ae with SMTP id af79cd13be357-93eb95e2c20mr2595658385a.10.1791985175483;
        Wed, 14 Oct 2026 06:39:35 -0700 (PDT)
X-Received: by 2002:a05:620a:294a:b0:93e:60e8:c9ae with SMTP id af79cd13be357-93eb95e2c20mr2595639485a.10.1791985173150;
        Wed, 14 Oct 2026 06:39:33 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9766209sm720315966b.3.2026.10.14.06.39.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2026 06:39:32 -0700 (PDT)
Message-ID: <21f3a18d-88a8-4c0b-9ccc-590b311f0aeb@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 15:39:31 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
Subject: Re: [PATCH 2/3] ACPI: battery: Evaluate battery methods exclusively
To: =?UTF-8?Q?Ali_Ahmet_Memi=C5=9F?= <aliamemis@disroot.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Armin Wolf <W_Armin@gmx.de>, Rong Zhang <i@rong.moe>,
        Charis Stratakis <c.stratakis@proton.me>, linux-acpi@vger.kernel.org,
        linux-pm@vger.kernel.org, acpica-devel@lists.linux.dev,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261014132703.93355-1-aliamemis@disroot.org>
 <20261014133013.94097-2-aliamemis@disroot.org>
Content-Language: en-US, nl
In-Reply-To: <20261014133013.94097-2-aliamemis@disroot.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: LoUV9xKvZGSjCG-SR8CNwY9x1qsGY-Hh
X-Proofpoint-GUID: LoUV9xKvZGSjCG-SR8CNwY9x1qsGY-Hh
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA1NCBTYWx0ZWRfXzVOMB3+LFV/l
 UEkvM5gLI0E5qiWbnS8hVVEukq+oc2sDC9NBdCTfTm5jOu3JvhksILuhg192Bp+xQvJdUy5+RbN
 awaEU+mEGyPqj4aEN2jg43IdbHXzPbg=
X-Authority-Analysis: v=2.4 cv=NctzRGD4 c=1 sm=1 tr=0 ts=6acf8618 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=LpNgXrTXAAAA:8 a=EUspDBNiAAAA:8 a=RHI-k3j4eS9Gi5hBZt8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=LqOpv0_-CX5VL_7kjZO3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA1NCBTYWx0ZWRfX4SmTvIBHme5m
 rZcumevAPP6WwtK7D2yPoGz1Cq2wqJciIVxdVUGDJhnI5nCsl4ZHM6xkdoEBaA0ihfU2NT/5Du7
 3+AuFcF7EWkL5EEK8L0EF3EZi0vcsGjYK1Duh+aGACZ9dZJw/8Wyo9eBq71tuUW887NaSQVgoQa
 g6jIyReslMpPT3C83qdZyE5D5yE/NCCPccF3QXn0Nn7Ji5CDsbtJYIixBeeCxjNfGnbCkYacePp
 Aml8OREP2IjHrE+KJSW+h2JkiQkEWMahh11bU5NF7dFmyeSD+9/AJrbZwB3EV/fV/bjZ9yb7bEn
 HidH2ymjTJkg0pDxEKUoZgzeeB90A0iIY3EWeLTLTO/YLWCUiizg7AZ7f+NJCbU8gll3R6+9xmT
 LkSSx3X5dM9u0n24Uc/GgTYC7eLr3QTqLPcVBF1pWzCqfTrBezd8EMVJmTFg5nnkiuHYht70HMF
 BqIWxI0iu52dROEATwg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 suspectscore=0 lowpriorityscore=0
 spamscore=0 phishscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140054

Hi,

On 14-Oct-26 15:30, Ali Ahmet Memiş wrote:
> On ThinkPad P1 Gen2 and P53, INT3403 _TMP switches the EC page selector
> without taking the AML mutex the battery methods use, so _BIX and _BST
> running at the same time can read the wrong page. Since commit d33e89d12295
> ("thermal: core: Suspend thermal zones later and resume them earlier")
> this happens on most resumes.
> 
> Evaluate the battery methods with acpi_evaluate_object_exclusive().
> 
> Fixes: d33e89d12295 ("thermal: core: Suspend thermal zones later and resume them earlier")
> Reported-by: Charis Stratakis <c.stratakis@proton.me>
> Closes: https://lore.kernel.org/all/37N_jFulf7n-Z55NfKfE71C_wVPxYvZ0xD_iRUg2fXu7TypDiF5PStQ6siSfVBih6fThg5WoPes8U5ZQpfVm_teMFcUGXFxz2DdMbfSWuws=@proton.me/
> Cc: stable@vger.kernel.org
> Signed-off-by: Ali Ahmet Memiş <aliamemis@disroot.org>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>

Regards,

Hans


> ---
>  drivers/acpi/battery.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index 670853ec3a4d..61de3f5be51f 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -583,9 +583,9 @@ static int acpi_battery_get_info(struct acpi_battery *battery)
>  		struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
>  		acpi_status status = AE_ERROR;
>  
> -		status = acpi_evaluate_object(battery->device->handle,
> -					      use_bix ? "_BIX":"_BIF",
> -					      NULL, &buffer);
> +		status = acpi_evaluate_object_exclusive(battery->device->handle,
> +							use_bix ? "_BIX":"_BIF",
> +							NULL, &buffer);
>  
>  		if (ACPI_FAILURE(status)) {
>  			acpi_handle_info(battery->device->handle,
> @@ -624,8 +624,8 @@ static int acpi_battery_get_state(struct acpi_battery *battery)
>  			msecs_to_jiffies(cache_time)))
>  		return 0;
>  
> -	status = acpi_evaluate_object(battery->device->handle, "_BST",
> -				      NULL, &buffer);
> +	status = acpi_evaluate_object_exclusive(battery->device->handle, "_BST",
> +						NULL, &buffer);
>  	if (ACPI_FAILURE(status)) {
>  		acpi_handle_info(battery->device->handle,
>  				 "_BST evaluation failed: %s",
> @@ -667,6 +667,8 @@ static int acpi_battery_get_state(struct acpi_battery *battery)
>  
>  static int acpi_battery_set_alarm(struct acpi_battery *battery)
>  {
> +	union acpi_object arg = { .type = ACPI_TYPE_INTEGER };
> +	struct acpi_object_list args = { .count = 1, .pointer = &arg };
>  	acpi_status status = 0;
>  
>  	lockdep_assert_held(&battery->property_lock);
> @@ -675,8 +677,9 @@ static int acpi_battery_set_alarm(struct acpi_battery *battery)
>  	    !test_bit(ACPI_BATTERY_ALARM_PRESENT, &battery->flags))
>  		return -ENODEV;
>  
> -	status = acpi_execute_simple_method(battery->device->handle, "_BTP",
> -					    battery->alarm);
> +	arg.integer.value = battery->alarm;
> +	status = acpi_evaluate_object_exclusive(battery->device->handle, "_BTP",
> +						&args, NULL);
>  	if (ACPI_FAILURE(status))
>  		return -ENODEV;
>  

