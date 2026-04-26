Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3892750E6
	for <linux-acpi@vger.kernel.org>; Sun, 26 Apr 2026 20:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777236321; cv=pass; b=kookRUctcBKcyhEwEQtGjGKjJqiKxPV4usDcldpBlJlQ/vxCIQXqxuW+MMgWa56bYLzlO0Y121MxnqzDMnKzBY7k9rm7iCN4qOo1emPNvFLOzP9MK6HJ+V8lgJXHudjLat0oD8SK8qvuXfEFcDJqWAmz8Y8ZM/yXaNsheNFXIn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777236321; c=relaxed/simple;
	bh=xsCqiLWlmlKEfzOlQLOq2KagHtUsAxco7lxmqPv4vFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pxdP6c2cNzd65++UQUIblDnDC0ZH6rrQV/amhyUr0/zkCG6miN9OEtfvHss2c3VJKsX2fkFymLUvaTXiGMJZmP+s1jf2nAEIqsYlUQQJrIFSKgtt5zBtcIQrJRt3iQaNugLvrTTXto1ZmOSwpFyESTe0xOk4fpcLREGYet5xxQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HbAzUklU; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HbAzUklU"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b9d9971d059so1353827066b.2
        for <linux-acpi@vger.kernel.org>; Sun, 26 Apr 2026 13:45:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777236317; cv=none;
        d=google.com; s=arc-20240605;
        b=aEqX8CB+4f+bXEeZ1dc1cg888ctFSCbywFqcA05AiEeGfIkF+m9SQnrPfcUVghrzzZ
         YIF6ttEeekIDuT9IKQcW8cmTfKe0MnjRVAjN4Ys+FBKKXLazPrEB2+FG7GNcTpSPyqgC
         CQ4a1BO9Y3kc4QnIVp+A5nFBDbYCxmUng3b7cqwWMvL5+CosSQ4Ug28t9IHzVxXRMmNm
         E1SePtV88swjC7hHMV/3AhXBjj4RQBy0H2qqHcH39WBGogpNea7RX/eopBzdjlamibdJ
         5cCKjAmBZ0UKAitMSG6m0xYUj+dmU8osm1+YK5JD++uqKme7ebVkGeLNhWsUHLW/NOnZ
         x7QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=H42zUt22pJHq35qrT9HLLcYii5EQ25Njx0nZAlGKwMA=;
        fh=gekNmFa5vFEy6RuAF1k8NammWi9YFBXeZQhesPc/Y30=;
        b=k9Qc7/F3pDm+gPHc3oRGhsRp4jTF1pDKEYSCzWuTIbJEnX7MhWsDT+0TV2no5bARo3
         9C4cJTY3XdXichzp/uVibcxVFI/clSdS/EYZLLv0EQWN5Man7rIf2t+BGHD+ADxsIKzN
         wUz0KriA7U/209ceM1aAmctvvJiM6g3App6eT8Jrfz5Y5Cv8bHqjeVbyR7H7oaLlIKNk
         fPdFhULdwWVf4MXLO4VdROADjCp1LuJQoXlIQJtGep6jOTfNeUSNvkmqDbw3LErjUnaX
         XrMbTe/ihnvmRat3QCDraXjEfiz9dvORmO6DFL574ICXSMu5CLDh/p/lTifBUxwzwk6c
         ATfg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777236317; x=1777841117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H42zUt22pJHq35qrT9HLLcYii5EQ25Njx0nZAlGKwMA=;
        b=HbAzUklUsyBMk727h5CTVYNpSgoMaQQdxj2ERWcGt3IWhkhgLDkeOuZ9G7XnOwGV6D
         ZF11UpgcZ9F14qk1D4DHGhq77+c1y2PQ56vJgvIUFWGeGJG++w2B05D7zNDKgp8WPTYg
         rE9elo29vj6vjP79Qlw6TzpELYCPGZ5oLpy9W+D2Qr2MEAZBvC9YEYyaEfc0sKFAVoFB
         /F+lW6g+K3LSFpF47dnYmdmCv8Gv77S67ePaVXUWfRcG1uhQw2Wx2K//1YrfF68OONLc
         aik8J4n3BWYXYv2B4kbF5HeOhEKhjRF2eH6sNuAKCXyx3NdSuSqc9m9bNmLgxirXJnmH
         9A5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777236317; x=1777841117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H42zUt22pJHq35qrT9HLLcYii5EQ25Njx0nZAlGKwMA=;
        b=WsnLyq9SVMCI90pPojzXELVksYMuWT0yHgXei0BbIhs/jOznKWIZyxeMIgd1PzLbhl
         SokYSTLFCJ/H5eWuCeIEyRUJjz6puUTgMD9DAe6bpBQPwxcqUXrnTpVjeoCQritBivrN
         EoBFA0neE7lV4qNFFlabmBmwqgZNDmTol5TElivBuWGr/DUIoR0rzRd5TwDYHjq5/RLl
         Mw9kW8FoLZ17IwYFw6xQANst3PGc1rif1AL3ovdcITA1FWKX/vpNhBtniuyWUQWxTVvf
         7qK/HBgHA8Dy/JdBwu0JyS7Ud4VPG5yfurJv0qPY+17orngKKpD2YuyiPP7HCgARRXX1
         0b5g==
