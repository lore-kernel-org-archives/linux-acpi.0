From: Andrew Morton <akpm@osdl.org>
Subject: Re: [Acpi4asus-user] [patch 1/6] asus_acpi: W3000 support
Date: Sat, 1 Jul 2006 16:35:02 -0700
Message-ID: <20060701163502.6a87e01a.akpm@osdl.org>
References: <CFF307C98FEABE47A452B27C06B85BB6E16B8A@hdsmsx411.amr.corp.intel.com>
	<20060630193130.GA11609@hell.org.pl>
	<1151765434.30054.9.camel@nouse.suse.de>
	<1151793983.27214.4.camel@frolic>
	<1151795155.30054.25.camel@nouse.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:58011 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932109AbWGAXfS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 1 Jul 2006 19:35:18 -0400
In-Reply-To: <1151795155.30054.25.camel@nouse.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Timo Hoenig <thoenig@suse.de>
Cc: acpi4asus-list@cerqueira.org, len.brown@intel.com, acpi4asus-user@lists.sourceforge.net, linux-acpi@vger.kernel.org, sziwan@hell.org.pl, marekw1977@yahoo.com.au

On Sun, 02 Jul 2006 01:05:55 +0200
Timo Hoenig <thoenig@suse.de> wrote:

> Hi Ricardo,
> 
> On Sat, 2006-07-01 at 23:46 +0100, R Cerqueira wrote:
> 
> > Since we're talking about applying patches, it would be nice if the W5F
> > patch I sent to the list back on April 26th could go in as well.
> 
> Patches sent to the acpi4asus list should be reviewed there and
> afterwards sent to linux-acpi.  As there was no reply to your mail on
> acpi4asus it got lost.
> 
> > Anything wrong with it?
> 
> Just had a short look at it and it looks fine to me.  You may probably
> want to re-diff against Len's tree as I haven't checked if it still
> applies cleanly.
> 

I'm carrying this version, whcih applies and builds OK.

From: Marek W <marekw1977@yahoo.com.au>

Add support for W3000 (W3V) and indirectly fixes an issue with kmilo under KDE
(it was triggering excessive LCD read error messages by querying asus_acpi
module) allowing people (I am probably the only one who tested this) with
W3000 to run kmilo.

Cc: Karol Kozimor <sziwan@hell.org.pl>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/acpi/asus_acpi.c |   17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff -puN drivers/acpi/asus_acpi.c~asus_acpi-w3000-support drivers/acpi/asus_acpi.c
--- a/drivers/acpi/asus_acpi.c~asus_acpi-w3000-support
+++ a/drivers/acpi/asus_acpi.c
@@ -138,6 +138,7 @@ struct asus_hotk {
 		S2x,		//S200 (J1 reported), Victor MP-XP7210
 		W1N,		//W1000N
 		W5A,		//W5A
+		W3V,            //W3030V
 		xxN,		//M2400N, M3700N, M5200N, M6800N, S1300N, S5200N
 		//(Centrino)
 		END_MODEL
@@ -376,6 +377,17 @@ static struct model_data model_conf[END_
 	 .display_get = "\\ADVG"},
 
 	{
+	 .name = "W3V",
+	 .mt_mled = "MLED",
+	 .mt_wled = "WLED",
+	 .mt_lcd_switch = xxN_PREFIX "_Q10",
+	 .lcd_status = "\\BKLT",
+	 .brightness_set = "SPLV",
+	 .brightness_get = "GPLV",
+	 .display_set = "SDSP",
+	 .display_get = "\\INFB"},
+
+       {
 	 .name = "xxN",
 	 .mt_mled = "MLED",
 /* WLED present, but not controlled by ACPI */
@@ -1097,6 +1109,8 @@ static int asus_model_match(char *model)
 		return A4G;
 	else if (strncmp(model, "W1N", 3) == 0)
 		return W1N;
+	else if (strncmp(model, "W3V", 3) == 0)
+		return W3V;
 	else if (strncmp(model, "W5A", 3) == 0)
 		return W5A;
 	else
@@ -1200,9 +1214,10 @@ static int asus_hotk_get_info(void)
 		hotk->methods->mt_wled = NULL;
 	/* L5D's WLED is not controlled by ACPI */
 	else if (strncmp(string, "M2N", 3) == 0 ||
+		 strncmp(string, "W3V", 3) == 0 ||
 		 strncmp(string, "S1N", 3) == 0)
 		hotk->methods->mt_wled = "WLED";
-	/* M2N and S1N have a usable WLED */
+	/* M2N, S1N and W3V have a usable WLED */
 	else if (asus_info) {
 		if (strncmp(asus_info->oem_table_id, "L1", 2) == 0)
 			hotk->methods->mled_status = NULL;
_

