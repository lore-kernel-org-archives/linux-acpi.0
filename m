Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C804034E746
	for <linux-acpi@vger.kernel.org>; Sat, 30 May 2026 13:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780148091; cv=none; b=JCsolpd0xVMQI7P7B6mF3GT40KmceihYKcR4RhsUR6Dqixz+9EAw+BGr9EwDqVDNtDVskpczaPSC3mFejxOrqqB151OzL6IjtQjd+lDL0Ho1yERf+E7G7gnTQclx/Bp82U1Ih5MNhQ9N29+5XO2Vcxu2H08KX/2bZQzlWIWsFD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780148091; c=relaxed/simple;
	bh=nZm7/KrAFnUmw0HLeCbq5IVzJNNGM1ZDj6512w4P8Y8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Lshjyqk7bGVOC/DBAg0xc6zdd9/1koKKEi6jLKPibmzmKWi+dhYzqJ3ZUmTCwqYcHL9T1l9MUeuHSBXT/PMyovy48TMRvVzrAfVzMBDALdYcewRnbEpBVGKCCrCx/F7lV5N6xG2u8iGIcLGpbfyJYVt/H2LyrnJytyrnFq88cZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CJk4ZQAw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZYlsJ6DY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CJk4ZQAw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZYlsJ6DY"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64U3QREd1400718
	for <linux-acpi@vger.kernel.org>; Sat, 30 May 2026 13:34:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vZoiK8MxIGVbxIKBU/zLhqCKZIIFuB7l/xTg1Y+vmAc=; b=CJk4ZQAwCqxaXy3r
	L2HLKZg9u9DRzbofSzp0fLi+FRrJG350s7E78UPm9VzTvligyzWOUzAj6ef0VKP+
	I9pKrRDQs/e3HDhpl7l5bOFe2NE5MoT2nWM6QJS9zW0gUHB0sQQQbVfbRCr3vcMW
	znMCDkJDeCwYusRp/DvZTQXMMn+4DSz608FBT9gnWulhfuHUT1/hlMBCpTdua9HW
	LfS4Kbvz8z0y1hiN8OWnONUwPVHDoZKyZw0iMpPk1P6I7JdFOxGHuWmOHEaKL22D
	xUgyR/H1xF7XY3xmN9sUeyGnaxsjnP0eAfYd7CgSauGF4NZxRzQSRErUmrAqEADV
	9VDH5A==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efqyus119-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Sat, 30 May 2026 13:34:48 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-516dd6e4ed4so166355221cf.0
        for <linux-acpi@vger.kernel.org>; Sat, 30 May 2026 06:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780148088; x=1780752888; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vZoiK8MxIGVbxIKBU/zLhqCKZIIFuB7l/xTg1Y+vmAc=;
        b=ZYlsJ6DYJKiykTHVfesJ/D34RApF97+DhNyv4as7iNwWp2muTAw1kC4LOHeEuNmSsf
         RESKzKgBG0YFK2cd39gjOEtcrdoxdWPjac+gFtli9Cfhcl+hdYF5VK8NVCt1m+uip7FH
         O2cQDsm0EpN5RhJXBPq++Biu1oimi0mOhUsRjR0K+iPjUZV7993zIFyTVaHDPIiPlOBP
         rqWxtc/hLUDMAOnBmnK/X+cXEGKCJ4IKED7Yg+QcP05FBClehakMsb+8klorIRmhKEPk
         hfkCUS8AMbW5tRkRf+BM93pQ/SgL3x2bd5p8zf6qIvx/R6PVr2K/8nVy7i7AWKSlK+CN
         9RbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780148088; x=1780752888;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vZoiK8MxIGVbxIKBU/zLhqCKZIIFuB7l/xTg1Y+vmAc=;
        b=gmKB/iduV8po7z6jiiGooETihoj0IUKDSXLra0np1ddWf2xklDU7OxLqdP5TJYLcij
         MoXTaPHLn8xeoatiooh/3JyL6cWFLnfyWA+uZEBuesWb7JC2oCHXrdEddRQJuba5+QPf
         2Eelwy/Xlqbd0oWwKfFEAdD6M4R74H+RuUVx/g4h8kwrNzZycjSIYOQcN3dh78XVjuZU
         yOd9rlBiPgEZEx5poURFDP0M/8hKGcw7Lou4UZNeYGT41aVJNTpPczC6yXPFUx/j3CIo
         WWcjWIg5l6cRA8wo7TI0hbOJP0Q4u88uOuu/K826TrT/Yna/9xTk6KM26xr8cDsszo7v
         WAjw==
X-Forwarded-Encrypted: i=1; AFNElJ+2djMCvF0RfEbmnxqeKQCArxjGaKIppGpIXOONBT/GCSyEtWZdcjBGXYvSXPM9+1ezRiltEOaYvWiE@vger.kernel.org
X-Gm-Message-State: AOJu0YxNpm/5PTl0Fz9eGuT/6jOOlyC7vR1J288X00X9LlAAHR2OqXtx
	/x4Hp9pZF5RVq4EMQt/QLvpXVhq65W/xbWmtr4e1pdf1eFq734rEmzS0CN4Ecd2i36yPbOlAlzd
	EJdQHyEgpeLPOgbbj55UnbHyTkxrG+fV6Q4FASCcrcT5xDyexcz0ePxpvY2ldHsRW
