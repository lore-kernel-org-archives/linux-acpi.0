From: "Jordan Crouse" <jordan.crouse@amd.com>
Subject: [RFC/PATCH] ACPI:  Correctly recover from a failed S3 attempt
Date: Tue, 8 Aug 2006 14:04:34 -0600
Message-ID: <20060808200434.GJ14539@cosmic.amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary=vGgW1X5XWziG23Ko
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from outbound-cpk.frontbridge.com ([207.46.163.16]:28964 "EHLO
	outbound2-cpk-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1030288AbWHHUEf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 8 Aug 2006 16:04:35 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, william.morrow@amd.com


--vGgW1X5XWziG23Ko
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

We have a poorly behaving BIOS that simply returns from its suspend
procedure, rather then jumping to the restart routine indicated by
the FACS.  This appears to Linux as a failed S3 attempt.

This would normally succeed, but the sysenter msrs are not
restored and the restart fails.  It is not clear if this is the only
omission, but if the sysenter msrs are manually entered in the debugger, 
the OS resumes.

The attached patch would invoke the register restore function on failure.
This has absolutely no effect on correct systems, and, "does the right thing"
for failed or stupid BIOSes, at least as far as I am concerned.

Comments?
Jordan

-- 
Jordan Crouse
Senior Linux Engineer
Advanced Micro Devices, Inc.
<www.amd.com/embeddedprocessors>

--vGgW1X5XWziG23Ko
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline;
 filename=acpi-s3-fix.patch
Content-Transfer-Encoding: 7bit

[PATCH] ACPI:  Correctly recover from a failed S3 attempt

From: William Morrrow <william.morrow@amd.com>

This was discovered on a broken BIOS that simply returned from its 
suspend procedure, appearing to the OS as a failed S3 attempt. 

It is possible to invoke the protected mode register restore routine (which
would normally restore the sysenter registers) when the bios returns from S3. 
This has no effect on a correctly running system and repairs the damage
from broken BIOS.

Signed-off-by: William Morrow <william.morrow@amd.com>
Signed-off-by: Jordan Crouse <jordan.crouse@amd.com>
---

 arch/i386/kernel/acpi/wakeup.S |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/i386/kernel/acpi/wakeup.S b/arch/i386/kernel/acpi/wakeup.S
index 9f408ee..b781b38 100644
--- a/arch/i386/kernel/acpi/wakeup.S
+++ b/arch/i386/kernel/acpi/wakeup.S
@@ -292,7 +292,10 @@ ENTRY(do_suspend_lowlevel)
 	pushl	$3
 	call	acpi_enter_sleep_state
 	addl	$4, %esp
-	ret
+
+#	In case of S3 failure, we'll emerge here.  Jump
+# 	to ret_point to recover
+	jmp	ret_point
 	.p2align 4,,7
 ret_point:
 	call	restore_registers

--vGgW1X5XWziG23Ko--


