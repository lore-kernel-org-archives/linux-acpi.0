Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD99233722
	for <linux-acpi@vger.kernel.org>; Wed, 22 Apr 2026 13:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776864869; cv=pass; b=IB3ngrnY3RpsV2mdol8n2Wy6OQmz9mf/TFPzonfJ9gJ3CP47OgFjI5Q/Xw8uTZSJCuWvGmqop7UYjwEXw6QqrnJpLCBU93/3OJFvrfWVxLlj/q9TIaVLT78EWKzj+/rrufN/2kT9D6IN98EYQykDqNUV4Omb/nrqjUnN+dppjE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776864869; c=relaxed/simple;
	bh=QA29cQnK/1JztOScyeUpoHQ8dFYNMTgvcQaoe53VFZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TLwbxj+178goONc4eoJaQlIjXpOmBIaGipUNGguIkkv9mVFZydrHa8M6483+fJ4EPkjgSX+Ey1qpVCbawttV4youSiRiaG5xJ3vxNqr6NC2hAFApfNen0Mk7Topr/HYHh0CfhMOoYFFJEflfZKCVt/GGjjbRp2K0nzNZiSX1hIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HcomVtEk; arc=pass smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HcomVtEk"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b9c603ec2dfso726977066b.1
        for <linux-acpi@vger.kernel.org>; Wed, 22 Apr 2026 06:34:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776864865; cv=none;
        d=google.com; s=arc-20240605;
        b=B5eWhW/Cwr5spjatxP3kqQfFhXxrv4uqlGlWBuZ0vLcLaacRTQ6q76SuEudUosQv4G
         ccwQTSzawdGghDD4c/0O6+cjCHIfrXgClUbIW5uvuBJdSwtkca4gUdzoovt+yj1pFou0
         fVsK5fOf4cYtSSfoHFzOgSjArj6BglMLgmaDe5EFn+QcQB0V80tjPShekk+QxPA6T4pP
         pyVrJ2yz62jnk2yQ3wJbjWeuJIVyw2NVwMiRQnTCuIOvMm6zLqrti8+utgPEVFd51FSB
         2Eo5DbOb7F/Yyvf8iA2oqDUCtCbuVDgb/Ag7v5/Ibj9CkGThLmV4QrKtsVAhrCUmAl8I
         Ck7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NZkd2D73PHtWefZWJw4AGGbqe6ZH3GFkVlr9uMwfb6I=;
        fh=JI37QmuIUkkiz+ApBQ1T89fBURSOqOhByF9iawb+6DA=;
        b=c7VnZysG8hYiWzSI18JWNajIimdBdIxEkpLHirJC18Jk1jUcTYfEqkUQJSJ06qyjaz
         bYCoD4YoxVgOrx4uik9e5Qhb2KftHbvUcN41tO0ww8rbXubYG3VNzaVYFZ8Xn2r0iYq9
         r3oQTXqz9VjGhqdY9iVw0H4vwvQqPhIvLbnJHIrJ/IixYGV/RaCqI6XvKa56XTcRPfWI
         zo8Btq5H27qnqyXqkh6QgT3bwAntJI88HeP6kP9/IM60c9O3HaOkTrmFZdFzQaD6gmke
         NJpb8kruRe4YWnxO1zKkUHBO5S+d0LOnmf4TYlPQ/+8Y+SYx/JBZpwoquHn0z4CLws5U
         j3Yw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776864865; x=1777469665; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZkd2D73PHtWefZWJw4AGGbqe6ZH3GFkVlr9uMwfb6I=;
        b=HcomVtEkYYo/64zjGgy5SUpIjmm2B1kctRjG/zJSAy7x3EjSNP3iRmL+vvOSICOoYY
         gair5Py1Oyf48rwztsFWmXSCMfwvU/W3WpFUcg+GAQu1h622YchKxqlNvF/kU9o8PhoL
         zWjse7n9qnpTDR5MLViyYrAXxfmxIQFjO+WGOrn53ncwMI3nmyE+vGjWayh0vqADdRtP
         D1Rx2sPzDxbra/j3McxEAVIfg6zQuuf/m434hzwh3FYFkNOChNX7HzFgY1TOBzP9U4nK
         j//lrfDENNtnE+8QMA6sw5DCnTCyNw+LoAzcGwkbsur9GEVQiShuFDa2ta/6LU/JgOxv
         eZBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776864865; x=1777469665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NZkd2D73PHtWefZWJw4AGGbqe6ZH3GFkVlr9uMwfb6I=;
        b=ay1oZvvFZruTcykPJkvbfw3VX7Sl68QmXfZi76Qq91eL/fP0wIqr4z1NC5ltaCXcpf
         0LsCQRYfVRfqjKYWZhRwRHksIz0RHlGPfjtAWKCfo8CjH009on2W7t7DKOVVjzE5KYam
         1Vz4yI49yxYv3u2MZenkG/3itnZOSB+OyAZAQEMfyszte2Pfn4G9rhtJjH9NmlDQbEvY
         jMKf1G3zQjo3BbtueB1FK5Rh9i03UN0tn/SqdxZ8TwOVKgcwPSLD9hETC3U18NCZ6Tmy
         Eq8PCWrF1sIJXWD9vtsmhhq+oBBfRgCEfKzfDlxIn8h1QHh2T2T+i6301gRBv21JbNKp
         fZ3g==
