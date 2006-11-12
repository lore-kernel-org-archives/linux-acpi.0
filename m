From: Holger Macht <hmacht@suse.de>
Subject: Comments about commit 'PCI: docking station: remove dock uevents'?
Date: Sun, 12 Nov 2006 15:07:37 +0100
Message-ID: <20061112140737.GA21908@homac2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:13991 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932487AbWKLOIV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 12 Nov 2006 09:08:21 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: kristen.c.accardi@intel.com, fseidel@suse.de

Hi,

> commit 5669021e40964303994a20633548732c6bb26636
> Author: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
> Date:   Tue Aug 1 14:59:19 2006 -0700
>
>     PCI: docking station: remove dock uevents
>
>     Remove uevent dock notifications.  There are no consumers
>     of these events at present, and uevents are likely not the
>     correct way to send this type of event anyway.
>
>     Until I get some kind of idea if anyone in userspace cares
>     about dock events, I will just not send any.
>
>     Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
>     Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

I'm currently looking at docking station support for various
laptops/vendors and what can be done to get them working. At the moment,
userspace has to do some quirks to get support for them. For instance,
when docking an X60 into a docking station where a SATA DVD drive is
located, userland has to rescan the scsi host for the drive to show up. So
I need a notification from the kernel on dock/undock events. Currently I'm
using the ibm_acpi driver to either get the ibm/hotkey or the ibm/dock
event. Due to the fact that I also want to support other laptops and
because of the existance of a common dock station driver, I'm considering
to use it. A notification is of course only needed if triggering something
in userspace is the right way to go at all. So if ideally everything
should happen inside the kernel anyway, please tell me. In this case maybe
I will have a look at the kernel and will use ibm_acpi meanwhile. However,
if it's possible to readd the notification, I could just skip the ibm_acpi
way for docking and could use the common driver. Maybe it even shouldn't
be done via uevent, maybe an acpi event is enough?

Additionally, currently the dock driver automatically executes the _DCK
method when it detects a dock/undock event. Wouldn't it be good to have
common sysfs interface for docking so that userland can trigger the
dock/undock? This way userland would also be able to do 'something before'
docking/undocking, such as unregistering a device, showing a poput that it
is now save to physically undock, etc.

Regards,
	Holger
