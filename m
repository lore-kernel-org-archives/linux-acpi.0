Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1021946AEF5
	for <linux-acpi@vger.kernel.org>; Thu, 30 Apr 2026 16:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777565059; cv=pass; b=O4KUCSvXPGS8mohLakB3Ewbv+c+PdnvQVBShoN4naLJQ8dbkl8KU+ULcQSHuTb2PFDXzT80389+7TN3S4ifMXKgSko+sDgu1S0EP/7NC6mPhpp2yCQCfvqVALq77ZY4Kzej9j/Ir2MwyZYL5C5UjYnYKI2Em6Isg0XcHB89+qMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777565059; c=relaxed/simple;
	bh=Ef49oYT6p94yZhjmT5kOtDJ3He8IHhFy3xHgSEFlhfE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FpI+kovYWXk6QAj79hofcL32QvFITPtySHDUkAx2PtFEdjFtubFi3vTlu65ZB0iUGjV8zFWQ3t8uFlcIsidAvrFy3hfoLngCI49URtvq5BFI8Nz9mQ+pgcn1u7hq+8vrOaFNVGrsVx/vWIWVwdMoaIlhQarO0SNxl3h1S49XpL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lhze9BHM; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lhze9BHM"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-bb3c4d8cc29so174044966b.1
        for <linux-acpi@vger.kernel.org>; Thu, 30 Apr 2026 09:04:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777565056; cv=none;
        d=google.com; s=arc-20240605;
        b=ilzqoZY927I5PONMk8uCvpL7GsDVr6W2RMB7Eg+8SUyq/dIYEGboM0slPOgXoP18ff
         PD5RwQFXZc/NHCCWX0x4W0ylFA+BJfdz/5AXnDU2zqr4TNCteov5qiuJokTbLfxQYVFB
         ueu+42atOUai8oeNeLxSCTntzQJdyVaJf5nYyRpIJkTTW4ERaUc6QYJDDSVMbldJxt/H
         nFfesvFpcW0yfRfTzcOqkzMdQdTim8kIl+EJGr5867cnhNCLrOAnlZN4uKgbQktJGKPd
         9yormqNgVadv1gKQxxidod5NoHtO08RrmLdmF4ueX4rynd1ZA4/PZKeAhVPtZz8zj158
         wh8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=y9SQf5HaVb2gJQwnS3/lQbxFEkfxVfifFwEXsxY/FTg=;
        fh=FyFR1CYEVP2ZlJ8ilMU69V8b0yUtaVspGzEEWKc7WH0=;
        b=EsM6yKqhbT1qIQHvGgfASuCcPPUB7hGxqqwacUQPCxG631vgU71CStvJqFQDz82g2E
         JqnEMhwEjXyxrWoLFOW8RQ+hDvJL9/1nAtFyPNyBnj5WBkrK2Hvr3JpKaXWCgnK40lFu
         qiomhKFcBoZLPMcYbSeLNBFz/qkhgC3F7s9pkVxqHr+ga1Tv7w1UMWZtTnK4+aIef1Gp
         P+OvFvNMAr8cvdL83bHCXUPxtaPvPSzojb54JS2/oKICAxrerYTEdx1vD/Z84qf9LXPe
         T5sRaGAC+PR7YoMA2YnEslYONA9fXXRhzMYxS/qLB1J/K1rMiy+f07tHMcpJXCiC8+Xy
         pboA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777565056; x=1778169856; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y9SQf5HaVb2gJQwnS3/lQbxFEkfxVfifFwEXsxY/FTg=;
        b=lhze9BHM4va6t/JKBjz4mULz7dXkT+/roF+3vDCPU9uF5btBO93ftpeVxPv9V+sDbP
         F+CeitjKF3z4Gm6ACeVDswYcBZNbejJMm0MWLO+JvBL/IArO7hHzLMz5ZiYfnMjch4ln
         9IaOx1gCeW49qrn7xm9AEJKPrlC4ojDdoJUdb1iVeXFY/fQfX0cx0bBv21jOQBihfqSV
         S2PaejWHo/8qBJsDjcnRURlfTHRKcFzGQFRWRYHnOIxr8SMHq6v3/KXBfbAF7U4KKsZW
         76x4dW3Xby9jl2Eb8M2yDI9o7Ld0WEPgRXnohA0QCNvuR/zOrvMt8WIEqN20SW3sz6qb
         VFrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777565056; x=1778169856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y9SQf5HaVb2gJQwnS3/lQbxFEkfxVfifFwEXsxY/FTg=;
        b=cdCyiiBSZVompH/RZbXco/T6P+I98ir35wba5pG2OaWieeC7n03HKGH0gXFzQfFE3D
         G738U1QHPMIXYaR/tGCW2gEjixos3xL1EOT7uoLfJVVJ1rf0Q78s5jmXPUvTTEYSU5Tw
         ZwSUZPOJp0R4PReXAzR65GkCu0WCho3fxO9YkXeufkGK1FzlL7oQ0dGzHyaZDC1IrDOP
         RPyhh7ozWKDEntVPyU+meXBZsYcnr6dm1qDF8XK2QHU4Lr60fG36kzE9az1G+189B5fY
         A0COMF5yx2rxP/WIaI3jJBa32jQg8diFX2h7aAmYz2Py6zZHBGV07uh9iZHDHXN9JKBa
         zSHA==
