Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D9B2BEFF6
	for <linux-acpi@vger.kernel.org>; Thu, 23 Apr 2026 14:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776955911; cv=pass; b=cTLiOHiqUODwCqIFjTh3xMcvN2548KPWFuRJW9u2M0l1weD5aU7zCm1427sVIKAPvxnyoZOo9jwnZrk8L/a5WUXLVJeAmCTfj8uwaMAnvcveMuoh/cp4KiCICD/31UwI+WI7Js4F0CJdo2TWQWtzHTXVJEjRRSRV6GubLK/SW9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776955911; c=relaxed/simple;
	bh=Tvt+6PAwQGXnwKvbAByp2cPSTvij5Ijun8m6mGBO50k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=boI7Ei/IU9zAQJ51NAMpqM/4PLHB04JwXlMz2O5XVipmN7LSQVdUTPnWLH+JlGjW5Ti7J7/I88bYk8XjbKcwhMZcRFui8GDMtdC2Pmus/qamfCZ3fUhe0Xz/VxKBkv3lv4Am4o0ea4ngyKW9n5MgwavMdUyOhQdrCY8HS2uh7Wg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ODWLMJVF; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ODWLMJVF"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ba922426c5cso130299166b.3
        for <linux-acpi@vger.kernel.org>; Thu, 23 Apr 2026 07:51:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776955909; cv=none;
        d=google.com; s=arc-20240605;
        b=Uhy5xuUKA65cVjV3+RlgWS31hrAx+25hYspbiGioXdL6Fq8YB6KJvTCzao65KQKiaa
         BJXz+kztwa1AKKtmW2hPGI5Dixp+BKYeGVeS4gfixBve5YK2q7s8NGv1YvWL43HtvTDD
         gZHfQEVlt/Y6vsXy4kKLf6cPac9SCJO5Y4VW3MbAy7TjmFu5Oilj/EiPsxnkdwVOqO8m
         nm6mcw+7PvCJ3s4lJpve4g1q8valNpqPahVtHh8pkO8vmMyf/jh9lNsLY40JLkk8KLcV
         Av9JA08f1bbbBb/nryFrftfNx2gPzB4MWwDljfV2InpfQtW+NSOFxCpRH0keJB4GsCTw
         YFng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hNRA6uaMpTQXVK/P2OTZ4gcm9H3zQjkQ6p6Olm+4n1w=;
        fh=/MiYjmRmJPDZAgHDkB6UV5CQgT6MDcYArHlCy1xjiko=;
        b=RGHNWMkcCizGL600sBXjrbIs5COihau9CRjLsJK2vZyhh1HdcjfskKHWcEUWnx2fu6
         rqdKoayVQa/Qa3MyvaqNaXzEdQFNY1Tv7Cs4H9nuMmqTJQ97LJcNOCuyFx1z7meuB/Tc
         ZTAtvwCAbhFu7gabkleBjHx4FYW6hVpBHP/OSKhgfazb4SkjJ89AHz7OhElDxYM+mdNx
         749QnvEpuPRvtxsajGlin26m7bMzr/iVtE+LXTgLoKtRGab1JSc8zzNuRrR/miKKNMfF
         RbShnpvjJk4kbtNZbVBGsEsWgV5RnfCwjNlbkpdSqA4FPzWlPVjnJ/XmMC3Cme8I6yBK
         TEQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776955909; x=1777560709; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hNRA6uaMpTQXVK/P2OTZ4gcm9H3zQjkQ6p6Olm+4n1w=;
        b=ODWLMJVFAMDmsHtU0YQL9WVPWeNTimUtW+jmZHFLNn66LGVx3fmJRrave3vzQxdWa5
         +t3weaTw27Qbyk6mfV5LG4+W4hMlLB4+yRIzpx0Cv3Fdk8XjMU3O60eXZ8cP1LN2SxnB
         7RD5OJgrS9D2nq2CPXii0y64MCGD00SbokSJLbqDrss9ktTViln1Dc6VrFeeX252hxBU
         mxpKrqW2jA/wTiITZOmX7zOtCiLXIekOOAlNdTxWkpA1/pjaw/LvDGiN+kzRo7YFghgu
         5pILmjter4Dat9n2gItGMmed2ncNIj92nZq3aO57Bfn1NjCrlyXZIh6NUCaVAzH7EMmj
         N/vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776955909; x=1777560709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hNRA6uaMpTQXVK/P2OTZ4gcm9H3zQjkQ6p6Olm+4n1w=;
        b=mnuH49/IrkKcGcXaf+OcTEKv3E0Pq2s9/Y+cspdFoWxpWFO366xls3Das7bd7BC876
         u/9UKI2lXXLfYihK4dFx9mSbLh0UeZhOFsLpMh3Eb/MOO3IujeltOe2aYnnyPIRyIgD9
         c9muStl5D+ZFjckP0WdDlWTUQ7cI/1MxFptTlb/CXO2ET7+GtyrBaF0KItEvYZlZbABX
         OwJOQ0kJdUl3mCHwdE5SCbAChZ+zhmc/cSHNL/yz33bfmV36NEtfCQapctT3pZ/FmE9E
         W+7ywaQ0L12AVYyvu3HFgAnu0crvk45lLtV+ofxR3TbS7BLsOEtFnDo0lvtqatH4DJ1b
         VrJw==
