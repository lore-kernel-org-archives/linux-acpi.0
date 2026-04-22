Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20FE2DEA98
	for <linux-acpi@vger.kernel.org>; Wed, 22 Apr 2026 14:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776866697; cv=none; b=eSUtHGtJdgQXZ8YGr5Dd9UmyAtLZPnHPasVzwm8hiIEZ/RcAnon6PoyL8XppGdqbgIbDlxUB3BuAvWopCldyNzmAVU3m2QDVOP+mta+Z2DDCyPmrs+hZaXvK4do9Q5XzPmqIjk58/VxZwFP99HIavDAAl3CLJJzrVFEr/uA9OhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776866697; c=relaxed/simple;
	bh=HR5sbDWr3FmNz2JYBR0bAktt5I7s7gqaPwSYJhVsr90=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KQGtt6ra14h6DXx/nFWSNCL5Cw9anHVKgTUz/YTQLvJgWq8ITigbFod3IK21afw6t9AKZpBZEbo9PIuaqEtbOWpRPKKVb9NeV74YD8yO9/SMw0pRLqlCeOmZpBzKFSLKNplRva51Sx6YKGBlBgo/6kM7NGOZcHNR15hjI0mlJyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PpUPrBJZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PpUPrBJZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C1F1C2BCB7
	for <linux-acpi@vger.kernel.org>; Wed, 22 Apr 2026 14:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776866697;
	bh=HR5sbDWr3FmNz2JYBR0bAktt5I7s7gqaPwSYJhVsr90=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PpUPrBJZYzR/mpWTBUH0SfDiqzR15YdUbvvZN6i9YXoC0FGrYDfaKgv7DvGewgmoi
	 nhcQRbrRbPcmSnz3iQaLAPqQEC9bMnN6aDf8XK2K6e2w6iq7ZOUZhzzQ/6cWNZ/rOq
	 3W2voOTPDTbd6ZEwH024mSCIqHylEsoJNwDSXk5jLyFAp5f9S3LqbpaNV92OXrDt4z
	 VlU3vIgwfR5wdJebqLpy/VQJIWlYCu8iBcYf+gJG0zLLC4CZx5PC8210dPE5jAuV1I
	 p3aQHWvvh+ZUjP7R1vssOkJXXr3hd6R2FSlVjPcmkr9opkEg9iPBN30DQwsxmkV371
	 jGQnVw3Lij2fQ==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5a2c3dfb4a1so5739141e87.2
        for <linux-acpi@vger.kernel.org>; Wed, 22 Apr 2026 07:04:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+L3aWCZXiQPC1AqYmF4pVwutO2lgnYBDxEufe9e+9TMyn71vD7HLPW3N+Je6EwgEXE3JadHBjEVFRS@vger.kernel.org
X-Gm-Message-State: AOJu0YyPcp+z6GnZJVvTgI4BBVO0ZWcEkU1y5H3b8wEg+ywBJRO+3/li
	d7sGOpIb9HSnp7aPbd9ZolMdd6J7chs7vFVQciztFZZhHFkEeG5wvfmrbI9/eHSHz9oFf/eNHwL
	8Cmo4NRh0YNl4FX/UOFOmrQwjPjHHT+A=
X-Received: by 2002:a05:6512:31d4:b0:5a2:c404:8383 with SMTP id
 2adb3069b0e04-5a4172ea739mr8516959e87.44.1776866695907; Wed, 22 Apr 2026
 07:04:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12879883.O9o76ZdvQC@rafael.j.wysocki> <168591776860440@mail.yandex.ru>
 <CAGAxtY1QDN_vkXEzdT8yUC5ZR3W+18TypEcJLR+-=kUkaBOdTw@mail.gmail.com>
 <CAJZ5v0jzPk1Ad-fkKnKZwBWifQ89oPgEhv7A5M5mLtPyMRX+nw@mail.gmail.com> <CAGAxtY0g-eo9r5NmSD34bZrPWwfHsfNcXb=XRPuL=65WGmgOmg@mail.gmail.com>
