From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH 2/3] spi / ACPI: add ACPI enumeration support
Date: Mon, 5 Nov 2012 13:23:50 +0100
Message-ID: <20121105132350.59c6e4d9@endymion.delvare>
References: <1351928793-14375-1-git-send-email-mika.westerberg@linux.intel.com>
	<20121103201310.GQ16648@intel.com>
	<1535917.BaYBBNgGy0@vostro.rjw.lan>
	<4052192.ry8JrGTr6H@vostro.rjw.lan>
	<20121105105602.GC24532@intel.com>
	<20121105105639.GE1385@opensource.wolfsonmicro.com>
	<20121105120219.GF24532@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from zoneX.GCU-Squad.org ([194.213.125.0]:10694 "EHLO
	services.gcu-squad.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750985Ab2KEMYJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Nov 2012 07:24:09 -0500
In-Reply-To: <20121105120219.GF24532@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org, lenb@kernel.org, rafael.j.wysocki@intel.com, grant.likely@secretlab.ca, linus.walleij@linaro.org, ben-linux@fluff.org, w.sang@pengutronix.de, mathias.nyman@linux.intel.com, linux-acpi@vger.kernel.org

On Mon, 5 Nov 2012 14:02:19 +0200, Mika Westerberg wrote:
> On Mon, Nov 05, 2012 at 11:56:39AM +0100, Mark Brown wrote:
> > I've got practical systems where there are multiple buses physically
> > connected, though in practice almost always only one is actually used at
> > runtime when it's I2C and SPI there are some systems (usually with other
> > buses) where you might want to use more than one bus.  Not sure those
> > buses will fit in here though.
> 
> Yeah, I just went through DSDT table of one of our machines and found a
> device that actually has two I2CSerialBus connectors (and those are to the
> same controller). What I'm not sure is that is it used to select between
> two different addresses or doest the device really have two physical I2C
> connections.

Neither would make sense from a hardware perspective.

-- 
Jean Delvare
