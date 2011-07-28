From: akpm@linux-foundation.org
Subject: [patch 5/5] acpi: add missing _OSI strings
Date: Thu, 28 Jul 2011 13:48:43 -0700
Message-ID: <201107282048.p6SKmihW007591@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:54427 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754934Ab1G1Usq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 28 Jul 2011 16:48:46 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, shaohua.li@intel.com, mjg@redhat.com, sebastian.jarosz@intel.com

From: Shaohua Li <shaohua.li@intel.com>

Linux supports some optional features, but it should notify the BIOS about
them via the _OSI method.  Currently Linux doesn't notify any, which might
make such features not work because the BIOS doesn't know about them.

Jarosz has a system which needs this to make ACPI processor aggregator
device work.

Reported-by: "Jarosz, Sebastian" <sebastian.jarosz@intel.com>
Signed-off-by: Shaohua Li <shaohua.li@intel.com>
Acked-by: Matthew Garrett <mjg@redhat.com>
Cc: Len Brown <lenb@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/acpi/osl.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff -puN drivers/acpi/osl.c~acpi-add-missing-_osi-strings-resend drivers/acpi/osl.c
--- a/drivers/acpi/osl.c~acpi-add-missing-_osi-strings-resend
+++ a/drivers/acpi/osl.c
@@ -1098,7 +1098,13 @@ struct osi_setup_entry {
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
_
