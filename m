From: David Brownell <david-b@pacbell.net>
Subject: Re: PATCH/RFC: driver model/pmcore wakeup hooks (1/4)
Date: Mon, 18 Oct 2004 20:41:02 -0700
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <200410182041.02192.david-b@pacbell.net>
References: <200410051309.02105.david-b@pacbell.net> <1097906636.14156.41.camel@d845pe>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S267916AbUJSDkh@vger.kernel.org>
In-Reply-To: <1097906636.14156.41.camel@d845pe>
Content-Disposition: inline
To: Len Brown <len.brown@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org, ACPI Developers <acpi-devel@lists.sourceforge.net>
List-Id: linux-acpi@vger.kernel.org

On Friday 15 October 2004 11:03 pm, Len Brown wrote:
> > - ACPI (this should probably replace the new /proc/acpi/wakeup)
> 
> Agreed.  That file is a temporary solution.
> The right solution is for the devices to appear in the right
> place in the device tree and to hang the wakeup capabilities
> off of them there.

So what would that patch need before ACPI could convert to use it?

I didn't notice any obvious associations between the strings in
the acpi/wakeup file and anything in sysfs.  Which of USB1..USB4
was which of the three controllers shown by "lspci" (and which
one was "extra"!), as one head-scratcher.

For PCI, I'd kind of expect pci_enable_wake() to trigger the
additional ACPI-specific work to make sure the device can
actually wake that system.   Seems like dev->platform_data
might need to combine with some platform-specific API hook.

- Dave
