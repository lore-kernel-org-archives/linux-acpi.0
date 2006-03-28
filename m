From: akpm@osdl.org
Subject: [patch 24/26] x86_64: Remove unnecessary lapic definition from acpidef.h
Date: Tue, 28 Mar 2006 14:03:49 -0800
Message-ID: <200603282203.k2SM3t8g027722@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:3760 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932430AbWC1WEC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 28 Mar 2006 17:04:02 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org, akpm@osdl.org, ashok.raj@intel.com, ak@muc.de


From: Ashok Raj <ashok.raj@intel.com>

Dont know why this exists...  just happened to trip me when i used a variable
name with lapic, and until i looked at the pre-processed output couldnt figure
out we had a lame definition like this.

Hope I am not breaking anything here..

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Cc: Andi Kleen <ak@muc.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 include/asm-i386/apicdef.h   |    1 -
 include/asm-x86_64/apicdef.h |    2 --
 2 files changed, 3 deletions(-)

diff -puN include/asm-i386/apicdef.h~remove-unnecessary-lapic-definition-from-acpidefh include/asm-i386/apicdef.h
--- devel/include/asm-i386/apicdef.h~remove-unnecessary-lapic-definition-from-acpidefh	2006-03-28 14:03:07.000000000 -0800
+++ devel-akpm/include/asm-i386/apicdef.h	2006-03-28 14:03:07.000000000 -0800
@@ -120,7 +120,6 @@
  */
 #define u32 unsigned int
 
-#define lapic ((volatile struct local_apic *)APIC_BASE)
 
 struct local_apic {
 
diff -puN include/asm-x86_64/apicdef.h~remove-unnecessary-lapic-definition-from-acpidefh include/asm-x86_64/apicdef.h
--- devel/include/asm-x86_64/apicdef.h~remove-unnecessary-lapic-definition-from-acpidefh	2006-03-28 14:03:07.000000000 -0800
+++ devel-akpm/include/asm-x86_64/apicdef.h	2006-03-28 14:03:07.000000000 -0800
@@ -137,8 +137,6 @@
  */
 #define u32 unsigned int
 
-#define lapic ((volatile struct local_apic *)APIC_BASE)
-
 struct local_apic {
 
 /*000*/	struct { u32 __reserved[4]; } __reserved_01;
_
