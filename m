From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 00/15] acpi4asus updates
Date: Thu, 18 Jun 2009 02:21:54 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0906180157380.8921@localhost.localdomain>
References: <1245180536-28009-1-git-send-email-corentincj@iksaif.net>
 <alpine.LFD.2.00.0906172241040.8921@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:53863 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757641AbZFRGbp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 18 Jun 2009 02:31:45 -0400
Received: from localhost.localdomain ([98.118.45.40])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KLF00GKZ8CK35T0@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 18 Jun 2009 01:21:57 -0500 (CDT)
In-reply-to: <alpine.LFD.2.00.0906172241040.8921@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Corentin Chary <corentincj@iksaif.net>
Cc: linux-acpi@vger.kernel.org

> applied

This series was okay in my 2.6.30-based test tree -- modulo
a simple conflict with Bjorn's .notify patch.  But there are more
conflicts when merged up w/ Linus in preparation for a push
due to the rfkill changes that are upstream:-(

I got lost trying to merge that branch on top of Linus's tree --
git merges do all the branch conflicts at once rather than
patch-by-patch, so I quickly lost track of which line was
from which patch.

So I abandoned the 2.6.30-based asus branch in my test tree
and instead created a new asus branch on top of my release
tree, which contains Linus' latest, bjorn's .notifiy series;
and I simply took the (6) patches in the series that applied
cleanly and skipped the ones that did not.

Corentin,
If you can refresh the skipped patches below (or simply the whole series)
so it applies on top of my test or release trees, that would be great.

thanks,
-Len


Subject: [01/15] eeepc-laptop: Register as a pci-hotplug device

skipped

Subject: [02/15] eeepc: fix kconfig selects

skipped

Subject: [03/15] eeepc-laptop.c: use pr_fmt and pr_<level>

skipped

Subject: [04/15] eeepc-laptop: enable camera by default

applied

Subject: [05/15] asus-laptop: platform dev as parent for led and backlight

applied

Subject: [06/15] acpi4asus: update MAINTAINER and KConfig links

applied

Subject: [07/15] asus_acpi: Deprecate in favor of asus-laptop

applied

Subject: [08/15] asus-laptop: use pr_fmt and pr_<level>

skipped

Subject: [09/15] eeepc-laptop: rfkill refactoring

skipped

Subject: [10/15] eeepc-laptop: right parent device

skipped

Subject: [11/15] eeepc-laptop: sync eeepc-laptop with asus_acpi

applied

Subject: [12/15] eeepc-laptop: makes get_acpi() returns -ENODEV

skipped

Subject: [13/15] eeepc-laptop: get the right value for CMSG

skipped

Subject: [14/15] eeepc-laptop: add rfkill support for the 3G modem in Eee PC

skipped

Subject: [15/15] eeepc-laptop: cpufv updates

applied.


