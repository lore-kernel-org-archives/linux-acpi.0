Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7275D391E64
	for <linux-acpi@vger.kernel.org>; Wed, 29 Apr 2026 21:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777497430; cv=pass; b=RQwB1wSxEO5e3xir4z8XHo55S+pssX0NfUFhS9C62F+9eb2JON6zACEeWONxUJTANVaXzssylv0R3Js7Sh5PAR32LvuX+nJOnxsl7J2a1ipi/ghQeNFzV+VGkA/JiHrjZmLW0G6GWv8tBjZWMyS3Cc8PXU5jtYmfiytqS4sQS+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777497430; c=relaxed/simple;
	bh=3bpZh9hQlts0dYs3ZbQFjTJzAxcieL24QZx80d/S960=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sz+wbDsfUHT5nMSBgJBJavaAbMDDAgMAr+q3ivYYFFu+RCPy8vLXt16bkICirSiYu/SfXe34tjCS92K0RS71T8X6BuiG285upC6epwC4VTr9+tafC7fVlKGTGGH2qJn8FsL4xlKJl32ndP6CSBya3XqyBMreRsriJV+26gHIQwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oGwxfCUg; arc=pass smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oGwxfCUg"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-baebe98afa0so25574266b.3
        for <linux-acpi@vger.kernel.org>; Wed, 29 Apr 2026 14:17:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777497427; cv=none;
        d=google.com; s=arc-20240605;
        b=i8Kq3LUdXjdk4rgWMKm+aWJGZIbsUCQo4Uoo9NnlscjNUtSz2HBHI6mGZPn6DUs+v4
         0bRQAjOeUNLc61ciD3beEqKFKG+dOEl02uKPocIBGOcnkoI3qPfJdlorpq++1uoOyOeK
         jKW5EQFuFCiP/6Dnp4opcjQkNJAKf240VY3eQV6PA85D9g/eTro1ymIgpAQwJN6r5v1J
         E889RAhTNiX6RcGQzbqBH56NDuEVvqdM0sQlfIRD93MmcSvkz+/P1dTuzgPsH2jKyCop
         Etm9oA1Rd8hyydWBgrvwF1MWQDWSUkmhgFnPt4zRnVwbJQRhPDFptpmZlhNQnJTlbIyu
         DdCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=j3TppP6mq4j0d1qnbCekTG1cdcTHkaYTXo+iqgksTc4=;
        fh=EVVZIx4GQLraBMHE+qciyM2Ei9Oih66h7nn84oF459Q=;
        b=O+lUtK/ABLWfubxM3b0gzDd42gjTV9jgWLbrr9fKiDTPPI3OzPCRXlLgMnQb3DHMov
         5B3FonRDHI/oz0XjYeHXzC8YUcrSNV2UlH91y7ErHyzTv0L1TJRCTwgbjBKXALHgFEBg
         9zn9wS3j/gZ38bkPZokADaNpgOfB5jlp70L0DjE31+yLaqNmB4YoVXi223IiQVk3/PIL
         E65oC4gm+0MBfoI5TZBbWvieyjeAAlhZprR54Aa/uyTeFX50ll4a1Yz3ndqkm7pOxJXs
         KjwM+ehhOrwK5dMQVc/CUMHS90Kdf3Ywh6ZL1mKiHuPNy3TPIFJ6GMM5qc1SrLDJGxi4
         +bTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777497427; x=1778102227; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j3TppP6mq4j0d1qnbCekTG1cdcTHkaYTXo+iqgksTc4=;
        b=oGwxfCUgM2j0H+KgmYNl4kr9Fm2idd/VjwpGWU22oWgIkOoe1MZiJZ57rrqbYhriJ4
         swIMMXK82cRjv8//KOejvvkktdcyBKdpfkGYHYURYeajFDdNcHZmF+2DRvbefQj0gefu
         5bevneD8zq+t73R8vpo3h1ERqy9+4ACNzpGlGWtcVXDgeWkuLUrYKUR8f2BAO1yHLh7g
         ZHYoVvQINO8P86kEZkF8pFBj4niyio4513u9AU6U6/gb2bWx+XmeN4sG5oKORVEm77k3
         XP+/6bqje5997bipLgjySQ3HoGtMvKXbJtWfxXccit6LKDuNI/iEjGj7lrz2Rkiprswm
         I6qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777497427; x=1778102227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j3TppP6mq4j0d1qnbCekTG1cdcTHkaYTXo+iqgksTc4=;
        b=qTc2Pr6zdg/0qWGjsyooPdCqj3L6Ojc5wa+ZeFsBVtt86QOEvVHF4ApLXQe9naCGt9
         ghSFKLQDs1E/O9EKdiZqNVpe4nRjS2lYhhWXv8KZh20NfpMb/dwuab2r1RNlU3mOGBfk
         +3nFiuoQjfEHlOgK1Fq1PM/FuGaLEFQfM0OiA7kRhE9wwNKmqQd05e1jpnlXTC5agKHH
         MZwYDgJlD2Z0A5R8CpIoJ9R/sss/npX0vsKOLz5n/BDzzjJUYzRTYHHy9+YEuosz/t0K
         D7RLR6fnz1lweTVsyX7wN0egyZFMilkaXEdJ93viKbf1VkUPtXD6n2vDFAC44w0aA0nF
         +plg==
