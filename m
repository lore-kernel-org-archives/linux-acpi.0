From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v2 03/11] vga-switcheroo: make PCI dependency explicit
Date: Mon, 24 Dec 2018 10:27:28 +0100
Message-ID: <CAKMK7uGcqZA7ZXNhmd8mwhho9wxobAkZdhknaWXF6wAz9rsRjw@mail.gmail.com>
References: <20181222090720.19234-1-okaya@kernel.org> <20181222090720.19234-4-okaya@kernel.org>
 <20181222164013.2l7etklpxjrrobnm@wunner.de> <CAK9iUCNkQR=bUhBPYp_3kr6fo7Y0Jtko=BSjU4QozuOs9mA+kQ@mail.gmail.com>
 <20181223171501.4hwqu6wn4jzwrcmn@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181223171501.4hwqu6wn4jzwrcmn@wunner.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>
Cc: Sinan Kaya <Okaya@kernel.org>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Maxime Ripard <maxime.ripard@bootlin.com>, "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, David Airlie <airlied@linux.ie>, Sean Paul <sean@poorly.run>
List-Id: linux-acpi@vger.kernel.org

On Sun, Dec 23, 2018 at 6:15 PM Lukas Wunner <lukas@wunner.de> wrote:
>
> On Sun, Dec 23, 2018 at 02:00:15AM +0300, Sinan Kaya wrote:
> > On Sat, Dec 22, 2018 at 7:40 PM Lukas Wunner <lukas@wunner.de> wrote:
> > > On Sat, Dec 22, 2018 at 09:07:12AM +0000, Sinan Kaya wrote:
> > > > This driver depends on the PCI infrastructure but the dependency has not
> > > > been explicitly called out.
> > > >
> > > > Signed-off-by: Sinan Kaya <okaya@kernel.org>
> > > > Reviewed-by: Lukas Wunner <lukas@wunner.de>
> > >
> > > This series doesn't have a cover letter so it's unclear to me through
> > > which tree it's supposed to go in?  Each patch through the individual
> > > subsystem tree or all through the same tree?  If the former I guess I
> > > could push this to drm-misc...
> >
> > Feel free to apply individual patches independently. Let me know which
> > one you applied so that I can drop them on the next rev.
>
> I've realized only now that this patch fixes fallout of commit
> 5d32a66541c4 ("PCI/ACPI: Allow ACPI to be built without CONFIG_PCI set")
> which is part of Rafael's acpi pull for v4.21.
>
> Usually such fixes go through the same tree as the offending commit,
> so I'd expect Raphael to pick up the whole series and forward it to
> Linus in the second half of the merge window.  I'm not sure if that's
> how it'll play out though given the holidays.

Yeah, best to get this merged through the tree that broke things.
Acked-by: Daniel Vetter <daniel.ffwll.ch> for that.

> Additionally, drm-misc is currently in a somewhat confusing state:
> Normally fixes targeting v4.21 should have been applied to
> drm-misc-next-fixes for the last 2 weeks, yet no new commits have
> been applied to that branch since December 5, but plenty of stuff
> that should have been applied (various fixes and a MAINTAINERS change)
> went to drm-misc-next instead.  So it looks like a lot of folks picked
> the wrong branch and drm-misc-next is now a mix of v4.22 features and
> v4.21 fixes.  I think I should rather not add to this mess before a
> drm-misc maintainer has had a chance to sort it out.

If a patch has been misplaced the only way to fix it is to cherry-pick
it over. Hence no need to wait for maintainers to sort out anything if
you have patches for drm-misc-next-fixes, you can't make it worse :-)

> I'll be sure to keep an eye on this though.  The fallout addressed by
> the patch is mostly confined to randconfigs I think, so waiting a few
> more days probably won't hurt much.

Agreed.
-Daniel
>
> Thanks,
>
> Lukas
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