In-Reply-To: <CAGAxtY0g-eo9r5NmSD34bZrPWwfHsfNcXb=XRPuL=65WGmgOmg@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 22 Apr 2026 16:04:43 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j+WO2yP53nvjshFfEo+ETWiyCo7LohoN2DoORVd_NFbw@mail.gmail.com>
X-Gm-Features: AQROBzDioQ0npVI7emEruPtTw51gXKSszk41v1gDHgj-gaRAh5k4lp4IR3x9tpQ
Message-ID: <CAJZ5v0j+WO2yP53nvjshFfEo+ETWiyCo7LohoN2DoORVd_NFbw@mail.gmail.com>
Subject: Re: Pressing the power button causes the device to freeze completely
To: Evgeny Sagatov <evgeny.sagatov@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, regressions@lists.linux.dev, 
	linux-acpi@vger.kernel.org, Thorsten Leemhuis <regressions@leemhuis.info>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Wysocki Rafael J <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2026 at 3:34=E2=80=AFPM Evgeny Sagatov <evgeny.sagatov@gmai=
l.com> wrote:
>
> # grep -r . /sys/devices/system/cpu/cpufreq/
> /sys/devices/system/cpu/cpufreq/schedutil/rate_limit_us:240
> /sys/devices/system/cpu/cpufreq/policy2/scaling_min_freq:2000000
> /sys/devices/system/cpu/cpufreq/policy2/scaling_available_governors:perfo=
rmance
> schedutil

There are two cpufreq governors to choose from.  Have you decided to
compile out the other ones on purpose?

It might be useful to compile the powersave governor in and try to
switch over to it (on all CPUs) before pressing the power button
(without any patches applied).

> /sys/devices/system/cpu/cpufreq/policy2/freqdomain_cpus:2
> /sys/devices/system/cpu/cpufreq/policy2/scaling_governor:schedutil
> /sys/devices/system/cpu/cpufreq/policy2/cpuinfo_max_freq:2834000
> /sys/devices/system/cpu/cpufreq/policy2/scaling_available_frequencies:283=
4000
> 2000000

The frequency scaling on this CPU is quite limited (only 2 states to
choose from).

> /sys/devices/system/cpu/cpufreq/policy2/related_cpus:2
> /sys/devices/system/cpu/cpufreq/policy2/scaling_cur_freq:2000088

Interestingly, this number doesn't match the available choices (maybe
due to a rounding error or similar).

> /sys/devices/system/cpu/cpufreq/policy2/scaling_setspeed:<unsupported>
> grep: /sys/devices/system/cpu/cpufreq/policy2/stats/reset: Access denied
> /sys/devices/system/cpu/cpufreq/policy2/stats/trans_table:   From  :    T=
o
> /sys/devices/system/cpu/cpufreq/policy2/stats/trans_table:         :
> 2834000   2000000
> /sys/devices/system/cpu/cpufreq/policy2/stats/trans_table:  2834000:
>       0       762
> /sys/devices/system/cpu/cpufreq/policy2/stats/trans_table:  2000000:
>     761         0
> /sys/devices/system/cpu/cpufreq/policy2/stats/total_trans:1523
> /sys/devices/system/cpu/cpufreq/policy2/stats/time_in_state:2834000 6606
> /sys/devices/system/cpu/cpufreq/policy2/stats/time_in_state:2000000 24873=
3
> /sys/devices/system/cpu/cpufreq/policy2/affected_cpus:2
> /sys/devices/system/cpu/cpufreq/policy2/scaling_max_freq:2834000
> /sys/devices/system/cpu/cpufreq/policy2/cpuinfo_transition_latency:160000
> /sys/devices/system/cpu/cpufreq/policy2/scaling_driver:acpi-cpufreq
> /sys/devices/system/cpu/cpufreq/policy2/cpuinfo_min_freq:2000000
> /sys/devices/system/cpu/cpufreq/policy2/bios_limit:2834000

The fact that acpi-cpufreq is the scaling driver may be related to the
power button issue in principle.

I'm still going to send you another debug patch for the button driver thoug=
h.
