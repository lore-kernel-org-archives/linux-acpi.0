From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] ACPI / hotplug / PCI: Always rescan the slot for new
 devices
Date: Wed, 30 Oct 2013 16:07:33 +0200
Message-ID: <20131030140733.GH3521@intel.com>
References: <1383136836-15306-1-git-send-email-mika.westerberg@linux.intel.com>
 <1383141466.4097.163.camel@ul30vt.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:9273 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754171Ab3J3OCI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 30 Oct 2013 10:02:08 -0400
Content-Disposition: inline
In-Reply-To: <1383141466.4097.163.camel@ul30vt.home>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alex Williamson <alex.williamson@redhat.com>
Cc: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Oct 30, 2013 at 07:57:46AM -0600, Alex Williamson wrote:
> On Wed, 2013-10-30 at 14:40 +0200, Mika Westerberg wrote:
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
> > ---
> > Alex,
> > 
> > Are you able to check if your machine still works and doesn't slow down
> > during boot after this patch is applied?
> 
> Looks ok to me, no new console output or boot delay.  Thanks,

Thanks!
