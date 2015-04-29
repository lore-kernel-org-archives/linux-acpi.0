From: Antonio Ospite <ao2@ao2.it>
Subject: [PATCH 2/2] Documentation / ACPI: fix a typo, s/objecte/object/
Date: Wed, 29 Apr 2015 10:37:25 +0200
Message-ID: <1430296645-18086-3-git-send-email-ao2@ao2.it>
References: <1430296645-18086-1-git-send-email-ao2@ao2.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp208.alice.it ([82.57.200.104]:29722 "EHLO smtp208.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031507AbbD2Ihj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 29 Apr 2015 04:37:39 -0400
In-Reply-To: <1430296645-18086-1-git-send-email-ao2@ao2.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Antonio Ospite <ao2@ao2.it>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>

Also add some commas to make it clear that the word "object" refers to
"configuration" and not to "names".

Signed-off-by: Antonio Ospite <ao2@ao2.it>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org
---
 Documentation/acpi/gpio-properties.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/acpi/gpio-properties.txt b/Documentation/acpi/gpio-properties.txt
index ae36fcf..cd4b6c7 100644
--- a/Documentation/acpi/gpio-properties.txt
+++ b/Documentation/acpi/gpio-properties.txt
@@ -1,7 +1,7 @@
 _DSD Device Properties Related to GPIO
 --------------------------------------
 
-With the release of ACPI 5.1 and the _DSD configuration objecte names
+With the release of ACPI 5.1, and the _DSD configuration object, names
 can finally be given to GPIOs (and other things as well) returned by
 _CRS.  Previously, we were only able to use an integer index to find
 the corresponding GPIO, which is pretty error prone (it depends on
-- 
2.1.4

