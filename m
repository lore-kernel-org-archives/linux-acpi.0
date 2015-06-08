From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 0/6] ACPI / EC: Fix issues related to the event handling.
Date: Mon,  8 Jun 2015 13:26:59 +0800
Message-ID: <cover.1433734431.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:11979 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751539AbbFHF17 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 8 Jun 2015 01:27:59 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

ACPI specification doesn't define the SCI_EVT clearing timing for the EC
firmware. There could be 4 possible positions the firmware may use to clear
the SCI_EVT indication:
 STATUS: After indicating SCI_EVT to the host via the status register
         (EC_SC), the target can clear SCI_EVT at any time.
 QUERY: After seeing the query request (QR_EC) written to the command
        register (EC_CMD) by the host and having prepared the responding
        event value in the data register (EC_DATA), the target can safely
        clear SCI_EVT.
 EVENT: After seeing the event response read from the data register
        (EC_DATA) by the host, the target can clear SCI_EVT.
 METHOD: After the event has been handled via the host _Qxx evaluation,
         the target can clear SCI_EVT.

The old EC driver re-checked SCI_EVT using the 3rd position, while during
the race fixes, the new EC driver was switched to re-check SCI_EVT using
the 1st position. Using the earliest position may help to reduce issues
when the other races are not fully fixed and there is an ACPI specification
statement around an expected behavior:
 The query value of zero is reserved for a spurious query result and
 indicates "no outstanding events."
This statement was the motivation of this choice.

But there are platforms do not follow this definition, since there is also
a coverity issue left in the new EC driver, the unmatched SCI_EVT clearing
timing finally was trapped by this coverity issue, and users can see that
the new EC driver stops processing further SCI_EVTs. The new EC driver then
implemented EC_FLAGS_QUERY_HANDSHAKE quirk as a workaround for such
platforms.
Now more and more reports can be seen for this SCI_EVT clearing timing
unmatched problem, we need to consider a better approach to fix all of them
instead of adding new EC_FLAGS_QUERY_HANDSHAKE quirk users.

This patchset thus finally implements 4 modes to handle the SCI_EVT
clearing timing variations. And according to the tests, chooses the next
earlier position (the 2rd position) as the default behavior.
This patchset also fixes the coverity problem so that even though the
default behavior still cannot match the Windows behavior, it is possible
for the new EC driver to proceed to handle further SCI_EVT indications.

Related bug reports are as follows:
Link: https://bugzilla.kernel.org/show_bug.cgi?id=44161
Link: https://bugzilla.kernel.org/show_bug.cgi?id=82611
Link: https://bugzilla.kernel.org/show_bug.cgi?id=94411
Link: https://bugzilla.kernel.org/show_bug.cgi?id=97381
Link: https://bugzilla.kernel.org/show_bug.cgi?id=98111

Lv Zheng (6):
  ACPI / EC: Cleanup transaction state transition.
  ACPI / EC: Cleanup _Qxx evaluation work item.
  ACPI / EC: Convert event handling work queue into loop style.
  ACPI / EC: Add event clearing variation support.
  ACPI / EC: Fix EC_FLAGS_QUERY_HANDSHAKE platforms using new event
    clearing timing.
  ACPI / EC: Fix a code coverity issue when QR_EC transactions are
    failed.

 drivers/acpi/ec.c       |  272 ++++++++++++++++++++++++++++++++++++++---------
 drivers/acpi/internal.h |    1 +
 2 files changed, 223 insertions(+), 50 deletions(-)

-- 
1.7.10

