From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v5 1/3] mfd: Add support for Cherry Trail Dollar Cove TI
 PMIC
Date: Thu, 7 Sep 2017 13:24:00 +0100
Message-ID: <20170907122400.75s6ylzkglerenxt@dell>
References: <20170904144340.27693-1-tiwai@suse.de>
 <s5htw0ej1l2.wl-tiwai@suse.de>
 <20170907105348.i52vnf732xpxjubq@dell>
 <4262027.ElY9A0iLZM@aspire.rjw.lan>
 <20170907111747.gk3rmsbbmu4c5icv@dell>
 <s5hd172ivi4.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:34883 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932070AbdIGMYF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Sep 2017 08:24:05 -0400
Received: by mail-wm0-f46.google.com with SMTP id f199so2804091wme.0
        for <linux-acpi@vger.kernel.org>; Thu, 07 Sep 2017 05:24:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <s5hd172ivi4.wl-tiwai@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Johannes Stezenbach <js@sig21.net>, Hans de Goede <hdegoede@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 07 Sep 2017, Takashi Iwai wrote:

> On Thu, 07 Sep 2017 13:17:47 +0200,
> Lee Jones wrote:
> > 
> > On Thu, 07 Sep 2017, Rafael J. Wysocki wrote:
> > 
> > > On Thursday, September 7, 2017 12:53:48 PM CEST Lee Jones wrote:
> > > > On Thu, 07 Sep 2017, Takashi Iwai wrote:
> > > > 
> > > > > On Tue, 05 Sep 2017 10:54:49 +0200,
> > > > > Lee Jones wrote:
> > > > > > 
> > > > > > On Tue, 05 Sep 2017, Takashi Iwai wrote:
> > > > > > 
> > > > > > > On Tue, 05 Sep 2017 10:10:49 +0200,
> > > > > > > Lee Jones wrote:
> > > > > > > > 
> > > > > > > > On Tue, 05 Sep 2017, Takashi Iwai wrote:
> > > > > > > > 
> > > > > > > > > On Tue, 05 Sep 2017 09:24:51 +0200,
> > > > > > > > > Lee Jones wrote:
> > > > > > > > > > 
> > > > > > > > > > On Mon, 04 Sep 2017, Takashi Iwai wrote:
> > > > > > > > > > 
> > > > > > > > > > > This patch adds the MFD driver for Dollar Cove (TI version) PMIC with
> > > > > > > > > > > ACPI INT33F5 that is found on some Intel Cherry Trail devices.
> > > > > > > > > > > The driver is based on the original work by Intel, found at:
> > > > > > > > > > >   https://github.com/01org/ProductionKernelQuilts
> > > > > > > > > > > 
> > > > > > > > > > > This is a minimal version for adding the basic resources.  Currently,
> > > > > > > > > > > only ACPI PMIC opregion and the external power-button are used.
> > > > > > > > > > > 
> > > > > > > > > > > Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=193891
> > > > > > > > > > > Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > > > > > > > > > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > > > > > > > > > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > > > > > > > > > > ---
> > > > > > > > > > > v4->v5:
> > > > > > > > > > > * Minor coding-style fixes suggested by Lee
> > > > > > > > > > > * Put GPL text
> > > > > > > > > > > v3->v4:
> > > > > > > > > > > * no change for this patch
> > > > > > > > > > > v2->v3:
> > > > > > > > > > > * Rename dc_ti with chtdc_ti in all places
> > > > > > > > > > > * Driver/kconfig renames accordingly
> > > > > > > > > > > * Added acks by Andy and Mika
> > > > > > > > > > > v1->v2:
> > > > > > > > > > > * Minor cleanups as suggested by Andy
> > > > > > > > > > > 
> > > > > > > > > > >  drivers/mfd/Kconfig                   |  13 +++
> > > > > > > > > > >  drivers/mfd/Makefile                  |   1 +
> > > > > > > > > > >  drivers/mfd/intel_soc_pmic_chtdc_ti.c | 184 ++++++++++++++++++++++++++++++++++
> > > > > > > > > > >  3 files changed, 198 insertions(+)
> > > > > > > > > > >  create mode 100644 drivers/mfd/intel_soc_pmic_chtdc_ti.c
> > > > > > > > > > 
> > > > > > > > > > For my own reference:
> > > > > > > > > >   Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> > > > > > > > > 
> > > > > > > > > Thanks!
> > > > > > > > > 
> > > > > > > > > Now the question is how to deal with these.  It's no critical things,
> > > > > > > > > so I'm OK to postpone for 4.15.  OTOH, it's really a new
> > > > > > > > > device-specific stuff, thus it can't break anything else, and it'd be
> > > > > > > > > fairly safe to add it for 4.14 although it's at a bit late stage.
> > > > > > > > 
> > > > > > > > Yes, you are over 2 weeks late for v4.14.  It will have to be v4.15.
> > > > > > > 
> > > > > > > OK, I'll ring your bells again once when 4.15 development is opened.
> > > > > > 
> > > > > > Please don't.  Just collect all the Acks you have received and sent
> > > > > > out the set again changing [PATCH] for [RESEND].  Only if there
> > > > > > haven't been any code changes of course. 
> > > > >   
> > > > > You seem to have applied the patches in some branch, but still do I
> > > > > need to resend the whole patches?
> > > > 
> > > > That's up to the Platform Maintainers.
> > > > 
> > > > Since the MFD and ACPI are applied, you do not need to resend those.
> > > > 
> > > > > BTW, was patch 2/3 applied?  I miss your notification mail.
> > > > 
> > > > Patch 2 needs to be applied into the Platform tree.
> > > 
> > > Actually, that's drivers/platform/x86/ so it falls under
> > > X86 PLATFORM DRIVERS and it has already been ACKed by Andy who is
> > > one of the maintainers of that.
> > > 
> > > Andy, Darren, can patch [2/3] from this series go in via the MFD tree?
> > 
> > ... without an immutable branch.
> 
> Why can't it be immutable?  You just don't branch off the commit
> containing these three patches, and don't touch any longer on that, so
> that other trees can pull it in; it's all what we need.

Firstly, the MFD main branch is not immutable.

Secondly, you cannot simply pull a patch in from another tree.  All of
the patches before it and your local base will be pulled in too.  This
is why we create purposely created immutable branches which *only*
contain the patches required by other repos.

> > Which also means all changes to this
> > file due for v4.15 would have to come in via the MFD tree too.
> > 
> > This is sub optimal IMHO.  I'd rather it was fed through the proper
> > tree(s), so we can continue our normal flow for subsequent changes.
> 
> Other trees sometimes pull this kind of "immutable" branches, too.
> I see no big problem there.

There are no valid reason to create an IB for this case.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
