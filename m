Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A37407562;
	Mon, 11 May 2026 16:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778517856; cv=none; b=G/tT/PIpQGGnyWGddsIDyiXNY0gmz1vMqwPZtUSlXxdFjZ3rBEVJGMFoGCZPZmgHmbyMPvVwDnqu7v9s7kaxS3Ewe7VpEm7neIZxcYXE1J9Xgk9m5LLdzC8g9ApEEETT+JMezNPbU5Jtj01r0fMOa8mdINXOMbGKs4bggQjW9r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778517856; c=relaxed/simple;
	bh=hZ++uq1f+VahNVpGV/puiTR6jEUR8QMqwpo+A4CUh+Y=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=J7H3St0sVxTsLi4MpTveCueqOmLDLK0LmvbpOlGdOGydmWHJMCUEECnfVCwu8AeXTcPX16CpMT7gAOT9upwDsvWOy3LGd0PQn+VeuaPwpChoRhofMYbJ57Kb3cG+dz20bWPErFd3Z7DKEUh1icCXwo4N8pG0GBCzCeCFnHw7Ggg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=koEpfAJv; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="koEpfAJv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778517853; x=1810053853;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=hZ++uq1f+VahNVpGV/puiTR6jEUR8QMqwpo+A4CUh+Y=;
  b=koEpfAJv/9io13KY97JaPI57j5njYL6xZF3NslXRO3tr7j1MjM7lZe3P
   X/BuDWEhRkZhiI7VFzkTnqyL7d3aPosnvJ3+BMeZkYInKVJqJW1U58n8s
   R99RC8FLosgN+E5jCzJ3aUqv4pvKbeArCKIpa17JSzk6Mu3gCZgzmqv9K
   gSQOYf6tyreb86GjHW4ap4CLuBULDujrNaAIZ+ZSLo+YyDmMpY/m053Ua
   yI1MKcxThMzsJKmaXRFTaJkSvuPTIePktCoMIohIww7SjQGKsj8Frp5gN
   KDH0GwRCOCMFxvrMZbuBKCcggnx2y6/FcYkbvxROG5c0CBq1i7Q92OISu
   A==;
X-CSE-ConnectionGUID: UpMiSJk4RRCo3IYx5CYoHg==
X-CSE-MsgGUID: 03WTzfUqTyC1mFZ6GM70SA==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="79309022"
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="79309022"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 09:44:11 -0700
X-CSE-ConnectionGUID: X6+CMRKKQraanl7f8aEVdA==
X-CSE-MsgGUID: KbqGJRWkS7WzYeZmdX1yNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="234841040"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.28])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 09:44:09 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 11 May 2026 19:44:06 +0300 (EEST)
To: "Rafael J. Wysocki" <rafael@kernel.org>
cc: LKML <linux-kernel@vger.kernel.org>, 
    Linux ACPI <linux-acpi@vger.kernel.org>, Hans de Goede <hansg@kernel.org>, 
    platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v1 3/4] platform/x86: xo15-ebook: Register ACPI notify
 handler directly
In-Reply-To: <CAJZ5v0hAKEiy3JVP4w+wX-P3XxiVddVXt36zqqRdtPLnnmnYnw@mail.gmail.com>
Message-ID: <de73ccd5-15c4-4836-d63e-4bb3138310d7@linux.intel.com>
References: <2420444.ElGaqSPkdT@rafael.j.wysocki> <3420768.aeNJFYEL58@rafael.j.wysocki> <e46d3374-4762-3776-6195-bd6220998b5e@linux.intel.com> <CAJZ5v0i5u4uq7v52oWYNt_tXwJAcpuXVS21y6PKU54XY7y=ciA@mail.gmail.com> <db0875af-5b2f-b710-43ff-ec1b9922ec27@linux.intel.com>
 <CAJZ5v0hAKEiy3JVP4w+wX-P3XxiVddVXt36zqqRdtPLnnmnYnw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2032936054-1778517846=:981"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2032936054-1778517846=:981
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 11 May 2026, Rafael J. Wysocki wrote:

> On Mon, May 11, 2026 at 6:17=E2=80=AFPM Ilpo J=C3=A4rvinen
> <ilpo.jarvinen@linux.intel.com> wrote:
> >
> > On Mon, 11 May 2026, Rafael J. Wysocki wrote:
> >
> > > On Mon, May 11, 2026 at 3:59=E2=80=AFPM Ilpo J=C3=A4rvinen
> > > <ilpo.jarvinen@linux.intel.com> wrote:
> > > >
> > > > On Fri, 8 May 2026, Rafael J. Wysocki wrote:
> > > >
> > > > > From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> > > > >
> > > > > To facilitate subsequent conversion of the driver to a platform o=
ne,
> > > > > make it install an ACPI notify handler directly instead of using
> > > > > a .notify() callback in struct acpi_driver.
> > > > >
> > > > > No intentional functional impact.
> > > > >
> > > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > > ---
> > > > >  drivers/platform/x86/xo15-ebook.c | 19 ++++++++++++++-----
> > > > >  1 file changed, 14 insertions(+), 5 deletions(-)
> > > > >
> > > > > diff --git a/drivers/platform/x86/xo15-ebook.c b/drivers/platform=
/x86/xo15-ebook.c
> > > > > index 616f4bb3461a..8af1b9078db8 100644
> > > > > --- a/drivers/platform/x86/xo15-ebook.c
> > > > > +++ b/drivers/platform/x86/xo15-ebook.c
> > > > > @@ -57,16 +57,15 @@ static int ebook_send_state(struct acpi_devic=
e *device)
> > > > >       return 0;
> > > > >  }
> > > > >
> > > > > -static void ebook_switch_notify(struct acpi_device *device, u32 =
event)
> > > > > +static void ebook_switch_notify(acpi_handle handle, u32 event, v=
oid *data)
> > > > >  {
> > > > >       switch (event) {
> > > > >       case ACPI_FIXED_HARDWARE_EVENT:
> > > > >       case XO15_EBOOK_NOTIFY_STATUS:
> > > > > -             ebook_send_state(device);
> > > > > +             ebook_send_state(data);
> > > > >               break;
> > > > >       default:
> > > > > -             acpi_handle_debug(device->handle,
> > > > > -                               "Unsupported event [0x%x]\n", eve=
nt);
> > > > > +             acpi_handle_debug(handle, "Unsupported event [0x%x]=
\n", event);
> > > > >               break;
> > > > >       }
> > > > >  }
> > > > > @@ -123,6 +122,11 @@ static int ebook_switch_add(struct acpi_devi=
ce *device)
> > > > >       if (error)
> > > > >               goto err_free_input;
> > > > >
> > > > > +     error =3D acpi_dev_install_notify_handler(device, ACPI_DEVI=
CE_NOTIFY,
> > > > > +                                             ebook_switch_notify=
, device);
> > > > > +     if (error)
> > > > > +             goto err_unregister_input;
> > > > > +
> > > > >       ebook_send_state(device);
> > > > >
> > > > >       if (device->wakeup.flags.valid) {
> > > > > @@ -139,6 +143,10 @@ static int ebook_switch_add(struct acpi_devi=
ce *device)
> > > > >  err_free_button:
> > > > >       kfree(button);
> > > > >       return error;
> > > > > +
> > > > > +err_unregister_input:
> > > > > +     input_unregister_device(input);
> > > > > +     goto err_free_button;
> > > >
> > > > The end result would be much simpler if there would be patch 5 to c=
onvert
> > > > to devm_*().
> > >
> > > Well, I can add one.
> > >
> > > Do you want me to resend an update of the series for this?
> >
> > Ah, right. I took these now to review-ilpo-next.
> >
> > (I was initially thinking of making a little bit different suggestion
> > which would have required changes to these patches but then realized it
> > was better to just add the devm_*() conversion after these).
>=20
> So I guess I'll prepare a follow-up patch for the devm_ conversion.
>=20
> Note though that there's no devm_ counterpart of
> acpi_dev_install_notify_handler() ATM, so I may need to add one while
> at it.

While adding it will be able to remove acpi_dev_remove_notify_handler()=20
call from ebook_switch_remove(), there's no such call in rollbacks for=20
ebook_switch_probe() so it wouldn't be strictly required.

But it certainly wouldn't hurt to have one for other drivers.

--=20
 i.

--8323328-2032936054-1778517846=:981--
