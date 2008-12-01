From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [intel/acpi] backlight - T61
Date: Mon, 01 Dec 2008 13:08:23 +0800
Message-ID: <1228108103.2713.27.camel@rzhang-dt>
References: <1227854824.3477.9.camel@hidalgo>
	 <alpine.LFD.2.00.0811281316390.3204@localhost.localdomain>
	 <1227912656.17845.5.camel@hidalgo> <1228095176.2713.18.camel@rzhang-dt>
	 <alpine.LFD.2.00.0811302158150.3314@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:46873 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750740AbYLAFJ7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 1 Dec 2008 00:09:59 -0500
In-Reply-To: <alpine.LFD.2.00.0811302158150.3314@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Yves-Alexis Perez <corsac@debian.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "dri-devel@lists.sourceforge.net" <dri-devel@lists.sourceforge.net>, "jbarnes@virtuousgeek.org" <jbarnes@virtuousgeek.org>, Thomas Renninger <trenn@suse.de>, Matthew Garrett <mjg@redhat.com>, Keith Packard <keithp@keithp.com>

On Mon, 2008-12-01 at 11:18 +0800, Len Brown wrote:
>=20
> > IMO, after loading i915 driver, the ACPI backlight I/F can work aga=
in,
> > right?
>=20
> No.
> hotkeys have never worked in console mode,
that's bad. We should try to work this out.
len, can you please send me the acpidump output of your x60?

> but in 2.6.27, echo into /proc and /sys did work in console mode
> and in 2.6.28 they do not.  So this is a regression.
>=20
> > If this is true, why not always loading i915 both in X and console =
mode?
> > the kernel mode setting should not only work for X mode.
>=20
> I agree that the i915 driver should handle brightness, no matter if w=
e
> are in GUI mode or console mode.  Unfortunately, today it
> doesn't seem to do anything in console mode.
>=20
> That is why I pointed out that the regression here was
> when we deleted the /proc and /sys nodes that actualy work
> from console mode...
>=20
> On a brightner note, I'm pleased to report that after upgrading
> my T61 to FC10 from FC9, the brightness suddenly became consistent
> across screen saver events.  ie. the brightness I set via hotkey
> before the screen saver event was restored after the screen
> comes back from screen blank.
>=20
> However, testing FC10 with the latest upstream kernel,
> including the i915 changes that appeared today...
> it seems that GUI mode forgets the brighness when
> I switch to console mode.  Eg. If I use /sys or
> hotkeys in GUI mode to reduce brightness to 0,
> it stays dim when I switch to console mode,
> but switches back to max brightness when
> I switch back to GUI mode.
hah, that's a done by X.
ZhenYu pointed out that the graphics driver will set the backlight to
maximum if it is 0 =EF=BB=BFwhen =EF=BB=BFswitching to GUI.
=EF=BB=BFwhat if reducing the brightness to a lower but not 0 level?
it should switch back to the original value, right?
cc ZhenYU. :)

thanks,
rui


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
