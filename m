From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] Re: [2.6.22-rc1-mm1] vaio laptop (SZ72B) immediately
 resumes after STR
Date: Wed, 20 Jun 2007 12:33:04 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0706201220150.3518-100000@iolanthe.rowland.org>
References: <20070620144532.GA3761@inferi.kami.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:60990 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752468AbXFTQdH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Jun 2007 12:33:07 -0400
In-Reply-To: <20070620144532.GA3761@inferi.kami.home>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mattia Dongili <malattia@linux.it>
Cc: Zhang Rui <rui.zhang@intel.com>, David Brownell <dbrownell@users.sourceforge.net>, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, akpm@linux-foundation.org

On Wed, 20 Jun 2007, Mattia Dongili wrote:

> > Just as with Raphael, I suggest you build a kernel with 
> > CONFIG_USB_DEBUG turned on and then post the dmesg log showing the USB 
> > debugging messages during the suspend and immediate resume.  To reduce 
> > the amount of clutter you might want to rmmod uhci-hcd before starting 
> > the test.
> 
> here we go:
> http://www.linux.it/~malattia/logs/dmesg-suspend-ehci-debug-log
> 
> and by the way:
> 00:1d.0 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #1 (rev 02)
> 00:1d.1 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #2 (rev 02)
> 00:1d.2 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #3 (rev 02)
> 00:1d.3 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #4 (rev 02)
> 00:1d.7 USB Controller: Intel Corporation 82801G (ICH7 Family) USB2 EHCI Controller (rev 02)
> 
> with ehci only:
> Bus 005 Device 007: ID 054c:0281 Sony Corp. 
> Bus 005 Device 004: ID 05ca:1830 Ricoh Co., Ltd 
> Bus 005 Device 001: ID 0000:0000  

The log shows suspicious behavior on the part of the Sony UMH-U09
device, the first one in your ehci-only list above.  When it was
suspended it apparently disconnected itself from the USB bus, thereby
triggering a wakeup signal.  If at all possible, try unplugging the USB
cable to that device and then see what happens when you suspend.

You also ought to be able to prevent this immediate resume by disabling
wakeup on the EHCI controller.  For example:

	echo disable >/sys/bus/usb/devices/usb5/power/wakeup
	echo disable >/sys/bus/usb/devices/usb5/../power/wakeup

(Maybe you only need one of those two lines; in principle either one
should be sufficient.)  After doing this it's probably a good idea to
run lsusb, to force the new settings to take effect in case the root
hub was autosuspended.

Alan Stern

