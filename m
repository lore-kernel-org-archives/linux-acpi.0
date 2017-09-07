From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v5 1/3] mfd: Add support for Cherry Trail Dollar Cove TI PMIC
Date: Thu, 07 Sep 2017 12:59:25 +0200
Message-ID: <4262027.ElY9A0iLZM@aspire.rjw.lan>
References: <20170904144340.27693-1-tiwai@suse.de> <s5htw0ej1l2.wl-tiwai@suse.de> <20170907105348.i52vnf732xpxjubq@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:60341 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754953AbdIGLIS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Sep 2017 07:08:18 -0400
In-Reply-To: <20170907105348.i52vnf732xpxjubq@dell>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>
Cc: Takashi Iwai <tiwai@suse.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, Johannes Stezenbach <js@sig21.net>, Hans de Goede <hdegoede@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Thursday, September 7, 2017 12:53:48 PM CEST Lee Jones wrote:
> On Thu, 07 Sep 2017, Takashi Iwai wrote:
> 
> > On Tue, 05 Sep 2017 10:54:49 +0200,
> > Lee Jones wrote:
> > > 
> > > On Tue, 05 Sep 2017, Takashi Iwai wrote:
> > > 
> > > > On Tue, 05 Sep 2017 10:10:49 +0200,
> > > > Lee Jones wrote:
> > > > > 
> > > > > On Tue, 05 Sep 2017, Takashi Iwai wrote:
> > > > > 
> > > > > > On Tue, 05 Sep 2017 09:24:51 +0200,
> > > > > > Lee Jones wrote:
> > > > > > > 
> > > > > > > On Mon, 04 Sep 2017, Takashi Iwai wrote:
> > > > > > > 
> > > > > > > > This patch adds the MFD driver for Dollar Cove (TI version) PMIC with
> > > > > > > > ACPI INT33F5 that is found on some Intel Cherry Trail devices.
> > > > > > > > The driver is based on the original work by Intel, found at:
> > > > > > > >   https://github.com/01org/ProductionKernelQuilts
> > > > > > > > 
> > > > > > > > This is a minimal version for adding the basic resources.  Currently,
> > > > > > > > only ACPI PMIC opregion and the external power-button are used.
> > > > > > > > 
> > > > > > > > Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=193891
> > > > > > > > Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > > > > > > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > > > > > > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > > > > > > > ---
> > > > > > > > v4->v5:
> > > > > > > > * Minor coding-style fixes suggested by Lee
> > > > > > > > * Put GPL text
> > > > > > > > v3->v4:
> > > > > > > > * no change for this patch
> > > > > > > > v2->v3:
> > > > > > > > * Rename dc_ti with chtdc_ti in all places
> > > > > > > > * Driver/kconfig renames accordingly
> > > > > > > > * Added acks by Andy and Mika
> > > > > > > > v1->v2:
> > > > > > > > * Minor cleanups as suggested by Andy
> > > > > > > > 
> > > > > > > >  drivers/mfd/Kconfig                   |  13 +++
> > > > > > > >  drivers/mfd/Makefile                  |   1 +
> > > > > > > >  drivers/mfd/intel_soc_pmic_chtdc_ti.c | 184 ++++++++++++++++++++++++++++++++++
> > > > > > > >  3 files changed, 198 insertions(+)
> > > > > > > >  create mode 100644 drivers/mfd/intel_soc_pmic_chtdc_ti.c
> > > > > > > 
> > > > > > > For my own reference:
> > > > > > >   Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> > > > > > 
> > > > > > Thanks!
> > > > > > 
> > > > > > Now the question is how to deal with these.  It's no critical things,
> > > > > > so I'm OK to postpone for 4.15.  OTOH, it's really a new
> > > > > > device-specific stuff, thus it can't break anything else, and it'd be
> > > > > > fairly safe to add it for 4.14 although it's at a bit late stage.
> > > > > 
> > > > > Yes, you are over 2 weeks late for v4.14.  It will have to be v4.15.
> > > > 
> > > > OK, I'll ring your bells again once when 4.15 development is opened.
> > > 
> > > Please don't.  Just collect all the Acks you have received and sent
> > > out the set again changing [PATCH] for [RESEND].  Only if there
> > > haven't been any code changes of course. 
> >   
> > You seem to have applied the patches in some branch, but still do I
> > need to resend the whole patches?
> 
> That's up to the Platform Maintainers.
> 
> Since the MFD and ACPI are applied, you do not need to resend those.
> 
> > BTW, was patch 2/3 applied?  I miss your notification mail.
> 
> Patch 2 needs to be applied into the Platform tree.

Actually, that's drivers/platform/x86/ so it falls under
X86 PLATFORM DRIVERS and it has already been ACKed by Andy who is
one of the maintainers of that.

Andy, Darren, can patch [2/3] from this series go in via the MFD tree?

Thanks,
Rafael

