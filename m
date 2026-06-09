Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79332344DAD
	for <linux-acpi@vger.kernel.org>; Tue,  9 Jun 2026 14:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781016366; cv=pass; b=QKmIjFe2nVbO9e4pSm39AmGt3jiZGJgwMO4WVQ1tQFAa6YG7spDzV57VuY/PkyIptS0JQ05iVwoT7KG1/6WkdgF/WqTDStPUg9UIfLSEotmUr0Wxh410XQZ3ebiH0ItFX/oSFN/Ici1Yc37UMpSuyPE2RMvXAPa32ADa8DTlct4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781016366; c=relaxed/simple;
	bh=BkSambIUQitGRlTvVm9rbPHKE+ioSB6QhEypVQhx7ss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LDlVD5tGdIxv2Mg407vZ+svUetHFomsnNSscoIldsi5xqy8VbL7vyelmIokTFxnF8AuzPADkBQSPZbllTqPUZiezQwDnwN4BqIQJSYjwdGasqoNv1kGnI3izvjOCQ4NvIC08gibf3dYumM5jPjV8zo0U/vHK7h73bKcrwdn93Vc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YUqcfUNU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DMLL0i7I; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YUqcfUNU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DMLL0i7I"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 659ClLwt2249450
	for <linux-acpi@vger.kernel.org>; Tue, 9 Jun 2026 14:46:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=BkSambIUQitGRlTvVm9rbPHKE+ioSB6QhEypVQhx7ss=; b=YU
	qcfUNUaOVUkovl/5AssMnAttWPY7SDezAdkO+w640KWrdDbDpxlMFLt8DDCQtOjc
	+GKx50SzLMy8zXgyM7r6SadFmanGTCCh7Y6CNvOHlCuk5QzVyVhgliKcnHKdVXmD
	LHJOQTbG1Jl9u1IVSLFyut3VMqBblidslvPIklCQxjOKdvhp+hQKHcPB1D48e31v
	xP0VHjZ6VJo8RfJSRmq929I3fyQ45t0Xb3iClFnOMwR0OPWnJ4pZGWf1y+awNqtD
	LPFHaxwjMu5LiQ2a/EO+zXdnCzNmY2kzen8bQG/C0g/roSiKTi0NDEoSqxzcFxPM
	AGOBDDAAltAUPagEOjNQ==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com [209.85.128.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epg3whgkn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Tue, 09 Jun 2026 14:46:03 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-7f010ade153so43937417b3.1
        for <linux-acpi@vger.kernel.org>; Tue, 09 Jun 2026 07:46:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781016363; cv=none;
        d=google.com; s=arc-20240605;
        b=AzwMrZ0IdoUfQt+f0vjMEHdFZ5XN38yDQEk9Jq/jaFD4HI1Fnvo+2dZFi3DtrlyP7e
         4q2ieiWqyWSo0GTscgYrJaH96Vh83RbPIZ2BZuCsdIW5Ml7GIsp0kPWrumznKwP24EvP
         mKFXFvUpGa8sx/LToQ7HkCcwP4dh4b89AmAUPugnJC6XQ/Fxxh1qrjA8awsgLPZk8a5u
         YUXu5wLQjrhg5eB5PIFBMzmhc6xxUn0nfKdLMKhtAMJSe+q9gRfpwjmIyRqTLpThVgUg
         strIT/1CRViFd5dbf/n7nUIBhLljDsxOgiuL6XPsyESH9K74SBf5SM0XM30kIXP9sXtt
         zMhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=BkSambIUQitGRlTvVm9rbPHKE+ioSB6QhEypVQhx7ss=;
        fh=KSwx1ZGGhyUBHkrg6rTW/SsfNx+4lODHT8qIQUNTFHk=;
        b=cuP1iNr959OV0k1X6eZPZdoNA+KxWsAIOJpTi4GWnszbddqF+I8vXDqv4Bcl69ofNd
         VnUApQZiv6BTnjdXeJPhysht+Tpt4KJi7cl2jr69j+SKCaqOSn41zxS+xUf9lLkCgohq
         Vk9BxDJs6KKX9H/zthUBRme59fGBmpYWt1AoRuXo3YRdC5YhfX0KoQ8N5DI5bkQL3ZMi
         yxhjnrpmAbRiYPegcmQWP32peALUnGfx9qSPXLNc8Q/0SXWbC5M2C36KcnF+0UqZfp/X
         Z3SKKhq74pBbkIBTS284FOmwamUh9DgB5ShecutZEjV71cL16dnXovbq5hG1x5VMyFzI
         1fkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781016363; x=1781621163; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BkSambIUQitGRlTvVm9rbPHKE+ioSB6QhEypVQhx7ss=;
        b=DMLL0i7I7cv9wHTXdRJctjNGnNa+Ng/7eOdqYhlr9sbs1WunXkbjoeI5QTv0Q91E4Q
         Q86a5/zbUNWCvKz8FLFAY5PLqV6sx1v/PBrsnWRn1p+hedkPISqcTfCU8PASSE6GNLus
         zbPVlahpITcMl+lvisRAfYg+u+VYSGYoRGUudIl0FU+J/bvBFte1U6auQ6HYgpxSO4R0
         r/QNB7dMbF6opjM+OHP5EGX2ov11jmZPZhv+k80STl5zs4Z4/EZN7cAvBzXUdYk0JDog
         Gcsf0+u5kHopmSbl1hO0zt/fHz4W4veplEnnMI1hPXCxJXSS75vTwihq/QCaEmF+1U2L
         Kh9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781016363; x=1781621163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BkSambIUQitGRlTvVm9rbPHKE+ioSB6QhEypVQhx7ss=;
        b=lU303PkV5b7EGx1HDdu/F5QYbPleXrZli0crV3MmAgH09gZwzHbyHEN2PKRT/3ErD5
         JTjVO6t6XFPI+tdB5C9YuQWYFrrih0ZvCXZzMr0RpOEVhz+X3zh5s9/bvV/iPbAXknOg
         URFcuX3ndgO8CES3K4ZwObTDFCGeo4IyTpmqlLwNEJ4cakBxfaCJ1KkxiqWxKqay66W5
         L2KVqDMdGVSBC5W4cGtvoJiTYoDUNjndEnKOxOMfrsrJpRzPzO45QPwNWaJ79gwWweOl
         Vci89bNyK8FiLLq8NiuQrSfoE0w5nlEROI/A24UoR7IwX95NZvblw6IRo9dHloIpBDku
         wVmg==
X-Forwarded-Encrypted: i=1; AFNElJ820JrrAjNXz9x+gp2cNBmWHrfUhwsp8VeW9A7vbrNoTqEu9CDK6yToCwv/2Q1SmgH1ndw73Cc5HlWS@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxdr4pYGkW8Etxx8hXnANj5wRU3uq+3TEmtRPXjkwIrWSBggMX
	7YfxZEmfKKN/+Qd4VkzurznI1h/2X6ckEcu0jPhjrJrZJNLRMhbcSClZlATINDBI5viP95jimUa
	y0TNc8WyjYKqadz7rAYKHVQT5Pk/VwK2xl98BO+e/wROtJr4dTBxOqlXjJwZob6EyA25+LNsQ+r
	nK1vkVrEKvhgBvLyUxp6PX5ZuFktZhpLqMOU2lzE0=
X-Gm-Gg: Acq92OFdjRQ0rL4nRCEzh1+/eQ+bqXu3ufhrNxKrmRIMa0sExlolaZk2LmnUUj1OuVw
	Yq0CAtFpE7bJkMxQEVG7TQge3N2mSbkU6/boSZd4fDRr+ni6zhTblR4fFYGbnfL0IRjTK9zlqDO
	dMvm83TpgRLfts53qTSfNUp+ATj1zXMyVDGmNc3wyu8yvBH0CpsiXE/NN8Akos4kLDMXE0BH/uW
	qGYvfjVEEflWF0Drw==
X-Received: by 2002:a05:690c:600a:b0:7dd:35fb:a529 with SMTP id 00721157ae682-7ed0f826fb1mr175041127b3.25.1781016362720;
        Tue, 09 Jun 2026 07:46:02 -0700 (PDT)
X-Received: by 2002:a05:690c:600a:b0:7dd:35fb:a529 with SMTP id
 00721157ae682-7ed0f826fb1mr175040657b3.25.1781016362226; Tue, 09 Jun 2026
 07:46:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603-gic-v5-acpi-iwb-probe-deferral-v2-0-23ffa16b6ebb@kernel.org>
 <20260603-gic-v5-acpi-iwb-probe-deferral-v2-1-23ffa16b6ebb@kernel.org>
 <CAB19ukFFwm3ehzkBFr+oXRjA7VK_4_=XHFSuqdEpbVqUz8Do4Q@mail.gmail.com> <aifahCtdj8GpHN/v@lpieralisi>
In-Reply-To: <aifahCtdj8GpHN/v@lpieralisi>
Reply-To: sunilvl@oss.qualcomm.com
From: Sunil V L <sunilvl@oss.qualcomm.com>
Date: Tue, 9 Jun 2026 20:15:51 +0530
X-Gm-Features: AVVi8Cd9pzTcVntwOkdct8eFjOpuS2Xxx1qo-G3imlUBB7gP99ylMuHrty8LTZg
Message-ID: <CAB19ukHAAHp5kmm+5KBDqtn969h3V4LBr2put9hJSWphPS8jmw@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] ACPI: RISC-V: Fix riscv_acpi_irq_get_dep() loop termination
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Sunil V L <sunilvl@ventanamicro.com>, Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
        Anup Patel <anup@brainfault.org>, Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDE0MCBTYWx0ZWRfX6amyiVhS4qpd
 TJf0Xp+hs5xc6ZvcG+v7g51co6hcMlFUcel3lJ8hO4tnv6U0s2lBw2IAgjrgLPl9pGKUZHqzByw
 OVhlTarop5ythDh2q1K4UzloT0I4gJjdXV/1TCvS0Kwdcujw6cCOAMriPT7SQLX003TmH8z/CpT
 Noe085g33eBGWTU/u7KNbJWq69hNXYzKYmZgd1KbsRhI04gLLdR9JSLdygnGPMZKCLcc1BaVKdH
 bPeOpNKzNY/ZFEvwCRSVTjKQGGrbcLd7+3C6zL8R1gjF7OuU1JeeG4i57MXlGJpozSuqo6EPtDS
 M4sjPvs3goWgXu7auvvOiu44evR5qCwiuVAvu3nKS6IcWMl2yVP2D5NFBzzWJVeWdQD8gSEe2eE
 fKEQFrHijkQ1twUuoHcLfdKz32cEUrsMFeFWWMn3DC/Gr+UUiNw0cb19vWqqWzfBE0L/fbYSTwp
 URecqn4s1tBU3gSX9ug==
