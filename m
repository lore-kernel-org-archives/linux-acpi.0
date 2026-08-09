Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6413B368974
	for <linux-acpi@vger.kernel.org>; Sun,  9 Aug 2026 22:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786313841; cv=none; b=rHn/t9xqrUfNRdlE4EUA4VPvlS1bPc6OSRy3wrgN/iAmwmTYGYe10v29u0981mUU7ORoUo4BVaSG9+h7x2zJcKM91S2G3LxLmPA5MJGWUOZ4JGkH3zPfDIq+NrMJdpg2XGj/NDRTApJevN/r8Xh9zlZWnoQot7g4Qvw+bpDT3B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786313841; c=relaxed/simple;
	bh=nhdqEbSz8qSG7osSBFFJiYNmPxdqJgnHGqPOYaeaDVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m7f58GHqHFv3/kS2drgdRuoKcdzYgCCt3kcISmf7ucNGbLbKDEZmkAKajYVUFBfRjg/QT96QjrkM3r+M/REtpoWaBo4LBcexPJ4B3b9NwEEXjmICEpfYAWJP2NlIDMNdhIdh/+rTXVlisKVGhvHkVFD4iXCGISKU1EAh6FN1TsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nONNCQXo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nONNCQXo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3976C1F000E9
	for <linux-acpi@vger.kernel.org>; Sun,  9 Aug 2026 22:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786313840;
	bh=nhdqEbSz8qSG7osSBFFJiYNmPxdqJgnHGqPOYaeaDVw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=nONNCQXouVsHIKRK2hYsLMITmuoZ6KEDTBlkONLf7Ufrr47x2CrM+peC5rgyzliJm
	 SS84wLwSLK7f262JDgYuNpgOMRrzcsffeF+LiNwVcbqgBMrqPC/JxVqRB2aKGoQpEy
	 TbGT9yyG9Q62ybHRkuE34bRIEbzR0gRqSYDjljgRE2d++ma2jBZIv86L3MN+UWy5HK
	 cA3dw+qch065Z3xWPrDVPUNQQEbw4OZ8oVrGbFv7fy7oWEmwMHSbh4+9KPNUnf6cwi
	 rJ0AY5dFvx2QaZYRt/lBpH9Riu8b258iGovP9Nkn5S8w+7xautUS4jf+IEBOSOQomF
	 ap52fGwbbHabQ==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-39c74722e27so14084821fa.0
        for <linux-acpi@vger.kernel.org>; Sun, 09 Aug 2026 15:17:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Ropvw8Jeb7l5iwlHJckcvMCViqNKG1+JxEbGa5xB6Q6+9WU8Uj5a5aomi2OqreKLxmERZmwpjxYbiXw@vger.kernel.org
X-Gm-Message-State: AOJu0YwDDQ2GPZzkGVA83MeXAZCk+Rp3K87VFixGxHtypsgubnOkkdXq
	i6FgyUaPH1QlDvKiRlivrKORDjriQRTcHKcAXhtAIm3UURau2MEk48CQISgE1FRwZAcySYtrfZO
	KJsLnhUuvIovXafFzz0TAeYQ0zCGzKgY=
X-Received: by 2002:a2e:be0a:0:b0:39c:a24b:f0b8 with SMTP id
 38308e7fff4ca-39fe830f6e4mr19632901fa.2.1786313839066; Sun, 09 Aug 2026
 15:17:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260808155513.2221976-1-xnorigc@gmail.com> <aneGptJn8J7eF9tj@ashevche-desk.local>
In-Reply-To: <aneGptJn8J7eF9tj@ashevche-desk.local>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 10 Aug 2026 00:17:06 +0200
X-Gmail-Original-Message-ID: <CAD++jLkCYwTyK6C8LvZiYJ9fSc8bp3RPpb4d6EgQTRraJtJDzA@mail.gmail.com>
X-Gm-Features: AUfX_mwdclHsp2TUQj2kqqtrFMTvL6R8j3-WzVqxIY599QYIJ4ZBXCxS7imuOfs
Message-ID: <CAD++jLkCYwTyK6C8LvZiYJ9fSc8bp3RPpb4d6EgQTRraJtJDzA@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: acpi: Add ignore_wake quirk for ASUS TX Air FA401GM
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Yao Qi <xnorigc@gmail.com>, westeri@kernel.org, brgl@kernel.org, 
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 8, 2026 at 9:42=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Sat, Aug 08, 2026 at 03:55:13PM +0000, Yao Qi wrote:

> > The ASUS TX Air FA401GM experiences immediate wakeups from s2idle
> > (Modern Standby) when suspended with an external HDMI display connected=
.
> >
> > This issue is caused by spurious ACPI event signaling routed through
> > GPIO 24 on the AMD GPIO controller (AMDI0030:00), which triggers a
> > system-wide IRQ 7 (pinctrl_amd) wake-up interrupt during sleep.
> >
> > Add an ignore_wake quirk for GPIO 24 on this machine to prevent these
> > unwanted wakeups. This has been runtime-tested and verified using the
> > `gpiolib_acpi.ignore_wake=3DAMDI0030:00@24` kernel parameter.
>
> If AMD people will be quick enough to tag this, I will include in my PR t=
o
> Linus W. on next week.

To Bartosz?

It's gpiolib...

Yours,
Linus Walleij
