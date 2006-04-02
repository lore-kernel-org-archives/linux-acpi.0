From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [patch 24/26] x86_64: Remove unnecessary lapic definition from acpidef.h
Date: Sun, 2 Apr 2006 00:22:42 -0500
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6123DF1@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:63322 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751465AbWDBFWq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 2 Apr 2006 00:22:46 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@osdl.org
Cc: linux-acpi@vger.kernel.org, "Raj, Ashok" <ashok.raj@intel.com>, ak@muc.de

applied (even though it is apicdef.h, not acpidef.h:-)
thanks,
-Len 

>-----Original Message-----
>From: linux-acpi-owner@vger.kernel.org 
>[mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of akpm@osdl.org
>Sent: Tuesday, March 28, 2006 5:04 PM
>To: Brown, Len
>Cc: linux-acpi@vger.kernel.org; akpm@osdl.org; Raj, Ashok; ak@muc.de
>Subject: [patch 24/26] x86_64: Remove unnecessary lapic 
>definition from acpidef.h
>
>
>From: Ashok Raj <ashok.raj@intel.com>
>
>Dont know why this exists...  just happened to trip me when i 
>used a variable
>name with lapic, and until i looked at the pre-processed 
>output couldnt figure
>out we had a lame definition like this.
>
>Hope I am not breaking anything here..
>
>Signed-off-by: Ashok Raj <ashok.raj@intel.com>
>Cc: Andi Kleen <ak@muc.de>
>Signed-off-by: Andrew Morton <akpm@osdl.org>
>---
>
> include/asm-i386/apicdef.h   |    1 -
> include/asm-x86_64/apicdef.h |    2 --
> 2 files changed, 3 deletions(-)
>
>diff -puN 
>include/asm-i386/apicdef.h~remove-unnecessary-lapic-definition-
>from-acpidefh include/asm-i386/apicdef.h
>--- 
>devel/include/asm-i386/apicdef.h~remove-unnecessary-lapic-defin
ition-from-acpidefh	2006-03-28 14:03:07.000000000 -0800
>+++ devel-akpm/include/asm-i386/apicdef.h	2006-03-28 
>14:03:07.000000000 -0800
>@@ -120,7 +120,6 @@
>  */
> #define u32 unsigned int
> 
>-#define lapic ((volatile struct local_apic *)APIC_BASE)
> 
> struct local_apic {
> 
>diff -puN 
>include/asm-x86_64/apicdef.h~remove-unnecessary-lapic-definitio
n-from-acpidefh include/asm-x86_64/apicdef.h
>--- 
>devel/include/asm-x86_64/apicdef.h~remove-unnecessary-lapic-def
inition-from-acpidefh	2006-03-28 14:03:07.000000000 -0800
>+++ devel-akpm/include/asm-x86_64/apicdef.h	2006-03-28 
>14:03:07.000000000 -0800
>@@ -137,8 +137,6 @@
>  */
> #define u32 unsigned int
> 
>-#define lapic ((volatile struct local_apic *)APIC_BASE)
>-
> struct local_apic {
> 
> /*000*/	struct { u32 __reserved[4]; } __reserved_01;
>_
>-
>To unsubscribe from this list: send the line "unsubscribe 
>linux-acpi" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
