From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v5 1/3] mfd: Add support for Cherry Trail Dollar Cove TI
 PMIC
Date: Wed, 6 Sep 2017 10:05:04 +0100
Message-ID: <20170906090504.oo5equym533u7u5q@dell>
References: <20170904144340.27693-1-tiwai@suse.de>
 <20170904144340.27693-2-tiwai@suse.de>
 <20170905072451.ephscqjqgwpnl6da@dell>
 <s5hmv69twov.wl-tiwai@suse.de>
 <20170905081049.r3gbdtr2iuom6uk6@dell>
 <s5hefrltv43.wl-tiwai@suse.de>
 <20170905085341.ssukn2rtyf3q65bn@dell>
 <s5hwp5do578.wl-tiwai@suse.de>
 <20170906075444.7apee362ij3wqall@dell>
 <s5hd174s0b7.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5hd174s0b7.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@linux.intel.com>, Johannes Stezenbach <js@sig21.net>, Hans de Goede <hdegoede@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wed, 06 Sep 2017, Takashi Iwai wrote:

> On Wed, 06 Sep 2017 09:54:44 +0200,
> Lee Jones wrote:
> > 
> > On Tue, 05 Sep 2017, Takashi Iwai wrote:
> > 
> > > On Tue, 05 Sep 2017 10:53:41 +0200,
> > > Lee Jones wrote:
> > > > 
> > > > On Tue, 05 Sep 2017, Takashi Iwai wrote:
> > > > 
> > > > > On Tue, 05 Sep 2017 10:10:49 +0200,
> > > > > Lee Jones wrote:
> > > > > > 
> > > > > > On Tue, 05 Sep 2017, Takashi Iwai wrote:
> > > > > > 
> > > > > > > On Tue, 05 Sep 2017 09:24:51 +0200,
> > > > > > > Lee Jones wrote:
> > > > > > > > 
> > > > > > > > On Mon, 04 Sep 2017, Takashi Iwai wrote:
> > > > > > > > 
> > > > > > > > > This patch adds the MFD driver for Dollar Cove (TI version) PMIC with
> > > > > > > > > ACPI INT33F5 that is found on some Intel Cherry Trail devices.
> > > > > > > > > The driver is based on the original work by Intel, found at:
> > > > > > > > >   https://github.com/01org/ProductionKernelQuilts
> > > > > > > > > 
> > > > > > > > > This is a minimal version for adding the basic resources.  Currently,
> > > > > > > > > only ACPI PMIC opregion and the external power-button are used.
> > > > > > > > > 
> > > > > > > > > Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=193891
> > > > > > > > > Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > > > > > > > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > > > > > > > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > > > > > > > > ---
> > > > > > > > > v4->v5:
> > > > > > > > > * Minor coding-style fixes suggested by Lee
> > > > > > > > > * Put GPL text
> > > > > > > > > v3->v4:
> > > > > > > > > * no change for this patch
> > > > > > > > > v2->v3:
> > > > > > > > > * Rename dc_ti with chtdc_ti in all places
> > > > > > > > > * Driver/kconfig renames accordingly
> > > > > > > > > * Added acks by Andy and Mika
> > > > > > > > > v1->v2:
> > > > > > > > > * Minor cleanups as suggested by Andy
> > > > > > > > > 
> > > > > > > > >  drivers/mfd/Kconfig                   |  13 +++
> > > > > > > > >  drivers/mfd/Makefile                  |   1 +
> > > > > > > > >  drivers/mfd/intel_soc_pmic_chtdc_ti.c | 184 ++++++++++++++++++++++++++++++++++
> > > > > > > > >  3 files changed, 198 insertions(+)
> > > > > > > > >  create mode 100644 drivers/mfd/intel_soc_pmic_chtdc_ti.c
> > > > > > > > 
> > > > > > > > For my own reference:
> > > > > > > >   Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> > > > > > > 
> > > > > > > Thanks!
> > > > > > > 
> > > > > > > Now the question is how to deal with these.  It's no critical things,
> > > > > > > so I'm OK to postpone for 4.15.  OTOH, it's really a new
> > > > > > > device-specific stuff, thus it can't break anything else, and it'd be
> > > > > > > fairly safe to add it for 4.14 although it's at a bit late stage.
> > > > > > 
> > > > > > Yes, you are over 2 weeks late for v4.14.  It will have to be v4.15.
> > > > > 
> > > > > OK, I'll ring your bells again once when 4.15 development is opened.
> > > > > 
> > > > > 
> > > > > > > IMO, it'd be great if you can carry all stuff through MFD tree; or
> > > > > > > create an immutable branch (again).  But how to handle it, when to do
> > > > > > > it, It's all up to you guys.
> > > > > > 
> > > > > > If there aren't any build dependencies between the patches, each of
> > > > > > the patches should be applied through their own trees.  What are the
> > > > > > build-time dependencies?  Are there any?
> > > > > 
> > > > > No, there is no strict build-time dependency.  It's just that I don't
> > > > > see it nice to have a commit for a dead code, partly for testing
> > > > > purpose and partly for code consistency.  But if this makes
> > > > > maintenance easier, I'm happy with that, too, of course.
> > > > 
> > > > There won't be any dead code.  All of the subsystem trees are pulled
> > > > into -next [0] where the build bots can operate on the patches as a
> > > > whole.
> > > 
> > > But the merge order isn't guaranteed, i.e. at the commit of other tree
> > > for this new stuff, it's a dead code without merging the MFD stuff
> > > beforehand.  e.g. Imagine to perform the git bisection.  It's not
> > > about the whole tree, but about the each commit.
> > 
> > Only *building* is relevant for bisection until the whole feature
> > lands.
> 
> Why only building?
> 
> When merging through several tress, commits for the same series are
> scattered completely although they are softly tied.  This sucks when
> you perform git bisection, e.g. if you have an issue in the middle of
> the patch series.  It still works, but it jumps unnecessarily too far
> away and back before reaching to the point, and kconfig appears /
> disappears inconsistently (the dependent kconfig gone in the middle).
> And, this is about the release kernel (4.15 or whatever).

