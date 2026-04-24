Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337B2347C7
	for <linux-acpi@vger.kernel.org>; Fri, 24 Apr 2026 21:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777065500; cv=pass; b=rD9k1eoo7cATeN7j87JHVoIOcLRDhRJmHN8MrPQ5dkzKDainVsHKQipvy5HDarT6yA9NWJ26GjZ9kcpLpxQx3ee2yhbJe5BKz45r9gRA9iIw78Pc+JXAkhjShfff9u9bnBNasPwVYOAx60d4YlaC5qSGzs1NS30tZQii+XQFbpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777065500; c=relaxed/simple;
	bh=lz585B6WwMiI2wowDHqw9h6Q9k9rsSJa7Fgv8ysQuAQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OfFPw0JbcGe7/EptU5QqKGLTod3+F7cZmTSJXJxzhABq93AAFYTvJx3pfTvENvb0Vl3pPPX0pZKARqqYfIhLRAuuEQ0CbMLr3vB5Je6cMFvYzQY49obv+OT5/Nocoaq/iVor0ePEhpxB+9O9oWaYDCHYh4m9r5b2zylEXKDeWts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EAI65fue; arc=pass smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EAI65fue"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ba67b332bbaso944910666b.0
        for <linux-acpi@vger.kernel.org>; Fri, 24 Apr 2026 14:18:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777065498; cv=none;
        d=google.com; s=arc-20240605;
        b=IdmSkRzNivXqwuvWdAIt7sF/zv8tv6qAYHeeU5nTtFkfCssfa+KDbaYNkyLq+f4zjB
         8L8Oa7qMxCZ1dRsbe3Nwp27REWlfulaiHEXZaOE8wGvexqnUQWm28Dqqmfl2Jg0nAcOT
         EdiFBWtIbiVBatRyV3Z48gPygBq5+lggbfGSzRyvPzUKczVVYsfFL6fEbx4cqxhSVyOq
         kcF19Tpw7J4vncHFDbpdw77KpO0VYqIhtSBkRiUN8YxeDmTnf07JabMlZIbF0D540HbR
         5q+3LATOMC1spZ5wjc4eLxc+cM743jF80n2a7DEEf5BQsbljmbtMaxZBy0dia4CjuO4H
         1KKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=U5w6t51wi/NJAU0rulc7jt2qH+Lioz+UwXc7O5pAq7g=;
        fh=7YzDRVfzCfHOHtMcWlUvlKDUoidXrGo32c31f2bystw=;
        b=JvJRuOvEcb8DPYws9u3wzKCRX81D2s6FVlu7anZbzlm0Fsok1rMhktbr0PKSWzxzGo
         RnIY+DL6bnOsZErb86pX0CDfP7jrZEordVxuqQ7kFtjDLKzr79I0K2A6mHeo4Ad+7dow
         Q55ctuSA61jgBWVxe3pFSfeL7+Rmp6g7pObkQsJt1RAN9dVEXUvkggqMQI1qVmaiwiMm
         IpAzQ8Onp/2pQC7gHgGBDF7BS7YVlK04LRi2gtb/13VFRa+SJkFXFDmOgkNppdfuhpU7
         ZIn9bThu5rzeZsLqMcNGmJl7eTZWVqtIR87fK5SOE7kjg5YpOVWD0cDJP7HlbUY3Z/pC
         KxPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777065498; x=1777670298; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U5w6t51wi/NJAU0rulc7jt2qH+Lioz+UwXc7O5pAq7g=;
        b=EAI65fueuET1xI++jinpwuhYwcwaxn/2h4+iJ+RujpY/5LQpeOGVLwWe7EkSv1/r+4
         dNBeNo7m0WRe0ZaEPmsN0o/zUAvhC2x3gnV1tavMeqGKQFV+I/aRmVD6hOw4fg7QNChl
         /2bvEU2F7zw93rxpkCNMX3tN3dvC5O9Pdovp91PpXSr6nageX1vQzEPv9HWBwxdUKcPf
         MoUeV29MmOzRNnsKKTxQbcY1HO+9A8BxgfmdDqV6k6CUeTLzSFnJA2yOz8IpbiBUwufi
         F3plKlBHVsRF/uvJttA8edlUjHXPTkB6hHhUNTAHjHNa0oF+ciscAJJh97mAxLlmK9v4
         uR1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777065498; x=1777670298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U5w6t51wi/NJAU0rulc7jt2qH+Lioz+UwXc7O5pAq7g=;
        b=XsMm3/Q9sFKST9u/YYoAm+6cQmJrtvDZjD/+LkVd/KrATuvnGLuGbQ4YRpTh5g6rp7
         dIejxJLP/nRcAYptOYtqXMlMqVDzQh0rFRQoGmgL/kpD0Qsf6PhswIDOczJG4wex4yfg
         bYRBLKk1DtQ3UH9UWUiR7LNkcsZbfle7uRV1rZg3yv0GLtUphEnQxuYz1tC6Tg/zaeWK
         rWgBN0sHGX2/j/21Y/edEu3lruir79OdGOPDUJdnyi1guhC5byMGbdH9Skov/Oc3BwPr
         nfH2j/x8f9lfMJ8ojQBkaMKLEf+t9SRJ5jNsraXvRbh2CC3QnbLyBblwxLfbaYJGNAOG
         bPeg==
