From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.21-rc5-git] make /proc/acpi/wakeup more useful
Date: Sat, 7 Apr 2007 13:08:07 -0700
Message-ID: <200704071308.07571.david-b@pacbell.net>
References: <200704031741.42273.david-b@pacbell.net> <200704060843.30723.david-b@pacbell.net> <20070407050131.GB25511@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S966306AbXDGUIM@vger.kernel.org>
In-Reply-To: <20070407050131.GB25511@kroah.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, lenb@kernel.org, "linux-acpi@vger" <linux-acpi@vger.kernel.org>, Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Friday 06 April 2007 10:01 pm, Greg KH wrote:

> Are you _sure_ you have a 1-to-1 relationship here?  No multiple devices
> pointing to the same acpi node?  Or the other way around?  If so, you
> are going to have to change the name to be something more unique.

I've wondered that too.  The short answer:  APCI only supports 1-1
here.  It will emit warnings if it tries to bind more than one ACPI
device to a given "real" device ... but errors the other way are
silently ignored.

By adding a warning over this create-links patch, I found that the
system in the $SUBJECT patch (and likely every ACPI system) has
two different nodes that correspond to one ACPI node:

	/sys/devices/pci0000:00 ... pci root node
	/sys/devices/pnp0/00:00 ... id PNP0a03
	/sys/devices/acpi_system:00/device:00/PNP0A03:00 ... ditto

Arguably that's too many sysfs nodes for one device...

Plus, there's the issue of flakey ACPI tables; in the $SUBJECT patch
both MDM and AUD nodes exist in the ACPI namespace, but they could
only refer to one PCI device (with MDM as the wakeup source, not AUD
as listed in the table).  Or maybe that's another case where the ACPI
code isn't handling the tables as sensibly as it might...


> Or how about "firmware" instead of "acpi" to be able to have the
> userspace tools work on any type of firmware that provides this, like
> openfirmware?

Assuming they all adopt that same "parallel tree" model, that seems
like a good idea.  The tools will likely need to understand how ACPI
and OF differ, but there's no point in reserving more names than we
really need.  Though it may be that "parallel trees" should go away.

A small glitch in the patch:  lines bigger than 80 characters.  :)

- Dave
