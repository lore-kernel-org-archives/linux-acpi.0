Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A714389DFF
	for <linux-acpi@vger.kernel.org>; Mon, 27 Apr 2026 21:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777326609; cv=pass; b=GMYK/tWyikoXztQpSKF//Y0BRp0Tj6OskI30PSYh9TiCzUVkqYradnc5rX5vm3gADCLuHqqYbuGEQs2aIdSbcL7b58703TdoADNvzSh7zSbI3lDMMzD9NhGBSi8AHKZpMOyDgU+sCCG6b22mTlA7yJuuTZl26teRGdo7Lqu4Pys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777326609; c=relaxed/simple;
	bh=L7xa02X7WdX9x9vHRITtqt4+zXkzCD26OYMMG+OjAXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZManF3lkcw3iPmFMJdIRPw+CV0mhcapO0pb+L/7106L7cGja+zIZDbdk8i90rA4NwrASDvfjdPgQq1zcZcm1MoZlvkpKtREsZQ/CjeG5gmkTuOOd2KKuRKwDfKwbck9sXVDWHK/GkAEweebR3Gf8bgbUWnIMCUQwO9Bf+CHN1Gk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m9bnshga; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m9bnshga"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b8f9568e074so1772327466b.0
        for <linux-acpi@vger.kernel.org>; Mon, 27 Apr 2026 14:50:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777326605; cv=none;
        d=google.com; s=arc-20240605;
        b=PiOeSWc1C+f5D40T2F/zSOsBP8Tqwk/WednzA/O4F4EYcNHC+s7CzCALuueITymT5K
         6SazpIBOwdg6qDIbiJwNmgmnwO5o0SjBrHLnemqs6Jsito3UA6P18AIqIG/Y+aSYQNub
         0FlqKyLkGHOtyyTvuDgUrWBfqKM4kngyVFK7cYClo/dV4pUgtZQY7xHw3QAbc5bOo5mP
         XQ68TTa/SAGDUrR4EhjidsfxFocNlRrJKhJbD7pcRu5t3xaUhlQnghgaZERRhgl7AF1U
         kYc4pmejngDKkAOZXv/eG2YhhcA8+z3aU0Y7Zox+u1cGUDhct7+JV0SwdPwsMRmT3mQ6
         nYTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oXNTkuokTYZhJ+ynIL21Ir8zjvS3sW03jWnhSBy68kg=;
        fh=XwyZo3oJRfpka4MEK/7yw/iW1Ye7Dv3nv3mcKxjZ+iw=;
        b=fgeVdbfeA9NQpDQQwsCp7XdPjBWZfncN+bUn86yyTybTESUFqBkKzxvWQY4XBUJm8P
         g2W6UX4eahZ/TROhKAh3JTqojgwgMQDVHN9RNWJotE6zGtV5xGqan3WxnV8Y1ql0Rb7D
         hOYngUeIRhwXRYqe/r/nVwHb5nNyYRvxk9L1j9jesajGjdWU+7K6bPlX73sXAc6oV8e7
         FVzrQeW97Yoy47MUz/SjH+3VqEGY1ldC1UIbZFpFIC4latn46NPbk9O5fR+i5qXLrVFu
         IKMcnUGZSLxSOmV+rnFi+irQXrhGILUQDTzrMGO1UOFCDKFzvzsImyQYFhGYgddRwO2N
         G8gA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777326605; x=1777931405; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oXNTkuokTYZhJ+ynIL21Ir8zjvS3sW03jWnhSBy68kg=;
        b=m9bnshgaSiTwlZdgR/YaRwwkOxOHu9ABD77EGr3zNsHL8iCCtBG51yCLuIBeOw3ey/
         ov3+3gs/oB5Hd4qx7zX65nrCVJhZnKL1cWhgGkfQjLQYTwL2KB+UJ267B/os06Ry9kMw
         KB9nMJ4OMgC8w7lEHJdP49jftL7Sd87GKH8geyWtKILjNeQbmi830wptDj57OSa768Dn
         jrLgJIxgImG5qW/IKnfIvX7mjM15raRnPy6mFHfLMgDBJRzQU+AYCkteWXBvTk2UFI0m
         ZUWsiVx4IuraNpX0IIHEz9tJgbiKOhP9+uhbItzH04IFP40+0rOgkOGZMaM/9AE2CDw9
         dTxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777326605; x=1777931405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oXNTkuokTYZhJ+ynIL21Ir8zjvS3sW03jWnhSBy68kg=;
        b=adpi0NuI8kCG6YdfIlWhU3C6IBKoKU3eAyVSUI2PQX5HYeYrW1EbHC0Xr5w/ljQ//e
         48M+R/9IwiGO+3UImS62hIWZDkeqaoCdAQT+L/KdZoJE6H77a8t+g5FoYhpZTz0UdzhH
         6TQiZKWUfzVnxjYo6mxg/auQdZnpoPlXWR4EvME7+qEXzaMhyp8GZf25p/iqU7cU0u/a
         0NI2U1PxebifqNVi0lqQ6FSxymR53BcRXjmhg5RZxdLIn27kx4gWZUwWKWpK4Iar9QEQ
         j2R380K6GhWZSfY0YAuJEqeDLBVrBAAExVaWmI++NA05T2cNH4fSi0Fb4pg478d4QzR9
         WEjw==