X-Forwarded-Encrypted: i=1; AFNElJ+pr/wgwholKLtyu9XRJrMRVKmq/XlYoMIepTrvmJYfqyiAmbAoknlZ3QXiGIRDmc38LyHQYmDr8yfb@vger.kernel.org
X-Gm-Message-State: AOJu0YzMUeO2Mu3vMuVOjAZwBR+Tn0DyRu4cShNDtB53D92oDDwE46b7
	gZJgPyx4ylhahOVLtLeSxpQnkq7ASdUcLo/SbVP+iJ8olVqBSRGXgWvWRCg3uzScRznTO9nbTt1
	fXEvURjr71uzCVRHytuMwT4exWC93RbI=
X-Gm-Gg: AeBDieuDMe8NSRrbfGAH2Mbb35S/nARmKZRhNGaJJX7Oppq/Nme5MZAUS/FiQlUCGHY
	Z7ws4y9AF2/yHDQ92UmacZNNJtV0m/sM21TahGg4vhOMY2eQBZoRa5aAMdSm0CN0xltu2b10ZBo
	Hhv0cmmafB8sRPoGycHoiwwTKAoYZBhk5IEjDhSIIUv9BhJh8qFzTp9BwOPHj4lpnA4kYSfKhZi
	M3zVsHsxpIYb95cnmiA4KSjzAgdF+FX2XiCFZGoatqFv4zgzz04RQR3CJHSWVWUrppedJBJqMnu
	Qu1lgWjkNat1qp5TUA==
X-Received: by 2002:a17:907:d03:b0:baa:2d37:cbf9 with SMTP id
 a640c23a62f3a-baa2d37ce1bmr1034416966b.1.1777236317215; Sun, 26 Apr 2026
 13:45:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12879883.O9o76ZdvQC@rafael.j.wysocki> <12895688.O9o76ZdvQC@rafael.j.wysocki>
 <CAGAxtY13R3F6M4HFiwwsx8SEbcUsu5mQKJrayaCGFp14cEB2wg@mail.gmail.com>
 <5112068.31r3eYUQgx@rafael.j.wysocki> <CAJZ5v0ivGuRESW2B1_+8s1=YSm9YV4FAuc1CB9FGTdwHZuGZNA@mail.gmail.com>
In-Reply-To: <CAJZ5v0ivGuRESW2B1_+8s1=YSm9YV4FAuc1CB9FGTdwHZuGZNA@mail.gmail.com>
From: Evgeny Sagatov <evgeny.sagatov@gmail.com>
Date: Sun, 26 Apr 2026 23:45:03 +0300
X-Gm-Features: AVHnY4JCKXiEdZaeifSP1mB5o8qE3MJnXWsD_ALENnorm_5WHY2xGSdQErODl3U
Message-ID: <CAGAxtY3HF3iOV7ZKq9-LTjyA-p3jNVHKSi5CBM8AJ38LYUdXbw@mail.gmail.com>
Subject: Re: Pressing the power button causes the device to freeze completely
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: regressions@lists.linux.dev, linux-acpi@vger.kernel.org, 
	Thorsten Leemhuis <regressions@leemhuis.info>, LKML <linux-kernel@vger.kernel.org>, 
	Wysocki Rafael J <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

dmesg | grep "frequency s"
[    8.622778] acpi_cpufreq: CPU0: Using I/O space for frequency scaling
[    8.622806] cpufreq: CPU0: Fast frequency switching enabled
[    8.622869] acpi_cpufreq: CPU1: Using I/O space for frequency scaling
[    8.622888] cpufreq: CPU1: Fast frequency switching enabled
[    8.622938] acpi_cpufreq: CPU2: Using I/O space for frequency scaling
[    8.622955] cpufreq: CPU2: Fast frequency switching enabled
[    8.623006] acpi_cpufreq: CPU3: Using I/O space for frequency scaling
[    8.623026] cpufreq: CPU3: Fast frequency switching enabled

When I press the power button, a message is displayed:
apr 26 23:40:36 srv kernel: ACPI power button event

The PC does not freeze.
The single core performance benchmark shows good values.

