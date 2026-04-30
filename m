Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF94D3BC66A
	for <linux-acpi@vger.kernel.org>; Thu, 30 Apr 2026 23:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777591086; cv=pass; b=Dk1T0rbep/2uZV3SoQREV70flB3reLxNIYbzEvteYSRWE19rReLJhiZ+Tws9gk4QdtuezlF1HZoQ18gDaDSzVwo1CFhcV92Xu/XueqwJDqENUBfJ5MdCvGsv/yznmKmdxXpAqUHxnTAFgsi/YBxjRd5x/InW5bVqrJ1IgpKnYeQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777591086; c=relaxed/simple;
	bh=qMssuPB08Ftixa7cUXrksbDoBvMFkJHrhq6Zs/nyBnM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hEae1+erggpdzgB8D7vZigQT4qRNVPAheQz7cjUvFv7d19MozI+wied/++o0I9vMitSTGrUmLHoMxltfscjb2lFPwOaObHlOBGL2ax1nS0v8PpenZJsIMeei1PSHzY5m5C/fBgaMfzCLl1qp1d2LDj8NFXjsffYZ70zJgdhI4MM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PGvMF6X7; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PGvMF6X7"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ba51e69988aso247716766b.0
        for <linux-acpi@vger.kernel.org>; Thu, 30 Apr 2026 16:18:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777591080; cv=none;
        d=google.com; s=arc-20240605;
        b=bzMaXD78KWX8kPrruWFCoJv1Jy5u5ezOo40uOVHXrCqhD5AMkdNjGQKFmv6qxg6fz3
         Cs+gsifvPXHEyGXAaF1HY6qKuoIL/TbukpRINYbcS02DD5An918A0Qi17XPJARFq9Tc8
         QcfSDBvXOoKqwcwbcLiTqKvjNNl37HFrH6fQxaBVNuhzxI9INF0THGf92PyXmfPOuyq4
         UeEEUKUUtyu4nQro0/K/RFIxnwMYgR+GlturO0gu5rTpe6Qswvn7u/MIpb4uLmXBRiSR
         5t8R9pomACxeoEtpskWvryut8qPdON2RZM+wtXlans3GDPikJoICXlC4oXl/jg5B2utt
         XnQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wr4f/O6tnwowWz0YOGfaBNk5o8gSqrjyXSQ8QIaml/8=;
        fh=YeRhbhph7YYs1iC3U3wNAVeR23IaemsgqOx3g1wK9TA=;
        b=SDXhwRL3NSxojbULZDQDJkzracgYuKHmMn2BU8wZgWEeRpCiXs3Xch8oaroRUQsv+z
         jOaG9/9QA2obUzsQG6n99S8Xtdh+EvcV0yUmthvbCfa7/nmBQYxNx4tqyeywnnsERgqR
         q4f8/TFV4CmjDk+rsU7ft55Bh97WlK9MfVezHNAdpVSlHJZ4gdYq0vXUB9kLZ1Kz0rF/
         eOeiAlzop7fSZMqshx6FWAwySG5uwsl+hRual/29rHQXWzPQCfJunP+mxW5obmHq1ZFz
         ioVZpa7BewDc/87P5tnQ1opmka/MmHsuH5zwT6a2YO1jRSsXdEQfO3RGrUX6l89FDb5X
         RzOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777591080; x=1778195880; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wr4f/O6tnwowWz0YOGfaBNk5o8gSqrjyXSQ8QIaml/8=;
        b=PGvMF6X7BnyJBp+WQjPOkm6JwqAIQbmHj2iWmHVxxnkvzM5mAmsjNVJaIW+7uJ+Q+n
         COza2Ga4wvqoOXF8eI/807nP4cfcuxfnHCNxSGVQ9fXDWki3Sh5AUV6VThlWh/QkKyQO
         AFsLlZyFcphGA/TN6KXZqzweDHx+m3r9NmRJTBnq2oOnV+jjcbdvlof6p1nCRUV/FuIC
         3lTHA0ZZTp1I0vngnkQQ/JvtEZgkn07K/fc9nHOw7jxmjE7y2eZfC6BrtEXiFLSKkui3
         U2f9ba0cSe3sez+1M9UwBX6+OVbl8KGIn0T6a61UX6AkHJ8ilUjGvPMdL2wIemJcawFg
         6C4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777591080; x=1778195880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wr4f/O6tnwowWz0YOGfaBNk5o8gSqrjyXSQ8QIaml/8=;
        b=F1VlJ4N8QbqaaNkU/nNdHn1rfbtDVJoI7kYzRCl0DTfr/ckpg9Ka1DqgKkDBGY7TgP
         TWpzQdFKNSvV1B5aCQdW35jcbcFD1e4d3fwY9yo84wAY1wi6t8qPW1va6ad/GDCqkgDe
         RMwjmntcTAl2CV6T/28BSv31+qRdiTaASg/i2ygx02nnkCtYLrlT52K9JJur4+o3N/c6
         MHYdoTVCdd4Z5J+6shE0esyLRlbQL/T4H2apMGmLNElBxBczLvpCeQTun1+Uzlh89jKu
         Fdfc3rBwpKGswB6tHZzr2sTZkKy8bDoKrcrWtkX7xySYtn9iIxvKhkPpXT/90Iytwft7
         5uDQ==
