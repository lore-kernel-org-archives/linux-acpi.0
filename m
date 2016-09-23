From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: Cherryview wake up events
Date: Fri, 23 Sep 2016 11:19:04 +0300
Message-ID: <20160923081904.GM1218@lahna.fi.intel.com>
References: <20160919112117.55dim46nmqdmqjan@sig21.net>
 <20160919115619.GF1811@lahna.fi.intel.com>
 <20160919203622.ujh4l5eudrncv3rl@sig21.net>
 <20160920091840.GN1811@lahna.fi.intel.com>
 <20160920101450.ylohouriienzrgtj@sig21.net>
 <20160920104014.GO1811@lahna.fi.intel.com>
 <20160920155943.zrj7wwgg7ugqyv6i@sig21.net>
 <20160920211153.y7ntwwik2l6ppoqz@sig21.net>
 <20160921090614.GY1811@lahna.fi.intel.com>
 <20160921091635.tjnc2gvj75jixycv@sig21.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:55394 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934891AbcIWI1w (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 23 Sep 2016 04:27:52 -0400
Content-Disposition: inline
In-Reply-To: <20160921091635.tjnc2gvj75jixycv@sig21.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Johannes Stezenbach <js@sig21.net>
Cc: linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, David Cohen <david.a.cohen@linux.intel.com>

On Wed, Sep 21, 2016 at 11:16:35AM +0200, Johannes Stezenbach wrote:
> On Wed, Sep 21, 2016 at 12:06:14PM +0300, Mika Westerberg wrote:
> > On Tue, Sep 20, 2016 at 11:11:53PM +0200, Johannes Stezenbach wrote:
> > > Or it is because the PNP0C40 device depends on GpioInt from PMIC
> > > which isn't available...
> > > 
> > >             Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
> > >             {
> > >                 Name (CBUF, ResourceTemplate ()
> > >                 {
> > >                     GpioInt (Edge, ActiveBoth, ExclusiveAndWake, PullUp, 0x0BB8,
> > >                         "\\_SB.PCI0.I2C7.PMI2", 0x00, ResourceConsumer, ,
> > >                         )
> > >                         {   // Pin list
> > >                             0x0016
> > >                         }
> > >                 })
> > >                 Return (CBUF) /* \_SB_.TBAD._CRS.CBUF */
> > >             }
> > 
> > Most likely this is the reason. I'll try to find if we have an existing
> > driver for this PMIC somewhere. I guess this is the Dollar Cove which is
> > successor of Crystal Cove IIRC which is already supported by the
> > mainline kernel.
> 
> There is an ADBG ("TI_DCOVE") in PMI2._STA, so Dollar Cove
> sounds like a good guess.

David (CC'd) is working on getting the Dollar Cove PMIC driver
upstreamed to the mainline kernel.
