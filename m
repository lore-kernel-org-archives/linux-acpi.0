From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] [0/1] acpi_wakeup.S
Date: Tue, 11 Feb 2003 15:25:33 +0100
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20030211142533.GM25625@poup.poupinou.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="aM3YZ0Iwxop3KEKx"
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--aM3YZ0Iwxop3KEKx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This one correct the arithmetic 0x1000 = 4096.

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.

--aM3YZ0Iwxop3KEKx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="00_acpi_wakeup.diff"

--- linux-2.5.60/arch/i386/kernel/acpi_wakeup.S	2003/02/11 13:59:48	1.1
+++ linux-2.5.60/arch/i386/kernel/acpi_wakeup.S	2003/02/11 14:00:41
@@ -160,11 +160,11 @@
 	ALIGN
 
 
-.org	0x2000
+.org	0x800
 wakeup_stack:
-.org	0x3000
+.org	0x900
 ENTRY(wakeup_end)
-.org	0x4000
+.org	0x1000
 
 wakeup_pmode_return:
 	movl	$__KERNEL_DS, %eax

--aM3YZ0Iwxop3KEKx--
