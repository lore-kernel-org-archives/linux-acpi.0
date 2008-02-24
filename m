From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: [PATCH 0/4] ACPI-WMI patches for 2.6.25-rc3
Date: Sun, 24 Feb 2008 13:34:13 +0000
Message-ID: <20080224133412.2317.5802.stgit@pacifica>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bb-87-81-255-5.ukonline.co.uk ([87.81.255.5]:34341 "EHLO
	pacifica" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756523AbYBXNee (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 24 Feb 2008 08:34:34 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org

Len,

The following patchset is a fix and some minor cleanups for 2.6.25-rc3.

The acer-wmi patches are minor cleanups to rename some unhelpful error
messages, remove a superflous warning (a user complained about this one),
and rename the mail LED in line with current reccomendations. There is no
functional change to the acer-wmi driver.

The WMI patch fixes a real bug observed on an Acer laptop, and has been
tested as working on the relevant hardware (yes, Acer can even manage to
violate ACPI-WMI :)

-Carlos
---

Carlos Corbacho (4):
      ACPI: WMI: Clean up handling of spec violating data blocks
      acer-wmi: Don't warn if mail LED cannot be detected
      acer-wmi: Make device detection error messages more descriptive
      acer-wmi: Rename mail LED correctly & remove hardcoded colour


 Documentation/laptops/acer-wmi.txt |    2 +-
 drivers/acpi/wmi.c                 |   10 ++++++----
 drivers/misc/acer-wmi.c            |   16 ++++++++--------
 3 files changed, 15 insertions(+), 13 deletions(-)


