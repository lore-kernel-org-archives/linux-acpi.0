From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] Override DSDT and SSDTs via initramfs
Date: Fri, 01 Feb 2008 11:21:36 +0100
Message-ID: <1201861297.14573.66.camel@queen.suse.de>
References: <4798E2A5.6020804@users.sf.net>
	 <20080125063328.4e3b4752.akpm@linux-foundation.org>
	 <200801252339.44246.lenb@kernel.org>
	 <1201714051.1222.131.camel@queen.suse.de>
	 <47A0FBD4.6090603@tremplin-utc.net>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.suse.de ([195.135.220.2]:39632 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751024AbYBAKVi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 1 Feb 2008 05:21:38 -0500
In-Reply-To: <47A0FBD4.6090603@tremplin-utc.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?ISO-8859-1?Q?=C9ric?= Piel <Eric.Piel@tremplin-utc.net>
Cc: Len Brown <lenb@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Philippe Coval <rzr@users.sourceforge.net>, linux-acpi@vger.kernel.org, dsdt <dsdt@gaugusch.at>

On Wed, 2008-01-30 at 23:36 +0100, =C3=89ric Piel wrote:
> Hi,
> Just a few comments for now as I don't have much time until this week=
end.
> 30/01/08 18:27, Thomas Renninger wrote/a =C3=A9crit:
> :
> > On Fri, 2008-01-25 at 23:39 -0500, Len Brown wrote:
> :
> >> Probably it is best to forward the original patch
> >> w/ proper credits, and then send updates to address 1-4.
> Thomas, the patch you have included is only the "original" patch, rig=
ht?=20
> We need to address the points 1-4 (which seem very reasonable) later =
on=20
> with additional patches. I think most of them are already implemented=
 in
> http://gaugusch.at/acpi-dsdt-initrd-patches/acpi-dsdt-initrd-v0.8.2-2=
=2E6.17-ssdt.patch
> So that should be quite easy :-)
>=20
> > I do not know who initially came up with this, I just modified/adju=
sted
> > the patch sometimes. I expect it's Markus, possibly Eric or best bo=
th
> > who should be mentioned as author.
> Yep, to be precise, Markus Gaugusch is the original author, I'm just =
the=20
> current maintainer, and Thomas has been very helpful for a looong tim=
e :-)
Long time is true..., very helpful, don't know, I didn't do that much..=
=2E

> > Jeff (Mahony) has adjusted the last bits of it when he updated it t=
o the
> > latest rcX-gitY version:
> > Changes:
> >  We no longer call populate_rootfs() twice. If we want the custom D=
SDT,
> >  we load the rootfs before ACPI. Otherwise, it is loaded at the
> > appropriate
> >  initcall time. -jeffm
> I had left it this way because I though Linus had a good reason for=20
> delaying populate_rootfs(). But if it works, fine! Maybe some additio=
nal=20
> comments should be added in before the #ifdef's to clearly show that=20
> populate_rootfs() is _always_ called, and they modify only the moment=
 it=20
> is called.
I don't know about this, I took that change from your patches...
>=20
> >  There is a new version at
> > http://gaugusch.at/acpi-dsdt-initrd-patches/acpi-dsdt-initrd-v0.8.4=
-2.6.21.patch,
> >  but there doesn't seem to be any real changes other than elminatin=
g the
> > file
> >  name array.
> Yes, exactly.
>=20
> > In fact, I added the array some time ago.
> > Not sure whether the latest Version of Eric/Markus can also load se=
veral
> > DSDT/SSDTs? Maybe you found a more elegant way?
> Nope. On the website (http://gaugusch.at/kernel.shtml) you can just f=
ind=20
> two versions of the patch: one simple and one with your addition for=20
> SSDTs support. At least with SSDTs support there is even an advantage=
=20
> over the DSDT-in-kernel version :-)
>=20
> Just one comment about the patch for now: it misses=20
> Documentation/dsdt-initrd.txt . Please include this file too so that =
the=20
> documentation is provided at the same time (it's in the official patc=
h).
>=20
> I'll test the patch and try to be productive this weekend.
There is no real need for testing the patch.
It is in OpenSUSE for quite some time. While I don't know how much it
got used, it shouldn't break anything if unused.
As Jeff stated (I haven't had a look at your current version) it should
be nearly the same.

About Len's points 1-4:

1. tainted bit needs to be set when a DSDT override is used.
   (this is common both to the new patch and the current
    override method)

2. upon setting the tainted bit, print a BIG FAT WARNING
   that this is not a supported configuration.

3. cmdline option needs to be available to disable
   an override.  Otherwise a bad image in the intrd
   may be a serious pickle for some users.

4. get rid of alarming failure message:

+       printk(KERN_INFO "Looking for DSDT in initrd ...");
=2E..
+       printk(" not found!\n");

Most of this should be included in the one I sent:
1+2 should be covered by this:
+                               printk(PREFIX "Override [%4.4s-%8.8s]"
+                                      " from initramfs -"
+                                      " tainting kernel\n",
+                                      t->signature,
+                                      t->oem_table_id);
+                               add_taint(TAINT_NO_SUPPORT);
I remember that I introduced a new TAINT flag, this got probably ripped
out because I expect it needed conflict solving with new kernels all th=
e
time.
Now when it goes mainline a TAINT_DSDT_OVERRIDE flag might be
appropriate, so that if you see a kernel panic or whatever bug, you
immediately see why the kernel is tainted.

Problem from 4. should also not exist in this patch anymore.

The boot parameter (3.) is still missing.

Eric, would you mind bringing this all together (if Len agrees with my
aspects).
I'd vote for moving the current location of the DSDT file to:
/dsdt/DSDT.aml
This would break current userspace apps (including SuSE's mkinitrd), bu=
t
would prepare the patch for further SSDT enhancements.

    Thomas

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
