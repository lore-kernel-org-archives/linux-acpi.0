Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AA837DEB5
	for <linux-acpi@vger.kernel.org>; Thu, 23 Apr 2026 20:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776974875; cv=pass; b=ZDMLeKCVj3fBMcBBApIlgsXqAY75LfKdd/4XBaRVWEd3NyiZVrZcH0SntJkbsRFZZKNnkphey5y0UN534+fUg5gzf+9Cd/64t+UA7b6P36Zs1lYKE7SPwDfW+FM6n2DmZJrnCARBDY8qkgntmMhjL67tSWsFG2DyK46t3naxSl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776974875; c=relaxed/simple;
	bh=ptennygPTeYOh3hyjkB0bFPt3NW80AGcTawmPCnKvGk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JTTw9tRzqucSHe+Hq/GeWc2gFStSYnFm8Eicw5z21eWK3arZXRowJS+olWuBcpZgYBoi+Y2GunWpASvTIwfSUeGEkRtqifoKBpCFz1OhcKrEYJjEhlbAcnmRSAiR7/JAdkHAnvw58yWzw/wiFzsRIJRXFQHnXY5btZ5eiTZYRLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HkoZu03m; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HkoZu03m"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b9358dd7f79so163742066b.1
        for <linux-acpi@vger.kernel.org>; Thu, 23 Apr 2026 13:07:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776974872; cv=none;
        d=google.com; s=arc-20240605;
        b=HvuV1XDyQLzL4eSJjTzFeXe9xqqnLgcpTt4NhqZUA09YCAl4hKBgMc9cbL5JUeN39C
         R6nEs0dT8/wntvp/UMKo0/xHuymD9qc2pQEiZ7PTWJukFxsyby6itDofOx0KpgqIBZuv
         ls7sIL3JHlbkVdAhFlM+kHTHHbWoxpirwQsZO75MxwIQ5HL+jE56NElhmEadfIbmyfJd
         D27jmHs4wRdoX/Frv5lOzdeqyv6hTg3MIPrQXzSGUy+ZZB5iAjIGIYI7Qs31w9mzg3BF
         jpIR7rOi/XLfyAVueXG4OkSzjvyNM6sSazmekFHqY/IvTzvyuzNmb8qzEfz5ZjHGZRqg
         oVeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jGCi+RvGdziSzpVZyx3Aax7NdvsO8nn7n5GmUEwoKVI=;
        fh=t+fW53XHpwn/12OdZqIMfA8oQrPo4qQdxfy3kglG/nY=;
        b=Aq22H0n8eylUbhj1y80KSm2EVp9Ciks/Esvdzc2dLtWfCR3oXnXZ6NI4RD5qCxx5kw
         +eTvZ5odtIfK4bYCrd8Ktlq9+Ec6H1UcR+o07tjzjTlG6MBY097Fe/Xe1KMd1ENCncgB
         Leba6DO+gPdEz0/M0pmKhHw9WkmWUx0iENYWiic/dBNPdCy8atiqVVH3DObW2inwn7z8
         TjgyBSjj3eTtB2xgCtXrYY+GGYfppQ8A6Nxarw9XgPiqqmPmzkNsMdTGclYCbOkPZsTw
         W92o4ME60KiKP9fp6uJT6V922tdm3/spsf94S8zlzDQmIKKGU8VnW9EJnWdR7EJICkrH
         q6FQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776974872; x=1777579672; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jGCi+RvGdziSzpVZyx3Aax7NdvsO8nn7n5GmUEwoKVI=;
        b=HkoZu03mXzMcJtBWmSKwkuNNZdQgyGWJPiAyO03Qy4VEHA+YozIglY5c4SM7+fMo42
         7osV8d1pO+M8vxhNk2o3fgvgJySGFA+fDttW7YLr0li1pZ4HFtDWulYIymUWsqMCG1XP
         o/dqxe+7mFP0+GN+R9RHHqgruG3um/WOJPL/WfMM+DPJj2b0XYeeSWka6kQFJ2dn9Uuu
         a/nyBvRniKKL0mS5IMrhPB38II+MhRMg2dKnr8nf6L7EFYYnSHwgVqjVHgnquIKdm9Wc
         tXLOt42kLOVL20/hS3TragKdCcLPNnKMEfTYaYS4XuGo4EaBLH18LWg1M9ijBWjWsULg
         y4nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776974872; x=1777579672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jGCi+RvGdziSzpVZyx3Aax7NdvsO8nn7n5GmUEwoKVI=;
        b=PVE+DO5s2Iuppsx6xY+ACkG03Yb7ye9zuZCW5t3hlH01UydtBXaMZOR++sRGgyGntO
         FmJoiS4sykEvhYaS7pt1WfAnZn+dkrDbp27ZOmW55o8XALLxbnMmWgVHMTkazIlRorHZ
         7/fNygmU6LUxuVBGNkkAD88ynfmxzJiLsmVwBWCUwuHzxNDCWtjotHDmS/J5k8oIxUXa
         GHabs68Ti+sDpCfX44gxH1o/EuAJwHneVpWA4xITc1LcGVwbMDy2ibnyZjIB89vxKjPp
         lgHj71aBtKYSYr2/i6cmrd/ARenXVtqd35Rl7VoE5A+37kNz75g6FGi9mCnVBAOFvLUV
         ftWQ==