X-Forwarded-Encrypted: i=1; AFNElJ9kePfWJZB8wGTtrN4OYkqFvuz+jYWkaBuJv7JLbE3lun1BPYwK6Gvk7vMCTcY2Acf13LllLmkH5ZS6@vger.kernel.org
X-Gm-Message-State: AOJu0YxV/i1ec8BmxOjJqLWOO1v3XAtLmX4TgKpGd900EzSC/w5EIrVW
	DGqc48IEOPmJZWPJfnlQCmfCWLTZAcA25BODpig3FasOQYbSOU61oaW6CVMpEibiF/ypAII6eIA
	roNOVo2Il6W7EVn4fXYJVOkEs7jTztvuXQgCH
X-Gm-Gg: AeBDiesHRtw+ugBA9eizxxRruXtTsxIFqYmDlD4TSoH+QafhBTFzMGcM0jI/hPpCDnL
	kJrSnJ/qnpq3gn7VpUGETmgnkwovi1myPSWUbD9fVOuiQYJsFNNTgF/y8vyK3mF8ewzoszmOaJL
	U01DK89Re6I6Buuwc2V+1op+WckwTbSnL6dF1WLuUGpCJc4bIUTXtj6GOsZ7zZ8nG76mfxyD1K9
	1mw9ZuesfD75SuV7qDpKlhx1A9IrCWSgiin864Hx14f1PYOguyLjHCS6BpYPrxg4UD/mr1wUAEd
	J8dUcuLJ2YxyhPACjQ==
X-Received: by 2002:a17:907:3e82:b0:ba7:e65:a5f0 with SMTP id
 a640c23a62f3a-bbebe614a46mr27887066b.5.1777591080209; Thu, 30 Apr 2026
 16:18:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12879883.O9o76ZdvQC@rafael.j.wysocki> <CAGAxtY3h4sEphqKL-jiSn4p0NT9mdZtOFrVxW7CDo22XdL56iw@mail.gmail.com>
 <CAJZ5v0ixuF=AQf0_VcPH=4jo5X-HbEB3WvJAnk8_fZes+bjyLg@mail.gmail.com> <12909238.O9o76ZdvQC@rafael.j.wysocki>
In-Reply-To: <12909238.O9o76ZdvQC@rafael.j.wysocki>
From: Evgeny Sagatov <evgeny.sagatov@gmail.com>
Date: Fri, 1 May 2026 02:17:48 +0300
X-Gm-Features: AVHnY4Jqj25Kx5PBJv7oNLRVP3qU3f7s4xB1XbA1jZxGD5_AcSNv8SeOCrXOIeU
Message-ID: <CAGAxtY2J3vBJ9oUh1nt1c9ytRE_o=-rwk7nLKuDN==jW2kodbA@mail.gmail.com>
Subject: Re: Pressing the power button causes the device to freeze completely
 (schedutil involved)
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>, 
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Thorsten Leemhuis <regressions@leemhuis.info>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Wysocki Rafael J <rafael.j.wysocki@intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Linux PM <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Rafael,

