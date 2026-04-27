Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D3430C34A
	for <linux-acpi@vger.kernel.org>; Mon, 27 Apr 2026 20:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777320771; cv=pass; b=pwlhKsrf/MMhyUU6yV8WLHEck/1VTnSkizc9LBucnzkJsNmLta4HBaSsJatCf08K20I4XNKTFBpBYTzrofa4GANdY2r2G+39EIg64VspV/ZCSwFvMui+T/LUKUjXyMApKA6hbRbTNzQAEUjJ/xI2uaR/6LwDUSCx2o5Avh3Onzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777320771; c=relaxed/simple;
	bh=9vW/3lbk7DRjYsT62iTadU0jnqJlWuda0DAKNWjxLyU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N4zifSKSq84hJh6fge4XAdIgmctrOQ83MZH4QBx5B7DIo/jkI1Peny1YNnMPckNSV5iD4KMCF5mrfrdQuAmB15OAsVC9CFVuyAp1fu9v1sol8xJyXArjr6A5T0w9ASvU2ox6KlMS8XWPg8S9RzOibrhN1PpuZ/gw36CAZQC/Bys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qn5bI33M; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qn5bI33M"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b9358bc9c50so1414696366b.1
        for <linux-acpi@vger.kernel.org>; Mon, 27 Apr 2026 13:12:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777320767; cv=none;
        d=google.com; s=arc-20240605;
        b=UaORSgp2AyMT5032ZJKoaO1THdKyT1Ro6btNPrhD51sbiflSz2bw2avtMp4Nov7pBl
         9JMqPMBWBqK1cacJ9wUxRe/gqE0wM8LaxBxxocX4jgD4sYQeMMXZVMFCUskwSsNUaCY4
         vUZM+KDvtXygahc/5wSATq9usjLUzfR+MLKogiY6OyXoWDFEY32r6+qMhSdW2ntxZPmb
         5DTv1yM4SCJeuitr+Scxv0lq79DDZZDwSTxwadp+OTe1sjHpdwPHBTCg6/tTWso0ph2L
         EorDe3W6qPp1IuWHvh8aSeyFRxwDRccfitYuCrDViQNoELn7+rwEdun6DU0weNkmVBA1
         jbZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=COXxo1EcXVAZxC6kJw+zQp1hv6Gelh8PpeiNjEsxWao=;
        fh=QkIVgW1reL0BbYlHD6QAANUZ6ZvnZRzMGjmBLJufuHU=;
        b=RzD1B17KUYLXNSEEHTr24INtno4wOkU47cNiXN4ETFk4fGeh+JpKQhCfzYPueRMhJV
         ESzKwQRXd/DHmrHljhGSJtn0+ZdzcWdZKLPzsnwrAFiBlUfdh9c/QpUsJlK+DJlwV8L5
         i/1Ub35evkVvAXxFinh1GQW4FIwfh7zedjSXCF2Yxq5vv39Cwcvv8uvLGuY5QBjVIERh
         6dG6L/wK5EW+17cTzw7UVi18Z9YegLyZlYHMxVxvgBmtKh2MOL0d035snQgSZo4yfVYd
         irFfVe8QggLNTYjqpjTJILzmWVtJwx0YGb7EQjpfiqJ3C/8VA1wuLwHtKCd8FQT5NZsd
         fa+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777320767; x=1777925567; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=COXxo1EcXVAZxC6kJw+zQp1hv6Gelh8PpeiNjEsxWao=;
        b=qn5bI33MUGrKJUSNOW4uD7SPkVmXzajpQAHEipgkgwvSKAWH3EQ0h9Of+H2b3X1uhC
         D+Ux5DAijDW6Je88qyGc43164dGRmOx5KVz32iM/LrPdBP/W1iXBRQPS2FVKlEYql75l
         KiAWRm6UirBLDzAlI4sdqLQJ9DZ5wa4GySjLUR7gWZKW2RiAcwpXPadHntlvq26Ic5eY
         GxVvzcdxN954YcGkIq4cXkAPU7QKyGormHFu1T8m0qoV/DQTqPivhhRvaVjW+2kPfwEP
         36DUxW+18kkXXgI6jWHAh39jZLctna0yGPHueiV9UacF4vHcuvr1xdBN9ynU4xEBLPOm
         0Dgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777320767; x=1777925567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=COXxo1EcXVAZxC6kJw+zQp1hv6Gelh8PpeiNjEsxWao=;
        b=kWbVwXSYY4AuV4eB02dsWD2UPkjwrbbqOTszWJ4H8i2nnkeQIHyHAc9gcqBCd2Lvjh
         NJvLgm8axLK40q4hZ7L5H7MM5ajhAsuiBwsVqNFmRb3EhzAy0yDsMrb+uoMwZMNXB3JT
         e3qFzneHNw4syd3MxOpwi9jm6oLqgkgwwSSjypqjGvGv0+XkLZjxIEp/7XBtVgiIxnah
         7fi3FKwx6hcN9gzRcNt5gpyeINrwdYQJp4p4TEnJNK4pEhRDxbmhnekz1Nng3PIvnEJC
         3GFHPrbxuLKLkod6GLx1sYDF0tibPvUgLbID9ZitNVTMZrjBaLx2/qNNqHTF83oZXjlR
         GQBA==