=D0=B2=D1=81, 26 =D0=B0=D0=BF=D1=80. 2026=E2=80=AF=D0=B3. =D0=B2 17:54, Raf=
ael J. Wysocki <rafael@kernel.org>:
>
> On Sun, Apr 26, 2026 at 4:50=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.=
org> wrote:
> >
> > On Friday, April 24, 2026 11:18:02 PM CEST Evgeny Sagatov wrote:
> > > dmesg | grep "Fast frequency"
> > > Nothing was displayed.
> > >
> > > The PC froze when I pressed the power button. Nothing in the log.
> > >
> > > I applied this patch after deleting all the previous ones. Is this co=
rrect?
> >
> > Yes, it is.
> >
> > > I received this message when applying a patch. Perhaps we have
> > > different versions of the source code? I'm using 7.0.0.
> > > patching file drivers/acpi/acpica/evevent.c
> > > patching file drivers/cpufreq/acpi-cpufreq.c
> > > Hunk #1 succeeded at 895 (offset -17 lines).
> > > patching file drivers/cpufreq/cpufreq.c
> >
> > That should be fine.
> >
> > We've switched over schedutil to a different code path and the problem =
is
> > still there, so it appears to be related to hardware accesses.
> >
> > To test this, please apply the patch below (which is a replacement for =
the
> > previous patch) and collect the output of
> >
> > $ dmesg | grep ""
>
> This should have been
>
> $ dmesg | grep "frequency scaling"
>
> (pressed "send" too early, sorry about that) but sending a complete
> dmesg log (which would be produced by grepping for an empty string)
> would work either.
>
> > after a fresh boot.  Please let me know what's there.
> >
> > Also, the "Fast frequency switching enabled" messages should be back.
> >
> > Then, check what happens when the power button is pressed (if the syste=
m
> > doesn't lock up, a message should be printed to the kernel log every ti=
me
> > the power button is pressed).
> >
> > With this patch applied, schedutil will not access hardware in the fast
> > frequency switching path, so the frequency scaling will not actually wo=
rk
> > (this is roughly equivalent to running the "performance" or "powersave"
> > governor all the time).
> >
> > ---
> >  drivers/acpi/acpica/evevent.c  |    5 +++++
> >  drivers/cpufreq/acpi-cpufreq.c |    6 ++++--
> >  drivers/cpufreq/cpufreq.c      |    1 +
> >  3 files changed, 10 insertions(+), 2 deletions(-)
> >
> > --- a/drivers/acpi/acpica/evevent.c
> > +++ b/drivers/acpi/acpica/evevent.c
> > @@ -243,6 +243,11 @@ static u32 acpi_ev_fixed_event_dispatch(
> >         (void)acpi_write_bit_register(acpi_gbl_fixed_event_info[event].
> >                                       status_register_id, ACPI_CLEAR_ST=
ATUS);
> >
> > +       if (event =3D=3D ACPI_EVENT_POWER_BUTTON) {
> > +               pr_info("ACPI power button event\n");
> > +               return (ACPI_INTERRUPT_HANDLED);
> > +       }
> > +
> >         /*
> >          * Make sure that a handler exists. If not, report an error
> >          * and disable the event to prevent further interrupts.
> > --- a/drivers/cpufreq/acpi-cpufreq.c
> > +++ b/drivers/cpufreq/acpi-cpufreq.c
> > @@ -479,8 +479,8 @@ static unsigned int acpi_cpufreq_fast_sw
> >                         return next_freq;
> >         }
> >
> > -       data->cpu_freq_write(&perf->control_register,
> > -                            perf->states[next_perf_state].control);
> > +       /*data->cpu_freq_write(&perf->control_register,
> > +                            perf->states[next_perf_state].control);*/
> >         perf->state =3D next_perf_state;
> >         return next_freq;
> >  }
> > @@ -887,9 +887,11 @@ static int acpi_cpufreq_cpu_init(struct
> >                  * unknown and not detectable via IO ports.
> >                  */
> >                 policy->cur =3D acpi_cpufreq_guess_freq(data, policy->c=
pu);
> > +               pr_info("CPU%u: Using I/O space for frequency scaling\n=
", cpu);
> >                 break;
> >         case ACPI_ADR_SPACE_FIXED_HARDWARE:
> >                 acpi_cpufreq_driver.get =3D get_cur_freq_on_cpu;
> > +               pr_info("CPU%u: Using FFH for frequency scaling\n", cpu=
);
> >                 break;
> >         default:
> >                 break;
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -473,6 +473,7 @@ void cpufreq_enable_fast_switch(struct c
> >         if (cpufreq_fast_switch_count >=3D 0) {
> >                 cpufreq_fast_switch_count++;
> >                 policy->fast_switch_enabled =3D true;
> > +               pr_info("CPU%u: Fast frequency switching enabled\n", po=
licy->cpu);
> >         } else {
> >                 pr_warn("CPU%u: Fast frequency switching not enabled\n"=
,
> >                         policy->cpu);
> >
> >
> >
> >
