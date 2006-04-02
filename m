From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [patch 21/26] acpi EC: acpi-ecdt-uid-hack
Date: Sun, 2 Apr 2006 00:22:31 -0500
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6123DEF@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:10073 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751359AbWDBFWf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 2 Apr 2006 00:22:35 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@osdl.org
Cc: linux-acpi@vger.kernel.org, jirislaby@gmail.com, "Yu, Luming" <luming.yu@intel.com>

applied to acpi-test

thanks,
-Len 

>-----Original Message-----
>From: akpm@osdl.org [mailto:akpm@osdl.org] 
>Sent: Tuesday, March 28, 2006 5:04 PM
>To: Brown, Len
>Cc: linux-acpi@vger.kernel.org; akpm@osdl.org; 
>jirislaby@gmail.com; Yu, Luming
>Subject: [patch 21/26] acpi EC: acpi-ecdt-uid-hack
>
>
>From: Jiri Slaby <jirislaby@gmail.com>
>
>On some boxes ecdt uid may be equal to 0, so do not test for 
>uids equality,
>so that fake handler will be unconditionally removed to allow 
>loading the
>real one.
>
>See http://bugzilla.kernel.org/show_bug.cgi?id=6111
>
>Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
>Cc: Luming Yu <luming.yu@intel.com>
>Cc: "Brown, Len" <len.brown@intel.com>
>Signed-off-by: Andrew Morton <akpm@osdl.org>
>---
>
> drivers/acpi/ec.c |   16 ++++++----------
> 1 files changed, 6 insertions(+), 10 deletions(-)
>
>diff -puN drivers/acpi/ec.c~acpi-ec-acpi-ecdt-uid-hack 
>drivers/acpi/ec.c
>--- devel/drivers/acpi/ec.c~acpi-ec-acpi-ecdt-uid-hack	
>2006-03-28 14:03:07.000000000 -0800
>+++ devel-akpm/drivers/acpi/ec.c	2006-03-28 
>14:03:07.000000000 -0800
>@@ -989,7 +989,6 @@ static int acpi_ec_poll_add(struct acpi_
> 	int result = 0;
> 	acpi_status status = AE_OK;
> 	union acpi_ec *ec = NULL;
>-	unsigned long uid;
> 
> 	ACPI_FUNCTION_TRACE("acpi_ec_add");
> 
>@@ -1012,10 +1011,9 @@ static int acpi_ec_poll_add(struct acpi_
> 	acpi_evaluate_integer(ec->common.handle, "_GLK", NULL,
> 			      &ec->common.global_lock);
> 
>-	/* If our UID matches the UID for the ECDT-enumerated EC,
>-	   we now have the *real* EC info, so kill the makeshift one. */
>-	acpi_evaluate_integer(ec->common.handle, "_UID", NULL, &uid);
>-	if (ec_ecdt && ec_ecdt->common.uid == uid) {
>+	/* XXX we don't test uids, because on some boxes ecdt 
>uid = 0, see:
>+	   http://bugzilla.kernel.org/show_bug.cgi?id=6111 */
>+	if (ec_ecdt) {
> 		acpi_remove_address_space_handler(ACPI_ROOT_OBJECT,
> 						  ACPI_ADR_SPACE_EC,
> 						  
>&acpi_ec_space_handler);
>@@ -1059,7 +1057,6 @@ static int acpi_ec_intr_add(struct acpi_
> 	int result = 0;
> 	acpi_status status = AE_OK;
> 	union acpi_ec *ec = NULL;
>-	unsigned long uid;
> 
> 	ACPI_FUNCTION_TRACE("acpi_ec_add");
> 
>@@ -1085,10 +1082,9 @@ static int acpi_ec_intr_add(struct acpi_
> 	acpi_evaluate_integer(ec->common.handle, "_GLK", NULL,
> 			      &ec->common.global_lock);
> 
>-	/* If our UID matches the UID for the ECDT-enumerated EC,
>-	   we now have the *real* EC info, so kill the makeshift one. */
>-	acpi_evaluate_integer(ec->common.handle, "_UID", NULL, &uid);
>-	if (ec_ecdt && ec_ecdt->common.uid == uid) {
>+	/* XXX we don't test uids, because on some boxes ecdt 
>uid = 0, see:
>+	   http://bugzilla.kernel.org/show_bug.cgi?id=6111 */
>+	if (ec_ecdt) {
> 		acpi_remove_address_space_handler(ACPI_ROOT_OBJECT,
> 						  ACPI_ADR_SPACE_EC,
> 						  
>&acpi_ec_space_handler);
>_
>
