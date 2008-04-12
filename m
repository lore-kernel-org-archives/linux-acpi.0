From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: ACPICA branch - first try Core revision 20080321
Date: Sun, 13 Apr 2008 00:46:11 +0400
Message-ID: <48011F93.2000102@gmail.com>
References: <1207974356-30687-1-git-send-email-lenb@kernel.org> <200804120041.31583.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:34844 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750910AbYDLUqO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 12 Apr 2008 16:46:14 -0400
Received: by ug-out-1314.google.com with SMTP id z38so159643ugc.16
        for <linux-acpi@vger.kernel.org>; Sat, 12 Apr 2008 13:46:10 -0700 (PDT)
In-Reply-To: <200804120041.31583.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, "Moore, Robert" <robert.moore@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>

Len Brown wrote:
> The acpica branch is based on 2.6.25-rc9.
> Below is a dmesg diff of an HP nx6325 booting that baseline
> vs. booting the acpica branch.
>
> Two things jump out:
>
> 1. ACPI: Expecting a [Reference] package element, found type 14
>
>   
Add this to #67
diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index 44ea60c..1009261 100644
--- a/drivers/acpi/utils.c
+++ b/drivers/acpi/utils.c
@@ -398,7 +398,7 @@ acpi_evaluate_reference(acpi_handle handle,
 
         element = &(package->package.elements[i]);
 
-        if (element->type != ACPI_TYPE_ANY) {
+        if (element->type != ACPI_TYPE_LOCAL_REFERENCE) {
             status = AE_BAD_DATA;
             printk(KERN_ERR PREFIX
                     "Expecting a [Reference] package element, found 
type %X\n",

> 2. memory coorruption:
>
> slab error in verify_redzone_free(): cache `size-1024': memory outside object was overwritten
>
>   
drop #60
> -Len
>
>   
Regards,
Alex.