X-Forwarded-Encrypted: i=1; AFNElJ+ANtW5jlfg7wwUEjoUt+ftodadZGeIinBOk5vX7oHUj0JZt7ejzJYmqemD97Q800Bex/otmmjhDvGB@vger.kernel.org
X-Gm-Message-State: AOJu0YxDZ7uuR+vXvafck1yz0STLQtb2V+bS3U4jNfqHRNST6rrvbthe
	H8NomLJN7JwkNXxZrp+r36SxmYfD5YCwWsvspPua/ZzUNFPQski0oIyxh322RDc9A/0xO/Mqy04
	P6ISS8sRkdXTjWEIYYGv1gDMeG8HcFms=
X-Gm-Gg: AeBDiesCSNlXIxpoZZFfOLiZ3GxuyVXZ9u8srl3KvU7fhVnwYcrzL098tJ7DcxyVtQO
	QK4255LgXGFX4cyzjTSRaPymXNlRNaid9oqc5Tq63XIWkHrzF6lSPN5iG4laouZkwwzFlpDToDT
	HlsNJCzIAb1EOl9XrMJQvcQfBJd0sSe/7Kg9nomjOiwNVh7anPv+olMmwj8W7HIw+9hmWlB+Ax/
	xX54HXq2Bzzdfetr4h0GBgF4BsuSk+xuTwpVzh8NvPunMPwU3PeK4WDOzrk3OuUoabYiAMfngx2
	wG59EehfJH1Nibvfpw==
X-Received: by 2002:a17:907:5c4:b0:bb7:e621:1fb7 with SMTP id
 a640c23a62f3a-bb803d65610mr27224366b.36.1777326604854; Mon, 27 Apr 2026
 14:50:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12879883.O9o76ZdvQC@rafael.j.wysocki> <6005325.DvuYhMxLoT@rafael.j.wysocki>
 <CAGAxtY28bho6+PRoEypepAK1UpmGQ8WzkvPnUEmGvx7vWqkHeA@mail.gmail.com> <6006426.DvuYhMxLoT@rafael.j.wysocki>
In-Reply-To: <6006426.DvuYhMxLoT@rafael.j.wysocki>
From: Evgeny Sagatov <evgeny.sagatov@gmail.com>
Date: Tue, 28 Apr 2026 00:49:51 +0300
X-Gm-Features: AVHnY4LYfieYFEwFkIH9vT0bp_c4_c5sUBtPRqiCRcUPccxdXq9Voy4SegmRU2I
Message-ID: <CAGAxtY2QRhfoP5NjMQOg5WB15DpPcmX3aBWEy70xYKGMveZ_zg@mail.gmail.com>
Subject: Re: Pressing the power button causes the device to freeze completely
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: regressions@lists.linux.dev, linux-acpi@vger.kernel.org, 
	Thorsten Leemhuis <regressions@leemhuis.info>, LKML <linux-kernel@vger.kernel.org>, 
	Wysocki Rafael J <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

