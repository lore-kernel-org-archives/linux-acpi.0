From: Ben Guthro <benjamin.guthro@citrix.com>
Subject: [PATCH v3 0/3] Xen/ACPI: support sleep state entering on hardware reduced systems
Date: Wed, 26 Jun 2013 10:06:12 -0400
Message-ID: <1372255575-29567-1-git-send-email-benjamin.guthro@citrix.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.citrix.com ([66.165.176.89]:54617 "EHLO SMTP.CITRIX.COM"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751368Ab3FZOG3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 26 Jun 2013 10:06:29 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Jan Beulich <jbeulich@suse.com>, "Rafaell J . Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, xen-devel@lists.xen.org
Cc: Ben Guthro <benjamin.guthro@citrix.com>, Richard L Maliszewski <richard.l.maliszewski@intel.com>, Gang Wei <gang.wei@intel.com>, Shane Wang <shane.wang@intel.com>, Bob Moore <robert.moore@intel.com>, tboot-devel@lists.sourceforge.net

I have volunteered to take over the efforts of Jan Beulich in getting
this patch series upstreamed. His original submission text is below,
along with the v3 modifications.


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

Signed-off-by: Ben Guthro <benjamin.guthro@citrix.com>
Signed-off-by: Jan Beulich <jbeulich@suse.com>
Cc: Richard L Maliszewski <richard.l.maliszewski@intel.com>
Cc: Gang Wei <gang.wei@intel.com>
Cc: Shane Wang <shane.wang@intel.com>
Cc: Bob Moore <robert.moore@intel.com>
Cc: Rafaell J. Wysocki <rjw@sisk.pl>
Cc: linux-acpi@vger.kernel.org
Cc: tboot-devel@lists.sourceforge.net 

v2: Extend description to include reference to hypervisor side change
v3: Split into multiple patches, separating subsystems
    Remove bool parameters, in favor of u8

Ben Guthro (3):
  acpi: Call acpi_os_prepare_sleep hook in reduced hardware sleep path
  x86/tboot: Fail extended mode reduced hardware sleep
  xen/acpi: notify xen when reduced hardware sleep is available

 arch/x86/kernel/tboot.c          |    6 +++++-
 drivers/acpi/acpica/hwesleep.c   |    8 ++++++++
 drivers/acpi/acpica/hwsleep.c    |    2 +-
 drivers/acpi/osl.c               |   16 ++++++++--------
 drivers/xen/acpi.c               |   26 +++++++++++++-------------
 include/linux/acpi.h             |   10 +++++-----
 include/xen/acpi.h               |    4 ++--
 include/xen/interface/platform.h |    7 ++++---
 8 files changed, 46 insertions(+), 33 deletions(-)

-- 
1.7.9.5

