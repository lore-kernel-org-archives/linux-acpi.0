From: Ben Guthro <benjamin.guthro@citrix.com>
Subject: [PATCH v5 0/5] Xen/ACPI: support sleep state entering on hardware reduced systems
Date: Fri, 28 Jun 2013 09:46:19 -0400
Message-ID: <1372427184-6197-1-git-send-email-benjamin.guthro@citrix.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp02.citrix.com ([66.165.176.63]:14174 "EHLO
	SMTP02.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751132Ab3F1Nqh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 28 Jun 2013 09:46:37 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Jan Beulich <jbeulich@suse.com>, "Rafael J . Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, xen-devel@lists.xen.org
Cc: Ben Guthro <benjamin.guthro@citrix.com>, Richard L Maliszewski <richard.l.maliszewski@intel.com>, Gang Wei <gang.wei@intel.com>, Shane Wang <shane.wang@intel.com>, Bob Moore <robert.moore@intel.com>, tboot-devel@lists.sourceforge.net

In version 3.4 acpi_os_prepare_sleep() got introduced in parallel with
reduced hardware sleep support, and the two changes didn't get
synchronized: The new code doesn't call the hook function (if so
requested). Fix this, requiring a boolean parameter to be added to the
hook function to distinguish "extended" from "legacy" sleep.

This requires adjusting TXT, but the adjustments only go as far as
failing the extended mode call (since, looking at the TXT interface,
there doesn't even appear to be precautions to deal with that
alternative interface).

The hypervisor change underlying this is commit 62d1a69 ("ACPI: support
v5 (reduced HW) sleep interface") on the master branch of
git://xenbits.xen.org/xen.git.

Signed-off-by: Jan Beulich <jbeulich@suse.com>
Signed-off-by: Ben Guthro <benjamin.guthro@citrix.com>
Cc: Richard L Maliszewski <richard.l.maliszewski@intel.com>
Cc: Gang Wei <gang.wei@intel.com>
Cc: Shane Wang <shane.wang@intel.com>
Cc: Bob Moore <robert.moore@intel.com>
Cc: Rafael J. Wysocki <rjw@sisk.pl>
Cc: linux-acpi@vger.kernel.org
Cc: tboot-devel@lists.sourceforge.net 

v2: Extend description to include reference to hypervisor side change
v3: Split into multiple patches, separating subsystems
    Remove bool parameters, in favor of u8
v4: Remove linux/acpi.h dependencies
    Further patch split to break out acpica from OSL
    More bool vs u8 fixes
v5: Fix build of consumers of acpi_os_prepare_sleep() interface change,
    so intermediate builds of partial patch series will not fail.

Ben Guthro (5):
  acpi: Remove need to include linux/acpi.h in common acpica code
  acpi: Call acpi_os_prepare_sleep hook in reduced hardware sleep path
  acpi: Adjust linux acpi OS functions to new extended parameter
  x86/tboot: Fail extended mode reduced hardware sleep
  xen/acpi: notify xen when reduced hardware sleep is available

 arch/x86/kernel/tboot.c          |    6 +++++-
 drivers/acpi/acpica/hwesleep.c   |    7 +++++++
 drivers/acpi/acpica/hwsleep.c    |    3 +--
 drivers/acpi/osl.c               |   16 ++++++++--------
 drivers/xen/acpi.c               |   26 +++++++++++++-------------
 include/acpi/acpiosxf.h          |    6 ++++++
 include/linux/acpi.h             |    9 +++------
 include/xen/acpi.h               |    4 ++--
 include/xen/interface/platform.h |    7 ++++---
 9 files changed, 49 insertions(+), 35 deletions(-)

-- 
1.7.9.5

