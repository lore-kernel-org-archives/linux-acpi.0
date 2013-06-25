From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 0/3] Fix backlight issues on some Windows 8 systems
Date: Tue, 25 Jun 2013 22:33:00 +0100
Message-ID: <20130625213300.GA3296@srcf.ucam.org>
References: <1370818899-8595-1-git-send-email-matthew.garrett@nebula.com>
 <1371937599.17761.19.camel@scapa>
 <20130625160848.GA27123@srcf.ucam.org>
 <1372193037.8189.24.camel@scapa>
 <20130625205430.GA2438@srcf.ucam.org>
 <1372194611.8189.31.camel@scapa>
 <20130625211415.GA2899@srcf.ucam.org>
 <1372195837.8189.42.camel@scapa>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:59869 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751367Ab3FYVdD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 25 Jun 2013 17:33:03 -0400
Content-Disposition: inline
In-Reply-To: <1372195837.8189.42.camel@scapa>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yves-Alexis Perez <corsac@debian.org>
Cc: linux-acpi@vger.kernel.org, seth.forshee@canonical.com, joeyli.kernel@gmail.com, daniel.vetter@ffwll.ch, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, lenb@kernel.org, rjw@sisk.pl, Henrique de Moraes Holschuh <hmh@debian.org>

On Tue, Jun 25, 2013 at 11:30:37PM +0200, Yves-Alexis Perez wrote:
> On mar., 2013-06-25 at 22:14 +0100, Matthew Garrett wrote:
> > Which, as we've already established, you don't - Lenovo broke it. Y=
our=20
> > Thinkpad claims to have 100 available levels, and most of them don'=
t=20
> > work. The kernel has no way of knowing which levels work and which=20
> > don't, so leaving this up to the kernel won't actually fix your sys=
tem=20
> > either.
>=20
> I was referring to =E2=80=9Cstandardize the behaviour by leaving up t=
o
> userspace=E2=80=9D. A lot of thinkpads (for example) (all the pre-win=
dows 8
> ones) have a perfectly working ACPI backlight interface.

And this patchset won't alter their behaviour.

> Also, if the kernel has no way of knowing which levels work, I fail t=
o
> see how userspace can do better.

It can't. That's why this patchset disables the ACPI interface on=20
Windows 8 systems.

> I understand that switching to intel_backlight instead of acpi_video0
> follows what Windows 8 recommends but for me it looks orthogonal to t=
he
> fact ACPI methods now have some awkward (Lenovo) or broken (Dell). I
> mean, it's not the first time firmware people break some kernel
> behavior. I know it's usually not easy to contact them, but shouldn't
> those methods be fixed, instead of somehow blindly switching to graph=
ic
> drivers?

No. The correct answer to all firmware issues is "Are we making the sam=
e=20
firmware calls as the version of Windows that this hardware thinks it's=
=20
running". If Windows 8 doesn't make these calls, we shouldn't make thes=
e=20
calls.

--=20
Matthew Garrett | mjg59@srcf.ucam.org
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
