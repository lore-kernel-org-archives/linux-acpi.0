From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] User tool for configuring wake-up devices
Date: Mon, 24 Jan 2011 11:17:01 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1101241107330.2030-100000@iolanthe.rowland.org>
References: <201101241509.48032.trenn@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:46554 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751878Ab1AXQRD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Jan 2011 11:17:03 -0500
In-Reply-To: <201101241509.48032.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: David Brownell <david-b@pacbell.net>, "Rafael J. Wysocki" <rjw@sisk.pl>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-acpi@vger.kernel.org, oneukum@suse.de

On Mon, 24 Jan 2011, Thomas Renninger wrote:

> Hi,
> 
> some time ago we talked about a userspace tool
> which can enable specific devices to be able to
> wake the machine up from suspend.
> 
> While Rafael solved that for network directly
> in the driver iirc (should work via ethtool now),
> there wasn't any outcome for
> other devices (usb, key, mouse, generic ACPI implementation
> reading out device's sysfs path...) to activate them as
> wakeup devices in a userfriendly way?

I'm not aware of any.  (Note that keyboard devices are supposed to be
enabled for wakeup by default, although this may not yet be implemented
in all the keyboard drivers.)

> Oliver just asked me for a tool to e.g. configure
> and enable usb or other devices as wake-up devices.
> 
> I quickly googled and found:
>   - acpitools (http://sourceforge.net/projects/acpitool)
>     rather old, I doubt it does any sysfs reads to find
>     out which devices could be configured and of what
>     type they are?
> 
>   - acpi-wakeup
>     even less feature rich...
> 
> In sysfs is this supposed to work via:
> /sys/devices/.../power/wakeup_active
> now?

The filename is just "wakeup", not "wakeup_active".  It's worth 
pointing out that for USB devices, one must enable wakeup both on the 
device itself and also on the host controller for the device's bus.

> How are users supposed to enable devices for suspend wake up?

By writing "enabled" to the sysfs file.  Writing "disabled" to the file 
has the opposite effect.

Currently this is done by udev rules, by desktop config programs, or by
manually adding lines to system shell scripts.

> Are there any tools already which are worth packaging
> or is such a tool waiting for implementation?

I don't know of any tools capable of handling this.

Alan Stern

