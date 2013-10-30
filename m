From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] ACPI / hotplug / PCI: Always rescan the slot for new
 devices
Date: Wed, 30 Oct 2013 15:04:16 +0200
Message-ID: <20131030130416.GF3521@intel.com>
References: <1383136836-15306-1-git-send-email-mika.westerberg@linux.intel.com>
 <1406112.LRdFoqkugQ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1406112.LRdFoqkugQ@vostro.rjw.lan>
Sender: linux-pci-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Oct 30, 2013 at 02:01:40PM +0100, Rafael J. Wysocki wrote:
> On Wednesday, October 30, 2013 02:40:36 PM Mika Westerberg wrote:
> > Commit 2dc4128 (ACPI / hotplug / PCI: Avoid doing too much for spurious
> > notifies) changed the enable_slot() to check return value of pci_scan_slot()
> > and if it is zero return early from the function. It means that there were
> > no new devices in this particular slot.
> > 
> > However, if a device appeared deeper in the hierarchy the code now ignores
> > it causing things like Thunderbolt chaining fail to recognize new devices.
> > 
> > The problem with Alex Williamson's machine was solved with commit
> > a47d8c8 (ACPI / hotplug / PCI: Avoid parent bus rescans on spurious device
> > checks) and hence we should be able to restore the original functionality
> > that we always rescan on bus check notification.
> > 
> > On a device check notification we still check what acpiphp_rescan_slot()
> > returns and on zero bail out early.
> > 
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> So, this is a revert of commit a47d8c8, correct?

Correct.

Plain revert didn't work because the code has changed after that commit.
