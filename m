From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: [PATCH 0/3] acer-wmi patches for 2.6.30
Date: Sat, 04 Apr 2009 09:12:43 +0100
Message-ID: <20090404081243.9812.3769.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bb-87-81-255-5.ukonline.co.uk ([87.81.255.5]:37592 "EHLO
	pegasus." rhost-flags-OK-OK-FAIL-FAIL) by vger.kernel.org with ESMTP
	id S1750913AbZDDIUk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 4 Apr 2009 04:20:40 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org

Len,

The following are the patches for 2.6.29-rc5 for acer-wmi.

The first one is quite a nasty one, as it appears the Aspire One's
non-functional ACPI-WMI interface is now causing problems for userspace.

-Carlos
---

Andy Whitcroft (1):
      acer-wmi: Cleanup the failure cleanup handling

Carlos Corbacho (2):
      acer-wmi: Update copyright notice & documentation
      acer-wmi: Blacklist Acer Aspire One


 Documentation/laptops/acer-wmi.txt |   10 +++++++---
 drivers/platform/x86/acer-wmi.c    |   37 ++++++++++++++++++++++++++++++++++--
 2 files changed, 42 insertions(+), 5 deletions(-)


