From: Hiroshi 2 Itoh <HIROIT@jp.ibm.com>
Subject: Re: [ACPI] [Proposal]Another way to save/restore PCI config space	for
 suspend/resume
Date: Wed, 27 Oct 2004 11:26:40 +0900
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <OF96A27AFE.EC89615C-ON49256F3A.000B5394-49256F3A.000CB5DB@jp.ibm.com>
References: <1098842129.12477.2.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261560AbUJ0C0z@vger.kernel.org>
In-Reply-To: <1098842129.12477.2.camel@sli10-desk.sh.intel.com>
To: Li Shaohua <shaohua.li@intel.com>
Cc: ACPI-DEV <acpi-devel@lists.sourceforge.net>, greg@kroah.com, Len Brown <len.brown@intel.com>, lkml <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>
List-Id: linux-acpi@vger.kernel.org





> >
> > I think a basic problem of current Linux device model is that there is
no
> > effective message path from sibling devices to their root device.
> > Although the message direction from a root device to sibling devices is
> > natural from the viewpoint of device enumeration, the direction from
> > sibling devices to a root device is required for effective arbitration
for
> > device configuration and power management.
> >
> > The Windows driver model uses the direction from sibling drivers to a
root
> > bus driver mainly, i.e. sibling drivers are layered on a root bus
driver.
> > While we need a kind of callback mechanism from PCI (sibling) devices
to
> > PCI bus (root) device instead because their normal call interface is
from a
> > root device to sibling devices.
> Hiro-san,
> I don't really understand why this is related with suspend/resume. Could
> you please explain it more clearly?
>
Hi,

What I mean is that:

There are some bridge devices to be supported by a driver for various
device types and vendors. In the long run PCI drivers will have power
dependency one another in the long run. It is natual that PCI bridge driver
reports its child devices and their dependency to PCI core because PCI core
driver needs to know power up/down sequence at suspend/resume time. So I
think callbacks from bridge-to-core is useful. Especially it is more useful
for the core to get exact timing to power up the next driver if some
devices have certain latency to power up.

- Hiro.
