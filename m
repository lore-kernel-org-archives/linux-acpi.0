From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: PME# for add-on cards
Date: Mon, 24 Aug 2009 01:12:39 +0200
Message-ID: <200908240112.39424.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
Sender: linux-pci-owner@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Linux PCI <linux-pci@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hi,

Recently we've had a bug report indicating that WoL doesn't work with e100,
although the driver does everything needed to support it.  Apparently, the user
had to echo PCI0 to /proc/acpi/wakeup to make it work.

After some debugging it turned out that PCI0 is the PCI host bridge
(no-bus:pci0000:00), so apparently echoing PCI0 to /proc/acpi/wakeup causes
a wake-up GPE to be set up for the host bridge which triggers wake-up once
eth0 signals PME#.

So, it looks like we need to set up wake-up GPE for a host bridge for PME#
from add-on cards to work, at least on this particular box.

First, I wonder if that's the case in general (anybody knows?).  Second, if
that is the case, would it be a good idea to set up the host bridge wake-up GPE
by default?

Rafael
 
