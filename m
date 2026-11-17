Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794950827;
	b=rEty5qhXsxzfDKXjGp9Ecx60oI4nKslXePu03bjXLy4Uy2xOFWbGgsa5Qx1b7XrhLBw7
	 OKBSmMqyWxJ6Jp0nWoSuLSPEjPtRWZJPDJGKZ3lbjfJpD6DKPP92+KFq325LVwf07ZYUG
	 tOhlgsMJ51GeVIQuMBwuR+NHcqRgKkA3uVaKKdlSLcY1Cn9rjM3czaiTNQ+yw4PDJzPcm
	 AsK4R8iHZ8IOCJKWsRtQ5N7m2DTVyuB/DllJvLat1ovoyw4/DBkQXd9nJ03SsCY0XeLR1
	 Yy5HOpdczQP2CQFqiQ4Zl3WfuuyS4uDB+M5nPJGG9qv6+H2XF+avojcsoIBremRuvxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794950827;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Kye5UCFhAlBn+MOXhNz9A2crB6ZLISzlyY8FztGTBT4=;
	b=vlep3U+86BU9en8TIL4pwbmRpTHqFAyfFxhmAMwphMa3fRCCoJApxa1XSgGPq/NUdNtA
	 hI1tvp/g10V4pC9+EDwJbXf5+dEkeEF0+XhD3TLpQosQ1j6hh6pUxmlp9DMYWy8MWPRk7
	 XaIQS1ewW7mFZ4/T2SRGL3whuwVMp/ssIErxT6gBtwSkPZZZSPA3LkSB/zMPoSCAD/Rv+
	 WAwlJfxpjT6rNE6p0DMjV3KOzrE8StT/VkzshuDWhHDwPNJfBVp1Qc20Z7U6o/7Ed6FNQ
	 KaRliRVlxC6Z1Mq2U2clHRv51dlFcMxALBa9RFYjkI4Pv8SxQuWxYfXU2vxwUm4zYLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mzqgtgXh;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=J2SqIZqa;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B99606A31C
	for <linux-acpi@vger.kernel.org>; Tue, 17 Nov 2026 21:27:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8B99606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mzqgtgXh;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=J2SqIZqa
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHKfWCb1627415
	for <linux-acpi@vger.kernel.org>; Tue, 17 Nov 2026 21:27:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Kye5UCFhAlBn+MOXhNz9A2crB6ZLISzlyY8FztGTBT4=; b=mzqgtgXh+8LtF9DP
	EF0D5lQ3qW7+qC4zKERMkCrEqQKmpFz7ZEkgFGX0pLrxYz4k5h5anxYY9Onv61IE
	O1yMYDU1dsuOf8EYLIbQOULw30htv2ksBapiCniOlj94uWXKiuCASqeiFc+S0iB0
	FAB8aEH4H6t2nYg4QMG8Bo/mkt4Q66kEFW5/u+ZpWXvwAWMdE3clhQCYU30/v4go
	qWBbGFQcMMSxgnA21BKrCrfv+0MDmRyi2mwGpho99EsGgOkEKCcdOPyHMK+jYRJi
	zYnTb/YGV4smLo2nlgjPYYC7vdMeSlwbTR8GaxBQxN9ub4NiPvdpCVgD6qCSoMz4
	e3ngwQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0qms25qv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Tue, 17 Nov 2026 21:27:05 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-947a607ec40so36795485a.3
        for <linux-acpi@vger.kernel.org>; Tue, 17 Nov 2026 13:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794950824; x=1795555624; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Kye5UCFhAlBn+MOXhNz9A2crB6ZLISzlyY8FztGTBT4=;
        b=J2SqIZqaDeC6AS3p0N7vX/KfVgChE0ItzAJ6PoExFwQl1Qrp+HrvNsWdTyIsiZrtJZ
         W2XfoMS4ZfLAHbYDlWefQo4lwBxvnrCVoZzbGVUKdBNQypwW8ThQaCfefONvIYbRa1vv
         /2rclYNMkEHZDeSxqNlD2p6mSCApkqp2cuNT/OJRj9pHfdv7ad2M6Q7ssRDRj7vh4bR3
         vfcrENJ8MhOrC+heQt01SCxj8C64uENH2LGh/96NtyRprE4/klNqpqAxHW2Rv7K/Cffr
         siFOl7UBOE+2CKJcXoSCkNRkUDYoMfA6idGQaEWBI9b3F2h6G5QQqsdSiZKAolxgB8Rg
         pNFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794950824; x=1795555624;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Kye5UCFhAlBn+MOXhNz9A2crB6ZLISzlyY8FztGTBT4=;
        b=AVkKrJI8yvbr+gtErMyDSIip2TtmXkIu8RbXdYDQMcXWEaFCXh7zqkqA59DosoG8wO
         aAi357w3g/vAVp+zU/43Gi0QAnZn8fqY7+/iu09Zd16TVrQTQngeBnD0l3z+mU4e8oZk
         B6LAKUuACHwejhqKeNYo56YAOAcXZC1BkhbS/qUbyB1TVHBf2CLnbFCjv33ifGmh+ePX
         pf9wKgQx3gg5/viQSU74YeX+36WsvYcBkAfVG7bADLRKtTtR1Y24ryMeTcr3aMqEsv86
         WuyKgEk/a9datzkhCuilJWjYxN8/vtmF5NPM6/KcXeqplChTCLyQhqGmMV91KERlCDxK
         Bgtg==
