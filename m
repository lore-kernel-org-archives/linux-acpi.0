Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2A937C930
	for <linux-acpi@vger.kernel.org>; Wed,  3 Jun 2026 10:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780483894; cv=none; b=uzwAxRrEcYeD3/B8K6tS0RsvZbNDkm2g/+05ua1Qy9g/GVl8Aey8R7+1AHAFaLo1JsAZwtr49uih9ufxre0MFXjfFZ5GsBEctwOzlwtMExh74tyIRRK61tie/V17LFGfLl2EjmgmrOSQmibWJdeu7ITVAjyMycyCQsne13d/2tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780483894; c=relaxed/simple;
	bh=5MWalmedndmPVMrtI7ZjPTxmDKVrlERlEKgr/etOe4Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O6da4ajBwBo9rosu6roF4xiU50+Cc6gVbUsfOyC+AqbAf5YFMZSFKMnqJ53KVDEN8Gzl//u06JKm2gcg8n587KuKys43sNmGhEJnPWVqn/8giel3y0b4t4gNMW8TjgNKMnuocUhcQOY4lSqX4yNVGBgfRYWsmnWbb6W/CaPtHqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FvSTw/BZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FvSTw/BZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB4E61F0089A
	for <linux-acpi@vger.kernel.org>; Wed,  3 Jun 2026 10:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780483893;
	bh=SfhPC82DNXc+mRIg3HiwuwtlL8sGtxkh5ddYgE5vT5U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=FvSTw/BZfFn9w9FQBX8YjjfF6jH1eKpyP8GXRjXUkHn+JPU8kTeFxMDzm8RHmLo1r
	 seFl3JobU4BLhqv5F9JmEr6aFlHpc1N9cqDG3cQFr6e/osN7jno0bIVEVf2GliUJb8
	 uMhU1y137qdXU0hsXUZQiQj44nbeGpW+NXgOmMLBIw9+CZtytiD0EGUYnqJZfViihi
	 kAnvSmfY7PHsEmk4u1kb9kUUNylgkyuYdbxwmIT+BHMuaIp/Jf+OCPuW8xAF8Lo1y7
	 cLlAX3uVfLa5Wx9GlpXTFmVgOtH9Vifpk9+P/wSKxAGlZa8rTOpai+ksNH4CqYFd0M
	 B602czkcOwS1A==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5aa61e3d3f3so4032899e87.0
        for <linux-acpi@vger.kernel.org>; Wed, 03 Jun 2026 03:51:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+Gh+kc6oaPtfp+V3A3s/XZbUXoKSbNdLYN2VHHOY1hmJR8JqxF3RcFWAd8xTOCGVXi0xtOpyfvyd7d@vger.kernel.org
X-Gm-Message-State: AOJu0YzyqPQfn0ZyNobpSvsM9DPNSXwT2eyLpc1yKa72WYyBqPmVAGLj
	c/0m4nxb1okejpwIxxdeW7ndW4TzJ+MUDramVljlGqDE1rrE0dMXcu1e28n+fIOmPEL0iFTmBd0
	/RO+VqzlMueEIi/CbeXuqQGohlEUyq/8=
X-Received: by 2002:a05:6512:4055:20b0:5aa:6a12:7d58 with SMTP id
 2adb3069b0e04-5aa7c114ce8mr694459e87.30.1780483891426; Wed, 03 Jun 2026
 03:51:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4739447.LvFx2qVVIh@rafael.j.wysocki> <7950702.EvYhyI6sBW@rafael.j.wysocki>
 <ah9UyXwsLAjIJEff@ashevche-desk.local>
In-Reply-To: <ah9UyXwsLAjIJEff@ashevche-desk.local>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 3 Jun 2026 12:51:20 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hX_UCzmEuGYT6mhTf-L=vzN7dgoG_9FZw-Ccr=_Fo+5w@mail.gmail.com>
X-Gm-Features: AVHnY4JE_NfLU_9VWTvGoBivILn7j7vH3mvzXND1aNsEMVOyqoi9xJaKBdDfUig
Message-ID: <CAJZ5v0hX_UCzmEuGYT6mhTf-L=vzN7dgoG_9FZw-Ccr=_Fo+5w@mail.gmail.com>
Subject: Re: [PATCH v1 06/17] ACPI: HED: Switch over to devres-based resource management
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Hans de Goede <hansg@kernel.org>, 
	Armin Wolf <w_armin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 3, 2026 at 12:10=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, May 21, 2026 at 04:04:03PM +0200, Rafael J. Wysocki wrote:
>
> > Use the newly introduced devm_acpi_install_notify_handler() for
> > installing an ACPI notify handler and since that function checks the
> > ACPI companion of the owner device against NULL internally, remove the
> > the explicit ACPI companion check from acpi_hed_probe().
> >
> > No intentional functional impact.
>
> ...
>
> >  static void acpi_hed_remove(struct platform_device *pdev)
> >  {
> > -     struct acpi_device *device =3D ACPI_COMPANION(&pdev->dev);
> > -
> >       hed_present =3D false;
> > -     acpi_dev_remove_notify_handler(device, ACPI_DEVICE_NOTIFY,
> > -                                    acpi_hed_notify);
> >  }
>
> devm will be cleaned after this, right?

Yes.

> So, here is a window that if one tries
> to unbind device from the driver in one thread and do the opposite in ano=
ther
> they will see the flag false while resources are still allocated for the =
old
> one. It seems that hed_present should be also devm:ed?

If this is the same device, both binding and unbinding (including
devm) take place under its device lock which will serialize all of
that.

If they are different devices with different ACPI companions, there's
no resource conflict.  If they are both valid HEDs (which would be a
stretch already) and they both trigger a notification exactly at the
"wrong" time (more stretch), worst-case stuff will be called twice in
a row via blocking_notifier_call_chain().
