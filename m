From: Al Stone <al.stone@linaro.org>
Subject: [PATCH 0/4] Fix regressions uncovered by bad_madt_entry() patches
Date: Wed, 14 Oct 2015 15:26:21 -0600
Message-ID: <1444857985-28844-1-git-send-email-al.stone@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179]:34589 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932093AbbJNV0h (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Oct 2015 17:26:37 -0400
Received: by igbni9 with SMTP id ni9so1374060igb.1
        for <linux-acpi@vger.kernel.org>; Wed, 14 Oct 2015 14:26:36 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linaro-acpi@lists.linaro.org, linaro-kernel@lists.linaro.org, patches@linaro.org, Al Stone <al.stone@linaro.org>

Once the patch series "Provide better MADT subtable sanity checks" got
into linux-next (commit b9e11e92b9), several existing platforms were found
where the firmware was doing odd things that aren't exactly correct if
the ACPI specification is being followed precisely.  This patch series
relaxes some of the checks on MADT subtables so that these previously 
working systems (all x86-based) will continue to boot.  For arm64, since
ACPI usage is still relatively new, the stricter checking is left in place.

Al Stone (4):
  ACPI: workaround x86 firmware using reserved MADT subtable IDs
  ACPI: workaround x86 firmware with mis-matched FADT/MADT revisions
  ACPI: workaround FADT always being revision 2
  ACPI: for bad_madt_entry(), the GIC ITS table is 20 bytes long, not 16

 drivers/acpi/tables.c | 62 ++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 51 insertions(+), 11 deletions(-)

-- 
2.4.3

