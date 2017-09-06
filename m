From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v5 1/3] mfd: Add support for Cherry Trail Dollar Cove TI
 PMIC
Date: Wed, 6 Sep 2017 11:47:23 +0100
Message-ID: <20170906104723.qs3b7p6p6x2ixmvb@dell>
References: <20170904144340.27693-1-tiwai@suse.de>
 <CAJZ5v0gvekbzJx6FhPjEGjTeAQVBa0uJZ=g-M_dYKrX6nLWUqg@mail.gmail.com>
 <20170906075852.xigwtpjsm5f65ehs@dell>
 <752349439.V0JAASK4Ip@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <752349439.V0JAASK4Ip@aspire.rjw.lan>
Sender: platform-driver-x86-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Takashi Iwai <tiwai@suse.de>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Johannes Stezenbach <js@sig21.net>, Hans de Goede <hdegoede@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Platform Driver <platform-driver-x86@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, 06 Sep 2017, Rafael J. Wysocki wrote:

> On Wednesday, September 6, 2017 9:58:52 AM CEST Lee Jones wrote:
> > On Tue, 05 Sep 2017, Rafael J. Wysocki wrote:
> > 
> > > On Tue, Sep 5, 2017 at 11:38 AM, Takashi Iwai <tiwai@suse.de> wrote:
> > > > On Tue, 05 Sep 2017 10:53:41 +0200,
> > > > Lee Jones wrote:
> > > >>
> > > >> On Tue, 05 Sep 2017, Takashi Iwai wrote:
> > > >>
> > > >> > On Tue, 05 Sep 2017 10:10:49 +0200,
> > > >> > Lee Jones wrote:
> > > >> > >
> > > >> > > On Tue, 05 Sep 2017, Takashi Iwai wrote:
> > > >> > >
> > > >> > > > On Tue, 05 Sep 2017 09:24:51 +0200,
> > > >> > > > Lee Jones wrote:
> > > >> > > > >
> > > >> > > > > On Mon, 04 Sep 2017, Takashi Iwai wrote:
> > > >> > > > >
> > > >> > > > > > This patch adds the MFD driver for Dollar Cove (TI version) PMIC with
> > > >> > > > > > ACPI INT33F5 that is found on some Intel Cherry Trail devices.
> > > >> > > > > > The driver is based on the original work by Intel, found at:
> > > >> > > > > >   https://github.com/01org/ProductionKernelQuilts
> > > >> > > > > >
> > > >> > > > > > This is a minimal version for adding the basic resources.  Currently,
> > > >> > > > > > only ACPI PMIC opregion and the external power-button are used.
> > > >> > > > > >
> > > >> > > > > > Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=193891
> > > >> > > > > > Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > >> > > > > > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > >> > > > > > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > > >> > > > > > ---
> > > >> > > > > > v4->v5:
> > > >> > > > > > * Minor coding-style fixes suggested by Lee
> > > >> > > > > > * Put GPL text
> > > >> > > > > > v3->v4:
> > > >> > > > > > * no change for this patch
> > > >> > > > > > v2->v3:
> > > >> > > > > > * Rename dc_ti with chtdc_ti in all places
> > > >> > > > > > * Driver/kconfig renames accordingly
> > > >> > > > > > * Added acks by Andy and Mika
> > > >> > > > > > v1->v2:
> > > >> > > > > > * Minor cleanups as suggested by Andy
> > > >> > > > > >
> > > >> > > > > >  drivers/mfd/Kconfig                   |  13 +++
> > > >> > > > > >  drivers/mfd/Makefile                  |   1 +
> > > >> > > > > >  drivers/mfd/intel_soc_pmic_chtdc_ti.c | 184 ++++++++++++++++++++++++++++++++++
> > > >> > > > > >  3 files changed, 198 insertions(+)
> > > >> > > > > >  create mode 100644 drivers/mfd/intel_soc_pmic_chtdc_ti.c
> > > >> > > > >
> > > >> > > > > For my own reference:
> > > >> > > > >   Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> > > >> > > >
> > > >> > > > Thanks!
> > > >> > > >
> > > >> > > > Now the question is how to deal with these.  It's no critical things,
> > > >> > > > so I'm OK to postpone for 4.15.  OTOH, it's really a new
> > > >> > > > device-specific stuff, thus it can't break anything else, and it'd be
> > > >> > > > fairly safe to add it for 4.14 although it's at a bit late stage.
> > > >> > >
> > > >> > > Yes, you are over 2 weeks late for v4.14.  It will have to be v4.15.
> > > >> >
> > > >> > OK, I'll ring your bells again once when 4.15 development is opened.
> > > >> >
> > > >> >
> > > >> > > > IMO, it'd be great if you can carry all stuff through MFD tree; or
> > > >> > > > create an immutable branch (again).  But how to handle it, when to do
> > > >> > > > it, It's all up to you guys.
> > > >> > >
> > > >> > > If there aren't any build dependencies between the patches, each of
> > > >> > > the patches should be applied through their own trees.  What are the
> > > >> > > build-time dependencies?  Are there any?
> > > >> >
> > > >> > No, there is no strict build-time dependency.  It's just that I don't
> > > >> > see it nice to have a commit for a dead code, partly for testing
> > > >> > purpose and partly for code consistency.  But if this makes
> > > >> > maintenance easier, I'm happy with that, too, of course.
> > > >>
> > > >> There won't be any dead code.  All of the subsystem trees are pulled
> > > >> into -next [0] where the build bots can operate on the patches as a
> > > >> whole.
> > > >
> > > > But the merge order isn't guaranteed, i.e. at the commit of other tree
> > > > for this new stuff, it's a dead code without merging the MFD stuff
> > > > beforehand.  e.g. Imagine to perform the git bisection.  It's not
> > > > about the whole tree, but about the each commit.
> > > >
> > > > And I won't be surprised if 0-day build bot gets a new feature to
> > > > inspect the kconfig files, spot a dead kconfig entry and warn
> > > > maintainers at each commit, too :)
> > > 
> > > So I would prefer the whole series to go in via one tree in one go,
> > > because it is a series for a reason. :-)
> > > 
> > > The patches do depend on each other logically even though there may
> > > not be hard build-time dependencies between them.  It would be sort of
> > > good if the git history reflected that logical dependency.
> > 
> > We *never* do this.
> 
> Who's we?  I sometimes do that, for one.  I guess Takashi does that too.
> The tip people do that on a regular basis and I know of at least several
> other top-level maintainers doing it at least occasionally.

The Maintainers who normally interact with MFD; Regulator,
GPIO/Pinctrl, Power, IIO, PWM, ARM-SoC, LED, HWMON, Input MTD, PHY,
Regmap, I2C, RTC, etc.

> > Only build-time dependencies warrant the hassle
> > of immutable branches and cross-subsystem committing.  Patches should
> > be taken in via their own subsystems unless it would cause merge or
> > build issues if we did.
> 
> I beg to differ, but whatever.
> 
> In any case, I wouldn't mind it if you took the [3/3] from this series, because
> if there are any conflicts with it, they will be trivial to resolve.  And I
> don't need an immutable branch with it or anything like that.

No problem.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
