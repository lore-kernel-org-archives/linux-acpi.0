From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI / hotplug / PCI: Always rescan the slot for new devices
Date: Wed, 30 Oct 2013 15:13:15 +0100
Message-ID: <2238508.7Zxn6keMnr@vostro.rjw.lan>
References: <1383136836-15306-1-git-send-email-mika.westerberg@linux.intel.com> <1383141466.4097.163.camel@ul30vt.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:62229 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754581Ab3J3OBJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Oct 2013 10:01:09 -0400
In-Reply-To: <1383141466.4097.163.camel@ul30vt.home>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday, October 30, 2013 07:57:46 AM Alex Williamson wrote:
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

Great, thanks!

May I add your Tested-by to it, then?

Rafael

