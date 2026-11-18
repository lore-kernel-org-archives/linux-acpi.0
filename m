Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794992042;
	b=CZWXjO4UGLQ3m/lVM8CsMoy0093iw8aLh+nDspASz2m/yn2WA/X+CZ1jyO8+eZKF2T/W
	 Sr2Mls1qX39EMwUYiKdXJb50I4qFjMNaQPPciJ6TWvyTMShuL98R0xeEytfPbCEH4wWZt
	 9fF141RGEo8F//u5HpPqe2oT7RDQnXPNERqLcPuP9mTMT/ZaCWACz++cDOeGkDJeMOveW
	 j1EBQ18vMPiQIFXUxeeJESwTJwUsN5unCSrMx8CEzX+yQoNjj+RkPuKF7aqH8AX6faNww
	 1YhnPoTCtSHTqt86muP+H6TeWYHpJgAMkX9lHwfBpi0wJ2VsFmv6jLAaDR+HdkGZqUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794992042;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:From:Subject:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=rT/jrZwwXN904cWDEpMToaPw7m4qZt1ENrd9xxrm5sI=;
	b=AwuQI9z/DOoY+af3GA2vKo/25ZPaCoutZoAvtCNYwp/2UXC9x/lCKceOfb68hyQr0Of0
	 uansqEXuTTLIFZjFYmqccQ9fQJn/Fg+DxbwpDFIY+U2rKnt4dcHFbpr53z18QnPwMbBH1
	 VKXc9JopRGmnQhz+RYO8UbbTRXJRARY9aOPk/R2S/ykE9cq6yMeBhx7dNUc8KTeYzC22/
	 qmAFAyBRSnQfPKdS/Vg/YCt8w5eMlnRFFVshPZF4vGRcbUhft5/jIMS7lD7tmLCdnt08w
	 iIQvh3QaLziEJ0g92zPEd8bxzB1rhJKW2efudMfGWvwamHHb1vPHREWS+6jpTcAMiyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CXb2FBuR;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hL5mwCxh;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF85606A32F
	for <linux-acpi@vger.kernel.org>; Wed, 18 Nov 2026 08:54:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1AF85606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CXb2FBuR;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hL5mwCxh
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI8NqZE2453547
	for <linux-acpi@vger.kernel.org>; Wed, 18 Nov 2026 08:54:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rT/jrZwwXN904cWDEpMToaPw7m4qZt1ENrd9xxrm5sI=; b=CXb2FBuRtfrKI6Wt
	tT8jIN6qyBYv34z2hn2aEJXlfUTnX1rjG7egcgwnlrCU0ytmXazgbUnnEaVcjZAH
	sOsQrf+fbyZ6B4lp7MSMMlDFHcPw47QRhiglU6DFMxvyNGyOsF2seJ9eLlUeSU+V
	WgWoUJu1DsrRBUjv9veukm5BG1ISJgB+9tSKjyukDXkOQcDh9gK7Uao5QA/9YIla
	ysoL4lEPaypgdVQbW2rC2amX0IzaBPCU+CVG5eVCisHqFD+SUZAJr8duM+rGHsRV
	JBwfsrOWZc+h4ArFZ6X2ssVhVY9s5vIVPq818bd+jqbpxHFPe2Sjy/KdbkOWxdAK
	VfqpxA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0yv9a4dx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Wed, 18 Nov 2026 08:54:00 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-9495876f8beso130435585a.1
        for <linux-acpi@vger.kernel.org>; Wed, 18 Nov 2026 00:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794992040; x=1795596840; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rT/jrZwwXN904cWDEpMToaPw7m4qZt1ENrd9xxrm5sI=;
        b=hL5mwCxhLsPZmxDjiHZ9i7b06yciCSeCCvWXcF1Bh6awNem1NrXrQzCND5bBceF9P3
         2oTJ870OLhfrhD70CNw9jcoslT8hunATDYJu4w42BBLx5kcgiolUYqeZNd48c7XG8hVq
         sK+cs404Ht+GxkVq9Ema0jfvXs+gesmqTI5TZacLFITaMeUlXygDmkEgpNwvn71xOnQ4
         Fdub+E1TmNeUlbDvcNmjIGacVSM+oR3hqzF91Krxd6ZtYhTLup1qz8X5rSvVI+UdFHEM
         CRbW7VymNiEt/dQkNEMhKJ/4emhyaLFhXyTBj7KrpOzDn2sYwTNA8xkN11S9hlB8ZcqT
         zrzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794992040; x=1795596840;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rT/jrZwwXN904cWDEpMToaPw7m4qZt1ENrd9xxrm5sI=;
        b=THLPvDJGUVF01w12MMsprK0TRZEl0N+cPuc7FYDzJftQS7Jvteexa9cL3LiRwEraxH
         K6pCIBc4if/DrLQ5Ziw1xiCCDyYfzOrnIiD3QoJd8jR8fp/Wzk/f5L8ce/wIziVYyW5v
         cXrHeY6szkztNbRGRNW7daVhMLsylMHer3hmHFgUyxq46mCaI0O6Jh6Q6S48iqFFv7hj
         Gp3/YtoJ6PRwxZ1/OBbo9NhxEcL18t/+HObvSftNFr40uehWcgWaUj87de2qWwwuRRXd
         HBAAamhHtaFJHbto9ruC7wptQf87WdunG0+H0S3/1QLx6krXHYhsbxfmcIvFDq0rcu53
         pIGQ==