X-Forwarded-Encrypted: i=1; AFNElJ8xErHSEH7Ib9StbMDXaJZ/hX0l1zSRZZEmdkMeWMBvW/cZz6WEYsCqL/c7evz8DW7rs3d0ngRP4RlB@vger.kernel.org
X-Gm-Message-State: AOJu0YxZcXQfoeeVqF/ZZrEwjEj9jtSGeV8PaKKhfZwcK1qvweaqZ0rv
	vGVEMlS20iLV2OEy4JhXzt/fTdFGNFNuxtufye47K+T8CeG3hUjmqSlzIRW5F65o6/zoMaH0S5j
	jeNRYuZjOqzahsPP76ruBqPz/+dY48H8=
X-Gm-Gg: AeBDies8SyXRsZ8Aav79APuRZuycx2wOglEru90r6LEwH4f4DRXzWqmSuRh7mmd79Gx
	KxJaupD1inNx0DklWdrHVtTLGTa3xg63MHsZGUR90kERAcaJ9gCU+xiK2CrYpAQ3yZ1Y1aM3UlN
	78j/1LCWgfLWRq+x8xiG4ab+dTnvuRzS4qpmznpPEPXcy5ZNBd+Ms1l9O38/FaZI/Uw2YsXxsWa
	Uj2tCKhS5MtKoWfAPh8F4q/+uEbCv2NxwGg5J9E8NBxQ9wFR+e1yYdMijM4OmQVfkdG6IAq+hvo
	72hoLwAITsaW2EhkKUfrIa88JtEz
X-Received: by 2002:a17:907:8e0e:b0:b9d:1a1c:a664 with SMTP id
 a640c23a62f3a-ba41a91e25bmr1130030066b.40.1776864864806; Wed, 22 Apr 2026
 06:34:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12879883.O9o76ZdvQC@rafael.j.wysocki> <168591776860440@mail.yandex.ru>
 <CAGAxtY1QDN_vkXEzdT8yUC5ZR3W+18TypEcJLR+-=kUkaBOdTw@mail.gmail.com> <CAJZ5v0jzPk1Ad-fkKnKZwBWifQ89oPgEhv7A5M5mLtPyMRX+nw@mail.gmail.com>
In-Reply-To: <CAJZ5v0jzPk1Ad-fkKnKZwBWifQ89oPgEhv7A5M5mLtPyMRX+nw@mail.gmail.com>
From: Evgeny Sagatov <evgeny.sagatov@gmail.com>
Date: Wed, 22 Apr 2026 16:34:11 +0300
X-Gm-Features: AQROBzDJ8YY-nCoKKhheG8PdTwAWdP6pC1HZ7XbvttrXJ7xE97z0nMFUDTMDkfA
Message-ID: <CAGAxtY0g-eo9r5NmSD34bZrPWwfHsfNcXb=XRPuL=65WGmgOmg@mail.gmail.com>
Subject: Re: Pressing the power button causes the device to freeze completely
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: regressions@lists.linux.dev, linux-acpi@vger.kernel.org, 
	Thorsten Leemhuis <regressions@leemhuis.info>, LKML <linux-kernel@vger.kernel.org>, 
	Wysocki Rafael J <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

