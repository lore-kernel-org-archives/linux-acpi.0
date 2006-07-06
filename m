From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [PATCH] [6/8] x86_64: Fix up bogus defaults in ACPI Kconfig
Date: Thu, 6 Jul 2006 14:08:39 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6E59877@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:60249 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750846AbWGFSJA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Jul 2006 14:09:00 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <ak@suse.de>, torvalds@osdl.org
Cc: akpm@osdl.org, discuss@x86-64.org, linux-acpi@vger.kernel.org

Acked-by: Len Brown <len.brown@intel.com> 

>-----Original Message-----
>From: Andi Kleen [mailto:ak@suse.de] 
>Sent: Thursday, July 06, 2006 12:14 PM
>To: torvalds@osdl.org
>Cc: akpm@osdl.org; discuss@x86-64.org; 
>linux-acpi@vger.kernel.org; Brown, Len
>Subject: [PATCH] [6/8] x86_64: Fix up bogus defaults in ACPI Kconfig
>
>
>No need for video to be always in
>No need for ACPI dock driver to be always in
>No need for smart battery driver to be always in
>
>Cc: len.brown@intel.com
>Cc: linux-acpi@vger.kernel.org
>Signed-off-by: Andi Kleen <ak@suse.de>
>
>---
> drivers/acpi/Kconfig |    3 ---
> 1 files changed, 3 deletions(-)
>
>Index: linux/drivers/acpi/Kconfig
>===================================================================
>--- linux.orig/drivers/acpi/Kconfig
>+++ linux/drivers/acpi/Kconfig
>@@ -107,7 +107,6 @@ config ACPI_BUTTON
> config ACPI_VIDEO
> 	tristate "Video"
> 	depends on X86
>-	default y
> 	help
> 	  This driver implement the ACPI Extensions For Display Adapters
> 	  for integrated graphics devices on motherboard, as 
>specified in
>@@ -136,7 +135,6 @@ config ACPI_FAN
> config ACPI_DOCK
> 	tristate "Dock"
> 	depends on !ACPI_IBM_DOCK
>-	default y
> 	help
> 	  This driver adds support for ACPI controlled docking stations
> 
>@@ -357,7 +355,6 @@ config ACPI_SBS
> 	tristate "Smart Battery System (EXPERIMENTAL)"
> 	depends on X86 && I2C
> 	depends on EXPERIMENTAL
>-	default y
> 	help
> 	  This driver adds support for the Smart Battery System.
> 	  Depends on I2C (Device Drivers ---> I2C support)
>
