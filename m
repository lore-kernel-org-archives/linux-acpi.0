Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE15D3921C6
	for <linux-acpi@vger.kernel.org>; Tue, 28 Apr 2026 19:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777403511; cv=pass; b=JmDpMQctfk8rl8r5tq66TVSf3RbB2qP46n1ZU+Uo4IXWzVKkr23tUyJ6bpKAg4csCOTaurOQeerBLcINLPvbPkTZy/HspxsW+KgYEa8buDTvoMmesRDxwGB18PUEOIK5cqjpyDqDxXx7j5I1AEg3DV16dbLZThTvhiQTr4sTU/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777403511; c=relaxed/simple;
	bh=Humb92FTmdxnR1tjgNxmE7FrXLG/asrw1MJD00P+pg0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uFFZqOfr3bB2ohFeEWzubzMKiNPHuXY1v0J61brZJzrQ8/cgLCQ/zFv6M7238QYri/M6R5nJY53ZdUgVDInoqW7WbnUkkKjP53CJKRsfbq7Htera1z3nSgtecoVBidLEpYdR2KDO+gcR+V0+W1wdU4CYNoSwGalBX2bCE2uuRr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ddgTZG+U; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ddgTZG+U"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b9c3e2cf3c0so1995311666b.1
        for <linux-acpi@vger.kernel.org>; Tue, 28 Apr 2026 12:11:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777403508; cv=none;
        d=google.com; s=arc-20240605;
        b=lSAL7YisEdhDtZACRcVxU/p2A1oN9ztdUmp/pEJcg5HromB18KDgiB7eao9aHlv3Sx
         z2e4gpH1RhPf+IkxktC8aiQFlkA1OQUVHU3X4SBfxdPRqXA1wat0B2dIVo8gof3it2bM
         N8S27mT599Bms1kkmmTgVJcYdJpUAqqxv9a0WEou/czR43v6xbx3zZz8TV7rSxIG/4R/
         gv4Nzf2VB4Qiy+9Rx7Nj6cCzBxkCRU89hQffySHS5GgfA5bWYoxk6fuiI+d2SLo700+T
         3+R1ZWKVkYrvAqi/JQHw5TiMn1vwDrMGITX6F/mWcfp2S6npo0DZ1FSEiahs1FkqeDE1
         PFfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iecOFez/t9e4qazz5GWjB4HvrXVYjjG0JR1pPehAX8o=;
        fh=y4aHP9/yKTl9E2y8g1QJMom7Y2vpS7TKkUaA26RVV9Q=;
        b=Jqv1DNkMV8F2NsBWXxv88jFgUhEpOdD2/zOdapYeNYZEinJlg4FP4JjzBaNNRg85Bk
         nUlMQv9YqhagwxDbWVq+Jod+nMBCYRKMB7SJYHDJ5GkGX8SbABTvo28COhGcwX3XM9qb
         NoKTSuHdUeTMDmJDtPPAZJexwnrlE163RZ7iF7GuaBSeCUgF0UhWei064wo3LfaR1PpJ
         8J/6nDOofUDGeJHCkfghe+RbMRVjmjrEiByvtVnLdskXIjRCQSwjmgSzTdI0/3ZqQiWe
         dcUigyacECul311fRFnJJkRK2WmkC2Y85fh0B379bv1spM1wPHH9R4+5lL46w20LzN1z
         NvAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777403508; x=1778008308; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iecOFez/t9e4qazz5GWjB4HvrXVYjjG0JR1pPehAX8o=;
        b=ddgTZG+Ua17+njbZmdFVLWKpWLtLFpZsVDgZgoKCLzqahSV1IdMWGvWAbm24WYeEXN
         cIyela9W35Fes90fq1gdr9ILsfzDhU8cK4Rwr/wQx4JkG9OHQnVaw8bAJ1yggKGXvZsE
         JIKHAK3fhaCz7Hr0QMt6Mml7tpPxSZhgQ0hHjE1DuoUpxUP/ow+PEjzt73UdhfE0UhBf
         htSirIUqtkx4XNr0faXTJmNQS9290kl74VKn3A23eoWP+t2BWCR58HyApduPiPnONAIj
         qWCZDiZqxh8yPtoi0NqoqqFDY/rhghtnJKcegpwo4gt+utUseEQeuwCDfE2tq8SbcQF3
         UG4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777403508; x=1778008308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iecOFez/t9e4qazz5GWjB4HvrXVYjjG0JR1pPehAX8o=;
        b=WkVApTvscRcRHYjHFky7FQb97W+5kD0ZfE7W2W7hHHPEQPfDbvW81b9BblVqZydhJr
         W42BNv4dYVyLhE5MUr2eFjwP3YKZj5pIRLUA4gnhB3KiNR/1xtNC8Q5ZYmqY28Fn1oju
         58lEKn1mxoRTY8i7S/B9aEykBmwv99k0fwrzxJthlEW5w0y42/e/CZ140Xl5km4vhAg8
         eHJ5VkismTtiUB4QRefCXZrBIizBLRf+UuTgT+7aHqTCSFzmWkPS4BBk/IJrCCDma4va
         f7B0/nrrpi5R/Xj93q7sn0c9ejPEnpLrETnnkiVgQUNQHW8kZz2CT3FAPEDGo/lzHK5y
         npZA==