# grep -r . /sys/devices/system/cpu/cpufreq/
/sys/devices/system/cpu/cpufreq/schedutil/rate_limit_us:240
/sys/devices/system/cpu/cpufreq/policy2/scaling_min_freq:2000000
/sys/devices/system/cpu/cpufreq/policy2/scaling_available_governors:perform=
ance
schedutil
/sys/devices/system/cpu/cpufreq/policy2/freqdomain_cpus:2
/sys/devices/system/cpu/cpufreq/policy2/scaling_governor:schedutil
/sys/devices/system/cpu/cpufreq/policy2/cpuinfo_max_freq:2834000
/sys/devices/system/cpu/cpufreq/policy2/scaling_available_frequencies:28340=
00
2000000
/sys/devices/system/cpu/cpufreq/policy2/related_cpus:2
/sys/devices/system/cpu/cpufreq/policy2/scaling_cur_freq:2000088
/sys/devices/system/cpu/cpufreq/policy2/scaling_setspeed:<unsupported>
grep: /sys/devices/system/cpu/cpufreq/policy2/stats/reset: Access denied
/sys/devices/system/cpu/cpufreq/policy2/stats/trans_table:   From  :    To
/sys/devices/system/cpu/cpufreq/policy2/stats/trans_table:         :
2834000   2000000
/sys/devices/system/cpu/cpufreq/policy2/stats/trans_table:  2834000:
      0       762
/sys/devices/system/cpu/cpufreq/policy2/stats/trans_table:  2000000:
    761         0
/sys/devices/system/cpu/cpufreq/policy2/stats/total_trans:1523
/sys/devices/system/cpu/cpufreq/policy2/stats/time_in_state:2834000 6606
/sys/devices/system/cpu/cpufreq/policy2/stats/time_in_state:2000000 248733
/sys/devices/system/cpu/cpufreq/policy2/affected_cpus:2
/sys/devices/system/cpu/cpufreq/policy2/scaling_max_freq:2834000
/sys/devices/system/cpu/cpufreq/policy2/cpuinfo_transition_latency:160000
/sys/devices/system/cpu/cpufreq/policy2/scaling_driver:acpi-cpufreq
/sys/devices/system/cpu/cpufreq/policy2/cpuinfo_min_freq:2000000
/sys/devices/system/cpu/cpufreq/policy2/bios_limit:2834000
/sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq:2000000
/sys/devices/system/cpu/cpufreq/policy0/scaling_available_governors:perform=
ance
schedutil
/sys/devices/system/cpu/cpufreq/policy0/freqdomain_cpus:0
/sys/devices/system/cpu/cpufreq/policy0/scaling_governor:schedutil
/sys/devices/system/cpu/cpufreq/policy0/cpuinfo_max_freq:2834000
/sys/devices/system/cpu/cpufreq/policy0/scaling_available_frequencies:28340=
00
2000000
/sys/devices/system/cpu/cpufreq/policy0/related_cpus:0
/sys/devices/system/cpu/cpufreq/policy0/scaling_cur_freq:2000000
/sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed:<unsupported>
grep: /sys/devices/system/cpu/cpufreq/policy0/stats/reset: Access denied
/sys/devices/system/cpu/cpufreq/policy0/stats/trans_table:   From  :    To
/sys/devices/system/cpu/cpufreq/policy0/stats/trans_table:         :
2834000   2000000
/sys/devices/system/cpu/cpufreq/policy0/stats/trans_table:  2834000:
      0       850
/sys/devices/system/cpu/cpufreq/policy0/stats/trans_table:  2000000:
    849         0
/sys/devices/system/cpu/cpufreq/policy0/stats/total_trans:1699
/sys/devices/system/cpu/cpufreq/policy0/stats/time_in_state:2834000 6684
/sys/devices/system/cpu/cpufreq/policy0/stats/time_in_state:2000000 248654
/sys/devices/system/cpu/cpufreq/policy0/affected_cpus:0
/sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq:2834000
/sys/devices/system/cpu/cpufreq/policy0/cpuinfo_transition_latency:160000
/sys/devices/system/cpu/cpufreq/policy0/scaling_driver:acpi-cpufreq
/sys/devices/system/cpu/cpufreq/policy0/cpuinfo_min_freq:2000000
/sys/devices/system/cpu/cpufreq/policy0/bios_limit:2834000
/sys/devices/system/cpu/cpufreq/policy3/scaling_min_freq:2000000
/sys/devices/system/cpu/cpufreq/policy3/scaling_available_governors:perform=
ance
schedutil
/sys/devices/system/cpu/cpufreq/policy3/freqdomain_cpus:3
/sys/devices/system/cpu/cpufreq/policy3/scaling_governor:schedutil
/sys/devices/system/cpu/cpufreq/policy3/cpuinfo_max_freq:2834000
/sys/devices/system/cpu/cpufreq/policy3/scaling_available_frequencies:28340=
00
2000000
/sys/devices/system/cpu/cpufreq/policy3/related_cpus:3
/sys/devices/system/cpu/cpufreq/policy3/scaling_cur_freq:1999770
/sys/devices/system/cpu/cpufreq/policy3/scaling_setspeed:<unsupported>
grep: /sys/devices/system/cpu/cpufreq/policy3/stats/reset: Access denied
/sys/devices/system/cpu/cpufreq/policy3/stats/trans_table:   From  :    To
/sys/devices/system/cpu/cpufreq/policy3/stats/trans_table:         :
2834000   2000000
/sys/devices/system/cpu/cpufreq/policy3/stats/trans_table:  2834000:
      0       623