X-Forwarded-Encrypted: i=1; AFNElJ+7lli5tGaN2dSUlA+ijSamYmZIzbdU1U/NmJDlKTAL9TTUqRrUGMoiTv+gy1IVlNRto3A3Jqw4wL9z@vger.kernel.org
X-Gm-Message-State: AOJu0YxrILoKqicETziSTWjV9j8CPxBWlf+PwdZHpsXVVCUl+YUWpZee
	fOnTwdrzaKHaKbNEel2mKXOQv3lCY7QykH4KL2JpLAa+1iMXiLFMUo6piRHhv4lRtfoIatYVCFn
	ONxGFt0EaNTCQrt00EqJVZezoS0OnbW0=
X-Gm-Gg: AeBDiesrwsBuN43gLkEuyAxyJwv9KC6TkS+NEiGKGsASKabk6uFUlof6MQMbigoWZrE
	8keOvFfIldVgPRRahyJCjR+mpB1TrkrJ1hDNTp2LSK09h7U5FDm+LrELqj2rDuei8kblAsxCaCY
	wX/daqKorIt4USpWwNQP+yrs7Wwv3qLvupQhMBUVf+/4NBpftcZPpDLT+BglnxxDgdXhNwtJz/o
	RdPSchOWD8uR/aCO9hjgcY7TPE6PPrlON0Ex+ju4MNOMwwBJNVaX47KpNw0kYVI1bQZ1a5HSuOF
	olDaFtRTns8s+gRpKg==
X-Received: by 2002:a17:907:6d0c:b0:bba:87c4:2a8c with SMTP id
 a640c23a62f3a-bbb68d0e7ccmr214367666b.4.1777565056166; Thu, 30 Apr 2026
 09:04:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12879883.O9o76ZdvQC@rafael.j.wysocki> <CAGAxtY2SEkx7OgMgM5ypA8qsBN0h6pcs111VjnhD-5ZGq7Je6Q@mail.gmail.com>
 <CAJZ5v0ikAeu7cW9K6sfKYbbsVK51GOsFrX-qv3KJ7cVr-gRHew@mail.gmail.com>
 <6010375.DvuYhMxLoT@rafael.j.wysocki> <CAGAxtY2N-=3taOBCTFZzEmm4NqJ-KhtsWq0fNts_tn3nAxpkTA@mail.gmail.com>
 <CAJZ5v0j2MKGRFRRVT4rFuzr2OwJg7ufAfDKUS0rgAsg-EBH6Kg@mail.gmail.com>
 <CAJZ5v0jhjXap6gSZ5unR7cE+CQQPk1tDnAXLm9rkGsC2AnZTew@mail.gmail.com>
 <CAGAxtY3h4sEphqKL-jiSn4p0NT9mdZtOFrVxW7CDo22XdL56iw@mail.gmail.com>
 <CAGAxtY39Te1zwK11KmuELHGV3MJMRYfTju+oXuzKeEZqVGKQzg@mail.gmail.com> <CAJZ5v0jF1YNyo4uYTK+JPK2QFhC-k=dazgoq4XCAYVri9Km99A@mail.gmail.com>
In-Reply-To: <CAJZ5v0jF1YNyo4uYTK+JPK2QFhC-k=dazgoq4XCAYVri9Km99A@mail.gmail.com>
From: Evgeny Sagatov <evgeny.sagatov@gmail.com>
Date: Thu, 30 Apr 2026 19:04:04 +0300
X-Gm-Features: AVHnY4LYFq_5yQK-qoCOKzisAXSWoguvo_eBUYRzmRmEVKO3fMayERUTrTMbmVw
Message-ID: <CAGAxtY0qGr4ULh+dV6f6JnYoFinMhJM6B2SLAEGAL+5Z-K6pMQ@mail.gmail.com>
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

