From: akpm@linux-foundation.org
Subject: [patch 1/7] git-acpi: s390: struct bin_attribute changes
Date: Mon, 09 Jul 2007 11:33:12 -0700
Message-ID: <200707091833.l69IXDiT000333@imap1.linux-foundation.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:49694 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753727AbXGISd3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Jul 2007 14:33:29 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, heiko.carstens@de.ibm.com, greg@kroah.com, len.brown@intel.com, rui.zhang@intel.com, schwidefsky@de.ibm.com

From: Heiko Carstens <heiko.carstens@de.ibm.com>

git-acpi contains a patch that adds 'struct bin_attribute *' to
the read method of struct bin_attribute. This breaks s390:

  CC      arch/s390/kernel/ipl.o
arch/s390/kernel/ipl.c:317:
 warning: initialization from incompatible pointer type
arch/s390/kernel/ipl.c:340:
  warning: initialization from incompatible pointer type

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Greg KH <greg@kroah.com>
Cc: Len Brown <len.brown@intel.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/s390/kernel/ipl.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff -puN arch/s390/kernel/ipl.c~git-acpi-s390-struct-bin_attribute-changes arch/s390/kernel/ipl.c
--- a/arch/s390/kernel/ipl.c~git-acpi-s390-struct-bin_attribute-changes
+++ a/arch/s390/kernel/ipl.c
@@ -297,8 +297,9 @@ static ssize_t sys_ipl_device_show(struc
 static struct subsys_attribute sys_ipl_device_attr =
 	__ATTR(device, S_IRUGO, sys_ipl_device_show, NULL);
 
-static ssize_t ipl_parameter_read(struct kobject *kobj, char *buf, loff_t off,
-				  size_t count)
+static ssize_t ipl_parameter_read(struct kobject *kobj,
+				  struct bin_attribute *attr,
+				  char *buf, loff_t off, size_t count)
 {
 	unsigned int size = IPL_PARMBLOCK_SIZE;
 
@@ -320,8 +321,9 @@ static struct bin_attribute ipl_paramete
 	.read = &ipl_parameter_read,
 };
 
-static ssize_t ipl_scp_data_read(struct kobject *kobj, char *buf, loff_t off,
-	size_t count)
+static ssize_t ipl_scp_data_read(struct kobject *kobj,
+				 struct bin_attribute *attr,
+				 char *buf, loff_t off, size_t count)
 {
 	unsigned int size = IPL_PARMBLOCK_START->ipl_info.fcp.scp_data_len;
 	void *scp_data = &IPL_PARMBLOCK_START->ipl_info.fcp.scp_data;
_
