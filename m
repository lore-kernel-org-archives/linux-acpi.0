From: Myron Stowe <myron.stowe@hp.com>
Subject: [PATCH 3/3] ACPI: 80 column adherence and spelling fix (no
	functional change)
Date: Wed, 22 Oct 2008 13:14:48 -0600
Message-ID: <1224702889.6784.20.camel@localhost>
References: <1224702636.6784.13.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0006.atlanta.hp.com ([15.192.0.43]:15497 "EHLO
	g5t0006.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755126AbYJVTOu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 22 Oct 2008 15:14:50 -0400
In-Reply-To: <1224702636.6784.13.camel@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: aystarik@gmail.com, linux-acpi <linux-acpi@vger.kernel.org>


Signed-off-by: Myron Stowe <myron.stowe@hp.com>

---
 drivers/acpi/processor_core.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

Index: linux-2.6/drivers/acpi/processor_core.c
===================================================================
--- linux-2.6.orig/drivers/acpi/processor_core.c	2008-10-22 12:12:11.000000000 -0600
+++ linux-2.6/drivers/acpi/processor_core.c	2008-10-22 12:42:22.000000000 -0600
@@ -582,9 +582,9 @@ static int acpi_processor_get_info(struc
 		pr->acpi_id = value;
 	} else {
 		/*
-		* Evalute the processor object.  Note that it is common on SMP to
-		* have the first (boot) processor with a valid PBLK address while
-		* all others have a NULL address.
+		* Evaluate the Processor object.  Note that it is common on SMP
+		* to have the first (boot) processor with a valid PBLK address
+		* while * all others have a NULL address.
 		*/
 		status = acpi_evaluate_object(pr->handle, NULL, NULL, &buffer);
 		if (ACPI_FAILURE(status)) {
@@ -594,7 +594,8 @@ static int acpi_processor_get_info(struc
 
 		/*
 		* TBD: Synch processor ID (via LAPIC/LSAPIC structures) on SMP.
-		*      >>> 'acpi_get_processor_id(acpi_id, &id)' in arch/xxx/acpi.c
+		*      >>> 'acpi_get_processor_id(acpi_id, &id)' in
+		*      arch/xxx/acpi.c
 		*/
 		pr->acpi_id = object.processor.proc_id;
 	}


