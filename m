From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [PATCH] ACPI: fix find_pci_rootbridge() return value to save time finding rootbridge
Date: Fri, 27 Oct 2006 02:27:59 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB601D58A9C@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:13423 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1946032AbWJ0G2D convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 27 Oct 2006 02:28:03 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Chen, Justin" <justin.chen@hp.com>
Cc: linux-acpi@vger.kernel.org

applied.

thanks,
-Len 

>-----Original Message-----
>From: Chen, Justin [mailto:justin.chen@hp.com] 
>Sent: Tuesday, October 10, 2006 5:07 PM
>To: Brown, Len
>Cc: linux-acpi@vger.kernel.org
>Subject: [PATCH] ACPI: fix find_pci_rootbridge() return value 
>to save time finding rootbridge
>
>
>The acpi_get_pci_rootbridge_handle() walk through the acpi ns 
>to find the handle matches the seg, bus and the 
>PCI_ROOT_HID_STRING.  It should returns the handle as soon as 
>if find the match.  But the current codes always parse through 
>the whole namespace because the user_function 
>find_pci_rootbridge() returns status=AE_OK when it finds the match.
>
>This patch, on top of 2.6.19-rc1, is to make the 
>find_pci_rootbridge() returning AE_CTRL_TERMINATE when it 
>finds the match.
>
>Signed-off-by: Justin Chen <justin.chen@hp.com>
>
>---------------------------------------------------------------
>----------------------------------------------------
>--- 2.6.19-rc1/drivers/acpi/glue.c.orig	2006-10-10 
>16:02:40.000000000 -0700
>+++ 2.6.19-rc1/drivers/acpi/glue.c	2006-10-10 
>16:05:11.000000000 -0700
>@@ -189,8 +189,12 @@ find_pci_rootbridge(acpi_handle handle, 
> 	bus = tmp;
> 
> 	if (seg == find->seg && bus == find->bus)
>+	{
> 		find->handle = handle;
>-	status = AE_OK;
>+		status = AE_CTRL_TERMINATE;
>+	}
>+	else
>+		status = AE_OK;
>       exit:
> 	kfree(buffer.pointer);
> 	return status;
>
