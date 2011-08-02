From: Len Brown <lenb@kernel.org>
Subject: [PATCH 27/27] ACPI: add missing _OSI strings
Date: Tue, 02 Aug 2011 16:53:29 -0400
Message-ID: <aa165971c2923d05988f920c978e438dbc7b0de6.1312318300.git.len.brown@intel.com>
References: <1312318409-29363-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:41222 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755541Ab1HBVwI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Aug 2011 17:52:08 -0400
Received: from localhost.localdomain ([unknown] [65.175.195.226])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LPB00IROM2GJRGL@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 02 Aug 2011 16:52:06 -0500 (CDT)
In-reply-to: <1312318409-29363-1-git-send-email-lenb@kernel.org>
In-reply-to: <c8cefe307d79c57b32ca1d4c9ebff528f8dd914c.1312318300.git.len.brown@intel.com>
References: <c8cefe307d79c57b32ca1d4c9ebff528f8dd914c.1312318300.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Shaohua Li <shaohua.li@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>

From: Shaohua Li <shaohua.li@intel.com>

Linux supports some optional features, but it should notify the BIOS about
them via the _OSI method.  Currently Linux doesn't notify any, which might
make such features not work because the BIOS doesn't know about them.

Jarosz has a system which needs this to make ACPI processor aggregator
device work.

Reported-by: "Jarosz, Sebastian" <sebastian.jarosz@intel.com>
Signed-off-by: Shaohua Li <shaohua.li@intel.com>
Acked-by: Matthew Garrett <mjg@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/osl.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 372f9b7..0e47857 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -1083,7 +1083,13 @@ struct osi_setup_entry {
 	bool enable;
 };
 
-static struct osi_setup_entry __initdata osi_setup_entries[OSI_STRING_ENTRIES_MAX];
+static struct osi_setup_entry __initdata
+		osi_setup_entries[OSI_STRING_ENTRIES_MAX] = {
+	{"Module Device", true},
+	{"Processor Device", true},
+	{"3.0 _SCP Extensions", true},
+	{"Processor Aggregator Device", true},
+};
 
 void __init acpi_osi_setup(char *str)
 {
-- 
1.7.6.396.ge0613

