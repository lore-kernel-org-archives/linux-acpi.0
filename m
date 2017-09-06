From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v5 1/3] mfd: Add support for Cherry Trail Dollar Cove TI
 PMIC
Date: Wed, 6 Sep 2017 14:51:13 +0100
Message-ID: <20170906135113.vztfak2bumqpjhos@dell>
References: <20170905072451.ephscqjqgwpnl6da@dell>
 <20170906104040.jtribzvrutdgmtqt@dell>
 <s5hk21cks9c.wl-tiwai@suse.de>
 <2820948.LZW4fHiiGQ@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2820948.LZW4fHiiGQ@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Takashi Iwai <tiwai@suse.de>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Johannes Stezenbach <js@sig21.net>, Hans de Goede <hdegoede@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wed, 06 Sep 2017, Rafael J. Wysocki wrote:

> On Wednesday, September 6, 2017 12:58:55 PM CEST Takashi Iwai wrote:
> > On Wed, 06 Sep 2017 12:40:40 +0200,
> > Lee Jones wrote:
> > > 
> > > On Wed, 06 Sep 2017, Takashi Iwai wrote:
> > > 
> > > > On Wed, 06 Sep 2017 11:05:04 +0200,
> > > > Lee Jones wrote:
> > > > > 
> > > > > On Wed, 06 Sep 2017, Takashi Iwai wrote:
> > > > > 
> > > > > > On Wed, 06 Sep 2017 09:54:44 +0200,
> > > > > > Lee Jones wrote:
> > > > > > > 
> > > > > > > On Tue, 05 Sep 2017, Takashi Iwai wrote:
> > > > > > > 
> > > > > > > > On Tue, 05 Sep 2017 10:53:41 +0200,
> > > > > > > > Lee Jones wrote:
> > > > > > > > > 
> > > > > > > > > On Tue, 05 Sep 2017, Takashi Iwai wrote:
> > > > > > > > > 
> > > > > > > > > > On Tue, 05 Sep 2017 10:10:49 +0200,
> > > > > > > > > > Lee Jones wrote:
> > > > > > > > > > > 
> > > > > > > > > > > On Tue, 05 Sep 2017, Takashi Iwai wrote:
> > > > > > > > > > > 
> > > > > > > > > > > > On Tue, 05 Sep 2017 09:24:51 +0200,
> > > > > > > > > > > > Lee Jones wrote:
> > > > > > > > > > > > > 
> > > > > > > > > > > > > On Mon, 04 Sep 2017, Takashi Iwai wrote:
> > > > > > > > > > > > > 
> > > > > > > > > > > > > > This patch adds the MFD driver for Dollar Cove (TI version) PMIC with
> > > > > > > > > > > > > > ACPI INT33F5 that is found on some Intel Cherry Trail devices.
> > > > > > > > > > > > > > The driver is based on the original work by Intel, found at:
> > > > > > > > > > > > > >   https://github.com/01org/ProductionKernelQuilts
> > > > > > > > > > > > > > 
> > > > > > > > > > > > > > This is a minimal version for adding the basic resources.  Currently,
> > > > > > > > > > > > > > only ACPI PMIC opregion and the external power-button are used.
> > > > > > > > > > > > > > 
> > > > > > > > > > > > > > Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=193891
> > > > > > > > > > > > > > Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > > > > > > > > > > > > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > > > > > > > > > > > > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > > > > > > > > > > > > > ---
> > > > > > > > > > > > > > v4->v5:
> > > > > > > > > > > > > > * Minor coding-style fixes suggested by Lee
> > > > > > > > > > > > > > * Put GPL text
> > > > > > > > > > > > > > v3->v4:
> > > > > > > > > > > > > > * no change for this patch
> > > > > > > > > > > > > > v2->v3:
> > > > > > > > > > > > > > * Rename dc_ti with chtdc_ti in all places
> > > > > > > > > > > > > > * Driver/kconfig renames accordingly
> > > > > > > > > > > > > > * Added acks by Andy and Mika
> > > > > > > > > > > > > > v1->v2:
> > > > > > > > > > > > > > * Minor cleanups as suggested by Andy
> > > > > > > > > > > > > > 
> > > > > > > > > > > > > >  drivers/mfd/Kconfig                   |  13 +++
> > > > > > > > > > > > > >  drivers/mfd/Makefile                  |   1 +
> > > > > > > > > > > > > >  drivers/mfd/intel_soc_pmic_chtdc_ti.c | 184 ++++++++++++++++++++++++++++++++++
> > > > > > > > > > > > > >  3 files changed, 198 insertions(+)
> > > > > > > > > > > > > >  create mode 100644 drivers/mfd/intel_soc_pmic_chtdc_ti.c
> > > > > > > > > > > > > 
> > > > > > > > > > > > > For my own reference:
> > > > > > > > > > > > >   Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> > > > > > > > > > > > 
> > > > > > > > > > > > Thanks!
> > > > > > > > > > > > 
> > > > > > > > > > > > Now the question is how to deal with these.  It's no critical things,
> > > > > > > > > > > > so I'm OK to postpone for 4.15.  OTOH, it's really a new
> > > > > > > > > > > > device-specific stuff, thus it can't break anything else, and it'd be
> > > > > > > > > > > > fairly safe to add it for 4.14 although it's at a bit late stage.
> > > > > > > > > > > 
> > > > > > > > > > > Yes, you are over 2 weeks late for v4.14.  It will have to be v4.15.
> > > > > > > > > > 
> > > > > > > > > > OK, I'll ring your bells again once when 4.15 development is opened.
> > > > > > > > > > 
> > > > > > > > > > 
> > > > > > > > > > > > IMO, it'd be great if you can carry all stuff through MFD tree; or
> > > > > > > > > > > > create an immutable branch (again).  But how to handle it, when to do
> > > > > > > > > > > > it, It's all up to you guys.
> > > > > > > > > > > 
> > > > > > > > > > > If there aren't any build dependencies between the patches, each of
> > > > > > > > > > > the patches should be applied through their own trees.  What are the
> > > > > > > > > > > build-time dependencies?  Are there any?
> > > > > > > > > > 
> > > > > > > > > > No, there is no strict build-time dependency.  It's just that I don't
> > > > > > > > > > see it nice to have a commit for a dead code, partly for testing
> > > > > > > > > > purpose and partly for code consistency.  But if this makes
> > > > > > > > > > maintenance easier, I'm happy with that, too, of course.
> > > > > > > > > 
> > > > > > > > > There won't be any dead code.  All of the subsystem trees are pulled
> > > > > > > > > into -next [0] where the build bots can operate on the patches as a
> > > > > > > > > whole.
> > > > > > > > 
> > > > > > > > But the merge order isn't guaranteed, i.e. at the commit of other tree
> > > > > > > > for this new stuff, it's a dead code without merging the MFD stuff
> > > > > > > > beforehand.  e.g. Imagine to perform the git bisection.  It's not
> > > > > > > > about the whole tree, but about the each commit.
> > > > > > > 
> > > > > > > Only *building* is relevant for bisection until the whole feature
> > > > > > > lands.
> > > > > > 
> > > > > > Why only building?
> > > > > > 
> > > > > > When merging through several tress, commits for the same series are
> > > > > > scattered completely although they are softly tied.  This sucks when
> > > > > > you perform git bisection, e.g. if you have an issue in the middle of
> > > > > > the patch series.  It still works, but it jumps unnecessarily too far
> > > > > > away and back before reaching to the point, and kconfig appears /
> > > > > > disappears inconsistently (the dependent kconfig gone in the middle).
> > > > > > And, this is about the release kernel (4.15 or whatever).
> > > > > 
> > > > > Think about how bisection works.  You state a good commit and a bad
> > > > > one.  The good commit will be when the feature last worked, which will
> > > > > not be until the feature has fully landed.  Bisect will not check any
> > > > > point prior to this date.
> > > > > 
> > > > > If there aren't any build deps, each Maintainer will apply patches
> > > > > into their own tree.  These will be merged together in -next where
> > > > > they can be tested, both manually and by the 0-days.  Once the merge
> > > > > window is opened all patches will be sucked into -rc1.  If the feature
> > > > > works here, then it you could use -rc1 as your 'good' commit.  If it
> > > > > doesn't, then this could indicate a merge error or a missing piece of
> > > > > the set, either way bisect wouldn't help you.
> > > > 
> > > > Not really.
> > > > 
> > > > First of all, most of user start testing from the release kernel, so
> > > > you can't trust that RC covered all test cases.  (Who can blame users
> > > > who didn't use / test RC?)
> > > 
> > > That's fine.  We are not talking about spreading the merge of a
> > > patch-set over different releases, or even release candidates.  All
> > > non-bugfix patches should be in by -rc1.
> > > 
> > > > Second, you ignore the fact that the development continues after
> > > > merging *this* patchset.  What if a breakage is introduced after this
> > > > patch?  (See below)
> > > > 
> > > > They often need a full bisection between the previous release and the
> > > > current release.
> > > 
> > > You cannot bisect a specific function back before it was merged.  It's
> > > impossible.
> > > 
> > > P1 ---> P4 ---> P3 ---> P2
> > >                          ^
> > > Bisect only starts working here.  Prior to this point the feature
> > > doesn't build at all.  If it builds, but breaks, then that is a build
> > > dependency and is a different use-case to what we are discussing here.
> > 
> > OK, let me rephrase.  With the scenario above, user *cannot* perform
> > bisect.  Meanwhile, with the straight merge, you can bisect a
> > breakage.  That's a significant difference.
> > 
> > I.e. in the case where both commits A1, B1 and B2 are merged through
> > tree A an B.  B2 is the breakage.  With separate tree merges, you
> > cannot bisect, while the straight merge allows you to bisect B2.
> 
> Right, and that's really fundamental, because then the user can tell you
> "look, this commit doesn't work for me" instead of just "this kernel
> doesn't work for me" and now you need to spend *your* time on trying to
> figure out which commit may be at fault.
> 
> So speaking of benefits, I really prefer to avoid spending my time on
> such things. :-)