X-Forwarded-Encrypted: i=1; AFNElJ9br4Vd5LaKpHgHv3xRtyrq4YJiL0Aova/NUPcTTW39/q9M5qt8+PyRSm+gvfY9d2BhGTc9byhJpgMY@vger.kernel.org
X-Gm-Message-State: AOJu0YwEVxrVE1v4EoWelvP4XmY/TN0jXVjhRNsEdryv4aQhoCKYgxjX
	GExOQa+9QW/bfY3aL2IitYaZKtf/BCHn5idzet8bSxGq4QsVjKjYmC6LUUptCndLPeto1IKnKW5
	ZF1LIuBYA4EORQh4GVtwytDWauVQ+Og4=
X-Gm-Gg: AeBDieuISI7tJM1pVV8VwOjmGLO/m6teB8Ew29AGNga1M2rhwsOMmYTeE9PCzjoWOVs
	rxV5o3Dls82w9nDOi0k5XsJ2F6zDDHxWoGP9l/0quHW5t0eakefDAehdnCJ+8JT75nW4t5UubTV
	ELGQVRrHMV/N10mcH3nFpNqNsl6U6MxJKu12c/XWuqhTT/AJ6p2uyZq3sPS6MEFmvs9GCSCwLqB
	znDDlYhb9UN6+IKYgSg34NaVwmOF/4GE6xR1bcpdH+WrXH4jAK+SqMeMt7JKnMuq/wUVCIb5oUm
	rSl1b9ss9Rbg2Rn6Ug==
X-Received: by 2002:a17:907:a286:b0:b9c:5cf3:50a6 with SMTP id
 a640c23a62f3a-bbac7e84109mr21464166b.30.1777497426616; Wed, 29 Apr 2026
 14:17:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12879883.O9o76ZdvQC@rafael.j.wysocki> <CAGAxtY2SEkx7OgMgM5ypA8qsBN0h6pcs111VjnhD-5ZGq7Je6Q@mail.gmail.com>
 <CAJZ5v0ikAeu7cW9K6sfKYbbsVK51GOsFrX-qv3KJ7cVr-gRHew@mail.gmail.com> <6010375.DvuYhMxLoT@rafael.j.wysocki>
In-Reply-To: <6010375.DvuYhMxLoT@rafael.j.wysocki>
From: Evgeny Sagatov <evgeny.sagatov@gmail.com>
Date: Thu, 30 Apr 2026 00:16:51 +0300
X-Gm-Features: AVHnY4KQuLV8jtSJgaT06T0eu5vZOeUPrvaMqIdpG3nAv6ESCUXOtpijMALDXbk
Message-ID: <CAGAxtY2N-=3taOBCTFZzEmm4NqJ-KhtsWq0fNts_tn3nAxpkTA@mail.gmail.com>
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

The PC froze when I pressed the power button.

