From: Dustin Byford <dustin@cumulusnetworks.com>
Subject: Re: [RFC v2 0/1] i2c: acpi: scan ACPI enumerated I2C mux channels
Date: Wed, 30 Sep 2015 10:54:26 -0700
Message-ID: <20150930175426.GB712@cumulusnetworks.com>
References: <1439510358-16664-1-git-send-email-dustin@cumulusnetworks.com>
 <20150929231912.GA7913@cumulusnetworks.com>
 <20150930094336.GF1551@lahna.fi.intel.com>
 <2521626.jxElES8O1e@vostro.rjw.lan>
 <20150930135702.GJ1551@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:34809 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753956AbbI3Ry2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Sep 2015 13:54:28 -0400
Received: by padhy16 with SMTP id hy16so47112706pad.1
        for <linux-acpi@vger.kernel.org>; Wed, 30 Sep 2015 10:54:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150930135702.GJ1551@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org

On Wed Sep 30 16:57, Mika Westerberg wrote:
> On Wed, Sep 30, 2015 at 02:52:28PM +0200, Rafael J. Wysocki wrote:
> > > >     Device (CH00) {
> > > >         Name (_ADR, 0x0)
> > > > 
> > > >         Device (TMP0) {
> > > >             Name (_ADR, 0x50)
> > > 
> > > ... and this are not needed. I2cSerialBus already contains the address.
> > > 
> > > Also I think you need to have "PRP0001" here as well.
> > 
> > The idea is to use _ADR kind of instead of "PRP0001" to express the "you
> > don't need a driver for this" idea AFAICS.
> 
> But I think it needs a driver and it even includes "compatible" string
> below :-)

Right, CH00 has just an _ADR, but TMP0 really needs a PRP0001.

> > > >             Name (_CRS, ResourceTemplate()
> > > >             {
> > > >                 I2cSerialBus (0x60, ControllerInitiated, I2C_SPEED,
> > > >                               AddressingMode7Bit, "^CH00", 0x00,
> > > >                               ResourceConsumer,,)
> > > >             })
> > > >             Name (_DSD, Package ()
> > > >             {
> > > >                 ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> > > >                 Package () {
> > > >                     Package (2) { "compatible", "national,lm75" },
> > > >                 }
> > > >             })
> > > >         }
> > > >     }
> > > > }

		--Dustin
