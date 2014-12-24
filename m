From: Eugene Korenevsky <ekorenevsky@gmail.com>
Subject: [PATCH] acpi: remove pointless checks for NULL pointer
Date: Wed, 24 Dec 2014 23:16:48 +0300
Message-ID: <20141224201648.GA15251@gnote>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-la0-f50.google.com ([209.85.215.50]:62827 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751483AbaLXUO7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 24 Dec 2014 15:14:59 -0500
Received: by mail-la0-f50.google.com with SMTP id pn19so7282415lab.23
        for <linux-acpi@vger.kernel.org>; Wed, 24 Dec 2014 12:14:57 -0800 (PST)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>

A trivial fix. No need to check `p` for NULL.
`resource` pointer is valid therefore `p` is also valid.

Signed-off-by: Eugene Korenevsky <ekorenevsky@gmail.com>
---
 drivers/acpi/pci_link.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index cfd7581..6379186 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -111,7 +111,7 @@ static acpi_status acpi_pci_link_check_possible(struct acpi_resource *resource,
 	case ACPI_RESOURCE_TYPE_IRQ:
 		{
 			struct acpi_resource_irq *p = &resource->data.irq;
-			if (!p || !p->interrupt_count) {
+			if (!p->interrupt_count) {
 				ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 						  "Blank _PRS IRQ resource\n"));
 				return AE_OK;
@@ -137,7 +137,7 @@ static acpi_status acpi_pci_link_check_possible(struct acpi_resource *resource,
 		{
 			struct acpi_resource_extended_irq *p =
 			    &resource->data.extended_irq;
-			if (!p || !p->interrupt_count) {
+			if (!p->interrupt_count) {
 				printk(KERN_WARNING PREFIX
 					      "Blank _PRS EXT IRQ resource\n");
 				return AE_OK;
@@ -198,7 +198,7 @@ static acpi_status acpi_pci_link_check_current(struct acpi_resource *resource,
 	case ACPI_RESOURCE_TYPE_IRQ:
 		{
 			struct acpi_resource_irq *p = &resource->data.irq;
-			if (!p || !p->interrupt_count) {
+			if (!p->interrupt_count) {
 				/*
 				 * IRQ descriptors may have no IRQ# bits set,
 				 * particularly those those w/ _STA disabled
@@ -214,7 +214,7 @@ static acpi_status acpi_pci_link_check_current(struct acpi_resource *resource,
 		{
 			struct acpi_resource_extended_irq *p =
 			    &resource->data.extended_irq;
-			if (!p || !p->interrupt_count) {
+			if (!p->interrupt_count) {
 				/*
 				 * extended IRQ descriptors must
 				 * return at least 1 IRQ
-- 
2.0.4