X-Forwarded-Encrypted: i=1; AL+hErEvxPrxUdMYsrfFcjDmgwXTE/FwhLYDNV9In4EtwDVVtTrmUeuEnaNhIel9H6ugpLVjjx0HF4y+i4G8@vger.kernel.org
X-Gm-Message-State: APuU4Z+QQc67g2Cra+7ia5jw28wpLxWkYZk4o83EE1k0XwJfat/na4h4
	dVN6PdN36m61sIMBuOrkjyMJSYNqqPhph29SPBmHHnW1eCrRbtr/S6pbCK+ay24e9/BvvwYuaaw
	cFi1/bn5tmrNanA53OwoJXbMZlOuYutRlqCYIm/c5r7Vz2j6jYhT9aAShN0fQ015o
X-Gm-Gg: AYBFou3dxHv+bFnC9WniQ7efQ1Z/toyNJi8dv9ykr47MCzpDMMpX4RnRbNasfpLcKrK
	a3brJufDbwt0HrJ1IuUZbOYTkBBHaB+wYwkNuxll65/Yd6hV/Tsk3bQdonOh48fHghwTXhDAbP7
	Xn8iDLRwMQNHdti9XO5H/NzTqK4gT7GSR+2PsRKDkYaA166nA2cY8dsdv5/H7Un7SGGv6NTIyGy
	0hxI3ctGMflfccxNJzUn2dzMQDWxeM/GecDwUtzciAVoEwivUPk3cPgrVte5UHTZ1rolo9kGGMf
	T+i6MF2eHx488hX6idnzv9ua4lAnyAA/AXcvQrWBUdhifV70ojWWOtkzPpje+H8IpDhay07swWq
	knI8X++dy50RQSD+s2RewxspeeujZesUHYMtK0Y6+mdpSPpuNoDnXkUi6TkSblrlxwd9ifPw=
X-Received: by 2002:a05:620a:6f05:b0:93e:6f43:b2c1 with SMTP id af79cd13be357-94999576296mr365360085a.16.1794992040201;
        Wed, 18 Nov 2026 00:54:00 -0800 (PST)
X-Received: by 2002:a05:620a:6f05:b0:93e:6f43:b2c1 with SMTP id af79cd13be357-94999576296mr365357185a.16.1794992039637;
        Wed, 18 Nov 2026 00:53:59 -0800 (PST)
