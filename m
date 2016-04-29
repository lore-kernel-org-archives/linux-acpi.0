From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: OpRegion conflicts for Skylake LPSS
Date: Fri, 29 Apr 2016 10:42:27 +0300
Message-ID: <20160429074227.GJ32610@lahna.fi.intel.com>
References: <87lh41nqqq.fsf@smart-cactus.org>
 <20160426155437.GA10202@lahna.fi.intel.com>
 <87eg9snkiw.fsf@smart-cactus.org>
 <87r3dona7g.fsf@smart-cactus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:25016 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752630AbcD2Hmd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 29 Apr 2016 03:42:33 -0400
Content-Disposition: inline
In-Reply-To: <87r3dona7g.fsf@smart-cactus.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ben Gamari <ben@smart-cactus.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>

On Fri, Apr 29, 2016 at 09:30:27AM +0200, Ben Gamari wrote:
> Ben Gamari <ben@smart-cactus.org> writes:
> 
> > [ Unknown signature status ]
> > Mika Westerberg <mika.westerberg@linux.intel.com> writes:
> >
> >> On Tue, Apr 26, 2016 at 02:44:13AM +0200, Ben Gamari wrote:
> >>> 
> > snip
> >
> >>> It looks very much like these are describing the same device. Perhaps
> >>> the lpss driver should be binding to this ACPI node? Or perhaps this is
> >>> a firmware issue? Any guidance would be greatly appreciated.
> >>
> >> Can you send me full acpidump of that machine?
> >
> > It can be found at
> > https://github.com/bgamari/dell-e7470-dsdt/blob/master/acpi.log.
> >
> Did this provide any insight? Let me know if more information would be
> helpful.

Sorry about the delay.

The GEXP device is most probably a GPIO expander that is connected to
one of the I2C buses. And it indeed looks to use directly the I2C host
controller registers so kernel rightfully complains about that.

Are you able to run Windows on that machine? If yes, it would be nice to
know if the INT3446 I2C device is shown in the device manager.

> Also, is there a way to simply allow the driver subsystem to allow
> probing to proceed despite this resource conflict so that I can resume
> debugging my original input device issue?

Try to pass "acpi_enforce_resources=lax" in the kernel command line.
