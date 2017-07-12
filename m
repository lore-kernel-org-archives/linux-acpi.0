From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/3] ACPI / X86: Allow matching always_present_id array entries by DMI
Date: Wed, 12 Jul 2017 23:22:29 +0200
Message-ID: <3621134.B5yKqrfy72@aspire.rjw.lan>
References: <20170709190514.3437-1-hdegoede@redhat.com> <20605f11-e788-6dd5-74e7-28a31b00d599@redhat.com> <1499711994.22624.330.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:56080 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752614AbdGLVaM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 12 Jul 2017 17:30:12 -0400
In-Reply-To: <1499711994.22624.330.camel@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On Monday, July 10, 2017 09:39:54 PM Andy Shevchenko wrote:
> On Mon, 2017-07-10 at 20:13 +0200, Hans de Goede wrote:
> > Hi,
> > 
> > On 10-07-17 16:25, Andy Shevchenko wrote:
> > > On Sun, 2017-07-09 at 21:05 +0200, Hans de Goede wrote:
> > > > On some X86 systems the DSDT hides APCI devices to work around
> > > > Windows
> > > > driver bugs. On one such system the device is even hidden until a
> > > > certain
> > > > time after _SB.PCI0.GFX0.LCD.LCD1._ON gets called has passed *and*
> > > > _STA has been called at least 3 times since. TL;DR: it is a mess.
> > > > 
> > > > Until now the always_present_id matching was used to force status
> > > > for a whole class of devices, e.g. always enable PWM1 on CHerry
> > > > Trail
> > > 
> > > Cherry
> > > 
> > > > devices.
> > > > 
> > > > This commit extends the always_present_id matching code to
> > > > optionally
> > > > als check for a DMI match so that we can also add system specific
> > > > quirks to the always_present_id array.
> > > > 
> > > 
> > > I got answers to my questions (see thread), thus, FWIW,
> > > 
> > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 
> > Thank you, does that apply to the entire set or just the first patch ?
> 
> Entire series.

OK, series applied with your Reviewed-by, thanks!

