From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: [PATCH 0/3] WMI patches for 2.6.28 (Resend)
Date: Wed, 08 Oct 2008 21:40:15 +0100
Message-ID: <20081008204015.1815.15275.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bb-87-81-255-5.ukonline.co.uk ([87.81.255.5]:35545 "EHLO
	pacifica." rhost-flags-OK-OK-FAIL-FAIL) by vger.kernel.org with ESMTP
	id S1751314AbYJHUk1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 8 Oct 2008 16:40:27 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org

Len,

The following are three WMI patches for 2.6.28 (resending them again, this
is the same series I sent out a month ago).

The first two add rfkill support to acer-wmi for wireless & bluetooth, and
remove the old sysfs interfaces for these.

The third patch, from Matthew Garrett, adds event enabling/ disabling for
certain events to WMI, and is required for another WMI driver he's working
on.

-Carlos
---

Carlos Corbacho (2):
      acer-wmi: Remove wireless and bluetooth sysfs entries
      acer-wmi: Add rfkill support for wireless and bluetooth

Matthew Garrett (1):
      ACPI: WMI: Enable event methods when registering notifiers


 Documentation/laptops/acer-wmi.txt |   28 +---
 drivers/acpi/wmi.c                 |   39 ++++++
 drivers/misc/Kconfig               |    1 
 drivers/misc/acer-wmi.c            |  229 +++++++++++++++++++++++-------------
 4 files changed, 191 insertions(+), 106 deletions(-)

-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
