From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 0/4] PCI/ACPI PM: Propagate wake-up enable upstream
Date: Fri, 4 Sep 2009 00:02:02 +0200
Message-ID: <200909040002.02562.rjw@sisk.pl>
References: <200908300041.14541.rjw@sisk.pl> <200909012103.19761.rjw@sisk.pl> <200909020041.57754.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:39275 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932370AbZICWGh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 3 Sep 2009 18:06:37 -0400
In-Reply-To: <200909020041.57754.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-pm@lists.linux-foundation.org
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Jesse Barnes <jbarnes@virtuousgeek.org>, Linux PCI <linux-pci@vger.kernel.org>

On Wednesday 02 September 2009, Rafael J. Wysocki wrote:
> On Tuesday 01 September 2009, Rafael J. Wysocki wrote:
> > On Tuesday 01 September 2009, Matthew Garrett wrote:
> > > On Mon, Aug 31, 2009 at 11:24:20PM +0200, Rafael J. Wysocki wrote:
> > > 
> > > > Updated patch is appended, but there's a problem with it.  Namely, when the
> > > > root bridge GPE is shared with other devices, those devices are also enabled
> > > > to wake up and they may be kind of "interesting" (on one of my test boxes they
> > > > include the ethernet and audio adapters).  I'm not sure what to do about that.
> > > 
> > > Perhaps only enable it if a child device is enabled?
> > 
> > Well, the problem is that we have to enable the devices that share the GPE to
> > wake up together, but the child device we _really_ want to wake-up need not
> > be any of them.
> > 
> > Also, the child device may be enabled to wake up after we've run the "glue"
> > code.
> > 
> > Well, perhaps it's better to rework pci_enable_wake() so that it, if the device
> > doesn't have an ACPI handle and is not PCIe, it will go and enable the root
> > bridge to wake up as well?
> > 
> > I wonder what about the bridges between the desired wake-up device and the
> > root bridge.  I guess they also should be enabled to wake-up, so that they can
> > forward the PME# in case the system is designed this way.
> 
> Below is a prototype of what I was thinking of, although I'm not sure if that's
> enough.
> 
> Comments welcome.

Hm, no comments. :-(

In the meantime I spent some time on this problem and prepared the following
series of patches.

The last one has to be tested on the system it was invented for, but that's
going to take some time.

Comments welcome.

Rafael

