From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 2/2] tools acpidump: acpidump must be run as root - install it into /usr/sbin
Date: Sat, 15 Dec 2012 18:11:59 +0100
Message-ID: <1355591519-44664-3-git-send-email-trenn@suse.de>
References: <1355591519-44664-1-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:52937 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751608Ab2LORML (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 15 Dec 2012 12:12:11 -0500
In-Reply-To: <1355591519-44664-1-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: rjw@sisk.pl, lenb@kernel.org, Thomas Renninger <trenn@suse.de>

Signed-off-by: Thomas Renninger <trenn@suse.de>
---
 tools/power/acpi/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/tools/power/acpi/Makefile b/tools/power/acpi/Makefile
index 8650fd8..c5cbe30 100644
--- a/tools/power/acpi/Makefile
+++ b/tools/power/acpi/Makefile
@@ -21,7 +21,7 @@ clean:
 	done
 
 install:
-	install acpidump /usr/bin/acpidump
+	install acpidump /usr/sbin/acpidump
 	install acpidump.8 /usr/share/man/man8
 	for dir in $(SUBDIRS); do \
 		$(MAKE) -C $$dir install; \
-- 
1.7.6.1

