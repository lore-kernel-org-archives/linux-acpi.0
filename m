From: Imre Deak <imre.deak@intel.com>
Subject: 4.9-rc1: [TMP_] ACPI namespace lookup failure, AE_ALREADY_EXISTS
Date: Thu, 20 Oct 2016 00:36:41 +0300
Message-ID: <1476913001.7633.13.camel@intel.com>
Reply-To: imre.deak@intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:19440 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753800AbcJSVgt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 19 Oct 2016 17:36:49 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org, devel@acpica.org

Hi,

after upgrading to 4.9-rc1 I get the following errors occasionally
during boot and suspend-to-ram on an APL system:

[   59.513434] ACPI Error: [TMP_] Namespace lookup failure, AE_ALREADY_EXISTS (20160831/dswload2-330)
[   59.513446] ACPI Exception: AE_ALREADY_EXISTS, During name lookup/catalog (20160831/psobject-227)
[   59.513469] ACPI Error: Method parse/execution failed [\_SB.PCI0.SCPG] (Node ffff8802770b7bb8), AE_ALREADY_EXISTS (20160831/psparse-543)
[   59.515415] ACPI Error: Method parse/execution failed [\_SB.PCI0.SDHA._PS3] (Node ffff8802770b7dc0), AE_ALREADY_EXISTS (20160831/psparse-543)
[   59.517118] ACPI: Marking method _PS3 as Serialized because of AE_ALREADY_EXISTS error

Other than these error messages, booting and suspend/resume seems to work ok.
Bisecting points to
commit 74f51b80a0c4ff84fbeb7f12ea43ce66934d29aa
Author: Lv Zheng <lv.zheng@intel.com>
Date:   Wed Sep 7 14:07:10 2016 +0800

    ACPICA: Namespace: Fix dynamic table loading issues

Reverting this on top of 4.9-rc1 gets rid of the error messages.

--Imre
