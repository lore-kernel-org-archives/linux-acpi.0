From: Alex Chiang <achiang@hp.com>
Subject: [PATCH] ACPICA: Eliminate double call to acpi_ns_get_parent_node in
	acpi_get_parent
Date: Mon, 18 May 2009 21:23:24 -0600
Message-ID: <20090519032244.3729.46729.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753083AbZESDXe@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Robert Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

Cache the value of the parent node so we don't have to look it up twice.

Cc: Robert Moore <robert.moore@intel.com>
Signed-off-by: Alex Chiang <achiang@hp.com>
---

 drivers/acpi/acpica/nsxfobj.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpica/nsxfobj.c b/drivers/acpi/acpica/nsxfobj.c
index 1c7efc1..1cd8f15 100644
--- a/drivers/acpi/acpica/nsxfobj.c
+++ b/drivers/acpi/acpica/nsxfobj.c
@@ -161,7 +161,7 @@ ACPI_EXPORT_SYMBOL(acpi_get_type)
  ******************************************************************************/
 acpi_status acpi_get_parent(acpi_handle handle, acpi_handle * ret_handle)
 {
-	struct acpi_namespace_node *node;
+	struct acpi_namespace_node *node, *parent_node;
 	acpi_status status;
 
 	if (!ret_handle) {
@@ -189,12 +189,12 @@ acpi_status acpi_get_parent(acpi_handle handle, acpi_handle * ret_handle)
 
 	/* Get the parent entry */
 
-	*ret_handle =
-	    acpi_ns_convert_entry_to_handle(acpi_ns_get_parent_node(node));
+	parent_node = acpi_ns_get_parent_node(node);
+	*ret_handle = acpi_ns_convert_entry_to_handle(parent_node);
 
 	/* Return exception if parent is null */
 
-	if (!acpi_ns_get_parent_node(node)) {
+	if (!parent_node) {
 		status = AE_NULL_ENTRY;
 	}
 
