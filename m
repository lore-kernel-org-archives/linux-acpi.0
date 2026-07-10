Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E623B3793CC
	for <linux-acpi@vger.kernel.org>; Fri, 10 Jul 2026 18:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783707127; cv=none; b=BrKsDeFig/TTExlHtlngXTSvklbL67twxxP9F/NG6p8GYwLiRDFDKG8OmskdCeNkR8ekz1xhA5xMUYQFWMWOK+nXsG29feX/mPxOimyAYlanhx4qsPJ8/ENS7KkTFtRA+x1YWeBp9sXBG5gV707SVB1aCstPw4wNfFOnY9kh6dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783707127; c=relaxed/simple;
	bh=iTFefsKyW4e1mPnz1L2I7Sk9lHm5oSBmmbcBqKlSPk4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VQSYKUyviHa+y7TIr3hVdh0nGwSCgHolCDkaE+dhnYk93Jg1SQMWaKdPOb+DiXDWHDK15tB+HopZbO8dRJ3keUiPMtc77EUH4RSbRSzeUipOVDtn12pcxwMbt/t0di+bmQj3sjAn7wUfSRbeq+g/y1NyqVuSfBdfeN/7A86rKh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MR4lXYnK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eHKNvKlr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MR4lXYnK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eHKNvKlr"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66AH3XrC1502018
	for <linux-acpi@vger.kernel.org>; Fri, 10 Jul 2026 18:12:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jYBrJjdKrOKbj3osoG4eQPla9/ybrU/AxjCqhdtwem8=; b=MR4lXYnKcyKDNO9o
	6T0eVBHrNaK/eRsohzffKoZ6n0QNhTkuPiDN6941TiDCoqyO877HAXV1FTrsd20L
	GhFiPws43ptjVYdAY2vgj9WFzSAq+xuMzKPr5kSOA3uJlKbjNPwcBXuYGcsYa0qA
	HrJPRWPNITDviy1e+NXKwKc0NB5jFfGT+6XkRx2Lu72cdq3ZnC6p4o5wq6BO0YZF
	e40VW/UKHk0fNyDQiYJzJD9XinzfHKwU49HdE4ebw8wDSOcUMxXpfcvVojY4q2zC
	yhfBFQF2JWlB9XdmUfDZVBVUSlCkkACq+oTQe7o+T43iUbI+wGUb3MM7/cIOZqDy
	xFVYTQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb3xvreub-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Fri, 10 Jul 2026 18:12:05 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38d7fcd1f66so1447429a91.2
        for <linux-acpi@vger.kernel.org>; Fri, 10 Jul 2026 11:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783707124; x=1784311924; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=jYBrJjdKrOKbj3osoG4eQPla9/ybrU/AxjCqhdtwem8=;
        b=eHKNvKlrDf0xAppEZsxmR0wF90MZT4/6zxJGhL5BESYl481IqAA2JRZoRGpZ3nB6aL
         Tcn5eawNrMMJrsBjh41AI4jBx5bfsYnW5VtxGvRPaRGN7cGqt8yeac2ZQLGcjmM9dHdv
         /qWLxzZy5lWAZSWYGEcQjB7RR3P9hEgzbsDO+RuqYk0Zlc7vtTfXVVU3L4TN7g8FI4Oh
         cF5sXqX14A7hHM1OyeWZusd2BcZqnE5fBy7MM9keIK4PBdVT9DQCbejiTugF7Q3a3Jhe
         wjM7Xqwkn9Pu54sKiWukt1XD2UG2bAP4c0trH8Bdcm4J+x+SDxs4sCCIltMli/kSbQEQ
         +bFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783707124; x=1784311924;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jYBrJjdKrOKbj3osoG4eQPla9/ybrU/AxjCqhdtwem8=;
        b=iil/0sL82XKv4dZBoRZpGcZC0SgCCSCNaO58HjsDfkigzxLUwGX3ob+rbw9XPH8Nl4
         geH1yxG1r2dxPEhvUW/c1IC7iXxfen9PotCt/fc0XQNm8F1Q8kghy7xNllbs9NMils5y
         rIHf5hAwxKSbYGv0kyJthL6LJwIBCqbmc07iZj4LNQb4ID1ILgaZkst9yhwHtFd/GvhF
         r9eg+xVqzpELY1ZsK5KiLlx4AF3PBwE6aFgG53sWR3hXnbB3X4okjZfcgh2DDQYuhD5n
         e5vOTLe41/wy8cgFH8PkXNS8nVbaqn8Vmq0wRgmN+BxaTbAZmoEKTHFcLhz+KCTPEC2X
         rzOg==
