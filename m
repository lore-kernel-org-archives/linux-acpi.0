From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: Check for ACPI backlight support otherwise use vendor
	ACPIdrivers - version 4
Date: Mon, 04 Aug 2008 09:16:20 +0800
Message-ID: <1217812580.2969.184.camel@rzhang-dt>
References: <1217605083-31003-1-git-send-email-trenn@suse.de>
	 <1217632817.4610.6.camel@hidalgo>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:28569 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751904AbYHDBSt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 3 Aug 2008 21:18:49 -0400
In-Reply-To: <1217632817.4610.6.camel@hidalgo>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yves-Alexis Perez <corsac@debian.org>
Cc: Thomas Renninger <trenn@suse.de>, ak@linux.intel.com, nokos@gmx.net, linux-acpi@vger.kernel.org, mjg59@srcf.ucam.org, hmh@debian.org

On Sat, 2008-08-02 at 07:20 +0800, Yves-Alexis Perez wrote:
> On ven, 2008-08-01 at 17:37 +0200, Thomas Renninger wrote:
> > Please queue for 2.6.28.
> > Tell me if parts do not patch and I can repost them against
> > whatever is needed.
> > 
> > Ideally they should go in together with Matthew's/Hong's IGD
> > patches (which should come mainline through the dri tree), these
> > patches should need mine.
> 
> Ok, as those patches were merged in linux-acpi-2.6/test I managed to
> build and test (0d0b6e44c2d3295b790ecfd20d2461181e10c846).
> 
> I'm using a Thinkpad T61 with Intel graphics. Config is attached.
> 
> When booting in single user, without acpid, hal, dbus etc. running,
> brightness keys doesn't work. thinkpad-acpi and video are loaded, I
> tried to boot with acpi_backlight=video just to be sure, but nothing
> changes. I have only one device in /sys/class/backlight (acpi_video0).
> brightness and actual_brightness follow the changes when I press the
> brigthness keys, but the real brightness doesnt.

I think you're using the laptop that this patch does break.
Please try acpi_backlight=vendor.

thanks,
rui

