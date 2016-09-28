From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 2/4] mfd: lpc_ich: Do not create iTCO watchdog when WDAT table exists
Date: Wed, 28 Sep 2016 03:24:52 +0200
Message-ID: <3201345.Lem5P2ZXCJ@vostro.rjw.lan>
References: <20160920123054.195021-1-mika.westerberg@linux.intel.com> <1611175.DW5CysW0GN@vostro.rjw.lan> <20160928010941.GR21388@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:49423 "HELO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1753785AbcI1BS1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 27 Sep 2016 21:18:27 -0400
In-Reply-To: <20160928010941.GR21388@dell>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>, Len Brown <lenb@kernel.org>, Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, Peter Tyser <ptyser@xes-inc.com>, Zha Qipeng <qipeng.zha@intel.com>, Darren Hart <dvhart@infradead.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday, September 28, 2016 02:09:41 AM Lee Jones wrote:
> On Wed, 28 Sep 2016, Rafael J. Wysocki wrote:
> 
> > On Tuesday, September 27, 2016 08:41:14 PM Lee Jones wrote:
> > > On Tue, 20 Sep 2016, Mika Westerberg wrote:
> > > 
> > > > ACPI WDAT table is the preferred way to use hardware watchdog over the
> > > > native iTCO_wdt. Windows only uses this table for its hardware watchdog
> > > > implementation so we should be relatively safe to trust it has been
> > > > validated by OEMs
> > > > 
> > > > Prevent iTCO watchdog creation if we detect that there is ACPI WDAT table.
> > > > 
> > > > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > > Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> > > > ---
> > > >  drivers/mfd/lpc_ich.c | 4 ++++
> > > >  1 file changed, 4 insertions(+)
> > > 
> > > Applied, thanks.
> > 
> > Well, I applied this too.
> 
> How can you apply this without an MFD Ack?

First, Guenter has reviewed it.

Second, there was no response to this:

http://marc.info/?l=linux-acpi&m=147467687316117&w=4

> > And it depends on the [1/4], doesn't it?
> 
> Yes, I just found that out myself. :)
> 
> Well I only have 4 lines of changes in drivers/mfd/lpc_ich.c, so I
> guess it'll be okay to apply this without the fear of conflicts.
> 
> Do that end, please apply my:
> 
> Acked-by: Lee Jones <lee.jones@linaro.org>

Thanks!

Best,
Rafael

