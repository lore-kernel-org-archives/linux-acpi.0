From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] Re: [patch] hibernation: utilize ACPI hardware signature
Date: Wed, 2 Jan 2008 23:18:58 +0100
Message-ID: <200801022318.59392.rjw@sisk.pl>
References: <1199257162.14632.4.camel@sli10-desk.sh.intel.com> <200801021512.54140.rjw@sisk.pl> <477C0155.70902@nigel.suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:43838 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751814AbYABWRC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Jan 2008 17:17:02 -0500
In-Reply-To: <477C0155.70902@nigel.suspend2.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: nigel@nigel.suspend2.net
Cc: Erik =?iso-8859-15?q?Andr=E9n?= <erik.andren@gmail.com>, pm list <linux-pm@lists.linux-foundation.org>, linux acpi <linux-acpi@vger.kernel.org>

On Wednesday, 2 of January 2008, Nigel Cunningham wrote:
> Hi.
>=20
> Rafael J. Wysocki wrote:
> > On Wednesday, 2 of January 2008, Erik Andr=E9n wrote:
> >> Hi,
> >>
> >> 2008/1/2, Shaohua Li <shaohua.li@intel.com>:
> >>> ACPI defines a hardware signature. BIOS calculates the signature
> >>> according to hardware configure, if hardware changes, the signatu=
re will
> >>> change, in this case, S4 resume should fail.
> >>>
> >>> Signed-off-by: Shaohua Li <shaohua.li@intel.com>
> >>> ---
> >>
> >> Would it be possible to extend this mechanism to prevent the follo=
wing
> >> scenario:
> >>
> >> 1. Linux image A is suspended to disk
> >> 2. Linux image B is booted and various changes to the system are d=
one.
> >> 3. Linux image B is shut down
> >> 4. Linux image A is booted, restoring the suspend to disk image.
> >> 5. Chaos is ensured as the file system state is changed in regard =
to how
> >> linux image A expects it.
> >>
> >> Correct behaviour would naturally be that image A detects that cha=
nges have
> >> been made under its feet and proceed to perform a normal boot inst=
ead of
> >> resuming the stored suspend-to-disk image.
> >=20
> > It should be possible in theory.
> >=20
> >> Is there another mechanism preventing this?
> >=20
> > Not at the kernel level, but you can prevent this from happening by=
 running
> > mkswap on all swap spaces that refuse to come up after a fresh boot=
=2E
>=20
> We really should do something about this. It should be possible to
> handle this properly if something along the following lines was imple=
mented:
>=20
> 1) Each filesystem implements a function taking a pointer to a struct
> block_device and returns a mount count for that filesystem without
> making any modifications to the filesystem.
> 2) Hibernation implementations store the major & minor numbers and mo=
unt
> counts for each mounted filesystem in the image header when hibernati=
ng,
> and recheck those values at resume time. If the mount count on any
> filesystem has changes, we warn the user, invalidate the image and bo=
ot
> normally.

That may quickly become complicated.

=46or example, boot kernel need not contain all drivers used by the hib=
ernated
ones, so some filesystems may be physically inaccessible to them.

Greetings,
Rafael
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
