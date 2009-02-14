From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: [PATCH 0/4] WMI patches for 2.6.29-rc5
Date: Sat, 14 Feb 2009 09:53:43 +0000
Message-ID: <20090214095342.18550.24339.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bb-87-81-255-5.ukonline.co.uk ([87.81.255.5]:33145 "EHLO
	pegasus." rhost-flags-OK-OK-FAIL-FAIL) by vger.kernel.org with ESMTP
	id S1750898AbZBNKNO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 14 Feb 2009 05:13:14 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by pegasus. (8.14.3/8.13.8) with ESMTP id n1E9rhr3018578
	for <linux-acpi@vger.kernel.org>; Sat, 14 Feb 2009 09:53:43 GMT
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Len,

The following are a set of trivial patches for 2.6.29-rc5 for ACPI-WMI and
acer-wmi. The last patch in this series you may already have picked up,
but is reposted here for completeness sake.

-Carlos
---

Carlos Corbacho (2):
      acer-wmi: Unmark as 'experimental'
      ACPI: WMI: Unmark as 'experimental'

Dan Carpenter (1):
      acer-wmi: double free in acer_rfkill_exit()

Robert Jarzmik (1):
      acer-wmi: Fix acpi video detection


 drivers/platform/x86/Kconfig    |    6 ++----
 drivers/platform/x86/acer-wmi.c |    2 +-
 2 files changed, 3 insertions(+), 5 deletions(-)


