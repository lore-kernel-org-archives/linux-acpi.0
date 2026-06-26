Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961D93B1009
	for <linux-acpi@vger.kernel.org>; Fri, 26 Jun 2026 20:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782507475; cv=none; b=O1xlKVpsnffk4O7KBd9Mzt6dznFI+u9PiW0wEoQji5JojL/CVHQdfX15tvUIoyh0xGzwDEDg29Fkkfp0ulxwgg4QDVLDzHwdPQA1gPR+pKDPc2DITXP97KIB95sa5yQjpRLZFLoiIcU2rWB0VaSuY9Y3ry39ZvJn+yLbwQD7gl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782507475; c=relaxed/simple;
	bh=1Mlqdx0yALmjRxStf7R8xHxhf5GtiIJdHJ/PGKKoFS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UeqjlmDI4DaIknU/zvhi9+7B2BAShkY1itltjPhui+w3+F88c7YOfE103VXMTlIQp3gkg8ZdlSgRwKAHzK0Ilz/ett6Xm50ua660nY1H537zImp77ZfKlzl9uRC9f3a9sNQ6+4jFnPwTaSHBIdmpujejFmWCV43EOfI1Z//XpI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j2Xcs9rH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CaQAi7O0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="j2Xcs9rH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CaQAi7O0"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65QJ8d9f2174622
	for <linux-acpi@vger.kernel.org>; Fri, 26 Jun 2026 20:57:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=yd7du5bvNXW9tUAU2kTjwJsr
	b2hTJirrDWb8BV4Ma7c=; b=j2Xcs9rH5ijerF/VZLQstRSueiY1yoyk0h05sPev
	MSHTJ9Lk5WDThq/f+Q55ViUkCvHrZ1gSFVddqPTyD/VBehY43Xi/D7d+LCoq6dwG
	dWA6KkwIDLJkyhfQcDEJyC4IM9pX8Yz2EF6EkMsnsjmXDka+iP7dybiWFt1rjU+h
	J8QFvdUdQYZVub2fvKeQLwTpDY5iRx+SMriiq1u4dUoIupdoLWJgYPNbYiTWCHqi
	g+zD9iOFlbk7GnUvhQSqoT67qSzYoHKmx/AH4QTC5MkKw/OEk4Sd6cadcFVQ3q94
	RWTB+9p96rpqGFkxNjzQA4nx61b0P1iLhyBZ4y1ImeRJpQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f1nggjq96-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Fri, 26 Jun 2026 20:57:52 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-921ed86ddeaso300476385a.3
        for <linux-acpi@vger.kernel.org>; Fri, 26 Jun 2026 13:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782507472; x=1783112272; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yd7du5bvNXW9tUAU2kTjwJsrb2hTJirrDWb8BV4Ma7c=;
        b=CaQAi7O0pJRlDy2DxBfFupchhfmCZ/1nnLmPYxGU5d1SC3DApgZkiS+fRJ5R3SVGG7
         w4a1nZtnDPNPk3a9Fn665leMsRxScPEtzrDe8H1NDTvPkaLDMXEa7TuJ2YFIVEIYVxf6
         3nNkVsgfMgBBQJecAssyuDXNjzW7G2fpyLOuHUs6nPp/noeppMORv26aRjCJajaR2yNc
         xOVsUy59OlXbkuvcJ7AMYbzz/cKKgnGfl7lJKLJnFlMRGc9ozq7q9zoHiwQONP51Yyyp
         CUJD2CsKcmACR5IeofbvfBlkJ0reTG8dYlC4wtA+GKtp0j/Rvwg4wnL746jiu+lNrFFA
         uyoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782507472; x=1783112272;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yd7du5bvNXW9tUAU2kTjwJsrb2hTJirrDWb8BV4Ma7c=;
        b=qk2+IZSCQsnYLgE+SxuqvwuZMLQkJG9/dzxWQS+aaWk7wNe7pD89slTMV8YyUgrWvO
         08igKKznN1YxkToNmpPL8rh1jatFqmXLlEkCTVnWhsxxamXkHv09PSisFGHcU8q64q62
         ozhE0ORYFKYk30UMPM3P7cQk3mY9f5z6YHFaEO4iE6aJOeHlS6HwAnY/J0XtfwAuUytE
         dxG5TY2Izcn4enjpR0nzCB2kIBXJC9tsn92jjhbQvzP0FeH6mitYvjqYoyAKrGpHvB/b
         lmlZMvM3B25Wd+hU7bUWqsVYLl7SRegwyAQNqSb1yZ34P4rP4LvYA4nR71A6JCczM8SU
         BUlQ==
X-Forwarded-Encrypted: i=1; AFNElJ8WaNm0w5JgjwgPx0xl1/IdmsogPf4Bf43cQHNDxhtyLnUxDG+4Jn751q7NR04fwbukVMeC7BuZ/QFp@vger.kernel.org
X-Gm-Message-State: AOJu0YyfZs0php5YxfmUM5wi8TdiNa9cfGWdja6l4/Z+Eb7H6rDdNZCQ
	D9oGD8Y20IG1hjM7a9fouemrmodgqX/WGFhrvPBVHWBJia7inW5qxiGcVBMjDXZ+QNbQ5Tsbx1R
	MN5+GBcUyNb6izkIC08taTDVP3sf7flOLVMlGjJ2hCziXv7y85t2M5AHxWyuS8ox0