X-Forwarded-Encrypted: i=1; AFNElJ9BNOFxlDwixNT4zQqE6uw/7C5cCL9OWcH/BRZ8boXt9PxhGRpwTbzkOCRLddYEWdde5f3Uo1d0v/vx@vger.kernel.org
X-Gm-Message-State: AOJu0YwHh95jBU9c7N+mo+8vRRATwDcws3y6Ph/6TSNEUpVv2ycEVbZg
	Kc8eXOCT4mp1sKXzSimTGWHRJ6RupgF3cMvQ5G2fGZjSQMk0RrcOeyqAzK6RyEy8bOU4tPQGiZp
	YISnBAgVfLim6s4LWR31EeKvlDAIHZ2s=
X-Gm-Gg: AeBDiesrRp4w9hfvt9omaBAXdxEDvS4t5wHQrIerxP4fLdrzsP84Nc7JDw2Fzst8Mk6
	aJ8y0XW99AOPin7A8TAYm1AJ24mx1Y8/MkG6oZ2I9RTXSK9dHrwrM0P1dKiS/x0DVoMso0Trofc
	vpcHHOkbUIXEvgBSB9NCO324Pe/UapdRmmoMRH+jNRGw0nmBP8jpRacJgNN+PbYcTIAVpFPyeke
	XpigZoV0+CoE1IUo8PiHe3WFMUko686cVX6dAGU3fmhgw9c5dG+VmgbBYVb6tC9I+NviPwpPxNM
	QTYH9KEb5FrJy5ZGyw==
X-Received: by 2002:a17:907:c80d:b0:bad:9363:901c with SMTP id
 a640c23a62f3a-bb801ad745dmr17228366b.17.1777320767005; Mon, 27 Apr 2026
 13:12:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12879883.O9o76ZdvQC@rafael.j.wysocki> <CAJZ5v0ivGuRESW2B1_+8s1=YSm9YV4FAuc1CB9FGTdwHZuGZNA@mail.gmail.com>
 <CAGAxtY3HF3iOV7ZKq9-LTjyA-p3jNVHKSi5CBM8AJ38LYUdXbw@mail.gmail.com> <6005325.DvuYhMxLoT@rafael.j.wysocki>
In-Reply-To: <6005325.DvuYhMxLoT@rafael.j.wysocki>
From: Evgeny Sagatov <evgeny.sagatov@gmail.com>
Date: Mon, 27 Apr 2026 23:12:33 +0300
X-Gm-Features: AVHnY4K1H0QdQfslenLzI8QP0Rb2KcBnE4tILgx6uOQOuGCNKAaG_1hI1lBixqo
Message-ID: <CAGAxtY28bho6+PRoEypepAK1UpmGQ8WzkvPnUEmGvx7vWqkHeA@mail.gmail.com>
Subject: Re: Pressing the power button causes the device to freeze completely
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: regressions@lists.linux.dev, linux-acpi@vger.kernel.org, 
	Thorsten Leemhuis <regressions@leemhuis.info>, LKML <linux-kernel@vger.kernel.org>, 
	Wysocki Rafael J <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

