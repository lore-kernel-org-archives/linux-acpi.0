Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36FA35DA43
	for <linux-acpi@vger.kernel.org>; Wed, 15 Jul 2026 16:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784133296; cv=none; b=b+qEBFsVa51z5aHAM+fwHy0QQP/68KEadNJOUcgeTep+vWXlYfgmspzqiiSpz8dXlqAQV3CrYwIlayZVRinvPmR0H9SGHS+M8vovEMq0psSj+8uwf4eckF50ERI0ejmIpxlLQIXZ+r6DxD0Ts9RPyozk4WlMyj1CGXo/tsp7fDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784133296; c=relaxed/simple;
	bh=xklFY7jiNfxbOwm2afgigwLDyXAIDQlKwreNetLZm28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mGEA155ai2cheatiVKWt8Lq69fORyOefXbWxqw5SARctjVNVPGl925httRE2yKBniMhjVV905cMd9zXsUyPFuNvuUM0zeHc9DI4QnW/Vx6ohLwrcU0sINa8qm2HDcH9sAxcXBbuyn770j60W3DqcZXVlSyKkLZo6OZDXK1wE8+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d/YcQ+bu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d/YcQ+bu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0D621F00A3D
	for <linux-acpi@vger.kernel.org>; Wed, 15 Jul 2026 16:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784133295;
	bh=aUR6TK12zOwCpmFN2mBE5VaKFv6paOL9Pd091+0pRI0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=d/YcQ+bu7P0gomP52oEFaFLOTjrRwM61otTaaPh9EhLtrOtwGqsz5TinXOBXSRnMf
	 Ev2M/63PiRyyJC1+xaoY22/MufwHffw/2giRmBTyDk5QB9q4voEEo1xOWB84/g8GiF
	 UesbEkpGRb6dysXtff5w9D0lYOcbdO6OPqCx0EBvfHkwbnMERtfPkqZwPHh3J5ulid
	 m/cutH9StehdEaXxItDF6abZUj7dxEpqolcRrm7ON/n7JkuBwUrBJ59AfzWax7PpIQ
	 xk8QjjVxAuVV8y3ACvpFOJmS8noDeWg+f6wzCi0/2X1vYn8dm4BHz4PahJC4UGlq+M
	 aLCv3sXJ9kLog==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5aec139da7eso2312865e87.1
        for <linux-acpi@vger.kernel.org>; Wed, 15 Jul 2026 09:34:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rqsfw8VM7C+WSe6B1UFTwfArhjGzXHJo1FMZXvPT70Ziy9se9ZC7HncR+jmaETImIYvNGQlKB2GlKOk@vger.kernel.org
X-Gm-Message-State: AOJu0YzvOoe33bIdCXlwRPC7D31HKJ4tPirSHkENN4cW5f9fGYes5phy
	neaeZpx3Qi4iURgIyOPGEaVvQM+/rsABpXeskJ5nbZkywKzcGhTSYXbHidGYkSihZeRtpV5k3Od
	nx+dvlvzYQjnAhqIq4pFqI7YHBtCsC9g=
X-Received: by 2002:a05:6512:3089:b0:5ae:bf5d:5c54 with SMTP id
 2adb3069b0e04-5b1c0f9251emr31531e87.27.1784133294165; Wed, 15 Jul 2026
 09:34:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5115219.31r3eYUQgx@rafael.j.wysocki> <8706171.T7Z3S40VBb@rafael.j.wysocki>
 <aleucS8bSeEveCDZ@ashevche-desk.local>
In-Reply-To: <aleucS8bSeEveCDZ@ashevche-desk.local>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 15 Jul 2026 18:34:42 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gSJYkHhKrA=gDFnovarB9kHdPi9ZTc=iXDRvsdCQRvGA@mail.gmail.com>
X-Gm-Features: AUfX_mxI6tZx2IuUjgrzQQUi9YVdmUEpmXs8MyJd16QA-mgvRUa1TZhoRxwvDdg
Message-ID: <CAJZ5v0gSJYkHhKrA=gDFnovarB9kHdPi9ZTc=iXDRvsdCQRvGA@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] ACPI: video: Use acpi_dev_get_pci_dev() instead of acpi_get_pci_dev()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	Linux PCI <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Bjorn Helgaas <helgaas@kernel.org>, Hans de Goede <hansg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2026 at 5:59=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Jul 15, 2026 at 05:21:23PM +0200, Rafael J. Wysocki wrote:
>
> > In acpi_video_bus_check() and find_video(), simply replace
> > acpi_get_pci_dev() with acpi_dev_get_pci_dev() that can be used
> > in both places because the ACPI device needed to do the lookup is
> > available.
> >
> > In acpi_video_dev_register_backlight(), instead of doing a parent ACPI
> > handle lookup based on the handle of an ACPI device that is already
> > available, pass that ACPI device to acpi_dev_parent() which is much
> > more straightforward and pass the return value of the latter directly
> > to acpi_dev_get_pci_dev() to get the PCI device associated with it.
> > That allows local variable acpi_parent to be eliminated.
>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks!

> ...
>
> > +++ b/drivers/acpi/video_detect.c
>
> >       if (acpi_dev && !acpi_match_device_ids(acpi_dev, video_ids)) {
> > -             dev =3D acpi_get_pci_dev(handle);
> > +             dev =3D acpi_dev_get_pci_dev(acpi_dev);
>
> This likely needs to be rebased on top of the series I sent?

Probably.