Received: from [172.20.97.137] ([195.50.164.66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb78430752sm135959695e9.12.2026.11.18.00.53.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 00:53:58 -0800 (PST)
Message-ID: <70618789-f82a-4cd7-953a-a97f555fa98d@oss.qualcomm.com>
Date: Wed, 18 Nov 2026 09:53:57 +0100
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
Subject: Re: [PATCH v2] i2c: acpi: Force Dell XPS 17 9720 touchpad to 100 kHz
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, penhouse24@proton.me,
        linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org
References: <20261118073607.297350-1-mika.westerberg@linux.intel.com>
Content-Language: en-US, nl
In-Reply-To: <20261118073607.297350-1-mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDAzNSBTYWx0ZWRfXw5+ePAhxS3gC
 b4fhThMJTYxLi6XBmpl34FGU3fpXTz5iufTGgfmBa/iljQPLm6rrMYTaPf7NqM/GxiidgQb+SZw
 QKr/PaLl3+aHkJTcCYogxmea52SWISw=
X-Authority-Analysis: v=2.4 cv=acT0Dhot c=1 sm=1 tr=0 ts=6afd67a8 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=Jk2/TV77q6/E6wQq2oQJxQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=PoUxWBnWaag7qOlay5cA:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDAzNSBTYWx0ZWRfX8gl59cLMeKtL
 aBhkqhnn60d+LmoKcXpNW2T9S/YUcV2l4In+1X1tGzoWaYpGTzhzW9Uiobjwxm0KBrUKEhXBGlC
 8OfFWE3JpeC4ha4kuB6R2HO/YVJdJisX9HQDvDA5wmLYtENrhMLtwgySRDh1mIEIpdsyy2WiXk0
 g6Pifw+DXp3Lt7CELGxvGzaaWahUM+YKnPff4HqY+g/USBmQPeNP22Suo4LcUgg3ycFzj7Z9NIJ
 DBGEAL6l+yqeS70GL7oRPHfGR699Rf9A1p/8ZYk9Tc7PVJFElpXFfOcPrtG2L5A8z6nrQbw8dL9
 T9erleLTWvBTKKSGbFDFhLndXcjq6oezFCpTJpJPZKKkaIIcJ7T8Hn+F7nRXGcyY0heP1ftZXHd
 Or6cP4wPmSgBbzOChIq64js0kxukFmCW4iBd23AWaw4ZmLRvlrpgy/WHjpX8W5r9lGK+adGfSNT
 ccsaDtHHMj3masqhlDw==
X-Proofpoint-ORIG-GUID: Gk1Vu6q0wrQJMKEytFAVBi4B-pafPQt_
X-Proofpoint-GUID: Gk1Vu6q0wrQJMKEytFAVBi4B-pafPQt_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180035

Hi,

On 18-Nov-26 08:36, Mika Westerberg wrote:
> The Dell XPS 17 9720 touchpad has the same lagging issue as with others
> when run at 400 kHz as the ACPI tables describe. This particular system
> does not use standard ACPI ID but it seems to use "Windows Device ID"
> VEN_04F3 for whatever reason. Add this one to the 100 kHz quirk list as
> well.
> 
> Link: https://lore.kernel.org/linux-i2c/20261109104542.GL176724@black.igk.intel.com/
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=214597
> Reported-by: penhouse24@proton.me
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>

Regards,

Hans




> ---
> v2: Drop the DMI match, add bugzilla link.
> 
> v1 can be found here:
> 
> https://lore.kernel.org/linux-i2c/20261113083940.2583439-1-mika.westerberg@linux.intel.com/
> 
>  drivers/i2c/i2c-core-acpi.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
> index 84841ed13487..64fdf8ffb5ff 100644
> --- a/drivers/i2c/i2c-core-acpi.c
> +++ b/drivers/i2c/i2c-core-acpi.c
> @@ -377,6 +377,12 @@ static const struct acpi_device_id i2c_acpi_force_100khz_device_ids[] = {
>  	{ .id = "ELAN0678" },
>  	{ .id = "ELAN06FA" },
>  	{ .id = "ELAN1300" },
> +	/*
> +	 * This is non-standard ACPI ID used by some Dell XPS 17 9720
> +	 * systems. They do have the same issue when used with 400 kHz so
> +	 * force 100 kHz.
> +	 */
> +	{ .id = "VEN_04F3" },
>  	{ }
>  };
>  

