From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v5 1/3] mfd: Add support for Cherry Trail Dollar Cove TI
 PMIC
Date: Wed, 6 Sep 2017 11:50:25 +0100
Message-ID: <20170906105025.onbkawultjmyc5bz@dell>
References: <20170904144340.27693-1-tiwai@suse.de>
 <20170906090504.oo5equym533u7u5q@dell>
 <s5hshg0kuo5.wl-tiwai@suse.de>
 <1783868.XLEivnFYIC@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:34648 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752557AbdIFKua (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Sep 2017 06:50:30 -0400
Received: by mail-wm0-f49.google.com with SMTP id 137so27125319wmj.1
        for <linux-acpi@vger.kernel.org>; Wed, 06 Sep 2017 03:50:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1783868.XLEivnFYIC@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Takashi Iwai <tiwai@suse.de>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Johannes Stezenbach <js@sig21.net>, Hans de Goede <hdegoede@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 06 Sep 2017, Rafael J. Wysocki wrote:

> On Wednesday, September 6, 2017 12:06:50 PM CEST Takashi Iwai wrote:
> > On Wed, 06 Sep 2017 11:05:04 +0200,
> > Lee Jones wrote:
> > > 
> > > On Wed, 06 Sep 2017, Takashi Iwai wrote:
> > > 
> > > > On Wed, 06 Sep 2017 09:54:44 +0200,
> > > > Lee Jones wrote:
> > > > > 
> > > > > On Tue, 05 Sep 2017, Takashi Iwai wrote:
> > > > > 
> > > > > > On Tue, 05 Sep 2017 10:53:41 +0200,
> > > > > > Lee Jones wrote:
> > > > > > > 
> > > > > > > On Tue, 05 Sep 2017, Takashi Iwai wrote:
> > > > > > > 
> > > > > > > > On Tue, 05 Sep 2017 10:10:49 +0200,
> > > > > > > > Lee Jones wrote:
> > > > > > > > > 
> > > > > > > > > On Tue, 05 Sep 2017, Takashi Iwai wrote:
> > > > > > > > > 
> > > > > > > > > > On Tue, 05 Sep 2017 09:24:51 +0200,
> > > > > > > > > > Lee Jones wrote:
> > > > > > > > > > > 
> > > > > > > > > > > On Mon, 04 Sep 2017, Takashi Iwai wrote:
> > > > > > > > > > > 
> > > > > > > > > > > > This patch adds the MFD driver for Dollar Cove (TI version) PMIC with
> > > > > > > > > > > > ACPI INT33F5 that is found on some Intel Cherry Trail devices.
> > > > > > > > > > > > The driver is based on the original work by Intel, found at:
> > > > > > > > > > > >   https://github.com/01org/ProductionKernelQuilts
> > > > > > > > > > > > 
> > > > > > > > > > > > This is a minimal version for adding the basic resources.  Currently,
> > > > > > > > > > > > only ACPI PMIC opregion and the external power-button are used.
> > > > > > > > > > > > 
> > > > > > > > > > > > Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=193891
> > > > > > > > > > > > Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > > > > > > > > > > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > > > > > > > > > > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > > > > > > > > > > > ---
> > > > > > > > > > > > v4->v5:
> > > > > > > > > > > > * Minor coding-style fixes suggested by Lee
> > > > > > > > > > > > * Put GPL text
> > > > > > > > > > > > v3->v4:
> > > > > > > > > > > > * no change for this patch
> > > > > > > > > > > > v2->v3:
> > > > > > > > > > > > * Rename dc_ti with chtdc_ti in all places
> > > > > > > > > > > > * Driver/kconfig renames accordingly
> > > > > > > > > > > > * Added acks by Andy and Mika
> > > > > > > > > > > > v1->v2:
> > > > > > > > > > > > * Minor cleanups as suggested by Andy
> > > > > > > > > > > > 
> > > > > > > > > > > >  drivers/mfd/Kconfig                   |  13 +++
> > > > > > > > > > > >  drivers/mfd/Makefile                  |   1 +
> > > > > > > > > > > >  drivers/mfd/intel_soc_pmic_chtdc_ti.c | 184 ++++++++++++++++++++++++++++++++++
> > > > > > > > > > > >  3 files changed, 198 insertions(+)
> > > > > > > > > > > >  create mode 100644 drivers/mfd/intel_soc_pmic_chtdc_ti.c
> > > > > > > > > > > 
> > > > > > > > > > > For my own reference:
> > > > > > > > > > >   Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> > > > > > > > > > 
> > > > > > > > > > Thanks!
> > > > > > > > > > 
> > > > > > > > > > Now the question is how to deal with these.  It's no critical things,
> > > > > > > > > > so I'm OK to postpone for 4.15.  OTOH, it's really a new
> > > > > > > > > > device-specific stuff, thus it can't break anything else, and it'd be
> > > > > > > > > > fairly safe to add it for 4.14 although it's at a bit late stage.
> > > > > > > > > 
> > > > > > > > > Yes, you are over 2 weeks late for v4.14.  It will have to be v4.15.
> > > > > > > > 
> > > > > > > > OK, I'll ring your bells again once when 4.15 development is opened.
> > > > > > > > 
> > > > > > > > 
> > > > > > > > > > IMO, it'd be great if you can carry all stuff through MFD tree; or
> > > > > > > > > > create an immutable branch (again).  But how to handle it, when to do
> > > > > > > > > > it, It's all up to you guys.
> > > > > > > > > 
> > > > > > > > > If there aren't any build dependencies between the patches, each of
> > > > > > > > > the patches should be applied through their own trees.  What are the
> > > > > > > > > build-time dependencies?  Are there any?
> > > > > > > > 
> > > > > > > > No, there is no strict build-time dependency.  It's just that I don't
> > > > > > > > see it nice to have a commit for a dead code, partly for testing
> > > > > > > > purpose and partly for code consistency.  But if this makes
> > > > > > > > maintenance easier, I'm happy with that, too, of course.
> > > > > > > 
> > > > > > > There won't be any dead code.  All of the subsystem trees are pulled
> > > > > > > into -next [0] where the build bots can operate on the patches as a
> > > > > > > whole.
> > > > > > 
> > > > > > But the merge order isn't guaranteed, i.e. at the commit of other tree
> > > > > > for this new stuff, it's a dead code without merging the MFD stuff
> > > > > > beforehand.  e.g. Imagine to perform the git bisection.  It's not
> > > > > > about the whole tree, but about the each commit.
> > > > > 
> > > > > Only *building* is relevant for bisection until the whole feature
> > > > > lands.
> > > > 
> > > > Why only building?
> > > > 
> > > > When merging through several tress, commits for the same series are
> > > > scattered completely although they are softly tied.  This sucks when
> > > > you perform git bisection, e.g. if you have an issue in the middle of
> > > > the patch series.  It still works, but it jumps unnecessarily too far
> > > > away and back before reaching to the point, and kconfig appears /
> > > > disappears inconsistently (the dependent kconfig gone in the middle).
> > > > And, this is about the release kernel (4.15 or whatever).
> > > 
> > > Think about how bisection works.  You state a good commit and a bad
> > > one.  The good commit will be when the feature last worked, which will
> > > not be until the feature has fully landed.  Bisect will not check any
> > > point prior to this date.
> > > 
> > > If there aren't any build deps, each Maintainer will apply patches
> > > into their own tree.  These will be merged together in -next where
> > > they can be tested, both manually and by the 0-days.  Once the merge
> > > window is opened all patches will be sucked into -rc1.  If the feature
> > > works here, then it you could use -rc1 as your 'good' commit.  If it
> > > doesn't, then this could indicate a merge error or a missing piece of
> > > the set, either way bisect wouldn't help you.
> > 
> > Not really.
> > 
> > First of all, most of user start testing from the release kernel, so
> > you can't trust that RC covered all test cases.  (Who can blame users
> > who didn't use / test RC?)
> > 
> > Second, you ignore the fact that the development continues after
> > merging *this* patchset.  What if a breakage is introduced after this
> > patch?  (See below)
> > 
> > They often need a full bisection between the previous release and the
> > current release.
> > 
> > > > Basically, my complaint here comes with my user's hat on.  It *is*
> > > > indeed worse than a straight application of patches in some levels.
> > > > It's unavoidable if you do in that way.
> > > 
> > > I disagree.  I user wouldn't set the 'good' commit at any point prior
> > > to the feature working at least once.
> > 
> > Again no, not all users do test at the same time.  A device driver
> > may support multiple devices / platforms, and it might be that the bug
> > manifests itself only on a certain system that no one has tested
> > beforehand; it's a typical case we often see after the releases.
> > 
> > > This will not happen if any
> > > parts were missing.  The order in which the pieces are applied is
> > > irrelevant if there aren't any build deps between them.  If you bisect
> > > between them, then the driver simply will not build.  No problem.
> > 
> > The bisection is required not only for build errors but also for
> > functional tests.  Sometimes it's the only way to spot the culprit of
> > a functional regression.
> > 
> > Imagine the following case: both MFD and platform drivers are merged
> > into individual trees separately.  And, some change in platform driver
> > after this patch series broke some functionality mistakenly.
> > 
> > Now, suppose that the platform tree is merged to Linus tree before MFD
> > tree, that is, the situation is like:
> > 
> >   MFD (commit A1) -- ... -------------------------+
> >   platform (commit B1) -> broken change (B2) -+   |
> >                                               v   v
> >                                             --M1--M2--> Linus RC1
> > 
> > git-bisection can inspect M2, which shows already broken.  Then it
> > inspects M1, but you can't evaluate it because the target platform
> > driver can't be built without A1.  At this point, you're stuck.
> > But in this case, B1 is correct and B2 is the culprit.  How can you
> > spot it out?
> > 
> > OTOH, if the merge history honors the functional dependency, you can
> > bisect properly.
> 
> Exactly and not only that.
> 
> If the git history reflects the logical dependencies between patches,
> you should be able to figure out the reason why the code was changed
> this way (sometimes you can't anyway if commit logs suck, for example,
> but this is a different problem) which quite often is essential for
> debugging, backporting and similar.

The example you reference is a really small corner case (I don't
recall an occurrence) and is very easy to debug without bisect.  The
pros of taking patches in via their pre-defined subsystem trees far
outweighs the slight possibility and the debugging complexity of this
example.
 
-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
