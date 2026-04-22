Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358D23CBE97
	for <linux-acpi@vger.kernel.org>; Wed, 22 Apr 2026 13:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776864435; cv=none; b=ntDJeE92PYf60L15/9xJtvVueWDEEUQr9xXLe3+u4d1MnZ/SxZ/AtZLmdUFrDYTM5VwyL8pjw57Nvm8eq/7DZZGrC0Yz6p0zy1NxbAlxIgzskya6nY9rNhPOfXPwSTLi/TZtHOzrbUVvSrD5c12mPxABmNjee2OMupKmHMKfq9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776864435; c=relaxed/simple;
	bh=IYC+sUrQnoBvQ7f9cR4U5CF7nGhhi6uzi/Zp3PEjhs0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uviEbpc0N6q2MU07crQi47v5FRJF/5zNvpuoe3MZyadxgDNz3A830iMJnnmbaTwfwkMcKBuLWn8UO2NmvO3MhdSnORjJ4LV2abyItvkTEdB9yxwCx8+I6Cmfpof0C0ScU7t/3Nr91LhqpZQhBg6HFNt4QQtfwqQhwt+YWv/4I6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bb6aoaph; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bb6aoaph"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E34A9C2BCB8
	for <linux-acpi@vger.kernel.org>; Wed, 22 Apr 2026 13:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776864434;
	bh=IYC+sUrQnoBvQ7f9cR4U5CF7nGhhi6uzi/Zp3PEjhs0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Bb6aoaphzN4diYbSuF6qXpJ2gzynsAtFIa5YvaA5e4YQA7kF4hitzzuYMc7Qx+mWV
	 DsHl0CPQ5aX3Snk+eBYxPvJhaGHb7sn8FFAaWbkzJViEkSTKiYVdX7KD8uIiy1XZVY
	 uvMlZI1xEkTWBbbqUZ7gOPodBzs+2Aq4PEJ4rLw+sPyUPiX7axNhNvSARGa1ULUnMH
	 sGW5nyGVWcmsorhyUsqVc1WQspzBM4gPBPGJMV/VOrtX+/9mesi+BrdM6Pwl/p6b15
	 ikkvJR2AK7WlZ9ZjB5SWizp+QGZyUxZI0hTJBK5Kcp+7j9fM451l8xbQuCT8ybFN1Z
	 uFMCvdvgOwbiw==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3878de20527so40606961fa.3
        for <linux-acpi@vger.kernel.org>; Wed, 22 Apr 2026 06:27:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+70vsTPjzmucQ5l5cgU3Xq/4T/cpQyI7LjEGX6B67s9pxLq7rL96qB71qVUe3vg+XuIghYpOtnaAQi@vger.kernel.org
X-Gm-Message-State: AOJu0YylXZDW14lQJjjrjLkqIhkZBzlPwCI0sDV2KJ4kpsmI1TzNaf0B
	PBS1jjoVibOqy6PjRht6BYKcFc7bAcjyShqJTYXW8C5RVxnoaNCAHwvIG8YgZ4CiwHo9QyTWUTC
	6YtdhrkWKOmOA0zQfC0smp8H+kl35lzk=
X-Received: by 2002:a05:6512:32c8:b0:5a2:c406:a74a with SMTP id
 2adb3069b0e04-5a4172de4ccmr8579506e87.35.1776864433237; Wed, 22 Apr 2026
 06:27:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12879883.O9o76ZdvQC@rafael.j.wysocki> <168591776860440@mail.yandex.ru>
 <CAGAxtY1QDN_vkXEzdT8yUC5ZR3W+18TypEcJLR+-=kUkaBOdTw@mail.gmail.com>
In-Reply-To: <CAGAxtY1QDN_vkXEzdT8yUC5ZR3W+18TypEcJLR+-=kUkaBOdTw@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 22 Apr 2026 15:26:59 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jzPk1Ad-fkKnKZwBWifQ89oPgEhv7A5M5mLtPyMRX+nw@mail.gmail.com>
X-Gm-Features: AQROBzCjzFXToE_yaHV47kSWGXepOXgPexweqVCWE1kWPaGN9wSQKqTFZfMy7EQ
Message-ID: <CAJZ5v0jzPk1Ad-fkKnKZwBWifQ89oPgEhv7A5M5mLtPyMRX+nw@mail.gmail.com>
Subject: Re: Pressing the power button causes the device to freeze completely
To: Evgeny Sagatov <evgeny.sagatov@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, regressions@lists.linux.dev, 
	linux-acpi@vger.kernel.org, Thorsten Leemhuis <regressions@leemhuis.info>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Wysocki Rafael J <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Apr 22, 2026 at 2:36=E2=80=AFPM Evgeny Sagatov <evgeny.sagatov@gmai=
l.com> wrote:
>
> Hello Rafael,
>
> I applied the patch that you sent.
> The PC isn't responding to the power button press. It doesn't freeze.

