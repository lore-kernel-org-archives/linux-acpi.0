From: Darren Hart <dvhart@linux.intel.com>
Subject: Re: ACPI vs Device Tree - moving forward
Date: Fri, 23 Aug 2013 16:45:48 -0700
Message-ID: <1377301548.5259.91.camel@dvhart-mobl4.amr.corp.intel.com>
References: <20130820192650.GA19470@srcf.ucam.org>
	 <6438184.2yT2NMB1CE@vostro.rjw.lan> <20130821233942.GA21502@srcf.ucam.org>
	 <1810269.JOHnJ0H7P9@vostro.rjw.lan> <20130822000306.GA21785@srcf.ucam.org>
	 <1377300343.5259.84.camel@dvhart-mobl4.amr.corp.intel.com>
	 <20130823233805.GA1801@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:13761 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754169Ab3HWXpu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 23 Aug 2013 19:45:50 -0400
In-Reply-To: <20130823233805.GA1801@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Linus Walleij <linus.walleij@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>, "H. Peter Anvin" <hpa@zytor.com>

On Sat, 2013-08-24 at 00:38 +0100, Matthew Garrett wrote:
> On Fri, Aug 23, 2013 at 04:25:43PM -0700, Darren Hart wrote:
> 
> > It had been my hope at the start of this project to open the creation of
> > SSDTs up to inventors and hackers who want to create Lures for the
> > MinnowBoard in such a way that they could write these SSDTs and load
> > them from a file at boot time, modify, rebuild, iterate, etc. When/if
> > the Lure goes to production, the SSDT could either be stored on an
> > EEPROM, or for very low volume boards, possibly just shipped as a binary
> > to be loaded (with source available of course).
> 
> There's no fundamental problem with doing this, especially on UEFI 
> systems. As long as you know the host ACPI code, it's trivial to merge 
> an SSDT in from a UEFI option ROM.
> 
> > It appears that Matthew, at least, would prefer this latter scenario
> > just used DT instead. However, that seems to leave a gap in the
> > transition to incorporating the table into the board firmware should a
> > derivative product be made. e.g. no good way to prototype with ACPI. It
> > also seems to have all the same problems raised regarding mixing ACPI
> > and DT on the same system.
> 
> I've no problem with additional hardware shipping with ACPI support - my 
> position was more that if a vendor ships a system with ACPI that fails 
> to describe the integrated hardware (or does so incorrectly), it's 
> probably easier to replace it with DT than a fixed ACPI table. Still, if 
> people *do* want to replace shipped ACPI tables, it's probably 
> preferable to do that at the bootloader level than the kernel level.
> 

OK. Thanks for elaborating.

It seems to me that in order to fully support this, we are back to the
problem of how do we provide arbitrary configuration data via ACPI (the
DSM being the only current means, but there is no standard there). Is
that still the hard problem we are looking to solve as a group?

-- 
Darren Hart
Intel Open Source Technology Center
Yocto Project - Linux Kernel


