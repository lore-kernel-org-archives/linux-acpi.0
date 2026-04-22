Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4433F23E33D
	for <linux-acpi@vger.kernel.org>; Wed, 22 Apr 2026 14:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776869337; cv=pass; b=ETDmpxTRSoxiA/z4eZVFKoBC6gCy4+t1IBxsMSOOpg6UOADXEcyqlMJWJ/+P0i45OO/7EfmTlwbIa03LMzlfW+QkszGL02ZLCByoeM57iLdeco8oFPxd26dIZFBGzGJgmsgixiob/Hx8P7+dpW2cDZUfRRJ1ZsdsQko0PRW8uzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776869337; c=relaxed/simple;
	bh=wn3ok0Jkz5sAH4FeklqQIbZniTuIxmMNTkxtEQVgsic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hBrNEXlis+is0hzS1+PjtPd40QN82tQJWQBGy/dCTYryvFoWCeXcIxXjE82rm0TLa+1lf8D42HF/Pht00YMHNxWVRvp2LDzeHI1r9h/EgXICtq7C5zcEaRqpx5GDb9tCFC/dUUMvqJwSnckwyi/JRJXp4YplTby8Xm9NQO1Eo14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U5V8woiC; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U5V8woiC"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ba67b332bbaso575283266b.0
        for <linux-acpi@vger.kernel.org>; Wed, 22 Apr 2026 07:48:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776869335; cv=none;
        d=google.com; s=arc-20240605;
        b=NZdienU78goah9a5SZG7GRXfMfBROiUEEwWZ0KjvxUZrAcnbhV5Hk1qiY2UxNnYZb5
         yYZohIwLJlh89exq+nxPKgsUCsMzolD86GopHPqJiyPcHdAK3ytl2xBnJcwXNMARqYDE
         MWgQu9DYsGam8r+lGOSusnciaDMvM1vJuM3jnJWmVcSViYDRueHoT/24g+3xTb/rrlbh
         v0xZvx+NwOP9dSXlq9rLK83GEszhrsiPJ3HHs19F8BQybqlxNncwtVr+aziT2P1sqV3z
         r/+Pa6T+gKs+VbhILqRA6OiS7pZ+wQhibD4lPydwfGl+ktmT1Di46EFBMsi4RzlfPECv
         B9Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KZiPIh5LbjptiRP0arjwi4DSydPp0e+RsTQxDhLOBuM=;
        fh=K9C+XX/h1v6gjm8p4hU2PR4tgSA0g3CLDIqlMtH/kTA=;
        b=fOVmMfLgnM9P/bI+FN6jBQ8w3733nRlW+7HAAMMGmV3Djbe87MmyjP/IPAmuulzLMQ
         +OGyrakPZxEJGjsPbH+LP3Udp20tFy+AMhpPptQhkbUh9o0+NndL0ggMNSEFujlrRdDU
         aUylSe+N66s4geP5/i5xOKs+Cp7YKG5QD0lKm5RAj2KBcPHL1nbUwnQZl+mmBq9Mg8AU
         yEgj7XzvPIKlXDN3tVq7VvFK/t6aLSXFncupur9y/fugooiUsS8j9PITr+OH+nJO6Icy
         GcYlGlHLlGDgrzm8bjpykVAwABwunMcB/uEMfdNrkWMksGFefBJx6DlgRkH6PG5TSYmx
         WbNw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776869335; x=1777474135; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KZiPIh5LbjptiRP0arjwi4DSydPp0e+RsTQxDhLOBuM=;
        b=U5V8woiCVvk10ICdXaNeuIQZES+3cT34TZ4G7TephFtbxzPzoSSNf9fCpHUkubANmX
         dm5WrWF7vsPmSt7qwWRje86Z8niXQfXv+0pEQzTwiBcsPtTk0tKflO9eoNSMot3mHKiZ
         lwvYGbMLP5cnmN+LaSrgJLAf+LUtOXtY2MBxx1T7d39GDcZxLgTjE1HfnXz6K5gtHNX2
         xdy5GuBlpnKJlAqF2BjPXbyDfhMIOr4iFX2/9XonV1oUgV7+6nFDLDU5HQ2eiSEIWS0D
         VzpCN+dkxGGpaw8jBjG36eOl4rFLUPvdtth1bZ5zQjR1VKieDqPANaL38KFfJzqykStl
         IzvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776869335; x=1777474135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KZiPIh5LbjptiRP0arjwi4DSydPp0e+RsTQxDhLOBuM=;
        b=SXzlNevRh8+xLym9BfYZbQ/vbzUAxwHtpfnGim7GOGx3tAovwwtMlrH0TV1QodHtJO
         TmPUfYMtDmlLnMwZeSaxzedNZm8AF1dIZZC1Nf8GzKfJy9wHCKKjWD+duiYUfrCNY4yH
         jmgqR5qetiGNpf5pBwWjiMqFeW4ZWE6RxOrEyxOuVTwmKffYzfOJOEsz8JDF58bl36KN
         D10RiKON70RS9cf9R1hS/WNsvmkcjjaN+fd0qjtbQ3X0t6Y6DtPuJ8owmmhMvXkMV+vR
         n/lVmI1ld7th2/qPJqVyEybpO6qhi85xdRej+/csQK10bEg5mlvneuhJtVrX03Dq0jWo
         2Dbw==
