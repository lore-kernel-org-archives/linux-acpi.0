Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794491134;
	b=R/v4AQOks68kUJHevEi0z1TKt38NM1khLvzcBg3v1uicZI2NhyfMUkJ/RUlXUvomMpVK
	 0TZ1vobHOMCmE15NwJwvMLJr3mpGRtpHb83TpIz1ZplrzXlOkeOaUY+sxDkPMFTQWiRIX
	 ckf+K4kfWVDzoKCABTSlkeBLjVVsG/c0H6PFZTCvXl7BOBK+bcF/oO+T8wLkpcZxFrfjv
	 WAcrcVzwkyqsc+yrJocmSDRbjGrkU+/1LpB11wQOQdm4okFL6rnGXwSD0kI4m2gzbCJmu
	 bN1DcVU+dg9zJtKYe715XgdY7CeedzIH7HyvJc2WHvFYK1pCJ25EqTYg1aDWG4W1jfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794491134;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:From:Subject:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=SSHTQa6HyakUeWII5QwTPdRVYIzIGg3+WldbvYwS3KY=;
	b=DByuUoJi7TeuDX/mFwucwQuRtfc84K2uFzSG8HU+1TT3tCzYnSjMQbEFwwSpRDxxh07C
	 0MF+GHJwIug+y5A53G0DfQbh6/hnH9T3i82CMGLbUBgzpCLgETukgCStxZ+mi+oVhZ3LF
	 q29fUZuHdu61G8EwiGnzPqlpJgn65DNV3HJL4ZomgaZIZ2RMVdnjCAAxsNt6z5ydYDL9r
	 bIhosPJapb4/PHyK9gtFySGKxSQUrxarbthwe+Y4LKzg0yVjmO4W12c/IwEgZ/UFFbE9D
	 kzylTWXPiuhfBYLGeeFybM17onwNO/la71mZ3fBfhH1PbAV5TSh/JOOsyzlQrcuj3vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nj4sXmSj;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jQan9dsG;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6975B606A31C
	for <linux-acpi@vger.kernel.org>; Thu, 12 Nov 2026 13:45:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6975B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nj4sXmSj;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jQan9dsG
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ACBUS4v442333
	for <linux-acpi@vger.kernel.org>; Thu, 12 Nov 2026 13:45:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SSHTQa6HyakUeWII5QwTPdRVYIzIGg3+WldbvYwS3KY=; b=nj4sXmSjUAISGVD3
	5Nk0C06mgyyX4VE8uX40/BJCKpM4N16OAs60W/ZAciCWNlW8cAl1QpqJku3wdRCV
	jaNVGAOdjUUuQpR10aejveIzpUJQT8PBymo85eWtuqEUSeglS/Ms/z0SMigMOvNl
	vybNoXozdjlLrX10l5rJnPCv5vJks/LYxee96DMVmZnfQahU52gzDBLnbQdDl0Bu
	EnJ6pL/itJt4UalizLpynU+e8qTybWcuImpuOSrEEm+m32VNnSvU1VLNYmP1O1R5
	Ryz9lNmA71g14b97fB5GrZ+mqqmtJzyhxWcN9WYaHvzmRgvHD5GnqCGPb9U9rb6w
	tUNblQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hw7nc1p9a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Thu, 12 Nov 2026 13:45:33 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-943e8ff02d0so486766185a.2
        for <linux-acpi@vger.kernel.org>; Thu, 12 Nov 2026 05:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794491133; x=1795095933; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SSHTQa6HyakUeWII5QwTPdRVYIzIGg3+WldbvYwS3KY=;
        b=jQan9dsGKzZYYoQRa9U+IO7oLFWgzRMazYZTjkZoyVi8kFGfY8/D92E9jk7H30UXod
         DxsaEhHsXOanbgur1i1EPGv4ClXMWW7zxjXYjjedPDU53JA5j+UYgPzqitvulSqBSGoe
         jVbWfgq/Hce592/YDjC3N/4QqoOLwWlTk/GRhfJiZcACWntOa1ZISdCWHLyMaN9eEaue
         diproXsnxrLZrJkt/MSMdla/tEK8tzg/w1LrZJIPt0eOJgU8GaJh6r/vtD11ZPzFGa/l
         lhZpcbzqUv/xz3/S0mihKhafoacwVrECrArIWLkFSOTQU3NhdFUkfcURdi9B9ApJJgMr
         CT8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794491133; x=1795095933;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SSHTQa6HyakUeWII5QwTPdRVYIzIGg3+WldbvYwS3KY=;
        b=pkaiOPLmBVM3HwzgBgAdSNrsQgYeS22f34knvnkkwedyg+5QDj7LVVMEGKXpRgKUE9
         01qeOQ18TAFp+UrdEsLNxkEmsCB1KhS+ptYmydsFccDBXrrkNUM2OVIhbdt37l505j/R
         NrA7CGXjR2va3MkxjF/NglL7E9ARUAvaxOqZmVQ2OQp7kG5C/zkOzDcPPwk901U9f4QY
         JDRSHKq5mjCteeQTHRjXvAzPzFFbmjh2ctOcoZbX9LcivKInW9smcHTYK6pT7TPRIlCu
         Zt2UhcIEKavyytJEVCoOk4Mdo3raSzcMKh7A77/wgvT7J9z/UsrjW5T6TPd8uO06OQtW
         Pqgw==
