From: Marco Aurelio da Costa <costa@gamic.com>
Subject: [RFC][PATCH v3]: ACPI: Ignore invalid _PSS entries, but use valid ones
Date: Fri, 4 May 2012 18:53:44 +0200
Message-ID: <CAEe-dwjEM8bHV838VwAO1riQk7tVUgdwKxnULxXzrajqjHkLaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:34165 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751996Ab2EDQxp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 4 May 2012 12:53:45 -0400
Received: by obbtb18 with SMTP id tb18so4194309obb.19
        for <linux-acpi@vger.kernel.org>; Fri, 04 May 2012 09:53:44 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

From: Marco Aurelio da Costa <costa@gamic.com>
[v3: Fixes suggested by Konrad]
Signed-off-by: Marco Aurelio da Costa <costa@gamic.com>

The EliteBook 8560W has non-initialized entries in its _PSS ACPI
table. Instead of bailing out when the first non-initialized entry is
found, ignore it and use only  the valid entries. Only bail out if there
is no valid entry at all.

---
--- linux-3.3.3/drivers/acpi/processor_perflib.c.orig	2012-04-24
22:18:23.288041268 +0200
+++ linux-3.3.3/drivers/acpi/processor_perflib.c	2012-05-04
18:23:02.640111246 +0200
@@ -311,6 +311,7 @@ static int acpi_processor_get_performanc
 	struct acpi_buffer state = { 0, NULL };
 	union acpi_object *pss = NULL;
 	int i;
+	int last_invalid = -1;


 	status = acpi_evaluate_object(pr->handle, "_PSS", NULL, &buffer);
@@ -372,14 +373,33 @@ static int acpi_processor_get_performanc
 		    ((u32)(px->core_frequency * 1000) !=
 		     (px->core_frequency * 1000))) {
 			printk(KERN_ERR FW_BUG PREFIX
-			       "Invalid BIOS _PSS frequency: 0x%llx MHz\n",
-			       px->core_frequency);
-			result = -EFAULT;
-			kfree(pr->performance->states);
-			goto end;
+			       "Invalid BIOS _PSS frequency found for processor %d: 0x%llx MHz\n",
+			       pr->id, px->core_frequency);
+			if (last_invalid == -1)
+				last_invalid = i;
+		} else {
+			if (last_invalid != -1) {
+				/*
+				 * Copy this valid entry over last_invalid entry
+				 */
+				memcpy(&(pr->performance->states[last_invalid]),
+				       px, sizeof(struct acpi_processor_px));
+				++last_invalid;
+			}
 		}
 	}

+	if (last_invalid == 0) {
+		printk(KERN_ERR FW_BUG PREFIX
+		       "No valid BIOS _PSS frequency found for processor %d\n", pr->id);
+		result = -EFAULT;
+		kfree(pr->performance->states);
+		pr->performance->states = NULL;
+	}
+
+	if (last_invalid > 0)
+		pr->performance->state_count = last_invalid;
+
       end:
 	kfree(buffer.pointer);

-- 
Marco Costa
Customer Support
--
GAMIC mbH
Roermonder Strasse, 151
52072 Aachen
Germany
