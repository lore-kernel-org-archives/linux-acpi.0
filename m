From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: [PATCH 0/2] WMI based driver fixes for 2.6.25
Date: Fri, 08 Feb 2008 23:51:37 +0000
Message-ID: <20080208235137.2786.80503.stgit@pacifica>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bb-87-81-255-5.ukonline.co.uk ([87.81.255.5]:35728 "EHLO
	pacifica" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752312AbYBHXvy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 8 Feb 2008 18:51:54 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <lenb@kernel.org>

The following series is two small fixes to the WMI based drivers:

1) Make tc1100-wmi depend on EXPERIMENTAL, since its code base is completely
untested. (This is just a resend of the patch I sent earlier today).

2) Fix setting the backlight on acer-wmi for older Acer laptops.

These are both candidates for 2.6.25, but they can wait until -rc1 if need
be.

-Carlos
---

Carlos Corbacho (2):
      acer-wmi: Fix backlight on AMW0 (V1) laptops
      tc1100-wmi: Mark as experimental


 drivers/misc/Kconfig    |    3 ++-
 drivers/misc/acer-wmi.c |    6 ++----
 2 files changed, 4 insertions(+), 5 deletions(-)


