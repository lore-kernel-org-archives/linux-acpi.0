From: =?UTF-8?B?w4lyaWMgUGllbA==?= <Eric.Piel@tremplin-utc.net>
Subject: [PATCH 3/3] Add acpi_no_initrd_override kernel parameter
Date: Sun, 03 Feb 2008 18:29:35 +0100
Message-ID: <47A5F9FF.9010401@tremplin-utc.net>
References: <4798E2A5.6020804@users.sf.net> <200801311417.57469.lenb@kernel.org> <1201859637.14573.41.camel@queen.suse.de> <200802012336.10687.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailservice.tudelft.nl ([130.161.131.5]:30127 "EHLO
	mailservice.tudelft.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755994AbYBCR3j (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 3 Feb 2008 12:29:39 -0500
In-Reply-To: <200802012336.10687.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: trenn@suse.de, Andrew Morton <akpm@linux-foundation.org>, Philippe Coval <rzr@users.sourceforge.net>, linux-acpi@vger.kernel.org, dsdt <dsdt@gaugusch.at>

The acpi_no_initrd_override parameter permits to disable the load of an ACPI
table from the initramfs.

Signed-off-by: Eric Piel <eric.piel@tremplin-utc.net>
---
  Documentation/kernel-parameters.txt |    3 +++
  drivers/acpi/osl.c                  |   14 +++++++++++++-
  2 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 17fc60e..9bda965 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -170,6 +170,9 @@ and is between 256 and 4096 characters. It is defined in the file

  	acpi_no_auto_ssdt	[HW,ACPI] Disable automatic loading of SSDT

+	acpi_no_initrd_override	[KNL,ACPI]
+			Disable loading custom ACPI tables from the initramfs
+
  	acpi_os_name=	[HW,ACPI] Tell ACPI BIOS the name of the OS
  			Format: To spoof as Windows 98: ="Microsoft Windows"

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 549daea..73d838f 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -77,6 +77,10 @@ static struct workqueue_struct *kacpi_notify_wq;
  #define	OSI_STRING_LENGTH_MAX 64	/* arbitrary */
  static char osi_additional_string[OSI_STRING_LENGTH_MAX];

+#ifdef CONFIG_ACPI_CUSTOM_DSDT_INITRD
+static int acpi_no_initrd_override;
+#endif
+
  /*
   * "Ode to _OSI(Linux)"
   *
@@ -386,7 +390,8 @@ acpi_os_table_override(struct acpi_table_header * existing_table,
  		*new_table = (struct acpi_table_header *)AmlCode;
  #endif
  #ifdef CONFIG_ACPI_CUSTOM_DSDT_INITRD
-	if (strncmp(existing_table->signature, "DSDT", 4) == 0) {
+	if ((strncmp(existing_table->signature, "DSDT", 4) == 0) &&
+	    !acpi_no_initrd_override) {
  		struct acpi_table_header *initrd_table = acpi_find_dsdt_initrd();
  		if (initrd_table)
  			*new_table = initrd_table;
@@ -402,6 +407,13 @@ acpi_os_table_override(struct acpi_table_header * existing_table,
  	return AE_OK;
  }

+int __init acpi_no_initrd_override_setup(char *s)
+{
+	acpi_no_initrd_override = 1;
+	return 1;
+}
+__setup("acpi_no_initrd_override", acpi_no_initrd_override_setup);
+
  static irqreturn_t acpi_irq(int irq, void *dev_id)
  {
  	return (*acpi_irq_handler) (acpi_irq_context) ? IRQ_HANDLED : IRQ_NONE;
