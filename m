Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE752D063A;
	Tue, 17 Mar 2026 15:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773763020; cv=none; b=t4vgPBwb8uuvtGlx588+Wn56QQHEYpliXK4OtZbTnxLcEKKgSpqCDf1uGI00pieyqzgGJhWUc5YWydKtvYG+XtDHAPUQOcxxGuuLZEhE4MIASaMRpin9hu/ijzg4gWYbFVUs+6l+h0JVZOa6MgqswMmmNkB/g0VGqlgtjIVKkp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773763020; c=relaxed/simple;
	bh=l3aen0shIsMMSxofK0sSFZ9ORdFXn6ThSmBBoz/oF34=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=FjmaaUfABT9VsCK8Zi7s4+qjSkLyal8iP2JzxKYsAklNENLnxZPPVXlLcbsaqDP7Xsp1MPH0RnKRHA9Y8cToEVVp3SNKFgxQS1RoCNWOorgMPIIJnBV0qZ6fQkBA9ucvl8zSrahJ9/dPjB8Q9Piew3htzV8fMtjNKbt0y3YY4W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B5agLADx; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B5agLADx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773763019; x=1805299019;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=l3aen0shIsMMSxofK0sSFZ9ORdFXn6ThSmBBoz/oF34=;
  b=B5agLADx3Tvnq4hWUF4cGIl3FF1ttUAQ7rlF7QQ2zB2faJnp10C+bfrT
   lMUpcPb6qmB/fGyEpv5h7P1W0YLp7R+Yf6hJqWhC1qO/6FFwXtRWBJgM2
   FBAfJxB4ET76slODnvU1VT047Pfov4My00UOmV6DUAWecmWlSSvfLxxN1
   lPS8yD+1ZhcBrRUZ7IXyNXccRU5eQN4jU/zxXY6vLEYGf69g2P1KYS24b
   fwUTAXkmTscI0+UDLcRE5UZpWQ1t3QcRhJau27eWgkCZyV8wodakaxgVv
   Yd+F9LF8rgvgwvzooDEuClkhYNQWMRlYdU/KFeKFVASGS7hUrEMFNMfF0
   g==;
X-CSE-ConnectionGUID: kSb5jZD1SnuA7pUeIHN5ag==
X-CSE-MsgGUID: Lu3O1IcXS/WTsrzTt/adPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="62365203"
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="62365203"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 08:56:39 -0700
X-CSE-ConnectionGUID: 1NuqkNMZSeWVOFzn2CnpRA==
X-CSE-MsgGUID: LJ1DcEEsTV2AniJhX/4zDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="260213755"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.161])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 08:56:34 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 17 Mar 2026 17:56:31 +0200 (EET)
To: "Rafael J. Wysocki" <rafael@kernel.org>
cc: Robert Gerlach <khnz@gmx.de>, Hans de Goede <hansg@kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>, 
    Linux ACPI <linux-acpi@vger.kernel.org>, 
    platform-driver-x86@vger.kernel.org, Jonathan Woithe <jwoithe@just42.net>
Subject: Re: [PATCH v2 3/5] platform/x86: fujitsu: Register ACPI notify
 handlers directly
In-Reply-To: <CAJZ5v0g1M_rooYSYvFN4Chq-NovvS=gc5dhdw_BRvd-1S_tVVg@mail.gmail.com>
Message-ID: <2c1378d5-7dce-2d22-6013-53e4b027d41c@linux.intel.com>
References: <12863082.O9o76ZdvQC@rafael.j.wysocki> <1961003.tdWV9SEqCh@rafael.j.wysocki> <6768d6a8-3ab5-f4c8-7e77-229fd8135f53@linux.intel.com> <CAJZ5v0g1M_rooYSYvFN4Chq-NovvS=gc5dhdw_BRvd-1S_tVVg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-357418628-1773762991=:968"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-357418628-1773762991=:968
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 17 Mar 2026, Rafael J. Wysocki wrote:

> On Tue, Mar 17, 2026 at 4:19=E2=80=AFPM Ilpo J=C3=A4rvinen
> <ilpo.jarvinen@linux.intel.com> wrote:
> >
> > On Mon, 9 Mar 2026, Rafael J. Wysocki wrote:
> >
> > > From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> > >
> > > To facilitate subsequent conversion of the driver to using struct
> > > platform_driver instead of struct acpi_driver, make it install its AC=
PI
> > > notify handlers directly instead of using struct acpi_driver .notify(=
)
> > > callbacks.
> > >
> > > No intentional functional impact.
> > >
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > ---
> > >
> > > v1 -> v2: Call fujitsu_laptop_platform_remove() in acpi_fujitsu_lapto=
p_add()
> > >    error code path if notify handler registration fails (Ilpo)
> >
> > Hmm, did you forget to commit something as I don't see this addressed
> > below?
>=20
> No, I didn't.  It's there, you had a comment on it below even.

Yes, sorry, I forgot I'd already written this (and to remove it), only=20
after having written this I noticed it was done differently than what I=20
had expected.

--=20
 i.


> > > ---
> > >  drivers/platform/x86/fujitsu-laptop.c | 32 ++++++++++++++++++++++---=
--
> > >  1 file changed, 27 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/platform/x86/fujitsu-laptop.c b/drivers/platform=
/x86/fujitsu-laptop.c
> > > index 1adce90ae3e6..7816a867a60c 100644
> > > --- a/drivers/platform/x86/fujitsu-laptop.c
> > > +++ b/drivers/platform/x86/fujitsu-laptop.c
> > > @@ -502,8 +502,9 @@ static int fujitsu_backlight_register(struct acpi=
_device *device)
> > >
> > >  /* Brightness notify */
> > >
> > > -static void acpi_fujitsu_bl_notify(struct acpi_device *device, u32 e=
vent)
> > > +static void acpi_fujitsu_bl_notify(acpi_handle handle, u32 event, vo=
id *data)
> > >  {
> > > +     struct acpi_device *device =3D data;
> > >       struct fujitsu_bl *priv =3D acpi_driver_data(device);
> > >       int oldb, newb;
> > >
> > > @@ -558,7 +559,18 @@ static int acpi_fujitsu_bl_add(struct acpi_devic=
e *device)
> > >       if (ret)
> > >               return ret;
> > >
> > > -     return fujitsu_backlight_register(device);
> > > +     ret =3D fujitsu_backlight_register(device);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     return acpi_dev_install_notify_handler(device, ACPI_DEVICE_NOTI=
FY,
> > > +                                            acpi_fujitsu_bl_notify, =
device);
> > > +}
> > > +
> > > +static void acpi_fujitsu_bl_remove(struct acpi_device *device)
> > > +{
> > > +     acpi_dev_remove_notify_handler(device, ACPI_DEVICE_NOTIFY,
> > > +                                    acpi_fujitsu_bl_notify);
> > >  }
> > >
> > >  /* ACPI device for hotkey handling */
> > > @@ -941,8 +953,9 @@ static void acpi_fujitsu_laptop_release(struct ac=
pi_device *device)
> > >       }
> > >  }
> > >
> > > -static void acpi_fujitsu_laptop_notify(struct acpi_device *device, u=
32 event)
> > > +static void acpi_fujitsu_laptop_notify(acpi_handle handle, u32 event=
, void *data)
> > >  {
> > > +     struct acpi_device *device =3D data;
> > >       struct fujitsu_laptop *priv =3D acpi_driver_data(device);
> > >       unsigned long flags;
> > >       int scancode, i =3D 0;
> > > @@ -1056,6 +1069,13 @@ static int acpi_fujitsu_laptop_add(struct acpi=
_device *device)
> > >       if (ret)
> > >               goto err_free_fifo;
> > >
> > > +     ret =3D acpi_dev_install_notify_handler(device, ACPI_DEVICE_NOT=
IFY,
> > > +                                           acpi_fujitsu_laptop_notif=
y, device);
> > > +     if (ret) {
> > > +             fujitsu_laptop_platform_remove(device);
> >
> > Please add this into the rollback path instead and add another label
> > there.
>=20
> OK
>=20
--8323328-357418628-1773762991=:968--
