From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [Fwd: [PATCH] Don't save state in ACPI on shutdown/reboot]
Date: 11 Nov 2003 11:23:44 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1068567824.24982.21.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-6X6O1QvX2wRgj1ggAs8m"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--=-6X6O1QvX2wRgj1ggAs8m
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



--=-6X6O1QvX2wRgj1ggAs8m
Content-Disposition: inline
Content-Description: Forwarded message - [PATCH] Don't save state in ACPI
	on shutdown/reboot
Content-Type: message/rfc822

Received: from hdsmsx401.amr.corp.intel.com ([10.127.2.60]) by
	hdsmsx402.amr.corp.intel.com with Microsoft SMTPSVC(5.0.2195.5329); Tue, 11
	Nov 2003 08:15:05 -0500
Received: from fmsmsx311.amr.corp.intel.com ([132.233.42.214]) by
	hdsmsx401.amr.corp.intel.com with Microsoft SMTPSVC(5.0.2195.5329); Tue, 11
	Nov 2003 08:15:05 -0500
Received: from scsmsx402.amr.corp.intel.com ([10.3.90.16]) by
	fmsmsx311.amr.corp.intel.com with Microsoft SMTPSVC(5.0.2195.5329); Tue, 11
	Nov 2003 05:15:04 -0800
Received: from scsmsx332.amr.corp.intel.com ([10.3.90.6]) by
	scsmsx402.amr.corp.intel.com with Microsoft SMTPSVC(5.0.2195.5329); Tue, 11
	Nov 2003 05:15:04 -0800
Received: from scsmsxvs040.sc.intel.com ([10.3.90.8]) by
	scsmsx332.amr.corp.intel.com with Microsoft SMTPSVC(5.0.2195.5329); Tue, 11
	Nov 2003 05:15:03 -0800
Received: from petasus.sc.intel.com ([10.3.253.4]) by
	scsmsxvs040.sc.intel.com (SAVSMTP 3.1.1.32) with SMTP id
	M2003111105150301443 for <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>; Tue, 11 Nov 2003 05:15:03
	-0800
Received: from hermes.sc.intel.com (hermes.sc.intel.com [10.3.252.3]) by
	petasus.sc.intel.com (8.11.6-20030918-01/8.11.6/d: inner.mc,v 1.35
	2003/05/22 21:18:01 rfjohns1 Exp $) with ESMTP id hABD9PS26068 for
	<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>; Tue, 11 Nov 2003 13:09:25 GMT
Received: from zero.aec.at (zero.aec.at [193.170.194.10]) by
	hermes.sc.intel.com (8.12.9-20030918-01/8.12.9/d: outer.mc,v 1.66
	2003/05/22 21:17:36 rfjohns1 Exp $) with ESMTP id hABDBGDX029742 for
	<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>; Tue, 11 Nov 2003 13:11:17 GMT
Received: from fred.muc.de (Joram_Tate-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org [127.0.0.1])
	by zero.aec.at (8.11.6/8.11.2) with ESMTP id hABDEiS25327; Tue, 11 Nov 2003
	14:14:45 +0100
Received: by fred.muc.de (Postfix on SuSE Linux 7.3 (i386), from userid
	500) id 433635BBF5; Tue, 11 Nov 2003 14:14:43 +0100 (CET)
Date: Tue, 11 Nov 2003 14:14:43 +0100
From: Andi Kleen <ak-h9bWGtP8wOw@public.gmane.org>
To: marcelo.tosatti-3EexvZdKGZRWk0Htik3J/w@public.gmane.org, len.brown@intel.com
Subject: [PATCH] Don't save state in ACPI on shutdown/reboot
Message-ID: <20031111131443.GA23874-/48724CwFAA@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Scanned-By: MIMEDefang 2.31 (www . roaringpenguin . com / mimedefang)
Return-Path: andi-bSFPc0o6UAsfkAVcSgbgKT/hqV7O9W1bHZ5vskTnxNA@public.gmane.org
X-OriginalArrivalTime: 11 Nov 2003 13:15:03.0923 (UTC)
	FILETIME=[D1A1BC30:01C3A855]
Content-Transfer-Encoding: 7bit


The ACPI code in 2.4 currently saves the machine state as for a 
suspend when doing an reboot or shutdown. This fails on x86-64
on some boxes.

Don't save/restore state in ACPI when entering S5.

-Andi

diff -u linux-2.4.21/drivers/acpi/system.c-o linux-2.4.21/drivers/acpi/system.c
--- linux-2.4.21/drivers/acpi/system.c-o	2003-09-23 00:40:19.000000000 +0200
+++ linux-2.4.21/drivers/acpi/system.c	2003-09-23 01:05:05.000000000 +0200
@@ -118,7 +118,8 @@
 	 * been loaded from disk.
 	 */
 	if (state > ACPI_STATE_S1) {
-		acpi_restore_state_mem();
+		if (state != ACPI_STATE_S5) 
+			acpi_restore_state_mem();
 
 		/* Do _early_ resume for irqs.  Required by
 		 * ACPI specs.
@@ -127,6 +128,7 @@
 		 * interrupts.
 		 */
 #ifdef CONFIG_X86
+		/* AK: this looks rather broken in APIC mode */
 		init_8259A(0);
 #endif
 		/* wait for power to come back */
@@ -200,7 +202,7 @@
 		ACPI_FLUSH_CPU_CACHE();
 
 		/* Do arch specific saving of state. */
-		if (state > ACPI_STATE_S1) {
+		if (state > ACPI_STATE_S1 && state < ACPI_STATE_S5) {
 			error = acpi_save_state_mem();
 
 			/* TBD: if no s4bios, write codes for


--=-6X6O1QvX2wRgj1ggAs8m--



-------------------------------------------------------
This SF.Net email sponsored by: ApacheCon 2003,
16-19 November in Las Vegas. Learn firsthand the latest
developments in Apache, PHP, Perl, XML, Java, MySQL,
WebDAV, and more! http://www.apachecon.com/
