From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: Re: [PATCH 2/4] ACPI: video: prevent ACPI video actions
	upondisplay switch notifications
Date: Wed, 12 Mar 2008 10:53:00 +0800
Message-ID: <1205290380.2240.41.camel@acpi-hp-zz.sh.intel.com>
References: <1201243677.4663.18.camel@acpi-sony.sh.intel.com>
	 <1205281262.8194.58.camel@linux-2bdv.site>
	 <1205284888.8194.72.camel@linux-2bdv.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:21312 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751230AbYCLDFO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 11 Mar 2008 23:05:14 -0400
In-Reply-To: <1205284888.8194.72.camel@linux-2bdv.site>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn@suse.de
Cc: lenb <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, linux-gfx@linux.intel.com


On Wed, 2008-03-12 at 09:21 +0800, Thomas Renninger wrote:
>=20
> On Wed, 2008-03-12 at 01:21 +0100, Thomas Renninger wrote:
> > On Fri, 2008-01-25 at 14:47 +0800, Zhang Rui wrote:
> > > From: Zhang Rui <rui.zhang@intel.com>
> > >
> > > Display switching via ACPI control methods are known to work on
> none
> > > platform AFAIK.
> > > And graphics people want to control the display switching all by
> themselves.
> > > Prevent ACPI from handling display switch hotkey events in this
> patch.
> >
> > I expect this one has to be reverted.
> > I can double check tomorrow, but I am pretty sure I have a Compaq
> and
> > also saw more and I expect there are a lot more that work pretty
> fine
> > with Display Output Switching (_DOS) set to be handled by BIOS and
> not
> > graphics driver.
> >
> > As said, I can double check, but this would be a regression.
> >
> > IMO the logic should be:
> >   - Let the BIOS handle the switching (also works without X)
> >   - If a graphics driver gets active which can do the switching, it
> can
> >     take over control by:
> >     echo 0 >/proc/acpi/video/*/DOS
> >
>=20
> I mixed this up with the default value for _DOS:
> git commit a21101c46ca5b4320e31408853cdcbf7cb1ce4ed
>=20
> Again, =EF=BB=BFIMO the logic should be:
>  - Let the BIOS handle the switching (also works without X)
>  - If a graphics driver gets active which can do the switching, it ca=
n
>    take over control by:
>    echo 0 >/proc/acpi/video/*/DOS
That's what I thought at the beginning,
and the bug
http://bugzilla.kernel.org/show_bug.cgi?id=3D6001
suggested me to set _DOS to 0 by default.

>=20
> Also the bug which above commit claims to fix has an interesting
> add-on
> comment (after the bug got closed):
> ----------------
> My HP 6710B also crashes when DOS=3D0, DOS=3D1,2 or 3 works just fine
> though.
which version of kernel are you using?
I get this problem before, but it can not be reproduced in the kernel
later than 2.6.23.

>  This
> has an GM965 intel chipset. What does the ACPI spec say about values
> other then
> 0 or 1 ?
nothing interesting.
And many laptops don't follow the ACPI spec on this. :(
> It seems that the change that was done from 1 to 0 causes some quit
> bad
> regressions on some laptops, while fixing others. Otoh all reporters
> say that
> DOS=3D2 works..
> =EF=BB=BF----------------
well, DOS=3D2 doesn't work either...
there is no solution that can work for all laptops.

thanks,
rui

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
