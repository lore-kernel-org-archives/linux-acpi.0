From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PCI / hotplug: Propagate the "ignore hotplug" setting to parent
Date: Tue, 26 May 2015 00:27:48 +0200
Message-ID: <8651379.9rUBgamt32@vostro.rjw.lan>
References: <2001450.KHHLaZsp3O@vostro.rjw.lan> <20150523014037.GL32152@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:48726 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750954AbbEYWCV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 May 2015 18:02:21 -0400
In-Reply-To: <20150523014037.GL32152@google.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Linux PCI <linux-pci@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Friday, May 22, 2015 08:40:37 PM Bjorn Helgaas wrote:
> On Mon, Apr 13, 2015 at 04:23:36PM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > Refine the mechanism introduced by commit f244d8b623da (ACPIPHP / radeon
> > / nouveau: Fix VGA switcheroo problem related to hotplug) to propagate
> > the ignore_hotplug setting of the device to its parent bridge in case
> > hotplug notifications related to the graphics adapter switching are
> > given for the bridge rather than for the device itself (the need to
> > be ignored in both cases).
> > 
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=61891
> > Link: https://bugs.freedesktop.org/show_bug.cgi?id=88927
> > Reported-and-tested-by: tiagdtd-lava <tiagdtd-lava@yahoo.de>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Applied to pci/hotplug for v4.2, thanks!
> 
> I marked it for stable and added a note to connect it to b440bde74f04
> ("PCI: Add pci_ignore_hotplug() to ignore hotplug events for a device")

Thanks a lot!

