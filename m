From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 2/4] mfd: lpc_ich: Do not create iTCO watchdog when
 WDAT table exists
Date: Thu, 29 Sep 2016 18:20:00 +0100
Message-ID: <20160929172000.GC2844@dell>
References: <20160920123054.195021-1-mika.westerberg@linux.intel.com>
 <1611175.DW5CysW0GN@vostro.rjw.lan>
 <20160928010941.GR21388@dell>
 <3201345.Lem5P2ZXCJ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:34071 "EHLO
        mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755619AbcI2RRs (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 29 Sep 2016 13:17:48 -0400
Received: by mail-pa0-f51.google.com with SMTP id dw4so15949938pac.1
        for <linux-acpi@vger.kernel.org>; Thu, 29 Sep 2016 10:17:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <3201345.Lem5P2ZXCJ@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>, Len Brown <lenb@kernel.org>, Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, Peter Tyser <ptyser@xes-inc.com>, Zha Qipeng <qipeng.zha@intel.com>, Darren Hart <dvhart@infradead.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 28 Sep 2016, Rafael J. Wysocki wrote:

> On Wednesday, September 28, 2016 02:09:41 AM Lee Jones wrote:
> > On Wed, 28 Sep 2016, Rafael J. Wysocki wrote:
> > 
> > > On Tuesday, September 27, 2016 08:41:14 PM Lee Jones wrote:
> > > > On Tue, 20 Sep 2016, Mika Westerberg wrote:
> > > > 
> > > > > ACPI WDAT table is the preferred way to use hardware watchdog over the
> > > > > native iTCO_wdt. Windows only uses this table for its hardware watchdog
> > > > > implementation so we should be relatively safe to trust it has been
> > > > > validated by OEMs
> > > > > 
> > > > > Prevent iTCO watchdog creation if we detect that there is ACPI WDAT table.
> > > > > 
> > > > > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > > > Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> > > > > ---
> > > > >  drivers/mfd/lpc_ich.c | 4 ++++
> > > > >  1 file changed, 4 insertions(+)
> > > > 
> > > > Applied, thanks.
> > > 
> > > Well, I applied this too.
> > 
> > How can you apply this without an MFD Ack?
> 
> First, Guenter has reviewed it.

Guenter isn't the MFD Maintiner.

> Second, there was no response to this:
> 
> http://marc.info/?l=linux-acpi&m=147467687316117&w=4

This in my queue.  I was on vacation last week.

> > > And it depends on the [1/4], doesn't it?
> > 
> > Yes, I just found that out myself. :)
> > 
> > Well I only have 4 lines of changes in drivers/mfd/lpc_ich.c, so I
> > guess it'll be okay to apply this without the fear of conflicts.
> > 
> > Do that end, please apply my:
> > 
> > Acked-by: Lee Jones <lee.jones@linaro.org>
> 
> Thanks!

NP

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
