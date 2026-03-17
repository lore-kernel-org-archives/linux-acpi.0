Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526DF29D264
	for <linux-acpi@vger.kernel.org>; Tue, 17 Mar 2026 15:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773762746; cv=none; b=OqU52my2j6wOEZg2DkAweYEUKO5+mehFsQTpkNKbnWhzXaQslitANaof3Qi//ETd2S17V74F8YNfBW7rGg2K7CdwoiDk7GQCZyhObpv/HNJB2TglFxlXi0TBzbhSGXnyJl9Jk3afyFzHunhgUwfQJyenxZVCa+23VqfHk0Hbcks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773762746; c=relaxed/simple;
	bh=DQCJEcDFzb2Hskg2Z+OEIUslpvySN6AUvc2IGO+f2Aw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nTnlCrijqnHN9As9CHTiXE30yIXDutsES3Bj+g019RA9uXLpIY613oN4vArgIqJpSAaRvarASt3vdrXODjS3Nz9WCdcn14Y47mtw5K0pUYleOEz0oBG3QXyW7sxPqiMLDQmIxl3w2AvELLcS1siy6HfVb0IqMgIoOQyHzVzC140=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LZqaFq6Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LZqaFq6Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18DFCC2BCB0
	for <linux-acpi@vger.kernel.org>; Tue, 17 Mar 2026 15:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773762746;
	bh=DQCJEcDFzb2Hskg2Z+OEIUslpvySN6AUvc2IGO+f2Aw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LZqaFq6YH+cLIpPB2UPkY7zBWv58i+OcMXASJJGhYwGNfoLzs2e4EDJO9eKLTVWp2
	 sPrr99RTR3Q4lCm9aFIYerT+gWPMBTHxZKOZjaYg/6gSHL5bRSLcny+nBUpZZF94X7
	 34N9IzWC70w1pY5tTyG/Z3r/pXBjWlE9oJv/TlAKuY/bBpTb2K+eAnEOTKv2IdauWd
	 rVAsrnbBfA82OMG+GzEfGgseSDw1rgH5K+7VGX32LgaNM5FsU9DxhwWjiylhWopluU
	 hlFpoUrOtcxYjQ1S9DJmS0VQk6WZ8xCEbyg/Cwejtmu4XvQaj5HC42xgV+NkNXSF6p
	 yiqccqzCKGlKg==
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7d744540081so15117a34.0
        for <linux-acpi@vger.kernel.org>; Tue, 17 Mar 2026 08:52:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUtg7gWV870EPEZcuRDvoSQQDIEoEOwqL5XItzi6gpjcXTpmmY0iBZkTNNiEaEMvFwxbjjDSd7q7KIm@vger.kernel.org
X-Gm-Message-State: AOJu0YwAfUh+95eVrBp6wBc+8FTeumFTczntrG5nf3XIzVP2J1foZrdg
	1fHl2Ck97Sf549VpD3GhdMwQ7ADiagTIdMyTUOQkh7TS80KkoXj5SJSsPvtKC9/AaYxGvIpfmOb
	pJMFlQ2AYRgptSA/fUj734ncYZdrRiW4=
X-Received: by 2002:a05:6820:f02e:b0:67b:f13d:afe8 with SMTP id
 006d021491bc7-67c0d04d9e0mr86167eaf.22.1773762745166; Tue, 17 Mar 2026
 08:52:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12863082.O9o76ZdvQC@rafael.j.wysocki> <1961003.tdWV9SEqCh@rafael.j.wysocki>
 <6768d6a8-3ab5-f4c8-7e77-229fd8135f53@linux.intel.com>
