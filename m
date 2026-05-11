Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC76425CC3;
	Mon, 11 May 2026 16:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778516219; cv=none; b=YLMSQR8c5rNW6Ac9i8yuAD9tZ7gjatZCr2S3zhPC4QYMcXE/7JTmbBBnz2Vo6EIs1dL5KwW/2+XQW4UEPnFi8V/XUx9WNlsfHUcNqVj9dvCJeU2QXyicpHq6Wng2n6gYPVGv41enQQAwUK5ZuUV7pWbXLUpiwse2R2zsY+wcVMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778516219; c=relaxed/simple;
	bh=5sS315e2A6L/O39wqZk8NO8bHnc3DdC7Ys+QKAQJStI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=VwlO4SmmB84Z3jC97SKolDPcuF14BEhMDS1Tya21kI0MvItpyuUr6vU1lOm5vSYUFb7b8eNpbP+UnesBSBe+oIQ+SODk+3ICd4cH8Ab2K1WHbMciBgjaeMmLMxrkhtwn3NmdQnf99yx0PG4Xbi9N0xwOXFyGAjITE4XrBfKeqGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AetnFqVn; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AetnFqVn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778516218; x=1810052218;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=5sS315e2A6L/O39wqZk8NO8bHnc3DdC7Ys+QKAQJStI=;
  b=AetnFqVnZcPxRTO9iWjEo89PvCiOJoIdvH82DDiqrj9km8Sb/9HkVi+r
   fd7hn8OSIqJ8EgR7IuLhLl40HVrhpMkdVKhPAL49VZNnf/jHgILWl8No6
   jdK3F69A5Olz9sC1aZWZBYha5yV5qlo/SUVVGyENlidW0McEfl3Z/Cxp5
   o7m8wKLDLNMJ8lNmQsyJVwA+6STkgncabKYQlV2yB420HmAsNTfaj0bc0
   7mvfeYNtcjhzq2y8WG7y0/WE2cdUDdtV61BPdBxjj+6x+YKToiaAfaSNg
   WXuXaLDorAa1xHH3s89FWrNfeh/J9ZPzMNz63YcE58flFD6bvH6wOaKu0
   Q==;
X-CSE-ConnectionGUID: T5aJarAJSkGLBb55AXqIQA==
X-CSE-MsgGUID: O2HM2Te9RceEX9DXCtYbpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="66940305"
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="66940305"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 09:13:17 -0700
X-CSE-ConnectionGUID: Bj3ea8EQTEuNZhoApMBRMw==
X-CSE-MsgGUID: 3eezALfzTb26Kewhi9Bveg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="233013276"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.28])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 09:13:15 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 11 May 2026 19:13:11 +0300 (EEST)
To: "Rafael J. Wysocki" <rafael@kernel.org>
cc: LKML <linux-kernel@vger.kernel.org>, 
    Linux ACPI <linux-acpi@vger.kernel.org>, Hans de Goede <hansg@kernel.org>, 
    platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v1 3/4] platform/x86: xo15-ebook: Register ACPI notify
 handler directly
In-Reply-To: <CAJZ5v0i5u4uq7v52oWYNt_tXwJAcpuXVS21y6PKU54XY7y=ciA@mail.gmail.com>
Message-ID: <db0875af-5b2f-b710-43ff-ec1b9922ec27@linux.intel.com>
References: <2420444.ElGaqSPkdT@rafael.j.wysocki> <3420768.aeNJFYEL58@rafael.j.wysocki> <e46d3374-4762-3776-6195-bd6220998b5e@linux.intel.com> <CAJZ5v0i5u4uq7v52oWYNt_tXwJAcpuXVS21y6PKU54XY7y=ciA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1896914216-1778515991=:981"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1896914216-1778515991=:981
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 11 May 2026, Rafael J. Wysocki wrote:

> On Mon, May 11, 2026 at 3:59=E2=80=AFPM Ilpo J=C3=A4rvinen
> <ilpo.jarvinen@linux.intel.com> wrote:
> >
> > On Fri, 8 May 2026, Rafael J. Wysocki wrote:
> >
> > > From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> > >
> > > To facilitate subsequent conversion of the driver to a platform one,
> > > make it install an ACPI notify handler directly instead of using
> > > a .notify() callback in struct acpi_driver.
> > >
> > > No intentional functional impact.
> > >
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > ---
> > >  drivers/platform/x86/xo15-ebook.c | 19 ++++++++++++++-----
> > >  1 file changed, 14 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/platform/x86/xo15-ebook.c b/drivers/platform/x86=
/xo15-ebook.c
> > > index 616f4bb3461a..8af1b9078db8 100644
> > > --- a/drivers/platform/x86/xo15-ebook.c
> > > +++ b/drivers/platform/x86/xo15-ebook.c
> > > @@ -57,16 +57,15 @@ static int ebook_send_state(struct acpi_device *d=
evice)
> > >       return 0;
> > >  }
> > >
> > > -static void ebook_switch_notify(struct acpi_device *device, u32 even=
t)
> > > +static void ebook_switch_notify(acpi_handle handle, u32 event, void =
*data)
> > >  {
> > >       switch (event) {
> > >       case ACPI_FIXED_HARDWARE_EVENT:
> > >       case XO15_EBOOK_NOTIFY_STATUS:
> > > -             ebook_send_state(device);
> > > +             ebook_send_state(data);
> > >               break;
> > >       default:
> > > -             acpi_handle_debug(device->handle,
> > > -                               "Unsupported event [0x%x]\n", event);
> > > +             acpi_handle_debug(handle, "Unsupported event [0x%x]\n",=
 event);
> > >               break;
> > >       }
> > >  }
> > > @@ -123,6 +122,11 @@ static int ebook_switch_add(struct acpi_device *=
device)
> > >       if (error)
> > >               goto err_free_input;
> > >
> > > +     error =3D acpi_dev_install_notify_handler(device, ACPI_DEVICE_N=
OTIFY,
> > > +                                             ebook_switch_notify, de=
vice);
> > > +     if (error)
> > > +             goto err_unregister_input;
> > > +
> > >       ebook_send_state(device);
> > >
> > >       if (device->wakeup.flags.valid) {
> > > @@ -139,6 +143,10 @@ static int ebook_switch_add(struct acpi_device *=
device)
> > >  err_free_button:
> > >       kfree(button);
> > >       return error;
> > > +
> > > +err_unregister_input:
> > > +     input_unregister_device(input);
> > > +     goto err_free_button;
> >
> > The end result would be much simpler if there would be patch 5 to conve=
rt
> > to devm_*().
>=20
> Well, I can add one.
>=20
> Do you want me to resend an update of the series for this?

Ah, right. I took these now to review-ilpo-next.

(I was initially thinking of making a little bit different suggestion=20
which would have required changes to these patches but then realized it=20
was better to just add the devm_*() conversion after these).

--=20
 i.

--8323328-1896914216-1778515991=:981--