dmesg | grep "frequency scaling"
[    8.552380] acpi_cpufreq: CPU0: Using I/O space for frequency scaling
[    8.552386] acpi_cpufreq: CPU0: frequency scaling I/O port number: 2176
[    8.552478] acpi_cpufreq: CPU1: Using I/O space for frequency scaling
[    8.552480] acpi_cpufreq: CPU1: frequency scaling I/O port number: 2176
[    8.552584] acpi_cpufreq: CPU2: Using I/O space for frequency scaling
[    8.552586] acpi_cpufreq: CPU2: frequency scaling I/O port number: 2176
[    8.552668] acpi_cpufreq: CPU3: Using I/O space for frequency scaling
[    8.552670] acpi_cpufreq: CPU3: frequency scaling I/O port number: 2176

Messages that appear when I press the power button:
apr 27 23:07:33 srv kernel: ACPI power button event
apr 27 23:07:33 srv kernel: ACPI event status register ID: 3

=D0=BF=D0=BD, 27 =D0=B0=D0=BF=D1=80. 2026=E2=80=AF=D0=B3. =D0=B2 21:48, Raf=
ael J. Wysocki <rafael@kernel.org>:
>
> On Sunday, April 26, 2026 10:45:03 PM CEST Evgeny Sagatov wrote:
> > dmesg | grep "frequency s"
> > [    8.622778] acpi_cpufreq: CPU0: Using I/O space for frequency scalin=
g
> > [    8.622806] cpufreq: CPU0: Fast frequency switching enabled
> > [    8.622869] acpi_cpufreq: CPU1: Using I/O space for frequency scalin=
g
> > [    8.622888] cpufreq: CPU1: Fast frequency switching enabled
> > [    8.622938] acpi_cpufreq: CPU2: Using I/O space for frequency scalin=
g
> > [    8.622955] cpufreq: CPU2: Fast frequency switching enabled
> > [    8.623006] acpi_cpufreq: CPU3: Using I/O space for frequency scalin=
g
> > [    8.623026] cpufreq: CPU3: Fast frequency switching enabled
> >
> > When I press the power button, a message is displayed:
> > apr 26 23:40:36 srv kernel: ACPI power button event
> >
> > The PC does not freeze.
>
> Good.
>
> > The single core performance benchmark shows good values.
>
> That most likely is a coincidence.
>
> The above means that the issue is related to HW accesses in the I/O space=
.
>
> I don't actually think that the writes to the I/O space outright clash wi=
th
> each other, but the timing between them may be somewhat overly aggressive=
.
>
> Let's first check what I/O ports come into play though.
>
> Please apply the patch below (which is a replacement for the previous one=
),
> run
>
> $ dmesg | grep "frequency scaling"
>
> after a fresh boot of the new kernel and let me know the output of it.
>
> Then, press the power button and send the messages printed after that.
>
> ---
>  drivers/acpi/acpica/evevent.c  |   12 ++++++++++++
>  drivers/cpufreq/acpi-cpufreq.c |    8 ++++++--
>  drivers/cpufreq/cpufreq.c      |    1 +
>  3 files changed, 19 insertions(+), 2 deletions(-)
>
> --- a/drivers/acpi/acpica/evevent.c
> +++ b/drivers/acpi/acpica/evevent.c
> @@ -243,6 +243,18 @@ static u32 acpi_ev_fixed_event_dispatch(
>         (void)acpi_write_bit_register(acpi_gbl_fixed_event_info[event].
>                                       status_register_id, ACPI_CLEAR_STAT=
US);
>
> +       if (event =3D=3D ACPI_EVENT_POWER_BUTTON) {
> +               pr_info("ACPI power button event\n");
> +               if (acpi_gbl_fixed_event_info[event].status_register_id =
=3D=3D 0)
> +                       pr_info("ACPI event status I/O port number: %llu\=
n",
> +                               acpi_gbl_xpm1a_status.address);
> +               else
> +                       pr_info("ACPI event status register ID: %u\n",
> +                               acpi_gbl_fixed_event_info[event].status_r=
egister_id);
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
