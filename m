From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [opensuse-kernel] 3.4rc6: ACPI change/regression ?
Date: Thu, 10 May 2012 20:31:26 +0200
Message-ID: <201205102031.26807.rjw@sisk.pl>
References: <4FAA8C36.7040503@opensuse.org> <201205102028.33871.rjw@suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:36630 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761098Ab2EJS0f convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 10 May 2012 14:26:35 -0400
In-Reply-To: <201205102028.33871.rjw@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: opensuse-kernel@opensuse.org
Cc: Linux PM list <linux-pm@vger.kernel.org>, Cristian =?iso-8859-1?q?Rodr=EDguez?= <crrodriguez@opensuse.org>, len.brown@intel.com, ming.m.lin@intel.com, Len Brown <lenb@kernel.org>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>

Hi,

On Thursday, May 10, 2012, Rafael J. Wysocki wrote:
> On Wednesday, May 09, 2012, Cristian Rodr=EDguez wrote:
> > Hi:
> >=20
> > Since 3.4rc6 I am not able to "turn off" unused Nvidia "optimus" ca=
rd,=20
> > either with 3rd party modules or vga_switchero.
> >=20
> > In rc5 it worked fine, now I get:
> >=20
> > a) with third party bbswitch module.
> >=20
> > bbswitch: Found integrated VGA device 0000:00:02.0: \_SB_.PCI0.GFX0
> > bbswitch: Found discrete VGA device 0000:01:00.0: \_SB_.PCI0.PEG0.P=
EGP
> > bbswitch: detected an Optimus _DSM function
> > bbswitch: disabling discrete graphics
> > bbswitch: Result of Optimus _DSM call: 11000059
> > pci 0000:01:00.0: Refused to change power state, currently in D0
> > ACPI: Device does not support D3
> > bbswitch: Succesfully loaded. Discrete card 0000:01:00.0 is on
> >=20
> > Ok, third party module may be buggy and I don't expect anyone here =
to=20
> > support it, so I went to try kernel vga_switchero..
> >=20
> > VGA switcheroo: switched nouveau off
> > [drm] nouveau 0000:01:00.0: Disabling display...
> > [drm] nouveau 0000:01:00.0: Disabling fbcon...
> > [drm] nouveau 0000:01:00.0: Unpinning framebuffer(s)...
> > [drm] nouveau 0000:01:00.0: Evicting buffers...
> > [drm] nouveau 0000:01:00.0: Idling channels...
> > [drm] nouveau 0000:01:00.0: Suspending GPU objects...
> > [drm] nouveau 0000:01:00.0: And we're gone!
> > ACPI: Device does not support D3
> >=20
> > But device DOES support D3 states or at least it did in rc5..
> >=20
> > The ill effec of this change is that now the video card fan is runn=
ing=20
> > almost all the time.
> >=20
> > Is this a side effect of=20
> > http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux.git;a=3D=
commit;h=3D1cc0c998fdf2cb665d625fb565a0d6db5c81c639=20
> > ?

Yes, it's probably this one.  Have you tried to revert it?

Rafael
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