X-Forwarded-Encrypted: i=1; AFNElJ9zw5fZfE/+s68uvC84o1i0bk0SkZAn75iPJ+qVIELQPFibptJWvxqEzR3bA1gk/P7f5M4pS0ogrkXu@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgtq3oLGI2EqfaBnBO+oCrkGvqSY7QDlNLdTkV2gCzEDEuXkc6
	1k1WIpxjhQnCnafvGd+aF1prtW3dJ0rkcdKqvETA55n2FiVPkP74sD/d+eRuPlvAurjD/W4sVIC
	20SPG6xz4kBCjTLt9sVy/o7zgcGKeY04=
X-Gm-Gg: AeBDiesNz+zmEeyT7QlGR42JYAFUQbUoGrTiE2nEsUjjF4I56ek+guG7xeX0OzR8hh4
	98KpqcaHg/BejWbAvVPJMFnhWX3HLTS3RBPyZQl42qne/63Zf+3bOlh+0Oe91HD5qDj144DXf/N
	clPTKYbrWL9yZuhqXekKjwl0Eunvf41qQscvmx3LSMlJVKXt7jmIsQKh/ROrsvtA2NQvgLk+85w
	9SF9QRnYpGWItjoQEPDV8w/Bd7N1AWneffpFquC2umXJN+gQ+HX4cEQJha/6yYOL4LY4dn73RAM
	fdLWEHFJoNjZMajllA==
X-Received: by 2002:a17:907:c302:b0:b96:e593:fd24 with SMTP id
 a640c23a62f3a-ba419658d6fmr1680530166b.15.1776955908482; Thu, 23 Apr 2026
 07:51:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12879883.O9o76ZdvQC@rafael.j.wysocki> <CAJZ5v0j+WO2yP53nvjshFfEo+ETWiyCo7LohoN2DoORVd_NFbw@mail.gmail.com>
 <CAGAxtY0tgWJ=QQ48=aYTiQd994Z+9e=BAFN1OFTvzP9KE46t8A@mail.gmail.com> <4738258.LvFx2qVVIh@rafael.j.wysocki>
In-Reply-To: <4738258.LvFx2qVVIh@rafael.j.wysocki>
From: Evgeny Sagatov <evgeny.sagatov@gmail.com>
Date: Thu, 23 Apr 2026 17:51:36 +0300
X-Gm-Features: AQROBzA2BZiK1Q9Er7MrjKmDBu_kHDu7iP8s-fNdIhrgHAoUpPhoFZHF0rW7jmQ
Message-ID: <CAGAxtY1eVP5y6GTDoLM2xVDt2KF7fCKxDx0Mo9QO3afTA54GgQ@mail.gmail.com>
Subject: Re: Pressing the power button causes the device to freeze completely
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: regressions@lists.linux.dev, linux-acpi@vger.kernel.org, 
	Thorsten Leemhuis <regressions@leemhuis.info>, LKML <linux-kernel@vger.kernel.org>, 
	Wysocki Rafael J <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I removed the previous patch and installed the new one in kernel 7.0.0.
schedutil - complete freeze, no messages in the log
performance - log message when pressing power button, doesn't reboot
ondemand - log message when pressing power button, doesn't reboot

Log: apr 23 17:40:04 srv kernel: acpi-button LNXPWRBN:00: ACPI button event

=D1=87=D1=82, 23 =D0=B0=D0=BF=D1=80. 2026=E2=80=AF=D0=B3. =D0=B2 16:17, Raf=
ael J. Wysocki <rafael@kernel.org>:
>
> On Wednesday, April 22, 2026 4:48:41 PM CEST Evgeny Sagatov wrote:
> > > There are two cpufreq governors to choose from.  Have you decided to =
compile out the other ones on purpose?
> >
> > Powersave is compiled into the stock Debian kernel as a module, so it
> > does not appear in this list.
> >
> > I changed governor to powersave and pressed the power button. The PC
> > shut down normally.
>
> Interesting.
>
> Can you please also check what happens if you change the cpufreq governor
> to "performance" (on all CPUs) before pressing the power button?
>
> The difference is that with the "performance" governor the CPUs will be
> running at the highest frequency.
>
> > =D1=81=D1=80, 22 =D0=B0=D0=BF=D1=80. 2026=E2=80=AF=D0=B3. =D0=B2 17:04,=
 Rafael J. Wysocki <rafael@kernel.org>:
> > >
> > > On Wed, Apr 22, 2026 at 3:34=E2=80=AFPM Evgeny Sagatov <evgeny.sagato=
v@gmail.com> wrote:
> > > >
> > > > # grep -r . /sys/devices/system/cpu/cpufreq/
> > > > /sys/devices/system/cpu/cpufreq/schedutil/rate_limit_us:240
> > > > /sys/devices/system/cpu/cpufreq/policy2/scaling_min_freq:2000000
> > > > /sys/devices/system/cpu/cpufreq/policy2/scaling_available_governors=
:performance
> > > > schedutil
> > >
> > > There are two cpufreq governors to choose from.  Have you decided to
> > > compile out the other ones on purpose?
> > >
> > > It might be useful to compile the powersave governor in and try to
> > > switch over to it (on all CPUs) before pressing the power button
> > > (without any patches applied).
> > >
> > > > /sys/devices/system/cpu/cpufreq/policy2/freqdomain_cpus:2
> > > > /sys/devices/system/cpu/cpufreq/policy2/scaling_governor:schedutil
> > > > /sys/devices/system/cpu/cpufreq/policy2/cpuinfo_max_freq:2834000
> > > > /sys/devices/system/cpu/cpufreq/policy2/scaling_available_frequenci=
es:2834000
> > > > 2000000
> > >
> > > The frequency scaling on this CPU is quite limited (only 2 states to
> > > choose from).
> > >
> > > > /sys/devices/system/cpu/cpufreq/policy2/related_cpus:2
> > > > /sys/devices/system/cpu/cpufreq/policy2/scaling_cur_freq:2000088
> > >
> > > Interestingly, this number doesn't match the available choices (maybe
> > > due to a rounding error or similar).
> > >
> > > > /sys/devices/system/cpu/cpufreq/policy2/scaling_setspeed:<unsupport=
ed>
> > > > grep: /sys/devices/system/cpu/cpufreq/policy2/stats/reset: Access d=
enied
> > > > /sys/devices/system/cpu/cpufreq/policy2/stats/trans_table:   From  =
:    To
> > > > /sys/devices/system/cpu/cpufreq/policy2/stats/trans_table:         =
:
> > > > 2834000   2000000
> > > > /sys/devices/system/cpu/cpufreq/policy2/stats/trans_table:  2834000=
:
> > > >       0       762
> > > > /sys/devices/system/cpu/cpufreq/policy2/stats/trans_table:  2000000=
:
> > > >     761         0
> > > > /sys/devices/system/cpu/cpufreq/policy2/stats/total_trans:1523
> > > > /sys/devices/system/cpu/cpufreq/policy2/stats/time_in_state:2834000=
 6606
> > > > /sys/devices/system/cpu/cpufreq/policy2/stats/time_in_state:2000000=
 248733
> > > > /sys/devices/system/cpu/cpufreq/policy2/affected_cpus:2
> > > > /sys/devices/system/cpu/cpufreq/policy2/scaling_max_freq:2834000
> > > > /sys/devices/system/cpu/cpufreq/policy2/cpuinfo_transition_latency:=
160000
> > > > /sys/devices/system/cpu/cpufreq/policy2/scaling_driver:acpi-cpufreq
> > > > /sys/devices/system/cpu/cpufreq/policy2/cpuinfo_min_freq:2000000
> > > > /sys/devices/system/cpu/cpufreq/policy2/bios_limit:2834000
> > >
> > > The fact that acpi-cpufreq is the scaling driver may be related to th=
e
> > > power button issue in principle.
> > >
> > > I'm still going to send you another debug patch for the button driver=
 though.
>
> So the patch is appended.  It causes a message to be printed into the ker=
nel
> log every time the power button is pressed if all goes well, but the syst=
em
> will not shut down (it is also not expected to hang).
>
> Please see if that happens with the patch applied (it is a replacement fo=
r the
> previous debug patch).  In principle it should work without changing the
> cpufreq governor.
>
> ---
>  drivers/acpi/button.c |   10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> --- a/drivers/acpi/button.c
> +++ b/drivers/acpi/button.c
> @@ -473,14 +473,12 @@ static void acpi_button_notify(acpi_hand
>                                         event, ++button->pushed);
>  }
>
> -static void acpi_button_notify_run(void *data)
> -{
> -       acpi_button_notify(NULL, ACPI_BUTTON_NOTIFY_STATUS, data);
> -}
> -
>  static u32 acpi_button_event(void *data)
>  {
> -       acpi_os_execute(OSL_NOTIFY_HANDLER, acpi_button_notify_run, data)=
;
> +       struct acpi_button *button =3D data;
> +
> +       dev_info(button->dev, "ACPI button event\n");
> +
>         return ACPI_INTERRUPT_HANDLED;
>  }
>
>
>
>