The toss-up is between splitting the patch-set up and *maybe* spending
time on debugging in the small chance of this occurring OR
*definitely* spending time creating immutable branches and sending out
pull-requests in the *hope* that all the other Maintainers involved
are diligent enough to merge it in order to avoid conflicts during
merge time.

In the circles I spend time in ("we"), the former is the favourite.

Until this point (and from this point going forward) we have taken the
decision that the default is to take individual patches through their
own trees.  The only time this differs (unless other arrangements are
made e.g. PATCH 3/3) is when there are; build, merge or API
dependencies between them.  The same stance is taken with
driver/platform data and driver/other driver.

Let me put one of the issues into context:

For those reading along that do not know, Multi-Functional Devices are
usually single pieces of silicon which provide many functions
(e.g. LED Controllers, Voltage Regulation, Power Management, Sensors,
Timers, GPIO/Pinctrl Controllers, Watchdog Timers, Real-Time Clocks,
etc etc).  The driver which sits in drivers/mfd acts as the parent
device and registers its children which live in their own subsystems.

Almost all of the patch-sets I receive touch multiple subsystems.
Moreover, when the recently described dependencies occur, it is
usually I who creates the immutable branches and sends out the
pull-requests.

If I had to go through the immutable branch/pull-request process for
every patch-set I receive, there would be very little time to conduct
duties pertaining to my proper job.  Ergo, why we apply our own
patches, unless there is a good reason (already described) to apply
others too.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
