Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB713382F3
	for <linux-acpi@vger.kernel.org>; Sun, 28 Jun 2026 19:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782674603; cv=none; b=l/MnXPI8OjSZ6n6B0KaYj1adzkA4qk+16Gxt9fAIjO/iDBLrsv8GPt9dz/u+mEY3itnLcj85ywe7KMO5YNhSVBx/rgw5mqwWt1tUNc85pQeUKaTeaZ41jrfBTah9x6U6FCMwbvigbV3WFeeW1B9O0xCwv2uF6yzu42jIawk+NLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782674603; c=relaxed/simple;
	bh=MYgSAuMhbxiutVM5DXxwk58W4oicMwjhPZrOhiMr8NY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ArSepLAye7iBgFP4CQx/gqzmBSMPXNw95fSNtI4gVYKZQ17m4FWaexeF4QZLY/vYd4Uhf/UyLK2tj8Zvh4IKtqlDMxpGrHnIzEHutiJ3gb8BSp9W2zSBRgXlKKsdXnd6EkYbZh8ezlmUEuACwk4mYYVjlMmj6B1Fb4Yjjb2qfM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oTHW0JZA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eMz+yVBf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oTHW0JZA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eMz+yVBf"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65SHj2AL425714
	for <linux-acpi@vger.kernel.org>; Sun, 28 Jun 2026 19:23:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Dlxmw3piWy9gqO1kMZlq3gPc
	gqxSTVsCV/CnysTfKpw=; b=oTHW0JZAJxv9OA8a3iGO/yV0kBlvo0XVEpd0eRKx
	G/okrLOQx4PGr1zKlsVj+Tp3Qj1mmnQq/c0BKqYLtERitSHKnyZqWfefXHALoS/P
	ZxT3JihsDhVDiV/ZecOSjU9QxtHQsewspFBnuXN9RmsI8EtwEUiB5MxEJhb4DenF
	n9rULAugnj66TrgijHU6pOTCsYXTJ5GBhcyyXsil5SzOidKT3B9oUpRTMm8hGdk7
	AzOVrwkeXXFwhwY4+vyMORANjFLqk38hwIyMUwhC/6LUtRCk+xCklHVz/869dPqj
	aBc9jX2AzlK75WIKlnNGmr1JmiNT/zi0cqkgpNSlQt/+Zw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f27333gpe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Sun, 28 Jun 2026 19:23:21 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92e538afe65so13247085a.3
        for <linux-acpi@vger.kernel.org>; Sun, 28 Jun 2026 12:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782674601; x=1783279401; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dlxmw3piWy9gqO1kMZlq3gPcgqxSTVsCV/CnysTfKpw=;
        b=eMz+yVBfTK6X+YY+ouduUkqSZH7JfVDCMjJBIynfpVfU2dBYqAIRYcyDf5D1K1NKvp
         Cbz2u+NjugApIvfwNASwr0lnScaEbqy7tWfauFrztdcx0W2Ogzm9nwbs9gVh4JCM1Ehy
         XU+xtUbdqGM9292HsmFj5S7gNU7hd6uCzAojR65y8aG82VJUm2fUxxnnYfIfsMtC4FyV
         dcW+41Tep+wQJdo5oL0vPjQ2aKmcLrBt99kPnJbuOHPXGHZFDy57nQb9iL67XJmQSjWN
         jqvOdXOjYPXicflTPk2yKuYz9JDi+8ax8m/DXafeQJGDiLOqN1CqNCmqz3Y0HAvPi/JU
         145Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782674601; x=1783279401;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dlxmw3piWy9gqO1kMZlq3gPcgqxSTVsCV/CnysTfKpw=;
        b=BB+jqSOXMSwW137pDxkf73FMvXKK2hDVAdlAiX1Kn+CZn6E+SjnhlaRB9w2KJw2c17
         rj4ziboPILfaqAKt+1nqikenU1VUJfWM+hVBLqr1p48WiHCSHIb5mcn7fydFaJSbL8Zm
         CEhhVbUYsWy1iy2RAE1LNK9hwTenJtbX59HsK+hqmCoe2X1vaiFBLkjYIubemhZAWF52
         g6l9rwFdVr4HZ859hKb4HuuPuD6MoHlqJakcNNfg6nzQ4l+DcM/midxtM8tGuVwQIYZp
         iV+Dz8b4NUhZ5kKmaT4I453fB+d//KDWVrlefwRiclnG2k7OojLrF27dMp6naMDkdvSf
         ke1Q==
