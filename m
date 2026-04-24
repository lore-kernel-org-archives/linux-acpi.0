Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1105339875
	for <linux-acpi@vger.kernel.org>; Fri, 24 Apr 2026 17:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777050427; cv=pass; b=Eoq8rISiTt+CWTuuVwOo2jOVXG+iNCLpRO6Hrj+ZRAGmFCakeHcLfVKi/Y+ST02fAJACV6xUkCAMXiJR+UQyiKnX26P/4p53Hzs6OTClUzNlTnhR6mzcpJxVZBsmRzkkjP3wWcKYkh5Y6e7JwDgxkLkSrAyfOqlJz9NmhUhuVC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777050427; c=relaxed/simple;
	bh=24Zfv+qvRFEUO3TUOKmBVNj0oMoEPk55Nlkrv/OpgNA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JpytEpYxQlnAewUULQcO0V1p1DYRx/TDCv8oc3IsBOsK3bBEYl+BvDJHm3caW8VMjQiAZ0APfjAPGk9LNc/EGnuVYzUXrfey1e+VdeIbkpn50O/dqSJHrRWr3RQwqvMA+fzejJJiHgZOsGN/jHrAySLqpk259aGP1edGUh6IIMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X+sDy+er; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X+sDy+er"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b9358dd7f79so310660766b.1
        for <linux-acpi@vger.kernel.org>; Fri, 24 Apr 2026 10:07:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777050424; cv=none;
        d=google.com; s=arc-20240605;
        b=ju8mbtvUqwgVJu4V5j7koibCoQuVG3G2Gx+FbcPf++aDS2udhO7mIIYLqkxNtCiuFt
         hDsP0XO/k6a6Ia9wBtxzD7DJVA6w7iDHLM2kUGb+xLT+59pXOAPcNVisALvw8bfWoNmG
         hTWIT7OTQsLxE6cHJZbHdozJ29ZOh8kVoaFf5v3LM89zLAlLxKYExOPeDqOtU72bJX84
         rNXRW3U/OUJPK/eolYpvVn1q2bKPUM79AwnneOOqUHDFhiPkEdnxKIz0CO5xviHQ8pCX
         XruEFQlMYSUUm7f9yTakqXw00PBeKZJ1b7nh9qiGsRsEU+B4R8skHrY/Ia8vnhdgp8Wn
         dNrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=USoxp0h405rV0N6lkVHBax6uv3vDEH6jVbUSziMSuKA=;
        fh=i/H2n6+zaIUdWpyezUk62iK7YeqBtuFpdT1VDH1qkz0=;
        b=MEeZ4/E9LzmR5oE1KzBeqwF7NhKbDH7kzRWw0voPRF8q1M8BdSzAREdIuPpKFcNDDt
         2mdNbbVeUUpFv/kx34YB0cuyFF09HV6ZzdeySbq2QG7Fftul3oZSB8YvV8RUmFfexL1P
         bdx8f3kmd1oNCjjHK4W0tgrUnALvocTwT5TbLxzfYHrHQS4u/YKgCPpVggDdHi99TTGG
         2oAHDSWxyWV3cDe2teMKA2AY8svzO43WTXu9/iTFxPYBv7FDHwdW0l/pM2yezKxwQ29W
         wHNa43ynkTCKMTY4WqJyT2GzLvzogE7MvBYgZDm6S6YAOOP7kI4bqaqdjfl75r4GpFrF
         dkOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777050424; x=1777655224; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=USoxp0h405rV0N6lkVHBax6uv3vDEH6jVbUSziMSuKA=;
        b=X+sDy+erjpY3uFJQ3DlolOyT/rVNodtrh8SBMVaLrOkkEQmDbXx29aqKMSQ7eKga9M
         Ej3tbkcl0fxKD7PLEbxuqWNHg4vmNLOR5REerKxg3d0eaeV6U0RDviS/fhpWQnZd2xZT
         mXB6U0YmpQbJAh8j5llXCMjDJ2UP/pntcXw2KRmSvJyGmBgTFwBTWZT/qQtxe6IplC+u
         E7QLPNsuwxYBDKR7CfBeRBUjwkJDPV3VHYxV7vHTt7lAjnLeVXsQndYlTJBXQfHiNd9k
         XhBg/bD3fdRikKQZB7Z64F9L2GnGQZRONCS3gdRlxtWloS8LaYf2/dbaDphWcnFc4Qqx
         Ln9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777050424; x=1777655224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=USoxp0h405rV0N6lkVHBax6uv3vDEH6jVbUSziMSuKA=;
        b=MS0ILleyed0gNO11ThBf+Ptet8hOopg3Tcoam5qq77SIFFS26T991h9vpu+OmZS1hW
         CqrjHOTM+79O/x+z4KshwAVo76Hzl4bWr4vwlYu1Y32IKxsVAdnHv1QiSYA26+ZNYGEA
         yFXatIkEuyMpm1GPm6UKHaO9XUBNE2eheMNsptct3sSezb3jmNExZPkyg/cpNIzYrufw
         7+AEWjBe2KgeJhY2ZteTcmJimiNbWohs+nuj3kXvGNRoOz+sBK2iKQEhlzs9pCGYvh1y
         lxEsbi37b96MxgUF0yd6k5eN0a5xLCLtABFeFBbDrqYDLDFPBxdj11YYieHyts1qVjZ2
         pxKQ==
