From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: Re: [GIT PATCH] ACPI patches for 2.6.21
Date: Fri, 9 Feb 2007 17:24:10 -0800
Message-ID: <20070209172410.e2c4566b.kristen.c.accardi@intel.com>
References: <200702071418.51058.lenb@kernel.org>
	<20070209230928.GD3949@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:48430 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752589AbXBJB00 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 9 Feb 2007 20:26:26 -0500
In-Reply-To: <20070209230928.GD3949@ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Len Brown <lenb@kernel.org>, Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>, tony.luck@intel.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org

On Fri, 9 Feb 2007 23:09:29 +0000
Pavel Machek <pavel@ucw.cz> wrote:

> Hi!
> 
> > Per your request, and the request of the distros, we've changed
> > how ACPICA Core releases are integrated into Linux so that each
> > upstream (CVS) check-in appears as a single git commit.
> > While this process is not yet perfect, it should be vastly better
> > than previous "code drops" in allowing git bisect to work,
> > and allowing distros to cherry-pick individual fixes.
> > 
> > The "bay" driver is new (and marked EXPERIMENTAL) -- adding initial
> > hot-plug support for ACPI controlled drive bays such as the
> > IBM ultrabay or the Dell Module Bay.
> 
> Could you describe userland interface it uses? /proc? Will it be
> usable for bays on notebooks not using acpi?

The user interface for the Bay driver is via sysfs - it is a platform
driver, so once you load it you will find 2 files created under
/sys/devices/platform/bay.X, "eject" and "present".  When the user
writes 1 to the "eject" file, the driver will call the ACPI eject
routine - this normally blinks leds and does whatever the system vendor
thinks is necessary to safely eject the device.  The "present" file
will query the driver to determine if the device is present or not (note,
not good for poll(), it's on my todo list...).  Depending on the system
implementation, when the user presses the eject button on the laptop for
the bay device, the driver will inform user space via a CHANGE uevent.  User
space is then responsible for doing whatever needs to be done to cleanup
and safely eject the drive, the driver will not call the ACPI eject
routine without user space initiation.  The driver currently only handles
module bays that use ACPI to send eject notifications or need "something"
done before ejecting (i.e. _EJ0 in ACPI).  The bay driver will also register 
with the dock driver if the bay is on the dock device (such
as with the IBM X60) so that when the dock station is ejected, the bay
driver is notified with the eject request as well.  This notification will
be passed to user space via the CHANGE uevent.

Kristen
