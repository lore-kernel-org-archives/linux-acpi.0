From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [REGRESSION 5.0.8] Dell thunderbolt dock broken (xhci_hcd and
 thunderbolt)
Date: Mon, 6 May 2019 09:45:34 +0300
Message-ID: <20190506064534.GG2895@lahna.fi.intel.com>
References: <s5hsgu0ihyg.wl-tiwai@suse.de>
 <EksOpJxc6GB@mike.franken.de>
 <20190430090021.GF26516@lahna.fi.intel.com>
 <CAJZ5v0j_fYqtMv07C-V_9fCJ6=1ec3GjvT2M7PXVNSbZpoM67Q@mail.gmail.com>
 <20190502114839.GC24696@kroah.com>
 <CAEGmHFFGpUmK1VitkUxqXL29dBrKwbceT0pEOeR_7+_4+eLzvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAEGmHFFGpUmK1VitkUxqXL29dBrKwbceT0pEOeR_7+_4+eLzvA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Furquan Shaikh <furquan@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, "Schmauss, Erik" <erik.schmauss@intel.com>, mh@mike.franken.de, Lukas Wunner <lukas@wunner.de>, Takashi Iwai <tiwai@suse.de>, Bjorn Helgaas <bhelgaas@google.com>, ckellner@redhat.com, Jiri Slaby <jslaby@suse.cz>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Robert Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Fri, May 03, 2019 at 04:35:02PM -0700, Furquan Shaikh wrote:
> Thanks for reporting the issue and apologize for the breakage. When I
> pushed the patch, my understanding was that the device drivers do not
> depend on stale GPE events to take any action.
> 
> I am curious to understand the behavior for the thunderbolt device
> since I do not have one to test with. The failure seems to be a result
> of either having a edge-triggered interrupt or a pulse interrupt which
> indicates some kind of ready condition to the kernel driver. All the
> runtime GPEs seem to be initialized as part of acpi_init before ACPI
> bus is scanned. So, is this some special kind of requirement for
> thunderbolt that requires GPE enabled before the device can actually
> be probed. And so the GPEs going active before being enabled are then
> used as a way to call into ACPI Method to enable something which is
> essential for probing of device?

IIRC the idea is that when you boot with a TBT device connected (this is
only for the BIOS assisted/ACPI enumeration mode) the Thunderbolt host
router (the device with PCIe switch + xHCI + NHI) is configured in two
phases. The basic configuration is done in the ASL code that then waits
for a synchronization event (signal) from the SMI hotplug handler that
allows it to continue. The GPE which can be either edge or level is then
used to call the SMI hotplug handler to initialize the host router and
its resources properly.

If this is not done the PCI stack finds the host router half-configured
causing the failure.

> The other question I have is given that handling of GPE events that
> were active before being enabled is required at least for some set of
> devices (e.g. thunderbolt), what is a good way to solve the original
> problem that was being addressed by the patch being reverted i.e.
> stale events resulting in spurious wakes on wakeup GPEs. One way I can
> think of is clearing the status of GPEs when they are setup for
> wake(acpi_setup_gpe_for_wake). What do you think?

Sounds good to me.