Think about how bisection works.  You state a good commit and a bad
one.  The good commit will be when the feature last worked, which will
not be until the feature has fully landed.  Bisect will not check any
point prior to this date.

If there aren't any build deps, each Maintainer will apply patches
into their own tree.  These will be merged together in -next where
they can be tested, both manually and by the 0-days.  Once the merge
window is opened all patches will be sucked into -rc1.  If the feature
works here, then it you could use -rc1 as your 'good' commit.  If it
doesn't, then this could indicate a merge error or a missing piece of
the set, either way bisect wouldn't help you.

> Basically, my complaint here comes with my user's hat on.  It *is*
> indeed worse than a straight application of patches in some levels.
> It's unavoidable if you do in that way.

I disagree.  I user wouldn't set the 'good' commit at any point prior
to the feature working at least once.  This will not happen if any
parts were missing.  The order in which the pieces are applied is
irrelevant if there aren't any build deps between them.  If you bisect
between them, then the driver simply will not build.  No problem.

> OTOH, with maintainer's hat on, I do agree with that it'll make things
> often easier.  Judging with these merits and demerits, I find it's
> acceptable, too.
> 
> > No one is going to bisect the function of a feature until it
> > is present.  So long as there aren't any build-time dependencies then
> > we're good, 
> > 
> > > And I won't be surprised if 0-day build bot gets a new feature to
> > > inspect the kconfig files, spot a dead kconfig entry and warn
> > > maintainers at each commit, too :)
> > 
> > 
> > 0-days don't check for that and static analysers only check releases.
> 
> How can you guarantee that 0-days will not do that in future?
> I learned that I shouldn't be too naive about 0-day bot facility :)

Due to the way we operate, testing for dead code in between releases
would be foolish, since there would be too many false positives.
Static analysis is best for this and they are normally run on releases.

> In anyway, as I already mentioned, I'm fine with taking changes
> individually in each tree.  No need for further bike-shedding.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