I'm leaving on vacation today. I'll be able to conduct new checks
starting May 17th.

Thanks for helping with resolving the issue!

=D1=87=D1=82, 30 =D0=B0=D0=BF=D1=80. 2026=E2=80=AF=D0=B3. =D0=B2 17:42, Raf=
ael J. Wysocki <rafael@kernel.org>:
>
> On Thursday, April 30, 2026 3:57:41 PM CEST Rafael J. Wysocki wrote:
> > On Thu, Apr 30, 2026 at 1:41=E2=80=AFPM Evgeny Sagatov <evgeny.sagatov@=
gmail.com> wrote:
> > >
> > > I noticed that for powersave mode, I'm getting the following values:
> >
> > I guess you mean with the powersave governor.
> >
> > > cat /proc/cpuinfo | grep MHz
> > > cpu MHz         : 2798.689
> > > cpu MHz         : 1999.659
> > > cpu MHz         : 1999.797
> > > cpu MHz         : 2741.103
> > > Also, there's now no difference in the single-core benchmark between
> > > schedutil, ondemand, powersave and performance modes. The benchmark
> > > always gives a very high result.
> > > This wasn't the case before; the modes had different performance leve=
ls.
> >
> > I would expect schedutil, ondemand and performance to give similar
> > scores, but for powersave I would expect the score to be lower.
> >
> > With the same patch applied, can you please switch over to powersave,
> > reset the stats and then capture the output of
> >
> > grep -r . /sys/devices/system/cpu/cpufreq/
> >
> > Also, I'd still like to see the output of
> >
> > grep . /sys/firmware/acpi/interrupts/sci*
>
> Additionally, please remove all of the debug patches sent so far, apply
> the one below and send a dmesg boot log.
>
> I want to check if all of the CPUs use the same control values when
> they write to the frequency scaling control register.
>
> ---
>  drivers/cpufreq/acpi-cpufreq.c |   12 +++++++++---
>  drivers/cpufreq/cpufreq.c      |    1 +
>  2 files changed, 10 insertions(+), 3 deletions(-)
>
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -887,9 +887,14 @@ static int acpi_cpufreq_cpu_init(struct
>                  * unknown and not detectable via IO ports.
>                  */
>                 policy->cur =3D acpi_cpufreq_guess_freq(data, policy->cpu=
);
> +               pr_info("CPU%u: Using I/O space for frequency scaling\n",=
 cpu);
> +               pr_info("CPU%u: frequency scaling control address: %llu, =
bit width: %u\n",
> +                       cpu, perf->control_register.address,
> +                       perf->control_register.bit_width);
>                 break;
>         case ACPI_ADR_SPACE_FIXED_HARDWARE:
>                 acpi_cpufreq_driver.get =3D get_cur_freq_on_cpu;
> +               pr_info("CPU%u: Using FFH for frequency scaling\n", cpu);
>                 break;
>         default:
>                 break;
> @@ -898,13 +903,14 @@ static int acpi_cpufreq_cpu_init(struct
>         /* notify BIOS that we exist */
>         acpi_processor_notify_smm(THIS_MODULE);
>
> -       pr_debug("CPU%u - ACPI performance management activated.\n", cpu)=
;
> +       pr_info("CPU%u - ACPI performance management activated.\n", cpu);
>         for (i =3D 0; i < perf->state_count; i++)
> -               pr_debug("     %cP%d: %d MHz, %d mW, %d uS\n",
> +               pr_info("     %cP%d: %d MHz, %d mW, %d uS, %u\n",
>                         (i =3D=3D perf->state ? '*' : ' '), i,
>                         (u32) perf->states[i].core_frequency,
>                         (u32) perf->states[i].power,
> -                       (u32) perf->states[i].transition_latency);
> +                       (u32) perf->states[i].transition_latency,
> +                       (u32) perf->states[i].control);
>
>         /*
>          * the first call to ->target() should result in us actually
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
>
