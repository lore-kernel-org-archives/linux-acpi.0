Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794826308;
	b=YptJvtVxTXBw+nGib0ENH/SISiNBoBq43UVkjjOr7ap1P+asll/sumAzRKVfZascMBv4
	 sqL8pP2PeILPTH1OsNeCYTGbnoiTGH55LvGj3ZiN/SWWYyxW0/AISsKpZwgAhz3S+xlJg
	 p4tSo5Z3BfMFQ712dvS5coQMhmwYM95a2jJidYLDoq0c9xQgMKybgji9cMEHl2mOHytFH
	 92mJ97eFrRQk9fJtRs+q1ZgrEzz+FdsIGESLuvCOvL2KQHgsbjflC8aa2UYEaP7DMeL/2
	 OJKsfdRLxFrrAN8ThMvmZ8Ic6HNDkdBiMazh+8Vp7u11Wn2GIQAKTaxffw6IW0K2aPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794826308;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:From:Subject:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=DNZx/fJio0QkyIvjPmXj7q0Y3XwFo5rxRepEK0oSLsc=;
	b=OrJp9UdDF2KN75vcfYqKSOAvrnkmLDLIsr0aRySNaPI1OdZuMW8ZSkKVyfCxlA4voOvb
	 100UqK1uu76BniSYMO5ppvCgNZuGo6+wRW1+p0Ir5feYWKNVYBDdhKgrXKxUrWqjqun7M
	 CjpYzOOlk+z+hIEBC2tZRZiIDzjCAO6i15yA5bIqVNArHu4AK3nWOLI7+E8CIOiWMP3WA
	 2gSGz91iTklUDC9UeohozH3PfrF6Wdv4SXBq/0xxs29tsA9qWH/kTyvC2rFbS9GU+VRHQ
	 fZxhArOQjW3CIb7YnqUlEm+CfvBJyezTrKrzwwcUOzYRQIDxosenkmtKDxBtp5E8soA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Qr3W95QW;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hoMGSkkl;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717A6606A332
	for <linux-acpi@vger.kernel.org>; Mon, 16 Nov 2026 10:51:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 717A6606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Qr3W95QW;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hoMGSkkl
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AG7en7R1109764
	for <linux-acpi@vger.kernel.org>; Mon, 16 Nov 2026 10:51:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DNZx/fJio0QkyIvjPmXj7q0Y3XwFo5rxRepEK0oSLsc=; b=Qr3W95QWtux64/FI
	+pAhcXt7H9zdKXShDzY7iBSeeuCWr7CLy1HAD8r7Y6wvhtPl3+U4XDHUGUgnUj2W
	+Z1cdwcZzTg9OLxKlHj/0+lFJAPxoR5ROp+6HNTEmE0TGnF2KWPRrwZNXbijy/Ro
	SHPSnEh31na7h9/0xEQbyDgKbS5FRiRNAJttZ33q/giJ89o5Fpr9CT8yXP14cvGP
	giSvr23JoYBDecACp8Y9HaNVoBLqa9/hH7UubAikto7jlLp3wql9OyFS+972EF56
	uiXNjd+CalvmVFeIf3RFE7i4px1UOR0Gvcg7ArR1P2O0JCvy/iq+T0QETBKcteYc
	Bz6uLQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hyrmc1sd9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Mon, 16 Nov 2026 10:51:47 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-944138ed63fso515682485a.3
        for <linux-acpi@vger.kernel.org>; Mon, 16 Nov 2026 02:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794826307; x=1795431107; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DNZx/fJio0QkyIvjPmXj7q0Y3XwFo5rxRepEK0oSLsc=;
        b=hoMGSkklzvCO4JLISup4koj5YZiJKiJiBzQvr3k+ImcjTAbJ+Z+C4UtzkXc3L7D2fP
         PLK+dg/OrUSQbDSMTVgRYwrUA0z9uU2nbslJOxu+XU52SYkaIohwE6/y/whOyUj5oXMB
         CAvvqxFfKariY4Qacu+4hBvhKoj4bMbxkDs5Jz+1G+oeaiqbMFVt+Eiqq+epe9uyQ9uK
         XN5ydyPVcE4wawfCv9Q2e8r9CoF3EqPe/oBrltjVssHtgBQw0yE2ZfqAYCVnduQR9+2w
         pfLPC0gtB5QGL95A6OnfGcWnuCUn8oXQDd9Y2aopwhtsDYblKaRE5ZemQ5msLnWaMfKj
         4MfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794826307; x=1795431107;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DNZx/fJio0QkyIvjPmXj7q0Y3XwFo5rxRepEK0oSLsc=;
        b=G9FCHOTPg35Ac/qXSSpEem0SDkrxKQVJSzgPilX+04NkWGw++btOUEjJr5F7wXPqoQ
         3XaGvEnsNGrBfKwTOpsdhtUy+hagEAC98DJWH4J067YLCwPF9fvHXrCgDJ/3SeZQavdv
         05hQ+jUOhJBuZxfsTm/S/XwQc235zb0pHFpKFHUP0X3+7MhlY38kq4P69GsCL/LELXFa
         nmM47nD6nxt43NWyh8mzprHmDXYKvQrB+ZmFA8/FwO5/02Sro9N6ndU3Psh2NV8x+F2/
         9kOubSWVdLVd/IVqcCQxyk37BK8eVE5LuUmI9VfrJ5Z9q+LT6xBFjXC8sVFoRRAtw+cd
         TQhA==
