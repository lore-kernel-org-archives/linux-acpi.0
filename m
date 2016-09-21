From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: Cherryview wake up events
Date: Wed, 21 Sep 2016 12:06:14 +0300
Message-ID: <20160921090614.GY1811@lahna.fi.intel.com>
References: <20160919112117.55dim46nmqdmqjan@sig21.net>
 <20160919115619.GF1811@lahna.fi.intel.com>
 <20160919203622.ujh4l5eudrncv3rl@sig21.net>
 <20160920091840.GN1811@lahna.fi.intel.com>
 <20160920101450.ylohouriienzrgtj@sig21.net>
 <20160920104014.GO1811@lahna.fi.intel.com>
 <20160920155943.zrj7wwgg7ugqyv6i@sig21.net>
 <20160920211153.y7ntwwik2l6ppoqz@sig21.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:51385 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753039AbcIUJIr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 21 Sep 2016 05:08:47 -0400
Content-Disposition: inline
In-Reply-To: <20160920211153.y7ntwwik2l6ppoqz@sig21.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Johannes Stezenbach <js@sig21.net>
Cc: linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Sep 20, 2016 at 11:11:53PM +0200, Johannes Stezenbach wrote:
> On Tue, Sep 20, 2016 at 05:59:43PM +0200, Johannes Stezenbach wrote:
> > On Tue, Sep 20, 2016 at 01:40:14PM +0300, Mika Westerberg wrote:
> > > If yes, it probably does not have the normal Fixed power button but
> > > instead it has something called "Windows button array device" with
> > > _HID/_CID of PNP0C40. Looking at your dsdt.dsl, this looks to be the
> > > case.
> > > 
> > > That device is driven by soc_button_array.c driver which can be enabled
> > > with CONFIG_KEYBOARD_GPIO=y and CONFIG_INPUT_SOC_BUTTON_ARRAY=y. Can you
> > > check if you have that enabled already?
> > > 
> > > You should actually see it in /proc/interrupts with names like "power"
> > > and so on.
> > 
> > I added CONFIG_INPUT_SOC_BUTTON_ARRAY=y, but no joy.
> > Maybe because the _HID is INTCFD9, only _CID is PNP0C40?
> > It also has a _DSM with UUID dfbcf3c5-e7a5-44e6-9c1f-29c76f6e059c.
> 
> Or it is because the PNP0C40 device depends on GpioInt from PMIC
> which isn't available...
> 
>             Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
>             {
>                 Name (CBUF, ResourceTemplate ()
>                 {
>                     GpioInt (Edge, ActiveBoth, ExclusiveAndWake, PullUp, 0x0BB8,
>                         "\\_SB.PCI0.I2C7.PMI2", 0x00, ResourceConsumer, ,
>                         )
>                         {   // Pin list
>                             0x0016
>                         }
>                 })
>                 Return (CBUF) /* \_SB_.TBAD._CRS.CBUF */
>             }

Most likely this is the reason. I'll try to find if we have an existing
driver for this PMIC somewhere. I guess this is the Dollar Cove which is
successor of Crystal Cove IIRC which is already supported by the
mainline kernel.
