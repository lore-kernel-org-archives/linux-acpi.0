From: Rami Rosen <ramirose@gmail.com>
Subject: [PATCH] Documentation: ACPI: add copy_dsdt to ACPI format options.
Date: Sat, 26 Sep 2015 19:27:57 +0300
Message-ID: <1443284877-7537-1-git-send-email-ramirose@gmail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:34624 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751478AbbIZQ2Y (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 26 Sep 2015 12:28:24 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rafael.j.wysocki@intel.com
Cc: ming.m.lin@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Rami Rosen <ramirose@gmail.com>

commit aa2110cb1a7510f9b834adfb39b05d4843a35d35
("ACPI: add boot option acpi=copy_dsdt to fix corrupt DSDT") added 
copy_dsdt as an ACPI boot option, but did not add it to ACPI format options in
Documentation/kernel-parameters.txt. This patch fixes it.

Signed-off-by: Rami Rosen <ramirose@gmail.com>
---
 Documentation/kernel-parameters.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 22a4b68..bbf4ee6c 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -167,7 +167,8 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 
 	acpi=		[HW,ACPI,X86,ARM64]
 			Advanced Configuration and Power Interface
-			Format: { force | off | strict | noirq | rsdt }
+			Format: { force | off | strict | noirq | rsdt |
+				  copy_dsdt }
 			force -- enable ACPI if default was off
 			off -- disable ACPI if default was on
 			noirq -- do not use ACPI for IRQ routing
-- 
2.4.3

