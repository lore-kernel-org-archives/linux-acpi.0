From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [Fwd: [PATCH][RFC] Clean up Kconfig logic for IA64 ACPI]
Date: 01 Nov 2003 21:48:52 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1067741332.2724.3.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-j4hBRen0UcKO14ABBXay"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Luming Yu <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--=-j4hBRen0UcKO14ABBXay
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Luming,
Please review and comment.

thanks,
-Len


--=-j4hBRen0UcKO14ABBXay
Content-Disposition: inline
Content-Description: Forwarded message - [PATCH][RFC] Clean up Kconfig
	logic for IA64 ACPI
Content-Type: message/rfc822

Received: from fmsmsx312.amr.corp.intel.com ([132.233.42.227]) by
	hdsmsx402.amr.corp.intel.com with Microsoft SMTPSVC(5.0.2195.5329); Sat, 1
	Nov 2003 19:37:57 -0500
Received: from fmsmsx332.amr.corp.intel.com ([132.233.42.148]) by
	fmsmsx312.amr.corp.intel.com with Microsoft SMTPSVC(5.0.2195.5329); Sat, 1
	Nov 2003 16:37:56 -0800
MIME-Version: 1.0
Received: from fmsmsxv041-1.fm.intel.com ([132.233.42.126]) by
	fmsmsx332.amr.corp.intel.com with Microsoft SMTPSVC(5.0.2195.5329); Sat, 1
	Nov 2003 16:37:56 -0800
Received: from petasus.fm.intel.com ([10.1.192.37]) by
	fmsmsxv041-1.fm.intel.com (NAVGW 2.5.2.11) with SMTP id
	M2003110116375515052 for <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>; Sat, 01 Nov 2003 16:37:55
	-0800
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Received: from hermes-pilot.fm.intel.com (hermes-pilot.fm.intel.com
	[10.1.193.42]) by petasus.fm.intel.com (8.11.6-20030918-01/8.11.6/d:
	inner.mc,v 1.35 2003/05/22 21:18:01 rfjohns1 Exp $) with ESMTP id
	hA20TQD29810 for <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>; Sun, 2 Nov 2003 00:29:26 GMT
Received: from vger.kernel.org (vger.kernel.org [67.72.78.212]) by
	hermes-pilot.fm.intel.com (8.12.9-20030918-01/8.11.6/d: major-outer.mc,v
	1.5 2003/10/14 22:30:27 root Exp $) with ESMTP id hA20XHYD006194 for
	<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>; Sun, 2 Nov 2003 00:33:23 GMT
Received: (majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org) by vger.kernel.org via listexpand id
	S261298AbTKBAfh (ORCPT <rfc822;len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>); Sat, 1 Nov 2003
	19:35:37 -0500
Received: (majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org) by vger.kernel.org id
	S261299AbTKBAfh (ORCPT <rfc822;linux-kernel-outgoing>); Sat, 1 Nov 2003
	19:35:37 -0500
Received: from SteeleMR-loadb-NAT-49.caltech.edu ([131.215.49.69]:24437
	"EHLO earth-ox.its.caltech.edu") by vger.kernel.org with ESMTP id
	S261298AbTKBAfN (ORCPT <rfc822;linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>); Sat, 1 Nov
	2003 19:35:13 -0500
Received: from water-dog (water-dog [192.168.1.26]) by earth-ox-postvirus
	(Postfix) with ESMTP id CD138109A16; Sat,  1 Nov 2003 16:35:12 -0800 (PST)
Received: from water-ox ([192.168.1.10]) by water-dog (MailMonitor for
	SMTP v1.2.2 ) ; Sat, 1 Nov 2003 16:35:11 -0800 (PST)
Received: from sue.its.caltech.edu (sue.its.caltech.edu [131.215.48.175])
	by water-ox.its.caltech.edu (Postfix) with ESMTP id 9FD5126AC3E; Sat,  1
	Nov 2003 16:35:11 -0800 (PST)
Received: from localhost (noah@localhost) by sue.its.caltech.edu
	(8.12.9/8.12.8) with ESMTP id hA20ZBkI011573; Sat, 1 Nov 2003 16:35:11
	-0800 (PST)
