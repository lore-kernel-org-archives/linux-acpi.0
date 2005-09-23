From: akpm-3NddpPZAyC0@public.gmane.org
Subject: [patch 4/7] Don't set dcdbas driver to default m
Date: Thu, 22 Sep 2005 20:59:54 -0700
Message-ID: <200509230400.j8N40WSY003695@shell0.pdx.osdl.net>
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
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, akpm-3NddpPZAyC0@public.gmane.org, ak-l3A5Bk7waGM@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


From: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>

It's nasty to set random drivers to default m because people who just press
enter on make oldconfig get these.  Remove the default m

Signed-off-by: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>
Signed-off-by: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
---

 drivers/firmware/Kconfig |    1 -
 1 files changed, 1 deletion(-)

diff -puN drivers/firmware/Kconfig~dont-set-dcdbas-driver-to-default-m drivers/firmware/Kconfig
--- devel/drivers/firmware/Kconfig~dont-set-dcdbas-driver-to-default-m	2005-09-10 04:09:41.000000000 -0700
+++ devel-akpm/drivers/firmware/Kconfig	2005-09-10 04:09:41.000000000 -0700
@@ -71,7 +71,6 @@ config DELL_RBU
 config DCDBAS
 	tristate "Dell Systems Management Base Driver"
 	depends on X86 || X86_64
-	default m
 	help
 	  The Dell Systems Management Base Driver provides a sysfs interface
 	  for systems management software to perform System Management
_


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
