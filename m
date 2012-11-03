From: Zhang Rui <rui.zhang@intel.com>
Subject: [GIT PULL] Thermal management & ACPI update for v3.7-rc4
Date: Sat, 03 Nov 2012 19:08:35 +0800
Message-ID: <1351940915.2523.15.camel@rzhang1-mobl4>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:3749 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751541Ab2KCLIm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 3 Nov 2012 07:08:42 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>, "Wu, Fengguang" <fengguang.wu@intel.com>

Hi Linus,

Could you please pull from the git repository at

  git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git release

to receive three thermal and acpi fixes for v3.7-rc4.

thanks,
rui


The following changes since commit
1e207eb1c3f0e8b690401f02fe08e7b53903f010:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/nab/target-pending
(2012-10-31 15:42:08 -0700)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git 

for you to fetch changes up to 2566285df1863f69a6552dbcd8f38153db8d2e15:

  exynos4_tmu_driver_ids should be exynos_tmu_driver_ids. (2012-11-01
09:21:54 +0800)

----------------------------------------------------------------
Devendra Naga (1):
      thermal: solve compilation errors in rcar_thermal

Igor Murzov (1):
      ACPI video: Ignore errors after _DOD evaluation.

Jonghwan Choi (1):
      exynos4_tmu_driver_ids should be exynos_tmu_driver_ids.

 drivers/acpi/video.c             |   11 +++++++----
 drivers/thermal/exynos_thermal.c |    2 +-
 drivers/thermal/rcar_thermal.c   |    2 +-
 3 files changed, 9 insertions(+), 6 deletions(-)


