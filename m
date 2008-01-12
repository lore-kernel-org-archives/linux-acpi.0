From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Lenovo ThinkPads need acpi_osi="Linux"
Date: Sat, 12 Jan 2008 00:23:48 -0200
Message-ID: <20080112022348.GC27524@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:47930 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752484AbYALCXw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 11 Jan 2008 21:23:52 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

While helping a user find out what happened to his mute key, I found out
that the Lenovo BIOSes need the OSI string Linux defined to behave properly
in Linux.

Lenovo has been attempting to make things a bit easier for Linux on their
ThinkPads, by disabling the more obnoxious behaviours of the firmware (used
by their Windows drivers) when in Linux.  It looks like they used the OSI
string for that.

It is probably worthwhile to give a head's up: regressions involving
thinkpads and 2.6.23+ should probably have a 'please test with
acpi_osi="Linux"' step added if there is any chance ACPI AML code, BIOS or
SMBIOS code, or EC behaviour could be involved.

The most concrete example I have right now of changed behaviour is the Mute
key on the T61, which just plain disappears if acpi_osi="!Linux" (2.6.23
default).

I have also seen some hacked DSDTs around (mostly for older T4x models)
which used the Linux OSI string to fix or work around AML weirdness.  Those
would break in 2.6.23 (and 2.6.24?) as well.

Now, what should we do about it?  Add a quirk to always define the Linux OSI
string on ThinkPads (based on DMI information)?  All IBM ones (which won't
have BIOS revisions anymore, anyway) deal well with it, and Lenovo ones
seem to benefit from it.

We could also ask Lenovo to change the BIOS to stop paying attention to that
OSI string, but they will likely want/need a trigger for the AML code to
know it should change behaviour anyway, and the OSI string *does* look like
the proper thing to use IMHO.  I don't know if we could get them to arrive
to a behaviour that is acceptable both to us, and also to their Windows
drivers...

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