X-Forwarded-Encrypted: i=1; AL+hErHjcKXVdEBio4WFNuHoklDX0VqS2KyvN8cvvJbpikL7KUiiLT7Oz+H5CDryiWnWbDUKnZCqK3P34d1F@vger.kernel.org
X-Gm-Message-State: APuU4Z9VWqzlSF/ZEngwMfdZYFp/vBj9u4zzXVCoaNyhfASPieKSYoS5
	y/RGm+plMmxtcuqTQvZjrOxeTcFgKMdcpgRjnEJOG3Akz7nycZbghZ02IpXooUGlSrSYVbR0TXZ
	N5wl0P6Zc5V7oLhnoR0dWK7WPAyixkuli4LQhfeKeXZ1RNiAMdJVbPerNwWVSkYX/
X-Gm-Gg: AYBFou0wKFDl2OblStydD6cKTR41Rpz9bYORoeWhvR0PcFo1Fy+wiffbAKDuDJhdU+o
	EP7O1gQwIUY/hmG0Ng6wp6A2vTUaIqLTnzpfCTV0bq2vv9XWmfDNI172WUjdgsKnGFLbVP1JvHx
	9lV+Rrwn4PEngWo3wLWkcVtG2AGJqkaPga2UA2hkshTRvhsY42czRzAcKoUAzgGUXEHgOWfjo8D
	URekTp0ZOAD1bm7bBIsKqAIfC1UbMfUaR4udZhUg/1mLhDIrev/9XatMcb++YLYJ7Ogj40xGBcz
	GwaWFHg2cFr/3WuYGmX6iP9V4NORtZvz7P4w+H8V3K3Uj1GJYmwTdiYyaBCTxcVK/sGRKv9kyrd
	IRC+AKDIVs7AviaxWFz8XzSYiP6viomt0gvZuwlK4EUhF1mVW/TPLhJcyJ3AuHoGYpRJ8kmnuz0
	/iG0nYatuTjK7EQfdcOIbpguXZ3/76RA8wsTwPWUqOPwXATT7r8EcMDkH+/1WM0jXXuJ8c4Pefn
	VjESRQoM1iYSNWQaYKDv4dphFFVuKs5HcqzW21TA9Y=
X-Received: by 2002:a05:620a:2b46:b0:93a:2611:270f with SMTP id af79cd13be357-947aff88b4bmr1027606185a.13.1794491132575;
        Thu, 12 Nov 2026 05:45:32 -0800 (PST)
X-Received: by 2002:a05:620a:2b46:b0:93a:2611:270f with SMTP id af79cd13be357-947aff88b4bmr1027599685a.13.1794491132056;
        Thu, 12 Nov 2026 05:45:32 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a62b303sm342113466b.58.2026.11.12.05.45.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 05:45:30 -0800 (PST)
Message-ID: <993586ff-a618-4a92-b95a-552e2ba268f4@oss.qualcomm.com>
Date: Thu, 12 Nov 2026 14:45:29 +0100
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
Subject: Re: [PATCH] platform/wmi: Allow wmi module to load when acpi_disabled
 is set
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Armin Wolf <W_Armin@gmx.de>,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        Han Gao
 <gaohan@iscas.ac.cn>, Han Gao <rabenda.cn@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-riscv@lists.infradead.org
