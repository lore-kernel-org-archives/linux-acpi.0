From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: [PATCH 0/7] acer-wmi patches for 2.6.27
Date: Sat, 21 Jun 2008 09:09:03 +0100
Message-ID: <20080621080903.26920.14225.stgit@pacifica>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bb-87-81-255-5.ukonline.co.uk ([87.81.255.5]:38509 "EHLO
	pacifica" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755107AbYFUIgI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 21 Jun 2008 04:36:08 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org

Len,

The following series is the latest set of updates for acer-wmi.

For the most part, these are just a few minor tweaks, fixes for Fujitsu Siemens laptops,
and the addition of some debugfs output for future reverse engineering.

-Carlos
---

Carlos Corbacho (7):
      acer-wmi: Remove version number
      acer-wmi: Add debugfs file for device detection
      acer-wmi: Disable device autodetection on Fujitsu Siemens Amilo Li2732
      acer-wmi: Add EC quirk for Fujitsu Siemens Amilo Li 1718
      acer-wmi: Respect framebuffer blanking in backlight
      acer-wmi: Blacklist backlight on Acer Aspire 1520 & 1360 series
      acer-wmi: Remove LED colour comment from documentation


 Documentation/laptops/acer-wmi.txt |    2 
 drivers/misc/acer-wmi.c            |  145 ++++++++++++++++++++++++++++++++++--
 2 files changed, 135 insertions(+), 12 deletions(-)

