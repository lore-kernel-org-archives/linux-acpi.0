From: Anders Kaseorg <andersk@MIT.EDU>
Subject: Re: [Intel-gfx] PROBLEM: Native backlight regressed from logarithmic
 to linear scale
Date: Tue, 29 Jul 2014 06:14:16 -0400 (EDT)
Message-ID: <alpine.DEB.2.02.1407290554280.44274@all-night-tool.MIT.EDU>
References: <alpine.DEB.2.02.1407212333200.44274@all-night-tool.MIT.EDU> <53D76D65.6030704@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from dmz-mailsec-scanner-4.mit.edu ([18.9.25.15]:61110 "EHLO
	dmz-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752168AbaG2KOY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 29 Jul 2014 06:14:24 -0400
In-Reply-To: <53D76D65.6030704@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Jani Nikula <jani.nikula@linux.intel.com>, linux-acpi@vger.kernel.org, intel-gfx@lists.freedesktop.org

On Tue, 29 Jul 2014, Hans de Goede wrote:
> I've been thinking a bit about this, and I believe that the right ans=
wer=20
> here is to do the linear to logarithmic mapping in user-space. The in=
tel=20
> backlight interface has a type of raw, clearly signalling to userspac=
e=20
> that it is a raw "untranslated" interface, as such any fanciness such=
 as=20
> creating a logarithmic scale should be done in userspace IMHO.

I was going to respond that the kernel does its own brightness stepping=
=20
when userspace isn=E2=80=99t paying attention.  But apparently only acp=
i_video=20
does that, and intel_backlight does not; my brightness keys now have no=
=20
effect outside of the X server.  Is that the expected behavior?

In any case, if you think punting part of the problem to userspace is t=
he=20
right answer, then to flesh out the details: do you think it=E2=80=99s =
right for=20
userspace to assume that any backlight with type =E2=80=98raw=E2=80=99 =
is a linear scale=20
that needs to be converted, and one with type =E2=80=98firmware=E2=80=99=
 or =E2=80=98platform=E2=80=99 has=20
already been converted appropriately?

Anders
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
