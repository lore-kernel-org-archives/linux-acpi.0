From: akpm-3NddpPZAyC0@public.gmane.org
Subject: [patch 3/7] set IBM ThinkPad extras to default n in Kconfig
Date: Thu, 22 Sep 2005 20:59:52 -0700
Message-ID: <200509230400.j8N40Vit003691@shell0.pdx.osdl.net>
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, akpm-3NddpPZAyC0@public.gmane.org, petkov-xhPu7QH+N+StU9/U+hoEgQ@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


From: Borislav Petkov <petkov-xhPu7QH+N+StU9/U+hoEgQ@public.gmane.org>

I think the following isn't on purpose but the IBM Thinkpad acpi extras
default to y in Kconfig.  The patch below fixes it:

Signed-off-by: <petkov-xhPu7QH+N+StU9/U+hoEgQ@public.gmane.org>
Cc: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
---

 drivers/acpi/Kconfig |    1 -
 1 files changed, 1 deletion(-)

diff -puN drivers/acpi/Kconfig~set-ibm-thinkpad-extras-to-default-n-in-kconfig drivers/acpi/Kconfig
--- devel/drivers/acpi/Kconfig~set-ibm-thinkpad-extras-to-default-n-in-kconfig	2005-09-09 18:19:42.000000000 -0700
+++ devel-akpm/drivers/acpi/Kconfig	2005-09-09 18:19:57.000000000 -0700
@@ -197,7 +197,6 @@ config ACPI_ASUS
 config ACPI_IBM
 	tristate "IBM ThinkPad Laptop Extras"
 	depends on X86
-	default y
 	---help---
 	  This is a Linux ACPI driver for the IBM ThinkPad laptops. It adds
 	  support for Fn-Fx key combinations, Bluetooth control, video
_


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
