From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v5 1/3] mfd: Add support for Cherry Trail Dollar Cove TI
 PMIC
Date: Thu, 7 Sep 2017 14:00:01 +0100
Message-ID: <20170907130001.bkwuljsejrks63x3@dell>
References: <20170905072451.ephscqjqgwpnl6da@dell>
 <s5hmv69twov.wl-tiwai@suse.de>
 <20170905081049.r3gbdtr2iuom6uk6@dell>
 <s5hefrltv43.wl-tiwai@suse.de>
 <20170905085449.dsadovrpmpj6vsvv@dell>
 <s5htw0ej1l2.wl-tiwai@suse.de>
 <20170907105348.i52vnf732xpxjubq@dell>
 <s5hefriivmj.wl-tiwai@suse.de>
 <20170907122834.nhsd5pgv2azwdcg4@dell>
 <s5hvakuhdxy.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:34446 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755053AbdIGNAF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Sep 2017 09:00:05 -0400
Received: by mail-wm0-f53.google.com with SMTP id 137so33776416wmj.1
        for <linux-acpi@vger.kernel.org>; Thu, 07 Sep 2017 06:00:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <s5hvakuhdxy.wl-tiwai@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@linux.intel.com>, Johannes Stezenbach <js@sig21.net>, Hans de Goede <hdegoede@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

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
> > > > 
> > > > Since there are no deps between the patches, they should be applied
> > > > into their own trees (as previously discussed).  I only applied the
> > > > ACPI patch because Rafael asked me nicely.  Normally this should have
> > > > gone in separately too.
> > > 
> > > Andy already expressed his preference about the patch going through
> > > MFD tree in the v5 thread.  Below is the excerpt.
> > 
> > If Andy is happy for me to apply the patch without an immutable
> > branch, then I'll take it.  But as I've already said, this it
> > non-optimal.
> > 
> > There is no reason why it can't be taken in via the Platform tree.
> > Nothing depends on it and it depends on nothing, since it is new
> > code.
> 
> That approach is also far from optimal, too, as Rafael and I
> explained.

That's just my point.  This approach is optimal.

The alternative is that I (or someone else) jumps through the required
hoops to create an immutable branch.  As a one off, it's not actually
that big of a deal.  However, if I do it for you, I have to do it for
every submitter, else it's not fair to them.

MFD patch-sets inherently cross subsystem boundaries, which means I
would end up taking many more patches than I do already.  Subsequently
the per-cycle MFD pull-request exponentially grows in size, as does my
work load.

This is the way we've been working for years, and it works really
well.  I'm not about to change something which isn't broken, just to
avoid the really tiny corner-case you described before.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
