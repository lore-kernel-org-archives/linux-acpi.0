From: Thomas Renninger <trenn@suse.de>
Subject: Re: Check for ACPI backlight support otherwise use vendor ACPIdrivers - version 4
Date: Mon, 4 Aug 2008 13:19:42 +0200
Message-ID: <200808041319.44362.trenn@suse.de>
References: <1217605083-31003-1-git-send-email-trenn@suse.de> <200808041220.29892.trenn@suse.de> <20080804103929.GC28887@corsac.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:38778 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753225AbYHDLTs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Aug 2008 07:19:48 -0400
In-Reply-To: <20080804103929.GC28887@corsac.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yves-Alexis Perez <corsac@debian.org>
Cc: Zhang Rui <rui.zhang@intel.com>, ak@linux.intel.com, nokos@gmx.net, linux-acpi@vger.kernel.org, mjg59@srcf.ucam.org, hmh@debian.org

On Monday 04 August 2008 12:39:30 Yves-Alexis Perez wrote:
> On Mon, Aug 04, 2008 at 12:20:28PM +0200, Thomas Renninger wrote:
> > > But when in user mode, brightness keys doesn't do anything either=
=2E
> > > Echo'ing to /proc/acpi/ibm/brightness doesn't work, but echoing
> > > to /sys/class/backlight/thinkpad_screen/brightness works.
> >
> > That /proc/acpi/ibm/brightness does not and
> > /sys/class/backlight/thinkpad_screen/brightness
> > works is strange, this should be a bug?
>
> I guess so, but I don't really know how to check.
>
> > I wonder whether /proc/acpi/ibm/brightness can be removed soon, peo=
ple
> > had some time to make use of the generic interface.
>
> I'm not using it usually anyway.
>
> > What you describe very much reminds me when I tested on a ThinkPad =
with
> > an IGD device. I removed the check for IGD devices in favour of a w=
orking
> > IGD driver.
> >
> > Attached patch might help you (with acpi_backlight=3Dvendor)?
> > You should be able to apply this on my latest patchset, but use thi=
s
> > patch instead of the thinkpad_acpi one.
>
> Ok, will try tonight. But I remember Henrique saying my thinkpad
> shouldnt use thinkpad-acpi but rather video.ko for brightness
> management, so I'm a bit puzzled.
>
> > > Cat'ing /proc/acpi/events still gives:
> > > video LCD0 00000086 00000000
> > > video LCD0 00000087 00000000
> > >
> > > At one time I get the 750ms delay, but I don't have the
> > > ibm/hotkey HKEY 00000080 00005010 at all.
> >
> > Hmm, on my machine it was 1010 and 1011 key event values for up/dow=
n
> > brightness. If you do not see those, the patch might not work.
>
> And I do remember that the key changed (but can't remember when). May=
be
> that's due to a bios upgrade.
>
> > > In X, same thing, no brightness keys, but xbacklight does work in
> > > standard mode (=E2=80=9Ckernel=E2=80=9D).
> > >
> > > (btw it seems my mails don't reach linux-acpi, I don't really kno=
w why
> > > and postmaster don't answer, maybe they didn't have my mail eithe=
r).
> >
> > I expect you have an IGD device and this should by default be serve=
d by
> > Matthew's/Hong's patches. Matthew said something about a needed pea=
ce
> > that came in in latest BIOSes? But I expect you already run on the
> > latest?
>
> I run Bios 2.19 and EC 1.08 which are the latest available on
> lenovo.com.
>
> The kernel I'm testing on is a pure linux-acpi-2.6/test so i'm not su=
re
> I have Matthew's patches.

And this probably is the problem.
They seem not to be in:
branch 'test' of=20
git://git.kernel.org/pub/scm/linux/kernel/git/ak/linux-acpi-2.6

I just tried to find them in the tree that I thought Matthew stated tha=
t they=20
are queued their in the master branch:
git://git.kernel.org/pub/scm/linux/kernel/git/airlied/drm-2.6.git
Without success, neither in the master nor in the -mm nor in the linux-=
next=20
branch I could find anything with Matthew in CC or pointing to opregion=
=2E

The last post from Matthew on the dri list sending an update patch is f=
rom:
2008-05-29
This was before he found out that on ThinkPads a PWM method has to be c=
alled.

Something is fishy here.
Seems there are still problems? Maybe I should add the IGD check again,=
 then=20
it's not harmful if the two patchsets do not go in together...

      Thomas
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
