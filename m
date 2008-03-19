From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 6/6] Revert "ACPI: video: Ignore ACPI video devices
	that aren't present in hardware"
Date: Wed, 19 Mar 2008 10:10:14 +0100
Message-ID: <1205917814.4040.41.camel@linux-2bdv.site>
References: <1205820132-21689-1-git-send-email-lenb@kernel.org>
	 <f0d6752c9fa51d24c86b57c76ec5b2926a716b23.1205819948.git.len.brown@intel.com>
	 <1205852061.21619.192.camel@queen.suse.de>
	 <200803181701.30447.lenb@kernel.org>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns1.suse.de ([195.135.220.2]:36735 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753670AbYCSUMP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 19 Mar 2008 16:12:15 -0400
In-Reply-To: <200803181701.30447.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Adrian Bunk <bunk@stusta.de>


On Tue, 2008-03-18 at 17:01 -0400, Len Brown wrote:
> On Tuesday 18 March 2008, Thomas Renninger wrote:
> > On Tue, 2008-03-18 at 02:02 -0400, Len Brown wrote:
> > > From: Len Brown <len.brown@intel.com>
> > >=20
> > > This reverts commit 3fa2cdcc45a0176de15cac9dbf4ed2834ebf8932.
> > >=20
> > > http://bugzilla.kernel.org/show_bug.cgi?id=3D9995
> >=20
> > This is so wrong...
> > You register a driver on a device which does not exist.
> > You do this because on T61 ThinkPads, the external graphics device
> > method (soft-int 10) for brightness switching also works for the
> > internal Intel graphics card by pure luck...
> >
> > You introduce this obviously wrong approach and break other machine=
s
> > intentionally (this is not a regression, because brightness switchi=
ng
> > was done through thinkpad_acpi before).
>=20
> acpi video brightness worked on the T61 before this patch, eg. in 2.6=
=2E24.
> acpi video brightness stopped working when this patch was applied.
> acpi video brightness works again when this patch (and its clone) wer=
e reverted.
It worked in a very broken way, by using the Nvidia ACPI graphics
device, even you have an Intel graphics card plugged in.
>=20
> > This is known for months and reverting this in last minute is the w=
rong
> > action.
> > This should be:
> >   - fixed up in BIOS through a OSI("IGD") string
>=20
> IGD isn't part of this discussion, since that support didn't ship
> in 2.6.24, and isn't shipping in 2.6.25.
IGD is the reason why this does not work as expected.

> Enabling IGD, or any other feature, via OSI on a platform that has
> already shipped is effectively impossible.  It would require every
> BIOS and every OS to be updated.
The only correct fix (as long as Linux does not support IGD) is a BIOS
fix like this:

Nvidia device
    _BCM implementation: use_int10
Intel device
    if (OSI=3D"IGD")
        _=EF=BB=BFBCM implementation: use_IGD
    else
        =EF=BB=BF_BCM implementation: use_int10

and everything could work fine with the video.c implementation.
I just realize that this does not work because we return true for
OSI=3DWindows and these do not know about OSI=3D"IGD".
This must be changed in future (I am still waiting for examples where i=
t
really makes sense and does some good to return OSI=3DWindows). We now =
are
lucky because on ThinkPads the thinkpad_acpi driver can ugly, but easil=
y
work around this.
There may pop up other things (e.g. IGD on other machines and whatever
other stuff) which will end in a Linux support impasse then.

Now this could get inverted and it would work (it is a bit embarrassing
to suggest this to a vendor: Can you please invert the logic because we
return true for Windows also)...:
=EF=BB=BFNvidia device
    _BCM implementation: use_int10
Intel device
    if (OSI=3D"NOIGD")
=EF=BB=BF        =EF=BB=BF_BCM implementation: use_int10
    else
=EF=BB=BF        =EF=BB=BF_BCM implementation: use_IGD

That vendors are publishing OSI=3D"Linux feature support" in their BIOS=
 is
a bit optimistic and we might end up trying to dig in the dark fiddling
together things in vendor_acpi drivers as we always did.
But currently there is a move towards Linux also on laptops/workstation=
s
and those vendors who care to publish a BIOS which fully works on Linux
and always should need the ability to do this.

> >   - get workarounded (as it always has been done) in thinkpad-acpi
> >     meanwhile.
> >
> > Please try to not load the ACPI video driver.
> > Instead load the thinkpad_acpi driver with:
> > brightness_enable=3D1
> > parameter. Does this work?
> > If that works, this is the right workaround for T61 with
> > internal/on-board
> > Intel graphics card.
>=20
> Yes, the thinkpad_acpi driver with brightness_enable=3D1 works.
>=20
> The thinkpad_acpi driver is really useful.
> It provides ways to get to thinkpad features for which
> no standard interface in Linux currently exists.
>=20
> However, the thinkpad_acpi driver should not be used
> to provide features for which a generic method exists.
>=20
> I understand that a distro may latch onto thinkpad_acpi
> to get features in the hands of customers as soon as possible.
> I understand that the transition off of custom solutions
> is never easy.  brightness_enable=3D1 was added to ease that
> transition.  If you have additional suggestions, please speak up.
>=20
> > You can get a dmi blacklisting so that video driver is not loaded o=
n the
> > ThinkPads or this can be done in user-space, but pls do not revert =
this
> > obvious fix.
>=20
> This patch was far from obvious, including to Matthew, who created it=
=2E
PCI devices do not have a _STA function.
Therefore one has to look up PCI slot:dev.func and check whether the
device is present and really plugged into the board.

   Thomas

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
