From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 0/2] ACPI / PMIC: make some  structures and function argument as const
Date: Fri,  3 Nov 2017 16:03:46 +0100
Message-ID: <1509721428-6147-1-git-send-email-bhumirks@gmail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:49425 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755282AbdKCPDz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Nov 2017 11:03:55 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: julia.lawall@lip6.fr, rjw@rjwysocki.net, lenb@kernel.org, andy@infradead.org, mika.westerberg@linux.intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>

Make some structures and the argument of the function 
intel_pmic_install_opregion_handler as const. After this change,
make the structures of type intel_pmic_opregion_data as const. 

Bhumika Goyal (2):
  ACPI / PMIC: Make some pointers, structure field and function argument
        as const
  ACPI / PMIC: make intel_pmic_opregion_data structures const

 drivers/acpi/pmic/intel_pmic.c        | 10 +++++-----
 drivers/acpi/pmic/intel_pmic.h        |  4 +++-
 drivers/acpi/pmic/intel_pmic_bxtwc.c  |  2 +-
 drivers/acpi/pmic/intel_pmic_chtwc.c  |  2 +-
 drivers/acpi/pmic/intel_pmic_crc.c    |  2 +-
 drivers/acpi/pmic/intel_pmic_xpower.c |  2 +-
 6 files changed, 12 insertions(+), 10 deletions(-)

-- 
1.9.1

