From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [Intel-gfx] PROBLEM: Native backlight regressed from logarithmic
 to linear scale
Date: Tue, 29 Jul 2014 12:38:22 +0200
Message-ID: <20140729103822.GO4747@phenom.ffwll.local>
References: <alpine.DEB.2.02.1407212333200.44274@all-night-tool.MIT.EDU>
 <53D76D65.6030704@redhat.com>
 <alpine.DEB.2.02.1407290554280.44274@all-night-tool.MIT.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:35525 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752859AbaG2KiQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Jul 2014 06:38:16 -0400
Received: by mail-wi0-f170.google.com with SMTP id f8so5644730wiw.1
        for <linux-acpi@vger.kernel.org>; Tue, 29 Jul 2014 03:38:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1407290554280.44274@all-night-tool.MIT.EDU>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Anders Kaseorg <andersk@MIT.EDU>
Cc: Hans de Goede <hdegoede@redhat.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Jani Nikula <jani.nikula@linux.intel.com>, linux-acpi@vger.kernel.org, intel-gfx@lists.freedesktop.org

On Tue, Jul 29, 2014 at 06:14:16AM -0400, Anders Kaseorg wrote:
> On Tue, 29 Jul 2014, Hans de Goede wrote:
> > I've been thinking a bit about this, and I believe that the right a=
nswer=20
> > here is to do the linear to logarithmic mapping in user-space. The =
intel=20
> > backlight interface has a type of raw, clearly signalling to usersp=
ace=20
> > that it is a raw "untranslated" interface, as such any fanciness su=
ch as=20
> > creating a logarithmic scale should be done in userspace IMHO.
>=20
> I was going to respond that the kernel does its own brightness steppi=
ng=20
> when userspace isn=E2=80=99t paying attention.  But apparently only a=
cpi_video=20
> does that, and intel_backlight does not; my brightness keys now have =
no=20
> effect outside of the X server.  Is that the expected behavior?

Userspace on linux is supposed to catch brightness keys and update the
backlight. Some acpi drivers do funny stuff behind everyone's back, but
generally that's the expected behavior. You'd need a deamon for the
backlight to work on the console.

> In any case, if you think punting part of the problem to userspace is=
 the=20
> right answer, then to flesh out the details: do you think it=E2=80=99=
s right for=20
> userspace to assume that any backlight with type =E2=80=98raw=E2=80=99=
 is a linear scale=20
> that needs to be converted, and one with type =E2=80=98firmware=E2=80=
=99 or =E2=80=98platform=E2=80=99 has=20
> already been converted appropriately?

I don't think you can generally assume anything - what we do is send th=
e
pwm signal, how linearly that translates into brightness is totally pan=
el
and driver dependent. So no matter what you pick someone will complain =
I
think.
-Daniel
--=20
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
