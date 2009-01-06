From: Luca Tettamanti <kronos.it@gmail.com>
Subject: [PATCH] ACPI: set acpi_enforce_resources to strict
Date: Tue, 6 Jan 2009 19:20:12 +0100
Message-ID: <20090106182012.GA6668@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:36991 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751659AbZAFS1O (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Jan 2009 13:27:14 -0500
Received: by bwz14 with SMTP id 14so24426255bwz.13
        for <linux-acpi@vger.kernel.org>; Tue, 06 Jan 2009 10:27:12 -0800 (PST)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>

The following patch changes the default for "acpi_enforce_resources" option to
"strict", disallowing access by native drivers to IO ports and memory regions
claimed by ACPI firmware.

The patch is mainly aimed to block native hwmon drivers from touching
monitoring chips that ACPI thinks it own; there have reports of such
conflicts in the past, leading to an emergency shutdown of the machine
(due to native IC driver interference ACPI TZ polling ends up reading
garbage); I'm also writing a driver for ASUS ATK0110 ACPI hwmon
interface[1], which will _definitely_ clash with native drivers.

Currently only hwmon SuperIO IC's and SMBus controllers will be affected by
this change. Unfortunately this also means that drivers for those devices will
refuse to load and users may perceive this as regression; consensus - however
- is that we shouldn't touch resources claimed by the firmware because it's too
risky since we do not know what ACPI code may be doing (and it is risky
_right now_, regardless of the new ATK driver); for people who needs to
force the loading of hwmon drivers regardless of what ACPI is doing there's is
always the possibility to set acpi_enforce_resources to "lax".

While I as at it I also documented the parameter ;-)

[1] http://lists.lm-sensors.org/pipermail/lm-sensors/2009-January/025035.html

Signed-off-by: Luca Tettamanti <kronos.it@gmail.com>
Blessed-by: Hans de Goede <hdegoede@redhat.com>
---
 Documentation/kernel-parameters.txt |   16 ++++++++++++++++
 drivers/acpi/osl.c                  |    2 +-
 2 files changed, 17 insertions(+), 1 deletion(-)

Index: b/Documentation/kernel-parameters.txt
===================================================================
--- a/Documentation/kernel-parameters.txt	2009-01-06 16:44:29.406069082 +0100
+++ b/Documentation/kernel-parameters.txt	2009-01-06 19:16:57.543996442 +0100
@@ -252,6 +252,22 @@
 			to assume that this machine's pmtimer latches its value
 			and always returns good values.
 
+	acpi_enforce_resources=	[ACPI]
+			{ strict, lax, no }
+			Check for resource conflicts between native drivers
+			and ACPI OperationRegions (SystemIO and System Memory
+			only). IO ports and memory declared in ACPI might be
+			used by the ACPI subsystem in arbitrary AML code and
+			can interfere with legacy drivers.
+			strict (default): access to resources claimed by ACPI
+			is denied; legacy drivers trying to access reserved
+			resources will fail to load.
+			lax: access to resources claimed by ACPI is allowed;
+			legacy drivers trying to access reserved resources
+			will load and a warning message is logged.
+			no: ACPI OperationRegions are not marked as reserved,
+			no further checks are performed.
+
 	agp=		[AGP]
 			{ off | try_unsupported }
 			off: disable AGP support
Index: b/drivers/acpi/osl.c
===================================================================
--- a/drivers/acpi/osl.c	2008-12-14 19:26:02.926046208 +0100
+++ b/drivers/acpi/osl.c	2009-01-06 19:16:31.506869922 +0100
@@ -1077,7 +1077,7 @@
 #define ENFORCE_RESOURCES_LAX    1
 #define ENFORCE_RESOURCES_NO     0
 
-static unsigned int acpi_enforce_resources = ENFORCE_RESOURCES_LAX;
+static unsigned int acpi_enforce_resources = ENFORCE_RESOURCES_STRICT;
 
 static int __init acpi_enforce_resources_setup(char *str)
 {

Luca
-- 
Dicono che  il cane sia  il miglior  amico dell'uomo. Secondo me  non e`
vero. Quanti dei vostri amici avete fatto castrare, recentemente?
