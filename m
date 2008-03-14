From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: Re: [PATCH 2/4] ACPI: video: prevent ACPI video actionsupondisplay
	switch notifications
Date: Fri, 14 Mar 2008 10:03:23 +0800
Message-ID: <1205460204.2240.81.camel@acpi-hp-zz.sh.intel.com>
References: <1201243677.4663.18.camel@acpi-sony.sh.intel.com>
	 <1205281262.8194.58.camel@linux-2bdv.site>
	 <1205284888.8194.72.camel@linux-2bdv.site>
	 <1205290380.2240.41.camel@acpi-hp-zz.sh.intel.com>
	 <1205338005.29877.247.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:65211 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751937AbYCNCOh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 13 Mar 2008 22:14:37 -0400
In-Reply-To: <1205338005.29877.247.camel@queen.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn@suse.de
Cc: lenb <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, linux-gfx@linux.intel.com


On Thu, 2008-03-13 at 00:06 +0800, Thomas Renninger wrote:
> On Wed, 2008-03-12 at 10:53 +0800, Zhang, Rui wrote:
> > On Wed, 2008-03-12 at 09:21 +0800, Thomas Renninger wrote:
> > >
> > > On Wed, 2008-03-12 at 01:21 +0100, Thomas Renninger wrote:
> > > > On Fri, 2008-01-25 at 14:47 +0800, Zhang Rui wrote:
> > > > > From: Zhang Rui <rui.zhang@intel.com>
> > > > >
> > > > > Display switching via ACPI control methods are known to work
> on
> > > > > none platform AFAIK.
> > > > > And graphics people want to control the display switching all
> by
> > > > > themselves.
> > > > > Prevent ACPI from handling display switch hotkey events in
> this
> > > > > patch.
> > > >
> > > > I expect this one has to be reverted.
> > > > I can double check tomorrow, but I am pretty sure I have a
> Compaq
> > > > and also saw more and I expect there are a lot more that work
> pretty
> > > > fine with Display Output Switching (_DOS) set to be handled by
> BIOS and
> > > > not graphics driver.
> > > >
> > > > As said, I can double check, but this would be a regression.
> > > >
> > > > IMO the logic should be:
> > > >   - Let the BIOS handle the switching (also works without X)
> > > >   - If a graphics driver gets active which can do the switching=
,
> it
> > > >     can take over control by:
> > > >     echo 0 >/proc/acpi/video/*/DOS
> > > >
> > >
> > > I mixed this up with the default value for _DOS:
> > > git commit a21101c46ca5b4320e31408853cdcbf7cb1ce4ed
> > >
> > > Again, =EF=BB=BFIMO the logic should be:
> > >  - Let the BIOS handle the switching (also works without X)
> > >  - If a graphics driver gets active which can do the switching, i=
t
> can
> > >    take over control by:
> > >    echo 0 >/proc/acpi/video/*/DOS
> > That's what I thought at the beginning,
> > and the bug
> > http://bugzilla.kernel.org/show_bug.cgi?id=3D6001
> > suggested me to set _DOS to 0 by default.
> Yep. I think _DOS set to 0 by default is wrong and in the bug machine=
s
> were stated where this causes problems now.
>=20
> > > Also the bug which above commit claims to fix has an interesting
> > > add-on
> > > comment (after the bug got closed):
> > > ----------------
> > > My HP 6710B also crashes when DOS=3D0, DOS=3D1,2 or 3 works just =
fine
> > > though.
> > which version of kernel are you using?
> > I get this problem before, but it can not be reproduced in the
> kernel
> > later than 2.6.23.
> >
> > > This has an GM965 intel chipset. What does the ACPI spec say abou=
t
> values
> > > other then 0 or 1 ?
> > nothing interesting.
> > And many laptops don't follow the ACPI spec on this. :(
>=20
> > > It seems that the change that was done from 1 to 0 causes some
> quit bad
> > > regressions on some laptops, while fixing others. Otoh all
> reporters
> > > say that
> > > DOS=3D2 works..
> > > =EF=BB=BF----------------
> > well, DOS=3D2 doesn't work either...
> > there is no solution that can work for all laptops.
> Above was not from myself, but copied out from the bug.
> The guy(s) complained that DOS=3D0 now breaks their machines...
> I try to find some time to look at this a bit deeper and will then
> comment in the bug (can take some time...).
> IMO recent HPs can/should be taken as a reference as they tend to
> stick
> to the ACPI spec closely.
> As said, it was late and I mixed up patches, the patch to switch _DOS
> default value to 0 was already in 2.6.24?
Yes.
> I don't know now how much was tried already.
> A) To switch DOS to 0 when e.g. intel graphics driver gets active
> (should be done by the graphics driver package or if X is started if
> the
> driver is aware of the hotkey and can do the switching).
> B) Otherwise (e.g. if framebuffer or graphics driver which do not
> switch
> the display) it should stay to be BIOS handled.
> This is the correct way IMO this should get handled.
Well, I agree. If the patch causes regressions, we should revert it.
And I saw several bugs on this.

thanks,
rui
> Puhh, this needs a lot testing (different graphics drivers, different
> machines,...) and implementation to switch to DOS=3D0 in graphics
> drivers...


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
