From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/9] PM: Asynchronous suspend of devices
Date: Thu, 10 Sep 2009 01:27:11 +0200
Message-ID: <200909100127.11252.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
Sender: linux-pci-owner@vger.kernel.org
To: linux-pm <linux-pm@lists.linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Pavel Machek <pavel@ucw.cz>, Alan Stern <stern@rowland.harvard.edu>, Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-acpi@vger.kernel.org

Hi,

The following series of patches implements asynchronous suspend and resume of
devices.

All of the patches have already been discussed, please refer to the changelogs
for details.

The patches are targeted at 2.6.33, so if there are no major objections, I'll
put them into the linux-next branch of the suspend-2.6 tree after .31-rc1 is
out.

Thanks,
Rafael
