From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: ACPI: Can I use I2cSerialBus with a PCI I2C controller?
Date: Fri, 23 Oct 2015 12:43:45 +0300
Message-ID: <20151023094345.GY1526@lahna.fi.intel.com>
References: <CAE7DoPZs69A5vLzDfrRXuC3q9fpkaXRYna2NQwHZk_BK9gLnvQ@mail.gmail.com>
 <20151021085056.GV1526@lahna.fi.intel.com>
 <CAE7DoPak939WjCWaGQw7W6aR0dZOcJCjcQK8gMa9iu+WRmnDDw@mail.gmail.com>
 <20151022080157.GI1526@lahna.fi.intel.com>
 <CAE7DoPY8+zw4xw0hWTmPoG4iPgC=2JRCT4bHqeqqaH+BywTWpw@mail.gmail.com>
 <CAE7DoPZfLDEBmeODQv3oEbs033gpq4oSA=Sx15wMajzVUbUinw@mail.gmail.com>
 <20151023082054.GP1526@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:21578 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751609AbbJWJns (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 23 Oct 2015 05:43:48 -0400
Content-Disposition: inline
In-Reply-To: <20151023082054.GP1526@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ben Gardner <gardner.ben@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Fri, Oct 23, 2015 at 11:20:54AM +0300, Mika Westerberg wrote:
> On Thu, Oct 22, 2015 at 12:17:58PM -0500, Ben Gardner wrote:
> > > The next issue is that the I2C-core isn't matching the device to the
> > > "at24" driver, which has the alias "24c02".
> > 
> > Here is what I found.
> > i2c-core is creating the device with the ACPI name "24C02:00".
> > The at24 driver uses "24c02" as the alias.
> > i2c-code is matching devices to drivers using strcmp().
> > 
> > Result: no match. ("24c02" != "24C02:00").
> > 
> > If I modify acpi_i2c_add_device() to cut off the name at the ':' and
> > covert to lowercase when populating info.type, it matches and works.
> > I must be missing something here, because this would have never worked as-is.
> > I'll ask on the I2C mailing list.
> 
> You should either use proper _HID/_CID for the device or put "PRP0001"
> to the _HID and let the match happen with DT .compatible strings. I've
> attached a hack that I use locally.

Alternatively you can use patch by Andy here:

https://patchwork.ozlabs.org/patch/524923
