Received: from relay12.grserver.gr (relay12.grserver.gr [88.99.38.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F1B364943
	for <linux-acpi@vger.kernel.org>; Fri,  8 May 2026 19:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.99.38.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778270126; cv=none; b=lxhsPRYJpxFggd22W/eZCvP7DwHzXcvklXLLAswW7ye8BR52J31dhp0PGx/CWzqc3oKIDdMc5OJYFZhfKhDBttgXnGGjDjRpvBZpvvQTTq9Sdot71BZPmPZ7jKL1KAoMZJNHtKJRWSD4rsTbRpRMtJFQ/a1NUEiHH/4SZp+pydY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778270126; c=relaxed/simple;
	bh=KA4miKqqRPOLV2rn9eGzKFAAnUOg4b+Y7isnYHPR2W8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZScBMgSvONPbByhQX9u0LqLJPxpms1WrI+YfRf7nLWaJnyFCY3la2Za1Xx5N3sL11+gyKgMOkJUm3njzjTFoAzT9ae3d4p0FZKiX25wdOjHXOPFLCYrgaPZhHTVudKhiQRW2pDC93Frso0+kP+4xdC0S8rrvfAplqZ/9l5CV4/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=N47PtNil; arc=none smtp.client-ip=88.99.38.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="N47PtNil"
Received: from relay12 (localhost [127.0.0.1])
	by relay12.grserver.gr (Proxmox) with ESMTP id 052F5C1C70
	for <linux-acpi@vger.kernel.org>; Fri,  8 May 2026 22:49:33 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay12.grserver.gr (Proxmox) with ESMTPS id 03D4EC1C62
	for <linux-acpi@vger.kernel.org>; Fri,  8 May 2026 22:49:32 +0300 (EEST)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 40B262018E8
	for <linux-acpi@vger.kernel.org>; Fri,  8 May 2026 22:49:31 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1778269771;
	bh=j25iPAtKA6Lkbiwv8HlQ/3k50JlsFq/fBcuMjG9V8SY=;
	h=Received:From:Subject:To;
	b=N47PtNilTG1kbH0KU4+lFx1LVlnC3BGENm3lHkKxdLCIiBnfOP/ZHEflY5bhXcg8B
	 DUbzgS3KA6fd1KBV5lypKuKm9ZHkWawxpsthR46ZfAhh3SGaAhtOTgQWwCD3/9iT/E
	 xNIT8+loKtynepvQNdl/XcdrVOY8kaHXNFbZDDFynxdDz9tUpSERhWK84e/sMSMIWe
	 ZtHloDtY7Kybm61z86LGG6BBAU4kFTKnLbB5H/P2adEb7gptVyHC2FkMP6xAcrUuUk
	 3YbbSP6antxjK3bie382eYDshhEdT5Y3nTU6vS1bC5ggC9F2CvGVDfqQ7lxt58YLVV
	 /3OsSiWsqFzDQ==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.214.172) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-pl1-f172.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-2b9ea536877so16373085ad.1
        for <linux-acpi@vger.kernel.org>;
 Fri, 08 May 2026 12:49:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ+JaLoTmfkbYdvNzGkM7iG7PFjjQTqqnC6lA6qUvglFJDX5HStglZfY3oPrsUYKxqwwlt22XsPP93er@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe2nHl4VAJ5EvlMA9zcBE5AuoXyhVVPtZ4I60kf/ukCUvV4Roy
	wORqgmcLX/vY6yA925Cwv7msfL0gAgttcRETLi4RD5nbGgXXlh05Tis0CgYKR3TE6vWamNihL+a
	L/XdGMzLDsFIZRP8r3hIU2toAsFVRuh8=
X-Received: by 2002:a17:902:db01:b0:2ba:76ff:57a6 with SMTP id
 d9443c01a7336-2babc858f46mr82569455ad.4.1778269769746; Fri, 08 May 2026
 12:49:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260425215734.14116-1-lkml@antheas.dev>
 <20260425215734.14116-3-lkml@antheas.dev>
 <CAJZ5v0jXccTBZOkzSMv38aMP7H5S5sR8viAoffqqHuENx1pGWQ@mail.gmail.com>
In-Reply-To: 
 <CAJZ5v0jXccTBZOkzSMv38aMP7H5S5sR8viAoffqqHuENx1pGWQ@mail.gmail.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Fri, 8 May 2026 21:49:17 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwHs3m7TA5MpzhQoTkPJ6zE7PxXhmoQ9+cOULPeZ9+jZBA@mail.gmail.com>
X-Gm-Features: AVHnY4L8GlPwiLRrUS2R25uRQGrKRhUu5uYU2DXu2Z9cJWLTCbIK-5-_DdHHeF0
Message-ID: 
 <CAGwozwHs3m7TA5MpzhQoTkPJ6zE7PxXhmoQ9+cOULPeZ9+jZBA@mail.gmail.com>
Subject: Re: [RFC v2 02/10] acpi/x86: s2idle: Move Modern Standby calls to
 s2idle begin/end
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: dmitry.osipenko@collabora.com, bob.beckett@collabora.com,
	bookeldor@gmail.com, hadess@hadess.net, kernel@collabora.com,
	lennart@poettering.net, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, mccann@jhu.edu, richard@hughsie.com,
	sebastian.reichel@collabora.com, superm1@kernel.org,
	systemd-devel@lists.freedesktop.org, xaver.hugl@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-PPP-Message-ID: 
 <177826977154.567302.2833156058456045815@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Fri, 8 May 2026 at 21:25, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Sat, Apr 25, 2026 at 11:57=E2=80=AFPM Antheas Kapenekakis <lkml@anthea=
s.dev> wrote:
> >
> > In Windows, the modern standby calls for sleep entry/exit and display
> > on/off happen while the kernel device subsystems are active and the
> > device is asleep. Currently, in the Linux kernel they happen in
> > prepare_late, after e.g. the USB subsystem has turned off. This
> > disimilarity causes obscure issues in certain devices that use these
> > calls to turn off peripherals that should not be active during modern
> > standby, e.g. handheld controllers, and RGB.
> >
> > Therefore, move these calls to _begin(), and _end() to match Windows.
> > Particularly for _end(), introduce a acpi_s2idle_end_lps0() function to
> > wrap acpi_s2idle_end(), matching the structure introduced with
> > acpi_s2idle_begin_lps0().
> >
> > Of note is that unlike the ACPI ABI of LPS0, there is no device power
> > state requirement before entering sleep/screen off, therefore it is
> > appropriate to move these calls to _begin(), before s2idle suspend.
> >
> > Link: https://learn.microsoft.com/en-us/windows-hardware/design/device-=
experiences/modern-standby-states
> > Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> > ---
> >  drivers/acpi/x86/s2idle.c | 63 +++++++++++++++++++++++----------------
> >  1 file changed, 37 insertions(+), 26 deletions(-)
> >
> > diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
> > index 61a044b59776..f5aefba8b191 100644
> > --- a/drivers/acpi/x86/s2idle.c
> > +++ b/drivers/acpi/x86/s2idle.c
> > @@ -517,8 +517,10 @@ static struct acpi_scan_handler lps0_handler =3D {
> >
> >  static int acpi_s2idle_begin_lps0(void)
> >  {
> > -       if (lps0_device_handle && !sleep_no_lps0 && check_lps0_constrai=
nts &&
> > -           !lpi_constraints_table) {
> > +       if (!lps0_device_handle || sleep_no_lps0)
> > +               return acpi_s2idle_begin();
> > +
> > +       if (check_lps0_constraints && !lpi_constraints_table) {
> >                 if (acpi_s2idle_vendor_amd())
> >                         lpi_device_get_constraints_amd();
> >                 else
> > @@ -532,6 +534,24 @@ static int acpi_s2idle_begin_lps0(void)
> >                         lpi_constraints_table =3D ERR_PTR(-ENODATA);
> >         }
> >
> > +       /* Display off */
> > +       if (lps0_dsm_func_mask > 0)
> > +               acpi_sleep_run_lps0_dsm(acpi_s2idle_vendor_amd() ?
> > +                                       ACPI_LPS0_DISPLAY_OFF_AMD :
> > +                                       ACPI_LPS0_DISPLAY_OFF,
> > +                                       lps0_dsm_func_mask, lps0_dsm_gu=
id);
> > +
> > +       if (lps0_dsm_func_mask_microsoft > 0)
> > +               acpi_sleep_run_lps0_dsm(ACPI_LPS0_DISPLAY_OFF,
> > +                                       lps0_dsm_func_mask_microsoft,
> > +                                       lps0_dsm_guid_microsoft);
> > +
> > +       /* Modern Standby entry */
> > +       if (lps0_dsm_func_mask_microsoft > 0)
> > +               acpi_sleep_run_lps0_dsm(ACPI_LPS0_SLEEP_ENTRY,
> > +                                       lps0_dsm_func_mask_microsoft,
> > +                                       lps0_dsm_guid_microsoft);
>
> This is almost certainly too early at least for some systems out there.
>
> While I can agree with putting ACPI_LPS0_DISPLAY_OFF here, I don't
> quite agree with the other one.

Can you expand? I am not aware of any such systems and the
specification does not require that any subsystem be powered off prior
to the notification. In the contrary, since some systems use the call
to power off their USB gamepad, this suggests that the USB system is
active during the call in Windows, where in Linux it has already been
put to D3 under current kernels

We deployed a prior variant of this series to around ~60k devices and
found no issue.

Best,
Antheas

> > +
> >         return acpi_s2idle_begin();
> >  }
> >
> > @@ -545,36 +565,17 @@ static int acpi_s2idle_prepare_late_lps0(void)
> >         if (check_lps0_constraints)
> >                 lpi_check_constraints();
> >
> > -       /* Display off */
> > +       /* LPS0 entry */
> >         if (lps0_dsm_func_mask > 0)
> >                 acpi_sleep_run_lps0_dsm(acpi_s2idle_vendor_amd() ?
> > -                                       ACPI_LPS0_DISPLAY_OFF_AMD :
> > -                                       ACPI_LPS0_DISPLAY_OFF,
> > +                                               ACPI_LPS0_ENTRY_AMD :
> > +                                               ACPI_LPS0_ENTRY,
> >                                         lps0_dsm_func_mask, lps0_dsm_gu=
id);
> >
> >         if (lps0_dsm_func_mask_microsoft > 0)
> > -               acpi_sleep_run_lps0_dsm(ACPI_LPS0_DISPLAY_OFF,
> > -                                       lps0_dsm_func_mask_microsoft,
> > -                                       lps0_dsm_guid_microsoft);
> > -
> > -       /* LPS0 entry */
> > -       if (lps0_dsm_func_mask > 0 && acpi_s2idle_vendor_amd())
> > -               acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY_AMD,
> > -                                       lps0_dsm_func_mask, lps0_dsm_gu=
id);
> > -
> > -       if (lps0_dsm_func_mask_microsoft > 0) {
> > -               /* Modern Standby entry */
> > -               acpi_sleep_run_lps0_dsm(ACPI_LPS0_SLEEP_ENTRY,
> > -                                       lps0_dsm_func_mask_microsoft,
> > -                                       lps0_dsm_guid_microsoft);
> >                 acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY,
> >                                         lps0_dsm_func_mask_microsoft,
> >                                         lps0_dsm_guid_microsoft);
> > -       }
> > -
> > -       if (lps0_dsm_func_mask > 0 && !acpi_s2idle_vendor_amd())
> > -               acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY,
> > -                                       lps0_dsm_func_mask, lps0_dsm_gu=
id);
> >
> >         list_for_each_entry(handler, &lps0_s2idle_devops_head, list_nod=
e) {
> >                 if (handler->prepare)
> > @@ -615,9 +616,19 @@ static void acpi_s2idle_restore_early_lps0(void)
> >                                         ACPI_LPS0_EXIT,
> >                                         lps0_dsm_func_mask, lps0_dsm_gu=
id);
> >
> > -       if (lps0_dsm_func_mask_microsoft > 0) {
> > +       if (lps0_dsm_func_mask_microsoft > 0)
> >                 acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT,
> >                                 lps0_dsm_func_mask_microsoft, lps0_dsm_=
guid_microsoft);
> > +}
> > +
> > +static void acpi_s2idle_end_lps0(void)
> > +{
> > +       acpi_s2idle_end();
> > +
> > +       if (!lps0_device_handle || sleep_no_lps0)
> > +               return;
> > +
> > +       if (lps0_dsm_func_mask_microsoft > 0) {
> >                 /* Intent to turn on display */
> >                 acpi_sleep_run_lps0_dsm(ACPI_LPS0_TURN_ON_DISPLAY,
> >                                         lps0_dsm_func_mask_microsoft,
> > @@ -648,7 +659,7 @@ static const struct platform_s2idle_ops acpi_s2idle=
_ops_lps0 =3D {
> >         .wake =3D acpi_s2idle_wake,
> >         .restore_early =3D acpi_s2idle_restore_early_lps0,
> >         .restore =3D acpi_s2idle_restore,
> > -       .end =3D acpi_s2idle_end,
> > +       .end =3D acpi_s2idle_end_lps0,
> >  };
> >
> >  void __init acpi_s2idle_setup(void)
> > --
>

