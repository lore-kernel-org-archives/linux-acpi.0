From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 00/21] ACPI: ibm-acpi: cleanups, extended fan/thermal support
Date: Sat, 25 Nov 2006 18:41:55 -0200
Message-ID: <20061125204155.6604.35338.stgit@thorin.khazad-dum.debian.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:46005 "EHLO
	out2.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S967177AbWKYUly (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 25 Nov 2006 15:41:54 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org


This patch series contains the ibm-acpi devel queue for 2006-11-25.
Please merge for acpi-test.

Patch 1 fixes sub-driver naming so that it doesn't get in the way of
a ACPI sysfs conversion work.

Patch 2 just does some Lindent housekeeping work, as Len said he likes
code to be as Lindent-clean as possible.

Patches 3-5 extend thermal support for the new thinkpads, and updates
thermal docs.

Patches 6-13 extend fan support for new thinkpads, so people will stop
using ecdump to directly modify EC registers ;-)

Patches 14-15 implement a work-around for a bug in the EC firmware in
certain thinkpads, see
http://thinkwiki.org/wiki/Embedded_Controller_Firmware#Bug:_Fan_control_loop_status_is_not_initialized

Patch 16 adds a watchdog functionality for fan control that has been
requested by developers of userspace fan control utilities.  Many
thinkpads have very annoying out-of-the-box fan behaviour, so userspace
fan control is quite widespread among T4x owners, for example.

Patch 17 adds support for SATA ultrabay (advanced ultrabay), found in
*60 and *61 x/t/z-series.

Patch 18 makes ibm-acpi non-generic bay support optional.

Patch 19 refactors backlight support so that it is in line with 
the rest of the ibm-acpi driver code.

Patches 20-21 are just housekeeping.

This patch series is available for git pull from:
git://repo.or.cz/linux-2.6/linux-acpi-2.6/ibm-acpi-2.6.git branch
for-upstream/acpi-test.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
