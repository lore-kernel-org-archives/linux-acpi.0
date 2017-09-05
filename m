From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v5 1/3] mfd: Add support for Cherry Trail Dollar Cove TI
 PMIC
Date: Tue, 5 Sep 2017 09:54:49 +0100
Message-ID: <20170905085449.dsadovrpmpj6vsvv@dell>
References: <20170904144340.27693-1-tiwai@suse.de>
 <20170904144340.27693-2-tiwai@suse.de>
 <20170905072451.ephscqjqgwpnl6da@dell>
 <s5hmv69twov.wl-tiwai@suse.de>
 <20170905081049.r3gbdtr2iuom6uk6@dell>
 <s5hefrltv43.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:37169 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751544AbdIEIyx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Sep 2017 04:54:53 -0400
Received: by mail-wm0-f50.google.com with SMTP id u26so15732476wma.0
        for <linux-acpi@vger.kernel.org>; Tue, 05 Sep 2017 01:54:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <s5hefrltv43.wl-tiwai@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@linux.intel.com>, Johannes Stezenbach <js@sig21.net>, Hans de Goede <hdegoede@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 05 Sep 2017, Takashi Iwai wrote:

> On Tue, 05 Sep 2017 10:10:49 +0200,
> Lee Jones wrote:
> > 
> > On Tue, 05 Sep 2017, Takashi Iwai wrote:
> > 
> > > On Tue, 05 Sep 2017 09:24:51 +0200,
> > > Lee Jones wrote:
> > > > 
> > > > On Mon, 04 Sep 2017, Takashi Iwai wrote:
> > > > 
> > > > > This patch adds the MFD driver for Dollar Cove (TI version) PMIC with
> > > > > ACPI INT33F5 that is found on some Intel Cherry Trail devices.
> > > > > The driver is based on the original work by Intel, found at:
> > > > >   https://github.com/01org/ProductionKernelQuilts
> > > > > 
> > > > > This is a minimal version for adding the basic resources.  Currently,
> > > > > only ACPI PMIC opregion and the external power-button are used.
> > > > > 
> > > > > Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=193891
> > > > > Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > > > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > > > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > > > > ---
> > > > > v4->v5:
> > > > > * Minor coding-style fixes suggested by Lee
> > > > > * Put GPL text
> > > > > v3->v4:
> > > > > * no change for this patch
> > > > > v2->v3:
> > > > > * Rename dc_ti with chtdc_ti in all places
> > > > > * Driver/kconfig renames accordingly
> > > > > * Added acks by Andy and Mika
> > > > > v1->v2:
> > > > > * Minor cleanups as suggested by Andy
> > > > > 
> > > > >  drivers/mfd/Kconfig                   |  13 +++
> > > > >  drivers/mfd/Makefile                  |   1 +
> > > > >  drivers/mfd/intel_soc_pmic_chtdc_ti.c | 184 ++++++++++++++++++++++++++++++++++
> > > > >  3 files changed, 198 insertions(+)
> > > > >  create mode 100644 drivers/mfd/intel_soc_pmic_chtdc_ti.c
> > > > 
> > > > For my own reference:
> > > >   Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> > > 
> > > Thanks!
> > > 
> > > Now the question is how to deal with these.  It's no critical things,
> > > so I'm OK to postpone for 4.15.  OTOH, it's really a new
> > > device-specific stuff, thus it can't break anything else, and it'd be
> > > fairly safe to add it for 4.14 although it's at a bit late stage.
> > 
> > Yes, you are over 2 weeks late for v4.14.  It will have to be v4.15.
> 
> OK, I'll ring your bells again once when 4.15 development is opened.

Please don't.  Just collect all the Acks you have received and sent
out the set again changing [PATCH] for [RESEND].  Only if there
haven't been any code changes of course. 

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
