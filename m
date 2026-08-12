Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACD73B19B3
	for <linux-acpi@vger.kernel.org>; Wed, 12 Aug 2026 08:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786523037; cv=none; b=FT5/33/L72oWOQse7fumrCwurQJ2RB1usZr23N2mgeCtbBKkHosGcjyIgroaUTyVYOJq/aX1l4L74w744JF6I/NGHFHtY0pSH4XIVP22o2x8TXAQjB4iF6zFOr+xJ+OUe7DxEOEcSD2FjwhFYYRDyFyMG+BHj1l3w0offh9sPTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786523037; c=relaxed/simple;
	bh=ggewJBxgRCZ6GM4jSGbE8mnerhZ/94VxFYfhAw6sWlQ=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SA30SH0OX2Uj7KxmckgDHhdgiBBSTwL7wdZj985UpCOt/ek+r3cRnao08SQO+eK7YXI9xC7tbqSWzXsMCQ8PrYRWMpud50zRyR07vrk1OoDBoefdTQn+JWkfcmjXfWmnPkEPoFAawf4LHzvBRVmD2GPnACJNeTbHmhKDkQ3xIiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QiS5Q6w+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QiS5Q6w+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A8391F00ACF
	for <linux-acpi@vger.kernel.org>; Wed, 12 Aug 2026 08:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786523036;
	bh=ggewJBxgRCZ6GM4jSGbE8mnerhZ/94VxFYfhAw6sWlQ=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=QiS5Q6w+hl4qg76NBgLfnDqncgvI2uMa+x/VHPPxMVYz2km6lrdHHYNIj4qEwFWuL
	 Brkv4f5ujuTCZD8chLJGV1knvpAJjF4fnI5vajQGv6HUPZTnzNq26cTjV3YU1gGl3a
	 ldLrxuidqzC0ZVCg5OPCbiHLGTtNyd4Vs1QI+Waa1eH+SaOH3gusXJ/qJN+6ClaKOy
	 tVu16cQwoY8PtKVBLqO3SEHbQ89rnHcimarER8dWbnaGhyl2cN9OgnglAOoAozijeR
	 J61PfsWJ4hlB8Yrc8Q32hlv+nVy4lKKdU3gcrXAOWBN0wb1aDlfYuL+5sbqILqagNm
	 E+aJ3eJA1/fmA==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5aeba09900bso539740e87.2
        for <linux-acpi@vger.kernel.org>; Wed, 12 Aug 2026 01:23:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqcppMrJZJ9sdBHYI/XVU2NQmzMViotLgSW1z+3I6L3rMmOB4bdPDDiZcQachex75yi3ksEhYnYomkS@vger.kernel.org
X-Gm-Message-State: AOJu0Yzml3kjYknmotMTJSYc1F4jk8I6Q5LT0HHjyvfcNEUVsD1kX8Qn
	6eQ+ZIqZeQ9SI+a2Mf4TdN4G7SBggFPTELR5FTXg59ImmCihdjf8Ez8FTuTTEJfuITcAmbVn7m3
	hyy+NF1+vdfrYGVdwux04ckBqxWvxGa+crTFegs8cZw==
X-Received: by 2002:a05:6512:ac8:b0:5b2:d876:514a with SMTP id
 2adb3069b0e04-5b44e31a1famr493806e87.26.1786523034804; Wed, 12 Aug 2026
 01:23:54 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 12 Aug 2026 01:23:53 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 12 Aug 2026 01:23:53 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <ans3pcNFEDVBYXXT@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260808155513.2221976-1-xnorigc@gmail.com> <aneGptJn8J7eF9tj@ashevche-desk.local>
 <CAD++jLkCYwTyK6C8LvZiYJ9fSc8bp3RPpb4d6EgQTRraJtJDzA@mail.gmail.com>
 <anmNf3rJGxso6nuc@ashevche-desk.local> <ans3pcNFEDVBYXXT@ashevche-desk.local>
Date: Wed, 12 Aug 2026 01:23:53 -0700
X-Gmail-Original-Message-ID: <CAMRc=MeDLc-LPwoCEA8yMw3+L9UcN-NgXpYpFPxtUNffAAffyw@mail.gmail.com>
X-Gm-Features: AUfX_mzp0xFoKJQOkb5LbPvMPRLjgGd29o-t2k5FVBFiVV_bBiOJeFevYaDnlEM
Message-ID: <CAMRc=MeDLc-LPwoCEA8yMw3+L9UcN-NgXpYpFPxtUNffAAffyw@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: acpi: Add ignore_wake quirk for ASUS TX Air FA401GM
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Yao Qi <xnorigc@gmail.com>, westeri@kernel.org, brgl@kernel.org, 
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Linus Walleij <linusw@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 11 Aug 2026 16:54:29 +0200, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> said:
> On Mon, Aug 10, 2026 at 11:36:19AM +0300, Andy Shevchenko wrote:
>> On Mon, Aug 10, 2026 at 12:17:06AM +0200, Linus Walleij wrote:
>> > On Sat, Aug 8, 2026 at 9:42=E2=80=AFPM Andy Shevchenko
>> > <andriy.shevchenko@linux.intel.com> wrote:
>> > > On Sat, Aug 08, 2026 at 03:55:13PM +0000, Yao Qi wrote:
>> >
>> > > > The ASUS TX Air FA401GM experiences immediate wakeups from s2idle
>> > > > (Modern Standby) when suspended with an external HDMI display conn=
ected.
>> > > >
>> > > > This issue is caused by spurious ACPI event signaling routed throu=
gh
>> > > > GPIO 24 on the AMD GPIO controller (AMDI0030:00), which triggers a
>> > > > system-wide IRQ 7 (pinctrl_amd) wake-up interrupt during sleep.
>> > > >
>> > > > Add an ignore_wake quirk for GPIO 24 on this machine to prevent th=
ese
>> > > > unwanted wakeups. This has been runtime-tested and verified using =
the
>> > > > `gpiolib_acpi.ignore_wake=3DAMDI0030:00@24` kernel parameter.
>> > >
>> > > If AMD people will be quick enough to tag this, I will include in my=
 PR to
>> > > Linus W. on next week.
>> >
>> > To Bartosz?
>> > It's gpiolib...
>>
>> Oh, true, I have also pin control stuff to send!
>
> Okay, I have checked if I have anything to Bart and it seems I mixed that=
 with
> pin control stuff. So, Bart, if you feel confident about this patch, you =
can
> take it directly. Here is my formal tag for that
>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>

Is this a bugfix? I'll be OoO until the end of August starting on Friday wi=
th
the exception of a single day to catch up on email. I'll be sending my PRs =
for
v7.3 tomorrow. Not sure if I should take it for v7.3 or v7.2?

Bart