X-Gm-Gg: Acq92OHNvTe2mkGS/15kWMHoczW/ZOG+oF4k9YPosXFazHX2yKnBmIGmWhKlxA5bRSo
	iXmrBdn2Pt99ReLoeHdFAa+YUsk8MZ9r9P8qAVSmgKgm18KiFrDUowjxUEMjYz0Pmn89PbrQCTE
	3DON+cF2lCkH5xoETz9yee2iIpqb2lnzobmkQgKvO/pJqKSgi7QnpQXoaDq0JMrlulYiemyHpo+
	dQQZmW+QJ4fGSBtB/TZi/dnJ4xFWUwMwSnNOhe7DcSDhitMMmr/zs682YemaJuj7aMs5fbjr5Q8
	ieUDrIPyi67rJME5C8ki61JomlD10eZo10NKyzF/xhXTY6rRFSOu5Yq3MuoPAbW123PreHpEHKR
	+K2/4oNxF2UNAiiYOHxnp64yOgfZtvGFl6dkNw4XJpSIx3igfhi3k3bWoKdExpDrn4Agv/OCgXD
	i1vTB1432i28ZQ1DiKEsUKDejnu0fODgIaDzpfItBrU2pVRKcfQUhxkyjhS+XpO4XzT4MHZw+oa
	fg1Wgt7WbSJeUm/tii/aoOB8f4=
X-Received: by 2002:a05:622a:4c8c:b0:516:dcbd:aab9 with SMTP id d75a77b69052e-5173a67adb7mr54009791cf.16.1780148088260;
        Sat, 30 May 2026 06:34:48 -0700 (PDT)
X-Received: by 2002:a05:622a:4c8c:b0:516:dcbd:aab9 with SMTP id d75a77b69052e-5173a67adb7mr54009351cf.16.1780148087807;
        Sat, 30 May 2026 06:34:47 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-beb4356b901sm38478066b.9.2026.05.30.06.34.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 May 2026 06:34:46 -0700 (PDT)
Message-ID: <8503d297-68ca-4bfe-bbdf-537a85890d86@oss.qualcomm.com>
Date: Sat, 30 May 2026 15:34:43 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: johannes.goede@oss.qualcomm.com
Subject: Re: [REGRESSION] Toshiba Fn keys + lidswitch
To: John Veness <john-linux@pelago.org.uk>,
        "Rafael J. Wysocki" <rafael@kernel.org>, Nick <nick@kousu.ca>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        regressions@lists.linux.dev, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        todd.e.brandt@linux.intel.com, xi.pardee@linux.intel.com,
        platform-driver-x86@vger.kernel.org, stable@vger.kernel.org
References: <E2OXET.4X5GTP37VTNC3@kousu.ca>
 <CAJZ5v0jVQyWYqPo_MiUwNQb7FLNR_Q_++Xq=xA1owcHpcjN=OA@mail.gmail.com>
 <bc9d5258-d4df-46a1-bba9-de3486f722ab@pelago.org.uk>
Content-Language: en-US, nl
In-Reply-To: <bc9d5258-d4df-46a1-bba9-de3486f722ab@pelago.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTMwMDE0NiBTYWx0ZWRfX4OoG3F1z0Wz9
 C9kdn3ZIB4ZSBMlfniG3/W1vgkoDJIRDo02oCTrCQxUvOOIob939ANaRaivF1J8VhazuBgll0Jd
 8cIuOzQ0IhfkwVyO2HU/oSKTy9xAXXIeAb+kgm4qqVfh9uEIbjfAcqFiBOhEfNzN64KUX5BR5fQ
 3DrNeWEzC4wLF+B2WrJjEhyC73vykf0Ll+1Nk7Zsyorg3SX7NCItv0r1t/I7C925jZhnbRzmhqu
 7u5HN0lGTagd1UtorfWltTowfhmxUJekGzEBtvxZVIZ6vGEN3ewy/TNr8oKG5b7a1Dlb9ftaoBG
 VV8CPGgptKnCLFqNobHqhSyFLyEPcpOMwq1mMYTpEDuLrQb9zT5c0QAXT4MqmE1qNAt3R5q4QKR
 oprPTmG7ROodC9HACy9UkRWIpmfKnLq7665A0c81vqy+4Mq3vH4+TIawrNi8e66Uu0/HY/Pr+Ka
 BgWY6nRPWV6XW1QFPfQ==
X-Proofpoint-ORIG-GUID: X9AQQCgcsDZ4doD8iU-tbmAffTiAJ3jK
X-Proofpoint-GUID: X9AQQCgcsDZ4doD8iU-tbmAffTiAJ3jK
X-Authority-Analysis: v=2.4 cv=B5uJFutM c=1 sm=1 tr=0 ts=6a1ae778 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=jmGAqP9c4pEhswuVvyEA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-30_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 impostorscore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605300146

Hi John,

On 30-May-26 14:19, John Veness wrote:
> On 19/05/2026 15:08, Rafael J. Wysocki wrote:
>> Thanks for reporting!
>>
>> I think that the problem is acpi_setup_gpe_for_wake() doing too much,
>> I'll send you a patch to test later today.
> 
> Hi, can you release the test patch publicly? I'd like to test it here,
> as I have several Toshiba laptops whose Fn+keys don't work (apart from
> vol+/vol-).

In case you've not seen it yet, Rafael send out the test patch
publicly later that day in another email in this thread:

https://lore.kernel.org/linux-acpi/12896447.O9o76ZdvQC@rafael.j.wysocki/

Regards,

Hans


