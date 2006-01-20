From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [PATCH] drivers/acpi/hotkey.c: check kmalloc return value
Date: Fri, 20 Jan 2006 17:11:04 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B3005CA222B@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr14.intel.com ([192.55.52.68]:56017 "EHLO
	fmsfmr002.fm.intel.com") by vger.kernel.org with ESMTP
	id S932234AbWATWL4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Jan 2006 17:11:56 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Dobriyan <adobriyan@gmail.com>, Andrew Morton <akpm@osdl.org>
Cc: Irwan Djajadi <irwan.djajadi@iname.com>, linux-acpi@vger.kernel.org

applied.

thanks,
-len 

>-----Original Message-----
>From: linux-acpi-owner@vger.kernel.org 
>[mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Alexey Dobriyan
>Sent: Friday, January 20, 2006 3:28 PM
>To: Andrew Morton
>Cc: Irwan Djajadi; linux-acpi@vger.kernel.org
>Subject: [PATCH] drivers/acpi/hotkey.c: check kmalloc return value
>
>From: Irwan Djajadi <irwan.djajadi@iname.com>
>
>Signed-off-by: Irwan Djajadi <irwan.djajadi@iname.com>
>Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
>---
>
> drivers/acpi/hotkey.c |    2 ++
> 1 file changed, 2 insertions(+)
>
>--- a/drivers/acpi/hotkey.c
>+++ b/drivers/acpi/hotkey.c
>@@ -723,6 +723,8 @@ get_parms(char *config_record,
> 		goto do_fail;
> 	count = tmp1 - tmp;
> 	*action_handle = (char *)kmalloc(count + 1, GFP_KERNEL);
>+	if (!*action_handle)
>+		goto do_fail;
> 	strncpy(*action_handle, tmp, count);
> 	*(*action_handle + count) = 0;
> 
>
>-
>To unsubscribe from this list: send the line "unsubscribe 
>linux-acpi" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