In-Reply-To: <6768d6a8-3ab5-f4c8-7e77-229fd8135f53@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 17 Mar 2026 16:52:14 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0g1M_rooYSYvFN4Chq-NovvS=gc5dhdw_BRvd-1S_tVVg@mail.gmail.com>
X-Gm-Features: AaiRm5256R136KmY0ZvirE7tFy1qg8uIABme8T_63gQebeB8gBG1skfYTElTFlM
Message-ID: <CAJZ5v0g1M_rooYSYvFN4Chq-NovvS=gc5dhdw_BRvd-1S_tVVg@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] platform/x86: fujitsu: Register ACPI notify
 handlers directly
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Robert Gerlach <khnz@gmx.de>, Hans de Goede <hansg@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	platform-driver-x86@vger.kernel.org, Jonathan Woithe <jwoithe@just42.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2026 at 4:19=E2=80=AFPM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Mon, 9 Mar 2026, Rafael J. Wysocki wrote:
>
> > From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> >
> > To facilitate subsequent conversion of the driver to using struct
> > platform_driver instead of struct acpi_driver, make it install its ACPI
> > notify handlers directly instead of using struct acpi_driver .notify()
> > callbacks.
> >
> > No intentional functional impact.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > v1 -> v2: Call fujitsu_laptop_platform_remove() in acpi_fujitsu_laptop_=
add()
> >    error code path if notify handler registration fails (Ilpo)
>
> Hmm, did you forget to commit something as I don't see this addressed
> below?

No, I didn't.  It's there, you had a comment on it below even.

> > ---
> >  drivers/platform/x86/fujitsu-laptop.c | 32 ++++++++++++++++++++++-----
> >  1 file changed, 27 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/platform/x86/fujitsu-laptop.c b/drivers/platform/x=
86/fujitsu-laptop.c
> > index 1adce90ae3e6..7816a867a60c 100644
> > --- a/drivers/platform/x86/fujitsu-laptop.c
> > +++ b/drivers/platform/x86/fujitsu-laptop.c
> > @@ -502,8 +502,9 @@ static int fujitsu_backlight_register(struct acpi_d=
evice *device)
> >
> >  /* Brightness notify */
> >
> > -static void acpi_fujitsu_bl_notify(struct acpi_device *device, u32 eve=
nt)
> > +static void acpi_fujitsu_bl_notify(acpi_handle handle, u32 event, void=
 *data)
> >  {
> > +     struct acpi_device *device =3D data;
> >       struct fujitsu_bl *priv =3D acpi_driver_data(device);
> >       int oldb, newb;
> >
> > @@ -558,7 +559,18 @@ static int acpi_fujitsu_bl_add(struct acpi_device =
*device)
> >       if (ret)
> >               return ret;
> >
> > -     return fujitsu_backlight_register(device);
> > +     ret =3D fujitsu_backlight_register(device);
> > +     if (ret)
> > +             return ret;
> > +
> > +     return acpi_dev_install_notify_handler(device, ACPI_DEVICE_NOTIFY=
,
> > +                                            acpi_fujitsu_bl_notify, de=
vice);
> > +}
> > +
> > +static void acpi_fujitsu_bl_remove(struct acpi_device *device)
> > +{
> > +     acpi_dev_remove_notify_handler(device, ACPI_DEVICE_NOTIFY,
> > +                                    acpi_fujitsu_bl_notify);
> >  }
> >
> >  /* ACPI device for hotkey handling */
> > @@ -941,8 +953,9 @@ static void acpi_fujitsu_laptop_release(struct acpi=
_device *device)
> >       }
> >  }
> >
> > -static void acpi_fujitsu_laptop_notify(struct acpi_device *device, u32=
 event)
> > +static void acpi_fujitsu_laptop_notify(acpi_handle handle, u32 event, =
void *data)
> >  {
> > +     struct acpi_device *device =3D data;
> >       struct fujitsu_laptop *priv =3D acpi_driver_data(device);
> >       unsigned long flags;
> >       int scancode, i =3D 0;
> > @@ -1056,6 +1069,13 @@ static int acpi_fujitsu_laptop_add(struct acpi_d=
evice *device)
> >       if (ret)
> >               goto err_free_fifo;
> >
> > +     ret =3D acpi_dev_install_notify_handler(device, ACPI_DEVICE_NOTIF=
Y,
> > +                                           acpi_fujitsu_laptop_notify,=
 device);
> > +     if (ret) {
> > +             fujitsu_laptop_platform_remove(device);
>
> Please add this into the rollback path instead and add another label
> there.

OK