grep -r . /sys/devices/system/cpu/cpufreq/
/sys/devices/system/cpu/cpufreq/schedutil/rate_limit_us:240
/sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq:2000000
/sys/devices/system/cpu/cpufreq/policy0/scaling_available_governors:perform=
ance
schedutil
/sys/devices/system/cpu/cpufreq/policy0/freqdomain_cpus:0 1 2 3
/sys/devices/system/cpu/cpufreq/policy0/scaling_governor:schedutil
/sys/devices/system/cpu/cpufreq/policy0/cpuinfo_max_freq:2834000
/sys/devices/system/cpu/cpufreq/policy0/scaling_available_frequencies:28340=
00
2000000
/sys/devices/system/cpu/cpufreq/policy0/related_cpus:0 1 2 3
/sys/devices/system/cpu/cpufreq/policy0/scaling_cur_freq:1999759
/sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed:<unsupported>
grep: /sys/devices/system/cpu/cpufreq/policy0/stats/reset: =D0=9E=D1=82=D0=
=BA=D0=B0=D0=B7=D0=B0=D0=BD=D0=BE =D0=B2 =D0=B4=D0=BE=D1=81=D1=82=D1=83=D0=
=BF=D0=B5
/sys/devices/system/cpu/cpufreq/policy0/stats/trans_table:   From  :    To
/sys/devices/system/cpu/cpufreq/policy0/stats/trans_table:         :
2834000   2000000
/sys/devices/system/cpu/cpufreq/policy0/stats/trans_table:  2834000:
      0       844
/sys/devices/system/cpu/cpufreq/policy0/stats/trans_table:  2000000:
    843         0
/sys/devices/system/cpu/cpufreq/policy0/stats/total_trans:1687
/sys/devices/system/cpu/cpufreq/policy0/stats/time_in_state:2834000 1164
/sys/devices/system/cpu/cpufreq/policy0/stats/time_in_state:2000000 14130
/sys/devices/system/cpu/cpufreq/policy0/affected_cpus:0 1 2 3
/sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq:2834000
/sys/devices/system/cpu/cpufreq/policy0/cpuinfo_transition_latency:160000
/sys/devices/system/cpu/cpufreq/policy0/scaling_driver:acpi-cpufreq
/sys/devices/system/cpu/cpufreq/policy0/cpuinfo_min_freq:2000000
/sys/devices/system/cpu/cpufreq/policy0/cpuinfo_avg_freq:1999759
/sys/devices/system/cpu/cpufreq/policy0/bios_limit:2834000