/sys/devices/system/cpu/cpufreq/policy3/stats/trans_table:  2000000:
    622         0
/sys/devices/system/cpu/cpufreq/policy3/stats/total_trans:1245
/sys/devices/system/cpu/cpufreq/policy3/stats/time_in_state:2834000 6697
/sys/devices/system/cpu/cpufreq/policy3/stats/time_in_state:2000000 248642
/sys/devices/system/cpu/cpufreq/policy3/affected_cpus:3
/sys/devices/system/cpu/cpufreq/policy3/scaling_max_freq:2834000
/sys/devices/system/cpu/cpufreq/policy3/cpuinfo_transition_latency:160000
/sys/devices/system/cpu/cpufreq/policy3/scaling_driver:acpi-cpufreq
/sys/devices/system/cpu/cpufreq/policy3/cpuinfo_min_freq:2000000
/sys/devices/system/cpu/cpufreq/policy3/bios_limit:2834000
/sys/devices/system/cpu/cpufreq/policy1/scaling_min_freq:2000000
/sys/devices/system/cpu/cpufreq/policy1/scaling_available_governors:perform=
ance
schedutil
/sys/devices/system/cpu/cpufreq/policy1/freqdomain_cpus:1
/sys/devices/system/cpu/cpufreq/policy1/scaling_governor:schedutil
/sys/devices/system/cpu/cpufreq/policy1/cpuinfo_max_freq:2834000
/sys/devices/system/cpu/cpufreq/policy1/scaling_available_frequencies:28340=
00
2000000
/sys/devices/system/cpu/cpufreq/policy1/related_cpus:1
/sys/devices/system/cpu/cpufreq/policy1/scaling_cur_freq:1999773
/sys/devices/system/cpu/cpufreq/policy1/scaling_setspeed:<unsupported>
grep: /sys/devices/system/cpu/cpufreq/policy1/stats/reset: Access denied
/sys/devices/system/cpu/cpufreq/policy1/stats/trans_table:   From  :    To
/sys/devices/system/cpu/cpufreq/policy1/stats/trans_table:         :
2834000   2000000
/sys/devices/system/cpu/cpufreq/policy1/stats/trans_table:  2834000:
      0       882
/sys/devices/system/cpu/cpufreq/policy1/stats/trans_table:  2000000:
    881         0
/sys/devices/system/cpu/cpufreq/policy1/stats/total_trans:1763
/sys/devices/system/cpu/cpufreq/policy1/stats/time_in_state:2834000 5501
/sys/devices/system/cpu/cpufreq/policy1/stats/time_in_state:2000000 249838
/sys/devices/system/cpu/cpufreq/policy1/affected_cpus:1
/sys/devices/system/cpu/cpufreq/policy1/scaling_max_freq:2834000
/sys/devices/system/cpu/cpufreq/policy1/cpuinfo_transition_latency:160000
/sys/devices/system/cpu/cpufreq/policy1/scaling_driver:acpi-cpufreq
/sys/devices/system/cpu/cpufreq/policy1/cpuinfo_min_freq:2000000
/sys/devices/system/cpu/cpufreq/policy1/bios_limit:2834000