X-Gm-Gg: AfdE7clOjruJWxqoivV6AHTeMfKgs+qGAAIRlezhircGzyBh824JFFq9c47KgAG177Z
	Ub8c0QWAh/rYHzC7knPNzt89Hu9Zqra+6SHGVshuvOq/0qLmiQzZHklbhRVcVKFy55UgwrzoJki
	K1LpMO8weyv/T+B6PhMKfkmJJ7+4k3Vvpbx6rDt7nz6uFJ/ZYPgGOANsUalHfHh8kdpMBecUEV1
	Wfll+cQNTjq2k3gr/hoE6prNsB/2mvXEI3HCKV7/JG2EmyU9jWycnPwaUupAMBZAsT0usGGO++F
	clS7o4iRFYkdzOeMV7AR79EdrNwbyvfM2/GdO/gPlOs4/ot13J5YdAu9J7mXxc5fZ/To6twT0X+
	2eUl9rTDRyBNuErsY9z76u3aL3+5RP83KjUm+EXYwmFjzr2sVrT5xR77KN86sBBudMBJzGOtfUS
	sPV5jupU3dafkRLKoN80zGXmkU
X-Received: by 2002:a05:620a:6302:10b0:92a:9d2b:1ccf with SMTP id af79cd13be357-92a9d2b265dmr434981285a.36.1782507471864;
        Fri, 26 Jun 2026 13:57:51 -0700 (PDT)
X-Received: by 2002:a05:620a:6302:10b0:92a:9d2b:1ccf with SMTP id af79cd13be357-92a9d2b265dmr434978985a.36.1782507471408;
        Fri, 26 Jun 2026 13:57:51 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad69585a76sm3638337e87.74.2026.06.26.13.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 13:57:50 -0700 (PDT)
Date: Fri, 26 Jun 2026 23:57:47 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Sudeep Holla <sudeep.holla@kernel.org>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [RFC 00/12] RFC: Devicetree-ACPI hybrid mode
Message-ID: <obvpvyx3kmzcdc5nxmx4inlpiqugjxdgzfzmdxzfqqy4qqwt7l@y2zyrtso6yk4>
References: <20260623145225.143218-1-johannes.goede@oss.qualcomm.com>
 <20260626-friendly-ammonite-of-holiness-aabefb@sudeepholla>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260626-friendly-ammonite-of-holiness-aabefb@sudeepholla>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDE3MyBTYWx0ZWRfX/sv+UalgBJGs
 KC3mADmCby1ERTTbn+i3j6rXQAFZmewAAdJ0ol7K1vBsdG7JNiawuVc6w7dZ4QYxt8u+C1ccBy7
 XhnKzwZpCWNZ+IjfltOZLSvvXLa7OxdYsdC1U98F2Bputyl73oNDGtJh7ap0j1t2J7EwELjhG4+
 cmGetnbtIdr6IdgnR2HwwWZOAWutLEYlSReAcuECymX3JF3d9TNS3zmwTpEqpb/QXJNLw2kBZdx
 vtUyWQ15dulJAXIXBf128WPsG1Gha+nAwXOoZI43AuNr0UEvlMCTonWwZXRSJ4uSPjl/OwA+nkl
 JyPZekeyxVNydtXmzSJ+OKujAz2oRCt0chZWlXst1d9u7T6MiIlTYIPHX8LWUVhqUHNa2b8HkRq
 TNZcdsV0t8vZ5sEZUDU4hXYeAmyHf4Z4nCSykiMeN+3Xmv35b0tj/5bUctCkWONfRl6kOYCiZ3X
 6tqgkKneJR7m+asHMog==
X-Authority-Analysis: v=2.4 cv=KNlqylFo c=1 sm=1 tr=0 ts=6a3ee7d0 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=NEAV23lmAAAA:8
 a=Fl7lxUCT7PhOQckEiWcA:9 a=CjuIK1q_8ugA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDE3MyBTYWx0ZWRfX9RCQA0GjqbDm
 XV/BGqdjvJk7Jhqwkk1xWdZRKCSdqOXiuHXHO8x3IAl4y+oIFbNVRDn+FhHstdBr/Tfn/XHaBlR
 MoYtnf8zijPh76BUu1THu4Y+oUt0wwY=
X-Proofpoint-ORIG-GUID: uoAppqXvxs3cUydii7ScD9erJaW3WKMw
X-Proofpoint-GUID: uoAppqXvxs3cUydii7ScD9erJaW3WKMw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606260173

On Fri, Jun 26, 2026 at 04:52:41PM +0100, Sudeep Holla wrote:
> On Tue, Jun 23, 2026 at 04:52:13PM +0200, Hans de Goede wrote:
> > Hi All,
> > 
> > Currently as soon as the kernel boots with a populated DT provided then
> > the arch/arm64 code sets acpi_disabled=1 and the complete ACPI subsystem
> > gets disabled. On WoA Snapdragon laptops where the factory Windows OS
> > actually boots using these tables this is not necessarily desirable.
> > 
> 
> I am bit lost reading the very first statement here.
> 
> Who is populating DT and why ? It seems that is the source of the problem.
> 
> If windows can boot with ACPI tables, why is it causing issues for the
> Linux kernel, any specifics?

Windows uses a separate beast called PEP, which nobody wanted to
implement for these platforms up to now. You can find a lot of ACPI
dumps for these devices at [1].

> IOW why is DT populated which creates the problem you are trying to address
> here.

Most of the laptops resemble other Qualcomm platforms, which use DT for
hardware description. In some cases, it is the same platform being used
for both mobile, IoT and laptops. It was more or less natural to reuse
existing support.

[1] https://github.com/aarch64-laptops/build/tree/master/misc

-- 
With best wishes
Dmitry
