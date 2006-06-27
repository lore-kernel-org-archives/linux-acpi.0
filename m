From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [patch 16/18] disable ACPI on some Phoenix BIOS
Date: Tue, 27 Jun 2006 02:33:53 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6D8C7C8@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:48052 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S932125AbWF0Gd4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 27 Jun 2006 02:33:56 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@osdl.org
Cc: linux-acpi@vger.kernel.org, randy.dunlap@oracle.com, mjg59@srcf.ucam.org

What machine is this for?  The patch does not say.

What steps were taken to show that this is not
an ACPI bug in Linux that would be masked if we
applied this patch?

thanks,
-Len 

>-----Original Message-----
>From: akpm@osdl.org [mailto:akpm@osdl.org] 
>Sent: Saturday, June 24, 2006 7:37 PM
>To: Brown, Len
>Cc: linux-acpi@vger.kernel.org; akpm@osdl.org; 
>randy.dunlap@oracle.com; mjg59@srcf.ucam.org
>Subject: [patch 16/18] disable ACPI on some Phoenix BIOS
>
>
>From: Randy Dunlap <randy.dunlap@oracle.com>
>
>Disable ACPI on some Phoenix BIOS, or the system will freeze.
>
>http://www.kernel.org/git/?p=linux/kernel/git/bcollins/ubuntu-d
>apper.git;a=commitdiff;h=8ae54aeedb4b33a74ba5d811abef07d83f1838f4
>
>Cc: Matthew Garrett <mjg59@srcf.ucam.org>
>Signed-off-by: Andrew Morton <akpm@osdl.org>
>---
>
> arch/i386/kernel/acpi/boot.c |   10 +++++++++-
> 1 file changed, 9 insertions(+), 1 deletion(-)
>
>diff -puN 
>arch/i386/kernel/acpi/boot.c~disable-acpi-on-some-phoenix-bios 
>arch/i386/kernel/acpi/boot.c
>--- a/arch/i386/kernel/acpi/boot.c~disable-acpi-on-some-phoenix-bios
>+++ a/arch/i386/kernel/acpi/boot.c
>@@ -991,7 +991,15 @@ static struct dmi_system_id __initdata a
> 		     DMI_MATCH(DMI_BOARD_NAME, "2629H1G"),
> 		     },
> 	 },
>-
>+	 {
>+	  .callback = dmi_disable_acpi,
>+	  .ident = "Phoenix Technologies",
>+	  .matches = {
>+	  	      DMI_MATCH(DMI_BIOS_VENDOR,"Phoenix 
>Technologies, LTD"),
>+		      DMI_MATCH(DMI_BIOS_VERSION, "6.00 PG"),
>+		      DMI_MATCH(DMI_BIOS_DATE, "11/05/2003"),
>+	  	     },
>+	 },
> 	/*
> 	 * Boxes that need acpi=ht
> 	 */
>_
>
