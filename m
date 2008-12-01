From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 2/3] acpiphp: identify more removable slots
Date: Mon, 1 Dec 2008 14:39:06 -0800
Message-ID: <20081201143906.d95c8e0d.akpm@linux-foundation.org>
References: <200812012212.mB1MCo2w008300@imap1.linux-foundation.org>
	<20081201221455.GA10372@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:57360 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752745AbYLAWjW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Dec 2008 17:39:22 -0500
In-Reply-To: <20081201221455.GA10372@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, gregkh@suse.de, kristen.c.accardi@intel.com, len.brown@intel.com, Jesse Barnes <jbarnes@virtuousgeek.org>

On Mon, 1 Dec 2008 22:14:55 +0000
Matthew Garrett <mjg59@srcf.ucam.org> wrote:

> This has been picked up by Jesse for the PCI tree.

It isn't in today's linux-next?



From: Matthew Garrett <mjg59@srcf.ucam.org>

According to section 6.3.6 of the ACPI spec, the presence of an _RMV
method that evaluates to 1 is sufficient to indicate that a slot is
removable without needing an eject method.  This patch refactors the
ejectable slot detection code a little in order to flag these slots as
ejectable and register them.  Acpihp then binds to the expresscard slot on
my HP test machine.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Cc: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Cc: Len Brown <len.brown@intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/pci/hotplug/acpiphp_glue.c |   32 ++++++++++++++-------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff -puN drivers/pci/hotplug/acpiphp_glue.c~acpiphp-identify-more-removable-slots drivers/pci/hotplug/acpiphp_glue.c
--- a/drivers/pci/hotplug/acpiphp_glue.c~acpiphp-identify-more-removable-slots
+++ a/drivers/pci/hotplug/acpiphp_glue.c
@@ -74,7 +74,7 @@ static void handle_hotplug_event_func(ac
  * Ejectable slot should satisfy at least these conditions:
  *
  *  1. has _ADR method
- *  2. has _EJ0 method
+ *  2. has _EJ0 method or _RMV method
  *
  * optionally
  *
@@ -87,18 +87,25 @@ static int is_ejectable(acpi_handle hand
 {
 	acpi_status status;
 	acpi_handle tmp;
+	unsigned long long removable;
 
 	status = acpi_get_handle(handle, "_ADR", &tmp);
-	if (ACPI_FAILURE(status)) {
+	if (ACPI_FAILURE(status))
 		return 0;
-	}
 
 	status = acpi_get_handle(handle, "_EJ0", &tmp);
-	if (ACPI_FAILURE(status)) {
-		return 0;
+	if (ACPI_SUCCESS(status))
+		return 1;
+
+	status = acpi_get_handle(handle, "_RMV", &tmp);
+	if (ACPI_SUCCESS(status)) {
+		status = acpi_evaluate_integer(handle, "_RMV", NULL,
+					       &removable);
+		if (ACPI_SUCCESS(status) && removable)
+			return 1;
 	}
 
-	return 1;
+	return 0;
 }
 
 
@@ -185,16 +192,10 @@ register_slot(acpi_handle handle, u32 lv
 	unsigned long long adr, sun;
 	int device, function, retval;
 
-	status = acpi_evaluate_integer(handle, "_ADR", NULL, &adr);
-
-	if (ACPI_FAILURE(status))
-		return AE_OK;
-
-	status = acpi_get_handle(handle, "_EJ0", &tmp);
-
-	if (ACPI_FAILURE(status) && !(is_dock_device(handle)))
+	if (!is_ejectable(handle) && !is_dock_device(handle))
 		return AE_OK;
 
+	acpi_evaluate_integer(handle, "_ADR", NULL, &adr);
 	device = (adr >> 16) & 0xffff;
 	function = adr & 0xffff;
 
@@ -205,7 +206,8 @@ register_slot(acpi_handle handle, u32 lv
 	INIT_LIST_HEAD(&newfunc->sibling);
 	newfunc->handle = handle;
 	newfunc->function = function;
-	if (ACPI_SUCCESS(status))
+
+	if (ACPI_SUCCESS(acpi_get_handle(handle, "_EJ0", &tmp)))
 		newfunc->flags = FUNC_HAS_EJ0;
 
 	if (ACPI_SUCCESS(acpi_get_handle(handle, "_STA", &tmp)))
_

