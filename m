From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: ACPI: Can I use I2cSerialBus with a PCI I2C controller?
Date: Mon, 2 Nov 2015 12:25:02 +0200
Message-ID: <20151102102502.GC1509@lahna.fi.intel.com>
References: <CAE7DoPZs69A5vLzDfrRXuC3q9fpkaXRYna2NQwHZk_BK9gLnvQ@mail.gmail.com>
 <20151021085056.GV1526@lahna.fi.intel.com>
 <CAE7DoPak939WjCWaGQw7W6aR0dZOcJCjcQK8gMa9iu+WRmnDDw@mail.gmail.com>
 <20151022080157.GI1526@lahna.fi.intel.com>
 <CAE7DoPY8+zw4xw0hWTmPoG4iPgC=2JRCT4bHqeqqaH+BywTWpw@mail.gmail.com>
 <CAE7DoPZfLDEBmeODQv3oEbs033gpq4oSA=Sx15wMajzVUbUinw@mail.gmail.com>
 <20151023082054.GP1526@lahna.fi.intel.com>
 <20151027211111.GA6011@cumulusnetworks.com>
 <20151028090140.GL1548@lahna.fi.intel.com>
 <CAE7DoPbPuHTEZGvRTPrUXVCWLHwWPow9_1W15kHLTgXWQtwXUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:3045 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753398AbbKBKZT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 2 Nov 2015 05:25:19 -0500
Content-Disposition: inline
In-Reply-To: <CAE7DoPbPuHTEZGvRTPrUXVCWLHwWPow9_1W15kHLTgXWQtwXUw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ben Gardner <gardner.ben@gmail.com>
Cc: Dustin Byford <dustin@cumulusnetworks.com>, linux-acpi@vger.kernel.org

On Fri, Oct 30, 2015 at 11:51:01AM -0500, Ben Gardner wrote:
> It looks like you are supposed to have the first compatible entry be
> the exact manufacturer,model.
> http://devicetree.org/Device_Tree_Usage#Understanding_the_compatible_Property
> 
> I am considering using a generic compatible entry ("linux,at24") to
> match the Linux at24 driver.
> In my case, I'm using a M24C02 from ST, so the compatible line would be:
> 
>   Package () {"compatible", Package () {"st,m24c02", "linux,at24"}},
>   Package () {"size", 256},
>   Package () {"pagesize", 16},
> 
> The "linux,at24" would require the other properties (size and
> pagesize) to be present.
> I've seen something similar done with a few other devices.

Using "linux,foo" is not a good idea and I'm pretty sure DT maintainers
will not take such patches. The compatible (and other properties as
well) should describe hardware not software.

> > Alternatively we may use the same _HID "INT3499" as Andy is doing in his
> > series with the below properties.
> 
> The only issue with reusing INT3499 is that it is configured to be a
> 24C08 in the at24 driver.
> Reusing the 24C08 HID for a 24C02 or other chip might be a bit confusing.

It could default to 24c08 but if it has properties the driver should use
those to determine size etc.