=D1=81=D1=80, 29 =D0=B0=D0=BF=D1=80. 2026=E2=80=AF=D0=B3. =D0=B2 23:22, Raf=
ael J. Wysocki <rafael@kernel.org>:
>
> On Wednesday, April 29, 2026 8:24:02 PM CEST Rafael J. Wysocki wrote:
> > On Tue, Apr 28, 2026 at 11:05=E2=80=AFPM Evgeny Sagatov
> > <evgeny.sagatov@gmail.com> wrote:
> > >
> > > The PC also froze with this patch when I pressed the power button.
> >
> > Which means that the issue is not simply a matter of the lack of
> > synchronization between different I/O space accesses, so most likely
> > the problem lies deeper.
> >
> > Let me summarize what we've learned so far (and expand the CC list some=
what).
> >
> > For those who have not seen the previous discussion, it is at:
> >
> > https://lore.kernel.org/lkml/CAGAxtY2SEkx7OgMgM5ypA8qsBN0h6pcs111VjnhD-=
5ZGq7Je6Q@mail.gmail.com/#r
> >
> > 1. The issue is basically that the platform locks up completely when
> > the power button is pressed
> >
> > This is reproducible 100% of the time.
> >
> > The power button processing flow is that, if the power button event is
> > enabled in the ACPI PM1_ENABLE register, pressing the button causes
> > the corresponding status bit in the ACPI PM1_STATUS register to be
> > set, which in turn causes an ACPI interrupt (SCI) to trigger (both
> > PM1_STATUS and PM1_ENABLE registers are accessible through the I/O
> > address space).
> >
> > The SCI processing involves reading both the power button status and
> > enable bits and clearing the former if set (this needs to be done or
> > an interrupt storm would start if the status bit was not cleared).
> >
> > We don't actually know which of the steps above specifically causes
> > the platform to lock up, but that doesn't matter too much because all
> > of them are necessary.
> >
> > Clearing the power button enable bit in PM1_ENABLE prevents the issue
> > from occurring (but then the power button obviously doesn't work).
> >
> > 2. The issue only occurs if the schedutil cpufreq governor is used
> >
> > If either the "powersave" or "ondemand" governor is used instead, the
> > issue doesn't appear.
> >
> > Also switching over to a different cpufreq governor (on all CPUs)
> > before pressing the power button makes the issue go away.
> >
> > 3. The issue didn't occur at all before commit e37617c8e53a
> > ("sched/fair: Fix frequency selection for non-invariant case")
> >
> > Reverting the merge that introduced commit e37617c8e53a into the
> > mainline makes the issue go away.
> >
> > 4. The issue occurs regardless of how schedutil invokes the cpufreq
> > driver ("fast switch" vs sugov_deferred_update())
> >
> > 5. The cpufreq driver in question is acpi-cpufreq and it uses a
> > control register located in the I/O address space (the same control
> > register is used for all CPUs)
> >
> > 6. If acpi-cpufreq is not allowed to write into the control register
> > at all, the issue doesn't occur
> >
> > 7. Synchronizing all of the I/O space accesses in the ACPI-related
> > code (via a spinlock), including acpi-cpufreq, doesn't prevent the
> > issue from occurring
> >
> > So overall, it looks like the control register access pattern in
> > acpi-cpufreq that results from schedutil's use of it after commit
> > e37617c8e53a somehow puts the platform into a state in which a power
> > button event causes it to lock up at the hardware level.
> >
> > While there are a couple of things more to check, I'm afraid that
> > there may not be a viable way to address this issue other than
> > replacing the schedutil governor with ondemand on this platform.
>
> Below is one more patch to try.  It should cause acpi-cpufreq to use
> one shared cpufreq policy instead of 4 per-CPU policies which is
> more adequate because the CPUs share one control register.  It should
> also cause acpi-cpufreq to update the control register only on CPU0.
>
> Let's see if this changes the control register access pattern sufficientl=
y
> to work around the power button problem.
>
> In any case, please send the output of
>
> $ grep -r . /sys/devices/system/cpu/cpufreq/
>
> from a kernel with this patch applied.
>
> ---
>  drivers/cpufreq/acpi-cpufreq.c |   10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -743,7 +743,7 @@ static int acpi_cpufreq_cpu_init(struct
>         if (result)
>                 goto err_free_mask;
>
> -       policy->shared_type =3D perf->shared_type;
> +       policy->shared_type =3D CPUFREQ_SHARED_TYPE_ANY;
>
>         /*
>          * Will let policy->cpus know about dependency only when software
> @@ -751,9 +751,9 @@ static int acpi_cpufreq_cpu_init(struct
>          */
>         if (policy->shared_type =3D=3D CPUFREQ_SHARED_TYPE_ALL ||
>             policy->shared_type =3D=3D CPUFREQ_SHARED_TYPE_ANY) {
> -               cpumask_copy(policy->cpus, perf->shared_cpu_map);
> +               cpumask_copy(policy->cpus, cpu_present_mask);
>         }
> -       cpumask_copy(data->freqdomain_cpus, perf->shared_cpu_map);
> +       cpumask_copy(data->freqdomain_cpus, cpu_present_mask);
>
>  #ifdef CONFIG_SMP
>         dmi_check_system(sw_any_bug_dmi_table);
> @@ -913,7 +913,9 @@ static int acpi_cpufreq_cpu_init(struct
>         data->resume =3D 1;
>
>         policy->fast_switch_possible =3D !acpi_pstate_strict &&
> -               !(policy_is_shared(policy) && policy->shared_type !=3D CP=
UFREQ_SHARED_TYPE_ANY);
> +               (!policy_is_shared(policy) ||
> +                policy->shared_type =3D=3D CPUFREQ_SHARED_TYPE_ANY) &&
> +               perf->control_register.space_id !=3D ACPI_ADR_SPACE_SYSTE=
M_IO;
>
>         if (perf->states[0].core_frequency * 1000 !=3D freq_table[0].freq=
uency)
>                 pr_warn(FW_WARN "P-state 0 is not max freq\n");
>
>
>