X-Forwarded-Encrypted: i=1; AL+hErGlfUL3fLWU7cF9c9J0MhAkKMWFHwSp80DYyblEQU53gqV+Fza2S06mQPKShKrU4a4EXNAmXQXo43py@vger.kernel.org
X-Gm-Message-State: APuU4Z9Jft7Pcq+8+8cnjtmuUVe7mI5fJsjvp4AGGTruZhEdcRpmaFTE
	BKJufcMypoYRn0QRQdp3xP/el3P9scM1Cew3A2qJXUbZIW68PdN1l4jzIk+aX7VfMnA83/nsWm4
	IRWvLMYZFYAzen2Lfo5OYTiZ2W2UbTAdVbxVhU+icr6PXXP2JhLbGOUjUVfQWs7nb
X-Gm-Gg: AYBFou13rB4qpd873JEI2G8YZ73q6DEn0QhfuehtK8lL5n7Q4xXwa8ne8lul+1lb9gG
	+PPdldNn16sRBDrrSn1PJ0RId9zeMA+xijdw143vWxMbkTmK5/HNfkDyhIyXD9/EG5EHDgjoTvr
	XHSBZp4PpQps4jM2eI/TG9bOcWrHQISqPOBV7t4e2rgam4kxax2IpJf2Pe5ASs4xAl6lrDx7Dsl
	rsQ32N6AJFDN+Qbki5T8+hW9Vp3+m3JocVnhfFn3W7roVuIy2QLAvL0eVYKCtqGzY/PlzdZny9q
	2kl+pHhcORavcjQIlPagxRkDc1RBXmYYHak2bmKXJODOOB68xitHod5eBTTVqYky/SSq6AaEBEa
	DB7sUrkwcfsbVhmEdopNremxdegVeJ8o+3nUgZCZKj472pB4KhA/3BgPCU9M5bbDHUI80iK1gaA
	XXANFWczJ0IPsxNyWk+xelMMLxF/9FYPAlcEQ=
X-Received: by 2002:a05:620a:8014:b0:949:78dc:f90c with SMTP id af79cd13be357-9499960aefamr136051185a.60.1794950824616;
        Tue, 17 Nov 2026 13:27:04 -0800 (PST)
X-Received: by 2002:a05:620a:8014:b0:949:78dc:f90c with SMTP id af79cd13be357-9499960aefamr136047485a.60.1794950824084;
        Tue, 17 Nov 2026 13:27:04 -0800 (PST)
Received: from ?IPV6:2a0d:e487:16f:e583:d876:5ec1:ccc:7949? ([2a0d:e487:16f:e583:d876:5ec1:ccc:7949])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb78386902sm104139015e9.1.2026.11.17.13.27.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2026 13:27:03 -0800 (PST)
Message-ID: <4f9abffd-1794-4564-a752-60f99ccccb4e@oss.qualcomm.com>
Date: Tue, 17 Nov 2026 22:26:58 +0100
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
Subject: Re: [PATCH v3 1/4] platform profile: Extract the core from ACPI
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Len Brown <lenb@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Viresh Kumar
 <viresh.kumar@linaro.org>,
        Hans de Goede <hansg@kernel.org>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Mark Pearson <mpearson-lenovo@squebb.ca>,
        "Derek J. Clark" <derekjohn.clark@gmail.com>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Armin Wolf <W_Armin@gmx.de>, Jai Luthra <jai.luthra@ideasonboard.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jack Wu <jackbb_wu@compal.com>,
        "Mario Limonciello (AMD)"
 <superm1@kernel.org>,
        linux-acpi@vger.kernel.org,
        "open list:CLOCKSOURCE, CLOCKEVENT DRIVERS" <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org,
        Linux PM mailing list <linux-pm@vger.kernel.org>,
        PDx86 <platform-driver-x86@vger.kernel.org>