X-Authority-Analysis: v=2.4 cv=csWrVV4i c=1 sm=1 tr=0 ts=6a28272b cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=45POYx1-RFdywSfKWh4A:9 a=QEXdDO2ut3YA:10 a=MFSWADHSvvjO3QEy5MdX:22
X-Proofpoint-GUID: qqG35DDl-L9Osh7iAOcWwaw0J3EFJ2qj
X-Proofpoint-ORIG-GUID: qqG35DDl-L9Osh7iAOcWwaw0J3EFJ2qj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 phishscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090140

On Tue, Jun 9, 2026 at 2:49=E2=80=AFPM Lorenzo Pieralisi <lpieralisi@kernel=
.org> wrote:
>
> On Mon, Jun 08, 2026 at 09:54:28PM +0530, Sunil V L wrote:
> > Hi Lorenzo,
> >
> > On Wed, Jun 3, 2026 at 1:51=E2=80=AFPM Lorenzo Pieralisi <lpieralisi@ke=
rnel.org> wrote:
> > >
[...]
> > Do these fixes need the Fixes tag?
>
> I can add a Fixes: tag but I wanted first some help testing them, it
> is code perusal that got me there.
>
Oh, yes. I tested these changes on the RISC-V virt platform.

So for RISC-V testing,

Tested-by: Sunil V L <sunilvl@oss.qualcomm.com>

> > Otherwise, LGTM.
> > Reviewed-by: Sunil V L <sunilvl@oss.qualcomm.com>
>
> Thanks,
> Lorenzo
