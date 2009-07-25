From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] acpi: remove superfluous NULL pointer check from acpi_processor_get_throttling_info()
Date: Sat, 25 Jul 2009 18:24:30 +0200
Message-ID: <200907251824.31074.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752121AbZGYQ1t@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Dan Carpenter <error27@gmail.com>, corbet@lwn.net, eteo@redhat.com
List-Id: linux-acpi@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] acpi: remove superfluous NULL pointer check from acpi_processor_get_throttling_info()

>From Dan's list:

drivers/acpi/processor_throttling.c +1139 acpi_processor_get_throttling_info(11) warning: variable derefenced before check 'pr'

acpi_processor_get_throttling_info() is never called with pr == NULL.

Reported-by: Dan Carpenter <error27@gmail.com>
Cc: corbet@lwn.net
Cc: eteo@redhat.com
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/acpi/processor_throttling.c |    3 ---
 1 file changed, 3 deletions(-)

Index: b/drivers/acpi/processor_throttling.c
===================================================================
--- a/drivers/acpi/processor_throttling.c
+++ b/drivers/acpi/processor_throttling.c
@@ -1135,9 +1135,6 @@ int acpi_processor_get_throttling_info(s
 			  pr->throttling.duty_offset,
 			  pr->throttling.duty_width));
 
-	if (!pr)
-		return -EINVAL;
-
 	/*
 	 * Evaluate _PTC, _TSS and _TPC
 	 * They must all be present or none of them can be used.
