From: Kast Bernd <kastbernd@gmx.de>
Subject: [RFC 0/2] asus notebook fan control
Date: Wed, 22 Apr 2015 16:12:26 +0200
Message-ID: <cover.1429653764.git.kastbernd@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.22]:50117 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757232AbbDVOMc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 22 Apr 2015 10:12:32 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: corentin.chary@gmail.com
Cc: rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, dvhart@infradead.org, acpi4asus-user@lists.sourceforge.net, platform-driver-x86@vger.kernel.org

Hello,

This patchset implements a fan control for asus notebooks.
It's based on Felipe Contreras' patch
(https://lkml.org/lkml/2013/10/8/800), that was proposed one and a half
year ago, but never made it to the kernel, because of the use of
"virt_to_phys".
This problem is solved by using the acpi internal function that is
activated by the first patch (ACPI_FUTURE_USAGE is removed).
The second patch implements the actual fan control functions, with a
similar logic than Felipe, but using hwmon instead of the thermal
interface and some bugs removed.

This patchset contains the following 2 patches:
0001-ACPI-activate-export-acpi_os_get_physical_address.patch
0002-asus-wmi-add-fan-control.patch

This is my first kernel patch. I tried to respect all style rules and
implement it properly. I couldn't find any try to fix the old patch in
recent time, thus I wrote this new patch.

I would appreciate any kind of feedback to get this patch upstream.


Kast Bernd (2):
  ACPI: activate&export acpi_os_get_physical_address
  asus-wmi: add fan control

 drivers/acpi/osl.c              |   3 +-
 drivers/platform/x86/asus-wmi.c | 297 +++++++++++++++++++++++++++++++++++++---
 2 files changed, 278 insertions(+), 22 deletions(-)

-- 
2.3.5