X-Forwarded-Encrypted: i=1; AFNElJ+W7HDpcfv3kOJEVSrYjusOHFYRZ49P4CSiLWJaowp575fg1ME/61JR/U6aGIvs94/gkkjqoL+0IEXR@vger.kernel.org
X-Gm-Message-State: AOJu0YySVvUMCH2h0n+g3Wh3dt3IEaiDnAPEa19TYhWU8hkTTJdePnij
	gvqiptLQNgnXWLJxwroeKJMTsTGfwSwxAgq2dM/MBupfkK33kodfoKr28NnneLT/HQa+HgUE5G6
	LfeoN/19qPXaNQqpragTI3jjVsCG5fSVVP3O5z3vRWlxmJXDbXRhfwwyvh4zDX3JB
X-Gm-Gg: AfdE7cnKBFRZjeN4/cpTi5p5h677XZtS6bozPEZzGG40Zqg4uvWpxrctVeCPXELPK0H
	SczkknoYjw/n7IAMsk/Y5PAz6ATtzhi1wpRcXuIqctzOXnU7/Y7bwOdbzyjPYyJlxxPbPiJvNdx
	Q0qhD0lYmZRkgmjFycF4TuYnn6lgrmfiT1a4Kx8WYqeN1ApENHab8Ma9uppx7jplG6Xy209RhVS
	TJugST5WtWFzMtXrq+JBJ+uan/hK2epLvWUdx37xd7iyfhR7VszeCdTBafNQxBaXpCoeAfM1xib
	7Vxijv28qlwu0Lj1/IlgAkOlxMsib2eDNnNQXwHgkiQ7aC14HvCST89dCFQKhjYFhmOZyuHjrF3
	ohcLYp3zCk1Cq+JWcFXngB8hibmqX6yMBey4Qk87BSdmdGiaApfO1U5LrS4ctCuVxzBeuAtKNQ6
	AtDrfc4glJJCalll3hwki9BPmR
X-Received: by 2002:a05:620a:44cb:b0:915:9047:940b with SMTP id af79cd13be357-9293a2ccfbemr2196869085a.1.1782674600952;
        Sun, 28 Jun 2026 12:23:20 -0700 (PDT)
X-Received: by 2002:a05:620a:44cb:b0:915:9047:940b with SMTP id af79cd13be357-9293a2ccfbemr2196866585a.1.1782674600447;
        Sun, 28 Jun 2026 12:23:20 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aeb0ee9f6bsm1193080e87.54.2026.06.28.12.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 12:23:19 -0700 (PDT)
Date: Sun, 28 Jun 2026 22:23:15 +0300
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
Message-ID: <2dbfkh3djdrvklsin7zcy53g3wpc76dd4iosxgahbd26zssmx5@zpkplzscllx3>
References: <20260623145225.143218-1-johannes.goede@oss.qualcomm.com>
 <20260626-friendly-ammonite-of-holiness-aabefb@sudeepholla>
 <obvpvyx3kmzcdc5nxmx4inlpiqugjxdgzfzmdxzfqqy4qqwt7l@y2zyrtso6yk4>
 <20260627-miniature-skink-of-superiority-234091@sudeepholla>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260627-miniature-skink-of-superiority-234091@sudeepholla>
X-Authority-Analysis: v=2.4 cv=F+FnsKhN c=1 sm=1 tr=0 ts=6a4174a9 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=B8OEgOhrbld77uko4dQA:9
 a=CjuIK1q_8ugA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: kxsa3mCmfRetjS6RF0H-e8fxV2A3LTMh