content-class: urn:content-classes:message
Subject: [PATCH][RFC] Clean up Kconfig logic for IA64 ACPI
Date: Sat, 1 Nov 2003 19:35:11 -0500
Message-ID: <Pine.GSO.4.58.0310251706470.15711@inky>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH][RFC] Clean up Kconfig logic for IA64 ACPI
Thread-Index: AcOg2Y/oBzwuVMGbRL+SfcKfFMVMIw==
From: "Noah J. Misch" <noah-7GExONQZ6ZKVc3sceRu5cw@public.gmane.org>
Sender: <linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: <linux-ia64-WygotPe7DYIabbyE177sbg@public.gmane.org>
Cc: <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, <linux-kernel@vger.kernel.org>
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1">
<META NAME="Generator" CONTENT="MS Exchange Server version 6.0.6487.1">
<TITLE>[PATCH][RFC] Clean up Kconfig logic for IA64 ACPI</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=2>Greetings,<BR>
<BR>
I found the Kconfig logic for ACPI and IA64, as defined in arch/ia64/Kconfig and<BR>
drivers/acpi/Kconfig to be a bit redundant and hard to follow.&nbsp; It appears to do<BR>
the following:<BR>
<BR>
1) Set ACPI=y, ACPI_INTERPRETER=y, ACPI_EFI=y, and ACPI_KERNEL_CONFIG=y if and<BR>
only if not configuring for the HP simulator (arch/ia64/Kconfig).<BR>
<BR>
2) Show the configs in drivers/acpi/Kconfig unless configuring for the HP<BR>
simulator (arch/IA64/Kconfig).<BR>
<BR>
3) Set ACPI_BOOT=y under the same conditions as #1 (drivers/acpi/Kconfig).<BR>
<BR>
4) Set ACPI_INTERPRETER=y if and only if !IA64_SGI_SN (drivers/acpi/Kconfig).<BR>
<BR>
5) Automatically set or allow a number of specific ACPI options if<BR>
ACPI_INTERPRETER but not IA64_SGI_SN (drivers/acpi/Kconfig).<BR>
<BR>
6) Set ACPI_EFI=y if ACPI_INTERPRETER (drivers/acpi/Kconfig).<BR>
<BR>
There's a fair amount of textual and logical redundancy there, as well as<BR>
dependencies on and selections of obsolete options.&nbsp; This had even caused<BR>
compilation failures in certain corner cases.&nbsp; This patch corrects that:<BR>
<BR>
1) Remove the copies of ACPI, ACPI_INTERPRETER, and ACPI_EFI from<BR>
arch/ia64/Kconfig and instead make IA64 select ACPI unless configuring for the<BR>
HP simulator.<BR>
<BR>
2) Delete ACPI_KERNEL_CONFIG from arch/ia64/Kconfig.&nbsp; It no longer affects any<BR>
part of the kernel, and it appears as though ACPI_BOOT has fully superseded it.<BR>
<BR>
3) Remove all dependencies in drivers/acpi/Kconfig that reference IA64_SGI_SN.<BR>
That option no longer exists, and even if it did, only ACPI_INTERPRETER need<BR>
depend on it, and the rest of the options it currently guards would follow suit.<BR>
<BR>
I have compiled a wide variety of IA64 kernels with this patch applied, so I am<BR>
fairly confident that it is not introducing new problems.&nbsp; The patch applies to<BR>
linux-2.5 BK and linux-ia64-2.5 BK as of 2003-11-02 at 0000 UTC.<BR>
<BR>
This should not change any user-visible configuration semantics.&nbsp; Indeed, the<BR>
only user-visible change is the visible defaulting of ACPI.&nbsp; Please let me know<BR>
what you think.&nbsp; I consider this 2.7 material.<BR>
<BR>
Thanks,<BR>
Noah<BR>
<BR>
# This is a BitKeeper generated patch for the following project:<BR>
# Project Name: Linux kernel tree<BR>
# This patch format is intended for GNU patch command version 2.5 or higher.<BR>
# This patch includes the following deltas:<BR>
#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ChangeSet&nbsp;&nbsp;&nbsp; 1.1296.83.15 -&gt; 1.1296.83.16<BR>
#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; arch/ia64/Kconfig&nbsp;&nbsp;&nbsp; 1.46&nbsp;&nbsp;&nbsp; -&gt; 1.47<BR>
#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drivers/acpi/Kconfig&nbsp;&nbsp;&nbsp; 1.26&nbsp;&nbsp;&nbsp; -&gt; 1.27<BR>
#<BR>
# The following is the BitKeeper ChangeSet Log<BR>
# --------------------------------------------<BR>
# 03/10/27&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; noah-7GExONQZ6ZKVc3sceRu5cw@public.gmane.org&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.1296.83.16<BR>
# Merge ACPI Kconfig entries from arch/ia64/Kconfig into drivers/acpi/Kconfig.<BR>
# Eliminate references to obsolete ACPI_KERNEL_CONFIG and IA64_SGI_SN config<BR>
# variables.&nbsp; Add help text to ACPI_BOOT, for the benefit of developers<BR>
# perusing drivers/acpi/Kconfig.<BR>
# --------------------------------------------<BR>
#<BR>
diff -Nru a/arch/ia64/Kconfig b/arch/ia64/Kconfig<BR>
--- a/arch/ia64/Kconfig Sat Nov&nbsp; 1 14:43:25 2003<BR>
+++ b/arch/ia64/Kconfig Sat Nov&nbsp; 1 14:43:25 2003<BR>
@@ -11,6 +11,7 @@<BR>
<BR>
&nbsp;config IA64<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; select ACPI if !IA64_HP_SIM<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default y<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; help<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; The Itanium Processor Family is Intel's 64-bit successor to<BR>
@@ -130,57 +131,6 @@<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool &quot;64KB&quot;<BR>
<BR>
&nbsp;endchoice<BR>
-<BR>
-config ACPI<BR>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool<BR>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; depends on !IA64_HP_SIM<BR>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default y<BR>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ---help---<BR>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; ACPI/OSPM support for Linux is currently under development. As such,<BR>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; this support is preliminary and EXPERIMENTAL.&nbsp; Configuring ACPI<BR>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; support enables kernel interfaces that allow higher level software<BR>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; (OSPM) to manipulate ACPI defined hardware and software interfaces,<BR>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; including the evaluation of ACPI control methods.&nbsp; If unsure, choose<BR>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; N here.&nbsp; Note, this option will enlarge your kernel by about 120K.<BR>
-<BR>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; This support requires an ACPI compliant platform (hardware/firmware).<BR>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; If both ACPI and Advanced Power Management (APM) support are<BR>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; configured, whichever is loaded first shall be used.<BR>
-<BR>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; This code DOES NOT currently provide a complete OSPM implementation<BR>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; -- it has not yet reached APM's level of functionality.&nbsp; When fully<BR>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; implemented, Linux ACPI/OSPM will provide a more robust functional<BR>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; replacement for legacy configuration and power management<BR>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; interfaces, including the Plug-and-Play BIOS specification (PnP<BR>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; BIOS), the Multi-Processor Specification (MPS), and the Advanced<BR>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; Power Management specification (APM).<BR>
-<BR>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; Linux support for ACPI/OSPM is based on Intel Corporation's ACPI<BR>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; Component Architecture (ACPI CA). The latest ACPI CA source code,<BR>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; documentation, debug builds, and implementation status information<BR>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; can be downloaded from:<BR>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &lt;<A HREF="http://developer.intel.com/technology/iapc/acpi/downloads.htm">http://developer.intel.com/technology/iapc/acpi/downloads.htm</A>&gt;.<BR>
-<BR>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; The ACPI Sourceforge project may also be of interest:<BR>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &lt;<A HREF="http://sf.net/projects/acpi/">http://sf.net/projects/acpi/</A>&gt;<BR>
-<BR>
-config ACPI_EFI<BR>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool<BR>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; depends on !IA64_HP_SIM<BR>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default y<BR>
-<BR>
-config ACPI_INTERPRETER<BR>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool<BR>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; depends on !IA64_HP_SIM<BR>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default y<BR>
-<BR>
-config ACPI_KERNEL_CONFIG<BR>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool<BR>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; depends on !IA64_HP_SIM<BR>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default y<BR>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; help<BR>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; If you say `Y' here, Linux's ACPI support will use the<BR>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; hardware-level system descriptions found on IA-64 systems.<BR>
<BR>
&nbsp;config IA64_BRL_EMU<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool<BR>
diff -Nru a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig<BR>
--- a/drivers/acpi/Kconfig&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Sat Nov&nbsp; 1 14:43:25 2003<BR>
+++ b/drivers/acpi/Kconfig&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Sat Nov&nbsp; 1 14:43:25 2003<BR>
@@ -9,7 +9,7 @@<BR>
<BR>
&nbsp;config ACPI<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool &quot;ACPI Support&quot;<BR>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; depends on IA64 || X86<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; depends on IA64 &amp;&amp; !IA64_HP_SIM || X86<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default y<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ---help---<BR>
@@ -44,11 +44,15 @@<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; depends on ACPI || X86_HT<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default y<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; help<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; If you say `Y' here, Linux will read the ACPI tables at boot to<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; discover system characteristics such as processors, APICs, and<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; PCI IRQ routing.&nbsp; This replaces traditional mechanisms for<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; discovering those properties.<BR>
<BR>
&nbsp;config ACPI_INTERPRETER<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; depends on ACPI<BR>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; depends on !IA64_SGI_SN<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default y<BR>
<BR>
&nbsp;config ACPI_SLEEP<BR>
@@ -101,7 +105,6 @@<BR>
&nbsp;config ACPI_BUTTON<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tristate &quot;Button&quot;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; depends on ACPI_INTERPRETER<BR>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; depends on !IA64_SGI_SN<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default m<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; help<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; This driver registers for events based on buttons, such as the<BR>
@@ -113,7 +116,6 @@<BR>
&nbsp;config ACPI_FAN<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tristate &quot;Fan&quot;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; depends on ACPI_INTERPRETER<BR>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; depends on !IA64_SGI_SN<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default m<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; help<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; This driver adds support for ACPI fan devices, allowing user-mode<BR>
@@ -122,7 +124,6 @@<BR>
&nbsp;config ACPI_PROCESSOR<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tristate &quot;Processor&quot;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; depends on ACPI_INTERPRETER<BR>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; depends on !IA64_SGI_SN<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default m<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; help<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; This driver installs ACPI as the idle handler for Linux, and uses<BR>
@@ -207,7 +208,6 @@<BR>
&nbsp;config ACPI_DEBUG<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool &quot;Debug Statements&quot;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; depends on ACPI_INTERPRETER<BR>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; depends on !IA64_SGI_SN<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default n<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; help<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; The ACPI driver can optionally report errors with a great deal<BR>
@@ -217,7 +217,6 @@<BR>
&nbsp;config ACPI_BUS<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; depends on ACPI_INTERPRETER<BR>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; depends on !IA64_SGI_SN<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default y<BR>
<BR>
&nbsp;config ACPI_EC<BR>
@@ -233,19 +232,16 @@<BR>
&nbsp;config ACPI_POWER<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; depends on ACPI_INTERPRETER<BR>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; depends on !IA64_SGI_SN<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default y<BR>
<BR>
&nbsp;config ACPI_PCI<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; depends on ACPI_INTERPRETER<BR>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; depends on !IA64_SGI_SN<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default PCI<BR>
<BR>
&nbsp;config ACPI_SYSTEM<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; depends on ACPI_INTERPRETER<BR>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; depends on !IA64_SGI_SN<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default y<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; help<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; This driver will enable your system to shut down using ACPI, and<BR>
@@ -260,7 +256,6 @@<BR>
&nbsp;config ACPI_RELAXED_AML<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool &quot;Relaxed AML&quot;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; depends on ACPI_INTERPRETER<BR>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; depends on !IA64_SGI_SN<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default n<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; help<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; If you say `Y' here, the ACPI interpreter will relax its checking<BR>
<BR>
-<BR>
To unsubscribe from this list: send the line &quot;unsubscribe linux-kernel&quot; in<BR>
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org<BR>
More majordomo info at&nbsp; <A HREF="http://vger.kernel.org/majordomo-info.html">http://vger.kernel.org/majordomo-info.html</A><BR>
Please read the FAQ at&nbsp; <A HREF="http://www.tux.org/lkml/">http://www.tux.org/lkml/</A><BR>
</FONT>
</P>

</BODY>
</HTML>
--=-j4hBRen0UcKO14ABBXay--



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