apr 28 00:48:34 srv kernel: ACPI power button event
apr 28 00:48:34 srv kernel: ACPI event status I/O port number: 1024

=D0=BF=D0=BD, 27 =D0=B0=D0=BF=D1=80. 2026=E2=80=AF=D0=B3. =D0=B2 23:31, Raf=
ael J. Wysocki <rafael@kernel.org>:
>
> On Monday, April 27, 2026 10:12:33 PM CEST Evgeny Sagatov wrote:
> > dmesg | grep "frequency scaling"
> > [    8.552380] acpi_cpufreq: CPU0: Using I/O space for frequency scalin=
g
> > [    8.552386] acpi_cpufreq: CPU0: frequency scaling I/O port number: 2=
176
> > [    8.552478] acpi_cpufreq: CPU1: Using I/O space for frequency scalin=
g
> > [    8.552480] acpi_cpufreq: CPU1: frequency scaling I/O port number: 2=
176
> > [    8.552584] acpi_cpufreq: CPU2: Using I/O space for frequency scalin=
g
> > [    8.552586] acpi_cpufreq: CPU2: frequency scaling I/O port number: 2=
176
> > [    8.552668] acpi_cpufreq: CPU3: Using I/O space for frequency scalin=
g
> > [    8.552670] acpi_cpufreq: CPU3: frequency scaling I/O port number: 2=
176
> >
> > Messages that appear when I press the power button:
> > apr 27 23:07:33 srv kernel: ACPI power button event
> > apr 27 23:07:33 srv kernel: ACPI event status register ID: 3
>
> Of course it's a power button, so the register ID is 3 and the register
> is PM1.  Sorry for missing that previously.
>
> Please apply the slightly update patch below (which replaces the previous
> one) and send the messages printed to the log after booting the new
> kernel and pressing the power button.
>
> ---
>  drivers/acpi/acpica/evevent.c  |    8 ++++++++
>  drivers/cpufreq/acpi-cpufreq.c |    8 ++++++--
>  drivers/cpufreq/cpufreq.c      |    1 +
>  3 files changed, 15 insertions(+), 2 deletions(-)
>
> --- a/drivers/acpi/acpica/evevent.c
> +++ b/drivers/acpi/acpica/evevent.c
> @@ -243,6 +243,14 @@ static u32 acpi_ev_fixed_event_dispatch(
>         (void)acpi_write_bit_register(acpi_gbl_fixed_event_info[event].
>                                       status_register_id, ACPI_CLEAR_STAT=
US);
>
> +       if (event =3D=3D ACPI_EVENT_POWER_BUTTON) {
> +               pr_info("ACPI power button event\n");
> +               pr_info("ACPI event status I/O port number: %llu\n",
> +                       acpi_gbl_xpm1a_status.address);
> +
> +               return (ACPI_INTERRUPT_HANDLED);
> +       }
> +
>         /*
>          * Make sure that a handler exists. If not, report an error
>          * and disable the event to prevent further interrupts.
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -479,8 +479,8 @@ static unsigned int acpi_cpufreq_fast_sw
>                         return next_freq;
>         }
>
> -       data->cpu_freq_write(&perf->control_register,
> -                            perf->states[next_perf_state].control);
> +       /*data->cpu_freq_write(&perf->control_register,
> +                            perf->states[next_perf_state].control);*/
>         perf->state =3D next_perf_state;
>         return next_freq;
>  }
> @@ -887,9 +887,13 @@ static int acpi_cpufreq_cpu_init(struct
>                  * unknown and not detectable via IO ports.
>                  */
>                 policy->cur =3D acpi_cpufreq_guess_freq(data, policy->cpu=
);
> +               pr_info("CPU%u: Using I/O space for frequency scaling\n",=
 cpu);
> +               pr_info("CPU%u: frequency scaling I/O port number: %llu\n=
", cpu,
> +                       perf->control_register.address);
>                 break;
>         case ACPI_ADR_SPACE_FIXED_HARDWARE:
>                 acpi_cpufreq_driver.get =3D get_cur_freq_on_cpu;
> +               pr_info("CPU%u: Using FFH for frequency scaling\n", cpu);
>                 break;
>         default:
>                 break;
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
