From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [patch 1/6] asus_acpi: W3000 support
Date: Fri, 30 Jun 2006 14:10:32 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6E16B8A@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:30212 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S964816AbWF3SNG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 30 Jun 2006 14:13:06 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@osdl.org, sziwan@users.sourceforge.net
Cc: linux-acpi@vger.kernel.org, marekw1977@yahoo.com.au, acpi4asus-user@lists.sourceforge.net

I've applied this to acpi-test, but really the asus_acpi.c
maintainer or at least the list of asus_acpi users should ack it.

thanks,
-Len

>-----Original Message-----
>From: akpm@osdl.org [mailto:akpm@osdl.org] 
>Sent: Friday, June 30, 2006 5:15 AM
>To: Brown, Len
>Cc: linux-acpi@vger.kernel.org; akpm@osdl.org; marekw1977@yahoo.com.au
>Subject: [patch 1/6] asus_acpi: W3000 support
>
>From: Marek W <marekw1977@yahoo.com.au>
>
>Add support for W3000 (W3V) and indirectly fixes an issue with 
>kmilo under
>KDE (it was triggering excessive LCD read error messages by querying
>asus_acpi module) allowing people (I am probably the only one 
>who tested
>this) with W3000 to run kmilo.
>
>
>Signed-off-by: Andrew Morton <akpm@osdl.org>
>---
>
> drivers/acpi/asus_acpi.c |   19 +++++++++++++++++--
> 1 file changed, 17 insertions(+), 2 deletions(-)
>
>diff -puN drivers/acpi/asus_acpi.c~asus_acpi-w3000-support 
>drivers/acpi/asus_acpi.c
>--- a/drivers/acpi/asus_acpi.c~asus_acpi-w3000-support
>+++ a/drivers/acpi/asus_acpi.c
>@@ -131,6 +131,7 @@ struct asus_hotk {
> 		P30,		//Samsung P30
> 		S1x,		//S1300A, but also L1400B and 
>M2400A (L84F)
> 		S2x,		//S200 (J1 reported), Victor MP-XP7210
>+		W3V,            //W3030V
> 		xxN,		//M2400N, M3700N, M5200N, 
>S1300N, S5200N, W1OOON
> 		//(Centrino)
> 		END_MODEL
>@@ -345,6 +346,17 @@ static struct model_data model_conf[END_
> 	 .brightness_down = S2x_PREFIX "_Q0A"},
> 
> 	{
>+	 .name = "W3V",
>+	 .mt_mled = "MLED",
>+	 .mt_wled = "WLED",
>+	 .mt_lcd_switch = xxN_PREFIX "_Q10",
>+	 .lcd_status = "\\BKLT",
>+	 .brightness_set = "SPLV",
>+	 .brightness_get = "GPLV",
>+	 .display_set = "SDSP",
>+	 .display_get = "\\INFB"},
>+
>+       {
> 	 .name = "xxN",
> 	 .mt_mled = "MLED",
> /* WLED present, but not controlled by ACPI */
>@@ -1066,6 +1078,8 @@ static int asus_hotk_get_info(void)
> 		hotk->model = S2x;
> 	else if (strncmp(model->string.pointer, "L5", 2) == 0)
> 		hotk->model = L5x;
>+	else if (strncmp(model->string.pointer, "W3V", 3) == 0)
>+		hotk->model = W3V;
> 
> 	if (hotk->model == END_MODEL) {
> 		printk("unsupported, trying default values, supply the "
>@@ -1087,9 +1101,10 @@ static int asus_hotk_get_info(void)
> 		hotk->methods->mt_mled = NULL;
> 	/* S5N and M5N have no MLED */
> 	else if (strncmp(model->string.pointer, "M2N", 3) == 0 ||
>-		 strncmp(model->string.pointer, "W1N", 3) == 0)
>+		 strncmp(model->string.pointer, "W1N", 3) == 0 ||
>+		 strncmp(model->string.pointer, "W3V", 3) == 0)
> 		hotk->methods->mt_wled = "WLED";
>-	/* M2N and W1N have a usable WLED */
>+	/* M2N, W1N and W3V have a usable WLED */
> 	else if (asus_info) {
> 		if (strncmp(asus_info->oem_table_id, "L1", 2) == 0)
> 			hotk->methods->mled_status = NULL;
>_
>
