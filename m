From: Len Brown <len.brown@intel.com>
Subject: Re: [PATCH 0/4]Bind physical devices with ACPI devices - take 2
Date: 05 Jan 2005 23:00:55 -0500
Message-ID: <1104984055.18173.239.camel@d845pe>
References: <1104893444.5550.127.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S262713AbVAFEB5@vger.kernel.org>
In-Reply-To: <1104893444.5550.127.camel@sli10-desk.sh.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: ACPI Developers <acpi-devel@lists.sourceforge.net>, lkml <linux-kernel@vger.kernel.org>, Greg <greg@kroah.com>, Patrick Mochel <mochel@digitalimplant.org>, Pavel Machek <pavel@suse.cz>, Adam Belay <ambx1@neo.rr.com>
List-Id: linux-acpi@vger.kernel.org

On Tue, 2005-01-04 at 21:50, Li Shaohua wrote:
> Hi,
> The series of patches implement binding physical devices with ACPI
> devices. With it, device drivers can utilize methods provided by
> firmware (ACPI). These patches are against 2.6.10, please give your
> comments.

I think we'll save some significant power when ACPI D-states
are invoked for the devices that supply them.  While many
PCI devices support PCI power management and thus don't need/use
ACPI D-states, I think it will be even more important to add
this functionality to the legacy devices which never have
PCI power management and thus always depend on ACPI for D-states.

It looks like some device drivers scribble on dev->platform_data;
and we need to fix those drivers before deploying this patch.
Alternatively, we could add a new field to struct device,
but then we'd probably never get rid of it...

I'm a little unformforable with platform_notify
and platform_notify_remove available as globals.
We should probably BUG_ON if we
find them set before ACPI writes on them.

We'll need to update this patch to handle erroneous
but real platforms that don't have _BBN
by using _CRS to get PCI bus number.

Unclear to me if/how this association of ACPI capability
should be reflected in the sysfs device tree.

thanks,
-Len