X-Proofpoint-ORIG-GUID: kxsa3mCmfRetjS6RF0H-e8fxV2A3LTMh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI4MDE3NCBTYWx0ZWRfX2a8TuM3cUye6
 qBRtu7I0gyLNPIEdxWvhPdfAFub8AiNvkKDdRs5O8guljD+eBpfT1vLBrX+dQNifdcCcanPGRD2
 oA5w83pV8XDoDPqAEyTzockKSgs1FiAUNXW0FHjxwR3wx5ugf4+CBEr++FESC86MNzum3WpmqGZ
 cs8sqg/FX1tYHFZjLektMicp8rEsSn+tXjVyNDe3fot8FMMhP4zS+3ExOLbrawG2utjaQmt3mM6
 MQm7OUw4GYAVYRQEU4BTHNETssdIHzyV+nhQyUIG3MDO1p9B92Lm8tBaglbgJuzgXSTR4hfm7zJ
 VklGqeQ2m0EyJoR+La5wbK8KyOJF42jQ7dNogQDuhCT7tmZorVYAe2ZyBdUf3Yd+0sIueLf1hhx
 QdzdVa6FO9ope13H2whGggfg2wsL/A06k3JYgVh47WnLgjKsl5zEhYmDc9N6WG1awZk1/jBsGtf
 7nd50poHmk3rCSGXL+g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI4MDE3NCBTYWx0ZWRfX1YgZEIbovVMv
 pUI0BvzIuxKzecB5TwFqmzYxIhOpXTcMRl9YJ9xD1AKP461bHSUPb2gpkVrPRdcUXPe2VfQATq7
 VifAenVY3t/Huq0v/Ho2GVqAxGTpH4w=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-28_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606280174

On Sat, Jun 27, 2026 at 03:12:31PM +0100, Sudeep Holla wrote:
> On Fri, Jun 26, 2026 at 11:57:47PM +0300, Dmitry Baryshkov wrote:
> > On Fri, Jun 26, 2026 at 04:52:41PM +0100, Sudeep Holla wrote:
> > > On Tue, Jun 23, 2026 at 04:52:13PM +0200, Hans de Goede wrote:
> > > > Hi All,
> > > > 
> > > > Currently as soon as the kernel boots with a populated DT provided then
> > > > the arch/arm64 code sets acpi_disabled=1 and the complete ACPI subsystem
> > > > gets disabled. On WoA Snapdragon laptops where the factory Windows OS
> > > > actually boots using these tables this is not necessarily desirable.
> > > > 
> > > 
> > > I am bit lost reading the very first statement here.
> > > 
> > > Who is populating DT and why ? It seems that is the source of the problem.
> > > 
> > > If windows can boot with ACPI tables, why is it causing issues for the
> > > Linux kernel, any specifics?
> > 
> > Windows uses a separate beast called PEP, which nobody wanted to
> > implement for these platforms up to now. You can find a lot of ACPI
> > dumps for these devices at [1].
> > 
> 
> Agreed and I assume that is the reason why we want DT.

Not completely... Using DT forces us to reimplement bits and pieces for
these laptops. E.g. drivers for EC, battery, etc.

> 
> > > IOW why is DT populated which creates the problem you are trying to address
> > > here.
> > 
> > Most of the laptops resemble other Qualcomm platforms, which use DT for
> > hardware description. In some cases, it is the same platform being used
> > for both mobile, IoT and laptops. It was more or less natural to reuse
> > existing support.
> > 
> 
> Sure, just use DT then, why are we even talking about mixed/hybrid mode.
> It gives no incentive to OEMs using PEP to get away from it and use
> standard ACPI or improve if anything is missing.

Well. Here we are talking about the laptops which were being sold since
2018. I doubt there will be a UEFI update for all these models.

> 
> So I don't like this idea of mixing at all. Use ACPI or DT, make up you
> mind. You can't expect to get the best of both worlds if you are not improving
> the missing parts in either of those. This is just a shortcut.

So, if we need to append the DSDT, what would be the best way to do it?
Something like Surface platform drivers, providing extra device nodes?

-- 
With best wishes
Dmitry
