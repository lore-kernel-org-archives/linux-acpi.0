From: Thiago Farina <tfransosi@gmail.com>
Subject: [PATCH] trivial: remove ACPI_ARRAY_LENGTH macro.
Date: Sun,  1 Nov 2009 17:36:12 -0500
Message-ID: <1257114972-16039-1-git-send-email-tfransosi@gmail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yw0-f202.google.com ([209.85.211.202]:57637 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753595AbZKAWgr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 1 Nov 2009 17:36:47 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trivial@kernel.org
Cc: lenb@kernel.org, ming.m.lin@intel.com, robert.moore@intel.com, jkosina@suze.cz, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Thiago Farina <tfransosi@gmail.com>

Since the kernel already has a macro (ARRAY_SIZE) that does the same thing,
just use it instead of defining another macro for the same propose.

Signed-off-by: Thiago Farina <tfransosi@gmail.com>
---
 drivers/acpi/acpica/hwvalid.c |    2 +-
 drivers/acpi/acpica/uteval.c  |    4 ++--
 include/acpi/actypes.h        |    4 ----
 3 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/acpica/hwvalid.c b/drivers/acpi/acpica/hwvalid.c
index ec33f27..ca2eb02 100644
--- a/drivers/acpi/acpica/hwvalid.c
+++ b/drivers/acpi/acpica/hwvalid.c
@@ -103,7 +103,7 @@ static const struct acpi_port_info acpi_protected_ports[] = {
 	{"PCI", 0x0CF8, 0x0CFF, ACPI_OSI_WIN_XP}
 };
 
-#define ACPI_PORT_INFO_ENTRIES  ACPI_ARRAY_LENGTH (acpi_protected_ports)
+#define ACPI_PORT_INFO_ENTRIES  ARRAY_SIZE(acpi_protected_ports)
 
 /******************************************************************************
  *
diff --git a/drivers/acpi/acpica/uteval.c b/drivers/acpi/acpica/uteval.c
index 5d54e36..54efbaa 100644
--- a/drivers/acpi/acpica/uteval.c
+++ b/drivers/acpi/acpica/uteval.c
@@ -126,7 +126,7 @@ acpi_status acpi_ut_osi_implementation(struct acpi_walk_state *walk_state)
 
 	/* Compare input string to static table of supported interfaces */
 
-	for (i = 0; i < ACPI_ARRAY_LENGTH(acpi_interfaces_supported); i++) {
+	for (i = 0; i < ARRAY_SIZE(acpi_interfaces_supported); i++) {
 		if (!ACPI_STRCMP(string_desc->string.pointer,
 				 acpi_interfaces_supported[i].name)) {
 			/*
@@ -186,7 +186,7 @@ acpi_status acpi_osi_invalidate(char *interface)
 {
 	int i;
 
-	for (i = 0; i < ACPI_ARRAY_LENGTH(acpi_interfaces_supported); i++) {
+	for (i = 0; i < ARRAY_SIZE(acpi_interfaces_supported); i++) {
 		if (!ACPI_STRCMP(interface, acpi_interfaces_supported[i].name)) {
 			*acpi_interfaces_supported[i].name = '\0';
 			return AE_OK;
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 153f12d..641d746 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -441,10 +441,6 @@ typedef unsigned long long acpi_integer;
 #define ACPI_MIN(a,b)                   (((a)<(b))?(a):(b))
 #define ACPI_MAX(a,b)                   (((a)>(b))?(a):(b))
 
-/* Size calculation */
-
-#define ACPI_ARRAY_LENGTH(x)            (sizeof(x) / sizeof((x)[0]))
-
 /* Pointer manipulation */
 
 #define ACPI_CAST_PTR(t, p)             ((t *) (acpi_uintptr_t) (p))
-- 
1.6.5.1.61.ge79999

