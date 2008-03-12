From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: [PATCH 0/3] acer-wmi patches for 2.6.25-rc5
Date: Wed, 12 Mar 2008 20:12:39 +0000
Message-ID: <20080312201238.2071.31534.stgit@pacifica>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bb-87-81-255-5.ukonline.co.uk ([87.81.255.5]:45898 "EHLO
	pacifica" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752500AbYCLUNG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 12 Mar 2008 16:13:06 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org

Len,

The following patchset is some minor cleanups and an extra DMI quirk for
2.6.25-rc5.

If you're not happy with applying patch #3 now, it can always wait until 2.6.26

-Carlos
---

Carlos Corbacho (3):
      acer-wmi: Add mail LED support for Acer Aspire 3610/ 5610
      acer-wmi: Fix DSDT path in documentation
      acer-wmi: Make device detection error messages more descriptive


 Documentation/laptops/acer-wmi.txt |    2 +-
 drivers/misc/acer-wmi.c            |   30 +++++++++++++++++++++++++-----
 2 files changed, 26 insertions(+), 6 deletions(-)