> I guess you mean with the powersave governor.

That's the thing, I get these weird values in powersave mode.

> I would expect schedutil, ondemand and performance to give similar
> scores, but for powersave I would expect the score to be lower.

I did some measurements earlier. I got roughly the same values in
schedutil and performance modes. In ondemand mode, it was 7% lower. In
powersave mode, it was significantly lower, but I don't remember the
exact values.
Now, the values are at their maximum in all modes.

I see that the frequencies change frequently.

cat /proc/cpuinfo | grep MHz
cpu MHz         : 2000.000
cpu MHz         : 2000.000
cpu MHz         : 2673.037
cpu MHz         : 2601.029

But I don't see this reflected in the statistics.

grep -r . /sys/devices/system/cpu/cpufreq/
/sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq:2000000
/sys/devices/system/cpu/cpufreq/policy0/scaling_available_governors:powersa=
ve
performance schedutil
/sys/devices/system/cpu/cpufreq/policy0/freqdomain_cpus:0 1 2 3
/sys/devices/system/cpu/cpufreq/policy0/scaling_governor:powersave
/sys/devices/system/cpu/cpufreq/policy0/cpuinfo_max_freq:2834000
/sys/devices/system/cpu/cpufreq/policy0/scaling_available_frequencies:28340=
00
2000000
/sys/devices/system/cpu/cpufreq/policy0/related_cpus:0 1 2 3
/sys/devices/system/cpu/cpufreq/policy0/scaling_cur_freq:2000000
/sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed:<unsupported>
grep: /sys/devices/system/cpu/cpufreq/policy0/stats/reset: Access denied
/sys/devices/system/cpu/cpufreq/policy0/stats/trans_table:   From  :    To
/sys/devices/system/cpu/cpufreq/policy0/stats/trans_table:         :
2834000   2000000
/sys/devices/system/cpu/cpufreq/policy0/stats/trans_table:  2834000:
      0         0
/sys/devices/system/cpu/cpufreq/policy0/stats/trans_table:  2000000:
      0         0
/sys/devices/system/cpu/cpufreq/policy0/stats/total_trans:0
/sys/devices/system/cpu/cpufreq/policy0/stats/time_in_state:2834000 0
/sys/devices/system/cpu/cpufreq/policy0/stats/time_in_state:2000000 8222
/sys/devices/system/cpu/cpufreq/policy0/affected_cpus:0 1 2 3
/sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq:2834000
/sys/devices/system/cpu/cpufreq/policy0/cpuinfo_transition_latency:160000
/sys/devices/system/cpu/cpufreq/policy0/scaling_driver:acpi-cpufreq
/sys/devices/system/cpu/cpufreq/policy0/cpuinfo_min_freq:2000000
/sys/devices/system/cpu/cpufreq/policy0/cpuinfo_avg_freq:2000000
/sys/devices/system/cpu/cpufreq/policy0/bios_limit:2834000

grep . /sys/firmware/acpi/interrupts/sci*
/sys/firmware/acpi/interrupts/sci:       0
/sys/firmware/acpi/interrupts/sci_not:       0


I tried this with the previous patch, and the kernel didn't freeze
when I pressed the button.
But with kernel 6.12.74, it doesn't work.
echo 100000 > /sys/devices/system/cpu/cpufreq/schedutil/rate_limit_us

=D1=87=D1=82, 30 =D0=B0=D0=BF=D1=80. 2026=E2=80=AF=D0=B3. =D0=B2 17:10, Raf=
ael J. Wysocki <rafael@kernel.org>:
>
> On Thu, Apr 30, 2026 at 1:58=E2=80=AFPM Evgeny Sagatov <evgeny.sagatov@gm=
ail.com> wrote:
> >
> > I forgot to say that in ondemand mode, when I pressed the power
> > button, the PC did not freeze.
>
> OK
>
> I think that's because ondemand changes the CPU frequency 10 times
> less frequently than schedutil.
>
> Writing a sufficiently large number to
>
> /sys/devices/system/cpu/cpufreq/schedutil/rate_limit_us
>
> when schedutil is the cpufreq governor may help, but I actually don't
> know how large that number would need to be.
