From: "Jan Beulich" <JBeulich@novell.com>
Subject: [PATCH] acpi: fix parameter type of acpi_get_node()
Date: Wed, 27 Apr 2011 15:49:07 +0100
Message-ID: <4DB84903020000780003E662@vpn.id2.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

The extra (bogus) level of indirection worked only because acpi_handle
itself is a pointer to void.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

---
 drivers/acpi/numa.c  |    2 +-
 include/linux/acpi.h |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

--- 2.6.39-rc5/drivers/acpi/numa.c
+++ 2.6.39-rc5-acpi-get-node/drivers/acpi/numa.c
@@ -320,7 +320,7 @@ int acpi_get_pxm(acpi_handle h)
 	return -1;
 }
 
-int acpi_get_node(acpi_handle *handle)
+int acpi_get_node(acpi_handle handle)
 {
 	int pxm, node = -1;
 
--- 2.6.39-rc5/include/linux/acpi.h
+++ 2.6.39-rc5-acpi-get-node/include/linux/acpi.h
@@ -223,13 +223,13 @@ extern void acpi_osi_setup(char *str);
 
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