X-Forwarded-Encrypted: i=1; AFNElJ8oCRLuK0LTsq1XP+/plXYfCk8soekRS/KepgB1miOf89JJZKuuVjgK6sfTi/LuHG3Ld3m2sLN/sks9@vger.kernel.org
X-Gm-Message-State: AOJu0YzOn2VqtLBoLWNsMz49ie40gV+mFJL9mpbrZThdOAIgxn7cCWPI
	Q4eGlifceAwGnWlavZqQoTJFP6q9U1jhqnzQypjPaGwiq6HdV3qmOSn5Y5vG1LoIZsfwBNivWCJ
	x3RP4XPRHI9vMD/djAZkHt+6bPB+BrFAQP6ERhtw=
X-Gm-Gg: AeBDiesXYZcL16VpdOfPplJ6icb+SPsKuZQ/OqF45ppVFMuaLYFeukGge69h3I2nDSi
	mRDzvMfIOJmLNkOsToLHptgGMP5AtmSxNJU7vaRIjFe50dAWMoHJh/tsKzEcwcQdHoqUw+jeS2H
	oiqvMsrck5qeK/SKGnsxDXoqx1IO4k25pcTCUCWUvt9QhPsyY8k3jPKvH8BjHyKGVMagS6uXEJN
	1jOW8Ugkla0qIOukTKO+rx45NFw14i7GZw4pDX9OzhLznojrZsAooKSzkb6Ao4/IA6h+3nwhd9T
	ZKR2unidVjakvUC/jQ==
X-Received: by 2002:a17:907:96a1:b0:ba7:fbfb:4caf with SMTP id
 a640c23a62f3a-ba7fbfb4d91mr688050566b.43.1776869334367; Wed, 22 Apr 2026
 07:48:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12879883.O9o76ZdvQC@rafael.j.wysocki> <168591776860440@mail.yandex.ru>
 <CAGAxtY1QDN_vkXEzdT8yUC5ZR3W+18TypEcJLR+-=kUkaBOdTw@mail.gmail.com>
 <CAJZ5v0jzPk1Ad-fkKnKZwBWifQ89oPgEhv7A5M5mLtPyMRX+nw@mail.gmail.com>
 <CAGAxtY0g-eo9r5NmSD34bZrPWwfHsfNcXb=XRPuL=65WGmgOmg@mail.gmail.com> <CAJZ5v0j+WO2yP53nvjshFfEo+ETWiyCo7LohoN2DoORVd_NFbw@mail.gmail.com>
In-Reply-To: <CAJZ5v0j+WO2yP53nvjshFfEo+ETWiyCo7LohoN2DoORVd_NFbw@mail.gmail.com>
From: Evgeny Sagatov <evgeny.sagatov@gmail.com>
Date: Wed, 22 Apr 2026 17:48:41 +0300
X-Gm-Features: AQROBzDxrlXx0G1dGhXFpRFfGlujxPsMPFWTBSXxLZ5Jvf1Zt21D9ZANQ7KSIcY
Message-ID: <CAGAxtY0tgWJ=QQ48=aYTiQd994Z+9e=BAFN1OFTvzP9KE46t8A@mail.gmail.com>
Subject: Re: Pressing the power button causes the device to freeze completely
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: regressions@lists.linux.dev, linux-acpi@vger.kernel.org, 
	Thorsten Leemhuis <regressions@leemhuis.info>, LKML <linux-kernel@vger.kernel.org>, 
	Wysocki Rafael J <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> There are two cpufreq governors to choose from.  Have you decided to comp=