X-Forwarded-Encrypted: i=1; AFNElJ9/0KGq9pynEB3j7ktf6kHzanjtFrX1t7gsTqVWC6uATtPiYzkeF6DVfjrHd/UicntWyXyJiL2zktiP@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr2cjy+4B1g5zscIq2DmjPw746Ngz1nsHv6eQhKLCTx2O2M+8p
	4SNXdJzy8HlC5Mhefb7/56+f3h2s0jAgonLlyBDKNEY32xK+bO9nuivPdMuZCcCBpT4pgDtJ92L
	e3htwBROgaaJvz9arxI9J9ln6r4lGSd9z89+U
X-Gm-Gg: AeBDieuarfCN1ENh2tiGmCUyv0KLPnMFYQZSzMMJzQplmclROVOJ2alkyBEv5TIRLWF
	gNAh4Gozf0CPGLtq6t8yh5a5Up1qh9rh7Zb5Dt7YuvNhrK4o+pfomQhBTmOtDNY+OV4eVvYqLLc
	/2Nx5y+oICQyk4rGWziFwj6jYbO0wlhEdkH5pXjheEOr6iUOWHEIoJNeVyIMRv/S6BR6Uo5pugd
	Q5oowwgF2x0Okmcpaf/M9QgXJDW7X53BawJG8uFQiZQfpO8JwVcKs33zjcdY+I72to2PJQ8YWIc
	zuoQwJ20jyg4hMfRdQ==
X-Received: by 2002:a17:907:9729:b0:b9c:30b7:770f with SMTP id
 a640c23a62f3a-ba41b5d2827mr1521834466b.34.1777050423823; Fri, 24 Apr 2026
 10:07:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12879883.O9o76ZdvQC@rafael.j.wysocki> <5996744.DvuYhMxLoT@rafael.j.wysocki>
 <CAGAxtY2vstAuswt0b6sS_0Gi1=S6fd6cetskjfOEKnWqmMZBiw@mail.gmail.com> <5107109.31r3eYUQgx@rafael.j.wysocki>
In-Reply-To: <5107109.31r3eYUQgx@rafael.j.wysocki>
From: Evgeny Sagatov <evgeny.sagatov@gmail.com>
Date: Fri, 24 Apr 2026 20:06:50 +0300
X-Gm-Features: AQROBzCcsjsysuspgm4qM23t34TrUa56IeiNQj-n1rHW_AyJrvCF0ma597wuQqA
Message-ID: <CAGAxtY0av_gAk6Up9W8RHjrzWurHEou4RBNnv5wwSEsTUNT52Q@mail.gmail.com>
Subject: Re: Pressing the power button causes the device to freeze completely
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: regressions@lists.linux.dev, linux-acpi@vger.kernel.org, 
	Thorsten Leemhuis <regressions@leemhuis.info>, LKML <linux-kernel@vger.kernel.org>, 
	Wysocki Rafael J <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

dmesg | grep "Fast frequency"
[    8.903099] cpufreq: CPU0: Fast frequency switching enabled
[    8.903181] cpufreq: CPU1: Fast frequency switching enabled
[    8.903247] cpufreq: CPU2: Fast frequency switching enabled
[    8.903316] cpufreq: CPU3: Fast frequency switching enabled

When I pressed the power button, the PC froze. Nothing in the log.

=D0=BF=D1=82, 24 =D0=B0=D0=BF=D1=80. 2026=E2=80=AF=D0=B3. =D0=B2 17:40, Raf=
ael J. Wysocki <rafael@kernel.org>:
>
> On Thursday, April 23, 2026 10:07:39 PM CEST Evgeny Sagatov wrote:
> > This patch doesn't change anything. The PC remains frozen when
> > pressing the power button.
>
> Well, thanks for giving it a go.
>
> This at least means that the issue is related to certain activity in sche=
dutil,
> and the specific values used by it are most likely irrelevant.
>
> This time, I'd like to check two things in one go.  First, whether or not
> fast frequency switching is enabled on your system (if it is, it will exe=
rcise
> a different code path in schedutil) and second, whether or not the power =
button
> press processing gets beyond the clearing the associated event status bit=
.
>
> For this purpose, please apply the patch below and (1) after booting the
> system with the new kernel, run
>
> $ dmesg | grep "Fast frequency"
>
> and let me know if it produces any output (and what the output is if so).
>
> Then (2) press the power button and see if that still locks up the system
> if schedutil is the cpufreq governor (if it doesn't lock up, a message
> will be printed to the kernel log every time the button is pressed).
>
> ---
>  drivers/acpi/acpica/evevent.c |    5 +++++
>  drivers/cpufreq/cpufreq.c     |    1 +
>  2 files changed, 6 insertions(+)
>
> --- a/drivers/acpi/acpica/evevent.c
> +++ b/drivers/acpi/acpica/evevent.c
> @@ -243,6 +243,11 @@ static u32 acpi_ev_fixed_event_dispatch(
>         (void)acpi_write_bit_register(acpi_gbl_fixed_event_info[event].
>                                       status_register_id, ACPI_CLEAR_STAT=
US);
>
> +       if (event =3D=3D ACPI_EVENT_POWER_BUTTON) {
> +               pr_info("ACPI power button event\n");
> +               return (ACPI_INTERRUPT_HANDLED);
> +       }
> +
>         /*
>          * Make sure that a handler exists. If not, report an error
>          * and disable the event to prevent further interrupts.
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -473,6 +473,7 @@ void cpufreq_enable_fast_switch(struct c
>         if (cpufreq_fast_switch_count >=3D 0) {
>                 cpufreq_fast_switch_count++;
>                 policy->fast_switch_enabled =3D true;
> +               pr_info("CPU%u: Fast frequency switching enabled\n", poli=
cy->cpu);
>         } else {
>                 pr_warn("CPU%u: Fast frequency switching not enabled\n",
>                         policy->cpu);
>
>
>
