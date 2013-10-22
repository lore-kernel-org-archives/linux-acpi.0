From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] ACPICA: Invoke table unload handler after removing namespace objects
Date: Wed, 23 Oct 2013 00:26:42 +0200
Message-ID: <1423146.2PZnpW8Nea@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:52157 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753967Ab3JVWOo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 22 Oct 2013 18:14:44 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

At the point where acpi_gbl_table_handler(ACPI_TABLE_EVENT_UNLOAD, ...)
is called we don't really know what objects are going to be deleted as
a result of the table unload, so it is difficult to do the cleanup from
the handler in some cases (specifically, when some data items have been
attached to the objects being deleted).

For this reason, call acpi_gbl_table_handler(ACPI_TABLE_EVENT_UNLOAD, ...)
after acpi_tb_delete_namespace_by_owner() has run so that it can do the
cleanup properly.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/tbxfload.c |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

Index: linux-pm/drivers/acpi/acpica/tbxfload.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/tbxfload.c
+++ linux-pm/drivers/acpi/acpica/tbxfload.c
@@ -352,15 +352,6 @@ acpi_status acpi_unload_parent_table(acp
 			break;
 		}
 
-		/* Invoke table handler if present */
-
-		if (acpi_gbl_table_handler) {
-			(void)acpi_gbl_table_handler(ACPI_TABLE_EVENT_UNLOAD,
-						     acpi_gbl_root_table_list.
-						     tables[i].pointer,
-						     acpi_gbl_table_handler_context);
-		}
-
 		/*
 		 * Delete all namespace objects owned by this table. Note that
 		 * these objects can appear anywhere in the namespace by virtue
@@ -372,6 +363,15 @@ acpi_status acpi_unload_parent_table(acp
 			break;
 		}
 
+		/* Invoke table handler if present */
+
+		if (acpi_gbl_table_handler) {
+			(void)acpi_gbl_table_handler(ACPI_TABLE_EVENT_UNLOAD,
+						     acpi_gbl_root_table_list.
+						     tables[i].pointer,
+						     acpi_gbl_table_handler_context);
+		}
+
 		status = acpi_tb_release_owner_id(i);
 		acpi_tb_set_table_loaded_flag(i, FALSE);
 		break;