X-Forwarded-Encrypted: i=1; AFNElJ88M/+vAiyyOvaUEMH+OUaTfbHCtVPBeVwLgTjJn4FHpSk6hHTocfGh7UUwc43oi6QZEDz3QkBlLo8o@vger.kernel.org
X-Gm-Message-State: AOJu0YzF2cLBkGG6FjgX8Iz0YITZlv6KPQkuCP51OvEFfCNgguDjKCSK
	L67eHjzF25VlBP9KuzNtmjhivxksDTr3+37NxQFsaU1A975yGeIkm7BqkowbrRa4suMZPA2LsyS
	a+Gv69QuGSW9xuxoBJzM6nt3rHS232E0=
X-Gm-Gg: AeBDieuYrxebW77sTW/r0Q4NrapyO1IMJk2RtoXda05fFv7mXTIRQNG6ePR9gCbRtSw
	A5Nl+/ychzci18xO/DP64DT/IyAdkMbzpv2FZwV+FXG+o7wO11tB4vxyGHrjcNkgl9j8XWMdiqa
	Df6thee3Tj6i9rbRf8s05c/Tc26XiRiCxEpqunvIiIytrPSihIQ9CCrnJHIvWNydN6Cqn0J6Ys0
	rUlfmSkbn1ziWi2EsPoiK18q3/5P5D0NWWetomyp+q5szR9/oMSKjc7J1UN5++e034b2YLpJV8u
	qzM7Cl1t/M6e72vEiw==
X-Received: by 2002:a17:907:84e:b0:bae:658a:61af with SMTP id
 a640c23a62f3a-bb8039749cdmr271246266b.23.1777403507717; Tue, 28 Apr 2026
 12:11:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12879883.O9o76ZdvQC@rafael.j.wysocki> <6006426.DvuYhMxLoT@rafael.j.wysocki>
 <CAGAxtY2QRhfoP5NjMQOg5WB15DpPcmX3aBWEy70xYKGMveZ_zg@mail.gmail.com> <6281827.lOV4Wx5bFT@rafael.j.wysocki>
In-Reply-To: <6281827.lOV4Wx5bFT@rafael.j.wysocki>
From: Evgeny Sagatov <evgeny.sagatov@gmail.com>
Date: Tue, 28 Apr 2026 22:11:34 +0300
X-Gm-Features: AVHnY4L377X2QAXx4O0aamxxBtBzAaEfurvlcEiSGehkTu_ruA8b29duslqn8ck
Message-ID: <CAGAxtY1VBXN_6xY0WiraJt-BQiYp_kSdTt8xbPkgP8xPB26=WQ@mail.gmail.com>
Subject: Re: Pressing the power button causes the device to freeze completely
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: regressions@lists.linux.dev, linux-acpi@vger.kernel.org, 
	Thorsten Leemhuis <regressions@leemhuis.info>, LKML <linux-kernel@vger.kernel.org>, 
	Wysocki Rafael J <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yes, the PC froze when I pressed the power button.

=D0=B2=D1=82, 28 =D0=B0=D0=BF=D1=80. 2026=E2=80=AF=D0=B3. =D0=B2 20:40, Raf=
ael J. Wysocki <rafael@kernel.org>:
>
> On Monday, April 27, 2026 11:49:51 PM CEST Evgeny Sagatov wrote:
> > apr 28 00:48:34 srv kernel: ACPI power button event
> > apr 28 00:48:34 srv kernel: ACPI event status I/O port number: 1024
> >
> > =D0=BF=D0=BD, 27 =D0=B0=D0=BF=D1=80. 2026=E2=80=AF=D0=B3. =D0=B2 23:31,=
 Rafael J. Wysocki <rafael@kernel.org>:
> > >
> > > On Monday, April 27, 2026 10:12:33 PM CEST Evgeny Sagatov wrote:
> > > > dmesg | grep "frequency scaling"
> > > > [    8.552380] acpi_cpufreq: CPU0: Using I/O space for frequency sc=
aling
> > > > [    8.552386] acpi_cpufreq: CPU0: frequency scaling I/O port numbe=
r: 2176
> > > > [    8.552478] acpi_cpufreq: CPU1: Using I/O space for frequency sc=
aling
> > > > [    8.552480] acpi_cpufreq: CPU1: frequency scaling I/O port numbe=
r: 2176
> > > > [    8.552584] acpi_cpufreq: CPU2: Using I/O space for frequency sc=
aling
> > > > [    8.552586] acpi_cpufreq: CPU2: frequency scaling I/O port numbe=
r: 2176
> > > > [    8.552668] acpi_cpufreq: CPU3: Using I/O space for frequency sc=
aling
> > > > [    8.552670] acpi_cpufreq: CPU3: frequency scaling I/O port numbe=
r: 2176
>
> The I/O ports that play the role in this issue are separate from each oth=
er in
> the address space, but that need not mean that they are physically indepe=
ndent.
>
> My current theory is that accessing one of them while an access to the ot=
her
> one is still in progress may cause the platform to lock up, or there is a=
n
> access pattern that causes that to happen.
>
> Let's first test the simplest variant of that theory and see what happens=
 if
> all I/O port accesses in acpi_os_write_port() are serialized, which is do=
ne
> in the patch below (it is a replacement for all of the patches sent so fa=
r).
>
> In addition, that patch causes schedutil to use the slow path for updatin=
g the
> frequency because the I/O space is generally somewhat too slow to be used
> from the scheduler context relatively often, but that should not affect t=
he
> behavior related to I/O space accesses.
>
> Please check if the system still locks up after pressing the power button
> with this patch applied.
>
> ---
>  drivers/acpi/osl.c             |    9 +++++++--
>  drivers/cpufreq/acpi-cpufreq.c |    9 ++++++---
>  2 files changed, 13 insertions(+), 5 deletions(-)
>
> --- a/drivers/acpi/osl.c
> +++ b/drivers/acpi/osl.c
> @@ -700,8 +700,10 @@ EXPORT_SYMBOL(acpi_os_read_port);
>
>  acpi_status acpi_os_write_port(acpi_io_address port, u32 value, u32 widt=
h)
>  {
> -       if (!IS_ENABLED(CONFIG_HAS_IOPORT))
> -               return AE_NOT_IMPLEMENTED;
> +#ifdef CONFIG_HAS_IOPORT
> +       static DEFINE_RAW_SPINLOCK(acpi_os_write_port_lock);
> +
> +       guard(raw_spinlock_irqsave)(&acpi_os_write_port_lock);
>
>         if (width <=3D 8) {
>                 outb(value, port);
> @@ -715,6 +717,9 @@ acpi_status acpi_os_write_port(acpi_io_a
>         }
>
>         return AE_OK;
> +#else
> +       return AE_NOT_IMPLEMENTED;
> +#endif
>  }
>
>  EXPORT_SYMBOL(acpi_os_write_port);
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -878,6 +878,10 @@ static int acpi_cpufreq_cpu_init(struct
>         policy->freq_table =3D freq_table;
>         perf->state =3D 0;
>
> +       policy->fast_switch_possible =3D !acpi_pstate_strict &&
> +               !(policy_is_shared(policy) &&
> +                 policy->shared_type !=3D CPUFREQ_SHARED_TYPE_ANY);
> +
>         switch (perf->control_register.space_id) {
>         case ACPI_ADR_SPACE_SYSTEM_IO:
>                 /*
> @@ -887,6 +891,8 @@ static int acpi_cpufreq_cpu_init(struct
>                  * unknown and not detectable via IO ports.
>                  */
>                 policy->cur =3D acpi_cpufreq_guess_freq(data, policy->cpu=
);
> +               /* I/O spcase is too slow for fast switching. */
> +               policy->fast_switch_possible =3D false;
>                 break;
>         case ACPI_ADR_SPACE_FIXED_HARDWARE:
>                 acpi_cpufreq_driver.get =3D get_cur_freq_on_cpu;
> @@ -912,9 +918,6 @@ static int acpi_cpufreq_cpu_init(struct
>          */
>         data->resume =3D 1;
>
> -       policy->fast_switch_possible =3D !acpi_pstate_strict &&
> -               !(policy_is_shared(policy) && policy->shared_type !=3D CP=
UFREQ_SHARED_TYPE_ANY);
> -
>         if (perf->states[0].core_frequency * 1000 !=3D freq_table[0].freq=
uency)
>                 pr_warn(FW_WARN "P-state 0 is not max freq\n");
>
>
>
>
