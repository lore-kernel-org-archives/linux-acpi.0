Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992CD35F607
	for <linux-acpi@vger.kernel.org>; Sun, 26 Apr 2026 14:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777215290; cv=none; b=tZWDCpGtOlqjIAWNajXBo7tfBIWR44CF/DZucCr+4KLrOTFEl3KOb8Hhax/Jv+ypOYXBYkL1PoxImPYlkWeCmGfnRXmQ4kwdGWSSro0g2X0j9VN1dVtddS4VtvSVdCUj7QLM5778VeoeaDMmONLxba76RJMkgnKToQVQRAALQHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777215290; c=relaxed/simple;
	bh=PE1bu2R4cY5F8hyCzflHpztxeJP9+RVe4SgL8Nib3CA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VzSCqUOEoNzBrF/k4j+Oj06+tftaFfeR7H2kZY78LJEu85WRpp0Pjbhk53NE1nCKUi1TGE/AfVHlmPXt4RNTHpB8TrgBqqil7kwOsEQsxMKvQD/dFo17HHB7jOGNAhpVyb6gh+m2H93lzBvIkz78t01TGPe+Y6OQodtwtgYYxmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SOVmaFfF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SOVmaFfF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53836C2BCB3
	for <linux-acpi@vger.kernel.org>; Sun, 26 Apr 2026 14:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777215290;
	bh=PE1bu2R4cY5F8hyCzflHpztxeJP9+RVe4SgL8Nib3CA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SOVmaFfFv3f3Y+gfOZa1rEE0kskfDMj3UgSaIWHZmHeaMfaPMjIFI8By6GV4umK+f
	 tG3eTuGBtsDIMjziaHIRBg4+dsx2PcfBXAkvp9t6lykNooB93YxhoEgvdX/51vSQvi
	 7PeHFFGLV7MvAgtwSCggyWLxwZNotwWa1k31yp44oyijilerAVmk+IU1VdCP3oC+5c
	 hNAg68bgjzd7yz5V61dHuQ9UK+MCpN3wdBxC5wePR8Eu/VoEr7eFqb/dGVl30pTjbj
	 NVR6YesqeGZySPoTA/WpDsNNORtjmRnRTgpa9GIZRNY4pzB4CLKitMZgseVkF7b9L5
	 n2Oql755NXGaw==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-38e7d984096so102865371fa.2
        for <linux-acpi@vger.kernel.org>; Sun, 26 Apr 2026 07:54:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+Tbnz3ouC+M9zPB9Qhwp7cTODzObHy7loFJMfvQOo75BltxSsgCr1AW4zRzl9IB9Hg/3Qr6bsov2ZA@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4RfBGY6xDAp/q+d9Px2c68r2nucOMfY8AUdf4NnPIHg7ktx5P
	djoQKQG5cnN9a9kB5AX5xFylEWQFdgLspSB4fLKXZGl3luFfMHZ9/VnRXGgxSRIVf4PqxcJwoQf
	lGZauObFQlOnMoyuZ0FmO5n0qzG93pO0=
X-Received: by 2002:a05:6512:304d:b0:5a4:b02:66a2 with SMTP id
 2adb3069b0e04-5a4172e1bd6mr14266016e87.27.1777215288585; Sun, 26 Apr 2026
 07:54:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12879883.O9o76ZdvQC@rafael.j.wysocki> <12895688.O9o76ZdvQC@rafael.j.wysocki>
 <CAGAxtY13R3F6M4HFiwwsx8SEbcUsu5mQKJrayaCGFp14cEB2wg@mail.gmail.com> <5112068.31r3eYUQgx@rafael.j.wysocki>
In-Reply-To: <5112068.31r3eYUQgx@rafael.j.wysocki>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sun, 26 Apr 2026 16:54:35 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ivGuRESW2B1_+8s1=YSm9YV4FAuc1CB9FGTdwHZuGZNA@mail.gmail.com>
X-Gm-Features: AVHnY4K4wlTWBcKV34exd4EIq4YabdF6GMiNdF7nI52lASiFWODZMxpTxZO5Mf4
Message-ID: <CAJZ5v0ivGuRESW2B1_+8s1=YSm9YV4FAuc1CB9FGTdwHZuGZNA@mail.gmail.com>
Subject: Re: Pressing the power button causes the device to freeze completely
To: Evgeny Sagatov <evgeny.sagatov@gmail.com>
Cc: regressions@lists.linux.dev, linux-acpi@vger.kernel.org, 
	Thorsten Leemhuis <regressions@leemhuis.info>, LKML <linux-kernel@vger.kernel.org>, 
	Wysocki Rafael J <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 26, 2026 at 4:50=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Friday, April 24, 2026 11:18:02 PM CEST Evgeny Sagatov wrote:
> > dmesg | grep "Fast frequency"
> > Nothing was displayed.
> >
> > The PC froze when I pressed the power button. Nothing in the log.
> >
> > I applied this patch after deleting all the previous ones. Is this corr=
ect?
>
> Yes, it is.
>
> > I received this message when applying a patch. Perhaps we have
> > different versions of the source code? I'm using 7.0.0.
> > patching file drivers/acpi/acpica/evevent.c
> > patching file drivers/cpufreq/acpi-cpufreq.c
> > Hunk #1 succeeded at 895 (offset -17 lines).
> > patching file drivers/cpufreq/cpufreq.c
>
> That should be fine.
>
> We've switched over schedutil to a different code path and the problem is
> still there, so it appears to be related to hardware accesses.
>
> To test this, please apply the patch below (which is a replacement for th=
e
> previous patch) and collect the output of
>
> $ dmesg | grep ""

This should have been

$ dmesg | grep "frequency scaling"

(pressed "send" too early, sorry about that) but sending a complete
dmesg log (which would be produced by grepping for an empty string)
would work either.

> after a fresh boot.  Please let me know what's there.
>
> Also, the "Fast frequency switching enabled" messages should be back.
>
> Then, check what happens when the power button is pressed (if the system
> doesn't lock up, a message should be printed to the kernel log every time
> the power button is pressed).
>
> With this patch applied, schedutil will not access hardware in the fast
> frequency switching path, so the frequency scaling will not actually work
> (this is roughly equivalent to running the "performance" or "powersave"
> governor all the time).
>
> ---
>  drivers/acpi/acpica/evevent.c  |    5 +++++
>  drivers/cpufreq/acpi-cpufreq.c |    6 ++++--
>  drivers/cpufreq/cpufreq.c      |    1 +
>  3 files changed, 10 insertions(+), 2 deletions(-)
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
> @@ -887,9 +887,11 @@ static int acpi_cpufreq_cpu_init(struct
>                  * unknown and not detectable via IO ports.
>                  */
>                 policy->cur =3D acpi_cpufreq_guess_freq(data, policy->cpu=
);
> +               pr_info("CPU%u: Using I/O space for frequency scaling\n",=
 cpu);
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
>
