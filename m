From: Darren Hart <dvhart@linux.intel.com>
Subject: Re: ACPI vs Device Tree - moving forward
Date: Fri, 23 Aug 2013 16:25:43 -0700
Message-ID: <1377300343.5259.84.camel@dvhart-mobl4.amr.corp.intel.com>
References: <20130820192650.GA19470@srcf.ucam.org>
	 <6438184.2yT2NMB1CE@vostro.rjw.lan> <20130821233942.GA21502@srcf.ucam.org>
	 <1810269.JOHnJ0H7P9@vostro.rjw.lan> <20130822000306.GA21785@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:7074 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753610Ab3HWXZp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 23 Aug 2013 19:25:45 -0400
In-Reply-To: <20130822000306.GA21785@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Linus Walleij <linus.walleij@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>, "H. Peter Anvin" <hpa@zytor.com>

On Thu, 2013-08-22 at 01:03 +0100, Matthew Garrett wrote:
> On Thu, Aug 22, 2013 at 02:02:29AM +0200, Rafael J. Wysocki wrote:
> 
> > And now the practice appears to be that vendors actually ship some ACPI
> > tables with their systems, but those ACPI tables do not contain information
> > needed to enumerate all devices.  On the other hand, it is known what the
> > DT bindings for the missing part should be.  How can we address this?
> 
> On ARM? I know that this is true on x86, but that's because x86 vendors 
> have never intended i2c hardware monitoring devices be driven by a 
> general purpoes OS - they're there for the benefit of the firmware, not 
> anything above that.
> 
> > Next, say we have a driver written with DT bindings in mind and there's
> > an ACPI-based system with identical hardware, although wired up slightly
> > differently.  Say that all of the information needed by that driver is
> > there in the ACPI tables (Q: How the vendor is supposed to know what
> > information the driver expects?).  Who is supposed to take care of updating
> > the driver to be able to use ACPI in addition to DTs?
> 
> Ideally we have a consistent in-kernel representation of this 
> information and drivers don't need to care about whether it came from DT 
> or ACPI, but like I said, that's going to be tricky.
> 
> > I don't honestly think that the "ask vendors to ship their systems with correct
> > ACPI tables" approach will take us anywhere.
> 
> It's worked well enough on x86. If hardware vendors don't actually test 
> that their hardware is able to boot the OS it's intended to run then 
> there's very little we can do about that - and the worst case outcome is 
> that people just ignore the shipped ACPI and use FDT.
> 

It appears both Matthew and Rafael are supporting a statement to the
effect that we should not expect anyone but BIOS/firmware vendors to be
writing ACPI code (such as SSDTs which they compile, store on the boot
media, and pass into the kernel at boot time). This is certainly the
case know (with a few rare exceptions where people are trying to work
around broken BIOS ACPI tables.

It had been my hope at the start of this project to open the creation of
SSDTs up to inventors and hackers who want to create Lures for the
MinnowBoard in such a way that they could write these SSDTs and load
them from a file at boot time, modify, rebuild, iterate, etc. When/if
the Lure goes to production, the SSDT could either be stored on an
EEPROM, or for very low volume boards, possibly just shipped as a binary
to be loaded (with source available of course).

It appears that Matthew, at least, would prefer this latter scenario
just used DT instead. However, that seems to leave a gap in the
transition to incorporating the table into the board firmware should a
derivative product be made. e.g. no good way to prototype with ACPI. It
also seems to have all the same problems raised regarding mixing ACPI
and DT on the same system.

-- 
Darren Hart
Intel Open Source Technology Center
Yocto Project - Linux Kernel


