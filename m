From: Antonio Ospite <ao2@ao2.it>
Subject: [PATCH 1/2] Documentation / ACPI: fix a sentence about GPIO resources
Date: Wed, 29 Apr 2015 10:37:24 +0200
Message-ID: <1430296645-18086-2-git-send-email-ao2@ao2.it>
References: <1430296645-18086-1-git-send-email-ao2@ao2.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp206.alice.it ([82.57.200.102]:51937 "EHLO smtp206.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031697AbbD2IiE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 29 Apr 2015 04:38:04 -0400
In-Reply-To: <1430296645-18086-1-git-send-email-ao2@ao2.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Antonio Ospite <ao2@ao2.it>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>

The sentence "These resources are used be used to pass." contains
a suspicious repetition, maybe the author meant something like "These
resources can be used to pass ...".

Simplify the wording.

Signed-off-by: Antonio Ospite <ao2@ao2.it>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org
---
 Documentation/acpi/enumeration.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/acpi/enumeration.txt b/Documentation/acpi/enumeration.txt
index 750401f..15dfce7 100644
--- a/Documentation/acpi/enumeration.txt
+++ b/Documentation/acpi/enumeration.txt
@@ -253,7 +253,7 @@ input driver:
 GPIO support
 ~~~~~~~~~~~~
 ACPI 5 introduced two new resources to describe GPIO connections: GpioIo
-and GpioInt. These resources are used be used to pass GPIO numbers used by
+and GpioInt. These resources can be used to pass GPIO numbers used by
 the device to the driver. ACPI 5.1 extended this with _DSD (Device
 Specific Data) which made it possible to name the GPIOs among other things.
 
-- 
2.1.4

