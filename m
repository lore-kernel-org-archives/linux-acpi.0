From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/2] PM / PCMCIA: Fix CardBus suspend/resume regression
Date: Sat, 26 Sep 2009 01:22:58 +0200
Message-ID: <200909260122.59030.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
Sender: linux-pci-owner@vger.kernel.org
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pcmcia@lists.infradead.org, Andrew Morton <akpm@linux-foundation.org>, Florian <fs-kernelbugzilla@spline.de>
List-Id: linux-acpi@vger.kernel.org

Hi,

The following two patches fix a regression causing CardBus resume to fail,
introduced during the 2.6.29 development cycle.

[1/2] Drops the second argument of pcmcia_socket_dev_suspend(), which is not
      used.

[2/2] Fixes the regression by moving the yenta suspend/resume to the late phase
      of suspend and early phase of resume, respectively.

If there are no objections, I'll push these patches through the suspend-2.6
tree early next week.

Thanks,
Rafael
