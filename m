From: Thomas Renninger <trenn@suse.de>
Subject: User tool for configuring wake-up devices
Date: Mon, 24 Jan 2011 15:09:47 +0100
Message-ID: <201101241509.48032.trenn@suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:59904 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751946Ab1AXOJu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 24 Jan 2011 09:09:50 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Brownell <david-b@pacbell.net>, "Rafael J. Wysocki" <rjw@sisk.pl>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-acpi@vger.kernel.org
Cc: oneukum@suse.de

Hi,

some time ago we talked about a userspace tool
which can enable specific devices to be able to
wake the machine up from suspend.

While Rafael solved that for network directly
in the driver iirc (should work via ethtool now),
there wasn't any outcome for
other devices (usb, key, mouse, generic ACPI implementation
reading out device's sysfs path...) to activate them as
wakeup devices in a userfriendly way?

Oliver just asked me for a tool to e.g. configure
and enable usb or other devices as wake-up devices.

I quickly googled and found:
  - acpitools (http://sourceforge.net/projects/acpitool)
    rather old, I doubt it does any sysfs reads to find
    out which devices could be configured and of what
    type they are?

  - acpi-wakeup
    even less feature rich...

In sysfs is this supposed to work via:
/sys/devices/.../power/wakeup_active
now?

How are users supposed to enable devices for suspend wake up?
Are there any tools already which are worth packaging
or is such a tool waiting for implementation?

Thanks,

   Thomas
