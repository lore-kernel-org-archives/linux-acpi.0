From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 1/4] tools/power/acpi: Minor bugfixes
Date: Mon,  7 Apr 2014 15:16:54 +0200
Message-ID: <1396876617-53345-2-git-send-email-trenn@suse.de>
References: <1396876617-53345-1-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:47853 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755338AbaDGNRB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 7 Apr 2014 09:17:01 -0400
In-Reply-To: <1396876617-53345-1-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net
Cc: lv.zheng@intel.com, linux-acpi@vger.kernel.org, Thomas Renninger <trenn@suse.de>

- bindir is created, but sbindir is used -> fix that
- the debug parts are there twice (copy paste bug?). Remove one of the
  exact same parts

Signed-off-by: Thomas Renninger <trenn@suse.de>
---
 tools/power/acpi/Makefile |   11 +----------
 1 files changed, 1 insertions(+), 10 deletions(-)

diff --git a/tools/power/acpi/Makefile b/tools/power/acpi/Makefile
index d9186a2..c2c0f20 100644
--- a/tools/power/acpi/Makefile
+++ b/tools/power/acpi/Makefile
@@ -89,15 +89,6 @@ else
 	STRIPCMD = $(STRIP) -s --remove-section=.note --remove-section=.comment
 endif
 
-# if DEBUG is enabled, then we do not strip or optimize
-ifeq ($(strip $(DEBUG)),true)
-	CFLAGS += -O1 -g -DDEBUG
-	STRIPCMD = /bin/true -Since_we_are_debugging
-else
-	CFLAGS += $(OPTIMIZATION) -fomit-frame-pointer
-	STRIPCMD = $(STRIP) -s --remove-section=.note --remove-section=.comment
-endif
-
 # --- ACPIDUMP BEGIN ---
 
 vpath %.c \
@@ -128,7 +119,7 @@ clean:
 	-rm -f $(OUTPUT)acpidump
 
 install-tools:
-	$(INSTALL) -d $(DESTDIR)${bindir}
+	$(INSTALL) -d $(DESTDIR)${sbindir}
 	$(INSTALL_PROGRAM) $(OUTPUT)acpidump $(DESTDIR)${sbindir}
 
 install-man:
-- 
1.7.6.1

