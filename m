From: Borislav Petkov <bbpetkov-LWAfsSFWpa4@public.gmane.org>
Subject: Re: 2.6.15-rc5-mm3 [PATCH] remove Kconfig ACPI laptop default settings
Date: Thu, 15 Dec 2005 20:17:05 +0100
Message-ID: <20051215191705.GA16258@gollum.tnic>
References: <20051214234016.0112a86e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20051214234016.0112a86e.akpm-3NddpPZAyC0@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This removes the default (y|m) ACPI settings for laptops in order to speed up
automated kbuilds without compiling unneeded stuff - I'm pretty certain the
majority of machines running lnx are not laptops after all :)

Signed-off-by: Borislav Petkov <petkov-xhPu7QH+N+StU9/U+hoEgQ@public.gmane.org>


--- current/drivers/acpi/Kconfig.orig	2005-12-15 20:03:59.000000000 +0100
+++ current/drivers/acpi/Kconfig	2005-12-15 20:04:31.000000000 +0100
@@ -168,7 +168,6 @@ config ACPI_NUMA
 config ACPI_ASUS
         tristate "ASUS/Medion Laptop Extras"
 	depends on X86
-	default y
         ---help---
           This driver provides support for extra features of ACPI-compatible
           ASUS laptops. As some of Medion laptops are made by ASUS, it may also
@@ -209,7 +208,6 @@ config ACPI_IBM
 config ACPI_TOSHIBA
 	tristate "Toshiba Laptop Extras"
 	depends on X86
-	default y
 	---help---
 	  This driver adds support for access to certain system settings
 	  on "legacy free" Toshiba laptops.  These laptops can be recognized by
@@ -236,7 +234,6 @@ config ACPI_TOSHIBA
 config ACPI_SONY
 	tristate "Sony Laptop Extras"
 	depends on X86 && ACPI
-	default m
 	  ---help---
 	  This mini-driver drives the ACPI SNC device present in the
 	  ACPI BIOS of the Sony Vaio laptops.

	

	
		
___________________________________________________________ 
Telefonate ohne weitere Kosten vom PC zum PC: http://messenger.yahoo.de



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