X-Forwarded-Encrypted: i=1; AFNElJ+ifxG3tPhKKaa0a2gJaMtwUqcQ+euAf1VFMIILJXBGFHggI66Bnqv7+tUBlbvgWIJthm7oibVaFGid@vger.kernel.org
X-Gm-Message-State: AOJu0YwG28XTeHq90rgSDXhBdvlMMXtrK/axFlqhgIJZryWpmekBVGKV
	Ub62xeTZnYY6zRG3rlJPEFNIX3+ZdXRQB20UqSu3OF4WOc34NHZDnH/AnERpOFsTkJ6I+z+cYCu
	yrfD4D4lKbhi+Dw/bodlmuX84jx9rKFrPty3O
X-Gm-Gg: AeBDiesEyhUjjeIgrbhf0Exr/pT0xdwWyifrPXmle16q1Vb0HtshDrrx/HwLriqIbyJ
	CK4gADaqpuh5+Zwz2+NLLNxTCVE703W1LzwyoHxYeSkn/uKV/wMqvGUb5qRs+fBpdiKOxY6oCjQ
	73bA03DhqpBxkubwZV5mLm3k3a1vkY+hvx+ViMxwF5HHwolrzUsanGsDe5+fy6YSnRtcoCsdJfW
	h1DI4Kkp4dCldiNXZz6qW3Re3+xFmFPrszEnKbseadh+7c2H68npEK3tRvBtccGHMVGt060xUGM
	Ey0S+VTPH1XiLpetpA==
X-Received: by 2002:a17:907:2d09:b0:bad:6134:7125 with SMTP id
 a640c23a62f3a-bad61347395mr313790766b.38.1777065497270; Fri, 24 Apr 2026
 14:18:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12879883.O9o76ZdvQC@rafael.j.wysocki> <5107109.31r3eYUQgx@rafael.j.wysocki>
 <CAGAxtY0av_gAk6Up9W8RHjrzWurHEou4RBNnv5wwSEsTUNT52Q@mail.gmail.com> <12895688.O9o76ZdvQC@rafael.j.wysocki>
In-Reply-To: <12895688.O9o76ZdvQC@rafael.j.wysocki>
From: Evgeny Sagatov <evgeny.sagatov@gmail.com>
Date: Sat, 25 Apr 2026 00:18:02 +0300
X-Gm-Features: AQROBzBbz2A88RJqj9dFXx4Zfq70CenLvK7W2crgZXC-_gqkK-m5N4_vzzAGsQY
Message-ID: <CAGAxtY13R3F6M4HFiwwsx8SEbcUsu5mQKJrayaCGFp14cEB2wg@mail.gmail.com>
Subject: Re: Pressing the power button causes the device to freeze completely
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: regressions@lists.linux.dev, linux-acpi@vger.kernel.org, 
	Thorsten Leemhuis <regressions@leemhuis.info>, LKML <linux-kernel@vger.kernel.org>, 
	Wysocki Rafael J <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

dmesg | grep "Fast frequency"
Nothing was displayed.

The PC froze when I pressed the power button. Nothing in the log.

I applied this patch after deleting all the previous ones. Is this correct?

I received this message when applying a patch. Perhaps we have
different versions of the source code? I'm using 7.0.0.
patching file drivers/acpi/acpica/evevent.c
patching file drivers/cpufreq/acpi-cpufreq.c
Hunk #1 succeeded at 895 (offset -17 lines).
patching file drivers/cpufreq/cpufreq.c

=D0=BF=D1=82, 24 =D0=B0=D0=BF=D1=80. 2026=E2=80=AF=D0=B3. =D0=B2 22:45, Raf=
ael J. Wysocki <rafael@kernel.org>:
>
> On Friday, April 24, 2026 7:06:50 PM CEST Evgeny Sagatov wrote:
> > dmesg | grep "Fast frequency"
> > [    8.903099] cpufreq: CPU0: Fast frequency switching enabled
> > [    8.903181] cpufreq: CPU1: Fast frequency switching enabled
> > [    8.903247] cpufreq: CPU2: Fast frequency switching enabled
> > [    8.903316] cpufreq: CPU3: Fast frequency switching enabled
>
> If it is enabled, let's try to disable it and see what happens.
>
> > When I pressed the power button, the PC froze. Nothing in the log.
>
> Below is an updated version of the previous patch which additionally
> disables fast frequency switching in the ACPI cpufreq driver that is
> in use on your system.
>
> The "Fast frequency switching enabled" messages should not be there
> any more in the log with this patch applied (please verify) and
> please check if pressing the power button will still lock up the
> system.
>
> ---
>  drivers/acpi/acpica/evevent.c  |    5 +++++
>  drivers/cpufreq/acpi-cpufreq.c |    3 +--
>  drivers/cpufreq/cpufreq.c      |    1 +
>  3 files changed, 7 insertions(+), 2 deletions(-)
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
> @@ -912,8 +912,7 @@ static int acpi_cpufreq_cpu_init(struct
>          */
>         data->resume =3D 1;
>
> -       policy->fast_switch_possible =3D !acpi_pstate_strict &&
> -               !(policy_is_shared(policy) && policy->shared_type !=3D CP=
UFREQ_SHARED_TYPE_ANY);
> +       policy->fast_switch_possible =3D false;
>
>         if (perf->states[0].core_frequency * 1000 !=3D freq_table[0].freq=
uency)
>                 pr_warn(FW_WARN "P-state 0 is not max freq\n");
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
