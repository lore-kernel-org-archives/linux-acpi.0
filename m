Received: from relay14.grserver.gr (relay14.grserver.gr [157.180.73.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B5422D792
	for <linux-acpi@vger.kernel.org>; Mon, 16 Mar 2026 20:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.180.73.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773691286; cv=none; b=l8T1K/8+B9jzsg0aXuF2pQqTapa/7H1KulT0Nf9oAyKL8D/OQknE115ZovRdH3LcUq8hFLv16EVHlWe98Y8QaB6ugzdVwC5/BZGHGv7NJdNfbDoWSYzJXyxUAg8eLbHyyh4/W47kodM79kbwb/21xVJu3e/OspmgDKsoXiF7XOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773691286; c=relaxed/simple;
	bh=TWxd1ygPiD7JZpBdR/umANEYsRkJVz36tSHX5qfVkyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MMlEaY0yqcnquG7GWSF0SSMLVPCE1ivIDy3js7oEHn2bJsfJbE1SYbvqNM5ZYkHpxZCY76iHVHMFbB760Lzl48dAzyG7PukMnL2aYOD3lyL0Ohbn5JyuOWBfyCWMrVkDCWBPt3l9DZT2BTSIdcXITnYVsT56100rEmbiyJ/bdN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=J+MXdZJX; arc=none smtp.client-ip=157.180.73.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="J+MXdZJX"
Received: from relay14 (localhost [127.0.0.1])
	by relay14.grserver.gr (Proxmox) with ESMTP id C04F4409C8
	for <linux-acpi@vger.kernel.org>; Mon, 16 Mar 2026 20:01:23 +0000 (UTC)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay14.grserver.gr (Proxmox) with ESMTPS id D59F24077A
	for <linux-acpi@vger.kernel.org>; Mon, 16 Mar 2026 20:01:22 +0000 (UTC)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 0DC2A1FDACD
	for <linux-acpi@vger.kernel.org>; Mon, 16 Mar 2026 22:01:22 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1773691282;
	bh=IMHG5OEpqvm3B8552RXXvuRdrvKNQcB6yxv3LH3Azpw=;
	h=Received:From:Subject:To;
	b=J+MXdZJX4mYUrYuBViIMEPoVw0ydHMoovfbcZYs/9BnVXOptmyYrR5aJ3pBL9LcfD
	 eobjVo5xYB3UQAcU53ToUqH5rL5zdqO/ZUTbGcV1U3wE48vlgcWbEcI22lYtQ0dWLP
	 6ceykYaVBCHAgyGiQfqOIc8fpE2aOGaHZtqu/ax9sBA6fi9LDjq6Lj/VTcjJVCvn+Y
	 XtoRUjvCB7UL0F6+xz9fCacjpKtVOlTVY7riXaTTV+9adIhdLPRA0Jk8tB12qELKBI
	 L1nxjAb+alPFne2qFf/NI1u9HrVQfWZkb21SVjV8zsX4L1iRTIV+ef2G02tJzOc0ys
	 MbVx9Lcb6X19Q==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.216.49) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-pj1-f49.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-35a09e0dd63so5472708a91.3
        for <linux-acpi@vger.kernel.org>;
 Mon, 16 Mar 2026 13:01:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCUNPg+HWgeIkbRdbiqdDfKnsfT2ENAvjBPI1Vrq9QREEBDjKXX0tfKmaNKMrq4K12V6TNpXqCwAE/fC@vger.kernel.org
X-Gm-Message-State: AOJu0YyhnCEQwHpm6XQ1pDZiNTVmLojU9Yn1veFhyYtZ6VKLylVQcb20
	OAJK9SGSE15vspVRCUw0C8MogORuXQX+KOygAprgofeseBLJaeTI6uSOJFt1VVPNvl09F4yl+bn
	NXAaV1I0yTHqmOee3Bv1omXFni49T7EA=
X-Received: by 2002:a17:90b:314e:b0:35b:977f:f843 with SMTP id
 98e67ed59e1d1-35b977ffc49mr5644603a91.33.1773691280903; Mon, 16 Mar 2026
 13:01:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251226102656.6296-1-lkml@antheas.dev>
 <20251226102656.6296-3-lkml@antheas.dev>
 <CAJZ5v0hnP1cJqGN9gLyAgtz5pmRO0xsF6O8ZtnQ+ktRjSSOkyA@mail.gmail.com>
In-Reply-To: 
 <CAJZ5v0hnP1cJqGN9gLyAgtz5pmRO0xsF6O8ZtnQ+ktRjSSOkyA@mail.gmail.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Mon, 16 Mar 2026 21:01:09 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwE_QbiNk53+kTjwELtWhK31LCrBm5fgx2b46sZa_5wjaA@mail.gmail.com>
X-Gm-Features: AaiRm518a8b_PmPk7Kp1PQAXKs4Y7jn0iCjvXOpTX0L5eWISmTVIjV6VOcE_IJM
Message-ID: 
 <CAGwozwE_QbiNk53+kTjwELtWhK31LCrBm5fgx2b46sZa_5wjaA@mail.gmail.com>
Subject: Re: [RFC v1 2/8] acpi/x86: s2idle: Rename LPS0 constants so they
 mirror their function
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: dmitry.osipenko@collabora.com, bob.beckett@collabora.com,
	bookeldor@gmail.com, hadess@hadess.net, jaap@haitsma.org,
	kernel@collabora.com, lennart@poettering.net, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, mccann@jhu.edu, richard@hughsie.com,
	sebastian.reichel@collabora.com, superm1@kernel.org,
	systemd-devel@lists.freedesktop.org, xaver.hugl@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-PPP-Message-ID: 
 <177369128230.3206168.8496588666833579478@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Fri, 13 Mar 2026 at 21:13, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Fri, Dec 26, 2025 at 11:27=E2=80=AFAM Antheas Kapenekakis <lkml@anthea=
s.dev> wrote:
> >
> > The LPS0 3/4 constants are part of a firmware notification called
> > "Display on/off", in which the device enters a "Screen Off" state.
> > The LPS0 7/8 constants are part of a firmware notification in which
> > a Windows modern standby computer enters a "sleep" state where the
> > CPU may still be active and maintain the radios.
> >
> > However, currently, the values are named as "Screen on/off"
>
> This is based on the Intel documentation:
> https://uefi.org/sites/default/files/resources/Intel_ACPI_Low_Power_S0_Id=
le.pdf

The intel document affirms the rename, the state is referred to as
"Screen Off" with the callbacks being named "Display On/Off".

> > and "MS entry/exit", where Modern Standby is abbreviated as "MS". There=
fore,
> > perform a minor rename so that the values match their function.
>
> I'm not sure about the first two at least.

Sleep DSMs are a bit more complicated. They are only defined in the
Microsoft UUID. However, the Windows suspend flow uses both DSM sets
distinctly. LPS0 entry/exit are used the same way in the Microsoft
UUID. The MS_ pair is used for an intermediary sleep state where the
CPU is still active. As the MS_ prefix causes confusion, I would tend
towards keeping this patch.

> > Then, fix the debug message to say that it executes notifications inste=
ad of
> > entering states as it is otherwise confusing.
> >
> > Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> > ---
> >  drivers/acpi/x86/s2idle.c | 54 +++++++++++++++++++--------------------
> >  1 file changed, 27 insertions(+), 27 deletions(-)
> >
> > diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
> > index 6d4d06236f61..1f13c8b0ef83 100644
> > --- a/drivers/acpi/x86/s2idle.c
> > +++ b/drivers/acpi/x86/s2idle.c
> > @@ -39,19 +39,19 @@ static const struct acpi_device_id lps0_device_ids[=
] =3D {
> >  #define ACPI_LPS0_DSM_UUID     "c4eb40a0-6cd2-11e2-bcfd-0800200c9a66"
> >
> >  #define ACPI_LPS0_GET_DEVICE_CONSTRAINTS       1
> > -#define ACPI_LPS0_SCREEN_OFF   3
> > -#define ACPI_LPS0_SCREEN_ON    4
> > +#define ACPI_LPS0_DISPLAY_OFF  3
> > +#define ACPI_LPS0_DISPLAY_ON   4
> >  #define ACPI_LPS0_ENTRY                5
> >  #define ACPI_LPS0_EXIT         6
> > -#define ACPI_LPS0_MS_ENTRY      7
> > -#define ACPI_LPS0_MS_EXIT       8
> > +#define ACPI_LPS0_SLEEP_ENTRY  7
> > +#define ACPI_LPS0_SLEEP_EXIT   8
>
> These two renames are fine with me, although I'm not sure if they are
> worth the hassle.

As you mentioned, sleep is reserved, but as this is the canonical name
in internal code (much like display/screen that will not be exposed in
the ABI) it should be appropriate to keep here.

> >
> >  /* AMD */
> >  #define ACPI_LPS0_DSM_UUID_AMD      "e3f32452-febc-43ce-9039-932122d37=
721"
> >  #define ACPI_LPS0_ENTRY_AMD         2
> >  #define ACPI_LPS0_EXIT_AMD          3
> > -#define ACPI_LPS0_SCREEN_OFF_AMD    4
> > -#define ACPI_LPS0_SCREEN_ON_AMD     5
> > +#define ACPI_LPS0_DISPLAY_OFF_AMD   4
> > +#define ACPI_LPS0_DISPLAY_ON_AMD    5
> >
> >  static acpi_handle lps0_device_handle;
> >  static guid_t lps0_dsm_guid;
> > @@ -340,25 +340,25 @@ static const char *acpi_sleep_dsm_state_to_str(un=
signed int state)
> >  {
> >         if (lps0_dsm_func_mask_microsoft || !acpi_s2idle_vendor_amd()) =
{
> >                 switch (state) {
> > -               case ACPI_LPS0_SCREEN_OFF:
> > -                       return "screen off";
> > -               case ACPI_LPS0_SCREEN_ON:
> > -                       return "screen on";
> > +               case ACPI_LPS0_DISPLAY_OFF:
> > +                       return "display off";
> > +               case ACPI_LPS0_DISPLAY_ON:
> > +                       return "display on";
> >                 case ACPI_LPS0_ENTRY:
> >                         return "lps0 entry";
> >                 case ACPI_LPS0_EXIT:
> >                         return "lps0 exit";
> > -               case ACPI_LPS0_MS_ENTRY:
> > -                       return "lps0 ms entry";
> > -               case ACPI_LPS0_MS_EXIT:
> > -                       return "lps0 ms exit";
> > +               case ACPI_LPS0_SLEEP_ENTRY:
> > +                       return "sleep entry";
> > +               case ACPI_LPS0_SLEEP_EXIT:
> > +                       return "sleep exit";
> >                 }
> >         } else {
> >                 switch (state) {
> > -               case ACPI_LPS0_SCREEN_ON_AMD:
> > -                       return "screen on";
> > -               case ACPI_LPS0_SCREEN_OFF_AMD:
> > -                       return "screen off";
> > +               case ACPI_LPS0_DISPLAY_ON_AMD:
> > +                       return "display on";
> > +               case ACPI_LPS0_DISPLAY_OFF_AMD:
> > +                       return "display off";
> >                 case ACPI_LPS0_ENTRY_AMD:
> >                         return "lps0 entry";
> >                 case ACPI_LPS0_EXIT_AMD:
> > @@ -383,7 +383,7 @@ static void acpi_sleep_run_lps0_dsm(unsigned int fu=
nc, unsigned int func_mask, g
> >         lps0_dsm_state =3D func;
> >         if (pm_debug_messages_on) {
> >                 acpi_handle_info(lps0_device_handle,
> > -                               "%s transitioned to state %s\n",
> > +                               "%s executed notification %s\n",
> >                                  out_obj ? "Successfully" : "Failed to"=
,
> >                                  acpi_sleep_dsm_state_to_str(lps0_dsm_s=
tate));
> >         }
> > @@ -545,12 +545,12 @@ static int acpi_s2idle_prepare_late_lps0(void)
> >         /* Screen off */
> >         if (lps0_dsm_func_mask > 0)
> >                 acpi_sleep_run_lps0_dsm(acpi_s2idle_vendor_amd() ?
> > -                                       ACPI_LPS0_SCREEN_OFF_AMD :
> > -                                       ACPI_LPS0_SCREEN_OFF,
> > +                                       ACPI_LPS0_DISPLAY_OFF_AMD :
> > +                                       ACPI_LPS0_DISPLAY_OFF,
> >                                         lps0_dsm_func_mask, lps0_dsm_gu=
id);
> >
> >         if (lps0_dsm_func_mask_microsoft > 0)
> > -               acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF,
> > +               acpi_sleep_run_lps0_dsm(ACPI_LPS0_DISPLAY_OFF,
> >                                 lps0_dsm_func_mask_microsoft, lps0_dsm_=
guid_microsoft);
> >
> >         /* LPS0 entry */
> > @@ -560,7 +560,7 @@ static int acpi_s2idle_prepare_late_lps0(void)
> >
> >         if (lps0_dsm_func_mask_microsoft > 0) {
> >                 /* Modern Standby entry */
> > -               acpi_sleep_run_lps0_dsm(ACPI_LPS0_MS_ENTRY,
> > +               acpi_sleep_run_lps0_dsm(ACPI_LPS0_SLEEP_ENTRY,
> >                                 lps0_dsm_func_mask_microsoft, lps0_dsm_=
guid_microsoft);
> >                 acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY,
> >                                 lps0_dsm_func_mask_microsoft, lps0_dsm_=
guid_microsoft);
> > @@ -613,18 +613,18 @@ static void acpi_s2idle_restore_early_lps0(void)
> >                 acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT,
> >                                 lps0_dsm_func_mask_microsoft, lps0_dsm_=
guid_microsoft);
> >                 /* Modern Standby exit */
> > -               acpi_sleep_run_lps0_dsm(ACPI_LPS0_MS_EXIT,
> > +               acpi_sleep_run_lps0_dsm(ACPI_LPS0_SLEEP_EXIT,
> >                                 lps0_dsm_func_mask_microsoft, lps0_dsm_=
guid_microsoft);
> >         }
> >
> >         /* Screen on */
> >         if (lps0_dsm_func_mask_microsoft > 0)
> > -               acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_ON,
> > +               acpi_sleep_run_lps0_dsm(ACPI_LPS0_DISPLAY_ON,
> >                                 lps0_dsm_func_mask_microsoft, lps0_dsm_=
guid_microsoft);
> >         if (lps0_dsm_func_mask > 0)
> >                 acpi_sleep_run_lps0_dsm(acpi_s2idle_vendor_amd() ?
> > -                                       ACPI_LPS0_SCREEN_ON_AMD :
> > -                                       ACPI_LPS0_SCREEN_ON,
> > +                                       ACPI_LPS0_DISPLAY_ON_AMD :
> > +                                       ACPI_LPS0_DISPLAY_ON,
> >                                         lps0_dsm_func_mask, lps0_dsm_gu=
id);
> >  }
> >
> > --
> > 2.52.0
> >
> >
> >
>