X-Forwarded-Encrypted: i=1; AFNElJ+V3fm4rPpMYpLNHa9TLKqQVNDz6ziEqOCup8mEmzAR6rljyMXzh7F5bZVpPflbiwsrpRRTaryw7rvd@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4CzQ7edNcq1RrKBMCcypEQKZ05/ifTNupGELxndRfdNbGMdTv
	uZ+YoOpJn2FjkosjSlQLLOpbCtbBsY4vbYwUH8VOAPb+qrkQ7gKW+LteP+60UFenWBFU6e0CvPj
	sW9D0F+Pgsx0PCzU9cedUL9PSELsMVLk=
X-Gm-Gg: AeBDietehhc3y+gzsnTAE1yUjOPoEMszw2NouZ6W2Tu7ikVcTmlzgXtxud/u5y9mj1/
	urclvezjESgMmmsI2AWuXX9glCQQOysRev/JoBGnlqX0nsTI7wV5pGP/hR1lTnhqjAam3Ch5XgO
	7rpSl9kv5oUEKqQq4Mjay8e7+2qWQojJ1pJUnMuHGdRfIswvoPgtIZynt4OYzOJ4nGTjgNKExxt
	X3ZV2reybkETocV1PpCWdwr/ZpwL0wp9vvahnNNy0/JsYKokBPPYG4oTVvit/W5qzYGot/UxUxS
	DAxuuv9wU2oo7qe/BQ==
X-Received: by 2002:a17:907:86a3:b0:ba9:8b0b:986e with SMTP id
 a640c23a62f3a-ba98b0b9b8cmr720628866b.11.1776974872326; Thu, 23 Apr 2026
 13:07:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12879883.O9o76ZdvQC@rafael.j.wysocki> <4738258.LvFx2qVVIh@rafael.j.wysocki>
 <CAGAxtY1eVP5y6GTDoLM2xVDt2KF7fCKxDx0Mo9QO3afTA54GgQ@mail.gmail.com> <5996744.DvuYhMxLoT@rafael.j.wysocki>
In-Reply-To: <5996744.DvuYhMxLoT@rafael.j.wysocki>
From: Evgeny Sagatov <evgeny.sagatov@gmail.com>
Date: Thu, 23 Apr 2026 23:07:39 +0300
X-Gm-Features: AQROBzDh9sKKaRFRcBX9_7bAxxWy2J3ptQH43gEM6DvJhs_D_E8sAVyP6ZqTR60
Message-ID: <CAGAxtY2vstAuswt0b6sS_0Gi1=S6fd6cetskjfOEKnWqmMZBiw@mail.gmail.com>
Subject: Re: Pressing the power button causes the device to freeze completely
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: regressions@lists.linux.dev, linux-acpi@vger.kernel.org, 
	Thorsten Leemhuis <regressions@leemhuis.info>, LKML <linux-kernel@vger.kernel.org>, 
	Wysocki Rafael J <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This patch doesn't change anything. The PC remains frozen when
pressing the power button.

=D1=87=D1=82, 23 =D0=B0=D0=BF=D1=80. 2026=E2=80=AF=D0=B3. =D0=B2 21:21, Raf=
ael J. Wysocki <rafael@kernel.org>:
>
> On Thursday, April 23, 2026 4:51:36 PM CEST Evgeny Sagatov wrote:
> > I removed the previous patch and installed the new one in kernel 7.0.0.
> > schedutil - complete freeze, no messages in the log
> > performance - log message when pressing power button, doesn't reboot
> > ondemand - log message when pressing power button, doesn't reboot
> >
> > Log: apr 23 17:40:04 srv kernel: acpi-button LNXPWRBN:00: ACPI button e=
vent
>
> There clearly is some unexpected interaction between the schedutil govern=
or
> (or generally what happens in cpufreq when it is used) and the ACPI power
> button handling.  It looks like some memory gets corrupted when schedutil
> runs and it is then tripped over by the power button handling code.
>
> Kind of on a hunch, please see if the appended schedutil patch (either wi=
th
> or without the previous patch applied) makes any difference.
>
> ---
>  kernel/sched/cpufreq_schedutil.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -158,7 +158,7 @@ unsigned long get_capacity_ref_freq(stru
>         if (freq)
>                 return freq;
>
> -       if (arch_scale_freq_invariant())
> +       if (arch_scale_freq_invariant() || policy->cur >=3D policy->cpuin=
fo.max_freq)
>                 return policy->cpuinfo.max_freq;
>
>         /*
>
>
>
