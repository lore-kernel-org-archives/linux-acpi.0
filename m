Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF16439918
	for <linux-acpi@vger.kernel.org>; Tue, 28 Jul 2026 13:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785244769; cv=pass; b=hfInF889wZhdUhv6zHmnXEaNvHTdhRIZIzMSKF8dpUKZddLRUsb4iHhQhoQk/wLOMA9nOaQfHuaZdSsGslXYhLZOTilvAV90+1CTB0jq2P9hzKFNjBYnD1Fwtpm+DHlO7SBplZq9Fg2hgfoO0ADhw83n0HBJSO9oiZaCCrQIFRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785244769; c=relaxed/simple;
	bh=QBhObxMUgFixpqNh0VhKAcgY45hi1UoSYqoBvNbFV34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tLSmypxZN4AsL5qpEAOg6i6z2HvMsKw95DQCmJGOce069tF+QDfMm1oxkhSzf6/iAyWSaQCiLPIBI0jBqLREjcvJSBUtNrBMl969mCCG87mBJpZM1Ji7wP6QfajQ0klTaNvzL4KmkG+8MWBMFt/60KF8zAckira/bsdle4Tbp9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NvUXdXZd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gpbmpg6z; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NvUXdXZd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gpbmpg6z"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66SBHwk82817880
	for <linux-acpi@vger.kernel.org>; Tue, 28 Jul 2026 13:19:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=nnctF54TPwZcGfOLut/LOPU4PbG6XXe/8IY6GCcEFK4=; b=Nv
	UXdXZd9+hB42Fk1exzHMahtIrXNLTWhyNOcrlmRhvPbtCpm3ALUp7tJx+iHwTAm3
	Me19xmPpfwHjXiVHKjbhPg4yY26O0pkGHWYYw/B0LMYmVIhCwVh/wMPByBdqpIu5
	IkZiNEm5ddg++0lomRQvfJ9dh3XtDlj1amSlH8D91oeEoEhoxfk5XH2fgrlQeHcr
	R2eFVQy0PCgAOnxBJ3aVDCL/qSLEkS6nw1TBcH2zImElIT1kes72yrF8MlTVRECj
	VjyqtuLmdj4F4YhZ3mD9fp0SaH0u1ySuIJNgxaXDhTn3rDci6GK1p3zHoKejr3NM
	1NIyuZ+XdTc/Bu0QwH8Q==
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com [74.125.224.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpn3y256g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Tue, 28 Jul 2026 13:19:24 +0000 (GMT)
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-66899c73361so9479456d50.0
        for <linux-acpi@vger.kernel.org>; Tue, 28 Jul 2026 06:19:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785244764; cv=none;
        d=google.com; s=arc-20260327;
        b=deLOMMzfgcl2Zz5dcqra9eV8HSh0A6e4NwnijZOyNPL7sFb/6NI7q4M4HDgUNawgar
         zkwI75EDmG0UsoysBCc01yfESaF8UthrL3daGiHrSxT1PmLH2GRYr6AUurviOvtIfTnW
         whdy/78JSR+1sewMSNaqespsOIINZke9FjWsYSuOKHai+JcPl+s6NYzQTLv42ne7GzYq
         LbWSkJWiMN85lTdDBHODI2Q6e3W1I1ufyjfS7VX/dImlsWMOGWgZvT715fGlc5cS8ZsZ
         nIlvRynpLxAQ+YktLzHRCk1n1M/mjV7oRFGzDQzV0/t7EN7y4YY7+Ox4XYclMd1Jsani
         5F6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=nnctF54TPwZcGfOLut/LOPU4PbG6XXe/8IY6GCcEFK4=;
        fh=IV23gGZ1rCP5LUMhs4a44zsOUbxUL9LiJbE6Mi1bUms=;
        b=mEjTQSmCXxLC1yIAZ5ty0hYmch1dC8ui/RzECvtjRHjuAqx5xWk4OqRduKGCAqN0KJ
         F+a4qATHbPxMzwids4wrbGz0wEUYfzS5bfE0R15mZrr1N+X0c/9KDFstYvDdbqksvGr+
         tqp0AZ0F5LsUZo6cGLztSu/ddFxHZnJb+5fDEQ+zkvcWrcZjboyd5fgoV/WrPlBQhwZt
         7eEnd241slH9NpxIGy8QQk/4lRDf9hARgAhQjbKVDXrktL/ID7Ta0xHXZ8uWAcXWPVxq
         zQ59gMoUKsJBrDOUzyJ9p+f6cDCp9ra/qRUR6I0wHi/apjs2RBPbC/s/wUS13B2rcQ9w
         1fYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785244764; x=1785849564; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nnctF54TPwZcGfOLut/LOPU4PbG6XXe/8IY6GCcEFK4=;
        b=gpbmpg6zfWo+NE7Kf/DzxHhoWknmsooTJDJ0zLZUNyboXfmq2atpkCj/CfZZaS1GTb
         +oH0S9liuPhYxoCAy/a09knmpU+2BTjOV74cDq9AYR8OomoJDF9lhJWYnvR82VtgOTgG
         JmD/bpMAULY11b2z1bOJjFrmJoGPEcGcdx3pFAEhe3WHRXyhUMLYHQb+NTm4h8HkOqKU
         jkX6HyiZTwhFbe2ymWZ97ljFM7gNMIoYzS5oJnEUNhJc6ewa5u5aQG2t01kIQxETOW1w
         q4J8UMpDyRj5BMiPEjhINMmQP6eLgMj42MWEzAB0PTeZe+OpiTG9VjGDkqFD7fZl0/yx
         FXmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785244764; x=1785849564;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nnctF54TPwZcGfOLut/LOPU4PbG6XXe/8IY6GCcEFK4=;
        b=cPBgIOKKim0jozVVOWGY8psEwSaF2tXd3/pyPX/cPwxg61fEi0KMc/2eAWkaMsDQEZ
         pZxFCtjM4SVQ8VJg4wogxWS8fO1zGMK1CsL3xxwjKBOWOie7+O5S5C3czBGVmdtAwQmp
         BZZrFZo/XnjJikHH4gtYGeX06PQek2MyEbUCqBMHdYCkGs5gB6dX1VU9E32+FnL6hes/
         MmQ3GhJ42BciOPDK7kzeL/DWawPcmGHvaErEmsrosbLC6urTQLtPrYC2SUdm7Zrmw5RD
         7PA6ND2PW4zyclxs6MDQOsNoV0PyJI5cHA6sD085sy/DiMCAybGdNZhxgUO6ZN4mFP3G
         ILng==
X-Forwarded-Encrypted: i=1; AHgh+RpFnTZjQ5HaoxfNdy0hbJjRKczvue+EY6yj+dIw7EDOjSyBp9Q6yjQyX+eXDNk52nVueDPukTOZ7O/T@vger.kernel.org
X-Gm-Message-State: AOJu0YzJQh0dGrWsZOyb14oi0CjMNjY3dGIrTwkbOnQnbrL1hHu7wlx4
	yN8QWg2ofrJKP3UX1pDLe421Gn8Ycric0f8zPoYyeqyNzR2Ff40vWfTLtJ2UNG9MMERrt5JXf4o
	LHq6OjHWAdPl/u5BE5wXZJAgqDRU/IkQwLVJLVxo23TBbuErFS/xRT5NbJWqxnN0plfUT5FcKEz
	5GeZ2ixsiL0386Pu+xYWz5Lcs5ygizvUNoWVDgBD0=
X-Gm-Gg: AR+sD10HDf8/wMCRf1cru7X2Z0E2C0Sk7BSlPRceDr/9iZg70Ii0kTkIvWDYnkTdtJy
	5T0wxoVIBaXLYJMUUgJGM0FVll65VH/Q//QN5NTgK1aXGrbSAF2uHqv9BXltvFbriO0aSZbix4A
	P6CDA1IOTcp88sOtmxd8tZMww+mBZ4u6dgn9ViKlCHWqWBCH381bnp0zjVjQ==
X-Received: by 2002:a05:690e:4849:b0:668:81d:342f with SMTP id 956f58d0204a3-66905809df9mr477882d50.73.1785244763897;
        Tue, 28 Jul 2026 06:19:23 -0700 (PDT)
X-Received: by 2002:a05:690e:4849:b0:668:81d:342f with SMTP id
 956f58d0204a3-66905809df9mr477865d50.73.1785244763406; Tue, 28 Jul 2026
 06:19:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260728-riscv-acpi-lpi-timer-v2-1-5a30e0021ec9@linux.spacemit.com>
 <CAB19ukH1Srbw+Yko_-21DiV7Wc0ysJX9cmE7xDTwtrmUm_5rMw@mail.gmail.com>
In-Reply-To: <CAB19ukH1Srbw+Yko_-21DiV7Wc0ysJX9cmE7xDTwtrmUm_5rMw@mail.gmail.com>
Reply-To: sunilvl@oss.qualcomm.com
From: Sunil V L <sunilvl@oss.qualcomm.com>
Date: Tue, 28 Jul 2026 18:49:11 +0530
X-Gm-Features: AUfX_mzeOeCPWWFFch2ozJZGQHNRh9Ub0Dz-7Jpvn5Ws_eaBKb5S0K8D3nqJKts
Message-ID: <CAB19ukHpFS-=nK6Tfjk-nY_Jz7Pi82pE4-YQkfQqoBXekOLtuw@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: acpi: Handle LPI architectural context loss flags
To: Peixin Xie <peixin.xie@linux.spacemit.com>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
        Yixun Lan <dlan@kernel.org>, Sudeep Holla <sudeep.holla@kernel.org>,
        Oza Pawandeep <quic_poza@quicinc.com>, Will Deacon <will@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, spacemit@lists.linux.dev,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=fbidDUQF c=1 sm=1 tr=0 ts=6a68ac5c cx=c_pps
 a=VEzVgl358Dq0xwHDEbsOzA==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=bC-a23v3AAAA:8 a=lv0vYI88AAAA:8 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=yZKCaVM-5Wx_WF_-bDkA:9 a=QEXdDO2ut3YA:10
 a=uujmmnXaIg8lM0-o0HFK:22 a=FO4_E8m0qiDe52t0p3_H:22 a=9qqun4PRrEabIEPCFt1_:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDExOCBTYWx0ZWRfXwdHuV9jrGONu
 3AolgriHVHwv7aZnFIuitaWlQMpL+k9KjP3gVzqk9OPHnZ2rgflrt9BjgU01aeXsPg6Yjh22T47
 x7JdekNJF5SZ34OHRcG8Q0ETEHegSV0=
X-Proofpoint-ORIG-GUID: hrX-bWM-P9BHhvXfuQYsGANvw1wn9g9l
X-Proofpoint-GUID: hrX-bWM-P9BHhvXfuQYsGANvw1wn9g9l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDExOCBTYWx0ZWRfX6CS6x/psAi85
 XBPPUGrz7w8+7hkLH+qzrJ3I0Z7UAZsQ+WAhAlBXSsw/9TVuUPoHLaGkc0A1OpE0yuPai05IXYW
 bqrEtmWbB2BL8UCETURJ9Z8Gt+f8N9+5ij9ISxn2Y36PsvyT7sBT0LHuiGNuM2zxULkF6kSFbE0
 4Bb685jqIBIIeuDvs+QSD60UuI/QMh4HbfVunijDUzDt3DWYPP1icjefNFZRFa0FgZ2YgFNv5fk
 vlcwjK3J+PWehIDtCA+2+hkgjhGFVP05UOTfbjiIP3it01lLrt1DSWUZeQPeWL9L/PNOrK6GYYi
 eaiQ+S94na4Vm6M3n6ij2RSsgS0wPzpSz/GhAEsD4rkikeBMmkKlgCKF9tGJ2LRDuZgEZDyM9oI
 utqQo13MvwinD3oc7MV/4cO691RJk6YrYgVjwAb5ExNfHTUGxoocAOCDjMZboaGHrFELheONXrO
 3lMTt4VQlimKRiuRlAg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_03,2026-07-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280118

On Tue, Jul 28, 2026 at 6:24=E2=80=AFPM Sunil V L <sunilvl@oss.qualcomm.com=
> wrote:
>
> On Tue, Jul 28, 2026 at 5:24=E2=80=AFPM Peixin Xie
> <peixin.xie@linux.spacemit.com> wrote:
> >
> > Commit 4785aa802853 ("cpuidle, ACPI: Evaluate LPI arch_flags for
> > broadcast timer") replaced the generic nonzero check for LPI
> > architectural context loss flags with arch_get_idle_state_flags().
> > RISC-V does not implement the helper, so it falls back to the stub
> > that returns 0. Consequently, CPUIDLE_FLAG_TIMER_STOP is not set when
> > an LPI state loses the hart timer context, preventing cpuidle from
> > using a broadcast timer for that state.
> >
> > Implement the RISC-V helper and map the hart timer context loss flag
> > to CPUIDLE_FLAG_TIMER_STOP.
> >
> > Fixes: 4785aa802853 ("cpuidle, ACPI: Evaluate LPI arch_flags for broadc=
ast timer")
> > Cc: stable@vger.kernel.org
> > Acked-by: Sudeep Holla <sudeep.holla@kernel.org>
> > Reviewed-by: Yixun Lan <dlan@kernel.org>
> > Signed-off-by: Peixin Xie <peixin.xie@linux.spacemit.com>
> > ---
> > Changes in v2:
> > - Correct the FFH specification reference to Chapter 2.1.1.2,
> >   Table 3, as suggested by Yixun.
> > - Link to v1: https://patch.msgid.link/20260728-riscv-acpi-lpi-timer-v1=
-1-c722bce01e48@linux.spacemit.com
> > ---
> >  arch/riscv/include/asm/acpi.h | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> >
> > diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acp=
i.h
> > index 26ab37c171bc..2643e28fc08c 100644
> > --- a/arch/riscv/include/asm/acpi.h
> > +++ b/arch/riscv/include/asm/acpi.h
> > @@ -12,6 +12,8 @@
> >  #ifndef _ASM_ACPI_H
> >  #define _ASM_ACPI_H
> >
> > +#include <linux/cpuidle.h>
> > +
> >  /* Basic configuration for ACPI */
> >  #ifdef CONFIG_ACPI
> >
> > @@ -67,6 +69,23 @@ int acpi_get_riscv_isa(struct acpi_table_header *tab=
le,
> >
> >  void acpi_get_cbo_block_size(struct acpi_table_header *table, u32 *cbo=
m_size,
> >                              u32 *cboz_size, u32 *cbop_size);
> > +
> > +/*
> > + * RISC-V Functional Fixed Hardware Specification Version v1.0.1,
> > + * Chapter 2.1.1.2. Arch. Context Lost Flags, Table 3
> >
> Isn't it Chapter 3.1.2, Table 4?
>
It appears there is an issue with the HTML version regarding the
chapter numbering. I have reported this to the documentation team. In
the meantime, I recommend using the PDF version as the reference for
any citations.

Thanks,
Sunil