X-Forwarded-Encrypted: i=1; AHgh+RqpDiCZPwwhBaWNRk045eIQ1/WPcnao057Y0N3+URWf94R/NhxabYU5QF/KBwxzP+y0HeFHoQkVHrGW@vger.kernel.org
X-Gm-Message-State: AOJu0YwxPzfkerYMBgAM2aUlmpabf1T5vPa5R7lFyUZxZi4RqVZG4BeP
	Z7bKJi4rtqEPQD3c0DgXaKhTlDY6YLyu0KwfdAgYQloHQ6HaYVehKlHoxB9WWI/XmXPknS9TXfU
	PP+yLZsEsew66nLaalmaaIaXR/MKTCP0RJ6r6sHhRHdt75Jba/PQifzUaLURbOLbU
X-Gm-Gg: AfdE7cnzsztojOsCx3js0WV56vOZ24c5s4nrnOISir6Vdn4LbBrApkrKadeUAi5ltOb
	eDn6dk0ydtlHeFeQGSNuh3HwKK9Ao40vyWJr962c1oc55FfxV+lpX+N7NaKPRFniyAFFQdDZ2dR
	Yx0l0WUfOL3d3X6ZHi+LY/9r0p4CvMo2YhNCLGbSxUTZLT0kC6i3uSWy7tWPkQeqTH4cwrB4fuI
	BZ7j1kIlVOAQnRPCJDuIxLkPnIZ4/2Ld+YTx7LDq5k/ZykxOxk5Ss/qm2o/ICFiJHr6CnkinqqB
	P3hLOlhlwsA8V+1Ur6WFJ1dJlH7VYZ0SLLB84o0S6xJqJezejmeC/gGjp6Mj+qrqpn75AY9O2D7
	FZsoJvtRjtZJjMFxLgno99HknivG+pp6sjEet
X-Received: by 2002:a17:90b:4ed0:b0:37f:bfd6:8b40 with SMTP id 98e67ed59e1d1-38dc74c25d3mr94868a91.5.1783707124421;
        Fri, 10 Jul 2026 11:12:04 -0700 (PDT)
X-Received: by 2002:a17:90b:4ed0:b0:37f:bfd6:8b40 with SMTP id 98e67ed59e1d1-38dc74c25d3mr94846a91.5.1783707123891;
        Fri, 10 Jul 2026 11:12:03 -0700 (PDT)
Received: from localhost ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3117d847e17sm41239927eec.18.2026.07.10.11.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 11:12:03 -0700 (PDT)
Date: Fri, 10 Jul 2026 11:11:59 -0700
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Hanjun Guo
 <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@kernel.org>,
        Catalin
 Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Rafael J
 . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        James Morse
 <james.morse@arm.com>, Ben Horgan <ben.horgan@arm.com>,
        Reinette Chatre
 <reinette.chatre@intel.com>,
        Fenghua Yu <fenghuay@nvidia.com>, Jonathan
 Cameron <jic23@kernel.org>,
        Srivathsa L Rao
 <srivathsa.rao@oss.qualcomm.com>,
        Ganapatrao Kulkarni
 <ganapatrao.kulkarni@oss.qualcomm.com>,
        Trilok Soni <tsoni@quicinc.com>,
        Srinivas Ramana <sramana@qti.qualcomm.com>,
        Niyas Sait
 <niyas.sait@arm.com>, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 01/16] arm_mpam: let low level MSC read accessors
 return an error
Message-ID: <20260710111159.00001367@oss.qualcomm.com>
In-Reply-To: <20260710144520.917375-2-andre.przywara@arm.com>
References: <20260710144520.917375-1-andre.przywara@arm.com>
	<20260710144520.917375-2-andre.przywara@arm.com>
