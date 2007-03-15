From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: ibm-acpi bay and acpi generic bay convergence
Date: Thu, 15 Mar 2007 19:04:14 -0300
Message-ID: <20070315220414.GC15572@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:58150 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753392AbXCOWEW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 15 Mar 2007 18:04:22 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net

Kristen,

I just compared ibm-acpi bay stuff with what is in the generic driver.
Here's a initial take of stuff to do:


1. The generic driver only handles hotplug bays (_EJ0).  I'd like to also
handle warm/coldplug bays (_EJ3).

Warm/coldplug bays are available on ThinkPads model 600e/x, A2Xm/p, A3Xm/p.
They are otherwise as hard (or easy) to handle as any other thinkpad bay.

I don't know if for such bays it would be better to eject when preparing for
a suspend instead of immediately, as they lack the required hardware to
allow for safe removal of devices while the machine is still on.

2. The current logic for is_ata probably won't get everything PATA.  I
assume nobody is doing SATA bays without the SATA namespace nodes, but that
is also a possible source of error.  I didn't have time to manually check
the ThinkPad DSDTs I have around to see if there is a known failure for
PATA, yet.

If is_ata could try harder to identify a PATA/SATA device that is missing
the usual nodes, it would be better. However, I have *no* idea on how to do
that.

It is, however, a good enough reason to export an API to allow drivers like
ibm-acpi to inform ACPI_BAY that a given handle should be added as a bay --
this allows us to use higly model-specific knowledge (like a fixed map
between DSDT namespace to PATA port) to locate every bay.  That would also
require an API for ibm-acpi to know if ACPI_BAY gets loaded/unloaded...

If we were using anything less limited than the platform bus, we could even
do this properly and just have ibm-acpi register bay devices that the driver
model would match with a bay driver (ACPI_BAY).  That would also make it
extremely easy to deal with device-specific attributes, and inter-module
communication.  Can we have that proper bus for ACPI stuff, pretty please?

3. is_ejectable_bay is too simple-minded.  It could work for batteries, if it
didn't try so hard to detect only sata/ata devices as bays.  Maybe it can be
changed to try to detect anything that can be ejected and which is not a
dock?  It would find thinkpad batteries, then.

Alternatively, I can use the API I asked for (2) to register the battery bay
handler.  But that looks less optimal, right now.


I need to do some tests to check what happens in a thinkpad when you swap an
ATAPI device with a battery, let's hope IBM did the right thing re. the
event sources since they have two bay handles that belong to the same bay,
and that Lenovo didn't break it.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