References: <20261111131613.6290-1-johannes.goede@oss.qualcomm.com>
 <8382881b-f2d4-7909-d7d1-3a2c74f3b123@linux.intel.com>
Content-Language: en-US, nl
In-Reply-To: <8382881b-f2d4-7909-d7d1-3a2c74f3b123@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: E_K4fxnr3isuc7hJHCZLvh4wcxYUyVf0
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA1NCBTYWx0ZWRfX7Ntk5gp39gVV
 GSU6V14rNbN9l5AAJ40H43t9CuPIv48xwTll49nk7qpTydGcMhsTJR+IutD1mSP4RFcXMm2SR6i
 56ENz3C/FKz7zPzMMf6f+nd5vvaVlYo=
X-Proofpoint-GUID: E_K4fxnr3isuc7hJHCZLvh4wcxYUyVf0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA1NCBTYWx0ZWRfX9X74IjcOsJcq
 4xNnSXyiM5Tv0BQG5L2hy6pwkNfwKsJdWddGh6T8iCCHecgLjNlmykojWPBRd5MlfLzxoRSHxTR
 H0HECuiEQl/2G3SV+c7nqO3gNtJME6rw2ivlLfOdHNvNJUeVSej3PFXOT7kqY/vzqhBdsCbng45
 c944xeD5OOb0zSwuYwI0OE8ykZYMwaSPKAyU+eYxJmjeU/BFMNd6XpBBK2/n9qTKrttyneKxbra
 JHfHDWLleoj6eArMCSd9UrUIMfIqfNS8a3+LXiSnDV40FNJgUalvRut2VDVhfqQfcSkI2fmcj6Y
 TbLEZisfY3SIL2uHTaqTmo+gFozJR8DICK43xjzq6xZsNuVyyssazLS7ePfcqWaAHaw2Pfkj5QR
 ExX1htFftfPWlgIBAhXzSxpvzIio9ZYhb1pkR7KDlgf4rzq7YLUH4s4cfZRmGVQ8Ub5JcFwhO1w
 JNXFiCtrIH3xO2RuCNg==
X-Authority-Analysis: v=2.4 cv=A8b5rKWG c=1 sm=1 tr=0 ts=6af5c2fd cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=j-yhcRukXSKXep7fvDIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120054

Hi,

On 12-Nov-26 11:21, Ilpo Järvinen wrote:
> On Wed, 11 Nov 2026, Hans de Goede wrote:
> 
>> The core wmi module provides symbols which may be used by other modules.
>> These other modules may still function when acpi_disabled is set, but
>> the current behavior of acpi_wmi_init() returning -ENODEV when it is set
>> causes loading these modules to fail because the wmi module these depend
>> on fails to load with -ENODEV.
>>
>> One example of this is booting a kernel with both DT and ACPI/WMI support
>> on an arm64 systems with devicetree which will lead to acpi_disabled being
>> set. Trying to load the amdgpu module will fail in this case because it
>> uses symbols from the drivers/acpi/video module which in turn uses symbols
>> from the wmi module. Note the video module itself already contains handling
>> to still load when acpi_disables is set for similar reasons.
>>
>> Fix this by allowing the wmi module to still load and also register
>> the class and bus instances since some exported functions like
>> wmi_driver_register() rely on these being valid.
>>
>> Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
> 
> No Fixes tag?
> 
> Doesn't this fix a real issue and we want this go through the fixes 
> branch?

This problem of the GPU-driver -> drivers/acpi/video.ko -> wmi.ko
dep-chain breaking loading GPU drivers when acpi_disabled is set
stems in essence from:

fe7aebb40d42 ("ACPI: video: Add Nvidia WMI EC brightness control detection (v3)")

which introduces the drivers/acpi/video.ko -> wmi.ko dependency.

But that is from 2022 and was never a problem before, since booting
any modern x86 hw with acpi_disabled is not really realistic.

acpi_disabled however does get set on arm64 hw when booting
a machine with devicetree on a kernel which can handle both
devicetree as well as ACPI. So the real trigger for this being
a problem now is:

e2c1b56f3dfa ("platform/x86: wmi: Move WMI core code into a separate directory")

which allows this dep chain to now also happen on arm64.

I'll send a v2 with Armin's Reviewed-by and this as fixes tag.

Regards,

Hans



