From: Ducrot Bruno <poup-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] [1/1] acpi_wakeup.S
Date: Tue, 11 Feb 2003 15:37:17 +0100
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20030211143717.GC25632@poup.poupinou.org>
References: <20030211142533.GM25625@poup.poupinou.org>
Reply-To: ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="EVF5PPMfhYS0aIcm"
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030211142533.GM25625-j6u/t2rXLliUoIHC/UFpr9i2O/JbrIOy@public.gmane.org>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Patch from Pavel Macheck.  Just in case it was
lost..




-- 
Ducrot Bruno
http://www.poupinou.org        Page profaissionelle
http://toto.tu-me-saoules.com  Haume page

--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="01_acpi_wakeup.diff"

--- linux-2.5.60/arch/i386/kernel/acpi_wakeup.S	2003/02/11 14:02:07	1.2
+++ linux-2.5.60/arch/i386/kernel/acpi_wakeup.S	2003/02/11 14:02:54
@@ -31,7 +31,7 @@
 	movw	%cs, %ax
 	movw	%ax, %ds					# Make ds:0 point to wakeup_start
 	movw	%ax, %ss
-	mov	wakeup_stack - wakeup_code, %sp			# Private stack is needed for ASUS board
+	mov	$(wakeup_stack - wakeup_code), %sp		# Private stack is needed for ASUS board
 	movw	$0x0e00 + 'S', %fs:(0x12)
 
 	pushl	$0						# Kill any dangerous flags

--EVF5PPMfhYS0aIcm--
