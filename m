From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: [PATCH 0/3] WMI patches for 2.6.28
Date: Mon, 15 Sep 2008 22:32:29 +0100
Message-ID: <20080915213229.8464.20471.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bb-87-81-255-5.ukonline.co.uk ([87.81.255.5]:57962 "EHLO
	pacifica." rhost-flags-OK-OK-FAIL-FAIL) by vger.kernel.org with ESMTP
	id S1752317AbYIPTPE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 16 Sep 2008 15:15:04 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org

Len,

The following are three WMI patches for 2.6.28

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
      According to the ACPI-WMI spec, event blocks may provide a function call


 Documentation/laptops/acer-wmi.txt |   28 +---
 drivers/acpi/wmi.c                 |   39 ++++++
 drivers/misc/Kconfig               |    1 
 drivers/misc/acer-wmi.c            |  229 +++++++++++++++++++++++-------------
 4 files changed, 191 insertions(+), 106 deletions(-)

-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
