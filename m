From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: ACPI vs Device Tree - moving forward
Date: Tue, 20 Aug 2013 21:57:13 +0100
Message-ID: <20130820205712.GA22850@srcf.ucam.org>
References: <20130820192650.GA19470@srcf.ucam.org>
 <1377031863.1758.10.camel@dvhart-mobl4.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:41749 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751107Ab3HTU5S (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 20 Aug 2013 16:57:18 -0400
Content-Disposition: inline
In-Reply-To: <1377031863.1758.10.camel@dvhart-mobl4.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Darren Hart <dvhart@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux@roeck-us.net, hpa@zytor.com, linus.walleij@linaro.org, rjw@sisk.pl

On Tue, Aug 20, 2013 at 01:51:03PM -0700, Darren Hart wrote:

> It seems to me that the only way to end up in a situation where the data
> is reused by other OSes, is to go through a standards body. What about
> attempting to standardize the _DSM method? I suppose the challenge then
> is how do we standardize arbitrary data (which, of course, is an
> oxymoron)...

Right. We could certainly spec the DT bindings that currently exist, but 
the obvious pushback is that large chunks of it *are* already in ACPI - 
a _PS0 method (which is ACPI for "Power up the device") that toggles a 
GPIO pin, and then provides a different GPIO pin in the DT data, which 
would we believe?

> The interesting thing about this to me is that many of these devices are
> added after-the-fact (as add-on boards, for example). With the
> MinnowBoard we are looking to provide this configuration data in an
> EEPROM. Would it make sense for the device manufacturer (rather than the
> base-board manufacturer) to define the key-value pairs for their
> hardware?

Yes, hardware information that's on add-in boards should probably be 
provided by the add-in board if it carries a ROM. This is trivial on 
UEFI systems - you just need a UEFI driver for the board that can 
construct an appropriate SSDT. It's more of a problem for non-UEFI ACPI 
systems.

> Sadly, I will not be in New Orleans and am unlikely to receive a Kernel
> Summit invite, but I am planning be in Edinburgh and would like the
> opportunity to participate in this discussion.

I'm not planning on being at kernel summit this year, so I think we'll 
try to arrange something around that time but outside the event.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
