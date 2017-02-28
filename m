From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2] ACPI / PMIC: Add opregion driver for Intel CHT
 WhiskeyCove PMIC
Date: Tue, 28 Feb 2017 13:27:22 +0200
Message-ID: <1488281242.20145.53.camel@linux.intel.com>
References: <20170227202628.5737-1-hdegoede@redhat.com>
         <CAHp75VfY3zu94ivvvfDU51RCUwRdXucQ_aKLR9GcPnPXMEWp1Q@mail.gmail.com>
         <62049bce-0aad-8f08-23fd-23be769c9e19@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:56819 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751728AbdB1Lar (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 28 Feb 2017 06:30:47 -0500
In-Reply-To: <62049bce-0aad-8f08-23fd-23be769c9e19@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>, Bin Gao <bin.gao@intel.com>, Felipe Balbi <felipe.balbi@linux.intel.com>

On Tue, 2017-02-28 at 12:18 +0100, Hans de Goede wrote:
> Hi,
> 
> Thnak you for the review.
> 
> On 27-02-17 22:50, Andy Shevchenko wrote:
> > On Mon, Feb 27, 2017 at 10:26 PM, Hans de Goede <hdegoede@redhat.com
> > > wrote:
> > > Add opregion driver for Intel CHT WhiskeyCove PMIC, based on
> > > various
> > > non upstreamed CHT WhiskeyCove PMIC patches. This does not include
> > > support for the Thermal opregion (DPTF) due to lacking
> > > documentation.
> > 
> > Couple of nitpicks.
> > 
> > > @@ -0,0 +1,232 @@
> > > +/*
> > > + * intel_pmic_chtwc.c - Intel CHT Whiskey Cove PMIC operation
> > > region driver
> > 
> > I would remove file name. You never know if it's going to be renamed
> > or not.
> > 
> > > +static int intel_cht_wc_pmic_update_power(struct regmap *regmap,
> > > int reg,
> > > +               int bit, bool on)
> > > +{
> > > +       u8 mask = bit;
> > > +
> > > +       return regmap_update_bits(regmap, reg, mask, on ? 1 : 0);
> > 
> > Hmm... Just leave one line?
> 
> Both fixed. I will send a new version together with a new version
> of the Intel CHT WhiskeyCove PMIC mfd driver.

Please add my

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