References: <20261024223501.1420953-1-daniel.lezcano@oss.qualcomm.com>
 <20261024223501.1420953-2-daniel.lezcano@oss.qualcomm.com>
 <CAMuHMdXJOpcC3a6wMXF_m=uNjuqSO1Z3kyM7Az1uP_2GBurOvA@mail.gmail.com>
 <0de1444a-a0ba-4e16-a480-74a39c865ab6@oss.qualcomm.com>
 <CAMuHMdWfH+_4ijxko=LS_P6b1Y76WWDc8m4xL6qW1H+qKRQ98A@mail.gmail.com>
 <CAB9z6xC4c=o1DwVARBek7ozDxaCON9rpwTmJ810sDGyP0XYQDA@mail.gmail.com>
 <CAJZ5v0jg61_W6hgtMzKdMa+f27ApaNunnpkzM0MoYxN+aV-xog@mail.gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <CAJZ5v0jg61_W6hgtMzKdMa+f27ApaNunnpkzM0MoYxN+aV-xog@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA4NSBTYWx0ZWRfXw4nOzMTmS6or
 TFFyMvMv5p/H4wtp00kCvB7VsE5Dpi0gdJrTPYajlTSrNJLFNuXhBSSO+WtkVXpeZ+5PzXOkWy6
 6Cp5gziVIOhb6qF/BYr5EwwRJFyDqaQ=
X-Proofpoint-ORIG-GUID: 8BLfpXjivVv0LJx1Ce6MQjnkRm5nmaJi
X-Proofpoint-GUID: 8BLfpXjivVv0LJx1Ce6MQjnkRm5nmaJi
X-Authority-Analysis: v=2.4 cv=BIEmP1QG c=1 sm=1 tr=0 ts=6afcc6a9 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=1nFPZZerRWjXyXi6724A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA4NSBTYWx0ZWRfXzbeU01wpZH+T
 K4XqRLCMyyhGSnrje6GAYheEDTjWyZG7ldO19FcP5vf42nZ+87C+GjtpqUV466h8sdQ0eggHEjH
 fYGbTAEM+03Q1PMjhWFJW3AAWLgTa96Qvu0kb8D5yZkeLmwC4Fsk1nzDFmV6dxNv57vD/6JaEXr
 jNqIllcgrCTZtRocXNiU0LeyUcnIPJIGpHC9AyJqdgrsXtjSQAYTiGGTCTcVMHX/GmloSVwqnKP
 0byKSbT31okPScuSzJDANNaYe9/UH75mfjEJGda1Zf6+8tImHA0fETi7IPftYG52IRhUq5jZuUs
 reLiDRjiU6WHNz2j3Zzervj7AGA/YyQp35Bv8xT8IOeeSG+ibPfiQ/RTdXUYYARHs66lSaChZwf
 i9Rj/xN2K5USEeBIQ2Jc7bdJJqkkKsVPAejrwDzKgT9BZRDNnB0Ooju6ooxeMIXAse5mOYYcdEa
 fGvOHGBwfSFTeK4xf2Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 phishscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170085

On 11/17/26 21:22, Rafael J. Wysocki (Intel) wrote:
> On Tue, Nov 17, 2026 at 7:27 PM Daniel Lezcano
> <daniel.lezcano@oss.qualcomm.com> wrote:

[ ... ]

>>> Sure... Are there any users of it on these architectures?
>>
>>
>> ARM64 is about to (patches are cooked)
> 
> Geert has a point though.  There are arches that don't need to see this at all.
> 
> You can add ARM64 to the list while adding support for this to it.
> 
>> Others IDK
> 
> Well, exactly.

Ok, I will send a patch to depend on x86 and COMPILE_TESt