ile out the other ones on purpose?

Powersave is compiled into the stock Debian kernel as a module, so it
does not appear in this list.

I changed governor to powersave and pressed the power button. The PC
shut down normally.

=D1=81=D1=80, 22 =D0=B0=D0=BF=D1=80. 2026=E2=80=AF=D0=B3. =D0=B2 17:04, Raf=
ael J. Wysocki <rafael@kernel.org>:
>
> On Wed, Apr 22, 2026 at 3:34=E2=80=AFPM Evgeny Sagatov <evgeny.sagatov@gm=
ail.com> wrote:
> >
> > # grep -r . /sys/devices/system/cpu/cpufreq/
> > /sys/devices/system/cpu/cpufreq/schedutil/rate_limit_us:240
> > /sys/devices/system/cpu/cpufreq/policy2/scaling_min_freq:2000000
> > /sys/devices/system/cpu/cpufreq/policy2/scaling_available_governors:per=
formance
> > schedutil
>
> There are two cpufreq governors to choose from.  Have you decided to
> compile out the other ones on purpose?
>
> It might be useful to compile the powersave governor in and try to
> switch over to it (on all CPUs) before pressing the power button
> (without any patches applied).
>
> > /sys/devices/system/cpu/cpufreq/policy2/freqdomain_cpus:2
> > /sys/devices/system/cpu/cpufreq/policy2/scaling_governor:schedutil
> > /sys/devices/system/cpu/cpufreq/policy2/cpuinfo_max_freq:2834000
> > /sys/devices/system/cpu/cpufreq/policy2/scaling_available_frequencies:2=
834000
> > 2000000
>
> The frequency scaling on this CPU is quite limited (only 2 states to
> choose from).
>
> > /sys/devices/system/cpu/cpufreq/policy2/related_cpus:2
> > /sys/devices/system/cpu/cpufreq/policy2/scaling_cur_freq:2000088
>
> Interestingly, this number doesn't match the available choices (maybe
> due to a rounding error or similar).
>
> > /sys/devices/system/cpu/cpufreq/policy2/scaling_setspeed:<unsupported>
> > grep: /sys/devices/system/cpu/cpufreq/policy2/stats/reset: Access denie=
d
> > /sys/devices/system/cpu/cpufreq/policy2/stats/trans_table:   From  :   =
 To
> > /sys/devices/system/cpu/cpufreq/policy2/stats/trans_table:         :
> > 2834000   2000000
> > /sys/devices/system/cpu/cpufreq/policy2/stats/trans_table:  2834000:
> >       0       762
> > /sys/devices/system/cpu/cpufreq/policy2/stats/trans_table:  2000000:
> >     761         0
> > /sys/devices/system/cpu/cpufreq/policy2/stats/total_trans:1523
> > /sys/devices/system/cpu/cpufreq/policy2/stats/time_in_state:2834000 660=
6
> > /sys/devices/system/cpu/cpufreq/policy2/stats/time_in_state:2000000 248=
733
> > /sys/devices/system/cpu/cpufreq/policy2/affected_cpus:2
> > /sys/devices/system/cpu/cpufreq/policy2/scaling_max_freq:2834000
> > /sys/devices/system/cpu/cpufreq/policy2/cpuinfo_transition_latency:1600=
00
> > /sys/devices/system/cpu/cpufreq/policy2/scaling_driver:acpi-cpufreq
> > /sys/devices/system/cpu/cpufreq/policy2/cpuinfo_min_freq:2000000
> > /sys/devices/system/cpu/cpufreq/policy2/bios_limit:2834000
>
> The fact that acpi-cpufreq is the scaling driver may be related to the
> power button issue in principle.
>
> I'm still going to send you another debug patch for the button driver tho=
ugh.
