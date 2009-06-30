From: "Jan Beulich" <JBeulich@novell.com>
Subject: [PATCH] acpi: fix parameter declaration of acpi_get_node()
Date: Tue, 30 Jun 2009 12:24:35 +0100
Message-ID: <4A4A1213020000780000832D@vpn.id2.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vpn.id2.novell.com ([195.33.99.129]:45832 "EHLO
	vpn.id2.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750990AbZF3Loh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 30 Jun 2009 07:44:37 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org

The function expects an acpi_handle, not a pointer to one.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

---
 drivers/acpi/numa.c  |    2 +-
 include/linux/acpi.h |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

--- linux-2.6.31-rc1/drivers/acpi/numa.c	2009-06-10 05:05:27.000000000 +0200
+++ 2.6.31-rc1-acpi-get-node/drivers/acpi/numa.c	2009-05-04 11:39:30.000000000 +0200
@@ -316,7 +316,7 @@ int acpi_get_pxm(acpi_handle h)
 	return -1;
 }
 
-int acpi_get_node(acpi_handle *handle)
+int acpi_get_node(acpi_handle handle)
 {
 	int pxm, node = -1;
 
--- linux-2.6.31-rc1/include/linux/acpi.h	2009-06-26 17:49:59.000000000 +0200
+++ 2.6.31-rc1-acpi-get-node/include/linux/acpi.h	2009-05-04 11:39:30.000000000 +0200
@@ -226,13 +226,13 @@ extern int acpi_osi_setup(char *str);
 
 #ifdef CONFIG_ACPI_NUMA
 int acpi_get_pxm(acpi_handle handle);
-int acpi_get_node(acpi_handle *handle);
+int acpi_get_node(acpi_handle handle);
 #else
 static inline int acpi_get_pxm(acpi_handle handle)
 {
 	return 0;
 }
-static inline int acpi_get_node(acpi_handle *handle)
+static inline int acpi_get_node(acpi_handle handle)
 {
 	return 0;
 }



