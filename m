From: Daniel Drake <drake@endlessm.com>
Subject: [PATCH] ACPI: avoid KERN_ERR in log messages
Date: Wed, 13 Sep 2017 10:16:44 +0800
Message-ID: <20170913021644.7385-1-drake@endlessm.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pf0-f171.google.com ([209.85.192.171]:35749 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751078AbdIMCQy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Sep 2017 22:16:54 -0400
Received: by mail-pf0-f171.google.com with SMTP id q76so7814431pfq.2
        for <linux-acpi@vger.kernel.org>; Tue, 12 Sep 2017 19:16:54 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux@endlessm.com

Linux distros typically ship with the "quiet" boot parameter,
and a userspace splash (e.g. plymouth) in order to control what is shown
on screen during boot so that ordinary users are not troubled by boot
messages that they don't understand.

However, any error messages printed before userspace has started
are going to show on-screen and hence we should only log errors that
are really going to prevent use of the system.

It seems that many consumer systems for years now have come with
imperfect ACPI tables, and Linux reacts to this with highly verbose
error messages logged from early boot such as these on the Asus X541UJ:
  ACPI Error: [PRT0] Namespace lookup failure, AE_ALREADY_EXISTS (20170119/dswload-378)
  ACPI Exception: AE_ALREADY_EXISTS, During name lookup/catalog (20170119/psobject-227)
  ACPI Exception: AE_ALREADY_EXISTS, (SSDT:SataTabl) while loading table (20170119/tbxfload-228)
  ACPI Error: 1 table load failures, 8 successful (20170119/tbxfload-246)

We've seen cases where these messages generate support tickets or
product returns, but it seems to me that the vast majority of ACPI
error messages (when occurring on end-user systems) are not going to
affect system boot, so it would be better if they didn't spam the screen
when booting with "quiet".

Demote the messages to KERN_WARNING in order to avoid them appearing
on the console.

Signed-off-by: Daniel Drake <drake@endlessm.com>
---
 include/acpi/platform/aclinux.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform/aclinux.h
index 1b473efd9eb6..6bdb523a6d55 100644
--- a/include/acpi/platform/aclinux.h
+++ b/include/acpi/platform/aclinux.h
@@ -171,12 +171,12 @@
 #define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_get_next_filename
 #define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_close_directory
 
-#define ACPI_MSG_ERROR          KERN_ERR "ACPI Error: "
-#define ACPI_MSG_EXCEPTION      KERN_ERR "ACPI Exception: "
+#define ACPI_MSG_ERROR          KERN_WARNING "ACPI Error: "
+#define ACPI_MSG_EXCEPTION      KERN_WARNING "ACPI Exception: "
 #define ACPI_MSG_WARNING        KERN_WARNING "ACPI Warning: "
 #define ACPI_MSG_INFO           KERN_INFO "ACPI: "
 
-#define ACPI_MSG_BIOS_ERROR     KERN_ERR "ACPI BIOS Error (bug): "
+#define ACPI_MSG_BIOS_ERROR     KERN_WARNING "ACPI BIOS Error (bug): "
 #define ACPI_MSG_BIOS_WARNING   KERN_WARNING "ACPI BIOS Warning (bug): "
 
 /*
-- 
2.11.0