=D1=81=D1=80, 22 =D0=B0=D0=BF=D1=80. 2026=E2=80=AF=D0=B3. =D0=B2 16:27, Raf=
ael J. Wysocki <rafael@kernel.org>:
>
> Hi,
>
> On Wed, Apr 22, 2026 at 2:36=E2=80=AFPM Evgeny Sagatov <evgeny.sagatov@gm=
ail.com> wrote:
> >
> > Hello Rafael,
> >
> > I applied the patch that you sent.
> > The PC isn't responding to the power button press. It doesn't freeze.
>
> As expected, thanks!  I'll send you another patch to test (instead of
> the one you have tested) in the next message.
>
> > I just want to clarify, did you receive messages where we found the
> > first broken commit using git bisect?
> >
> > > 8c94ccc7cd691472461448f98e2372c75849406c    good
> > > e37617c8e53a1f7fcba6d5e1041f4fd8a2425c27    good
> > > b0d326da462e20285236e11e4cbc32085de9f363    bad
>
> Yes, I did, but I think that reverting the schedutil change hides the pro=
blem.
>
> BTW, since reverting the schedutil change makes a difference for you,
> I'm wondering about the cpufreq configuration on your system.  Can you
> please send me the
>
> $ grep -r . /sys/devices/system/cpu/cpufreq/
>
> output from your system?
>
>
> > > On Tuesday, April 21, 2026 5:11:36 PM CEST Wysocki, Rafael J wrote:
> > >
> > >  Hi,
> > >
> > >  On 4/13/2026 6:46 PM, Evgeny Sagatov wrote:
> > >  > Hello,
> > >  > I have a PC with a motherboard GA-EP45T-UD3LR (Rev. 1.0)
> > >  > <https://www.gigabyte.com/Motherboard/GA-EP45T-UD3LR-rev-10> and
> > >  > processor Intel Core 2 Quad Q9550.
> > >  > Previously, I had Debian 12 with kernel 6.1 installed, and pressin=
g
> > >  > the power button would shut down the PC as usual.
> > >  > I updated to Debian 13 with kernel 6.12.74, and now pressing the p=
ower
> > >  > button causes the PC to freeze completely.
> > >  > I see that systemd doesn't even begin to shut down. It freezes
> > >  > immediately after pressing the button. There's no error message in
> > >  > console. There's no error message in the logs either. Netconsole
> > >  > doesn't report any errors, and the kernel doesn't panic. It just
> > >  > freezes completely.
> > >
> > >  It looks like the ACPI button notify handler crashes on your system =
for
> > >  some obscure reason.
> > >
> > >  It should be possible to get to the bottom of it, but it will requir=
e
> > >  some investigation if you have the motivation and time to run debug =
patches.
> > >
> > >
> > >  > I checked that Live CD with Debian 12 continue to shut down normal=
ly,
> > >  > but Live CD with Debian 13 freeze.
> > >  > I tried updating and resetting the BIOS. I tried various kernel
> > >  > parameters related to ACPI settings. I also tried kernels 6.18 and
> > >  > 6.19. Nothing fixed the problem.
> > >  > If I unload the "button" module, the system doesn't freeze, but it
> > >  > also doesn't shut down.
> > >
> > >  This is a useful data point, thanks!
> > >
> > >
> > >  > I built "button" module by rolling back its version to commit 1a20=
d40
> > >  > <https://github.com/torvalds/linux/commit/1a20d409c874255086e2f42a=
729826d490294c91>,
> > >  > which corresponds to kernel version 6.1. This module does not free=
ze,
> > >  > but does not turn off the PC either.
> > >  > I've found that the freezes have been occurring since commit 0d511=
57
> > >  > <https://github.com/torvalds/linux/commit/0d51157dfaac05ea66616d8a=
250dce04bef49a4f>.
> > >
> > >  The main difference made by it is the fixed events handling and if t=
here
> > >  is a problem with that, a few debug patches should suffice to find o=
ut
> > >  what's going on. I'll send you one to try shortly.
> > >
> > >
> > > First off, on top of 7.0.0 (since the issue is present in this one, I=
 think
> > > it's better to focus the debugging on it), let's first check what hap=
pens if
> > > the ACPI fixed event handler is not installed for the power button at=
 all.
> > >
> > > This should be similar to using a 6.1 version of the button driver (t=
hat is,
> > > no crash, but pressing the power button will have no effect).
> > >
> > > Please test the patch below and let me know what happens.
> > >
> > > ---
> > >  drivers/acpi/button.c | 4 +---
> > >  1 file changed, 1 insertion(+), 3 deletions(-)
> > >
> > > --- a/drivers/acpi/button.c
> > > +++ b/drivers/acpi/button.c
> > > @@ -628,9 +628,7 @@ static int acpi_button_probe(struct plat
> > >
> > >          switch (device->device_type) {
> > >          case ACPI_BUS_TYPE_POWER_BUTTON:
> > > - status =3D acpi_install_fixed_event_handler(ACPI_EVENT_POWER_BUTTON=
,
> > > - acpi_button_event,
> > > - button);
> > > + status =3D AE_OK;
> > >                  break;
> > >          case ACPI_BUS_TYPE_SLEEP_BUTTON:
> > >                  status =3D acpi_install_fixed_event_handler(ACPI_EVE=
NT_SLEEP_BUTTON,
