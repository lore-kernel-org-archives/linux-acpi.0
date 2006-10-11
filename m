From: "Chen, Justin" <justin.chen@hp.com>
Subject: [PATCH] ACPI: fix find_pci_rootbridge() return value to save time finding rootbridge
Date: Tue, 10 Oct 2006 19:07:12 -0500
Message-ID: <BD66F1A3AD5256419EBBAAA49257848284F2A3@G3W0068.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ccerelbas04.cce.hp.com ([161.114.21.107]:4797 "EHLO
	ccerelbas04.cce.hp.com") by vger.kernel.org with ESMTP
	id S1030718AbWJKAHO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Oct 2006 20:07:14 -0400
Received: from cceexg11.americas.cpqcorp.net (cceexg11.americas.cpqcorp.net [16.81.1.59])
	by ccerelbas04.cce.hp.com (Postfix) with ESMTP id 35E8434543
	for <linux-acpi@vger.kernel.org>; Tue, 10 Oct 2006 19:07:14 -0500 (CDT)
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org


The acpi_get_pci_rootbridge_handle() walk through the acpi ns to find
the handle matches the seg, bus and the PCI_ROOT_HID_STRING.  It should
returns the handle as soon as if find the match.  But the current codes
always parse through the whole namespace because the user_function
find_pci_rootbridge() returns status=AE_OK when it finds the match.

This patch, on top of 2.6.19-rc1, is to make the find_pci_rootbridge()
returning AE_CTRL_TERMINATE when it finds the match.

Signed-off-by: Justin Chen <justin.chen@hp.com>

------------------------------------------------------------------------
-------------------------------------------
--- 2.6.19-rc1/drivers/acpi/glue.c.orig	2006-10-10 16:02:40.000000000
-0700
+++ 2.6.19-rc1/drivers/acpi/glue.c	2006-10-10 16:05:11.000000000
-0700
@@ -189,8 +189,12 @@ find_pci_rootbridge(acpi_handle handle, 
 	bus = tmp;
 
 	if (seg == find->seg && bus == find->bus)
+	{
 		find->handle = handle;
-	status = AE_OK;
+		status = AE_CTRL_TERMINATE;
+	}
+	else
+		status = AE_OK;
       exit:
 	kfree(buffer.pointer);
 	return status;
