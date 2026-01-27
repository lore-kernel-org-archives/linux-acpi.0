Received: from relay14.grserver.gr (relay14.grserver.gr [157.180.73.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CAB1E8836
	for <linux-acpi@vger.kernel.org>; Tue, 27 Jan 2026 15:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.180.73.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769529599; cv=none; b=qnUnuu2bl+7QNpo8WfnKlWrOBCfSHPAy7wmizFE8KGXxaMwWYPkELfG8yhE1ukwHnu55fef/z8zJBeP8tkyZtfzEOCt3UZl9kb7qozVijF3cZiyMenJQEQ29DqyAk/5V1IXFMfjNrGdJpGgOqsMKl9NNc1rm1TFW8b6oC6OngeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769529599; c=relaxed/simple;
	bh=7UbGIR6Ekx7jXYij3Pyl/ouoe5ssVqHUJ/fNeg9ZyC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cu7Uzzrv2sajGkmmVAYRnkaeqGkBdiRjY2lLF2SwIFbpQrAegNN8Pb1BPHiKd5BNY/no+W1e7kvu/lDC3MgYLZqg9OoT+FT5QUlJjhcPBsd1bNXSVC9orp5JmIrKCmp0M4KTLk5u/RebB2KfsTKhhM9W8JojbJsntxBVxVIc9no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=FrL9UJh2; arc=none smtp.client-ip=157.180.73.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="FrL9UJh2"
Received: from relay14 (localhost [127.0.0.1])
	by relay14.grserver.gr (Proxmox) with ESMTP id EB55D40B0B
	for <linux-acpi@vger.kernel.org>; Tue, 27 Jan 2026 15:59:48 +0000 (UTC)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay14.grserver.gr (Proxmox) with ESMTPS id DC75F40AFE
	for <linux-acpi@vger.kernel.org>; Tue, 27 Jan 2026 15:59:47 +0000 (UTC)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 2D9E81FD5CB
	for <linux-acpi@vger.kernel.org>; Tue, 27 Jan 2026 17:59:47 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1769529587;
	bh=aB9kxj1zBHCSlg1D4wHLF7HRgwHd7juII+bjzeQhnnA=;
	h=Received:From:Subject:To;
	b=FrL9UJh2ZRxMKt6cwBb/I2UdJf6lQycumpRgTl1ysHz3atxOCLfR4Y8zq+ap0sCD3
	 IhKcgTniqKO2xYCL3WCo17/H/rsncbHAipnldeeoJgyC/6+MsYcp6+O2GhpHPb86vC
	 HP0Qpqy3+dmfN89/DUrV/HWypvh3R37otfbz4AFTzevb4z+WQVQr/8Jd+tqAIcpjFN
	 jus0b7El0KnkgyLRANEvxO+nXH2X2ntuDnctj4h/VPMWFMcWOXeduVGpgMFxSOYnUA
	 68h2DF7Pvu6g7mlADZJ0n0i8wBsikKP6izKeuuyHciUSXOll+5zs1hLBYwetmTT6pw
	 Z8XQn3lpGG1cg==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.167.52) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lf1-f52.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-lf1-f52.google.com with SMTP id
 2adb3069b0e04-59dd54b1073so5930674e87.0
        for <linux-acpi@vger.kernel.org>;
 Tue, 27 Jan 2026 07:59:47 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVumFtfb/eVJ7uSXECxkEWljPoYp9LgS9zsgBprKdN8afWA+RzUh71a/+RZUuQdxwjC5gHBx5XPiPXR@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0JR+iC+c3Gz1sPnFH+PONskqQAzdI7WAIaszi03S39CLPRNKU
	JDJPwBOiRrnHKnVpR6NJkr34TjEO7YPsbj5b5Ofd2+fkLEqarKO/0GctlIBbshYJfPbULXdQtiH
	nnoP0eV/sK/3hRAqq5F5DH+IhdHsGNsI=
X-Received: by 2002:a05:6512:8006:10b0:59e:708:cf56 with SMTP id
 2adb3069b0e04-59e0708cfb6mr111582e87.26.1769529586606; Tue, 27 Jan 2026
 07:59:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107154015.322698-1-jriemenschne@student.ethz.ch>
 <CAJZ5v0gj6YmypO7B-FpjPKc3WK3R5HSso0RaMBER9FMripYCaA@mail.gmail.com>
In-Reply-To: 
 <CAJZ5v0gj6YmypO7B-FpjPKc3WK3R5HSso0RaMBER9FMripYCaA@mail.gmail.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Tue, 27 Jan 2026 16:59:35 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwF_Phm_MiLg3Zv89aZUGgV-DW6crXT5P9n75hd7j7hQjw@mail.gmail.com>
X-Gm-Features: AZwV_Qgdpkr1uWtz5Bsz-CDVReDjhJA4fNROMjnnQdoFg18CwMY_leEE2v2WvLU
Message-ID: 
 <CAGwozwF_Phm_MiLg3Zv89aZUGgV-DW6crXT5P9n75hd7j7hQjw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: x86: s2idle: Invoke Microsoft _DSM Function 9 (Turn
 On Display)
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Jakob Riemenschneider <riemenschneiderjakob@gmail.com>,
 linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-PPP-Message-ID: 
 <176952958736.2010671.9987305260845602235@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Tue, 27 Jan 2026 at 15:50, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, Jan 7, 2026 at 4:40=E2=80=AFPM Jakob Riemenschneider
> <riemenschneiderjakob@gmail.com> wrote:
> >
> > Windows 11, version 22H2 introduced a new function index (Function 9) t=
o
> > the Microsoft LPS0 _DSM, titled "Turn On Display Notification".
> >
> > According to Microsoft documentation, this function signals to the syst=
em
> > firmware that the OS intends to turn on the display when exiting Modern
> > Standby. This allows the firmware to release Power Limits (PLx) earlier=
,
> > improving resume latency on supported OEM designs. Without this call,
> > some devices may remain in a throttled power state longer than necessar=
y
> > during resume.
>
> Has this been observed in the field?
>
> Any examples?
>
> > This patch defines the new function index (ACPI_LPS0_MS_DISPLAY_ON) and
> > invokes it in acpi_s2idle_restore_early_lps0() immediately after the
> > screen-on notification, provided the firmware supports the function in
> > its mask.
> >
> > Link: https://learn.microsoft.com/en-us/windows-hardware/design/device-=
experiences/modern-standby-firmware-notifications#turn-on-display-notificat=
ion-function-9
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D220505
> > Signed-off-by: Jakob Riemenschneider <jriemenschne@student.ethz.ch>
> > ---
> >  drivers/acpi/x86/s2idle.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
> > index 6d4d06236..4ce4cc8a0 100644
> > --- a/drivers/acpi/x86/s2idle.c
> > +++ b/drivers/acpi/x86/s2idle.c
> > @@ -45,6 +45,7 @@ static const struct acpi_device_id lps0_device_ids[] =
=3D {
> >  #define ACPI_LPS0_EXIT         6
> >  #define ACPI_LPS0_MS_ENTRY      7
> >  #define ACPI_LPS0_MS_EXIT       8
> > +#define ACPI_LPS0_MS_DISPLAY_ON 9
> >
> >  /* AMD */
> >  #define ACPI_LPS0_DSM_UUID_AMD      "e3f32452-febc-43ce-9039-932122d37=
721"
> > @@ -352,6 +353,8 @@ static const char *acpi_sleep_dsm_state_to_str(unsi=
gned int state)
> >                         return "lps0 ms entry";
> >                 case ACPI_LPS0_MS_EXIT:
> >                         return "lps0 ms exit";
> > +               case ACPI_LPS0_MS_DISPLAY_ON:
> > +                       return "lps0 ms display on";
> >                 }
> >         } else {
> >                 switch (state) {
> > @@ -618,9 +621,14 @@ static void acpi_s2idle_restore_early_lps0(void)
> >         }
> >
> >         /* Screen on */
> > -       if (lps0_dsm_func_mask_microsoft > 0)
> > +       if (lps0_dsm_func_mask_microsoft > 0) {
> >                 acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_ON,
> >                                 lps0_dsm_func_mask_microsoft, lps0_dsm_=
guid_microsoft);
> > +                               /* Modern Turn Display On */
> > +               acpi_sleep_run_lps0_dsm(ACPI_LPS0_MS_DISPLAY_ON,
> > +                               lps0_dsm_func_mask_microsoft, lps0_dsm_=
guid_microsoft);
>
> Is the ordering right with respect to the non-MSFT screen-on
> notifications below?
>
> I would expect it to be done after all of the screen-on notifications,
> so is there a specific reason to do it earlier?
>
> > +       }
> > +
> >         if (lps0_dsm_func_mask > 0)
> >                 acpi_sleep_run_lps0_dsm(acpi_s2idle_vendor_amd() ?
> >                                         ACPI_LPS0_SCREEN_ON_AMD :
> > --
>
> Also, this kind of clashes with the "dark mode" work in progress, see
> for example:
>
> https://lore.kernel.org/linux-acpi/20251226102656.6296-1-lkml@antheas.dev=
/
>

Hi,
I wasn't aware of a device that uses this function but I guess OEMs
could so they shipped buggy firmware. It is added speculatively in my
series.

Technically, it is supposed to be called before ms exit, as windows
uses it to signal that _it will_ turn on the display while in sleep.
So, exit, intent, ms exit, display on.

I am not sure if it is also called when in the "screen off" state if
the device uses the mouse while inactive. Someone would need to check
in Windows using power manager. I do not have a device to check.

So, two comments from me:
  - Move to before ms_exit, or show it should be fired after (sleep
exit in windows)
  - Change the name, as it is a bit confusing, perhaps to
ACPI_MS_TURN_ON_DISPLAY or similar. If you can make that change I will
ack it and add rby

This merging first simplifies my series so it should go through (I can
drop "[RFC v1 6/8] acpi/x86: s2idle: implement turn on display DSM as
resume notification").

In addition, as we now know resume needs to fire always, I will need
to make some changes for V2 of my series to make sure that happens

Antheas