X-Forwarded-Encrypted: i=1; AL+hErEZFjASsD1jNAFman+4Sm9JPEQlY/HBf7bmuq2e7shEnOlHpbGAg171PshnhawNXiVNQYitlXz2TLTW@vger.kernel.org
X-Gm-Message-State: APuU4Z9qwgNl8HrsOG6BqP9TIQOQ9LZe8mD6xkVVnfH04Wyj/OY+7I0Q
	zpYU36BFeGSL5t/u4KoqLGKpNeMG0rG/qU+V1HLBDe69bvOnncXJYL0HvLSFw4MTCqIOM/YUnAL
	QuIbzcTrnVgHAzzvsGG4vjsON3DGCZM107JJwCCiq707QD2MTxHt791Fn/zFa+95ZBGPfty5Sr5
	s=
X-Gm-Gg: AYBFou3tbV0CFA6C/uC3T1s3M+mPWv8wDp1pjmOaBo6lPzuqrwo/wzOtGZuTF7XWsni
	qFnZJuT1XYL8UxG/Uz6SMGCd+JJWuy0pHHRQdgObSpFd+YtfGQgJ81o6yxqpwPmOSA692HoXlaJ
	Vt0vFdTGw7KuzQMuincOQLJNMaxqqBl/h4ZzBGrNODgmwHjP6Num0kpsrz8iCAifa/JdpcJwwWV
	uIQVLOArUW+UUSO04bQIT9vNKVhCWYlH0P1kVvJ7LhmRybQttYcaLBHATlylyor0c3wsCOlQxCh
	ZUWlWCrajad57zZSy/awqLrChCvqwPgXHW653w8FgjNmH2qB9OHPo/znHa5VcvDDpONix68pheK
	QHuBTYYanLYYs2iVf4nvtcJ0k7pG8oBLWvnysujXS0/K2L8rmfyPwBrPtgXWgOnQQE0twrilHAp
	zlXKcB91lUBnpamNOCJ0cYERV6pF1oRIH6nqoc
X-Received: by 2002:a05:620a:4009:b0:949:3066:556a with SMTP id af79cd13be357-9494bce0ec4mr1811015285a.69.1794826306553;
        Mon, 16 Nov 2026 02:51:46 -0800 (PST)
X-Received: by 2002:a05:620a:4009:b0:949:3066:556a with SMTP id af79cd13be357-9494bce0ec4mr1811013785a.69.1794826306120;
        Mon, 16 Nov 2026 02:51:46 -0800 (PST)
Received: from [172.18.133.33] (195-200-21-10.mclarenap.oninferno.net. [195.200.21.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb62d5ec30sm295319355e9.15.2026.11.16.02.51.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 02:51:45 -0800 (PST)
Message-ID: <12a87383-f4fb-4145-9c9e-15b52a930f93@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 11:51:43 +0100
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
Subject: Re: [PATCH 2/2] i2c: acpi: Add AttribRawBytes accessor-type support
 to OpRegion handler
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org
References: <20260919193642.43058-1-johannes.goede@oss.qualcomm.com>
 <20260919193642.43058-2-johannes.goede@oss.qualcomm.com>
 <as1gYyr53eIxdzZV@zenone.zhora.eu>
Content-Language: en-US, nl
In-Reply-To: <as1gYyr53eIxdzZV@zenone.zhora.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA0MyBTYWx0ZWRfX3q0t7mlZz2Hq
 V4fm9PZ3DHQM3sP0avPIgemhNL4Sm/jQ4dRCOllQWXEEk/0cyH/SgXYRodbNNPcuZkFZoV7RMci
 kkfrP/LYqg9AoZfW17XCcUI67cEiax0=
X-Authority-Analysis: v=2.4 cv=C9N8WgP+ c=1 sm=1 tr=0 ts=6afae043 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=LwtOfSRbDNzKn4Mtwg6Q5A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=CeogzBoLu_OrgXPPlcMA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: WORChWEMOSiXQtV9U3QVKf6CQ0wwTkcg
X-Proofpoint-GUID: WORChWEMOSiXQtV9U3QVKf6CQ0wwTkcg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA0MyBTYWx0ZWRfXx93v6m2AXVFS
 l1co9mmhHbvuSLwPsHu2AGu7ExPsOHqG8cr7mE5FnaYUbzicZTspq8hUa+Z2chP678nn3E/Nud5
 mijFFaXXhec8d+T3a9bryDbhfKbV+Samx7y1PE1JOqC0cSiQ9SqW7yJO0MBWT1TdoFvqffYBHMP
 m+7MpYSDCzeEaJGwV3LbnJL81ajMeNgWYhqjuErA8P0++rqS7PNy8WfKAwxRwVmjx+gZv3FLuph
 R3jxa6wjh/FkZAAEXTy8+2Prec7aKt14W2IdhquwAhlT8bGdZohO9xRTBvLFLk4ix1uhar+nWdS
 eiRlBCg5K/mBLPxg3T6nUwszvzatr3ilHw6SLCPQfaggt5PVHQVoMiu+BAkI7wtjraUgHfmkO29
 aQyuRijwkjbMwucXa3Wc0demomnfTE7m+AekH2U59pNIXvSO7kh9wevksXx5E/mNKmgzdW5RWxm
 VbVCImHfgIbFds9ZnbQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611160043

Hi Andi,

On 13-Oct-26 00:55, Andi Shyti wrote:
> Hi Hans,
> 
> ...
> 
>> +	case ACPI_GSB_ACCESS_ATTRIB_RAW_BYTES:
>> +		if (action == ACPI_READ)
>> +			status = i2c_master_recv(client, gsb->data, info->access_length);
>> +		else
>> +			status = i2c_master_send(client, gsb->data, info->access_length);
>> +
>> +		if (status >= 0) {
>> +			gsb->len = status;
>> +			status = 0;
>> +		}
> 
> We should also check whether status != info->access_length.

Right, good point I'll prepare a v2 with this fixed.

Regards,

Hans