Organization: Qualcomm
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: ZxR3SmxrBez4z_UlZISOyYFJRS2tfSeR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDE4MiBTYWx0ZWRfX74EDV8Z48971
 8J75s+WpfHKIegc+uwiq5bX4jxDo/pSJ6h9aF9s7QLzkSBWcfQNwm1u5Sil/OrWxAIJJ/XigF+U
 XWp9qhqt4GGOpjvwrdwxYRBVzld0M5qtzL4ceJxa0x9lFdU6vEP4sCgy5ygpigYwfpjCA6asAjJ
 8Lt9mmZetQHp17QrtkF3W9CIIkoqesAN7rfQYf4TpcCn4oebtHAJeefvLBsQvG7ODOVGi5/02cF
 uKhW3rgaWNZgT6wJ5wSXR6cQENqzqy9ROYp6OOK03ocHk2xmRUG62CLdzed50AKp6EaYbLNE/qN
 Qn1/FT2dSQ73DN/5bDLXL/VypfZGNA3qvzK+Fq5ffy37WmDJ5Z37z6tIgt3jNH21orfO4YLV98Y
 A3RCNOh4V4x1byCzakznZlqM6Nm327diJ2ORhvzf7aU/1Rb7Sg7qYMoX9XFbjDUuuUFcrq2ZtLG
 071vI/nwdnG0oOmUqvQ==
X-Proofpoint-GUID: ZxR3SmxrBez4z_UlZISOyYFJRS2tfSeR
X-Authority-Analysis: v=2.4 cv=HInz0Itv c=1 sm=1 tr=0 ts=6a5135f5 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=7CQSdrXTAAAA:8 a=q567kdKukifiGPTRiikA:9 a=CjuIK1q_8ugA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDE4MiBTYWx0ZWRfX1gdElL4z0SmL
 ch601TSF7NuuXmiSFFyvKF/XXXpjrffBdA6O3UajAm/9MvPc55ylT7Lc9F/vMxJnTpilnd0+6z/
 8F668Kmr/7RG3Ph60gAo0zSY/VQCOS4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 clxscore=1011 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100182

On Fri, 10 Jul 2026 16:45:05 +0200
Andre Przywara <andre.przywara@arm.com> wrote:

> The upcoming MPAM-Fb support does not use MMIO primitives to access an
> MSC, but employs a shared-memory/doorbell based firmware protocol.
> Its complexity means that is must be able to handle errors, whereas we
> always assume an MSC access succeeds today.
> 
> Change the __mpam_read_reg() low level accessor function to return the
> requested data through a pointer, and return an error code instead.
> At the moment this is always 0, but this will change with alternative
> MSC access methods.
> Change all users of those MSC read wrappers to comply with the new
> prototype, though at the moment without propagating any errors.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Why do it in this order? It seems like it is a path for some code churn 
from patch to path.  If you started at the outermost calls and
worked in adding error handling at each layer, you wouldn't end up with
the change here to add the parameter, then the same lines changed again
to stash the new return value. Those lines would change just once.
Maybe I'm wrong though and it ends up even messier.

Or as you suggest, maybe just squash the patches, which will also
remove the churn.

Jonathan

> @@ -226,10 +230,11 @@ static inline void _mpam_write_monsel_reg(struct mpam_msc *msc, u16 reg, u32 val
>  
>  static bool mpam_msc_check_aidr(struct mpam_msc *msc)
>  {
> -	u32 aidr = __mpam_read_reg(msc, MPAMF_AIDR);
> -	u32 major = FIELD_GET(MPAMF_AIDR_ARCH_MAJOR_REV, aidr);
> -	u32 minor = FIELD_GET(MPAMF_AIDR_ARCH_MINOR_REV, aidr);
> +	u32 aidr, major, minor;
>  
> +	__mpam_read_reg(msc, MPAMF_AIDR, &aidr);

This will need updating to handle the error.  If you were to instead do
the patches in the opposite order. So add return value to the outer
most calls that is always 0 then work your way in it should end up
as a fair bit less code churn.

That update is in a later patch.

> +	major = FIELD_GET(MPAMF_AIDR_ARCH_MAJOR_REV, aidr);
> +	minor = FIELD_GET(MPAMF_AIDR_ARCH_MINOR_REV, aidr);
>  	/*
>  	 * v0.0 and >v2.x aren't supported, but anything else should be backward
>  	 * compatible to v0.1 or v1.0.