As expected, thanks!  I'll send you another patch to test (instead of
the one you have tested) in the next message.

> I just want to clarify, did you receive messages where we found the
> first broken commit using git bisect?
>
> > 8c94ccc7cd691472461448f98e2372c75849406c    good
> > e37617c8e53a1f7fcba6d5e1041f4fd8a2425c27    good
> > b0d326da462e20285236e11e4cbc32085de9f363    bad

Yes, I did, but I think that reverting the schedutil change hides the probl=
em.

BTW, since reverting the schedutil change makes a difference for you,
I'm wondering about the cpufreq configuration on your system.  Can you
please send me the

$ grep -r . /sys/devices/system/cpu/cpufreq/

output from your system?


> > On Tuesday, April 21, 2026 5:11:36 PM CEST Wysocki, Rafael J wrote:
> >
> >  Hi,
> >
> >  On 4/13/2026 6:46 PM, Evgeny Sagatov wrote:
> >  > Hello,
> >  > I have a PC with a motherboard GA-EP45T-UD3LR (Rev. 1.0)
> >  > <https://www.gigabyte.com/Motherboard/GA-EP45T-UD3LR-rev-10> and
> >  > processor Intel Core 2 Quad Q9550.
> >  > Previously, I had Debian 12 with kernel 6.1 installed, and pressing
> >  > the power button would shut down the PC as usual.
> >  > I updated to Debian 13 with kernel 6.12.74, and now pressing the pow=
er
> >  > button causes the PC to freeze completely.
> >  > I see that systemd doesn't even begin to shut down. It freezes
> >  > immediately after pressing the button. There's no error message in
> >  > console. There's no error message in the logs either. Netconsole
> >  > doesn't report any errors, and the kernel doesn't panic. It just
> >  > freezes completely.
> >
> >  It looks like the ACPI button notify handler crashes on your system fo=
r
> >  some obscure reason.
> >
> >  It should be possible to get to the bottom of it, but it will require
> >  some investigation if you have the motivation and time to run debug pa=
tches.
> >
> >
> >  > I checked that Live CD with Debian 12 continue to shut down normally=
,
> >  > but Live CD with Debian 13 freeze.
> >  > I tried updating and resetting the BIOS. I tried various kernel
> >  > parameters related to ACPI settings. I also tried kernels 6.18 and
> >  > 6.19. Nothing fixed the problem.
> >  > If I unload the "button" module, the system doesn't freeze, but it
> >  > also doesn't shut down.
> >
> >  This is a useful data point, thanks!
> >
> >
> >  > I built "button" module by rolling back its version to commit 1a20d4=
0
> >  > <https://github.com/torvalds/linux/commit/1a20d409c874255086e2f42a72=
9826d490294c91>,
> >  > which corresponds to kernel version 6.1. This module does not freeze=
,
> >  > but does not turn off the PC either.
> >  > I've found that the freezes have been occurring since commit 0d51157
> >  > <https://github.com/torvalds/linux/commit/0d51157dfaac05ea66616d8a25=
0dce04bef49a4f>.
> >
> >  The main difference made by it is the fixed events handling and if the=
re
> >  is a problem with that, a few debug patches should suffice to find out
> >  what's going on. I'll send you one to try shortly.
> >
> >
> > First off, on top of 7.0.0 (since the issue is present in this one, I t=
hink
> > it's better to focus the debugging on it), let's first check what happe=
ns if
> > the ACPI fixed event handler is not installed for the power button at a=
ll.
> >
> > This should be similar to using a 6.1 version of the button driver (tha=
t is,
> > no crash, but pressing the power button will have no effect).
> >
> > Please test the patch below and let me know what happens.
> >
> > ---
> >  drivers/acpi/button.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > --- a/drivers/acpi/button.c
> > +++ b/drivers/acpi/button.c
> > @@ -628,9 +628,7 @@ static int acpi_button_probe(struct plat
> >
> >          switch (device->device_type) {
> >          case ACPI_BUS_TYPE_POWER_BUTTON:
> > - status =3D acpi_install_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
> > - acpi_button_event,
> > - button);
> > + status =3D AE_OK;
> >                  break;
> >          case ACPI_BUS_TYPE_SLEEP_BUTTON:
> >                  status =3D acpi_install_fixed_event_handler(ACPI_EVENT=
_SLEEP_BUTTON,
> >
> >
> >
> >
> >
> > -------- =D0=9A=D0=BE=D0=BD=D0=B5=D1=86 =D0=BF=D0=B5=D1=80=D0=B5=D1=81=
=D1=8B=D0=BB=D0=B0=D0=B5=D0=BC=D0=BE=D0=B3=D0=BE =D1=81=D0=BE=D0=BE=D0=B1=
=D1=89=D0=B5=D0=BD=D0=B8=D1=8F --------
