Received: from relay13.grserver.gr (relay13.grserver.gr [178.156.171.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3613C5539
	for <linux-acpi@vger.kernel.org>; Tue, 28 Apr 2026 08:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.156.171.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777364353; cv=none; b=eGZESuP/X29Fx8emzApA4NJeWlqcIjybCaN+ZHcS0HaDO542LAU6fyhdiWzQSo5ivK330Kn+SVk3RLAjzTdy9woUxFnV+X9yzIEv7h6BH6GPSlQuYezHafTKELs+EmSEfB96LL/ylN/zn44M4HIYBPbZKaroFIOGv/mrVY9h7+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777364353; c=relaxed/simple;
	bh=5qUff3OaqwfKMVEVzHhC7u0IDWF25nVL6mUPh+PE3Z4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=odqV7aaGSBnM0GRCoEq87KNTfcmwRWHFL7IDkDy5MLeTL0Qqo37PhCFKEHJtlhZ7L+By5u94/Hwa+Rb43v8AkPX7NIOoLwUd4THfewgztxMcS3zg3VQIYzKYQRUETByNVNkAgUzJFXHExieFr7tK2daPXg6Gz0J6wFQpi1YI1Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=GPrNLtU4; arc=none smtp.client-ip=178.156.171.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="GPrNLtU4"
Received: from relay13 (localhost [127.0.0.1])
	by relay13.grserver.gr (Proxmox) with ESMTP id 49C815DF1B
	for <linux-acpi@vger.kernel.org>; Tue, 28 Apr 2026 11:19:02 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay13.grserver.gr (Proxmox) with ESMTPS id 3D5675E546
	for <linux-acpi@vger.kernel.org>; Tue, 28 Apr 2026 11:19:00 +0300 (EEST)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 0CC6A1FCE4A
	for <linux-acpi@vger.kernel.org>; Tue, 28 Apr 2026 11:18:59 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1777364339;
	bh=TVgXc0KwwLKEsaCOrVpgZEldsX97AJCG9Zlqmcu74MQ=;
	h=Received:From:Subject:To;
	b=GPrNLtU4fS2iLAmwcplAbcTDWCsYuT0TVft5P1KvkxJm4rPl1vFFuFuJSjge564eY
	 hWyvgvwWk/8y18D5hHHrt57W/5HWdk8HzPX7lDr/sW1izJ3VSQgZZ/RdUOSj/KrzcN
	 qO/MQ/DRKGa5l/MbC/DaMO9wgB+4Kb/uR/nX6LLMWfXbYF6+rNcPm7p9ve+Cgirf48
	 ac5LQfEP/uJiHChTwwyXvrOIymdfPxed4FET4oGd6mi7t+tMPAOWmL6LHl3pqCPd3R
	 IC0baOMETidZyS5OinZl5SwaVurJFuS5d6jLP496tR7jSLhBpq0EukQpZUEBP7/BSi
	 n7INNl23eT8gg==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.215.174) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-pg1-f174.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-pg1-f174.google.com with SMTP id
 41be03b00d2f7-c7963df6f17so7288956a12.0
        for <linux-acpi@vger.kernel.org>;
 Tue, 28 Apr 2026 01:18:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ9FO+2bPNi18ipU66qRegDfFOBLprBLIidNqyS9O4VIrMTd5U4VnvtS0XyvZJzx+9nRYIu6wy7dVwDl@vger.kernel.org
X-Gm-Message-State: AOJu0YwhyUSMloi79G2sEeNy2Pxk7Dcg15+SV6wGFyPW01keMhUgBp/t
	Ko3UthrJPzArY9Haa/TstdfDktXIYukG/viARG7ep4a5HIuQZiolAnPcNS7aUwCZioiOawESBAQ
	nnJsf37Amckr9kbbX/g+rO54wfRTWP4M=
X-Received: by 2002:a05:6a20:548d:b0:3a0:cd5:82b7 with SMTP id
 adf61e73a8af0-3a39c46a108mr2529853637.55.1777364337930; Tue, 28 Apr 2026
 01:18:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260425215734.14116-1-lkml@antheas.dev>
 <20260425215734.14116-5-lkml@antheas.dev>
 <c2dc681e-2291-4dc7-b0d4-8f8f6996cf48@molgen.mpg.de>
In-Reply-To: <c2dc681e-2291-4dc7-b0d4-8f8f6996cf48@molgen.mpg.de>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Tue, 28 Apr 2026 10:18:46 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwEEuTOrSj988XR7jUWpfVESCp3YVS_NsmLuQXxFxGAACQ@mail.gmail.com>
X-Gm-Features: AVHnY4IcfMVAAkwc9N9jQJseVDOTyGuh0FmREA1ud2pEB-lqd4KIn5s7l82wbjc
Message-ID: 
 <CAGwozwEEuTOrSj988XR7jUWpfVESCp3YVS_NsmLuQXxFxGAACQ@mail.gmail.com>
Subject: Re: [systemd-devel] [RFC v2 04/10] platform/x86: asus-wmi: add s2idle
 begin delay for Ally devices
To: Paul Menzel <pmenzel+systemd-devel@molgen.mpg.de>
Cc: dmitry.osipenko@collabora.com, bob.beckett@collabora.com,
	bookeldor@gmail.com, hadess@hadess.net, jaap@haitsma.org,
	kernel@collabora.com, lennart@poettering.net, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, mccann@jhu.edu, rafael@kernel.org,
	richard@hughsie.com, sebastian.reichel@collabora.com, superm1@kernel.org,
	systemd-devel@lists.freedesktop.org, xaver.hugl@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-PPP-Message-ID: 
 <177736433927.2507709.12950782454498651576@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Tue, 28 Apr 2026 at 08:34, Paul Menzel
<pmenzel+systemd-devel@molgen.mpg.de> wrote:
>
> Dear Antheas,
>
>
> Thank you for your patch.
>
> Am 25.04.26 um 23:57 schrieb Antheas Kapenekakis:
> > Asus ROG Ally devices have a small fade animation during their suspend
> > sequence. This animation is triggered by the Display Off firmware
> > notification. After it, they power off, disconnect, and save their
>
> Does *they* mean the system firmware?

Hi,
thanks

MCU firmware, will reword to say controller

> > state. Without a delay after that notification, if the device is placed
> > into D3, it causes it to reboot during resume, or particularly for
> > original Allies, also leave the xpad device connected, causing spurious
> > wakeups when a gamepad button is pressed and higher standby drain.
> >
> > Therefore, introduce a small delay quirk and bind it to an s2idle dev
> > ops device. Place this quirk in the asus-wmi driver, as the USB gamepad
> > disconnects, making it hard to place in hid-asus, and to allow for
> > proper functionality when the hid-asus driver is blacklisted.
>
> Reading the commit message, it=E2=80=99s not clear to me, if it=E2=80=99s=
 a firmware bug
> or not. I=E2=80=99d say, it is. Could Asus fix *additionally* fix it?

It is a linux specific firmware bug that happens because the
assumption of "In 95% of cases, I will have 300ms after the Display
Off notification fires" does not hold in Linux.

Because the controller expects to have the time to fade the RGB, and
then power off.

Currently, the notification fires after the controller has already
powered off. It is mostly fixed by Asus already and even without this
patch the controller has correct functionality. The delay mostly makes
sure that the fade animation is performed correctly, the original ally
yanks its xpad device, and when mcu powersave is off, instead of the
controller rebooting, it comes back instantly after suspend. For
earlier firmwares that had bigger issues, the delay also fixes those.

> Also please list the devices added to the quirk list to the commit messag=
e.

Ack.

> > Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> > ---
> >   drivers/platform/x86/asus-nb-wmi.c | 40 +++++++++++++++++++++++++++++=
+
> >   drivers/platform/x86/asus-wmi.c    | 12 +++++++++
> >   drivers/platform/x86/asus-wmi.h    | 14 +++++++++++
> >   3 files changed, 66 insertions(+)
> >
> > diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/=
asus-nb-wmi.c
> > index b4677c5bba5b..da963f3a17b1 100644
> > --- a/drivers/platform/x86/asus-nb-wmi.c
> > +++ b/drivers/platform/x86/asus-nb-wmi.c
> > @@ -155,6 +155,10 @@ static struct quirk_entry quirk_asus_z13 =3D {
> >       .tablet_switch_mode =3D asus_wmi_kbd_dock_devid,
> >   };
> >
> > +static struct quirk_entry quirk_ally =3D {
> > +     .lps0_begin_delay =3D 500,
>
> I=E2=80=99d append the unit to the variable name. (But I also saw that
> `s2idle_dev_ops.begin_delay` does not follow this schema.)

I can add that.

> > +};
> > +
> >   static int dmi_matched(const struct dmi_system_id *dmi)
> >   {
> >       pr_info("Identified laptop model '%s'\n", dmi->ident);
> > @@ -553,6 +557,42 @@ static const struct dmi_system_id asus_quirks[] =
=3D {
> >               },
> >               .driver_data =3D &quirk_asus_z13,
> >       },
> > +     {
> > +             .callback =3D dmi_matched,
> > +             .ident =3D "ASUS ROG Ally",
> > +             .matches =3D {
> > +                     DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."=
),
> > +                     DMI_MATCH(DMI_BOARD_NAME, "RC71L"),
> > +             },
> > +             .driver_data =3D (void *)&quirk_ally,
> > +     },
> > +     {
> > +             .callback =3D dmi_matched,
> > +             .ident =3D "ASUS ROG Ally X",
> > +             .matches =3D {
> > +                     DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."=
),
> > +                     DMI_MATCH(DMI_BOARD_NAME, "RC72L"),
> > +             },
> > +             .driver_data =3D (void *)&quirk_ally,
> > +     },
> > +     {
> > +             .callback =3D dmi_matched,
> > +             .ident =3D "ASUS ROG Xbox Ally",
> > +             .matches =3D {
> > +                     DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."=
),
> > +                     DMI_MATCH(DMI_BOARD_NAME, "RC73Y"),
> > +             },
> > +             .driver_data =3D (void *)&quirk_ally,
> > +     },
> > +     {
> > +             .callback =3D dmi_matched,
> > +             .ident =3D "ASUS ROG Xbox Ally X",
> > +             .matches =3D {
> > +                     DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."=
),
> > +                     DMI_MATCH(DMI_BOARD_NAME, "RC73X"),
> > +             },
> > +             .driver_data =3D (void *)&quirk_ally,
> > +     },
> >       {},
> >   };
> >
> > diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asu=
s-wmi.c
> > index 7c0915e097ba..3316415abbdf 100644
> > --- a/drivers/platform/x86/asus-wmi.c
> > +++ b/drivers/platform/x86/asus-wmi.c
> > @@ -337,6 +337,8 @@ struct asus_wmi {
> >       struct asus_wmi_debug debug;
> >
> >       struct asus_wmi_driver *driver;
> > +
> > +     struct acpi_s2idle_dev_ops s2idle_dev_ops;
> >   };
> >
> >   /* Global to allow setting externally without requiring driver data *=
/
> > @@ -5030,6 +5032,12 @@ static int asus_wmi_add(struct platform_device *=
pdev)
> >       if (err)
> >               goto fail_platform;
> >
> > +     if (asus->driver->quirks->lps0_begin_delay) {
> > +             asus->s2idle_dev_ops.begin_delay =3D
> > +                     asus->driver->quirks->lps0_begin_delay;
> > +             acpi_register_lps0_dev(&asus->s2idle_dev_ops);
> > +     }
> > +
> >       if (use_ally_mcu_hack =3D=3D ASUS_WMI_ALLY_MCU_HACK_INIT) {
> >               if (acpi_has_method(NULL, ASUS_USB0_PWR_EC0_CSEE)
> >                                       && dmi_check_system(asus_rog_ally=
_device))
> > @@ -5184,6 +5192,8 @@ static int asus_wmi_add(struct platform_device *p=
dev)
> >   fail_custom_fan_curve:
> >   fail_platform_profile_setup:
> >   fail_fan_boost_mode:
> > +     if (asus->driver->quirks->lps0_begin_delay)
> > +             acpi_unregister_lps0_dev(&asus->s2idle_dev_ops);
> >   fail_platform:
> >       kfree(asus);
> >       return err;
> > @@ -5207,6 +5217,8 @@ static void asus_wmi_remove(struct platform_devic=
e *device)
> >       asus_fan_set_auto(asus);
> >       throttle_thermal_policy_set_default(asus);
> >       asus_wmi_battery_exit(asus);
> > +     if (asus->driver->quirks->lps0_begin_delay)
> > +             acpi_unregister_lps0_dev(&asus->s2idle_dev_ops);
> >
> >       kfree(asus);
> >   }
> > diff --git a/drivers/platform/x86/asus-wmi.h b/drivers/platform/x86/asu=
s-wmi.h
> > index 5cd4392b964e..2a8c51d39bf8 100644
> > --- a/drivers/platform/x86/asus-wmi.h
> > +++ b/drivers/platform/x86/asus-wmi.h
> > @@ -52,6 +52,20 @@ struct quirk_entry {
> >        */
> >       int no_display_toggle;
> >       u32 xusb2pr;
> > +     /*
> > +      * Ally devices uninitialize after the display off DSM of modern
> > +      * stanby, after a predetermined fade animation on their RGB.
>
> standby
>
> > +      * If the USB subsystem puts the controller into D3 before that,
> > +      * it loses its state and (i) for original allies, it leaves the
>
> Allies (or Allys) to make it easier to read for non-native speakers.
>
> > +      * xpad device connected, causing spurious wake-ups and higher
> > +      * power draw, (ii) for newer allies using the adaptive protocol
>
> Ditto.
>
> > +      * causes the controller to reboot on resume if mcu_powersave is
> > +      * false. Therefore, allow adding a delay for the affected device=
s.
> > +      * (if MCU powersave is true the controller always reboots, but
>
> Is MCU powersave a system firmware (UEFI) option?

MCU powersave (as named in this driver), and named Extreme Standby in
Windows, is an Asus WMI param (cannot be set in the BIOS but it is
UEFI) that makes it so the controller completely powers off during
sleep and halves standby power.

Noted on the other comments.

Antheas

> > +      * this also causes an unwelcome 5-7s delay on resume, this issue
> > +      * is present on all firmwares)
> > +      */
> > +     int lps0_begin_delay;
> >   };
> >
> >   struct asus_wmi_driver {
>
>
> Kind regards,
>
> Paul
>

