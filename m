From: =?UTF-8?B?w4lyaWMgUGllbA==?= <Eric.Piel@tremplin-utc.net>
Subject: [PATCH 2/3] Taint kernel on ACPI table override
Date: Sun, 03 Feb 2008 18:29:27 +0100
Message-ID: <47A5F9F7.2080901@tremplin-utc.net>
References: <4798E2A5.6020804@users.sf.net> <200801311417.57469.lenb@kernel.org> <1201859637.14573.41.camel@queen.suse.de> <200802012336.10687.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailservice.tudelft.nl ([130.161.131.5]:8235 "EHLO
	mailservice.tudelft.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756134AbYBCR3b (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 3 Feb 2008 12:29:31 -0500
In-Reply-To: <200802012336.10687.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: trenn@suse.de, Andrew Morton <akpm@linux-foundation.org>, Philippe Coval <rzr@users.sourceforge.net>, linux-acpi@vger.kernel.org, dsdt <dsdt@gaugusch.at>

When an ACPI table is overridden (for now this can happen only for DSDT)
display a big warning and taint the kernel with flag A.

Signed-off-by: Eric Piel <eric.piel@tremplin-utc.net>
---
  drivers/acpi/osl.c     |    7 +++++++
  include/linux/kernel.h |    1 +
  kernel/panic.c         |    5 +++--
  3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 4568a59..549daea 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -392,6 +392,13 @@ acpi_os_table_override(struct acpi_table_header * existing_table,
  			*new_table = initrd_table;
  	}
  #endif
+	if (*new_table != NULL) {
+		printk(KERN_WARNING PREFIX "Override [%4.4s-%8.8s], "
+			   "this is unsafe: tainting kernel\n",
+		       existing_table->signature,
+		       existing_table->oem_table_id);
+		add_taint(TAINT_OVERRIDDEN_ACPI_TABLE);
+	}
  	return AE_OK;
  }

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index a7283c9..f51f8bd 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -240,6 +240,7 @@ extern enum system_states {
  #define TAINT_BAD_PAGE			(1<<5)
  #define TAINT_USER			(1<<6)
  #define TAINT_DIE			(1<<7)
+#define TAINT_OVERRIDDEN_ACPI_TABLE	(1<<8)

  extern void dump_stack(void) __cold;

diff --git a/kernel/panic.c b/kernel/panic.c
index da4d6ba..1b7a002 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -160,7 +160,7 @@ const char *print_tainted(void)
  {
  	static char buf[20];
  	if (tainted) {
-		snprintf(buf, sizeof(buf), "Tainted: %c%c%c%c%c%c%c%c",
+		snprintf(buf, sizeof(buf), "Tainted: %c%c%c%c%c%c%c%c%c",
  			tainted & TAINT_PROPRIETARY_MODULE ? 'P' : 'G',
  			tainted & TAINT_FORCED_MODULE ? 'F' : ' ',
  			tainted & TAINT_UNSAFE_SMP ? 'S' : ' ',
@@ -168,7 +168,8 @@ const char *print_tainted(void)
  			tainted & TAINT_MACHINE_CHECK ? 'M' : ' ',
  			tainted & TAINT_BAD_PAGE ? 'B' : ' ',
  			tainted & TAINT_USER ? 'U' : ' ',
-			tainted & TAINT_DIE ? 'D' : ' ');
+			tainted & TAINT_DIE ? 'D' : ' ',
+			tainted & TAINT_OVERRIDDEN_ACPI_TABLE ? 'A' : ' ');
  	}
  	else
  		snprintf(buf, sizeof(buf), "Not tainted");
