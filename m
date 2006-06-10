From: Matthew Wilcox <matthew@wil.cx>
Subject: [PATCH] pnpacpi mishandles port io ADDRESS resources
Date: Sat, 10 Jun 2006 10:41:50 -0600
Message-ID: <20060610164150.GR1651@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:40349 "EHLO
	palinux.external.hp.com") by vger.kernel.org with ESMTP
	id S1750763AbWFJQlv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 10 Jun 2006 12:41:51 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, ambx1@neo.rr.com
Cc: linux-kernel@vger.kernel.org


ACPI ADDRESSn resources can describe both memory and port io, but the
current code assumes they're descibing memory, which isn't true for HP's
ia64 systems.

Signed-off-by: Matthew Wilcox <matthew@wil.cx>

--- a/drivers/pnp/pnpacpi/rsparser.c	4 Feb 2006 04:51:56 -0000	1.7
+++ b/drivers/pnp/pnpacpi/rsparser.c	10 Jun 2006 16:27:48 -0000
@@ -221,19 +221,34 @@ static acpi_status pnpacpi_allocated_res
 				res->data.fixed_memory32.address_length);
 		break;
 	case ACPI_RESOURCE_TYPE_ADDRESS16:
-		pnpacpi_parse_allocated_memresource(res_table,
-				res->data.address16.minimum,
-				res->data.address16.address_length);
+		if (res->data.address.resource_type == 0)
+			pnpacpi_parse_allocated_memresource(res_table,
+					res->data.address16.minimum,
+					res->data.address16.address_length);
+		else if (res->data.address.resource_type == 1)
+			pnpacpi_parse_allocated_ioresource(res_table,
+					res->data.address16.minimum,
+					res->data.address16.address_length);
 		break;
 	case ACPI_RESOURCE_TYPE_ADDRESS32:
-		pnpacpi_parse_allocated_memresource(res_table,
-				res->data.address32.minimum,
-				res->data.address32.address_length);
+		if (res->data.address.resource_type == 0)
+			pnpacpi_parse_allocated_memresource(res_table,
+					res->data.address32.minimum,
+					res->data.address32.address_length);
+		else if (res->data.address.resource_type == 1)
+			pnpacpi_parse_allocated_ioresource(res_table,
+					res->data.address32.minimum,
+					res->data.address32.address_length);
 		break;
 	case ACPI_RESOURCE_TYPE_ADDRESS64:
-		pnpacpi_parse_allocated_memresource(res_table,
-		res->data.address64.minimum,
-		res->data.address64.address_length);
+		if (res->data.address.resource_type == 0)
+			pnpacpi_parse_allocated_memresource(res_table,
+					res->data.address64.minimum,
+					res->data.address64.address_length);
+		else if (res->data.address.resource_type == 1)
+			pnpacpi_parse_allocated_ioresource(res_table,
+					res->data.address64.minimum,
+					res->data.address64.address_length);
 		break;
 
 	case ACPI_RESOURCE_TYPE_EXTENDED_ADDRESS64:
