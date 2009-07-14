From: Alex Chiang <achiang@hp.com>
Subject: Re: [PATCH 0/3] ACPI/PCI Hotplug: acpiphp cleanup
Date: Tue, 14 Jul 2009 14:04:31 -0600
Message-ID: <20090714200431.GC15021@ldl.fc.hp.com>
References: <20090710193601.30165.62311.stgit@bob.kio> <20090714122731.1ebea158@jbarnes-g45>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0007.atlanta.hp.com ([15.192.0.44]:18040 "EHLO
	g5t0007.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751663AbZGNUEc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 14 Jul 2009 16:04:32 -0400
Content-Disposition: inline
In-Reply-To: <20090714122731.1ebea158@jbarnes-g45>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: lenb@kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

* Jesse Barnes <jbarnes@virtuousgeek.org>:
> Haven't heard from Len yet, but I'm a bit nervous about adding this to
> for-linus.  We already have a fix upstream for the acpi_get_pci_dev
> issue right?  So there's no hurry on this set of (nice) cleanups is
> there?

The problem is that I introduced an assumption in acpiphp_configure_bridge,
which calls acpi_get_pci_dev. That call may fail on systems
with non-materialized PCI root bridges.

Fixing that assumption was addressed by this hunk in patch 2/3:

@@ -1387,16 +1363,7 @@ static void acpiphp_sanitize_bus(struct pci_bus *bus)
 /* Program resources in newly inserted bridge */
 static int acpiphp_configure_bridge (acpi_handle handle)
 {
-       struct pci_dev *dev;
-       struct pci_bus *bus;
-
-       dev = acpi_get_pci_dev(handle);
-       if (!dev) {
-               err("cannot get PCI domain and bus number for bridge\n");
-               return -EINVAL;
-       }
-
-       bus = dev->bus;
+       struct pci_bus *bus = pci_bus_from_handle(handle);

        pci_bus_size_bridges(bus);
        pci_bus_assign_resources(bus);

Now, my systems cannot do PCI root bridge hotplug, so that line
where we call acpi_get_pci_dev() won't cause us to fail, but I'm
concerned about machines in the wild that:

	a) can do PCI root bridge hotplug
	b) have non-materialized PCI root bridges

Maybe that is a small set of machines...

I agree that this series is on the large side for -rc4 and
beyond, but I'd prefer to fix it now.

The thing is, a "minimal" fix wouldn't save us that much, since
we'd still have to export acpi_pci_root stuff. We could maybe
drop patch 3/3 which makes the final diffstat look like this:

 drivers/acpi/pci_root.c            |   17 +-----
 include/acpi/acpi_bus.h            |   14 +++++
 drivers/pci/hotplug/acpiphp_glue.c |  108 ++++++++++++------------------------
 3 files changed, 53 insertions(+), 86 deletions(-)

Hm, actually, I can actually make that even smaller by separating
out the interface change.

Would you like me to do that and resubmit? I'd still need an ACK
from Len re: acpi_pci_root...

Thanks.

/ac

