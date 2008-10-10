From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: [RFT PATCH 0/2] rfkill for tc1100-wmi
Date: Fri, 10 Oct 2008 18:59:58 +0100
Message-ID: <20081010175958.12879.26768.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bb-87-81-255-5.ukonline.co.uk ([87.81.255.5]:43405 "EHLO
	pegasus." rhost-flags-OK-OK-FAIL-FAIL) by vger.kernel.org with ESMTP
	id S1759558AbYJJSAH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 10 Oct 2008 14:00:07 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org

The following series implements rfkill support for tc1100-wmi, and rips out
the old sysfs interface for wireless.

As I don't have the hardware, this is compile-tested only, so I'd appreciate
some victims^^^^^^volunteers testing this first (and/ or possibly some time
in linux-next).

-Carlos
---

Carlos Corbacho (2):
      tc1100-wmi: Remove wireless sysfs entry
      tc1100-wmi: Convert wireless to use rfkill


 drivers/misc/Kconfig      |    5 +
 drivers/misc/tc1100-wmi.c |  153 +++++++++++++++++++++++++++++----------------
 2 files changed, 101 insertions(+), 57 deletions(-)

-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
